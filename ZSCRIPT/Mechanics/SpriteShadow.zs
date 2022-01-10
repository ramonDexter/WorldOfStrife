//===========================================================================
//
// SpriteShadow
//
// Duke3D-style Actor Shadows
//
// Written by Nash Muhandes
//
// Feel free to use this in your mods. You don't have to ask my permission!
//
//===========================================================================

class Z_SpriteShadowBase : Actor
{
	Default
	{
		+NOINTERACTION
		+MOVEWITHSECTOR
	}

	// reference to owner
	Actor ownerRef;

	override void Tick(void)
	{
		Super.Tick();

		if (ownerRef)
		{
			// sync size of bounding box
			if (Radius != ownerRef.Radius || Height != ownerRef.Height)
			{
				A_SetSize(ownerRef.Radius, ownerRef.Height);
			}

			// sync sprites and angle
			Sprite = ownerRef.Sprite;
			Frame = ownerRef.Frame;
			Angle = ownerRef.Angle;
		}
	}
}

class Z_Shadow : Z_SpriteShadowBase
{
	Default
	{
		RenderStyle "Stencil";
		StencilColor "Black";
	}

	override void Tick(void)
	{
		Super.Tick();

		if (ownerRef)
		{
			// filter your own shadow and hide it from your first person view
			if (ownerRef is "PlayerPawn" && players[consoleplayer].mo == ownerRef)
			{
				if (players[consoleplayer].camera == players[consoleplayer].mo && !(ownerRef.player.cheats & CF_CHASECAM))
				{
					bInvisible = true;
				}
				else
				{
					bInvisible = false;
				}
			}
			else
			{
				// always visible for monsters
				bInvisible = false;
			}

			// prevent shadow from floating in the air
			A_SetSize(1, 1);

			// set alpha
			alpha = ownerRef.Alpha * 0.5;

			// sync scale
			Scale.X = ownerRef.Scale.X;
			Scale.Y = ownerRef.Scale.Y * 0.1;

			// sync position
			Vector3 sPos = (ownerRef.Pos.X, ownerRef.Pos.Y, FloorZ);

			// [EXPERIMENTAL] offset shadow away from camera
			Vector3 viewOffset;
			if (players[consoleplayer].camera)
			{
				viewOffset.X = (cos(players[consoleplayer].camera.Angle) * 0.1);
				viewOffset.Y = (sin(players[consoleplayer].camera.Angle) * 0.1);
				sPos += viewOffset;
			}

			SetOrigin(sPos, true);
		}

		// clean-up
		if (ownerRef && ownerRef.CountInv("Z_ShadeMe") <= 0) Destroy();
		if (!ownerRef) Destroy();
	}
}

class Z_ShadeMe : CustomInventory
{
	// reference to the shadow
	Actor sr;

	Default
	{
		Inventory.MaxAmount 1;
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		+INVENTORY.AUTOACTIVATE
	}

	override void Tick(void)
	{
		if (!sr && Owner)
		{
			// spawn the shadow
			Actor sh = Spawn("Z_Shadow", Owner.Pos, NO_REPLACE);

			if (sh)
			{
				sr = sh;
				Z_Shadow(sh).ownerRef = Owner;
			}
		}

		Super.Tick();
	}

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

class SpriteShadowHandler : EventHandler
{
	// spawn shadows for monsters
	override void WorldThingSpawned(WorldEvent e)
	{
		if (e.Thing.bIsMonster && !e.Thing.CountInv("Z_ShadeMe"))
		{
			e.Thing.A_GiveInventory("Z_ShadeMe", 1);
		}
	}

	// players need to be handled a little differently
	void DoSpawnPlayerShadow(PlayerPawn p)
	{
		if (p) p.A_GiveInventory("Z_ShadeMe", 1);
	}

	void DoRemovePlayerShadow(PlayerPawn p)
	{
		if (p) p.TakeInventory("Z_ShadeMe", 0x7FFFFFFF);
	}

	override void PlayerEntered(PlayerEvent e)
	{
		let p = players[e.PlayerNumber].mo;
		if (p) DoSpawnPlayerShadow(p);
	}

	override void PlayerRespawned(PlayerEvent e)
	{
		let p = players[e.PlayerNumber].mo;
		if (p) DoSpawnPlayerShadow(p);
	}

	override void PlayerDied(PlayerEvent e)
	{
		let p = players[e.PlayerNumber].mo;
		if (p) DoRemovePlayerShadow(p);
	}

	override void WorldUnloaded(WorldEvent e)
	{
		// player is leaving this level, so mark their shadows for destruction
		for (int i = 0; i < MAXPLAYERS; i++)
		{
			let p = players[i].mo;

			if (p && playeringame[i])
			{
				// find the shadow and destroy it
				let shadeMe = Z_ShadeMe(p.FindInventory("Z_ShadeMe"));

				if (shadeMe && shadeMe.sr != null)
				{
					shadeMe.sr.Destroy();
				}

				DoRemovePlayerShadow(p);
			}
		}
	}
}
