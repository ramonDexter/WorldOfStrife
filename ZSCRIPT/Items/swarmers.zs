////////////////////////////////////////////////////////////////////////////////
//  swarmers  //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
Name: Swarmers
Type: Offensive
Palette: Doom
Summon: Swarmers
Use type: Inventory
Duration: Instant
Brightmaps: No
Added States: No
ACS: No


Description:
Releases razor sharp mites to slice through enemies.

Submitted: Mor'ladim
Decorate: Mor'ladim
Sounds: Mor'ladim, Atomic Bomberman
Sprites: Mor'ladim, Raven Software
Idea Base: Original idea
*/
////////////////////////////////////////////////////////////////////////////////
const swarmersWeight = 5;

class wosSwarmers : wosPickup
{
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Swarmers"
	
		+INVENTORY.INVBAR
		+FLOORCLIP
		
		Tag "$T_SWARMERS";
		Inventory.PickupSound "SHPODGET";
		Inventory.PickupMessage "$F_SWARMERS";
		Inventory.Icon "ISHDA0";
		Mass swarmersWeight;
	}
	
	States
	{
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_ThrowGrenade("SwarmerPodSet",4,16,3,0);
			Stop;
	} 
}

class SwarmerPodSet : actor
{
	Default
	{
		+MISSILE
		+DROPOFF
		+CANBOUNCEWATER
		+BOUNCEONWALLS
		+THRUACTORS
		//DONTHURTSHOOTER
		
		Radius 3;
		Height 5;
		Speed 22;
		BounceType "Doom";
		BounceCount 2;
		WallBounceFactor 0.25;
		BounceFactor 0.25;
		//scale 0.5;
	}
	
	States
	{
		Spawn:
			DUMM A 1 Bright;	
			Loop;
		Death:
			DUMM A 1 Bright;
			TNT1 A 0 A_SpawnItem("SwarmerPodActive",1,0,0);
			Stop;
	} 
}

class SwarmerPodActive : actor
{
	Default
	{
		+THRUACTORS
		-SHOOTABLE
		+BRIGHT
		
		Radius 3;
		Height 5;
		Speed 12;
		Reactiontime 2;
		PROJECTILE;
		//scale 0.5;
	}
	
	States
	{
		Spawn:   
			TNT1 A 0;
			DUMM A 1;
			TNT1 A 0 A_CountDown();
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_StartSound("SHPODEXP", 0);
			TNT1 AAAAAAAA 0 A_SpawnItemEx("SwarmerMite",0,0,0,0,0,0,0,SXF_ABSOLUTEPOSITION);
			TNT1 A 0 A_SpawnItem("SPodExplosion",0,0,0);
			Stop;
	}
}

class SwarmerMite : actor
{
	Default
	{
		+THRUACTORS
		-SHOOTABLE
		+NOGRAVITY
		+NOTARGET
		-SEEKERMISSILE
		+STEPMISSILE
		+CANBOUNCEWATER
		+BRIGHT
		+USEBOUNCESTATE
		+DROPOFF
		
		Radius 2;
		Height 2;
		Speed 12;
		PROJECTILE;
		Reactiontime 180;
		//Scale 0.25;
		BounceType "Hexen";
		WallBounceFactor 1.5;
		WallBounceSound "SHDPHIT";
		BounceCount 205;
	}
	
	States
	{
	Spawn:   
		TNT1 A 0;
		TNT1 A 0
		{
			self.bNoGravity = false;
			self.bUseBounceState = false;
		}
		SPMT AA 2;
		TNT1 A 0
		{
			self.bUseBounceState = true;
		}
		SPMT A 1 ThrustThingZ(0,6,0,0);
		SPMT A 1 ThrustThing(random(0,360), 3, 0, 0);
		TNT1 A 0 ThrustThing(random(0,360), 1, 0, 0);
		SPMT BC 1;
		TNT1 A 0 ThrustThing(random(0,360), 1, 0, 0);
		TNT1 A 0 A_StartSound("SHDPFLY",5,0.2,1);
		TNT1 A 0 A_Jump(150,8);
		TNT1 A 0 ThrustThingZ(random(3,6), 0, 0, 0);
		SPMT BC 1;
		TNT1 A 0 ThrustThingZ(random(3,6), 0, 0, 0);
		SPMT BC 1;
		TNT1 A 0 ThrustThingZ(random(3,6), 0, 0, 0);
		TNT1 A 0 ThrustThing(random(0,360), 3, 0, 0);
		SPMT BC 1;
		TNT1 A 0 A_SpawnItem("ShredderDMG",0,0,0);
		TNT1 A 0 A_CountDown();
		Goto Spawn+8;
	Bounce:
		TNT1 A 0;
		TNT1 A 0 A_Jump(255,"Rise","Seeker");
		Goto Spawn+8;
	Rise:
		TNT1 A 0;
		TNT1 A 0 A_StartSound("SHDPFLY",5,0.2,1);
		SPMT BCBC 1 ThrustThingZ(0,2,0,0);
		Goto Spawn+8;
	Seeker:
		TNT1 A 0;
		TNT1 A 0 A_StartSound("SHDPFLY",5,0.2,1);
		TNT1 A 0
		{
			self.bSeekerMissile = true;
		}
		TNT1 AAA 0 A_SeekerMissile(12,20,SMF_LOOK,256|SMF_PRECISE,40);
		TNT1 A 0 A_SpawnItem("ShredderDMG",0,0,0);
		SPMT BCBCBCBC 1 A_SeekerMissile(12,20,SMF_LOOK,256|SMF_PRECISE,40);
		TNT1 A 0
		{
			self.bSeekerMissile = false;
		}
		Goto Spawn+8;
	Death:
		TNT1 A 0;
		TNT1 A 0 
		{
			A_StartSound("SHDPDIE",5,0.6,0);
			A_SpawnItem("SMiteExplosion",0,0,0);
		}
		Stop;
	}
}

class ShredderDMG : actor //Spawn as the "mites" travel to damage enemies.
{
	Default
	{
		+BLOODSPLATTER
		+RIPPER
		
		Speed 2;
		Radius 15;
		Height 8;
		DamageFunction (1*random(1,3));
		PROJECTILE;
	}
	
	States
	{
		Spawn:
			TNT1 A 1;
			Stop;
		Death:
			TNT1 A 0;
			Stop;
	}
}

class SPodExplosion : actor
{
	Default
	{
		+BRIGHT
		
		PROJECTILE;
		Radius 4;
		Height 4;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.6;
		Scale 0.8;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_StartSound("SHPODEXP", 0);
			SHXP ABC 1;
			SHXP D 2 A_SetScale(2.1);
			SHXP E 2 A_SetTranslucent(0.4);
			TNT1 A 0 A_SetScale(1.4);
			SHXP F 2 A_SetTranslucent(0.2);
			Stop;
	}
}

class SMiteExplosion : actor
{
	Default
	{
		+BRIGHT
		
		PROJECTILE;
		Radius 4;
		Height 4;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.8;
		Scale 0.4;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_StartSound("SHPODEXP",5,0.6,0);
			MTXP ABCDEFGHIJ 1;
			Stop;
	}
}