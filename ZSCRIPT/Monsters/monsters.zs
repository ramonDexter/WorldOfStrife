///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// wos monsters defs //////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rebel enemy base class /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class rebelEnemy : Rebel replaces Rebel {

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
	string looteqip; Property Equipment : looteqip; //
	int looteqip2; //
    
	Override void PostBeginPlay() {
		Super.PostBeginPlay();
		gunmag=30;
		//If(shielded==1){A_SpawnItemEx("LFAcolyteShield",flags: SXF_SETMASTER);}
		If(Random(1,3)==1){lootmed=1;} If(Random(1,8)==1){lootarm=1; lootarm2=Random(15,85);}
		If(Random(1,6)==1){lootgun=1; lootgun2=Random(50,600);} If(Random(1,10)==1){lootrep=1;}
		lootmoney=Random(3,15);
	}

	Override bool Used(Actor user) {
		let pawn = binderPlayer(user);
		If( searched==0 && health<1 && InStateSequence(CurState,ResolveState("Death")) && user is "binderPlayer" && pawn.currentarmor!=4 ) {
			int tosearch = 6 - (2 * pawn.SpeedUpgrade);
			If( searchtimer >= tosearch ) {
				If( lootmed == 1 ){ 
					Actor med = A_DropItem("wosHyposprej"); 
				}
				If( lootarm == 1 ){ 
					Actor arm = A_DropItem("wosLeatherArmor"); 
				}
				If( looteqip == "TARG" ){ 
					Actor trg = A_DropItem("wosTargeter"); 
				}
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
				If( lootgun == 1 ){ Actor gun = A_DropItem("zscAssaultGun"); }
				Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				searchtimer++;
			}
		}
		Return Super.Used(user);
	}

	Default {
		//$category "Monsters/Heretics"
		//$Title "Heretic"
		
		-Friendly
		
		Tag "Heretic";
	}
	States {
		Spawn:
			HMN1 P 5 A_Look2;
			Loop;
			HMN1 Q 8;
			Loop;
			HMN1 R 8;
			Loop;
			HMN1 ABCDABCD 6 A_Wander;
			Loop;
		See:
			HMN1 AABBCCDD 3 A_Chase;
			Loop;
		Missile:
			HMN1 E 10 A_FaceTarget;
			HMN1 F 5 BRIGHT A_ShootGun;
			HMN1 E 3 A_ShootGun;
			HMN1 F 5 BRIGHT A_ShootGun;
			Goto See;
		Pain:
			HMN1 O 3;
			HMN1 O 3 A_Pain;
			Goto See;
		Death:
			HMN1 G 5;
			HMN1 H 5 A_Scream;
			HMN1 I 3 A_NoBlocking;
			HMN1 J 4;
			HMN1 KLM 3;
			HMN1 N -1;
			Stop;
		XDeath:
			RGIB A 4 A_TossGib;
			RGIB B 4 A_XScream;
			RGIB C 3 A_NoBlocking;
			RGIB DEF 3 A_TossGib;
			RGIB G 3;
			RGIB H 1400;
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

// rebels /////////////////////////////////////////////////////////////////////////////////////////////////////
class rebelEnemy_spider : rebelEnemy {
	Default {
		//$category "Monsters/WoS"
		//$Title "Spider  ganger"
		-Friendly
		
		Tag "Spider";
		Dropitem "gold10";
		Dropitem "ClipOfBullets";
	}
	
	
}
class ShieldRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Shield Heretic"
		
		-Friendly
		
		Tag "$TAG_ShieldRebel";//Shield Heretic
		Health 70;
		PainChance 110;
		Speed 8;
		DropItem "AssaultGun";
		DropItem "Shield";
		Dropitem "randomDrop_02";
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		Obituary "%o got shot down by a shield-wielding rebel.";
	}
	
	States {
		Spawn:
			SREB A 1 A_Look();
			loop;
		See:
			SREB AABBCCDD 3  A_Chase();
			loop;
		Melee:
			SREB E 4 A_FaceTarget();
			SREB G 4 A_CustomMeleeAttack(3*random(1, 6));
			SREB E 25;
			Goto See;
		Missile:
			SREB E 7 A_FaceTarget();
			SREB F 1 Bright A_ShootGun();
			SREB E 2 A_FaceTarget();
			SREB F 1 Bright A_ShootGun();
			SREB E 2 A_FaceTarget();
			SREB F 1 Bright A_ShootGun();
			SREB E 3;
			Goto See;
		Pain:
			SREB G 0 A_SetInvulnerable();
			SREB G 1 A_Pain();
			SREB G 29 A_CentaurDefend();
			SREB G 0 A_UnSetInvulnerable();
			Goto See;
		Death:
			SREB H 4 A_NoBlocking();
			SREB I 4 A_Scream();
			SREB J 4;
			SREB KLMN 3;
			SREB O -1;
			Stop;
		XDeath:
			SREB P 3 A_TossGib();
			SREB Q 0 A_NoBlocking();
			SREB Q 0 A_TossGib();
			SREB Q 3 A_XScream();
			SREB R 3 A_TossGib();
			SREB STUV 3 A_TossGib();
			SREB W -1;
			Stop;
		Burn:
			BURN A 3 Bright A_StartSound("human/imonfire", 2);
			BURN B 3 Bright A_DropFire();
			BURN C 3 Bright A_Wander();
			BURN D 3 Bright A_NoBlocking();
			BURN E 5 Bright A_DropFire();
			BURN FGH 5 Bright A_Wander();
			BURN I 5 Bright A_DropFire();
			BURN JKL 5 Bright A_Wander();
			BURN M 5 Bright A_DropFire();
			BURN NOPQPQ 5 Bright;
			BURN RSTU 7 Bright;
			BURN V -1;
			Stop;
		Disintegrate:
			DISR A 5 A_StartSound("misc/disruptordeath", 2);
			DISR BC 5;
			DISR D 5 A_NoBlocking();
			DISR EF 5;
			DISR GHIJ 4;
			MEAT D -1;
			Stop;
	}
}
class Shield : actor {
	Default {
		+DROPOFF
		+CORPSE
		+NOTELEPORT
		
		Health 1;		
	}
	
	States {
		Spawn:
			RSLD A 1;
			loop;
		Crash:
			RSLD B 4 A_StartSound("misc/metalhit", 0);
			RSLD C 4;
			RSLD D 1;
			Goto Crash+2;
	}
}

class spider_leader : ShieldRebel {
	Default {
		//$category "Monsters/WoS"
		//$Title "Spider  leader"
		
		Tag "$TAG_spider_leader";//Spider leader
	}
}

class EliteRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Elite Heretic"
		
		-Friendly
		
		Tag "$TAG_EliteRebel";
		Health 95;
		PainChance 140;
		Speed 7;
		DropItem "AssaultGun";
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		DropItem "ClipofBullets";
		Dropitem "randomDrop_01";
		Obituary "%o was riddled by an Elite Rebel.";
	}
	
	States {
		Spawn:
			RAVW A 1 A_Look();
			loop;
		See:
			RAVW AABBCCDDAABBCCDDAABBCCDDAABBCCDD 2 A_Chase();
			RAVW A 0 A_Jump(20, "Strafing");
			loop;
		Strafing:
			RAVW AAAABBBBCCCCDDDDAAAABBBBCCCCDDDDAAAABBBBCCCCDDDD 1 A_FastChase();
			loop;
		Melee:
		Missile:
			RAVW E 1 A_FaceTarget();
			RAVW F 2 Bright A_ShootGun();
			RAVW F 2 Bright A_ShootGun();
			RAVW E 1 A_FaceTarget();
			RAVW F 2 Bright A_ShootGun();
			RAVW F 2 Bright A_ShootGun();
			RAVW E 1 A_FaceTarget();
			RAVW F 2 Bright A_ShootGun();
			RAVW F 2 Bright A_ShootGun();
			RAVW E 20;
			RAVW E 0 A_CPosRefire();
			Goto Missile;
		Pain:
			RAVW G 3 A_Pain();
			Goto See;
		Death:
			RAVW H 5 A_Scream();
			RAVW I 5 A_NoBlocking();
			RAVW JKL 4;
			RAVW M -1;
			Stop;
		XDeath:
			RAVW N 3 A_XScream();
			RAVW N 0 A_NoBlocking();
			RAVW OPQRST 3 A_TossGib();
			RAVW U -1;
			Stop;
	}
}
class GrenadeRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Grenade Heretic"
		
		-Friendly
		
		Tag "$TAG_GrenadeRebel";
		Health 90;
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		DamageFactor "RebelGrenade", 0.1;
		DropItem "StrifeGrenadeLauncher";
		Obituary "%o was shot by a Rebel Grenadier.";
		Dropitem "randomDrop_03";
	}
	
	States {
		Spawn:
			GREB A 1 A_Look();
			loop;
		See:
			GREB AABBCCDD 3 A_Chase();
			loop;
		Melee:
		Missile:
			GREB E 0 A_JumpIfCloser(200, "Gun");
			GREB E 10 A_FaceTarget();
			GREB F 5 Bright A_SpawnProjectile("RebelGrenade");
			GREB E 10 A_FaceTarget();
			GREB F 5 Bright A_SpawnProjectile("RebelGrenade");
			Goto See;
		Gun:
			GREB E 6 A_FaceTarget();
			GREB F 6 Bright A_ShootGun();
			Goto See;
		Pain:
			GREB G 3;
			GREB G 3 A_Pain();
			Goto See;
		Death:
		GREB H 5 A_Scream();
			GREB I 5 A_NoBlocking();
			GREB JKLM 4;
			GREB N -1;
			Stop;
		XDeath:
			GREB O 4 A_TossGib();
			GREB P 4 A_XScream();
			GREB Q 3 A_NoBlocking();
			GREB RSTU 3 A_TossGib();
			GREB V -1;
			Stop;
	}
}
class RebelGrenade : HEGrenade {
	Default {
		BounceCount 3;
		Speed 25;
		DamageType "RebelGrenade";
		Obituary "%o tripped a rebel's grenade.";
	}
}
class MaulerRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Mauler Heretic"
		
		-Friendly
		
		Health 100;
		Tag "$TAG_MaulerRebel";
		AttackSound "templar/shoot";
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		Obituary "%o got mauled by a Mauler Rebel.";
		DropItem "Mauler";
		Dropitem "randomDrop_04";
	}
	
	States {
		Spawn:
			MRBL A 1 A_Look();
			loop;
		NoAttackSee:
			MRBL AABBCCDDAABBCCDDAABBCCDD 3 A_Chase();
		See:
			MRBL AABBCCDD 3 A_Chase();
			loop;
		Melee:
		Missile:
			MRBL E 35 A_FaceTarget();
			MRBL F 5 Bright A_CustomBulletAttack(11.25, 7, 20, 5*random(1, 3), "MaulerPuff");
			MRBL E 5 A_FaceTarget();
			Goto NoAttackSee;
		Pain:
			MRBL G 3;
			MRBL G 3 A_Pain();
			Goto See;
		Death:
			MRBL H 5 A_Scream();
			MRBL I 5 A_Noblocking();
			MRBL JK 4;
			MRBL L -1;
			Stop;
		XDeath:
			RAVW N 3 A_XScream();
			RAVW N 0 A_NoBlocking();
			RAVW OPQRST 3 A_TossGib();
			RAVW U -1;
			Stop;
	}
}

class tgPowerPlant_hereticCaptain : MaulerRebel {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "tg pp heretic captain"
		
		Tag "$TAG_tgPowerPlant_hereticCaptain";
		Health 200;
		DropItem "SHtgPowerplantKey";
	}
}

class FlamerRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Flamer Heretic"
		
		-Friendly
		
		Health 100;
		Tag "$TAG_FlamerRebel";
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		Obituary "%o got burned to death by a flamethrower rebel.";
		DropItem "Flamethrower";
		Dropitem "randomDrop_04";
		DamageFactor "Fire", 0.1;
	}
	
	States {
		Spawn:
			FLRB A 1 A_Look();
			loop;
		See:
			FLRB AABBCCDD 3 A_Chase();
			loop;
		Melee:
		Missile:
			FLRB E 0 A_JumpIfCloser(128, "Flamer");
			FLRB E 6 A_FaceTarget();
			FLRB F 6 A_ShootGun();
			Goto See;
		Flamer:
			FLRB E 2 A_FaceTarget();
		FlamerLoop:
			FLRB F 2 Bright A_SpawnProjectile("FlameMissile");
			FLRB F 3 Bright A_FaceTarget();
			FLRB E 0 A_JumpIfCloser(128, "FlamerLoop");
			Goto See;
		Pain:
			FLRB G 3;
			FLRB G 3 A_Pain();
			Goto See;
		Death:
			FLRB H 5 A_ScreamandUnblock();
			FLRB I 5;
			FLRB JK 4;
			FLRB L -1;
			Stop;
		XDeath:
			FLRB M 3 A_NoBlocking();
			FLRB N 3 A_XScream();
			FLRB OPQRS 3 A_TossGib();
			FLRB T -1;
			Stop;
	}
}

class RangerRebel : rebelEnemy {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "Ranger Heretic"
		
		-Friendly
		+LOOKALLAROUND
		
		Tag "$TAG_RangerRebel";
		PainSound "NewRebelPain";
		DeathSound "NewRebelDeath";
		AttackSound "monsters/rifle";
		Dropitem "randomDrop_01";
	}
	
	States {
		Spawn:
			RANG A 1 A_Look();
			loop;
		See:
			RANG ABCD 6 A_Chase();
			loop;
		Melee:
			RANG E 4 A_CustomMeleeAttack(random(1, 4)*5, "misc/meathit", "misc/swish");
			RANG A 12;
			Goto See;
		Missile:
			RANG E 35 A_FaceTarget();
			RANG F 4 Bright A_CustomBulletAttack(1, 1, 1, random(1, 5)*8);
			RANG E 10 A_FaceTarget();
			Goto See;
		Pain:
			RANG G 6 A_Pain();
			Goto See;
		Death:
			RANG H 4 A_ScreamandUnBlock();
			RANG IJK 4;
			RANG L -1;
			Stop;
		XDeath:
			CGIB A 3 A_XScream();
			CGIB BCDEFG 3 A_TossGib();
			CGIB H -1;
			Stop;
	}
}

class hereticCaptain : EliteRebel {
	Default {
		//$Title "Heretic Captain"
		
		Tag "$TAG_hereticCaptain";
		Dropitem "leaderskull";
		Dropitem "randomDrop_01";
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// spiker trap ////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class spikerTrap : actor {

	void A_TrapAttack() {
		let targ = target;
		if (targ)
		{
			int damage = random[spikerTrap](1, 8) * 3;
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
				
		Monster;
		Speed 0;
		Health 2000;
		Mass 10000;
		PainChance 200;
	
	}
	
	States {
		Spawn:
			TRAP A 1;
			Loop;
			
		See:
			TRAP A 1 A_Chase();
			Loop;
		
		Melee:
			TRAP A 2;
			TRAP B 3 A_TrapAttack();
			TRAP A 2;
			TRAP B 3 A_TrapAttack();
			TRAP A 2;
			TRAP B 3 A_TrapAttack();
			TRAP A 4;
			goto See;
		Death:
			TRAP A -1;
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// reikall's voxel sentinel - cool stuff :) ///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class RV_Sentinel : Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Sentinel vox"
		+DONTINTERPOLATE
		
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
}
class RV_CeilingTurret : CeilingTurret {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Ceiling Turret vox"
		+DONTINTERPOLATE
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
class hackedSentinel : Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Hacked Sentinel"
		
		Tag "$TAG_hackedSentinel";
	}
}
class friendSentinel : Sentinel {
	Default {
		//$Category "Monsters/WoS"
		//$Title "Friendly Sentinel"
		
		+FRIENDLY
		
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  zombie mutant /////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ZombieFodder : actor {
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
			ZFOD L 5;
			ZFOD M -1;
			Stop;
		XDeath:
			ZFOD N 5;
			ZFOD O 5 A_XScream();
			ZFOD P 5 A_NoBlocking();
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
			GHUL L 5;
			GHUL M -1;
			Stop;
		  XDeath:
			GHUL N 5;
			GHUL O 5 A_XScream();
			GHUL P 5 A_NoBlocking();
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
class MiniSentinel : actor {
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
class Paladin : actor {
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
            STLK VW 4;
            STLK XYZ[ 4 Bright;
            Stop;
	}	
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// acolytes ///////////////////////////////////////////////////////////////////////////////////////////////////
// looting code from Lost Frontier, credits to jarewill ///////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class wosAcolyte : Acolyte replaces Acolyte {
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
	string looteqip; Property Equipment : looteqip; //
	int looteqip2; //
    
	Override void PostBeginPlay() {
		Super.PostBeginPlay();
		gunmag=30;
		//If(shielded==1){A_SpawnItemEx("LFAcolyteShield",flags: SXF_SETMASTER);}
		If(Random(1,3)==1){lootmed=1;} If(Random(1,8)==1){lootarm=1; lootarm2=Random(15,85);}
		If(Random(1,6)==1){lootgun=1; lootgun2=Random(50,600);} If(Random(1,10)==1){lootrep=1;}
		lootmoney=Random(3,15);
	}

	Override bool Used(Actor user) {
		let pawn = binderPlayer(user);
		If( searched==0 && health<1 && InStateSequence(CurState,ResolveState("Death")) && user is "binderPlayer" && pawn.currentarmor!=4 ) {
			int tosearch = 6 - (2 * pawn.SpeedUpgrade);
			If( searchtimer >= tosearch ) {
				If( lootmed == 1 ){ 
					Actor med = A_DropItem("wosHyposprej"); 
				}
				If( lootarm == 1 ){ 
					Actor arm = A_DropItem("wosLeatherArmor"); 
				}
				If( looteqip == "TARG" ){ 
					Actor trg = A_DropItem("wosTargeter"); 
				}
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
				If( lootgun == 1 ){ Actor gun = A_DropItem("zscAssaultGun"); }
				Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				searchtimer++;
			}
		}
		Return Super.Used(user);
	}
}
class wosAcolyteTan : wosAcolyte replaces AcolyteTan {}
class wosAcolyteRed : wosAcolyte replaces AcolyteRed {}
class wosAcolyteRust : wosAcolyte replaces AcolyteRust {}
class wosAcolyteGray : wosAcolyte replaces AcolyteGray {}
class wosAcolyteDGreen : wosAcolyte replaces AcolyteDGreen {}
class wosAcolyteLGreen : wosAcolyte replaces AcolyteLGreen {}
class wosAcolyteGold : wosAcolyte replaces AcolyteGold {}
class wosAcolyteBlue : wosAcolyte replaces AcolyteBlue {}
class wosAcolyteShadow : wosAcolyte replaces AcolyteShadow {}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ascension flesh imp ////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class ascImpFlesh : actor {
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
  		+PUSHABLE;
	}  
  	States {
		Spawn:
			IMP1 J 8 A_Look();
			Loop;
		See:
			IMP1 BBBCCC 2 A_Chase();
			IMP1 C 0 A_Playsound("H2Imp/Wings");
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
			IMP1 C 0 A_PlaySound("H2Imp/Charge");
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
			IMP1 H -1;
		Crash:
			IMP1 H 0 { bFLOATBOB = 0; }
			IMP1 I 5;
			IMP3 J 5;
			IMP3 K 5 A_NoBlocking();
			IMP3 L -1;
			Stop;
		Idle:
			IMP1 BBBCCC 2 A_Look();
			IMP1 B 0 A_Playsound("H2Imp/Wings");
			IMP1 BBBAAA 2 A_Look();
			Loop;
   	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////