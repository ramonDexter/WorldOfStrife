class peasantBase : Peasant {
	Default {
		//$Category "Other NPCs/WoS"
		Health 64;
	}
}
class PeasantTan : peasantBase {
	Default {
		//$Title "Peasant Tan"		
		+FRIENDLY		
	}
}
class PeasantDarkGreen : peasantBase {
	Default {
		//$Title "Peasant Dark Green"	
		+FRIENDLY		
		Translation 3;
	}
}
class PeasantRed : peasantBase {
	Default {
		//$Title "Peasant Red"		
		+FRIENDLY		
		Translation 0;
	}
}
class PeasantGray : peasantBase {
	Default {
		//$Title "Peasant Gray"						
		+FRIENDLY		
		Translation 2;
	}
}
class PeasantBrightGreen : peasantBase {
	Default {
		//$Title "Peasant Bright Green"						
		+FRIENDLY		
		Translation 5;
	}
}
class PeasantRust : peasantBase {
	Default {
		//$Title "Peasant Rust"						
		+FRIENDLY		
		Translation 1;
	}
}
class PeasantGold : peasantBase {
	Default {
		//$Title "Peasant Gold"						
		+FRIENDLY		
		Translation 4;
	}
}
class PeasantBlue : peasantBase {
	Default {
		//$Title "Peasant Blue"						
		+FRIENDLY		
		Translation 6;
	}
}
class vendorBase : merchant {
	Default {
		//$Category "Other NPCs/WoS"
		+FRIENDLY
		-ISMONSTER
		
		Tag "Vendor";
	}
}
class vendor_Tan : vendorBase {
	Default {
		//$Title "Vendor Tan"			
	}
}
class vendor_BrightGreen : vendorBase {
	Default {
		
		//$Title "Vendor Bright Green"		
		
		Translation 5;
	}
}
class vendor_blue_1 : vendorBase {
	Default {		
		//$Title "Vendor Blue 1"		
		Translation 6;
		
	}
}
class vendor_blue_2 : vendorBase {
	Default {
		//$Title "Vendor Blue 2"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=96:111", "192:223=144:159";		
	}
}
class vendor_azure : vendorBase {
	Default {
		//$Title "Vendor Azure"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=96:111", "192:223=112:127";
	}
}
class vendor_gold : vendorBase {
	Default{
		//$Title "Vendor Gold"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=144:159", "192:223=80:95";
	}
}

class vendor_green : vendorBase {
	Default {
		//$Title "Vendor Green"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=168:182", "192:223=46:61";
	
	}
}
class vendor_gray : vendorBase {
	Default {
		//$Title "Vendor Gray"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=168:182", "192:223=16:31";
	
	}
}
class vendor_red : vendorBase {
	Default {
		//$Title "Vendor Red"		
		Translation "32:63=0:31", "80:95=16:31", "128:143=112:127", "192:223=68:79";
	
	}
}

class vendor_m8fTrading : vendorBase {
	Default {
		//$Title "Vendor Tan tradingLicense"
	}
}

class tekGuildMaster_01 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekGuild Representative 1"
		
		+SOLID
		
		Tag "Guildmaster";
		radius 16;
		height 56;
	}
	States  {
		Spawn:
			TKG1 A -1;
			Stop;
	}
}
class tekGuildMaster_02 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekGuild Representative 2"
		
		+SOLID
		
		Tag "Guildmaster";
		radius 16;
		height 56;
	}
	States  {
		Spawn:
			TKG2 A -1;
			Stop;
	}
}
class tekGuildMaster_03 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekGuild Representative 3"
		
		+SOLID
		
		Tag "Guildmaster";
		radius 16;
		height 56;
	}
	States  {
		Spawn:
			TKG3 A -1;
			Stop;
	}
}
class tekGuildMaster_04 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekGuild Representative 4"
		
		+SOLID
		
		Tag "Guildmaster";
		radius 16;
		height 56;
	}
	States  {
		Spawn:
			TKG4 A -1;
			Stop;
	}
}

class nwCultist : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Cultist"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Cultist";
		radius 16;
		height 56;
	}
	
	States {
		Spawn:
			CLTS A -1;
			Stop;
	}
}

class orderCultist : StrifeHumanoid {
	Default {
		//sprites by nash
		//zscript by ramon.dexter
		//$Category "Other NPCs/WoS"
		//$Title "Order Cultist"
		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
        Tag "Cultist";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "Peasant/sight";
		AttackSound "Peasant/attack";
		PainSound "Peasant/pain";
		DeathSound "Peasant/death";
		HitObituary "$OB_PeasANT";
	}
	
	States {
        Spawn:
            STCL A 10 A_Look2();
            Loop;
        See:
            STCL AABBCCDD 5 A_Wander();
            Goto Spawn;
        Melee:
        Missile:
            STCL E 4;
            STCL F 10 A_FaceTarget();
            STCL G 8 Bright A_CustomBulletAttack(11.25, 7, 20, 5*random(1, 3), "MaulerPuff");
            STCL F 8 A_FaceTarget();
            STCL E 4;
            Goto See;
        Pain:
            STCL H 3;
            STCL H 3 A_Pain();
            Goto Melee;
        Wound:
            STCL H 5;
            STCL H 10 A_GetHurt();
            STCL H 6;
            Goto Wound+1;
        Death:
            STCL I 5;
            STCL J 5 A_Scream();
            STCL K 6;
            STCL L 5 A_NoBlocking();
            STCL M 5;
            STCL N 6;
            STCL O 8;
            STCL P 5;
            STCL Q 700;
            Stop;
        XDeath:
            GIBS M 5 A_TossGib();
            GIBS N 5 A_XScream();
            GIBS O 5 A_NoBlocking();
            GIBS PQRS 4 A_TossGib();
            Goto Death+8;
        Disintegrate:
            STCD A 5 A_StartSound("misc/disruptordeath", 2);
            STCD BC 5;
            STCD D 4 A_NoBlocking();
            STCD EF 5;
            STCD GH 4;
            DISR IJ 4;
            MEAT D 700;
            Stop;
	}
}
class hereticCultist : orderCultist {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Heretic Cultist"
		
		-FRIENDLY
		
		Tag "Heretic Cultist";
	}
}
class hereticCultistLeader : hereticCultist {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Heretic Cultist Leader"
		
		Tag "Heretic Cultist Leader";
		Dropitem "hereticLeaderSkull";
		Dropitem "randomDrop_01";
	}
}
class tekPeasant01_base : StrifeHumanoid {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekPeasant - baldy"
		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
		Tag "tekpeasant";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "Peasant/sight";
		AttackSound "Peasant/attack";
		PainSound "Peasant/pain";
		DeathSound "Peasant/death";
		HitObituary "$OB_PeasANT";
	}
	
	States {
		Spawn:
			PS01 G 10 A_Look2();
			Loop;
			PS01 G 10;
			loop;
			PS01 G 10;
			Loop;
			PS01 AABBCCDD 5 A_Wander();
			Goto Spawn;
		See:
			PS01 AABBCCDD 5 A_Wander();
			Goto Spawn;
		Melee:
			PS01 E 10 A_FaceTarget();
			PS01 F 8 A_CustomMeleeAttack(2*random[PeasantAttack](1, 5)+2);
			PS01 E 8;
			Goto See;
		Pain:
			PEAS O 3;
			PEAS O 3 A_Pain();
			Goto Melee;
		Wound:
			PEAS G 5;
			PEAS H 10 A_GetHurt();
			PEAS I 6;
			Goto Wound+1;
		Death:
			PEAS G 5;
			PEAS H 5 A_Scream;
			PEAS I 6;
			PEAS J 5 A_NoBlocking;
			PEAS K 5;
			PEAS L 6;
			PEAS M 8;
			PEAS N 1400;
			GIBS U 5;
			GIBS V 1400;
			Stop;
		XDeath:
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRS 4 A_TossGib;
			Goto Death+8;
	}
}
class tekPeasant02_base : StrifeHumanoid {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekPeasant - cyber R eye"
		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
		Tag "tekpeasant";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "PS01ant/sight";
		AttackSound "PS01ant/attack";
		PainSound "PS01ant/pain";
		DeathSound "PS01ant/death";
		HitObituary "$OB_PS01ANT";
	}
	
	States {
		Spawn:
			PS02 G 10 A_Look2();
			Loop;
			PS02 G 10;
			loop;
			PS02 G 10;
			Loop;
			PS02 AABBCCDD 5 A_Wander();
			Goto Spawn;
		See:
			PS02 AABBCCDD 5 A_Wander();
			Goto Spawn;
		Melee:
			PS02 E 10 A_FaceTarget();
			PS02 F 8 A_CustomMeleeAttack(2*random[PeasantAttack](1, 5)+2);
			PS02 E 8;
			Goto See;
		Pain:
			PEAS O 3;
			PEAS O 3 A_Pain();
			Goto Melee;
		Wound:
			PEAS G 5;
			PEAS H 10 A_GetHurt();
			PEAS I 6;
			Goto Wound+1;
		Death:
			PEAS G 5;
			PEAS H 5 A_Scream;
			PEAS I 6;
			PEAS J 5 A_NoBlocking;
			PEAS K 5;
			PEAS L 6;
			PEAS M 8;
			PEAS N 1400;
			GIBS U 5;
			GIBS V 1400;
			Stop;
		XDeath:
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRS 4 A_TossGib;
			Goto Death+8;
	}
}

class tekPeasant03_base : StrifeHumanoid {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekPeasant - green cyber R eye"
		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
		Tag "tekpeasant";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "PS01ant/sight";
		AttackSound "PS01ant/attack";
		PainSound "PS01ant/pain";
		DeathSound "PS01ant/death";
		HitObituary "$OB_PS01ANT";
	}
	
	States {
		Spawn:
			PS03 G 10 A_Look2();
			Loop;
			PS03 G 10;
			loop;
			PS03 G 10;
			Loop;
			PS03 AABBCCDD 5 A_Wander();
			Goto Spawn;
		See:
			PS03 AABBCCDD 5 A_Wander();
			Goto Spawn;
		Melee:
			PS03 E 10 A_FaceTarget();
			PS03 F 8 A_CustomMeleeAttack(2*random[PeasantAttack](1, 5)+2);
			PS03 E 8;
			Goto See;
		Pain:
			PEAS O 3;
			PEAS O 3 A_Pain();
			Goto Melee;
		Wound:
			PEAS G 5;
			PEAS H 10 A_GetHurt();
			PEAS I 6;
			Goto Wound+1;
		Death:
			PEAS G 5;
			PEAS H 5 A_Scream;
			PEAS I 6;
			PEAS J 5 A_NoBlocking;
			PEAS K 5;
			PEAS L 6;
			PEAS M 8;
			PEAS N 1400;
			GIBS U 5;
			GIBS V 1400;
			Stop;
		XDeath:
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRS 4 A_TossGib;
			Goto Death+8;
	}
}

class tekPeasant04_base : StrifeHumanoid {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekPeasant - cyber ears"
		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
		Tag "tekpeasant";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "PS01ant/sight";
		AttackSound "PS01ant/attack";
		PainSound "PS01ant/pain";
		DeathSound "PS01ant/death";
		HitObituary "$OB_PS01ANT";
	}
	
	States {
		Spawn:
			PS04 G 10 A_Look2();
			Loop;
			PS04 G 10;
			loop;
			PS04 G 10;
			Loop;
			PS04 AABBCCDD 5 A_Wander();
			Goto Spawn;
		See:
			PS04 AABBCCDD 5 A_Wander();
			Goto Spawn;
		Melee:
			PS04 E 10 A_FaceTarget();
			PS04 F 8 A_CustomMeleeAttack(2*random[PeasantAttack](1, 5)+2);
			PS04 E 8;
			Goto See;
		Pain:
			PEAS O 3;
			PEAS O 3 A_Pain();
			Goto Melee;
		Wound:
			PEAS G 5;
			PEAS H 10 A_GetHurt();
			PEAS I 6;
			Goto Wound+1;
		Death:
			PEAS G 5;
			PEAS H 5 A_Scream;
			PEAS I 6;
			PEAS J 5 A_NoBlocking;
			PEAS K 5;
			PEAS L 6;
			PEAS M 8;
			PEAS N 1400;
			GIBS U 5;
			GIBS V 1400;
			Stop;
		XDeath:
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRS 4 A_TossGib;
			Goto Death+8;
	}
}
class tekPeasant05_base : StrifeHumanoid {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "tekPeasant - older guy"		
		+NEVERTARGET
		-COUNTKILL
		+NOSPLASHALERT
		+FLOORCLIP
		+JUSTHIT
		+FRIENDLY
		
		Tag "tekpeasant";
		Health 64;
		PainChance 200;
		Speed 8;
		Radius 20;
		Height 56;
		Monster;
		MinMissileChance 150;
		MaxStepHeight 16;
		MaxDropoffHeight 32;
		SeeSound "PS01ant/sight";
		AttackSound "PS01ant/attack";
		PainSound "PS01ant/pain";
		DeathSound "PS01ant/death";
		HitObituary "$OB_PS01ANT";
	}
	
	States {
		Spawn:
			PS05 G 10 A_Look2();
			Loop;
			PS05 G 10;
			loop;
			PS05 G 10;
			Loop;
			PS05 AABBCCDD 5 A_Wander();
			Goto Spawn;
		See:
			PS05 AABBCCDD 5 A_Wander();
			Goto Spawn;
		Melee:
			PS05 E 10 A_FaceTarget();
			PS05 F 8 A_CustomMeleeAttack(2*random[PeasantAttack](1, 5)+2);
			PS05 E 8;
			Goto See;
		Pain:
			PEAS O 3;
			PEAS O 3 A_Pain();
			Goto Melee;
		Wound:
			PEAS G 5;
			PEAS H 10 A_GetHurt();
			PEAS I 6;
			Goto Wound+1;
		Death:
			PEAS G 5;
			PEAS H 5 A_Scream;
			PEAS I 6;
			PEAS J 5 A_NoBlocking;
			PEAS K 5;
			PEAS L 6;
			PEAS M 8;
			PEAS N 1400;
			GIBS U 5;
			GIBS V 1400;
			Stop;
		XDeath:
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRS 4 A_TossGib;
			Goto Death+8;
	}
}

//tekPeasant01_base
//tekPeasant02_base
//tekPeasant03_base
//tekPeasant04_base
//tekPeasant05_base
/*
tekPeasant translations
dark green "128:143=48:63"
gold "128:143=80:95"
blue "128:143=112:127"
azure "128:143=144:159"
rust "128:143=175:191"
dark tan "128:143=208:223"
red "128:143=64:79"
gray "128:143=15:31"
*/
class tekPeasant01_darkGreen : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy darkGreen"		
		Translation "128:143=48:63";
	}
}
class tekPeasant01_gold : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy gold"
		Translation "128:143=80:95";
	}
}
class tekPeasant01_blue : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy blue"
		Translation "128:143=112:127";		
	}
}
class tekPeasant01_azure : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy azure"
		Translation "128:143=144:159";		
	}
}
class tekPeasant01_rust : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy rust"
		Translation "128:143=175:191";		
	}
}
class tekPeasant01_darkTan : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy dark tan"
		Translation "128:143=208:223";		
	}
}
class tekPeasant01_red : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy red"
		Translation "128:143=64:79";		
	}
}
class tekPeasant01_gray : tekPeasant01_base {
	Default {
		//$Title "tekPeasant - baldy gray"
		Translation "128:143=15:31";		
	}
}
class tekPeasant02_darkGreen : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye darkGreen"		
		Translation "128:143=48:63";
	}
}
class tekPeasant02_gold : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye gold"
		Translation "128:143=80:95";
	}
}
class tekPeasant02_blue : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye blue"
		Translation "128:143=112:127";		
	}
}
class tekPeasant02_azure : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye azure"
		Translation "128:143=144:159";		
	}
}
class tekPeasant02_rust : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye rust"
		Translation "128:143=175:191";		
	}
}
class tekPeasant02_darkTan : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye dark tan"
		Translation "128:143=208:223";		
	}
}
class tekPeasant02_red : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye red"
		Translation "128:143=64:79";		
	}
}
class tekPeasant02_gray : tekPeasant02_base {
	Default {
		//$Title "tekPeasant - cyber R eye gray"
		Translation "128:143=15:31";		
	}
}
class tekPeasant03_darkGreen : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye darkGreen"		
		Translation "128:143=48:63";
	}
}
class tekPeasant03_gold : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye gold"
		Translation "128:143=80:95";
	}
}
class tekPeasant03_blue : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye blue"
		Translation "128:143=112:127";		
	}
}
class tekPeasant03_azure : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye azure"
		Translation "128:143=144:159";		
	}
}
class tekPeasant03_rust : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye rust"
		Translation "128:143=175:191";		
	}
}
class tekPeasant03_darkTan : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye dark tan"
		Translation "128:143=208:223";		
	}
}
class tekPeasant03_red : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye red"
		Translation "128:143=64:79";		
	}
}
class tekPeasant03_gray : tekPeasant03_base {
	Default {
		//$Title "tekPeasant - green cyber R eye gray"
		Translation "128:143=15:31";		
	}
}
class tekPeasant04_darkGreen : tekPeasant04_base {
	Default {
		//$Title "tekPeasant - cyber ears darkGreen"		
		Translation "128:143=48:63";
	}
}
class tekPeasant04_gold : tekPeasant04_base {
	Default {
		//$Title "tekPeasant - cyber ears gold"
		Translation "128:143=80:95";
	}
}
class tekPeasant04_blue : tekPeasant04_base {
	Default {
		//$Title "tekPeasant - cyber ears blue"
		Translation "128:143=112:127";		
	}
}
class tekPeasant04_azure : tekPeasant04_base {
	Default {
		//$Title "tekPeasant - cyber ears azure"
		Translation "128:143=144:159";		
	}
}
class tekPeasant04_rust : tekPeasant04_base {
	Default {
		//$Title "tekPeasant - cyber ears rust"
		Translation "128:143=175:191";		
	}
}
class tekPeasant04_darkTan : tekPeasant04_base
{
	Default
	{
		//$Title "tekPeasant - cyber ears dark tan"
		Translation "128:143=208:223";		
	}
}
class tekPeasant04_red : tekPeasant04_base
{
	Default
	{
		//$Title "tekPeasant - cyber ears red"
		Translation "128:143=64:79";		
	}
}
class tekPeasant04_gray : tekPeasant04_base
{
	Default
	{
		//$Title "tekPeasant - cyber ears gray"
		Translation "128:143=15:31";		
	}
}


class tekPeasant05_gold : tekPeasant05_base
{
	Default
	{
		//$Title "tekPeasant - older guy gold"
		Translation "128:143=80:95";
	}
}

class tekPeasant05_rust : tekPeasant05_base
{
	Default
	{
		//$Title "tekPeasant - older guy rust"
		Translation "128:143=175:191";		
	}
}
class tekPeasant05_darkTan : tekPeasant05_base
{
	Default
	{
		//$Title "tekPeasant - older guy dark tan"
		Translation "128:143=208:223";		
	}
}
class tekPeasant05_red : tekPeasant05_base
{
	Default
	{
		//$Title "tekPeasant - older guy red"
		Translation "128:143=64:79";		
	}
}
class tekPeasant05_gray : tekPeasant05_base
{
	Default
	{
		//$Title "tekPeasant - older guy gray"
		Translation "128:143=15:31";		
	}
}

class beggarBase : Beggar {
	Default {
		//$Category "Other NPCs/WoS"
		Health 56;
	}
	States {
		Spawn:
			BEGR P 10 A_Look2();
			Loop;
			BEGR P 10;
			Loop;
			BEGR P 10;
			Loop;
			BEGR AABBCC 4 A_Wander;
			Loop;
		See:
			BEGR AABBCC 4 A_Wander;
			Loop;
		Melee:
			BEGR D 8;
			BEGR D 8 A_CustomMeleeAttack(2*random[PeasantAttack](1,5)+2);
			BEGR E 1 A_Chase;
			BEGR D 8 A_SentinelRefire;
			Loop;
		Pain:
			BEGR A 3 A_Pain;
			BEGR A 3 A_Chase;
			Goto Melee;
		Death:
			BEGR F 4;
			BEGR G 4 A_Scream;
			BEGR H 4;
			BEGR I 4 A_NoBlocking;
			BEGR JKLM 4;
			BEGR N -1;
			Stop;
		XDeath:
			BEGR F 5 A_TossGib;
			GIBS M 5 A_TossGib;
			GIBS N 5 A_XScream;
			GIBS O 5 A_NoBlocking;
			GIBS PQRST 4 A_TossGib;
			GIBS U 5;
			GIBS V 1400;
			Stop;
	}
}

class beggar_tan : beggarBase {
	Default {
		//$Title "Beggar Tan"
		+FRIENDLY
	}
}

class beggar_darkGreen : beggarBase {
	Default {
		//$Title "Beggar Dark Green"
		+FRIENDLY
		Translation "128:143=48:63";
		
	}
}
class beggar_bronze : beggarBase {
	Default {
		//$Title "Beggar Bronze"
		+FRIENDLY
		Translation "128:143=80:95";		
	}
}
class beggar_blue : beggarBase {
	Default {
		//$Title "Beggar Blue"
		+FRIENDLY
		Translation "128:143=112:127";
	}
}
class beggar_brown : beggarBase {
	Default {
		//$Title "Beggar Brown"
		+FRIENDLY
		Translation	"128:143=173:188";	
	}
}
class beggar_darkTan : beggarBase {
	Default {
		//$Title "Beggar darkTan"
		+FRIENDLY
		Translation "128:143=208:223";
	}
}
class beggar_gray : beggarBase {
	Default {
		//$Title "Beggar gray"
		+FRIENDLY
		Translation "128:143=16:31";
	}
}

class beggarEnemy : beggarBase {
	Default {
		-FRIENDLY
	}
	States {
		Spawn:
			BEGR A 10 A_Look();
			Loop;
		See:
			BEGR AABBCC 4 A_Chase();
			Loop;
		Melee:
			BEGR D 8;
			BEGR D 8 A_CustomMeleeAttack(2*random[PeasantAttack](1,5)+2);
			BEGR E 1 A_Chase();
			BEGR D 8 A_SentinelRefire();
			Loop;
		Pain:
			BEGR A 3 A_Pain();
			BEGR A 3 A_Chase();
			Goto Melee;
		Death:
			BEGR F 4;
			BEGR G 4 A_Scream();
			BEGR H 4;
			BEGR I 4 A_NoBlocking();
			BEGR JKLM 4;
			BEGR N -1;
			Stop;
		XDeath:
			BEGR F 5 A_TossGib();
			GIBS M 5 A_TossGib();
			GIBS N 5 A_XScream();
			GIBS O 5 A_NoBlocking();
			GIBS PQRST 4 A_TossGib();
			GIBS U 5;
			GIBS V 1400;
			Stop;
	}
}
class beggarEnemy_darkGreen : beggarEnemy {
	Default {
		//$title "beggar foe DG"
	}	
}
class beggarEnemy_bronze : beggarEnemy {
	Default {
		//$title "beggar foe bronze"
	}
}
class beggarEnemy_blue : beggarEnemy {
	Default {
		//$title "beggar foe blue"
	}
}
class beggarEnemy_brown : beggarEnemy {
	Default {
		//$title "beggar foe brown"
	}
}
class beggarEnemy_darkTan : beggarEnemy {
	Default {
		//$title "beggar foe darktan"
	}
}
class beggarEnemy_gray : beggarEnemy {
	Default {
		//$title "beggar foe gray"
	}
}

class medicalBotHealing : Health {
	Default {
		Health -100;
		Inventory.pickupSound "sounds/med";
		
	}
}
//  deus ex medicalBot  ////////////////////////////////////////////////////////
class dx_medicalBot : SwitchableDecoration {
    Default {
        //$Category "Other NPCs/WoS"
        //$Title "Medical Bot"
        +SOLID;
        +USESPECIAL;

		Tag "medical bot";
        radius 16;
        height 42;
        Mass 5000;
        Activation THINGSPEC_Switch;
    }
    States {
        Spawn:
            DUMM A 1;
            Wait;        
        Active:
            DUMM ABC 8;
		ActiveLoop:
            DUMM DEFG 10;
			TNT1 A 0 A_GiveInventory("medicalBotHealing", 100, AAPTR_PLAYER1);
			DUMM FED 10;
			DUMM CBA 8;
			//Loop;
        Inactive:            
			DUMM A -1;
            Stop;
    }
}
//  deus ex cleanerBot  ////////////////////////////////////////////////////////
class dx_cleanerBot : Actor {	

    Default {
        //$Category "Other NPCs/WoS"
        //$Title "Cleaner Bot"
        +SOLID;
        +USESPECIAL;
        +DROPOFF;
        +FRIENDLY;
        +NOTARGET;
        +NODAMAGE;
        +INVULNERABLE;

		Tag "cleaner bot";
        radius 8;
        height 16;
        Health 9999999;
        Speed 12;
        Monster;
        MaxDropOffHeight 8;
        MaxStepHeight 8;
		ActiveSound "sounds/clrBotAct";
        
    }
    States {
		Spawn:
			TNT1 A 0 A_StartSound ("sounds/clrBotAct", 0, CHANF_LOOPING, 0.25);
			DUMM A 10 A_Look2();
			Loop;
		See:		
			DUMM AAAAAAAA 5 A_Wander();
			Goto Spawn;
		Melee:
			//DUMM A 10 A_FaceTarget();
			//DUMM A 8 A_CustomMeleeAttack(2*random[DUMMantAttack](1, 5)+2);
			//DUMM A 8;
			Goto See;
		Pain:
			DUMM A 3;
			DUMM A 3 A_Pain();
			Goto Melee;
		Wound:
			DUMM A 5;
			DUMM A 10 A_GetHurt();
			DUMM A 6;
			Goto Wound+1;
		Death:
			DUMM A 5;
			DUMM A 5 A_Scream;
			DUMM A 6;
			DUMM A 5 A_NoBlocking;
			DUMM A 5;
			DUMM A 6;
			DUMM A 8;
			DUMM A 1400;
			DUMM A 5;
			DUMM A 1400;
			Stop;
		XDeath:
			DUMM A 5 A_TossGib;
			DUMM A 5 A_XScream;
			DUMM A 5 A_NoBlocking;
			DUMM AAAA 4 A_TossGib;
			Goto Death+8;
	}
}
////////////////////////////////////////////////////////////////////////////////

// monk guy ////////////////////////////////////////////////////////////////////
class wos_monkGuy : SwitchableDecoration {
	Default {
        //$Category "Other NPCs/WoS"
        //$Title "Monk guy"
        +SOLID
        +USESPECIAL
		Tag "Monk";
  		Radius 16;
  		Height 56;
        Activation THINGSPEC_Switch; // dulezity pokud to ma jit aktivovat!!!!
	}
	States {
		Spawn:
			PRIE F -1;
			Wait;
		Active:
			PRIE ABCDE 5;
		Ahold:
			PRIE F -1;
			Stop;		
		Inactive:
			PRIE FEDCB 5;
		Hold:
			PRIE A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// daggerfall blacksmith ///////////////////////////////////////////////////////
class wos_daggerfallBlacksmith : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "blacksmith daggerfall"
		Tag "Blacksmith";
		radius 32;
		height 96;
		+SOLID
		+USESPECIAL
	}
    States {
		Spawn:
			DM12 E 5;
			DM12 B 8;
			DM12 AB 7;
			DM12 C 6;
			DM12 D 5 A_StartSound("npc/smith",5,1.0);
			DM12 D 3 A_Jump(64,"Spawn4");           
			Loop;
		Spawn3:
			DM12 C 0;
			DM12 C 6;
			DM12 D 6 A_StartSound("npc/smith",5,1.0);
			DM12 D 3 A_Jump(64,"Spawn4");
			Loop;
		Spawn4:
			DM12 D 1;
			DM12 D 6 A_StartSound("npc/smith",5,1.0);
			DM12 E 6;
			DM12 E 3 A_Jump(64,"Spawn");
			DM12 E 3 A_Jump(64,"Spawn3");
			Loop;
  	}
}
class wos_daggerfallBlacksmith2 : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "blacksmith arena"
		Tag "Blacksmith";
		radius 16;
		height 70;
		+SOLID
		+USESPECIAL
	}
    States {
		Spawn:
			DM29 ABCDE 8;
			Loop;
  	}
}
class wos_arenaOldGuy : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "oldguy"
		Tag "old guy";
		radius 16;
		height 87;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM13 A -1;
			Stop;
	}
}
class wos_daggerfallFatNoble : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger fat noble"
		Tag "fat noble";
		radius 16;
		height 68;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM14 A -1;
			Stop;
	}
}
class wos_daggerMonk : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger monk"
		Tag "monk";
		radius 16;
		height 69;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM15 A -1;
			Stop;
	}
}
class wos_daggerfallNobleGuy : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger noble"
		Tag "noble";
		radius 16;
		height 69;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM16 A -1;
			Stop;
	}
}
class wos_guywithStick : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "guy with stick"
		Tag "guy with stick";
		radius 16;
		height 63;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM17 A -1;
			Stop;
	}
}
class wos_daggerInnkeeper1 : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger innkeeper"
		Tag "innkeeper";
		radius 16;
		height 62;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM18 A -1;
			Stop;
	}
}
class wos_daggerTrader : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger trader"
		Tag "trader";
		radius 16;
		height 62;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM19 A -1;
			Stop;
	}
}
class wos_daggerScholar : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger scholar"
		Tag "scholar";
		radius 16;
		height 65;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM20 A -1;
			Stop;
	}
}
class wos_daggerTrader2 : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "dagger trader 2"
		Tag "trader";
		radius 16;
		height 63;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM21 A -1;
			Stop;
	}
}
class wos_daggerBeardedMonk : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "bearded monk"
		Tag "bearded monk";
		radius 16;
		height 63;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM22 A -1;
			Stop;
	}
}
class wos_daggerGuyInRed : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "bearded guy"
		Tag "bearded guy";
		radius 16;
		height 64;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM23 A -1;
			Stop;
	}
}
class wos_femaleInGreen : actor {
	Default {
		//$Category "Other NPCs/Females"
        //$Title "lady in green"
		Tag "lady in green";
		radius 16;
		height 59;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DF24 A -1;
			Stop;
	}
}
class wos_femaleNobleLady : actor {
	Default {
		//$Category "Other NPCs/Females"
        //$Title "noble lady"
		Tag "noble lady";
		radius 16;
		height 62;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DF25 A -1;
			Stop;
	}
}
class wos_daggerBard : actor {
	Default {
		//$Category "Other NPCs/WoS"
        //$Title "bard with lute"
		Tag "bard with lute";
		radius 16;
		height 62;
		+SOLID
		+USESPECIAL
	}
	States {
		Spawn:
			DM27 ABCDEF 6;
			Loop;
	}
}
////////////////////////////////////////////////////////////////////////////////

// noeworm based Order priests /////////////////////////////////////////////////
class wos_nwCultist02 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 2"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT2 A -1;
			Stop;
	}
}
class wos_nwCultist03 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 3"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT3 A -1;
			Stop;
	}
}
class wos_nwCultist04 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 4"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT4 A -1;
			Stop;
	}
}
class wos_nwCultist05 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 5"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT5 A -1;
			Stop;
	}
}
class wos_nwCultist06 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 6"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT6 A -1;
			Stop;
	}
}
class wos_millportBishop : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "millport bishop"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Bishop";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT6 A -1;
			Stop;
	}
}
class wos_nwCultist07 : actor {
	Default {
		//$Category "Other NPCs/WoS"
		//$Title "Priest 7"		
		+SOLID
		+USESPECIAL
		+DONTTHRUST		
		Tag "Priest";
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CLT7 A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

class wosD_npc_daggHolkaZhospody : actor {
	Default {
		//$Category "Other NPCs/females"
		//$Title "Lady innkeeper"
		+solid
		+useSpecial
		//+nogravity
		+DontThrust
		tag "innkeeper";
		scale 0.85;
		radius 16;
		height 56;
	}
	States {
		Spawn:
			CL19 A -1;
			Stop;
	}
}








////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////