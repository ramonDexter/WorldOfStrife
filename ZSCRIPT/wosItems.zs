////////////////////////////////////////////////////////////////////////////////
//  WoS items main definition  /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  item weights  //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
const leaderSkullWeight = 10;
const gCoinWeight = 0;
const gChest50Weight = 25;
const gChest100Weight = 50;
const gChest250Weight = 125;
const gChest500Weight = 250;
const wosDegninOreWeight = 10;
const wosq_chemicalOreWeight = 5;
const wosq_chemicalSolutionWeight = 15;
const wosq_rottenWaterWeight = 5;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  main base item class  //////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosPickup : CustomInventory {
    int stack;
    property Stack : stack;
    bool onlyone;
    property Only : onlyone;
	int charge;
	property charge : charge;
	

    override bool TryPickup (in out Actor toucher) {
        if (onlyone==1 && toucher.CountInv(self.GetClassName())>0) {
            return 0;
        }
        Else {
            return super.TryPickup(toucher);
        }
    }
    override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.encumbrance+=self.mass;
    }
    override void DoEffect() {
        super.DoEffect();
        let pawn = binderPlayer(owner);
        if (onlyone==0) {
            pawn.encumbrance+=self.mass*self.amount;
        }
        else {
            pawn.encumbrance+=self.mass;
        }
    }
    override void OnDrop (Actor dropper) {
        if (self.stack>0) {
            let whatto = self.GetClassName();
            int todrop = dropper.CountInv(whatto);
            if (todrop>self.stack-1) {
                todrop = self.stack - 1;
            }
            dropper.takeInventory(self.GetClassName(), todrop);
            self.amount = todrop + 1;
            super.OnDrop(dropper);
        }
    }

    Default {
		+INVENTORY.INVBAR;
        Inventory.Amount 1;
		Inventory.MaxAmount 999;
		Inventory.InterHubAmount 999;
		Inventory.PickupSound "sounds/itemPickup";
		Mass 0;
		radius 12;
		height 12;
    }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  upgrade token  /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class upgradeToken : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Upgrade Token"
				
		+INVENTORY.INVBAR
		Tag "Upgrade Token";
		Inventory.Icon "I_UPTK";
		Inventory.Amount 1;
		Inventory.MaxAmount 100;
		Inventory.InterHubAmount 100;		
		Inventory.PickupMessage "Upgrade Token Acquired!";
		Inventory.PickupSound "misc/p_pkup";
		Mass 0;
	}
	
	States {
		Spawn:
			UPTK A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}

// upgrade implants ////////////////////////////////////////////////////////////

// health regeneration implant /////////////////////////////////////////////////
class implant_health : CustomInventory {

	int counter;
	override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        counter = 0;
    }
	override void Tick() {
		if ( counter == 35 ) {
			let pawn = binderPlayer(owner);
			if ( owner && owner.player ) {
				if ( pawn.health < pawn.maxhealth ) { 
					owner.GiveBody(1, 0); 
					counter = 0;
					if ( pawn.bleedlevel > 0 ) {
						pawn.bleedlevel = 0;
						A_Log("\c[red][ Bleeding stopped! ]");
					}
				}
			}
		} else {
			counter++;
		}
		Super.Tick();
	}

	Default {
		-INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.UNCLEARABLE
		tag "Health Regeneration Implant";
		inventory.icon "I_HLRG";
		inventory.Amount 1;
		inventory.MaxAmount 1;
		Inventory.InterHubAmount 1;
		Mass 0;
	}

	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}

// full stamina implant ////////////////////////////////////////////////////////
class implant_stamina : CustomInventory {
	Default {
		-INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.UNCLEARABLE
		tag "Stamina Implant";
		inventory.icon "I_STRG";
		inventory.Amount 1;
		inventory.MaxAmount 1;
		Inventory.InterHubAmount 1;
		Mass 0;
	}

	override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.staminaImplant = true;
    }

	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////

// mind upgrade ////////////////////////////////////////////////////////////////
class upgradeMind : DummyStrifeItem {
	override bool TryPickup(in out Actor toucher) {
		let pawn = binderPlayer(toucher);
		if ( toucher.player == NULL || pawn.mindValue >= 100 ) {
			return false;
		} else {
			pawn.mindValue += 10;
			GoAwayAndDie();
			return true;
		}
	}
}

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  quest journal  /////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class journalitem : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Journal"
			
		+CountItem
		+Inventory.invbar
		+Inventory.AlwaysPickup
		+INVENTORY.UNDROPPABLE
		-SOLID
		+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS		
		
		Tag "$TAG_journalitem";	
		Inventory.PickupSound "misc/i_pkup";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.icon "I_JRNL";
		height 24;
		radius 10;
		scale 0.3;
		Mass 0;
	}
	
	States {
		Spawn:
			JRNL A -1;
            Stop;
		Use:
			TNT1 A 0 {
				ACS_NamedExecute("journal", 0, 0, 0, 0);
				//A_GiveInventory("journalitem",1);
			}
			Fail;
	}

}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  binder badge - also serves as token  ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class binderBadge : CustomInventory {	
	Default {
		//$Category "Quest things/WoS"
		//$Title "Binder Badge"
		
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE		
		Tag "Binder Badge";
		inventory.icon "I_BADG";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}
	
	States {
		Spawn:
			BADG A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}	
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  money  /////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class goldCoin : Inventory /*replaces coin*/ {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coin"
		+DROPPED
		+NOTDMATCH
		+FLOORCLIP
		+INVENTORY.INVBAR
		Inventory.MaxAmount 10000;
		Tag "$TAG_COIN";
		Inventory.Icon "I_COIN";
		Inventory.PickupMessage "$TXT_COIN";
		Inventory.pickupSound "sounds/coinPickup";
		Mass gCoinWeight;
		radius 8;
		
	}
	States {
		Spawn:
			COIN A -1;
			Stop;
	}
}
class wosGold10 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (10)"
		-INVENTORY.INVBAR
		//Inventory.Amount 10
		Tag "$TAG_10GOLD"; // "10 gold"
		Inventory.PickupMessage "$TXT_10GOLD"; // "You picked up 10 gold."
		Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			CRED A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("goldCoin", 10);
			Stop;
	}
}
class wosGold25 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (25)"
		-INVENTORY.INVBAR
		Tag "$TAG_25GOLD";
		Inventory.PickupMessage "$TXT_25GOLD";
		Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			SACK A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("goldCoin", 25);
			Stop;
	}
}
class wosGold50 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (50)"
		-INVENTORY.INVBAR
		Tag "$TAG_50GOLD";
		Inventory.PickupMessage "$TXT_50GOLD";
		Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			CHST A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("goldCoin", 50);
			Stop;
	}
}
//  gold chest  ////////////////////////////////////////////////////////////////
//  50  ////////////////////////////////////////////////////////////////////////
class goldChest50_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with coins (50)"
		
		+INVENTORY.INVBAR
		
		Tag "Chest with coins";
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "You picked up the Chest with coins.";
		Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest50Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("goldCoin", 50);
            }
            Stop;
    }
}
//  100  ///////////////////////////////////////////////////////////////////////
class goldChest100_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with coins (100)"
		
		+INVENTORY.INVBAR
		
		Tag "Chest with coins";
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "You picked up the Chest with coins.";
		Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest100Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("goldCoin", 100);
            }
            Stop;
    }
}
//  250  ///////////////////////////////////////////////////////////////////////
class goldChest250_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with coins (250)"
		
		+INVENTORY.INVBAR
		
		Tag "Chest with coins";
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "You picked up the Chest with coins.";
		Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest250Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("goldCoin", 250);
            }
            Stop;
    }
}
//  500  ///////////////////////////////////////////////////////////////////////
class goldChest500_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with coins (500)"
		
		+INVENTORY.INVBAR
		
		Tag "Chest with coins";
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "You picked up the Chest with coins.";
		Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest500Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("goldCoin", 500);
            }
            Stop;
    }
}

class zscScanner : Scanner replaces Scanner {
	Default {
		//$Category "Powerups/WoS"
		//$Title "zscScanner"
		radius 10;
		height 10;
		Mass 0;
	}
	States {
		Spawn:
			PMUP ABCD 6;
			Loop;
	}
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//  QUEST ITEMS&&TOKENS  ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

class travelTicket : CustomInventory
{
	Default
	{			
		//$Category "Quest things/WoS"
		//$Title "Travel Ticket"
		
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		Tag "Transportation Ticket";
		Inventory.Icon "I_TRTK";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Transportation Ticket!";
		Inventory.PickupSound "misc/i_pkup";
		Mass 0;
	}
	
	States
	{
		Spawn:
			TRTK A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	
	}
}

class powerPlant_powerCoupling : CustomInventory
{
	Default
	{			
		//$Category "Quest things/WoS"
		//$Title "Power Coupling (wos)"
		
		+inventory.invbar
		
		Tag "Power Coupling";
		inventory.icon "I_PCOP";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}
	
	States
	{
		Spawn:
			COUP AB 5;
			Loop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class hereticDatapad1 : CustomInventory
{
	Default
	{			
		//$Category "Quest things/WoS"
		//$Title "Heretic Datapad #1"
		
		+INVENTORY.INVBAR
		
		Tag "Heretic Datapad 1";
		inventory.icon "I_HDPD";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}
	
	States
	{
		Spawn:
			HDPD A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}



class caseInformationDisk : CustomInventory
{
	Default
	{			
		//$Category "Quest things/WoS"
		//$Title "Lost artifact information disk"
		
		+INVENTORY.INVBAR
		
		Tag "Lost artifact information disk";
		inventory.icon "I_HDPD";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}
	
	States	
	{
		Spawn:
			HDPD A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class leaderskull : wosPickup {
	Default {
		//$Category "Quest things"
		//$Title "Heretic Leader Skull"
		
		+inventory.INVBAR
		+inventory.alwayspickup
	
		Tag "Heretic Leader Skull";
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_HCSK";
		Inventory.PickupMessage "Heretic Captain skull acquired!";
		Mass leaderSkullWeight;
	}
	
	States
	{
		Spawn:
			HCSK A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}



class cityBathMurder_Detonator : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "city bath murder - detonator"
		
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		Tag "Detonator";
		Inventory.Icon "I_DTNT";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Detonator!";
		Inventory.PickupSound "misc/i_pkup";
		Mass 0;
	}
	States {
		Spawn:
			MGD5 A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class hereticalRelic : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "heretical relic"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Heretical Relic";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Heretical Relic!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			HRLC V -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}
class infoDisk : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "heretical Data Disk"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Data Disk";
		Inventory.Icon "I_DDSB";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Data Disk!";
		Inventory.PickupSound "misc/i_pkup";
		Mass 0;
	}
	States {
		Spawn:
			DDSB A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class q_explosiveDevice_01 : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Explosive Device";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}
class q_bomb_01 : actor {
	Default {
		-SOLID
		height 32;
		radius 16;
	}
	States {
		Spawn:
			MS01 A 175;
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m06_lowerWall", 6);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}

// queen1 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen1 : CustomInventory {
	// ACS support /////////////////////////////////////////////////////////
	/*bool bombCanBePlanted;	
	action void F_plantBombAllow(void) {
		bombCanBePlanted = true;
		A_Log("\c[green][ You can place the bomb#1 here. ]");
	}
	action void F_plantBombDisable(void) {
		bombCanBePlanted = false;
	}*/
	////////////////////////////////////////////////////////////////////////
	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#1"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Explosive Device #1";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			/*TNT1 A 0 {
				if ( bombCanBePlanted ) {
					return resolveState("UseYes");
				} else {
					return resolveState("UseNot");
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#1 only! ]");
			Fail;
		UseYes:*/
			TNT1 A 0 {
				A_SpawnItemEx("q_bomb_queen1", 16, 0, 0);
				A_Log("\c[red][ Bomb#1 planted. RUN AWAY!!! ]");
			}
			Stop;
	}
}
class q_bomb_queen1 : actor {
	Default {
		-SOLID
		height 32;
		radius 16;
	}
	States {
		Spawn:
			MS01 A 175;
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen1_blowWall", 14);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
// queen2 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen2 : CustomInventory {
	// ACS support /////////////////////////////////////////////////////////
	/*bool bombCanBePlanted;
	static void F_plantBombAllow(void) {
		bombCanBePlanted = true;
		A_Log("\c[green][ You can place the bomb#2 here. ]");
	}
	static void F_plantBombDisable(void) {
		bombCanBePlanted = false;
	}*/
	////////////////////////////////////////////////////////////////////////

	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#2"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Explosive Device #2";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			/*TNT1 A 0 {
				if ( bombCanBePlanted ) {
					return resolveState("UseYes");
				} else {
					return resolveState("UseNot");
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#2 only! ]");
			Fail;
		UseYes:*/
			TNT1 A 0 {
				A_SpawnItemEx("q_bomb_queen2", 16, 0, 0);
				A_Log("\c[red][ Bomb#2 planted. RUN AWAY!!! ]");
			}
			Stop;
	}
}
class q_bomb_queen2 : actor {
	Default {
		-SOLID
		height 32;
		radius 16;
	}
	States {
		Spawn:
			MS01 A 175;
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen2_blowWall", 14);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
// queen3 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen3 : CustomInventory {
	// ACS support /////////////////////////////////////////////////////////
	/*bool bombCanBePlanted;
	static void F_plantBombAllow(void) {
		bombCanBePlanted = true;
		A_Log("\c[green][ You can place the bomb#3 here. ]");
	}
	static void F_plantBombDisable(void) {
		bombCanBePlanted = false;
	}*/
	////////////////////////////////////////////////////////////////////////

	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#2"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "Explosive Device #2";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			/*TNT1 A 0 {
				if ( bombCanBePlanted ) {
					return resolveState("UseYes");
				} else {
					return resolveState("UseNot");
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#3 only! ]");
			Fail;
		UseYes:*/
			TNT1 A 0 {
				A_SpawnItemEx("q_bomb_queen3", 16, 0, 0);
				A_Log("\c[red][ Bomb#3 planted. RUN AWAY!!! ]");
			}
			Stop;
	}
}
class q_bomb_queen3 : actor {
	Default {
		-SOLID
		height 32;
		radius 16;
	}
	States {
		Spawn:
			MS01 A 175;
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen3_blowWall", 14);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
////////////////////////////////////////////////////////////////////////////////



class hereticLeaderSkull : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Heretic Leader Skull"
		+inventory.INVBAR
		+inventory.alwayspickup
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		Tag "Heretic Leader Skull";
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_HCSK";
		Inventory.PickupMessage "Heretic Leader skull acquired!";
		Mass 0;
	}
	States {
		Spawn:
			HCSK A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class blueChalice : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "blue chalice inv item"
		+inventory.INVBAR
		+inventory.alwayspickup
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		Tag "Blue Offering Chalice";
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_RELB";
		Inventory.PickupMessage "Blue Offering Chalice acquired!";
		Mass 0;
	}
	States {
		Spawn:
			RELB A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

//my own version of degnin ore, mostly stock the only difference is that it is custom Inventory
class wosDegninOre : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Degnin Ore"
		
		+SOLID		
		+SHOOTABLE
		+NOBLOOD
		+FLOORCLIP
		+INCOMBAT
		+INVENTORY.INVBAR
		
		Tag "Degnin Ore";
		Health 10;
		//Radius 16;
		//Height 16;
		DeathSound "ore/explode";
		//Inventory.Amount 1;
		//Inventory.MaxAmount 20;
		//inventory.interhubamount 20;
		Inventory.Icon "I_DGOR";
		Inventory.PickupMessage "You picked up the Degnin Ore.";
		Mass wosDegninOreWeight;
	}
	
	States {
		Spawn:
			DGOR A -1;
			Stop;
		Death:
			DGOR A 1 A_RemoveForceField();
			BNG3 A 0 A_SetTranslucent(1, 1);
			BNG3 A 0 A_Scream();
			BNG3 A 3 Bright A_Explode(192, 192, 1, 1);
			BNG3 BCDEFGH 3 Bright;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}
// chemical ore 
class wosq_chemicalOre : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Copper Sulfate Ore"
		+SOLID
		+INVENTORY.INVBAR

		Tag "Copper Sulfate Ore";
		Inventory.Icon "I_CHOR";
		Inventory.PickupMessage "You picked up the Coppar Sulfate Ore.";
		Mass wosq_chemicalOreWeight;
	}
	States {
		Spawn:
			CHOR A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_chemicalSolution : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Chemical Solution"
		+SOLID
		+INVENTORY.INVBAR

		Tag "Chemical Solution";
		Inventory.Icon "I_CHSL";
		Inventory.PickupMessage "You picked up the Copper Sulfate Ore.";
		Mass wosq_chemicalSolutionWeight;
	}
	States {
		Spawn:
			CHSL A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_rottenWater : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "rotten water"
		+SOLID
		+INVENTORY.INVBAR

		Tag "Rotten Water";
		Inventory.Icon "I_RTWT";
		Inventory.PickupMessage "You picked up the Coppar Sulfate Ore.";
		Mass wosq_rottenWaterWeight;
	}
	States {
		Spawn:
			RTWT A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}

class millPortTransportTicket : travelTicket {
	Default {
		//$Category "Quest things/WoS"
		//$Title "millport travel ticket"
		
		Tag "Millport Travel Ticket";
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  deprecated&&unused stuff  //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*class wosi_implant_accuracy : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Accuracy Implant"
				
		+INVENTORY.INVBAR
		Tag "Accuracy Implant";
		Inventory.Icon "I_UPAC";
		Inventory.Amount 1;
		Inventory.MaxAmount 10;
		Inventory.InterHubAmount 10;		
		Inventory.PickupMessage "Accuracy Implant Acquired!";
		Inventory.PickupSound "misc/p_pkup";
		Mass 0;
	}
	States {
		Spawn:
			UPAC A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosi_implant_stamina : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "Stamina Implant"
				
		+INVENTORY.INVBAR
		Tag "Stamina Implant";
		Inventory.Icon "I_UPST";
		Inventory.Amount 1;
		Inventory.MaxAmount 10;
		Inventory.InterHubAmount 10;		
		Inventory.PickupMessage "Stamina Implant Acquired!";
		Inventory.PickupSound "misc/p_pkup";
		Mass 0;
	}
	States {
		Spawn:
			UPST A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}*/

/*
class flatCoin : coin replaces coin {
	Default {
		+FLATSPRITE
	}
	States {
		Spawn:
			ZCON A -1;
			Stop;
	}
}

class modelCoin : coin replaces coin {
	States {
		
	}
}
*/
//energy cell >> to power powerups
//==---------------------------------------------------
/*
class EnergyCell : CustomInventory
{
	Default
	{
		//$Category "Ammunition"
		//$Color 5
		//$Title "energy Cell"
				
		+Inventory.invbar
		+Inventory.AlwaysPickup
		-SOLID
		+SHOOTABLE
		+NODAMAGE
		+NOBLOOD
		+CANPASS
		+NOGRAVITY
		
		Tag "Battery Cell";
		Inventory.PickupMessage "$ENERGCELLFND";
		Inventory.PickupSound "misc/i_pkup";
		inventory.amount 1;
		inventory.maxamount 999;
		inventory.interhubamount 999;
		inventory.icon "I_ENCL";	
		
		height 24;
		radius 8;
		scale 0.5;		
	}
	
	States
	{
		Spawn:
			ENCL AB 8;
			loop;		
		Use:
			TNT1 A -1;
			Stop;
	}
}
*/
//==---------------------------------------------------
/*
class shoulderLamp : CustomInventory
{
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Shoulder Lamp"
		
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		radius 6;
		height 16;
		scale 0.5;
		
		Tag "Shoulder Lamp";
		inventory.icon "I_SHLM";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
	}
	
	States
	{
		Spawn:
			SHLM P -1;
			Stop;
		Use:
			TNT1 A 0
			{
				ACS_NamedExecute("toggleFlashlight", 0);
				A_GiveInventory("shoulderLamp",1);
			}
			Stop;
	}
}
*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////