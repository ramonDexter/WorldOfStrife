//===========================================================================
//
// Tilt++.pk3
//
// Unified player camera tilting for strafing, moving, swimming and death
//
// Written by Nash Muhandes
//
// Feel free to use this in your mods. You don't have to ask my permission!
//
//===========================================================================

class TiltPlusPlusHandler : EventHandler
{
	override void PlayerEntered(PlayerEvent e)
	{
		players[e.PlayerNumber].mo.A_GiveInventory("Z_TiltMe", 1);
	}
}

class Z_TiltMe : CustomInventory
{
	Default
	{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.AUTOACTIVATE
	}

	double strafeInput;
	double moveTiltOsc, underwaterTiltOsc;
	double deathTiltOsc;
	double deathTiltAngle;
	double lastRoll;

	//===========================================================================
	//
	//
	//
	//===========================================================================

	bool bIsOnFloor (void)
	{
		return (Owner.Pos.Z == Owner.FloorZ) || (Owner.bOnMObj);
	}

	bool bIsCrouching (void)
	{
		return Owner.GetCameraHeight() <= (Owner.player.mo.ViewHeight / 2);
	}

	double GetVelocity (void)
	{
		return Owner.Vel.Length();
	}

	int GetWaterLevel (void)
	{
		return Owner.WaterLevel;
	}

	bool bIsPlayerAlive (void)
	{
		return Owner.Health > 0;
	}

	//===========================================================================
	//
	//
	//
	//===========================================================================
	void Tilt_CalcViewRoll (void)
	{
		// CVARS ///////////////////////////////////////////////////////////////
		bool strafeTiltEnabled = sv_strafetilt;
		bool moveTiltEnabled = sv_movetilt;
		bool underwaterTiltEnabled = sv_underwatertilt;
		bool deathTiltEnabled = sv_deathtilt;
		double strafeTiltSpeed = sv_strafetiltspeed;
		double strafeTiltAngle = sv_strafetiltangle;
		bool strafeTiltReversed = sv_strafetiltreversed;
		double moveTiltScalar = sv_movetiltscalar;
		double moveTiltAngle = sv_movetiltangle;
		double moveTiltSpeed = sv_movetiltspeed;
		double underwaterTiltSpeed = sv_underwatertiltspeed;
		double underwaterTiltAngle = sv_underwatertiltangle;
		double underwaterTiltScalar = sv_underwatertiltscalar;

		// Shared variables we'll need later
		double r, v;

		//===========================================================================
		//
		// Strafe Tilting
		//
		//===========================================================================

		// normalized strafe input
		if (strafeTiltEnabled && bIsOnFloor() && bIsPlayerAlive())
		{
			int dir;
			if (strafeTiltReversed) dir = -1;
			else dir = 1;
			strafeInput = strafeTiltSpeed * (Owner.GetPlayerInput(INPUT_SIDEMOVE) / 10240.0);
			strafeInput *= strafeTiltAngle;
			strafeInput *= dir;
		}

		// tilt!
		lastRoll += strafeInput;

		//===========================================================================
		//
		// Movement Tilting
		//
		//===========================================================================

		if (moveTiltEnabled && bIsOnFloor() && bIsPlayerAlive())
		{
			// get player's velocity
			v = GetVelocity() * moveTiltScalar;

			// increment angle
			moveTiltOsc += moveTiltSpeed;

			// clamp angle
			if (moveTiltOsc >= 360. || moveTiltOsc < 0.)
			{
				moveTiltOsc = 0.;
			}

			// calculate roll
			r = Sin(moveTiltOsc);
			r *= moveTiltAngle;
			r *= v;
		}

		// tilt!
		lastRoll += r;

		//===========================================================================
		//
		// Underwater Tilting
		//
		//===========================================================================

		if (GetWaterLevel() >= 3 && underwaterTiltEnabled)
		{
			// fixed rate of 15
			v = 15. * underwaterTiltScalar;

			// increment angle
			underwaterTiltOsc += underwaterTiltSpeed;

			// clamp angle
			if (underwaterTiltOsc >= 360. || underwaterTiltOsc < 0.)
			{
				underwaterTiltOsc = 0.;
			}

			// calculate roll
			r = Sin(underwaterTiltOsc);
			r *= underwaterTiltAngle;
			r *= v;
		}

		// tilt!
		lastRoll += r;

		//===========================================================================
		//
		// Death Tilting
		//
		//===========================================================================

		if (!bIsPlayerAlive() && deathTiltEnabled)
		{
			double deathTiltSpeed = 1.0;

			if (deathTiltAngle == 0)
			{
				// vary the angle a little
				deathTiltAngle = -90.f;
				deathTiltAngle += FRandom(-45.f, 45.f);
				deathTiltAngle *= RandomPick(-1, 1);
			}

			if (deathTiltOsc < 22.5)
			{
				deathTiltOsc += deathTiltSpeed;
			}

			r = Sin(deathTiltOsc);
			r *= deathTiltAngle;
		}
		else
		{
			deathTiltOsc = 0;
			deathTiltAngle = 0;
		}

		// tilt!
		lastRoll += r;

		//===========================================================================
		//
		// Tilt Post Processing
		//
		//===========================================================================

		if (abs(lastRoll) > 0.000001)
		{
			// Stabilize tilt
			lastRoll *= 0.75;

			// Apply the sum of all rolling routines
			// (including after stabilization)
			Owner.A_SetRoll(lastRoll, SPF_INTERPOLATE);
		}
	}

	override void Tick(void)
	{
		if (Owner && Owner is "PlayerPawn")
		{
			Tilt_CalcViewRoll();
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
