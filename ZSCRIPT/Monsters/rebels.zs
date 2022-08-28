///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rebel enemy base class /////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class rebelEnemy : Rebel replaces Rebel {

	// usage: W_rewardXPRebel(SpawnHealth());   //
	action void W_rewardXPRebel (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}

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
		If(Random(1,3)==1) { lootmed=1; } 
		If(Random(1,8)==1) { lootarm=1; lootarm2=Random(15,85); }
		If(Random(1,6)==1) { lootgun=1; lootgun2=Random(50,600); } 
		If(Random(1,10)==1) { lootrep=1; }
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
				If( lootgun == 1 ){ Actor gun = A_DropItem("wosAssaultGun"); }
				Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				A_StartSound("sound/wearClothing");
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
			//TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			HMN1 N -1;
			Stop;
		XDeath:
			RGIB A 4 A_TossGib;
			RGIB B 4 A_XScream;
			RGIB C 3 A_NoBlocking;
			RGIB DEF 3 A_TossGib;
			RGIB G 3;
			//TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
		Dropitem "wosgold10";
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
		//DropItem "AssaultGun";
		DropItem "Shield";
		//Dropitem "randomDrop_02";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			SREB O -1;
			Stop;
		XDeath:
			SREB P 3 A_TossGib();
			SREB Q 0 A_NoBlocking();
			SREB Q 0 A_TossGib();
			SREB Q 3 A_XScream();
			SREB R 3 A_TossGib();
			SREB STUV 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			BURN RSTU 7 Bright;
			BURN V -1;
			Stop;
		Disintegrate:
			DISR A 5 A_StartSound("misc/disruptordeath", 2);
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
		//DropItem "ClipofBullets";
		//Dropitem "randomDrop_01";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			RAVW M -1;
			Stop;
		XDeath:
			RAVW N 3 A_XScream();
			RAVW N 0 A_NoBlocking();
			RAVW OPQRST 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
		//Dropitem "randomDrop_03";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			GREB N -1;
			Stop;
		XDeath:
			GREB O 4 A_TossGib();
			GREB P 4 A_XScream();
			GREB Q 3 A_NoBlocking();
			GREB RSTU 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
		//Dropitem "randomDrop_04";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			MRBL L -1;
			Stop;
		XDeath:
			RAVW N 3 A_XScream();
			RAVW N 0 A_NoBlocking();
			RAVW OPQRST 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			RAVW U -1;
			Stop;
	}
}

class tgPowerPlant_hereticCaptain : MaulerRebel {
	Default {
		//$Category "Monsters/Heretics"
		//$Title "tg pp heretic captain"
		
		Tag "$TAG_tgPowerPlant_hereticCaptain";
		Health 222;
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
		//Dropitem "randomDrop_04";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			FLRB L -1;
			Stop;
		XDeath:
			FLRB M 3 A_NoBlocking();
			FLRB N 3 A_XScream();
			FLRB OPQRS 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
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
		//Dropitem "randomDrop_01";
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
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			RANG L -1;
			Stop;
		XDeath:
			CGIB A 3 A_XScream();
			CGIB BCDEFG 3 A_TossGib();
			TNT1 A 0 W_rewardXPRebel(SpawnHealth());
			CGIB H -1;
			Stop;
	}
}

class hereticCaptain : EliteRebel {
	Default {
		//$Title "Heretic Captain"
		
		Tag "$TAG_hereticCaptain";
		Dropitem "leaderskull";
		Health 222;
		//Dropitem "randomDrop_01";
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////