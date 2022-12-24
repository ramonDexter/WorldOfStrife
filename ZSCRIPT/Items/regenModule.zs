//const regenModuleWeight = 45;
////////////////////////////////////////////////////////////////////////////////
class wosRegenModule : wosPickup {
    int depleteTimer;
    bool inUse;

    override void Tick() {
        Super.Tick();
        if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 105 ) { //every 3 seconds >> 3*35
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerRegenModule", 1); //power item give
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerRegenModule", 1); //power item take
            }
        }
    }
	Default {
		//$Category "Powerups/WoS"
		//$Title "Regeneration Module"
		
		+INVENTORY.INVBAR;
		+INVENTORY.ALWAYSPICKUP;
		-SOLID;
		
		Tag "$T_RGNMDL";
		inventory.icon "I_RGNM";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_RGNMDL";
		Mass regenModuleWeight;
		wosPickup.charge 100;
	}
	States {
		Spawn:
			DUMM ABCD 6;
			Loop;
		Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("Usecheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 ) {return resolveState("UseReload"); }
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
				A_StartSound("pickups/slowmo", CHAN_5);
				textureID txID_I_RGN2 = TexMan.CheckForTexture("I_RGN2", 0, 0);
				invoker.icon = txID_I_RGN2;
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
		UseEnd:
            TNT1 A 0 {
                invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StopSound(CHAN_5);
				textureID txID_I_RGNM = TexMan.CheckForTexture("I_RGNM", 0, 0);
				invoker.icon = txID_I_RGNM;
            }
            Fail;
		UseNot:
            TNT1 A 0 A_Log("$M_item_battsDepleted");
            TNT1 A 0 {
                invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StopSound(CHAN_5);
				textureID txID_I_RGNM = TexMan.CheckForTexture("I_RGNM", 0, 0);
				invoker.icon = txID_I_RGNM;
            }
            Fail;
        Usecheck:
            TNT1 A 0 A_Log(String.Format("%s%i%s", stringtable.localize("$M_item_battsLeft1"), invoker.charge, stringtable.localize("$M_item_battsLeft2")));
            Fail;
	}
}
class wosPowerRegenModule : PowerRegeneration {
	Default {
		powerup.duration 0x7FFFFFFD;
		powerup.strength 2;
		inventory.icon "";
	}
}
class wosD_RegenModule : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "deco regenmodule"
		+SOLID
		-NOBLOCKMAP
		Tag "$T_RGNMDL";
		radius 8;
		height 8;
	}
	States {
		Spawn:
			DUMM ABCD 6;
			Loop;
	}
}
////////////////////////////////////////////////////////////////////////////////
/*class regenModule_Item : wosPickup
{
	int rgnModSwitch;
	
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Regeneration Module"
		
		+INVENTORY.INVBAR
		+INVENTORY.ALWAYSPICKUP
		-SOLID
		
		Tag "$T_RGNMDL";
		radius 10;
		height 10;
		//scale 1;
		inventory.icon "I_RGNM";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_RGNMDL";
		Mass regenModuleWeight;
		wosPickup.Only 1;
	}
	
	States
	{
		Spawn:
			DUMM ABCD 6;
			Loop;
		
		Use:
			TNT1 A 0
			{
				if(invoker.rgnModSwitch == 0) {return ResolveState("Activate");}
				if(invoker.rgnModSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0
			{
				invoker.rgnModSwitch = 1;
				A_Giveinventory("RegenModuleActive", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0
			{
				invoker.rgnModSwitch = 0;
				A_TakeInventory("PowerRegenModule");
				A_TakeInventory("RegenModuleActive");
			
			}
			Stop;
	}

}

//==--------------------------------------------------------------------------==
//mechanics
//==--------------------------------------------------------------------------==
class PowerRegenModule : PowerRegeneration
{
	int regnModCount; 

    override void attachtoowner(actor user)
    {
        regnModCount = 0;
        super.attachtoowner(user);
    }

    override void doeffect()
    {
		Super.doEffect();
        if(owner.countinv("regenModule_Item") == 0) 
        {
            owner.takeinventory("PowerRegenModule", 1);
            owner.takeinventory("RegenModuleActive", 1);
            regnModCount = 0;
			return;
		}

        regnModCount++;

        if(regnModCount == 35)
        {
            owner.takeinventory("regenModule_Item", 1);
            regnModCount = 0;
		
        }

    }
	
	Default
	{
		powerup.duration 0x7FFFFFFD;
		powerup.strength 2;
		inventory.icon "I_XXXX";
	}
}

class RegenModuleActive : PowerupGiver
{
	Default
	{
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.FANCYPICKUPSOUND		
		
		powerup.duration 0x7FFFFFFD;
		powerup.Type "PowerRegenModule";
		powerup.color "A70000", 0.3;
		inventory.pickupmessage "Regeneration!!";
		inventory.maxamount 0;
		inventory.usesound "pickups/slowmo";
	}
	
	States
	{
		Spawn:
			RGNM AB 8;
			Loop;
	}

}*/
//==--------------------------------------------------------------------------==

