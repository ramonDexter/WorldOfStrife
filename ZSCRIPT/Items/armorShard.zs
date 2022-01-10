const armorShardWeight = 5;
class wosArmorShard : wosPickup {
	Default {
		//$Category "Health and Armor/WoS"
		//$Title "Armor Shard"
		
		-SOLID
		+INVENTORY.INVBAR
		
		Tag "$T_ARMORSHARD";
		Inventory.Pickupmessage "$F_ARMORSHARD";
		Inventory.Icon "I_ARKT";
		Inventory.UseSound "items/ARKuse";
		radius 10;
		height 10;
		Mass armorShardWeight;
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;			
		Use:
			TNT1 A 1 {			
				let pawn = binderPlayer(self);
				int maxarmor;
				//nastavit maximální hodnotu armoru podle itemů
				If (pawn.currentarmor==1) { maxarmor=100; }
				If (pawn.currentarmor==2) { maxarmor=200; }
				If (pawn.currentarmor==3) { maxarmor=120; }
				If (pawn.currentarmor==4) { maxarmor=240; }
				If (pawn.currentarmor==5) { maxarmor=360; }				
				 
				If (pawn.armoramount >= maxarmor) { 
					return resolveState("Nope"); 
				} else { 
					return resolveState("UseYes"); 
				}
			}
			Stop;
		UseYes:
			TNT1 A 0 {
				//opravit existující armor
				let pawn = binderPlayer(self);
				pawn.armoramount+=10; 
				A_StartSound("items/ARKuse");
			}
			Stop;
		Nope:
			TNT1 A 0 A_Print("\c[green][ Armor fully repaired! ]");
			Fail;
		
	}
}
