//inv.item
//==----------------------------------------------------------------------------
class ShieldModule : CustomInventory
{

	int shieldToggle;

	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Shield"
		
		-Solid
		+inventory.invbar
		+inventory.AlwaysPickup
		
		radius 10;
		height 10;
		//scale 0.5;
		Tag "$T_SHIELDDEVICE";
		inventory.icon "I_SHLD";
		inventory.amount 100;
		inventory.maxamount 200;
		inventory.interhubamount 200;
		inventory.PickupMessage "$F_SHIELDDEVICE";
	}

	States
	{
		Spawn:
			SHLD V -1;
			Stop;

		Use: //A_Giveinventory("PowerPortableShield", 1);
			TNT1 A 0 
            {
                if(invoker.shieldToggle == 0) {return ResolveState("Activate");}
                if(invoker.shieldToggle == 1) {return ResolveState("Deactivate");}
                return ResolveState(null);
            }
        Activate:
            TNT1 A 0
            {
                invoker.shieldToggle = 1;
                A_Giveinventory("PortableShieldActive", 1);
            }
            Stop;
        Deactivate:
            TNT1 A 0
            {
                invoker.shieldToggle = 0;
                A_TakeInventory("PowerPortableShield", 1);
                A_TakeInventory("PortableShieldActive", 1);
            }
			Stop;
	}

}

//shield inventory spawner
//------------------------------------------------------------------------------
class shield_inv_spawner : custominventory
{
	Default
	{
		-INVENTORY.INVBAR
		+INVENTORY.ALWAYSPICKUP
	}
	
	States
	{
		Spawn:
		Pickup:
			TNT1 A 0 A_SpawnItemEx ("ShieldSpawner", 0, 96, 0, 0, 0, 0, -270, 32);
			Stop;
	}
}

//shield controller
//------------------------------------------------------------------------------
class PowerPortableShield : Powerup
{
	
	int shield_tics; 

    override void attachtoowner(actor user)
    {
        shield_tics = 0;
        super.attachtoowner(user);
    }

    override void doeffect()
    {
        if(owner.countinv("ShieldModule") == 0) 
        {
			A_Print("Portable Shield depleted!", 0, "smallfont");
            owner.takeinventory("PowerPortableShield", 1);
            owner.takeinventory("PortableShieldActive", 1);
            shield_tics = 0;
			return;
		}
		
        owner.giveInventory("shield_inv_spawner", 1);
        shield_tics++;

        if(shield_tics == 35)
        {
            owner.takeinventory("ShieldModule", 1);
            shield_tics = 0;
        }

    }
	
	
	Default
	{
		powerup.Duration 0x7FFFFFFD;
		powerup.color "000000", 0.0;
		Inventory.Icon "I_XXXX";
	}
}

class PortableShieldActive : PowerupGiver
{
	

	Default
	{
		+INVENTORY.AUTOACTIVATE
		+INVENTORY.FANCYPICKUPSOUND
		
		powerup.Duration 0x7FFFFFFD;
		powerup.Type "PowerPortableShield";
		Inventory.MaxAmount 1;
		Inventory.UseSound "pickups/slowmo";
	}

	States
	{
		Spawn:
			TNT1 A 0;
			Stop;
	}

}


//shield itself
//------------------------------------------------------------------------------
class ShieldPart : actor
{
    Default
    {
        +SHOOTABLE
		+NOGRAVITY
		+NOTELEPORT
		+NODAMAGE
		+NORADIUSDMG
		+DONTRIP
		+NOBLOODDECALS
		+FLOORCLIP	
		+GHOST

        Radius 8;
        Height 8;
        Scale 0.5;
        RenderStyle "None";
        Alpha 0.15;
        BloodType "ShieldHit";
    }

    States
    {
        Spawn:
            HEXA A 2 bright;
            stop;
        Death:
            TNT1 A 2;
            stop;
    }
}

class ShieldPartVisual : actor
{
    Default
    {
        +NOINTERACTION
        +CLIENTSIDEONLY
        +FLOORCLIP

        Radius 8;
        Height 8;
        Scale 0.5;
        RenderStyle "Add";
        Obituary "%o was evaporated by %k's shield, mwahahaha!";
        Alpha 0.15;
    }
    States
    {
        Spawn:
            HEXA A 2 bright;
            stop;
        Death:
            TNT1 A 2;
            stop;
    }
}

class ShieldSpawner : actor
{
    Default
    {        
        +NOGRAVITY
        +NOINTERACTION

        Radius 1;
        Height 1;
    }
    States
    {
        Spawn:
            TNT1 A 0;
            TNT1 A 1;
            TNT1 A 0 
			{
				A_SpawnItemEx ("ShieldSpawner4up", 0, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner5up", 24, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner5up", -24, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner4up", 48, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner4up", -48, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner3up", 72, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldSpawner3up", -72, 0, 0, 0, 0, 0, 0, 32);
				//A_SpawnItemEx ("ShieldSpawner2up", 96, 0, 0, 0, 0, 0, 0, 32);
				//A_SpawnItemEx ("ShieldSpawner2up", -96, 0, 0, 0, 0, 0, 0, 32);
			}
           
            stop;
    }
}

class ShieldSpawner5up : actor
{
    Default
    {
        +NOGRAVITY
        +NOINTERACTION

        Radius 1;
        Height 1;
    }
    
    States
    {
        Spawn:
            TNT1 A 0;
            TNT1 A 1;
            TNT1 A 0 
			{
				A_SpawnItemEx ("ShieldPart", 0, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 64, 0, 0, 0, 0, 32);
				//A_SpawnItemEx ("ShieldPartVisual", 0, 0, 0, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 64, 0, 0, 0, 0, 32);
			}
            stop;
    }
}

class ShieldSpawner4up : actor
{
    Default
    {
        +NOGRAVITY
        +NOINTERACTION
		
        Radius 1;
        Height 1;
    }

    States
    {
    Spawn:
        TNT1 A 0;
        TNT1 A 1;
        TNT1 A 0 
		{
			A_SpawnItemEx ("ShieldPart", 0, 0, 8, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPart", 0, 0, 56, 0, 0, 0, 0, 32);
			//A_SpawnItemEx ("ShieldPartVisual", 0, 0, 8, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			A_SpawnItemEx ("ShieldPartVisual", 0, 0, 56, 0, 0, 0, 0, 32);
		}			
        stop;
    }
}

class ShieldSpawner3up : actor
{
    Default
    {
        +NOGRAVITY
        +NOINTERACTION

        Radius 1;
        Height 1;
    }

    States
    {
        Spawn:
            TNT1 A 0;
            TNT1 A 1;
            TNT1 A 0 
			{
				A_SpawnItemEx ("ShieldPart", 0, 0, 16, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 32, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 48, 0, 0, 0, 0, 32);
				//A_SpawnItemEx ("ShieldPartVisual", 0, 0, 16, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 32, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 48, 0, 0, 0, 0, 32);
			}
            stop;
    }
}


class ShieldSpawner2up : actor
{
    Default
    { 
        +NOGRAVITY
        +NOINTERACTION   

        Radius 1;
        Height 1;
    }

    States
    {
        Spawn:
            TNT1 A 0;
            TNT1 A 1;
            TNT1 A 0 
			{
				A_SpawnItemEx ("ShieldPart", 0, 0, 24, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPart", 0, 0, 40, 0, 0, 0, 0, 32);
				//A_SpawnItemEx ("ShieldPartVisual", 0, 0, 24, 0, 0, 0, 0, 32);
				A_SpawnItemEx ("ShieldPartVisual", 0, 0, 40, 0, 0, 0, 0, 32);
			}
            stop;
    }
}

class ShieldHit : actor
{
    Default
	{
		+NOGRAVITY
		+NOINTERACTION
		
		Radius 1;
		Height 1;
		Scale 0.5;
		Renderstyle "Add";
	}
	
	States
	{
		Spawn:
			FHIT A 0 bright;
			FHIT A 1 bright A_Stop();
			FHIT A 0 bright A_StartSound ("ForceBarrier/Hit", 0);
			FHIT BCDEFGH 1 bright;
			stop;
	}
}


