class wosCultist : wosMonsterBase {
    Default {
		//$category "Monsters/WoS"
		//$Title "heretic cultist aggresive"
        Tag "Heretic Cultist";
        Health 75;
        PainChance 200;
        //DropItem "Fire";
        Scale 0.90;
        Speed 8;
        Radius 20;
        Height 56;
        Mass 100;
        Monster;
        +FloorClip
        +DONTHARMSPECIES
        Obituary "%o was killed by a lowly Cultist.";
        SeeSound "monster/culsit";
        AttackSound "monster/culatk"; 
        PainSound "monster/culpai"; 
        DeathSound "monster/culdth"; 
        ActiveSound "monster/culact";
    }
  
    States { 
        Spawn: 
            CULT AB 10 A_Look();
            Loop;
        See: 
            CULT AABBCCDD 2 A_Chase();
            Loop;
        Missile:
            CULT EE 5 A_FaceTarget();
            CULT F 0 Bright A_SpawnProjectile("ThrallShot1",42,-6,0,1,0);
            CULT F 0 Bright A_SpawnProjectile("ThrallShot1",42,6,0,1,0);
            CULT F 8 Bright A_StartSound("monster/culatk");
            Goto See;
        Pain: 
            CULT G 2;
            CULT G 2 A_Pain(); 
            Goto See;
        Death: 
            CULT H 8;
            CULT I 8 A_Scream(); 
            CULT J 4;
            CULT K 4 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth()); 
            CULT L 4;
            CULT M -1;
            Stop;
        XDeath:
            CULT N 5;
            CULT O 5 A_XScream(); 
            CULT P 5 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            CULT QRSTUV 5;
            CULT W -1;
            Stop;
        Raise: 
            CULT MLKJHI 5; 
            Goto See;
    } 
}

class ThrallShot1 : actor {
    Default {
        Radius 4;
        Height 6;
        Speed 20;
        Damage 1;
        RenderStyle "Add";
        Alpha 0.67;
        Projectile;
        +ThruGhost;
        DeathSound "monster/disht1";
    }
    
    States {
        Spawn:
            CFX4 A 2 Bright;
            CFX4 B 2 Bright;
            Loop;
        Death:
            CFX4 CDEF 3 Bright;
            Stop;
    }
}