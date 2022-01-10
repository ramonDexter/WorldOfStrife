const grenadeExplosiveWeight = 2;
const grenadeFireWeight = 3;
const grenadeGasWeight = 3;
//  inventory bar  grenades  ///////////////////////////////////////////////////

// explosive ///////////////////////////////////////////////////////////////////
class wosGrenadeE : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Grenade Explosive THRW"
		+inventory.invbar
		//+inventory.alwayspickup
		//+countitem
		
		Tag "$T_GRENADEEXPL";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$F_GRENADEEXPL";
		Inventory.Icon "I_GEXP";
		Mass grenadeExplosiveWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_ThrowGrenade("wosGrenadeE_Throw", 8, 12, 6);
			Stop;
	}
}
class wosgrenadeE_3 : Custominventory {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Grenade Explosive THRW 3x"
		Tag "Explosive Grenades";
		radius 10;
		height 10;
		-inventory.invbar
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_Giveinventory("wosGrenadeE", 3);
			Stop;
	}
}
class wosGrenadeE_Throw : HEGrenade {
	Default {
		SeeSound "weapons/grenadeThrow";
		BounceSound "weapons/grenadeBounce";
	}
}
// fire ////////////////////////////////////////////////////////////////////////
class wosGrenadeF : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Grenade Fire THRW"
		+inventory.invbar
		//+inventory.alwayspickup
		//+countitem
		
		Tag "$T_GRENADEFIRE";
		Inventory.PickupSound "misc/p_pkup";
		Inventory.PickupMessage "$F_GRENADEFIRE";
		Inventory.Icon "I_GFIR";
		Mass grenadeFireWeight;
	}	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_ThrowGrenade("wosgrenadeF_Throw", 8, 12, 6);
			Stop;			
	}
}
class wosgrenadeF_3 : Custominventory {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Grenade Fire THRW 3x"
		Tag "Fire Grenades";
		radius 10;
		height 10;
		-inventory.invbar
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_Giveinventory("wosGrenadeF", 3);
			Stop;
	}
}
class wosgrenadeF_Throw : PhosphorousGrenade {
	Default {
		SeeSound "weapons/grenadeThrow";
		BounceSound "weapons/grenadeBounce";
	}
}

// gas /////////////////////////////////////////////////////////////////////////
class wosGrenadeG : wosPickup {
    Default {
        //$Category "Ammunition/WoS"
        //$Title "Gas Grenade"
        +inventory.INVBAR
        +inventory.alwayspickup
        Tag "$T_grenadeGas";
        Inventory.pickupmessage "$F_grenadeGas";
        Inventory.icon "I_GGAS";
		Mass grenadeGasWeight;
    }
	
	States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 A_ThrowGrenade("wosgrenadeG_Throw", 8, 12, 6);
            Stop;
	}
}
class wosgrenadeG_3 : Custominventory {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Grenade Gas THRW 3x"
		Tag "Gas Grenades";
		radius 10;
		height 10;
		-inventory.invbar
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Pickup:
			TNT1 A 0 A_Giveinventory("wosGrenadeG", 3);
			Stop;
	}
}
class wosgrenadeG_Throw : zscHEGrenade {
    Default {
		Speed 15;
		Radius 13;
		Height 13;
		Mass 20;
		Damage 1;
		ReactionTime 70;
		Projectile;
		-NOGRAVITY
		+STRIFEDAMAGE
		+BOUNCEONACTORS
		+EXPLODEONWATER
		MaxStepHeight 4;
		BounceType "Doom";
		BounceFactor 0.5;
		BounceCount 3;
		//SeeSound "weapons/hegrenadeshoot";
		SeeSound "weapons/grenadeThrow";
		BounceSound "weapons/grenadeBounce";
		DeathSound "weapons/hegrenadebang";
		Obituary "$OB_MPSTRIFEGRENADE"; // "%o was inverted by %k's H-E grenade."
	
    }
	
	States
	{
		Spawn:
			GASG BBBBCCCC 1 { 
				A_Countdown();
				A_SetPitch(pitch-20);
			}
			Loop;
		Death:
			MISL BCD 4 Bright A_Explode(20,32);
			GASC ABCD 2 Bright;
			TNT1 A 0 A_SpawnItemEx("ToxinCloud", 0, 0, 8);
			GASC EFGH 2 Bright;
			TNT1 A 0 A_SpawnItemEx("ToxinCloud", 0, 0, 8);
			Stop;
	}
}
class ToxinCloud : actor {
    Default {
        -SOLID
        -SHOOTABLE
        -ACTIVATEMCROSS
        -COUNTKILL
        +NOTELEPORT
        +THRUGHOST
        +DROPOFF
        +LOWGRAVITY
        +NODAMAGETHRUST
        Projectile;
        Radius 0;
        Height 48;
        ExplosionDamage 5;
        ExplosionRadius 42;
        RENDERSTYLE "translucent";
        ReactionTime 20;
        ALPHA 0.5;
        Seesound "weapons/poof1";
    }
   
    States {
        Spawn:
            GGAS ABCDEFGFD 5 A_Explode();
            GGAS A 0 A_Countdown();
            //goto Spawn+2;
        Death:
            GGAS C 5 A_FadeOut(0.20);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS D 5 A_FadeOut(0.10);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS E 5 A_FadeOut(0.20);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS F 5 A_FadeOut(0.10);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS G 5 A_FadeOut(0.20);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS F 5 A_FadeOut(0.10);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS E 5 A_FadeOut(0.20);
            GGAS C 0 A_Explode(10, 64, XF_NOTMISSILE|XF_NOSPLASH, false);
            GGAS D 5 A_FadeOut(0.10);
            loop;
    }
}
////////////////////////////////////////////////////////////////////////////////
