////////////////////////////////////////////////////////////////////////////////
//  WoS StatusBAR  /////////////////////////////////////////////////////////////
//  based on strife statusbar  /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosStatusBar : BaseStatusBar {
	
	InventoryBarState diparms;
	InventoryBarState diparms_argsbar;

	// Number of tics to move the popscreen up and down.
	const POP_TIME = (Thinker.TICRATE/8);

	// Popscreen height when fully extended
	const POP_HEIGHT = 104;

	// Number of tics to scroll keys left
	const KEY_TIME = (Thinker.TICRATE/3);

	enum eImg {
		imgINVCURS,
		imgCURSOR01,
		imgINVPOP,
		imgINVPOP2,
		imgINVPBAK,
		imgINVPBAK2,
		imgFONY0,
		imgFONY1,
		imgFONY2,
		imgFONY3,
		imgFONY4,
		imgFONY5,
		imgFONY6,
		imgFONY7,
		imgFONY8,
		imgFONY9,
		imgFONY_PERCENT,
		imgSTFON0,
		imgSTFON1,
		imgSTFON2,
		imgSTFON3,
		imgSTFON4,
		imgSTFON5,
		imgSTFON6,
		imgSTFON7,
		imgSTFON8,
		imgSTFON9,
		imgSTFON_PERCENT,
		imgNEGATIVE,
	};
	
	
	TextureID Images[imgNEGATIVE + 1];
	int CursorImage;
	int CurrentPop, PendingPop, PopHeight, PopHeightChange;
	int KeyPopPos, KeyPopScroll;
	
	HUDFont mYelFont, mGrnFont, mBigFont, mESfont;
	HUDFont mIndexFont;

	override void Init() {
		static const Name strifeLumpNames[] = {
			"INVCURS", "CURSOR01", "INVPOP", "INVPOP2",
			"INVPBAK", "INVPBAK2",
			"INVFONY0", "INVFONY1", "INVFONY2", "INVFONY3", "INVFONY4",
			"INVFONY5", "INVFONY6", "INVFONY7", "INVFONY8", "INVFONY9",
			"INVFONY%", 
			"STFON0", "STFON1", "STFON2", "STFON3", "STFON4", 
			"STFON5", "STFON6", "STFON7", "STFON8", "STFON9", "STFON%", ""

		};
		
		Super.Init();
		SetSize(0, 320, 200); //size
		Reset();
		
		for(int i = 0; i <= imgNEGATIVE; i++) {
			Images[i] = TexMan.CheckForTexture(strifeLumpNames[i], TexMan.TYPE_MiscPatch);
		}

		CursorImage = Images[imgINVCURS].IsValid() ? imgINVCURS : imgCURSOR01;
		Font fnt = "INDEXFONT";
		mYelFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), true, 1, 1);
		mGrnFont = HUDFont.Create(fnt, fnt.GetCharWidth("0"), true, 1, 1);
		mBigFont = HUDFont.Create("BigFont", 0, false, 2, 2);
        mESfont = HUDFont.Create("ESFONT", 0, false, 1, 1);

        diparms_argsbar = InventoryBarState.CreateNoBox(mYelFont, boxsize:(36, 30), innersize:(40, 30), arrowoffs:(0, 0));

        
	}

	override void NewGame () {
		Super.NewGame();
		Reset ();
	}

	override int GetProtrusion(double scaleratio) const {
		return 10;
	}

	override void Draw (int state, double TicFrac) {
		Super.Draw (state, TicFrac);

		if (state == HUD_StatusBar) {
			BeginStatusBar();
			DrawMainBar (TicFrac);
		}
		else {
			if (state == HUD_Fullscreen) {
				//BeginHUD();
				//DrawFullScreenStuff ();
				BeginStatusBar();
				DrawMainBar (TicFrac);
			}

			// Draw pop screen (log, keys, and status)
			if (CurrentPop != POP_None && PopHeight < 0) {
				// This uses direct low level draw commands and would otherwise require calling
				// BeginStatusBar(true);
				DrawPopScreen (screen.GetHeight(), TicFrac);
			}
		}
	}

	override void ShowPop (int popnum) {
		Super.ShowPop(popnum);
		if (popnum == CurrentPop) {
			if (popnum == POP_Keys) {
				Inventory item;

				KeyPopPos += 10;
				KeyPopScroll = 280;

				int i = 0;
				for (item = CPlayer.mo.Inv; item != NULL; item = item.Inv) {
					if (item is "Key") {
						if (i == KeyPopPos) {
							return;
						}
						i++;
					}
				}
			}
			PendingPop = POP_None;
			// Do not scroll keys horizontally when dropping the popscreen
			KeyPopScroll = 0;
			KeyPopPos -= 10;
		}
		else {
			KeyPopPos = 0;
			PendingPop = popnum;
		}
	}

	override bool MustDrawLog(int state) {
		// Tell the base class to draw the log if the pop screen won't be displayed.
		return false;
	}

	void Reset () {
		CurrentPop = POP_None;
		PendingPop = POP_NoChange;
		PopHeight = 0;
		KeyPopPos = 0;
		KeyPopScroll = 0;
	}

	override void Tick () {
		Super.Tick ();

		PopHeightChange = 0;
		if (PendingPop != POP_NoChange) {
			if (PopHeight < 0) {
				PopHeightChange = POP_HEIGHT / POP_TIME;
				PopHeight += POP_HEIGHT / POP_TIME;
			}
			else {
				CurrentPop = PendingPop;
				PendingPop = POP_NoChange;
			}
		}
		else {
			if (CurrentPop == POP_None) {
				PopHeight = 0;
			}
			else if (PopHeight > -POP_HEIGHT) {
				PopHeight -= POP_HEIGHT / POP_TIME;
				if (PopHeight < -POP_HEIGHT) {
					PopHeight = -POP_HEIGHT;
				}
				else {
					PopHeightChange = -POP_HEIGHT / POP_TIME;
				}
			}
			if (KeyPopScroll > 0) {
				KeyPopScroll -= 280 / KEY_TIME;
				if (KeyPopScroll < 0) {
					KeyPopScroll = 0;
				}
			}
		}
	}

	// health indicator ////////////////////////////////////////////////////////
	private void FillBar(double x, double y, double start, double stopp, Color color1, Color color2) {
		Fill(color1, x, y, (stopp-start)*2, 1);
		Fill(color2, x, y+1, (stopp-start)*2, 1);
	}
	
	protected void DrawHealthBar(int health, int x, int y) {
		Color green1 = Color(255, 180, 228, 128);	// light green
		Color green2 = Color(255, 128, 180, 80);	// dark green

		Color blue1 = Color(255, 196, 204, 252);	// light blue
		Color blue2 = Color(255, 148, 152, 200);	// dark blue

		Color gold1 = Color(255, 224, 188, 0);	// light gold
		Color gold2 = Color(255, 208, 128, 0);	// dark gold

		Color red1 = Color(255, 216, 44,  44);	// light red
		Color red2 = Color(255, 172, 28,  28);	// dark red

		Color grey1 = Color(255, 44, 44,  44);	// light grey
		Color grey2 = Color(255, 28, 28,  28);	// dark grey
		
		Color azure1 = Color(255, 143, 195, 211);
		Color azure2 = Color(255, 59, 127, 139);
		
		if (health == 999) {
				FillBar(x, y-4, 0, 14, azure2, azure2);
				FillBar(x, y-2, 0, 14, azure2, azure2);
				FillBar(x, y, 0, 14, azure1, azure1);
				FillBar(x, y+2, 0, 14, azure1, azure1);
				FillBar(x, y+4, 0, 14, azure2, azure2);
				FillBar(x, y+6, 0, 14, azure2, azure2);
		}
		else {
			if (health == 0) {
				FillBar(x, y-4, 0, 14, grey2, grey2);
				FillBar(x, y-2, 0, 14, grey2, grey2);
				FillBar(x, y, 0, 14, grey1, grey1);
				FillBar(x, y+2, 0, 14, grey1, grey1);
				FillBar(x, y+4, 0, 14, grey2, grey2);
				FillBar(x, y+6, 0, 14, grey2, grey2);
			} else if ( health <= 33 ) {
				FillBar(x, y-4, 0, 14, red2, red2);
				FillBar(x, y-2, 0, 14, red2, red2);
				FillBar(x, y, 0, 14, red1, red1);
				FillBar(x, y+2, 0, 14, red1, red1);
				FillBar(x, y+4, 0, 14, red2, red2);
				FillBar(x, y+6, 0, 14, red2, red2);
			} else if ( health <= 66 ) {
				FillBar(x, y-4, 0, 14, gold2, gold2);
				FillBar(x, y-2, 0, 14, gold2, gold2);
				FillBar(x, y, 0, 14, gold1, gold1);
				FillBar(x, y+2, 0, 14, gold1, gold1);
				FillBar(x, y+4, 0, 14, gold2, gold2);
				FillBar(x, y+6, 0, 14, gold2, gold2);
			} else if ( health<=88 ) {
				FillBar(x, y-4, 0, 14, blue2, blue2);
				FillBar(x, y-2, 0, 14, blue2, blue2);
				FillBar(x, y, 0, 14, blue1, blue1);
				FillBar(x, y+2, 0, 14, blue1, blue1);
				FillBar(x, y+4, 0, 14, blue2, blue2);
				FillBar(x, y+6, 0, 14, blue2, blue2);
			} else {
				FillBar(x, y-4, 0, 14, green2, green2);
				FillBar(x, y-2, 0, 14, green2, green2);
				FillBar(x, y, 0, 14, green1, green1);
				FillBar(x, y+2, 0, 14, green1, green1);
				FillBar(x, y+4, 0, 14, green2, green2);
				FillBar(x, y+6, 0, 14, green2, green2);
			}			
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	
	//##########################################################################
	//## main status bar #######################################################
	//##########################################################################
	protected void DrawMainBar (double TicFrac) {        
		Inventory item; //temp item variable holder
		int i; // temp counter variable
		
		//  Pop screen (log, keys, and status)  ////////////////////////////////
		if (CurrentPop != POP_None && PopHeight < 0) {
			double tmp, h;
			[tmp, tmp, h] = StatusbarToRealCoords(0, 0, 8);
			DrawPopScreen (int(GetTopOfStatusBar() - h), TicFrac);
		}
		
		//  zobrazit statusbar jenom pokud ma hrac helmu  //////////////////////
        item = CPlayer.mo.FindInventory('binder_helmet');
        if (item != null ) {     
		
            //  draw statusbar frame  //////////////////////////////////////////
            drawImage ("HUDfrmT", (-54, 0), DI_ITEM_OFFSETS);
            drawImage ("HUDiB", (-54, 0), DI_ITEM_OFFSETS, 0.5);

            //  Health  ////////////////////////////////////////////////////////
            DrawString(mGrnFont, FormatNumber(CPlayer.health, 3, 19), (359, 20), DI_TEXT_ALIGN_RIGHT, Font.CR_DARKRED);
            int points;        
            if (CPlayer.cheats & CF_GODMODE) {
                points = 999;
            }
            else {
                points = min(CPlayer.health, 200);				
            }			
            DrawHealthBar (points, 339, 8);

			// stamina bar /////////////////////////////////////////////////////
			let pawn = binderPlayer(CPlayer.mo);
			DrawBar("stamBar", "stamBck", pawn.stamin, 350, (369, 97), 0, 3);

            //  Armor  /////////////////////////////////////////////////////////			
			let armo = binderPlayer(CPlayer.mo);
			If(armo.currentarmor > 0 && armo.armoramount > 0) {
				string armortype;
				If(armo.currentarmor==1){armortype="I_ARM2";}Else If(armo.currentarmor==2){armortype="I_ARM1";}Else If(armo.currentarmor==3){armortype="I_RGA1";}Else If(armo.currentarmor==4){armortype="I_RGA2";}Else If(armo.currentarmor==5){armortype="I_SHLD";}
				DrawImage(armortype,(-56, 0),DI_ITEM_OFFSETS);
				//DrawString(mYelFont, FormatNumber(item.Amount, 3, 5), (362, 19), DI_TEXT_ALIGN_RIGHT, Font.CR_LIGHTBLUE);
				//DrawInventoryIcon(armortype, (120, 177), DI_ITEM_OFFSETS);
				If(armo.currentarmor!=6){DrawString(mYelFont, FormatNumber(armo.armoramount, 3, 5), (-31, 30), DI_TEXT_ALIGN_RIGHT, Font.CR_LIGHTBLUE);}
			}

            //  Ammo  //////////////////////////////////////////////////////////		
            Inventory ammo1, ammo2; 
            [ ammo1, ammo2 ]= GetCurrentAmmo ();
            if (ammo2 != NULL) {
                DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3, 5), (-12, 33), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
                DrawString(mGrnFont, FormatNumber(ammo2.Amount, 3, 5), (-12, 40), DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);		
				//drawBar int vertical == 0 left>right; 1 right>left; 2 down>up; 3 up>down
				DrawBar("mgznBar", "mgznBck", ammo1.Amount, ammo1.MaxAmount, (-18, 31), 0, 3);				
                DrawInventoryIcon (ammo2, (-25, 2), DI_ITEM_OFFSETS);
            } else if ( ammo1 != NULL ) {
				DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3, 5), (-12, 37), DI_TEXT_ALIGN_RIGHT, Font.CR_GOLD);
				//DrawString(mGrnFont, FormatNumber(ammo2.Amount, 3, 5), (370, 148), DI_TEXT_ALIGN_RIGHT);		
				DrawBar("mgznBar", "mgznBck", ammo1.Amount, ammo1.MaxAmount, (-18, 31), 0, 3);
				DrawInventoryIcon (ammo1, (-25, 2), DI_ITEM_OFFSETS);
			}			
			
            //  weapon icon  ///////////////////////////////////////////////////
            item = CPlayer.ReadyWeapon;
            if ( item != null ) {
                DrawInventoryIcon(CPlayer.ReadyWeapon, (20, 1), DI_ITEM_OFFSETS);
            }            

            //  shoulderGun icon + ammo display  ///////////////////////////////
            inventory shldGun;
            inventory shldGunAmmo;
            shldGun = CPlayer.mo.FindInventory("shoulderGun");
            shldGunAmmo = CPlayer.mo.FindInventory("shldrGunMag");
            int shldGunAmmoCount = CPlayer.mo.CountInv("shldrGunMag");

            if ( shldGun != null ) {
                drawImage ("HUDshgf", (-54, 0), DI_ITEM_OFFSETS);
				if ( shldGunAmmo != null ) {
					DrawString (mGrnFont, FormatNumber(shldGunAmmo.Amount, 3, 5), (-42, 62), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
				}
            }

            //  selected inventory display  ////////////////////////////////////
			if (CPlayer.mo.InvSel != null) {
				DrawInventoryIcon(CPlayer.mo.InvSel, (-23, 179), DI_ARTIFLASH|DI_ITEM_CENTER, boxsize:(28, 28));
				item = CPlayer.mo.InvSel;
				/*wosPickup itemCharge = wosPickup(item);
				if (item.Amount == 1 && item is "wosPickup" && itemCharge.charge > 0) {
					DrawString(mYelFont, FormatNumber(itemCharge.charge, 3, 5, 0, ""), (-8, 188), DI_TEXT_ALIGN_RIGHT, Font.CR_CYAN);
				} else*/ if (item.Amount > 1) {					
					DrawString(mYelFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3, 5, 0, ""), (-8, 188), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
				} 
			}			

            //  inventory  pop - up  ///////////////////////////////////////////
            if ( isInventoryBarVisible() ) {
                drawImage ("invBACK", (-54, 0), DI_ITEM_OFFSETS);
                //CPlayer.inventorytics = 0;
				CPlayer.mo.InvFirst = ValidateInvFirst (7);
				// display all items overall weight in open inventory //////////
				let wght = binderPlayer(CPlayer.mo);
				if ( wght != NULL ) {
					DrawString (mESfont, FormatNumber(wght.encumbrance, 3, 5, 0, "Weight: "), (40, 156), DI_TEXT_ALIGN_LEFT, Font.CR_GREEN);				
				}
				////////////////////////////////////////////////////////////////
				
				let coins = CPlayer.mo.FindInventory("goldCoin");
				if ( coins != null ) {
					DrawString(mESfont, FormatNumber(coins.Amount, 3, 5, 0, "Coins: "), (280, 156), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
				}
				
				// draw items bar //////////////////////////////////////////////
				i = 0;
				for (item = CPlayer.mo.InvFirst; item != NULL && i < 7; item = item.NextInv()) {
					int flags = item.Amount <= 0? DI_ITEM_OFFSETS|DI_DIM : DI_ITEM_OFFSETS;
					if (item == CPlayer.mo.InvSel) {
						DrawTexture (Images[CursorImage], (29 + 35*i, 167), flags, 1. - itemflashFade);
					}
					DrawInventoryIcon (item, (35 + 35*i, 169), flags);
					// display item weight
					if (item.Mass > 0) {
						DrawString(mESfont, FormatNumber(item.Mass, 3, 5, 0, "W:"), (65 + 35*i, 168), DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
					}
					// display item amount
					// display item charge
					/*wosPickup itemCharge = wosPickup(item);
					if (item.Amount == 1 && item is "wosPickup" && itemCharge.charge > 0) {
						DrawString(mESfont, FormatNumber(itemCharge.charge, 3, 5, 0, "C:"), (65 + 35*i, 192), DI_TEXT_ALIGN_RIGHT, Font.CR_CYAN);						
					} else*/ if (item.Amount > 1) { //item.Amount > 1
						DrawString(mESfont, FormatNumber(item.Amount, 3, 5, 0, "A:"), (65 + 35*i, 192), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
					} 
					i++;
				}
				////////////////////////////////////////////////////////////////
            }
			////////////////////////////////////////////////////////////////////
        }
        
	}
	//##########################################################################
	//##########################################################################
	//##########################################################################

	// fullscreen statusbar replaced with mainBar
	/*protected void DrawFullScreenStuff () {
		// Draw health (use red color if health is below the run health threashold.)
		DrawString(mGrnFont, FormatNumber(CPlayer.health, 3), (4, -10), DI_TEXT_ALIGN_LEFT, (CPlayer.health < CPlayer.mo.RunHealth)? Font.CR_BRICK : Font.CR_UNTRANSLATED);
		DrawImage("I_MDKT", (14, -17));

		// Draw armor
		let armor = CPlayer.mo.FindInventory('BasicArmor');
		if (armor != NULL && armor.Amount != 0)
		{
			DrawString(mYelFont, FormatNumber(armor.Amount, 3), (35, -10));
			DrawInventoryIcon(armor, (45, -17));
		}

		// Draw ammo
		Inventory ammo1, ammo2;
		int ammocount1, ammocount2;

		[ammo1, ammo2, ammocount1, ammocount2] = GetCurrentAmmo ();
		if (ammo1 != NULL)
		{
			// Draw primary ammo in the bottom-right corner
			DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3), (-23, -10));
			DrawInventoryIcon(ammo1, (-14, -17));
			if (ammo2 != NULL && ammo1!=ammo2)
			{
				// Draw secondary ammo just above the primary ammo
				DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3), (-23, -48));
				DrawInventoryIcon(ammo1, (-14, -55));
			}
		}

		if (deathmatch)
		{ // Draw frags (in DM)
			DrawString(mBigFont, FormatNumber(CPlayer.FragCount, 3), (4, 1));
		}

		// Draw inventory
		if (CPlayer.inventorytics == 0)
		{
			if (CPlayer.mo.InvSel != null)
			{
				if (itemflashFade > 0)
				{
					DrawTexture(Images[CursorImage], (-42, -15));
				}
				DrawString(mYelFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3, 5), (-30, -10), DI_TEXT_ALIGN_RIGHT);
				DrawInventoryIcon(CPlayer.mo.InvSel, (-42, -17), DI_DIMDEPLETED);
			}
		}
		else
		{
			CPlayer.mo.InvFirst = ValidateInvFirst (6);
			int i = 0;
			Inventory item;
			Vector2 box = TexMan.GetScaledSize(Images[CursorImage]) - (4, 4);	// Fit oversized icons into the box.
			if (CPlayer.mo.InvFirst != NULL)
			{
				for (item = CPlayer.mo.InvFirst; item != NULL && i < 6; item = item.NextInv())
				{
					if (item == CPlayer.mo.InvSel)
					{
						DrawTexture(Images[CursorImage], (-90+i*35, -3), DI_SCREEN_CENTER_BOTTOM, 0.75);
					}
					if (item.Icon.isValid())
					{
						DrawInventoryIcon(item, (-90+i*35, -5), DI_SCREEN_CENTER_BOTTOM|DI_DIMDEPLETED, 0.75);
					}
					DrawString(mYelFont, FormatNumber(item.Amount, 3, 5), (-72 + i*35, -8), DI_TEXT_ALIGN_RIGHT|DI_SCREEN_CENTER_BOTTOM);
					++i;
				}
			}
		}
	}*/
	
	//##########################################################################
	//## popscreens ############################################################
	//##########################################################################
	protected void DrawPopScreen (int bottom, double TicFrac)
	{
		String buff;
		String label;
		int i;
		Inventory item;
		int xscale, yscale, left, top;
		int bars = (CurrentPop == POP_Status) ? imgINVPOP : imgINVPOP2;
		int back = (CurrentPop == POP_Status) ? imgINVPBAK : imgINVPBAK2;
		// Extrapolate the height of the popscreen for smoother movement
		int height = clamp (PopHeight + int(TicFrac * PopHeightChange), -POP_HEIGHT, 0);

		xscale = CleanXfac;
		yscale = CleanYfac;
		left = screen.GetWidth()/2 - 160*CleanXfac;
		top = bottom + height * yscale;

		//  odstranit defaultni background&border  /////////////////////////////
		//screen.DrawTexture (Images[back], true, left, top, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
		//screen.DrawTexture (Images[bars], true, left, top, DTA_CleanNoMove, true);


		switch (CurrentPop) {
		
			case POP_Status:
				// STATUS popup ////////////////////////////////////////////////
				//  Show miscellaneous status items.  //////////////////////////
				
				//  show backrground & foreground text&border  /////////////////
				TextureID idPOPSTBK = TexMan.CheckForTexture("POPSTBK", 0, 0);
				TextureID idPOPSTAT = TexMan.CheckForTexture("POPSTAT", 0, 0);
				screen.DrawTexture (idPOPSTBK, true, left, top-50, DTA_CleanNoMove, true, DTA_Alpha, 0.85);
				screen.DrawTexture (idPOPSTAT, true, left, top-50, DTA_CleanNoMove, true);
				
				//  Print stats  ///////////////////////////////////////////////
				//  accuracy
				DrINumber2 (CPlayer.mo.accuracy, left+266*xscale, top+9*yscale, 7*xscale, imgSTFON0);
				//  stamina
				DrINumber2 (CPlayer.mo.stamina, left+266*xscale, top+27*yscale, 7*xscale, imgSTFON0);

				// How many keys does the player have?
				/*
				i = 0;
				for (item = CPlayer.mo.Inv; item != NULL; item = item.Inv)
				{
					if (item is "Key")
					{
						i++;
					}
				}
				DrINumber2 (i, left+268*xscale, top+76*yscale, 7*xscale, imgSTFON0);
				*/

				//  Does the player have a binder badge?  //////////////////////
				item = CPlayer.mo.FindInventory ("binderBadge");
				if (item != NULL) {
					screen.DrawTexture (item.Icon, true,
						left + 248*xscale,
						top + 82*yscale,
						DTA_CleanNoMove, true);
				}
				
				//  Does the player have shouldergun?  /////////////////////////
				item = CPlayer.mo.FindInventory ("shoulderGun");
				if (item != NULL) {
					screen.DrawTexture (item.Icon, true, 
						left + 211*xscale,
						top + 73*yscale,
						DTA_CleanNoMove, true);
					item = CPlayer.mo.FindInventory("shoulderGunMag_item");
					if (item != NULL) {
						DrINumber2 (item.Amount*32, left+249*xscale, top+91*yscale, 7*xscale, imgSTFON0);
					}
				}

				//  Does the player have coins?  ///////////////////////////////
				item = CPlayer.mo.FindInventory("goldCoin");
				if ( item != NULL ) {
					DrINumber2 (item.Amount, left+284*xscale, top+45 * yscale, 7*xscale, imgSTFON0);
				}
				
				//  Display weight of owned items  /////////////////////////////
				let wght = binderPlayer(CPlayer.mo);
				if ( wght != NULL ) {
					DrINumber2 (wght.encumbrance, left+284*xscale, top+64 * yscale, 7*xscale, imgSTFON0);				
				}
				
				//  How much ammo does the player have?  ///////////////////////
				static const class<Ammo> AmmoList[] = {
					"ClipOfBullets",			
					"PoisonBolts",	//			
					"ElectricBolts",			
					"HEGrenadeRounds",			
					"PhosphorusGrenadeRounds",	
					"MiniMissiles",			
					"EnergyPod"};				
				//  ammo y coordinate
				static const int AmmoY[] = {0, 16, 24, 40, 48, 56, 64};
				
				for (i = 0; i < 7; ++i) {
					item = CPlayer.mo.FindInventory (AmmoList[i]);

					if (item == NULL) {
						DrINumber2 (0, left+204*xscale, top+AmmoY[i] * yscale, 7*xscale, imgSTFON0);
						DrINumber2 (GetDefaultByType(AmmoList[i]).MaxAmount, left+237*xscale, top+AmmoY[i] * yscale, 7*xscale, imgSTFON0);
					}
					else {
						DrINumber2 (item.Amount, left+204*xscale, top+AmmoY[i] * yscale, 7*xscale, imgSTFON0);
						DrINumber2 (item.MaxAmount, left+237*xscale, top+AmmoY[i] * yscale, 7*xscale, imgSTFON0);
					}
				}

				//  What weapons does the player have?  ////////////////////////
				static const class<Weapon> WeaponList[] = {
					"laserPistol",
					"zscStrifeCrossbow",
					"zscAssaultGun",
					"staffBlaster",
					"zscMiniMissileLauncher",
					"zscFlameThrower",
					"zscStrifeGrenadeLauncher",
					"zscMauler",
					"StormPistol"
					/*"StrifeCrossbow",
					"AssaultGun",
					"FlameThrower",
					"MiniMissileLauncher",
					"StrifeGrenadeLauncher",
					"Mauler"*/
				};
				static const int WeaponX[] = {64, 23, 57, 24, 59, 20, 54, 22, 77};
				static const int WeaponY[] = {0, 7, 17, 25, 39, 50, 60, 77, 83};

				for (i = 0; i < 9; ++i) {
					item = CPlayer.mo.FindInventory (WeaponList[i]);
					if (item != NULL) {
						screen.DrawTexture (item.Icon, true,
							left + WeaponX[i] * xscale,
							top + WeaponY[i] * yscale,
							DTA_CleanNoMove, true,
							DTA_LeftOffset, 0,
							DTA_TopOffset, 0);
					}
				}
			break;
		
			case POP_Log:
				// LOG popup ///////////////////////////////////////////////////
				//  show backrground & foreground text&border  /////////////////	
				TextureID idPOPSTBKLog = TexMan.CheckForTexture("IPOPB", 0, 0);
				TextureID idPOPSTATLog = TexMan.CheckForTexture("IPOPF", 0, 0);
				screen.DrawTexture (idPOPSTBKLog, true, left, top, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
				screen.DrawTexture (idPOPSTATLog, true, left, top, DTA_CleanNoMove, true);
				/*
				// Draw the latest log message.
				screen.DrawText(SmallFont2, Font.CR_UNTRANSLATED, left + 210 * xscale, top + 8 * yscale, Level.TimeFormatted(),
					DTA_CleanNoMove, true);

				if (CPlayer.LogText.Length() > 0 {
					let text = Stringtable.Localize(CPlayer.LogText);
					BrokenLines lines = SmallFont2.BreakLines(text, 272);
					for (i = 0; i < lines.Count(); ++i) {
						screen.DrawText(SmallFont2, Font.CR_UNTRANSLATED, left + 24 * xscale, top + (18 + i * 12)*yscale, lines.StringAt(i), DTA_CleanNoMove, true);
					}
				}*/
			break;

		case POP_Keys:
			// KEYS popup //////////////////////////////////////////////////////
			//  show backrground & foreground text&border  /////////////////////					
			TextureID idPOPSTBKkeys = TexMan.CheckForTexture("IPOPB", 0, 0);
			TextureID idPOPSTATkeys = TexMan.CheckForTexture("IPOPF", 0, 0);
			screen.DrawTexture (idPOPSTBKkeys, true, left, top, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
			screen.DrawTexture (idPOPSTATkeys, true, left, top, DTA_CleanNoMove, true);
			// List the keys the player has.
			int pos, endpos, leftcol;
			int clipleft, clipright;
			
			pos = KeyPopPos;
			endpos = pos + 10;
			leftcol = 20;
			clipleft = left + 17*xscale;
			clipright = left + (320-17)*xscale;
			if (KeyPopScroll > 0) {
				// Extrapolate the scroll position for smoother scrolling
				int scroll = MAX (0, KeyPopScroll - int(TicFrac * (280./KEY_TIME)));
				pos -= 10;
				leftcol = leftcol - 280 + scroll;
			}
			i = 0;
			for (item = CPlayer.mo.Inv; i < endpos && item != NULL; item = item.Inv) {
				if (!(item is "Key"))
					continue;
				
				if (i < pos) {
					i++;
					continue;
				}

				label = item.GetTag();

				int colnum = ((i-pos) / 5) & (KeyPopScroll > 0 ? 3 : 1);
				int rownum = (i % 5) * 18;

				screen.DrawTexture (item.Icon, true,
					left + (colnum * 140 + leftcol)*xscale,
					top + (6 + rownum)*yscale,
					DTA_CleanNoMove, true,
					DTA_ClipLeft, clipleft,
					DTA_ClipRight, clipright);
				screen.DrawText (SmallFont2, Font.CR_UNTRANSLATED,
					left + (colnum * 140 + leftcol + 17)*xscale,
					top + (11 + rownum)*yscale,
					label,
					DTA_CleanNoMove, true,
					DTA_ClipLeft, clipleft,
					DTA_ClipRight, clipright);
				i++;
			}
			break;

		}
	}
	//##########################################################################
	//##########################################################################
	//##########################################################################

	void DrINumber2 (int val, int x, int y, int width, int imgBase) const
	{
		x -= width;

		if (val == 0)
		{
			screen.DrawTexture (Images[imgBase], true, x, y, DTA_CleanNoMove, true);
		}
		else
		{
			while (val != 0)
			{
				screen.DrawTexture (Images[imgBase+val%10], true, x, y, DTA_CleanNoMove, true);
				val /= 10;
				x -= width;
			}
		}
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////