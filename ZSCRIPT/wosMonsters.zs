// base monster //
class wosMonsterBase : actor {

	/////////////////////////////////////////
	// usage: W_rewardXP(SpawnHealth());   //
	/*
			TNT1 A 0 W_rewardXP(SpawnHealth()); //
	*/
	/////////////////////////////////////////
	action void W_rewardXP (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}

	Default {
		+SHOOTABLE;
		+SOLID;
	}

}

///////////////////////////////////////////////////////////////////////////////////////
// spawner base definition ////////////////////////////////////////////////////////////
// by jarewill ////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Class wosMonsterSpawner : Actor { //This is the base class that deals with respawning
	string montype; 
	Property MonsterType : montype; //This is the monster type property
	int restime; 
	Property RespawnTime : restime; //And this is the respawn time property (respawn is in seconds)
	Default {        
		//$arg0 "respawn time (sec)"
	}
	States {
		Spawn:
			TNT1 A 0 SpawnMonster(); //This respawns the monster
			TNT1 A 1 A_JumpIf(!target||target.health<1,1); //This loops the state until the monster has died
			Wait;
			//TNT1 A 1 A_SetTics(restime*35); //This waits a set number of time after the monster's death
			TNT1 A 1 {
				if ( Args[0] ) {
					A_SetTics(Args[0]*35);
				} else { 
					A_SetTics(restime*35);
				}
			}
			Loop; //This loops the state and respawns the monster
	}
	Override void PostBeginPlay() { //This override spawns the monster at the beginning of the game without a teleport effects
		Super.PostBeginPlay();
		Actor mon = Spawn(montype,pos);
		mon.bAMBUSH=true;//so the spawned mosnter waits until player appears
		If(mon){target=mon;}
	}
	Action void SpawnMonster() { //This function deals with respawning
		Actor mon = Spawn(Invoker.montype,Invoker.pos); //Spawn the new monster        
		If(mon) {
			If(Invoker.target){Invoker.target.Destroy();} //Remove the old monster's corpse
			//Spawn("TeleportFog",Invoker.pos); //Spawn teleport fog effect
			Invoker.target=mon; //Keep track of the newly spawned monster
			mon.bCOUNTKILL=0; //Remove the monster's COUNTKILL flag
			mon.bAMBUSH=1;//so the respawned monster dont start chasing player around map
			level.total_monsters--; //Remove the monster's count from the map, allowing for 100% kills
		}
	}
}
/*
class wosMonsterSpawnerCustom : wosMonsterSpawner {
	States {
		Spawn:
			TNT1 A 0 SpawnMonster(); //This respawns the monster
			TNT1 A 1 A_JumpIf(!target||target.health<1,1); //This loops the state until the monster has died
			Wait;
			//TNT1 A 1 A_SetTics(Args[0]*35);
			TNT1 A 1 {
				if ( Args[0] ) {
					A_SetTics(Args[0]*35);
				} else { 
					A_SetTics(restime*35);
				}
			}
			Loop; //This loops the state and respawns the monster
	}
}
*/
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// example spawner ////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
/*
Class ZombieSpawner2 : wosMonsterSpawner replaces Zombieman
{ //This is an example actor that deals with spawning
	Default
	{
		wosMonsterSpawner.MonsterType "Zombieman"; //Spawn a zombieman
		wosMonsterSpawner.RespawnTime 5; //Wait 5 seconds for respawn
	}
} 
*/
///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////
// monster spawners ///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class wosMonsterSpawner_mutantFly : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Mutant Fly"
		//$Sprite "DIS6A1"
		wosMonsterSpawner.MonsterType "MutantFly"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_ascSerpentFly : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - serpent Fly"
		//$Sprite "SFL1A1"
		wosMonsterSpawner.MonsterType "ascSerpentFly"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PSXWasp : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Wasp Drone"
		//$Sprite "PM03A1"
		wosMonsterSpawner.MonsterType "PSXWasp"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_BlackScorpion : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - scorpion black"
		//$Sprite "SC2IA1"
		wosMonsterSpawner.MonsterType "BlackScorpion"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_CarnivorousWeed : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Carnivorous Weed"
		//$Sprite "ROSEA0"
		wosMonsterSpawner.MonsterType "CarnivorousWeed"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_YellowScorpion : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - scorpion yellow"
		//$Sprite "SC1IA1"
		wosMonsterSpawner.MonsterType "YellowScorpion"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_DaggerScorpion : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - scorpion dagger"
		//$Sprite "9DAGF1"
		wosMonsterSpawner.MonsterType "DaggerScorpion"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PSScorpion : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - scorpion blue"
		//$Sprite "PM01B1"
		wosMonsterSpawner.MonsterType "PSScorpion"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PSWasp : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Wasp Warrior"
		//$Sprite "PWSPA1"
		wosMonsterSpawner.MonsterType "PSWasp"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PSRedWasp : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Killer Wasp"
		//$Sprite "PSRWA1"
		wosMonsterSpawner.MonsterType "PSRedWasp"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_CycloneWasp : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Wasp Red"
		//$Sprite "CYCAA1"
		wosMonsterSpawner.MonsterType "CycloneWasp"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_Widow : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Widow Spider"
		//$Sprite "MOSAA1"
		wosMonsterSpawner.MonsterType "Widow"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_SmallSteal : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Small Thief"
		//$Sprite "SPSPA1"
		wosMonsterSpawner.MonsterType "SmallSteal"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_ShadowSpider2 : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Shadowcaster Spider Small"
		//$Sprite "CSPIA1"
		wosMonsterSpawner.MonsterType "ShadowSpider2"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_ShadowSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Shadowcaster Spider"
		//$Sprite "CSPIA1"
		wosMonsterSpawner.MonsterType "ShadowSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PowerSlaveSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Powerslave Spider Small"
		//$Sprite "PSPIA1"
		wosMonsterSpawner.MonsterType "PowerSlaveSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_PowerSlaveSpider2 : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Powerslave Spider"
		//$Sprite "PSPIA1"
		wosMonsterSpawner.MonsterType "PowerSlaveSpider2"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_GoldenSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Golden Spider"
		//$Sprite "PSGIA1"
		wosMonsterSpawner.MonsterType "GoldenSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_GiantSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Giant Spider"
		//$Sprite "GTSDA1"
		wosMonsterSpawner.MonsterType "GiantSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_DeathWidow : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Death Widow"
		//$Sprite "DWIDA1"
		wosMonsterSpawner.MonsterType "DeathWidow"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_DaggerSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Dagger Spider"
		//$Sprite "DAGDA1"
		wosMonsterSpawner.MonsterType "DaggerSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_BloodSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Blood Spider"
		//$Sprite "SPULA1"
		wosMonsterSpawner.MonsterType "BloodSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_AvalonSpider : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Avalon Spider"
		//$Sprite "SPAYA1"
		wosMonsterSpawner.MonsterType "AvalonSpider"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_wosGiantEel : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Giant Eel"
		//$Sprite "EEL1A1"
		wosMonsterSpawner.MonsterType "wosGiantEel"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_wosBogMonster : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - bog monster"
		//$Sprite "SSDVA0"
		wosMonsterSpawner.MonsterType "wosBogMonster"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_ascTramp : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - tramp"
		//$Sprite "BEGRA1"
		wosMonsterSpawner.MonsterType "ascTramp"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_ascRogue : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - rogue"
		//$Sprite "DATFA1"
		wosMonsterSpawner.MonsterType "ascRogue"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_LizardSmall : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Lizard Small"
		//$Sprite "LIZRA1"
		wosMonsterSpawner.MonsterType "LizardSmall"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_LizardMiddle : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Lizard Middle"
		//$Sprite "LIZRA1"
		wosMonsterSpawner.MonsterType "LizardMiddle"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_LizardLarge : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - Lizard Large"
		//$Sprite "LIZRA1"
		wosMonsterSpawner.MonsterType "LizardLarge"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
class wosMonsterSpawner_Ophidiant : wosMonsterSpawner {
	Default {
		//$Category "Monsters/WoS"
		//$Title "spawner - snakeman"
		//$Sprite "oOS2A1C1"
		wosMonsterSpawner.MonsterType "Ophidiant"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 60 seconds for respawn DEFAULT else set time by args[0]
	}
}
///////////////////////////////////////////////////////////////////////////////////////
/*class wosMonsterSpawnerCustom_CarnivorousWeed : wosMonsterSpawnerCustom {
	Default {
		//$Category "Monsters/WoS"
		//$Title "custom spawner - Carnivorous Weed"
		//$Sprite "ROSEA0"
		wosMonsterSpawner.MonsterType "CarnivorousWeed"; //Spawn a monster
		wosMonsterSpawner.RespawnTime 60; //Wait 5 seconds for respawn
	}
}*/
///////////////////////////////////////////////////////////////////////////////////////

// base monster fancy projectile ///////////////////////////////////////////////
/*	
	TRACER SYSTEM FOR ZSCRIPT 2.4 | APRIL 7TH 2017
	AUTHOR: (DENIS) BELMONDO
	
	USAGE: make a new class, inherit from soa_monsterTracer and change the properties as
		   you wish.
	
	you may use this in your project. just leave this comment at the top of 
	this script and give credit please! thank you :^)	
*/
class wosMonsterTracer : FastProjectile {

	const TRACERDURATION	= 1; // tics
	const TRACERFANCY		= 0; // fake bool
	const TRACERLENGTH		= 96.0; // float
	const TRACERSCALE		= 4.0; // float
	const TRACERSTEP		= 0.01; // float
	const TRACERFANCYSTEP	= 0.01; // float
	const TRACERACTOR		= "wos_monsterTracerTrail"; // actor name

	float x1, y1, z1;
	float x2, y2, z2;
	
	// intentional briticism to avoid conflicts with "color" keyword.
	static const color colours[] = {
		"9b 5b 13",
		"af 7b 1f",
		"c3 9b 2f",
		"d7 bb 43",
		"ff ff 73",
		"ff ff 73" /* appears twice so a segment of this color is longer
					than the others. */
	};
	
	// literally just stole this from wikipedia
	float lerp(float v0, float v1, float t) {
		return (1 - t) * v0 + t * v1;
	}
	
	override void BeginPlay() {
		// we don't want to lerp into weird coordinates
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x;
		y2 = pos.y;
		z2 = pos.z;
	}
	
	override void Tick() {	
		if (Level.isFrozen()) return;
		
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x + vel.x / GetDefaultSpeed("wosMonsterTracer") * TRACERLENGTH;
		y2 = pos.y + vel.y / GetDefaultSpeed("wosMonsterTracer") * TRACERLENGTH;
		z2 = pos.z + vel.z / GetDefaultSpeed("wosMonsterTracer") * TRACERLENGTH;
		
		if (TRACERFANCY == 0) {
			for(float i = 0; i < 1; i += TRACERSTEP) {
				A_SpawnParticle (
					colours[clamp(i * colours.Size(), 0, colours.Size() - 1)],
					SPF_FULLBRIGHT,
					TRACERDURATION,
					TRACERSCALE * i,
					0,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0,
					0, 0, 0,
					1.0
				);
			} 
		}
		else {
			for(float i = 0; i < 1; i += TRACERFANCYSTEP) {
				A_SpawnItemEx (
					TRACERACTOR,
					(-pos.x) + lerp(x1, x2, i),
					(-pos.y) + lerp(y1, y2, i),
					(-pos.z) + lerp(z1, z2, i),
					0, 0, 0, 0,
					SXF_ABSOLUTEPOSITION
				);
			}
		}
		Super.Tick();
	}
	Default {
		//Damage (random(5,9));
		DamageType "Bullet";
		Height 1;
		Radius 1;
		Speed 125;
		fastspeed 160;
		+BLOODSPLATTER;
	}
	States {
		Spawn:
			TNT1 A 1;
			Loop;
		Death:
			TNT1 A 0 A_SpawnItemEx("BulletPuff");
		XDeath:
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}	
}
class wos_monsterTracerTrail : Actor {
	Default {
		Alpha 0.5;
		RenderStyle "Add";
		Scale 0.25;
		+NOINTERACTION;
	}
	States {
		Spawn:
			PUFF A 2 Bright;
			TNT1 A -1 A_Jump(256, "Null");
			Stop;
	}
}
// damage type for different types of enemies //
class wosMonsterTracer_Acolyte : wosMonsterTracer {
	Default {
		DamageFunction (3*random(2,8));
	}
}
class wosMonsterTracer_Rebel : wosMonsterTracer {
	Default {
		DamageFunction (3*random(1,4));
	}
}

///////////////////////////////////////////////////////////////////////////////////////
// monster XP replacers ///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

// stalker XP replacer ////////////////////////////////////////////////////////////////
class wosStalker : Stalker replaces Stalker {
	/*action void W_rewardXPstalker (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/

	States {
		Death:
			STLK O 4;
			STLK P 4 A_Scream;
			STLK QRST 4;
			//TNT1 A 0 W_rewardXPstalker(SpawnHealth());
			STLK U 4 A_NoBlocking;
			STLK VW 4;
			STLK XYZ[ 4 Bright;
			Stop;
	}
}
// CeilingTurret XP replacer //////////////////////////////////////////////////////////
class wosCeilingTurret : CeilingTurret replaces CeilingTurret {
	/*action void W_rewardXPCeilingTurret (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	Default {
		//$Category "Monsters/WoS/"
		//$Title "dx Ceiling Turret"
	}

	States {
		Death:
			BALL A 6 Bright A_Scream;
			BALL BCDE 6 Bright;
			//TNT1 A 0 W_rewardXPCeilingTurret(SpawnHealth());
			TURT C -1;
			Stop;
	}
}
// crusader XP replacer ///////////////////////////////////////////////////////////////
class wosCrusader : Crusader replaces Crusader {
	Default {
		//$Category "Monsters/WoS"
		//$Title "wosCrusader"
		//$Sprite "ROB2A1"
		Speed 2;
	}
  	/*action void W_rewardXPcrusader (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.Player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	States {
		Spawn:
			DUMA A 10 A_LookEx (0, 0, 0, 0, 0, "Activation");
			Loop;

		Activation:
			DUMB AB 2;
			goto See;
			
		Idle:
			DUMB B 3 A_StartSound("robot/deactivation");
			DUMB A 3;
			goto Spawn;
		
		See:
			DUMC AA 1 A_Chase();
			DUMC A 1 A_Chase();
			DUMC BB 1 A_Chase();
			DUMC B 1 A_Chase();
			DUMC CC 1 A_Chase();
			DUMC C 1 A_Chase();
			DUMC DD 1 A_Chase();
			DUMC D 1 A_Chase();
			DUMC D 0 A_StartSound("crus/walk", CHAN_BODY, CHANF_DEFAULT, 0.5);
			DUMC EE 1 A_Chase();
			DUMC E 1 A_Chase();
			DUMC FF 1 A_Chase();
			DUMC F 1 A_Chase();
			DUMC GG 1 A_Chase();
			DUMC G 1 A_Chase();
			DUMC HH 1 A_Chase();
			DUMC H 1 A_Chase();
			DUMC II 1 A_Chase();
			DUMC I 1 A_Chase();
			DUMC I 0 A_StartSound("crus/walk", CHAN_BODY, CHANF_DEFAULT, 0.5);
			goto See +2;  //makes animation a little smoother

		Melee:
			DUMD C 3 A_FaceTarget();
			DUMD D 3 A_StartSound ("skeleton/swing");
			DUMD E 3 A_MeleeAttack();
			DUMD E 3 A_FaceTarget();
			DUMD D 3 A_FaceTarget();
			DUMD C 3 A_FaceTarget();
			goto See;
		
		Missile:    
			DUMD HH 5 A_FaceTarget();
			DUMD A 6 A_CrusaderChoose();
			DUMD B 5 A_CrusaderSweepLeft();
			DUMD A 5 A_CrusaderSweepLeft();
			DUMD B 5 A_CrusaderSweepRight();
			DUMD A 5 A_CrusaderRefire();
			Goto See;

		Pain:
			DUMD G 2;
			DUMD G 2 A_Pain();
			goto See;

		Death:
			//TNT1 A 0 A_SpawnItemEx ("Alarm01", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION, 0);
			TNT1 A 0 A_SpawnItemEx ("CrusHeavyLegs", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 0);
			TNT1 A 0 A_SpawnItemEx ("CrusHeavyBody", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 0);
			TNT1 A 0 A_SpawnItemEx ("CrusHeavyArm", 8.0, 30.0, 40.0, 0.0, 4.0, 2.0, 0.0, SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 0);
			TNT1 A 0 A_SpawnItemEx ("CrusHeavyGun", 8.0, -30.0, 40.0, 0.0, -5.0, 0.0, 0.0, SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION, 0);
			TNT1 A 0 A_SpawnItemEx ("wosExplosion_medium", 0.0, 0.0, 32.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//TNT1 A 0 W_rewardXPcrusader(SpawnHealth());
			//TNT1 A 0 A_SpawnItemEx ("ModelSmoke1Medium", 0.0, 0.0, 32.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
			TNT1 A 3 A_Quake(9,8,0,192,"NJMT");
			TNT1 AAAAAA 1 A_TossGib();
			TNT1 A 3 A_Scream();
			TNT1 A 3 A_Fall();
			TNT1 A 3;
			stop;
  	}
}
class CrusHeavyLegs : actor {
	Default {
		Height 1;
		Radius 1;
		Mass 5;
		+NOBLOOD;
	}	
	States {
		Spawn:
			DUME AAAAAAAA 2 A_TossGib();
			DUME B 8;
			DUME C 8;
			DUME D 8;
			DUME E 35;
			Goto FadeOut;
			
		FadeOut:
			DUME E 1 A_FadeOut(0.01);
			Loop;
   	}
}
class CrusHeavyBody : actor {
	Default {
		Height 1;
		Radius 1;
		Mass 5;
		+NOBLOOD;
	}	
	States {
		Spawn:
			DUME A 3;
			DUME B 3;
			DUME C 3;
			DUME D 3;
			DUME E 1 A_SetTranslucent(0.9, 0);
			DUME E 2 A_SetTranslucent(0.8, 0);
			DUME F 1 A_SetTranslucent(0.7, 0);
			DUME F 2 A_SetTranslucent(0.6, 0);
			DUME G 1 A_SetTranslucent(0.5, 0);
			DUME G 2 A_SetTranslucent(0.4, 0);
			DUME H 1 A_SetTranslucent(0.3, 0);
			DUME H 2 A_SetTranslucent(0.2, 0);
			Stop;
  	}
}
class CrusHeavyGun : actor {
	Default {
		Height 1;
		Radius 1;
		Mass 5;
		+NOBLOOD;
		+CORPSE;
	}	
	States {
		Spawn:
			DUME ABCDEF 1;
			Loop;			
		Crash:
			DUME D 70;
			goto FadeOut;			
		FadeOut:
			DUME D 1 A_FadeOut(0.01);
			Loop;		
  	}
}
class CrusHeavyArm : actor {
	Default {
		Height 1;
		Radius 1;
		Mass 5;
		+NOBLOOD;
		+CORPSE;
	}	
	States {
		Spawn:
			DUME ABCDEFGH 3;
			Loop;		
		Crash:
			DUME IJKLMNOPONMNOPIJKLMNOPONMNOPIJKLMNOPMNOPMNOPMNOPMNOPMNO 6;
			DUME P 35;
			goto FadeOut;		
		FadeOut:
			DUME P 1 A_FadeOut(0.01);
			Loop;		
  	}
}
// Inquisitor XP replacer /////////////////////////////////////////////////////////////
class wosInquisitor : Inquisitor replaces Inquisitor {
	/*action void W_rewardXPInquisitor (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	States {
		Death:
			ROB3 L 0 A_StopSound(CHAN_ITEM);
			ROB3 L 4 A_TossGib;
			ROB3 M 4 A_Scream;
			ROB3 N 4 A_TossGib;
			TNT1 A 0 A_SpawnItemEx("wosExplosion_high");
			ROB3 O 4 Bright A_Explode(128, 128, alert:true);
			ROB3 P 4 Bright A_TossGib;
			ROB3 Q 4 Bright A_NoBlocking;
			ROB3 RSTUV 4 A_TossGib;
			TNT1 A 0 A_SpawnItemEx("wosExplosion_high");
			ROB3 W 4 Bright A_Explode(128, 128, alert:true);
			ROB3 XY 4 Bright A_TossGib;
			ROB3 Z 4 A_TossGib;
			ROB3 [ 4 A_TossGib;
			ROB3 \ 3 A_TossGib;
			TNT1 A 0 A_SpawnItemEx("wosExplosion_high");
			ROB3 ] 3 Bright A_Explode(128, 128, alert:true);
			//TNT1 A 0 W_rewardXPInquisitor(SpawnHealth());
			RBB3 A 3 Bright A_TossArm;
			RBB3 B 3 Bright A_TossGib;
			RBB3 CD 3 A_TossGib;
			RBB3 E -1;
			Stop;
	}
}
// Templar XP replacer ////////////////////////////////////////////////////////////////
class wosTemplar : Templar replaces Templar {
	/*action void W_rewardXPTemplar (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	States {
		Death:
			PGRD I 4 A_TossGib;
			PGRD J 4 A_Scream;
			PGRD K 4 A_TossGib;
			PGRD L 4 A_NoBlocking;
			PGRD MN 4;
			PGRD O 4 A_TossGib;
			//TNT1 A 0 W_rewardXPTemplar(SpawnHealth());
			PGRD PQRSTUVWXYZ[ 4;
			PGRD \ -1;
			Stop;
	}
}
// Reaver XP replacer /////////////////////////////////////////////////////////////////
class wosReaver : Reaver replaces Reaver {
	/*action void W_rewardXPReaver (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	States {
		Death:
			ROB1 J 6;
			ROB1 K 6 A_Scream;
			ROB1 L 5;
			ROB1 M 5 A_NoBlocking;
			ROB1 NOP 5;
			TNT1 A 0 A_SpawnItemEx("wosExplosion_high");
			ROB1 Q 6 A_Explode(32, 32, alert:true);
			//TNT1 A 0 W_rewardXPReaver(SpawnHealth());
			ROB1 R -1;
			Stop;
		XDeath:
			ROB1 L 5 A_TossGib;
			ROB1 M 5 A_Scream;
			ROB1 N 5 A_TossGib;
			ROB1 O 5 A_NoBlocking;
			ROB1 P 5 A_TossGib;
			Goto Death+7;
	}
}
// sentinel XP replacer ///////////////////////////////////////////////////////////////
class sentinelLaserTracer : FastProjectile {
	/*const TRACERSPEED 		= 40;
	const TRACERLENGTH		= 256.0; // float
	const TRACERSCALE		= 8.0; // float
	Default {
		Damage 1;
		Speed TRACERSPEED;
	}*/
	const TRACERDURATION	= 1; // tics
	const TRACERLENGTH		= 256.0; // float
	const TRACERSCALE		= 8.0; // float
	const TRACERSTEP		= 0.005; // float
	//const TRACERACTOR		= "laserTracerTrail"; // actor name
	const TRACERSPEED		= 40;

	float x1, y1, z1;
	float x2, y2, z2;
	
	// intentional briticism to avoid conflicts with "color" keyword.
	// modified with strife fitting colors
	static const color colours[] = {
		
		// reversed order
		"db 2b 2b",
		"cb 23 23",
		"bf 1f 1f",
		"af 1b 1b",
		"af 1b 1b",
		"93 13 13"
		// reversed order

		/*"13 3f 0b",
		"23 57 13",
		"37 73 23",
		"4f 8f 37",
		"6b ab 4b",
		"8b c7 67"*/ /* appears twice so a segment of this color is longer
					than the others. */
	};
	
	// literally just stole this from wikipedia
	float lerp(float v0, float v1, float t) {
		return (1 - t) * v0 + t * v1;
	}
	
	override void BeginPlay() {
		// we don't want to lerp into weird coordinates
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x;
		y2 = pos.y;
		z2 = pos.z;
	}

	void W_spawnLaserParticleTrail() {
		if (level.frozen || globalfreeze) return;
		
		x1 = pos.x;
		y1 = pos.y;
		z1 = pos.z;
		
		x2 = pos.x + vel.x / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;
		y2 = pos.y + vel.y / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;
		z2 = pos.z + vel.z / GetDefaultSpeed("BlasterTracer") * TRACERLENGTH;		
		
		for(float i = 0; i < 1; i += TRACERSTEP) {
			A_SpawnParticle (
				colours[clamp(i * colours.Size(), 0, colours.Size() - 1)],
				SPF_FULLBRIGHT,
				TRACERDURATION,
				TRACERSCALE * (1 - i),
				0,
				pos.x - lerp(x1, x2, i),
				pos.y - lerp(y1, y2, i),
				pos.z - lerp(z1, z2, i),
				0, 0, 0,
				0, 0, 0,
				1.0
			);
			/*A_SpawnItemEx (
				TRACERACTOR,
				pos.x - lerp(x1, x2, i),
				pos.y - lerp(y1, y2, i),
				pos.z - lerp(z1, z2, i),
				0, 0, 0, 0,
				SXF_ABSOLUTEPOSITION
			);	*/		
		}		
	}

    Default {
        Radius 2;
        Height 2;
		Speed TRACERSPEED;
        Damage 1;
        Decal "redShotScorch";        
		SeeSound "weapons/laserProj";
		DeathSound "weapons/lasProjDeath";
		+NOEXTREMEDEATH;
    }
    States {
        Spawn:
            LSTR A 1 Bright W_spawnLaserParticleTrail();
            Loop;
        Death:
            TNT1 A 0 A_AlertMonsters();
            TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 2.5, 0, frandom(-1,1),  frandom(-1,1), frandom(-1,1), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.05);
			TNT1 AAAAAAAAAAAAAAAAAAAAA 0 A_SpawnParticle ("red", SPF_FULLBRIGHT|SPF_RELATIVE, 15, 1.75, 0, frandom(-0.5,0.5),  frandom(-0.5,0.5), frandom(-0.5,0.5), frandom(-4,4), frandom(-4,4), frandom(-4,4), 0, 0, 0, 1.0, -0.1, 0.025);
			TNT1 A 0 A_SpawnItemEx("lasPisFlashLong", 0, 0, 0, 0);			
			TNT1 A 0 A_SpawnItemEx("laserExplosion", 0, 0, 0, 0);
            TNT1 A 2 Light("BLASTERSHOT2");
            TNT1 A 2 Light("BLASTERSHOT3");
            TNT1 A 2 Light("BLASTERSHOT4");
            TNT1 A 2 Light("BLASTERSHOT5");
            Stop;
	}
}
class wosSentinel : Sentinel replaces Sentinel {
    Default {
        //$Category "Monsters/WoS"
		//$Title "wosSentinel"
		//$Sprite "SEWRA1"
    }
	/*action void W_rewardXPsentinel (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
    States {
        Spawn:
            DUMA A 10 A_Look();
            Loop;
        See:
            DUMA A 0 {
                bFLOATBOB = true;
            }
            DUMA AAA 1 A_Chase ();
            DUMA A 1 A_Chase();
            DUMA A 0 {
				if ( random(1,5) == 3 ) {
					return resolveState("Bobby");
				}
				return resolveState(null);
			}
            DUMA AAA 1 A_Chase ();
            DUMA A 1 A_Chase();
            Loop;
        
        Bobby:
            DUMA A 0 {
                bFLOATBOB = false;
            }
            DUMA AAAAAA 6 A_SentinelBob();
            goto See;
        
        Missile:
            DUMA B 0 A_CheckLOF ("Missile2", CLOFF_JUMP_ON_MISS|CLOFF_MUSTBESOLID, 3072, 0, 0, 0, 24, 0, AAPTR_DEFAULT);
            goto See;
        Missile2:
            DUMA B 4 A_FaceTarget();
            DUMA C 8 A_SpawnProjectile("sentinelLaserTracer", 8, 0, frandom(-6.0, 6.0), 0, frandom(-6.0, 6.0));//A_SentinelAttack();
            DUMA C 4 A_SentinelRefire();
            Goto Missile+1;
        
        Pain:
            /*DUMA D 0 A_Jump (256, "Pain1", "Pain2");
            
        Pain1:    
            DUMA K 4;
            DUMA K 4 A_Pain();
            Goto See;
            
        Pain2:*/
            DUMA D 4;
            DUMA D 4 A_Pain();
            Goto See;

        Death:
            //change to give nogravity and explosion end
            //TNT1 A 0 A_SpawnItemEx ("Alerter", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION, 0);
            DUMA E 2 A_NoGravity();
            DUMA E 3;
            DUMA FFFF 1 A_TossGib();
            DUMA G 1 A_Scream();
            DUMA GGG 1 A_TossGib();
            //TNT1 A 0 W_rewardXPsentinel(SpawnHealth());
            DUMA G 1 A_SpawnItemEx ("wosSentinelDeath", 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
            TNT1 A 1 A_NoBlocking();
            Stop;
        
            //unlikely to be needed because they don't leave corpses
        Crush:
            TNT1 A 4;
            Stop;
    }
}
class wosSentinelDeath : actor {
    Default {
        Mass 5;
        Height 1;
        Radius 1;
        +NOGRAVITY;
        +NOBLOOD;
    }	
	States {
		Spawn:
            DUMB A 0;
            DUMB A 1 A_SpawnItemEx ("wosExplosion_low", 0.0, 0.0, 24.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
            //DUMB A 1 A_SpawnItemEx ("ModelSmoke1Small", 0.0, 0.0, 24.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
            DUMB B 2 A_SetTranslucent(0.8, 0);
            DUMB C 2 A_SetTranslucent(0.7, 0);
            DUMB D 2 A_SetTranslucent(0.6, 0);
            DUMB E 2 A_SetTranslucent(0.5, 0);
            DUMB F 2 A_SetTranslucent(0.4, 0);
            DUMB G 2 A_SetTranslucent(0.3, 0);
            DUMB H 2 A_SetTranslucent(0.2, 0);
            Stop;
	}
}
class hackedSentinel : wosSentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Hacked Sentinel"
		
		Tag "$TAG_hackedSentinel";
	}
}
class friendSentinel : wosSentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Friendly Sentinel"
		
		+FRIENDLY
		
	}
}
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////