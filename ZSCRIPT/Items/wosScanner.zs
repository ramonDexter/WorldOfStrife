////////////////////////////////////////////////////////////////////////////////
// wos scanner thing ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
const wosscannerWeight = 32;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
class wosI_scanner : wosPickup {
    bool scannerUsed;    

    action void W_EquipScanner (void) {
        if ( player == null ) {
            return;
        }

        let pawn = binderPlayer(self);
        pawn.selectedWeapon = Weapon(pawn.player.readyWeapon);
        A_GiveInventory("wosscannerweapon", 1);
        A_SelectWeapon("wosscannerweapon");
		A_Overlay(7, "Scanner");
        invoker.scannerUsed = true;
    }
    action void W_RemoveScanner (void) {
        if ( player == null ) {
            return;
        }

        let pawn = binderPlayer(self);
        A_SelectWeapon(pawn.selectedWeapon.GetClassName(), SWF_SELECTPRIORITY);
        A_TakeInventory("wosscannerweapon", 1);
        A_ClearOverlays(7, 7);
        invoker.scannerUsed = false;
    }

    Default {
        //$Category "Powerups/WoS"
		//$Title "Binoculars"		
		+INVENTORY.INVBAR
		Tag "$T_wosscanner";
		Inventory.Icon "I_SCHD";
		inventory.PickupMessage "$F_wosscanner";
		Mass wosscannerWeight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {				
                if ( !invoker.scannerUsed ) {
                    return resolveState("Equip");
                } else {
                    return resolveState("Unequip");
                }
                return resolveState(null);
            }
            Fail;
        Equip:
            TNT1 A 0 W_EquipScanner();
            Fail;
        Unequip:
            TNT1 A 0 W_RemoveScanner();
            Fail;
		Scanner:
			SCHD ABCDEFGHIJ 4;
			loop;
    }
}
////////////////////////////////////////////////////////////////////////////////
class wosscannerweapon : weapon {

    action void W_startScanner (void) {
        if ( player == null ) {
            return;
        }

        MWR_LookCursorHandler.SendNetworkEvent("mwr_lookcursor_on");
    }
    action void W_stopScanner (void) {
        if ( player == null ) {
            return;
        }

        MWR_LookCursorHandler.SendNetworkEvent("mwr_lookcursor_off");
    }

	Default {
        inventory.icon "H_SCHD";
		weapon.selectionOrder 4000;
        Tag "$T_wosscannerweapon";
		Mass 0;
	}
	States {
		Nope:
            TNT1 A 1 A_WeaponReady();
            Loop;
        Ready:
            TNT1 A 1 A_WeaponReady(WRF_NOSWITCH);
            Loop;
        Select:
			TNT1 A 0;
		SelectLoop:
            TNT1 A 0 A_Raise();
            Loop;
        Deselect:
			TNT1 A 0;
		DeselectLoop:
            TNT1 A 0 A_Lower();
            Loop;
        Fire: //actually scanner action, when held, repeated action
            TNT1 A 0;
            TNT1 A 1 W_startScanner();
            TNT1 A 1;
            TNT1 A 1 W_stopScanner();
            TNT1 A 0 A_Refire("Fire");
            TNT1 AAAAA 0;            
            Goto Ready;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////