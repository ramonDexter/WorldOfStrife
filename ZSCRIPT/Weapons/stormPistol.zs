////////////////////////////////////////////////////////////////////////////////
// storm pistol ////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// weapon //////////////////////////////////////////////////////////////////////
class StormPistol : wosWeapon {

	/*override void AttachToOwner(actor other) {
		Super.AttachToOwner(other);
		let pawn = binderplayer(owner);
		pawn.GiveInventory("ClipOfBullets", 12);
	}*/

	Default {
		//$Category "weapons/WoS"
		//$Title "Pistol"
		
		+Weapon.AMMO_OPTIONAL;
		+THRUGHOST;
		
		Tag "$TAG_StormPistol";
		Inventory.icon "H_SPIS";
		Inventory.Pickupmessage "$FND_StormPistol";
		Inventory.Pickupsound "misc/w_pkup";
		Obituary "$OBI_StormPistol"; // %o was bolted by %k's storm pistol.
		AttackSound "weapons/rlPistolShoot";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.Kickback 40;
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 800;
		Mass stormPistolBaseWeight;
		wosWeapon.Magazine 12;
		wosWeapon.magazineMax 12;
		wosWeapon.magazineType "ClipOfBullets";
	}
	
	States {
		Spawn:
			DUMM Z -1;
			Stop;			
		Nope:
			DUMM A 1 {
				A_WeaponReady(WRF_NOFIRE); 
				A_ZoomFactor(1.0);
			}
			TNT1 A 0 A_ClearReFire();
			Goto Ready;
		Ready:
			DUMM A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
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
			TNT1 A 0 W_CheckAmmo();
			DUMM A 1;
			DUMM B 3 {
				A_GunFlash();				
				W_ShootFirearm2(3, "weapons/rlPistolShoot");
				A_AlertMonsters();
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
			}				
			DUMM C 2;
			//TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			//TNT1 A 0 A_FireProjectile("pistolCasingSpawner",-10,0,15,0);
			DUMM DE 1;
			DUMM F 1 A_ReFire();
			Goto Ready;
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			DUMM G 3;
			DUMM HI 2;
			DUMM JKL 3 A_StartSound("weapons/RLpistolRLout", 1);
			DUMM M 5;
			DUMM NOPQ 2;
			DUMM PON 3;
			DUMM M 5 A_StartSound("weapons/RLpistolRLin", 1);
			TNT1 A 0 W_Reload2();
			DUMM LKJ 2;
			DUMM IHG 3;
			Goto Ready;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//const stormPistolBaseWeight = 50;



		//Weapon.AmmoUse1 1;
		//Weapon.AmmoGive1 0;
		//Weapon.AmmoType1 "magazine_pistol";
		//Weapon.AmmoGive2 0;
		//Weapon.AmmoType2 "ClipOfBullets";
		//Decal "SVEbulletScorch";

		
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
				A_TakeInventory("magazine_pistol", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM B 1 {
				A_GunFlash();				
				A_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
				A_TakeInventory("magazine_pistol", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM B 1 {
				A_GunFlash();				
				A_ShootFirearm(3, "weapons/rlPistolShoot");
				A_SpawnItemEx("gunFlash", 8, 0, 16, 0);
				A_TakeInventory("magazine_pistol", 1);
			}				
			DUMM C 2;
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("pistolCasingSpawner", -7, 12, 15, 0);
			DUMM DE 3;
			DUMM F 4 A_ReFire();
			Goto Ready;
		*/
			
			

/*class magazine_pistol : ammo {
	Default {
		Inventory.MaxAmount 12;
		+Inventory.IGNORESKILL;
		Mass 0;
	}
}*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////