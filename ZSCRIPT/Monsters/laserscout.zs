Class LaserScout : Sentinel
{
	Default
	{
		//$category "Monsters/Heretics"
		//$Title "Heretic Laser Scout"
		Health 250;
		Speed 11;
		Radius 40;
		Height 56;
		Mass 450;
		PainChance 40;
		-FLOAT
		-NOGRAVITY
		-SPAWNCEILING
		-NOGRAVITY
		-DROPOFF
		+SEESDAGGERS
		Tag "Laser-Scout";
		DeathSound "scout/death";
		Obituary "%o was vaporized by a laser-scout.";
		DropItem "EnergyPod";
		GibHealth 100;
	}
	States
	{
		Spawn:
			MECH H 1 A_TurretLook;
			loop;
		See:
			MECH ABCD 5 A_Chase;
			loop;
		Melee:
		Missile:
			MECH E 2 A_FaceTarget;
			MECH F 4 Bright A_SpawnProjectile("SentinelFX3", 48, -8) ;
			MECH E 2 A_FaceTarget;
			MECH E 0 A_MonsterRefire(30, "See");
			Goto Missile+1;
		Pain:
			MECH G 4 A_Pain;
			Goto See;
		Death:
			MECH I 6 A_Scream;
			MECH J 6 A_Fall;
			MECH K 6;
			MECH L 12;
			MECH MNO 5 Bright;
			MECH L -1;
			Stop;
		XDeath:
			MECH Q 5 Bright A_StartSound("reaver/death", CHAN_BODY);
			MECH Q 0 A_Explode;
			MECH Q 0 A_Fall;
			MECH RRSSTT 2 Bright A_TossGib;
			MECH UVW 5 Bright A_TossGib;
			MECH X -1;
			Stop;
	}
}

Class SentinelFX3 : SentinelFX2
{
	Default{+BRIGHT}
	States
	{
		Spawn:
		SHT1 AABB 2 A_SpawnItemEx("LaserTrail", -10);
		loop;
	}
}

Class LaserTrail : Actor
{
	Default
	{
		+BRIGHT
		+NOGRAVITY
	}
	States
	{
		Spawn:
		SHT1 AAAABBBB 4 A_FadeOut(0.5);
		loop;
	}
}