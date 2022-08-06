////////////////////////////////////////////////////////////////////////////////
// mauler //////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// weapon //////////////////////////////////////////////////////////////////////
class wosMauler : wosWeapon replaces Mauler {
	int maulerSwitch;
	
	Default {
		//$Category "Weapons/WoS"
		//$Title "zsc Mauler"
		
		+WEAPON.NOAUTOAIM;
		
		Tag "$T_MAULER";
		Inventory.PickupMessage "$F_MAULER";
		inventory.icon "H_MAUL";
        Weapon.UpSound "weapons/weaponUP";
		Weapon.SlotNumber 7;
		Weapon.SelectionOrder 2400;
		Mass maulerBaseWeight;
		wosWeapon.Magazine 200;
		wosWeapon.magazineMax 200;
		wosWeapon.magazineType "EnergyPod";
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
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return resolveState("mauler2ready"); }
				if(invoker.maulerSwitch == 0) { return resolveState("mauler1ready"); }				
				return resolveState(null);
			}
		mauler1ready:
			MAUL F 3 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL G 3 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL H 3 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL A 3 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			Loop;
		mauler2ready:
			MAUL I 4 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL J 4 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL K 4 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			MAUL L 4 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			Loop;
		AltFire:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("setMauler1"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("setMauler2"); }				
				return ResolveState(null);
			}			
		setMauler1:
			TNT1 A 0 { invoker.maulerSwitch = 0; }
			MAUL FG 6;
			MAUL HA 6;
			goto mauler1ready;
		setMauler2:
			TNT1 A 0 { invoker.maulerSwitch = 1; }
			MAUL IJKL 7;
			goto mauler2ready;		
		Fire:
			TNT1 A 0 {
				if(invoker.maulerSwitch == 1) { return ResolveState("mauler2fire"); }
				if(invoker.maulerSwitch == 0) { return ResolveState("mauler1fire"); }
				return ResolveState(null);
			}			
		mauler1fire:
			BLSF A 5 Bright W_FireMauler1();
			MAUL B 3 Bright A_Light1();
			MAUL C 2 A_Light2();
			MAUL DE 2;
			MAUL A 7 A_Light0();
			MAUL H 7;
			MAUL G 7 A_CheckReload();
			goto mauler1ready;		
		mauler2fire:
			MAUL I 20 W_FireMauler2Pre();
			MAUL J 10 A_Light1;
			BLSF A 10 Bright W_FireMauler2();
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
		Reload:
			TNT1 A 0 W_reloadCheck2();
			goto Ready;
		DoReload:
			MAUL F 1 Offset(0,35);
			MAUL F 1 Offset(0,38) A_StartSound("weapons/RLpistolRLout", 1);
			MAUL F 1 Offset(0,44);
			MAUL F 1 Offset(0,52);
			MAUL F 1 Offset(0,62);
			MAUL F 1 Offset(0,72);
			MAUL F 1 Offset(0,82);
			MAUL F 16 W_Reload2(); //middle
			MAUL F 1 Offset(0,82);
			MAUL F 1 Offset(0,72);
			MAUL F 1 Offset(0,62);
			MAUL F 1 Offset(0,52);
			MAUL F 1 Offset(0,44);
			MAUL F 1 Offset(0,38) A_StartSound("weapons/RLpistolRLin", 1);
			MAUL F 1 Offset(0,35);
			MAUL F 1 Offset(0,32);
			Goto Ready;
	}	
}
class wosMauler2 : Mauler2 replaces Mauler2 {
	Default { +WEAPON.CHEATNOTWEAPON; }	
}
////////////////////////////////////////////////////////////////////////////////

// projectile //////////////////////////////////////////////////////////////////
class wosMaulerTorpedo : MaulerTorpedo {
	Default {
		+THRUGHOST		
	}
}
////////////////////////////////////////////////////////////////////////////////

// dummy ///////////////////////////////////////////////////////////////////////
class mauler_dummy : actor {
	Default {
		//$Category "Weapons/dummy"
		//$Title "dummy mauler"
		
		+SOLID
		+USESPECIAL
		+NOGRAVITY
		Tag "$T_MAULER";
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
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

		//Weapon.AmmoUse1 0;
        //Weapon.AmmoGive1 100;
        //Weapon.AmmoType1 "energyPod";
        //Weapon.AmmoUse2 0;
        //Weapon.AmmoGive2 0;
        //Weapon.AmmoType2 "energyPod";


/*class wosMaulerFire1token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}
class wosMaulerFire2token : inventory {
	Default {
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
}*/

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////