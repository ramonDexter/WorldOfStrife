const CrossbowBaseWeight = 85;

class wosStrifeXbow : wosWeapon replaces StrifeCrossbow
{
    bool xbowSwitch;

    Default
    {
		//$Category "weapons/WoS"
		//$Title "zsc crossbow"
        +FLOORCLIP
		+WEAPON.NOALERT
		+WEAPON.NOAUTOAIM
				
		radius 12;
		height 16;
		
		Weapon.Slotnumber 2;
		Weapon.SlotPriority 0.2;
        //Weapon.SelectionOrder 1200;        
        Weapon.AmmoUse1 0;
        Weapon.AmmoGive1 12;
        Weapon.AmmoType1 "ElectricBolts";
        Weapon.AmmoUse2 0;
        Weapon.AmmoGive2 4;
        Weapon.AmmoType2 "PoisonBolts";
        Inventory.PickupMessage "$F_CROSSBOW"; // "You picked up the crossbow"
        Tag "$T_CROSSBOW"; // "Crossbow"
        Inventory.Icon "H_XBOW";
		Mass CrossbowBaseWeight;
        Weapon.UpSound "weapons/weaponUP";
    }

    States
    {
        Spawn:
            DUMM A -1;
            Stop;

        Ready:
			TNT1 A 0
			{
				if(invoker.xbowSwitch == 1) { return ResolveState("PoisonReady"); }
				if(invoker.xbowSwitch == 0) { return ResolveState("ElectricReady"); }
				return ResolveState(null);
			}
        ElectricReady:
			XBOW A 0;
            XBOW A 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
            Loop;
			
        PoisonReady:
			XBOW A 0;
            XBOW H 1 A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
            Loop;
			
        AltFire:
			TNT1 A 0
			{
				if(invoker.xbowSwitch == 1) { return ResolveState("SetElectric"); }
				if(invoker.xbowSwitch == 0) { return ResolveState("SetPoison"); }
				return ResolveState(null);
			}

        SetElectric:
            TNT1 A 0
            {
                invoker.xbowSwitch = 0;
				//self.bNOALERT = false;
            }
            XBOW F 5;
            XBOW G 5;
            XBOW A 5 A_CheckReload();
            goto ElectricReady;

        SetPoison:
			TNT1 A 0
			{
				if(CountInv("PoisonBolts") < 1) {return ResolveState("SetElectric");}
				return ResolveState(null);
			}
            TNT1 A 0
            {
                invoker.xbowSwitch = 1;
				//self.bNOALERT = true;
            }
            XBOW IJH 5;
            goto PoisonReady;
        
        Fire:
			TNT1 A 0
			{
				if(invoker.xbowSwitch == 1) { return ResolveState("PoisonFire"); }
				if(invoker.xbowSwitch == 0) { return ResolveState("ElectricFire"); }
				return ResolveState(null);
			}

        ElectricFire:
            XBOW A 3;
            XBOW B 6 
            {
                W_ShootArrow("ElectricBolt");
                A_TakeInventory("ElectricBolts", 1);
            }
            XBOW C 4;
            XBOW D 6;
            XBOW E 3;
            XBOW F 5;
            XBOW G 0;
            XBOW G 5 A_CheckReload();
            goto ElectricReady+1;

        PoisonFire:
			TNT1 A 0
			{
				if(CountInv("PoisonBolts") < 1) {return ResolveState("ElectricFire");}
				return ResolveState(null);
			}
            XBOW H 3;
            XBOW B 6 
            {
                W_ShootArrow("PoisonBolt");
                A_TakeInventory("PoisonBolts", 1);

            }
			TNT1 A 0
			{
				if(CountInv("PoisonBolts") < 1) {return ResolveState("SetElectric");}
				return ResolveState(null);
			}
            XBOW C 4;
            XBOW D 6;
            XBOW E 3;
            XBOW I 5;
            XBOW J 0;
            XBOW J 5 A_CheckReload();
            goto PoisonReady;

        Select:
			TNT1 A 0
			{
				if(invoker.xbowSwitch == 1) { return ResolveState("SelectPoison"); }
				if(invoker.xbowSwitch == 0) { return ResolveState("SelectElectric"); }
				return ResolveState(null);
			}
        
        SelectElectric:			
            XBOW A 1 A_Raise();
			XBOW A 0 A_Raise();
            Loop;
        SelectPoison:
            XBOW H 1 A_Raise();
			XBOW H 0 A_Raise();
            Loop;

        Deselect:
			TNT1 A 0
			{
				if(invoker.xbowSwitch == 1) { return ResolveState("DeselectPoison"); }
				if(invoker.xbowSwitch == 0) { return ResolveState("DeselectElectric"); }
				return ResolveState(null);
			}
        
        DeselectElectric:
			XBOW A 0 A_Lower();
            XBOW A 1 A_Lower();
            Loop;
        DeselectPoison:
			XBOW H 0 A_Lower();
            XBOW H 1 A_Lower();
            Loop;
		Flash:
			Stop;
			
		AmmoDepleted:
			TNT1 A 0 A_SelectWeapon("wosPunchDagger");
			Stop;
			
		
    }
}

class zscElectricBolt : Actor {
	Default {
		+STRIFEDAMAGE
		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		-SEEKERMISSILE
		Speed 30;
		Radius 10;
		Height 10;
		Damage 10;
		Projectile;
		MaxStepHeight 4;
		SeeSound "misc/swish";
		ActiveSound "misc/swish";
		DeathSound "weapons/xbowhit";
		Obituary "$OB_MPELECTRICBOLT";
	}
	States {
		Spawn:
			AROW A 10 A_LoopActiveSound;
			Loop;
		Death:
			ZAP1 A 3 A_AlertMonsters;
			ZAP1 BCDEFE 3;
			ZAP1 DCB 2;
			ZAP1 A 1;
			Stop;
	}
}
class zscPoisonBolt : Actor {
	Default {
		+STRIFEDAMAGE
		-SEEKERMISSILE
		Speed 30;
		Radius 10;
		Height 10;
		Damage 500;
		Projectile;
		MaxStepHeight 4;
		SeeSound "misc/swish";
		ActiveSound "misc/swish";
		Obituary "$OB_MPPOISONBOLT";
	}
	States {
		Spawn:
			ARWP A 10 A_LoopActiveSound;
			Loop;
		Death:
			AROW A 1;
			Stop;
	}
	
	override int DoSpecialDamage (Actor target, int damage, Name damagetype) {
		if (target.bNoBlood) {
			return -1;
		}
		if (target.health < 1000000) {
			if (!target.bBoss)			
				return target.health + 10;
			else
				return 50;
		}
		return 1;
	}
}

class wosStrifeXbow2 : StrifeCrossbow2 replaces StrifeCrossbow2 {
	Default {
		+WEAPON.CHEATNOTWEAPON			
	}
}