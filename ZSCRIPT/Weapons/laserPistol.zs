////////////////////////////////////////////////////////////////////////////////
// laser pistol ////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class laserPistol : wosWeapon {
	bool laserPistolIsFiring;
	
	Default {
		//$Category "weapons/WoS"
		//$Title "Laser Pistol (weapon)"
		+WEAPON.AMMO_OPTIONAL;
		+WEAPON.NOAUTOAIM;
		+WEAPON.NOAUTOFIRE;	
		+WEAPON.NOALERT;
		
		//radius 12;
		Height 16;		
		Tag "$TAG_laserPistol";
		Inventory.icon "H_LSPS";
		Inventory.pickupmessage "$FND_laserPistol";
		Obituary "$OBI_laserPistol"; // %o was burned to ashes by %k Laser Pistol
		AttackSound "weapons/staffShoot";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.SlotNumber 2;
		Weapon.SlotPriority 3;
		Mass laserPistolBaseWeight;
		// new magazine&reload system //////////////////////////////////////////
		wosWeapon.Magazine 32;
		wosWeapon.magazineMax 32;
		wosWeapon.magazineType "EnergyPod";
	}
	
	States {
		Spawn:
			DUMM ABCDEF 3;
			Loop;
		Select:
			LSPI C 1 A_Raise();
			LSPI C 0 A_Raise();
			Loop;
		Deselect:
			LSPI C 0 A_Lower();
			LSPI C 1 A_Lower();
			Loop;	
		Nope:
			TNT1 A 1 {
				A_WeaponReady(WRF_NOFIRE); 
				A_ZoomFactor(1.0);
			}
			//TNT1 A 0 B_NoReFire();
			TNT1 A 0 A_ClearReFire();
			Goto Ready;
		Ready:
			LSPI DEFGHI 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			Loop;
		Fire:
			TNT1 A 0 W_CheckAmmo();	
			//DUMM A 0 A_JumpIfNoAmmo("Reload");		
			TNT1 A 0 A_JumpIf(invoker.laserPistolIsFiring == true, "RealFire");
			LSPI CBA 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPI A 1 {
				invoker.laserPistolIsFiring = true;
			}
		RealFire:
			LSPI A 0 W_CheckAmmo();
			//DUMM A 0 A_JumpIfNoAmmo("Reload");
			LSPS BDF 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH);
			LSPS G 2 bright W_FireLaserPistol2("laserTracer", "lasPisFlashShort");
			LSPS H 2;
			LSPS I 2;
			LSPS I 2 A_Refire("RealFire");
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPS ABCDEF 3 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			LSPI ABC 4 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4|WRF_NOFIRE|WRF_NOSWITCH);
			TNT1 A 0 {
				invoker.laserPistolIsFiring = false;
			}
			Goto Ready;
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			//TNT1 A 0 W_reloadCheck();
			LSPR A 2;
			LSPR B 2;
			LSPR C 2;
			LSPR D 2;
			LSPR E 2;
			LSPR F 2;
			LSPR G 2;
			LSPR H 2;
			TNT1 A 0 A_StartSound("weapons/mmsl_in", 0); //zacatek nabijeni; sem dat nejakej zvuk pripojeni a nabijeni
			LSPR I 2;
			LSPR J 2;
			LSPR K 2;
			LSPR L 15;
			LSPR M 20; //konec nabijeni, zvuk odpojeni, nebo na predchozi frame
			TNT1 A 0 { 
				A_StartSound("weapons/staffOut", 0);
				W_reload2();
			}
			LSPR N 2;
			LSPR O 2;
			LSPR P 2;
			LSPR Q 2;
			LSPR R 2;
			LSPR S 2;
			Goto Ready;	
	}
}
class temp_laserPistolProjectile : SentinelFX2 {
	Default {
		Damage 8;
	}
}
class lasPisFlashShort : FlashBase {
	Default { +NOINTERACTION }	
	States {
		Spawn:
			TNT1 A 3;
			Stop;
	}
}
class lasPisFlashLong : FlashBase {
	Default { +NOINTERACTION }	
	States {
		Spawn:
			TNT1 A 15;
			Stop;
	}
}

class laserTracer : FastProjectile {
    const TRACERDURATION	= 1; // tics
	const TRACERLENGTH		= 128.0; // float
	const TRACERSCALE		= 4.0; // float
	const TRACERSTEP		= 0.005; // float
	//const TRACERACTOR		= "laserTracerTrail"; // actor name
	const TRACERSPEED		= 90;

	float x1, y1, z1;
	float x2, y2, z2;
	
	// intentional briticism to avoid conflicts with "color" keyword.
	// modified with strife fitting colors
	static const color colours[] = {
		
		// reversed order
		"db 2b 2b",
		"cb 23 23",
		"bf 1f 1f",
		"af 1b 1b",
		"af 1b 1b",
		"93 13 13"
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

	void W_spawnLaserParticleTrail() {
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
			/*A_SpawnItemEx (
				TRACERACTOR,
				pos.x - lerp(x1, x2, i),
				pos.y - lerp(y1, y2, i),
				pos.z - lerp(z1, z2, i),
				0, 0, 0, 0,
				SXF_ABSOLUTEPOSITION
			);	*/		
		}		
	}

    Default {
        Radius 2;
        Height 2;
		Speed TRACERSPEED;
        Damage 6;
        Decal "redShotScorch";        
		SeeSound "weapons/laserProj";
		DeathSound "weapons/lasProjDeath";
		+NOEXTREMEDEATH;
    }
    States {
        Spawn:
            LSTR A 1 Bright W_spawnLaserParticleTrail();
            Loop;
        Death:
            TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 2.5, 0, frandom(-1,1),  frandom(-1,1), frandom(-1,1), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 1.75, 0, frandom(-0.5,0.5),  frandom(-0.5,0.5), frandom(-0.5,0.5), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.025);
			TNT1 A 0 A_SpawnItemEx("lasPisFlashLong", 0, 0, 0, 0);			
			TNT1 A 0 A_SpawnItemEx("laserExplosion", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}
/*class laserTracer : FastProjectile {
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
        Damage 6;
        Decal "redShotScorch";
        Projectile;
        Renderstyle "Add";
        Alpha 0.90;
        Scale 0.9;        
        MissileType "laserParticleTrailSpawner";
        MissileHeight 8;        
		SeeSound "weapons/laserProj";
		DeathSound "weapons/lasProjDeath";
    }

	States {
        Spawn:
            LSTR A 1 Bright A_SpawnItem("laserFlare",0,0);
            Loop;
        Death:
            TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 2.5, 0, frandom(-1,1),  frandom(-1,1), frandom(-1,1), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 1.75, 0, frandom(-0.5,0.5),  frandom(-0.5,0.5), frandom(-0.5,0.5), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.025);
			TNT1 A 0 A_SpawnItemEx("lasPisFlashLong", 0, 0, 0, 0);			
			TNT1 A 0 A_SpawnItemEx("laserExplosion", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}*/
class laserParticleTrailSpawner : actor {
    Default {
    	Radius 0;
	    Height 0;
	    +NOINTERACTION;        
		SeeSound "weapons/staffprojectile";
    }

    States {
        Spawn:
			TNT1 A 0 A_SpawnItemEx("laserShotSmoke", 0, 0, 0, 0);
			TNT1 AA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 0.5, 0, frandom(-1,1), frandom(-1,1), frandom(-1,1), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 0.25, 0, frandom(-0.5,0.5), frandom(-0.5,0.5), frandom(-0.5,0.5), 0, 0, 0, 0, 0, 0, 1.0, -0.1, 0.025);
            Stop;
    }
}
class Flare_General : actor {
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
        scale 0.4;
    }
}
class laserFlare : Flare_General {
    Default {
        scale 0.15;
    }

    states {
        Spawn:
            TNT1 A 0;
            TNT1 A 0 A_Jump(128,2);
            LENR A 1 bright;
            stop;
            TNT1 A 0;
            LENR B 1 bright;
            stop;
    }
}
class laserParticle : actor {
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
        Renderstyle "translucent";
        Alpha 0.25;        
        Speed 0;
    }

    States {
        Spawn:
		    SPKR AAAAAAAA 1 Bright A_SetScale(scale.x*0.94);
		    Stop;
    }
}
class laserParticle2 : laserParticle {
    Default {
	    Scale 0.07;
    }

    States {
        Spawn:
            SPKR AAAAAAAAA 1 Bright A_SetScale(scale.x*0.86);
            Stop;
    }
}
class laserShotSmoke : actor {
	Default {
		+NOINTERACTION
		+NOGRAVITY
		
		RenderStyle "Add";
		Scale 0.08;
		Alpha 0.8;
	}
	
	States {
        Spawn:
            TNT1 A 0;
            ARLR BCDE 2 bright A_FadeOut(0.1);
            //ARLB ABCDE 2 bright A_FadeOut(0.1);
        Next:
            TNT1 A 0 A_SetScale(-0.01);
            ARLR F 1 bright A_FadeOut(0.08);
            Loop;
	}
}
class laserExplosion : actor {
	Default {
		+NOBLOCKMAP
		+NOGRAVITY
		+SHADOW
		+NOTELEPORT
		+CANNOTPUSH
		+NODAMAGETHRUST
        +FORCEXYBILLBOARD
		
		renderStyle "Add";
		scale 0.6;
		alpha 0.75;
	}
	
	States {
        Spawn:
            TNT1 A 0;
            ARLR ABCDEF 2 Bright;
            Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


		
		//Weapon.AmmoType1 "magazine_pistolLaser";
		//Weapon.AmmoUse1 1;
		//Weapon.AmmoType2 "EnergyPod";
		//Weapon.AmmoUse2 0;
		//Weapon.AmmoGive2 32;		
		//Weapon.kickback 40;

//const laserPistolBaseWeight = 70;

/*class magazine_pistolLaser : ammo {
	Default {
		+Inventory.IgnoreSkill
		Mass 0;
		inventory.maxAmount 32;
	}
}*/
/*
class lasershotDeath : actor
{
	Default
	{
		+CannotPush
		+NoDamageThrust
		+SpawnSoundsource
		+nogravity
		RenderStyle "Add";
		scale 0.25;
	}
	States
	{
        Spawn:
            RP_D ABCDE 3 Bright;
            Stop;
	}
}

class laserTracer : fastProjectile {
	Default {
		+RANDOMIZE
		
		MissileType "laserMissileType";
		Radius 13;
		Height 8;
		Speed 184;
		DamageFunction (5*random(1,5));
		Projectile;
		RenderStyle "Translucent";
		Alpha 0.5;
		SeeSound "weapons/laserProj";
		DeathSound "weapons/plasmax";
		Obituary "$OB_MPPLASMARIFLE";
		Decal "MyDecal";
	}
	
	States {
		Spawn:
			LAZR DDDD 4;
		Death:
			LAZR ABCDE 4 Bright;
			Stop;
	}
}

class laserMissileType : actor {
	Default {
		+NOBLOCKMAP;
		+NOGRAVITY;
		+SHADOW;
		+NOTELEPORT;
		+CANNOTPUSH;
		+NODAMAGETHRUST;
		RenderStyle "Translucent";
		Alpha 0.6;
	}
	
	States {
		Spawn:
			TNT1 A 0;
			LAZR EE 4;
			Stop;
	}
}

class laserPistolProjectile : FastProjectile {
	Default {
		+RANDOMIZE
        +FORCEXYBILLBOARD
        +BLOODSPLATTER
		+SpawnSoundsource
		+NoExtremeDeath
		//+THRUGHOST
		DamageType "Disintegrate";
        Radius 2;
        Height 2;
        Speed 184;
        Damage 10; //old: 16
        Decal "blueShotScorch";
        Projectile;
        //Renderstyle "Add";
        //Alpha 0.90;
        //Scale 0.9;        
        MissileType "BlasterParticleTrailSpawner";
        MissileHeight 8;        
		SeeSound "weapons/staffprojectile";
		DeathSound "weapons/shotdeath";
	}
	
	States {
		Spawn:
			DUMM A 2 {
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
			}
			DUMM B 2 {
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
				A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 35, 1, 0, frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), frandom(-6,6), 0, 0, 0, 1.0, 0.2, 1);
			}
			Loop;
		Death:
            TNT1 A 0;
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("BlasterParticle2",0,0,0,frandom(-6,6),frandom(-6,6),frandom(-6,6),0,SXF_NOCHECKPOSITION);
			TNT1 A 0 A_SpawnItemEx("staffFlashLong", 0, 0, 0, 0);
			//TNT1 A 0 A_SpawnItemEx("blueExplosion", 0, 0, 0, 0);				
			TNT1 A 0 A_SpawnItemEx("lightningExplosion", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("blueshotDeath", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
			
	}
}
class laserProjectileTrailSpawner : actor {
	Default {
		Radius 0;
	    Height 0;
	    +NOINTERACTION;        
		SeeSound "weapons/staffprojectile";
	}
	States {}
}
*/