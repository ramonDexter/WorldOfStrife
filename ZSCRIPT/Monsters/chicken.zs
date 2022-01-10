////////////////////////////////////////////////////////////////////////////////
// Code: TheDoomedArchvile
// Sounds: FreeSounds, Raven Software
// Sprites: Raven Software
// Sprite Edits: TheDoomedArchvile
// Idea Base: Population animal
// borrowed from: Inquisitor 3 with permission by Jake CRusher
////////////////////////////////////////////////////////////////////////////////
class wosChicken : actor {
	Default {
        //$Category "Other NPCs/WoS"
        //$Title "chicken - slepice"
		
		-ISMONSTER
		-COUNTKILL
		+FLOORCLIP
		+PUSHABLE
		
		obituary "%o was killed by a chicken!";
		health 15;
		radius 8;
		height 28;
		mass 20;
		speed 5;
		painchance 255;
		seesound "chicken/active";
		attacksound "chicken/attack";
		painsound "chicken/pain";
		deathsound "chicken/death";
		//MONSTER;
	}
	
    States {
        Spawn:
            CHKN A 10 A_Look();
            loop;
        See:
            CHKN AABBAABB 2 A_Wander();
            CHKN A 0 A_Jump(8,9);
            CHKN AABBAABB 2 A_Wander();
            Goto See;
            CHKN A 2 A_StartSound("chicken/active");
            Goto See;
            CHKN AABBAABB 2 A_Chase();
            CHKN A 0 A_Jump(8,9);
            CHKN AABBAABB 2 A_Chase();
            Goto See+19;
            CHKN A 2 A_StartSound("chicken/active");
            Goto See+19;
        Melee:
            CHKN C 0;
            CHKN C 1 A_Jump(160,3);
            CHKN C 4 A_FaceTarget();
            CHKN D 4 A_CustomMeleeAttack(random(0,1), "chicken/attack", "chicken/attack");
            goto See+19;
            CHKN C 4 A_FaceTarget();
            CHKN D 4 A_CustomMeleeAttack(0, "chicken/attack", "chicken/attack");
            goto See+19;
        Pain:
            CHKN D 2;
            CHKN D 4 A_Pain();
            goto See+19;
        /*Pain.Arrow:
            CHKN D 4 A_SpawnDebris("BloodSpurt");
            CHKN D 4 A_Pain();
            goto See+19;*/
        Death:
            CHKN E 6;
            CHKN F 6 A_Scream();
            CHKN G 6 A_NoBlocking();
            CHKN HJIK 3;
            CHKN L -1;
            stop;
        /*Death.Arrow:
            CHKN E 6 A_SpawnDebris("BloodSpurt");
            CHKN E 0 A_SpawnDebris("BloodSpurt");
            CHKN F 6 A_Scream();
            CHKN G 6 A_NoBlocking();
            CHKN HIJK 3;
            CHKN L -1;
            stop;*/
    }
}
////////////////////////////////////////////////////////////////////////////////
