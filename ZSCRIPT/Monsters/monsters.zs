///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// wos monsters defs //////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////



//>>moved to rebels.zs

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// spiker trap ////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class spikerTrap : wosMonsterBase {

	void W_TrapAttack() {
		let targ = target;
		if (targ) {
			int damage = random[spikerTrap](1, 8) * 2;
			A_StartSound("Spiders/Attack", CHAN_WEAPON);
			int newdam = targ.DamageMobj (self, self, damage, "Melee");
			targ.TraceBleed (newdam > 0 ? newdam : damage, self);
			
		}
	}

	Default {
		//$Category "Monsters/WoS"
		//$Title "Spiker Trap"
		
		-FRIENDLY
		+FLOORCLIP
		
		Tag "$TAG_spikerTrap";
		Radius 8;
		Height 12;
		Monster;
		Speed 0;
		Health 256;
		Mass 10000;
		PainChance 200;
	
	}
	
	States {
		Spawn:
			TRAP A 1 A_Look();
			Loop;
			
		See:
			TRAP A 1 A_Chase("Melee");
			Loop;
		
		Melee:
			TRAP A 2;
			TRAP B 3 W_TrapAttack();
			TRAP A 2;
			TRAP B 3 W_TrapAttack();
			TRAP A 2;
			TRAP B 3 W_TrapAttack();
			TRAP A 4;
			goto See;
		Death:
			TNT1 A 0 A_SpawnItemEx("wosExplosion_low");
            TNT1 A 0 W_rewardXP(SpawnHealth()/4);
			TRAP A -1;
			Stop;
	}
}
class spikerTrapFriendly : spikerTrap {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Spiker Trap friendly"
		+FRIENDLY
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// reikall's voxel sentinel - cool stuff :) ///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*class RV_Sentinel : Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Sentinel vox"
		+DONTINTERPOLATE
		
	}
	action void W_rewardXPRVsentinel (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	
	States {
		Spawn:
			SEWR W 1 
			{
				A_Look(); 
				A_SpawnItemEx("RV_SentinelBright");
			}
			SEWR WWWWWWWWW 1 A_SpawnItemEx("RV_SentinelBright");
			Loop;
		See:
			SEWR W 1 {
				A_SentinelBob(); 
				A_SpawnItemEx("RV_SentinelBright");
			}
			SEWR WWWWW 1 A_SpawnItemEx("RV_SentinelBright");
			SEWR W 1 {
				A_Chase(); 
				A_SpawnItemEx("RV_SentinelBright");
			}
			SEWR WWWWW 1 A_SpawnItemEx("RV_SentinelBright");
			Loop;
		Missile:
			SEWR X 1 {
				A_FaceTarget(); 
				A_SpawnItemEx("RV_SentinelBright", 0, 0, 8);
			}
			SEWR XXX 1 A_SpawnItemEx("RV_SentinelBright", 0, 0, 8);
			SEWR Y 1 {
				A_SentinelAttack(); 
				A_SpawnItemEx("RV_SentinelBright", 0, 0, 16);
			}
			SEWR YYYYYYY 1 A_SpawnItemEx("RV_SentinelBright", 0, 0, 16);
			SEWR Y 1 {
				A_SentinelRefire(); 
				A_SpawnItemEx("RV_SentinelBright", 0, 0, 16);
			}
			SEWR YYY 1 A_SpawnItemEx("RV_SentinelBright", 0, 0, 16);
			Goto Missile+1;
		Death:
			SEWR D 7 A_Fall();
			SEWR E 8 Bright A_TossGib();
			SEWR F 5 Bright A_Scream();
			SEWR GH 4 Bright A_TossGib();
            TNT1 A 0 W_rewardXPRVsentinel(SpawnHealth());
			SEWR I 4;
			SEWR J 5;
			Stop;
	}
}
class RV_SentinelBright : actor {
	Default {
		+NOINTERACTION
	}
	
	States {
		Spawn:
			SEWR Z 2 BRIGHT;
			stop;
	}
}*/
class RV_CeilingTurret : CeilingTurret {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Ceiling Turret vox"
		+DONTINTERPOLATE
	}
	action void W_rewardXPturret (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}
	
	States {
		Spawn:
			TURT Z 1 BRIGHT {
				A_TurretLook(); 
				A_SpawnItemEx("RV_TurretBase");
			}
			TURT ZZZZ 1 BRIGHT A_SpawnItemEx("RV_TurretBase");
			Loop;
		See:
			TURT Z 1 BRIGHT {
				A_Chase(); 
				A_SpawnItemEx("RV_TurretBase");
			}
			TURT Z 1 BRIGHT A_SpawnItemEx("RV_TurretBase");
			Loop;
		Death:
			BALL A 6 Bright A_Scream();
			BALL BCDE 6 Bright;
            TNT1 A 0 W_rewardXPturret(SpawnHealth());
			TURT C -1;
			Stop;
	}
}
class RV_TurretBase : actor {
	Default {
		+NOINTERACTION
	}
	
	States {
		Spawn:
			TURT X 2 SLOW;
			stop;
	}
}
/*
class hackedSentinel : RV_Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Hacked Sentinel"
		
		Tag "$TAG_hackedSentinel";
	}
}
class friendSentinel : RV_Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Friendly Sentinel"
		
		+FRIENDLY
		
	}
}
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  zombie mutant /////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ZombieFodder : wosMonsterBase {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Zombie Fodder"
		
		+FLOORCLIP
		
		Tag "$T_ZOMBIEFODDER";
		Health 55;
		GibHealth 20;
		Radius 20;
		Height 56;
		Speed 10;
		PainChance 256;
		Monster;
		SeeSound "ZombieFodder/sight";
		PainSound "ZombieFodder/pain";
		DeathSound "ZombieFodder/death";
		ActiveSound "ZombieFodder/active";
		Obituary "%o joins the zombies.";
	}
	
	States {
		Spawn:
			ZFOD AB 10 A_Look();
			Loop;
		See:
			ZFOD AABBCCDD 4 A_Chase();
			Loop;
		Melee:
			ZFOD EF 10 A_FaceTarget();
			ZFOD G 8 A_CustomMeleeAttack(random(2,16)*(random(1,2)),"ZombieFodder/Melee");
			Goto See;
		Pain:
			ZFOD H 4;
			ZFOD H 4 A_Pain();
			Goto See;
		Death:
			ZFOD I 7;
			ZFOD J 7 A_Scream();
			ZFOD K 5 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			ZFOD L 5;
			ZFOD M -1;
			Stop;
		XDeath:
			ZFOD N 5;
			ZFOD O 5 A_XScream();
			ZFOD P 5 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			ZFOD QR 5;
			ZFOD S -1;
			Stop;
		Raise:
			ZFOD L 5;
			ZFOD KJI 5;
			Goto See;
	}
}


class ZombFlesh : actor {
	Default {
		+CANBOUNCEWATER
		-NOGRAVITY
		+NOBLOCKMAP 
		//+MISSILE
		
		Radius 4;
		Height 9;
		Health 40;
		Damage (10);
		Speed 35;
		Gravity 0.5;
		Mass 0;
		PROJECTILE;
		ReactionTime 120;
		Seesound "ZFlesh/Throw";
	}
	
	States {
		Spawn:
			ZGIB A 1 A_SpawnItemEx("ZombFleshTrail",0,0,0);
			Loop;
		Death:
			TNT1 B 1 A_StartSound ("ZFlesh/miss", 0);
			Stop;
		XDeath:
			TNT1 B 1 A_StartSound ("ZFlesh/hit", 0);
			Stop;
	}
}

class ZombFleshTrail : actor {
	Default {
		+NOBLOCKMAP
		+NOTELEPORT
		+NOGRAVITY
		
		Health 3;
		Scale 0.8;
		RenderStyle "Translucent";
		Alpha 0.8;
	}
	States {
		Spawn:
			BL0D ABCD 3;
			Stop;
	}
}

class FodderSoul : actor {
	Default {
		+NOBLOCKMAP
		+NOGRAVITY
	}
	
	States {
		Spawn:
			ZFSL ABC 5;
			ZFSL DEFG 9;
			Stop;
	}
}

class fodderGhoul : ZombieFodder {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Ghoul"
		
		Tag "$TAG_fodderGhoul";
		Health 100;
	}
	
	States {
		  Spawn:
			GHUL AB 10 A_Look();
			Loop;
		  See:
			GHUL AABBCCDD 4 A_Chase();
			Loop;
		  Melee:
			GHUL EF 10 A_FaceTarget();
			GHUL G 8 A_CustomMeleeAttack(random(2,16)*(random(1,2)),"ZombieFodder/Melee");
			Goto See;
		  Pain:
			GHUL H 4;
			GHUL H 4 A_Pain();
			Goto See;
		  Death:
			GHUL I 7;
			GHUL J 7 A_Scream();
			GHUL K 5 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			GHUL L 5;
			GHUL M -1;
			Stop;
		  XDeath:
			GHUL N 5;
			GHUL O 5 A_XScream();
			GHUL P 5 A_NoBlocking();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			GHUL QR 5;
			GHUL S -1;
			Stop;
		  Raise:
			GHUL L 5;
			GHUL KJI 5;
			Goto See;
	}	
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// mini sentinel //////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class MiniSentinel : wosMonsterBase {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Mini Sentinel"
		
		+SPAWNCEILING
		+NOGRAVITY
		+DROPOFF
		+NOBLOOD
		+NOBLOCKMONST
		+INCOMBAT
		+MISSILEMORE
		+LOOKALLAROUND
		+NEVERRESPAWN
		
		Tag "$TAG_MiniSentinel";
		Health 50;
		Painchance 255;
		Speed 7;
		Radius 12;
		Height 26;
		Mass 300;
		MONSTER;
		SeeSound "sentinel/sight";
		DeathSound "sentinel/death";
		ActiveSound "sentinel/active";
		Obituary "%o was vaporized by a mini sentinel";
	}
	
	States {
		Spawn:
			MNDR A 10 A_Look();
			loop;
		See:
			MNDR A 6 A_SentinelBob();
			MNDR A 6 A_Chase();
			loop;
		Missile:
			MNDR A 4 A_FaceTarget();
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX2",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			MNDR A 4 A_FaceTarget();
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX2",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			MNDR A 4 A_FaceTarget();
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX2",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			MNDR B 1 BRIGHT A_SpawnProjectile("SentinelFX1",15,0,0);
			goto see;
		Pain:
			MNDR A 5 A_Pain();
			goto see;
		Death:
			MNDR C 7 BRIGHT A_Fall();
			MNDR D 5 BRIGHT A_Scream();
			MNDR E 5 BRIGHT A_TossGib();
            TNT1 A 0 {
				//W_rewardXP(SpawnHealth());
				A_SpawnItemEx("wosExplosion_low");
			}
			MNDR F 5 BRIGHT;
			MNDR G 5 BRIGHT A_TossGib();
			MNDR HI 5 BRIGHT;
			stop;
	}
}
class LaserBolt : actor {
	Default {
		+STRIFEDAMAGE
		+NOEXTREMEDEATH
		+SPAWNSOUNDSOURCE
		
		Speed 30;
		Radius 10;
		Height 8;
		Damage 8;
		Projectile;
		RenderStyle "Add";
		DamageType "disentegrate";
		SeeSound "LaserCannon/Fire";
		DeathSound "LaserCannon/End";
		Decal "PlasmaScorchLower";
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1 ThrustThingZ(0, random (-7, 1), 0, 1);
		Fly:
			TNT1 A 1 A_SpawnItem("LaserBoltTrail");
			Loop;
		Death:
			POW1 FGHIJ 2 bright;
			Stop;
	}
}

class LaserBoltTrail : actor {
	Default {
		+NOINTERACTION
		+CLIENTSIDEONLY

		Renderstyle "Add";
	}
	
	States {
		Spawn:
			SHT1 AB 1 Bright A_FadeOut (0.1);
			Loop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// paladin robot //////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Paladin : wosMonsterBase {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Paladin"
		
		+FLOORCLIP
		+NOBLOOD
		+MISSILEMORE
		
		Tag "$TAG_Paladin";
		obituary "A paladin's laser cannon wiped the smile off of %o's face.";
		health 750;
		radius 32;
		height 96;
		mass 1000;
		speed 8;
		painchance 50;
		scale 0.75;
		painsound "Robot/Pain";
		deathsound "Robot/Death";
		MONSTER;
	}
	
	states {
		Spawn:
			RROB B 10 A_Look();
			loop;
		See:
			RROB A 4 A_Chase();
			RROB A 0 A_StartSound ("Robot/Step", 0);
			RROB AA 4 A_Chase();
			RROB BB 4 A_Chase();
			RROB C 4 A_Chase();
			RROB C 0 A_StartSound ("Robot/Step", 0);
			RROB CC 4 A_Chase();
			RROB BB 4 A_Chase();
			loop;
		Missile:
			RROB D 16 A_FaceTarget();
			RROB D 0 A_StartSound ("Robot/Step", 0);
		Fire:
			RROB D 2 Bright A_SpawnProjectile("LaserBolt", 60, 12, random (-2, 2), 1);
			RROB D 3 A_CposRefire();
			loop;
		Pain:
			RROB E 2;
			RROB E 2 A_Pain();
			goto See;
		Death:
			RROB F 6;
			RROB G 6 A_Scream();
			RROB H 6;
			RROB I 6 A_NoBlocking();
			RROB J 6;
			RROB K 6 A_StartSound ("Robot/Fall", 0);
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			RROB L -1;
			stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// binder npc friendly ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class binderNPC : actor {
	Default {
		//$Category "Other NPCs"
		//$Title "Binder NPC"
		
		+FRIENDLY
		-COUNTKILL
		
		radius 16;
		height 56;		
		Monster;
		Health 120;
		PainChance 250;
		Speed 10;	
		Tag "$TAG_binderNPC";
		Obituary "";
		ATTACKSOUND "grunt/attack";
		SeeSound "rebel/sight";
		PainSound "rebel/pain";
		DeathSound "rebel/death";
		ActiveSound "rebel/active";
	}
	
	States {
		Spawn:
			RNGS A 5 A_Look2();
			Loop;
			RNGS A 8;
			Loop;
			RNGS A 8;
			Loop;
            RNGP ABCDABCD 6 A_Wander();
            Loop;
		See:
			RNGP AABBCCDD 6  A_Chase();
			Loop;
		Missile:
			RNGP E 10 A_FaceTarget();
            RNGP F 12 Bright A_SpawnProjectile("BlasterTracer", 32, 0, 0);
            RNGP F 10 A_SpawnProjectile("BlasterTracer", 32, 0, 0);
			Goto See;	
		Pain:
			RNGP O 4;
			RNGP O 4 A_Pain();
			Goto See;
		Death:
			RNGP G 8;		
			RNGP H 10;
			RNGP I 10 A_PlayerScream();
			RNGP J 10 A_NoBlocking();
			RNGP KLM 10;
			RNGP N -1;
			Stop;
		XDeath:
			RNGP G 8; 		
			RNGP H 10;
			RNGP I 10 A_PlayerScream();
			RNGP J 10 A_NoBlocking();
			RNGP KLM 10;
			RNGP N -1;
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// shooting stalker ///////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class shootingStalker : Stalker {
	Default {
		//$category "Monsters/WoS"
		//$Title "shooting stalker"
		+NOGRAVITY
		+DROPOFF
		+NOBLOOD
		+SPAWNCEILING
		+INCOMBAT
		+NOVERTICALMELEERANGE

        Tag "$TAG_shootingStalker";
		Health 60;
		Painchance 40;
		Speed 16;
		Radius 31;
		Height 25;
		Monster;
		MaxDropOffHeight 32;
		MinMissileChance 150;
		SeeSound "stalker/sight";
		AttackSound "stalker/attack";
		PainSound "stalker/pain";
		DeathSound "stalker/death";
		ActiveSound "stalker/active";
		HitObituary "$OB_STALKER";
	}
	/*action void W_rewardXPshootingStalker (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/

	States {
        Spawn:
            STLK A 1 A_StalkerLookInit;
            Loop;
        LookCeiling:
            STLK A 10 A_Look;
            Loop;
        LookFloor:
            STLK J 10 A_Look;
            Loop;
        See:
            STLK A 1 Slow A_StalkerChaseDecide;
            STLK ABB 3 Slow A_Chase;
            STLK C 3 Slow A_StalkerWalk;
            STLK C 3 Slow A_Chase;
            Loop;
        Melee:
            STLK J 3 Slow A_FaceTarget;
            STLK K 3 Slow A_StalkerAttack;
        Missile:
            STLK C 2 A_StalkerDrop;
            STLK J 3 Slow A_FaceTarget;
            STLK M 3 A_ShootGun();
            STLK J 3 Slow A_FaceTarget;
            STLK M 3 A_ShootGun();
            STLK J 3;
        SeeFloor:
            STLK J 3 A_StalkerWalk;
            STLK KK 3 A_Chase;
            STLK L 3 A_StalkerWalk;
            STLK L 3 A_Chase;
            Loop;
        Pain:
            STLK L 1 A_Pain;
            Goto See;
        Drop:
            STLK C 2 A_StalkerDrop;
            STLK IHGFED 3;
            Goto SeeFloor;
        Death:
            STLK O 4;
            STLK P 4 A_Scream;
            STLK QRST 4;
            STLK U 4 A_NoBlocking;
            //TNT1 A 0 W_rewardXPshootingStalker(SpawnHealth());
            STLK VW 4;
            STLK XYZ[ 4 Bright;
            Stop;
	}	
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//>>moved to acolyte.zs

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ascension flesh imp ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ascImpFlesh : wosMonsterBase {
	Default {
		//$category "Monsters/WoS"
		//$Title "Imp Green"
		Tag "$TAG_ascImpFlesh";
		Obituary "$OBI_ascImpFlesh"; //%o was bitten by a Flesh Imp.
		Health 55;
		Speed 10;
		FastSpeed 20;
		DamageFunction (random(4,8));
		PainChance 144;
  		SeeSound "H2Imp/Sight";
		DeathSound "H2Imp/Death";
		PainSound "H2Imp/Pain";
		meleeSound "H2Imp/Melee";
		Monster;
		radius 16;
		height 32;
		+FloorClip
		+DONTHARMSPECIES
		+Float
		+NoGravity
		+NoTrigger
		+NOTARGETSWITCH
		+PUSHABLE
	}  
  	States {
		Spawn:
			IMP1 J 8 A_Look();
			Loop;
		See:
			IMP1 BBBCCC 2 A_Chase();
			IMP1 C 0 A_StartSound("H2Imp/Wings");
			IMP1 BBBAAA 2 A_Chase();
			Loop;
		Melee:
			IMP1 D 0;
			IMP1 DE 4 A_FaceTarget();
			IMP1 F 4 A_CustomMeleeAttack(random(1,8)*2,"H2Imp/Melee","");
			Goto See;
		FakeMelee:
			IMP1 DE 4 A_FaceTarget();
			IMP1 F 4;
			Goto See;
		Missile:
			IMP1 A 0;
			IMP1 A 0 A_JumpIfCloser(384, 1);
			Goto See;
			IMP1 A 8 A_FaceTarget();
			IMP1 C 0 A_StartSound("H2Imp/Charge");
			IMP1 C 15 A_SkullAttack();
			IMP1 C 0 A_Stop();
			Goto See;
		Pain:
			IMP1 G 2;
			IMP1 G 3 A_Pain();
			Goto See;
		Death:
			IMP1 H 0 { bFLOATBOB = 0; }
			IMP1 H 1 A_Scream();
            //TNT1 A 0 W_rewardXP(SpawnHealth());
			IMP1 H 1;
		Crash:
			IMP1 H 0 { bFLOATBOB = 0; }
			IMP1 I 5;
			IMP3 J 5;
			IMP3 K 5 A_NoBlocking();
			IMP3 L -1;
			Stop;
		Idle:
			IMP1 BBBCCC 2 A_Look();
			IMP1 B 0 A_StartSound("H2Imp/Wings");
			IMP1 BBBAAA 2 A_Look();
			Loop;
   	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// heretic loremaster /////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class wosLoremasterHeretic_base : Loremaster {
	Default {
		//$category "Monsters/WoS"
		Tag "Heretic Loremaster";
	}
	States {
		Death:
		PDED A 6;
		PDED B 6 A_Scream();
		PDED C 4;
		PDED D 3 A_Fall();
		PDED E 3;
		PDED FGHIJIJIJKL 3;
		PDED MNOP 3;
		PDED Q 4;
		PDED RS 4;
		PDED T -1;
		Stop;
	}
}
class wosLoremasterHereticLesser : wosLoremasterHeretic_base {
	Default {
		//$Title "heretic loremaster lesser"
		Health 300;
	}
}
class wosLoremasterHereticMaster : wosLoremasterHeretic_base {
	Default {
		//$Title "heretic loremaster master"
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// bog/swamp monster //////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class wosBogMonster : Serpent {
	Default {
		//$Category "Monsters/WoS"
		//$Title "bog monster"
		Tag "Bog Monster";
		Health 80;
		SeeSound "SerpentSight"; //bogmonster/sight
		AttackSound "SerpentAttack"; //bogmonster/attack
		PainSound "SerpentPain"; //bogmonster/pain
		DeathSound "SerpentDeath"; //bogmonster/death
	}
	/*action void W_rewardXPbogMonster (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}*/
	States {
		Death:
			SSPT O 4;
			SSPT P 4 A_Scream();
			SSPT Q 4 A_NoBlocking();
            //TNT1 A 0 W_rewardXPbogMonster(SpawnHealth());
			SSPT RSTUVWXYZ 4;
			Stop;
		XDeath:
			SSXD A 4;
			SSXD B 4 A_SpawnItemEx("SerpentHead", 0, 0, 45);
			SSXD C 4 A_NoBlocking();
            //TNT1 A 0 W_rewardXPbogMonster(SpawnHealth());
			SSXD DE 4;
			SSXD FG 3;
			SSXD H 3 A_SerpentSpawnGibs();
			Stop;
		
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////