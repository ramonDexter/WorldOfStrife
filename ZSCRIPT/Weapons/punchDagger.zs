class zscPunchDagger : augmentedWeapon replaces PunchDagger {
	int altCounter;
	
	Default {	
		+WEAPON.MELEEWEAPON
		+WEAPON.NOALERT
		+WEAPON.WIMPY_WEAPON
		
		Tag "$T_PUNCHDAGGER";
		inventory.icon "H_PUND";
		weapon.slotNumber 1;
		Weapon.slotPriority 2;
        //Weapon.UpSound "weapons/weaponUP";
		//weapon.selectionorder 2100;
	}
	
	States {
		Nope:
			PUND A 1 A_WeaponReady(WRF_NOFIRE);
			//TNT1 A 0 A_NoReFire();
			TNT1 A 0 A_ClearReFire();
			Goto Ready;
		Ready:
			PUND A 1 {
				A_WeaponReady(WRF_ALLOWUSER1);
				if ( invoker.altCounter > 0 ) {
					invoker.altCounter--;
				}
			}
			Loop;
			
		Deselect:
			PUND A 0 A_Lower();
			PUND A 1 A_Lower();
			Loop;
			
		Select:
			PUND A 1 A_Raise();
			PUND A 0 A_Raise();
			Loop;
			
		Fire:
			PUND ACF 1;
			PUND G 1;
			PUND H 2 { 
				W_stabDagger();
				if ( invoker.altCounter > 0 ) {
					invoker.altCounter--;
				}
			}
			PUND I 2;
			PUND JK 1;
			PUND LMNOP 1;
			PUND A 1 A_ReFire();
			Goto Ready;
			
		AltFire:
			TNT1 A 0 {
				if ( invoker.altCounter > 0 ) {
					return resolveState("Ready");
				}
				return resolveState(null);
			}
			PUND R 2;
			PUND S 1;
			PUND T 1 A_SetPitch(pitch-3);							
			PUND U 1 A_SetPitch(pitch-3);
			PUND V 1 {
				W_stabDaggerAlt();
				invoker.altCounter = 45;
			}
			PUND VV 1;
			PUND UU 1;
			PUND T 2;
			PUND S 3;
			PUND R 4;
			PUND A 1 A_SetPitch(pitch+6);
			goto Ready;
		User1:
			TNT1 A 0 { 
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { wos_stripArmor(); }
			}
			goto Nope;
	}
}
class zscFist : augmentedWeapon {
	Default {
		+WEAPON.MELEEWEAPON
		+WEAPON.NOALERT
		+WEAPON.WIMPY_WEAPON
		+WEAPON.CHEATNOTWEAPON
		
		Tag "Bare Hands";
		inventory.icon "I_XXXX";
		Weapon.SlotNumber 1;
		Weapon.slotPriority 1;
	}
	
	States {
		Ready:
			PEST A 1 {
				A_WeaponReady(WRF_ALLOWUSER1);
			}
			Loop;
		Select:
			PEST A 1 A_Raise();
			Loop;
		Deselect:
			PEST A 1 A_Lower();
			Loop;
		Fire:
			PEST ACF 1;
			PEST GH 1;
			PEST I 2 W_uderPesti("StaffBlasterPuff");//A_CustomPunch(random(1, 6), false, 0, "StaffBlasterPuff");
			PEST I 2;
			PEST HG 1;
			PEST FEDCB 1;
			PEST A 1 A_ReFire();
			Goto Ready;
	}
}