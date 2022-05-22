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
const wosVegieWeight = 1;
const wosfbMeat1Weight = 2;
const wosfbMeat2Weight = 1;
const wosfbMeat3Weight = 1;
const wosSoyFoodWeight = 2;
const wosSodaCanWeight = 3;
const wosCandyBarWeight = 1;
////////////////////////////////////////////////////////////////////////////////

// food dispensers, vanding machines ///////////////////////////////////////////

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
			TNT1 A 0 {
				ACS_NamedExecute("drunkPivo", 0);
				A_GiveInventory("beerBottle_heal", 1);
			}
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
			TNT1 A 0 {
				ACS_NamedExecute("drunkPivo", 0);
				A_GiveInventory("aleBottle_heal", 1);
			}
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
			TNT1 A 0 {
				ACS_NamedExecute("drunkVino", 0);
				A_GiveInventory("vineBottle_heal", 1);
			}
			Stop;
	}
}
class spiritsBottle_heal : Health {
	Default { 
		Inventory.Amount 7; 
	}
}
class wosSpiritsBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Spirits Bottle"

		Tag "Spirits Bottle";
		height 24;
		Inventory.PickupMessage "You picked up the Spirits Bottle!";
		Inventory.Icon "I_SPIB";
		Inventory.useSound "sounds/dukeDrink";
		Mass BottleWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 { 
				ACS_NamedExecute("drunkKoralka", 0);
				A_GiveInventory("spiritsBottle_heal", 1); 
			}
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
		inventory.amount 35;
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
			CHKN W -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("wosGrilledChicken_Heal", 1);
			Stop;
	}
}
// food from foodbarrels //////////////////////////////////////////////////////
class Vegie1 : health {
	Default {
		Inventory.Amount 10;
	}
}
class wosVegie1 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Strange Fruit"
		Tag "Strange Fruit";
		inventory.icon "I_FRTA";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Chewed a strange fruit, WTF?.";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosVegieWeight;
	}
	States {
		Spawn:
			FRUT A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("Vegie1", 1);
			Stop;
	}
}
class Vegie2 : health {
	Default {
		Inventory.Amount 15;
	}
}
class wosVegie2 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Apple"
		Tag "Apple";
		inventory.icon "I_FRTB";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten an apple, Good.";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosVegieWeight;
	}
	States {
		Spawn:
			FRUT B -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("Vegie2", 1);
			Stop;
	}
}
class Vegie3 : Health {
	Default {
		Inventory.Amount 10;
	}
}
class wosVegie3 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Lettuce"
		Tag "Lettuce";
		inventory.icon "I_FRTD";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten a Lecttuce, Humn...";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosVegieWeight;
	}
	States {
		Spawn:
			FRUT D -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("Vegie3", 1);
			Stop;
	}
}
class Vegie4 : Health {
	Default {
		Inventory.Amount 15;
	}
}
class wosVegie4 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Carrots"
		Tag "Carrots";
		inventory.icon "I_FRTE";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten some Carrots,...";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosVegieWeight;
	}
	States {
		Spawn:
			FRUT E -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("Vegie4", 1);
			Stop;
	}
}
class Vegie5 : Health {
	Default {
		Inventory.Amount 10;
	}
}
class wosVegie5 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Onion"
		Tag "Onion";
		inventory.icon "I_FRTG";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten some Onions, Yuck!.";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosVegieWeight;
	}
	States {
		Spawn:
			FRUT G -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("Vegie5", 1);
			Stop;
	}
}
class fbMeat1 : Health {
	Default {
		Inventory.Amount 25;
	}
}
class wosfbMeat1 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Beef"
		Tag "Beef";
		inventory.icon "I_FRTC";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten a Beef, Tasty.";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosfbMeat1Weight;
	}
	States {
		Spawn:
			FRUT C -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("fbMeat1", 1);
			Stop;
	}
}
class fbMeat2 : Health {
	Default {
		Inventory.Amount 20;
	}
}
class wosfbMeat2 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Cheese"
		Tag "Cheese";
		inventory.icon "I_FRTF";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten a Cheese, Yum..";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosfbMeat2Weight;
	}
	States {
		Spawn:
			FRUT F -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("fbMeat2", 1);
			Stop;
	}
}
class fbMeat3 : Health {
	Default {
		Inventory.Amount 20;
	}
}
class wosfbMeat3 : wosPickup {
	Default {
		//$Category "Decorations/food barrels"
		//$Title "Fish"
		Tag "Fish";
		inventory.icon "I_FRTH";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "Eaten a Fish, Gulp..";
		inventory.usesound "sounds/eat";
		+DOOMBOUNCE
		Speed 4;
		Mass wosfbMeat3Weight;
	}
	States {
		Spawn:
			FRUT H -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("fbMeat3", 1);
			Stop;
	}
}

class soyFoodHeal : Health {
	Default { 
		inventory.Amount 20; 
	}
}
class wosSoyFood : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Soy Food"
		
		Tag "Soy Food";
		inventory.icon "I_SYFD";
		Inventory.PickupMessage "You picked up the Soy Food!";
		inventory.usesound "sounds/eat";
		Mass wosSoyFoodWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("soyFoodHeal", 1);
			Stop;
	}
}

class sodaCanHeal : Health {
	Default {
		inventory.Amount 10;
	}
}
class wosSodaCan : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "soda can"
		
		Tag "NRG Soda";
		inventory.icon "I_SDCN";
		Inventory.PickupMessage "You picked up the NRG Soda!";
		inventory.usesound "sounds/eat";
		Mass wosSodaCanWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("sodaCanHeal", 1);
			Stop;
	}
}

class candyBarHeal : Health {
	Default {
		inventory.Amount 15;
	}
}
class wosCandyBar : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "candy bar"
		
		Tag "Chocolate Candybar";
		inventory.icon "I_CDBR";
		Inventory.PickupMessage "You picked up the Chocolate Candybar!";
		inventory.usesound "sounds/eat";
		Mass wosCandyBarWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 A_GiveInventory("candyBarHeal", 1);
			Stop;
	}
}

class FoodTrayHeal : Health {
	Default {
		inventory.Amount 17;
	}
}
class wosFoodTrayEmpty : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Empty Food Tray"
		Tag "Empty Food Tray";
		inventory.icon "I_FDTE";
		Inventory.PickupMessage "You picked up the Empty Food Tray!";
		inventory.usesound "sounds/eat";
		Mass wosCandyBarWeight;
	}
	States {
		Spawn:
			FDTE A -1;
			Stop;
		Use:
			TNT1 A 0;
			Fail;
	}
}
class wosFoodTray : wosPickup {
	action void W_eatFoodTray() {
		if ( player == null ) {
            return;
        }
		A_GiveInventory("FoodTrayHeal", 1);
		A_GiveInventory("wosFoodTrayEmpty", 1);
	}

	Default {
		//$Category "Health and Armor/Food"
		//$Title "Food Tray"
		
		Tag "Food Tray";
		inventory.icon "I_FDTR";
		Inventory.PickupMessage "You picked up the Food Tray!";
		inventory.usesound "sounds/eat";
		Mass wosCandyBarWeight;
	}
	States {
		Spawn:
			FDTR A -1;
			Stop;
		Use:
			TNT1 A 0 W_eatFoodTray();
			Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////