class HayRoll : Actor {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "Hay rolled"
		tag "hay rolled";
		Radius 20;
		Height 40;
		+SOLID;
	}
	States {
		Spawn:
		 	DUMM A -1;
		 	Stop;
	}
}
class HayRoll2 : Actor {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "Hay rolled stackable"
		tag "hay rolled";
		Radius 20;
		Height 40;
		+SOLID;
		+NOGRAVITY;
		+ACTLIKEBRIDGE;
	}
	States {
		Spawn:
		 	DUMM A -1;
		 	Stop;
	}
}

class HayCube : Actor {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "Hay cube"
		tag "hay cube";
		Radius 20;
		Height 32;
		+SOLID;
		+CANPASS;
		+ACTLIKEBRIDGE;
		+FLOORCLIP;
		+SHOOTABLE;
		+NOBLOOD;
	}
	States {
		Spawn:
		 	DUMM A -1;
		 	Stop;
	}
}

// by NeoWorm
class Cart01 : Actor {
	Default {
		tag "wooden cart";
		Radius 32;
		Height 48;
		Mass 800;
		+SOLID;
		+ACTLIKEBRIDGE;
		//Health 600;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Cart square 64"
	}

    States {
		Spawn:
			DUMM A -1;
			Stop;
    }
}

// by NeoWorm
class Cart02 : Actor {
	Default {
		tag "wooden cart";
		Radius 32;
		Height 32;
		Mass 800;
		//Health 600;
		+SOLID;
		+ACTLIKEBRIDGE;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Cart square 64 alternative
	}

    States {
		Spawn:
			DUMM A -1;
			Stop;
    }
}

// by NeoWorm
class Cart03 : Actor {
	Default {
		tag "gypsy cart";
		Radius 32;
		Height 96;
		Mass 800;
		+SOLID;
		//Health 900;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Gypsy Cart"
	}

    States {
		Spawn:
			DUMM A -1;
			Stop;
    }
}

class Table01 : Actor {
	Default {
		Tag "wooden table";
		Radius 32;
		Height 24;
		Mass 400;
		Friction 0.8;
		//Health 120;
		+SOLID;
		+PUSHABLE;
		+DROPOFF;
		+SLIDESONWALLS;
		+CANPASS;
		+ACTLIKEBRIDGE;
		+FLOORCLIP;
		//+SHOOTABLE;
		+NOBLOOD;
		PushFactor 0.2;
		//$Category "Decorations/WoS/furniture/"
		//$Title "Table square 64"
	}

    States {
		Spawn:
			DUMM A -1;
			Stop;
    }
}

class Table03 : Table01 {
	Default {
		Tag "decorated table";
		Radius 32;
		Height 24;
		Mass 800;
		//Health 600;
		//$Category "Decorations/WoS/furniture/"
		//$Title "Table square 64 decorative"
	}

    States {
		Spawn:
			DUMM A -1;
			Stop;
    }
}

// by NeoWorm
// textures by Raven software
class Box01 : Actor {
	Default {
		Tag "wooden box big";
		Radius 32;
		Height 64;
		Mass 35;
		//Friction 0.8;
		//Health 200;
		+SOLID
		+PUSHABLE
		+DROPOFF
		+SLIDESONWALLS
		+CANPASS
		+ACTLIKEBRIDGE
		+FLOORCLIP;
		//+SHOOTABLE;
		+NOBLOOD;
		PushFactor 0.1;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Box big 1"
	}
	
    States {
		Spawn:
			/*TNT1 A 0 {
				if ( vel.x > 2 || vel.x < -2 || vel.y > 2 || vel.y < -2 ) {
					return resolveState("Grind");
				}
				return resolveState(null);
			}*/
			DUMM A 0 A_JumpIf(vel.x > 0.1, "Grind");
			DUMM A 0 A_JumpIf(vel.x < -0.1, "Grind");
			DUMM A 0 A_JumpIf(vel.y < -0.1, "Grind");
			DUMM A 1 A_JumpIf(vel.y > 0.1, "Grind");
			Loop;
		Grind:
			//DUMM A 1 A_Playsound ("Grind",0|4096,1.2);
			DUMM A 1 A_StartSound ("Grind", CHAN_BODY, CHANF_NOSTOP, 1.0, 2);
			goto Spawn;

		/*		
		Death:
			BOX1 A 0 A_Burst("WoodenBit");
			Stop;*/
    }
}

class Box02 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "Box big 2"
	}
	/*States {
		Spawn:
			//DUMM A -1;
			//Stop;
			DUMM A 0 A_JumpIf(vel.x > 1, "Grind");
			DUMM A 0 A_JumpIf(vel.x < -1, "Grind");
			DUMM A 0 A_JumpIf(vel.y < -1, "Grind");
			DUMM A 1 A_JumpIf(vel.y > 1, "Grind");
			Loop;
		Grind:
			DUMM A 1 A_Playsound ("Grind",0|4096,1.2);
			goto Spawn;
    }*/
}

class Box03 : Box01 {
	Default {
		Tag "wooden box low";
		Radius 32;
		Height 32;
		Mass 500;
		Friction 0.8;
		Health 160;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Box low"
	}
	
   /* States {
		Spawn:
			//DUMM A -1;
			//Stop;
			DUMM A 0 A_JumpIf(vel.x > 1, "Grind");
			DUMM A 0 A_JumpIf(vel.x < -1, "Grind");
			DUMM A 0 A_JumpIf(vel.y < -1, "Grind");
			DUMM A 1 A_JumpIf(vel.y > 1, "Grind");
			Loop;
		Grind:
			DUMM A 1 A_Playsound ("Grind",0|4096,1.2);
			goto Spawn;
    }*/
}

class Box04 : Box01 {
	Default {
		Tag "wooden box tall";
		Radius 16;
		Height 64;
		Mass 400;
		Friction 0.8;
		Health 120;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Box small high"
	}
	
    /*States {
		Spawn:
			//DUMM A -1;
			//Stop;
			DUMM A 0 A_JumpIf(vel.x > 1, "Grind");
			DUMM A 0 A_JumpIf(vel.x < -1, "Grind");
			DUMM A 0 A_JumpIf(vel.y < -1, "Grind");
			DUMM A 1 A_JumpIf(vel.y > 1, "Grind");
			Loop;
		Grind:
			DUMM A 1 A_Playsound ("Grind",0|4096,1.2);
			goto Spawn;
    }*/
}

class Box05 : Box01
{
	Default
	{
		Tag "wooden box small";
		Radius 16;
		Height 32;
		Mass 300;
		Friction 0.8;
		Health 100;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Box small"
	}
	
    /*States {
		Spawn:
			//DUMM A -1;
			//Stop;
			DUMM A 0 A_JumpIf(vel.x > 1, "Grind");
			DUMM A 0 A_JumpIf(vel.x < -1, "Grind");
			DUMM A 0 A_JumpIf(vel.y < -1, "Grind");
			DUMM A 1 A_JumpIf(vel.y > 1, "Grind");
			Loop;
		Grind:
			DUMM A 1 A_Playsound ("Grind",0|4096,1.2);
			goto Spawn;
    }*/
}

// by NeoWorm
// needs destructability
class Sack01 : Actor {
	Default {
		Tag "cloth sack";
		Radius 18;
		Height 12;
		+SOLID;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Sack 01"
	}
	States {
		Spawn:
			NSAK A -1;
			Stop;
	}
}

class Sack02 : Sack01 {
	Default {
		Radius 18;
		Height 24;
		//$Category "Decorations/WoS/neoworm"
		//$Title "Sack 02"
	}
	States {
		Spawn:
			NSAK B -1;
			Stop;
	}
}

class strifeBox01 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox01"
		Tag "strife box big wooden";
		Radius 32;
    	Height 64;
	}
}
class strifeBox02 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox02"
		Tag "strife box big metal";
		Radius 32;
    	Height 64;
	}
}
class strifeBox03 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox03"
		Tag "strife box low metal";
		Radius 32;
    	Height 32;
	}
}
class strifeBox04 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox04"
		Tag "strife box tall wooden";
		Radius 16;
    	Height 64;
	}
}
class strifeBox05 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox05"
		Tag "strife box small wooden";
		Radius 16;
    	Height 32;
	}
}
class strifeBox06 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox06"
		Tag "strife box small metal";
		Radius 16;
    	Height 32;
	}
}
class strifeBox07 : Box01 {
	Default {
		//$Category "Decorations/WoS/neoworm"
		//$Title "strifeBox07"
		Tag "strife box low wooden";
		Radius 32;
    	Height 32;
	}
}