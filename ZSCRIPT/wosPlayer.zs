////////////////////////////////////////////////////////////////////////////////
//  WoS Player class definition  ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class binderPlayer : StrifePlayer {
	//  credits:
	//  Jarewill for his wonderful Lost Frontier mod and zscript code
	//  variables init  ////////////////////////////////////////////////////////
	//  vyzaduje efekt pouziti med/jiny itemu  /////////////////////////////////
	//  promenna do ktery se uklada prave vybrana zbran
	Weapon selectedWeapon;
	
	//  LF mechanics vars  //
	bool sprinting;
	bool bracing;
	int stamin;
	int maxstamin; //to allow handling of var in statusbar
	bool staminaImplant;
	int bleedlevel;
	int bleedtimer;
	double pvel;
	double pang;
	int encumbrance;
	int weightmax;
	bool overweight;
	bool overweight2;
	int currentarmor;
	int armoramount;
	int armorpower;
	int armorclass;
	int SpeedUpgrade;
	Actor backplaye;
	bool nightEyeGrainEnable;
	// backpack //
	int playerBackpack;
	
	// RPG system - new player stats ///////////////////////////////////////////
	int mindValue;
	property mind : mindValue;
	int playerXP;
	property playerXP : playerXP;
	int playerLevel;
	property playerLevel : playerLevel;

	// broken lands ledge climbing /////////////////////////////////////////////	
	double speedbase; property BaseSpeed : speedbase;
	bool running;

	////////////////////////////////
	//C3DCollisionClient client;
	
	// main player def /////////////////////////////////////////////////////////
	Default {	
		+FLOORCLIP;	
		+SHOOTABLE; // musí tu být, aby nepřátelé správně registrovali hráče :)
		//  various player properties  /////////////////////////////////////////
		Player.ForwardMove 1.0, 1.0;
		Player.SideMove 0.75, 0.75;
		Player.AirCapacity 2.0;
		player.viewheight 48;
		player.attackzoffset 11;
		Player.jumpZ 8.0;
		Player.MaxHealth 100;
		Player.DisplayName "Binder";
		Player.CrouchSprite "BNDP";
		Species "binderPlayer";
		Health 100;
		Radius 16;
		Height 56;
		Mass 100;
		PainChance 255;
		MaxStepHeight 20;
		//  weaponslots  ///////////////////////////////////////////////////////
		Player.WeaponSlot 1, "wosBareHands", "wosPunchDagger";
		Player.WeaponSlot 2, "wosStrifeXbow","laserPistol";
		Player.WeaponSlot 3, "wosAssaultGun", "wosPhaestonRifle", "staffBlaster";
		Player.WeaponSlot 4, "wosMinimissileLauncher";
		Player.WeaponSlot 5, "wosGrenadeLauncher";
		Player.WeaponSlot 6, "wosFlamethrower";
		Player.WeaponSlot 7, "wosMauler";
		//  start items  ///////////////////////////////////////////////////////
		Player.StartItem "wosBareHands", 1;
		Player.StartItem "wosPunchDagger", 1;
		Player.StartItem "magazine_shoulderGun", 32;
		Player.StartItem "notePlayerPersonal", 1;
		Player.StartItem "journalitem", 1;
		Player.StartItem "PDAReader", 1;
		// custom properties ///////////////////////////////////////////////////
		binderPlayer.BaseSpeed 2.0;
		binderPlayer.mind 0;
		binderPlayer.playerXP 0;
		binderPlayer.playerLevel 1;
		////////////////////////////////////////////////////////////////////////
		
		//Player.WeaponSlot 8, "Sigil";
		//Player.WeaponSlot 9, "hookShotWeapon";		
		//Player.ForwardMove 0.75, 0.75;
		//Player.StartItem "magazine_executorRifle", 32;
		//Player.StartItem "wosi_scanner", 1;	
		//Player.StartItem "magazine_wosAssaultGun", 32;
		//Player.StartItem "magazine_pistolLaser", 32;
		//Player.StartItem "magazine_blasterStaff", 48;
		//Player.StartItem "magazine_missileLauncher", 8;
		//Player.StartItem "magazine_pistol", 12;
		//Player.StartItem "zscFist", 1;	
		// dodopod ledge climbing //
		//binderPlayer.MaxLedgeHeight 56;
		//binderPlayer.ClimbSpeed 2;
	}
	////////////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////////////////
	// overall override ////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	// Tick() //////////////////////////////////////////////////////////////////
	override void Tick() {
		pvel=vel.z;
		pang=angle;
		encumbrance=0; //Before ticking, reset the encumbrance
		///////////////
		//client.PushState();
		//client.Tick();
		///////////////
		Super.Tick();
		///////////////
		//client.PopState();
		
		// custom functions ////////////////////////////////////////////////////		
		HandleStamina();
		HandleEncumberance();
		HandleArmorMass();
		HandlePlayerBody();		
		HealthShake();
		HandleBleed();
		LedgeClimb();
		HandleSpeed();
		HandlePlayerLevel();
		
		level.aircontrol=1; //umoznuje ovladani hrace ve vzduchu - hrac se nezasekne ve skoku	
		////////////////////////////////////////////////////////////////////////	
	}
	////////////////////////////////////////////////////////////////////////////

	// postBeginPlay() /////////////////////////////////////////////////////////
	override void PostBeginPlay() {
		Super.PostBeginPlay();
		// LF sprinting code //
		stamin = 400;
		bleedlevel = 0;
		///////////////////////
		//client = new('C3DCollisionClient');
		//client.parent = self;
	}
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
 	// ACS support - functions to touch values with ACS scripts ////////////////
	////////////////////////////////////////////////////////////////////////////
	static int getplayerAccuracy(actor activator) {
		let pawn = binderplayer(activator);
		if ( pawn && pawn.player ) {
			return pawn.accuracy;
		}
		return 0;
	}
	static int getplayerStamina(actor activator) {
		let pawn = binderplayer(activator);
		if ( pawn && pawn.player ) {
			return pawn.stamina;
		}
		return 0;
	}
	static int getplayerMind(actor activator) {
		let pawn = binderplayer(activator);
		if ( pawn && pawn.player ) {
			return pawn.MindValue;
		}
		return 0;
	}
	static int getplayerXP(actor activator) {
		let pawn = binderPlayer(activator);
		if ( pawn && pawn.player ) {
			return pawn.playerXP;
		}
		return 0;
	}
	static int getplayerLevel(actor activator) {
		let pawn = binderPlayer(activator);
		if ( pawn && pawn.player ) {
			return pawn.playerLevel;
		}
		return 0;
	}
	static void FN_giveXP(actor activator, int amountXP) {
		let pawn = binderPlayer(activator);
		if ( pawn && pawn.player ) {
			pawn.playerXP += amountXP;
			pawn.A_Log(string.format("\c[yellow][ %s%i%s ]", "Received ", amountXP, " XP!"));
		}
	}
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	// common handlers /////////////////////////////////////////////////////////
	// encumberance ////////////////////////////////////////////////////////////
	// weight based on player's stamina ////////////////////////////////////////
	void HandleEncumberance() {
		weightmax=2200; //Set the default		
		//If(HandleUpgrade==1){weightmax+=500;} //Add 500 with the specific upgrade at level 1
		// modify weightmax with stamina upgrades
		if ( maxstamin == 440 ) { weightmax = 2420; }
		if ( maxstamin == 520 ) { weightmax = 2860; }
		if ( maxstamin == 600 ) { weightmax = 3300; }
		if ( maxstamin == 700 ) { weightmax = 3850; }
		if ( maxstamin == 800 ) { weightmax = 4400; }
		// finalize wightmax
		If( staminaImplant ){ weightmax+=1000; } //Add 1000 if it's at 2 instead
		//If(CountInv("AmmoSatchel")){ weightmax*=1.5; } //Double with the backpack
		if ( playerBackpack == 1 ) { weightmax*=2.0; } //Double with the backpack
		If(encumbrance>weightmax){overweight=1;}Else{overweight=0;} //If it's over the limit (for example 1500/1000)
		If(encumbrance>(weightmax*2)){overweight2=1;}Else{overweight2=0;} //If it's twice over the limit (for example 2000/1000)
	}
 	// armor&mass //////////////////////////////////////////////////////////////
	void HandleArmorMass() {
		If (armoramount < 1) {
			//reset power when no armor or depleted
			currentarmor=0; 
			armorpower=0;
			armorclass=0;
		}		
		If (currentarmor==1) {
			encumbrance+=LeatherWeight/5; 
			mass=300; 
			bNOBLOOD=0;
			armorpower = 24;
			armorclass = 4;
		} Else If (currentarmor==2) {
			encumbrance+=MetalWeight/5; 
			mass=400; 
			bNOBLOOD=1;
			armorpower = 44;
			armorclass = 7;
		} Else If (currentarmor==3) {
			encumbrance+=BinderBasicWeight/7; 
			mass=350; 
			bNOBLOOD=0;
			armorpower = 33;
			armorclass = 6;
		} Else If (currentarmor==4) {
			encumbrance+=BinderAdvancedWeight/7; 
			mass=350; 
			bNOBLOOD=1;
			armorpower = 50;
			armorclass = 9;
		} Else if (currentarmor==5) {
			encumbrance+=KineticWeight/7; 
			mass=250; 
			bNOBLOOD=1;
			armorpower = 65;
			armorclass = 12;
		} Else {
			mass=100; 
			bNOBLOOD=0; 
			PainChance=255;
		}
	}
 	// spawn player body ///////////////////////////////////////////////////////
	void HandlePlayerBody() {
		If(backplaye==null) {
			bool spawn1; 
			Actor spawn2;
			[spawn1, spawn2] = A_SpawnItemEx("binderPlayerBody",flags: SXF_SETMASTER);
			backplaye=spawn2;
		}
	}
	// bleeding controller /////////////////////////////////////////////////////
	void HandleBleed() {
		If ( bleedlevel > 0 ) {
			If( bleedtimer >= ( 70 / bleedlevel )) {
				BleedDamage();
				//A_Print("bleedDamage!");
			}
			Else {
				bleedtimer++;
				//A_Print("bleedTimer++");
			}
		}
	}
	
	////////////////////////////////////////////////////////////////////////////

	// jarewill's adopted code /////////////////////////////////////////////////
	//  code by Jarewill
	void BleedDamage() {
		If(health>0) {
			//A_Print("BleedDamage();");
			DamageMobj(null,null,bleedlevel,"Bleeding");
			SpawnBlood((pos.x,pos.y,pos.z+height-20),angle,bleedlevel);
			A_StartSound("sounds/ambient/heartBeat", CHAN_BODY, CHANF_DEFAULT, 0.9);
			bleedtimer=0;
		}
	}		
    
	void HealthShake() {
		double shake = 0.2 - health*0.002;
		double stamshak = 0.001 * (400 - stamin);
		If(stamshak>0){shake+=stamshak;}
		If(shake<0){shake=0;}
		If(health<1){shake=0;}
		angle+=frandom(-shake,shake);
		pitch+=frandom(-shake,shake);
	}
	////////////////////////////////////////////////////////////////////////////

	// stamina controller //////////////////////////////////////////////////////
	//  code by Jarewill
	void HandleStamina() {
		// modified working stamina raise according to player's health modified by UpgradeStamina //
		maxstamin = 400;
		int pawnmaxhealth = GetMaxHealth(true);
		If ( pawnmaxhealth >= 120 && pawnmaxhealth < 140 ) { maxstamin = 440; }
		If ( pawnmaxhealth >= 140 && pawnmaxhealth < 160 ) { maxstamin = 520; }
		If ( pawnmaxhealth >= 160 && pawnmaxhealth < 180 ) { maxstamin = 600; }
		If ( pawnmaxhealth >= 180 && pawnmaxhealth < 200 ) { maxstamin = 700; }
		If ( pawnmaxhealth == 200 ) { maxstamin = 800; }
		If ( (player.cheats&(CF_GODMODE|CF_GODMODE2)) || staminaImplant ) { stamin = maxstamin; }		
		If( sprinting == 0 ) {
			If( stamin > 10 && GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED ) {
				//A_Print("speeding up!", 1.0);
				selectedWeapon=Weapon(player.readyweapon);
				sprinting=1;
				bracing=1;
				If(!CountInv("wos_sprintWeap")) {
					A_GiveInventory("wos_sprintWeap",1);
				}
				A_SelectWeapon("wos_sprintWeap");
			}
			Else If( stamin<maxstamin && !(GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED) && ( !(GetPlayerInput(MODINPUT_BUTTONS)&(BT_FORWARD|BT_BACK|BT_MOVELEFT|BT_MOVERIGHT)) || vel.length()<2 ) ) {
				stamin++;				
			}
			If( player.readyweapon is "wos_sprintWeap" ) {
				Player.SetPSprite(PSP_WEAPON,player.readyweapon.FindState("Nope"));
				A_SelectWeapon(selectedWeapon.GetClassName());
			}
		}
		Else {
			bracing=1;
			If( GetPlayerInput(MODINPUT_BUTTONS)&(BT_FORWARD|BT_BACK|BT_MOVELEFT|BT_MOVERIGHT) ){ If( stamin > 0 ) { stamin--; } }
			If( stamin > 0 && GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED ){ }
			Else {
				//A_Print("slowing down!", 1.0);
				sprinting=0;
				bracing=0;
				let sprwep = Weapon(player.readyweapon);
				If(player.readyweapon is "wos_sprintWeap"){Player.SetPSprite(PSP_WEAPON,sprwep.FindState("Nope"));}
				A_SelectWeapon(selectedWeapon.GetClassName());
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////

	// damageMObj() ////////////////////////////////////////////////////////////
	//  code by Jarewill
	Override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle) {
		int newdamage;
		
		let playe = self.player;
		If(playe.cheats & (CF_GODMODE | CF_GODMODE2)){}
		Else {
			If(!DamageTypeDefinition.IgnoreArmor(mod)) {
				If(currentarmor>0) {
					double damaged = 1.0 - (armorpower * 0.01);
					newdamage = int(damage * damaged);
					If(newdamage<1) {
						newdamage=1;
					}					
					If(mod=="Fire"&&currentarmor==6) {newdamage/=2;}
					If(mod=="Fire"/*&&CountInv("LFPowerMask")>0)||*/&&currentarmor==4){}
					Else{
						armoramount -= damage/20; //vykomnetovanim se vypne damage armoru >> armor funguje jako ve falloutu nebo v hexenu
					}
					If(armoramount<=0) {
						armorpower=0;
						currentarmor=0;
					}
					damage = newdamage;
				}
			}
			//If(mod=="Gas"&&CountInv("LFPowerMask")>0){damage=0;}
		}
		Return Super.DamageMobj(inflictor,source,damage,mod);
	}
	////////////////////////////////////////////////////////////////////////////
	
	// new movement function ///////////////////////////////////////////////////
	//  code by Jarewill & ramon.dexter
	void HandleSpeed() {
		double hpeed = speedbase;
		bool dont;
		double stmed = 0.01 * (175 - stamin);

		If ( !dont && !reactiontime && player.health ) {
			vel.x*=0.9; 
			vel.y*=0.9; 
			ViewBob=0.6*hpeed;
		}
		If ( hpeed < 0.5 ) {
			hpeed=0.5;
		}
		If ( stmed < 0 ) {
			stmed=0;
		}
		hpeed -= stmed;
		If ( hpeed < 0.1 ) {
			hpeed=0.1;
		}
		If ( hpeed > 1.0 ) {
			hpeed=1.0;
		}
		If( sprinting == 1 ) {
			hpeed*=3.0;
			If( GetPlayerInput(MODINPUT_BUTTONS)&BT_RUN ){ hpeed /= 2;}			
		} else if ( sprinting == 0 ) {
			hpeed *= 0.9;
		}
		If( currentarmor == 2 ){ 
			hpeed*=0.8; 
		}
		If( overweight == 1 ){ 
			hpeed*=0.5; 
		} //Halve speed when true
		If( overweight2 == 1 ){ 
			hpeed*=0.01; 
		} //Set it to veery slow when true
		//If(surgery==1||repairing==1){hpeed=0;}
		ViewBob = 0.6*hpeed; //lower the viewBob
		speed = hpeed;
	}
	////////////////////////////////////////////////////////////////////////////

	// level handler ///////////////////////////////////////////////////////////
	void HandlePlayerLevel() {		

		if ( playerXP>=1000 && playerLevel==1 ) {
			playerLevel=2;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=3000 && playerLevel==2 ) {
			playerLevel=3;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=6000 && playerLevel==3 ) {
			playerLevel=4;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=10000 && playerLevel==4 ) {
			playerLevel=5;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=15000 && playerLevel==5 ) {
			playerLevel=6;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=21000 && playerLevel==6 ) {
			playerLevel=7;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=28000 && playerLevel==7 ) {
			playerLevel=8;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=36000 && playerLevel==8 ) {
			playerLevel=9;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=45000 && playerLevel==9 ) {
			playerLevel=10;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=55000 && playerLevel==10 ) {
			playerLevel=11;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=66000 && playerLevel==11 ) {
			playerLevel=12;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=78000 && playerLevel==12 ) {
			playerLevel=13;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=91000 && playerLevel==13 ) {
			playerLevel=14;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=105000 && playerLevel==14 ) {
			playerLevel=15;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=120000 && playerLevel==15 ) {
			playerLevel=16;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=136000 && playerLevel==16 ) {
			playerLevel=17;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=153000 && playerLevel==17 ) {
			playerLevel=18;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=171000 && playerLevel==18 ) {
			playerLevel=19;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=190000 && playerLevel==19 ) {
			playerLevel=20;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=210000 && playerLevel==20 ) {
			playerLevel=21;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=231000 && playerLevel==21 ) {
			playerLevel=22;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
		if ( playerXP>=253000 && playerLevel==22 ) {
			playerLevel=23;
			A_GiveInventory("upgradeToken", 1);
			A_Log("\c[yellow][ !!! LEVEL UP !!! ]");
		}
	}
	////////////////////////////////////////////////////////////////////////////

	// ledge climb function ////////////////////////////////////////////////////
	// code by Jarewill
	void LedgeClimb() {
		if( (player.readyweapon is "wosPunchDagger" || player.readyweapon is "wosBareHands" ) && player.cmd.buttons&BT_JUMP ) {
			FLineTraceData h, i, j;
			LineTrace(angle,24,0,TRF_THRUSPECIES,height+8,data: i);
			LineTrace(angle,24,0,TRF_THRUSPECIES,height-4,data: j);
			if( i.HitType == TRACE_HitNone ) {
				for(int tall=16; tall<=height; tall+=8) {
					LineTrace(angle,24,0,TRF_THRUSPECIES,tall,data: h);
					if( h.HitType == TRACE_HitWall ) {
						int zspd = 0;
						If(j.HitType==TRACE_HitWall||player.cmd.buttons&BT_FORWARD){zspd=2;}
						Else{ViewBob=0;}
						vel.z=zspd;
						player.jumpTics=-1;
					}
				}
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////

	// new jump function ///////////////////////////////////////////////////////
	//  code by Jarewill
	Override void CheckJump() {
		If ( player.readyweapon is "wosPunchDagger" || player.readyweapon is "wos_sprintWeap" || player.readyweapon is "wosBareHands" ) {
			Super.CheckJump();
		}
		Else If ( player.cmd.buttons & BT_JUMP ) {
			If ( player.cmd.buttons & (BT_FORWARD|BT_BACK|BT_MOVELEFT|BT_MOVERIGHT) && player.onground && stamin >= 35 ) {
				double slideBase = speedbase*4.0;
				double slideBonus = 3.0;
				If ( slideBonus < 0.5 ) { 
					slideBonus = 0.5; 
				}
				reactiontime = 18;
				player.deltaviewheight = -8;
				stamin -= 35;
				A_StartSound("weapons/swing",CHAN_BODY);
				//bSHOOTABLE=0; bNONSHOOTABLE=1; bDONTTHRUST=1;
				If ( player.cmd.buttons & BT_FORWARD ) {
					Thrust(slideBase*slideBonus,angle);
				}
				Else If ( player.cmd.buttons & BT_BACK ) {
					Thrust(slideBase*slideBonus,angle-180);
				}
				If ( player.cmd.buttons & BT_MOVELEFT ) {
					Thrust(slideBase*slideBonus,angle-270);
				}
				Else If ( player.cmd.buttons & BT_MOVERIGHT ) {
					Thrust(slideBase*slideBonus,angle-90);
				}
			}
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	// CheatGive() new commands ////////////////////////////////////////////////
	//  code by ramon.dexter
	override void CheatGive( String name, int amount ) {
		if ( name ~== "accuracy" ) {			
			if ( !amount ) { 
				A_GiveInventory("upgradeAccuracy", 1);
			} else {
				switch(amount) {
					case 1:
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 2:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 3:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 4:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 5:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 6:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 7:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 8:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 9:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
					case 10:
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
						A_GiveInventory("upgradeAccuracy", 1);
					break;
				}
			}
		} 
		else if ( name ~== "stamina" ) {			
			if ( !amount ) {
				A_GiveInventory("UpgradeStamina", 10);
			} else {
				A_GiveInventory("UpgradeStamina", amount*10);
			}
		} 
		else if ( name ~== "mind" ) {
			if ( !amount ) {
				A_GiveInventory("upgradeMind", 1);
			} else {
				switch(amount) {
					case 1:
						A_GiveInventory("upgradeMind", 1);
					break;
					case 2:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 3:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 4:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 5:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 6:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 7:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 8:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 9:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
					case 10:
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
						A_GiveInventory("upgradeMind", 1);
					break;
				}
			}
		}
		else if ( name ~== "meds" || name ~== "medicals" ) {
			if (!amount) {
				A_GiveInventory("wosHyposprej", 10);
				A_GiveInventory("wosKombopack", 5);
				A_GiveInventory("wosInstaLek", 2);
				A_GiveInventory("wosi_StimDevice", 5);
			} else {
				A_GiveInventory("wosHyposprej", amount);
				A_GiveInventory("wosKombopack", amount);
				A_GiveInventory("wosInstaLek", amount);
				A_GiveInventory("wosi_StimDevice", amount);
			}
		} 
		else if ( name ~== "notes" ) {
			A_GiveInventory("notePrayers", 1);
			A_GiveInventory("noteSHmedical", 1);
			A_GiveInventory("noteSHshouldergun", 1);
			A_GiveInventory("noteSHbinderStavesTechnical", 1);
			A_GiveInventory("noteSHbinderNote01", 1);
			A_GiveInventory("noteSHsilentHillsTouristGuide", 1);
			A_GiveInventory("noteSHminesReport", 1);
			A_GiveInventory("noteSHbindersOath", 1);
			A_GiveInventory("noteCommonDogmas", 1);
			A_GiveInventory("noteTheGreatHouses", 1);
			A_GiveInventory("noteTekGuildNotes", 1);
			A_GiveInventory("noteMillport", 1);
			A_GiveInventory("noteEmperorsList", 1);
			A_GiveInventory("noteEastcliff", 1);
			A_GiveInventory("noteTekGuild", 1);
			A_GiveInventory("noteLustyKolymanMaid1", 1);
			A_GiveInventory("noteLustyKolymanMaid2", 1);
			A_GiveInventory("noteLustyKolymanMaid3", 1);
			//A_GiveInventory("", 1);
		} 
		else if ( name ~== "weapons" ) {
			//A_GiveInventory("", 1);
			//A_GiveInventory("StormPistol", 1);
			A_GiveInventory("laserPistol", 1);
			A_GiveInventory("wosStrifeXbow", 1);
			A_GiveInventory("wosAssaultGun", 1);
			A_GiveInventory("wosPhaestonRifle", 1);
			A_GiveInventory("staffBlaster", 1);
			A_GiveInventory("wosMinimissileLauncher", 1);
			A_GiveInventory("wosGrenadeLauncher", 1);
			A_GiveInventory("wosFlamethrower", 1);
			A_GiveInventory("wosMauler", 1);
		} 
		else if ( name ~== "items" ) {			
			if ( !amount ) {
				//A_GiveInventory("", 1);
				A_GiveInventory("wosArmorShard", 1);
				A_GiveInventory("wosPortableMap", 1);
				A_GiveInventory("wosBinocular", 1); //
				A_GiveInventory("wosBlasterTurret", 1);
				A_GiveInventory("wosDeployableShield", 1);
				A_GiveInventory("wosEnvSuit", 1); //
				A_GiveInventory("wosFlameTurret", 1);
				A_GiveInventory("Flare", 1);
				A_GiveInventory("wosHyposprej", 1);
				A_GiveInventory("wosKombopack", 1);
				A_GiveInventory("wosInstaLek", 1);
				A_GiveInventory("zscMedPatch", 1);
				A_GiveInventory("zscMedicalKit", 1);
				A_GiveInventory("zscSurgeryKit", 1);
				A_GiveInventory("wosi_StimDevice", 1);
				A_GiveInventory("wosInterceptorDrone", 1);
				A_GiveInventory("wosLandMine", 1);
				A_GiveInventory("wosNightEyeDevice", 1); //
				A_GiveInventory("wosQuickTravel", 1); //
				A_GiveInventory("wosRebreather", 1); //
				A_GiveInventory("wosRegenModule", 1); //
				A_GiveInventory("wosShadowArmor", 1);
				A_GiveInventory("wosSpringMine", 1);
				A_GiveInventory("wosStealthBoy", 1); //
				A_GiveInventory("wosSwarmers", 1); 
				A_GiveInventory("wosTargeter", 1); //
			} else {
				//A_GiveInventory("", amount);
				A_GiveInventory("wosArmorShard", amount);
				A_GiveInventory("wosPortableMap", amount);
				//A_GiveInventory("wosBinocular", amount); //
				A_GiveInventory("wosBlasterTurret", amount);
				A_GiveInventory("wosDeployableShield", amount);
				//A_GiveInventory("wosEnvSuit", 1); //
				A_GiveInventory("wosFlameTurret", amount);
				A_GiveInventory("Flare", amount);
				A_GiveInventory("wosHyposprej", amount);
				A_GiveInventory("wosKombopack", amount);
				A_GiveInventory("wosInstaLek", amount);
				A_GiveInventory("zscMedPatch", amount);
				A_GiveInventory("zscMedicalKit", amount);
				A_GiveInventory("zscSurgeryKit", amount);
				A_GiveInventory("wosi_StimDevice", amount);
				A_GiveInventory("wosInterceptorDrone", amount);
				A_GiveInventory("wosLandMine", amount);
				//A_GiveInventory("wosNightEyeDevice", 1); //
				//A_GiveInventory("wosQuickTravel", 1); //
				//A_GiveInventory("wosRebreather", 1); //
				//A_GiveInventory("wosRegenModule", 1); //
				A_GiveInventory("wosShadowArmor", amount);
				A_GiveInventory("wosSpringMine", amount);
				//A_GiveInventory("wosStealthBoy", 1); //
				A_GiveInventory("wosSwarmers", amount); 
				//A_GiveInventory("wosTargeter", 1); //
			}
		} 
		else if ( name ~== "armor" ) {
			A_GiveInventory("wosLeatherArmor", 1);
			A_GiveInventory("wosMetalArmor", 1);
			A_GiveInventory("wosBinderArmorBasic", 1);
			A_GiveInventory("wosBinderArmorAdvanced", 1);
			A_GiveInventory("wosKineticArmor", 1);
			//A_GiveInventory("", 1);
		}
		else if ( name ~== "shouldergun" ) {
			A_GiveInventory("shoulderGun", 1);
			A_GiveInventory("magazine_shoulderGun", 32);
			A_GiveInventory("shoulderGunCharger", 1);
		}
		else if ( name ~== "gold" || name ~=="money" || name ~== "coin" || name ~== "coins" ) {
			if ( !amount ) {
				A_GiveInventory("Coin", 1);
			} else {
				A_GiveInventory("Coin", amount);
			}
		}
		else if ( name ~== "all" || name ~== "everything" ) {
			A_Log("\c[red][ Cheat blocked because of dangerously breaking the game. Use other cheats if you are in need of assistance. ]");
		}
		else if ( name ~== "keys" ) {
			A_GiveInventory("skeletonKey", 1);
			A_GiveInventory("BHWasteCatacombKey", 1);
			A_GiveInventory("BHWasteKey", 1);
			A_GiveInventory("BHminesKey", 1);
			A_GiveInventory("BHbathKey", 1);
			A_GiveInventory("BHpowerPlantKey", 1);
			A_GiveInventory("BHpowerPlantKey2", 1);
			A_GiveInventory("BHpowerPlantReactorKey", 1);
			A_GiveInventory("BHfactoryKey", 1);
			A_GiveInventory("SHtgPowerplantKey", 1);
			A_GiveInventory("m08k_BP_pokladnice", 1);
			//A_GiveInventory("", 1);
		}
		else if ( name ~== "implants" ) {
			A_GiveInventory("implant_health", 1);
			A_GiveInventory("implant_stamina", 1);
		}
		else if ( name ~== "binderpack" ) {
			A_GiveInventory("binder_helmet", 1);
			//armor
			A_GiveInventory("wosKineticArmor", 1);
			// weapons
			A_GiveInventory("shoulderGun", 1);
			A_GiveInventory("magazine_shoulderGun", 32);
			A_GiveInventory("StaffBlaster", 1);
			A_GiveInventory("laserpistol", 1);
			//ammo
			A_GiveInventory("EnergyPod", 400);
			A_GiveInventory("wosenergykit", 10);
			A_GiveInventory("shoulderGunCharger", 1);
			//grenades
			A_GiveInventory("wosGrenadeE", 15);
			A_GiveInventory("wosGrenadeF", 15);
			A_GiveInventory("wosGrenadeG", 15);
			A_GiveInventory("wosArmorShard", 10);
			//medical
			A_GiveInventory("wosHyposprej", 30);
			A_GiveInventory("wosKombopack", 10);
			A_GiveInventory("wosInstaLek", 5);
			A_GiveInventory("wosi_StimDevice", 5);
			//quicktravel
			A_GiveInventory("wosQuickTravel", 1);
			//binocular
			A_GiveInventory("wosBinocular", 1);
			//BlasterTurret_item
			A_GiveInventory("wosInterceptordrone", 5);	
			//DeployableShieldItem
			A_GiveInventory("wosDeployableShield", 1);
			//Swarmers_item
			A_GiveInventory("wosSwarmers", 5);
			// goldCoin x2500
			A_GiveInventory("Coin", 2500);
		}
		else if ( name ~== "binderpacklight" ) {
			A_GiveInventory("binder_helmet", 1);
			//armor
			A_GiveInventory("wosKineticArmor", 1);
			// weapons
			A_GiveInventory("shoulderGun", 1);
			A_GiveInventory("magazine_shoulderGun", 32);
			A_GiveInventory("StaffBlaster", 1);
			// ammo
			A_GiveInventory("EnergyPod", 400);
			A_GiveInventory("wosenergykit", 10);
			A_GiveInventory("shoulderGunCharger", 1);
			// medical
			A_GiveInventory("wosHyposprej", 20);
			A_GiveInventory("wosKombopack", 5);
			A_GiveInventory("wosInstaLek", 2);
			A_GiveInventory("wosKombopack", 5);
			A_GiveInventory("wosi_StimDevice", 5);
			// grenades
			A_GiveInventory("wosGrenadeE", 5);
			A_GiveInventory("wosGrenadeF", 5);
			A_GiveInventory("wosInstaLek", 5);
			//quicktravel
			A_GiveInventory("wosQuickTravel", 1);
			//binocular
			A_GiveInventory("wosBinocular", 1);
			// gold
			A_GiveInventory("Coin", 2500);
		}
		else if ( name ~== "badge" || name ~== "binderbadge" ) {
			A_GiveInventory("binderbadge", 1);
		}
		else if ( name ~== "arkadiakeys" || name ~== "keysarkadia" ) {
			A_GiveInventory("arkadia_templeVaultKey_01", 1);
			A_GiveInventory("arkadia_templeVaultKey_02", 1);
			A_GiveInventory("arkadia_templeVaultKey_03", 1);
		}
		else {
			Super.CheatGive(name,amount);
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	// States definition ///////////////////////////////////////////////////////
	States {
		Spawn:
			BNDP A -1;
			Loop;
		See:
			BNDP ABCD 4;
			Loop;
		Missile:
			BNDP F 12 BRIGHT;
			Goto Spawn;
		Melee: 
			BNDP E 6;
			Goto Missile;
		Pain:
			BNDP G 4;
			BNDP G 4 A_Pain();
			Goto Spawn;
		Death:
			BNDP H 0 A_PlayerSkinCheck("AltSkinDeath");
		Death1:
			BNDP H 10;
			BNDP I 10 A_PlayerScream();
			BNDP J 10 A_NoBlocking();
			BNDP KLM 10;
			BNDP N -1;
			Stop;
		XDeath:
			BNDP O 0 A_PlayerSkinCheck("AltSkinXDeath");
		XDeath1:						
			BNDP RSTU 4;			
			BNDP W -1;
			Stop;
		AltSkinDeath:
			BNDP H 6;
			BNDP I 6 A_PlayerScream();
			BNDP JK 6;
			BNDP L 6 A_NoBlocking();
			BNDP MNO 6;
			BNDP P -1;
			Stop;
		AltSkinXDeath:
			BNDP Q 5 A_PlayerScream;
			BNDP R 0 A_NoBlocking;
			BNDP R 5 A_SkullPop;
			BNDP STUVWX 5;
			BNDP Y -1;
			Stop;
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
	/*void HandleWeight() {
		if ( maxstamin == 440 ) { weightmax = 2420; }
		if ( maxstamin == 520 ) { weightmax = 2860; }
		if ( maxstamin == 600 ) { weightmax = 3300; }
		if ( maxstamin == 700 ) { weightmax = 3850; }
		if ( maxstamin == 800 ) { weightmax = 4400; }
	}*/
	/*void FallDamage() {
		double cvel = vel.z;
		int damage;
		If(pvel<cvel) {
			If(pvel<=-32){damage=(int)(pvel)*2;}
			Else If(pvel<=-23){damage=(int)(pvel);}
			Else If(pvel<=-16&&bracing==0){damage=(int)(pvel)/4;}
			If(bracing==1){damage/=2;}
			DamageMobj(null,null,-damage,"Falling");
		}
	}*/
	/*void HealthSlow() {
		double hpeed = 1.0; //health*0.01;
		double stmed = 0.01 * (175 - stamin);
		If(stmed<0){stmed=0;}
		hpeed -= stmed;
		If(hpeed<0.1){hpeed=0.1;}
		If(hpeed>1.0){hpeed=1.0;}        
		//If(currentarmor!=4)
		//{
		//	If(SpeedUpgrade==2){hpeed*=1.5;}
		//	Else If(SpeedUpgrade==1){hpeed*=1.2;}
		//}
		If(sprinting==1){
			hpeed*=3.0;
            If(GetPlayerInput(MODINPUT_BUTTONS)&BT_RUN){hpeed/=2;}			
		} else if ( sprinting == 0 ) {
			hpeed = 0.55;
		}
		If(currentarmor==2){ hpeed*=0.8; }
		If(overweight==1){ hpeed*=0.5; } //Halve speed when true
        If(overweight2==1){ hpeed*=0.01; } //Set it to veery slow when true
		//If(surgery==1||repairing==1){hpeed=0;}
		ViewBob = 1.1*hpeed;
		speed = hpeed;
	}*/
	/*void CheckSprint()
	{
		If (player.cmd.buttons&BT_SPEED&&!slowed) {
			running = 1;
			//sprinting = 1;
		}
		Else {
			running = 0;
			//sprinting = 0;
		}
	}*/
	////////////////////////////////////////////////////////////////////////////
	
	//  climbing code by Dodopod  //////////////////////////////////////////////
	/*const climbReach = 8;
    const thrustSpeed = 4;
    bool climbing;
    int maxLedgeHeight;
    int climbSpeed;
    property MaxLedgeHeight: maxLedgeHeight;
    property ClimbSpeed: climbSpeed;	

    override void CheckJump() {
        let player = self.player;

        double ledgeHeight;
        {
            vector3 oldPos = pos;

            SetXyz(pos + (0, 0, maxLedgeHeight));   // Account for thin 3D floors
            ledgeHeight = GetZAt(radius + climbReach, 0) - oldPos.z;
            SetXyz(oldPos);
        }

        bool jump = player.cmd.buttons & BT_JUMP;
        double clearance = GetZAt(radius + climbReach, 0, 0, GZF_CEILING) - GetZAt(radius + climbReach, 0);

        // Start/stop climbing
        if (!climbing) {
			// allow climbing only with dagger in hand /////////////////////////
            if (jump && ledgeHeight > maxStepHeight && ledgeHeight <= maxLedgeHeight && player.readyweapon is "wosPunchDagger") {
                climbing = true;
                A_StartSound("*Climb", CHAN_BODY);
                viewBob = 0.0;
            }
        }
        else {
            if (!jump || ledgeHeight > maxLedgeHeight) { // Drop down/get knocked down from ledge
                climbing = false;
            }
            else if (ledgeHeight <= maxStepHeight && clearance >= 0.5 * height) { // Reach top of ledge
                climbing = false;

                // Crouch, so player can fit into small spaces
                player.crouchFactor = 0.5;
                SetOrigin(pos + (0, 0, 0.5 * fullHeight), false);   // Keep view from jerking
                player.viewHeight *= 0.5;

                VelFromAngle(thrustSpeed, angle);  // Thrust player onto ledge
            }

            if (!climbing) { // Exit climbing state
                viewBob = 1.0;
                player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetUpState());
                player.jumpTics = -1;
            }
        }

        if (climbing) {
            // Weapon will reset to Ready state, so we need to set it to Down state every tic
            player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetDownState());
            let psp = player.GetPsprite(PSP_WEAPON);
			
            if (psp.y == WEAPONTOP) { // Keep weapon down
                psp.y = WEAPONBOTTOM;
            }
            else { // Lower weapon twice as fast
                psp.y += 6;
            }

            if (ledgeHeight <= maxStepHeight) { // Hold onto ledge at top, if player can't get on it
                vel = (0, 0, 0);
            }
            else { // Climb ledge
                vel = (0, 0, climbSpeed);
            }
        }
		
        Super.CheckJump();
    }*/
	////////////////////////////////////////////////////////////////////////////
}
////////////////////////////////////////////////////////////////////////////////

// no weapon ///////////////////////////////////////////////////////////////////
class wos_sprintWeap : wosWeapon {
	Default {
		weapon.selectionOrder 4000;
		Tag "$T_sprinting";
		Mass 0;
	}
	States {
		Nope:
			TNT1 A 1 A_WeaponReady();
			Loop;
		Ready:
			TNT1 A 1 A_WeaponReady(WRF_NOSWITCH);
			Loop;
		Select:
			TNT1 A 0 A_Raise();
			Loop;
		Deselect:
			TNT1 A 0 A_Lower();
			Loop;
		Fire:
			TNT1 A 0;
			Goto Ready;
	}
}
class wosBareHands : wosWeapon {
	Default {	
		+WEAPON.MELEEWEAPON;
		+WEAPON.NOALERT;
		+WEAPON.WIMPY_WEAPON;
		+INVENTORY.UNDROPPABLE;
		+INVENTORY.UNCLEARABLE;
		+INVENTORY.UNTOSSABLE;
		weapon.selectionOrder 5000;
		weapon.slotNumber 1;
		Weapon.slotPriority 0.1;
		Tag "$T_bareHands";
		Mass 0;
	}
	States {
		Nope:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER1);
			Goto Ready;
		Ready:
			TNT1 A 1 A_WeaponReady(WRF_ALLOWUSER1);
			Loop;
		Select:
			TNT1 A 0 A_Raise();
			Loop;
		Deselect:
			TNT1 A 0 A_Lower();
			Loop;
		Fire:
			TNT1 A 0;
			Goto Ready;
		User1:
			TNT1 A 0 { 
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { wos_stripArmor(); }
			}
			goto Nope;
	}
}
////////////////////////////////////////////////////////////////////////////////

// visible player body /////////////////////////////////////////////////////////
class binderPlayerBody : Actor {
	Default {
		+NOGRAVITY; 
		+NOBLOCKMAP;
		+FORCEYBILLBOARD; 
		+FLOORCLIP;
	}
	Override void Tick() {
		Super.Tick();
		If(master==null||master.health<1){Destroy();}
		If(master.pitch>=55){sprite=master.sprite;}Else{sprite=GetSpriteIndex("TNT1");}
		frame=master.frame;
		translation=master.translation;
		A_Warp(AAPTR_MASTER,-16,0,0,0,WARPF_NOCHECKPOSITION);
	}
	States {
		Spawn:
			BNDP A 1;
			Loop;
	}
}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// DEPRECATED - OBSOLETE ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////