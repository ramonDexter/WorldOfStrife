////////////////////////////////////////////////////////////////////////////////
// flamethrower ////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// weapon //////////////////////////////////////////////////////////////////////
class wosFlamethrower : wosWeapon replaces FlameThrower {
	Default {
		//$Category "Weapons/WoS"
		//$Title "zsc Flamethrower"
	
		inventory.icon "H_FLMR";
		Tag "$T_FLAMER";
		Inventory.PickupMessage  "$F_FLAMER";
		Weapon.AmmoUse1 1;
  		Weapon.AmmoGive1 100;
		Weapon.AmmoType1 "EnergyPod";
		Mass flamerBaseWeight;
        Weapon.UpSound "weapons/weaponUP";
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;			
		Nope:
			TNT1 A 1 {
				A_WeaponReady(WRF_NOFIRE); 
				A_ZoomFactor(1.0);
			}
			TNT1 A 0 A_ClearReFire();
			Goto Ready;			
		Ready:
			FLMT A 3 A_WeaponReady(WRF_ALLOWUSER1);
			FLMT B 3 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;		
		Deselect:
			FLMT A 1 A_Lower();
			Loop;
		Select:
			FLMT A 1 A_Raise();
			Loop;
		Fire:
			FLMF AB 2 {
				A_FireProjectile("FlamethrowerProjectile");
				A_WeaponOffset(random(-2,2),random(30,34), WOF_INTERPOLATE);
			}
			FLMF B 3 A_ReFire();
			Goto Ready;			
	}
}
////////////////////////////////////////////////////////////////////////////////

// projectile //////////////////////////////////////////////////////////////////
//  code by Boondorl  //////////////////////////////////////////////////////////
class FlamethrowerProjectile : FastMissile {
	Default {
		Radius 36.5;
		Height 60;
		FastMissile.RadiusScale 0.1;
		FastMissile.HeightScale 0.1;
		FastMissile.RadiusScaleFactor 0.03;
		FastMissile.HeightScaleFactor 0.03;
		
		FastMissile.DOTType "BurnDOT";
		
		Scale 0.95;
		FastMissile.XScaleFactor 0.03;
		FastMissile.YScaleFactor 0.03;
		
		DamageFunction 10;
		DamageType "Fire";
		Speed 24;
		RenderStyle "Add";
		Alpha 0.75;
		SeeSound "weapons/flamethrower";
		Obituary "$OB_MPFLAMETHROWER"; // "%o was barbecued by %k."
		Decal "Scorch";
		
		+FORCEXYBILLBOARD
		+NOBLOOD
		//+PAINLESS
		+FASTMISSILE.HITONCE
	}
	
	States {
		Spawn:
			BNG3 AB 3 Bright;
            //FRBL C 3 Bright;
			Loop;
			
		Death:
			TNT1 A 0 A_AlertMonsters();
            BNG3 D 5 Bright A_AreaOfEffect("FireAoE", 12);
            BNG3 EFGH 5 Bright A_Splash(32, radius*2, XF_NOSPLASH);
            Stop;
			
	}
	
	override void CustomEffect() {
		alpha -= min(0.02, alpha);
	}
}
class BurnDOT : CustomDOT {
	Default {
		DamageType "Fire";
		CustomDOT.EffectRate 4;
		CustomDOT.EffectActor "FlameEffect";
		Inventory.MaxAmount 7;
		DamageFunction 5;
		
		//+PAINLESS
	}
}
class FlameEffect : DOTEffect {
	Default
	{
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.9;
		
		+DOTEFFECT.NOWARP
	}
	
	States {
		Spawn:
			FLBE ABCDEFGHIJK 2 Bright;
			Stop;
	}
	
	override void Effect() {
		scale.x -= min(0.01, scale.x);
		scale.y -= min(0.01, scale.y);
	}
}
class FireAoE : AoE {
	static const String noSpawn[] = {
		"FWATER1", "FWATER2", "FWATER3", "FWATER4",
		"BLOOD1", "BLOOD2", "BLOOD3"
	};
	
	Default {
		Radius 16;
		Height 24;
		DamageFunction 5;
		DamageType "Fire";
		
		AoE.DOTType "BurnDOT";
		AoE.EffectRate 4;
		AoE.EffectActor "GroundFireFlame";
		
		//+PAINLESS
		+AOE.NOLIQUIDS
	}
	
	States {
		Spawn:
			TNT1 A 70;
			Stop;
	}
	
	override void BeginPlay() {
		super.BeginPlay();
		
		TextureID offLimits;
		for (int i = 0; i < noSpawn.Size(); ++i) {
			offLimits = TexMan.CheckForTexture(noSpawn[i], TexMan.Type_Flat);
			if (floorpic == offLimits) {
				Destroy();
				return;
			}
		}
	}
}
class GroundFireFlame : Actor {
	Default {
		RenderStyle "Add";
		Alpha 0.4;
		Scale 0.95;
		
		//+NOINTERACTION
	}
	
	States {
		Spawn:
			FLBE ABCDEFGHIJK 2 Bright;
			Stop;
	}
	
	override void Tick() {
		super.Tick();
		
		if (bDestroyed || IsFrozen())
			return;
		
		scale.x -= min(0.02, scale.x);
		scale.y -= min(0.02, scale.y);
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
class wosFlamethrower : FlameThrower replaces FlameThrower
{
	Default
	{
		//$Category "Weapons"
		//$Title "zsc Flamethrower"
	
		inventory.icon "H_FLMR";
		Tag "$T_FLAMER";
		Inventory.PickupMessage  "$F_FLAMER";
		
		
		radius 12;
		height 16;
	}
	
	States
	{
		Spawn:
			FLAM A -1;
			Stop;			
	
		Ready:
			FLMT A 3
			{
				A_WeaponReady(WRF_ALLOWUSER1);
				A_WeaponOffset(CallACS("Script_GetGunOffsetX"));
			}
			FLMT B 3
			{
				A_WeaponReady(WRF_ALLOWUSER1);
				A_WeaponOffset(CallACS("Script_GetGunOffsetX"));
			}
			Loop;
		
		Deselect:
			FLMT A 1 A_Lower();
			Loop;
		Select:
			FLMT A 1 A_Raise();
			Loop;
		Fire:
			FLMF A 2 A_FireFlamer();
			FLMF B 3 A_ReFire();
			Goto Ready;
		Spawn:
			FLAM A -1;
			Stop;
			
	}
}*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////