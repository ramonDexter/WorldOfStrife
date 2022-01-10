class BHimpossibleKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"		
	}
	
	States {
		Spawn:
			TNT1 A -1;
			Stop;
	}
}
// universal key ///////////////////////////////////////////////////////////////
class skeletonKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		+INVENTORY.INVBAR
		inventory.icon "I_SKLK";
		Tag "Skeleton Key";
	}
	
	States {
		Spawn:
			SKLK A -1;
			Stop;
	}
}

//MAP02 KEYS
//------------------------------------------------------------------------------
class BHWasteCatacombKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.Icon "I_TUNL";
		Tag "Catacombs Key";
		Inventory.PickupMessage "You picked up the Catacomb Key.";
	}
	
	States {
		Spawn:
			TUNL A -1;
			Stop;
	}
}

class BHWasteKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.Icon "I_TUNL";
		Tag "Waste Treatment Key";
		Inventory.PickupMessage "You picked up the Waste Treatment Key.";	
	}
	
	States {
		Spawn:
			TUNL A -1;
			Stop;	
	}
}

class BHminesKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.Icon "I_MINE";
		Tag "Mines key";
		Inventory.PickupMessage "You picked up the Mine Key.";
	}
	
	States {
		Spawn:
			MINE A -1;
			Stop;
	}
}

class BHbathKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"		
		Tag "Bath entrance pass";
		inventory.icon "I_BATH";
	}
	
	States {
		Spawn:
			BATH A -1;
			Stop;
	}
}
//------------------------------------------------------------------------------

//MAP04 keys
//------------------------------------------------------------------------------
class BHpowerPlantKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.Icon "I_PWR1";
		Tag "Powerplant Key";
		Inventory.PickupMessage "You picked up the Powerplant Key.";
	}
	
	States {
		Spawn:
			PWR1 A -1;
			Stop;
	}
}

class BHpowerPlantKey2 : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.icon "I_PWR2";
		Tag "Powerplant Security card";
		Inventory.PickupMessage "You picked up the Powerplant Security card.";
	}
	
	States {
		Spawn:
			PWR2 A -1;
			Stop;
	}
}

class BHpowerPlantReactorKey : StrifeKey {
	Default {
		//$category "Keys/WoS"
		
		Inventory.icon "I_ORAC";
		Tag "Powerplant Reactor key";
		Inventory.PickupMessage "You picked up the Powerplant Reactor key.";
	}
	
	States {
		Spawn:
			ORAC A -1;
			Stop;
	}
}
//------------------------------------------------------------------------------

// MAP06 Keys //////////////////////////////////////////////////////////////////
//------------------------------------------------------------------------------
class BHfactoryKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		
		Inventory.icon "I_FCTR";
		Tag "Factory ID card";
		Inventory.PickupMessage "You picked up the Factory ID card.";
	}
	
	States {
		Spawn:
			FCTR A -1;
			Stop;
	}
}
//------------------------------------------------------------------------------

class SHtgPowerplantKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.icon "I_TGPP";
		Tag "TekGuild Powerplant ID card";
		Inventory.PickupMessage "You picked up the TekGuild Powerplant ID card.";
	}
	States {
		Spawn:
			TGPP A -1;
			Stop;
	}
}

// MAP08 keys //////////////////////////////////////////////////////////////////

// MAP10 keys //////////////////////////////////////////////////////////////////
/*class m10k_acolyteBase_firstKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.icon "I_AB1K";
		Tag "Order Base Barracks Key";
		Inventory.PickupMessage "You picked up the Order Base Barracks Key.";	
	}
	States {
		Spawn:
			AB1K V -1;
			Stop;
	}	
}
class m10k_acolyteBase_secondKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.icon "I_AB2K";
		Tag "Order Base Command Key";
		Inventory.PickupMessage "You picked up the Order Base Command Key.";
	}
	States {
		Spawn:
			AB2K V -1;
			Stop;
	}
}*/
// map08 keys //////////////////////////////////////////////////////////////////
class m08k_BP_pokladnice : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.Icon "I_AB1K";
		Tag "Baron's Treasury Key";
		Inventory.PickupMessage "You picked up the Baron's Treasury Key!";
	}
	States {
		Spawn:
			AB1K V -1;
			Stop;
	}
}

