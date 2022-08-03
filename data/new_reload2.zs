    Action void W_CheckAmmo(int much = 1) {
		If(Invoker.Magazine<much){Player.SetPSprite(PSP_WEAPON,invoker.FindState("Nope"));}
	}
    
    action void W_reloadCheck2() {
		if ( player == null ) {
			return;
		}
		// check if no ammo and default to dagger
		if ( invoker.magazine == 0 && !invoker.magazineType ) {
			A_Log("\c[red]Ammo depleted!");
			player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetDownState());
			A_SelectWeapon("wospunchdagger");
			//Player.SetPSprite(PSP_WEAPON,invoker.FindState("Nope"));
			return;
		} else {
			// check if magazine is full or not && if player has ammo to reload
			if ( CountInv(invoker.magazineType) > 0 && invoker.magazine < invoker.magazineMax ) {
				Player.SetPSprite(PSP_WEAPON,invoker.FindState("DoReload"));
			} else {
				// if magazine is full, return to ready
				if (invoker.magazine == invoker.magazineMax) {
					//.. vrati se do 'ready'
					A_Log("\c[green]Ammo full!");
					Player.SetPSprite(PSP_WEAPON,invoker.FindState("Ready"));
				}
			}
		}
	}
	action void W_Reload2() {
		if ( player == null ) {
			return;
		}	
		if ( invoker.magazine == 0 || !invoker.magazineType ) {
			//return ResolveState("Ready");
			A_Log("\c[red]Not enough ammo!");
			player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetDownState());
			A_SelectWeapon("wospunchdagger");
		} 
		//ammoAmount = min (FindInventory (invoker.ammoType1).maxAmount - CountInv (invoker.ammoType1), CountInv (invoker.ammoType2));
		int ammoAmount = invoker.magazineMax - invoker.magazine;
		if (ammoAmount <= 0) { 
		//do nothing
		} else { 
			invoker.magazine += ammoAmount;
			TakeInventory (invoker.magazineType, ammoAmount);
		}
		//return ResolveState ("ReloadFinish");
	}