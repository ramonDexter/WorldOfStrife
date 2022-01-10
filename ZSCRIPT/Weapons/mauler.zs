const maulerBaseWeight = 300;

class zscMaulerFire1token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class zscMaulerFire2token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class zscMauler : augmentedWeapon replaces Mauler {

	int maulerSwitch;
	
	Default {
		//$Category "Weapons/WoS"
		//$Title "zsc Mauler"
		
		+WEAPON.NOAUTOAIM
		
		Tag "$T_MAULER";
		Inventory.PickupMessage "$F_MAULER";
		inventory.icon "H_MAUL";
		//Weapon.SisterWeapon "zscMauler2";
		Weapon.AmmoUse1 0;
        Weapon.AmmoGive1 100;
        Weapon.AmmoType1 "energyPod";
        Weapon.AmmoUse2 0;
        Weapon.AmmoGive2 0;
        Weapon.AmmoType2 "energyPod";
        Weapon.UpSound "weapons/weaponUP";
				
		//scale 0.8;
		radius 12;
		height 12;
		Mass maulerBaseWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
			
		Ready:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return resolveState("mauler2ready"); }
				if(invoker.maulerSwitch == 0) { return resolveState("mauler1ready"); }				
				return resolveState(null);
			}

		mauler1ready:
			MAUL F 3 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL G 3 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL H 3 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL A 3 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;
		mauler2ready:
			MAUL I 4 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL J 4 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL K 4 A_WeaponReady(WRF_ALLOWUSER1);
			MAUL L 4 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;

		AltFire:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("setMauler1"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("setMauler2"); }				
				return ResolveState(null);
			}			
		setMauler1:
			TNT1 A 0 {
				invoker.maulerSwitch = 0;
				self.giveinventory("zscMaulerFire1token", 1);
				self.takeinventory("zscMaulerFire2token", 1);
			}
			MAUL FG 6;
			MAUL HA 6;
			goto mauler1ready;
		setMauler2:
			TNT1 A 0 {
				invoker.maulerSwitch = 1;
				self.giveinventory("zscMaulerFire2token", 1);
				self.takeinventory("zscMaulerFire1token", 1);
			}
			MAUL IJKL 7;
			goto mauler2ready;
		
		Fire:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("mauler2fire"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("mauler1fire"); }
				return ResolveState(null);
			}			
			
		mauler1fire:
			BLSF A 5 Bright {
				W_FireZSCMauler1();
				A_TakeInventory("energyPod", 15);
			}
			MAUL B 3 Bright A_Light1();
			MAUL C 2 A_Light2();
			MAUL DE 2;
			MAUL A 7 A_Light0();
			MAUL H 7;
			MAUL G 7 A_CheckReload();
			goto mauler1ready;
		
		mauler2fire:
			MAUL I 20 W_FireZSCMauler2Pre();
			MAUL J 10 A_Light1;
			BLSF A 10 Bright {
				W_FireZSCMauler2();
				A_TakeInventory("energyPod", 30);			
			}
			MAUL B 10 Bright A_Light2();
			MAUL C 2;
			MAUL D 2 A_Light0();
			MAUL E 2 A_ReFire();
			goto mauler2ready;

		Select:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("mauler2select"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("mauler1select"); }
				return ResolveState(null);
			}			
		
		mauler1select:
			MAUL A 1 A_Raise();
			Loop;
		mauler2select:
			MAUL I 1 A_Raise();
			Loop;
		
		Deselect:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("mauler2deselect"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("mauler1deselect"); }
				return ResolveState(null);
			}
			
		mauler1deselect:
			MAUL A 1 A_Lower();
			Loop;		
		mauler2deselect:
			MAUL I 1 A_Lower();
			Loop;
		
		Flash:
			Stop;
			
		/*User1:
			TNT1 A 0
			{
				if(invoker.maulerSwitch == 1) {return resolveState("mauler2user1");}
				if(invoker.maulerSwitch == 0) {return resolveState("mauler1user1");}
				return resolveState(null);
			}
		mauler1user1:
			TNT1 A 0 
			{
				A_GiveInventory("zscMauler_knife", 1);
				A_selectWeapon("zscMauler_knife");
			}
			Goto Ready;	
		mauler2user1:
			TNT1 A 0 
			{
				A_GiveInventory("zscMauler_knife", 1);
				A_selectWeapon("zscMauler_knife");
			}
			Goto Ready;	*/
	}	
}

class zscMauler2 : Mauler2 replaces Mauler2 {
	Default {
		+WEAPON.CHEATNOTWEAPON
		
		//inventory.icon "I_MAUL";
		//Weapon.SisterWeapon "zscMauler";
	}	
}


class mauler_dummy : actor {
	Default {
		//$Category "Weapons/dummy"
		//$Title "dummy mauler"
		
		+SOLID
		+USESPECIAL
		+NOGRAVITY
		
		radius 12;
		height 20;
		scale 0.8;
	
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}

class zscMaulerTorpedo : MaulerTorpedo {
	Default {
		+THRUGHOST		
	}
}