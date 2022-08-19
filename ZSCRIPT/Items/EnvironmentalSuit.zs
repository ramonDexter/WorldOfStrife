//const envSuitWeight = 120;
////////////////////////////////////////////////////////////////////////////////
class wosEnvSuit : wosPickup replaces EnvironmentalSuit {
    int depleteTimer;
    bool inUse;

    override void Tick() {
        Super.Tick();
        if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 175 ) { //every 5 seconds >> 5*35
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerMask", 1); //power item give
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerMask", 1); //power item take
            }
        }
    }

    Default {
        //$Category "Powerups/WoS"
		//$Title "wos Environmental Suit"
		
		-SOLID
		+INVENTORY.INVBAR
				
		Tag "$T_ENVSUIT";
		inventory.icon "I_MASK";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_ENVSUIT";
		wosPickup.charge 100;
		Mass envSuitWeight;
    }
    States {
        Spawn:
            MASK A -1;
            Stop;
        Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("Usecheck"); }
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
				A_StartSound("sounds/armorLight", CHAN_BODY, 0);
            }
            Fail;
        UseEnd:
            TNT1 A 0 {
                invoker.inUse = 0;
                invoker.bUNDROPPABLE = 0;
				A_StopSound(CHAN_5);
            }
            Fail;
        UseNot:
            TNT1 A 0 A_log("$M_ENVSUIT_filtersUsedUp");
            Fail;
        Usecheck:
            TNT1 A 0 A_log(String.Format("%s%i%s", stringtable.localize("$M_ENVSUIT_filtersLeft1"), invoker.charge, stringtable.localize("$M_ENVSUIT_filtersLeft2")));
            Fail;
    }
}

class wosPowerMask : PowerIronFeet {
	
	Override void AbsorbDamage(int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags) {
		If(damageType=="Fire"||damageType=="Drowning"||damageType=="Gas") {
			newdamage = 0;
		}
	}
	Override void DoEffect() {
		Super.DoEffect();
		If(!(Level.maptime & 0x3f)) {
			Owner.A_StartSound("misc/mask", CHAN_5);
		}
	}
	
	Default {
		+INVENTORY.HUBPOWER;		
		Powerup.Duration 0x7FFFFFFD;
		Powerup.Color "00 00 00", 0;
		Inventory.Icon "";
	}
}
////////////////////////////////////////////////////////////////////////////////
/*class zscEnvironmentalSuit : wosPickup replaces EnvironmentalSuit {
	int envSuitSwitch;
	int depleteTimer;
	
	override void Tick() {
		Super.Tick();
		
	}

	Default {
		//$Category "Powerups/WoS"
		//$Title "zsc Environmental Suit"
		
		-SOLID
		+INVENTORY.INVBAR
		//+INVENTORY.ALWAYSPICKUP
				
		Tag "$T_ENVSUIT";
		inventory.icon "I_MASK";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_ENVSUIT";
		radius 10;
		height 10;
		wosPickup.Only 1;
		wosPickup.charge 100;
		Mass envSuitWeight;
	}	
	States {
		Spawn:
			MASK A -1;
			Stop;
			
		Use:
			TNT1 A 0 {
				if(invoker.envSuitSwitch == 0) {return ResolveState("Activate");}
				if(invoker.envSuitSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0 {
				invoker.envSuitSwitch = 1;
				A_GiveInventory("EnvSuitActive", 1);
				A_GiveInventory("PowerEnvSuit", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0 {
				invoker.envSuitSwitch = 0;
				A_TakeInventory("EnvSuitActive", 1);
				A_TakeInventory("PowerEnvSuit", 1);
			}
			Stop;
	}
}

class EnvSuitActive : PowerupGiver {
	Default {
		-INVENTORY.INVBAR
		-INVENTORY.FANCYPICKUPSOUND
		
		Inventory.MaxAmount 1;
		Powerup.Type "PowerEnvSuit";
		Inventory.Icon "I_XXXX";
	}	
	States {
		Spawn:
			MASK A -1;
			Stop;
	}
}*/

//class PowerEnvSuit : PowerIronFeet {
	/*int envSuitCount; 

    override void attachtoowner(actor user) {
        envSuitCount = 0;
        super.attachtoowner(user);
    }

    override void doeffect() {
		Super.doEffect();
        if(owner.countinv("zscEnvironmentalSuit") == 0) {
            owner.takeinventory("EnvSuitActive", 1);
            owner.takeinventory("PowerEnvSuit", 1);
            envSuitCount = 0;
			return;
		}

        envSuitCount++;

        if(envSuitCount == 70) {
            owner.takeinventory("zscEnvironmentalSuit", 1);
            envSuitCount = 0;
		
        }
		if (!(level.time & 0x3f)) {
			Owner.A_StartSound ("misc/mask", CHAN_AUTO);
		}

    }*//*
	Override void AbsorbDamage(int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags)
	{
		If(damageType=="Fire"||damageType=="Drowning"||damageType=="Gas")
		{
			newdamage = 0;
		}
	}
	Override void DoEffect()
	{
		Super.DoEffect();
		If(!(Level.maptime & 0x3f))
		{
			Owner.A_StartSound("misc/mask",CHAN_5);
		}
	}
	
	Default {
		+INVENTORY.HUBPOWER
		
		Powerup.Duration 0x7FFFFFFD;
		Powerup.Color "00 00 00", 0;
		Inventory.Icon "";
		ActiveSound "misc/mask";
	}
}*/
