//=--RL PISTOL----------------------------------------------------------------==
const stormPistolBaseWeight = 50;

class StormPistol : augmentedWeapon 
{
	Default
	{
		//$Category "weapons/WoS"
		//$Title "Pistol"
		
		+Weapon.AMMO_OPTIONAL
		+THRUGHOST
		
		//scale 0.5;
		height 12;
		radius 12;
		Tag "$T_PISTOL";
		Inventory.icon "H_SPIS";
		Inventory.Pickupmessage "$F_PISTOL";
		Inventory.Pickupsound "misc/w_pkup";
		Obituary "%o was bolted by %k's storm pistol.";
		AttackSound "weapons/rlPistolShoot";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.Kickback 40;
		Weapon.SlotNumber 2;
		Weapon.SlotPriority 0.1;
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 0;
		Weapon.AmmoType1 "stormPistol_magazine";
		Weapon.AmmoGive2 0;
		Weapon.AmmoType2 "ClipOfBullets";
		//Decal "SVEbulletScorch";
		Mass stormPistolBaseWeight;
	}
	
	States
	{
		Spawn:
			DUMM R -1;
			Stop;
			
		Ready:
			DUMM A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			Loop;
		
		Deselect:
			DUMM A 0 A_Lower();
			DUMM A 1 A_Lower();
			Loop;
		
		Select:
			DUMM A 1 A_Raise();
			DUMM A 0 A_Raise();
			Loop;
		
		Fire:
			DUMM A 0 A_JumpIfNoAmmo("Reload");
			DUMM A 4;
			DUMM B 1 {
				A_GunFlash();				
				W_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_FireProjectile("pistolCasingSpawner",-10,0,15,0);
			//TNT1 A 0 A_SpawnItemEx("Casing9mm",random(3,4),cos(pitch)*-25,sin(-pitch)*25+random(31,32), random(1,3),0,random(4,6), random(-80,-90),0, SXF_ABSOLUTEMOMENTUM);
			DUMM DE 3;
			DUMM F 4 A_ReFire();
			Goto Ready;
		/*
		Flash:
			SPIS B 4 bright A_light2();
			Stop;		
			*/ 
		/*
		Altfire:
			DUMM A 0 A_JumpIfNoAmmo("Reload");
			DUMM A 4;
			DUMM B 1 {
				A_GunFlash();				
				A_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
				A_TakeInventory("stormPistol_magazine", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM B 1 {
				A_GunFlash();				
				A_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
				A_TakeInventory("stormPistol_magazine", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM B 1 {
				A_GunFlash();				
				A_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
				A_TakeInventory("stormPistol_magazine", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM DE 3;
			DUMM F 4 A_ReFire();
			Goto Ready;
		*/
			
			
		Reload:
			TNT1 A 0 W_reloadCheck();
			DUMM G 3;
			DUMM HI 2;
			DUMM JKL 3 A_StartSound("weapons/RLpistolRLout", 1);
			DUMM M 5;
			DUMM NOPQ 2;
			DUMM PON 3;
			DUMM M 5 A_StartSound("weapons/RLpistolRLin", 1);
			TNT1 A 0 W_Reload();
			DUMM LKJ 2;
			DUMM IHG 3;
			Goto Ready;
		  
		
			
			
		
	}
}

class stormPistol_magazine : Ammo //actor for reloading weapon - actually ammo in magazine
{
	Default
	{
		 Inventory.MaxAmount 12;
		 +Inventory.IGNORESKILL;
	}
}


//==--------------------------------------------------------------------------==
