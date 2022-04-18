//  item weights  //////////////////////////////////////////////////////////////
const elBoltsQwWeight = 24;
const posBoltsQwWeight = 12;
const elBoltsBndlWeight = 10;
const posBoltsBndlWeight = 5;
const energyPodWeight = 5;
const energyKitWeight = 10;
const energyPackWeight = 20;
const boxOfBulletsWeight = 20;
const bulletCartridgeWeight = 5;
const miniMissileBndlWeight = 25;
const heGRboxWeight = 35;
const fireGRboxWeight = 35;
const ammoSatchelWeight = 50;
const ammoBandolierWeight = 50;
////////////////////////////////////////////////////////////////////////////////

/*class wosAmmo : Ammo {
	int magStack;
	property magazineAmount : magStack;

	Default {
		Inventory.Amount 1;
		Inventory.MaxAmount 9999;
		Mass 0;
		-INVENTORY.INVBAR;
		-INVENTORY.KEEPDEPLETED;
	}

	override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.encumbrance+=self.mass;
    }
    override void DoEffect() {
        super.DoEffect();
        let pawn = binderPlayer(owner);
        if (onlyone==0) {
            pawn.encumbrance+=self.mass*self.amount;
        }
        else {
            pawn.encumbrance+=self.mass;
        }
    }
    override void OnDrop (Actor dropper) {
        if (self.stack>0) {
            let whatto = self.GetClassName();
            int todrop = dropper.CountInv(whatto);
            if (todrop>self.stack-1) {
                todrop = self.stack - 1;
            }
            dropper.takeInventory(self.GetClassName(), todrop);
            self.amount = todrop + 1;
            super.OnDrop(dropper);
        }
    }
	Override Class<Ammo> GetParentAmmo()
	{
		class<Object> type = GetClass();

		while (type.GetParentClass() != "wosAmmo" && type.GetParentClass() != NULL)
		{
			type = type.GetParentClass();
		}
		return (class<wosAmmo>)(type);
	}
	Override bool HandlePickup(Inventory item)
	{
		let ammoitem = wosAmmo(item);
		if (ammoitem != null && ammoitem.GetParentAmmo() == GetClass())
		{
			if (Amount < MaxAmount || sv_unlimited_pickup)
			{
				int receiving = item.Amount;

				if (!item.bIgnoreSkill)
				{
					receiving = int(receiving * G_SkillPropertyFloat(SKILLP_AmmoFactor));
				}
				int oldamount = Amount;

				if (Amount > 0 && Amount + receiving < 0)
				{
					Amount = 0x7fffffff;
				}
				else
				{
					Amount += receiving;
				}
				if (Amount > MaxAmount && !sv_unlimited_pickup)
				{
					Amount = MaxAmount;
				}
				item.bPickupGood = true;
				if (oldamount == 0 && Owner != null && Owner.player != null)
				{
					PlayerPawn(Owner).CheckWeaponSwitch(GetClass());
				}
			}
			return true;
		}
		return false;
	}
}*/

class wosBoltsElectric : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Quirell of electric bolts (item)"
		+INVENTORY.INVBAR
		
		radius 10;
		height 16;
		Tag "$T_ELEBOLTS";
		inventory.icon "I_EQRL";
		Inventory.PickupMessage "$F_ELEBOLTS";
		Mass elBoltsQwWeight;
	}
	
	States {
		Spawn:
			XQRL A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("ElectricBolts", 24);
			Stop;
	}
}

class wosBoltsPoison : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Quirell of electric bolts (item)"
		+INVENTORY.INVBAR
		
		Tag "$T_POISONBOLTS";
		inventory.icon "I_POQR";
		Inventory.PickupMessage "$F_POISONBOLTS";
		Mass posBoltsQwWeight;
	}
	
	States {
		Spawn:
			PQRL A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("PoisonBolts", 12);
			Stop;
	}
}
class wosBundlePoison : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Poison bolt bundle"
		
		+INVENTORY.INVBAR
		
		Tag "Poison bolt bundle";
		Inventory.Icon "I_MPAR";
		Inventory.PickupMessage "You picked up the poison bolt bundle!";
		Scale 1.2;
		Mass posBoltsBndlWeight;
	}
	
	States {
		Spawn:
			MPAR A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("ElectricBolts", 5);
			Stop;
	}
}
class wosBundleElectric : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Electric bolt bundle"
		
		+INVENTORY.INVBAR
		
		Tag "Electric bolt bundle";
		Inventory.Icon "I_MEAR";
		Inventory.PickupMessage "You picked up the electric bolt bundle!";
		Scale 1.2;
		Mass elBoltsBndlWeight;
	}
	
	States {
		Spawn:
			MEAR A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("ElectricBolts", 10);
			Stop;
	}
}

class wosBulletsBox : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Box of bullets (item)"
		+INVENTORY.INVBAR
		
		radius 10;
		height 10;
		Tag "$T_BOXOFBULLETS";
		inventory.icon "I_BBOX";
		Inventory.PickupMessage "$F_BOXOFBULLETS";
		Mass boxOfBulletsWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("ClipOfBullets", 50);
			Stop;
	}
}

class wosEnergyPod : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Energy Pod (item)"
		+INVENTORY.INVBAR
		
		//scale 0.7;
		radius 10;
		height 16;
		Tag "$T_ENERGYPOD";
		inventory.icon "I_BRYI";
		Inventory.PickupMessage "$F_ENERGYPOD";
		Mass energyPodWeight;
	
	}
	
	States {
		Spawn:
			DUMM AAABB 6;
			Loop;
		Use:
			TNT1 A 0 A_GiveInventory("EnergyPod", 20);
			Stop;	
	}
}
/*
class energyPodPack_item : wosPickup
{
	Default
	{
		//$Category "Ammunition"
		//$Title "Energy Pod pack"
		+INVENTORY.INVBAR
		+DONTINTERPOLATE
		scale 0.6;
		radius 10;
		height 16;
		Tag "$T_ENERGYPODPACK";
		inventory.icon "I_EPPK";
		inventory.amount 1;
		Inventory.MaxAmount 10;
		inventory.interhubamount 10;
		Inventory.PickupMessage "$F_ENERGYPODPACK";	
	
	}
	
	States
	{
		Spawn:
			EPPK AAAAAABBBBBB 1 BRIGHT;
			Loop;
			
		Use:
			TNT1 A 0 A_GiveInventory("EnergyPod", 60);
			Stop;
	}
}
*/
class wosEnergyPack : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Energy Pack (item)"
		+INVENTORY.INVBAR
		
		Tag "$T_ENERGYPACK";
		inventory.icon "I_CPAX";	
		Inventory.PickupMessage "$F_ENERGYPACK";		
		Mass energyPackWeight;
	}
	
	States {
		Spawn:
			DUMM AAABB 6 Bright;
			Loop;
		Use:
			TNT1 A 0 A_GiveInventory("EnergyPod", 120);
			Stop;
	}
}
class wosEnergyKit : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	GLDefs: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "EnergyKit (item)"
		
		+INVENTORY.INVBAR
		
		Tag "Energy Kit";
		Inventory.Icon "I_MENK";
		Inventory.PickupMessage "You picked up the energy kit.";
		Mass energyKitWeight;
	}
	
	States {
		Spawn:
			DUMM AAAABB 6 Bright;
			Loop;
		Use:
			TNT1 A 0 A_GiveInventory("energyPod", 60);
			Stop;
	}
}


/*
class ClipOfBullets2 : ClipOfBullets replaces ClipOfBullets {
	Default {
		Inventory.Icon "H_CLBL";
	}
}
*/
class wosBulletCartridge : wosPickup replaces ClipOfBullets {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Bullet Cartridge"
		
		+INVENTORY.INVBAR
		
		Tag "Bullet Cartridge";
		Inventory.Icon "I_MBLK";
		Inventory.PickupMessage "You picked up the bullet cartridge!";
		Mass bulletCartridgeWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("ClipOfBullets", 25);
			Stop;
	}
}

class wosBundleMiniMissile : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Mini Missile bundle"
		
		+INVENTORY.INVBAR
		
		Tag "Mini Missile bundle";
		Inventory.Icon "I_MMMB";
		//Inventory.Amount 1;
		//Inventory.MaxAmount 5;
		Inventory.PickupMessage "You picked up the mini missile bundle.";
		Mass miniMissileBndlWeight;
	}
	
	States {
		Spawn:
			MMMB A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("MiniMissiles", 5);
			Stop;
	}
}



class wosHEGrenadeBox : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "HE grenade box"
		
		+INVENTORY.INVBAR
		
		Tag "Explosive Grenade Box";
		Inventory.Icon "I_LHEG";
		Inventory.PickupMessage "You picked up the HE-Grenade Box.";
		Mass heGRboxWeight;
	}
	
	States {
		Spawn:
			LHEG A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("HEGrenadeRounds", 5);
			Stop;
	}
}

class wosPhosphorusGrenadeBox : wosPickup {
	/*
	Submitted: Dreadopp
	Decorate: Dreadopp
	Sounds: Rogue Entertainment
	Sprites: Rogue Entertainment
	Sprite Edit: Dreadopp
	*/
	Default {
		//$Category "Ammunition/WoS"
		//$Title "PH grenade box"
		
		+INVENTORY.INVBAR
		
		Tag "Phosphorous Grenade Box";
		Inventory.Icon "I_LPHG";
		Inventory.PickupMessage "You picked up the Phosphorus-Grenade Box.";
		Mass fireGRboxWeight;
	}
	
	States {
		Spawn:
			LPHG A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("PhosphorusGrenadeRounds", 5);
			Stop;
	}
}

//ammo satchel
//gives:
//ElectricBolts, 20
//PoisonBolts, 5
//ClipOfBullets, 50
//EnergyPod, 40
//MiniMissiles, 5
//shldrgunmag, 16
//HEGrenadeRounds, 10
//PhosphorusGrenadeRounds, 10
//grenadeExplosive, 5
//grenadeFire, 5

class ammoSatchel_item : wosPickup {
    Default {
        //$Category "Ammunition/WoS"
		//$Title "Ammo Satchel"
		
		+INVENTORY.INVBAR
		
		Tag "Ammo Satchel";
		Inventory.Icon "I_BPAK";
		Inventory.PickupMessage "You picked up the Ammo Satchel.";
		Mass ammoSatchelWeight;
    }

    States {
        Spawn:
            BKPK A -1;
            Stop;
        Use:
            TNT1 A 0 {
                A_GiveInventory("ElectricBolts", 20);
                A_GiveInventory("PoisonBolts", 5);
                A_GiveInventory("ClipOfBullets", 50);
                A_GiveInventory("EnergyPod", 40);
                //A_GiveInventory("MiniMissiles", 5);
                A_GiveInventory("shldrgunmag", 32);
                A_GiveInventory("HEGrenadeRounds", 3);
                A_GiveInventory("PhosphorusGrenadeRounds", 3);
                A_GiveInventory("wosGrenadeE", 5);
                A_GiveInventory("wosGrenadeF", 5);
                A_GiveInventory("wosGrenadeG", 5);
            }
            Stop;
    }
}
