////////////////////////////////////////////////////////////////////////////////
//  common stuff  //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  flash base  ////////////////////////////////////////////////////////////////
class flashBase : actor {	
	Default {
		+MISSILE;
		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		+NOTELEPORT
		+FORCEXYBILLBOARD
		+NOTDMATCH
		+GHOST		
		Radius 1;
		Height 1;
		Mass 1;
		Damage 0;
		Speed 1;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  strife water splash  ///////////////////////////////////////////////////////
class StrifeWaterSplashBase : WaterSplashBase {
	States {
		Spawn:
			SWSH EFGHIJK 5;
			Stop;
	}
}
class StrifeWaterSplash : WaterSplash {
	States {
		Spawn:
			SWSH ABC 8;
			SWSH D 16;
			Stop;
		Death:
			SWSH D 10;
			Stop;
	}
}
class groundDustSplashBase : WaterSplashBase {
	Default {
		Renderstyle "Translucent";
	}
	States {
		Spawn:
			SMK3 ABCDE 5;
			Stop;
	}
}
class groundDustSplash : WaterSplash {
	Default {
		Renderstyle "Translucent";
	}
	States {
		Spawn:
			SMK3 CD 8;
			SMK3 E 16;
			Stop;
		Death:
			SMK3 E 10;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  QUEST MARKERS in SVE style  ////////////////////////////////////////////////
class questMarker : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker"
		//$NotAngled
	}	
	States {
		Spawn:
			MRKR ABCDEFEDCB 2;
			Loop;
	}
}
class questMarker_1 : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker#1"
		//$NotAngled
	}	
	States {
		Spawn:
			MRK1 ABCDEFEDCB 2;
			Loop;
	}
}
class questMarker_2 : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker#2"
		//$NotAngled
	}	
	States {
		Spawn:
			MRK2 ABCDEFEDCB 2;
			Loop;
	}
}
class questMarker_3 : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker#3"
		//$NotAngled
	}	
	States {
		Spawn:
			MRK3 ABCDEFEDCB 2;
			Loop;
	}
}
class questMarker_4 : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker#4"
		//$NotAngled
	}	
	States {
		Spawn:
			MRK4 ABCDEFEDCB 2;
			Loop;
	}
}
class questMarker_5 : MapMarker {
	Default {
		//$Category "Map Markers"
		//$Color 7
		//$Title "quest marker#5"
		//$NotAngled
	}	
	States {
		Spawn:
			MRK5 ABCDEFEDCB 2;
			Loop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  RANDOM DROPS - RANDOM SPAWNERS  ////////////////////////////////////////////
//heretic random drops
class randomDrop_01 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 10;
		DropItem "wosBulletCartridge", 255, 2;
		DropItem "wosGold10", 128, 1;
		DropItem "zscMedPatch", 128, 1;
		DropItem "zscMedicalKit", 64, 1;
		DropItem "wosEnergyCell", 64, 1;
	}
}
class randomDrop_02 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 5;
		DropItem "wosBulletCartridge", 255, 2;
		DropItem "wosGold10", 128, 1;
		DropItem "zscMedPatch", 128, 1;
		DropItem "Gold25", 64, 1;
	}
}
class randomDrop_03 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 5;
		DropItem "wosBulletCartridge", 255, 2;
		DropItem "wosGold10", 128, 1;
		DropItem "wosHyposprej", 128, 1;
		DropItem "wosGrenadeE", 64, 1;
	}
}
class randomDrop_04 : RandomSpawner {
	Default {
		DropItem "wosGold10", 255, 1;
		DropItem "wosEnergyCell", 255, 1;
		DropItem "wosHyposprej", 128, 1;
		DropItem "Flare", 128, 1;
		DropItem "wosDeployableShield", 64, 1;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  dummy explosion  ///////////////////////////////////////////////////////////
class dummy_explosion : actor {
	Default {
		-NOGRAVITY
		+RANDOMIZE
		+DEHEXPLOSION		
        Projectile;
        Speed 0;
        Damage 0;
		Radius 1;
        Height 1;
        //Gravity 1.0;
        DeathSound "weapons/plasmax";
	}	
	States {
		Spawn:
		Death:
            TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));	
            TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
            TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
            stop;
			
	}
}
class wosExplosion_low : dummy_explosion {
	Default { Damage 8; }
}
class wosExplosion_medium : dummy_explosion {
	Default { Damage 16; }
}
class wosExplosion_high : dummy_explosion {
	Default { Damage 32; }
}
class wosExplosion_veryhigh : dummy_explosion {
	Default { Damage 64; }
}
class wosExplosion_extreme : dummy_explosion {
	Default { Damage 128; }
}
////////////////////////////////////////////////////////////////////////////////

// light replacers - to brighten up ////////////////////////////////////////////
class wos_bright_techlampbrass : techlampbrass replaces techlampbrass {
	Default {
		Tag "techlamp brass";
	}
	States {
		Spawn:
			TECH B -1 Bright light("TLLIGHT2");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

class wosd_AmmoFiller : AmmoFiller replaces AmmoFiller {
	Default {
		//$Category "Decorations/WoS"
		//$Title "dx ammo filler"
		Tag "Ammo Filler";
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}

// new blood that stays on floor for a while, code by jarewill /////////////////
Class wosBlood : Blood replaces Blood {	
	bool nomore;
	Override void Tick() {
		Super.Tick();
		If( nomore == 0 ) {
			If( pos.z == GetZAt() ) {
				bFLATSPRITE = 1; 
				SetStateLabel("Crash"); 
				nomore = 1;
			}
		}
	}
	States {
		Spawn:
			BLUD C 8;
			Wait;
			BLUD B 8;
			Wait;
			BLUD A 8;
			Wait;
		Crash:
			#### # 175;
			#### # 1 A_FadeOut(0.02);
			Wait;
	}
}
////////////////////////////////////////////////////////////////////////////////





















////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////