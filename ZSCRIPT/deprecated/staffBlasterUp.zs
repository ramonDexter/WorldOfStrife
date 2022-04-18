//==----------------------------------------------------------
class staffBlasterUpgrSelected : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class StaffBlasterUpgr : wosWeapon
{
	int Fire1;
	int Fire2;
	int upStaffSwitch;
	bool staffUpgrIsFiring;
	
	Default
	{
		//$Category "weapons"
		//$color 6
		//$Title "Blaster Staff lvl.2"
		
		+WEAPON.AMMO_OPTIONAL
		+WEAPON.NOAUTOAIM
		+WEAPON.NOAUTOFIRE		
		+WEAPON.NOALERT
		+WEAPON.CHEATNOTWEAPON
		
		
		Tag "$T_STAFFBLASTER2";
		Inventory.icon "H_USTF";
		Inventory.pickupmessage "$F_STAFFBLASTER2";
		Obituary "%o was splattered by %k Blaster Staff";		
		AttackSound "weapons/staffShoot";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.SlotNumber 3;
		Weapon.SlotPriority 0.1;
		//Weapon.SelectionOrder 13
		Weapon.kickback 40;
		Weapon.AmmoType1 "StaffRedMag";
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 0;
		Weapon.AmmoType2 "EnergyPod";
		Weapon.AmmoUse2 0;
		Weapon.AmmoGive2 32;
		//Decal "redShotScorch";
		Scale 0.4;
		Radius 16;
		Height 64;
	}
		States
	{
		Spawn:
			USTD W -1;
			Stop;
					
		Ready:
			USTF J 2 
			{
				A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
				A_WeaponOffset(CallACS("Script_GetGunOffsetX"));
			}	
			Loop;
					
		Deselect:
			TNT1 A 0 { self.takeInventory("staffBlasterUpgrSelected", 1); }
			USTF J 1 A_Lower();
			Loop;
					
		Select:
			TNT1 A 0 {
				self.giveInventory("staffBlasterUpgrSelected", 1);
				//select default fire mode on first selection - fire mode 1
				if ( self.CountInv("staffFire1token") == 0 && self.CountInv("staffFire2token") == 0 ) {					
					self.giveInventory("staffFire1token", 1);
				}
			}
			USTF J 1 A_Raise();
			Loop;

		AltFire:
			TNT1 A 0
			{
				if(invoker.upStaffSwitch == 1)
				{
					return resolveState("setFire2");
				}
				if(invoker.upStaffSwitch == 2)
				{
					return resolveState("setFire1");
				}
				return resolveState(null);
			}
			//intentional fallthrough
		setFire2:
			USTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE | WRF_NOSWITCH|WRF_ALLOWUSER1);
			USSW A 4;
			USSW B 3;
			USSW C 3;
			USSW D 4;
			USSW E 5;
			TNT1 A 0
			{
				A_StartSound("weapons/staffClose", 0);
				invoker.upStaffSwitch = 2;
				self.giveinventory("staffFire2token", 1);
				self.takeinventory("staffFire1token", 1);
			}
			USSW E 5;
			USSW D 4;
			USSW C 3;
 			USSW B 4;
			USSW A 3;
			USTF HIJ 3;
			goto Ready;
		setFire1:
			USTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE | WRF_NOSWITCH|WRF_ALLOWUSER1);
			USSW A 4;
			USSW B 3;
			USSW C 3;
			USSW D 4;
			USSW E 5;
			TNT1 A 0
			{
				A_StartSound("weapons/staffClose", 0);
				invoker.upStaffSwitch = 1;
				self.giveinventory("staffFire1token", 1);
				self.takeinventory("staffFire2token", 1);
			}
			USSW E 5;
			USSW D 4;
			USSW C 3;
 			USSW B 4;
			USSW A 3;
			USTF HIJ 3;
			goto Ready;

		Fire:
			TNT1 A 0
			{
				if(invoker.upStaffSwitch == 1)
				{
					return resolveState("Fire1");
				}
				if(invoker.upStaffSwitch == 2)
				{
					return resolveState("Fire2");
				}
				return resolveState(null);				
			}
			//intentional fallthrough
		Fire1:
			TNT1 A 0 A_JumpIf(invoker.Fire1 == 1, "RealFire1");
			USTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE | WRF_NOSWITCH|WRF_ALLOWUSER1);
			USTF A 1 //takze hul zustane ve stredu obrazu
			{
				invoker.Fire1 = 1;
			}				
		RealFire1:			
			USTF A 0 A_JumpIfNoAmmo("Reload");
			USTF A 1;
			USTF B 3 bright 
			{
				W_FireStaffBlaster("redBlasterTracer", "redFlashShort", true);
				A_AlertMonsters();
			}
			USTF C 4;	
			USTF D 3;		
			USTF E 1;
			USTF F 3;
			USTF A 5 A_Refire("RealFire1"); //umoznuje rychlou strelbu
			USTF A 140 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			USTF GHIJ 4 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1);
			TNT1 A 0
			{
				invoker.Fire1 = 0;
			}
			Goto Ready;
		
		Fire2:
			TNT1 A 0 A_JumpIf(invoker.Fire2 == 1, "RealFire2");
			USTF JIH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1);
			USTF A 1 //takze hul zustane ve stredu obrazu
			{
				invoker.Fire2 = 1;
			}
		RealFire2:			
			USTF A 0 A_JumpIfNoAmmo("StopSoundnReload");
            USTG A 1;
            USTG BC 1 bright A_StartSound("weapons/lightninggun/fire",7);
            USTG D 1;
        Hold:			
			USTF A 0 A_JumpIfNoAmmo("StopSoundnReload");
            USTG E 2 bright
            {
                A_StartSound("weapons/lightninggun/loop", CHAN_6, CHANF_DEFAULT, 1.0, false);                               
                A_GunFlash();
				A_FireProjectile("greenArcLightning", 0.1*random(20,-20), 1, 5, 8, 0, 0.1*random(20,-20));
				A_SpawnItemEx("redFlashShort", 8, 0, 16, 0);
                A_AlertMonsters();
                A_WeaponOffset(random(-2,2), random(30,34), WOF_INTERPOLATE);
            }
            USTG F 2 bright 
            {
                A_StartSound("weapons/lightninggun/loop", CHAN_6, CHANF_DEFAULT, 1.0, false);                                
                A_GunFlash();
				A_FireProjectile("greenArcLightning", 0.1*random(20,-20), 0, 5, 8, 0, 0.1*random(20,-20));
				A_SpawnItemEx("redFlashShort", 8, 0, 16, 0);
                A_AlertMonsters();
                A_WeaponOffset(random(-2,2),random(30,34), WOF_INTERPOLATE);
            }
            USTG E 0 A_Refire("Hold");
        RealFire2End:
            USTG E 1 bright Offset(0,35) A_StartSound("weapons/lightninggun/stop",6);
            USTG D 1 bright Offset(0,34);
            USTG C 1 bright Offset(0,33);
            USTG B 1 bright Offset(0,32);
            USTG A 5 A_ReFire("RealFire2");
            USTF A 140 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			USTF GHIJ 4 A_WeaponReady(WRF_ALLOWRELOAD|WRF_NOFIRE|WRF_NOSWITCH|WRF_ALLOWUSER1);
			TNT1 A 0
			{
				invoker.Fire2 = 0;
			}
			goto Ready;

		StopSoundnReload:
			TNT1 A 0 A_StopSound(CHAN_6);
			goto Reload;		
									  
		ReloadFinish:	
			USTU A 3;
			USTU B 2;
			USTU C 1 A_StartSound("weapons/staffOpen", 0);
			USTU DEFGH 2;
			USTU I 4;
			USTU J 3;
			USTU K 2;
			USTU L 3;
			USTU M 4;
			USTU N 5 A_StartSound("weapons/staffOut", 0);
			USTU OP 3;
			USTU QR 4;
			USTU ST 3;
			USTU UVW 2;
			USTU W 1;
			USTL W 2
			{
				A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
				A_FireProjectile("staffCasingSpawner",-10,0,15,0);				
			}
			USTL WVU 3;
			USTL TS 3;
			USTL RQ 4;
			USTL PO 5;
			USTL N 5;
			USTL M 9 A_StartSound("weapons/mmsl_in", 0);
			USTL L 5;
			USTL K 3;
			USTL J 4;
			USTL I 6;
			USTL HGFED 2;
			USTL C 2 A_StartSound("weapons/staffClose", 0);
			USTL B 2;
			USTL A 3;
			USTL A 3;
			Goto Ready;	
	}
}
class StaffRedMag : ammo
{
	Default
	{
		+Inventory.IgnoreSkill;
		Inventory.MaxAmount 64;
	}
}

class staffFire1token : inventory
{
	Default
	{
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class staffFire2token : inventory
{
	Default
	{
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}


//==----------------------------------------------------------

//melee puff
//==----------------------------------------------------------
class electroMeleePuff : BulletPuff
{
	Default
	{
		seeSound "weapons/staffswing";
		attacksound "weapons/xbowhit";
		activesound "weapons/staffswing";
		renderstyle "add";
		alpha 0.95;
	}
	States
	{
	Spawn:
		ZAP1 A 4 Bright;
		ZAP1 B 4 Bright;
		// Intentional fall-through
	Melee:
		ZAP1 CDEF 4 Bright;
		Stop;
	
	}
}
//primary fire projectile
//==----------------------------------------------------------
class redBlasterTracer : FastProjectile
{
    Default
    {
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
        Damage 32;
        Decal "blueShotScorch";
        Projectile;
        Renderstyle "Add";
        Alpha 0.90;
        Scale 0.9;        
        MissileType "redBlasterParticleTrailSpawner";
        MissileHeight 8;        
		SeeSound "weapons/staffprojectile";
		DeathSound "weapons/shotdeath";
    }

	States
	{
        Spawn:
            FX98 A 1 Bright A_SpawnItem("redBlasterFlare",0,0);
            Loop;
        Death:
            TNT1 A 0;
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("redBlasterParticle2",0,0,0,frandom(-6,6),frandom(-6,6),frandom(-6,6),0,SXF_NOCHECKPOSITION);
			TNT1 A 0 A_SpawnItemEx("redFlashLong", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("lightningExplosion", 0, 0, 0, 0);
			TNT1 A 0 A_SpawnItemEx("redBlasterDeath", 0, 0, 0, 0);
			//TNT1 A 0 A_SpawnItemEx("redExplosion", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}

class redBlasterDeath : actor
{
	Default
	{
		+CannotPush
		+NoDamageThrust
		+SpawnSoundsource
		+nogravity
		
		Renderstyle "Add";
		Alpha 0.90;
		Scale 0.5;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
		Death:		
			GP_D ABCDEF 3 Bright;
			Stop;
	}
}

class redBlasterParticleTrailSpawner : actor
{
    Default
    {
    	Radius 0;
	    Height 0;
	    +NOINTERACTION;
    }

    States
    {
        Spawn:
            TNT1 A 0 NoDelay A_Jump(192,"Stopped");
			TNT1 A 0 A_SpawnItemEx("redShotSmoke2", 0, 0, 0, 0);
            TNT1 AA 0 A_SpawnItemEx("redBlasterParticle",0,0,0,frandom(-0.4,0.4),frandom(-0.4,0.4),frandom(-0.4,0.4),0,SXF_NOCHECKPOSITION);
            TNT1 AA 0 A_SpawnItemEx("redBlasterParticle",0,0,0,frandom(-0.2,0.2),frandom(-0.2,0.2),frandom(-0.2,0.2),0,SXF_NOCHECKPOSITION);			
        Stopped:
            TNT1 A 0;
            Stop;
    }
}

class redBlasterParticle : actor
{
    Default
    {
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

    States
    {
     Spawn:
		SPKB AAAAAAAAAAAAAAAAAAA 1 Bright A_SetScale(scale.x*0.94);
		Stop;
    }
}

class redBlasterParticle2 : redBlasterParticle
{
    Default
    {
	    Scale 0.07;
    }

    States
    {
        Spawn:
            SPKB AAAAAAAAA 1 Bright A_SetScale(scale.x*0.86);
            Stop;
    }
}

class redFlare_General : actor
{
    Default
    {
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

class redBlasterFlare : redFlare_General
{
    Default
    {
        scale 0.15;
    }

    states
    {
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
class redFlashLong : flashBase {
	Default {
		+NOINTERACTION;
	}
	States {
		Spawn:
		TNT1 A 15;
		Stop;
	}
}
class redFlashShort : flashBase //used for light to spawn
{
	Default
	{
		+NOINTERACTION;
	}
	States
	{
	Spawn:
		TNT1 A 3;
		Stop;
	}
}
class redExplosion : actor
{
	Default
	{
		+NOBLOCKMAP;
		+NOGRAVITY;
		+SHADOW;
		+NOTELEPORT;
		+CANNOTPUSH;
		+NODAMAGETHRUST;
		renderStyle "Add";
		scale 0.3;
		alpha 0.95;
	}
	States
	{
	Spawn:
		GXPL ABCDEFGHIJKLM 2 Bright;
		Stop;
	}
}

class redShotSmoke2 : actor
{
	Default
	{
		+NOINTERACTION;
		+NOGRAVITY;
		RenderStyle "Add";
		Scale 0.08;
		Alpha 0.8;
	}
	States
	{
	Spawn:
		TNT1 A 0;
		ARLR BCD 2 bright A_FadeOut(0.1);
		//ARLR ABCDE 2 bright A_FadeOut(0.1);
	Next:
		TNT1 A 0 A_SetScale(-0.01);
		ARLR F 1 bright A_FadeOut(0.08);
		Loop;
	}
}
//altfire projectile
//==----------------------------------------------------------
/*
class greenArcLightning : FastProjectile
{
    Default
    {
        Speed 50;
        Radius 4;
        Height 4;
        Damage 12;
        Renderstyle "Add";
        DamageType "Disintegrate";
        MissileType "arcLightningTrailSpawner";
		Decal "DoomImpScorch";

        +CANNOTPUSH
        +BLOODLESSIMPACT
		+THRUGHOST
    }

    states
    {
        Spawn:
            TNT1 A 2;
        Looplet:
            TNT1 A 0;
            TNT1 A 2 A_ChangeVelocity(frandom(-8,8), frandom(-8,8), frandom(-3, 3), 0);
            TNT1 A 2 A_ChangeVelocity(frandom(-8,8), frandom(-8,8), frandom(-3, 3), 0);
            TNT1 A 2 A_ChangeVelocity(frandom(-6,6), frandom(-6,6), frandom(-3, 3), 0);
            Stop;
        Ded:
            TNT1 A 1;
            stop;
    }
}
class arcLightningTrailSpawner : actor
{
    Default
    {
        +NOINTERACTION
        +NOGRAVITY
		+THRUGHOST
    }

    States
    {
        Spawn:
            TNT1 A 0;
            TNT1 A 2 A_SpawnItemEx("arcLightningTrail",frandom(2.0,-2.0),frandom(2.0,-2.0),4+frandom(2.0,-2.0),0,0,0,0,0,0);
            Stop;
    }
}
class arcLightningTrail : actor
{
    Default
    {
        RenderStyle "Add";
        Scale 0.175;
        Alpha 0.75;

        +NOINTERACTION
        +NOGRAVITY
		+THRUGHOST
    }

    States
    {
        Spawn:
            TNT1 A 0;
            PLSG BBCCDD 1 bright A_FadeOut(0.1);
        Trolololo:
            TNT1 A 0 A_SetScale(Scale.X -0.01, Scale.Y -0.01);
            PLSG D 1 bright A_FadeOut(0.08);
            Loop;
    }
}
*/
//==----------------------------------------------------------
/*
//altfire projectile - lightning
class arcLightning : FastProjectile
{
	Default
	{
		+RIPPER
		+CANNOTPUSH
		+BLOODLESSIMPACT
		
		Speed 50;
		Radius 11;
		Height 6;
		DamageFunction (1*random(3,5));
		Renderstyle "Add";
		//ReactionTime 5
		DamageType "Fire";
		MissileType "arcLightningTrailSpawner";
	}
	
	states
	{
		Spawn:
			TNT1 A 2			
		Looplet:
			TNT1 A 0; //A_Countdown
			TNT1 A 1 A_ChangeVelocity (frandom(-22,22), frandom(-22, 22), frandom(-10, 10), 0);
			TNT1 A 1 A_ChangeVelocity (frandom(-22,22), frandom(-22, 22), frandom(-10, 10), 0);
			TNT1 A 1 A_ChangeVelocity (frandom(-22,22), frandom(-22, 22), frandom(-10, 10), 0);
			Stop;
		Ded:
			TNT1 A 1;
			stop;
	}
}

class arcLightningTrailSpawner : actor
{
	Default
	{
		+NOINTERACTION
		+NOGRAVITY
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 2 A_SpawnItemEx("arcLightningTrail",frandom(2.0,-2.0),frandom(2.0,-2.0),4+frandom(2.0,-2.0),0,0,0,0,0,0);
			Stop;
	}
}
class arcLightningTrail : actor
{
	Default
	{
		+NOINTERACTION
		+NOGRAVITY
		
		RenderStyle "Add";
		Scale 0.5;
		Alpha 0.8;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			ARLB ABCDE 2 bright A_FadeOut(0.1);
		Trolololo:
			TNT1 A 0 A_SetScale(scale.x -0.01, Scale.Y -0.01);
			ARLB F 1 bright A_FadeOut(0.08);
			Loop;
	}
}
*/