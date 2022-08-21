///////////////////////////////////////////////////////////////////////////////////////////////////////////////
Class LFGrenadeBase : Actor
{
	int fusetime; property FuseTime : fusetime;
	Default
	{
		Health 5;
		Speed 1;
		Radius 4;
		Height 4;
		Mass 10;
		Damage 1;
		Projectile;
		-NOGRAVITY
		+STRIFEDAMAGE
		+BOUNCEONACTORS
		+EXPLODEONWATER
		-NOBLOCKMAP; +SOLID;
		+SHOOTABLE; +NOBLOOD;
		MaxStepHeight 4;
		BounceType "Doom";
		BounceFactor 0.5;
		+MTHRUSPECIES;
	}
	Override bool CanCollideWith(Actor other, bool passive)
	{
		If(passive)
		{
			If(other.GetPlayerInput(MODINPUT_BUTTONS)&BT_USE)
			{
				angle=other.angle;
				A_ChangeVelocity(12,0,6,CVF_RELATIVE|CVF_REPLACE);
				SetStateLabel("Spawn");
			}
		}
		If(other.bMISSILE){Return 1;}
		Else{Return 0;} //Super.CanCollideWith(other,passive);
	}
	Override void Tick()
	{
		Super.Tick();
		If(InStateSequence(CurState,ResolveState("Spawn"))&&vel.length()<1){SetStateLabel("Death");}
		If(InStateSequence(CurState,ResolveState("Explode"))){A_Stop();}
	}
	Action void B_NadeCountdown()
	{
		If(Invoker.FuseTime<=0||Invoker.health<=0){SetStateLabel("Explode");}
		If(Invoker.bSHOOTABLE==0){Invoker.bSHOOTABLE=1;}
		Else{Invoker.FuseTime--;}
	}
}
Class LFBulletPuff : StrifePuff
{
	States
	{
	Spawn:
		PUFY A 4 Bright;
		PUFY BCD 4;
		Stop;
	}
}
Class LFBulletSpark : StrifePuff
{
	States
	{
	Spawn:
		POW3 ABCDEFGH 3;
		Stop;
	}
}
Class LFBulletBase : FastProjectile
{
	Array<Actor> ShotList;
	int penetration; property Penetration : penetration;
	int BulletDmg; property BulletDmg : BulletDmg;
	Default
	{
		Radius 2;
		Height 2;
		Decal "BulletChip";
		MissileType "LFBulletDebug";
		MissileHeight 8;
		DamageType "Bullet";
		ProjectileKickback 50;
		+MTHRUSPECIES; +NOEXTREMEDEATH;
	}
	States
	{
	Spawn:
		TNT1 A 1 A_ChangeVelocity(0,0,-1);
		Loop;
	Death:
		TNT1 A 0 A_AlertMonsters(128);
		TNT1 A 0 A_SpawnItemEx("LFBulletPuff");
		Stop;
	Crash:
		TNT1 A 0 A_AlertMonsters(128);
		TNT1 A 0 A_SpawnItemEx("LFBulletSpark");
		Stop;
	XDeath:
		TNT1 A 0;
		Stop;
	}
	Override int SpecialMissileHit(Actor victim)
	{
		If(ShotList.Find(victim) == ShotList.Size())
		{
			If(victim==Self.target){Return 1;}
			Else
			{
				victim.DamageMobj(Self,target,Self.BulletDmg*Random(1,4),"Bullet"); ShotList.Push(victim);
				If(victim.bSHOOTABLE&&!victim.bNOBLOOD){victim.SpawnBlood(self.pos,self.angle,self.BulletDmg);}
				If(Self.Penetration>victim.Mass){Self.Penetration-=(victim.Mass); Return 1;}
				Else{Return 0;}
			}
		}
		Else{Return 1;}
	}
}
Class LFBulletDebug : Actor
{
	Default{+NOGRAVITY}
	States
	{
	Spawn:
		PUFY A 0 NoDelay Bright {If(GetCVar("lf_debug")){A_SetTics(35);}}
		Stop;
	}
}

Class LF542 : LFBulletBase
{
	Default
	{
		Speed 640;
		LFBulletBase.Penetration 300;
		LFBulletBase.BulletDmg 10;
		Obituary "%o was shot down by %k's assault rifle.";
	}
}
Class LFAcolyte : Acolyte replaces Acolyte
{
	int gunmag;
	int sighttimer;
	int searchtimer;
	bool searched;
	bool lootmed;
	bool lootarm;
	int lootarm2;
	bool lootgun;
	int lootgun2;
	int lootmoney;
	bool lootrep;
	string looteqip; Property Equipment : looteqip;
	int looteqip2;
	bool grenout;
	bool grenon;
	bool wounded;
	int woundtimer;
	int healtimer;
	bool nowound;
	Actor prevtarg;
	bool shielded; Property Shielded : shielded;
	bool healed;
	int noescape;
	Default
	{
		PainChance "Bleeding", 0;
		Species "LFAcolyte";
	}
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		gunmag=30;
		If(shielded==1){A_SpawnItemEx("LFAcolyteShield",flags: SXF_SETMASTER);}
		If(Random(1,3)==1){lootmed=1;} If(Random(1,8)==1){lootarm=1; lootarm2=Random(15,85);}
		If(Random(1,6)==1){lootgun=1; lootgun2=Random(50,600);} If(Random(1,10)==1){lootrep=1;}
		lootmoney=Random(3,15);
	}
	Override void Tick()
	{
		Super.Tick();
		If(health>0)
		{
			If(healed==0)
			{
				For(let i = BlockThingsIterator.Create(self,1024); i.Next();)
				{
					Actor other = i.thing;
					If(other==self)
					{Continue;}
					double distance = Distance3D(other);
					If(distance>1024)
					{Continue;}
					If(target!=null&&CheckSight(target))
					{Continue;}
					If(other is "LFAcolyte"&&other.InStateSequence(other.CurState,other.ResolveState("Wound")))
					{
						prevtarg=target;
						target=other;
					}
				}
			}
			If(wounded==1)
			{
				If(woundtimer>=35)
				{
					DamageMobj(null,null,1,"Bleeding");
					SpawnBlood((pos.x+random(-8,8),pos.y+random(-8,8),pos.z+16),angle,1);
					woundtimer=0;
				}
				Else{woundtimer++;}
			}
			If(healtimer>0)
			{
				If(woundtimer>=18){GiveBody(1); healtimer--; woundtimer=0;}
				Else{woundtimer++;}
			}
		}
		If(shielded==0&&sprite==GetSpriteIndex("AGRD")){sprite=GetSpriteIndex("ATRP");}
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
						A_DropItem("Gold25"); 
						lootmoney-=25; 
					} Else If( lootmoney >= 10 ){ 
						A_DropItem("Gold10"); 
						lootmoney-=10; 
					} Else If(lootmoney>=1){
						A_DropItem("coin"); 
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

	// usage: W_rewardXPacolyte(SpawnHealth());   //	
	action void W_rewardXPacolyte (int rewardXP) {
		let pawn = binderPlayer(target);
		if ( pawn && pawn.player ) {
			pawn.playerXP+=rewardXP;
			//A_Log("Added ", rewardXP, " XP!");
			A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", rewardXP, " XP!"));
		}
	}

	States
	{
	Spawn:
		AGRD A 0 {reactiontime=8;}
		AGRD A 5 A_Look2();
		Loop;
		AGRD B 8 A_ClearShadow();
		Loop;
		AGRD D 8;
		Loop;
		AGRD ABCDABCD 6 A_Wander();
		Loop;
	ShieldDown:
		AGRD A 18;
		AGRD A 0 B_CheckMeleeRange(1);
		Goto See;
	See:
		//AGRD A 0 {If(target!=null&&target.health<1){SetStateLabel("See2");}}
		//AGRD A 0 A_CheckRange(1024,"See2");
		//AGRD A 0 A_CheckSight("See2");
		//AGRD A 0 A_Chase(null,null,CHF_DONTMOVE|CHF_DONTTURN);
		AGRD A 0
		{
			If(target is "LFAcolyte")
			{sighttimer=0; SetStateLabel("See2");}
			Else If(shielded==0&&health<=30&&healed==0&&noescape<3)
			{bFRIGHTENED=1; speed=14; sighttimer=0; SetStateLabel("RunAway");}
			Else{bFRIGHTENED=0; speed=7;}
		}
		AGRD A 0 A_JumpIfTargetInLOS(1,90,JLOSF_DEADNOJUMP,1024);
		Goto See2;
		AGRD A 0 {A_FaceTarget(); B_CheckAlly();}
		AGRD E 4 Slow Fast {sighttimer=140; A_FaceTarget(); If(reactiontime<=0){SetStateLabel("Missile");}Else{reactiontime--;}}
		AGRD A 0 B_CheckMeleeRange();
		Loop;
	See2:
		AGRD A 0 {If(sighttimer>0){SetStateLabel("See3");}}
		AGRD A 4 Fast Slow {A_Chase("Melee",null); A_AcolyteBits(); reactiontime=8;}
		AGRD BCD 4 Fast Slow {A_Chase("Melee",null); reactiontime=8;}
		Goto See;
	RunAway:
		AGRD A 0 A_CheckSight("HealUp");
		AGRD A 4 Fast Slow {A_Chase("Melee",null); A_AcolyteBits(); reactiontime=8;}
		AGRD BCD 4 Fast Slow {A_Chase("Melee",null); reactiontime=8;}
		Goto See;
	HealUp:
		AGRD OOOO 8 A_StartSound("misc/swish",CHAN_WEAPON);
		AGRD O 18;
		AGRD OO 8 A_StartSound("misc/meathit",CHAN_VOICE);
		AGRD O 18 B_AcolyteHeal(1);
		Goto See;
	See3:
		AGRD E 1 {sighttimer--; reactiontime=8;}
		Goto See;
	SeePain:
		AGRD A 0 {A_FaceTarget(); reactiontime=8;}
		Goto See;
	Missile:
		AGRD E 0 {If(reactiontime>0){SetStateLabel("See");}}
		AGRD E 0 A_FaceTarget();
		AGRD E 0 {If(invoker.gunmag<1){SetStateLabel("Dry");}}
		AGRD A 0 A_CheckRange(512,"Missile2");
		AGRD A 0 A_JumpIf(looteqip=="GASG"&&grenout==0&&Random(1,4)==1,"MissileGren");
		AGRD FEF 3 B_ShootGun();
		AGRD A 0 {If(looteqip=="TARG"){SetStateLabel("See");}}
		AGRD A 0 A_SentinelRefire();
		Goto Missile+1;
	Missile2:
		AGRD F 3 B_ShootGun(1);
		AGRD E 3;
		Goto See;
	MissileGren:
		AGRD O 16 {A_StartSound("weapons/grenfuse",CHAN_WEAPON); grenon=1;}
		AGRD E 4 B_ThrowGas();
		Goto See;
	Melee:
		AGRD O 0 A_FaceTarget();
		AGRD O 0 A_JumpIf(target is "LFAcolyte","HealAlly");
		AGRD O 0 A_JumpIf(shielded==0,2);
		AGRD O 4 B_AcolytePunch();
		Goto See;
		AGRD PQ 7 A_StopSound(CHAN_WEAPON);
		AGRD R 14 B_AcolytePunch();
		Goto See;
	HealAlly:
		AGRD EEEE 8 A_StartSound("misc/swish",CHAN_WEAPON);
		AGRD E 18 {If(Invoker.target.health<1){Invoker.target=Invoker.prevtarg; SetStateLabel("See");}}
		AGRD EE 8 A_StartSound("misc/meathit",CHAN_VOICE);
		AGRD E 18 B_AcolyteHeal();
		Goto See;
	Dry:
		AGRD E 1;
		AGRD E 8 A_StartSound("weapons/reload",CHAN_WEAPON);
		AGRD O 18;
		AGRD O 8
		{
			A_StartSound("weapons/reload",CHAN_WEAPON);
			//A_SpawnItemEx("LFEmptyClip",0,0,0,0,8.25);
			gunmag=30;
			reactiontime=8;
		}
		AGRD O 12 A_StartSound("weapons/chamber",CHAN_WEAPON);
		Goto See;
	Pain:
		AGRD O 0
		{
			If(Invoker.grenon==1)
			{
				Actor grenade = A_SpawnProjectile("LFGasGrenade");
				grenade.A_ChangeVelocity(0,0,0,CVF_REPLACE);
				Invoker.grenout=1; Invoker.grenon=0;
			}
			If(shielded==0&&health<=30&&healed==0){noescape++;}
		}
		AGRD O 8 Fast Slow {A_Pain(); A_AlertMonsters(96); reactiontime=8;}
		Goto SeePain;
	Wound:
		AGRD G 0 A_JumpIf(Invoker.nowound==1,"Pain");
		AGRD G 4 A_JumpIf(Invoker.wounded==1,7);
		AGRD H 4 {A_Scream(); A_AlertMonsters(256);}
		AGRD I 4;
		AGRD J 3;
		AGRD K 3 {height=16; A_StopSound(CHAN_VOICE);}
		AGRD L 3;
		AGRD M 3 {wounded=1; bINCOMBAT=1;}
		AGRD N 1 A_ChangeVelocity(frandom(-0.05,0.05),frandom(-0.05,0.05));
		Wait;
	WoundEnd:
		AGRD N 1 A_JumpIf(Invoker.health>=10,"Raise");
		Wait;
	Raise:
		AGRD A 0 {height=64; shielded=0;}
		AGRD MLKJ 3;
		AGRD IHG 4;
		Goto See;
	Death:
		AGRD G 4 {If(Invoker.wounded==1){A_NoBlocking(); A_StartSound(DeathSound,CHAN_VOICE,0,0.75); A_AlertMonsters(64); SetStateLabel("DeathEnd");}}
		AGRD H 4 {A_Scream(); A_AlertMonsters(256);}
		AGRD I 4;
		AGRD J 3;
		AGRD K 3 A_NoBlocking();
		AGRD L 3;
		AGRD M 3 A_AcolyteDie();
	DeathEnd:
		TNT1 A 0 W_rewardXPacolyte(SpawnHealth());
		AGRD N -1;
		Stop;
	Death.Stab:
		AGRD G 4;
		AGRD H 4
		{
			A_StartSound(DeathSound,CHAN_VOICE,0,0.75);
			A_AlertMonsters(64);
		}
		Goto Death+2;
	XDeath:
		GIBS A 5 A_NoBlocking();
		GIBS BC 5 A_TossGib();
		GIBS D 4 A_TossGib();
		GIBS E 4 A_XScream();
		GIBS F 4 A_TossGib();
		GIBS GH 4;
		GIBS I 5;
		GIBS J 5 A_AcolyteDie();
		TNT1 A 0 W_rewardXPacolyte(SpawnHealth());
		GIBS K 5;
		GIBS L 1400;
		GIBS L 1 A_FadeOut(0.02);
		Wait;
	Dummy:
		AGRD A 0; ATRP A 0;
	}
	Action void B_ShootGun(bool sniper = 0)
	{
		If(!(Invoker.target is "LFAcolyte"))
		{
			If(Invoker.gunmag<1){SetStateLabel("Dry");}
			Else
			{
				double acc = 5.6;
				If(sniper==1){acc=1.4;}
				If(Invoker.looteqip=="TARG"){acc*=0.5;}
				A_FaceTarget();
				A_SpawnProjectile("LF542a",32,0,frandom(-acc,acc),0,frandom(-acc,acc));
				A_StartSound("weapons/assaultgun",CHAN_WEAPON);
				A_AlertMonsters(1024);
				Invoker.reactiontime=8;
				Invoker.gunmag--;
			}
		}
	}
	Action void B_ThrowGas()
	{
		If(!(Invoker.target is "LFAcolyte"))
		{
			A_FaceTarget();
			A_SpawnProjectile("LFGasGrenade");
			A_StartSound("misc/swish",CHAN_WEAPON);
			Invoker.grenout=1; Invoker.grenon=0;
		}
	}
	Action void B_CheckAlly()
	{
		FLineTraceData h;
		LineTrace(angle,1024,pitch,0,32,26,data: h);
		If(h.HitActor!=null&&h.HitActor is "LFAcolyte")
		{SetStateLabel("See2");}
	}
	Action void B_CheckMeleeRange(bool counter = 0)
	{
		FLineTraceData h;
		LineTrace(angle,meleerange,pitch,TRF_THRUSPECIES,32,data: h);
		int react = 4;
		If(Invoker.shielded==0){react=0;}
		If(h.HitActor!=null&&h.HitActor==target&&((counter==0&&Invoker.reactiontime<=0)||counter==1))
		{SetStateLabel("Melee");}
	}
	Action void B_AcolytePunch()
	{
		If(!(Invoker.target is "LFAcolyte"))
		{
			FLineTraceData h;
			LineTrace(angle,meleerange,pitch,TRF_THRUSPECIES,32,data: h);
			int dam = 3; int rec = 10; int apc = 20;
			If(Invoker.shielded==0){dam=1; rec=5; apc=10;}
			A_CustomMeleeAttack(random[AcolyteMelee](1,5)*dam);
			let hitm = h.HitActor;
			If(hitm!=null&&!(hitm is "LFAcolyteShield"))
			{
				string soundtoplay;
				If(hitm.bNOBLOOD==1){soundtoplay="misc/metalhit";}
				Else{soundtoplay="misc/meathit";}
				A_StartSound(soundtoplay,CHAN_WEAPON);
				rec-=hitm.mass/50; apc-=hitm.mass/25;
				If(rec<0){rec=0;} If(apc<0){apc=0;}
				hitm.A_Recoil(rec);
				hitm.Angle+=frandom(-apc,apc); hitm.pitch+=frandom(-apc,apc);
				If(pitch<=-90){pitch=-90;} If(pitch>=90){pitch=90;}
			}
			Invoker.reactiontime=8;
		}
	}
	Action void B_AcolyteHeal(bool slf = 0)
	{
		If(slf==0)
		{
			If(Invoker.target is "LFAcolyte")
			{
				If(Invoker.target.health>0)
				{
					let ally = LFAcolyte(target);
					ally.wounded=0;
					ally.healtimer=10;
					ally.bINCOMBAT=0;
					ally.nowound=1;
					ally.SetStateLabel("WoundEnd");
				}
				Invoker.target=Invoker.prevtarg;
				Invoker.healed=1;
			}
		}
		Else
		{
			Invoker.healtimer=10;
			Invoker.healed=1;
			Invoker.bFRIGHTENED=0;
			Invoker.speed=7;
		}
	}
}
Class LF542a : LF542
{
	Default{-MTHRUSPECIES;}
	Override int SpecialMissileHit(Actor victim)
	{
		If(victim is "LFAcolyteShield"){Return 1;}
		Else{Return Super.SpecialMissileHit(victim);}
	}
}
Class LFAcolyteShield : Actor
{
	Default
	{
		+SHOOTABLE; +NOBLOOD;
		+DONTTHRUST; +NODAMAGE;
		Radius 22;
		Height 20;
		Mass 200;
	}
	Override void Tick()
	{
		Super.Tick();
		let acol = LFAcolyte(master);
		If(master==null||master.health<1||acol.shielded==0){Destroy();}
		Else
		{
			let mf = master.frame;
			If(mf==4||mf==5||mf==14){A_Warp(AAPTR_MASTER,4,0,30,0);}
			Else{A_Warp(AAPTR_MASTER,0,0,0,0);}
		}
	}
	Override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle)
	{
		If(master!=null&&mod=="Melee2"){master.SetStateLabel("ShieldDown"); master.reactiontime=4;}
		Return Super.DamageMobj(inflictor,source,damage,mod,flags,angle);
	}
	States
	{
	Spawn:
		TNT1 A 1;
		Loop;
	}
}
Class LFGasGrenade : LFGrenadeBase
{
	Default
	{
		LFGrenadeBase.FuseTime 70;
		Speed 20;
		Obituary "%o choked on one of %k's gas grenades.";
		+ROLLSPRITE; +ROLLCENTER;
		+FORCEXYBILLBOARD;
	}
	States
	{
	Spawn:
		GASG BBBBCCCC 1 {B_NadeCountdown(); A_SetRoll(roll-2);}
		Loop;
	Death:
		GASG BBBBCCCC 1 B_NadeCountdown();
		Loop;
	Explode:
		GASG B 1 Bright
		{
			For(int i; i<2; i++)
			{
				bool spawn1; Actor spawn2;
				[spawn1, spawn2] = A_SpawnItemEx("LFGasObstacle",Random(-32,32),Random(-32,32));
				spawn2.Reactiontime=Random(60,100);
			}
			A_StartSound("weapons/phgrenadeshoot");
		}
		GASG B 175;
		GASG B 1 A_FadeOut(0.02);
		Wait;
	}
}
Class LFGasObstacle : Actor
{
	Default
	{
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
	States
	{
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

Class LFAcolyteTan : LFAcolyte replaces AcolyteTan
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
	}
}
Class LFAcolyteRed : LFAcolyte replaces AcolyteRed
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
		Health 100;
		Translation 0;
		LFAcolyte.Shielded 1;
	}
	/*Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		If(level.levelnum==2&&pos==(2048.0,2032.0,-32.0))
		{
			Spawn("LFWeaponSmith",pos);
			Destroy();
		}
	}*/
}
Class LFAcolyteRust : LFAcolyte replaces AcolyteRust
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
		Health 80;
		Translation 1;
		LFAcolyte.Shielded 1;
	}
	/*Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		If(level.levelnum==2&&pos==(2128.0,2032.0,-32.0))
		{
			Spawn("LFArmorer",pos);
			Destroy();
		}
	}*/
}
Class LFAcolyteGray : LFAcolyte replaces AcolyteGray
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
		Translation 2;
	}
}
Class LFAcolyteDGreen : LFAcolyte replaces AcolyteDGreen
{
	Default
	{
		+MISSILEMORE
		Translation 3;
	}
}
Class LFAcolyteGold : LFAcolyte replaces AcolyteGold
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
		Health 120;
		Translation 4;
		LFAcolyte.Shielded 1;
		LFAcolyte.Equipment "GASG";
		DamageFactor "Gas", 0;
		PainChance "Gas", 0;
	}
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		lootmoney=Random(5,25);
		nowound=1;
	}
}
Class LFAcolyteLGreen : LFAcolyte replaces AcolyteLGreen
{
	Default
	{
		Health 60;
		Translation 5;
	}
}
Class LFAcolyteBlue : LFAcolyte replaces AcolyteBlue
{
	Default
	{
		Health 60;
		Translation "32:63=0:31", "80:95=64:79", "128:143=144:159", "192:192=1:1", "193:223=1:31", "235:239=224:228";
		LFAcolyte.Equipment "TARG";
	}
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		looteqip2=Random(50,90);
	}
}
Class LFAcolyteShadow : LFAcolyte replaces AcolyteShadow
{
	Default
	{
		+MISSILEMORE +MISSILEEVENMORE
		Health 90;
		LFAcolyte.Shielded 1;
	}
}
Class LFAcolyteToBe : LFAcolyte replaces AcolyteToBe
{
	Default
	{
		Health 61;
		Radius 20;
		Height 56;
		DeathSound "becoming/death";
		-COUNTKILL
		-ISMONSTER
	}
	States
	{
	Spawn:
		ARMR A -1;
		Stop;
	Pain:
		ARMR A -1 A_HideDecepticon;
		Stop;
	Death:
		Goto XDeath;
	}
	void A_HideDecepticon ()
	{
		Door_Close(999, 64);
		if (target != null && target.player != null)
		{
			SoundAlert (target);
		}
	}
}
Class LFDeadAcolyte : LFAcolyte replaces DeadAcolyte
{
	Default{-COUNTKILL;}
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		gunmag=Random(5,25);
	}
	States
	{
	Spawn:
		AGRD N 0 NoDelay A_Die();
	Death:
		AGRD N 0 A_NoBlocking();
		AGRD N -1;
		Stop;
	}
}
Class LFUniqueAcolyte : LFDeadAcolyte
{
	Override void PostBeginPlay()
	{
		Super.PostBeginPlay();
		gunmag=30;
		lootmoney=25;
		lootmed=0; lootarm=0; lootarm2=0;
	}
	Default {Translation 5;}
	States
	{
	Spawn:
		AGRD N 0 NoDelay A_Die();
	Death:
		AGRD N 0 {A_NoBlocking(); /*A_SpawnItemEx("LFRifleParts",Random(-16,16),Random(-16,16));*/}
		AGRD N -1;
		Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////