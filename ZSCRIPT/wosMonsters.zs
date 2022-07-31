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
		+SHOOTABLE
		+SOLID
	}

}

///////////////////////////////////////////////////////////////////////////////////////
// spawner base definition ////////////////////////////////////////////////////////////
// by jarewill ////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Class wosMonsterSpawner : Actor { //This is the base class that deals with respawning
	string montype; Property MonsterType : montype; //This is the monster type property
	int restime; Property RespawnTime : restime; //And this is the respawn time property (respawn is in seconds)
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

///////////////////////////////////////////////////////////////////////////////////////
// monster XP replacers ///////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

// stalker XP replacer ////////////////////////////////////////////////////////////////
class wosStalker : Stalker replaces Stalker {
	action void W_rewardXPstalker (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}

	States {
		Death:
			STLK O 4;
			STLK P 4 A_Scream;
			STLK QRST 4;
			TNT1 A 0 W_rewardXPstalker(80);
			STLK U 4 A_NoBlocking;
			STLK VW 4;
			STLK XYZ[ 4 Bright;
			Stop;
	}
}
// CeilingTurret XP replacer //////////////////////////////////////////////////////////
class wosCeilingTurret : CeilingTurret replaces CeilingTurret {
	action void W_rewardXPCeilingTurret (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}

	States {
		Death:
			BALL A 6 Bright A_Scream;
			BALL BCDE 6 Bright;
			TNT1 A 0 W_rewardXPCeilingTurret(125);
			TURT C -1;
			Stop;
	}
}
// crusader XP replacer ///////////////////////////////////////////////////////////////
class wosCrusader : Crusader replaces Crusader {
	action void W_rewardXPCrusader (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	States {
		Death:
			ROB2 G 3 A_Scream;
			ROB2 H 5 A_TossGib;
			ROB2 I 4 Bright A_TossGib;
			ROB2 J 4 Bright A_Explode(64, 64, alert:true);
			ROB2 K 4 Bright A_Fall;
			TNT1 A 0 W_rewardXPCrusader(400);
			ROB2 L 4 A_Explode(64, 64, alert:true);
			ROB2 MN 4 A_TossGib;
			ROB2 O 4 A_Explode(64, 64, alert:true);
			ROB2 P -1 A_CrusaderDeath;
			Stop;
	}
}
// Inquisitor XP replacer /////////////////////////////////////////////////////////////
class wosInquisitor : Inquisitor replaces Inquisitor {
	action void W_rewardXPInquisitor (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	States {
		Death:
			ROB3 L 0 A_StopSound(CHAN_ITEM);
			ROB3 L 4 A_TossGib;
			ROB3 M 4 A_Scream;
			ROB3 N 4 A_TossGib;
			ROB3 O 4 Bright A_Explode(128, 128, alert:true);
			ROB3 P 4 Bright A_TossGib;
			ROB3 Q 4 Bright A_NoBlocking;
			ROB3 RSTUV 4 A_TossGib;
			ROB3 W 4 Bright A_Explode(128, 128, alert:true);
			ROB3 XY 4 Bright A_TossGib;
			ROB3 Z 4 A_TossGib;
			ROB3 [ 4 A_TossGib;
			ROB3 \ 3 A_TossGib;
			ROB3 ] 3 Bright A_Explode(128, 128, alert:true);
			TNT1 A 0 W_rewardXPInquisitor(1000);
			RBB3 A 3 Bright A_TossArm;
			RBB3 B 3 Bright A_TossGib;
			RBB3 CD 3 A_TossGib;
			RBB3 E -1;
			Stop;
	}
}
// Templar XP replacer ////////////////////////////////////////////////////////////////
class wosTemplar : Templar replaces Templar {
	action void W_rewardXPTemplar (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	States {
		Death:
			PGRD I 4 A_TossGib;
			PGRD J 4 A_Scream;
			PGRD K 4 A_TossGib;
			PGRD L 4 A_NoBlocking;
			PGRD MN 4;
			PGRD O 4 A_TossGib;
			TNT1 A 0 W_rewardXPTemplar(300);
			PGRD PQRSTUVWXYZ[ 4;
			PGRD \ -1;
			Stop;
	}
}
// Reaver XP replacer /////////////////////////////////////////////////////////////////
class wosReaver : Reaver replaces Reaver {
	action void W_rewardXPReaver (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	States {
		Death:
			ROB1 J 6;
			ROB1 K 6 A_Scream;
			ROB1 L 5;
			ROB1 M 5 A_NoBlocking;
			ROB1 NOP 5;
			ROB1 Q 6 A_Explode(32, 32, alert:true);
			TNT1 A 0 W_rewardXPReaver(150);
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
class wosSentinel : Sentinel replaces Sentinel {
	action void W_rewardXPsentinel (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	States {
		Death:
			SEWR D 7 A_Fall;
			SEWR E 8 Bright A_TossGib;
			SEWR F 5 Bright A_Scream;
			SEWR GH 4 Bright A_TossGib;
			TNT1 A 0 W_rewardXPsentinel(100);
			SEWR I 4;
			SEWR J 5;
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////