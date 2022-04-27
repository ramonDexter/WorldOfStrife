const executorRifleWeight = 150;

class magazine_executorRifle : ammo {
    Default {
        +INVENTORY.IGNORESKILL
        inventory.maxamount 32;
        Mass 0;
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
        weapon.ammoType1 "magazine_executorRifle";
        weapon.ammoUse1 1;
        weapon.ammoGive1 0;
        weapon.ammoType2 "ClipOfBullets";
        weapon.ammoUse2 0;
        weapon.ammoGive2 32;
        Mass executorRifleWeight;
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
            ERMD C 2 W_ShootFireArm(8, "weapons/execRiflShoot");
            ERMD D 2;
            TNT1 A 0 {
                ZWL_EjectCasing(
					"rifleCasing",//class<Actor> casingType
					false,//bool left
					-45,//double ejectPitch
					frandom(4,4.5),//double speed,
					8,//double accuracy
					(24, 16, -10)//Vector3 offset
				);
            }
            ERMD E 1 A_Refire();
            goto Ready;

        Reload:
			TNT1 A 0 W_reloadCheck();
			goto Ready;
		DoReload:
            ERMD B 2;
            ERMD E 3;
            ERMD F 2;
            ERMD G 2 A_StartSound("weapons/RLpistolRLout", 1);
            ERMD HI 2;
            ERMD J 8;
            TNT1 A 16 {
                //A_StartSound("weapons/RLpistolRLin", 1);
                W_reload();
            }
            ERMD J 8;
            ERMD IH 2;
            ERMD G 2 A_StartSound("weapons/RLpistolRLin", 1);
            ERMD F 3;
            ERMD B 1;
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
