class executorRifleMagazine : ammo {
    Default {
        +INVENTORY.IGNORESKILL
        inventory.maxamount 24;
    }
}

class executorRifle : wosWeapon {

    Default {
		//$Category "weapons"
		//$Title "Executor Rifle (weapon)"
        +WEAPON.AMMO_OPTIONAL
        +FLOORCLIP

        radius 24;
        height 16;

        Tag "Executor Rifle ER-15";
        Inventory.PickupMessage "You picked up the Executor Rifle!";
        obituary "%o was drilled full of holes by %k's executor rifle.";
        inventory.icon "H_ERMD";
        weapon.SelectionOrder 600;
        weapon.SlotNumber 3;
		Weapon.SlotPriority 2;
        weapon.kickBack 40;
        weapon.ammoType1 "executorRifleMagazine";
        weapon.ammoUse1 1;
        weapon.ammoGive1 0;
        weapon.ammoType2 "ClipOfBullets";
        weapon.ammoUse2 0;
        weapon.ammoGive2 24;
    }
	
    States {
        Spawn:
            ERMP A -1;
            Stop;
			
		Nope:
			TNT1 A 1 {
				A_WeaponReady(WRF_NOFIRE); 
				A_ZoomFactor(1.0);
			}
			//TNT1 A 0 B_NoReFire();
			TNT1 A 0 A_ClearReFire();
			Goto Ready;

        Select:
            ERMD B 1 A_Raise();
            Loop;

        Deselect:
            ERMD B 1 A_Lower();
            Loop;

        Ready:
            ERMD B 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1|WRF_ALLOWUSER4);
            Loop;

        Fire:
            ERMD B 1 A_JumpIfNoAmmo("Reload");
            ERMD C 5 W_ShootFireArm(8, "weapons/execRiflShoot");		
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,2,AAPTR_PLAYER1);
			TNT1 A 0 A_SpawnItemEx("Casing9mm",random(3,4),cos(pitch)*-25,sin(-pitch)*25+random(31,32),	random(1,3),0,random(4,6), random(-80,-90),0, SXF_ABSOLUTEMOMENTUM);
            ERMD D 3;
            ERMD E 6 A_Refire();
            goto Ready;

        Reload:
			TNT1 A 0 W_reloadCheck();
			goto Ready;
		DoReload:
            ERMD E 5;
            ERMD F 2;
            ERMD G 2;
            ERMD H 3;
            ERMD I 4;
            ERMD J 4 A_StartSound("weapons/RLpistolRLout", 1);
            ERMD K 5;
            ERMD L 5;
            ERMD M 5;
            ERMD N 5;
            ERMD M 5;
            ERMD L 5;
            ERMD K 5;
            ERMD J 5 A_StartSound("weapons/RLpistolRLin", 1);
			TNT1 A 0 W_reload();
            ERMD I 4;
            ERMD H 3;
            ERMD GF 2;
            ERMD E 5;
            goto Ready;
    }
}
/*
class executorRifle_ground01 : CustomInventory {
	Default {
		//$Category "weapons"
		//$Title "Executor Rifle (ground1)"
	}
	
	States {
		Spawn:
			ERMP A -1;
			Stop;
	}
}
class executorRifle_ground02 : executorRifle {
	Default {
		//$Category "weapons"
		//$Title "Executor Rifle (ground2)"
	}
	
	States {
		Spawn:
			ERMP B -1;
			Stop;
	}
}
class executorRifle_standing : executorRifle {
	Default {
		//$Category "weapons"
		//$Title "Executor Rifle (standing)"
	}
	
	States {
		Spawn:
			ERMP C -1;
			Stop;
	}
}
*/

//dummy actors
