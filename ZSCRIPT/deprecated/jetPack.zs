////////////////////////////////////////////////////////////////////////////////
//  Jetpack sorta thing  ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class jetPack_item : CustomInventory
{
	int jetPackSwith;
	
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Jetpack"
		
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		
		radius 10;
		height 10;
		scale 1;
		
		Tag "$T_JETPACK";
		inventory.icon "I_JETP";
		/*
		inventory.amount 1;
		inventory.maxamount 6;
		inventory.interhubamount 6;
		*/
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_JETPACK";
	}
	
	States
	{
		Spawn:
			DUMM A -1;
			Stop;		
		Use:	// A_Giveinventory("jetPackActive", 1);		
			TNT1 A 0
			{
				if(invoker.jetPackSwith == 0) {return ResolveState("Activate");}
				if(invoker.jetPackSwith == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0
			{
				invoker.jetPackSwith = 1;
				A_Giveinventory("jetPackActive", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0
			{
				invoker.jetPackSwith = 0;
				A_TakeInventory("jetPackActive", 1);
				A_TakeInventory("PowerJetPack", 1);
			}
			Stop;
	}

}

class PowerJetPack : PowerFlight
{
	int jetPackCount;
	
	override void attachtoowner(actor user)
    {
        jetPackCount = 0;
        super.attachtoowner(user);
    }
		
	override void doEffect()
	{
		if(owner.countinv("jetPack_item") == 0) 
        {
			return;
		}
		
		
        jetPackCount++;

        if(jetPackCount == 35)
        {
            owner.takeinventory("jetPack_item", 1);
            jetPackCount = 0;
        }
	}
	
	
	Default
	{
		Powerup.Duration 0x7FFFFFFD;
		Inventory.Icon "I_XXXX";
	}
}
class jetPackActive : PowerupGiver
{	
	Default
	{
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.FANCYPICKUPSOUND
		
		powerup.Duration 0x7FFFFFFD;
		powerup.Type "PowerJetPack";
		Inventory.MaxAmount 0;
		Inventory.UseSound "pickups/slowmo";
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			Stop;
	}

}
//==--------------------------------------------------------------------------==

