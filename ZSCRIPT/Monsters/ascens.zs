////////////////////////////////////////////////////////////////////////////////
//----------Carnivorous weed--------------//////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// YoungCarnivorous weed ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class YoungWeedSpores : Inventory {
    Default {
        Inventory.MaxAmount 3;
        Mass 0;
    }
}
class YoungCarnivorousWeed : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Carnivorous Weed Young"
        Tag "$T_YoungCarnivorousWeed";
        Health 90;
        Painchance 0;        
        height 44;
        radius 24;
        Mass 5000;
        Speed 0;
        Scale 0.4;
        Obituary "%o is six feet under.";
	    BloodColor "0 50 0";
        MONSTER;
        +DONTMORPH;
        +NOICEDEATH;
        +FLOORCLIP;
        +STANDSTILL;
        +LOOKALLAROUND;
        +SHORTMISSILERANGE;
        -CANPUSHWALLS;
        /*DamageFactor "Normal", 1.0
	    DamageFactor "NormalFist", 0.5
        DamageFactor "NormalHit", 1.0
        DamageFactor "NormalCrush", 0.8
	    DamageFactor "hornet", 0.0
        DamageFactor "Fire", 1.5
        DamageFactor "FireCannon", 1.5
        DamageFactor "Cannonball1", 1.0
        DamageFactor "Cannonball2", 1.0
	    DamageFactor "P_FireExplode", 1.5
        DamageFactor "Ice", 1.0
        DamageFactor "Lightning", 1.25
	    DamageFactor "P_Lightning", 1.25
	    DamageFactor "Lighting_Archmage", 1.25
        DamageFactor "Gas", 0.5
        DamageFactor "Poison", 0.0
        DamageFactor "Magic", 1.0
	    DamageFactor "MagicVampire", 0.0*/
    }

	States {
        Spawn:
            ROSE AAAB 10 A_Look();
            Loop;
        See:
            ROSE AAA 3 A_Chase();
            ROSE A 0 A_Jump(64,1,11,28);
            Loop;
            ROSE BBCC 3 A_Chase();
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
            ROSE BBCCDD 3 A_Chase();
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
            ROSE BBCCDDEE 3 A_Chase();
            ROSE EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
        Missile:
            ROSE B 1 A_JumpIfInventory("WeedSpores", 3, "See");
            ROSE A 0 A_Jump(64,14,32);
            ROSE BBCC 3;
            ROSE A 0;
            ROSE CCC 1 {
                A_SpawnitemEx("YoungHellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
            ROSE BBCCDD 3;
            ROSE A 0;
            ROSE DD 1 {
                A_SpawnitemEx("YoungHellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0,SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
            ROSE BBCCDDEE 3;
            ROSE A 0;
            ROSE EE 1 {
                A_SpawnitemEx("YoungHellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
        Death:
            ROSE F 5;
            ROSE F 1 /*ACS_NamedExecuteAlways("ExpGain",0,40,0,0)*/;         //Gain 40 Exp. 
            ROSE G 5 A_Scream();
            ROSE H 5 A_Fall();
            ROSE I 5 A_KillMaster();
            ROSE J 5;
            ROSE K 103;
            ROSE K 0 A_KillMaster();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSE K -1;
            Stop;
        XDeath:
            ROSE L 5;
            ROSE L 1 /*ACS_NamedExecuteAlways("ExpGain",0,40,0,0)*/;         //Gain 40 Exp. 
            ROSE M 5 A_XScream();
            ROSE N 5 A_Fall();
            ROSE O 5 A_KillMaster();
            ROSE PQ 5;
            ROSE R 98;
            ROSE R 0 A_KillMaster();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSE R -1;
            Stop;
	}
}
class YoungHellroseBramble : wosMonsterBase {
    Default {
        height 64;
        radius 20;
        speed 12;
        FastSpeed 24;
        Health 25;
        Mass 5000;
        meleedamage 1;
        meleerange 52;
        BloodColor "0 50 0";
        Painchance 128;
        MONSTER;
        -SHOOTABLE;
        -SOLID;
        -COUNTKILL;
        +NOTARGETSWITCH;
        +NOICEDEATH;
        +FLOORCLIP;
        +LOOKALLAROUND;
        /*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 0.8
	DamageFactor "hornet", 0.0
        	DamageFactor "Fire", 1.5
        	DamageFactor "FireCannon", 1.5
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	DamageFactor "P_FireExplode", 1.5
        	DamageFactor "Ice", 1.0
        	DamageFactor "Lightning", 1.25
	DamageFactor "P_Lightning", 1.25
	DamageFactor "Lighting_Archmage", 1.25
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 1.0
	DamageFactor "MagicVampire", 0.0*/
    }
   
        	
   
    States {
        Spawn:
            TNT1 A 0;
            TNT1 A 0 A_UnsetShootable();
            TNT1 A 0 A_UnsetSolid();
            ROSX RST 4 A_Look();
            Loop;
        See:
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            Goto Melee;
        Melee:
            TNT1 A 0 A_SetShootable();
            TNT1 A 0 A_SetSolid();
            ROSX RQ 4;
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX P 4 A_CustomMeleeAttack();
            ROSX ONML 4;
            ROSX ABC 4;
            ROSX D 0 A_FaceTarget();
            ROSX D 0 /*A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee")*/;
            ROSX D 3 A_CustomMeleeAttack();
            ROSX A 0 A_Jump(64,6);
            ROSX EF 5;
            ROSX G 0 A_FaceTarget();
            ROSX G 3 A_CustomMeleeAttack();
            ROSX G 0 A_CPosRefire();
            Goto Melee +14;
            ROSX JKL 4;
            ROSX H 3 A_CustomMeleeAttack();
            ROSX H 0 A_CPosRefire();
            Goto Melee +14;
        FakeMelee:
            ROSX G 3;
            Goto Melee +14;
        Pain:
            ROSX LMNOPQR 3;
            TNT1 A 0 A_UnSetSolid();
            TNT1 A 0 A_UnSetShootable();
            Goto See +30;
        Death:
            ROSX U 5 A_TakeInventory ("WeedSpores", 1, 0, AAPTR_MASTER);
            ROSX V 5 A_Scream();
            ROSX W 5 A_Fall();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSX XRR 5;
            ROSX RRRRRRRRR 2 A_FadeOut (0.1);
            stop;
   }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//------------------------Carnivorous weed----------------------------------////
////////////////////////////////////////////////////////////////////////////////

class WeedSpores : Inventory {
    Default {
        Inventory.MaxAmount 3;
        Mass 0;
    }
}

class CarnivorousWeed : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Carnivorous Weed"
        Tag "$T_CarnivorousWeed";
        Health 180;
        Painchance 0;
        height 56;
        radius 32;
        Mass 5000;
        Speed 0;
        Scale 0.8;
        Obituary "%o is six feet under.";
        BloodColor "0 50 0";
        MONSTER;
        +DONTMORPH;
        +NOICEDEATH;
        +FLOORCLIP;
        +STANDSTILL;
        +LOOKALLAROUND;
        +SHORTMISSILERANGE;
        -CANPUSHWALLS;
        /*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 0.8
	DamageFactor "hornet", 0.0
        	DamageFactor "Fire", 1.5
        	DamageFactor "FireCannon", 1.5
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	DamageFactor "P_FireExplode", 1.5
        	DamageFactor "Ice", 1.0
        	DamageFactor "Lightning", 1.25
	DamageFactor "P_Lightning", 1.25
	DamageFactor "Lighting_Archmage", 1.25
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 1.0
	DamageFactor "MagicVampire", 0.0*/
    }

	States {
        Spawn:
            ROSE AAAB 10 A_Look();
            Loop;
        See:
            ROSE AAA 3 A_Chase();
            ROSE A 0 A_Jump(64,1,11,28);
            Loop;
            ROSE BBCC 3 A_Chase();
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
            ROSE BBCCDD 3 A_Chase();
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
            ROSE BBCCDDEE 3 A_Chase();
            ROSE EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Loop;
        Missile:
            ROSE B 1 A_JumpIfInventory("WeedSpores", 3, "See");
            ROSE A 0 A_Jump(64,14,32);
            ROSE BBCC 3;
            ROSE A 0;
            ROSE CCC 1 {
                A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
            ROSE BBCCDD 3;
            ROSE A 0;
            ROSE DD 1 {
                A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0,SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
            ROSE BBCCDDEE 3;
            ROSE A 0;
            ROSE EE 1 {
                A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
                A_JumpIfInventory ("WeedSpores", 3, "See");
                A_GiveInventory ("WeedSpores", 1);
            }
            ROSE EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            ROSE BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
            Goto See;
        Death:
            ROSE F 5;
            ROSE F 1 /*ACS_NamedExecuteAlways("ExpGain",0,96,0,0)*/;         //Gain 96 Exp. 
            ROSE G 5 A_Scream();
            ROSE H 5 A_Fall();
            ROSE I 5 A_KillMaster();
            ROSE J 5;
            ROSE K 103;
            ROSE K 0 A_KillMaster();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSE K -1;
            Stop;
        XDeath:
            ROSE L 5;
            ROSE L 1 /*ACS_NamedExecuteAlways("ExpGain",0,96,0,0)*/;         //Gain 96 Exp. 
            ROSE M 5 A_XScream();
            ROSE N 5 A_Fall();
            ROSE O 5 A_KillMaster();
            ROSE PQ 5;
            ROSE R 98;
            ROSE R 0 A_KillMaster();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSE R -1;
            Stop;
	}
}

class HellroseBramble : wosMonsterBase {
    Default {
        height 64;
        radius 20;
        speed 12;
        FastSpeed 24;
        Health 50;
        Mass 5000;
        meleedamage 2;
        meleerange 52;
        BloodColor "0 50 0";
        Painchance 128;
        MONSTER;
        -SHOOTABLE;
        -SOLID;
        -COUNTKILL;
        +NOTARGETSWITCH;
        +NOICEDEATH;
        +FLOORCLIP;
        +LOOKALLAROUND;
        /*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 0.8
	DamageFactor "hornet", 0.0
        	DamageFactor "Fire", 1.5
        	DamageFactor "FireCannon", 1.5
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	DamageFactor "P_FireExplode", 1.5
        	DamageFactor "Ice", 1.25
        	DamageFactor "Lightning", 1.0
	DamageFactor "P_Lightning", 1.0
	DamageFactor "Lighting_Archmage", 1.0
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 1.0
	DamageFactor "MagicVampire", 0.0*/
    }

   States {
        Spawn:
            TNT1 A 0;
            TNT1 A 0 A_UnsetShootable();
            TNT1 A 0 A_UnsetSolid();
            ROSX RST 4 A_Look();
            Loop;
        See:
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX RS 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX TR 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX ST 3 A_Chase();
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            Goto Melee;
        Melee:
            TNT1 A 0 A_SetShootable();
            TNT1 A 0 A_SetSolid();
            ROSX RQ 4;
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt2", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt1", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX R 0 A_SpawnItemEx("Drt3", 0, 0, 0, 5, 0, 3, Random(0, 360), 128);
            ROSX P 4 A_CustomMeleeAttack();
            ROSX ONML 4;
            ROSX ABC 4;
            ROSX D 0 A_FaceTarget();
            ROSX D 0 /*A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee")*/;
            ROSX D 3 A_CustomMeleeAttack();
            ROSX A 0 A_Jump(64,6);
            ROSX EF 5;
            ROSX G 0 A_FaceTarget();
            ROSX G 3 A_CustomMeleeAttack();
            ROSX G 0 A_CPosRefire();
            Goto Melee +14;
            ROSX JKL 4;
            ROSX H 3 A_CustomMeleeAttack();
            ROSX H 0 A_CPosRefire();
            Goto Melee +14;
        FakeMelee:
            ROSX D 3;
            Goto Melee +14;
        Pain:
            ROSX LMNOPQR 3;
            TNT1 A 0 A_UnSetSolid();
            TNT1 A 0 A_UnSetShootable();
            Goto See +30;
        Death:
            ROSX U 5 A_TakeInventory ("WeedSpores", 1, 0, AAPTR_MASTER);
            ROSX V 5 A_Scream();
            ROSX W 5 A_Fall();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            ROSX XRR 5;
            ROSX RRRRRRRRR 2 A_FadeOut (0.1);
            stop;
   }
}

class Spore : actor {
    Default {
        PROJECTILE;
        -NOGRAVITY;
        -NOBLOCKMAP;
        -NOTELEPORT;
        +RANDOMIZE;
        renderstyle "translucent";
        alpha 0.5;
        Radius 2;
        Damage 0;
        //SeeSound "hellrose/dirt";
        Speed 3;
    }    
    States {
        Spawn:
            ROSE A 0 A_SetGravity (0.5);
            ROSE A 0 ThrustThingZ (0, 20, 0, 1);
            goto Death;
        Death:
            ROSE SSS 3;
            ROSE SSSSSS 3 A_FadeOut (0.3);
            Stop;
    }
}

class Drt1 : actor {
    Default {
        PROJECTILE;
        -NOGRAVITY;
        -NOBLOCKMAP;
        -NOTELEPORT;
        +RANDOMIZE;
        Radius 2;
        Damage 0;
        //SeeSound "hellrose/dirt";
        Speed 5;
    }    
    States {
        Spawn:
            DIRT A 0 A_SetGravity (0.5);
            DIRT A 0 ThrustThingZ (0, 15, 0, 1);
            goto See;
        See:
            DIRT ABC 5;
            loop;
        Death:
            DIRT JKL 3;
            Stop;
    }
}
class Drt2 : actor {
    Default {
        PROJECTILE;
        -NOGRAVITY;
        -NOBLOCKMAP;
        -NOTELEPORT;
        +RANDOMIZE;
        Radius 2;
        Damage 0;
        //SeeSound "hellrose/dirt";
        Speed 5;
    }    
    States {
        Spawn:
            DIRT A 0 A_SetGravity (0.5);
            DIRT A 0 ThrustThingZ (0, 15, 0, 1);
            goto See;
        See:
            DIRT DEF 5;
            loop;
        Death:
            DIRT JKL 3;
            Stop;
    }
}
class Drt3 : actor {
    Default {
        PROJECTILE;
        -NOGRAVITY;
        -NOBLOCKMAP;
        -NOTELEPORT;
        +RANDOMIZE;
        Radius 2;
        Damage 0;
        //SeeSound "hellrose/dirt";
        Speed 5;
    }    
    States {
        Spawn:
            DIRT A 0 A_SetGravity (0.5);
            DIRT A 0 ThrustThingZ (0, 15, 0, 1);
            goto See;
        See:
            DIRT GHI 5;
            loop;
        Death:
            DIRT JKL 3;
            Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//-------------------------Hell rose------------------------------------////////
////////////////////////////////////////////////////////////////////////////////
/*class WeedSpores2 : Inventory {
    Default {
        Inventory.MaxAmount 6;
        Mass 0;
    }
}

class HellRose : actor {
    Default {
        Health 350;
        Painchance 0;
        height 72;
        radius 36;
        Mass 5000;
        Speed 0;
        Scale 1.0;
        Obituary "%o is six feet under.";
        BloodColor "50 0 0";
        MONSTER;
        +DONTMORPH;
        +NOICEDEATH;
        +FLOORCLIP;
        +STANDSTILL;
        +LOOKALLAROUND;
        +SHORTMISSILERANGE;
        -CANPUSHWALLS;
        DamageFactor "Normal", 0.8
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 0.8
        	DamageFactor "NormalCrush", 0.5
	DamageFactor "hornet", 0.0
        	DamageFactor "Fire", 1.25
        	DamageFactor "FireCannon", 1.25
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	DamageFactor "P_FireExplode", 1.25
        	DamageFactor "Ice", 1.250
        	DamageFactor "Lightning", 1.0
	DamageFactor "P_Lightning", 1.0
	DamageFactor "Lighting_Archmage", 1.0
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 1.0
	DamageFactor "MagicVampire", 0.0
    }
	States {
	Spawn:
		ROSF AAAB 10 A_Look
		Loop
	See:
		ROSF AAA 3 A_Chase();
		ROSF A 0 A_Jump(64,"See2","See3","See4")
		Goto See
	See2:
		ROSF BBCC 3 A_Chase();
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		Goto See
	See3:
		ROSF BBCCDD 3 A_Chase();
		ROSF DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		Goto See
	See4:
		ROSF BBCCDDEE 3 A_Chase();
		ROSF EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		Goto See
	Missile:
		ROSF B 0
		ROSF B 0 A_Jump(128,"SnakePoison")
		ROSF B 1 A_JumpIfInventory("WeedSpores2", 6, "See")
		ROSF A 0 A_Jump(64,"Spore2","Spore3")
		ROSF BBCC 3
		ROSF A 0 
		ROSF CCC 1 
		{
		A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
		A_JumpIfInventory ("WeedSpores2", 6, "See");
		A_GiveInventory ("WeedSpores2", 1);
		}
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
                	ROSF B 6
                	ROSF B 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",40,0,0)
                	ROSF B 4
		Goto See
	Spore2:
		ROSF BBCCDD 3
		ROSF A 0
		ROSF DD 1 {
		A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0,SXF_SETMASTER);
		A_JumpIfInventory ("WeedSpores2", 6, "See");
		A_GiveInventory ("WeedSpores2", 1);
		}
		ROSF DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
                	ROSF B 6
                	ROSF B 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",40,0,0)
                	ROSF B 4
		Goto See
	Spore3:
		ROSF BBCCDDEE 3
		ROSF A 0 
		ROSF EE 1 {
		A_SpawnitemEx("HellroseBramble", random(0,64), random(0,64), 0, 0, 0, 0, 0, SXF_SETMASTER);
		A_JumpIfInventory ("WeedSpores2", 6, "See");
		A_GiveInventory ("WeedSpores2", 1);
		}
		ROSF EEEE 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF D 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF DDDD 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF C 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF CCC 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF B 3 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
		ROSF BB 0 A_SpawnItemEx("Spore", 0, 0, 56, 2, 0, 2, Random(0, 360), 128);
                	ROSF B 6
                	ROSF B 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",40,0,0)
                	ROSF B 4
		Goto See
	SnakePoison:
		ROSF BCD 3 A_FaceTarget
		ROSF E 3 A_SpawnProjectile ("SnakePoisonBall",40,0,0)
		ROSF B 4
		Goto See
	Death:
		ROSF F 5
		ROSF F 1 ACS_NamedExecuteAlways("ExpGain",0,180,0,0)          //Gain 180 Exp. 
		ROSF G 5 A_Scream
		ROSF H 5 A_Fall
		ROSF I 5 A_KillMaster
		ROSF J 5
		ROSF K 103
		ROSF K 0 A_KillMaster
		ROSF K -1
		Stop
	XDeath:
		ROSF L 5 
		ROSF L 1 ACS_NamedExecuteAlways("ExpGain",0,180,0,0)          //Gain 180 Exp. 
		ROSF M 5 A_XScream
		ROSF N 5 A_Fall
		ROSF O 5 A_KillMaster
		ROSF PQ 5
		ROSF R 98
		ROSF R 0 A_KillMaster
		ROSF R -1
		Stop
	}
}*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//--------------------------Giant Eel---------------------------------------////
////////////////////////////////////////////////////////////////////////////////
class wosGiantEel : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Giant Eel"
        Tag "$T_wosGiantEel";
        Obituary "%o is a meal for Giant Eel.";
        Health 30;
        Radius 16;
        Height 24;
        Mass 15;
        Speed 8;
        FastSpeed 16;
        Scale 0.35;
        BloodColor "Blue";
        PainChance 192;
        DeathSound "Eel/Death";
        Monster;
        +NoGravity
        //  +Float;
        +DONTHARMSPECIES
        -CANPUSHWALLS
        -CANUSEWALLS
        -ACTIVATEMCROSS
        +NOTRIGGER
        +NOINFIGHTING
        +PUSHABLE
        +NOICEDEATH
        //DamageFactor "Normal", 1.0
	    //DamageFactor "NormalFist", 0.5
        //DamageFactor "NormalHit", 1.0
        //DamageFactor "NormalCrush", 1.5
	    //DamageFactor "hornet", 0.0
        //DamageFactor "Fire", 1.5
        //DamageFactor "FireCannon", 1.5
        //DamageFactor "Cannonball1", 1.0
        //DamageFactor "Cannonball2", 1.0
	    //DamageFactor "P_FireExplode", 1.5
        //DamageFactor "Ice", 0.5
        //DamageFactor "Lightning", 1.25
	    //DamageFactor "P_Lightning", 1.25
	    //DamageFactor "Lighting_Archmage", 1.25
        //DamageFactor "Gas", 0.0
        //DamageFactor "Poison", 0.0
        //DamageFactor "Magic", 1.0
	    //DamageFactor "MagicVampire", 1.0
    }
    States {
        Spawn:
            EEL1 AA 1 A_JumpIf(waterlevel < 1, "FlyDown");
            EEL1 A 0  A_ChangeVelocity (random(-3, 3)*0.2, random(-3, 3)*0.2, random(-3, 3)*0.2, CVF_REPLACE);
            EEL1 AA 2 A_Look();
            EEL1 BB 1 A_JumpIf(waterlevel < 1, "FlyDown");
            EEL1 A 0  A_ChangeVelocity (random(-3, 3)*0.2, random(-3, 3)*0.2, random(-3, 3)*0.2, CVF_REPLACE);
            EEL1 BB 2 A_Look();
            Loop;
        FlyDown:
            EEL1 A 0;
            EEL1 A 1 A_ChangeVelocity (0, 0, -1, CVF_REPLACE);
            goto Spawn;
        See:
            EEL1 AA 1 A_JumpIf(waterlevel < 1, "FlyDown2");
            EEL1 A 0  A_ChangeVelocity (random(-3, 3)*0.2, random(-3, 3)*0.2, random(-3, 3)*0.2, CVF_REPLACE);
            EEL1 AA 2 A_Chase();
            EEL1 BB 1 A_JumpIf(waterlevel < 1, "FlyDown2");
            EEL1 A 0  A_ChangeVelocity (random(-3, 3)*0.2, random(-3, 3)*0.2, random(-3, 3)*0.2, CVF_REPLACE);
            EEL1 BB 2 A_Chase();
            Loop;
        FlyDown2:
            EEL1 A 0;
            EEL1 A 1 A_ChangeVelocity (0, 0, -1, CVF_REPLACE);
            goto See;
        Melee:
            EEL1 C 3 A_FaceTarget();
            EEL1 C 0 A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee");
            EEL1 D 3 A_CustomMeleeAttack(random(1,4),"H2Spider/Melee","");
            EEL1 AA 1 A_JumpIf(waterlevel < 1, "FlyDown2");
            Goto See;
        FakeMelee:
            EEL1 D 3 A_CustomMeleeAttack(0,"H2Spider/Melee","");
            EEL1 AA 1 A_JumpIf(waterlevel < 1, "FlyDown2");
            Goto See;
        Pain:
            EEL1 B 2;
            EEL1 AA 1 A_JumpIf(waterlevel < 1, "FlyDown2");
            EEL1 A 0  A_ChangeVelocity (random(-3, 3)*0.2, random(-3, 3)*0.2, random(-3, 3)*0.2, CVF_REPLACE);
            Goto See;
        Death:
            EEL1 E 5;
            EEL1 E 1 W_rewardXP(SpawnHealth());
            EEL1 F 5 A_Scream();
            EEL1 G 5 A_NoBlocking();
            EEL1 H 5;
            EEL1 I -1;
            Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//--------------------------FieryBeast-----------------------///////////////////
////////////////////////////////////////////////////////////////////////////////
class FieryBeast : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Fiery Beast"
        Tag "$T_FieryBeast";
        OBITUARY "%o was killed by a fiery beast.";
        Health 1200;
        Radius 40;
        Height 80;
        Mass 500;
        Speed 16;
        FastSpeed 32;
        PainChance 48;
        SEESOUND "shadowbeast/sight";
        PAINSOUND "shadowbeast/pain";
        DEATHSOUND "shadowbeast/death";
        ACTIVESOUND "shadowbeast/active";
        //DropItem "MoneyXLBag" 256;
        //DropItem "MoneyMediumBag" 128;
        MONSTER;
        +FloorClip;
        /*DamageFactor "Normal", 0.75
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 0.75
        	DamageFactor "NormalCrush", 0.75
	DamageFactor "hornet", 1.0
        	DamageFactor "Fire", 0.75
        	DamageFactor "FireCannon", 1.0
        	DamageFactor "Cannonball1", 0.25
        	DamageFactor "Cannonball2", 0.1
	DamageFactor "P_FireExplode", 1.0
        	DamageFactor "Ice", 0.25
        	DamageFactor "Lightning", 1.0
	DamageFactor "P_Lightning", 0.25
	DamageFactor "Lighting_Archmage", 0.25
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.5
        	DamageFactor "Magic", 0.5
	DamageFactor "MagicVampire", 0.0*/
    }
    states {
        Spawn:
            BLDD AB 10 A_Look();
            Loop;
        See:
            TNT1 A 0 A_JumpIfHealthLower (250, "Run");
            BLDD ABCDEF 6 A_Chase();
            Loop;
        Run:
            TNT1 A 0 A_StartSound("shadowbeast/sight");
            BLDD ABCDEF 2 A_Chase();
            BLDD ABCDEF 2 A_Chase();
            BLDD ABCDEF 2 A_Chase();
            Goto Missile;
        Missile:
            TNT1 A 0 A_JumpIfHealthLower (250, "Missile2");
            TNT1 A 0 A_Jump(90, 5);
            BLDD H 6 A_FaceTarget();
            BLDD I 0 A_SpawnProjectile ("FieryBeastBall", 56, 0, -8);
            BLDD I 6 A_SpawnProjectile ("FieryBeastBall", 56, 0, 8);
            BLDD I 0 A_SpawnProjectile ("FieryBeastBall", 56, 0, 0);
            Goto See;
            BLDD H 4 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, -16);
            BLDD I 0 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, -8);
            BLDD I 0 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, 0);
            BLDD I 0 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, 8);
            BLDD I 0 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, 16);
            BLDD I 0 A_FaceTarget();
            BLDD I 4 A_SpawnProjectile ("FieryBeastBall", 56, 0, 32);
            Goto See;
        Missile2:
            TNT1 A 0 A_JumpIfCloser (350, 1);
            Goto Wave;
            BLDD H 6 A_FaceTarget();
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            BLDD I 2 A_SpawnProjectile ("FieryBeast_BallFire", 56, 0, random(-8,8));
            Goto See;
        Wave:
            BLDD H 16 A_FaceTarget();
            BLDD I 0 A_SpawnProjectile ("FieryBeastFireWave", 0, 0, 0);
        /* BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 64)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -56)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 56)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -48)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 48)    
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -40)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 40)    
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -32)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 32)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -24)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 24)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -16)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 16)    
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, -8)
            BLDD I 0 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 8)    
            BLDD I 6 A_SpawnProjectile ("ShadowBeast_Ball3", 56, 0, 0)*/
            Goto See;
        Pain:
            TNT1 A 0 A_Jump (16, "Spread");
            BLDD G 4 A_Pain();
            Goto See;
        Death:
            BLDD J 8;
            BLDD K 8 A_Scream();
            BLDD LMNOP 6;
            BLDD Q 6 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
            BLDD R -1;
            Stop;
        Ice:
            "####" "#" 1 /*ACS_NamedExecuteAlways("ExpGain",0,1000,0,0)*/;	//Gain 1000 Exp 
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
        Spread:
            TNT1 A 0 A_SpawnItemEx ("FieryBeast_Spread", 0, 0, 0, 0, 0, 0, 0, 128);
            //TNT1 AAAAAAAAAAAAA 0 A_SpawnItemEx ("ShadowBeast_Sparkle", random(0,16), random(0,16), random(16,48), 0, 0, 0, random(0,359), 128);
            TNT1 AAAAA 0 A_SpawnItemEx ("FieryBeast", 0, 0, random(16,48), random(0,8), random(0,8), random(0,8), random(0,359), 0);
            TNT1 A 0 A_SetTranslucent (0.0);
            Goto Wander;
        Wander:
            TNT1 A 0 A_UnSetShootable();
            //TNT1 A 0 A_ChangeFlag("NoPain", 1);
            TNT1 A 0 { bNOPAIN = true; }
            TNT1 A 0 A_Jump(60, 5);
            TNT1 A 0 A_Jump(60, 15);
            TNT1 A 0 A_Jump(60, 25);
            TNT1 A 0 A_Jump(60, 35);
            TNT1 A 0 A_Jump(60, 45);
            TNT1 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA 2 A_Wander();
            BLDD A 3 A_Wander();
            BLDD A 0 A_SetTranslucent (0.2);
            BLDD B 3 A_Wander();
            BLDD A 0 A_SetTranslucent (0.4);
            BLDD C 3 A_Wander();
            BLDD A 0 A_SetTranslucent (0.6);
            BLDD D 3 A_Wander();
            BLDD A 0 A_SetTranslucent (0.75);
            BLDD E 3 A_Wander();
            BLDD A 0 A_SetTranslucent (0.8);
            BLDD F 3 A_Wander();
            BLDD A 0 A_SetTranslucent (1.0);
            TNT1 A 0 A_SetShootable();
            //TNT1 A 0 A_ChangeFlag("NoPain", 0);
            TNT1 A 0 { bNoPain = false; }
            Goto See;
    }
}
class FieryBeast_Spread : actor {   
    Default {
        Radius 1;
        Height 1;
        Damage 0;
        Speed 0;
        PROJECTILE;
    }	
	states {
		Spawn:
		    TNT1 A 0;
		    TNT1 A 0 A_StartSound ("shadowbeast/spread");
		    BLDD STUVWXY 8;
	        BLDD Z 70;
		Death:
	        BLDD Z 1 A_FadeOut(0.1);
		    Loop;
	}
}
class FieryBeastFireWave : actor {
    Default {
        Projectile;
        Speed 20;
        FastSpeed 40;
        Alpha 0.75;
        RenderStyle "Translucent";
        +FLOORHUGGER;
        +FLOORCLIP;
        +RANDOMIZE;
        Damage 15;
        DamageType "Disintegrate";
        SeeSound "fierybeast/waveshot";
        DeathSound "fierybeast/waveexp";
        +BRIGHT;
        Radius 10;
        Height 5;
    }	
	States {
        Spawn:
            HBFR AABBCC 6 A_SpawnItemEx ("WaveFireTrail", 0, 6, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION);
            Loop;
        Death:
            HBFR DEFGH 4;
            Stop;
	}
}	
class WaveFireTrail : actor {
    Default {
        +NOINTERACTION;
        RenderStyle "Translucent";
        +BRIGHT;
        Alpha 0.75;
        +RANDOMIZE;
    }	
	States {
        Spawn:
            TRGF ABCD 3;
        Death:
            TRGF ABCD 2 A_FadeOut (0.01);
            Loop;
	}
}
class FieryBeastBall : actor {
    Default {
        Alpha 1.0;
        Renderstyle "Add";
        Speed 25;
        FastSpeed 50;
        Radius 10;
        Height 6;
        Damage 10;
        DamageType "Fire";
        Projectile;
        +SPAWNSOUNDSOURCE;
        RenderStyle "Add";
        SeeSound "fierybeast/fire";
        DeathSound "shadowbeast/pr1death";
    }
  
    States {
        Spawn:
            DMFX ABC 4 Bright;
            Loop;
        Death:
            DMFX DE 4 Bright;
            DMFX FGH 3 Bright;
            Stop;
    }
}
class FieryBeast_BallFire : actor {
    Default {
        Alpha 1.0; 
        Renderstyle "Add";
        Speed 15;
        FastSpeed 30;
        Radius 10;
        Height 6;
        Damage 2;
        DamageType "Fire";
        Projectile;
        +RIPPER;
        RenderStyle "Add";
        SeeSound "fierybeast/fire";
        //Decal "MummyScorch";
    }
  
    States {
        Spawn:
            DMFX DEFGH 5 Bright;
            Goto Death;
        Death:
            TNT1 A 0;
            Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
//-------------------------Lizard-------------------------------------------////
////////////////////////////////////////////////////////////////////////////////
class Lizard : wosMonsterBase {
    Default {
        MONSTER;
        +FLOORCLIP;
        	/*DamageFactor "Normal", 1.0
	    DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
	    DamageFactor "hornet", 1.0
        	DamageFactor "Fire", 1.25
        	DamageFactor "FireCannon", 1.0
        	DamageFactor "Cannonball1", 0.25
        	DamageFactor "Cannonball2", 0.1
	    DamageFactor "P_FireExplode", 1.25
        	DamageFactor "Ice", 0.5
        	DamageFactor "Lightning", 1.25
	    DamageFactor "P_Lightning", 1.25
	    DamageFactor "Lighting_Archmage", 1.25
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 1.25
	    DamageFactor "MagicVampire", 0.5*/
        SeeSound "monster/lizardsee";
        PainSound "monster/lizardpain";
        DeathSound "monster/lizarddeath1";
        ActiveSound "monster/lizardidle";
        // MeleeSound "monster/ghlhit" **should be actual swipe sound**;
        Obituary "%o was actuated by a FellBeast's acid.";
        HitObituary "%o was mauled by a FellBeast.";
    }
    
    States {
        Spawn:
            LIZR A 10 A_Look();
            Loop;
        See:
            LIZR ABCD 2 A_Chase();
            Loop;
        Melee:
            LIZR FG 2 A_FaceTarget();
            LIZR H 0 /*A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee")*/;
            LIZR H 0 A_StartSound ("monster/lizardattack");
            LIZR H 4 A_CustomMeleeAttack();
            LIZR H 0 A_Jump (192,1);
            LIZR GF 4;
            Goto See;
        FakeMelee:
            LIZR H 0 A_StartSound ("monster/lizardattack");
            LIZR H 4;
            LIZR H 0 A_Jump (192,1);
            LIZR GF 4;
            Goto See;
        Pain:
            LIZR E 4;
            LIZR E 4 A_Pain();
            Goto See;
        DEATH:
            LIZR L 0 A_StartSound("monster/lizarddeath2");
            LIZR L 4;
            LIZR M 4 A_XScream();
            LIZR N 4 A_NoBlocking(); 
            LIZR OPQRS 4; 
            LIZR T -1;
        Raise: 
            CULT MLKJHI 5;
            Goto See;
    }
}

class LizardSmall: Lizard {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Lizard Small"
        Tag "$T_LizardSmall";
        Health 50;
        Radius 16;
        Height 24;
        Scale 0.5;
        Speed 5;
        //FastSpeed 35;
        PainChance 50;
        Mass 100;
        MeleeDamage 1;
    }
    
    States {
        See:
            LIZR ABCD 2 A_FastChase();
            Loop;
        Death:
            LIZR L 0 A_StartSound("monster/lizarddeath2");
            LIZR L 4;
            LIZR M 4 A_XScream();
            LIZR N 4 A_NoBlocking(); 
            LIZR OPQRS 4;
            LIZR S 1;
            LIZR T -1;
            Stop;
        Ice:
            "####" "#" 1 ;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
    }
}

class LizardMiddle : Lizard {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Lizard Middle"
        Tag "$T_LizardMiddle";
        Health 200;
        Radius 24;
        Height 48;
        Scale 1;
        Speed 6;
        //FastSpeed 30;
        PainChance 30;
        Mass 200;
        MeleeDamage 3;
        //DropItem "MoneySmallBag" 256;
    }
    
    states {
        Missile:
            LIZR E 6 A_FaceTarget();
            LIZR E 0 Bright A_StartSound("monster/lizardidle");
            LIZR E 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",40,0,0);
            LIZR E 4;
            Goto See;
        Death:
            LZXD A 4;
            LZXD B 4 A_Scream();
            LZXD C 4;
            LZXD D 4 A_Fall();
            LZXD EFGHIJ 4;
            LZXD J 1;
            LZXD K -1;
            Stop;
        Ice:
            "####" "#" 1;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
        XDEATH:
            LIZR L 0 A_StartSound("monster/lizarddeath2");
            LIZR L 4;
            LIZR M 4 A_XScream();
            LIZR N 4 A_NoBlocking(); 
            LIZR OPQRS 4;
            LIZR S 1 /*ACS_NamedExecuteAlways("ExpGain",0,120,0,0)*/;          //Gain 120 Exp.	
            LIZR T -1;
    }
}


class LizardLarge : Lizard {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Lizard Large"
        Tag "$T_LizardLarge";
        Health 500;
        Radius 24;
        Height 64;
        Scale 1.5;
        Speed 7;
        //FastSpeed 25;
        PainChance 20;
        Mass 300;
        MeleeDamage 5;
        //DropItem "MoneyLargeBag" 256;
    }
    
    states {
        See:
            LIZR ABCD 4 A_Chase();
            Loop;
        Missile:
            LIZR E 6 A_FaceTarget();
            LIZR E 0 Bright A_StartSound("monster/lizardidle");
            LIZR E 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",52,0,30);
            LIZR E 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",52,0,-30);
            LIZR E 0 BRIGHT A_SpawnProjectile ("SnakePoisonBall",52,0,0);
            LIZR E 4;
            Goto See;
        Charge:
            LIZR H 1 A_StartSound ("monster/lizardsee");
            LIZR H 4 A_SkullAttack (25);
            LIZR H 4 A_SkullAttack (25);     
            LIZR H 4 A_SkullAttack (25);     
            LIZR H 4 A_SkullAttack (25);
            LIZR H 4 A_SkullAttack (25); 
            LIZR H 4 A_SkullAttack (25);
            LIZR H 4 A_SkullAttack (25);
            LIZR H 4 A_SkullAttack (25); 
            LIZR H 0 A_Stop();
            LIZR H 1;
            Goto See;
        Death:
            LZXD A 4;
            LZXD B 4 A_Scream();
            LZXD C 4;
            LZXD D 4 A_Fall();
            LZXD EFGHIJ 4;
            LZXD J 1;
            LZXD K -1;
            Stop;
        Ice:
            "####" "#" 1 /*ACS_NamedExecuteAlways("ExpGain",0,500,0,0)*/;	//Gain 500 Exp 
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//-------------------------Ophidiant-----------------------------------------///
////////////////////////////////////////////////////////////////////////////////
class Ophidiant : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Snakeman"
        Tag "$T_Ophidiant";        
        obituary "%o was bruised by an Ophidiant.";
        hitobituary "%o was ripped open by an Ophidiant.";
        health 260;
        radius 24;
        height 64;
        mass 800;
        speed 8;
        FastSpeed 16;
        painchance 50;
        seesound "snake/sight";
        painsound "snake/pain";
        deathsound "snake/death";
        activesound "snake/active";
        attacksound "snake/attack";
        MONSTER;
        +FLOORCLIP;
        //DropItem "MoneyMediumBag" 256;
        	/*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
	DamageFactor "hornet", 1.0
        	DamageFactor "Fire", 1.25
        	DamageFactor "FireCannon", 1.0
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	DamageFactor "P_FireExplode", 1.25
        	DamageFactor "Ice", 0.5
        	DamageFactor "Lightning", 1.0
	DamageFactor "P_Lightning", 1.0
	DamageFactor "Lighting_Archmage", 1.0
        	DamageFactor "Gas", 0.0
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 0.75
	DamageFactor "MagicVampire", 0.0*/
  
    }
  
    states {
        Spawn:
            OOS2 AB 10 A_Look();
            loop;
        See:
            OOS2 AABBCCDD 3 A_Chase();
            loop;
        Melee:
            OOS2 E 6 A_FaceTarget();
            OOS2 F 4 A_FaceTarget();
            OOS2 F 2 A_StartSound("snake/attack");
            OOS2 G 6 A_SpawnProjectile("SnakePoisonBall", 32,0,0);
            goto See;
        Missile:
            OOS2 EF 6 A_FaceTarget();
            OOS2 G 6 A_SpawnProjectile("SnakePoisonBall", 32,0,0);
            goto See;
        Pain:
            OOS2 H 2;
            OOS2 H 2 A_Pain();
            goto See;
        Death:
            OOS2 I 8;
            OOS2 J 8 A_Scream();
            OOS2 K 8;
            OOS2 L 8 A_NoBlocking();
            OOS2 MN 8;
            OOS2 N 1;
            OOS2 O -1;
            stop;
            Ice:
                "####" "#" 1;
                "####" "#" 5 A_GenericFreezeDeath();
                "####" "#" 1 A_FreezeDeathChunks();
                Wait;
        Raise:
            OOS2 ONMLKJI 8;
            goto See;
    }
}
class SnakePoisonBall : actor {
    Default {
        Radius 8;
        Height 16;
        Speed 15;
        FastSpeed 30;
        Damage 5;
        Poisondamage 45;
        DamageType "Poison";
        scale 2.0;
        deathsound "imp/shotx";
        scale 0.6;
        PROJECTILE;
        RENDERSTYLE "ADD";
        ALPHA 0.65;
    }    
    States {
    	Spawn:
        	OPBL AB 4 bright;
        	Loop;
    	Death:
        	OPBL CDEFGH 4 bright;
        	Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//-------------------------PIT LORD-------------------------------------------//
////////////////////////////////////////////////////////////////////////////////
class wosPitLord : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Pit Lord"
        Tag "$T_wosPitLord";
        Health 600;
        Radius 32;
        Height 74;
        Mass 200;
        Speed 14;
        FastSpeed 28;
        Painchance 100;
        Monster;
        +FLOORCLIP;
        +Missilemore;
        SeeSound "pfiend/sight";
        AttackSound "pfiend/attack";
        PainSound "pfiend/pain";
        DeathSound "pfiend/death";
        ActiveSound "pfiend/active";
        Obituary "%o was burned by a Pit Lord's fire.";
        //DropItem "MoneyMediumBag" 256;
        /*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
	DamageFactor "hornet", 1.0
        	DamageFactor "Fire", 0.5
        	DamageFactor "FireCannon", 0.25
        	DamageFactor "Cannonball1", 0.5
        	DamageFactor "Cannonball2", 0.25
	DamageFactor "P_FireExplode", 0.5
        	DamageFactor "Ice", 1.5
        	DamageFactor "Lightning", 1.25
	DamageFactor "P_Lightning", 1.25
	DamageFactor "Lighting_Archmage", 1.25
        	DamageFactor "Gas", 0.5
        	DamageFactor "Poison", 0.5
        	DamageFactor "Magic", 0.75
	DamageFactor "MagicVampire", 0.0*/
    }
	States {
        Spawn:
            DRG1 AB 10 A_Look();
            Loop;
        See:
            DRG1 ABCDEF 3 A_Chase();
            Loop;
        Missile:
            DRG1 G 0;
            TNT1 A 0 A_JumpIfCloser(256, "FireBreath");
            DRG1 G 0 A_Jump(128,4);
            DRG1 G 0 A_Jump(128,7);
            DRG1 G 8 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            Goto See;
            DRG1 G 8 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 2 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            Goto See;
            DRG1 G 6 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 2 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 2 A_FaceTarget();
            //DRG1 H 8 A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG1 H 8 A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            Goto See;
        FireBreath:
            DRG1 GG 4 A_FaceTarget();
            DRG1 G 0 A_StartSound("WEAPONS/UFLAME");
            DRG1 HHHHHHHHHH 1 A_SpawnProjectile ("PitFiendFlameBurst", 40, 0, 0);
            Goto See;
        Pain:
            DRG1 I 3;
            DRG1 I 0 A_Jump(128,2);
            DRG1 I 3 A_Pain();
            Goto See;
            DRG1 I 3 A_Pain();
            Goto Missile+4;
        Death:
            DRG1 J 6;
            DRG1 K 6 A_Scream();
            DRG1 LMN 6;
            DRG1 O 6 A_NoBlocking();
            DRG1 PQ 6;
            DRG1 Q 1;
            DRG1 R -1;
            Stop;
        Ice:
            "####" "#" 1;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
	}
}
class PitFiendFlameBurst : actor {
    Default {
        Speed 18;
        FastSpeed 36;
        Damage 3;
        Radius 8;
        Height 8;
        PROJECTILE;
        RENDERSTYLE "ADD";
        damagetype "fire";
        SeeSound "WEAPONS/UFLAME";
    }   
    States {
        Spawn:
            TOZS ABCDEFGHI 2 Bright;
            Stop;

        Death:
            TOZS FGHI 2;
            Stop;
        }
}
class PitFiendBall : actor {
    Default {
        Radius 10;
        Height 8;
        Speed 15;
        FastSpeed 20;
        Damage 4;
        DamageType "fire";
        Projectile;
        -ACTIVATEIMPACT;
        -ACTIVATEPCROSS;
        -NOBLOCKMAP;
        +WINDTHRUST;
        +SPAWNSOUNDSOURCE;
        RenderStyle "Add";
        SeeSound "pfiend/attack";
    }
	
	States {
        Spawn:
            FBL8 AABBCC 2 bright A_SpawnProjectile("PitFiendBallTrail",0,0,0);
            Loop;
        Death:
            FBL8 DEFGH 4;
            Stop;
	}
}
class PitFiendBallTrail : actor {
    Default {
        RENDERSTYLE "Translucent";
        Alpha 0.5;
        +NOBLOCKMAP;
        +NOGRAVITY;
    }    
    States {
        Spawn:
            FBL8 DEFGH 4;
            Stop;
    }
}

////////////////////////////////////////////////////////////////////////////////
//-------------------------PIT FIEND------------------------------------------//
////////////////////////////////////////////////////////////////////////////////
class wosPitFiend : wosPitLord {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Pit Fiend"
        Tag "$T_wosPitFiend";
        Health 250;
	    Obituary "%o was burned by a Pit Fiend's fire.";
        -Missilemore;
        //DropItem "MoneyMediumBag" 192;
    }
	States {
        Spawn:
            DRG3 AB 10 A_Look();
            Loop;
        See:
            DRG3 ABCDEF 3 A_Chase();
            Loop;
        Missile:
            DRG3 H 0;
            TNT1 A 0 A_JumpIfCloser(256, "FireBreath");
            DRG3 H 8 A_FaceTarget();
            //DRG3 I 8 Bright A_CustomComboAttack("PitFiendBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            DRG3 I 8 Bright A_CustomComboAttack("SnakePoisonBall", 36, random[pfiendAttack](1,8)*3, "pfiend/attack");
            Goto See;
        FireBreath:
            DRG3 HH 4 A_FaceTarget();
            DRG3 H 0 A_StartSound("WEAPONS/UFLAME");
            DRG3 IIIIIIII 1 A_SpawnProjectile ("PitFiendFlameBurst", 40, 0, 0);
            Goto See;
        Pain:
            DRG3 G 3;
            DRG3 G 3 A_Pain();
            Goto See;
        Death:
            DRG3 J 6;
            DRG3 K 6 A_Scream();
            DRG3 LMN 6;
            DRG3 O 6 A_NoBlocking();
            DRG3 PQ 6;
            DRG3 P 1;
            DRG3 R -1;
            Stop;
        Ice:
            "####" "#" 1; 
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
	}
}

////////////////////////////////////////////////////////////////////////////////
//------------------PLAGUE FIEND-------------------------------------///////////
////////////////////////////////////////////////////////////////////////////////

class wosPlagueFiend : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Plague fiend"
        Tag "$T_wosPlagueFiend";
        Health 350;
        Radius 32;
        Height 74;
        Mass 200;
        Speed 14;
        FastSpeed 28;
        Painchance 100;
        Monster;        
        +FLOORCLIP;
        SeeSound "pfiend/sight";
        AttackSound "pfiend/attack";
        PainSound "pfiend/pain";
        DeathSound "pfiend/death";
        ActiveSound "pfiend/active";
        Obituary "%o was poisonous by a Plague fiend.";
        //DropItem "MoneyMediumBag" 256;
        /*DamageFactor "Normal", 1.0
	    DamageFactor "NormalFist", 0.5
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
	    DamageFactor "hornet", 1.0
        	DamageFactor "Fire", 0.75
        	DamageFactor "FireCannon", 0.5
        	DamageFactor "Cannonball1", 0.5
        	DamageFactor "Cannonball2", 0.25
	    DamageFactor "P_FireExplode", 0.75
        	DamageFactor "Ice", 1.25
        	DamageFactor "Lightning", 1.0
	    DamageFactor "P_Lightning", 1.0
	    DamageFactor "Lighting_Archmage", 1.0
        	DamageFactor "Gas", 0.0
        	DamageFactor "Poison", 0.0
        	DamageFactor "Magic", 0.75
	    DamageFactor "MagicVampire", 0.0*/
    }
	
        	
	States {
        Spawn:
            DRG2 AB 10 A_Look();
            Loop;
        See:
            DRG2 ABCD 3 A_Chase();
            Loop;
        Missile:
            DRG2 F 0;
            TNT1 A 0 A_JumpIfCloser(256, "PoisonBreath");
            DRG2 F 8 A_FaceTarget();
            DRG2 E 8 A_CustomComboAttack("PlagueFiendBall", 40, random[pfiendAttack](1,8)*3, "pfiend/attack");
            Goto See;
        PoisonBreath:
            DRG2 FF 4 A_FaceTarget();
            DRG2 EEEEEEEEEE 1 Bright A_SpawnProjectile ("PlagueFiendPoison", 48, 0, 0);
            Goto See;
        Pain:
            DRG2 G 3;
            DRG2 G 3 A_Pain();
            Goto See;
        Death:
            DRG2 H 6;
            DRG2 I 6 A_Scream();
            DRG2 JK 6;
            DRG2 K 0 A_Jump(128,2);
            DRG2 K 0 A_SpawnProjectile("ToxinCloud", 32,0,0,0,0);
            DRG2 L 6 A_NoBlocking();
            DRG2 M 6;
            DRG2 M 1;
            DRG2 N -1;
            Stop;
        Ice:
            "####" "#" 1;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
	}
}
class PlagueFiendPoison : actor {
    Default {
        Radius 4;
        Height 6;
        Speed 18;
        FastSpeed 36;
        DamageFunction (Random(1,8));
        Poisondamage 15;
        DamageType "Poison";
        PROJECTILE;
        RENDERSTYLE "ADD";
        ALPHA 0.8;
        SeeSound "Undead/gas";
    }
	
	States {
        Spawn:
            FBL5 ABCDEFGHIJKLMNOP 1 Bright;
            Stop;
        Death:
            FBL5 HIJKLMNOP 1 Bright;
            Stop;
	}
}
class PlagueFiendBall : actor {
    Default {
        Radius 8;
        Height 8;
        Speed 15;
        FastSpeed 30;
        DamageFunction (random(1,8)*3);
        Poisondamage 2,5,35;
        DamageType "Poison";
        //scale 0.8;
        PROJECTILE;
        +ADDITIVEPOISONDAMAGE;
        //+ADDITIVEPOISONDURATION
        RENDERSTYLE "ADD";
        ALPHA 0.65;
        Seesound "monster/vulsh1";
        DeathSound "monster/vulsh2";
    }
    
    States {
    	Spawn:
        	FBL2 AB 4 bright;
        	Loop;
    	Death:
        	FBL2 CDEF 4 bright;
        	Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//------------------------Dragon-------------------/////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class MiniDragon : wosMonsterBase {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Drake"
        Tag "$T_MiniDragon";
        Health 100;
        Radius 16;
        Height 32;
        Speed 10;
        FastSpeed 20;
        PainChance 100;
        MaxTargetRange 100;
        Monster;
        +NOGRAVITY;
        +FLOAT;
        +STRIFEDAMAGE;
        +NEVERRESPAWN;
        SeeSound "dragonfam/see";
        PainSound "dragonfam/pain";
        DeathSound "dragonfam/death";
        ActiveSound "dragonfam/idle";
        Obituary "%o was cooked by a dragon.";
        /*DamageFactor "Normal", 1.0
	DamageFactor "NormalFist", 1.0
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
        	DamageFactor "Fire", 0.25
        	DamageFactor "FireCannon", 0.1
        	DamageFactor "Cannonball1", 0.1
        	DamageFactor "Cannonball2", 0.1
	DamageFactor "P_FireExplode", 0.1
        	DamageFactor "Ice", 1.75
        	DamageFactor "Lightning", 1.0
	DamageFactor "P_Lightning", 1.0
	DamageFactor "Lighting_Archmage", 1.0
        	DamageFactor "Gas", 0.0
        	DamageFactor "Poison", 1.0
        	DamageFactor "Magic", 1.0
	DamageFactor "MagicVampire", 0.5*/
    }
    States {
        Spawn:
            IMPX ABCD 10 A_Look();
            Loop;
        See:
            IMPX AABBCCDD 3 A_Chase();
            Loop;
        Missile:
            TNT1 A 0 A_JumpIfCloser(270, 1);
            Goto See;
            TNT1 A 0 A_StartSound("dragonfam/attack");
            IMPX E 2 Bright A_CPosRefire();
            TNT1 A 0 A_SpawnProjectile("MiniFirePuffNoDamage", 12, 0, 0);
            IMPX F 2 Bright A_CPosRefire();
            TNT1 A 0 A_SpawnProjectile("MiniFirePuff", 12, 0, Random(1,2));
            IMPX F 2 Bright A_CPosRefire();
            TNT1 A 0 A_SpawnProjectile("MiniFirePuff", 12, 0, Random(-2,-1));
            TNT1 A 0 A_JumpIfCloser(270, 1);
            Goto See;
            TNT1 A 0 A_Jump(48, "See");
            Goto Missile+2;
        Pain:
            IMPX G 2;
            IMPX G 2 A_Pain();
            Goto See;
        Death:
            TNT1 A 0 A_Die();
            IMPX H 8 A_NoBlocking();
            IMPX I 8 A_Scream();
            IMPX J 6 A_SetFloorClip();
            IMPX KLMNO 6;
            IMPX O 1;
            TNT1 A -1;
            Stop;
        Ice:
            "####" "#" 1;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
    }
}
class MiniFirePuff : actor {
    Default {
        Radius 16;
        Height 16;
        Speed 7;
        Damage 1;
        Damagetype "Fire";
        Projectile;
        RenderStyle "Add";
        Alpha 0.67;
    }
    
    States {
        Spawn:
            INFE ABCDEFGHIJ 2 Bright;
        Death:
            INFE KLMNOPQRT 2 Bright;
            Stop;
    }
}
class MiniFirePuffNoDamage : MiniFirePuff {
    Default {
        Damage 0;
    }    
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// serpent fly /////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ascSerpentFly : wosMonsterBase/*actor*/ {
    Default {
		//$Category "Monsters/WoS"
        //$Title "Serpent fly"
        Tag "$T_ascSerpentFly";
		Species "Wasp";
        obituary "%o was stung by a Serpent Fly.";
        health 35;
        radius 16;
        height 40;
        mass 60;
        speed 7;
        FastSpeed 14;
        damageFunction (random(1,6));
        scale 0.26;
        damagetype "hornet";
        maxtargetrange 256;
        bloodcolor "yellow";
        deathsound "Hornet/Death";
        MONSTER;
        +FLOAT;
        +NOGRAVITY;
        +FLOATBOB;
        +NOBLOODDECALS;
        +SPAWNFLOAT;
        +DONTOVERLAP;
        /*damagefactor "hornet", 0
        	DamageFactor "Normal", 1.0
	    DamageFactor "NormalFist", 1.0
        	DamageFactor "NormalHit", 1.0
        	DamageFactor "NormalCrush", 1.0
        	DamageFactor "Fire", 1.5
        	DamageFactor "FireCannon", 1.5
        	DamageFactor "Cannonball1", 1.0
        	DamageFactor "Cannonball2", 1.0
	    DamageFactor "P_FireExplode", 1.5
        	DamageFactor "Ice", 1.0
        	DamageFactor "Lightning", 1.5
	    DamageFactor "P_Lightning", 1.5
	    DamageFactor "Lighting_Archmage", 1.5
        	DamageFactor "Gas", 1.0
        	DamageFactor "Poison", 1.0
        	DamageFactor "Magic", 1.0
	    DamageFactor "MagicVampire", 1.0*/
    }
    
    
    
    states {
        Spawn:
            SFL1 A 1;
            SFL1 A 1 A_StartSound ("Hornet/Fly", CHAN_7, CHANF_DEFAULT, 0.25);
            SFL1 ABBCCDD 2 A_Look();
            loop;
        See:
            SFL1 A 0;
            SFL1 A 0  {
                //A_ChangeFlag("FRIGHTENED",0); 
                bFRIGHTENED = false;
                A_ChangeVelocity (0, 0, 0, CVF_REPLACE); 
                A_SentinelBob();
            }
            SFL1 A 2 A_StartSound ("Hornet/Fly", CHAN_7, CHANF_DEFAULT, 0.25);
            SFL1 A 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 A 2 {
                A_Chase(); 
                A_StartSound ("Hornet/Fly", CHAN_7, CHANF_DEFAULT, 0.45);
            }
            SFL1 A 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 B 2 A_Chase();
            SFL1 B 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 B 2 A_Chase();
            SFL1 B 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 C 2 A_Chase();
            SFL1 C 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 C 2 A_Chase();
            SFL1 C 0 A_JumpIf(waterlevel > 0, "FlyUp"); 
            SFL1 D 2 A_Chase();
            SFL1 D 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 D 2 A_Chase();
            SFL1 D 0 A_JumpIf(waterlevel > 0, "FlyUp");
            Goto See;
        FlyUp:
            SFL1 A 0;
            SFL1 A 0 {
                //A_ChangeFlag("FRIGHTENED",1); 
                bFRIGHTENED = true;
                A_ChangeVelocity (0, 0, 7, CVF_REPLACE); 
                A_SentinelBob();
            }
            SFL1 A 0 A_StartSound ("Hornet/Fly", CHAN_7, CHANF_DEFAULT, 0.45);
            SFL1 AABBCCDDAABBCCDD 2 A_Chase();
            goto See;
        Missile:
            SFL1 E 4 A_FaceTarget();
            SFL1 F 4 A_SkullAttack();
            SFL1 A 0 A_JumpIf(waterlevel > 0, "FlyUp");
            goto Missile+1;
        Melee:
            SFL1 A 0;
            SFL1 A 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 E 4 A_FaceTarget();
            SFL1 A 0 A_JumpIf(waterlevel > 0, "FlyUp");
            SFL1 A 0 /*A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee")*/;
            SFL1 F 4 A_CustomMeleeAttack(Random(1,4)*1,"batfam/idle");
            goto See;
        FakeMelee:
            SFL1 F 4 A_CustomMeleeAttack(0,"batfam/idle");
            goto See; 
        Death:
            SFL1 G 1 A_StopSound (CHAN_7);
            SFL1 G 1;
            //SFL1 H 0 A_ChangeFlag ("FLOATBOB", 0);
            TNT1 A 0 { 
                bFLOATBOB = false;
                //W_rewardXP(SpawnHealth()); 
            }
            SFL1 H 0 A_ScreamAndUnblock();
        Fall:
            SFL1 H 1 A_CheckFloor ("Splat");
            loop;
        Splat:
            SFL1 I 1 A_Stop();
            SFL1 J 0 A_StartSound ("Hornet/Splat");
            SFL1 JKLM 4;
            SFL1 N -1;
            stop;
        Ice:
            "####" "#" 1;
            "####" "#" 5 A_GenericFreezeDeath();
            "####" "#" 1 A_FreezeDeathChunks();
            Wait;
    }
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// tramp - beggar //////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ascTramp : wosMonsterBase {

	int gunmag; //
	int searchtimer; //
	bool searched; //
	bool lootmed; //
	bool lootarm; //
	int lootarm2; //
	bool lootgun; //
	int lootgun2; //
	int lootmoney; //
	bool lootrep; //
	int lootinv;
	//string looteqip; Property Equipment : looteqip; //
	//int looteqip2; //
    
	Override void PostBeginPlay() {
		Super.PostBeginPlay();
		gunmag=30;
		//If(shielded==1){A_SpawnItemEx("LFAcolyteShield",flags: SXF_SETMASTER);}
		If(Random(1,3)==1){lootmed=1;} 
		If(Random(1,8)==1){lootarm=1; lootarm2=Random(15,85);}
		If(Random(1,6)==1){lootinv=1; lootmed=1;} 
		If(Random(1,4)==1){lootrep=1;}
		lootmoney=Random(3,15);
	}

	Override bool Used(Actor user) {
		let pawn = binderPlayer(user);
		If( searched==0 && health<1 && InStateSequence(CurState,ResolveState("Death")) && user is "binderPlayer" && pawn.currentarmor!=7 ) {
			int tosearch = 6 - (2 * pawn.SpeedUpgrade);
			If( searchtimer >= tosearch ) {
				If( lootmed == 1 ){ 
					Actor med = A_DropItem("wosHyposprej"); 
				}
				If( lootarm == 1 ){ 
					Actor arm = A_DropItem("wosArmorShard"); 
				}
				//If( looteqip == "TARG" ){ 
				//	Actor trg = A_DropItem("wosTargeter"); 
				//}
				While( lootmoney > 0 ) {
					If( lootmoney >= 25 ){ 
						A_DropItem("wosGold25"); 
						lootmoney-=25; 
					} Else If( lootmoney >= 10 ){ 
						A_DropItem("wosGold10"); 
						lootmoney-=10; 
					} Else If(lootmoney>=1){
						A_DropItem("goldCoin"); 
						lootmoney--;
					}
				}
				//If( lootinv == 1 ){ Actor gun = A_DropItem("wosAssaultGun"); }
				//Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				A_StartSound("sound/wearClothing");
				searchtimer++;
			}
		}
		Return Super.Used(user);
	}

    Default {
		//$Category "Monsters/WoS"
        //$Title "tramp"
        Tag "Tramp";
        Health 80;
        Radius 20;
        Height 56;
        Mass 100;
        Speed 12;
        FastSpeed 24;
        PainChance 170;
        Monster;
        +FLOORCLIP
        +missilemore
        +missileevenmore
        minmissilechance 2;
        SeeSound "insult";
        PainSound "getpain";
        DeathSound "getdead";
        AttackSound "swordhit";
        ActiveSound "insult";
        Obituary "%o was killed by a tramp.";
    }

    States {
        Spawn:
            BEGR A 10 A_Look();
            Loop;
        See:
            BEGR AABBCC 3 A_Chase();
            Loop;
        Melee:
            BEGR DD 4 A_FaceTarget();
            BEGR D 1 bright A_StartSound("swordmiss");
            BEGR E 7 bright A_Custommeleeattack(random(3,8), "swordhit", "swordmiss", "meleeattack", true);
            BEGR DD 4 A_FaceTarget();
            BEGR D 1 bright A_StartSound("swordmiss");
            //BEGR E 0 A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee");
            BEGR E 7 bright A_Custommeleeattack(random(3,8), "swordhit", "swordmiss", "meleeattack", true);
            Goto See;
        FakeMelee:
            BEGR E 7 bright A_Custommeleeattack(0, "swordhit", "swordmiss", "meleeattack", true);
            Goto See;
        Pain:
            BEGR E 3;
            BEGR E 3 A_Pain();
            Goto See;
        Death:
            BEGR F 5;
            BEGR G 5;
            BEGR H 5;
            BEGR I 5 A_Scream();
            BEGR J 5 A_NoBlocking();
            BEGR KLM 5;
            BEGR M 1; 
            BEGR N -1;
            Stop;
		Disintegrate:
			DISR A 5 A_StartSound("misc/disruptordeath", CHAN_AUTO);
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			DISR BC 5;
			DISR D 5 A_NoBlocking();
			DISR EF 5;
			DISR GHIJ 4;
			MEAT D 700;
			Stop;
		Burn:
			BURN A 3 Bright A_StartSound("human/imonfire", CHAN_AUTO);
			BURN B 3 Bright A_DropFire();
			BURN C 3 Bright A_Wander();
			BURN D 3 Bright A_NoBlocking();
			BURN E 5 Bright A_DropFire();
			BURN FGH 5 Bright A_Wander();
			BURN I 5 Bright A_DropFire();
			BURN JKL 5 Bright A_Wander();
			BURN M 5 Bright A_DropFire();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			BURN NOPQPQ 5 Bright;
			BURN RSTU 7 Bright;
			BURN V -1;
			Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Rogue ///////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class ascRogue : wosMonsterBase {

	int gunmag; //
	int searchtimer; //
	bool searched; //
	bool lootmed; //
	bool lootarm; //
	int lootarm2; //
	bool lootgun; //
	int lootgun2; //
	int lootmoney; //
	bool lootrep; //
	int lootinv;
	//string looteqip; Property Equipment : looteqip; //
	//int looteqip2; //
    
	Override void PostBeginPlay() {
		Super.PostBeginPlay();
		gunmag=30;
		//If(shielded==1){A_SpawnItemEx("LFAcolyteShield",flags: SXF_SETMASTER);}
		If(Random(1,3)==1){lootmed=1;} 
		If(Random(1,8)==1){lootarm=1; lootarm2=Random(15,85);}
		If(Random(1,6)==1){lootinv=1; lootmed=1;} 
		If(Random(1,4)==1){lootrep=1;}
		lootmoney=Random(3,15);
	}

	Override bool Used(Actor user) {
		let pawn = binderPlayer(user);
		If( searched==0 && health<1 && InStateSequence(CurState,ResolveState("Death")) && user is "binderPlayer" && pawn.currentarmor!=7 ) {
			int tosearch = 6 - (2 * pawn.SpeedUpgrade);
			If( searchtimer >= tosearch ) {
				If( lootmed == 1 ){ 
					Actor med = A_DropItem("wosHyposprej"); 
				}
				If( lootarm == 1 ){ 
					Actor arm = A_DropItem("wosLeatherArmor"); 
				}
				//If( looteqip == "TARG" ){ 
				//	Actor trg = A_DropItem("wosTargeter"); 
				//}
				While( lootmoney > 0 ) {
					If( lootmoney >= 25 ){ 
						A_DropItem("wosGold25"); 
						lootmoney-=25; 
					} Else If( lootmoney >= 10 ){ 
						A_DropItem("wosGold10"); 
						lootmoney-=10; 
					} Else If(lootmoney>=1){
						A_DropItem("goldCoin"); 
						lootmoney--;
					}
				}
				//If( lootinv == 1 ){ Actor gun = A_DropItem("wosAssaultGun"); }
				//Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				A_StartSound("sound/wearClothing");
				searchtimer++;
			}
		}
		Return Super.Used(user);
	}

    Default {
		//$Category "Monsters/WoS"
        //$Title "rogue"
        Tag "Rogue";
        Health 150;
        Radius 20;
        Height 56;
        Mass 100;
        Speed 14;
        FastSpeed 28;
        PainChance 150;
        Monster;
        +FLOORCLIP
        +missilemore
        +missileevenmore
        minmissilechance 2;
        MaxTargetRange 812;
        SeeSound "RogueSee1";
        PainSound "getroguepain";
        DeathSound "getroguedead";
        AttackSound "swordhit";
        ActiveSound "RogueSee1";
        Obituary "%o was killed by a rogue.";
    }

    States {
		Spawn:
			DATF A 10 A_Look();
			Loop;
		See:
			DATF AABBCCDD 3 A_Chase();
			Loop;
		Melee:
			DATF EE 4 A_FaceTarget();
			DATF E 1 bright A_StartSound("swordmiss");
			//DATF E 0 A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee"); 
			DATF F 7 bright A_Custommeleeattack(random(6,14), "swordhit", "swordmiss", "meleeattack", true);
			DATF EE 4 A_FaceTarget();
			DATF E 1 bright A_StartSound("swordmiss");
			//DATF E 0 A_Jump(4*ACS_NamedExecuteWithResult("RDexterity",0,0,0),"FakeMelee"); 
			DATF F 7 bright A_Custommeleeattack(random(6,14), "swordhit", "swordmiss", "meleeattack", true);
			Goto See;
		FakeMelee:
			DATF F 7 bright A_Custommeleeattack(0, "swordhit", "swordmiss", "meleeattack", true);
			Goto See;
		Missile:
			DATF H 12 A_FaceTarget();
			DATF I 3 A_SpawnProjectile ("Knife_1", 40, 3);
			DATF I 3;
			Goto See;
		Pain:
			DATF A 3;
			DATF J 3 A_Pain();
			Goto See;
		Death:
			DATF K 5;
			DATF L 5 A_Scream();
			DATF M 5 A_NoBlocking();
			DATF NOP 5;
			DATF P 1; 
			DATF Q -1;
			Stop;
		Disintegrate:
			DISR A 5 A_StartSound("misc/disruptordeath", CHAN_AUTO);
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			DISR BC 5;
			DISR D 5 A_NoBlocking();
			DISR EF 5;
			DISR GHIJ 4;
			MEAT D 700;
			Stop;
		Burn:
			BURN A 3 Bright A_StartSound("human/imonfire", CHAN_AUTO);
			BURN B 3 Bright A_DropFire();
			BURN C 3 Bright A_Wander();
			BURN D 3 Bright A_NoBlocking();
			BURN E 5 Bright A_DropFire();
			BURN FGH 5 Bright A_Wander();
			BURN I 5 Bright A_DropFire();
			BURN JKL 5 Bright A_Wander();
			BURN M 5 Bright A_DropFire();
			BURN NOPQPQ 5 Bright;
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			BURN RSTU 7 Bright;
			BURN V -1;
			Stop;
    }
}
// knife projectile ////////////////////////////////////////////////////////////
class Knife_1 : actor {
	Default {
		Speed 20;
		FastSpeed 40;
		Radius 8;
		Height 4;
		+BLOODSPLATTER
		Damage 6;
		SeeSound "flecha";
		DeathSound "batfam/crash";
		Projectile;
	}
	
	States {
		Spawn:
			KNIF ABCD 5 BRIGHT;
			Loop;
		Death:
			KNIF A 1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////