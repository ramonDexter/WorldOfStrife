////////////////////////////////////////////////////////////////////////////////
// grenade launcher ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosGrenadeLauncher : wosWeapon replaces StrifeGrenadeLauncher {
	int grnlSwitch;
	
	Default {
		//$Category "Weapons/WoS"
		//$Title "zsc grenade launcher"
		
		+WEAPON.NOAUTOAIM;
		
		Tag "$T_GRENADELAUNCHER";
		Inventory.PickupMessage "$F_GRENADELAUNCHER";
		inventory.icon "H_GRND";
		Weapon.AmmoUse1 0;
		Weapon.AmmoGive1 24;
		Weapon.AmmoType1 "HEGrenadeRounds";
        Weapon.AmmoUse2 0;
        Weapon.AmmoGive2 24;
        Weapon.AmmoType2 "PhosphorusGrenadeRounds";
		Mass grenadeLauncherBaseWeight;
        Weapon.UpSound "weapons/weaponUP";
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
			TNT1 A 0 {
				if(invoker.grnlSwitch == 1) { return ResolveState("grnl2ready"); }
				if(invoker.grnlSwitch == 0) { return ResolveState("grnl1ready"); }
				return ResolveState(null);
			}
			
        grnl1ready:
			GREN A 1 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;
        grnl2ready:
			GREN D 1 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;

        AltFire:
			TNT1 A 0 {
				if(invoker.grnlSwitch == 1) { return ResolveState("setGrnl1"); }
				if(invoker.grnlSwitch == 0) { return ResolveState("setGrnl2"); }
				return ResolveState(null);
			}
        setGrnl1:
            TNT1 A 0 {
                invoker.grnlSwitch = 0;
				//self.giveinventory("grenadeLauncherFire2token", 1);
				//self.takeinventory("grenadeLauncherFire1token", 1);
            }
            GREN A 15;
            goto grnl1ready;
        setGrnl2:
            TNT1 A 0 {
                invoker.grnlSwitch = 1;
				//self.giveinventory("grenadeLauncherFire1token", 1);
				//self.takeinventory("grenadeLauncherFire2token", 1);
            }
            GREN D 15;
            goto grnl2ready;

        Fire:
			TNT1 A 0 {
				if(invoker.grnlSwitch == 1) { return ResolveState("grnl2fire"); }
				if(invoker.grnlSwitch == 0) { return ResolveState("grnl1fire"); }
				return ResolveState(null);
			}
        grnl1fire:
			GREN A 5 {
                W_ShootGrenade("HEGrenade", -40, "grnl1Flash1");
				A_TakeInventory("HEGrenadeRounds", 1);
            }
			GREN B 10;
			GREN A 5 {
                W_ShootGrenade("HEGrenade", 40, "grnl1Flash2");
				A_TakeInventory("HEGrenadeRounds", 1);
            }
			GREN C 10;
			GREN A 0 A_ReFire();
            goto grnl1ready;
        grnl2fire:
			GREN D 5 {
                W_ShootGrenade("PhosphorousGrenade", -40, "grnl2Flash1");
				A_TakeInventory("PhosphorusGrenadeRounds", 1);
            }
			GREN E 10;
			GREN D 5 {
                W_ShootGrenade("PhosphorousGrenade", 40, "grnl2Flash2");
				A_TakeInventory("PhosphorusGrenadeRounds", 1);
            }
			GREN F 10;
			GREN A 0 A_ReFire();
            goto grnl2ready;

        Select:
			TNT1 A 0 {
				if(invoker.grnlSwitch == 1) { return ResolveState("grnl2select"); }
				if(invoker.grnlSwitch == 0) { return ResolveState("grnl1select"); }
				return ResolveState(null);
			}
        grnl1select:
			GREN A 1 A_Raise();
			Loop;
        grnl2select:
			GREN D 1 A_Raise();
			Loop;

        Deselect:
			TNT1 A 0 {
				if(invoker.grnlSwitch == 1) { return ResolveState("grnl2deselect"); }
				if(invoker.grnlSwitch == 0) { return ResolveState("grnl1deselect"); }
				return ResolveState(null);
			}
        grnl1deselect:
			GREN A 1 A_Lower();
			Loop;
        grnl2deselect:
			GREN D 1 A_Lower();
			Loop;

        grnl1flash1:
			GREF A 5 Bright A_Light1();
			Goto LightDone;
        grnl1flash2:
			GREF B 5 Bright A_Light2();
			Goto LightDone;

        grnl2flash1:
			GREF C 5 Bright A_Light1();
			Goto LightDone;
        grnl2flash2:
			GREF D 5 Bright A_Light2();
			Goto LightDone;
		
    }
}

class zscHEGrenade : HEGrenade {
	Default {
		+THRUGHOST
	}
}
class zscPhosphorousGrenade : PhosphorousGrenade {
	Default {
		+THRUGHOST
	}
}

class wosGrenadeLauncher2 : StrifeGrenadeLauncher2 replaces StrifeGrenadeLauncher2 {
	Default {
		+WEAPON.CHEATNOTWEAPON	
		//inventory.icon "I_GRND";
		//weapon.sisterweapon "wosGrenadeLauncher";
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//const grenadeLauncherBaseWeight = 320;

/*class grenadeLauncherFire1token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class grenadeLauncherFire2token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}*/