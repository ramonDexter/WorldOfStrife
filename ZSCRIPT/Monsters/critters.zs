class CritterBase : actor {
	Default {
		MONSTER;
		-COUNTKILL;
		+DONTMORPH;
	}
}

////////////////////////////////////////////////////////////////////////////////
// sprites Raven software, NeoWorm
// code Ghastly_dragon, Doomedarchviledemon
// sounds FreeSounds
////////////////////////////////////////////////////////////////////////////////
class wosSquirrel : CritterBase {
	Default {
		Tag "Squirrel";
		Health 30;
		Radius 8;
		Height 28;
		Speed 4;
		Mass 100;
		Scale 1;
		PainChance 255;
		+FRIGHTENED 
		+FRIENDLY 
		ActiveSound "SquirrelSpawn/Sight";
        //$Category "Other NPCs/WoS-critters"
		//$Title "Squirrel - veverka"
	}
	States {
		Spawn:
			SQUR A 10 A_Look();
			Goto See;
		See:
			TNT1 A 0 A_Chase();
			SQUR AAAABBBBCCCC 1 A_Wander();
			TNT1 A 0 A_Jump(256,"Jump","See","See","See","See","See");
			Loop;
		Jump:
			SQUR B 1;
			TNT1 A 0 ThrustThingZ (0, random(6,26), 0, 0);
			TNT1 A 0 ThrustThing(angle*256/360, 5, 0, 0);
		MidLeap:
			SQUR B 1 A_SpawnItem ("Fix1");
			TNT1 A 0 A_CheckFloor ("Land");
			Loop;
		Land:
			SQUR B 1 A_Stop();
			goto See;
		Pain:
			TNT1 A 0 A_PlaySound("SquirrelHit/Pain",0,1);
			goto See;
		Death:
			TNT1 A 0 A_PlaySound("SquirrelDead/Dead",0,1);
			SQUD AAAABBBBCCCC 1;
			Stop;
  	}
}

class Fix1 : actor {
	Default {
		Radius 2;
		Height 2;
		Speed 0;
	}
	States {
		Spawn:
			TNT1 A 1;
			stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// sprites Raven software
// code NeoWorm
// sounds ?
////////////////////////////////////////////////////////////////////////////////
class wosRat : CritterBase {
	Default {
		Tag "Rat";
		Health 10;
		Radius 10;
		Height 20;
		Mass 40;
		Speed 4;
		PainChance 255;
		SeeSound "rat/pain";
		AttackSound "rat/attack";
		PainSound "rat/pain";
		DeathSound "rat/death";
		ActiveSound "rat/sight";
		Obituary "%o was biten to death.";
        //$Category "Other NPCs/WoS-critters"
		//$Title "Rat - krysa"
	}
	States {
		Spawn:
			RATM AA 10 A_Look();
			Loop;
		See:
			RATM AAAABBBBCCCC 1 A_Wander(); // A_Chase;
			Loop;
		Melee:
			RATM A 6;
			RATM B 6 A_CustomMeleeAttack(random(1,8));
			Goto See;
		Death:
			RATM D 3 A_Scream();
			RATM E 3 A_NoBlocking();
			RATM F 3;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// sprites Raven software
// code Doomedarchviledemon
// sounds FreeSounds
////////////////////////////////////////////////////////////////////////////////
/*class Piggy : CritterBase
{
	Default
	{
	Health 60;
	Radius 15;
	Height 36;
	Speed 3;
	Mass 100;
	Scale 1;
	PainChance 255;
	seesound "Psight";
	activesound "Psight";
	//$Category "Critters"
	//$Title "Pig"
	//$Sprite PIGAA1
	}
	States
	{
	Spawn:
		PIGA A 10;
		Goto See;
	See:
		PIGA AAAABBBBCCCCDDDD 2 A_Wander;
		PIGA A 0 A_Chase;
		Loop;
	Pain:
		TNT1 A 0 A_PlaySound("PigHurt/Hurt",0,1);
		PIGA A 10;
		Goto RunAway;
	RunAway:
		TNT1 A 0 A_ChangeFlag("Frightened", True);
		TNT1 A 0 A_SetSpeed(6,AAPTR_DEFAULT);
		PIGA AAAABBBBCCCCDDDD 1 A_Chase;
		PIGA AAAABBBBCCCCDDDD 1 A_Chase;
		PIGA AAAABBBBCCCCDDDD 1 A_Chase;
		PIGA AAAABBBBCCCCDDDD 1 A_Chase;
		TNT1 A 0 A_SetSpeed(3,AAPTR_DEFAULT);
		TNT1 A 0 A_ChangeFlag("Frightened", False);
		Goto See;
	Death:
		TNT1 A 0 A_PlaySound("PigDeath/Death",0,1);
		PIGD AAAABBBBCCCCDDDDEEEEFFFFGGGGH 1;
		PIGD H -1;
		Stop;
	Ice:
		PIGF A 5 A_FreezeDeath;
		PIGF A 1 A_FreezeDeathChunks;
		Wait;
	}
}*/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// sprites Raven software, NeoWorm
// code Ghastly_dragon, Doomedarchviledemon
// sounds FreeSounds
////////////////////////////////////////////////////////////////////////////////
/*class Sheep : CritterBase
{
	Default
	{
	Health 50;
	Radius 30;
	Height 56;
	Speed 1;
	Mass 100;
	Scale 1;
	PainChance 255;
	seesound "sight";
	activesound "sight";
	//$Category "Critters"
	//$Title "Sheep"
	//$Sprite NSHEA1
	}
	States
	{
	Spawn:
		NSHE A 10 A_Look;
		Goto See;
	See:
		NSHE AAAABBBBCCCCDDDD 2 A_Wander;
		NSHE A 0 A_Chase;
		TNT1 A 0 A_Jump(256,"EatGrass","See","See","See","See","See","See","See","See");
		Loop;
	EatGrass:
		TNT1 A 0 A_PlaySound("SheepNom/Nom",0,1);
		NSHG A 50;
		NSHG B 30;
		Goto See;
	Pain:
		TNT1 A 0 A_PlaySound("sight",0,1);
		NSHP A 10;
		Goto RunAway;
	RunAway:
		TNT1 A 0 A_ChangeFlag("Frightened", True);
		TNT1 A 0 A_SetSpeed(3,AAPTR_DEFAULT);
		NSHE AAAABBBBCCCCDDDD 1 A_Chase;
		NSHE AAAABBBBCCCCDDDD 1 A_Chase;
		NSHE AAAABBBBCCCCDDDD 1 A_Chase;
		NSHE AAAABBBBCCCCDDDD 1 A_Chase;
		TNT1 A 0 A_SetSpeed(1,AAPTR_DEFAULT);
		TNT1 A 0 A_ChangeFlag("Frightened", False);
		Goto See;
	Death:
		TNT1 A 0 A_PlaySound("sight",0,1);
		NSHD AAAABBBBCCCCDDDDEEEEFFFF 1;
		NSHD F -1;
		Stop;
	}
}*/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// sprites Raven software
// code TheDoomedArchvile
// sounds FreeSounds, Raven Software
////////////////////////////////////////////////////////////////////////////////
class wosChickenCritter : CritterBase {
	Default {
		Tag "Chicken";
		Health 60;
		Radius 10;
		Height 24;
		Speed 2;
		FloatSpeed 2;
		Mass 100;
		Scale 1;
		PainChance 255;
		seesound "sight";
		activesound "sight";
		+FLOAT;
		+LOWGRAVITY;
        //$Category "Other NPCs/WoS-critters"
		//$Title "nw Chicken - slepice"
	}
	States {
		Spawn:
			TNT1 A 0 A_ChangeFlag("Float", False);
			TNT1 A 0 A_ChangeFlag("NOGRAVITY", False);
			CHIC A 10;
			Goto See;
		See:
			CHIC AAAABBBBCCCCDDDD 2 A_Wander();
			CHIC A 0 A_Chase();
			Loop;
		Pain:
			TNT1 A 0 A_PlaySound("ChickenHurt/Hurt",0,1);
			TNT1 A 0 A_ChangeFlag("Frightened", True);
			CHIC A 5;
			TNT1 A 0 ThrustThingZ (0, random(16,28), 0, 0);
			TNT1 A 0 ThrustThing(angle*256/360, random(1,5), 0, 0);
			Goto RunAway;
		RunAway:
			TNT1 A 0 A_ChangeFlag("LOWGRAVITY", TRUE);
			TNT1 A 0 A_ChangeFlag("Float", True);
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC AAAA 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC BBBB 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC CCCC 1 A_Chase();
			TNT1 A 0 A_SpawnItemEx("Feathers",random(-5,5),random(-5,5),random(-5,5),random(-1,1),random(-1,1),random(0,1),0, SXF_NOCHECKPOSITION);
			CHIC DDDD 1 A_Chase();
			TNT1 A 0 A_ChangeFlag("Float", False);
			TNT1 A 0 A_ChangeFlag("Frightened", False);
			Goto See;
		Death:
			TNT1 A 0 A_PlaySound("ChickenDeath/Death",0,1);
			CHDE ABCDEFG 4;
			CHDE H -1;
			Stop;
		Burn:
			TNT1 A 0 A_PlaySound("ChickenDeath/Death",0,1);
			CHDE ABC 4;
			CHDE DEFG 4;
			CHDE H -1;
			Stop;
	}
}

class Feathers : actor {
	Default {
		Speed 1;
		Radius 2;
		Height 2;
		Scale 1;
		Gravity 0.1;
		Projectile;
		-NOGRAVITY;
	}
	States {
		Spawn:
			FEAT AABBCCDDEEDDCCBB 2;
			TNT1 A 0 A_CheckFloor ("Death");
			loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// sprites Vader
// code Batandy/Andrea Gori
////////////////////////////////////////////////////////////////////////////////
class wosCrab : CritterBase {
	Default {
		Tag "Red Crab";
		Health 2;
		PainChance 0;
		Speed 4;
		Radius 14;
		Height 8;
		Mass 400;
		MaxStepHeight 2;
		//BloodColor orange;
		+LOOKALLAROUND;
		+FLOORCLIP;
		+NOTARGET;
		+NOINFIGHTING;
		+FRIGHTENED;
		+FRIENDLY 
		meleedamage 1;
		meleerange 32;
		meleesound "";
		Obituary "A crab sneaked inside %o's pants.";
        //$Category "Other NPCs/WoS-critters"
		//$Title "Crab - krab"
	}
	States {
		Spawn:
			CRAB ABCD 1 A_Wander();
			CRAB ABCD 1 A_LookEx(LOF_NOSOUNDCHECK, 0, 256, 0, 0, "See");
			Loop;
		See:
			CRAB ABCD 1 A_Wander();
			CRAB ABCD 1 A_Chase();
			Loop;
		Melee:
			CRAB A 3 A_FaceTarget();
			CRAB D 3 A_MeleeAttack();
			CRAB A 3;
			Goto See;
		Pain:
			TNT1 A 0 A_Pain();
			Goto See;
		Death:
			CRAB E 2 A_NoBlocking();
			CRAB FGHIJ 2;
			CRAB J 1 A_SetFloorClip();
			TNT1 A 0;
			Stop;
  	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// trees.wad by Ray "Shitbag " Schmitz
// modded by NeoWorm
////////////////////////////////////////////////////////////////////////////////
class wosDragonFly : CritterBase {
	Default {
		Tag "Dragonfly";
		scale 0.75;
		Health 1;
		Radius 3;
		Height 5;
		Speed 5;
		Mass 1;
		+NOGRAVITY
		+SPAWNFLOAT
		+FLOATBOB
		+FRIENDLY 
        //$Category "Other NPCs/WoS-critters"
		//$Title "Dragonfly - vazka"
	}
	States {
		Spawn:
			DFLY A 10 A_Look2();
			Goto See;
		See:
			DFLY ABAB 2 A_Wander();
			DFLY A 0 A_ChangeVelocity(velx, vely, random(-1,1), CVF_REPLACE);
			Loop;
		Death:
			TNT1 A 0;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// trees.wad by Ray "Shitbag " Schmitz
// modded by NeoWorm
////////////////////////////////////////////////////////////////////////////////
class wosFireFly : CritterBase {
	Default {
		Tag "Firefly";
		scale  0.5;
		Health 1;
		Radius 3;
		Height 5;
		Speed 3;
		Mass 1;
		+NOGRAVITY
		+SPAWNFLOAT
		+FLOATBOB
		+FRIENDLY 
        //$Category "Other NPCs/WoS-critters"
		//$Title "Firefly - svetluska"
	}
	States {
		Spawn:
			FFLY A 10 Bright light("fireflyLight") A_Look2();
			Goto See;
		See:
			FFLY AABB 2 Bright light("fireflyLight") A_Wander();
			FFLY A 0 Bright light("fireflyLight") A_ChangeVelocity(velx, vely, random(-1,1), CVF_REPLACE);
			Loop;
		Death:
			TNT1 A 0;
			Stop;
  	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// inquisitor crow by shadowman&bigmemka ///////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosICraw : actor {
	Default {
        //$Category "Other NPCs/WoS-critters"
		//$Title "vrana"
		
		-COUNTKILL
		+NEVERTARGET
		+FLOORCLIP
		+FRIGHTENED
		+SHOOTABLE
		//+FRIENDLY
		
		Tag "Raven";
		health 10;
		radius 8;
		height 24;
		mass 10;
		speed 15;
		seesound "craw/active";
		//MONSTER;
	}
	
    States {
        Spawn:
			//TNT1 A 0 A_JumpIfCloser(256, "See");
            CRW1 GGAABBCCDD 4 A_Look2();
            loop;
        See:
            CRW1 A 0 {
				self.bNoGravity = 0;
				self.bFloat = 0;
				A_SetGravity(1.0);
			}
            CRW1 E 0 ;
            CRW1 GGG 4;
            CRW1 G 0 A_JumpIfCloser(256, "Startfly");
            CRW1 AABB 4;
            CRW1 B 0 A_JumpIfCloser(256, "Startfly");
            CRW1 CCDD 4;
            CRW1 D 0 A_JumpIfCloser(256, "Startfly");
            CRW1 A 0 A_Jump(16, "Startfly");
            CRW1 A 0 A_Jump(128, 1);
            Goto See;
            CRW1 AABB 4;
            CRW1 B 0 A_JumpIfCloser(256, "Startfly");
            CRW1 CCDD 4;
            CRW1 D 0 A_JumpIfCloser(256, "Startfly");
            CRW1 GGGG 4;
            CRW1 G 0 A_JumpIfCloser(256, "Startfly");
            Goto See;
            
        Startfly:
            CRW1 A 0;
            CRW1 E 1; //A_SpawnItemEx("PEMysticEgg", 0, 0, 0, 0, 0, 0, 0, SXF_ABSOLUTEVELOCITY)
            CRW1 E 0;
            CRW1 E 1;
            Goto Fly;
        Fly:
            CRW1 A 0;
            CRW1 A 0 A_SentinelBob();
            CRW1 A 0 {
				self.bNoGravity = 1;
				self.bFloat = 1;
			}
            CRW1 EEFFEEFFEEFFEEFFEEFFEEFF 4 A_Wander();
            CRW1 A 0 A_Jump(128,2);
            CRW1 A 0 A_StartSound ("Craw/active");
            CRW1 A 0 A_Jump(32,1);
            Goto Fly;
            CRW1 A 0;
            CRW1 A 0 {
				self.bNoGravity = 0;
			}
            CRW1 E 0 A_SetGravity(0.1);
            CRW1 EEFFEEFFEEFFEEFF 4 A_Wander();
            CRW1 E 0 A_SetGravity(0.2);
            CRW1 EEFFEEFFEEFFEEFF 4 A_Wander();
            CRW1 E 0 A_SetGravity(0.4);
            CRW1 EEFFEEFFEEFFEEFF 4 A_Wander();
            CRW1 E 0 A_SetGravity(0.8);
            CRW1 EEFFEEFF 4 A_Wander();
            Goto See;
        Death:
            CRW1 H 4; 
            CRW1 I 4 A_NoBlocking();
            Goto Fall;
        Death.Arrow:
            CRW1 H 4 A_SpawnDebris("BloodSpurt");
            CRW1 H 0 A_SpawnDebris("BloodSpurt");
            CRW1 I 4 A_NoBlocking();
            Goto Fall;
        Death.Egg:
            CRW1 H 1;
            Stop;
        Fall:
            CRW1 I 1 A_CheckFloor ("Splat");
            loop;
        Splat:
            CRW1 I 1 A_Stop();
            CRW1 I 0 A_StartSound("Craw/Splat");
            CRW1 I -1;
            stop;
    }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// birds - boids ///////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosICrawBoid_leader : HXA_Boid {

	Override Void PostBeginPlay() {
		FlockID = random(0,255);
		for(int i=0; i<40; i++)
		{
			let k = Spawn("wosICrawBoid_follower", pos);
			wosICrawBoid_follower(k).FlockID = FlockID;
			wosICrawBoid_follower(k).MaxDistancetoBoid = 1600;
			wosICrawBoid_follower(k).BoidActor = "wosICrawBoid_leader";
			wosICrawBoid_follower(k).CloseToMaster = TRUE;
			wosICrawBoid_follower(k).DistanceFromMaster = 300;
			k.master = self;
		} 
	}
	Override Void Tick()
	{
		if(health > 0)
		{
			BoidFlight(null, MaxVelocity: 30, WallDetectionDistance: 10, MinDistanceBeacon: 400, MaxDistanceBeacon: 700, HorizonNormalizer: 30);
			//A_SpawnParticle("Gray", SPF_FULLBRIGHT, 4,15);
		}
		Super.Tick();
	}

	Default {
		//$Category "Other NPCs/WoS-critters"
		//$Title "vrana - boid leader"
	}
	States {
		Spawn:
			CRW1 EEFFEEFFEEFF 3;
			Loop;
	}
}
class wosICrawBoid_follower : HXA_Boid {
	Override Void Tick()
	{
		if(health > 0)
		{
			BoidFlight("wosICrawBoid_leader", BoidCohesion: 6);
			//A_SpawnParticle("White", SPF_FULLBRIGHT, 4,15);
		}
		Super.Tick();
	}
	States {
		Spawn:
			CRW1 EEFFEEFFEEFF 3;
			Loop;
	}
}
////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

/*
TO DO list
- rat spawner
- butterflies
- butterfly spawner
- fly swarm
*/