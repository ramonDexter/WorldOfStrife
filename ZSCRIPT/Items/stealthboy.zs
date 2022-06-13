////////////////////////////////////////////////////////////////////////////////
// stealth powerup /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//const StealthBoyWeight = 85;
///////////////////////////////////////////////////

class wosStealthBoy : wosPickup {
    int depleteTimer;
	bool inUse;
	
	override void Tick() {
		Super.Tick();
		if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 105 ) { //every 3 seconds >> 3*35tics
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerStealth", 1); //power item
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerStealth", 1); //power item
            }
        }
	}

    Default {
        //$Category "Powerups/WoS"
		//$Title "wos stealthboy"
		-SOLID
		+INVENTORY.INVBAR
		//+INVENTORY.ALWAYSPICKUP
				
		Tag "$T_wosStealthBoy";
		inventory.icon "I_STLT";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_wosStealthBoy";
		Mass StealthBoyWeight;
		wosPickup.charge 100;
    }

    States {
        Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("Usecheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 ) { return resolveState("UseReload"); } 
				else if ( invoker.inUse == 1 ) { return resolveState("UseEnd"); }
				else if ( invoker.charge == 0 ) { return resolveState("UseNot"); }
				else {
					return resolveState("UseStart");
				}
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
				A_StartSound("flashlight/off", CHAN_BODY);
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
class wosPowerStealth : PowerInvisibility {
    Default {
        +INVENTORY.HUBPOWER
        Powerup.Duration 0x7FFFFFFD;
        Powerup.Strength 75;
        Powerup.Mode "Cumulative";
		Inventory.Icon "";
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////