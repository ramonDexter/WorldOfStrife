const missileLauncherBaseWeight = 220;

class missileLauncherMag : Ammo {
	Default {		
		+Inventory.IgnoreSkill;		
		Inventory.MaxAmount 8;
	
	}
}
class missileLauncherFire1token : inventory {
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
}
class zscMiniMissileLauncher : augmentedWeapon replaces MiniMissileLauncher {
	int miniMissile_Switch;

	Default {	
		//$Category "Weapons/WoS"		
		//$Title "zsc Mini Missile Launcher"
		
		+WEAPON.AMMO_OPTIONAL		
		+FLOORCLIP
		+WEAPON.NOAUTOAIM
		
		//scale 0.8;
		radius 12;
		height 12;
		
		Tag "$T_MISSILELAUNCHER";
		Inventory.PickupMessage  "$F_MISSILELAUNCHER";
		Weapon.SelectionOrder 1800;
		Tag "Mini Missile Launcher";
		inventory.icon "H_MMSL";		
		Weapon.SlotNumber 4;
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 0;
		Weapon.AmmoType1 "missileLauncherMag";
		Weapon.AmmoUse2 0;
		Weapon.AmmoGive2 8;
		Weapon.AmmoType2 "MiniMissiles";
		Mass missileLauncherBaseWeight;
        Weapon.UpSound "weapons/weaponUP";
	}

	States {
		Spawn:
			DUMM A -1;
			Stop;
		
		Ready:
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) { return ResolveState("ReadyPrimary");}
				if(invoker.miniMissile_Switch == 1) { return ResolveState("ReadyAlt");}
				return ResolveState(null);
			}		
		ReadyPrimary:			
			MMIS A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			Loop;
		ReadyAlt:
			MMIS T 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			Loop;
			
		//AltFire:
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("SetAlt");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("SetPrimary");}
				return ResolveState(null);
			}
		SetAlt:
			TNT1 A 0 {
				invoker.miniMissile_Switch = 1;
				self.giveinventory("missileLauncherFire2token", 1);
				self.takeinventory("missileLauncherFire1token", 1);
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
				self.giveinventory("missileLauncherFire1token", 1);
				self.takeinventory("missileLauncherFire2token", 1);
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
			goto ReadyPrimary;
			
		Deselect:
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("DeselectPrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("DeselectAlt");}
				return ResolveState(null);
			}
		DeselectPrimary:
			MMIS A 1 A_Lower();			
			Loop;
		DeselectAlt:
			MMIS T 1 A_Lower();
			Loop;		
		
		Select:
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("SelectPrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("SelectAlt");}
				return ResolveState(null);
			}
		SelectPrimary:
			MMIS A 1 A_Raise();
			Loop;
		SelectAlt:
			MMIS T 1 A_Raise();
			Loop;
				
		Fire:
			TNT1 A 0 {
				if(invoker.miniMissile_Switch == 0) {return ResolveState("FirePrimary");}
				if(invoker.miniMissile_Switch == 1) {return ResolveState("FireAlt");}
				return ResolveState(null);
			}
		
		FirePrimary:
			MMIS A 0 A_JumpIfNoAmmo("Reload");
			MMIS A 4 W_zscFireMiniMissile("zscMiniMissile");
			MMIS B 4 A_Light1();
			MMIS C 5 Bright;
			MMIS D 2 Bright A_Light2();
			MMIS E 2 Bright;
			MMIS F 2 Bright A_Light0();
			MMIS F 0 A_ReFire();
			Goto ReadyPrimary;
		FireAlt:
			MMIS T 0 A_JumpIfNoAmmo("Reload");
			MMIS T 4 W_zscFireMiniMissile("zscMiniMissile_homing");
			MMIS U 4 A_Light1();
			MMIS V 5 Bright;
			MMIS W 2 Bright A_Light2();
			MMIS X 2 Bright;
			MMIS Y 2 Bright A_Light0();
			MMIS Y 0 A_ReFire();
			goto ReadyAlt;
		
		Reload:
			TNT1 A 0 W_reloadCheck();
			MMIS A 1 Offset(0,35);
			MMIS A 1 Offset(0,38) A_StartSound("weapons/RLpistolRLout", 1);
			MMIS A 1 Offset(0,44);
			MMIS A 1 Offset(0,52);
			MMIS A 1 Offset(0,62);
			MMIS A 1 Offset(0,72);
			MMIS A 1 Offset(0,82);
			TNT1 A 16 Offset(0,82); //middle
			MMIS A 1 Offset(0,82);
			MMIS A 1 Offset(0,72);
			MMIS A 1 Offset(0,62);
			MMIS A 1 Offset(0,52);
			MMIS A 1 Offset(0,44);
			MMIS A 1 Offset(0,38) A_StartSound("weapons/RLpistolRLin", 1);
			TNT1 A 0 W_reload();
			MMIS A 1 Offset(0,35);
			MMIS A 1 Offset(0,32);
			Goto Ready;
			
		
	}
}

class zscMiniMissile : MiniMissile {
	Default {
		+THRUGHOST
		Damage 20;
	}
}

class zscMiniMissile_homing : MiniMissile {
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
	}
	
}


