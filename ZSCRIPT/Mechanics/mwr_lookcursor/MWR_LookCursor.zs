class MWR_LookCursorInv : MWR_Cursor3dInv{
	
	override void DoBeforeDisable(){
		Console.Printf(MWR_DescriberProvider.YouSee_LineTraceHit(tCursorHit,owner,true,false));
	}
}

class MWR_LookCursorHandler : EventHandler{
	override void NetworkProcess(ConsoleEvent e){
		if (e.Name == "mwr_lookcursor_on"){
			SetCursorEnabled(e.Player, true);
		} else if (e.Name == "mwr_lookcursor_off"){
			SetCursorEnabled(e.Player, false);
		}
	}

	private void SetCursorEnabled(int player, bool enabled){
		if (playeringame[player]){
			let myInv = MWR_LookCursorInv(players[player].mo.FindInventory('MWR_LookCursorInv'));
			
			if (myInv == null){
				players[player].mo.GiveInventory('MWR_LookCursorInv',1);
				myInv = MWR_LookCursorInv(players[player].mo.FindInventory('MWR_LookCursorInv'));
			}
			

			if (myInv != null){
				if (enabled){
					myInv.EnableCursor();
				} else {
					myInv.DisableCursor();
				}
			} else {
				console.printf('[ERROR]No look cursor in inventory');
			}
		}
	}
}
