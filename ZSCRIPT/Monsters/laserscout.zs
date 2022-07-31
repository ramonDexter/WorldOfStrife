Class LaserScout : wosMonsterBase {

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
					Actor med = A_DropItem("wosArmorShard"); 
				}
				If( lootarm == 1 ){ 
					Actor arm = A_DropItem("wosMetalArmor"); 
				}
				/*If( looteqip == "TARG" ){ 
					Actor trg = A_DropItem("wosArmorShard"); 
				}*/
				While( lootmoney > 0 ) {
					If( lootmoney >= 25 ){ 
						A_DropItem("wosEnergyKit"); 
						lootmoney-=25; 
					} Else If( lootmoney >= 10 ){ 
						A_DropItem("wosEnergyCell"); 
						lootmoney-=10; 
					} Else If(lootmoney>=5){
						A_DropItem("wosEnergyPod"); 
						lootmoney-=5;
					}
				}
				//If( lootgun == 1 ){ Actor gun = A_DropItem("wosAssaultGun"); }
				//Else If( gunmag > 1 ){ Actor mag = A_DropItem("ClipOfBullets",gunmag/2); }
				If( lootrep == 1 ){ Actor rep = A_DropItem("wosArmorShard"); }
				searched = 1;
			} Else {
				A_ChangeVelocity(frandom(-0.5,0.5),frandom(-0.5,0.5));
				A_StartSound("sounds/armorMedium");
				searchtimer++;
			}
		}
		Return Super.Used(user);
	}

	Default {
		//$category "Monsters/Heretics"
		//$Title "Heretic Laser Scout"
		Health 250;
		Speed 11;
		Radius 16;
		Height 56;
		Mass 450;
		PainChance 40;
		Tag "Laser-Scout";
		DeathSound "scout/death";
		Obituary "%o was vaporized by a laser-scout.";
		//DropItem "wosEnergyPod";
		GibHealth 100;
		-FLOAT
		-NOGRAVITY
		-SPAWNCEILING
		-NOGRAVITY
		-DROPOFF
		+SEESDAGGERS
	}
	States {
		Spawn:
			MECH H 1 A_TurretLook();
			loop;
		See:
			MECH ABCD 5 A_Chase();
			loop;
		Melee:
		Missile:
			MECH E 2 A_FaceTarget();
			MECH F 4 Bright A_SpawnProjectile("SentinelFX3", 48, -8) ;
			MECH E 2 A_FaceTarget();
			MECH E 0 A_MonsterRefire(30, "See");
			Goto Missile+1;
		Pain:
			MECH G 4 A_Pain();
			Goto See;
		Death:
			MECH I 6 A_Scream();
			MECH J 6 A_Fall();
			MECH K 6;
			MECH L 12;
			MECH MNO 5 Bright;
            TNT1 A 0 W_rewardXP(SpawnHealth());
			MECH L -1;
			Stop;
		XDeath:
			MECH Q 5 Bright A_StartSound("reaver/death", CHAN_BODY);
			MECH Q 0 {
				A_SpawnItemEx("wosExplosion_low");
				A_Explode();
				A_Fall();
			}
			MECH RRSSTT 2 Bright A_TossGib();
			MECH UVW 5 Bright A_TossGib();
            TNT1 A 0 W_rewardXP(SpawnHealth());
			MECH X -1;
			Stop;
	}
}
Class SentinelFX3 : SentinelFX2 {
	Default { 
		+BRIGHT 
	}
	States {
		Spawn:
		SHT1 AABB 2 A_SpawnItemEx("LaserTrail", -10);
		loop;
	}
}
Class LaserTrail : Actor {
	Default {
		+BRIGHT
		+NOGRAVITY
	}
	States {
		Spawn:
		SHT1 AAAABBBB 4 A_FadeOut(0.5);
		loop;
	}
}