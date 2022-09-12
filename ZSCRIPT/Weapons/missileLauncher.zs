////////////////////////////////////////////////////////////////////////////////
// mini-missile launcher ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// weapon //////////////////////////////////////////////////////////////////////
class wosMinimissileLauncher : wosWeapon replaces MiniMissileLauncher {
	int miniMissile_Switch;

	Default {	
		//$Category "Weapons/WoS"		
		//$Title "zsc Mini Missile Launcher"
		
		+WEAPON.AMMO_OPTIONAL;
		+FLOORCLIP;
		+WEAPON.NOAUTOAIM;
		
		Tag "$T_MISSILELAUNCHER";
		Inventory.PickupMessage  "$F_MISSILELAUNCHER";
		Tag "Mini Missile Launcher";
		inventory.icon "H_MMSL";		
		Weapon.SlotNumber 4;
		Weapon.SelectionOrder 1800;
        Weapon.UpSound "weapons/weaponUP";
		Mass missileLauncherBaseWeight;
		wosWeapon.Magazine 8;
		wosWeapon.magazineMax 8;
		wosWeapon.magazineType "MiniMissiles";
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
			TNT1 A 0 A_ClearReFire();
			Goto Ready;			
		Ready:			
			MMIS A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			Loop;			
		Deselect:
			MMIS A 1 A_Lower();
			TNT1 A 0 A_SetCrosshair(9);	
			Loop;		
		Select:
			TNT1 A 0 A_SetCrosshair(10);
			MMIS A 1 A_Raise();
			Loop;				
		Fire:
			MMIS A 0 W_CheckAmmo();
			MMIS A 4 W_zscFireMiniMissile2("zscMiniMissile");
			MMIS B 4 A_Light1();
			MMIS C 5 Bright;
			MMIS D 2 Bright A_Light2();
			MMIS E 2 Bright;
			MMIS F 2 Bright A_Light0();
			MMIS F 0 A_ReFire();
			Goto Ready;		
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			MMIS A 1 Offset(0,35);
			MMIS A 1 Offset(0,38) A_StartSound("weapons/RLpistolRLout", 1);
			MMIS A 1 Offset(0,44);
			MMIS A 1 Offset(0,52);
			MMIS A 1 Offset(0,62);
			MMIS A 1 Offset(0,72);
			MMIS A 1 Offset(0,82);
			TNT1 A 16 W_Reload2(); //middle
			MMIS A 1 Offset(0,82);
			MMIS A 1 Offset(0,72);
			MMIS A 1 Offset(0,62);
			MMIS A 1 Offset(0,52);
			MMIS A 1 Offset(0,44);
			MMIS A 1 Offset(0,38) A_StartSound("weapons/RLpistolRLin", 1);
			MMIS A 1 Offset(0,35);
			MMIS A 1 Offset(0,32);
			Goto Ready;
	}
}
////////////////////////////////////////////////////////////////////////////////

// projectile //////////////////////////////////////////////////////////////////
class zscMiniMissile : MiniMissile {
	Default {
		+THRUGHOST
		Damage 20;
	}
	States {
		Death:
			SMIS A 0 A_AlertMonsters();
			SMIS A 0 Bright A_SetTranslucent(1, 1);
			SMIS A 0 Bright; // State left for savegame compatibility
			SMIS A 5 Bright A_Explode(64, 64, 1, 1);
			SMIS B 5 Bright;
			SMIS C 4 Bright;
			SMIS DEFG 2 Bright;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

			/*TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) { return ResolveState("ReadyPrimary");}
				if(invoker.miniMissile_Switch == 1) { return ResolveState("ReadyAlt");}
				return ResolveState(null);
			}		
		ReadyPrimary:*/
		/*ReadyAlt:
			MMIS T 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
			Loop;*/
			
		//AltFire:
			/*TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("SetAlt");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("SetPrimary");}
				return ResolveState(null);
			}*/
		/*SetAlt:
			TNT1 A 0 {
				invoker.miniMissile_Switch = 1;
				//self.giveinventory("missileLauncherFire2token", 1);
				//self.takeinventory("missileLauncherFire1token", 1);
			}
			MMIS G 2;
			MMIS H 4;
			MMIS I 4;
			MMIS J 3;
			MMIS KL 3;
			MMIS M 6 A_StartSound("weapons/mmsl_in", 1);
			MMIS N 5;
			MMIS OP 3;
			MMIS Q 3;
			MMIS R 2;
			MMIS T 1;
			goto ReadyAlt;			
		SetPrimary:
			TNT1 A 0 {
				invoker.miniMissile_Switch = 0;
				//self.giveinventory("missileLauncherFire1token", 1);
				//self.takeinventory("missileLauncherFire2token", 1);
			}
			MMIS T 2;
			MMIS R 4;
			MMIS Q 4;
			MMIS PO 3;
			MMIS N 5;
			MMIS M 6 A_StartSound("weapons/mmsl_out", 1);
			MMIS LK 3;
			MMIS J 3;
			MMIS I 4;
			MMIS H 4;
			MMIS G 2;
			goto ReadyPrimary;*/
			/*TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("DeselectPrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("DeselectAlt");}
				return ResolveState(null);
			}
		DeselectPrimary:*/
		/*DeselectAlt:
			MMIS T 1 A_Lower();
			Loop;*/	
			/*TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("SelectPrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("SelectAlt");}
				return ResolveState(null);
			}
		SelectPrimary:*/
		/*SelectAlt:
			MMIS T 1 A_Raise();
			Loop;*/
			/*TNT1 A 0 W_CheckAmmo();
			//DUMM A 0 A_JumpIfNoAmmo("Reload");
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("FirePrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("FireAlt");}
				return ResolveState(null);
			}
		
		FirePrimary:*/
		/*FireAlt:
			MMIS T 0 W_CheckAmmo();
			//DUMM A 0 A_JumpIfNoAmmo("Reload");
			MMIS T 4 W_zscFireMiniMissile2("zscMiniMissile_homing");
			MMIS U 4 A_Light1();
			MMIS V 5 Bright;
			MMIS W 2 Bright A_Light2();
			MMIS X 2 Bright;
			MMIS Y 2 Bright A_Light0();
			MMIS Y 0 A_ReFire();
			goto ReadyAlt;*/


		//Weapon.AmmoUse1 1;
		//Weapon.AmmoGive1 0;
		//Weapon.AmmoType1 "magazine_missileLauncher";
		//Weapon.AmmoUse2 0;
		//Weapon.AmmoGive2 8;
		//Weapon.AmmoType2 "MiniMissiles";

//const missileLauncherBaseWeight = 220;

/*class magazine_missileLauncher : Ammo {
	Default {		
		+Inventory.IgnoreSkill;		
		Inventory.MaxAmount 8;
	
	}
}*/

/*class missileLauncherFire1token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class missileLauncherFire2token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}*/

/*class zscMiniMissile_homing : MiniMissile {
	Default {
		+SEEKERMISSILE
		+THRUGHOST
		Damage 15;
	}
	
	States {
		Spawn:
			MICR A 6 Bright {
				A_RocketInFlight();
				A_SeekerMissile(45, 15, SMF_LOOK|SMF_PRECISE|SMF_CURSPEED , 248, 3);
			}
			Loop;
		Death:
			SMIS A 0 A_AlertMonsters();
			SMIS A 0 Bright A_SetTranslucent(1, 1);
			SMIS A 0 Bright; // State left for savegame compatibility
			SMIS A 5 Bright A_Explode(64, 64, 1, 1);
			SMIS B 5 Bright;
			SMIS C 4 Bright;
			SMIS DEFG 2 Bright;
			Stop;
	}
	
}*/

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////