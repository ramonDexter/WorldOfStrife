//===========================================================================
//
// nashmove.pk3
//
// Less slippery player movement. Works for any player class.
//
// Written by Nash Muhandes
//
// Feel free to use this in your mods. You don't have to ask my permission!
//
//===========================================================================

class NashMoveHandler : EventHandler
{
	override void PlayerEntered(PlayerEvent e)
	{
		players[e.PlayerNumber].mo.A_GiveInventory("Z_NashMove", 1);
	}
}

class Z_NashMove : CustomInventory
{
	Default
	{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.AUTOACTIVATE
	}

	// How much to reduce the slippery movement.
	// Lower number = less slippery.
	const DECEL_MULT = 0.8;

	//===========================================================================
	//
	//
	//
	//===========================================================================

	bool bIsOnFloor(void)
	{
		return (Owner.Pos.Z == Owner.FloorZ) || (Owner.bOnMObj);
	}

	bool bIsInPain(void)
	{
		State PainState = Owner.FindState('Pain');
		if (PainState != NULL && Owner.InStateSequence(Owner.CurState, PainState))
		{
			return true;
		}
		return false;
	}

	double GetVelocity (void)
	{
		return Owner.Vel.Length();
	}

	//===========================================================================
	//
	//
	//
	//===========================================================================

	override void Tick(void)
	{
		if (Owner && Owner is "PlayerPawn")
		{
			if (bIsOnFloor())
			{
				// bump up the player's speed to compensate for the deceleration
				// TO DO: math here is shit and wrong, please fix
				double s = 1.0 + (1.0 - DECEL_MULT);
				Owner.A_SetSpeed(s * 2);

				// decelerate the player, if not in pain
				if (!bIsInPain())
				{
					Owner.vel.x *= DECEL_MULT;
					Owner.vel.y *= DECEL_MULT;
				}

				// make the view bobbing match the player's movement
				PlayerPawn(Owner).ViewBob = DECEL_MULT;
			}
		}

		Super.Tick();
	}

	//===========================================================================
	//
	//
	//
	//===========================================================================
	States
	{
	Use:
		TNT1 A 0;
		Fail;
	Pickup:
		TNT1 A 0
		{
			return true;
		}
		Stop;
	}
}
