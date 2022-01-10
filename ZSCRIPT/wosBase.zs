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

//  RANDOM DROPS - RANDOM SPAWNERS  ////////////////////////////////////////////
//heretic random drops
class randomDrop_01 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 10;
		DropItem "ClipOfBullets", 255, 2;
		DropItem "Gold10", 128, 1;
		DropItem "zscMedPatch", 128, 1;
		DropItem "zscMedicalKit", 64, 1;
		DropItem "EnergyPod", 64, 1;
	}
}
class randomDrop_02 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 5;
		DropItem "ClipOfBullets", 255, 2;
		DropItem "Gold10", 128, 1;
		DropItem "zscMedPatch", 128, 1;
		DropItem "Gold25", 64, 1;
	}
}
class randomDrop_03 : RandomSpawner {
	Default {
		DropItem "goldCoin", 255, 5;
		DropItem "ClipOfBullets", 255, 2;
		DropItem "Gold10", 128, 1;
		DropItem "Hyposprej", 128, 1;
		DropItem "grenadeExplosive", 64, 1;
	}
}
class randomDrop_04 : RandomSpawner {
	Default {
		DropItem "Gold10", 255, 1;
		DropItem "energyPod", 255, 1;
		DropItem "Hyposprej", 128, 1;
		DropItem "Flare", 128, 1;
		DropItem "DeployableShieldItem", 64, 1;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  quest marker in SVE style  /////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////

// light replacers - to brighten up ////////////////////////////////////////////
class wos_bright_techlampbrass : techlampbrass replaces techlampbrass {
	States {
		Spawn:
			TECH B -1 Bright light("TLLIGHT2");
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////