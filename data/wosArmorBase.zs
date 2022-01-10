Const LeatherWeight = 125;
Const MetalWeight = 250;
Const BinderBasicWeight = 135;
Const BinderAdvancedWeight = 165;
Const KineticWeight = 180;

class wosArmorBase : wosPickup {
    int armorselect;
    int currentarmor;
    property ArmorType : currentarmor;
    int armorammo;
    property ArmorAmount : armorammo;
    int armorpower;
    property ArmorPower : armorpower;
    int armormass;
    property ArmorMass : armormass;
    bool nosound;
    property NoSound : nosound;
    default {
        +INVENTORY.INVBAR
        +FLOORCLIP
        Inventory.PickupSound "";
        radius 12;
        height 12;
    }

    override bool TryPickup (in out Actor toucher) {
        let armo = wosArmorBase(toucher.FindInventory(self.GetClassName()));
        if (armo != NULL) {
            armo.armoramount.Push(self.armorammo);
        }
        return super.TryPickup(toucher);
    }
    Override void AttachToOwner(Actor other) {
		self.armoramount.Push(self.armorammo);
		Super.AttachToOwner(other);
	}
	Override Inventory CreateTossable(int amt) {
		If(self.amount>1) {
			bool spawn1; Actor spawn2;
			[spawn1, spawn2] = owner.A_SpawnItemEx(self.GetClassName(),0,0,0,8.25);
			let armo = wosArmorBase(spawn2);
			owner.A_TakeInventory(self.GetClassName(),1);
			armo.armorammo = armoramount[armorselect];
			armoramount.Delete(armorselect);
			If(armorselect>0){armorselect--;}
			Return null;
		}
		Else {
			self.armorammo=armoramount[armorselect];
			armoramount.Clear();
			Return Super.CreateTossable(amt);
		}
	}
	States {
        Pickup:
            TNT1 A 0 A_RailWait();
            Stop;
        Use:
            TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_USE,"UseCheck");
            TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED,"UseSwitch");
            TNT1 A 0 {
                let pawn = LFPlayer(invoker.owner);
                If(pawn.currentarmor>0){Return ResolveState("UseNot");}
                Else If(pawn.CountInv("LFPowerMask")){
                    Return ResolveState("UseNot2");
                }
                Else {
                    pawn.currentarmor=invoker.currentarmor;
                    pawn.armoramount=invoker.armoramount[invoker.armorselect];
                    pawn.armorpower=invoker.armorpower;
                    pawn.mass=invoker.armormass;
                    pawn.TakeInventory(invoker.GetClassName(),1);
                    invoker.armoramount.Delete(invoker.armorselect);
                    If(Invoker.armorselect>0){Invoker.armorselect--;}
                    If(Invoker.nosound==0){
                        pawn.A_StartSound("misc/armor_pkup",CHAN_ITEM);
                    }
                    Return ResolveState("UseYes");
                }
            }
        UseYes:
            Stop;
        UseNot:
            TNT1 A 0 A_Log("You are already wearing armor");
            Fail;
        UseNot2:
            TNT1 A 0 A_Log("Take off your environmental suit first");
            Fail;
        UseCheck:
            TNT1 A 0 A_Log(String.Format("%i%s", Invoker.armoramount[Invoker.armorselect], "% durability left"));
            Fail;
        UseSwitch:
            TNT1 A 0
            {
                Invoker.armorselect++;
                If(Invoker.armorselect==Invoker.armoramount.Size())
                {Invoker.armorselect=0;}
            }
            Fail;
	}

}
class wosLeatherArmor : wosArmorBase replaces LeatherArmor {
    Default {
        wosArmorBase.ArmorType 1;
        wosArmorBase.ArmorPower 33;
		wosArmorBase.ArmorMass 200;
		wosArmorBase.ArmorAmount 100;
        Inventory.Icon "I_ARM2";
		Inventory.PickupMessage "Picked up a suit of leather armor.";
		Tag "Leather Armor";
		Mass LeatherWeight;
    }
    States {
        Spawn:
            ARM4 A -1;
            Stop;
	}
}
class wosMetalArmor : wosArmorBase replaces MetalArmor {
    Default {
        wosArmorBase.ArmorType 2;
		wosArmorBase.ArmorPower 50;
		wosArmorBase.ArmorMass 400;
		wosArmorBase.ArmorAmount 200;
		Inventory.Icon "I_ARM1";
		Inventory.PickupMessage "Picked up a suit of metal armor.";
		Tag "Metal Armor";
		Mass MetalWeight;
    }
    States {
        Spawn:
            ARM3 A -1;
            Stop;
	}
}
class wosBinderArmorBasic : wosArmorBase {
    Default {
        //$Category "Health and Armor/WoS"
		//$Title "wosbinder armor l.1"
        Tag "$T_CYBERARMOR1";
        inventory.icon "I_RGA1";
		Inventory.PickupMessage "$W_CYBERARMOR1";
        wosArmorBase.ArmorType 3;
		wosArmorBase.ArmorPower 33;
		wosArmorBase.ArmorMass 240;
		wosArmorBase.ArmorAmount 120;
        Mass BinderBasicWeight;
    }
    States {
        Spawn:
            RGA1 V -1;
                Stop;
    }
}
class wosBinderArmorAdvanced : wosArmorBase {
    Default {
        //$Category "Health and Armor/WoS"
		//$Title "wosbinder armor l.2"
        Tag "$T_CYBERARMOR2";
        inventory.icon "I_RGA2";
		Inventory.PickupMessage "$F_CYBERARMOR2";
        wosArmorBase.ArmorType 4;
		wosArmorBase.ArmorPower 45;
		wosArmorBase.ArmorMass 480;
		wosArmorBase.ArmorAmount 240;
        Mass BinderAdvancedWeight;
    }
    States {
		Spawn:
			RGA2 V -1;
			Stop;
	}
}
class wosKineticArmor : wosArmorBase {
    Default {
        //$Category "Health and Armor/WoS"
		//$Title "kinetic armor"
        Tag "$T_UberArmor";
        inventory.icon "I_SHLD";
		Inventory.PickupMessage "$F_UberArmor";
        wosArmorBase.ArmorType 5;
		wosArmorBase.ArmorPower 65;
		wosArmorBase.ArmorMass 620;
		wosArmorBase.ArmorAmount 360;
        Mass KineticWeight;
    }
    States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
