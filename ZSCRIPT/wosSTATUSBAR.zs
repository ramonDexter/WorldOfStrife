////////////////////////////////////////////////////////////////////////////////
//  WoS StatusBAR  /////////////////////////////////////////////////////////////
//  based on strife statusbar  /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosStatusBar : BaseStatusBar {
	
	//InventoryBarState diparms;
	//InventoryBarState diparms_argsbar;

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
			//disable fullscreen statusbar entirely
			/*if (state == HUD_Fullscreen) {
				//BeginHUD();
				//DrawFullScreenStuff ();
				BeginStatusBar();
				DrawMainBar (TicFrac);
			}*/

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
				//FillBar(x, y-4, 0, 14, azure2, azure2);
				FillBar(x, y-2, 0, 14, azure2, azure2);
				FillBar(x, y, 0, 14, azure1, azure1);
				FillBar(x, y+2, 0, 14, azure1, azure1);
				FillBar(x, y+4, 0, 14, azure2, azure2);
				//FillBar(x, y+6, 0, 14, azure2, azure2);
		}
		else {
			if (health == 0) {
				//FillBar(x, y-4, 0, 14, grey2, grey2);
				FillBar(x, y-2, 0, 14, grey2, grey2);
				FillBar(x, y, 0, 14, grey1, grey1);
				FillBar(x, y+2, 0, 14, grey1, grey1);
				FillBar(x, y+4, 0, 14, grey2, grey2);
				//FillBar(x, y+6, 0, 14, grey2, grey2);
			} else if ( health <= 33 ) {
				//FillBar(x, y-4, 0, 14, red2, red2);
				FillBar(x, y-2, 0, 14, red2, red2);
				FillBar(x, y, 0, 14, red1, red1);
				FillBar(x, y+2, 0, 14, red1, red1);
				FillBar(x, y+4, 0, 14, red2, red2);
				//FillBar(x, y+6, 0, 14, red2, red2);
			} else if ( health <= 66 ) {
				//FillBar(x, y-4, 0, 14, gold2, gold2);
				FillBar(x, y-2, 0, 14, gold2, gold2);
				FillBar(x, y, 0, 14, gold1, gold1);
				FillBar(x, y+2, 0, 14, gold1, gold1);
				FillBar(x, y+4, 0, 14, gold2, gold2);
				//FillBar(x, y+6, 0, 14, gold2, gold2);
			} else if ( health<=88 ) {
				//FillBar(x, y-4, 0, 14, blue2, blue2);
				FillBar(x, y-2, 0, 14, blue2, blue2);
				FillBar(x, y, 0, 14, blue1, blue1);
				FillBar(x, y+2, 0, 14, blue1, blue1);
				FillBar(x, y+4, 0, 14, blue2, blue2);
				//FillBar(x, y+6, 0, 14, blue2, blue2);
			} else {
				//FillBar(x, y-4, 0, 14, green2, green2);
				FillBar(x, y-2, 0, 14, green2, green2);
				FillBar(x, y, 0, 14, green1, green1);
				FillBar(x, y+2, 0, 14, green1, green1);
				FillBar(x, y+4, 0, 14, green2, green2);
				//FillBar(x, y+6, 0, 14, green2, green2);
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
			// cast player to access his vars //
			let pawn = binderPlayer(CPlayer.mo);

            //  draw statusbar frame  //////////////////////////////////////////
            drawImage ("HUDfrmT2", (-54, 0), DI_ITEM_OFFSETS);
            //drawImage ("HUDfrmT", (-54, 0), DI_ITEM_OFFSETS);
            //drawImage ("HUDiB", (-54, 0), DI_ITEM_OFFSETS, 0.5);

            //  Health  ////////////////////////////////////////////////////////
            DrawString(mGrnFont, FormatNumber(CPlayer.health, 3, 19), (296, 5), DI_TEXT_ALIGN_RIGHT, Font.CR_DARKRED);
            int points;        
            if (CPlayer.cheats & CF_GODMODE) {
                points = 999;
            }
            else {
                points = min(CPlayer.health, 200);				
            }			
            DrawHealthBar (points, 251, 6);

			// stamina bar /////////////////////////////////////////////////////
			//let pawn = binderPlayer(CPlayer.mo);
			if ( CPlayer.cheats & CF_GODMODE || pawn.staminaImplant ) {
				DrawBar("stamBax", "stamBck", pawn.stamin, pawn.maxstamin, (369, 100), 0, 3);
			} else {
				DrawBar("stamBar", "stamBck", pawn.stamin, pawn.maxstamin, (369, 100), 0, 3);
			}
			//DrawString(mGrnFont, FormatNumber(pawn.stamin, 3, 19), (359, 30), DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);

            //  Armor  /////////////////////////////////////////////////////////			
			//let pawn = binderPlayer(CPlayer.mo);
			If(pawn.currentarmor > 0 && pawn.armoramount > 0) {
				string armortype;
				If(pawn.currentarmor==1){armortype="I_ARM2";}
				Else If(pawn.currentarmor==2){armortype="I_ARM1";}
				Else If(pawn.currentarmor==3){armortype="I_RGA1";}
				Else If(pawn.currentarmor==4){armortype="I_RGA2";}
				Else If(pawn.currentarmor==5){armortype="I_SHLD";}
				DrawImage(armortype,(-56, 4),DI_ITEM_OFFSETS);
			}

            //  Ammo  //////////////////////////////////////////////////////////
			// normal ammo display + using class variables as magazine instead /
            Inventory ammo1, ammo2; 
            [ ammo1, ammo2 ]= GetCurrentAmmo ();
			let wpn = wosWeapon(CPlayer.ReadyWeapon);
			//inventory magtype = CPlayer.mo.FindInventory(wpn.magazinetype); 
            if (ammo2 != NULL) {
                DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3, 5), (-12, 29), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
                DrawString(mGrnFont, FormatNumber(ammo2.Amount, 3, 5), (-12, 36), DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);		
				//drawBar int vertical == 0 left>right; 1 right>left; 2 down>up; 3 up>down
				DrawBar("mgznBar", "mgznBck", ammo1.Amount, ammo1.MaxAmount, (-18, 27), 0, 3);				
                DrawInventoryIcon (ammo2, (-25, -2), DI_ITEM_OFFSETS);
            } else if ( ammo1 != NULL ) {
				DrawString(mGrnFont, FormatNumber(ammo1.Amount, 3, 5), (-12, 33), DI_TEXT_ALIGN_RIGHT, Font.CR_GOLD);
				DrawBar("mgznBar", "mgznBck", ammo1.Amount, ammo1.MaxAmount, (-18, 27), 0, 3);
				DrawInventoryIcon (ammo1, (-25, -2), DI_ITEM_OFFSETS);
			} else if ( wpn != null ) {
				inventory magtype = CPlayer.mo.FindInventory(wpn.magazinetype);
				if ( wpn.magazine > 0 && magtype ) {
					DrawString(mGrnFont, FormatNumber(wpn.magazine, 3, 5), (-12, 29), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
					DrawString(mGrnFont, FormatNumber(magtype.Amount, 3, 5), (-12, 36), DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);
					DrawBar("mgznBar", "mgznBck", wpn.magazine, wpn.magazinemax, (-18, 27), 0, 3);
					DrawInventoryIcon (magtype, (-25, -2), DI_ITEM_OFFSETS);
				} else if ( wpn.magazine == 0 && magtype ) {
					DrawString(mGrnFont, "0", (-12, 29), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
					DrawString(mGrnFont, FormatNumber(magtype.Amount, 3, 5), (-12, 36), DI_TEXT_ALIGN_RIGHT, Font.CR_GRAY);
					DrawBar("mgznBar", "mgznBck", wpn.magazine, wpn.magazinemax, (-18, 27), 0, 3);
					DrawInventoryIcon (magtype, (-25, -2), DI_ITEM_OFFSETS);
				} else if ( wpn.magazine > 0 && !magtype ) {
					DrawString(mGrnFont, FormatNumber(wpn.magazine, 3, 5), (-12, 29), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
					DrawBar("mgznBar", "mgznBck", wpn.magazine, wpn.magazinemax, (-18, 27), 0, 3);
					DrawInventoryIcon (magtype, (-25, -2), DI_ITEM_OFFSETS);
				}
			}
			
            //  weapon icon  ///////////////////////////////////////////////////
            item = CPlayer.ReadyWeapon;
            if ( item != null ) {
				if ( item is "staffBlaster" ) { //draw long staffblaster icon insted short one in h_astf
					drawImage ("STFSH", (14, 1), DI_ITEM_OFFSETS);
				} else {
					DrawInventoryIcon(CPlayer.ReadyWeapon, (20, 1), DI_ITEM_OFFSETS);
				}
                //DrawInventoryIcon(CPlayer.ReadyWeapon, (20, 1), DI_ITEM_OFFSETS);
            }            

            //  shoulderGun icon + ammo display  ///////////////////////////////
            inventory shldGun;
            inventory shldGunAmmo;
            shldGun = CPlayer.mo.FindInventory("shoulderGun");
            shldGunAmmo = CPlayer.mo.FindInventory("magazine_shoulderGun");
            int shldGunAmmoCount = CPlayer.mo.CountInv("magazine_shoulderGun");

            if ( shldGun != null ) {
                drawImage ("HUDshgf", (-54, 0), DI_ITEM_OFFSETS);
				if ( shldGunAmmo != null ) {
					DrawString (mGrnFont, FormatNumber(shldGunAmmo.Amount, 3, 5), (-42, 62), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
				}
            }

            //  selected inventory display  ////////////////////////////////////
			if (CPlayer.mo.InvSel != null) {
				DrawInventoryIcon(CPlayer.mo.InvSel, (351, 18), DI_ARTIFLASH|DI_ITEM_CENTER, boxsize:(28, 28)); //vpravo nahore
				item = CPlayer.mo.InvSel;
				// display item charge //>>removed, use manual check to check item charge, to improve immersion
				if (item.Amount > 1) {
					//DrawString(mYelFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3, 5, 0, ""), (-8, 188), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW); //vlevo dole		
					DrawString(mYelFont, FormatNumber(CPlayer.mo.InvSel.Amount, 3, 5, 0, ""), (368, 25), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW); //vpravo nahore
				} 
			}

            //  inventory  pop - up  ///////////////////////////////////////////
            if ( isInventoryBarVisible() ) {
                drawImage ("invBACK", (-54, 0), DI_ITEM_OFFSETS);
                //CPlayer.inventorytics = 0;
				CPlayer.mo.InvFirst = ValidateInvFirst (7);
				// display all items overall weight in open inventory //////////
				let pawn = binderPlayer(CPlayer.mo);
				if ( pawn != NULL ) {
					// more sophisticated approach //
					DrawString(mESfont, string.format("%s%i%s%i", "W: ", pawn.encumbrance, "/", pawn.weightmax), (40, 156), DI_TEXT_ALIGN_LEFT, Font.CR_GREEN);				
				}
				////////////////////////////////////////////////////////////////
				
				let coins = CPlayer.mo.FindInventory("Coin");
				if ( coins != null ) {
					DrawString(mESfont, FormatNumber(coins.Amount, 3, 5, 0, "GOLD: "), (280, 156), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
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
					if ( item is "Coin" ) {
						//do nothing
					} else if (item.Mass > 0) {
						DrawString(mESfont, FormatNumber(item.Mass, 3, 5, 0, "W:"), (65 + 35*i, 168), DI_TEXT_ALIGN_RIGHT, Font.CR_GREEN);
					}
					// display item amount
					if (item.Amount > 1) { 
						DrawString(mESfont, FormatNumber(item.Amount, 3, 5, 0, "A:"), (65 + 35*i, 192), DI_TEXT_ALIGN_RIGHT, Font.CR_YELLOW);
					}
					// display item charge >> disabled, use manual check to see item charge
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
				// cast player for various purposes ////////////////////////////
				let pawn = binderPlayer(CPlayer.mo);

				// STATUS popup ////////////////////////////////////////////////
				//  Show miscellaneous status items.  //////////////////////////
				
				//  show backrground & foreground text&border  /////////////////
				TextureID idPOPSTBK = TexMan.CheckForTexture("POPSTBK", 0, 0);
				TextureID idPOPSTAT = TexMan.CheckForTexture("POPSTAT", 0, 0);
				screen.DrawTexture (idPOPSTBK, true, left, top-86, DTA_CleanNoMove, true, DTA_Alpha, 0.85);
				screen.DrawTexture (idPOPSTAT, true, left, top-86, DTA_CleanNoMove, true);
				
				//  Print stats  ///////////////////////////////////////////////
				// accuracy //
				DrINumber2 (CPlayer.mo.accuracy, left+266*xscale, top-4*yscale, 7*xscale, imgSTFON0);
				// stamina //
				DrINumber2 (CPlayer.mo.stamina, left+266*xscale, top+13*yscale, 7*xscale, imgSTFON0);
				// mind //
				DrINumber2 (pawn.mindValue, left+266*xscale, top+30*yscale, 7*xscale, imgSTFON0);
				// Level //
				DrINumber2 (pawn.playerLevel, left+202*xscale, top+74*yscale, 7*xscale, imgSTFON0);
				// XP //
				DrINumber2 (pawn.playerXP, left+243*xscale, top+93*yscale, 7*xscale, imgSTFON0);
				
				// health implant display //////////////////////////////////////
				item = CPlayer.mo.FindInventory ("implant_health");
				if ( item != NULL ) {
					textureID implantName = TexMan.CheckForTexture("THLTRGN", 0, 0);
					screen.DrawTexture (implantName, true,
						left + 131*xscale,
						top + 62*yscale,
						DTA_CleanNoMove, true);
					screen.DrawTexture (item.Icon, true,
						left + 105*xscale,
						top + 63*yscale,
						DTA_CleanNoMove, true);
				}

 				// stamina implant display /////////////////////////////////////
				item = CPlayer.mo.FindInventory ("implant_stamina");
				if ( item != NULL ) {
					textureID implantName = TexMan.CheckForTexture("TENERGY", 0, 0);
					screen.DrawTexture (implantName, true,
						left + 131*xscale,
						top + 91*yscale,
						DTA_CleanNoMove, true);
					screen.DrawTexture (item.Icon, true,
						left + 105*xscale,
						top + 83*yscale,
						DTA_CleanNoMove, true);
				}			

				// moved to open inventorybar //////////////////////////////////
				//  Does the player have coins?  ///////////////////////////////
				//  Display weight of owned items  /////////////////////////////
				// moved to open inventorybar //////////////////////////////////
				
				//  Does the player have a binder badge?  //////////////////////
				item = CPlayer.mo.FindInventory ("binderBadge");
				if (item != NULL) {
					textureID id_badge = TexMan.CheckForTexture("h_badg", 0, 0); 
					screen.DrawTexture (id_badge, true,
						left + 229*xscale,
						top + 62*yscale,
						DTA_CleanNoMove, true);
				}
				
				// display worn armor //////////////////////////////////////////
				textureID id_armor01 = TexMan.CheckForTexture("I_ARM2", 0, 0);
				textureID id_armor02 = TexMan.CheckForTexture("I_ARM1", 0, 0);
				textureID id_armor03 = TexMan.CheckForTexture("I_RGA1", 0, 0);
				textureID id_armor04 = TexMan.CheckForTexture("I_RGA2", 0, 0);
				textureID id_armor05 = TexMan.CheckForTexture("I_SHLD", 0, 0);
				if ( pawn.currentarmor > 0 && pawn.armoramount > 0 ) {
					textureID id_holder;
					int armorClass;
					if ( pawn.currentarmor == 1 ) { id_holder = id_armor01; } 
					else if ( pawn.currentarmor == 2 ) { id_holder = id_armor02; } 
					else if ( pawn.currentarmor == 3 ) { id_holder = id_armor03; } 
					else if ( pawn.currentarmor == 4 ) { id_holder = id_armor04; } 
					else if ( pawn.currentarmor == 5 ) { id_holder = id_armor05; }
					screen.DrawTexture(id_holder, true,
						left + 258 *xscale,
						top + 49 *yscale,
						DTA_CleanNoMove, true
					);					
					DrINumber2 (pawn.armorclass, left+ 294 *xscale, top+ 78 *yscale, 7*xscale, imgSTFON0);//imgFONY0//imgSTFON0
					DrINumber2 (pawn.armoramount, left+ 293 *xscale, top+ 86 *yscale, 7*xscale, imgSTFON0);//imgFONY0//imgSTFON0
				}

				//  How much ammo does the player have?  ///////////////////////
				static const class<Ammo> AmmoList[] = {
					"ClipOfBullets",			
					"PoisonBolts",	//			
					"ElectricBolts",			
					"HEGrenadeRounds",			
					"PhosphorusGrenadeRounds",	
					"MiniMissiles",			
					"EnergyPod"
				};				
				//  ammo y coordinate
				static const int AmmoY[] = {-12, 4, 12, 28, 36, 44, 52};
				
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

				//  Does the player have shouldergun?  /////////////////////////
				item = CPlayer.mo.FindInventory ("shoulderGun");
				if (item != NULL) {
					screen.DrawTexture (item.Icon, true, 
						left + 65*xscale,
						top - 18*yscale,
						DTA_CleanNoMove, true);
				}

				//  What weapons does the player have?  ////////////////////////
				static const class<Weapon> WeaponList[] = {
					//"StormPistol", //x23 y-9
					"laserPistol", //x68 y12
					"wosStrifeXbow", //x24 y-7
					"wosAssaultGun", //x20 y43
					"wosPhaestonRifle", //x31 y28
					"staffBlaster", //x19 y13
					"wosMinimissileLauncher", //x60 y48
					"wosFlamethrower", //x19 y75
					"wosGrenadeLauncher", //x54 y83
					"wosMauler" //x19 y57
				};
				static const int WeaponX[] = {/*23,*/ 68, 24, 20, 31, 19, 60, 19, 54, 19};
				static const int WeaponY[] = {/*-9,*/ 12, -7, 43, 28, 13, 48, 75, 83, 57};

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
				// map textures //
				TextureID idPOPMAP8 = TexMan.CheckForTexture("IPOPM8", 0, 0);
				screen.DrawTexture (idPOPSTBKLog, true, left, top-50, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
				screen.DrawText(SmallFont, Font.CR_UNTRANSLATED, left + 22 * xscale, top - 8 * yscale, "LOCATION: "..level.FormatMapName(2), DTA_CleanNoMove, true);
				screen.DrawText(SmallFont2, Font.CR_UNTRANSLATED, left + 250 * xscale, top -8 * yscale, Level.TimeFormatted(), DTA_CleanNoMove, true);
				screen.DrawTexture (idPOPSTATLog, true, left, top-50, DTA_CleanNoMove, true);
				/*if ( level.mapname ~== "map08") {
					screen.DrawTexture (idPOPMAP8, true, left, top-50, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
					screen.DrawText(SmallFont, Font.CR_UNTRANSLATED, left + 22 * xscale, top - 8 * yscale, "LOCATION: "..level.FormatMapName(2), DTA_CleanNoMove, true);
				} else {
					screen.DrawTexture (idPOPSTBKLog, true, left, top-50, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
					screen.DrawText(SmallFont, Font.CR_UNTRANSLATED, left + 22 * xscale, top - 8 * yscale, "LOCATION: "..level.FormatMapName(2), DTA_CleanNoMove, true);
				}*/
				
				
				/*
				// Draw the latest log message.
				screen.DrawText(SmallFont2, Font.CR_UNTRANSLATED, left + 210 * xscale, top -8 * yscale, Level.TimeFormatted(),
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
			screen.DrawTexture (idPOPSTBKkeys, true, left, top-50, DTA_CleanNoMove, true, DTA_Alpha, 0.75);
			screen.DrawTexture (idPOPSTATkeys, true, left, top-50, DTA_CleanNoMove, true);
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
				int rownum = (i % 6) * 18;

				screen.DrawTexture (item.Icon, true,
					left + (colnum * 140 + leftcol)*xscale,
					(top-50) + (6 + rownum)*yscale,
					DTA_CleanNoMove, true,
					DTA_ClipLeft, clipleft,
					DTA_ClipRight, clipright);
				screen.DrawText (SmallFont, Font.CR_UNTRANSLATED,
					left + (colnum * 140 + leftcol + 17)*xscale,
					(top-50) + (11 + rownum)*yscale,
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