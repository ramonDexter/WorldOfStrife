////////////////////////////////////////////////////////////////////////////////
// Code: Doomedarchviledemon
// Sounds: FreeSounds
// Sprites: Raven Software
// Idea Base: Population animal
////////////////////////////////////////////////////////////////////////////////
class wosPiggy : actor {
    Default {
        //$Category "Other NPCs/WoS"
        //$Title "piggy - prase"
        Monster;
        Health 60;
        Radius 15;
        Height 36;
        Speed 3;
        Mass 100;
        Scale 1;
        PainChance 255;
        seesound "sounds/pig/sight";
        activesound "sounds/pig/sight";
        -COUNTKILL;
    }
    
    States {
        Spawn:
            PIGA A 10;
            Goto See;
        See:
            PIGA AAAABBBBCCCCDDDD 2 A_Wander();
            PIGA A 0 A_Chase();
            Loop;
        Pain:
            TNT1 A 0 A_PlaySound("PigHurt/Hurt",0,1);
            PIGA A 10;
            Goto RunAway;
        RunAway:
            TNT1 A 0 A_ChangeFlag("Frightened", True);
            TNT1 A 0 A_SetSpeed(6,AAPTR_DEFAULT);
            PIGA AAAABBBBCCCCDDDD 1 A_Chase();
            PIGA AAAABBBBCCCCDDDD 1 A_Chase();
            PIGA AAAABBBBCCCCDDDD 1 A_Chase();
            PIGA AAAABBBBCCCCDDDD 1 A_Chase();
            TNT1 A 0 A_SetSpeed(3,AAPTR_DEFAULT);
            TNT1 A 0 A_ChangeFlag("Frightened", False);
            Goto See;
        Death:
            TNT1 A 0 A_PlaySound("PigDeath/Death",0,1);
            PIGD AAAABBBBCCCCDDDDEEEEFFFFGGGGH 1;
            PIGD H -1;
            Stop;

    }
}
////////////////////////////////////////////////////////////////////////////////