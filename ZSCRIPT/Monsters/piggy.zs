////////////////////////////////////////////////////////////////////////////////
// Code: Doomedarchviledemon, shadowman, bigmemka
// Sounds: FreeSounds
// Sprites: Raven Software
// Idea Base: Population animal
////////////////////////////////////////////////////////////////////////////////
class wosPiggy : actor {
    Default {
        //$Category "Other NPCs/WoS"
        //$Title "piggy - prase"
        Monster;
        health 30;
		radius 12;
		height 28;
        scale 1;
		mass 30;
		speed 5;
		painchance 255;
		seesound "pig/sight";
		attacksound "pig/attack";
		painsound "pig/pain";
		deathsound "pig/death";
        -COUNTKILL;
    }    
    
    States {
        Spawn:
            PIGA A 10 A_Look();
            loop;
        See:
            PIGA AABBCCDD 2 A_Wander();
            PIGA A 0 A_Jump(8,9);
            PIGA AABBCCDD 2 A_Wander();
            Goto See;
            PIGA A 2 A_StartSound("pig/active");
            Goto See;
            PIGA AABBCCDD 2 A_Chase();
            PIGA A 0 A_Jump(8,9);
            PIGA AABBCCDD 2 A_Chase();
            Goto See+19;
            PIGA A 2 A_StartSound("pig/active");
            Goto See+19;
        Melee:
            PIGA C 4 A_FaceTarget();
            PIGA D 4 A_CustomMeleeAttack(1, "pig/attack", "pig/attack");
            goto See+19;
        Pain:
            PIGA D 2;
            PIGA D 4 A_Pain();
            goto See+19;
        Pain.Arrow:
            PIGA D 4 A_SpawnDebris("BloodSpurt");
            PIGA D 4 A_Pain();
            goto See+19;
        Death:
            PIGA E 6;
            PIGA F 6 A_Scream();
            PIGA G 6 A_NoBlocking();
            PIGA HJIK 3;
            PIGA L -1;
            stop;
        Death.Arrow:
            PIGA E 6 A_SpawnDebris("BloodSpurt");
            PIGA E 0 A_SpawnDebris("BloodSpurt");
            PIGA F 6 A_Scream();
            PIGA G 6 A_NoBlocking();
            PIGA HIJK 3;
            PIGA L -1;
            stop;
 	}
}
class BloodSpurt : actor {
	Default {
		+doombounce
		+FLOORCLIP
		+DONTSPLASH
		+NOTELEPORT
		
		Health 4;
		radius 3;
		height 6;
		speed 0.1;
		Scale 0.2;
		Mass  0;
	}
	
	States {
		Spawn:
			BBLD ABCDABCDABCDABCD 1;
			BBLD AB 1 A_SetTranslucent(0.8);
			BBLD CD 1 A_SetTranslucent(0.6);
			BBLD AB 1 A_SetTranslucent(0.4);
			BBLD CD 1 A_SetTranslucent(0.2);
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////