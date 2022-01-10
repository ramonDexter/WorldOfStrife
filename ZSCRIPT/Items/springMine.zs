/*
Name: Spring Mine
Type: Offensive
Palette: Doom
Summon: SpringMine
Use type: Inventory
Duration: Instant
Brightmaps : No
Added States: No
ACS: No


A mine that launches into the air when an enemy is in proximity, creating a
powerful blast.

Submitted: Mor'ladim
Decorate: Mor'ladim
zscript: ramon.dexter
Sounds: Mor'ladim, Phantasy Star Online, Fate
Sprites: Mor'ladim, Legend of the Monster Hunter, Dark Forces (Mine sprite used as base)
Idea Base: Original idea
*/

class wosSpringMine : CustomInventory
{
	Default
	{
		//$Category "Powerups/WoS"
		//$Title "Spting Mine"
		
		+INVENTORY.INVBAR
		+FLOORCLIP
		
		Inventory.Amount 1;
		Inventory.MaxAmount 8;
		Inventory.PickupSound "SMINGET";
		Inventory.PickupMessage "$F_SPRINGMINE";
		Inventory.Icon "SPMIA0";
		Tag "$T_SPRINGMINE";
		
		radius 10;
		height 10;
	}
	States
	{
		Spawn:
			SPMN ABC 2;
			Loop;
		Use:
			TNT1 A 0;
			SPMN A 0 A_ThrowGrenade("SpringMineSet",2,7,3,0);			
			Stop;
	} 
}

class SpringMineSet : actor
{
	Default
	{
		+MISSILE
		+DROPOFF
		+CANBOUNCEWATER
		+THRUACTORS
		
		Projectile;
		Radius 10;
		Height 5;
		Speed 22;
		BounceType "Doom";
		BounceSound "MINBNC";
		BounceCount 3;
		Mass 1000000;
		Speed 2;
	}
	
	States
	{
		Spawn:  
			TNT1 A 0;
			SPMN AAA 2 Bright;
			Loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_SpawnItemEx("SpringMineActive",0,0,0,0,0,0,0,32);
			Stop;
	} 
}

class SpringMineActive : actor
{
	
	int user_smine; //Related to visual pulse ring spawn.
	
	Default
	{
		+NOBLOOD
		-SHOOTABLE
		+BRIGHT
		+MISSILE
		+MOVEWITHSECTOR
		+NOCLIP
		+PAINLESS
		
		Radius 10;
		Height 5;
		Mass 1000000;
		Health 20;
		Damage 1;
		Speed 0;
	}
	States
	{
	Spawn:
		TNT1 A 0;
		SPMN A 0 A_Gravity();
		TNT1 A 0 A_StartSound("SMNSET1", 0);
		SPMN AAAAAAAAAA 2;
		TNT1 A 0 A_StartSound("SMNSET2", 0);
		SPMN AD 1;
		TNT1 A 0 
		{
			self.bNoclip = true;
		}
		GoTo Spawn+14;
	Death:
		TNT1 A 0;
		TNT1 A 0 
		{
			self.bTHRUACTORS = 1;
		}
		SPMN ABC 2;
		TNT1 A 0 ThrustThingZ(0,45,0,0);
		TNT1 A 0 A_StartSound("MINLNCH", 0);
		SPMN AAAAAAAAA 2;
		SPMN AAA 1;
		TNT1 A 0 A_AlertMonsters();
		TNT1 A 0 A_StartSound("SPRNMNXP", 0);
		TNT1 A 0 A_Explode(105,185,0,1,185); //Source of damage dealt.
		TNT1 A 0 A_SpawnItemEx("SMineExplosion",0,0,5,0,0,0,0,32);	
		TNT1 A 0 
		{
			self.user_smine = 0; //Related to visual pulse ring spawn.
		}
	Pulse:
		TNT1 A 0 A_SpawnProjectile("SpringMinePulseVisual",0,0,user_smine,CMF_AIMDIRECTION);
		TNT1 A 0 
		{
			self.user_smine++;
		}
		TNT1 A 0
		{
			if(self.user_smine == 360)
			{
				return resolveState("EndPulse");	
			}
			return resolveState(null);
		}
		Loop;
	EndPulse:
		TNT1 A 0;
		Stop;
	} 
}

class SpringMinePulseVisual : actor //Aesthetic. Deals no damage.
{
	Default
	{
		+BRIGHT
		+THRUACTORS
		+MOVEWITHSECTOR
		
		Speed 8;
		Radius 8;
		Height 5;
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.3;
		PROJECTILE;
	}
	
	States
	{
		Spawn:
			RGNA AAAAA 1;
			TNT1 A 0 A_SetTranslucent(0.1);
			RGNA AA 3 A_SetScale(0.2);
			RGNA A 1 A_SetScale(0.1);
		Death:
			TNT1 A 0;
			Stop;
	}
}

class SMineExplosion : actor  //Deals no damage.
{
	Default
	{
		+NOCLIP
		+THRUACTORS
		+BRIGHT
		+MOVEWITHSECTOR
		
		Projectile;
		Radius 6;
		Height 6;
		Speed 0;
		RenderStyle "Add";
		Alpha 0.2;
		Scale 1;
	}
	
	States
	{
		Spawn:
			TNT1 A 0;
			Goto Death;
		Death:
			PLXP A 1;
			TNT1 A 0 A_SetScale(2.1);
			PLXP A 1;
			TNT1 A 0 A_SetScale(3.3);
			PLXP A 1;
			TNT1 A 0 A_SetScale(4.5);
			TNT1 A 0 A_SetTranslucent(0.1);
			PLXP A 1;
			Stop;
	}
}