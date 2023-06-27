////////////////////////////////////////////////////////////////////////////////
// backpack ////////////////////////////////////////////////////////////////////
// code by ramon.dexter ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosBackpack : wosPickup {
	Default {        
		//$Category "Powerups/WoS"
		//$Title "Backpack"		
		-SOLID;
		+INVENTORY.INVBAR;	
		Tag "$T_wosBackpack";
		Inventory.Pickupmessage "$F_wosBackpack";
		Inventory.Icon "I_WBPK";
		Inventory.UseSound "sounds/armorLight";
		radius 10;
		height 10;
		Mass wosBackpackWeight;
	}    
	States {
		Spawn:
			WBPK A -1;
			Stop;
		Use:
			TNT1 A 0 {
				let pawn = binderPlayer(self);
				if ( pawn.playerBackpack == 1 ) { return resolveState("Undress"); }
				else if ( pawn.playerBackpack == 0 ) { return resolveState("Dress"); }
				return resolveState(null);
			}
			Fail;
		Dress:
			TNT1 A 0 {
				let pawn = binderPlayer(self);
				pawn.playerBackpack = 1;
				A_StartSound("sounds/armorLight");
				A_Log("You've worn the backpack!");
				textureID ID_I_WBP2 = TexMan.CheckForTexture("I_WBP2", 0, 0);
				invoker.icon = ID_I_WBP2;
				invoker.bUNDROPPABLE = true;
			}
			Fail;
		Undress:
			TNT1 A 0 {
				let pawn = binderPlayer(self);
				pawn.playerBackpack = 0;
				A_StartSound("sound/wearClothing");
				A_Log("You've worn the backpack!");
				textureID ID_I_WBPK = TexMan.CheckForTexture("I_WBPK", 0, 0);
				invoker.icon = ID_I_WBPK;
				invoker.bUNDROPPABLE = false;
			}
			Fail;
		Nope:
			TNT1 A 0;
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////