/*
	
	TRACER SYSTEM FOR ZSCRIPT 2.4 | APRIL 7TH 2017
	AUTHOR: (DENIS) BELMONDO
	
	USAGE: make a new class, inherit from _ZTracer and change the properties as
		   you wish.
	
	you may use this in your project. just leave this comment at the top of 
	this script and give credit please! thank you :^)
	
*/

// blasterStaff tracer ////////////////////////////////////////////////////////////////
class blaster_ZTracer : FastProjectile {

	const TRACERDURATION	= 1; // tics
	const TRACERFANCY		= 0; // fake bool
	const TRACERLENGTH		= 192.0; // float
	const TRACERSCALE		= 8.0; // float
	const TRACERSTEP		= 0.01; // float
	const TRACERFANCYSTEP	= 0.01; // float
	const TRACERACTOR		= "blaster_ZTracerTrail"; // actor name

	float x1, y1, z1;
	float x2, y2, z2;
	
	// intentional briticism to avoid conflicts with "color" keyword.
	// modified with strife fitting colors
	static const color colours[] = {
		"13 3f 0b",
		"23 57 13",
		"37 73 23",
		"4f 8f 37",
		"6b ab 4b",
		"8b c7 67" /* appears twice so a segment of this color is longer
					than the others. */
	};
	
	// literally just stole this from wikipedia
	float lerp(float v0, float v1, float t) {
		return (1 - t) * v0 + t * v1;
	}
	
	override void BeginPlay() {
		// we don't want to lerp into weird coordinates
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x;
		y2 = pos.y;
		z2 = pos.z;
	}

	void W_SpawnParticleTrail() {
		if (level.frozen || globalfreeze) return;
		
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x + vel.x / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;
		y2 = pos.y + vel.y / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;
		z2 = pos.z + vel.z / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;		
		
		if (TRACERFANCY == 0) {
			for(float i = 0; i < 1; i += TRACERSTEP) {
				A_SpawnParticle (
					colours[clamp(i * colours.Size(), 0, colours.Size() - 1)],
					SPF_FULLBRIGHT,
					TRACERDURATION,
					TRACERSCALE * (1 - i),
					0,
					/*(-pos.x) + lerp(x1, x2, i)*/pos.x - lerp(x1, x2, i),
					/*(-pos.y) + lerp(y1, y2, i)*/pos.y - lerp(y1, y2, i),
					/*(-pos.z) + lerp(z1, z2, i)*/pos.z - lerp(z1, z2, i),
					0, 0, 0,
					0, 0, 0,
					1.0
				);
				/*A_SpawnItemEx (
					TRACERACTOR,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0, 0,
					SXF_ABSOLUTEPOSITION
				);*/
			} 
		}
		else {
			for(float i = 0; i < 1; i += TRACERFANCYSTEP) {
				A_SpawnItemEx (
					TRACERACTOR,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0, 0,
					SXF_ABSOLUTEPOSITION
				);
			}
		}
	}

	override void Tick() {
		
		//Super.Tick();

		/*if (level.frozen || globalfreeze) return;
		
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x + vel.x / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;
		y2 = pos.y + vel.y / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;
		z2 = pos.z + vel.z / GetDefaultSpeed("blaster_ZTracer") * TRACERLENGTH;

		
		
		if (TRACERFANCY == 0) {
			for(float i = 0; i < 1; i += TRACERSTEP) {
				A_SpawnParticle (
					colours[clamp(i * colours.Size(), 0, colours.Size() - 1)],
					SPF_FULLBRIGHT,
					TRACERDURATION,
					TRACERSCALE * i,
					0,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0,
					0, 0, 0,
					1.0
				);
			} 
		}
		else {
			for(float i = 0; i < 1; i += TRACERFANCYSTEP) {
				A_SpawnItemEx (
					TRACERACTOR,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0, 0,
					SXF_ABSOLUTEPOSITION
				);
			}
		}*/		
		
		//W_SpawnParticleTrail();
		Super.Tick();
	}

	Default {
		//DamageFunction (3 * Random(1, 5));
		Height 1;
		Radius 1;
		Speed 60;
		//+BLOODSPLATTER;
	}
	/*States {
		Spawn:
			TNT1 A 1;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("BulletPuff");
		//XDeath:
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}*/
}

class blaster_ZTracerTrail : Actor {
	Default {
		Alpha 0.5;
		RenderStyle "Add";
		Scale 0.25;
		+NOINTERACTION;
	}
	States {
		Spawn:
			//PUFF A 2 Bright;
			TNT1 AA 0 A_SpawnParticle ("235713", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.35, 0, frandom(-1.25,1.25), frandom(-1.25,1.25), frandom(-1.25,1.25), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.25);				
			TNT1 AAA 0 A_SpawnParticle ("8fc75f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.5, 0, frandom(-0.85,0.85), frandom(-0.85,0.85), frandom(-0.85,0.85), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AA 0 A_SpawnParticle ("b7e77f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.25, 0, frandom(-0.45,0.45), frandom(-0.45,0.45), frandom(-0.45,0.45), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.025);
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////

/*
extend class _ZTracer {
	Default {
		//DamageFunction (3 * Random(1, 5));
		Height 1;
		Radius 1;
		Speed 60;
		+BLOODSPLATTER;
	}
	States {
		Spawn:
			TNT1 A 1;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("BulletPuff");
		XDeath:
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}
}
*/