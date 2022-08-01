///////////////////////////////////////////
// Tall Ed209 Chaingun Droid
///////////////////////////////////////////
  
//High look arounds use a different model.
//For some reason, interpolation makes the ED209 vanish momentarily
//when returning to the main model after these sequences.
//A 0 duration frame at the end of the sequence fixes it.
//
// The modeldef has a few sprites that do not appear in the DECORATE
// allocated to modelframes simply because I spent so much time 
// editing and re-editing this one.  It was a pain to get right.

class wosSecuriBot : wosMonsterBase {
	Default {
        //$Category "Monsters/WoS"		
        //$Title "securibot"
		Tag "Securibot";
		health 750;
		radius 40;
		height 100;
		mass 750;
		speed 12;
		painchance 20;
		DamageFactor "PoisonCloud", 0.0;
		//DamageFactor "Alarm", 0.0;
		SeeSound "ED209/See";
		PainSound "ED209/Pain";
		DeathSound "ED209/Death";
		Obituary "%o was riddled by a securibot.";
		MaxTargetRange 2048;
		//MONSTER;
		+NOBLOOD
		+FLOORCLIP
		+INTERPOLATEANGLES
	}
	
	states {
		Spawn:
			AGRD IIII 10 A_Look();
			//More likely to jump to low look arounds than the high ones
			//Low look arounds
			AGRD I 0 {
				if (random(1,4)==1) {
					return resolveState("LookAroundLow1");
				} else if ( random(1,4)==2 ) {
					return resolveState("LookAroundLow2");
				} else if ( random(1,4)==3 ) {
					return resolveState("LookAroundLow3");
				} else if ( random(1,4)==4 ) {
					return resolveState("LookAroundLow4");
				} 
				return resolveState(null);
			}
			//high look arounds
			AGRD I 0 A_Jump (128, "LookAroundUp");
			Loop;
		
		
		//Low look arounds
		//Low full sweep right first
		LookAroundLow1:
			AGRD I 10 A_Look();
			//look right
			AGRD EFFFFE 10 A_Look(); 
			//Face front again
			AGRD I 10 A_Look();
			//look left
			AGRD GHHHHG 10 A_Look();
			//Face front again
			AGRD I 5 A_Look();
			Goto Spawn;
		
		//Low full sweep left first
		LookAroundLow2:
			AGRD I 10 A_Look();
			//look left
			AGRD GHHHHG 10 A_Look();
			//Face front again
			AGRD I 10 A_Look();
			//look right
			AGRD EFFFFE 10 A_Look(); 
			//Face front again
			AGRD I 5 A_Look();
			Goto Spawn;
		
		//Low right only
		LookAroundLow3:
			AGRD I 10 A_Look(); 
			//look right
			AGRD EFFFFE 10 A_Look(); 
			//Face front again
			AGRD I 5 A_Look();
			Goto Spawn;
		
		//Low left only
		LookAroundLow4:
			AGRD I 10 A_Look(); 
			//look left
			AGRD GHHHHG 10 A_Look(); 
			//Face front again
			AGRD I 5 A_Look(); 
			Goto Spawn;
		
		//High look arounds
		//Stand tall
		LookAroundUp:
			AGRD I 0 A_PlaySound ("ED209/Whine2", CHAN_BODY);
			AGRD I 10 A_Look(); 
			AGRD D 0 A_Look(); 
			//Stand up
			ROB2 AB 10 A_Look(); 
			ROB2 C 0 A_PlaySound ("ED209/Tiss1", CHAN_AUTO);
			ROB2 CC 10 A_Look(); 
			ROB2 C 0 {
				if (random(1,4)==1) {
					return resolveState("LookAroundTall1");
				} else if ( random(1,4)==2 ) {
					return resolveState("LookAroundTall2");
				} else if ( random(1,4)==3 ) {
					return resolveState("LookAroundTall3");
				} else if ( random(1,4)==4 ) {
					return resolveState("LookAroundTall4");
				} 
				return resolveState(null);
			}
		
		//tall full sweep right first
		LookAroundTall1:
			//Look right
			ROB2 CDEEEF 10 A_Look(); 
			//Face front again
			ROB2 G 10 A_Look();  
			//Look Left
			ROB2 HIIIJ 10 A_Look(); 
			Goto LookAroundDown;
		
		//tall full sweep left first
		LookAroundTall2:
			//Look Left
			ROB2 CHIIIJ 10 A_Look(); 
			//Face front again
			ROB2 G 10 A_Look();
			//Look right
			ROB2 DEEEF 10 A_Look(); 
			Goto LookAroundDown;
		
		//tall right only
		LookAroundTall3:
			//Look right
			ROB2 CDEEEF 10 A_Look();  
			//Face front again
			ROB2 GG 10 A_Look();  
			Goto LookAroundDown;
		
		//tall left only
		LookAroundTall4:
			//Look Left
			ROB2 CHIIIJ 10 A_Look(); 
			//Face front again
			ROB2 GG 10 A_Look(); 
			//back down
			Goto LookAroundDown;
		
		//back down
		LookAroundDown:
			ROB2 C 0 A_PlaySound ("ED209/Whine1", CHAN_BODY);
			ROB2 CCB 10 A_Look(); 
			//interpolation fix
			ROB2 A 0 A_PlaySound ("ED209/Tiss2", CHAN_AUTO);
			AGRD D 5 A_Look(); 
			AGRD I 0 A_Look(); 
			Goto Spawn;

		See:
			SEWR AA 2 A_Chase();
			SEWR BB 2 A_Chase(); 
			SEWR CC 2 A_Chase();
			SEWR DD 2 A_Chase(); 
			SEWR D 0 A_PlaySound("ED209/Walk", CHAN_BODY, 0.6, 0, 1.2);
			SEWR EE 2 A_Chase();
			SEWR FF 2 A_Chase(); 
			SEWR GG 2 A_Chase();
			SEWR HH 2 A_Chase(); 
			SEWR II 2 A_Chase(); 
			SEWR I 0 A_PlaySound("ED209/Walk", CHAN_BODY, 0.6, 0, 1.2);
			loop;
		Missile:
			PGRD B 0 A_CheckLOF ("Missile2", CLOFF_JUMP_ON_MISS|CLOFF_MUSTBESOLID, 2048, 0, 0, 0, 24, 0, AAPTR_DEFAULT);
			goto See;
		Missile2: 
			PGRD BBBBBBBBBB 2 A_FaceTarget(); 
			PGRD C 0 A_CheckLOF ("Missile3", CLOFF_JUMP_ON_MISS|CLOFF_MUSTBESOLID|CLOFF_JUMPOBJECT, 2048, 0, 0, 0, 24, 0, AAPTR_DEFAULT);
			goto See;
		Missile3:  
			//PGRD C 0 A_SpawnItemEx ("MuzzleFlashMedium", 60.0, 36.0, 77.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//PGRD C 0 A_SpawnItemEx ("MuzzleFlashSmall", 68.0, 36.0, 77.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			PGRD C 0 A_FaceTarget(); 
			//PGRD C 0 bright A_PlaySound("ED209/Shot");
			PGRD C 0 bright A_PlaySound("weapons/execRiflShoot");
			PGRD C 1 bright A_CustomBulletAttack(16.0, 8.0, 3, random(1,5)*3, "BulletPuff", 0, CBAF_NORANDOM);
			PGRD D 1 A_FaceTarget(); 
			//fake attack to look scarier
			//PGRD D 0 A_SpawnItemEx ("MuzzleFlashMedium", 62.0, (frandom(35.0,37.0)), (frandom(78.0,82.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//PGRD D 0 A_SpawnItemEx ("MuzzleFlashSmall", 70.0, (frandom(35.0,37.0)), (frandom(78.0,82.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//
			PGRD D 1 A_FaceTarget(); 
			//PGRD E 0 A_SpawnItemEx ("MuzzleFlashMedium", 60.0, -36.0, 77.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//PGRD E 0 A_SpawnItemEx ("MuzzleFlashSmall", 68.0, -36.0, 77.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			PGRD E 1 A_FaceTarget(); 
			//PGRD C 0 bright A_PlaySound("ED209/Shot");
			PGRD C 0 bright A_PlaySound("weapons/execRiflShoot");
			PGRD E 1 bright A_CustomBulletAttack(16.0, 8.0, 3, random(1,5)*3, "BulletPuff", 0, CBAF_NORANDOM);
			PGRD E 1 A_FaceTarget(); 
			//PGRD E 0 A_SpawnItemEx ("MuzzleFlashMedium", 62.0, (frandom(-37.0,-35.0)), (frandom(75.0,80.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//PGRD E 0 A_SpawnItemEx ("MuzzleFlashSmall", 70.0, (frandom(-37.0,-35.0)), (frandom(75.0,80.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			PGRD D 2 A_FaceTarget(); 
			PGRD D 3 A_SpidRefire(); 
			goto Missile2+10;
		Pain:
			PGRD A 2;
			PGRD A 2 A_Pain(); 
			goto See;
		Death:
			//ROB3 A 0 A_SpawnItemEx ("Alarm01", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION, 0);
			ROB3 A 0 A_Jump (96, "Death2");  //lower chance of death2 because it doesn't look as good
			//fallthrough to death1
			
			Death1:
			ROB1 A 3 A_Quake(9,8,0,192,"NJMT");
			ROB1 B 3 A_TossGib(); 		
			ROB1 B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, 32.0, 48.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB1 B 0 A_PlaySound ("inquisitor/atkexplode");		
			ROB1 CD 3 A_TossGib(); 
			ROB1 B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, -32.0, 56.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB1 B 0 A_PlaySound ("inquisitor/atkexplode");		
			ROB1 E 0 A_Scream(); 
			ROB1 EFG 3 A_TossGib();		
			ROB1 G 0 A_SpawnItemEx ("wosExplosion_medium", 0.0, 0.0, 72.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//ROB1 G 0 A_SpawnItemEx ("ModelSmoke1Medium", 0.0, 0.0, 72.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB1 H 3 A_Fall(); 
			ROB1 IJKLM 3;		
			ROB1 M 0 A_PlaySound ("inquisitor/atkexplode");
			ROB1 M 0 A_SpawnItemEx ("wosExplosion_medium", -24.0, 24.0, 96.0, 0.0, 0.0, -2.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//ROB1 M 0 A_SpawnItemEx ("ModelSmoke1Small", -24.0, 24.0, 88.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB1 M 0 A_PlaySound ("inquisitor/atkexplode");
			TNT1 A 0 W_rewardXP(SpawnHealth());		
			ROB1 NOPQRSTUVWX 3;
			ROB1 Y 350;
			Goto FadeOut1;
			
		FadeOut1:
			ROB1 Y 1 A_FadeOut(0.01);
			Loop;
		
		Death2:
			ROB3 A 1;
			ROB3 A 0 A_Scream(); 
			ROB3 AA 3 A_Quake(9,8,0,192,"NJMT");
			ROB3 B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, 32.0, 48.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB3 B 0 A_PlaySound ("inquisitor/atkexplode");
			ROB3 BBBCC 1 A_TossGib(); 
			ROB3 C 0 A_SpawnItemEx ("wosExplosion_medium", -16.0, -32.0, 56.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB3 C 0 A_PlaySound ("inquisitor/atkexplode");   
			ROB3 CDDD 1 A_TossGib(); 
			ROB3 D 0 A_PlaySound ("boomexplosion");
			ROB3 D 0 A_SpawnItemEx ("wosExplosion_medium", 0.0, 0.0, 72.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//ROB3 D 0 A_SpawnItemEx ("ModelSmoke1Medium", 0.0, 0.0, 72.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
			ROB3 EEEFFF 1 A_TossGib(); 
			ROB3 G 3;
			TNT1 A 0 W_rewardXP(SpawnHealth());
			ROB3 H 3 A_Fall(); 
			ROB3 IJKLMNOPQR 3;
			ROB3 S 350;
			goto Fadeout2;
		
		FadeOut1:
			ROB1 Y 1 A_FadeOut(0.01);
			Loop;
		
		FadeOut2:
			ROB3 S 1 A_FadeOut(0.01);
			Loop;
	}
}
class wosSecuribotFriendly : wosSecuriBot {
	Default {
        //$Category "Monsters/WoS"		
        //$Title "securibot friendly"
		+FRIENDLY
	}
}
