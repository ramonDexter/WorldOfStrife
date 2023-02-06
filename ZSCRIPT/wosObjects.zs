////////////////////////////////////////////////////////////////////////////////
// advanced decorations definition file ////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// hl2 combine binoculars decoration ///////////////////////////////////////////
class wosD_hl2_combineBinocular : actor {
	bool ticked;
	override void Tick(void) {
		if (!ticked) {
			Super.Tick();
			ticked = true;
		}
	}
	Default {
		//$category "Decorations/WoS"
		//$Title "combine binocular"
		+SOLID
		+NOGRAVITY
		radius 8;
		height 48;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_hl2_combineBinocular2 : actor {
	bool ticked;
	override void Tick(void) {
		if (!ticked) {
			Super.Tick();
			ticked = true;
		}
	}
	Default {
		//$category "Decorations/WoS"
		//$Title "combine binocular 2"
		+SOLID
		+NOGRAVITY
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


// health charger //////////////////////////////////////////////////////////////
class wos_healthCharger : actor {
	bool drained;
	int timer;
	override bool Used(actor user) {
		let pawn = binderPlayer(user);
		if ( !drained ) {
			if ( pawn.health < pawn.GetMaxHealth(true) ) {
				pawn.A_StartSound("sounds/healthCharger", CHAN_AUTO);
				wosEventHandler.SendNetworkEvent("heal_Player");
				pawn.A_Log("$TXT_healthCharger_used");
				drained = true;
			} else {
				pawn.A_Log("$TXT_healthCharger_nouse");
			}
		} else {
			pawn.A_StartSound("sounds/healthChargerNo", CHAN_AUTO);
			pawn.A_Log("$TXT_healthCharger_drained");
		}		
		return Super.Used(user);
	}
	override void Tick() {
		timer++;
		if( timer == 10500 ) { //10500 ticks ==  5 minutes
			timer = 0;
			drained = false;
		}
		Super.Tick();
	}
	Default {
		//$Category "Decorations/WoS"
		//$Title "cmbn health charger active"
		Tag "firstaid station";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// dune movie inspired floating light object - active&static ///////////////////
class wosD_luminorb : actor {
	bool ticked;
	override void Tick(void) {
		if (!ticked) {
			Super.Tick();
			ticked = true;
		}
	}
	Default {
		//$category "Decorations/WoS"
		//$Title "luminorb static"
		+SOLID
		+NOGRAVITY
		+NOTARGET
		+NEVERTARGET
		Tag "luminorb";
		Radius 4;
		Height 8;
	}
	States {
		Spawn:
			DUMM A -1 bright light("luminorbLight");
			Stop;
	}
}
class wosD_luminorb2 : actor {
	Default {
		//$category "Decorations/WoS"
		//$Title "luminorb active"
		+SOLID
		+NOGRAVITY
		+NOTARGET
		+NEVERTARGET
		Tag "luminorb";
		Monster;
		Speed 0.5;
		Health 9999999;
		Radius 4;
		Height 8;
	}
	States {
		Spawn:
			DUMM A 1 bright light("luminorbLight") A_Wander() ;
			Loop;
		See:
			DUMM A 1 bright light("luminorbLight") A_Wander() ;
			Loop;
		Melee:
			goto Spawn;
		Missile:
			goto Spawn;
		Pain:
			goto Spawn;
		Death:
			goto Spawn;
	}
}
////////////////////////////////////////////////////////////////////////////////

// ascension palms /////////////////////////////////////////////////////////////
class wosD_asc_Palm01 : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 01"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
class wosD_asc_Palm02b : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 02b"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
class wosD_asc_Palm04 : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 04"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
class wosD_asc_Palm05 : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 05"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
class wosD_asc_Palm07 : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 07"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
class wosD_asc_Palm08 : wosOptDeco2_base {
	Default {
		//$Category "Trees and Rocks/NatureTree/"
		//$Title "palm 08"
		+SOLID
		Tag "Palm Tree";
		Height 128;
		Radius 8;
	}
}
////////////////////////////////////////////////////////////////////////////////

// ascension props /////////////////////////////////////////////////////////////
class wosD_asc_angelStatue : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "angel statue"
		Tag "angel statue";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_athenaStatue : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "athena statue"
		Tag "lady statue";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_beeStatue : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "bee statue"
		Tag "bee statue";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_dibellaStatue : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "dibella statue"
		Tag "dibella statue";
		radius 16;
		height 112;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_elkHead : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "elk head deco"
		Tag "elk head";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_lionStatue : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "lion statue"
		Tag "lion statue";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_waterput : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "waterput"
		Tag "waterput";
		radius 8;
		height 24;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

class wosD_hereticalRelic : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "heretical relic deco"
		Tag "$t_hereticalRelic";
		radius 8;
		height 40;
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		+DONTTHRUST;
	}
	States {
		Spawn:
			HRLC V -1;
			Stop;
	}
}


