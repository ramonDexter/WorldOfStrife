/*
sprites:
	- breadbagfly
	- strife hand
coding:
	- hookshot base: jpalomo

ZSCRIPT
//==----------------------------------------------------------
weapon: hookShotWeapon
ammo: hookShot_Ammo 
//==----------------------------------------------------------
*/

//==----------------------------------------------------------
//weapon
//==----------------------------------------------------------
class hookShotWeapon : augmentedWeapon 
{

    int hookLoaded;
	
    Default
    {
		//$Category "weapons"
		//$Title "hookShot"
        +Weapon.Ammo_Optional
		+Weapon.NoAutoAim
		+WEAPON.CHEATNOTWEAPON
		

        Tag "$T_HOOKSHOT";
	
        Weapon.slotnumber 9;
        Weapon.slotPriority 0;;
        Weapon.AmmoUse1 1;
        Weapon.AmmoGive1 0;
        Weapon.AmmoType1 "hookShot_magazine";
        Weapon.AmmoUse2 0;
        Weapon.AmmoGive2 0;
        Weapon.AmmoType2 "hookShot_Ammo";
        
        Inventory.Icon "H_HKST";
        Inventory.PickupMessage "$F_HOOKSHOT";
    }	
	
	States
	{
		Spawn:
			HKST V -1;
			Stop;
		Ready:
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 1, "LoadedReady");
			TNT1 A 0 A_JumpIfNoAmmo("Reload");
			HKST G 2 
			{
				A_WeaponReady(WRF_ALLOWRELOAD);
				A_WeaponOffset(CallACS("Script_GetGunOffsetX"));
			}
			Loop;
        LoadedReady:
            HKST A 8 A_WeaponReady(WRF_ALLOWRELOAD);
            Loop;            
		Select:
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 1, "LoadedSelect");
			HKST G 1 A_Raise;
			Loop;
        LoadedSelect:
			HKST A 1 A_Raise;
			Loop;
		Deselect:
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 1, "LoadedDeselect");
			HKST G 1 A_Lower;
			Loop;
        LoadedDeselect:
			HKST A 1 A_Lower;
			Loop;
        Fire:
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 1, "RealFire");
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 0, "AltFire");
            TNT1 A 0 A_JumpIfNoAmmo("Reload");
        AltFire:
            TNT1 A 0 A_JumpIf(invoker.hookLoaded == 1, "RealFire");
            HKST GHIJKLM 1;
            HKST A 1;
            TNT1 A 0 
            {
                invoker.hookLoaded = 1;
            }
            goto LoadedReady;
		RealFire:
			HKST A 1;
			HKST B 2 Bright A_FireProjectile("HookShot", 0, 1, 0, 0, FPF_NOAUTOAIM, 0);
			HKST CD 1 Bright;
			HKST EFG 1;
            TNT1 A 0
            {
                invoker.hookLoaded = 0;
            }
            goto Ready;
        					  
        ReloadFinish:
            HKSR ABCDEFG 4;
            HKSR HIJKLM 2;
            HKSL ABCDEFG 4;
            Goto LoadedReady;
	}
}
//==----------------------------------------------------------
//ammunition
//==----------------------------------------------------------
class hookShot_magazine : ammo
{
    Default    
    {
        Inventory.MaxAmount 10;
        +Inventory.IGNORESKILL;
    }
}
class hookShot_Ammo : ammo 
{
    Default
    {
        //$Category "SoA/items/Ammunition"
        //$color 14
        //$Title "hookShot Ammo"

        -SOLID;
        +SHOOTABLE;
        +NODAMAGE;
        +NOBLOOD;
        +CANPASS;	

        Tag "$T_HOOKSHOTAMMO";

        Inventory.Amount 10;
        Inventory.MaxAmount 50;
        Ammo.BackpackAmount 50;
        Ammo.BackpackMaxAmount 50;
        Inventory.Icon "I_USTC";
        Inventory.PickupMessage "$REDBATFND";

    }

    States
    {
        Spawn:
            HKSA V -1;
            Stop;
    }

}
//==----------------------------------------------------------
//projectile
//==----------------------------------------------------------
class HookShot : FastProjectile
{
	Default
    {
        
        +HitTracer;
        +PainLess;

        MissileHeight 8;
        MissileType "hookRail";
        Height 14;
        Radius 10;
        Projectile;
        MaxTargetRange 10;
        MaxStepHeight 4;
        SeeSound "hookshot/fire";
        ActiveSound "hookshot/swish";
        Speed 60;
        Damage 0;
    }    

	States
	{
		// The limited duration is intended to limit the range of the shot
		Spawn:
			HSKT AAAAAAAAAA 2 A_StartSound ("hookshot/loop", CHAN_BODY);
			Stop;
		Crash:
			HSKD A 0 A_StartSound ("hookshot/hit/terrain", 0);
			Goto RealDeath;
		XDeath:
			HSKD A 0 A_StartSound ("hookshot/hit/flesh", 0);
			Goto RealDeath;
		RealDeath:
			HSKD A 0 ACS_NamedExecuteAlways("Hook_HitEnemy", 0, 0, 0, 0);
			HSKD A 16;
			Stop;
		Death:
			HSKD A 0 A_StartSound ("hookshot/hit/terrain", 0);
			HSKD A 0 ACS_NamedExecuteAlways("Hook_HitWall", 0, 0, 0, 0);
			HSKD A 16;
			Stop;
	}
}
class hookRail : actor
{
	Default
	{
		+NOBLOCKMAP
		+NOGRAVITY
	}
	
	States
	{
		Spawn:
			HKRL A 20;
			Stop;
	}
}
//==----------------------------------------------------------