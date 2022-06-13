////////////////////////////////////////////////////////////////////////////////
//  Flares  ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  item weights  //////////////////////////////////////////////////////////////
//const FlareWeight = 5;
//const FlareBoxWeight = 50;
////////////////////////////////////////////////////////////////////////////////

class Flare : wosPickup {
	Default {
		//$Category "Powerups/WoS"		
		//$Title "Flare"
		
		+countitem
		+inventory.INVBAR
		+inventory.alwayspickup
		
		Tag "$T_FLARES";
		Inventory.Icon "I_FLAR";
		Inventory.PickupMessage "$F_FLARES";
		Mass FlareWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 1 A_SpawnItemEx ("ActiveFlare", 56, 0, 28, 0, 0, 0, 0, 1);
			Stop;
	}
}
class ActiveFlare : actor {
	Default {
		Radius 22;
		Height 11;
	}
	
	States {
		Spawn:
			FLAR A 0 Bright;
			FLAR A 0 Bright A_StartSound("Flare/Light", 0);
			FLAR A 0 Bright A_StartSound("Flare/Loop", 7, 1, -1);
			FLAR AB 1 Bright;
			Goto Spawn+3;
	}
}
class FlareBox : wosPickup {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Flare Box"
	
		Tag "$T_FlareBox";
		Inventory.PickupMessage "$F_FlareBox";
		Mass FlareBoxWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Pickup:
			TNT1 A 1 A_GiveInventory ("Flare", 10);
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
