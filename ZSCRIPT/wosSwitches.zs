class wos_switch_telep : switchableDecoration {
	Default {
		//$category "voxel switches"
		//$Title "telep1"
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		Tag "lever";
		//scale 0.75;
		Radius 8;
		height 32;
		Activation THINGSPEC_Switch;
	}
	States {
		Spawn:
			TLP1 A -1;
			Stop;
		Active:
			TLP1 A 6;
			TNT1 A 0 A_StartSound("switches/knob");
			TLP1 B -1 Bright;
			Stop;
		Inactive:
			TLP1 B 6 Bright;
			TNT1 A 0 A_StartSound("switches/knob");
			TLP1 A -1;
			Stop;
	}
}
class wos_switch_button1 : switchableDecoration {
    Default {
        //$category "voxel switches"
		//$Title "button1"
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		Tag "button";
		//scale 0.75;
		Radius 8;
		height 32;
		Activation THINGSPEC_Switch;
    }
    States {
        Spawn:
            BTN1 A -1;
            Stop;
        Active:
            BTN1 A 6;
            BTN1 B -1;
            Stop;
        Inactive:
            BTN1 B 6;
            BTN1 A -1;
            Stop;
    }
}
class wos_switch_doorKnob : switchableDecoration {
    Default {
        //$category "voxel switches"
		//$Title "doorKnob"
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		Tag "knob";
		//scale 0.75;
		Radius 8;
		height 32;
		Activation THINGSPEC_Switch;
    }
    States {
        Spawn:
            DNOB A -1;
            Stop;
        Active:
            DNOB A 6;
            DNOB B -1;
            Stop;
        Inactive:
            DNOB B 6;
            DNOB A -1;
            Stop;
    }
}
class wos_switch_lever3 : switchableDecoration {
    Default {
        //$category "voxel switches"
		//$Title "lever3"
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		Tag "knob";
		//scale 0.75;
		Radius 8;
		height 32;
		Activation THINGSPEC_Switch;
    }
    States {
        Spawn:
            LVR3 A -1;
            Stop;
        Active:
            LVR3 A 6;
            LVR3 B -1;
            Stop;
        Inactive:
            LVR3 B 6;
            LVR3 A -1;
            Stop;
    }
}
class wos_switch_slider : switchableDecoration {
    Default {
        //$category "voxel switches"
		//$Title "slider"
		+SOLID;
		+USESPECIAL;
		+NOGRAVITY;
		Tag "knob";
		//scale 0.75;
		Radius 8;
		height 32;
		Activation THINGSPEC_Switch;
    }
    States {
        Spawn:
            SLD1 A -1;
            Stop;
        Active:
            SLD1 A 6;
            SLD1 B -1;
            Stop;
        Inactive:
            SLD1 B 6;
            SLD1 A -1;
            Stop;
    }
}