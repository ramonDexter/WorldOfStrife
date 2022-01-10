
Class ZFIRE : ACTOR
	{

	Default
		{
		RenderStyle "None";
		+NOGRAVITY;
		+NOBLOCKMAP;
		+NOTIMEFREEZE;

		//$Category "Decorations"
		//$Title Small Fire
		

		//$Arg0 Fire Colour
		//$Arg0Type 11
		//$Arg0Enum { 0 = "Orange (Default)"; 1 = "Red"; 2 = "Green"; 3 = "Blue"; 4 = "Purple"; }

		//$Arg1 Emit Smoke?
		//$Arg1Type 11
		//$Arg1Enum { 0 = "No"; 1 = "Yes"; }

		//$Arg2 Ember Frequency

		//$Arg3 Dynamic Light?
		//$Arg3Type 11
		//$Arg3Enum { 0 = "No"; 1 = "Yes"; }

		//$Arg4	Ember Dynamic Light?
		//$Arg4Type 11
		//$Arg4Enum { 0 = "No"; 1 = "Yes (Perfomance Warning!)"; }

		}

	int colortic;

	Override void PostBeginPlay()
		{

		static const string Translation[] =
			{
			"None",
			"T_RED",
			"T_GRN",
			"T_BLU",
			"T_PRP"
			};
		static const string Lights[] =
			{
			"L_ORN",
			"L_RED",
			"L_GRN",
			"L_BLU",
			"L_PRP"
			};
		if(args[0] > Translation.Size()) { args[0] = 0; }
		A_SetTranslation(Translation[args[0]]);
		if(args[3])
			{
			Actor mo = Spawn(Lights[args[0]],(pos.x,pos.y,pos.z));
			mo.args[4] = 48*scale.x;
			}
		Super.PostBeginPlay();
		}

	Override void Tick()
		{
		if(args[1])
			{ A_SpawnItemEx("ZFIRE_SMOKE",zofs: 24.0,xvel: frandom(-1.0,1.0), zvel: frandom(1.0,3.0),angle: random(0,359)); }

		if(args[2])
			{ A_SpawnItemEx("ZFIRE_EMBER", frandom(1.0,4.0),0.0,24.0,frandom(0.25,1.25),0.0,frandom(0.5,3.0),random(0,359),SXF_NOCHECKPOSITION|SXF_TRANSFERTRANSLATION|SXF_TRANSFERSPECIAL,255-args[2]); }


		A_SpawnItemEx("ZFIRE_SHADOW",xofs: frandom(-2.0,2.0),zvel: frandom(0.1,1.5),angle: random(0,359),flags: SXF_TRANSFERSPRITEFRAME|SXF_TRANSFERTRANSLATION|SXF_TRANSFERSCALE);

		if(master)
			{ A_Warp(AAPTR_MASTER,-5,0,8,0,WARPF_NOCHECKPOSITION|WARPF_INTERPOLATE); }

		static const string Translation[] =
			{
			"None",
			"T_RED",
			"T_GRN",
			"T_BLU",
			"T_PRP"
			};
		static const string Lights[] =
			{
			"L_ORN",
			"L_RED",
			"L_GRN",
			"L_BLU",
			"L_PRP"
			};

		//Uncomment for rave-fire!!

		/*colortic++;
		if(colortic >=15)
			{
			if(args[0] >= 5) { args[0] = 0; }
			A_SetTranslation(Translation[args[0]]); args[0]++;
			colortic = 0;
			}*/

		Super.Tick();
		}

	States
		{
		Spawn:
			FFLG F 0;// NoDelay A_Jump(255,random(0,11));
		SPAWNLOOP:
			FFLG FGHIJKLMNOPQ 2 BRIGHT;
			loop;
		}
	}

Class ZFIRE2 : ZFIRE
	{

	Default
		{
		//$Category "Decorations"
		//$Title Large Fire
		
		}

	Override Void PostBeginPlay()
		{
		Actor.PostBeginPlay();

		static const string Translation[] =
			{
			"None",
			"T_RED",
			"T_GRN",
			"T_BLU",
			"T_PRP"
			};
		static const string Lights[] =
			{
			"L_ORN",
			"L_RED",
			"L_GRN",
			"L_BLU",
			"L_PRP"
			};

		A_SetTranslation(Translation[args[0]]);
		if(args[3])
			{
			Actor mo = Spawn(Lights[args[0]],(pos.x,pos.y,pos.z));
			mo.args[4] = 64*scale.x;
			}
		Super.PostBeginPlay();

		}

	States
		{
		SPAWN:
			BFIR B 0 NoDelay A_Jump(255,random(0,7));
		SPAWNLOOP:
			BFIR ABCDEFG 2 BRIGHT;
			loop;
		}
	}

Class ZFIRE_SHADOW : ACTOR
	{

	Default
		{
		+BRIGHT;
		+NOTIMEFREEZE;
		+NOBLOCKMAP;
		+NOGRAVITY;
		+ROLLSPRITE;
		Renderstyle "Add";
		Alpha 0.0;
		}

	double firegrowth;

	override void PostBeginPlay()
		{
		A_SetScale(scale.x+frandom(-0.025,0.025),scale.y);
		firegrowth = frandom(10.0,14.0);
		Super.PostBeginPlay();
		}

	void ShadowFade()
		{
		A_FadeOut(0.075);
		A_SetScale(scale.x-(scale.x/firegrowth),scale.y+(scale.y/firegrowth));
		}

	States
		{
		Spawn:
			"####" "####" 1 A_FadeIn(0.25);
		FadeOut:
			"####" "#" 1 ShadowFade();
			loop;
		}
	}

Class ZFIRE_SMOKE : ACTOR
	{

	Default
		{
		+NOGRAVITY;
		+NOBLOCKMAP;
		+ROLLSPRITE;
		+ROLLCENTER;
		+NOTIMEFREEZE;
		+NOCLIP;
		+FORCEXYBILLBOARD;
		RENDERSTYLE "Translucent";
		ALPHA 0.0;
		Radius 1;
		Height 1;
		}

	override void PostBeginPlay()
		{
		A_SetScale(1.0+(frandom(-0.25,0.25)));
		Super.PostBeginPlay();
		}

	override void Tick()
		{
		A_SetRoll(roll+5,SPF_INTERPOLATE);
		A_SetScale(scale.x+(scale.x/400));
		Super.Tick();
		}


	States
		{
		Spawn:
			TNT1 A 0 NoDelay A_Jump(255,"Smoke1","Smoke2","Smoke3");
		Smoke1:
			SMOK AAAAAA 1 A_FadeIn(0.02);
			Goto Fade;
		Smoke2:
			SMOK BBBBBB 1 A_FadeIn(0.02);
			Goto Fade;
		Smoke3:
			SMOK CCCCCC 1 A_FadeIn(0.02);
			Goto Fade;
		Fade:
			"####" "#" random(5,15);
		Fade.Loop:
			"####" "#" 1 A_FadeOut(0.005);
			loop;
		}
	}

//Ember Class
Class ZFIRE_EMBER : ACTOR
	{
	Default
		{
		+NOBLOCKMAP;
		+NOCLIP;
		+NOGRAVITY;
		+NOTIMEFREEZE;
		+ROLLSPRITE;
		+ROLLCENTER;
		+FORCEXYBILLBOARD;
		RADIUS 1;
		HEIGHT 1;
		Renderstyle "Add";
		Scale 0.5;
		}

	int lifespan;

	Override void PostBeginPlay()
		{
		lifespan = random(45,65);
		Super.PostBeginPlay();
		}

	Override Void Tick()
		{
		A_BishopMissileWeave();
		lifespan--;
		if(lifespan <= 0)
			{ SetStateLabel("Fade"); }
		Super.Tick();
		}

	States
		{
		Spawn:
			EMBR A 0 Nodelay
				{
				if(args[4]) // Ember Dynamic Lights? Can cause lag ...
					{
					if(args[0] == 0) 	{ SetStateLabel("Spawn.Orange"); 	}
					if(args[0] == 1) 	{ SetStateLabel("Spawn.Red"); 		}
					if(args[0] == 2) 	{ SetStateLabel("Spawn.Green");		}
					if(args[0] == 3) 	{ SetStateLabel("Spawn.Blue");		}
					if(args[0] == 4) 	{ SetStateLabel("Spawn.Purple");	}
					}
				}
		Spawn.Default:
			EMBR A 1 BRIGHT;
			loop;
		Spawn.Orange:
			EMBR A 1 BRIGHT Light("EMBER_O");
			loop;
		Spawn.Red:
			EMBR A 1 BRIGHT Light("EMBER_R");
			loop;
		Spawn.Green:
			EMBR A 1 BRIGHT Light("EMBER_G");
			loop;
		Spawn.Blue:
			EMBR A 1 BRIGHT Light("EMBER_B");
			loop;
		Spawn.Purple:
			EMBR A 1 BRIGHT Light("EMBER_P");
			loop;

		Fade:
			EMBR A 1 BRIGHT
				{
				A_FadeOut(0.025);
				}
			loop;
		}
	}

#region //Dynamic Lights
Class L_ORN : PointLight
	{

	int startrad;

	Override Void PostBeginPlay()
		{
		args[0] = 255;
		args[1] = 224;
		args[2] = 64;
		Super.PostBeginPlay();
		}

	Override Void Tick()
		{
		if(frandom(0.0,1.0) >= 0.3)
			{
			args[3] = args[4] + random(-(args[4]/20),(args[4]/20));
			}
		Super.Tick();
		}
	}

Class L_RED : L_ORN
	{

	Override Void PostBeginPlay()
		{
		Super.PostBeginPlay();
		args[0] = 255;
		args[1] = 64;
		args[2] = 64;
		}
	}

Class L_GRN : L_ORN
	{

	Override Void PostBeginPlay()
		{
		Super.PostBeginPlay();
		args[0] = 64;
		args[1] = 255;
		args[2] = 64;
		}
	}

Class L_BLU : L_ORN
	{

	Override Void PostBeginPlay()
		{
		Super.PostBeginPlay();
		args[0] = 32;
		args[1] = 32;
		args[2] = 255;
		}
	}

Class L_PRP : L_ORN
	{

	Override Void PostBeginPlay()
		{
		Super.PostBeginPlay();
		args[0] = 255;
		args[1] = 64;
		args[2] = 255;
		}
	}
#endregion
