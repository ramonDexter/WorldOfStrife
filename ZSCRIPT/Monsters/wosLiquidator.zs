class wosLiquidator : actor {
    Default {
		//$category "Monsters/WoS"
		//$Title "Liquidator robot"
        Tag "$T_wosLiquidator";
        Radius 52;
        Height 120;
        Health 2400;
        Speed 12;
        PainChance 16;
        Monster;
        +BOSS
        +NOBLOOD
        +NORADIUSDMG
        +FLOORCLIP
        +DONTMORPH
        +DONTTHRUST
        +MISSILEMORE
        SeeSound "Liquidator/See";
        ActiveSound "Liquidator/Active";
        PainSound "Liquidator/Pain";
        DeathSound "Liquidator/Death";
        Obituary "%o wasn't worth of defeating the Liquidator";
    }
    
    States {
        Spawn:
            LIQU B 10 A_Look();
            Loop;
        See:
            TNT1 A 0 A_PlaySound("Liquidator/LegLift",0);
            LIQU AAA 4 A_Chase();
            TNT1 A 0 A_PlaySound("Liquidator/LegStomp",0);
            LIQU BBB 4 A_Chase();
            TNT1 A 0 A_PlaySound("Liquidator/LegLift",0);
            LIQU CCC 4 A_Chase();
            TNT1 A 0 A_PlaySound("Liquidator/LegStomp",0);
            LIQU BBB 4 A_Chase();
            Loop;
        Missile:
            TNT1 A 0 A_Jump(100,"BFGAttack");
            LIQU D 4 A_FaceTarget();
            LIQU D 4 Bright {
                A_PlaySound("Liquidator/Fire",2);
                A_SpawnProjectile("LiquidatorPlasma",92,32,0);
                A_SpawnProjectile("LiquidatorPlasma",88,36,8);
                A_SpawnProjectile("LiquidatorPlasma",88,28,-8);
            }
            LIQU D 4;
            LIQU D 2 A_SentinelRefire();
            Goto Missile+1;
        BFGAttack:
            LIQU D 4 A_PlaySound("Liquidator/BFG",2);
            LIQU DDDDDDDDD 4 A_FaceTarget();
            LIQU D 4 Bright A_SpawnProjectile("LiquidatorBFG",88,32,0);
            LIQU D 8;
            Goto See;
        Pain:
            LIQU E 3 A_Pain();
            LIQU E 3;
            Goto See;
        Death:
            LIQU E 2;
            LIQU E 2 A_Scream();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionSmall",random(-8,8),random(-70,70),random(20,90),0,0,0);
            LIQU E 2 Bright A_TossGib();
            TNT1 AAAAAAA 0 A_TossGib();
            LIQU E 4 Bright A_SpawnItemEx("DeathExplosionBig",0,0,40,0,0,0);
            TNT1 A 0 A_Explode(48,128);
            TNT1 AAAAA 0 A_SpawnItemEx("DeathExplosionSmall",0,0,40,random(-6,6),random(-6,6),random(-3,3));
            TNT1 A 0 A_SpawnItemEx("LiquidatorArmToss",0,-40,30,random(-3,3),-3,random(0,5));
            TNT1 A 0 A_SpawnItemEx("LiquidatorCannonToss",0,40,30,random(-3,3),3,random(0,5));
            Stop;
	}
}
class LiquidatorPlasma : actor {
    Default {
        Radius 13;
        Height 8;
        Speed 25;
        Damage 10;
        Projectile;
        RenderStyle "Add";
        Alpha 0.75;
        DamageType "Disintegrate";
        +STRIFEDAMAGE;
        +BRIGHT;
        DeathSound "LiqPlasma/Explode";
    }
    
    States {
        Spawn:
            LQSH ABC 4;
            Loop;
        Death:
            LQSH D 3 A_Explode(12,48);
            LQSH EFGHI 3;
            Stop;
	}
}
class LiquidatorBFG : actor {
    int xplosionradius;
    int xplosiondamage;
    Default {
        Radius 13;
        Height 8;
        Speed 20;
        Damage 25;
        Projectile;
        RenderStyle "Add";
        DamageType "Disintegrate";
        +STRIFEDAMAGE
        +SEEKERMISSILE
        +BRIGHT
        SeeSound "LiqBFG/Fire";
        DeathSound "LiqBFG/Explode";
    }


States
	{
	Spawn:
		LQBG A 3 A_Tracer2();
		LQBG B 3;
		LQBG C 3 A_Tracer2();
		LQBG D 3;
		Loop;
	Death:
		LQBG G 1 {
			xplosionradius = 48;
			xplosiondamage = 32;
			A_SpawnItemEx("whycantyouusedecimalnumbersonmathoperations",0,0,0,0,0,0);
		}
		LQBG GHIJKL 2 {
			A_Explode(xplosiondamage,xplosionradius,1);
			xplosionradius+=16;
			xplosiondamage-=3;
		}
		TNT1 AAAA 2 {
			A_Explode(xplosiondamage,xplosionradius,1);
			xplosionradius+=16;
			xplosiondamage-=3;
		}
		Stop;
	}
}
class whycantyouusedecimalnumbersonmathoperations : actor {
    Default {
        +NOGRAVITY
        +NOINTERACTION
        +FLATSPRITE
        Renderstyle "add";
        Alpha 0.8;
    }

    States {
        Spawn:
            BGWV A 2 Bright A_SetScale(1.3,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV B 2 Bright A_SetScale(1.6,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV C 2 Bright A_SetScale(1.9,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV A 2 Bright A_SetScale(2.2,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV B 2 Bright A_SetScale(2.5,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV C 2 Bright A_SetScale(2.8,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV A 2 Bright A_SetScale(3.1,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV B 2 Bright A_SetScale(3.4,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV C 2 Bright A_SetScale(3.7,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV A 2 Bright A_SetScale(4.0,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV B 2 Bright A_SetScale(4.3,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV C 2 Bright A_SetScale(4.6,0);
            TNT1 A 0 A_FadeOut(0.08);
            BGWV A 2 Bright A_SetScale(4.9,0);
            TNT1 A 0 A_FadeOut(0.08);
            Stop;
	}
}
class DeathExplosionSmall : actor {
    Default {
        +NOGRAVITY
        +NOINTERACTION
        Renderstyle "add";
        Scale 0.8;
    }

    States {
        Spawn:
            DBOM ABCDEFGHIJK 2 Bright;
            Stop;
	}
}
class DeathExplosionBig : actor {
    Default {
        +NOGRAVITY
        +NOINTERACTION
        Renderstyle "add";
        Scale 1.2;
    }

    States {
        Spawn:
            DBO2 ABCDEFGHIJKL 3 Bright;
            Stop;
	}
}
class LiquidatorArmToss : actor {
    Default {
        +NOBLOCKMAP
        +NOBLOOD
    }

    States {
        Spawn:
            LIQJ A -1;
            Stop;
	}
}
class LiquidatorCannonToss : actor {
    Default {
        +NOBLOCKMAP
        +NOBLOOD
    }

    States {
        Spawn:
            LIQJ B -1;
            Stop;
	}
}