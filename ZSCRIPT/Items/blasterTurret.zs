////////////////////////////////////////////////////////////////////////////////
//  blaster turret  ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
--------------------------------------------------------------------------------
blaster turret
--------------------------------------------------------------------------------
credits:
sprites: Mor'ladim, Raven Software, raon.dexter
voxels: ramon.dexter
sounds: Mor'ladim, Tormentor667
zscript: ramon.dexter

- inspired by flame turret from realm667 by Mor'ladim
--------------------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////
const blasterTurretWeight = 150;

class wosBlasterTurret : wosPickup {
    Default {
		//$Category "Powerups/WoS"
		//$Title "Blaster Turret"
		
        +inventory.INVBAR;
		+inventory.alwayspickup;
		+FLOORCLIP;
		
		Tag "Mauler Turret";
		Inventory.PickupMessage "You picked up the Blaster Turret.";
		Inventory.Icon "I_STTR";		
		radius 10;
		height 10;		
		Mass blasterTurretWeight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 A_ThrowGrenade("blasterTurretSet", 4, 8, 3, 0);
            Stop;
    }
}
//turret spawner----------------------------------------------------------------
class blasterTurretSet : actor {
    Default {
        +DROPOFF
        +CANBOUNCEWATER
        +Missile

        Tag "Mauler Turret";
        DontHurtShooter;
        Radius 10;
        Height 8;
        Speed 15;
    }

    States {
        Spawn:
            DUMM A 1;
            Loop;
        Death:
            DUMM A 1;
            TNT1 A 0 A_SpawnItemEx("Blaster_turret",1,0,0);
            Stop;
    }
}
//turret actor with aggresive behavior------------------------------------------
class Blaster_turret : actor {
	int turretCount;	

    Default {
        +INCOMBAT
        +FRIENDLY
	    +DontThrust
	    +LOOKALLAROUND
	    +NOBLOOD
	    +NOTARGET
	    +NOINFIGHTING
	    +NOFEAR
	    +DONTMORPH
	    +NOICEDEATH

        Tag "Blaster Turret";
        Monster;
		Species "blasterTurret";
        Health 160;
        Radius 10;
        height 56;
        Speed 0;
        MinMissileChance 16;
        MaxTargetRange 768;

    }

    States {
        Spawn:
            DUMM A 2;
            DUMM A 0 A_StartSound("FTRSET", 0);
            DUMM BCDE 4;
        Spawned:
			TNT1 A 0 {
				self.turretCount++;				
				if(self.turretCount == 350) {  //lifespan limited to 350 tics == 10 secs
					self.turretCount = 0;
					return ResolveState("Death");
				}
				return ResolveState(null);
			}
            DUMM E 4 A_Look();
            Loop;
        See:
			TNT1 A 0 {
				self.turretCount++;				
				if(self.turretCount == 350) {
					self.turretCount = 0;
					return ResolveState("Death");
				}
				return ResolveState(null);
			}
            DUMM E 2 A_Chase();
            Loop;
        Missile:
            DUMM E 4 A_FaceTarget();
            DUMM F 3 Bright A_SpawnProjectile("blasterTurret_tracer");
            DUMM F 2 Bright;
            DUMM E 4 ;
            DUMM E 4 A_MonsterRefire(130, "See");
            goto Spawned;
        Death:
            TNT1 A 0;
            DUMM ED 2;
            TNT1 A 0 A_StartSound("FTRSET", 0);
            DUMM CB 2;
            DUMM AAA 5;
            TNT1 A 0;
            TNT1 A 0 A_SpawnItemEx("FlmTurretExplosion",0,0,5,0,0,0,0,32);
            Stop;
    }
}
//turret projectile-------------------------------------------------------------
class blasterTurret_tracer : BlasterTracer {
	Default {
		Damage 8;
	}
}
//------------------------------------------------------------------------------