const NightEyeDeviceWeight = 35;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosNightEyeDevice : wosPickup {
    int depleteTimer;
    bool inUse;
	
    override void Tick() {
        Super.Tick();
        if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 350 ) { //every 10 seconds >> 10*35
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerLantern", 1); //power item give
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerLantern", 1); //power item take
            }
        }
    }
	Default {
		//$Category "Powerups/WoS"
		//$Title "Night-Eye Device"
		
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		Tag "$T_NIGHTEYEDEVICE";
		inventory.icon "I_NEDV";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_NIGHTEYEDEVICE";
		wosPickup.charge 100;		
		Mass NightEyeDeviceWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Pickup:
            TNT1 A 0 A_RailWait();
            Stop;
		Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("Usecheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 ) { return resolveState("UseReload"); }
				else if ( invoker.inUse == 1 ) { return resolveState("UseEnd"); }
				else if ( invoker.charge == 0 ) { return resolveState("UseNot"); }
				else { return resolveState("UseStart"); }
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
            TNT1 A 0 A_Log("$M_item_battsDepleted");
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
        Usecheck:
            TNT1 A 0 A_Log(String.Format("%s%i%s", stringtable.localize("$M_item_battsLeft1"), invoker.charge, stringtable.localize("$M_item_battsLeft2")));
            Fail;
	}
}
class wosPowerLantern : PowerTorch {
	Default {
		powerup.Duration 0x7FFFFFFD;
		powerup.color "6fef67", 0.05;
		Inventory.Icon "";
	}
}
class wosD_NightEyeDevice : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "deco nighteyedevice"
		+SOLID
		-NOBLOCKMAP
		Tag "$T_NIGHTEYEDEVICE";
		radius 8;
		height 16;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*class NightEyeDevice : wosPickup {
	int nighEyeSwitch;

	Default {
		//$Category "Powerups/WoS"
		//$Title "Night-Eye Device"
		
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		
		radius 10;
		height 10;
		//scale 0.5;
		Tag "$T_NIGHTEYEDEVICE";
		inventory.icon "I_NEDV";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_NIGHTEYEDEVICE";
		wosPickup.Only 1;
		
		Mass NightEyeDeviceWeight;
	}

	States {
		Spawn:
			DUMM A -1;
			Stop;

		Use: 
			TNT1 A 0 {
				if(invoker.nighEyeSwitch == 0) {return ResolveState("Activate");}
				if(invoker.nighEyeSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
			Stop;
		Activate:
			TNT1 A 0 {
				invoker.nighEyeSwitch = 1;
				A_Giveinventory("LanternActive", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0 {
				invoker.nighEyeSwitch = 0;
				A_TakeInventory("PowerLantern", 1);
				A_TakeInventory("LanternActive", 1);
			}
			Stop;
	}

}


//==--------------------------------------------------------------------------==
//mechanics
//==--------------------------------------------------------------------------==

//example drain mechanics by Apeirogon
class lanternDrain : Inventory
{
	int tick_amount; //store integer variable with name tick_amount in this actor

    override void attachtoowner(actor user)//call every time item become part of actor inventory
    {
        tick_amount = 0;//define value of tick_amount, because compiler use value which left in memory in place where it left place for this integer value
        super.attachtoowner(user);//call super function
    }


    override void doeffect()
    {
        if(owner.countinv("cell") == 0) 
        {return;}//break funtion if owner of this item dont have cell in inventory

        tick_amount++;//AKA tick_amount + 1

        if(tick_amount == 35)
        {
            owner.takeinventory("EnergyCell", 1);
            tick_amount = 0;
        }

        //owner.a_spawnprojectile("plasmaball");
    }
}

class PowerLantern : PowerTorch {
	
	int lantern_tics; 
    override void attachtoowner(actor user) {
        lantern_tics = 0;
        super.attachtoowner(user);
    }

    override void doeffect() {
		Super.doEffect();
        if(owner.countinv("NightEyeDevice") == 0) {
			A_Print("Night-Eye Device depleted!", 0, "smallfont");
            owner.takeinventory("PowerLantern", 1);
            owner.takeinventory("LanternActive", 1);
			return;
		}
        lantern_tics++;
        if(lantern_tics == 70) {
            owner.takeinventory("NightEyeDevice", 1);
            lantern_tics = 0;
        }

    }	
	
	Default {
		powerup.Duration 0x7FFFFFFD;
		powerup.color "6fef67", 0.05;
		Inventory.Icon "I_XXXX";
	}
}

class LanternActive : PowerupGiver {
	

	Default {
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.FANCYPICKUPSOUND
		
		powerup.Duration 0x7FFFFFFD;
		powerup.Type "PowerLantern";
		Inventory.MaxAmount 1;
		Inventory.UseSound "pickups/slowmo";
	}

	States {
		Spawn:
			TNT1 A 0;
			Stop;
	}

}*/


