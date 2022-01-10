//===OLD LANTERN================================================================

class oldLantern : weapon
{
	Default
	{
		//$Category "Weapons"	
		//$Title "old lantern"
		
		+WEAPON.WIMPY_WEAPON
		+WEAPON.NOALERT
		+WEAPON.NOAUTOFIRE
		
		Tag "$T_OLDLANTERN";
		//Weapon.SelectionOrder 2900;
		Weapon.slotnumber 1;
		Weapon.slotPriority 0.1;
		Weapon.AmmoUse1 1;
		Weapon.AmmoGive1 50;
		Weapon.AmmoType1 "lampOil";
		Inventory.Pickupmessage "$F_OLDLANTERN";
		Inventory.PickupSound "items/gunspickup";
		Weapon.BobStyle "Alpha";
		Weapon.BobSpeed 1.5;
		Weapon.BobRangeX .2;
		Weapon.BobRangeY .5;	
		scale 0.7;
		radius 12;
		height 16;
	}
	
	States
	{
		Ready:
			TNT1 A 0 a_JumpIfInventory("lightlit",1, 4);
			OLNT A 1 A_WeaponReady(WRF_ALLOWUSER1);
			OLNT A 0;
			Loop;
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 0 A_jump(20,2);
			OLNT A 0 A_spawnitemex("lanternglow2",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT A 0 A_spawnitemex("lanternglow",0,0,8,0);
			OLNT B 1 BRIGHT A_WeaponReady(WRF_ALLOWRELOAD|WRF_ALLOWUSER1);
			OLNT B 0 A_jump(220,2);
			OLNT A 0 A_takeinventory("lampOil",1);
			OLNT A 0 A_checkreload();
			loop;
		Deselect:
			OLNT A 0 A_lower();
			OLNT A 1 A_Lower();
			Loop;
		Select:
			OLNT A 1 A_Raise();
			Loop;
		Fire:
			TNT1 A 0 a_JumpIfInventory("lightlit",1,"unlight");
			Goto Light;
		Unlight:
			OLNT A 1 A_takeinventory("lightlit",1);
			goto ready;
		Light:
			OLNT A 1 A_giveinventory("lightlit",1);
			goto ready;
		Spawn:
			PET2 A -1;
			Stop;
			
	}
}






class LanternGlow : GenericDebris
{
	Default
	{
		+NOINTERACTION
		
		Speed 1;
	}
	
	States
	{
		Spawn:
			TNT1 A 3;
			Stop;
	}
}

class LanternGlow2 : LanternGlow {}






class lightlit : Ammo
{
	Default
	{
		+INVENTORY.IGNORESKILL
		
		Inventory.MaxAmount 1;
		Ammo.BackPackMaxAmount 1;
	}
}



