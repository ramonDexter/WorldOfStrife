////////////////////////////////////////////////////////////////////////////////
// Decorate: Ghastly_dragon, Doomedarchviledemon
// Sprites: Raven Software, Neoworm
// Sounds: FreeSounds
// Idea Base: Population animal
////////////////////////////////////////////////////////////////////////////////
class wosSheep : actor {
    Default {
        //$Category "Other NPCs/WoS"
        //$Title "sheep - ovce"
        Monster;
        Health 50;
        Radius 30;
        Height 56;
        Speed 1;
        Mass 100;
        Scale 1;
        PainChance 255;
        seesound "sounds/sheep/sight";
        activesound "sounds/sheep/sight";
        -COUNTKILL;
    }

    States {
        Spawn:
            NSHE A 10 A_Look();
            Goto See;
        See:
            NSHE AAAABBBBCCCCDDDD 2 A_Wander();
            NSHE A 0 A_Chase();
            TNT1 A 0 A_Jump(256,"EatGrass","See","See","See","See","See","See","See","See");
            Loop;
        EatGrass:
            TNT1 A 0 A_StartSound("sounds/sheep/Nom");
            NSHG A 50;
            NSHG B 30;
            Goto See;
        Pain:
            TNT1 A 0 A_StartSound("sounds/sheep/sight");
            NSHP A 10;
            Goto RunAway;
        RunAway:
            TNT1 A 0 { bFRIGHTENED = true; }
            TNT1 A 0 A_SetSpeed(3,AAPTR_DEFAULT);
            NSHE AAAABBBBCCCCDDDD 1 A_Chase();
            NSHE AAAABBBBCCCCDDDD 1 A_Chase();
            NSHE AAAABBBBCCCCDDDD 1 A_Chase();
            NSHE AAAABBBBCCCCDDDD 1 A_Chase();
            TNT1 A 0 A_SetSpeed(1,AAPTR_DEFAULT);
            TNT1 A 0 { bFRIGHTENED = false; }
            Goto See;
        Death:
            TNT1 A 0 A_StartSound("sounds/sheep/sight");
            NSHD AAAABBBBCCCCDDDDEEEEFFFF 1;
            NSHD F -1;
            Stop;
    }
}
////////////////////////////////////////////////////////////////////////////////
