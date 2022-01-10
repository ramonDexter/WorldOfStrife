const shadowArmorWeight = 95;
////////////////////////////////////////////////////////////////////////////////
class wosShadowArmor : wosPickup replaces ShadowArmor {
	int depleteTimer;
    bool inUse;

    override void Tick() {
        Super.Tick();
        if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 52 ) { //every roughly 1.5 second >> 17+35
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerShadow", 1); //power item give
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerShadow", 1); //power item take
            }
        }
    }
	Default {
		//$Category "Powerups/WoS"
		//$Title "wos Shadow Armor"
		-SOLID
		+INVENTORY.INVBAR
				
		Tag "$T_SHADOWARMOR";
		inventory.icon "I_SHD1";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_SHADOWARMOR";
		wosPickup.charge 100;
		Mass shadowArmorWeight;
	}
	States {
		Spawn:
			SHD1 A -1 Bright;
			Stop;
		Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("Usecheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 ) { return resolveState("UseReload"); }
				else If ( invoker.inUse == 1 ) { return resolveState("UseEnd"); }
				Else if ( invoker.charge == 0 ) { return resolveState("UseNot"); }
				Else { return resolveState("UseStart"); }
				return resolveState(null);
			}
			Fail;
		UseStart:
			TNT1 A 0 {
				invoker.inUse = 1;
                invoker.bUNDROPPABLE = 1;
				A_StartSound("flashlight/on", CHAN_BODY);
			}
			Fail;
		UseEnd:
			TNT1 A 0 {
				invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StartSound("flashlight/off", CHAN_BODY);
			}
			Fail;
		UseNot:
			TNT1 A 0 {
				A_Log("$M_item_battsDepleted");
			}
			Fail;
		UseReload:
			TNT1 A 0 {
				int finalLoad = 100 - invoker.charge;
				if ( invoker.charge == 100 || CountInv("EnergyPod") < finalLoad ) { return resolveState("UseReloadNot"); }
				else { return resolveState("UseReloadYes"); }
				
			}
			Fail;
		UseReloadYes:
			TNT1 A 0 {
				int finalLoad = 100 - invoker.charge;
				if ( CountInv("EnergyPod") >= finalLoad ) {
					TakeInventory("EnergyPod", finalLoad);
					invoker.charge += finalload;
					A_Log(String.Format("%s%i%s", stringtable.localize("$M_item_battsReload1"), finalload, stringtable.localize("$M_item_battsReload2")));
				}				
			}
			Fail;
		UseReloadNot:
			TNT1 A 0 A_Log("$M_item_battsCantReload");
			Fail;
		UseCheck:
			TNT1 A 0 A_Log(String.Format("%s%i%s", stringtable.localize("$M_item_battsLeft1"), invoker.charge, stringtable.localize("$M_item_battsLeft2")));
			Fail;
	}
}
class wosPowerShadow : PowerInvisibility {
	Default {
		+INVENTORY.HUBPOWER;		
		Powerup.Duration 0x7FFFFFFD;
		Powerup.Strength 75;
		Powerup.Mode "Cumulative";
		Inventory.Icon "I_XXXX";
	}
}
////////////////////////////////////////////////////////////////////////////////

/*class zscShadowArmor : wosPickup replaces ShadowArmor
{
	int shadowArmorSwitch;
	
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "zsc Shadow Armor"
		-SOLID
		+INVENTORY.INVBAR
		//+INVENTORY.ALWAYSPICKUP
				
		Tag "$T_SHADOWARMOR";
		inventory.icon "I_SHD1";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_SHADOWARMOR";
		radius 10;
		height 16;
		wosPickup.Only 1;
		Mass shadowArmorWeight;
	}
	
	States
	{
		Spawn:
			SHD1 A -1 Bright;
			Stop;
			
		Use:
			TNT1 A 0
			{
				if(invoker.shadowArmorSwitch == 0) {return ResolveState("Activate");}
				if(invoker.shadowArmorSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0
			{
				invoker.shadowArmorSwitch = 1;
				//A_GiveInventory("ShadowArmorActive", 1);
				A_GiveInventory("wosPowerShadow", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0
			{
				invoker.shadowArmorSwitch = 0;
				//invoker.A_TakeInventory("ShadowArmorActive", 1);
				A_TakeInventory("wosPowerShadow", 1);
			}
			Stop;
	}
}*/

/*class ShadowArmorActive : PowerupGiver
{
	Default
	{
		+FLOORCLIP
		+VISIBILITYPULSE
		+INVENTORY.INVBAR
		-INVENTORY.FANCYPICKUPSOUND
		
		RenderStyle "Translucent";
		Tag "$TAG_SHADOWARMOR"; // "Shadow Armor"
		Inventory.MaxAmount 2;
		Powerup.Type "PowerShadowAugmented";
		Inventory.Icon "I_XXXX";
		Inventory.PickupSound "misc/i_pkup";
		Inventory.PickupMessage "$TXT_SHADOWARMOR"; // "You picked up the Shadow armor."
	}
}*/