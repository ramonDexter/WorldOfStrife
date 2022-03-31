////////////////////////////////////////////////////////////////////////////////
// destructible bushes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class dest_ShortBush : ShortBush Replaces ShortBush {
    Default {
        //$Category "Trees and Rocks/WoS"
        //$Title "Short Bush destructible"
        +SOLID
        +SHOOTABLE
        +NOBLOOD
		+DONTTHRUST
        Radius 15;
        Height 40;
        Health 70;
        //DamageFactor "Alarm", 0.0;
        Tag "short bush";
    }
	
	States {
        Spawn:
            BUSH A -1;
            Stop;
        Death:
            TNT1 A 0 A_NoBlocking();
            TNT1 AAA 0 A_SpawnProjectile ("LeafParticle", 20, 0, random (0, 360), 2, random (30, 160));
            TNT1 A 0 A_SpawnProjectile ("BushPiece1", 20, 0, random (0, 360), 2, random (30, 160));
            TNT1 A 0 A_SpawnProjectile ("BushPiece2", 20, 0, random (0, 360), 2, random (30, 160));
			BUSH D -1;
            Stop;
	}
}
class dest_TallBush : dest_ShortBush replaces TallBush {
    Default {
        //$Category "Trees and Rocks/WoS"
        //$Title "Tall Bush destructible"
        Tag "tall bush";
        Radius 20;
        Height 64;
    }
	States {
        Spawn:
            SHRB A -1;
            Stop;
        Death:
            TNT1 A 0 A_NoBlocking();
            TNT1 AAA 0 A_SpawnProjectile ("LeafParticle", 20, 0, random (0, 360), 2, random (30, 160));
            TNT1 A 0 A_SpawnProjectile ("BushPiece1", 20, 0, random (0, 360), 2, random (30, 160));
            TNT1 A 0 A_SpawnProjectile ("BushPiece2", 20, 0, random (0, 360), 2, random (30, 160));
			SHRB D -1;
            Stop;
	}
}

class XJunk1: actor {
    Default {
        +NOBLOCKMAP
        //+MISSILE
        +NOTELEPORT
        //+MOVEWITHSECTOR
        //+RIPPER
        +BLOODLESSIMPACT 
        +CLIENTSIDEONLY
        +DONTSPLASH
        +DOOMBOUNCE
        BounceFactor 0.5;
        Speed 14;
        Gravity 0.8;
        DeathSound "none";
        SeeSound "none";
        Decal "None";
        Scale 1.0;
    }
    
    States {
        Spawn:
            //TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
            JNK6 ABCD 3;
            //Loop;
        Death:
            JNK6 A 4;
            Stop;
        Splash:
            TNT1 A 1;
            JNK6 A -1;
            Stop;
    }
}
class BushPiece1: XJunk1 {
    Default {
        //+DOOMBOUNCE
        Speed 8;
        Gravity 0.2;
        BounceFactor 0.1;
    }

    States {
        Spawn:
            //TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
            XST3  ABCD 10;
            //Loop;
        Death:
            XST3 A 4;
            Stop;
        Splash:
            XST3 A 4;
            Stop;
    }
}
class BushPiece2: XJunk1 {
    Default {
        //+DOOMBOUNCE
        Speed 9;
        Gravity 0.3;
        BounceFactor 0.1;
    }

    States {
        Spawn:
            //TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
            XST4  ABCD 8;
            //Loop;
        Death:
            XST4 A 4;
            Stop;
        Splash:
            XST4 A 4;
            Stop;
    }
}
class LeafParticle: XJunk1 {
    Default {
        //+DOOMBOUNCE
        Speed 4;
        Gravity 0.1;
        BounceFactor 0.1;
    }

    States {
        Spawn:
            //TNT1 A 0 A_JumpIf(waterlevel > 1, "Splash");
            XST2 ABACA 10;
            //Loop;
        Death:
            XST2 A 4;
            Stop;
        Splash:
            XST2 A 4;
            Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// destructible pot & pitcher //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class potPuff : actor {
	Default {
		-SOLID
		+NOBLOCKMAP
		scale 0.95;
		//RenderStyle "Translucent";
		//Alpha 0.75;
	}
	States {
		Spawn:
			PUF1 ABCDE 2;
			Stop;
	}
}
class dest_Pot : Pot Replaces Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "Pot destructible"
        +SOLID
        +SHOOTABLE
        +NOBLOOD
        tag "earthenware pot";
        Radius 12;
        Height 24;
        DropItem "wosBulletCartridge", 12;
        DropItem "wosBulletCartridge", 12;
        DropItem "wosBoltsElectric", 12;
        DropItem "MedPatch", 12;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "wosBoltsPoison", 3;
        DropItem "wosBundleMiniMissile", 3;
        DropItem "wosGrenadeE", 3;
        Health 10;
    }
	
	States {
        Spawn:
            VASE A -1;
            Stop;
        Death:
            TNT1 A 0 A_Scream();
			//TNT1 A 0 A_SpawnProjectile("potPuff", 4.0);
            TNT1 AAAAAAA 0 A_SpawnProjectile ("VasePieces", 5, 0, random (0, 360), 2, random (30, 160));
			TNT1 A 0 A_SpawnProjectile("potPuff", 4.0);
            TNT1 A 0 A_NoBlocking();
            Stop;
	}
}
class dest_Pitcher : Pitcher Replaces Pitcher {
    Default {
        //$Category "Decorations/WoS"
        //$Title "Pitcher destructible"
        +SOLID
        +SHOOTABLE
        +NOBLOOD
        Tag "ceramic pitcher";
        Radius 12;
        Height 32;
        DropItem "wosBulletCartridge", 12;
        DropItem "wosBulletCartridge", 12;
        DropItem "wosBoltsElectric", 12;
        DropItem "MedPatch", 12;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "goldCoin", 22;
        DropItem "wosBoltsPoison", 3;
        DropItem "wosBundleMiniMissile", 3;
        DropItem "wosGrenadeE", 3;
        Health 10;
    }
	
	States {
        Spawn:
            DUMM A -1;
            Stop;
        Death:
            TNT1 A 0 A_Scream();
			//TNT1 A 0 A_SpawnProjectile("potPuff", 4.0);
            TNT1 AAAAAAA 0 A_SpawnProjectile ("VasePieces", 5, 0, random (0, 360), 2, random (30, 160));
			TNT1 A 0 A_SpawnProjectile("potPuff", 4.0);
            TNT1 A 0 A_NoBlocking();
            Stop;
	}
}
class VasePieces : actor {
    Default {
        +DOOMBOUNCE
        +MISSILE
        +NOBLOCKMAP
        +NOTELEPORT
        +CLIENTSIDEONLY
        Radius 5;
        Height 5;
        Speed 6;
        Mass 1;
        BounceFactor 0.5;
    }
    
    States {
        Spawn:
            PBIT ABCDEFGHIJ 1;
            Loop;
        Death:
            NULL A 0 A_Jump(90,2);
            PBIT G -1;
            Stop;
            NULL A 0 A_Jump(90,2);
            PBIT H -1;
            Stop;
            PBIT J -1;
            Stop;
    }
}
//strife pots by ??
class dest_strifeDecoVaze1 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco vase 1 destructible"
        tag "decorative vase";
        radius 12;
        height 32;
        +SOLID
    }
	
	
	States {
		Spawn:
			SPT1 A -1;
			Stop;
	}
}
class dest_strifeDecoPot1 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco pot small destructible"
        tag "decorative vase";
        radius 12;
        height 23;
        +SOLID
    }
	
	States {
		Spawn:
			SPT2 A -1;
			Stop;
	}
}
class dest_strifeDecoPot2 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco pot tall destructible"
        tag "tall decorative pot";
        radius 12;
        height 38;
        +SOLID
    }
	
	States {
		Spawn:
			SPT3 A -1;
			Stop;
	}
}
class dest_strifeDecoPot3 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco pot medium destructible"
        tag "medium decorative pot";
        radius 12;
        height 24;
        +SOLID;
    }
	
	States {
		Spawn:
			SPT4 A -1;
			Stop;
	}
}
class dest_strifeDecoPot4 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco pot tall 2 destructible"
        tag "tall decorative pot";
        radius 12;
        height 31;
        +SOLID
    }
	
	States {
		Spawn:
			SPT5 A -1;
			Stop;
	}
}
class dest_strifeDecoVaze2 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco vase 2 destructible"
        tag "decorative vase";
        radius 10;
        height 25;
        +SOLID
    }
	
	States {
		Spawn:
			SPT6 A -1;
			Stop;
	}
}
class dest_strifeDecoVaze3 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco vase 3 destructible"
        tag "decorative vase";
        radius 10;
        height 30;
        +SOLID
    }
	
	States {
		Spawn:
			SPT7 A -1;
			Stop;
	}
}
class dest_strifeDecoPot5 : dest_Pot {
    Default {
        //$Category "Decorations/WoS"
        //$Title "deco pot large destructible"
        tag "large decorative pot";
        radius 16;
        height 29;
        +SOLID
    }
	
	States {
		Spawn:
			SPT8 A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////