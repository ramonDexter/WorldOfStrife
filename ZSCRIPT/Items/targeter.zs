//const targeterWeight = 25;
////////////////////////////////////////////////////////////////////////////////
class wosTargeter : wosPickup replaces Targeter {
	int depleteTimer;
	bool inUse;
	
	override void Tick() {
		Super.Tick();
		if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 350 ) { //every 10 seconds >> 10*35tics
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerTargeter", 1); //power item
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerTargeter", 1); //power item
            }
        }
	}
	
	Default {
		//$Category "Powerups/WoS"
		//$Title "wos Targeter"
		-SOLID
		+INVENTORY.INVBAR
		//+INVENTORY.ALWAYSPICKUP
				
		Tag "$T_TARGETER";
		inventory.icon "I_TARG";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_TARGETER";
		Mass targeterWeight;
		wosPickup.charge 100;
	}
	States {
		Spawn:
			TARG A -1;
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
				textureID txID_I_TRG2 = TexMan.CheckForTexture("I_TRG2", 0, 0);
				invoker.icon = txID_I_TRG2;
			}
			Fail;
		UseEnd:
			TNT1 A 0 {
				invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StartSound("flashlight/off", CHAN_BODY);
				textureID txID_I_TARG = TexMan.CheckForTexture("I_TARG", 0, 0);
				invoker.icon = txID_I_TARG;
			}
			Fail;
		UseNot:
			TNT1 A 0 {
				A_Log("$M_item_battsDepleted");
				invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StartSound("flashlight/off", CHAN_BODY);
				textureID txID_I_TARG = TexMan.CheckForTexture("I_TARG", 0, 0);
				invoker.icon = txID_I_TARG;
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
class wosPowerTargeter : PowerTargeter {	
	Default {
		Powerup.Duration 0x7FFFFFFD;
	}
}
////////////////////////////////////////////////////////////////////////////////
/*class zscTargeter : wosPickup
{
	bool targeterSwitch;

	Default
	{
		//$Category "Powerups/WoS"
		//$Title "zsc Targeter"
		-SOLID
		+INVENTORY.INVBAR
		//+INVENTORY.ALWAYSPICKUP
				
		Tag "$T_TARGETER";
		inventory.icon "I_TARG";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_TARGETER";
		radius 10;
		height 10;
		Mass targeterWeight;
		wosPickup.Only 1;
	}
	
	States
	{
		Spawn:
			TARG A -1;
			Stop;
		Use:
			TNT1 A 0
			{
				if(invoker.targeterSwitch == 0) {return ResolveState("Activate");}
				if(invoker.targeterSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0
			{
				invoker.targeterSwitch = 1;
				A_GiveInventory("wosPowerTargeter", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0
			{
				invoker.targeterSwitch = 0;
				A_TakeInventory("wosPowerTargeter", 1);
			}
			Stop;
	}
}*/