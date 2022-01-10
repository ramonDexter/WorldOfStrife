////////////////////////////////////////////////////////////////////////////////
//  WoS event handler  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// bleeding code by jarewill
// armor hit display code by heydoomer
//
//
//
////////////////////////////////////////////////////////////////////////////////
class wosEventHandler : EventHandler {

	// armor screen hit display by heydoomer ///////////////////////////////////
	bool bGrid;
	int tCounter;
	int armor;

	struct hex {
		int x1;
		int y1;
		int x2;
		int y2;
	}
	hex sides[6];
	
	override void WorldLoaded(WorldEvent e) {
		bGrid = false;

		sides[0].x1 = -40;
		sides[0].y1 = 0;
		sides[0].x2 = -20;
		sides[0].y2 = 33;
		
		sides[1].x1 = -20;
		sides[1].y1 = 33;
		sides[1].x2 = 20;
		sides[1].y2 = 33;

		sides[2].x1 = 20;
		sides[2].y1 = 33;
		sides[2].x2 = 40;
		sides[2].y2 = 0;

		sides[3].x1 = 40;
		sides[3].y1 = 0;
		sides[3].x2 = 20;
		sides[3].y2 = -33;

		sides[4].x1 = 20;
		sides[4].y1 = -33;
		sides[4].x2 = -20;
		sides[4].y2 = -33;

		sides[5].x1 = -20;
		sides[5].y1 = -33;
		sides[5].x2 = -40;
		sides[5].y2 = 0;
	}
	override void RenderOverlay(RenderEvent e) {
			
		if (bGrid) {
			color hexColor = armor > 300 ? "Cyan" : armor > 200 ? "Green" : armor > 100 ? "Yellow" : "Red";
			int alpha = 80;
			double thickness = 5;
			int edge = 400;

			int X = 100;
			int Y = int(Screen.GetHeight() * 0.5);
			int radius = Screen.GetWidth() - 100 - X;

			int rFrom = int(Screen.GetWidth() * 0.75);
			int rTo = Screen.GetWidth() - 100;

			double inc = 0;
			for (int radius = rFrom; radius < rTo; radius += 85) {
				for (double ang = 0; ang < 360; ang += 5) {
					if (ang < 360 || ang > 0) {
//						console.printf("ang: %d", ang);

						if (Random(1, 50) < armor) {
							int cX = X + int(radius * cos(ang + inc));
							int cY = Y + int(radius * sin(ang + inc));

							if (cX > 0 && cX < Screen.GetWidth() && cY > 0 && cY < Screen.GetHeight()) {
								for (int i = 0; i < 6; i++) {
									Screen.DrawThickLine(cX + sides[i].x1, cY + sides[i].y1, cX + sides[i].x2, cY + sides[i].y2, thickness, hexColor, alpha);
								}
							}
						}
					}
				}
				inc += 2.5;
			}

			X = Screen.GetWidth() - 100;
			inc = 0;
			for (int radius = rFrom; radius < rTo; radius += 85) {
				for (double ang = 0; ang < 360; ang += 5) {
					if (ang < 360 || ang > 0) {
						if (Random(1, 50) < armor) {
							int cX = X - int(radius * cos(ang + inc));
							int cY = Y + int(radius * sin(ang + inc));

							if (cX > 0 && cX < Screen.GetWidth() && cY > 0 && cY < Screen.GetHeight()) {
								for (int i = 0; i < 6; i++)
								{
									Screen.DrawThickLine(cX + sides[i].x1, cY + sides[i].y1, cX + sides[i].x2, cY + sides[i].y2, thickness, hexColor, alpha);
								}
							}
						}
					}
				}
				inc += 2.5;
			}
		}
	}
	override void WorldTick() {
		if (tCounter < 14) {
			tCounter++;
		} else {
			bGrid = false;
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
    override void WorldThingDamaged(WorldEvent e) {
        if (e.thing && e.Thing is "binderPlayer") {
            let pawn = binderPlayer(e.Thing);
			If(e.Damage>9/*&&(e.DamageType=="Bullet"||e.DamageType=="Melee")*/) {
				//console.printf(string.format("%i", pawn.bleedlevel));
				pawn.bleedlevel++;				
				If(pawn.bleedlevel>5){pawn.bleedlevel=5;}
			}
            pawn.stamin -= e.Damage*7;
            if (pawn.stamin<0) {
                pawn.stamin = 0;
            }
			// armor screen hit display by heydoomer ///////////////////////////
			armor = pawn.armoramount;
			if ( armor > 0 && pawn.currentarmor == 5 ) {
				//pawn.A_print("!!!HIT!!!");
				pawn.A_StartSound("sounds/armorhit", CHAN_BODY, CHANF_OVERLAP);
				bGrid = true;
				tCounter = 0;
			}
			////////////////////////////////////////////////////////////////////
        }
    }
	override void PlayerEntered(PlayerEvent e) {
		let player = PlayerPawn(players[e.PlayerNumber].mo);
		//BEGIN VSO : Some Wads crash here with VM Abort because player can be NULL
		if (player == NULL) {
			return;
		}
		//END VSO
        //VSO: Attach footsteps to player:
		Footsteps fsteps = Footsteps(Actor.Spawn("Footsteps",player.pos));
        fsteps.Init(player);
	}
	
	

}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
