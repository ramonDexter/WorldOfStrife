class wosPickup : CustomInventory {
    int stack;
    property Stack : stack;
    bool onlyone;
    property Only : onlyone;

    override bool TryPickup (in out Actor toucher) {
        if (onlyone==1 && toucher.CountInv(self.GetClassName())>0) {
            return 0;
        }
        Else {
            return super.TryToPickup(toucher);
        }
    }
    override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.encumbrance+=self.mass;
    }
    override void DoEffect() {
        super.DoEffect();
        let pawn = binderPlayer(owner);
        if (onlyone==0) {
            pawn.encumbrance+=self.mass*self.amount;
        }
        else {
            pawn.encumbrance+=self.mass;
        }
    }
    override void OnDrop (Actor dropper) {
        if (self.stack>0) {
            let whatto = self.GetClassName();
            int todrop = dropper.CountInv(whatto);
            if (todrop>self.stack-1) {
                todrop = self.stack - 1;
            }
            dropper.takeInventory(self.GetClassName(), todrop);
            self.amount = todrop + 1;
            super.OnDrop(dropper);
        }
    }

    Default {
		+INVENTORY.INVBAR
        Inventory.Amount 1;
		Inventory.MaxAmount 999;
		Inventory.InterHubAmount 999;
		Inventory.PickupSound "misc/i_pkup";
		Mass 0;
    }
}

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
		radius 12;
		height 12;		
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