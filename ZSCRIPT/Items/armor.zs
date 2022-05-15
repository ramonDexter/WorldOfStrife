//  binder helmet  /////////////////////////////////////////////////////////////
class binder_helmet : CustomInventory {
	
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "Binder Helmet"
        +INVENTORY.INVBAR
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE		
		Tag "Binder Helmet";
		Inventory.PickupMessage "$F_INQHELMET";
		inventory.icon "I_RGH1";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		radius 10;
		height 10;
		Mass 0;
	}
    States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;		
	}
}

//  LF inspired code  //////////////////////////////////////////////////////////
//by jarewill
Const LeatherWeight = 125;
Const MetalWeight = 250;
Const BinderBasicWeight = 135;
Const BinderAdvancedWeight = 165;
Const KineticWeight = 140;

class wosArmorBase : wosPickup {
	array<int> armoramount;	
    int armorselect;
    int currentarmor;
    property ArmorType : currentarmor;
    int armorammo;
    property ArmorAmount : armorammo;
    int armorpower;
    property ArmorPower : armorpower;
    int armormass;
    property ArmorMass : armormass;
	//int armorClass;
	//property ArmorClass : armorClass;
    bool nosound;
    property NoSound : nosound;
	
    Default {
        +INVENTORY.INVBAR
        +FLOORCLIP
        //Inventory.PickupSound "sounds/armorLight";
		//Inventory.UseSound "sounds/armorLight";
		radius 10;
		height 10;
    }

	Override void DoEffect() {
        While(armoramount.Size()<Amount) {
            self.armoramount.Push(self.armorammo);
        }
        Super.DoEffect();
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
		//other.A_StartSound("sounds/armorLight", 0, 0, 1.0);
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
			/*TNT1 A 0 A_JumpIf(invoker.nosound, 3);
			TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_USE,"UseSwitch");
			TNT1 A 0 A_JumpIf(GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1,"UseCheck");
			Goto UseCheck;*/
			TNT1 A 0 {
				if ( invoker.nosound ) { return resolveState("UseCheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("UseCheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 ) { return resolveState("UseSwitch"); }
				else { return resolveState("UseYes"); }
			}
        UseYes:
            TNT1 A 0 {
                let pawn = binderPlayer(invoker.owner);
                If( pawn.currentarmor>0 ){ Return ResolveState("UseNot"); }
                Else {
                    pawn.currentarmor=invoker.currentarmor;
                    pawn.armoramount=invoker.armoramount[invoker.armorselect];
                    pawn.armorpower=invoker.armorpower;
                    pawn.mass=invoker.armormass;
                    pawn.TakeInventory(invoker.GetClassName(),1);
                    invoker.armoramount.Delete(invoker.armorselect);
                    If(Invoker.armorselect>0){Invoker.armorselect--;}
                    If(Invoker.nosound==0){
                        pawn.A_StartSound("sounds/armorLight",CHAN_ITEM);
                    }
                    Return ResolveState("UseEnd");
                }
            }
		UseEnd:
            Stop;
        UseNot:
            TNT1 A 0 A_Log("\c[red][ You are already wearing armor! ]");
            Fail;
        UseNot2:
            TNT1 A 0 A_Log("\c[red][ Take off your environmental suit first! ]");
            Fail;
        UseCheck:
            TNT1 A 0 A_Log(String.Format("\c[yellow][ %i%s", Invoker.armoramount[Invoker.armorselect], "\c[yellow]% durability left ]"));
            Fail;
        UseSwitch:
            TNT1 A 0 {
				////////////////////////////////////////////////////////////////
                Invoker.armorselect++;
                If( Invoker.armorselect == Invoker.armoramount.Size() )
                { Invoker.armorselect=0; }
				
				////////////////////////////////////////////////////////////////
				/*let pawn = binderPlayer(invoker.owner);
				if( pawn.currentArmor > 0 && pawn.armorAmount > 0 && pawn.armorpower > 0 ) {
					//int armorClass = pawn.currentArmor;
					switch(pawn.currentArmor) {
						Case 1:
							GiveInventory("wosLeatherArmor", 1);
						Break;
						
						Case 2:
							GiveInventory("wosMetalArmor", 1);
						Break;
						
						Case 3:
							GiveInventory("wosBinderArmorBasic", 1);
						Break;
						
						Case 4:
							GiveInventory("wosBinderArmorAdvanced", 1);
						Break;
						
						Case 5:
							GiveInventory("wosKineticArmor", 1);
						Break;
					}
					pawn.currentarmor = 0;
                    pawn.armoramount = 0;
                    pawn.armorpower = 0;
				}*/
				
            }            
			Fail;
	}

}
class wosLeatherArmor : wosArmorBase replaces LeatherArmor {
    Default {
        wosArmorBase.ArmorType 1;
        wosArmorBase.ArmorPower 24;
		wosArmorBase.ArmorMass 125;
		wosArmorBase.ArmorAmount 100;
		//wosArmorBase.ArmorClass 4;
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
		wosArmorBase.ArmorPower 44;
		wosArmorBase.ArmorMass 250;
		wosArmorBase.ArmorAmount 200;
		//wosArmorBase.ArmorClass 7;
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
		Inventory.UseSound "sounds/armorLight";
        wosArmorBase.ArmorType 3;
		wosArmorBase.ArmorPower 35;
		wosArmorBase.ArmorMass 135;
		wosArmorBase.ArmorAmount 120;
		//wosArmorBase.ArmorClass 6;
        Mass BinderBasicWeight;
    }
    States {
        Spawn:
            DUMM A -1;
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
		Inventory.UseSound "sounds/armorLight";
        wosArmorBase.ArmorType 4;
		wosArmorBase.ArmorPower 50;
		wosArmorBase.ArmorMass 165;
		wosArmorBase.ArmorAmount 240;
		//wosArmorBase.ArmorClass 9;
        Mass BinderAdvancedWeight;
    }
    States {
		Spawn:
			DUMM A -1;
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
		Inventory.UseSound "sounds/armorLight";
        wosArmorBase.ArmorType 5;
		wosArmorBase.ArmorPower 65;
		wosArmorBase.ArmorMass 140;
		wosArmorBase.ArmorAmount 360;
		//wosArmorBase.ArmorClass 12;
        Mass KineticWeight;
    }
    States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////

//  deprecated unused code  ////////////////////////////////////////////////////
/*
class RangerArmor1 : BasicArmorPickup
{
	Default
	{
		+INVENTORY.AUTOACTIVATE
		Tag "$T_CYBERARMOR1";
		Armor.SaveAmount 120;
		Armor.SavePercent 33.333;
		inventory.icon "I_RGA1";
		Inventory.PickupMessage "$W_CYBERARMOR1";
	}

	States
	{
		Spawn:
			RGA1 V -1;
			Stop;
	}
}

class RangerArmor1_item : CustomInventory
{
	Default
	{
		//$Category "Health and Armor/WoS"
		//$Title "binder armor l.1"
		
		+inventory.invbar
		
		Tag "$T_CYBERARMOR1";
		inventory.amount 1;
		inventory.maxamount 2;
		inventory.interhubamount 2;
		inventory.icon "I_RGA1";
		Inventory.PickupMessage "$F_CYBERARMOR1";
		radius 12;
		height 12;
	}
	
	States
	{
		Spawn:
			RGA1 V -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("RangerArmor1", 1);			
			Stop;
	}
}

class RangerArmor2 : BasicArmorPickup
{
	Default
	{
		+INVENTORY.AUTOACTIVATE
		Tag "$T_CYBERARMOR2";
		Armor.SaveAmount 240;
		Armor.SavePercent 44.444;
		inventory.icon "I_RGA2";
		Inventory.PickupMessage "$W_CYBERARMOR2";
	}

	States
	{
		Spawn:
			RGA2 V -1;
			Stop;
	}
}

class RangerArmor2_item : CustomInventory
{
	Default
	{
		//$Category "Health and Armor/WoS"
		//$Title "binder armor l.2"
		+inventory.invbar
		
		Tag "$T_CYBERARMOR2";
		inventory.amount 1;
		inventory.maxamount 2;
		inventory.interhubamount 2;
		inventory.icon "I_RGA2";
		Inventory.PickupMessage "$F_CYBERARMOR2";
		radius 12;
		height 12;
		
	}
	
	States
	{
		Spawn:
			RGA2 V -1;
			Stop;
		Use:
			TNT1 A 0 A_Giveinventory("RangerArmor2", 1);
			Stop;
	}
}

class kineticArmor : BasicArmorPickup {
	Default {
		+INVENTORY.AUTOACTIVATE
		Tag "$T_UberArmor";
		Armor.SaveAmount 360;
		Armor.SavePercent 80;
		inventory.icon "I_SHLD";
		Inventory.PickupMessage "$W_UberArmor";
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class kineticArmor_item : CustomInventory {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "kinetic armor"
		+inventory.invbar
		
		Tag "$T_UberArmor";
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		inventory.icon "I_SHLD";
		Inventory.PickupMessage "$F_UberArmor";
		radius 12;
		height 12;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("kineticArmor", 1);
			Stop;
	}
}
*/
/*class RangerHelm : ArmorBonus
{
	Default
	{
		//$Category "Health and Armor/WoS"
		//$Title "Ranger helm"
		+INVENTORY.AUTOACTIVATE
		Armor.SaveAmount 20;
		Armor.SavePercent 20;
		inventory.icon "I_RGH1";
	}

	States
	{
		Spawn:
			RNGH V -1;
			Stop;
	}
}

class rangerHelm_item : CustomInventory
{
	Default
	{
		//$Category "Health and Armor/WoS"
		//$Title "Ranger helm"
		
		+inventory.invbar
		Tag "Cybernetic Helmet";
		inventory.icon "I_RGH1";
		inventory.amount 1;
		inventory.maxamount 8;
		inventory.interhubamount 8;
		radius 12;
		height 12;
	}
	
	States
	{
		Spawn:
			RNGH V -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("RangerHelm", 1);
			Stop;
	}
}*/