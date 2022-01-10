//Quick Travel
//==----------------==
//Places a beacon dummy and TeleportDest with tag 4022
//returns back to TeleportDest with ID 4022
//script then changes teleportDest TID to 0 so player can use another place
//and removes beacon dummy
//ACS:
//==----------------==
//	script "quickTravelNavrat" (void)
//	{
//		Teleport(4022, 0, 0);
//		Thing_Remove(40204);
//		Delay(8);
//		Thing_ChangeTID(4022, 0);
//	}
//
//
//==--------------------------------------------------------------------------==
class quickTravelTAM : CustomInventory
{
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Quick Travel"		
		
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		//+inventory.Undroppable
		
		Tag "$T_QTDEV";
		height 10;
		radius 10;
		scale 0.5;
		inventory.icon "I_QTDB";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		inventory.pickupmessage "$F_QTDEV";
	}
	
	States
	{
		Spawn:
		QTDB V -1;
		Stop;
		
		Use:
		TNT1 A 0
		{
			A_SpawnItemEx("teleportDest", 0, 0, 0, 0, 0, 0, 0, 0, 0, 4022);
			A_SpawnItemEx("quickTravelBeacon", 0, 0, 0, 0, 0, 0, 0, 0, 0, 40204);
			A_Giveinventory("quickTravelZPET", 1);
		}
		Stop;
	}
}
class quickTravelZPET : CustomInventory
{
	Default
	{
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		+inventory.Undroppable
		+INVENTORY.UNTOSSABLE
		
		Tag "$T_QTDEV";
		height 8;
		radius 8;
		scale 0.5;
		inventory.icon "I_QTDV";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
	}
	States
	{
		Spawn:
		QTDV V -1;
		Stop;
		
		Use:
		TNT1 A 0
		{
			ACS_NamedExecuteAlways("quickTravelNavrat", 0, 0, 0, 0);
			A_Giveinventory("quickTravelTAM", 1);
		}
		Stop;
	}
}

class quickTravelBeacon : actor
{
	Default
	{
		-Solid
		-Nogravity
		+NoDamage
		+NoBlood
		+DontSplash
		+NoDamageThrust
		+DontThrust	
		
		radius 8;
		height 8;
		scale 0.5;
	}
	
	States
	{
		Spawn:
		QTBC V -1;
		Stop;
		
	}

}
//==--------------------------------------------------------------------------==