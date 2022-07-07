//credits: Marinelol [Tutorial] Ascending to ZScript on forum.zdoom.org
/*
nuclearMutant/sight             NMUTSIT
nuclearMutant/active            NMUTACT
nuclearMutant/pain              NMUTPAIN
nuclearMutant/raiseGuns         NMUTATK
nuclearMutant/death             NMUTDTH
nuclearMutant/attack            NMFIRSHT
nuclearMutant/shotx             NMFIRXPL
*/

class nuclearMutant : wosMonsterBase {
    
	void A_SmartChase() {
		if (CheckSight(target) == true) {
			A_Chase();
		}
		else {
			A_Wander();
		}
	}
	
	int punchLimit;
	override void PostBeginPlay() {		
		punchLimit = 3;
		Super.PostBeginPlay();
	}
	
    Default {
        //$Category "Monsters/WoS"		
        //$Title "nuclear mutant"
        +floorClip;
        +Jumpdown;
        +missileMore;
        Monster;
        Tag "$T_NUCLEARMUTANT";
        Health 300;
        Speed 8;
        Mass 1000;
        Radius 32;
        Height 64;
        PainChance 80;
        MeleeThreshold 196;
        SeeSound "nuclearMutant/sight";
        PainSound "nuclearMutant/pain";
        ActiveSound "nuclearMutant/active";
        DeathSound "nuclearMutant/death";
        MeleeSound "skeleton/melee";
    }

    States {
        Spawn:
            NMUT AABBCCDD 4 A_Look();
            Loop;
        See:
            NMUT AAABBBCCCDDD 6 A_SmartChase();
            Loop;
        Melee:
            NMUT F 4 {
                if(punchLimit > 0) {
                    punchLimit--;
                }
                else {
                    setStateLabel("Missile");
                }
                A_FaceTarget();
                A_Recoil(-16);
                A_CustomMeleeAttack((random(2,4)*2), "weapons/staffhit", "", "Melee", true);
            }
            NMUT E 6 {
                A_FaceTarget();
                A_Recoil(-16);
            }
        Missile:
            NMUT F 0 {
                if(CheckSight(target))
                if(CheckLof() == false) {                    
					setStateLabel("See");
                }
            }
            NMUT F 4 {                
                A_StartSound("nuclearMutant/raiseGuns");
                A_FaceTarget();
            }
            NMUT G 3;
            NMUT H 8 Bright A_SpawnProjectile("nuclearMutantMissile", 32);
            NMUT G 2 A_FaceTarget();
            Goto See;
        Pain:
            NMUT J 2;
            NMUT J 2 A_Pain();
            Goto See;
        Death:
            NMUT J 8;
            NMUT J 8 A_Scream();
            NMUT K 8;
            NMUT L 8 A_NoBlocking();
            NMUT MNOPQRS 6;
            TNT1 A 0 W_rewardXP(SpawnHealth());
            NMUT T -1;
            Stop;
        Raise:
            NMUT T 8;
            NMUT SRQPONMLKJ 8;
            Goto See;    
    }

}
class nuclearMutantMissile : actor
{
    Default
    {
        Radius 6;
        Height 8;
        Speed 20;
        Damage 8;
        Projectile;
        +RANDOMIZE;
        RenderStyle "Add";
        Alpha 1;
        SeeSound "nuclearMutant/attack";
        DeathSound "nuclearMutant/shotx";
    }

    States
    {
        Spawn:
            NMMS AB 4 Bright;
            Loop;
        Death:
            MISL B 8 Bright;
            MISL C 6 Bright;
            MISL D 4 Bright;
            Stop;
    }
}


