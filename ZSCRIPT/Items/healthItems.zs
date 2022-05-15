////////////////////////////////////////////////////////////////////////////////
//  wos Health items  //////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// _apply efekt ////////////////////////////////////////////////////////////////
/*
credits: jarewill za pomoc s 
	let playe = binderPlayer(self);
	playe.selectedWeapon = Weapon(playe.player.readyWeapon);
	
	a
	
	action void W_SelectPrevWeapon() {
		let playe = binderPlayer(self);
		A_SelectWeapon(playe.selectedWeapon.GetClassName(), SWF_SELECTPRIORITY);
		A_takeInventory("Hyposprej_apply", 1);
    }
*/
////////////////////////////////////////////////////////////////////////////////

//  item weights  //////////////////////////////////////////////////////////////
const hyposprejWeight = 2;
const kombopackWeight = 4;
const instalekWeight = 6;
const medpatchWeight = 5;
const medicalkitWeight = 7;
const surgerykitWeight = 12;
const wosStimDeviceWeight = 2;
////////////////////////////////////////////////////////////////////////////////

//  apply effect base  /////////////////////////////////////////////////////////
class medicalApply : weapon {
	action void W_SelectPrevWeapon_RemoveApply(string applyToRemove) {
		if (player == null) {
			return;
		}		
		let pawn = binderPlayer(self);
		A_SelectWeapon(pawn.selectedWeapon.GetClassName(), SWF_SELECTPRIORITY);
		A_takeInventory(applyToRemove, 1);
    }
	
	action void W_applyMed(string medToapply) {
		if (player == null) {
			return;
		}		
		A_GiveInventory(medToapply, 1); //do stuff
		let pawn = binderPlayer(self);
		pawn.bleedlevel=0;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// surgical unit healing ///////////////////////////////////////////////////////
class surgUnitHealth : Health {
	Default {
		Inventory.Amount -100;
	}
}
class surgUnitHealing : CustomInventory {
	Default {
		-INVENTORY.INVBAR
		Inventory.PickupSound "sounds/med";
		inventory.amount 1;
		Mass 0;
	}
	States {
		Spawn:
			TNT1 A -1;
			Stop;
		Pickup:
			TNT1 A 0 {
				let pawn = binderPlayer(self);
				pawn.bleedlevel = 0;
				A_GiveInventory("surgUnitHealth", 1);
			}
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Hyposprej  /////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  HealthPickup  //////////////////////////////////////////////////////////////
/*class Hyposprej : HealthPickup
{
	Default
	{
		//$Category "SoA/Items"
		//$Color 9
		//$Title "Hyposprej"
		-SOLID
		+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS
		+INVENTORY.INVBAR
		
		Tag "$T_HYPOSPREJ";
		height 18;
		radius 4;
		scale 0.65;
		
		Health 25;
		HealthPickup.AutoUse 3;
		
		Inventory.MaxAmount 20;
		Inventory.InterHubAmount 20;
		Inventory.PickupMessage "$F_HYPOSPREJ";
		Inventory.Icon "I_MED1";
		Inventory.useSound "sounds/med";
	}
	
	States
	{
		Spawn:
			DUMM A -1;
			Stop;
	}
}*/
//  customInvItem  /////////////////////////////////////////////////////////////
class hyposprej_heal : Health {
	Default {
		inventory.amount 25;
	}
}
class wosHyposprej : wosPickup {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "Hyposprej"
		
		+INVENTORY.INVBAR
		
		Tag "$T_HYPOSPREJ";		
		Inventory.PickupMessage "$F_HYPOSPREJ";
		Inventory.Icon "I_MED1";
		Inventory.useSound "sounds/armorLight";
		Mass hyposprejWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				let playe = binderPlayer(self);
				playe.selectedWeapon = Weapon(playe.player.readyWeapon);
				A_GiveInventory("Hyposprej_apply", 1);
				A_SelectWeapon("Hyposprej_apply");
			}
			Stop;
	}
}
class Hyposprej_apply : medicalApply {
	Default {
        +Inventory.Undroppable
    }

	States {
		Select:
			AMHS L 1 A_Raise(10);
			Loop;
		Ready:
			AMHS L 1 A_WeaponReady();
		Fire:
		ApplyMed:
            AMHS A 2;
			AMHS B 3;
			AMHS C 4;
			AMHS DE 6;
			AMHS F 4;
			AMHS G 3;
			AMHS H 2;
			AMHS I 2 A_startSound("sounds/med");
            AMHS J 1 W_applyMed("hyposprej_heal");
		Deselect:
			AMHS K 2 A_Lower(9);
			AMHS K 0 W_SelectPrevWeapon_RemoveApply("Hyposprej_apply");
			Stop;
	}	
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  Kombopack  /////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  HealthPickup  //////////////////////////////////////////////////////////////
/*class Kombopack : HealthPickup
{
	Default
	{
		//$Category "Health and Armor/WoS"
		//$Title "Kombopak"
		-SOLID
		+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS
		+INVENTORY.INVBAR
		
		Tag "$T_KOMBOPACK";
		height 12;
		radius 12;
		//scale 0.45;
		
		Health 50;
		HealthPickup.AutoUse 3;	
		
		Inventory.MaxAmount 15;
		Inventory.InterHubAmount 15;
		Inventory.PickupMessage "$F_KOMBOPACK";
		Inventory.Icon "I_MED2";
		Inventory.useSound "sounds/med";
	}
	
	States
	{
		Spawn:
			DUMM A -1;
			Stop;
	}
}*/
//  customInvItem  /////////////////////////////////////////////////////////////
class Kombopack_heal : Health {
	Default {
		inventory.amount 50;
	}
}
class wosKombopack : wosPickup {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "Kombopak"
		
		+INVENTORY.INVBAR
		
		Tag "$T_KOMBOPACK";
		Inventory.PickupMessage "$F_KOMBOPACK";
		Inventory.Icon "I_MED2";
		Inventory.useSound "sounds/armorLight";	
		Mass kombopackWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				let playe = binderPlayer(self);
				playe.selectedWeapon = Weapon(playe.player.readyWeapon);
				A_GiveInventory("Kombopack_apply", 1);
				A_SelectWeapon("Kombopack_apply");
			}
			Stop;
	}
}
class Kombopack_apply : medicalApply {
	Default {
        +Inventory.Undroppable
    }

	States {
		Select:
			AMHS L 1 A_Raise(10);
			Loop;
		Ready:
			AMHS L 1 A_WeaponReady();
		Fire:
		ApplyMed:
            AMHS A 2;
			AMHS B 3;
			AMHS C 4;
			AMHS DE 6;
			AMHS F 4;
			AMHS G 3;
			AMHS H 2;
			AMHS I 2 A_StartSound("sounds/med");
            AMHS J 1 W_applyMed("Kombopack_heal");
		Deselect:
			AMHS K 2 A_Lower(9);
			AMHS K 0 W_SelectPrevWeapon_RemoveApply("Kombopack_apply");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  InstaLek  //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  HealthPickup  //////////////////////////////////////////////////////////////
/*class InstaLek : HealthPickup
{
	Default
	{
		//$Category "Health and Armor/WoS"		
		//$Title "InstaLek"
		-SOLID
		+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS
		+INVENTORY.INVBAR
		
		Tag "$T_INSTALEK";
		height 12;
		radius 12;
		//scale 0.65;
		
		Health -100;
		Inventory.MaxAmount 10;
		
		Inventory.InterHubAmount 10;
		Inventory.PickupMessage "$F_INSTALEK";
		Inventory.Icon "I_MED3";
		Inventory.useSound "sounds/med";
	}
	
	States
	{
		Spawn:
			DUMM A -1;
			Stop;
	}
}*/
//  customInvItem  /////////////////////////////////////////////////////////////
class InstaLek_heal : Health {
	Default {
		//Health -100;
		Inventory.Amount -100;
	}
}
class wosInstaLek : wosPickup {
	Default {
		//$Category "Health and Armor/WoS"		
		//$Title "InstaLek"
		
		+INVENTORY.INVBAR
		
		Tag "$T_INSTALEK";
		Inventory.PickupMessage "$F_INSTALEK";
		Inventory.Icon "I_MED3";
		Inventory.useSound "sounds/armorLight";	
		Mass instalekWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				let playe = binderPlayer(self);
				playe.selectedWeapon = Weapon(playe.player.readyWeapon);
				A_GiveInventory("InstaLek_apply", 1);
				A_SelectWeapon("InstaLek_apply");
			}
			Stop;
	}
}
class InstaLek_apply : medicalApply {
	Default {
        +Inventory.Undroppable
    }

	States {
		Select:
			AMHS L 1 A_Raise(10);
			Loop;
		Ready:
			AMHS L 1 A_WeaponReady();
		Fire:
		ApplyMed:
            AMHS A 2;
			AMHS B 3;
			AMHS C 4;
			AMHS DE 6;
			AMHS F 4;
			AMHS G 3;
			AMHS H 2;
			AMHS I 2 A_StartSound("sounds/med");
            AMHS J 1 W_applyMed("InstaLek_heal");
		Deselect:
			AMHS K 2 A_Lower(9);
			AMHS K 0 W_SelectPrevWeapon_RemoveApply("InstaLek_apply");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  strife medical items with new use sound  ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  MedPatch  //////////////////////////////////////////////////////////////////
class zscMedPatch_heal : Health {
	Default {
		inventory.Amount 10;
	}
}
class zscMedPatch : wosPickup replaces MedPatch {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "zsc MedPatch"

		+INVENTORY.INVBAR
		
		Tag "$T_MEDPATCH";
		Inventory.Icon "I_STMP";
		Inventory.PickupMessage "$F_MEDPATCH";
		Mass medpatchWeight;
	}

	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				//A_GiveInventory("zscMedPatch_heal", 1);
				let pawn = binderPlayer(self);
				pawn.bleedlevel = 0;
				pawn.A_StartSound("sounds/armorLight",CHAN_ITEM);
			}
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  MedicalKit  ////////////////////////////////////////////////////////////////
class zscMedicalKit_heal : Health {
	Default {
		inventory.Amount 25;
	}
}
class zscMedicalKit : wosPickup replaces MedicalKit {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "zsc MedicalKit"
		+INVENTORY.INVBAR
		
		Tag "$T_MEDICALKIT";
		Inventory.Icon "I_MDKT";
		Inventory.PickupMessage "$F_MEDICALKIT";
		Mass medicalkitWeight;
	}

	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				A_GiveInventory("zscMedicalKit_heal", 1);
				let pawn = binderPlayer(self);
				pawn.bleedlevel=0;
				pawn.A_StartSound("sounds/med",CHAN_ITEM);
			}
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  SurgeryKit  ////////////////////////////////////////////////////////////////
class zscSurgeryKit_heal : Health {
	Default {
		inventory.Amount -100;
	}
}
class zscSurgeryKit : wosPickup replaces SurgeryKit {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "zsc SurgeryKit"
		+INVENTORY.INVBAR

		Tag "$T_SURGERYKIT";
		Inventory.Icon "I_FULL";
		Inventory.PickupMessage "$F_SURGERYKIT";
		Mass surgerykitWeight;
	}

	States {
		Spawn:
			DUMM AB 35;
			Loop;
		Use:
			TNT1 A 0 {				
				let pawn = binderPlayer(self);
				if (pawn.Health > 100) {
					return resolveState("UseNot");
				} else {
					return resolveState("UseYes");
				}
			}
			Stop;
		UseYes:
			TNT1 A 0 {
				A_GiveInventory("zscSurgeryKit_heal", 1);
				let pawn = binderPlayer(self);
				pawn.bleedlevel=0;
				pawn.A_StartSound("sounds/med",CHAN_ITEM);
			}
			Stop;
		UseNot:
			TNT1 A 0 {
				A_Print("Cannot use SurgeryKit while completely healthy!");
			}
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////

// stimDevice //////////////////////////////////////////////////////////////////
class wosi_StimDevice : wosPickup {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "stamina stim"

		+INVENTORY.INVBAR;
		Tag "$T_wosStimDevice";
		Inventory.Icon "I_STIM";
		Inventory.PickupMessage "$F_wosStimDevice";
		Mass wosStimDeviceWeight;
	}
	States {
		// spawn based on first argument //////////////////////
		Spawn:
			TNT1 A 0 A_JumpIf(args[0] == 1, "Spawn1");
			TNT1 A 0 A_JumpIf(args[0] == 2, "Spawn2");
			TNT1 A 0 A_JumpIf(args[0] == 3, "Spawn3");
		Spawn1:
			DUMM A -1;
			Stop;
		Spawn2:
			DUMM B -1;
			Stop;
		Spawn3:
			DUMM C -1;
			Stop;
		///////////////////////////////////////////////////////
		Use:
			TNT1 A 0 {
				let pawn = binderPlayer(self);				
				if ( pawn.stamin == pawn.maxstamin ) {
					return resolveState("UseNot");
				} else if ( pawn.stamin < pawn.maxstamin ) {
					return resolveState("UseYes");
				}
				return resolveState(null);
			}
			Fail;
		UseYes:
			TNT1 A 0 {
				let pawn = binderPlayer(self);	
				//int giveStamin = pawn.maxstamin - pawn.stamin;			
				pawn.stamin = pawn.maxstamin;
				pawn.A_StartSound("sounds/med",CHAN_ITEM);
			}
			Stop;
		UseNot:
			TNT1 A 0 A_Log("\c[yellow][ No need to use stimDevice! ]");
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


