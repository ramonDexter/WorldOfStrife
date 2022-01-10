////////////////////////////////////////////////////////////////////////////////
// rebreather
////////////////////////////////////////////////////////////////////////////////
// CREDITS:
// Sprites: Captain Toenail
// zscript: ramon.dexter, jarewill
////////////////////////////////////////////////////////////////////////////////

const rebreatherWeight = 50;
////////////////////////////////////////////////////////////////////////////////
class wosRebreather : wosPickup {
	int depleteTimer;
    bool inUse;

    override void Tick() {
        Super.Tick();
        if ( owner != null && owner.player && owner.player.health < 1 ) { inUse = 0; }
        if ( inUse == 1 ) {
            if( self.charge == 0 ) { 
                useInventory(self); 
            } else if ( depletetimer >= 70 ) { //every 2 seconds >> 2*35 tics
                self.charge--;
                depletetimer = 0;
            } else {
                depleteTimer++;
            }
            owner.GiveInventory("wosPowerRebreather", 1); //power item give
        } else {
            if ( owner != null ) {
                owner.TakeInventory("wosPowerRebreather", 1); //power item take
            }
        }
    }
	
	Default {
		//$Category "Powerups/WoS"
		//$Title "Rebreather"
		
		-SOLID
		+INVENTORY.INVBAR
		
		Tag "$T_REBREATHER";
		inventory.icon "I_RBRT";
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.PickupMessage "$F_REBREATHER";
		Mass rebreatherWeight;
		wosPickup.charge 100;
	}
	States {
		Spawn:
			RBRT A -1;
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
            TNT1 A 0 A_Log("$M_REBREATHER_filtersUsedUp");
            Fail;
		UseCheck:
            TNT1 A 0 A_Log(String.Format("%s%i%s", stringtable.localize("$M_REBREATHER_filtersLeft1"), invoker.charge, stringtable.localize("$M_REBREATHER_filtersLeft2")));
            Fail;
	}
}
class wosPowerRebreather : PowerIronFeet {
	Override void AbsorbDamage(int damage, Name damageType, out int newdamage, Actor inflictor, Actor source, int flags) {
		If( damageType=="Drowning" || damageType=="Gas" ) {
			newdamage = 0;
		}
	}
	override void DoEffect() {
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
/*class rebreather_item : wosPickup
{
	bool rebreatherSwitch;
	
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Rebreather"
		
		-SOLID
		+INVENTORY.INVBAR
		
		Tag "$T_REBREATHER";
		inventory.icon "I_RBRT";
		inventory.amount 100;
		inventory.maxamount 100;
		inventory.interhubamount 100;
		inventory.PickupMessage "$F_REBREATHER";
		radius 10;
		height 10;
		Mass rebreatherWeight;
		wosPickup.Only 1;
	
	}
	
	States
	{
		Spawn:
			RBRT A -1;
			Stop;
		Use:
			TNT1 A 0
			{
				if(invoker.rebreatherSwitch == 0) {return ResolveState("Activate");}
				if(invoker.rebreatherSwitch == 1) {return ResolveState("Deactivate");}
				return ResolveState(null);
			}
		Activate:
			TNT1 A 0
			{
				invoker.rebreatherSwitch = 1;
				A_GiveInventory("RebreatherActive", 1);
				A_GiveInventory("PowerRebreather", 1);
			}
			Stop;
		Deactivate:
			TNT1 A 0
			{
				invoker.rebreatherSwitch = 0;
				A_TakeInventory("RebreatherActive");
				A_TakeInventory("PowerRebreather");
			}
			Stop;
	}
}
//powerup with zscript magic----------------------------------------------------
class PowerRebreather : PowerProtection
{
	int RebreatherCount; 

    override void attachtoowner(actor user)
    {
        RebreatherCount = 0;
        super.attachtoowner(user);
    }

    override void doeffect()
    {
		Super.doEffect();
		
        if(owner.countinv("rebreather_item") == 0) 
        {
            owner.takeinventory("PowerRebreather", 1);
            owner.takeinventory("RebreatherActive", 1);
            RebreatherCount = 0;
			return;
		}

        RebreatherCount++;

        if(RebreatherCount == 35)
        {
            owner.takeinventory("rebreather_item", 1);
            RebreatherCount = 0;
		
        }
		if (!(level.time & 0x3f))
		{
			Owner.A_StartSound ("misc/mask", CHAN_AUTO);
		}

    }
	
	Default
	{
		Powerup.Duration 0x7FFFFFFD;
		damagefactor "drowning", 0;
		inventory.icon "I_XXXX";
	}
}
//powerup giver-----------------------------------------------------------------
class RebreatherActive : PowerupGiver
{
	Default
	{
		+INVENTORY.AUTOACTIVATE
		inventory.pickupmessage "Rebreather";
		//powerup.color "lightblue" 0.25;
		inventory.maxamount 0;
		powerup.type "PowerRebreather";
		powerup.duration 0x7FFFFFFD;
	}
	
	States
	{
		Spawn:
			RBRT A -1;
			Stop;
	}
}*/
//------------------------------------------------------------------------------

