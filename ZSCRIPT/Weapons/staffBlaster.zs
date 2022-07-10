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
		Weapon.AmmoType1 "magazine_blasterStaff";
		Weapon.AmmoUse1 1;
		Weapon.AmmoType2 "EnergyPod";
		Weapon.AmmoUse2 0;
		Weapon.AmmoGive2 64;
		//Decal "BulletChip";
		Mass blasterStaffBaseWeight;
		
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
			TNT1 A 0 A_JumpIf(invoker.staffIsFiring == 1, "RealFire");
			ASTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			ASTF A 1 { invoker.staffIsFiring = 1; } //takze hul zustane ve stredu obrazu 		
		RealFire:
			ASTF A 0 A_JumpIfNoAmmo("Reload");
			ASTF A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH);
			ASTF B 3 bright W_FireStaffBlaster("BlasterTracer", "staffFlashShort", true);
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
			TNT1 A 0 W_StaffSwing("StaffBlasterPuff");
			STFM M 2; //IJKLM
			STFM M 1;
			STFM LKJI 2;
			STFM HG 1;
			STFM FE 2;
			Goto Ready;		
		
		Reload:
			TNT1 A 0 W_reloadCheck();
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
			TNT1 A 0 W_Reload();
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
class StaffBlasterPuff: BulletPuff {
	Default {
		seeSound "weapons/staffswing";
		attacksound "weapons/staffhit";
		activesound "weapons/staffswing";
	}
}
//  staffBlaster.projectile  ///////////////////////////////////////////////////
class BlasterTracer : FastProjectile {
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
        Projectile;
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
			TNT1 A 0 A_SpawnItemEx("lightningExplosion", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("blueshotDeath", 0, 0, 0, 0);
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
}
class BlasterParticle : actor {
    Default {
        +DOOMBOUNCE
        +MISSILE
        +CLIENTSIDEONLY
        +NOTELEPORT
        +NOBLOCKMAP
        +CORPSE
        +BLOODLESSIMPACT
        +FORCEXYBILLBOARD
        +NODAMAGETHRUST
        +MOVEWITHSECTOR
        +NOBLOCKMONST
        -SOLID
        +THRUACTORS
        +DONTSPLASH
        -NOGRAVITY
        +DONTBLAST

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
}
class Flare_General : actor {
    Default {
        +NOINTERACTION
        +NOGRAVITY
        +CLIENTSIDEONLY
        +DONTBLAST
        +FORCEXYBILLBOARD
		
        renderstyle "Add";
        radius 1;
        height 1;
        alpha 0.4;
        scale 0.4;
    }
}
class BlasterFlare : Flare_General {
    Default {
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
}
class blueshotDeath : actor {
	Default {
		+CannotPush
		+NoDamageThrust
		+SpawnSoundsource
		+nogravity
        +FORCEXYBILLBOARD
		RenderStyle "Add";
		scale 0.6;
	}
	States {
		Spawn:
			GP_D ABCDE 3 Bright;
			Stop;
	}

}
class staffFlashShort : flashBase {
	Default {
		+NOINTERACTION;
	}
	States {
		Spawn:
			TNT1 A 3;
			Stop;
	}
}
class staffFlashLong : flashBase {
	Default {}
	States {
		Spawn:
			TNT1 A 15;
			Stop;
	}
}
class lightningExplosion : actor {
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
		alpha 0.95;
	}
	
	States {
		Spawn:
			TNT1 A 0;
			ARLG ABCDEF 2 Bright;
			Stop;
	}
}
class staffShotSmoke2 : actor {
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
			ARLG BCDE 2 bright A_FadeOut(0.1);
		Next:
			TNT1 A 0 A_SetScale(-0.01);
			ARLG F 1 bright A_FadeOut(0.08);
			Loop;
	}
}
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
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////