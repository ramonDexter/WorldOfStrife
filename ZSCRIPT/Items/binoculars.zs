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
        textureID txtID_I_BNCA = TexMan.CheckForTexture("I_BNCA", 0, 0);
        pawn.selectedWeapon = Weapon(pawn.player.readyWeapon);
        A_GiveInventory("binoc_weapon", 1);
        A_SelectWeapon("binoc_weapon");        
		A_Overlay(7, "Binoc");
        invoker.binocUsed = true;
        invoker.icon = txtID_I_BNCA;
    }
    action void W_RemoveBinoc(void) {
        if ( player == null ) {
            return;
        }
        let pawn = binderPlayer(self);
        textureID txtID_I_BNCL = TexMan.CheckForTexture("I_BNCL", 0, 0);
        A_SelectWeapon(pawn.selectedWeapon.GetClassName(), SWF_SELECTPRIORITY);
        A_TakeInventory("binoc_weapon", 1);
        A_ClearOverlays(7, 7);
        //A_SetCrosshair(13);
        invoker.binocUsed = false;
        invoker.icon = txtID_I_BNCL;
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
	bool Zoomswitch;
	override void AttachToOwner (Actor other) {
		super.AttachToOwner(other);
		Zoomswitch = false;
	}
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
            TNT1 A 1 A_WeaponReady(WRF_NOSWITCH|WRF_ALLOWUSER1);
            Loop;
        Select:
			TNT1 A 0 A_ZoomFactor(4.0);
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
		User1:
			TNT1 A 0 {
				if( !invoker.Zoomswitch ) {
					return resolveState("ZoomYes");					
				} else if ( invoker.Zoomswitch ) {
					return resolveState("ZoomNot");					
				}
				return resolveState(null);
			}
		ZoomYes:
			TNT1 A 1 A_ZoomFactor(5.0);
			TNT1 A 1 A_ZoomFactor(5.5);
			TNT1 A 1 A_ZoomFactor(6.0);
			TNT1 A 1 A_ZoomFactor(6.5);
			TNT1 A 1 A_ZoomFactor(7.0);
			TNT1 A 1 A_ZoomFactor(7.5);
			TNT1 A 0 {
				A_ZoomFactor(8.0);
				invoker.Zoomswitch = true;
			}
			TNT1 A 35;
			goto ready;
		ZoomNot:			
			TNT1 A 1 A_ZoomFactor(7.5);			
			TNT1 A 1 A_ZoomFactor(7.0);
			TNT1 A 1 A_ZoomFactor(6.5);
			TNT1 A 1 A_ZoomFactor(6.0);
			TNT1 A 1 A_ZoomFactor(5.5);
			TNT1 A 1 A_ZoomFactor(5.0);
			TNT1 A 0 {
				A_ZoomFactor(4.0);
				invoker.Zoomswitch = false;
			}
			TNT1 A 35;
			goto ready;
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
