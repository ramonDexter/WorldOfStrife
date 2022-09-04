#include "zscript/mechanics/collision/Array.txt"
#include "zscript/mechanics/collision/Stream.txt"
#include "zscript/mechanics/collision/StringStream.txt"
#include "zscript/mechanics/collision/LumpStream.txt"
#include "zscript/mechanics/collision/BinaryReader.txt"

class C3DVertex
{
	vector3 position;
	vector3 bakedposition;
	vector3 normal;
	vector3 bakednormal;
	
	static C3DVertex FromVector(vector3 vec)
	{
		C3DVertex ver = new('C3DVertex');
		ver.position = vec;
		return ver;
	}
}

class C3DTriangle
{
	C3DVertex v1;
	C3DVertex v2;
	C3DVertex v3;
	int iv1;
	int iv2;
	int iv3;
	double bBox[6];
	vector3 normal;
	vector3 center;
	vector3 planeanchors[5];
	vector3 planenormals[5];
	int checknum;
	int checknum2;
	
	vector3 CalculateNormal(vector3 v1, vector3 v2, vector3 v3)
	{
		vector3 norm;
		vector3 norm_U = v2 - v1;
		vector3 norm_V = v3 - v1;
		norm.x = norm_U.y * norm_V.z - norm_U.z * norm_V.y;
		norm.y = norm_U.z * norm_V.x - norm_U.x * norm_V.z;
		norm.z = norm_U.x * norm_V.y - norm_U.y * norm_V.x;
		return C3DCollision.NormalizeVector(norm);

	}
	
	void CalculateNormals()
	{
		normal = CalculateNormal(v1.bakedposition, v2.bakedposition, v3.bakedposition);
		planenormals[0] = normal;
		planenormals[1] = -normal;
		planeanchors[0] = planeanchors[1] = planeanchors[2] = v1.bakedposition;
		planeanchors[3] = v2.bakedposition;
		planeanchors[4] = v3.bakedposition;
		planenormals[2] = CalculateNormal(v1.bakedposition, v1.bakedposition+normal, v2.bakedposition);
		planenormals[3] = CalculateNormal(v2.bakedposition, v2.bakedposition+normal, v3.bakedposition);
		planenormals[4] = CalculateNormal(v3.bakedposition, v3.bakedposition+normal, v1.bakedposition);
		center = (v1.bakedposition + v2.bakedposition + v3.bakedposition)/3;
	}
}

class C3DFrame
{
	Array<C3DVertex> vertices;
}

class C3DSurface
{
	vector3 normal;
	Array<C3DTriangle> triangles;
}

class C3DBmEntry
{
	Array<C3DTriangle> triangles;
}

class C3DCollision : Inventory
{
	Array<C3DFrame> frames;
	C3DFrame frame;
	Array<C3DTriangle> triangles;
	Array<C3DSurface> surfaces;
	
	Array<C3DBmEntry> blockmap;
	int blockmapSizeX;
	int blockmapSizeY;
	int blockmapSizeZ;
	int blockmapOffsX; // blockmap can start at negative coords. array cannot
	int blockmapOffsY;
	int blockmapOffsZ;
	double blockmapResX;
	double blockmapResY;
	double blockmapResZ;
	
	vector3 p_scale;
	double p_angle;
	double p_pitch;
	double p_roll;
	vector3 p_translation;
	
	static vector3 NormalizeVector(vector3 vin)
	{
		double len = vin.Length();
		if (len != 0) // special case
		{
			vin.x /= len;
			vin.y /= len;
			vin.z /= len;
		}
		return vin;
	}

	bool InitTest()
	{
		C3DFrame frm = new('C3DFrame');
		frames.Push(frm);
		frame = frm;
		C3DTriangle tri1 = new('C3DTriangle');
		tri1.iv1 = 0;
		tri1.iv2 = 1;
		tri1.iv3 = 2;
		triangles.Push(tri1);
		C3DVertex v1 = C3DVertex.FromVector((1, 1, 1));
		C3DVertex v2 = C3DVertex.FromVector((-1, 1, 1));
		C3DVertex v3 = C3DVertex.FromVector((-1, 1, -1));
		frm.vertices.Push(v1);
		frm.vertices.Push(v2);
		frm.vertices.Push(v3);
		SetFrame(0);
		return true;
	}

	bool Init(string model)
	{
		int fnum = Wads.CheckNumForFullName(model);
		if (fnum < 0)
		{
			Console.Printf("\034GError: unable to open \"%s\"", model);
			return false;
		}
		
		let lump = LumpStream.Create(fnum);
		if (!lump)
		{
			Console.Printf("\034GError: unable to load \"%s\"", model);
			return false;
		}
		
		let br = BinaryReader.Create(lump);
		// this currently only supports MD3
		
		lump.Seek(0, SEEK_Begin);
		int md3_ident = br.ReadInt32();
		if (md3_ident != 0x33504449)
		{
			Console.Printf("\034GError: \"%s\" is not an MD3 file", model);
			return false;
		}
		
		int md3_version = br.ReadInt32();
		if (md3_version != 15)
		{
			Console.Printf("\034GError: \"%s\": unsupported MD3 version %d", model, md3_version);
			return false;
		}
		
		string md3_name = br.ReadString(64); // MAX_QPATH. unused
		int md3_flags = br.ReadInt32();
		int md3_frames = br.ReadInt32();
		int md3_tags = br.ReadInt32();
		int md3_surfaces = br.ReadInt32();
		int md3_skins = br.ReadInt32();
		int md3_frames_offs = br.ReadInt32();
		int md3_tags_offs = br.ReadInt32();
		int md3_surfaces_offs = br.ReadInt32();
		int md3_skins_offs = br.ReadInt32(); // 
		
		lump.Seek(md3_surfaces_offs, SEEK_Begin);
		//
		// from all this, we need ONLY triangle and vertex data
		// there is also texture ST data and shader data (?) but it means nothing for collision
		int surf_ident = br.ReadInt32();
		if (surf_ident != 0x33504449)
		{
			Console.Printf("\034GError: \"%s\": invalid MD3 surface section identifier %08X (expected IDP3)", model, surf_ident);
			return false;
		}
		
		string surf_name = br.ReadString(64);
		int surf_flags = br.ReadInt32();
		int surf_frames = br.ReadInt32();
		int surf_shaders = br.ReadInt32();
		int surf_verts = br.ReadInt32();
		int surf_triangles = br.ReadInt32();
		int surf_triangles_offs = br.ReadInt32();
		int surf_shaders_offs = br.ReadInt32();
		int surf_st_offs = br.ReadInt32();
		int surf_verts_offs = br.ReadInt32();
		
		// now read in vertices for each frame
		for (int i = 0; i < md3_frames; i++)
		{
			C3DFrame frame = new('C3DFrame');
			frames.Push(frame);
		}
		
		lump.Seek(md3_surfaces_offs+surf_verts_offs, SEEK_Begin);
		for (int i = 0; i < md3_frames; i++)
		{
			for (int j = 0; j < surf_verts; j++)
			{
				vector3 vertex;
				vertex.x = double(br.ReadInt16())/64;
				vertex.y = double(br.ReadInt16())/64;
				vertex.z = double(br.ReadInt16())/64;
				int vx_normal = br.ReadInt16();
				double M_PI = 3.14159265359;
				double vx_lat = double(((vx_normal >> 8) & 255)) / 255 * 360;
				double vx_lng = double((vx_normal & 255)) / 255 * 360;
				C3DVertex vx = new('C3DVertex');
				vx.position = vertex;
				vx.normal.x = cos(vx_lat) * sin(vx_lng);
				vx.normal.y = sin(vx_lat) * sin(vx_lng);
				vx.normal.z = cos(vx_lng);
				frames[i].vertices.Push(vx);
			}
		}
		
		lump.Seek(md3_surfaces_offs+surf_triangles_offs, SEEK_Begin);
		for (int i = 0; i < surf_triangles; i++)
		{
			C3DTriangle tri = new('C3DTriangle');
			tri.iv1 = br.ReadInt32();
			tri.iv2 = br.ReadInt32();
			tri.iv3 = br.ReadInt32();
			triangles.Push(tri);
		}
		
		SetFrame(0);
		return true;
	}
	
	void SetFrame(int index)
	{
		C3DFrame frame = frames[index];
		for (int i = 0; i < triangles.Size(); i++)
		{
			C3DTriangle triangle = triangles[i];
			triangle.v1 = frame.vertices[triangle.iv1];
			triangle.v2 = frame.vertices[triangle.iv2];
			triangle.v3 = frame.vertices[triangle.iv3];
		}
		
		self.frame = frame;
		Update();
		UpdateBlockmap();
	}
	
	private bool IsContinuedNormal(vector3 v1, vector3 v2, C3DTriangle tri)
	{
		bool samenormal = true;
		int checkedtriangles = 0;
		for (int i = 0; i < triangles.Size(); i++)
		{
			if (triangles[i] == tri)
				continue;
			vector3 tv1 = triangles[i].v1.bakedposition;
			vector3 tv2 = triangles[i].v2.bakedposition;
			vector3 tv3 = triangles[i].v3.bakedposition;
			if ((tv1 == v1 && tv2 == v2) ||
				(tv2 == v1 && tv3 == v2) ||
				(tv3 == v1 && tv1 == v2) ||
				(tv1 == v2 && tv2 == v1) ||
				(tv2 == v2 && tv3 == v1) ||
				(tv3 == v2 && tv1 == v1))
			{
				if (triangles[i].normal != tri.normal)
					samenormal = false;
				checkedtriangles++;
			}
		}
		
		/*if (checkedtriangles > 0)
			Console.Printf("IsContinuedNormal = %d; checked = %d", samenormal && checkedtriangles, checkedtriangles);*/
		
		return samenormal && checkedtriangles;
	}
	
	C3DSurface GetSurface(vector3 normal)
	{
		for (int i = 0; i < surfaces.Size(); i++)
		{
			if (surfaces[i].normal == normal)
				return surfaces[i];
		}
		C3DSurface surf = new ('C3DSurface');
		surf.normal = normal;
		surfaces.Push(surf);
		return surf;
	}
	
	/*	Array<C3DBmEntry> blockmap;
	int blockmapSizeX;
	int blockmapSizeY;
	int blockmapSizeZ;
	int blockmapOffsX; // blockmap can start at negative coords. array cannot
	int blockmapOffsY;
	int blockmapOffsZ;
	double blockmapResX;
	double blockmapResY;
	double blockmapResZ;*/
	
	void UpdateBlockmap()
	{
		vector3 start = (65536, 65536, 65536);
		vector3 end = (-65536, -65536, -65536);
		for (int j = 0; j < triangles.Size(); j++)
		{
			vector3 v1 = triangles[j].v1.bakedposition;
			vector3 v2 = triangles[j].v2.bakedposition;
			vector3 v3 = triangles[j].v3.bakedposition;
			start = (min(start.x, v1.x, v2.x, v3.x),
					 min(start.y, v1.y, v2.y, v3.y),
					 min(start.z, v1.z, v2.z, v3.z));
			end = (max(end.x, v1.x, v2.x, v3.x),
				   max(end.y, v1.y, v2.y, v3.y),
				   max(end.z, v1.z, v2.z, v3.z));
		}
		vector3 bboxSize = end - start;
		// support 8x8x8 bbox. this is fine.
		blockmapResX = max(bboxSize.x / 8, 64);
		blockmapResY = max(bboxSize.y / 8, 64);
		blockmapResZ = max(bboxSize.z / 8, 64);
		vector3 bboxSizeLeft = end - p_translation;
		vector3 bboxSizeRight = p_translation - start;
		blockmapSizeX = int(ceil(bboxSizeLeft.x / blockmapResX) + ceil(bboxSizeRight.x / blockmapResX));
		blockmapSizeY = int(ceil(bboxSizeLeft.y / blockmapResY) + ceil(bboxSizeRight.y / blockmapResY));
		blockmapSizeZ = int(ceil(bboxSizeLeft.z / blockmapResZ) + ceil(bboxSizeRight.z / blockmapResZ));
		blockmapOffsX = ceil(bboxSizeRight.x / blockmapResX);
		blockmapOffsY = ceil(bboxSizeRight.y / blockmapResY);
		blockmapOffsZ = ceil(bboxSizeRight.z / blockmapResZ);
		blockmap.Resize(blockmapSizeX*blockmapSizeY*blockmapSizeZ);
		for (int z = 0; z < blockmapSizeZ; z++)
		{
			for (int y = 0; y < blockmapSizeY; y++)
			{
				for (int x = 0; x < blockmapSizeX; x++)
				{
					int rx = x - blockmapOffsX;
					int ry = y - blockmapOffsY;
					int rz = z - blockmapOffsZ;
					vector3 start = (rx * blockmapResX, ry * blockmapResY, rz * blockmapResZ) + p_translation;
					vector3 end = ((rx+1) * blockmapResX, (ry+1) * blockmapResY, (rz+1) * blockmapResZ) + p_translation;
					int array_offs = blockmapSizeX*blockmapSizeY*z + blockmapSizeX*y + x;
					C3DBmEntry ent = blockmap[array_offs] = new('C3DBmEntry');
					for (int i = 0; i < triangles.Size(); i++)
					{
						if (C3DCollisionClient.IsIntersecting(start, end, triangles[i]))
						{
							ent.triangles.Push(triangles[i]);
						}
					}
				}
			}
		}
	}
	
	void Update()
	{
		if (!frame) return;
	
		for (int j = 0; j < frame.vertices.Size(); j++)
		{
			C3DVertex vertex = frame.vertices[j];
			vector3 bp;
			bp.x = vertex.position.x * p_scale.x;
			bp.y = vertex.position.y * p_scale.y;
			bp.z = vertex.position.z * p_scale.z;
			// rotate
			vector3 bp_rotated = bp;
			bp_rotated.x = bp.x * cos(p_pitch) - bp.z * sin(p_pitch);
			bp_rotated.z = bp.z * cos(p_pitch) + bp.x * sin(p_pitch);
			bp = bp_rotated;
			bp_rotated.x = bp.x * cos(p_angle) - bp.y * sin(p_angle);
			bp_rotated.y = bp.y * cos(p_angle) + bp.x * sin(p_angle);
			//bp_rotated.x *= -1;
			vertex.bakedposition = bp_rotated + p_translation;
			vector3 vn = vertex.normal;
			vertex.bakednormal = vn;
			vertex.bakednormal.x = vn.x * cos(p_pitch) - vn.z * sin(p_pitch);
			vertex.bakednormal.z = vn.z * cos(p_pitch) + vn.x * sin(p_pitch);
			vn = vertex.bakednormal;
			vertex.bakednormal.x = vn.x * cos(p_angle) - vn.y * sin(p_angle);
			vertex.bakednormal.y = vn.y * cos(p_angle) + vn.x * sin(p_angle);
		}
		
		surfaces.Clear();
		
		for(int i = 0; i < triangles.Size(); i++)
		{
			C3DTriangle triangle = triangles[i];
			if (!triangle.v1 || !triangle.v2 || !triangle.v3)
				continue;
			// calculate normal
			triangle.CalculateNormals();
			//triangle.normal = -((triangle.v1.normal + triangle.v2.normal + triangle.v3.normal) / 3);
			// calculate bounding box
			triangle.bBox[0] = min(triangle.v1.bakedposition.x, triangle.v2.bakedposition.x, triangle.v3.bakedposition.x);
			triangle.bBox[1] = max(triangle.v1.bakedposition.x, triangle.v2.bakedposition.x, triangle.v3.bakedposition.x);
			triangle.bBox[2] = min(triangle.v1.bakedposition.y, triangle.v2.bakedposition.y, triangle.v3.bakedposition.y);
			triangle.bBox[3] = max(triangle.v1.bakedposition.y, triangle.v2.bakedposition.y, triangle.v3.bakedposition.y);
			triangle.bBox[4] = min(triangle.v1.bakedposition.z, triangle.v2.bakedposition.z, triangle.v3.bakedposition.z);
			triangle.bBox[5] = max(triangle.v1.bakedposition.z, triangle.v2.bakedposition.z, triangle.v3.bakedposition.z);
			// 
			C3DSurface surf = GetSurface(triangle.normal);
			surf.triangles.Push(triangle);
		}
		/*
		for (int i = 0; i < surfaces.Size(); i++)
		{
			C3DSurface surf = surfaces[i];
			if (surf.triangles.Size() <= 1)
				continue;
				
			for (int j = 0; j < surf.triangles.Size(); j++)
			{
				C3DTriangle tri1 = surf.triangles[j];
				vector3 av1 = tri1.v1.bakedposition;
				vector3 av2 = tri1.v2.bakedposition;
				vector3 av3 = tri1.v3.bakedposition;
				for (int k = 0; k < surf.triangles.Size(); k++)
				{
					C3DTriangle tri2 = surf.triangles[k];
					vector3 bv1 = tri2.v1.bakedposition;
					vector3 bv2 = tri2.v2.bakedposition;
					vector3 bv3 = tri2.v3.bakedposition;
					// check collision along edges
					if ((av1 == bv1 && av2 == bv2) || (av2 == bv1 && av1 == bv2) ||
						(av2 == bv1 && av3 == bv2) || (av3 == bv1 && av2 == bv2) ||
						(av3 == bv1 && av1 == bv2) || (av1 == bv1 && av3 == bv2))
					{
						// bv1<->bv2 points at tri1
						tri2.planenormals[2] = tri2.planenormals[0];
						tri2.planeanchors[2] = tri2.planeanchors[0];
					}
					else if ((av1 == bv2 && av2 == bv3) || (av2 == bv2 && av1 == bv3) ||
							 (av2 == bv2 && av3 == bv3) || (av3 == bv2 && av2 == bv3) ||
							 (av3 == bv2 && av1 == bv3) || (av1 == bv2 && av3 == bv3))
					{
						// bv2<->bv3 points at tri1
						tri2.planenormals[3] = tri2.planenormals[0];
						tri2.planeanchors[3] = tri2.planeanchors[0];
					}
					else if ((av1 == bv3 && av2 == bv1) || (av2 == bv3 && av1 == bv1) ||
							 (av2 == bv3 && av3 == bv1) || (av3 == bv3 && av2 == bv1) ||
							 (av3 == bv3 && av1 == bv1) || (av1 == bv3 && av3 == bv1))
					{
						// bv3<->bv1 points at tri1
						tri2.planenormals[4] = tri2.planenormals[0];
						tri2.planeanchors[4] = tri2.planeanchors[0];
					}
				}
			}
		}*/
	}
	
	void SetTranslation(vector3 translation)
	{
		p_translation = translation;
		Update();
	}
	
	void SetAngle(double angle)
	{
		p_angle = angle;
		Update();
		UpdateBlockmap();
	}
	
	void SetPitch(double pitch)
	{
		p_pitch = -pitch;
		Update();
		UpdateBlockmap();
	}
	
	void SetScale(vector3 scale)
	{
		scale.z /= 1.2; // this is how Doom works
		p_scale = scale;
		Update();
		UpdateBlockmap();
	}
}
class wosD_jkjaPodCar2 : actor  { //21589
	Default {
        //$Category "Decorations/Wos/JKJA/"
        //$Title "pod car 2"
        Tag "pod car";
        radius 64;
        height 32;
        +SOLID;
        +USESPECIAL;
        +NOGRAVITY;
    }
    private C3DCollision coll;
	
	int user_a;
	
	override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		GiveInventory('C3DCollision', 1, false);
		coll = C3DCollision(FindInventory('C3DCollision', false));
		if (!coll.Init("models/PROPS/JKJA/podcar2.md3"))
			coll = null;
			
		coll.SetFrame(0);
		coll.SetScale((6, 6, 6));
		coll.SetTranslation(pos);
		coll.SetAngle(angle);
		coll.SetPitch(pitch);
		
		//
		
	}
	
	override void Tick()
	{
		/*
		// spawn particles at each vertex
		for (int i = 0; i < coll.frame.vertices.Size(); i++)
		{
			vector3 vx = coll.frame.vertices[i].bakedposition;
			vector3 n = coll.frame.vertices[i].normal;
			if (level.time % 35 == 0)
				A_SpawnParticle(0xFFFFFFFF, SPF_FULLBRIGHT, 35, 8, 0, vx.x-pos.x, vx.y-pos.y, vx.z-pos.z);//, n.x, n.y, n.z);
		}*/
		
		Super.Tick();
	}
    
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}