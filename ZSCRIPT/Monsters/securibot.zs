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
		speed 8;
		painchance 20;
		DamageFactor "PoisonCloud", 0.0;
		//DamageFactor "Alarm", 0.0;
		SeeSound "ED209/See";
		PainSound "ED209/Pain";
		DeathSound "ED209/Death";
		Obituary "%o was riddled by a securibot.";
		MaxTargetRange 2048;
		Monster;
		+NOBLOOD;
		+FLOORCLIP;
		+INTERPOLATEANGLES;
	}
	
	states {
		Spawn:
			DUMA IIII 10 A_Look2();
			//More likely to jump to low look arounds than the high ones
			//Low look arounds
			DUMA I 0 {
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
			DUMA I 0 A_Jump (128, "LookAroundUp");
			Loop;
		
		
		//Low look arounds
		//Low full sweep right first
		LookAroundLow1:
			DUMA I 10 A_Look2();
			//look right
			DUMA EFFFFE 10 A_Look2(); 
			//Face front again
			DUMA I 10 A_Look2();
			//look left
			DUMA GHHHHG 10 A_Look2();
			//Face front again
			DUMA I 5 A_Look2();
			Goto Spawn;
		
		//Low full sweep left first
		LookAroundLow2:
			DUMA I 10 A_Look2();
			//look left
			DUMA GHHHHG 10 A_Look2();
			//Face front again
			DUMA I 10 A_Look2();
			//look right
			DUMA EFFFFE 10 A_Look2(); 
			//Face front again
			DUMA I 5 A_Look2();
			Goto Spawn;
		
		//Low right only
		LookAroundLow3:
			DUMA I 10 A_Look2(); 
			//look right
			DUMA EFFFFE 10 A_Look2(); 
			//Face front again
			DUMA I 5 A_Look2();
			Goto Spawn;
		
		//Low left only
		LookAroundLow4:
			DUMA I 10 A_Look2(); 
			//look left
			DUMA GHHHHG 10 A_Look2(); 
			//Face front again
			DUMA I 5 A_Look2(); 
			Goto Spawn;
		
		//High look arounds
		//Stand tall
		LookAroundUp:
			DUMA I 0 A_PlaySound ("ED209/Whine2", CHAN_BODY);
			DUMA I 10 A_Look2(); 
			DUMA D 0 A_Look2(); 
			//Stand up
			DUMB AB 10 A_Look2(); 
			DUMB C 0 A_PlaySound ("ED209/Tiss1", CHAN_AUTO);
			DUMB CC 10 A_Look2(); 
			DUMB C 0 {
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
			DUMB CDEEEF 10 A_Look2(); 
			//Face front again
			DUMB G 10 A_Look2();  
			//Look Left
			DUMB HIIIJ 10 A_Look2(); 
			Goto LookAroundDown;
		
		//tall full sweep left first
		LookAroundTall2:
			//Look Left
			DUMB CHIIIJ 10 A_Look2(); 
			//Face front again
			DUMB G 10 A_Look2();
			//Look right
			DUMB DEEEF 10 A_Look2(); 
			Goto LookAroundDown;
		
		//tall right only
		LookAroundTall3:
			//Look right
			DUMB CDEEEF 10 A_Look2();  
			//Face front again
			DUMB GG 10 A_Look2();  
			Goto LookAroundDown;
		
		//tall left only
		LookAroundTall4:
			//Look Left
			DUMB CHIIIJ 10 A_Look2(); 
			//Face front again
			DUMB GG 10 A_Look2(); 
			//back down
			Goto LookAroundDown;
		
		//back down
		LookAroundDown:
			DUMB C 0 A_PlaySound ("ED209/Whine1", CHAN_BODY);
			DUMB CCB 10 A_Look2(); 
			//interpolation fix
			DUMB A 0 A_PlaySound ("ED209/Tiss2", CHAN_AUTO);
			DUMA D 5 A_Look2(); 
			DUMA I 0 A_Look2(); 
			Goto Spawn;

		See:
			DUMC AA 2 A_Chase();
			DUMC BB 2 A_Chase(); 
			DUMC CC 2 A_Chase();
			DUMC DD 2 A_Chase(); 
			DUMC D 0 A_PlaySound("ED209/Walk", CHAN_BODY, 0.6, 0, 1.2);
			DUMC EE 2 A_Chase();
			DUMC FF 2 A_Chase(); 
			DUMC GG 2 A_Chase();
			DUMC HH 2 A_Chase(); 
			DUMC II 2 A_Chase(); 
			DUMC I 0 A_PlaySound("ED209/Walk", CHAN_BODY, 0.6, 0, 1.2);
			loop;
		Missile:
			DUMD B 0 A_CheckLOF ("Missile2", CLOFF_JUMP_ON_MISS|CLOFF_MUSTBESOLID, 2048, 0, 0, 0, 24, 0, AAPTR_DEFAULT);
			goto See;
		Missile2: 
			DUMD BBBBBBBBBB 2 A_FaceTarget(); 
			DUMD C 0 A_CheckLOF ("Missile3", CLOFF_JUMP_ON_MISS|CLOFF_MUSTBESOLID|CLOFF_JUMPOBJECT, 2048, 0, 0, 0, 24, 0, AAPTR_DEFAULT);
			goto See;
		Missile3:  
			DUMD C 0 A_SpawnItemEx ("MuzzleFlashMedium", 50.0, 23.0, 57.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD C 0 A_SpawnItemEx ("MuzzleFlashSmall", 58.0, 23.0, 57.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD C 0 A_FaceTarget(); 
			//DUMD C 0 bright A_PlaySound("ED209/Shot");
			DUMD C 0 bright A_PlaySound("securibot/shoot"); //weapons/assaultgun // weapons/execRiflShoot
			DUMD C 1 bright A_CustomBulletAttack(16.0, 8.0, 3, random(1,5)*3, "BulletPuff", 0, CBAF_NORANDOM);
			DUMD D 1 A_FaceTarget(); 
			//fake attack to look scarier
			DUMD D 0 A_SpawnItemEx ("MuzzleFlashMedium", 52.0, (frandom(22.0,24.0)), (frandom(54.0,58.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD D 0 A_SpawnItemEx ("MuzzleFlashSmall", 60.0, (frandom(22.0,24.0)), (frandom(54.0,58.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//
			DUMD D 1 A_FaceTarget(); 
			DUMD E 0 A_SpawnItemEx ("MuzzleFlashMedium", 50.0, -23.0, 57.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD E 0 A_SpawnItemEx ("MuzzleFlashSmall", 58.0, -23.0, 57.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD E 1 A_FaceTarget(); 
			//DUMD C 0 bright A_PlaySound("ED209/Shot");
			DUMD C 0 bright A_PlaySound("securibot/shoot");
			DUMD E 1 bright A_CustomBulletAttack(16.0, 8.0, 3, random(1,5)*3, "BulletPuff", 0, CBAF_NORANDOM);
			DUMD E 1 A_FaceTarget(); 
			DUMD E 0 A_SpawnItemEx ("MuzzleFlashMedium", 52.0, (frandom(-24.0,-22.0)), (frandom(54.0,58.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD E 0 A_SpawnItemEx ("MuzzleFlashSmall", 60.0, (frandom(-24.0,-22.0)), (frandom(54.0,58.0)), 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMD D 2 A_FaceTarget(); 
			DUMD D 3 A_SpidRefire(); 
			goto Missile2+10;
		Pain:
			DUMD A 2;
			DUMD A 2 A_Pain(); 
			goto See;
		Death:
			//DUMF A 0 A_SpawnItemEx ("Alarm01", 0, 0, 0, 0, 0, 0, 0, SXF_NOCHECKPOSITION, 0);
			DUMF A 0 A_Jump (96, "Death2");  //lower chance of death2 because it doesn't look as good
			//fallthrough to death1
			
			Death1:
			DUME A 3 A_Quake(9,8,0,192,"NJMT");
			DUME B 3 A_TossGib(); 		
			DUME B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, 32.0, 48.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUME B 0 A_PlaySound ("inquisitor/atkexplode");		
			DUME CD 3 A_TossGib(); 
			DUME B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, -32.0, 56.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUME B 0 A_PlaySound ("inquisitor/atkexplode");		
			DUME E 0 A_Scream(); 
			DUME EFG 3 A_TossGib();		
			DUME G 0 A_SpawnItemEx ("wosExplosion_medium", 0.0, 0.0, 72.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//DUME G 0 A_SpawnItemEx ("ModelSmoke1Medium", 0.0, 0.0, 72.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUME H 3 A_Fall(); 
			DUME IJKLM 3;		
			DUME M 0 A_PlaySound ("inquisitor/atkexplode");
			DUME M 0 A_SpawnItemEx ("wosExplosion_medium", -24.0, 24.0, 96.0, 0.0, 0.0, -2.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//DUME M 0 A_SpawnItemEx ("ModelSmoke1Small", -24.0, 24.0, 88.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUME M 0 A_PlaySound ("inquisitor/atkexplode");
			TNT1 A 0 W_rewardXP(SpawnHealth());		
			DUME NOPQRSTUVWX 3;
			DUME Y 350;
			Goto FadeOut1;
			
		FadeOut1:
			DUME Y 1 A_FadeOut(0.01);
			Loop;
		
		Death2:
			DUMF A 1;
			DUMF A 0 A_Scream(); 
			DUMF AA 3 A_Quake(9,8,0,192,"NJMT");
			DUMF B 0 A_SpawnItemEx ("wosExplosion_medium", -8.0, 32.0, 48.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMF B 0 A_PlaySound ("inquisitor/atkexplode");
			DUMF BBBCC 1 A_TossGib(); 
			DUMF C 0 A_SpawnItemEx ("wosExplosion_medium", -16.0, -32.0, 56.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMF C 0 A_PlaySound ("inquisitor/atkexplode");   
			DUMF CDDD 1 A_TossGib(); 
			DUMF D 0 A_PlaySound ("boomexplosion");
			DUMF D 0 A_SpawnItemEx ("wosExplosion_medium", 0.0, 0.0, 72.0, 0.0, 0.0, 0.0, 0.0, SXF_NOCHECKPOSITION, 0);
			//DUMF D 0 A_SpawnItemEx ("ModelSmoke1Medium", 0.0, 0.0, 72.0, 0.0, 0.0, 1.0, 0.0, SXF_NOCHECKPOSITION, 0);
			DUMF EEEFFF 1 A_TossGib(); 
			DUMF G 3;
			TNT1 A 0 W_rewardXP(SpawnHealth());
			DUMF H 3 A_Fall(); 
			DUMF IJKLMNOPQR 3;
			DUMF S 350;
			goto Fadeout2;
		
		FadeOut1:
			DUME Y 1 A_FadeOut(0.01);
			Loop;
		
		FadeOut2:
			DUMF S 1 A_FadeOut(0.01);
			Loop;
	}
}
class wosSecuribotFriendly : wosSecuriBot {
	Default {
        //$Category "Monsters/WoS"		
        //$Title "securibot friendly"
		+FRIENDLY;
	}
}
class muzzleFlashMedium : actor {
	Default {
		+NOTELEPORT;
        +NOBLOCKMAP;
        +CORPSE;
        +BLOODLESSIMPACT;
        +FORCEXYBILLBOARD;
        +NODAMAGETHRUST;
        +MOVEWITHSECTOR;
        +NOBLOCKMONST;
        -SOLID;
        +THRUACTORS;
        +DONTSPLASH;
        +NOGRAVITY;
        +DONTBLAST;
		radius 2;
		height 2;
		Scale 0.75;
	}
	States {
		Spawn:
			WFLR AB 2 Bright;
			Stop;
	}
}
class muzzleFlashSmall : muzzleFlashMedium {
	Default {
		Scale 0.5;
	}
}
