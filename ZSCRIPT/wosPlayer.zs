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
	int SpeedUpgrade;
	
	Actor backplaye;
	bool nightEyeGrainEnable;
	
	////////////////////////////////////////////////////////////////////////////
	
	//  overall override  //////////////////////////////////////////////////////
	override void Tick() {
		pvel=vel.z;
		pang=angle;
		encumbrance=0; //Before ticking, reset the encumbrance
        Super.Tick();
		// LF encumberance code ////////////////////////////////////////////////
		weightmax=2500; //Set the default
        //If(HandleUpgrade==1){weightmax+=500;} //Add 500 with the specific upgrade at level 1
        //If(HandleUpgrade==2){weightmax+=1000;} //Add 1000 if it's at 2 instead
        If(CountInv("AmmoSatchel")){weightmax*=2;} //Double with the backpack
		If(encumbrance>weightmax){overweight=1;}Else{overweight=0;} //If it's over the limit (for example 1500/1000)
        If(encumbrance>(weightmax*2)){overweight2=1;}Else{overweight2=0;} //If it's twice over the limit (for example 2000/1000) 
		// armor ///////////////////////////////////////////////////////////////
		If (armoramount<1) {
			currentarmor=0; 
            armorpower=0;
        }		
		If (currentarmor==1) {
            encumbrance+=LeatherWeight/5; 
            mass=300; 
            bNOBLOOD=0;
        }
		Else If (currentarmor==2) {
            encumbrance+=MetalWeight/5; 
            mass=400; 
            bNOBLOOD=1;
        }
		Else If (currentarmor==3) {
            encumbrance+=BinderBasicWeight/7; 
            mass=350; 
            bNOBLOOD=0;
        }
        Else If (currentarmor==4) {
            encumbrance+=BinderBasicWeight/7; 
            mass=350; 
            bNOBLOOD=1;
        }
		Else {
			mass=100; 
			bNOBLOOD=0; 
			PainChance=255;
		}


		//  LF bleeding code  //////////////////////////////////////////////////
		If (bleedlevel>0) {
            If( bleedtimer >= ( 70 / bleedlevel )) {
				//A_Print("bleedDamage!");
                BleedDamage();
			}
			Else {
				//A_Print("bleedTimer++");
				bleedtimer++;
			}
		}
		//  LF 1st person player body code  ////////////////////////////////////
		If(backplaye==null) {
			bool spawn1; 
            Actor spawn2;
			[spawn1, spawn2] = A_SpawnItemEx("binderPlayerBody",flags: SXF_SETMASTER);
			backplaye=spawn2;
		}
		
		//  LF movement inspired code  /////////////////////////////////////////
		//FallDamage();
		HealthShake();
        SprintSpeed();
        HealthSlow();
		
    }
	override void PostBeginPlay() {
        Super.PostBeginPlay();
		// LF sprinting code //
        stamin = 350;
		////////
    }	
	//  Lost Frontier adapted code  ////////////////////////////////////////////
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
    void HealthSlow() {
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
			hpeed*=2.5;
            If(GetPlayerInput(MODINPUT_BUTTONS)&BT_RUN){hpeed/=2;}			
		} else if ( sprinting == 0 ) {
			hpeed = 0.55;
		}
		If(currentarmor==2){ hpeed*=0.8; }
		If(overweight==1){ hpeed*=0.5; } //Halve speed when true
        If(overweight2==1){ hpeed*=0.01; } //Set it to veery slow when true
		//If(surgery==1||repairing==1){hpeed=0;}
		ViewBob=1.1*hpeed;
		speed=hpeed;
	}
	void HealthShake()
	{
		double shake = 0.2 - health*0.002;
		double stamshak = 0.001 * (350 - stamin);
		If(stamshak>0){shake+=stamshak;}
		If(shake<0){shake=0;}
		If(health<1){shake=0;}
		angle+=frandom(-shake,shake);
		pitch+=frandom(-shake,shake);
	}
	void SprintSpeed() {
        int maxstamin = 350;
		If(maxhealth==120){maxstamin=420;}
		If(maxhealth==140){maxstamin=490;}
		If(maxhealth==160){maxstamin=560;}
		If(maxhealth==180){maxstamin=630;}
		If(maxhealth==200){maxstamin=700;}
		If(player.cheats&(CF_GODMODE|CF_GODMODE2)){stamin=maxstamin;}
		If(sprinting==0) {
			If(stamin>10&&GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED) {
				//A_Print("speeding up!", 1.0);
				selectedWeapon=Weapon(player.readyweapon);
				sprinting=1;
				bracing=1;
				If(!CountInv("wos_sprintWeap")){
					A_GiveInventory("wos_sprintWeap",1);
				}
				A_SelectWeapon("wos_sprintWeap");
			}
			Else If( stamin<maxstamin && !(GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED) && ( !(GetPlayerInput(MODINPUT_BUTTONS)&(BT_FORWARD|BT_BACK|BT_MOVELEFT|BT_MOVERIGHT)) || vel.length()<2 ) )
			/*else if ( stamin<maxstamin && !(GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED) )*/
			{
				stamin++;				
			}
			If(player.readyweapon is "wos_sprintWeap") {
				Player.SetPSprite(PSP_WEAPON,player.readyweapon.FindState("Nope"));
				A_SelectWeapon(selectedWeapon.GetClassName());
			}
		}
		Else {
			bracing=1;
			If(GetPlayerInput(MODINPUT_BUTTONS)&(BT_FORWARD|BT_BACK|BT_MOVELEFT|BT_MOVERIGHT)){If(stamin>0){stamin--;}}
			If(stamin>0&&GetPlayerInput(MODINPUT_BUTTONS)&BT_SPEED){ }
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
	void FallDamage() {
		double cvel = vel.z;
		int damage;
		If(pvel<cvel) {
			If(pvel<=-32){damage=(int)(pvel)*2;}
			Else If(pvel<=-23){damage=(int)(pvel);}
			Else If(pvel<=-16&&bracing==0){damage=(int)(pvel)/4;}
			If(bracing==1){damage/=2;}
			DamageMobj(null,null,-damage,"Falling");
		}
	}
	//damageMObj()
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
						armoramount -= damage/3;
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
	
	//  climbing code by Dodopod  //////////////////////////////////////////////
	const climbReach = 8;
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
            if (jump && ledgeHeight > maxStepHeight && ledgeHeight <= maxLedgeHeight) {
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
    }
	////////////////////////////////////////////////////////////////////////////

	Default {	
		+FLOORCLIP
		
		//  various player properties  /////////////////////////////////////////
		Player.ForwardMove 0.75, 0.75;
		Player.SideMove 0.75, 0.75;
		Player.AirCapacity 2.0;
		player.viewheight 48;
		player.attackzoffset 11;
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
		Player.WeaponSlot 1, "zscPunchDagger";
		Player.WeaponSlot 2, "zscStrifeCrossbow", "StormPistol", "laserPistol";
		Player.WeaponSlot 3, "zscAssaultGun", "staffBlaster";
		Player.WeaponSlot 4, "zscMiniMissileLauncher";
		Player.WeaponSlot 5, "zscStrifeGrenadeLauncher";
		Player.WeaponSlot 6, "zscFlameThrower";
		Player.WeaponSlot 7, "zscMauler";		
		//Player.WeaponSlot 8, "Sigil";
		//Player.WeaponSlot 9, "hookShotWeapon";		
		//  start items  ///////////////////////////////////////////////////////
		//Player.StartItem "zscFist", 1;	
		Player.StartItem "zscPunchDagger", 1;	
		Player.StartItem "zAssaultGunMag", 32;
		Player.StartItem "hookShot_magazine", 20;
		Player.StartItem "laserPistolCharge", 32;
		Player.StartItem "shldrGunMag", 32;
		Player.StartItem "Staffmagazine", 48;
		Player.StartItem "missileLauncherMag", 8;
		Player.StartItem "stormPistol_magazine", 12;
		//Player.StartItem "executorRifleMagazine", 24;
		Player.StartItem "journalitem", 1;
		Player.StartItem "PDAReader", 1;
		//  custom properties  /////////////////////////////////////////////////
		binderPlayer.MaxLedgeHeight 56;
		binderPlayer.ClimbSpeed 2;	
	}
	
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
		/*
			BNDP O 5 A_StartSound("Special/Gibdeath",CHAN_VOICE);
			BNDP OOOO 0 A_SpawnDebris("FlyingBlood",1);
			BNDP P 5 A_SpawnDebris("FlyingGibOffal",1);
			BNDP PPPP 0 A_SpawnDebris("FlyingBlood",1);
			BNDP P 0 A_SpawnDebris("FlyingGibOffal",1);
			BNDP P 0 A_SpawnDebris("FlyingGibEntrails",1);
			BNDP P 0 A_SpawnDebris("FlyingGibOffal",1);
			BNDP Q 4 A_NoBlocking();
			BNDP QQQ 0 A_SpawnDebris("FlyingBlood",1);
			*/
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
}
class wos_sprintWeap : augmentedWeapon {
    Default {
        weapon.selectionOrder 4000;
        Tag "Sprinting";
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
class binderPlayerBody : Actor {
	Default {
		+NOGRAVITY; +NOBLOCKMAP;
		+FORCEYBILLBOARD; +FLOORCLIP;
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
////////////////////////////////////////////////////////////////////////////////