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
		radius 24;
		height 96;
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

// heretical relic decoration //////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////

// hexen suit of armor destructible decoration /////////////////////////////////
class wosD_suitOfArmor : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "hexen suit of armor decoration"
		Tag "suit of armor";
		Height 72;
		Radius 16;
		Health 60;
		Mass 0x7fffffff;
		DeathSound "sounds/SuitofArmorBreak";
	}
	States {
		Spawn:
			WDAS A -1;
			Stop;
		Death:
			WDAS A 1 W_decoArmorExplode();
			Stop;
	}
	// action //
	void W_decoArmorExplode() {
		for ( int i = 0; i < 10; i++ ) {
			double xOff = ( random[decoArmorExplode]() - 128 ) / 16.;
			double yOff = ( random[decoArmorExplode]() - 128 ) / 16.;
			double zOff = random[decoArmorExplode]() * Height / 256.;
			actor mo = spawn("wosD_suitOfArmor_chunk", vec3Offset(xOff, yOff, zOff), ALLOW_REPLACE);
			if( mo ) {
				mo.setState(mo.SpawnState + i);
				mo.vel.X = random[decoArmorExplode]() / 64.;
				mo.vel.Y = random[decoArmorExplode]() / 64.;
				mo.vel.Z = ( random[decoArmorExplode]() & 7 ) + 5;
			}
		}
		//
		A_StartSound(DeathSound, CHAN_BODY);
		Destroy();
	}
}
class wosD_suitOfArmor_chunk : actor {
	Default {
		Radius 4;
		Height 8;
		Tag "chunk of armor";
	}
	States {
		Spawn:
			WDAS B -1;
			Stop;
			WDAS C -1;
			Stop;
			WDAS D -1;
			Stop;
			WDAS E -1;
			Stop;
			WDAS F -1;
			Stop;
			WDAS G -1;
			Stop;
			WDAS H -1;
			Stop;
			WDAS I -1;
			Stop;
			WDAS J -1;
			Stop;
			WDAS K -1;
			Stop;
	}
}

// ascension skeletons /////////////////////////////////////////////////////////
class wosD_asc_skeleton01 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 01 (leaned back)"
		Tag "skeleton";
		Radius 8;
		Height 28;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeleton02 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 02 (sitting)"
		Tag "skeleton";
		Radius 8;
		Height 28;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeleton03 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 03 (on back)"
		Tag "skeleton";
		Radius 16;
		Height 8;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeleton04 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 04 (hanged)"
		Tag "skeleton";
		Radius 8;
		Height 64;
		+NOGRAVITY;
		+SOLID;
		+USESPECIAL;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeleton05 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 05 (hanged 180)"
		Tag "skeleton";
		Radius 8;
		Height 64;
		+NOGRAVITY;
		+SOLID;
		+USESPECIAL;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeleton06 : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton 06 (sitting child)"
		Tag "skeleton";
		Radius 8;
		Height 20;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class wosD_asc_skeletonCaged : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "skeleton caged"
		Tag "skeleton";
		Radius 16;
		Height 52;
		+NOGRAVITY;
		+SOLID;
		+USESPECIAL;
		+DONTTHRUST;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

class wosD_kneelingGuyNoSound : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "kneeling guy (no sound, static)"
		Radius 6;
  		Height 17;
		+SOLID;
		+NOBLOOD;
		+USESPECIAL;
		+DONTTHRUST;
	}
	States {
		Spawn:
			NEAL A 15;
			NEAL B 40;
			Loop;
	}
}



////////////////////////////////////////////////////////////////////////////////