/*
credits: Jarewill
*/
Class wosGasGrenade : Actor {
    int grenadetime;
    property GrenadeTime : grenadetime;

    action void A_grenadeCount() {
        if ( invoker.grenadetime <= 0 || invoker.health <= 0 ) {
            setStateLabel("Explode");
        }
        if ( invoker.bSHOOTABLE == 0 ) {
            invoker.bSHOOTABLE == 1;
        } else {
            invoker.grenadetime--;
        }        
    }

	Default {
		-NOGRAVITY
		+STRIFEDAMAGE
		+BOUNCEONACTORS
		+EXPLODEONWATER
		-NOBLOCKMAP
        +SOLID
		+SHOOTABLE
        +NOBLOOD
		+ROLLSPRITE
        +ROLLCENTER
		+FORCEXYBILLBOARD
		+MTHRUSPECIES

        wosGasGrenade.GrenadeTime 70;
		Speed 20;
		Obituary "%o choked on one of %k's gas grenades.";
        Health 5;
		Speed 1;
		Radius 4;
		Height 4;
		Mass 10;
		Damage 1;
		Projectile;
		MaxStepHeight 4;
		BounceType "Doom";
		BounceFactor 0.5;
	}
	States {
        Spawn:
            GASG BBBBCCCC 1 { A_grenadeCount(); A_SetRoll(roll-2);}
            Loop;
        Death:
            GASG BBBBCCCC 1 A_grenadeCount();
            Loop;
        Explode:
            GASG B 1 Bright {
                For(int i; i<2; i++) {
                    bool spawn1; Actor spawn2;
                    [spawn1, spawn2] = A_SpawnItemEx("wosGasObstacle",Random(-32,32),Random(-32,32));
                    spawn2.Reactiontime = Random(60,100);
                }
                A_StartSound("weapons/phgrenadeshoot");
            }
            GASG B 175;
            GASG B 1 A_FadeOut(0.02);
            Wait;
	}
}
Class wosGasObstacle : Actor {
	Default {
		Reactiontime 80;
		+NOBLOCKMAP
		+FLOORCLIP
		+NOTELEPORT
		+NODAMAGETHRUST
		+DONTSPLASH
		RenderStyle "Translucent";
		Alpha 0.85;
		Obituary "%o didn't wear protection.";
		DamageType "Gas";
	}
	States {
        Spawn:
            GASC A 2 A_Countdown();
            GASC B 2 A_Explode(4,64);
            GASC C 2 A_Countdown();
            GASC D 2 A_Explode(4,64);
            GASC E 4 A_Countdown();
            GASC F 4 A_Explode(4,64);
            GASC G 4 A_Countdown();
            GASC H 4 A_Explode(4,64);
            Goto Spawn+4;
        Death:
            GASC E 4 A_FadeOut(0.05);
            GASC F 4 {A_Explode(4,64); A_FadeOut(0.05);}
            GASC G 4 A_FadeOut(0.05);
            GASC H 4 {A_Explode(4,64); A_FadeOut(0.05);}
            Loop;
	}
}