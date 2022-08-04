////////////////////////////////////////////////////////////////////////////////
//   STAFFBLASTER  /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//const blasterStaffBaseWeight = 100;

//  staffBlaster.reload magazine  //////////////////////////////////////////////  
class magazine_blasterStaff : ammo {
	Default {
		+Inventory.IgnoreSkill;		
		Inventory.MaxAmount 48;
	}
}
//  staffBlaster.weapon  ///////////////////////////////////////////////////////
class staffBlaster : wosWeapon {
	bool staffIsFiring;

	Default {		
		//$Category "weapons/WoS"
		//$Title "Blaster Staff lvl.1"
		
		+WEAPON.AMMO_OPTIONAL
		+WEAPON.NOAUTOAIM
		+WEAPON.NOAUTOFIRE		
		+WEAPON.NOALERT	
		
		//Scale 0.4;	
		Radius 12;
		Height 64;
		
		Tag "$TAG_staffBlaster";
		Inventory.icon "H_ASTF";
		Inventory.pickupmessage "$FND_staffBlaster";
		Obituary "$OBI_staffBlaster"; // %o was splattered by %k Mauler Staff
		AttackSound "weapons/staffShoot";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.SlotNumber 3;
		Weapon.SlotPriority 3;		
		Weapon.kickback 40;
		Mass blasterStaffBaseWeight;
		// new magazine&reload system //////////////////////////////////////////
		wosWeapon.Magazine 48;
		wosWeapon.magazineMax 48;
		wosWeapon.magazineType "EnergyPod";
		//Weapon.AmmoType1 "magazine_blasterStaff";
		//Weapon.AmmoUse1 1;
		//Weapon.AmmoType2 "EnergyPod";
		//Weapon.AmmoUse2 0;
		//Weapon.AmmoGive2 64;
		//Decal "BulletChip";
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
				
		Nope:
			TNT1 A 1 {
				A_WeaponReady(WRF_NOFIRE); 
				A_ZoomFactor(1.0);
			}
			//TNT1 A 0 B_NoReFire();
			TNT1 A 0 A_ClearReFire();
			Goto Ready;
					
		Ready:				
			ASTF J 2 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			Loop;		
		Deselect:
			ASTF J 0 A_Lower();
			ASTF J 1 A_Lower();
			Loop;				
		Select:
			ASTF J 1 A_Raise();
			ASTF J 0 A_Raise();
			Loop;		
		Fire:
			TNT1 A 0 W_CheckAmmo();
			//DUMM A 0 A_JumpIfNoAmmo("Reload");
			TNT1 A 0 A_JumpIf(invoker.staffIsFiring == 1, "RealFire");
			ASTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			ASTF A 1 { invoker.staffIsFiring = 1; } //takze hul zustane ve stredu obrazu 		
		RealFire:
			ASTF A 0 W_CheckAmmo();
			//DUMM A 0 A_JumpIfNoAmmo("Reload");
			ASTF A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH);
			ASTF B 3 bright W_FireStaffBlaster2("BlasterTracer", "staffFlashShort", true);
			ASTF C 4;
			ASTF D 3;				 
			ASTF E 1; 
			ASTF F 3;
			ASTF G 5 A_Refire("RealFire");
			ASTF G 140 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);				
			ASTF HIJ 4 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4|WRF_NOFIRE|WRF_NOSWITCH);
			TNT1 A 0 { invoker.staffIsFiring = 0; } //hul se muze vratit na stranu
			Goto Ready;
			
		//staff melee sttack
		AltFire: 			
			STFM EFGH 1;
			//TNT1 A 5;
			STFM I 1;
			STFM J 1;
			STFM K 2;
			STFM L 2;
			TNT1 A 0 W_StaffSwing("staffBlasterMeleePuff");
			STFM M 2; //IJKLM
			STFM M 1;
			STFM LKJI 2;
			STFM HG 1;
			STFM FE 2;
			Goto Ready;		
		
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			ASTU A 3;
			ASTU B 2;
			ASTU C 1 A_StartSound("weapons/staffOpen", 0);
			ASTU DEFGH 2;
			ASTU I 4;
			ASTU J 3;
			ASTU K 2;
			ASTU L 3;
			ASTU M 4;
			ASTU N 5 A_StartSound("weapons/staffOut", 0);
			ASTU OP 3;
			ASTU QR 4;
			ASTU ST 3;
			ASTU UVW 2;
			ASTU W 1 ; //middle of animation
			ASTL W 1 {
				A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
				A_FireProjectile("staffCasingSpawner",-10,0,15,0);				
			}
			ASTL WVU 3;
			ASTL TS 3;
			ASTL RQ 4;
			ASTL PO 5;
			ASTL N 5; 
			ASTL M 9 A_StartSound("weapons/mmsl_in", 0);
			TNT1 A 0 W_Reload2();
			ASTL L 5;
			ASTL K 3;
			ASTL J 4;
			ASTL I 6;
			ASTL HGFED 2;
			ASTL C 2 A_StartSound("weapons/staffClose", 0);
			ASTL B 2;
			ASTL A 3;
			ASTL A 3;
			Goto Ready;		
	}
}
//  staffBlaster.mellee puff  //////////////////////////////////////////////////
class staffBlasterMeleePuff : BulletPuff {
	Default {
		seeSound "weapons/staffswing";
		attacksound "weapons/staffhit";
		activesound "weapons/staffswing";
	}
}
////////////////////////////////////////////////////////////////////////////////


//  staffBlaster.projectile  ///////////////////////////////////////////////////
// particle based projectile ///////////////////////////////////////////////////
// code base by denis belmondo /////////////////////////////////////////////////
class BlasterTracer : FastProjectile {
    const TRACERDURATION	= 1; // tics
	const TRACERLENGTH		= 192.0; // float
	const TRACERSCALE		= 8.0; // float
	const TRACERSTEP		= 0.005; // float
	const TRACERACTOR		= "BlasterTracerTrail"; // actor name
	const TRACERSPEED		= 90;

	float x1, y1, z1;
	float x2, y2, z2;
	
	// intentional briticism to avoid conflicts with "color" keyword.
	// modified with strife fitting colors
	static const color colours[] = {
		
		// reversed order
		"6b ab 4b",
		"6b ab 4b",
		"4f 8f 37",
		"37 73 23",
		"23 57 13",
		"13 3f 0b"
		// reversed order

		/*"13 3f 0b",
		"23 57 13",
		"37 73 23",
		"4f 8f 37",
		"6b ab 4b",
		"8b c7 67"*/ /* appears twice so a segment of this color is longer
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
		
		x2 = pos.x + vel.x / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;
		y2 = pos.y + vel.y / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;
		z2 = pos.z + vel.z / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;		
		
		for(float i = 0; i < 1; i += TRACERSTEP) {
			A_SpawnParticle (
				colours[clamp(i * colours.Size(), 0, colours.Size() - 1)],
				SPF_FULLBRIGHT,
				TRACERDURATION,
				TRACERSCALE * (1 - i),
				0,
				pos.x - lerp(x1, x2, i),
				pos.y - lerp(y1, y2, i),
				pos.z - lerp(z1, z2, i),
				0, 0, 0,
				0, 0, 0,
				1.0
			);
			A_SpawnItemEx (
				TRACERACTOR,
				pos.x - lerp(x1, x2, i),
				pos.y - lerp(y1, y2, i),
				pos.z - lerp(z1, z2, i),
				0, 0, 0, 0,
				SXF_ABSOLUTEPOSITION
			);			
		}		
	}

    Default {		
		Height 2;
		Radius 2;
		Speed TRACERSPEED;
        //DamageFunction (16 * Random(1, 4));
		Damage 12;
        Decal "blueShotScorch";
        SeeSound "weapons/staffprojectile";
		DeathSound "weapons/shotdeath";
		//+BLOODSPLATTER;
		+NOEXTREMEDEATH;
	}
    States {
		Spawn:
			DUMM ABCDEFGHI 1 Bright W_SpawnParticleTrail();
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("BulletPuff");
			TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("greenShotParticle",0,0,0,frandom(-6,6),frandom(-6,6),frandom(-6,6),0,SXF_NOCHECKPOSITION);
			TNT1 A 0 {
				A_SpawnItemEx("staffFlashLong", 0, 0, 0, 0);			
				A_SpawnItemEx("greenShotExplosion", 0, 0, 0, 0);
				A_SpawnItemEx("greenShotDeath", 0, 0, 0, 0);
			}
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}
class BlasterTracerTrail : actor {
	const PTCLDURATION = 2;
	
    Default {
		//Alpha 0.5;
		//RenderStyle "Add";
		//Scale 0.25;
		+NOINTERACTION;
		+NOBLOCKMAP;
        SeeSound "weapons/staffprojectile";
	}
	States {
		Spawn:			
			TNT1 AA 0 {
				A_SpawnParticle (
					"235713", //color1, hexadecimal value or a predefined value such as "Black"
					SPF_FULLBRIGHT|SPF_RELATIVE, //flags
					PTCLDURATION, //lifetime in tics
					0.55, //size, default 1.0
					0, //angle, default 0
					frandom(-1.25,1.25), frandom(-1.25,1.25), frandom(-1.25,1.25), //x/y/z offset, default 0
					0, 0, 0, //velocity x/y/z
					0, 0, 0, //acceleration x/y/z
					1.0, //staralphaf, default 1.0
					-0.1, //fadestep, default -1
					0.25 //sizestep pre tic
				);
			}			
			TNT1 AAA 0 {
				A_SpawnParticle (
					"8fc75f", 
					SPF_FULLBRIGHT|SPF_RELATIVE, 
					PTCLDURATION, 
					0.75, 
					0, 
					frandom(-0.85,0.85), frandom(-0.85,0.85), frandom(-0.85,0.85), 
					0, 0, 0, 
					0, 0, 0, 
					1.0, 
					-0.1, 
					0.05
				);
			}
			TNT1 AA 0 {
				A_SpawnParticle (
					"b7e77f", 
					SPF_FULLBRIGHT|SPF_RELATIVE, 
					PTCLDURATION, 
					0.45, 
					0, 
					frandom(-0.45,0.45), frandom(-0.45,0.45), frandom(-0.45,0.45), 
					0, 0, 0, 
					0, 0, 0, 
					1.0, 
					-0.1, 
					0.025
				);
			}
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// projectile death sfx ////////////////////////////////////////////////////////
class greenShotParticle : actor {
	Default {
	    +DOOMBOUNCE;
        +MISSILE;
        +CLIENTSIDEONLY;
        +NOTELEPORT;
        +NOBLOCKMAP;
        +BLOODLESSIMPACT;
        +NODAMAGETHRUST;
        +MOVEWITHSECTOR;
        +NOBLOCKMONST;
        -SOLID;
        +THRUACTORS;
        +DONTSPLASH;
        -NOGRAVITY;
        +DONTBLAST;
		+FORCEXYBILLBOARD;
		+NOINTERACTION;
        Scale 0.8;
        Gravity 0.02;
        Radius 0;
        Height 0;
        Damage 0;     
        Speed 0;
    }
    States {
        Spawn:
            PTCL AAAAAAAAAA 1 Bright;
            Stop;
    }
}
class greenShotDeath : actor {
	Default {
		+CannotPush;
		+NoDamageThrust;
		+SpawnSoundsource;
		+nogravity;
        +FORCEXYBILLBOARD;
		RenderStyle "Add";
		scale 0.6;
	}
	States {
		Spawn:
			GP_D ABCDE 3 Bright;
			Stop;
	}

}
class greenShotExplosion : actor {
	Default {
		+NOBLOCKMAP;
		+NOGRAVITY;
		+SHADOW;
		+NOTELEPORT;
		+CANNOTPUSH;
		+NODAMAGETHRUST;
        +FORCEXYBILLBOARD;		
		renderStyle "Add";
		scale 0.6;
		alpha 0.95;
	}	
	States {
		Spawn:
			TNT1 A 0;
			ARLG ABCDEF 2 Bright;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// light bind actors ///////////////////////////////////////////////////////////
class staffFlashShort : flashBase {
	Default {
		+NOINTERACTION;
	}
	States {
		Spawn:
			TNT1 A 3 light("greenFlash");
			Stop;
	}
}
class staffFlashLong : flashBase {
	Default {
		+NOINTERACTION;
	}
	States {
		Spawn:
			TNT1 A 15 light("greenFlash");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////


//  staffblaster.TESTING MODEL  ////////////////////////////////////////////////
class staffBlasterModel : actor {
	Default {
		//$Category ""
		//$color 6
		//$title "blaster staff lvl1 model"
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// DEPRECATED //////////////////////////////////////////////////////////////////
/*class BlasterFlare : actor {
    Default {
		+NOINTERACTION;
        +NOGRAVITY;
        +CLIENTSIDEONLY;
        +DONTBLAST;
        +FORCEXYBILLBOARD;	
        renderstyle "Add";
        radius 1;
        height 1;
        alpha 0.4;
        scale 0.15;
    }
    states {
        Spawn:
            TNT1 A 0;
            TNT1 A 0 A_Jump(128,2);
            LENB A 1 bright;
            stop;
            TNT1 A 0;
            LENB B 1 bright;
            stop;
    }
}*/
/*class BlasterParticle : actor {
    Default {
        +DOOMBOUNCE;
        +MISSILE;
        +CLIENTSIDEONLY;
        +NOTELEPORT;
        +NOBLOCKMAP;
        +CORPSE;
        +BLOODLESSIMPACT;
        +FORCEXYBILLBOARD;
        +NODAMAGETHRUST;
        +MOVEWITHSECTOR;
        +NOBLOCKMONST;
        -SOLID;
        +THRUACTORS;
        +DONTSPLASH;
        -NOGRAVITY;
        +DONTBLAST;
        Scale 0.026;
        Gravity 0.02;
        Radius 0;
        Height 0;
        Damage 0;
        Renderstyle "Add";
        Alpha 0.95;        
        Speed 0;
    }
    States {
		Spawn:
			SPKB AAAAAAAA 1 Bright A_SetScale(scale.x*0.94);
			Stop;
    }
}
class BlasterParticle2 : BlasterParticle {
    Default {
	    Scale 0.07;
    }
    States {
        Spawn:
            SPKB AAAAAAAAA 1 Bright A_SetScale(scale.x*0.86);
            Stop;
    }
}*/
/*class staffShotSmoke2 : actor {
	Default {
		+NOINTERACTION;
		+NOGRAVITY;		
		RenderStyle "Add";
		Scale 0.08;
		Alpha 0.8;
	}	
	States {
		Spawn:
			TNT1 A 0;
			ARLG BCDE 2 bright A_FadeOut(0.1);
		Next:
			TNT1 A 0 A_SetScale(-0.01);
			ARLG F 1 bright A_FadeOut(0.08);
			Loop;
	}
}*/
/*class BlasterTracer : FastProjectile {
    Default {
        +RANDOMIZE
        +FORCEXYBILLBOARD
        +BLOODSPLATTER
		+SpawnSoundsource
		+NoExtremeDeath
		//+THRUGHOST		
		+STRIFEDAMAGE
		
		//DamageType "Disintegrate";
        Radius 2;
        Height 2;
        Speed 184;
        Damage 24; //old: 16
        Decal "blueShotScorch";
        //Projectile;
        //Renderstyle "Add";
        //Alpha 0.90;
		Renderstyle "Add";
        Alpha 0.9;
        //Scale 0.9;        
        MissileType "BlasterParticleTrailSpawner";
        MissileHeight 8;        
		SeeSound "weapons/staffprojectile";
		DeathSound "weapons/shotdeath";
    }

	States {
        Spawn:
            //FX98 A 1 Bright A_SpawnItem("BlasterFlare",0,0);
			DUMM ABCDEFGHI 1 Bright;
			TNT1 A 0 A_SpawnItem("BlasterFlare",0,0);
			//TNT1 AA 0 A_SpawnParticle ("235713", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.35, 0, frandom(-1.25,1.25), frandom(-1.25,1.25), frandom(-1.25,1.25), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.25);				
			//TNT1 AAA 0 A_SpawnParticle ("8fc75f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.5, 0, frandom(-0.85,0.85), frandom(-0.85,0.85), frandom(-0.85,0.85), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.05);
			//TNT1 AA 0 A_SpawnParticle ("b7e77f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.25, 0, frandom(-0.45,0.45), frandom(-0.45,0.45), frandom(-0.45,0.45), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.025);
            Loop;
			
        Death:
            TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("BlasterParticle2",0,0,0,frandom(-6,6),frandom(-6,6),frandom(-6,6),0,SXF_NOCHECKPOSITION);
			TNT1 A 0 A_SpawnItemEx("staffFlashLong", 0, 0, 0, 0);
			//TNT1 A 0 A_SpawnItemEx("blueExplosion", 0, 0, 0, 0);				
			TNT1 A 0 A_SpawnItemEx("greenShotExplosion", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("greenShotDeath", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}

class BlasterParticleTrailSpawner : actor {
    Default {
    	Radius 0;
	    Height 0;
	    +NOINTERACTION;        
		SeeSound "weapons/staffprojectile";
    }

    States {
        Spawn:
            //TNT1 A 0 NoDelay A_Jump(192,"Stopped");
			//TNT1 A 0 A_SpawnItemEx("staffShotSmoke2", 0, 0, 0, 0);
            //TNT1 AA 0 A_SpawnItemEx("BlasterParticle",0,0,0,frandom(-0.4,0.4),frandom(-0.4,0.4),frandom(-0.4,0.4),0,SXF_NOCHECKPOSITION);
            //TNT1 AA 0 A_SpawnItemEx("BlasterParticle",0,0,0,frandom(-0.2,0.2),frandom(-0.2,0.2),frandom(-0.2,0.2),0,SXF_NOCHECKPOSITION);				
			TNT1 AA 0 A_SpawnParticle ("235713", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.35, 0, frandom(-1.25,1.25), frandom(-1.25,1.25), frandom(-1.25,1.25), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.25);				
			TNT1 AAA 0 A_SpawnParticle ("8fc75f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.5, 0, frandom(-0.85,0.85), frandom(-0.85,0.85), frandom(-0.85,0.85), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AA 0 A_SpawnParticle ("b7e77f", SPF_FULLBRIGHT|SPF_RELATIVE, 17, 0.25, 0, frandom(-0.45,0.45), frandom(-0.45,0.45), frandom(-0.45,0.45), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.025);			
        Stopped:
            //TNT1 A 0;
            Stop;
    }
}*/
/*class BlasterTracerTrail : actor {	

	action void W_blasterTrailSpawnParticle(string color, double size, double setRandom) {
		A_SpawnParticle (color, SPF_FULLBRIGHT|SPF_RELATIVE, 1, size, 0, frandom(-setRandom,setRandom), frandom(-setRandom,setRandom), frandom(-setRandom,setRandom), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.25);
	}
	
    Default {
		Alpha 0.5;
		RenderStyle "Add";
		//Scale 0.25;
		+NOINTERACTION
		+NOBLOCKMAP
	}
	States {
		Spawn:			
			//TNT1 AA 0 A_SpawnParticle ("235713", SPF_FULLBRIGHT|SPF_RELATIVE, 1, 0.35, 0, frandom(-1.25,1.25), frandom(-1.25,1.25), frandom(-1.25,1.25), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.25);				
			//TNT1 AAA 0 A_SpawnParticle ("8fc75f", SPF_FULLBRIGHT|SPF_RELATIVE, 1, 0.5, 0, frandom(-0.85,0.85), frandom(-0.85,0.85), frandom(-0.85,0.85), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.05);
			//TNT1 AA 0 A_SpawnParticle ("b7e77f", SPF_FULLBRIGHT|SPF_RELATIVE, 1, 0.25, 0, frandom(-0.45,0.45), frandom(-0.45,0.45), frandom(-0.45,0.45), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.025);
			TNT1 AA 0 W_blasterTrailSpawnParticle("235713", 0.35, 1.25);				
			TNT1 AAA 0 W_blasterTrailSpawnParticle("8fc75f", 0.5, 0.85);
			TNT1 AA 0 W_blasterTrailSpawnParticle("b7e77f", 0.25, 0.45);
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}
}*/
/*class BlasterTracer : blaster_ZTracer {
	Default {
		//Damage 8; //old: 16
		DamageFunction (16 * Random(1, 4));
        Decal "blueShotScorch";
		//Speed 80;        
		SeeSound "weapons/staffprojectile";
		DeathSound "weapons/shotdeath";
	}
	States {
		Spawn:
			DUMM ABCDEFGHI 1 Bright W_SpawnParticleTrail();
			//TNT1 A 1 W_SpawnParticleTrail();
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("BulletPuff");
		//XDeath:
			TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("BlasterParticle2",0,0,0,frandom(-6,6),frandom(-6,6),frandom(-6,6),0,SXF_NOCHECKPOSITION);
			TNT1 A 0 A_SpawnItemEx("staffFlashLong", 0, 0, 0, 0);
			//TNT1 A 0 A_SpawnItemEx("blueExplosion", 0, 0, 0, 0);				
			TNT1 A 0 A_SpawnItemEx("greenShotExplosion", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("greenShotDeath", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}*/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////