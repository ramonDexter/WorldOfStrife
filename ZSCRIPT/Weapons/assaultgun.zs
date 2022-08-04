//const assaultGunBaseWeight = 150;

class magazine_wosAssaultGun : ammo {
	Default {
		+Inventory.IgnoreSkill;		
		Inventory.MaxAmount 32;
		Mass 0;
	}
}

class wosAssaultGun : wosWeapon replaces AssaultGun {
	bool assaultGun_isFiring;
	
	Default {
		//$Category "Weapons/WoS"
		//$Title "zsc Assault Gun"
	
		+WEAPON.AMMO_OPTIONAL
		+FLOORCLIP
		+THRUGHOST
		
		
		radius 12;
		height 12;
		
		Tag "$T_ASSAULTGUN";	
		inventory.icon "H_RIFL";
		Weapon.SelectionOrder 600;
		Weapon.SlotNumber 3;
		Weapon.SlotPriority 1;
		Weapon.Kickback 40;
		Inventory.PickupMessage "$F_ASSAULTGUN";
		Obituary "$OBI_wosAssaultGun"; // %o was drilled full of holes by %k's assault gun.		
        Weapon.UpSound "weapons/weaponUP";
		Mass assaultGunBaseWeight;
		// new magazine&reload system //////////////////////////////////////////
		wosWeapon.Magazine 32;
		wosWeapon.magazineMax 32;
		wosWeapon.magazineType "ClipOfBullets";
		//Weapon.AmmoType1 "magazine_wosAssaultGun";
		//Weapon.AmmoUse1 1;	
		//Weapon.AmmoGive1 0;	
		//Weapon.AmmoType2 "ClipOfBullets";
		//Weapon.AmmoUse2 0;
		//Weapon.AmmoGive2 32;
		//Decal "SVEbulletScorch";
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

		Select:
			RIFG A 1 A_Raise();
			RIFG A 0 A_Raise();
			Loop;
			
		Deselect:
			RIFG B 0 A_Lower();
			RIFG B 1 A_Lower();
			Loop;
			
		Ready:
			RIFG A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			Loop;
			
		Fire:
			TNT1 A 0 W_CheckAmmo();
			TNT1 A 0 A_JumpIf(invoker.assaultGun_isFiring == 1, "RealFire");
			RIFG AEH 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);			
			TNT1 A 0
			{
				invoker.assaultGun_isFiring = 1;				
			}
		RealFire:
			TNT1 A 0 W_CheckAmmo();
			RIFF A 1 W_ShootFirearm(4, "weapons/assaultgun");
			TNT1 A 0 A_AlertMonsters();	
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("Casing9mm",random(3,4),cos(pitch)*-25,sin(-pitch)*25+random(31,32),	random(1,3),0,random(4,6), random(-80,-90),0, SXF_ABSOLUTEMOMENTUM);
			RIFF C 2;
			RIFF D 1;
			RIFF E 1 W_ShootFirearm2(4, "weapons/assaultgun");
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("Casing9mm",random(3,4),cos(pitch)*-25,sin(-pitch)*25+random(31,32),	random(1,3),0,random(4,6), random(-80,-90),0, SXF_ABSOLUTEMOMENTUM);
			RIFF A 0 A_Refire("RealFire");
			RIFG H 140 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			RIFG GFEDCBA 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			TNT1 A 0
			{
				invoker.assaultGun_isFiring = 0;
			}
			goto Ready;
			
		
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			//TNT1 A 0 W_reloadCheck();
			RIFG ABCDEFG 1;
			RIFR A 2;
			RIFR B 3;
			RIFR C 2;
			RIFR D 4 A_StartSound("weapons/RLpistolRLout", 1);
			RIFR E 2;
			RIFR FG 3;
			RIFR H 1;
			RIFR IJ 6;
			RIFR KL 2;
			RIFR MN 2;
			RIFR O 4 A_StartSound("weapons/RLpistolRLin", 1);
			TNT1 A 0 W_reload2();
			RIFR P 3;
			RIFR CB 2;
			RIFR A 1;
			RIFG GFEDCBA 1;
			Goto Ready;
			
		
	}
}

class wosAssaultGun_standing : WeaponGiver replaces AssaultGunStanding {
	Default {
		//$Category "Weapons"
		//$Title "zsc Assault Gun - standing"
		DropItem "wosAssaultGun";
		Inventory.PickupMessage "$TXT_ASSAULTGUN";
		radius 12;
		height 32;
		Tag "$T_ASSAULTGUN";
	}
	
	States {
		Spawn:
			DUMM B -1;
			Stop;
	}
}