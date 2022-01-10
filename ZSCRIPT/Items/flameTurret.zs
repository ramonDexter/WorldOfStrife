////////////////////////////////////////////////////////////////////////////////
//  FlameTurret  ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
Submitted: Mor'ladim
Decorate: Mor'ladim
Sounds: Mor'ladim
Sprites: Mor'ladim, Raven Software
Idea Base: Original idea
*/
////////////////////////////////////////////////////////////////////////////////
const FlameTurretWeight = 150;

class wosFlameTurret : wosPickup {
	Default {
		//$Category "Powerups/WoS"
		//$Title "Flame Turret"
		
		+inventory.INVBAR;
		+inventory.alwayspickup;
		+FLOORCLIP;
		
		Tag "$T_FLAMETURRET";
		Inventory.PickupMessage "$F_FLAMETURRET";
		Inventory.Icon "FLTRI";	
		Mass FlameTurretWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_ThrowGrenade("FlameTurretSet",4,8,3,0);
			Stop;
	} 
}

class FlameTurretSet : actor
{
	Default
	{
		+DROPOFF
		+CANBOUNCEWATER
		+MISSILE
		DONTHURTSHOOTER;
		Radius 12;
		Height 8;
		Speed 15;		
	}
	
	States
	{
		Spawn:
			DUMM A 1 Bright;	
			Loop;
		Death:
			DUMM A 1 Bright;
			TNT1 A 0 A_SpawnItem("FlameTurretEngage",1,0,0);
			TNT1 A 0 A_SpawnItem("FlameTurretDummy",1,0,0);
			Stop;
	} 
}

class FlameTurretEngage : actor
{
	Default
	{
		-SHOOTABLE
		+NOBLOOD
		+INVULNERABLE
		+NOTARGET
		+MOVEWITHSECTOR
		+BRIGHT
		
		Radius 12;
		Height 40;
		Health 100;
		Mass 25;
	}
	
	States
	{
		Spawn:
			DUMM A 2;
			TNT1 A 0 A_StartSound("snd/flameturret/FTRSET", 0);
			DUMM BCDE 2;
			TNT1 A 0;
			TNT1 A 0;
			Goto See;
		See:
			DUMM EEE 260;
			GoTo Death;
		Missile:
			Stop;
		Death:
			TNT1 A 0;
			DUMM ED 2;
			TNT1 A 0 A_StartSound("snd/flameturret/FTRSET", 0);
			DUMM CB 2;
			DUMM AAA 5;
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("FlmTurretExplosion",0,0,5,0,0,0,0,32);
			Stop;
	}
}

class FlameTurretDummy : actor
{
	Default
	{
		-SHOOTABLE
		+NOBLOCKMAP
		+NOTARGET
		+MOVEWITHSECTOR
		+BRIGHT
		
		Radius 12;
		Height 3;		
		ReactionTime 8;
	}
	
	States
	{
	Spawn:
      TNT1 A 20;
	  TNT1 A 0 A_Countdown();
	  TNT1 A 0 A_StartSound("snd/flameturret/TRFLMS", 0);
	  DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 0, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 0, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 10, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -180, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 20, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -170, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 30, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -160, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 40, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -150, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 50, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -140, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 60, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -130, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 70, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -120, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 80, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -100, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 90, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -90, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 100, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -80, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 110, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -70, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 120, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -60, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 130, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -50, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 140, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -40, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 150, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -30, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 160, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -20, CMF_AIMDIRECTION);
	  DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 170, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -10, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 180, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, -0, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 190, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 10, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 200, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 20, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 210, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 30, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 220, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 40, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 230, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 50, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 240, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 60, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 250, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 70, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 260, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 80, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 270, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 90, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 280, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 100, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 290, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 110, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 300, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 120, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 310, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 130, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 320, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 140, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 330, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 150, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 340, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 160, CMF_AIMDIRECTION);
      DUMM E 3 A_SpawnProjectile("MainFlame", 28, 0, 350, CMF_AIMDIRECTION);
	  DUMM E 0 A_SpawnProjectile("MainFlame", 28, 0, 170, CMF_AIMDIRECTION);
      GoTo Spawn+1;
	Death:
      TNT1 A 0;
      Stop;
	}
}

class MainFlame : actor
{
	Default
	{
		+THRUACTORS
		+RANDOMIZE
		+NOTARGET
		+BRIGHT
		
		Radius 6;
		Height 8;
		Speed 8;
		Scale 0.9;
		RenderStyle "Translucent";
		Alpha 0.6;
		Projectile;	
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TFLM A 3;
			TNT1 A 0 A_SpawnItem("FlameSegmentDMG",0,0,0);
			TFLM B 3;
			TNT1 A 0 A_SpawnItem("FlameSegmentDMG",0,0,0);
			TFLM C 3;
			TNT1 A 0 A_SetScale(scale.x*0.6);
			TNT1 A 0 A_SpawnItem("FlameSegmentDMG",0,0,0);
			TFLM D 3;
			TNT1 A 0 A_SetScale(scale.x*0.7);
			TNT1 A 0 A_SetTranslucent(0.5);
			TNT1 A 0 A_SpawnItem("FlameSegmentDMG",0,0,0);
			TFLM E 1;
			TFLM E 1 A_SetTranslucent(0.4);
			TNT1 A 0 A_SetScale(scale.x*0.8);
			TFLM E 2 A_SetTranslucent(0.3);
			TNT1 A 0 A_SetScale(scale.x*0.10);
			TNT1 A 0 A_SpawnItem("FlameSegmentDMG",0,0,0);
			Stop;
		Death:
			TNT1 A 0 A_SetScale(0.6);
			FLMC ABCD 1;
			Stop;
	}
}

class FlameSegmentDMG : actor
{
	Default
	{
		+NOCLIP
		+FORCERADIUSDMG
		+NOEXTREMEDEATH
		
		Projectile;
		RenderStyle "Translucent";
		DamageType "Fire";
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Explode(Random(2,5),10,1,10);
			Stop;
	}
}

class FlmTurretExplosion : actor
{
	Default
	{
		+BRIGHT
		
		Projectile;
		Radius 6;
		Height 6;
		Speed 0;
		RenderStyle "Translucent";
		Alpha 0.99;
		Scale 1;		
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TNT1 A 0 A_StartSound("snd/flameturret/FTRDEST", 0);
			PEXP ABCDEFGHIJ 1;
			Stop;
	}
}
