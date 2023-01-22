////////////////////////////////////////////////////////////////////////////////
//  WoS items main definition  /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  item weights  //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// basic max carry capacity: 2200 ... 22 kg
// 100 .. 1 kg
// 50 .. 0.5 kg
// 1 .. 0.01 kg
////////////////////////////////////////////////////////////////////////////////

// ammo ////////////////////////////////////////////////////////////////////////
const elBoltsQwWeight = 24;
const posBoltsQwWeight = 12;
const elBoltsBndlWeight = 10;
const posBoltsBndlWeight = 5;
const energyPodWeight = 3;
const energyKitWeight = 8;
const energyPackWeight = 15;
const boxOfBulletsWeight = 20;
const bulletCartridgeWeight = 5;
const miniMissileBndlWeight = 25;
const heGRboxWeight = 35;
const fireGRboxWeight = 35;
const ammoSatchelWeight = 50;
const ammoBandolierWeight = 50;
const wosEnergyCellWeight = 5;
// armor ///////////////////////////////////////////////////////////////////////
Const LeatherWeight = 125;
Const MetalWeight = 250;
Const BinderBasicWeight = 135;
Const BinderAdvancedWeight = 165;
Const KineticWeight = 140;
// powerups ////////////////////////////////////////////////////////////////////
const armorShardWeight = 5;
const automapWeight = 3;
const wosBinocularWeight = 45;
const blasterTurretWeight = 135;
const DeployableShieldWeight = 95;
const envSuitWeight = 120;
const FlameTurretWeight = 150;
const FlareWeight = 1;
const FlareBoxWeight = 15;
const grenadeExplosiveWeight = 7;
const grenadeFireWeight = 9;
const grenadeGasWeight = 8;
const interceptorDroneWeight = 35;
const NightEyeDeviceWeight = 35;
const rebreatherWeight = 50;
const regenModuleWeight = 45;
const shadowArmorWeight = 95;
const StealthBoyWeight = 85;
const swarmersWeight = 13;
const targeterWeight = 25;
const quickTravelWeight = 45;
const landMineWeight = 12;
// shouldergun /////////////////////////////////////////////////////////////////
const shoulderGunWeight = 75;
const shoulderGunMagWeight = 1;
const shoulderGun_chargerWeight = 35;
// medicals ////////////////////////////////////////////////////////////////////
const hyposprejWeight = 1;
const kombopackWeight = 2;
const instalekWeight = 3;
const medpatchWeight = 2;
const medicalkitWeight = 7;
const surgerykitWeight = 12;
const wosStimDeviceWeight = 2;
// food ////////////////////////////////////////////////////////////////////////
const BottleWeight = 5;
const burgerweight = 3;
const cheeseBurgerWeight = 4;
const bigBurgerWeight = 5;
const dblCheeBWeight = 5;
const hotdogWeight = 4;
const donutsWeight = 4;
const foodBoxWeight = 5;
const foodRationWeight = 10;
const grilledChickenWeight = 10;
const wosVegieWeight = 1;
const wosfbMeat1Weight = 2;
const wosfbMeat2Weight = 1;
const wosfbMeat3Weight = 1;
const wosSoyFoodWeight = 2;
const wosSodaCanWeight = 3;
const wosCandyBarWeight = 1;
// quest items /////////////////////////////////////////////////////////////////
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
const woq_toolsWeight = 85;
const wosq_sparepartsWeight = 65;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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
	
	action void W_foodHeal(int healAmount) {
		if (player == null) {
			return;
		}
		let pawn = binderPlayer(self);
		pawn.GiveBody(healAmount, 0);
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

////////////////////////////////////////////////////////////////////////////////
// upgrade implants ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// health regeneration implant /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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
				if ( pawn.health < pawn.GetMaxHealth(true) ) { 
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
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// full stamina implant ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class implant_stamina : CustomInventory {
	override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.staminaImplant = true;
    }
	Default {
		-INVENTORY.INVBAR;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;
		+INVENTORY.UNCLEARABLE;
		tag "Stamina Implant";
		inventory.icon "I_STRG";
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
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// mind upgrade ////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
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
			
		+CountItem;
		+Inventory.invbar;
		+Inventory.AlwaysPickup;
		+INVENTORY.UNDROPPABLE;
		-SOLID;
		+SHOOTABLE;
		+NODAMAGE;
		+NOBLOOD;
		+CANPASS;		
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
		
		+INVENTORY.INVBAR;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNTOSSABLE;	
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

////////////////////////////////////////////////////////////////////////////////
//  goldcoin  //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class goldCoin : Inventory {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coin"
		+DROPPED;
		+NOTDMATCH;
		+FLOORCLIP;
		+INVENTORY.INVBAR;
		Inventory.MaxAmount 10000;
		Tag "$TAG_goldCOIN";
		Inventory.Icon "I_COIN";
		Inventory.PickupMessage "$TXT_goldCOIN";
		//Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
		
	}
	States {
		Spawn:
			COIN A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosGold10 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (10)"
		-INVENTORY.INVBAR;
		//Inventory.Amount 10
		Tag "$TAG_10GOLDcoins"; // "10 gold"
		Inventory.PickupMessage "$TXT_10GOLDcoins"; // "You picked up 10 gold."
		//Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			CRED A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("Coin", 10);
			Stop;
	}
}
class wosGold25 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (25)"
		-INVENTORY.INVBAR;
		Tag "$TAG_25GOLDcoins";
		Inventory.PickupMessage "$TXT_25GOLDcoins";
		//Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			SACK A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("Coin", 25);
			Stop;
	}
}
class wosGold50 : wosPickup {
	Default {
        //$Category "Quest things/WoS"
		//$Title "gold coins (50)"
		-INVENTORY.INVBAR;
		Tag "$TAG_50GOLDcoins";
		Inventory.PickupMessage "$TXT_50GOLDcoins";
		//Inventory.pickupSound "sounds/coinPickup";
		Mass 0;
		radius 8;
	}
	States {
		Spawn:
			CHST A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_GiveInventory("Coin", 50);
			Stop;
	}
}
//  gold chest  ////////////////////////////////////////////////////////////////
//  50  ////////////////////////////////////////////////////////////////////////
class goldChest50_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with gold coins (50)"
		
		+INVENTORY.INVBAR;
		
		Tag "$TAG_goldChest_item"; // "Chest with coins"
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "$TXT_goldChest_item"; // "You picked up the Chest with coins."
		//Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest50Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("Coin", 50);
            }
            Stop;
    }
}
//  100  ///////////////////////////////////////////////////////////////////////
class goldChest100_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with gold coins (100)"
		
		+INVENTORY.INVBAR;
		
		Tag "$TAG_goldChest_item"; // "Chest with coins"
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "$TXT_goldChest_item"; // "You picked up the Chest with coins."
		//Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest100Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("Coin", 100);
            }
            Stop;
    }
}
//  250  ///////////////////////////////////////////////////////////////////////
class goldChest250_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with gold coins (250)"
		
		+INVENTORY.INVBAR;
		
		Tag "$TAG_goldChest_item"; // "Chest with coins"
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "$TXT_goldChest_item"; // "You picked up the Chest with coins."
		//Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest250Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("Coin", 250);
            }
            Stop;
    }
}
//  500  ///////////////////////////////////////////////////////////////////////
class goldChest500_item : wosPickup {
    Default {
        //$Category "Quest things/WoS"
		//$Title "Chest with gold coins (500)"
		
		+INVENTORY.INVBAR;
		
		Tag "$TAG_goldChest_item"; // "Chest with coins"
		Inventory.Icon "I_GCHT";
		Inventory.PickupMessage "$TXT_goldChest_item"; // "You picked up the Chest with coins."
		//Inventory.pickupSound "sounds/coinPickup";
		Inventory.useSound "sounds/coinPickup";
		Mass gChest500Weight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("Coin", 500);
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



class travelTicket : CustomInventory {
	Default {			
		//$Category "Quest things/WoS"
		//$Title "Travel Ticket"
		
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		
		Tag "$t_travelTicket";//"Transportation Ticket";
		Inventory.Icon "I_TRTK";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_travelTicket";//"You picked up the Transportation Ticket!";
		Inventory.PickupSound "misc/i_pkup";
		Mass 0;
	}	
	States {
		Spawn:
			TRTK A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	
	}
}

class millPortTransportTicket : travelTicket {
	Default {
		//$Category "Quest things/WoS"
		//$Title "millport travel ticket"
		
		Tag "$t_millPortTransportTicket";//"Millport Travel Ticket";
	}
}

class powerPlant_powerCoupling : CustomInventory {
	Default {			
		//$Category "Quest things/WoS"
		//$Title "Power Coupling (wos)"
		
		+inventory.invbar
		
		Tag "$t_powerPlant_powerCoupling";//"Power Coupling";
		inventory.icon "I_PCOP";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}	
	States {
		Spawn:
			COUP AB 5;
			Loop;
		Use:
			TNT1 A 0;
			Stop;
	}
}

class hereticDatapad1 : CustomInventory {
	Default {			
		//$Category "Quest things/WoS"
		//$Title "Heretic Datapad #1"
		
		+INVENTORY.INVBAR
		
		Tag "$t_hereticDatapad1";//"Heretic Datapad 1";
		inventory.icon "I_HDPD";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}	
	States {
		Spawn:
			HDPD A -1;
			Stop;
		Use:
			TNT1 A 0;
			Stop;
	}
}



class caseInformationDisk : CustomInventory {
	Default {			
		//$Category "Quest things/WoS"
		//$Title "Lost artifact information disk"
		
		+INVENTORY.INVBAR
		
		Tag "$t_caseInformationDisk";//"Lost artifact information disk";
		inventory.icon "I_HDPD";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}	
	States {
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
	
		Tag "$t_leaderskull";//"Heretic Captain Skull";
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_HCSK";
		Inventory.PickupMessage "$p_leaderskull";//"Heretic Captain skull acquired!";
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
		
		Tag "$t_cityBathMurder_Detonator";//"Detonator";
		Inventory.Icon "I_DTNT";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_cityBathMurder_Detonator";//"You picked up the Detonator!";
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
		Tag "$t_hereticalRelic";//"Heretical Relic";
		Inventory.Icon "I_HRLC";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_hereticalRelic";//"You picked up the Heretical Relic!";
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
		Tag "$t_infoDisk";//"Data Disk";
		Inventory.Icon "I_DDSB";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_infoDisk";//"You picked up the Data Disk!";
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
		Tag "$t_q_explosiveDevice_01";//"Explosive Device";
		Inventory.Icon "I_QBMB";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_q_explosiveDevice_01";//"You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			TNT1 A 0 {
				let pawn = binderPlayer(self);
				let iterator = Level.CreateSectorTagIterator(6090);
				int index;
				while ( (index = iterator.Next()) > -1 ) {
					if ( pawn.CurSector && pawn.CurSector.Index() == index ) {
						return resolveState("UseYes");
					} else {
						return resolveState("UseNot");
					}
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near the wall to heretic base only! ]");
			Fail;
		UseYes:
			TNT1 A 0 {
				A_SpawnItemEx("q_bomb_01", 16, 0, 0);
				A_Log("\c[red][ Bomb planted. RUN AWAY!!! ]");
			}
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
			MS01 A 35 A_Log("\c[red][ = 5 = ]");
			MS01 A 35 A_Log("\c[red][ = 4 = ]");
			MS01 A 35 A_Log("\c[red][ = 3 = ]");
			MS01 A 35 A_Log("\c[red][ = 2 = ]");
			MS01 A 35 A_Log("\c[red][ = 1 = ]");
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecuteAlways("m06_lowerWall", 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}

// queen1 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen1 : CustomInventory {
	
	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#1"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "$t_wosq_dynamite_queen1";//"Explosive Device #1";
		Inventory.Icon "I_QB01";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_wosq_dynamite_queen";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			TNT1 A 0 {				
				let pawn = binderPlayer(self);
				let iterator = Level.CreateSectorTagIterator(100101); //tag sectoru s vchodem do hnizda
				int index;
				while ( (index = iterator.Next()) > -1 ) {
					if ( pawn.CurSector && pawn.CurSector.Index() == index ) {
						return resolveState("UseYes");
					} else {
						return resolveState("UseNot");
					}
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#1 only! ]");
			Fail;
		UseYes:
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
			//MS01 A 175;0
			MS01 A 35 A_Log("\c[red][ = 5 = ]");
			MS01 A 35 A_Log("\c[red][ = 4 = ]");
			MS01 A 35 A_Log("\c[red][ = 3 = ]");
			MS01 A 35 A_Log("\c[red][ = 2 = ]");
			MS01 A 35 A_Log("\c[red][ = 1 = ]");
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("exlosionFireBig", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen1_blowWall", 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
// queen2 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen2 : CustomInventory {
	
	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#2"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "$t_wosq_dynamite_queen2";//"Explosive Device #2";
		Inventory.Icon "I_QB02";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_wosq_dynamite_queen";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			TNT1 A 0 {				
				let pawn = binderPlayer(self);
				let iterator = Level.CreateSectorTagIterator(100102); //tag sektoru s vchodem do hnizda
				int index;
				while ( (index = iterator.Next()) > -1 ) {
					if ( pawn.CurSector && pawn.CurSector.Index() == index ) {
						return resolveState("UseYes");
					} else {
						return resolveState("UseNot");
					}
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#2 only! ]");
			Fail;
		UseYes:
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
			//MS01 A 175;
			MS01 A 35 A_Log("\c[red][ = 5 = ]");
			MS01 A 35 A_Log("\c[red][ = 4 = ]");
			MS01 A 35 A_Log("\c[red][ = 3 = ]");
			MS01 A 35 A_Log("\c[red][ = 2 = ]");
			MS01 A 35 A_Log("\c[red][ = 1 = ]");
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("exlosionFireBig", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen2_blowWall", 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
// queen3 cave /////////////////////////////////////////////////////////////////
class wosq_dynamite_queen3 : CustomInventory {
	Default {
		//$Category "Quest things/WoS"
		//$Title "explosive device#3"
		+INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "$t_wosq_dynamite_queen3";//"Explosive Device #3";
		Inventory.Icon "I_QB03";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$p_wosq_dynamite_queen";//"You picked up the Explosive Device!";
		Inventory.PickupSound "misc/i_pkup";
		height 32;
		Mass 0;
	}
	States {
		Spawn:
			MS01 A -1;
			Stop;
		Use:
			TNT1 A 0 {				
				let pawn = binderPlayer(self);
				let iterator = Level.CreateSectorTagIterator(100103); //tag sektoru s vchodem do hnizda
				int index;
				while ( (index = iterator.Next()) > -1 ) {
					if ( pawn.CurSector && pawn.CurSector.Index() == index ) {
						return resolveState("UseYes");
					} else {
						return resolveState("UseNot");
					}
				}
				return resolveState(null);
			}
		UseNot:
			TNT1 A 0 A_Log("\c[red][ This bomb could be used near nest#3 only! ]");
			Fail;
		UseYes:
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
			//MS01 A 175;
			MS01 A 35 A_Log("\c[red][ = 5 = ]");
			MS01 A 35 A_Log("\c[red][ = 4 = ]");
			MS01 A 35 A_Log("\c[red][ = 3 = ]");
			MS01 A 35 A_Log("\c[red][ = 2 = ]");
			MS01 A 35 A_Log("\c[red][ = 1 = ]");
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("exlosionFireBig", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 A 0 ACS_NamedExecute("m14_queen3_blowWall", 0);
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
		
		Tag "$t_hereticLeaderSkull";//Heretic Leader Skull
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_HCSK";
		Inventory.PickupMessage "$p_hereticLeaderSkull";//Heretic Leader skull acquired!
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
		
		Tag "$t_blueChalice";//Blue Offering Chalice
		Radius 4;
		Height 18;
		
		inventory.amount 1;
		Inventory.MaxAmount 1;
		inventory.interhubamount 1;
		Inventory.Icon "I_RELB";
		Inventory.PickupMessage "$p_blueChalice";//Blue Offering Chalice acquired!
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
		
		Tag "$t_wosDegninOre";//"Degnin Ore";
		Health 10;
		//Radius 16;
		//Height 16;
		DeathSound "ore/explode";
		//Inventory.Amount 1;
		//Inventory.MaxAmount 20;
		//inventory.interhubamount 20;
		Inventory.Icon "I_DGOR";
		Inventory.PickupMessage "$p_wosDegninOre";//"You picked up the Degnin Ore.";
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

		Tag "$t_wosq_chemicalOre";//"Copper Sulfate Ore";
		Inventory.Icon "I_CHOR";
		Inventory.PickupMessage "$p_wosq_chemicalOre";//"You picked up the Copper Sulfate Ore.";
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

		Tag "$t_wosq_chemicalSolution";//"Chemical Solution";
		Inventory.Icon "I_CHSL";
		Inventory.PickupMessage "$p_wosq_chemicalSolution";//"You picked up the Chemical Solution.";
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

		Tag "$t_wosq_rottenWater";//"Rotten Water";
		Inventory.Icon "I_RTWT";
		Inventory.PickupMessage "$p_wosq_rottenWater";//"You picked up the Rotten Water.";
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
class wosq_fishGuts : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "fish guts"
		+SOLID
		+INVENTORY.INVBAR

		Tag "$t_wosq_fishGuts";//"Fish Guts";
		Inventory.Icon "I_FSGT";
		Inventory.PickupMessage "$p_wosq_fishGuts";//"You picked up the Fish Guts.";
		Mass wosq_rottenWaterWeight;
	}
	States {
		Spawn:
			FSGT A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_ratPoison : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "rat poison"
		+SOLID
		+INVENTORY.INVBAR

		Tag "$t_wosq_ratPoison";//"Rat Poison";
		Inventory.Icon "I_RTPN";
		Inventory.PickupMessage "$p_wosq_ratPoison";//"You picked up the Rat Poison.";
		Mass wosq_rottenWaterWeight;
	}
	States {
		Spawn:
			RTPN A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}

class woq_tools : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "tools"
		+SOLID
		+INVENTORY.INVBAR

		Tag "$t_woq_tools";//"Tools";
		Inventory.Icon "I_QTLS";
		Inventory.PickupMessage "$p_woq_tools";//"You picked up the Tools.";
		Mass woq_toolsWeight;
	}
	States {
		Spawn:
			QTLS A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_spareparts : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "spare parts"
		+SOLID
		+INVENTORY.INVBAR

		Tag "$t_wosq_spareparts";//"Spare Parts";
		Inventory.Icon "I_QSPS";
		Inventory.PickupMessage "$p_wosq_spareparts";//"You picked up the Spare Parts.";
		Mass wosq_sparepartsWeight;
		Scale 0.5;
	}
	States {
		Spawn:
			QSPS A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_judgeofchangeEdict : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "edict"
		-SOLID
		+INVENTORY.INVBAR

		Tag "$t_wosq_judgeofchangeEdict";//"Edict";
		Inventory.Icon "I_QJED";
		Inventory.PickupMessage "$p_wosq_judgeofchangeEdict";//"You picked up the Edict.";
		Mass 0;
		Scale 0.5;
	}
	States {
		Spawn:
			QJED A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosq_judgeOfChangeDevice : wosPickup {
	Default {
		//$Category "Quest things/WoS"
		//$Title "recording device"
		-SOLID
		+INVENTORY.INVBAR

		Tag "$t_wosq_judgeOfChangeDevice";//"Recording Device";
		Inventory.Icon "I_QJRD";
		Inventory.PickupMessage "$p_wosq_judgeOfChangeDevice";//"You picked up the Recording Device.";
		Mass 0;
		Scale 0.5;
	}
	States {
		Spawn:
			QJRD A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
