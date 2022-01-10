const automapWeight = 3;

class wosPortableMap : wosPickup {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Portable Map"
		
		+INVENTORY.INVBAR
		
		Tag "$T_AUTOMAP";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$F_AUTOMAP";
		Inventory.Icon "I_MAPA";		
		radius 10;
		height 10;		
		Mass automapWeight;
		
		//Inventory.Amount 1;
		//Inventory.MaxAmount 5;
		//Inventory.InterhubAmount 5;
	}
	
	States {
		Spawn:
			DUMM ABCD 6 Bright;
			Loop;
		Use:
			TNT1 A 0 A_GiveInventory("StrifeMap", 1);
			Stop;
	}
}
