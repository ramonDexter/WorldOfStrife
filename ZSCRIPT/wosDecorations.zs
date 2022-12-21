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

// dune movie inspired floating light object - active&static ///////////////////
class wosD_luminorb : actor {
	Default {
		//$category "Decorations/WoS"
		//$Title "luminorb static"
		+SOLID
		+NOGRAVITY
		+NOTARGET
		+NEVERTARGET
		Radius 4;
		Height 8;
	}
	States {
		Spawn:
			DUMM A 1 bright light("luminorbLight");
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






