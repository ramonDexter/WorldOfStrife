////////////////////////////////////////////////////////////////////////////////
// land mine item //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// item ////////////////////////////////////////////////////////////////////////
class wosLandMine : wosPickup {
	Default {
		//$Category "Powerups/WoS"
		//$Title "land mine"
		+INVENTORY.INVBAR
		Tag "$T_LandMine";
		inventory.PickupMessage "$F_LandMine";
		Inventory.Icon "I_LMIN";
		Mass landMineWeight;
		//Scale 0.75;
	}
	States {
		Spawn:
			LMIN A -1;
			Stop;
		Use:
			TNT1 A 0 A_SpawnItemEx("landMinePlaced", 48.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, SXF_TRANSFERPOINTERS);
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// placed mine /////////////////////////////////////////////////////////////////
class landMinePlaced : SwitchableDecoration {
	Default {
		Radius 12;
		Height 16;
		Mass 1000000;
		Health 10;
		Damage 1;
		SeeSound "weapons/tripplace";
		Deathsound "weapons/tripwire";
		Activation THINGSPEC_Default | THINGSPEC_Activate | THINGSPEC_MonsterTrigger;
		ExplosionDamage 192;
		ExplosionRadius 128;
		Speed 0;
		//Scale 0.5;
		-SOLID
		+USESPECIAL
		+NOBLOOD
		+SHOOTABLE
		+EXTREMEDEATH
		+THRUSPECIES
		+CANBOUNCEWATER
		+FLOORCLIP
		+FLOORHUGGER
		+MISSILE
		Obituary "%o tripped over %k's wire.";
	}
	States {
		Spawn:
			LMIN A 0 A_Gravity();
			LMIN A 25;
			LMIN B 5 light("landMineLight");
			Loop;
		Xdeath:
			LMIN B 15 light("landMineLight") A_Scream();
		Death:
			TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 A 0 A_Explode(192, 192, 1, 1);
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
			stop;
		Active:
			TNT1 A 0 A_spawnItemEx("wosLandMine");
			stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// land mine trap //////////////////////////////////////////////////////////////
class landMineTrap : SwitchableDecoration {
	Default {
		//$Category "Powerups/WoS"
		//$Title "land mine trap"
		Radius 12;
		Height 16;
		Mass 1000000;
		Health 10;
		Damage 1;
		SeeSound "weapons/tripplace";
		Deathsound "weapons/tripwire";
		Activation THINGSPEC_Default | THINGSPEC_Activate;
		ExplosionDamage 192;
		ExplosionRadius 128;
		Speed 0;
		//Scale 0.5;
		+USESPECIAL
		+NOBLOOD
		+SHOOTABLE
		+EXTREMEDEATH
		+CANBOUNCEWATER
		+FLOORCLIP
		+FLOORHUGGER
		+MISSILE
		+SOLID
		+TOUCHY
		Obituary "%o tripped over a boobytrap.";
	}
	States {
		Spawn:
			LMIN A 0 A_Gravity();
			LMIN A 25;
			LMIN B 5 light("landMineLight");
			Loop;
		Xdeath:
			LMIN B 15 light("landMineLight") A_Scream();
		Death:
			TNT1 AAAAAAA 0 A_SpawnProjectile ("ExplosionFire", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 A 0 A_Explode(192, 192, 1, 1);
			TNT1 A 0 A_SpawnItemEx ("ExplosionFlareSpawner",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION,0);
			TNT1 A 0 A_StartSound("sounds/grenadeExplosion", 1);
			TNT1 A 1 Radius_Quake (4, 15, 0, 12, 0);
			TNT1 AAAA 0 A_SpawnProjectile ("PlasmaSmoke", 3, 0, random (0, 360), 2, random (0, 360));
			TNT1 AAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnProjectile ("ExplosionParticle1", 3, 0, random (0, 360), 2, random (0, 360));	
			TNT1 AAAAAAAAAAAAAAA 6 A_SpawnProjectile ("PlasmaSmoke", 1, 0, random (0, 360), 2, random (0, 160));
			stop;
		Active:
			TNT1 A 0 A_spawnItemEx("wosLandMine");
			stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////