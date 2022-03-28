//  item weights  //////////////////////////////////////////////////////////////
const BottleWeight = 5;
const burgerweight = 3;
const cheeseBurgerWeight = 4;
const bigBurgerWeight = 5;
const dblCheeBWeight = 5;
const hotdogWeight = 4;
const donutsWeight = 4;
const foodBoxWeight = 5;
const foodRationWeight = 10;
const grilledChickenWeight = 10;
////////////////////////////////////////////////////////////////////////////////

class waterBottle_heal : Health {
	Default {
		Inventory.Amount 5;
	}
}
class wosWaterBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Water Bottle"
		
		Tag "Water Bottle";
		height 24;
		Inventory.PickupMessage "You picked up the Water Bottle!";
		Inventory.Icon "I_WATR";
		Inventory.useSound "sounds/dukeDrink";
		Mass BottleWeight;
	}
	
	States {
		Spawn:			
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("waterBottle_heal", 1);
			Stop;
	}
}

class beerBottle_heal : Health {
	Default {
		Inventory.Amount 6;
	}
}
class wosBeerBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Beer Bottle"
		
		Tag "Beer Bottle";
		height 24;
		Inventory.PickupMessage "You picked up the Beer Bottle!";
		Inventory.Icon "I_SBER";
		Inventory.useSound "sounds/dukeDrink";
		Mass BottleWeight;
	}
	
	States {
		Spawn:			
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("beerBottle_heal", 1);
			Stop;
	}
}
class aleBottle_heal : Health {
	Default {
		Inventory.Amount 9;
	}
}
class wosAleBottle : wosPickup
{
	Default
	{
		//$Category "Health and Armor/Food"
		//$Title "Ale Bottle"
		
		Tag "Ale Bottle";
		height 24;
		Inventory.PickupMessage "You picked up the Ale Bottle!";
		Inventory.Icon "I_MS12";
		Inventory.useSound "sounds/dukeDrink";
		Mass BottleWeight;
	}
	
	States
	{
		Spawn:			
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("aleBottle_heal", 1);
			Stop;
	}
}
class vineBottle_heal : Health {
	Default {
		Inventory.Amount 7;
	}
}
class wosVineBottle : wosPickup {
	Default {	
		//$Category "Health and Armor/Food"
		//$Title "Vine Bottle"	
		
		Tag "Wine Bottle";
		height 24;
		Inventory.PickupMessage "You picked up the Vine Bottle!";
		Inventory.Icon "I_SVIN";
		Inventory.useSound "sounds/dukeDrink";
		Mass BottleWeight;
	}
	
	States {
		Spawn:			
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("vineBottle_heal", 1);
			Stop;
	}
}

class hamburger_heal : Health {
	Default {
		inventory.amount 5;
	}
}

class wosHamburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hamburger"
		
		Tag "Hamburger";
		inventory.icon "I_BRG1";
		Inventory.PickupMessage "You picked up the Hamburger!";
		inventory.usesound "sounds/eat";
		Mass burgerweight;
	}
	
	States {
		Spawn:
			BRGR A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("hamburger_heal", 1);
			Stop;
	}
}

class cheeseburger_heal : Health {
	Default {
		Inventory.amount 8;
	}
}

class wosCheeseburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Cheeseburger"
		
		Tag "Cheeseburger";
		inventory.icon "I_BRG3";
		Inventory.PickupMessage "You picked up the Cheeseburger!";
		inventory.usesound "sounds/eat";
		Mass cheeseBurgerWeight;
	}
	
	States {
		Spawn:
			BRGR B -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("cheeseburger_heal", 1);
			Stop;			
	}
}

class bigburger_heal : Health {
	Default {
		Inventory.amount 11;
	}
}

class wosBigburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Bigburger"
		
		Tag "Bigburger";
		inventory.icon "I_BRG2";
		Inventory.PickupMessage "You picked up the Bigburger!";
		inventory.usesound "sounds/eat";
		Mass bigBurgerWeight;
	}
	
	States {
		Spawn:
			BRGR C -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("bigburger_heal", 1);
			Stop;
	}
}

class cheeseburgerDouble_heal : Health {
	Default {
		Inventory.amount 15;
	}
}
class wosCheeseburgerDouble : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Double Cheeseburger"
		
		Tag "Double Cheeseburger";
		inventory.icon "I_BRG4";
		Inventory.PickupMessage "You picked up the Double Cheeseburger!";
		inventory.usesound "sounds/eat";
		Mass dblCheeBWeight;
	}
	
	States {
		Spawn:
			BRGR C -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("cheeseburgerDouble_heal", 1);
			Stop;
	}
}
class hotdog_heal : Health {
	Default {
		Inventory.Amount 7;
	}
}
class wosHotdog01 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hotdog 01"
		
		Tag "Hotdog";
		inventory.icon "I_HTD1";
		Inventory.PickupMessage "You picked up the Hotdog!";
		inventory.usesound "sounds/eat";
		Mass hotdogWeight;
	}
	
	States {
		Spawn:
			HTD1 A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("hotdog_heal", 1);
			Stop;
	}
}
class wosHotdog02 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hotdog 02"
		
		Tag "Hotdog";
		inventory.icon "I_HTD2";
		Inventory.PickupMessage "You picked up the Hotdog!";
		inventory.usesound "sounds/eat";
		Mass hotdogWeight;
	}
	
	States {
		Spawn:
			HTD2 A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("hotdog_heal", 1);
			Stop;
	}
}


class donuts_heal : Health {
	Default {
		inventory.amount 7;
	}
}

class wosDonuts : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Donuts"
		
		Tag "Donuts";
		inventory.icon "I_DNTS";
		Inventory.PickupMessage "You picked up the Donuts!";
		inventory.usesound "sounds/eat";
		Mass donutsWeight;
	}
	
	States {
		Spawn:
			DNTS A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("donuts_heal", 1);
			Stop;
	}
}

class foodBox_heal : Health {
	Default {
		inventory.amount 15;
	}
}

class wosFoodBox : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Foodbox"
		
		Tag "Foodbox";
		inventory.icon "I_DBOX";
		Inventory.PickupMessage "You picked up the Foodbox!";
		inventory.usesound "sounds/eat";
		Mass foodBoxWeight;
	}
	
	States {
		Spawn:
			DBOX A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("foodBox_heal", 1);
			Stop;
	}
}

class foodRation_heal : Health {
	Default {
		inventory.amount 20;
	}
}

class wosFoodRation1 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations I"
		
		Tag "Food Rations I";
		inventory.icon "I_FR01";
		Inventory.PickupMessage "You picked up the Food Rations I!";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("foodRation_heal", 1);
			Stop;
	}
}
class wosFoodRation2 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations II"
		
		Tag "Food Rations II";
		inventory.icon "I_FR02";
		Inventory.PickupMessage "You picked up the Food Rations II!";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("foodRation_heal", 1);
			Stop;
	}
}
class wosFoodRation3 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations III"
		
		Tag "Food Rations III";
		inventory.icon "I_FR03";
		Inventory.PickupMessage "You picked up the Food Rations III!";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("foodRation_heal", 1);
			Stop;
	}
}
class wosGrilledChicken_Heal : Health {
	Default {
		inventory.amount 20;
	}
}
class wosGrilledChicken : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "grilled chicken"
		Tag "Grilled Chicken";
		inventory.icon "I_CHKN";
		Inventory.PickupMessage "You picked up the Grilled Chicken!";
		inventory.usesound "sounds/eat";
		Mass grilledChickenWeight;
	}
	States {
		Spawn:
			CHKN V -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("wosGrilledChicken_Heal", 1);
			Stop;
	}
}