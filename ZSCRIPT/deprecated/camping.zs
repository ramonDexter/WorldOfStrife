class campFire : actor {
	Default {		
		-SOLID
		+USESPECIAL
		
		scale 1;
		Radius 16;
		Height 32;
	}
	
	States {
		Spawn:
			SKF1 ABCD 4 Bright light("FireMedium") {
				A_StartSound("sounds/DNfire", 0, 0.6, true);
				A_SetSpecial(80, 979);
			}
			Loop;
	}
}

class campFire_item : CustomInventory {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Campfire"
		
		+INVENTORY.INVBAR
		+INVENTORY.ALWAYSPICKUP
		
		Tag "$T_CAMPFIRE";
		Inventory.Amount 1;
		Inventory.MaxAmount 5;
		Inventory.InterHubAmount 5;
		Inventory.Icon "I_CFIR";
		radius 10;
		height 10;
	}
	
	States {
		Spawn:
			CFIR A -1;
			Stop;
		Use:
			TNT1 A 0 A_SpawnItemEx("campFire", 48, 0, 0, 0, 0, 0, 0, 0, 0, 979);
			Stop;
	}
}

class bedRoll : actor {
	Default {
		+FLATSPRITE
		-SOLID
		+USESPECIAL
		
		radius 32;
		height 8;
		scale 1;
	}
	
	States {
		Spawn:
			BEDR D 1 A_SetSpecial(80, 919);
			Loop;
	}
}

class bedRoll_decoration : actor {
	Default {
		//$Category "Decorations"
		//$Title "Bedroll dummy"
		
		+FLATSPRITE
		-SOLID
		
		radius 16;
		height 8;
		scale 1.0;
	}
	
	States {
		Spawn:
			BEDR D -1;
			Stop;
	}
}

class bedRoll_item : CustomInventory {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Bedroll"
	
		+INVENTORY.INVBAR
		+INVENTORY.ALWAYSPICKUP
		-SOLID
		
		Tag "$T_BEDROLL";
		Inventory.Amount 1;
		Inventory.MaxAmount 5;
		Inventory.InterHubAmount 5;
		Inventory.Icon "I_BEDR";
		radius 10;
		height 10;
	}
	
	States {
		Spawn:
			BEDR A -1;
			Stop;
		Use:
			TNT1 A 0 A_SpawnItemEx("bedRoll", 48, 0, 0, 0, 0, 0, 0, 0, 0, 919);
			Stop;
	}
}

class playerIsSleeping : Inventory {
	Default {
		inventory.amount 1;
		Mass 0;
	}
}
