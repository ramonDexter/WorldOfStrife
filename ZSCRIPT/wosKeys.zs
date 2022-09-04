////////////////////////////////////////////////////////////////////////////////
// World of Strife keys definition /////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// base parent class ///////////////////////////////////////////////////////////
class wosKey : StrifeKey {
	Default {
		//$Category "Keys/WoS"
		Mass 0;
		-INVENTORY.INVBAR;
	}
}
////////////////////////////////////////////////////////////////////////////////

// to show 'impossible!' message ///////////////////////////////////////////////
class BHimpossibleKey : StrifeKey {
	Default {}	
	States {
		Spawn:
			TNT1 A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// universal key ///////////////////////////////////////////////////////////////
class skeletonKey : wosKey {
	Default {
		//+INVENTORY.INVBAR
		inventory.icon "K_SKLK";//I_SKLK
		Tag "Skeleton Key";
	}
	
	States {
		Spawn:
			SKLK A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//MAP02 KEYS
//------------------------------------------------------------------------------
class BHWasteCatacombKey : wosKey {
	Default {
		Inventory.Icon "K_TUNL";//I_TUNL
		Tag "Catacombs Key";
		Inventory.PickupMessage "You picked up the Catacomb Key.";
	}
	
	States {
		Spawn:
			TUNL A -1;
			Stop;
	}
}

class BHWasteKey : wosKey {
	Default {
		Inventory.Icon "K_TUNL";//I_TUNL
		Tag "Waste Treatment Key";
		Inventory.PickupMessage "You picked up the Waste Treatment Key.";	
	}
	
	States {
		Spawn:
			TUNL A -1;
			Stop;	
	}
}

class BHminesKey : wosKey {
	Default {
		Inventory.Icon "K_MINE";//I_MINE
		Tag "Mines key";
		Inventory.PickupMessage "You picked up the Mine Key.";
	}
	
	States {
		Spawn:
			MINE A -1;
			Stop;
	}
}

class BHbathKey : wosKey {
	Default {		
		Tag "Silent Hills\nBath entrance pass";
		inventory.icon "K_BATH";//I_BATH
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
class BHpowerPlantKey : wosKey {
	Default {
		Inventory.Icon "K_PWR1";//I_PWR1
		Tag "PWPLNT Key";
		Inventory.PickupMessage "You picked up the Powerplant Key.";
	}
	
	States {
		Spawn:
			PWR1 A -1;
			Stop;
	}
}

class BHpowerPlantKey2 : wosKey {
	Default {
		Inventory.icon "K_PWR2";//I_PWR2
		Tag "PWPLNT Security card";
		Inventory.PickupMessage "You picked up the Powerplant Security card.";
	}
	
	States {
		Spawn:
			PWR2 A -1;
			Stop;
	}
}

class BHpowerPlantReactorKey : wosKey {
	Default {
		Inventory.icon "K_ORAC";//I_ORAC
		Tag "PWPLNT Reactor key";
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
class BHfactoryKey : wosKey {
	Default {
		Inventory.icon "K_FCTR";//I_FCTR
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

class SHtgPowerplantKey : wosKey {
	Default {
		Inventory.icon "K_TGPP";//I_TGPP
		Tag "TekGuild Powerplant\nID card";
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
class m08k_BP_pokladnice : wosKey {
	Default {
		Inventory.Icon "K_AB1K";//I_AB1K
		Tag "Baron's\nTreasury Key";
		Inventory.PickupMessage "You picked up the Baron's Treasury Key!";
	}
	States {
		Spawn:
			AB1K V -1;
			Stop;
	}
}
// map12 keys //////////////////////////////////////////////////////////////////
class m12k_powerPlant1Key : wosKey {
	Default {
		Inventory.Icon "K_PWR3";//I_AB1K
		Tag "RR Powerplant\nMain Control Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Main Control Key!";
	}
	States {
		Spawn:
			PWR3 A -1;
			Stop;
	}
}
class m12k_powerPlant2Key : wosKey {
	Default {
		Inventory.Icon "K_PWR4";//I_AB1K
		Tag "RR Powerplant\nFuel Preps Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Fuel Preps Key!";
	}
	States {
		Spawn:
			PWR4 A -1;
			Stop;
	}
}
class m12k_powerPlant3Key : wosKey {
	Default {
		Inventory.Icon "K_PWR5";//I_AB1K
		Tag "RR Powerplant\nReactor Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Reactor Key!";
	}
	States {
		Spawn:
			PWR5 A -1;
			Stop;
	}
}
class m12k_powerPlantEntryKey : wosKey {
	Default {
		Inventory.Icon "K_PWR6";//I_AB1K
		Tag "RR Powerplant\nEntry Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Entry Key!";
	}
	States {
		Spawn:
			PWR6 A -1;
			Stop;
	}
}
class m12k_powerPlantStorageA : wosKey {
	Default {
		+FLATSPRITE;
		Inventory.Icon "K_PWRA";//I_AB1K
		Tag "RR Powerplant\nStorage A Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Storage A Key!";
	}
	States {
		Spawn:
			PWRA A -1;
			Stop;
	}
}
class m12k_powerPlantStorageB : wosKey {
	Default {
		+FLATSPRITE;
		Inventory.Icon "K_PWRB";//I_AB1K
		Tag "RR Powerplant\nStorage B Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Storage B Key!";
	}
	States {
		Spawn:
			PWRB A -1;
			Stop;
	}
}
class m12k_powerPlantStorageC : wosKey {
	Default {
		+FLATSPRITE;
		Inventory.Icon "K_PWRC";//I_AB1K
		Tag "RR Powerplant\nStorage C Key";
		Inventory.PickupMessage "You picked up the RavenRock Powerplant Storage C Key!";
	}
	States {
		Spawn:
			PWRC A -1;
			Stop;
	}
}
// map14 keys //////////////////////////////////////////////////////////////////
class m14k_waterplantKey : wosKey {
	Default {
		Inventory.Icon "K_ECWM";//I_AB1K
		Tag "Waterplant Key";
		Inventory.PickupMessage "You picked up the Waterplant Key!";
	}
	States {
		Spawn:
			ECWM A -1;
			Stop;
	}
}
class m14k_whiteCockInnCellarKey : wosKey {
	Default {
		//$Category "Keys/WoS"
		Inventory.icon "K_AB2K";
		Tag "Cellar Key";
		Inventory.PickupMessage "You picked up the White Cock Inn Cellar Key.";
	}
	States {
		Spawn:
			AB2K V -1;
			Stop;
	}
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////