///////////////////////////////////////////////////////////////////////////////////////
// spawner base definition ////////////////////////////////////////////////////////////
// by jarewill ////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
Class wosMonsterSpawner : Actor { //This is the base class that deals with respawning
    string montype; Property MonsterType : montype; //This is the monster type property
    int restime; Property RespawnTime : restime; //And this is the respawn time property (respawn is in seconds)
    States {
        Spawn:
            TNT1 A 0 SpawnMonster(); //This respawns the monster
            TNT1 A 1 A_JumpIf(!target||target.health<1,1); //This loops the state until the monster has died
            Wait;
            TNT1 A 1 A_SetTics(restime*35); //This waits a set number of time after the monster's death
            Loop; //This loops the state and respawns the monster
    }
    Override void PostBeginPlay() { //This override spawns the monster at the beginning of the game without a teleport effects
        Super.PostBeginPlay();
        Actor mon = Spawn(montype,pos);
        If(mon){target=mon;}
    }
    Action void SpawnMonster() { //This function deals with respawning
        Actor mon = Spawn(Invoker.montype,Invoker.pos); //Spawn the new monster
        If(mon) {
            If(Invoker.target){Invoker.target.Destroy();} //Remove the old monster's corpse
            //Spawn("TeleportFog",Invoker.pos); //Spawn teleport fog effect
            Invoker.target=mon; //Keep track of the newly spawned monster
            mon.bCOUNTKILL=0; //Remove the monster's COUNTKILL flag
            level.total_monsters--; //Remove the monster's count from the map, allowing for 100% kills
        }
    }
}
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
        wosMonsterSpawner.MonsterType "MutantFly"; //Spawn a monster
        wosMonsterSpawner.RespawnTime 120; //Wait 5 seconds for respawn
    }
}
class wosMonsterSpawner_ascSerpentFly : wosMonsterSpawner {
    Default {
        //$Category "Monsters/WoS"
		//$Title "spawner - serpent Fly"
        wosMonsterSpawner.MonsterType "ascSerpentFly"; //Spawn a monster
        wosMonsterSpawner.RespawnTime 120; //Wait 5 seconds for respawn
    }
}
class wosMonsterSpawner_PSXWasp : wosMonsterSpawner {
    Default {
        //$Category "Monsters/WoS"
		//$Title "spawner - Wasp Drone"
        wosMonsterSpawner.MonsterType "PSXWasp"; //Spawn a monster
        wosMonsterSpawner.RespawnTime 120; //Wait 5 seconds for respawn
    }
}
class wosMonsterSpawner_BlackScorpion : wosMonsterSpawner {
    Default {
        //$Category "Monsters/WoS"
		//$Title "spawner - scorpion black"
        wosMonsterSpawner.MonsterType "BlackScorpion"; //Spawn a monster
        wosMonsterSpawner.RespawnTime 120; //Wait 5 seconds for respawn
    }
}
class wosMonsterSpawner_CarnivorousWeed : wosMonsterSpawner {
    Default {
        //$Category "Monsters/WoS"
		//$Title "spawner - Carnivorous Weed"
        wosMonsterSpawner.MonsterType "CarnivorousWeed"; //Spawn a monster
        wosMonsterSpawner.RespawnTime 120; //Wait 5 seconds for respawn
    }
}
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////