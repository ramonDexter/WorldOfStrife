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
		
		// to prevent reattaching footsteps actor if player returns to map in a hub
		if ( e.IsReturn ) return;
		// to prevent reattaching footsteps actor if player returns to map in a hub

        //VSO: Attach footsteps to player:
		Footsteps fsteps = Footsteps(Actor.Spawn("Footsteps",player.pos));
        fsteps.Init(player);
	}
	/*override void PlayerDisconnected(PlayerEvent e) {
		//Footsteps fsteps = footsteps("footsteps");
		//fsteps.Destroy();
	}*/
	// cheats & debug //////////////////////////////////////////////////////////
	override void NetworkProcess(ConsoleEvent e) {
        let pawn = binderPlayer(players[e.Player].mo);

		// ACS support //
		

        if ( e.Name == "give_binderPackRegular" ) {
            pawn.A_GiveInventory("binder_helmet", 1);
			pawn.A_GiveInventory("shoulderGun", 1);
			pawn.A_GiveInventory("magazine_shoulderGun", 32);
			pawn.A_GiveInventory("StaffBlaster", 1);
			pawn.A_GiveInventory("laserpistol", 1);
			//armor
			pawn.A_GiveInventory("wosKineticArmor", 1);
			//ammo
			pawn.A_GiveInventory("EnergyPod", 400);
			pawn.A_GiveInventory("wosenergykit", 10);
			pawn.A_GiveInventory("shoulderGunCharger", 1);
			//grenades
			pawn.A_GiveInventory("wosGrenadeE", 15);
			pawn.A_GiveInventory("wosGrenadeF", 15);
			pawn.A_GiveInventory("wosGrenadeG", 15);
			pawn.A_GiveInventory("wosArmorShard", 10);
			//medical
			pawn.A_GiveInventory("wosHyposprej", 30);
			pawn.A_GiveInventory("wosKombopack", 10);
			pawn.A_GiveInventory("wosInstaLek", 5);
			//BlasterTurret_item
			pawn.A_GiveInventory("wosInterceptordrone", 5);	
			//DeployableShieldItem
			pawn.A_GiveInventory("wosDeployableShield", 1);
			//Swarmers_item
			pawn.A_GiveInventory("wosSwarmers", 5);
			// goldCoin x2500
			pawn.A_GiveInventory("goldCoin", 2500);
        } else if ( e.Name == "give_binderpackLight" ) {
			pawn.A_GiveInventory("binder_helmet", 1);
			// weapons
			pawn.A_GiveInventory("shoulderGun", 1);
			pawn.A_GiveInventory("magazine_shoulderGun", 32);
			pawn.A_GiveInventory("StaffBlaster", 1);
			// armor
			pawn.A_GiveInventory("wosKineticArmor", 1);
			// ammo
			pawn.A_GiveInventory("EnergyPod", 400);
			pawn.A_GiveInventory("wosenergykit", 10);
			pawn.A_GiveInventory("shoulderGunCharger", 1);
			// medical
			pawn.A_GiveInventory("wosHyposprej", 20);
			pawn.A_GiveInventory("wosKombopack", 5);
			pawn.A_GiveInventory("wosInstaLek", 2);
			pawn.A_GiveInventory("wosKombopack", 5);
			// grenades
			pawn.A_GiveInventory("wosGrenadeE", 5);
			pawn.A_GiveInventory("wosGrenadeF", 5);
			pawn.A_GiveInventory("wosInstaLek", 5);
			// gold
			pawn.A_GiveInventory("goldCoin", 2500);
		} else if ( e.Name == "give_allarmor" ) {
			pawn.A_GiveInventory("wosLeatherArmor", 1);
			pawn.A_GiveInventory("wosMetalArmor", 1);
			pawn.A_GiveInventory("wosBinderArmorBasic", 1);
			pawn.A_GiveInventory("wosBinderArmorAdvanced", 1);
			pawn.A_GiveInventory("wosKineticArmor", 1);
		} else if ( e.Name == "give_allweapons" ) {
			pawn.A_GiveInventory("wosStrifeXbow", 1);
			pawn.A_GiveInventory("StormPistol", 1);
			pawn.A_GiveInventory("laserPistol", 1);
			pawn.A_GiveInventory("wosAssaultGun", 1);
			pawn.A_GiveInventory("staffBlaster", 1);
			pawn.A_GiveInventory("wosMinimissileLauncher", 1);
			pawn.A_GiveInventory("wosFlamethrower", 1);
			pawn.A_GiveInventory("wosGrenadeLauncher", 1);
			pawn.A_GiveInventory("wosMauler", 1);
		} else if ( e.Name == "give_shouldergun" ) {
			pawn.A_GiveInventory("shoulderGun", 1);
			pawn.A_GiveInventory("magazine_shoulderGun", 32);
			pawn.A_GiveInventory("shoulderGunCharger", 1);
		} else if ( e.Name == "give_10Accuracy" ) {
			pawn.A_GiveInventory("upgradeAccuracy", 1);
		} else if ( e.Name == "give_10Stamina" ) {
			pawn.A_GiveInventory("UpgradeStamina", 10);
		} else if ( e.Name == "give_10Mind" ) {
			pawn.A_GiveInventory("upgradeMind", 1);
		} else if ( e.Name == "give_20Accuracy" ) {
			pawn.A_GiveInventory("upgradeAccuracy", 1);
			pawn.A_GiveInventory("upgradeAccuracy", 1);
		} else if ( e.Name == "give_20Stamina" ) {
			pawn.A_GiveInventory("UpgradeStamina", 20);
		} else if ( e.Name == "give_20Mind" ) {
			pawn.A_GiveInventory("upgradeMind", 1);
			pawn.A_GiveInventory("upgradeMind", 1);
		} else if ( e.Name == "give_40accuracy" ) {
			pawn.A_GiveInventory("upgradeAccuracy", 1);
			pawn.A_GiveInventory("upgradeAccuracy", 1);
			pawn.A_GiveInventory("upgradeAccuracy", 1);
			pawn.A_GiveInventory("upgradeAccuracy", 1);
		} else if ( e.Name == "give_40stamina" ) {
			pawn.A_GiveInventory("UpgradeStamina", 40);
		} else if ( e.Name == "give_40Mind" ) {
			pawn.A_GiveInventory("upgradeMind", 1);
			pawn.A_GiveInventory("upgradeMind", 1);
			pawn.A_GiveInventory("upgradeMind", 1);
			pawn.A_GiveInventory("upgradeMind", 1);
		} else if ( e.Name == "log_pawnmaxhealth" ) {
			pawn.A_logInt(pawn.GetMaxHealth(true));
		} else if ( e.Name == "heal_Player" ) {
			pawn.A_GiveInventory("surgUnitHealing", 1);
		}
		// ACS script support //
		else if ( e.Name == "selectDagger" ) {
			pawn.A_SelectWeapon("wosPunchDagger");
		}
    }
	////////////////////////////////////////////////////////////////////////////
	

}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
