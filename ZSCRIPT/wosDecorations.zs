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

class wosD_luminorb : actor {
    Default {
        //$category "Decorations/WoS"
		//$Title "luminorb"
		+SOLID
		+NOGRAVITY
		radius 4;
		height 8;
    }
    States {
        Spawn:
            DUMM A -1 bright light("luminorbLight");
            Stop;
    }
}