class wosRocketTurret : Actor {
    Default {
		//$category "Monsters/WoS"
		//$Title "rocket turret"
        Tag "Rocket Turret";
        Radius 20;
        Height 24;
        Speed 0;
        Health 300;
        Monster;
        +MOVEWITHSECTOR
        +NOBLOOD
        +AMBUSH
        +NOSPLASHALERT
        +MISSILEMORE
        +DONTHARMCLASS
        +DONTTHRUST
        +NOPAIN
        Obituary "%o was blown to pieces by a Rocket Turret";
        SeeSound "RTurret/Activate";
        DeathSound "RTurret/Explode";
    }

    States {
        Spawn:
            RTUR A 5 A_TurretLook();
            Loop;
        See:
            RTUR A 2 A_Chase();
            Loop;
        Missile:
            RTUR A 2 A_FaceTarget();
            RTUR B 5 Bright A_SpawnProjectile("RTurretProjectile",20,0,0);
            RTUR A 12;
            Goto See;
        Death:
            RTUR A 2 A_Scream();
            RTUR C 4 A_SpawnItemEx("DeathExplosionSmaller",0,0,20,0,0,0);
            RTUR C 2 A_Fall();
            RTUR C -1;
            Stop;
	}
}
class RTurretProjectile : actor {
    Default {
        Radius 10;
        Height 14;
        Speed 24;
        Damage 10;
        Projectile;
        Scale 0.8;
        +STRIFEDAMAGE
        +DEHEXPLOSION
        SeeSound "TRocket/Fire";
        DeathSound "TRocket/Explode";
        Decal "Scorch";
    }

    States {
        Spawn:
            TMIS A 2 A_PlaySound("TRocket/Flight",5,0.4,true);
            TMIS A 2 A_SpawnItemEx("RocketTrail",0,0,0,0,0,0,180);
            Loop;
        Death:
            TNT1 A 0 A_StopSound(5);
            TMIS B 5 Bright A_Explode(24,120);
            TMIS CD 4 Bright;
            Stop;
	}
}
class DeathExplosionSmaller : actor {
    Default {
        +NOGRAVITY
        +NOINTERACTION
        Renderstyle "add";
        Scale 0.65;
    }

    States {
        Spawn:
            DBOM ABCDEFGHIJK 3 Bright;
            Stop;
	}
}