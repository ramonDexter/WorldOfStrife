//spiders

class Spider : actor
{
	Default
	{
		+BLOODSPLATTER
		+ALWAYSFAST
		+FLOORCLIP
		+DONTOVERLAP
		
		BloodColor "Green";
		Monster;
		SeeSound "spiders/sight";
		AttackSound "spiders/active";
		PainSound "spiders/pain";
		DeathSound "spiders/death";
		ActiveSound "spiders/active";
		MeleeSound "spiders/active";
	}
	
	States
	{
		Death.Fire: //(The 3D0 Killing Time Way)
			NULL A 0 A_SetScale(0.40);
			TNT1 A 0 A_StopSound(1);
			ASHD A 4 BRIGHT A_Scream();
			ASHD B 4 BRIGHT;
			ASHD C 4 BRIGHT;
			ASHD D 4 BRIGHT;
			ASHD E 4 BRIGHT A_NoBlocking();
			ASHD F -1;
			TNT1 A 0 A_StopSound(1);
			Stop;
	}
}

//========================================================================//
//
// Spider Swarms
//
//========================================================================//

//Basic Spawners

class ZMSpawner : RandomSpawner
{
	Default
	{
		DropItem "SmallSteal";
		DropItem "PowerSlaveSpider2";
	}
}

class ZM2Spawner : RandomSpawner
{
	Default
	{
		DropItem "PowerSlaveSpider2";
		DropItem "Widow";
	}
}

class PSSSpawner : RandomSpawner
{
	Default
	{
		DropItem "PowerSlaveSpider", 255, 5;
		DropItem "PowerSlaveSpider2", 255, 2;
	}
}

class Swarm : actor
{
	Default
	{
		+FLOORCLIP
		DropItem "PowerSlaveSpider2";	
		DropItem "SmallSteal";
		DropItem "Fright";
	}
	
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_Fall();
		Stop;
	}
}

// Adult Spiders RandomSpawner

class BigSwarm : ACTOR
{
	Default
	{
		+FLOORCLIP
		DropItem "PowerSlaveSpider";
		DropItem "ShadowSpider";	
		DropItem "Fright";
	}
	
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_Fall();
		Stop;
	}
}

// Adult Spiders RandomSpawner 2

class BigSwarm2 : actor
{
	Default
	{
		+FLOORCLIP
		DropItem "BloodSpider";
		DropItem "SmallSteal";	
		DropItem "Fright";
	}
	
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_Fall();
		Stop;
	}
}

// Adult Spiders RandomSpawner 3

class SpiderHell : actor
{
	Default
	{
		+FLOORCLIP
		DropItem "PowerSlaveSpider";
		DropItem "ShadowSpider";	
		DropItem "BloodSpider";
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			TNT1 A 1 A_Fall();
			Stop;
	}
}

// Small Spiders RandomSpawner

class SpiderHell2 : actor
{
	Default
	{
		+FLOORCLIP
		DropItem "PowerSlaveSpider2";
		DropItem "ShadowSpider2";	
		DropItem "SmallSteal";
	}
	
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_Fall();
		Stop;
	}
}


//Flying Spiders RandomSpawner

class FlyingSpiderHell : actor
{
	Default
	{
		+FLOORCLIP
		DropItem "MutantFly";
		DropItem "PSWasp";
		DropItem "PSRedWasp";
	}
	
	States
	{
	Spawn:
		TNT1 A 0;
		TNT1 A 1 A_Fall();
		Stop;
	}
}





//===========================================================================
//
// Gibs
//
//==========================================================================

class Gibbery : actor
{
	Default
	{
		+BLOODSPLATTER
		+DOOMBOUNCE
		+FLOORCLIP
		+PUSHABLE
		+NOTAUTOAIMED
		+MISSILE
		+NOBLOCKMAP
		+MOVEWITHSECTOR
		+DROPOFF
		+NOTELEPORT
		+FORCEXYBILLBOARD
		+NOTDMATCH
		+GHOST
		+EXPLODEONWATER
		+DROPPED
		-NOGRAVITY
		-SOLID
		-COUNTKILL
		
		Mass 50;
		Radius 8;
		Height 4;
		Health 200;
		Gravity 0.8;
		Decal "BloodSplat";
		Bouncefactor 0.5;
		SeeSound "";
		Speed 10;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
		Death:
			TNT1 A 0 A_UnSetFloorClip();
			Stop;
	}
}

//=======================================================//
// Blood Spider Gibs									 //
//=======================================================//

class BloodHead : Gibbery
{
	Default
	{
		Scale 0.6;
	}
    States
    {
		Spawn:
			BHED A 0 ThrustThingZ(0, 45, 0, 1);
			BHED ABCDABCD 2;
		Death:
			BHED A -1;
			Stop;
	}
}
	
class SBloodHead : BloodHead
{
	Default
	{
		Scale 0.3;
	}
}

class BloodRleg : Gibbery 
{
	Default
	{
		Scale 0.6;
	}
	
    States
    {
		Spawn:
			LSEG A 0 ThrustThingZ (0, 45, 0, 1);
			LSEG ABCDABCD 2;
		Death:
			LSEG A -1;
			Stop;
	}
}

class BloodLleg : Gibbery 
{
	Default
	{
		Scale 0.6;
	}
    States
    {
		Spawn:
			RSEG A 0 ThrustThingZ (0, 45, 0, 1);
			RSEG ABCDABCD 2; 
		Death:
			RSEG A -1;
			Stop;
	}
}

//=======================================================//
// Powerslave Spider Gibs								 //
//=======================================================//

class PSHead : Gibbery
{
	Default
	{
		Scale 0.7;
	}
    States
    {
		Spawn:
			PSEN K 0 ThrustThingZ (0, 56, 0, 1);
			PSEN K 1;
		Death:
			PSEN K -1;
			Stop;
	}
}
	
class SPSHead : PSHead
{
	Default
	{
		Scale 0.3;
	}
}

class PSLleg : Gibbery 
{
	Default
	{
		Scale 0.7;
	}
	
    States
    {
		Spawn:
			PSEN L 0 ThrustThingZ (0, 50, 0, 1);
			PSEN LMLMLM 1;
		Death:
			PSEN L -1;
			Stop;
	}
}

class PSRleg : Gibbery 
{
	Default
	{
		Scale 0.7;
	}
    States
    {
		Spawn:
			PSEN N 0 ThrustThingZ (0, 45, 0, 1);
			PSEN NONONO 1; 
		Death:
			PSEN N -1;
			Stop;
	}
}

class PSEye : Gibbery
{
	Default
	{	
		+DOOMBOUNCE
		+BOUNCEONWALLS
		BounceFactor 0.65;
		Speed 15;
		Scale 0.8;
	}
	
    States
    {
		Spawn:
			PSEN R 0 ThrustThingZ (0, 50, 0, 1);
			PSEN R 1;
		Death:
			PSEN R -1;
			Stop;
	}
}

//=======================================================//
// ShadowCaster Spider Gibs								 //
//=======================================================//

class SHHead : Gibbery
{
	Default
	{
		Speed 10;
		Scale 0.7;
	}
	
    States
    {
		Spawn:
			SHHD A 0 ThrustThingZ (0, 80, 0, 1);
			SHHD ABCDEFGH 1;
		Death:
			SHHD I -1;
			Stop;
	}
}
	
class SSHHead : PSHead
{
	Default
	{
		Scale 0.3;
	}
}

class SHLleg : Gibbery 
{
	Default
	{
		Scale 0.7;
	}
	
    States
    {
		Spawn:
			SHLG A 0 ThrustThingZ (0, 50, 0, 1);
			SHLG ABCDEFGH 1;
		Death:
			SHLG G -1;
			Stop;
	}
}

class SHRleg : Gibbery 
{
	Default
	{
		Scale 0.7;
	}
	
    States
    {
    Spawn:
        SHRG A 0 ThrustThingZ (0, 45, 0, 1);
		SHRG ABCDEFGH 1;
	Death:
		SHRG G -1;
		Stop;
	}
}

class SHEye : Gibbery
{	
	Default
	{
		+DOOMBOUNCE
		+BOUNCEONWALLS
		BounceFactor 0.65;
		Speed 15;
		Scale 0.8;
	}
	
    States
    {
    Spawn:
        SHEY A 0 ThrustThingZ (0, 50, 0, 1);
		SHEY A 1;
	Death:
		SHEY A -1;
		Stop;
	}
}

//===========================================================================
//
// Avalon Spider
//
//===========================================================================

class AvalonSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Avalon Spider"
		
		//+BOSS
		+JUMPDOWN
		+NOBLOOD
		
		Tag "Avalon Spider";
		Health 125;
		Radius 20;
		Height 20;
		Speed 5;
		PainChance 130;
		Mass 250;
		Scale 0.55;
		SeeSound "Uspiders/See";
		PainSound "Uspiders/See";
		DeathSound "Uspiders/death";
		Obituary "%o was hardly tried to kill an Avalon Steel-Skinned Spider.";
	}
	States
	{
	Spawn:
		SPAY AABBBCCCBB 2 A_Look();
		Loop;
	See:
		SPAY DEFGHIJKL 2 FAST A_Chase();
		Loop;
	Melee:
		SPAV A 4 A_FaceTarget();
		SPAV ABCDE 3;
		SPAV F 3 A_CustomMeleeAttack(10,0,0);
		SPAV GHI 4;
		Goto See;
	Pain:
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 0);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 45); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 90); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 135); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 180); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 225); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 270); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 315);
		SPAV EFGHI 3;
		SPAV I 3 A_Pain();
		Goto See;
	Death:
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 0); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 45); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 90); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 135); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 180); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 225); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 270);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 315);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 360);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 405);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 450);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 495);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 540);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 585);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 630);
		SPAV IJKL 3 A_Scream();
		SPAV MNOP 3 A_NoBlocking();
		SPAV P -1 A_BossDeath();
		Stop;
	XDeath:
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 0);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 45); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 90);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 135);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 180); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 225); 
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 270);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 315);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 360);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 405);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 450);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 495);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 540);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 585);
		TNT1 A 0 A_SpawnProjectile("SmallBC", 32, 0, 630);
		DWID H 5 A_Scream();
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		DWID I 4 A_NoBlocking();
		DWID J 3 A_BossDeath();
		Stop;
	}
}


//Blood gas coding, TOTALY taken from Shut up and bleed

class SmallBC : actor
{
	Default
	{
		+STRIFEDAMAGE 
		+BLOODLESSIMPACT
		Radius 24;
		Height 6;
		Speed 2;
		Damage 6;
		Scale 0.25;
		Projectile; 
		RenderStyle "Translucent";
		Alpha 0.15;
		DeathSound "";
	}
	
    States 
    { 
		Spawn: 
			RTXM ABCDEABCDEABCDE 5;
			Stop;
		Death: 
			RTXM DCBA 4;
			Stop;
    } 
}


//===========================================================================
//
// Blood Spider
//
//===========================================================================

class BloodSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Blood Spider"
		
		Tag "Grey Spider";
		Health 75;
		PainChance 200;
		Height 35;
		Speed 12;
		Radius 15;
		Mass 300;
		Scale 0.55;
		Damage 1;
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Bspiders/death";
		ActiveSound "hx2spider/step";
		Obituary "%o was overwhelmed by a blood spider's huggable legs.";
	}
	States
	{
	Spawn:
		SPUL A 1 A_Look();
		Loop;
	See:
		TNT1 A 0 A_Jump(120,"Steady");
		SPUL BCDEBCDE Random(2,4) FAST A_Chase();
		TNT1 A 0 A_StartSound("hx2spider/step", 0);
		Loop;
	Steady:
		TNT1 A 0 A_Jump(120,"Steady2");
		SPUL A Random(10,35);
		Goto See;
	Steady2:
		SPUL BCDE Random(2,4) FAST A_Wander();
		Goto See;
	Melee:
		TNT1 A 0 A_Jump(80,"JumpChance");
		SPUL P 5 A_FaceTarget();
		SPUL F 3;
		SPUL G 4 A_CustomMeleeAttack(6,0,0);
		SPUL H 2;
		Goto See;
	JumpChance:
		TNT1 A 0 A_JumpIfCloser(400,"JumpAttack");
		Goto See;
	JumpAttack:
		SPUL P 10 A_FaceTarget();
		SPUL I 3 ThrustThingZ (0, 26, 0, 1);
		TNT1 A 0 ThrustThing (angle*256/360, 15, 0, 0);
	JumpUp:
		SPUL J 5 A_SkullAttack();
	JumpDown:
		SPUL K 1 A_CheckFloor("Drop");
		loop;
	Drop:
		SPUL L 2 A_Stop();
		Goto See;
	Pain:
		TNT1 A 0 A_Jump(128,"AggressivePain");
		TNT1 A 0 A_Jump(256,"FrightenedPain");
		Wait;
	AggressivePain:
		SPUL P 3 A_Pain();
		SPUL BCDE 3 FAST A_Chase();
		Goto See;
	FrightenedPain:
		SPUL P 3 A_Pain();
		SPUL BCDEBCDE 3 FAST A_Wander();
		Goto See;
	Death:
		SPUD A 0 A_SetScale(1.0);
		SPUD A 3 A_Scream();
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		SPUD C 0 A_SpawnProjectile("BloodHead");
		SPUD CC 0 A_SpawnProjectile("BloodRleg",-2,0,random(80,100),2,random(40,80));
		SPUD CC 0 A_SpawnProjectile("BloodLleg",-2,0,random(75,95),2,random(35,75));
		SPUD B 3 A_NoBlocking();
		SPUD C 3;
		Stop;
	}
}

//===========================================================================
//
// Stealth Spider
//
//===========================================================================

class BloodSpider2 : BloodSpider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Darkblood Spider"
		Tag "Darkblood spider";
		Obituary "o% silently cringed and died by a darkblood spider.";
		RenderStyle "Fuzzy";
		Scale 0.80;
	}
	
	States
	{
		Death:
			SPUD A 0 A_SetScale(1.0);
			SPUD A 3 A_Scream();
			TNT1 A 0 A_StartSound("Spiders/Explode", 7);
			SPUD B 3 A_NoBlocking();
			SPUD C 3;
			Stop;
	}
}

//===========================================================================
//
// DaggerFall Spider
//
//===========================================================================

class DaggerSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Dagger Spider"
		
		+ALWAYSFAST
		+BLOODSPLATTER
		+BOSSDEATH
		
		Tag "Spitting Spider";
		PainChance 80;
		Health 600;
		Radius 48;
		Height 64;
		Mass 1000;
		Scale 0.8;
		Speed 8;
		BloodColor "Red";
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Bspiders/death";
		Obituary "%o was no match for a Dagger spider of unusual size.";
	}
	States
	{
	Spawn:
		DAGD A 1 A_Look();
		Loop;
	See:
		DAGA A 1 A_Chase();
		DAGA ABBCCDD 1 A_Chase();
		DAGA E 1 A_Chase();
		DAGA EFFGGHH 1 A_Chase();
		Loop;
	Missile:
		DAGB AABB 3;
		DAGB C 10 A_FaceTarget();
		DAGB F 0 A_StartSound("Spiders/Attack");
		DAGB D 10 A_SpawnProjectile("BigSpit");
		DAGB E 5 A_FaceTarget();
		DAGB F 5;
		Goto See;
	Pain:
		DAGC A 4;
		DAGC A 4 A_Pain();
		Goto See;
	Death:
		TNT1 A 0 A_ScreamAndUnblock();
		DAGC AAAAAAAAAAAA 1; //A_SpawnDebris("NashGore_FlyingBlood",1)
		TNT1 AA 0 A_SpawnProjectile("SHEye",-2,0,random(80,100),2,random(40,80));
		DAGE AAAAAAAAAAAA 1; //A_SpawnDebris("NashGore_FlyingBlood",1)
		DAGE A -1 A_BossDeath();
		Stop;
	Death.Fire:
		NULL A 0 A_SetScale(0.80);
		ASHD A 4 BRIGHT A_Scream();
		ASHD B 4 BRIGHT A_BossDeath();
		ASHD C 4 BRIGHT;
		ASHD D 4 BRIGHT;
		ASHD E 4 BRIGHT A_NoBlocking();
		ASHD F -1;
		Stop;
	/*Raise:
		DAGC A 3;
		Goto See;*/
	}
}


//===========================================================================
//
// Big Spit
//
//===========================================================================

class BigSpit : CStaffMissile
{
	Default
	{
		+SOLID
		+NOBLOOD
		+RANDOMIZE
		-NOGRAVITY
		+ROCKETTRAIL
		+STRIFEDAMAGE
		+ADDITIVEPOISONDAMAGE
		+ADDITIVEPOISONDURATION
		
		Radius 2;
		Height 2;
		Damage 3;
		Projectile;
		Gravity 0.4;
		Speed 50;
		DamageType "Poison";
		SeeSound "baron/attack";
		DeathSound "baron/shotx";
		PoisonDamage 2,2,0;
		RenderStyle "Stencil";
		StencilColor "DarkGreen";
	}
	
	States
	{
		Spawn:
			TNT1 A 0 A_SetTranslucent(0.5);
			TNT1 A 0 A_SetScale(0.9);
			BAL7 AB 1 BRIGHT;
			Loop;
		Death:
			BAL7 CDE 6 BRIGHT;
			Stop;
	}
}

//===========================================================================
//
// Death Widow
//
//===========================================================================

class DeathWidow : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Death Widow"
		+JUMPDOWN
		+DONTOVERLAP
		
		Tag "Death Widow";
		Health 35;
		Radius 8;
		Height 20;
		Speed 15;
		PainChance 50;
		Mass 150;
		Scale 0.45;
		SeeSound "Uspiders/See";
		PainSound "Uspiders/See";
		DeathSound "Uspiders/death";
		Obituary "%o Underestimated this little cute fella known as 'Death'Widow.";
	}
	
	States
	{
	Spawn:
		DWID A 2 A_Look();
		Loop;
	See:
		DWID A 3 A_FastChase();
		DWID AB 3 A_Chase();
		DWID B 3 A_FastChase();
		DWID BC 3 A_Chase();
		Loop;
	Melee:
		DWID E 4 A_FaceTarget();
		DWID FG 4 A_CustomMeleeAttack(3,0,0);
		DWID F 4;
		Goto See;
	Missile:
		DWID A 10 A_FaceTarget();
		DWID E 3 ThrustThingZ (0, 25, 0, 0);
		DWID E 0 ThrustThing (angle*256/360, 15, 0, 0);
	JumpUp:
		DWID F 8;
	JumpDown:
		DWID G 1 A_CheckFloor("Drop");
		loop;
	Drop:
		DWID D 2 A_Stop();
		goto See;
	Pain:
		DWID D 3;
		DWID D 3 A_Pain;
		Goto See;
	Death:
	XDeath:
		DWID H 5 A_Scream();
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		DWID I 4 A_NoBlocking();
		DWID J 3 A_BossDeath();
		Stop;
	}
}

//===========================================================================
//
// Frightened Spider
//
//===========================================================================

class Fright : Spider
{
	Default
	{
		//$Category "Monsters/Animals"
		//$Title "Fright"
		
		+NOBLOCKMONST
		+DROPOFF
		+FRIGHTENED
		+NOTARGET
		+CANTSEEK
		+CANNOTPUSH
		+LOOKALLAROUND
		+THRUSPECIES
		+AMBUSH
		-CANUSEWALLS
		-DONTOVERLAP
		-COUNTKILL
		
		Tag "Yellow Spider";
		Health 2;
		Painchance 256;
		Speed 4;
		Radius 7;
		Height 4;
		Mass 400;
		Monster;
		SeeSound "Sspiders/active";
		AttackSound "Sspiders/attack";
		PainSound "Sspiders/active";
		DeathSound "Sspiders/death";
		ActiveSound "Sspiders/active";
		Scale 0.15;
		HitObituary "%o is a real wimp because this spider doesn't kill you.";
	}
	States
	{
		Spawn:
			SPIC A 1 A_Look();
			Loop;
		See:
			SPIC ABCD 2 A_Chase();
			Loop;
		Melee:
			Goto death;
		Pain:
			Goto death;
		Death:
		XDeath:
			SPIC D 4 A_Scream;
			TNT1 A 0 A_StartSound("misc/squish", 0);
			SPIC E 4 A_NoBlocking;
			SPIC F 4;
			SPIC G -1;
			Stop;
	}
}

//===========================================================================
//
// Giant Spider
//
//===========================================================================

class GiantSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Giant Spider"
		
		+BOSSDEATH
		+BLOODSPLATTER
		+SHOOTABLE
		
		Tag "Giant Spider";
		Scale 0.45;
		Health 350;
		Radius 20;
		Height 46;
		Mass 400;
		Speed 5;
		PainChance 128;
		Monster;
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Bspiders/death";
		AttackSound "Sspiders/attack";
		Obituary "%o just encountered the real arachnophobic horror and died.";
	}
	
	States
	{
	Spawn:
		GTSP BBCCDDEEFFGGHHIIJJKKLL 2 A_Look();
		Loop;
	See:
		GTSD AABBC 1 A_Chase();
		GTSD C 1 FAST A_Chase();
		GTSD DDEEF 1 A_Chase();
		GTSD F 1 FAST A_Chase(); //Sorry J, they looked like they were dancing...
		Loop;
	Melee:
		GTSP C 4 A_FaceTarget();
		GTSP C 8 A_SargAttack();
		GTSP DDEEFF 2;
		Goto See;
	Pain:
		GTSH AABBCCDDEEFFG 1;
		GTSH G 3 A_Pain();
		Goto See;
	Death:
		TNT1 A 0 A_ScreamAndUnblock();
		GTSH ABBCCDDEEFFGGHHIIJJK 2 A_SpawnItem("Fright");
		GTSH K -1 A_BossDeath();
		Stop;
	Death.Fire:
		NULL A 0 A_SetScale(0.80);
		ASHD A 4 BRIGHT A_Scream();
		ASHD B 4 BRIGHT A_BossDeath();
		ASHD C 4 BRIGHT;
		ASHD D 4 BRIGHT;
		ASHD E 4 BRIGHT A_NoBlocking();
		ASHD F -1;
		Stop;
	/*Raise:
		GTSH K 4;
		GTSH KJJIIHHGGFFEEDDCCBBAA 3;
		Goto See;*/
	}
}


class spiderQueen01 : GiantSpider {
	Default {
		//$Title "spider queen#01"
		Tag "spider queen";
		Health 550;
	}
}
class spiderQueen02 : GiantSpider {
	Default {
		//$Title "spider queen#02"
		Tag "spider queen";
		Health 550;
	}
}
class spiderQueen03 : GiantSpider {
	Default {
		//$Title "spider queen#03"
		Tag "spider queen";
		Health 550;
	}
}

//===========================================================================
//
// Secret Golden Spider
//
//===========================================================================

class GoldenSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Golden Spider"
		
		+BOSS
		+BRIGHT
		+NOTARGET
		+JUMPDOWN
		+NOBLOCKMONST
		+QUICKTORETALIATE
		
		Tag "Golden Spider";
		BloodColor "Gold";
		PainChance 50;
		Scale 0.55;
		Health 500;
		Height 14;
		Radius 10;
		Speed 40; //I don't know the max speed.
		Mass 90;
		DropItem "SoulSphere";
		SeeSound "BSpiders/Sight";
		PainSound "Uspiders/Death";
		DeathSound "Spiders/Death";
		ActiveSound "Sspiders/active";
		AttackSound "Uspiders/attack";
		Obituary "%o got pwned by da golden spider."; //Sorry, no better ideas yet.
	}
	
	States
	{
		Spawn:
			PSGI A 10 A_Look();
			Loop;
		See:
			PSGI A 0 A_Jump(16, "Missile");
			PSGI AABBCC 4 FAST A_Chase();//(CHF_NORANDOMTURN)
			Loop;
		Melee:
			PSGI A 4 A_FaceTarget();
			PSGI E 4 A_CustomMeleeAttack(20,0,0);
			Goto See;
		Missile:
			PSGI A 10 A_FaceTarget();
			TNT1 A 0 A_SkullAttack();
			PSGI E 2 ThrustThingZ (0, 30, 0, 0);
			PSGI E 0 ThrustThing (angle*256/360, 3, 0, 0);
		JumpUp:
			PSGI F 0;
			PSGI F 4;
		JumpDown:
			PSGI F 3 A_CheckFloor("Drop");
			loop;
		Drop:
			PSGI G 2 A_Stop();
			goto See;
		Pain:
			PSGI D 3;
			PSGI D 3 A_Pain();
			Goto See;
		Death:
		XDeath:
			PSGI H 5 A_Scream();
			TNT1 A 0 A_StartSound("Spiders/Explode", 7);
			TNT1 AA 0 A_SpawnProjectile("PSEye",-2,0,random(80,100),2,random(40,80));
			PSGI I 5 A_NoBlocking();
			PSGI J 5;
			Stop;
	}
}




//===========================================================================
//
// Powerslave Spider
//
//===========================================================================

class PowerSlaveSpider2 : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Powerslave Spider Big"
		
		Tag "Red Spider";
		Health 35;
		Height 20;
		Radius 12;
		Speed 20;
		Mass 200;
		Scale 0.75;
		PainChance 128;
		SeeSound "Spiders/sight";
		PainSound "Spiders/pain";
		DeathSound "Spiders/death";
		ActiveSound "Spiders/active";
		AttackSound "Spiders/Grunt";
		Obituary "a Big Red Spider Blew a Big Venomous Hole on %o's Body.";
	}
	
	States
	{
	Spawn:
		PSPI A 10 A_Look();
		Loop;
	See:
		PSPI AABBCC 4 A_Chase();
		Loop;
	Melee:
		PSPI A 4 A_FaceTarget();
		PSPI T 4 A_CustomMeleeAttack(4,0,0);
		PSPI B 4;
		Goto See;
	Pain:
		PSPI D 3;
		PSPI D 3 A_Pain();
		Goto See;
	Death:
	XDeath:
		PSPI E 5 A_Scream();
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		TNT1 A 0 A_SpawnProjectile("PSHead");
		TNT1 AA 0 A_SpawnProjectile("PSEye",-2,0,random(80,100),2,random(40,80));
		TNT1 AA 0 A_SpawnProjectile("PSRLeg",-2,0,random(75,95),2,random(35,75));
		TNT1 AA 0 A_SpawnProjectile("PSLLeg",-2,0,random(75,95),2,random(35,75));
		PSPI FF 2 A_NoBlocking();
		PSPI G 4;
		Stop;
	}
}

// the small one that got taken out.

class PowerSlaveSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Powerslave Spider Small"
		
		+JUMPDOWN
		
		Tag "Red Spider Small";
		Health 10;
		Radius 5;
		Height 10;
		Speed 15;
		PainChance 200;
		SeeSound "Sspiders/active";
		AttackSound "Sspiders/attack";
		PainSound "Sspiders/active";
		DeathSound "Sspiders/death";
		ActiveSound "Sspiders/active";
		Mass 50;
		Scale 0.35;
		Obituary "%o just got spider bite from a Red Spider.";
	}
	
	States
	{
	Spawn:
		PSPI A 10 A_Look();
		Loop;
	See:
		PSPI A 0 A_Jump(16, "Missile");
		PSPI AABBCC 4 A_Chase();
		Loop;
	Melee:
		PSPI A 4 A_FaceTarget();
		PSPI T 4 A_CustomMeleeAttack(2,0,0);
		PSPI B 4 A_JumpIfCloser(16, "Squashed");
		Goto See;
	Missile:
		PSPI A 10 A_FaceTarget();
		PSPI H 3 ThrustThingZ (0, 30, 0, 0);
		PSPI H 0 ThrustThing (angle*256/360, 3, 0, 0);
	JumpUp:
		PSPI I 0;
		PSPI I 4;
	JumpDown:
		PSPI I 3 A_CheckFloor("Drop");
		loop;
	Drop:
		PSPI T 2 A_Stop();
		goto See;
	Pain:
		PSPI D 3;
		PSPI D 3 A_Pain();
		Goto See;
	Squashed:
		NULL A 0 A_Die();
	Death:
	XDeath:
		PSPI E 5 A_Scream();
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		TNT1 A 0 A_SpawnProjectile("SPSHead",-2,0,random(80,100),2,random(40,80));
		PSPI F 5 A_NoBlocking();
		PSPI G 5;
		Stop;
	}
}

//===========================================================================
//
// ShadowCaster Spider
//
//===========================================================================

class ShadowSpider : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Shadowcaster Spider"
		
		+QUICKTORETALIATE
		
		Tag "Shadow Spider";
		Health 60;
		Radius 16;
		Height 28;
		Mass 150;
		Speed 8;
		Scale 0.75;
		PainChance 98;
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Bspiders/death";
		ActiveSound "Spiders/Active";
		HitObituary "%o never knew a shadow spider's acid was that dangerous.";
		Obituary "%o felt the true taste of a shadow spider's acid.";
	}
	
	States
	{
	Spawn:
		CSPI A 5 A_Look();
		Loop;
	See:
		TNT1 A 0 A_JumpIfCloser(200,"Missile");
		CSPI A 3 A_Chase();
		TNT1 A 0 A_JumpIfCloser(200,"Missile");
		CSPI A 3 A_Chase();
		TNT1 A 0 A_JumpIfCloser(200,"Missile");
		CSPI B 3 A_Chase();
		TNT1 A 0 A_JumpIfCloser(200,"Missile");
		CSPI B 3 A_Chase();
		TNT1 A 0 A_JumpIfCloser(200,"Missile");
		Loop;
	Missile:
		CSPI C 10 A_FaceTarget();
		CSPI D 10 A_FaceTarget();
		CSPI E 10 A_FaceTarget();
		CSPI F 0 A_StartSound("Spiders/Attack", 0);
		CSPI F 3 A_SpawnProjectile("AcidSpit");
		TNT1 A 0 A_SentinelRefire();
		Goto See;
	Pain:
		CSPI D 2;
		CSPI D 2 A_Pain();
		Goto See;
	Death:
	XDeath:
		CSPI F 3;
		TNT1 A 0 A_StartSound("Spiders/Explode", 7);
		CSPI G 2 A_Scream();
		CSPI H 2;
		TNT1 A 0 A_SpawnProjectile("SHHead");
		TNT1 A 0 A_SpawnProjectile("SHEye",-2,0,random(80,100),2,random(40,80));
		TNT1 AA 0 A_SpawnProjectile("SHRLeg",-2,0,random(75,95),2,random(35,75));
		TNT1 AA 0 A_SpawnProjectile("SHLLeg",-2,0,random(75,95),2,random(35,75));
		CSPI I 2 A_NoBlocking();
		CSPI J -1;
		Stop;
	/*Raise:
		CSPI JIHGF 2;
		Goto See;*/
	}
}

//===========================================================================
//
// Acid Spit
//
//===========================================================================

//(Thanks to Chronoteeth, i was going to use poison screen effects 
// as a A_GiveInventory item with green screen color). CStaffMissile is WAY EASIER.

class AcidSpit : CStaffMissile
{
	Default
	{
		+SOLID
		+NOBLOOD
		-NOGRAVITY
		+RANDOMIZE
		+ROCKETTRAIL
		+STRIFEDAMAGE
		+ADDITIVEPOISONDAMAGE
		+ADDITIVEPOISONDURATION
		
		Radius 2;
		Height 2;
		Damage 1;
		Projectile;
		Speed 25;
		Gravity 0.4;
		DamageType "Poison";
		SeeSound "baron/attack";
		DeathSound "spiders/aciddth";
		PoisonDamage 1,1,0;
		RenderStyle "Stencil";
		StencilColor "DarkGreen";
	}
	
	States
	{
		Spawn:
			TNT1 A 0 A_SetTranslucent(0.3);
			TNT1 A 0 A_SetScale(0.5);
			BAL7 AB 1 BRIGHT;
			Loop;
		Death:
			BAL7 CDE 6 BRIGHT;
			Stop;
	}
}

//===========================================================================
//
// Small Shadow Spider
//
//===========================================================================

class ShadowSpider2 : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Shadowcaster Spider Small"
		
		Tag "Shadow Spider";
		Health 30;
		Radius 16;
		Height 15;
		Mass 50;
		SeeSound "Sspiders/active";
		AttackSound "Sspiders/attack";
		PainSound "Sspiders/active";
		DeathSound "Sspiders/death";
		ActiveSound "Sspiders/active";
		Speed 13;
		Scale 0.3;
		PainChance 150;
		Obituary "%o felt the small shadow spider's venomous wrath.";
	}
	
	States
	{
		Spawn:
			CSPI A 5 A_Look();
			Loop;
		See:
			CSPI AABBCC 3 A_Chase();
			Loop;
		Melee:
			CSPI D 6 A_FaceTarget();
			CSPI E 8 A_CustomMeleeAttack(3,0,0);
			CSPI E 1 A_JumpIfCloser(10, "Squashed");
			Goto See;
		Pain:
			CSPI D 2;
			CSPI D 2 A_Pain();
			Goto See;
		Squashed:
		Death:
		XDeath:
			CSPI F 5;
			CSPI G 5 A_Scream();
			CSPI H 5;
			CSPI I 5 A_NoBlocking();
			CSPI J -1;
			Stop;
		/*Raise:
			CSPI JIHGF 2;
			Goto See;*/
	}
}

//===========================================================================
//
// Small Steal Princess Spider
//
//===========================================================================

class SmallSteal : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Small Thief"
		
		Tag "Thief Spider";
		Health 10;
		Radius 8;
		Height 14;
		Mass 50;
		Speed 9;
		Scale 0.3;
		PainChance 170;
		SeeSound "Sspiders/active";
		AttackSound "Sspiders/attack";
		PainSound "Sspiders/active";
		DeathSound "Sspiders/death";
		ActiveSound "Sspiders/active";
		Obituary "a Small Steal Spider just took %o's Life.";
	}
	
	States
	{
	Spawn:
		SPSP ABC 5 A_Look();
		Loop;
	See:
		SPSP DDEEFFGGHHII 2 A_Chase();
		Loop;
	Melee:
		SPSP JK 2 A_FaceTarget();
		SPSP LLMMNNOPQR 1;
		SPSP S 4 A_CustomMeleeAttack(4,0,0);
		SPSP TUVW 2 A_JumpIfCloser(12,"Squashed");
		Goto See;
	Pain:
		SPSD ABCD 2;
		SPSD E 2 A_Pain();
		Goto See;
	Death:
		SPSD F 5 A_Scream();
		TNT1 A 0 A_StartSound("Misc/Squish", 7);
		SPSD G 4 A_NoBlocking();
		SPSD H 3;
		SPIC G -1;
		Stop;
	Squashed:
		NULL A 0 A_Die();
		Goto Death;
	XDeath:
		Goto Death;
	/*Raise:
		SPSD HGFEDCBA 2;
		Goto See;*/
	}
}

//===========================================================================
//
// Widow
//
//===========================================================================

class Widow : Spider
{
	Default
	{
		//$Category "Monsters/spiders"
		//$Title "Widow Spider"
		
		+FLOORCLIP 
		+NOTARGET
		
		Tag "Widow";
		Health 10;
		PainChance 200;
		Scale 0.7;
		Mass 80;
		Radius 10;
		Speed 12;
		Damage 5;
		PoisonDamage 5;
		DamageType "Poison";
		ActiveSound "Spiders/active";
		AttackSound "Uspiders/attack";
		MeleeSound "Uspiders/attack";
		SeeSound "Uspiders/See";
		PainSound "Uspiders/See";
		DeathSound "Uspiders/death";
		Obituary "%o melted out.";
	}
	
	States
	{
		Spawn:
			MOSA A 3 A_Look();
			Loop;
		See:
			MOSA ABCD 4 A_Chase();
			Loop;
		Melee:
			MOSA E 5 A_FaceTarget();
			MOSA A 3 A_JumpIfCloser(12,"Squashed");
			MOSA E 4 A_CustomMeleeAttack(3,0,0);
			MOSA AE 2 A_CustomMeleeAttack(2,0,0);
			Goto See;
		Pain:
			MOSA F 1 A_Pain();
			MOSA F 3;
			Goto See;
		Squashed:
			NULL A 0 A_Die();
		Death:
			MOSA G 3 A_Scream();
			TNT1 A 0 A_StartSound("Spiders/Explode", 7);
			MOSA H 3 A_NoBlocking();
			MOSA IJKLMLMLMLML 3;
			MOSA M -1;
			Stop;
		XDeath:
			TNT1 A 0 A_SetScale(0.3);
			MOSA N 2 A_ScreamAndUnblock();
			TNT1 A 0 A_StartSound("Spiders/Explode", 7);
			MOSA NOP 1;
			Stop;
	}
}

//=================================================================
//
//	WASPS
//
//=================================================================

//===========================================================================
//
// Cyclone Wasp
//
//===========================================================================

class CycloneWasp : Spider
{
	Default
	{
		//$Category "Monsters/wasps"
		//$Title "Wasp Red"
		
		+FLOAT 
		+NOGRAVITY 
		+NOICEDEATH
		+DONTHARMSPECIES
		+SPAWNFLOAT
		+DONTOVERLAP
		
		Tag "Red Wasp";
		Species "Wasp";
		Health 80;
		Radius 7;
		Height 15;
		Mass 100;
		Speed 1;
		Damage 1;
		PainChance 98;
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Spiders/FlyingDTH";
		ActiveSound "Spiders/Active";
		HitObituary "%o never knew a Cyclone Sting was that dangerous.";
		Obituary "%o felt the true taste of a cyclone wasp sting.";
	}
	
	States
	{
		Spawn:
			CYCA A 5 A_Look();
			Loop;
		See:
			TNT1 A 0 A_StartSound ("Spiders/Flying", 1, 1, 1);
			CYCA ABC 1 A_Chase();
			Loop;
		Missile:
			CYCA ABCABC 1 A_FaceTarget();
			CYCA ABCABC 1 A_FaceTarget();
			TNT1 A 0 A_StartSound("Spiders/FlyingATK", 0);
			CYCA DDEEFF 2 A_SkullAttack();
			CYCA ABC 2 A_Wander();
			Goto See;
		Melee:
			CYCA DEF 2 A_CustomMeleeAttack(1,0,0);
			CYCA ABC 2 A_Wander();
			Goto See;
		Pain:
			CYCA DEF 2;
			CYCA G 2 A_Pain();
			Goto See;
		Death:
		XDeath:
			PWSP G 0 A_StopSound(1);
			CYCA DEFG 3;
			TNT1 A 0 A_StartSound("Spiders/Explode", 7);
			CYCA H 2 A_ScreamAndUnblock();
			CYCA I 2;
			CYCA J 2;
			TNT1 A 0 A_StopSound(1);
			Stop;
		/*Raise:
			CYCA JIHGF 2;
			Goto See;*/
	}
}

//===========================================================================
//
// Disruptor Mutant Fly
//
//===========================================================================

class MutantFly : Spider
{
	Default
	{
		//$Category "Monsters/wasps"
		//$Title "Mutant Fly"
		
		+FLOAT 
		+NOGRAVITY 
		+NOICEDEATH
		+DONTHARMSPECIES
		+THRUSPECIES
		+SPAWNFLOAT
		+DONTOVERLAP
		+FLOATBOB
		
		Tag "Mutated Fly";
		Species "Wasp";
		Health 100;
		Radius 15;
		Height 36;
		Mass 400;
		PainChance 96;
		Speed 4;
		Damage 1;
		Scale 0.35;
		SeeSound "Bspiders/sight";
		PainSound "Bspiders/pain";
		DeathSound "Spiders/FlyingDTH";
		Obituary "%o was bitten by a mutant fly!";
	}
	
	States
	{
		Spawn:
			DIS6 AABB 1 A_Look();
			Loop;
		See:
			DIS6 A 0 A_StartSound("Spiders/Flying", 1, 1, 1);
			DIS6 ABA 1 A_Chase();
			DIS6 BAB 1 A_FastChase();
			DIS6 ABA 1 A_Chase();
			Loop;
		Melee:
			DIS6 CDEFGHIJ 2 A_CustomMeleeAttack(1,0,0);
			DIS6 AB 2 A_Wander();
			Goto See;
		Missile:
			DIS6 ABABABABAB 1 A_FaceTarget();
			DIS6 ABABABABAB 1 A_FaceTarget();
			DIS6 A 0 A_StartSound("Spiders/FlyingATK");
			DIS6 CCDDEEFFGGHHIIJJ 1 A_SkullAttack();
			Goto See;
		Pain:
			DIS6 JJKKLLMM 1;
			DIS6 NN 1 A_Pain();
			DIS6 OO 1;
			Goto See;
		Death.Fire:
		XDeath:
		Death:
			TNT1 A 0
			{
				self.bFLOATBOB = false;
			}
			TNT1 A 0 A_StopSound(1);
			DIS6 P 1 A_ScreamAndUnblock();
			DIS6 PQRSTU 2;
		Fall:
			DIS6 V 1 A_CheckFloor("Splat");
			loop;
		Splat:
			DIS6 W 1;
			DIS6 X -1 A_Stop();
			Stop;
		/*Raise:
			DIS6 A 8 A_UnSetFloorClip();
			DIS6 CCBBAA 8;
			Goto See;*/
	}
}



//PSX Powerslave/Exhumed Wasp decorate by Lex Safonov

class PSXWasp : actor
{
	default
	{
		//$Category "Monsters/wasps"
		//$Title "Wasp Drone"
		
		+FLOATBOB
		+FLOAT 
		+NOGRAVITY
		+JUMPDOWN
		+MOVEWITHSECTOR
		
		Tag "Wasp Drone";
		Species "Wasp";
		Health 128;
		Radius 16;
		Height 32;
		Mass 400;
		Speed 7;
		PainChance 128;
		Monster;
		Scale 0.6;
		SeeSound "Wasps/Attack";
		AttackSound "Wasps/Attack";
		MeleeSound "Wasps/Attack";
		PainSound "Wasps/Pain";
		DeathSound "Wasps/death";
		ActiveSound "Wasps/Flying";
	}
	
	States
	{
		Spawn:
			PM03 A 1 A_Look();
			Loop;
		See:
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 AB 1 A_Chase();
			PM03 BAB 1 A_Chase();
			Loop;
		Melee:
			TNT1 A 0 A_StartSound("Wasps/Attack");
			TNT1 A 0 A_CustomMeleeAttack(6, "wasphit");
			PM03 C 4 A_FaceTarget();
			PM03 A 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 A 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 AA 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 AA 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 AA 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 AA 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 BB 1 A_Wander();
			PM03 AA 1 A_Wander();
			TNT1 A 0 A_StartSound("Wasps/Flying",1,1,1);
			PM03 B 1 A_Wander();
			Goto See;
		Pain:
			PM03 A 3;
			TNT1 A 0 A_Pain();
			Goto See;
		Death:
			TNT1 A 0 A_StopSound(1);
			TNT1 A 0 A_StopSound(6);
			TNT1 A 0 A_StopSound(7);
			TNT1 A 0 A_Scream();
			PM01 JKLM 4; //A_SpawnDebris("NashGore_FlyingBlood",1)
			TNT1 A 0 A_SpawnProjectile("SHEye",-2,0,random(80,100),2,random(40,80));
			TNT1 AA 0 A_SpawnProjectile("SHRLeg",-2,0,random(75,95),2,random(35,75));
			TNT1 AA 0 A_SpawnProjectile("SHLLeg",-2,0,random(75,95),2,random(35,75));
			TNT1 A 0 A_NoBlocking();
			Stop;
	}
}

//===========================================================================
//
// Powerslave Red Wasp
//
//===========================================================================

class PSRedWasp : Spider
{
	Default
	{
		//$Category "Monsters/wasps"
		//$Title Killer wasp red
		
		+FLOAT 
		+NOGRAVITY
		+NOICEDEATH
		+DONTHARMSPECIES
		+NOTARGET
		+SPAWNFLOAT
		+DONTOVERLAP
		
		Tag "Killer Wasp";
		Species "Wasp";
		Health 700;
		Radius 24;
		Height 56;
		Mass 600;
		PainChance 96;
		Speed 4;
		Damage 5;
		Scale 0.40;
		SeeSound "Wasps/Attack";
		PainSound "Wasps/Pain";
		DeathSound "Wasps/death";
		ActiveSound "Wasps/Flying";
		AttackSound "Wasps/Attack";
		MeleeSound "Wasps/Attack";
		Obituary "%o died before the Mother Wasp.";
	}
	
	States
	{
	Spawn:
		PSRW ABAB 1 A_Look();
		Loop;
	See:
		PSRW A 0 A_StartSound ("Wasps/Flying", 1, 1, 1);
		PSRW ABABABAB 1 A_FastChase();
		Loop;
	Missile:
		PSRW ABABABABABABAB 2 A_FaceTarget();
		PSRW ABABABABABABAB 2 A_FaceTarget();
		PSRW ABABABABABABAB 2 A_FaceTarget();
		PSRW ABABABABABABAB 2 A_FaceTarget();
		TNT1 A 0 A_Jump(150,"WanderAround");
		PSRW A 0 A_StartSound("Wasps/Attack");
		PSRW D 4 BRIGHT A_PainAttack();
		Goto See;
	WanderAround:
		PSRW ABABABABABABAB 2 A_FaceTarget();
		PSRW ABABABABABABAB 2 A_Wander();
		Goto See;
	Pain:
		PSRW C 3;
		PSRW C 4 A_Pain();
		PSRW C 3;
		Goto See;
	Death.Fire:
	Death:
	XDeath:
		PSRW E 0 A_StopSound(1);
		PSRW E 4 A_Scream();
		PSRW F 4 A_Noblocking();
		PSRW G 4 A_SetFloorClip();
		Stop;
	/*Raise:
		PSRW A 8 A_UnSetFloorClip();
		PSRW CCBBAA 8;
		Goto See;*/
	}
}



//===========================================================================
//
// Powerslave Wasp
//
//===========================================================================

class PSWasp : Spider
{
	Default
	{
		//$Category "Monsters/wasps"
		//$Title Killer wasp 3
		
		+FLOAT 
		+NOGRAVITY
		+NOICEDEATH
		+DONTHARMSPECIES
		+SPAWNFLOAT
		+DONTOVERLAP
		
		Tag "Wasp Warrior";
		Species "Wasp";
		Health 200;
		Radius 24;
		Height 56;
		Mass 600;
		PainChance 96;
		Speed 3;
		Damage 3;
		Scale 0.5;
		SeeSound "Wasps/Attack";
		PainSound "Wasps/Pain";
		DeathSound "Wasps/death";
		ActiveSound "Wasps/Flying";
		AttackSound "Wasps/Attack";
		MeleeSound "Wasps/Attack";
		Obituary "%o Felt the deadly attack of a wasp!";
	}
	
	States
	{
		Spawn:
			PWSP ABAB 1 A_Look();
			Loop;
		See:
			TNT1 A 0 A_StartSound ("Wasps/Flying", 1, 1, 1);
			PWSP ABA 1 A_FastChase();
			Loop;
		Missile:
			PWSP ABABABABABAB 1 A_FaceTarget();
			PWSP ABAB 2 A_FaceTarget();
			TNT1 A 0 A_StartSound("Wasps/Attack");
			TNT1 A 0 A_SkullAttack();
			PWSP CDCDCD 1;
			Goto See;
		Melee:
			PWSP CDCD 2 A_CustomMeleeAttack(1,0,0);
			PWSP CD 2 A_Wander();
			Goto See;
		Pain:
			PWSP EEE 2;
			PWSP E 2 A_Pain();
			PWSP E 2;
			Goto See;
		Death:
		Death.Fire:
		XDeath:
			PWSP G 0 A_StopSound(1);
			PWSP FG 3;
			PWSP H 3 A_ScreamAndUnblock();
			PWSP I -1 A_SetFloorClip();
			Stop;
		/*Raise:
			PWSP A 8 A_UnSetFloorClip();
			PWSP CCBBAA 8;
			Goto See;*/
	}
}




