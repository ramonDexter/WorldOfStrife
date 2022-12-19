//  item weights  //////////////////////////////////////////////////////////////
/*
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
*/
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// food ////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosWaterBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Water Bottle"
		
		Tag "$T_WaterBottle";
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
			TNT1 A 0 W_foodHeal(5);
			Stop;
	}
}
class wosBeerBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Beer Bottle"
		
		Tag "$T_BeerBottle";//Beer Bottle
		height 24;
		Inventory.PickupMessage "$F_BeerBottle";//You picked up the Beer Bottle!
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
				W_foodHeal(6);
			}
			Stop;
	}
}
class wosAleBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Ale Bottle"
		
		Tag "$T_AleBottle";
		height 24;
		Inventory.PickupMessage "$F_AleBottle";
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
				W_foodHeal(9);
			}
			Stop;
	}
}
class wosVineBottle : wosPickup {
	Default {	
		//$Category "Health and Armor/Food"
		//$Title "Vine Bottle"	
		
		Tag "$T_VineBottle";
		height 24;
		Inventory.PickupMessage "$F_VineBottle";
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
				W_foodHeal(7);
			}
			Stop;
	}
}
class wosSpiritsBottle : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Spirits Bottle"

		Tag "$T_SpiritsBottle";
		height 24;
		Inventory.PickupMessage "$F_SpiritsBottle";
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
				W_foodHeal(7); 
			}
			Stop;
	}
}
class wosHamburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hamburger"
		
		Tag "$T_Hamburger";
		inventory.icon "I_BRG1";
		Inventory.PickupMessage "$F_Hamburger";
		inventory.usesound "sounds/eat";
		Mass burgerweight;
	}	
	States {
		Spawn:
			BRGR A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(5);
			Stop;
	}
}
class wosCheeseburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Cheeseburger"
		
		Tag "$T_Cheeseburger";
		inventory.icon "I_BRG3";
		Inventory.PickupMessage "$F_Cheeseburger";
		inventory.usesound "sounds/eat";
		Mass cheeseBurgerWeight;
	}	
	States {
		Spawn:
			BRGR B -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(8);
			Stop;			
	}
}
class wosBigburger : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Bigburger"
		
		Tag "$T_Bigburger";
		inventory.icon "I_BRG2";
		Inventory.PickupMessage "$F_Bigburger";
		inventory.usesound "sounds/eat";
		Mass bigBurgerWeight;
	}	
	States {
		Spawn:
			BRGR C -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(11);
			Stop;
	}
}
class wosCheeseburgerDouble : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Double Cheeseburger"
		
		Tag "$T_CheeseburgerDouble";
		inventory.icon "I_BRG4";
		Inventory.PickupMessage "$F_CheeseburgerDouble";
		inventory.usesound "sounds/eat";
		Mass dblCheeBWeight;
	}	
	States {
		Spawn:
			BRGR C -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(15);
			Stop;
	}
}
class wosHotdog01 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hotdog 01"
		
		Tag "$T_Hotdog";
		inventory.icon "I_HTD1";
		Inventory.PickupMessage "$F_Hotdog";
		inventory.usesound "sounds/eat";
		Mass hotdogWeight;
	}	
	States {
		Spawn:
			HTD1 A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(7);
			Stop;
	}
}
class wosHotdog02 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Hotdog 02"
		
		Tag "$T_Hotdog";
		inventory.icon "I_HTD2";
		Inventory.PickupMessage "$F_Hotdog";
		inventory.usesound "sounds/eat";
		Mass hotdogWeight;
	}	
	States {
		Spawn:
			HTD2 A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(7);
			Stop;
	}
}
class wosDonuts : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Donuts"
		
		Tag "$T_Donuts";
		inventory.icon "I_DNTS";
		Inventory.PickupMessage "$F_Donuts";
		inventory.usesound "sounds/eat";
		Mass donutsWeight;
	}	
	States {
		Spawn:
			DNTS A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(7);
			Stop;
	}
}
class wosFoodBox : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Foodbox"
		
		Tag "$T_FoodBox";
		inventory.icon "I_DBOX";
		Inventory.PickupMessage "$F_FoodBox";
		inventory.usesound "sounds/eat";
		Mass foodBoxWeight;
	}	
	States {
		Spawn:
			DBOX A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(15);
			Stop;
	}
}
class wosFoodRation1 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations I"
		
		Tag "$T_FoodRation1";
		inventory.icon "I_FR01";
		Inventory.PickupMessage "$F_FoodRation1";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(20);
			Stop;
	}
}
class wosFoodRation2 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations II"
		
		Tag "$T_FoodRation2";
		inventory.icon "I_FR02";
		Inventory.PickupMessage "$F_FoodRation2";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(20);
			Stop;
	}
}
class wosFoodRation3 : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "food rations III"
		
		Tag "$T_FoodRation3";
		inventory.icon "I_FR03";
		Inventory.PickupMessage "$F_FoodRation3";
		inventory.usesound "sounds/eat";
		Mass foodRationWeight;
	}	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(20);
			Stop;
	}
}
class wosGrilledChicken : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "grilled chicken"
		Tag "$T_GrilledChicken";
		inventory.icon "I_CHKN";
		Inventory.PickupMessage "$F_GrilledChicken";
		inventory.usesound "sounds/eat";
		Mass grilledChickenWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(35);
			Stop;
	}
}
// food from foodbarrels //////////////////////////////////////////////////////
class wosVegie1 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Strange Fruit"
		Tag "$T_strangeFruit";
		inventory.icon "I_FRTA";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_strangeFruit";
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
			TNT1 A 0 {
				A_Log("$eat_strangeFruit");
				W_foodHeal(10);
			}
			Stop;
	}
}
class wosVegie2 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Apple"
		Tag "$T_apple";
		inventory.icon "I_FRTB";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_apple";
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
			TNT1 A 0 {
				A_Log("$eat_apple");
				W_foodHeal(15);
			}
			Stop;
	}
}
class wosVegie3 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Lettuce"
		Tag "$T_lettuce";
		inventory.icon "I_FRTD";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_lettuce";
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
			TNT1 A 0 {
				A_Log("$eat_lettuce");
				W_foodHeal(10);
			}
			Stop;
	}
}
class wosVegie4 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Carrots"
		Tag "$T_carrots";
		inventory.icon "I_FRTE";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_carrots";
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
			TNT1 A 0 {
				A_Log("$eat_carrots");
				W_foodHeal(15);
			}
			Stop;
	}
}
class wosVegie5 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Onion"
		Tag "$T_onion";
		inventory.icon "I_FRTG";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_onion";
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
			TNT1 A 0 {
				A_Log("$eat_onion");
				W_foodHeal(10);
			}
			Stop;
	}
}
class wosfbMeat1 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Beef"
		Tag "$T_beef";
		inventory.icon "I_FRTC";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_beef";
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
			TNT1 A 0 {
				A_Log("$eat_beef");
				W_foodHeal(25);
			}
			Stop;
	}
}
class wosfbMeat2 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Cheese"
		Tag "$T_cheese";
		inventory.icon "I_FRTF";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_cheese";
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
			TNT1 A 0 {
				A_Log("$eat_cheese");
				W_foodHeal(20);
			}
			Stop;
	}
}
class wosfbMeat3 : wosPickup {
	Default {
		//$Category "Decorations/WoS/food barrels"
		//$Title "Fish"
		Tag "$T_fish";
		inventory.icon "I_FRTH";
		Inventory.PickupFlash "Pickupflash";
		Inventory.PickupMessage "$F_fish";
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
			TNT1 A 0 {
				A_Log("$eat_fish");
				W_foodHeal(20);
			}
			Stop;
	}
}
class wosSoyFood : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Soy Food"
		
		Tag "$T_SoyFood";
		inventory.icon "I_SYFD";
		Inventory.PickupMessage "$F_SoyFood";
		inventory.usesound "sounds/eat";
		Mass wosSoyFoodWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(20);
			Stop;
	}
}
class wosSodaCan : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "soda can"
		
		Tag "$T_SodaCan";
		inventory.icon "I_SDCN";
		Inventory.PickupMessage "$F_SodaCan";
		inventory.usesound "sounds/eat";
		Mass wosSodaCanWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(10);
			Stop;
	}
}
class wosCandyBar : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "candy bar"
		
		Tag "$T_CandyBar";
		inventory.icon "I_CDBR";
		Inventory.PickupMessage "$F_CandyBar";
		inventory.usesound "sounds/eat";
		Mass wosCandyBarWeight;
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 W_foodHeal(15);
			Stop;
	}
}
class wosFoodTrayEmpty : wosPickup {
	Default {
		//$Category "Health and Armor/Food"
		//$Title "Empty Food Tray"
		Tag "$T_FoodTrayEmpty";
		inventory.icon "I_FDTE";
		Inventory.PickupMessage "$F_FoodTrayEmpty";
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
		W_foodHeal(17);
		A_GiveInventory("wosFoodTrayEmpty", 1);
	}

	Default {
		//$Category "Health and Armor/Food"
		//$Title "Food Tray"
		
		Tag "$T_FoodTray";
		inventory.icon "I_FDTR";
		Inventory.PickupMessage "$F_FoodTray";
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
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  deprecated&&unused stuff  //////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
class waterBottle_heal : Health {
	Default {
		Inventory.Amount 5;
	}
}
class beerBottle_heal : Health {
	Default {
		Inventory.Amount 6;
	}
}
class aleBottle_heal : Health {
	Default {
		Inventory.Amount 9;
	}
}
class vineBottle_heal : Health {
	Default {
		Inventory.Amount 7;
	}
}
class spiritsBottle_heal : Health {
	Default { 
		Inventory.Amount 7; 
	}
}
class hamburger_heal : Health {
	Default {
		inventory.amount 5;
	}
}

class cheeseburger_heal : Health {
	Default {
		Inventory.amount 8;
	}
}

class bigburger_heal : Health {
	Default {
		Inventory.amount 11;
	}
}

class cheeseburgerDouble_heal : Health {
	Default {
		Inventory.amount 15;
	}
}
class hotdog_heal : Health {
	Default {
		Inventory.Amount 7;
	}
}


class donuts_heal : Health {
	Default {
		inventory.amount 7;
	}
}

class foodBox_heal : Health {
	Default {
		inventory.amount 15;
	}
}

class foodRation_heal : Health {
	Default {
		inventory.amount 20;
	}
}
class wosGrilledChicken_Heal : Health {
	Default {
		inventory.amount 35;
	}
}
class Vegie1 : health {
	Default {
		Inventory.Amount 10;
	}
}
class Vegie2 : health {
	Default {
		Inventory.Amount 15;
	}
}
class Vegie3 : Health {
	Default {
		Inventory.Amount 10;
	}
}
class Vegie4 : Health {
	Default {
		Inventory.Amount 15;
	}
}
class Vegie5 : Health {
	Default {
		Inventory.Amount 10;
	}
}
class fbMeat1 : Health {
	Default {
		Inventory.Amount 25;
	}
}
class fbMeat2 : Health {
	Default {
		Inventory.Amount 20;
	}
}
class fbMeat3 : Health {
	Default {
		Inventory.Amount 20;
	}
}

class soyFoodHeal : Health {
	Default { 
		inventory.Amount 20; 
	}
}

class sodaCanHeal : Health {
	Default {
		inventory.Amount 10;
	}
}

class candyBarHeal : Health {
	Default {
		inventory.Amount 15;
	}
}

class FoodTrayHeal : Health {
	Default {
		inventory.Amount 17;
	}
}


*/
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////