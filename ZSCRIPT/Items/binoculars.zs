////////////////////////////////////////////////////////////////////////////////
// Dalekohled - Binoculars /////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// inspired by LF sprinting weapon code and use
////////////////////////////////////////////////////////////////////////////////

// item mass ///////////////////////////////////////////////////////////////////
//const wosBinocularWeight = 45;

// inventory item //////////////////////////////////////////////////////////////
class wosBinocular : wosPickup {
    bool binocUsed;
    action void W_EquipBinoc(void) {
        if ( player == null ) {
            return;
        }

        let pawn = binderPlayer(self);
        pawn.selectedWeapon = Weapon(pawn.player.readyWeapon);
        A_GiveInventory("binoc_weapon", 1);
        A_SelectWeapon("binoc_weapon");
        
		A_Overlay(7, "Binoc");
        invoker.binocUsed = true;
    }
    action void W_RemoveBinoc(void) {
        if ( player == null ) {
            return;
        }

        let pawn = binderPlayer(self);
        A_SelectWeapon(pawn.selectedWeapon.GetClassName(), SWF_SELECTPRIORITY);
        A_TakeInventory("binoc_weapon", 1);
        A_ClearOverlays(7, 7);
        //A_SetCrosshair(13);
        invoker.binocUsed = false;
    }
    Default {
		//$Category "Powerups/WoS"
		//$Title "Binocular"		
		+INVENTORY.INVBAR
		Tag "$T_Binocular";
		Inventory.Icon "I_BNCL";
		inventory.PickupMessage "$F_Binocular";
		Mass wosBinocularWeight;
		//Scale 0.4;
    }
    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {				
                if ( !invoker.binocUsed ) {
                    return resolveState("Equip");
                } else {
                    return resolveState("Unequip");
                }
                return resolveState(null);
            }
            Fail;
        Equip:
            TNT1 A 0 W_EquipBinoc();
            Fail;
        Unequip:
            TNT1 A 0 W_RemoveBinoc();
            Fail;
		Binoc:
			RBPY ABCD 4;
			loop;			
    }
}
// aby nebylo mozne utocit pri zvednutem dalekohledu ///////////////////////////
// to disable attack during binoculars use /////////////////////////////////////
class binoc_weapon : weapon {
	Default {
        inventory.icon "H_BNCL";
		weapon.selectionOrder 4000;
        Tag "$T_binoc_weapon";
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
			TNT1 A 0 A_ZoomFactor(6.0);
            TNT1 A 0 A_SetCrosshair(15);
		SelectLoop:
            TNT1 A 0 A_Raise();
            Loop;
        Deselect:
			TNT1 A 0 A_ZoomFactor(1.0);
            TNT1 A 0 A_SetCrosshair(13);
		DeselectLoop:
            TNT1 A 0 A_Lower();
            Loop;
        Fire:
            TNT1 A 0;
            Goto Ready;
	}
}
class dummy_binoc : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "dummy binocular"
		-SOLID
		//+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS
		+USESPECIAL
		+NOGRAVITY
		
		Tag "$T_Binocular";
		height 8;
		radius 8;
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
