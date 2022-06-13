////////////////////////////////////////////////////////////////////////////////
//  interceptor drone  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//const interceptorDroneWeight = 35;

////////////////////////////////////////////////////////////////////////////////
class wosInterceptorDrone : wosPickup {
    Default {
		//$Category "Powerups/WoS"
		//$Title "Interceptor Drone"
		
        +inventory.INVBAR
		+inventory.alwayspickup
		+FLOORCLIP		
		
		Tag "$T_interceptorDrone";
		Inventory.PickupMessage "$F_interceptorDrone";
		Inventory.Icon "I_SPDR";
		Mass interceptorDroneWeight;
    }

    States {
        Spawn:
            DUMM A -1;
            Stop;
        Use:
            TNT1 A 0 A_ThrowGrenade("interceptorDrone_Set", 4, 8, 3, 0);
            Stop;
    }
}
class interceptorDrone_Set : actor {
    Default {
        +DROPOFF
        +CANBOUNCEWATER
        +Missile

        DontHurtShooter;
        Radius 4;
        Height 4;
        Speed 15;
    }

    States {
        Spawn:
            DUMM A 1;
            Loop;
        Death:
            DUMM A 1;
            TNT1 A 0 A_SpawnItemEx("interceptorDrone", 1, 0, 4, 0, 0, 1.5);
            Stop;
    }
}

class interceptorDrone : actor {
	int droneCount;	

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
        +NOGRAVITY
		+SPAWNFLOAT
		+FLOAT

        Tag "$T_interceptorDrone";
        Monster;
		Species "interceptorDrone";
		Mass 50;
        Health 100;
        Radius 2;
        height 2;
        Speed 8;
        MinMissileChance 16;
        MaxTargetRange 768;
		ActiveSound "sounds/spyDroneAct";

    }

    States {
        Spawn:            
			TNT1 A 0 {
				A_StartSound("sounds/spyDroneAct", 0, CHANF_LOOPING, 1.0);
				self.droneCount++;				
				if(self.droneCount == 350) {
					self.droneCount = 0;
					return ResolveState("Death");
				}
				return ResolveState(null);
			}
            DUMM A 4 A_Look2();
            Loop;
        See:
			TNT1 A 0 {
				self.droneCount++;
				
				if(self.droneCount == 350) {
					self.droneCount = 0;
					return ResolveState("Death");
				}
				return ResolveState(null);
			}
            DUMM AA 2 A_Wander();
            DUMM AA 2 A_Chase();
            Loop;
        Missile:
            DUMM A 4 A_FaceTarget();
            DUMM A 3 Bright A_SpawnProjectile("interceptorDrone_tracer");
            DUMM A 2 Bright;
            DUMM A 4 ;
            DUMM A 4 A_MonsterRefire(130, "See");
            goto Spawn;
        Death:
            TNT1 A 0;
            DUMM AA 2;
            TNT1 A 0 A_StartSound("FTRSET", 0);
            DUMM AA 2;
            DUMM AAA 5;
            TNT1 A 0;
            TNT1 A 0 A_SpawnItemEx("FlmTurretExplosion",0,0,5,0,0,0,0,32);
            Stop;
    }
}
class interceptorDrone_tracer : BlasterTracer {
	Default { Damage 8; }
}
