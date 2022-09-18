////////////////////////////////////////////////////////////////////////////////
//  shoulderGun weapon/item  ///////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
credits: 
sprites: banjo software, ramon.dexter
model: ramon.dexter
sounds: banjo software
zscript: ramon.dexter, gzdoom.pk3
*/
////////////////////////////////////////////////////////////////////////////////
//const shoulderGunWeight = 75;
//const shoulderGunMagWeight = 1;
//const shoulderGun_chargerWeight = 35;

//  puff with decal  ///////////////////////////////////////////////////////////
class decalMaulerPuff : MaulerPuff {
	Default {
		//+NODECAL
		Decal "BulletChip";
	}
}
////////////////////////////////////////////////////////////////////////////////
//  inventory item with new functionality  /////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class shoulderGun : wosPickup {	
	
	action void W_FireShoulderGun(bool useAmmo, bool doAlertMonsters) {        
		if (player == null) {
			return;
		}				
		player.mo.PlayAttacking2 ();
		let ownr2 = binderPlayer(invoker.owner);
		if (useAmmo) {
			ownr2.takeInventory("magazine_shoulderGun", 1);
		}		
		//  shoot action z blasterStaff lvl.2 altFire  /////////////////////////
		A_StartSound("weapons/shoulderGun/loop", CHAN_6, CHANF_DEFAULT, 1.0, false);                               
		//A_GunFlash();
		A_FireProjectile("greenArcLightning", 0.1*random(20,-20), false, -10, 20, 0, 0);
		A_SpawnItemEx("redFlashShort", 8, 0, 16, 0);
		if (doAlertMonsters) {
			A_AlertMonsters();
		}
		A_OverlayOffset(6, random(-2,2), random(-2,2), WOF_INTERPOLATE); //vypnout, protoze trese i hlavni zbrani
		////////////////////////////////////////////////////////////////////////
	}	
	
	Default {
		//$Category "Powerups/WoS"
		//$Title "ShoulderGun"
		
		+INVENTORY.INVBAR
		+INVENTORY.KEEPDEPLETED
		+INVENTORY.UNDROPPABLE
		+INVENTORY.UNTOSSABLE
		Tag "$TAG_shoulderGun";
		Inventory.Icon "I_SHCN";
		Inventory.Amount 1;
		Inventory.MaxAmount 1;	
		Inventory.InterhubAmount 1;
		Inventory.PickupMessage "$PICKUP_shoulderGun";
		Decal "BulletChip";
		Mass shoulderGunWeight;
		
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A 0 {
				if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USE ) { return resolveState("UseCheck"); }
				else if ( GetPlayerInput(MODINPUT_BUTTONS)&BT_USER1 && CountInv("shoulderGunCharger") && CountInv("magazine_shoulderGun") != 32 ) { return resolveState("UseReload"); }
				else { return resolveState("UseYes"); }
			}
			Fail;
		UseCheck:
			TNT1 A 0 A_Log(String.Format("\c[yellow][ %i%s", CountInv("magazine_shoulderGun"), "\c[yellow] pts ShoulderGun battery left ]"));
			Fail;
		UseReload:
			TNT1 A 0 {
				let item = self.FindInventory("shoulderGunCharger");
				if ( item != null ) {
					useInventory(item);
				} else {
					A_Log("\c[red][ You need ShoulderGun charger to reload your ShoulderGun! ]");
				}
			}
			Fail;
		UseYes:
			TNT1 A 0 {			
				statelabel nextstate = "remove";
				let ownr = binderPlayer(invoker.owner); 
				if (ownr && ownr.countInv("magazine_shoulderGun") > 0 ) {					
					nextstate = "startoverlay";						 									
				}
				else {
					A_Log("\c[red][ Not enough cells! ]");
					A_ClearOverlays(6, 6);
					return ResolveState("remove");					
				}
				return resolvestate(nextstate);
			}
			Fail;
	  
	  
		startoverlay:
			TNT1 A 0 {
				int layer = 6;
				A_OverLay(layer,"shootShoulderGun");
			}
			wait;
		shootShoulderGun:
			// animation remade with new model //////////////////////////////////////////
            DUMA ABCDEFGHIJ 1;
            DUMF AA 1;
            DUMF A 2;
            DUMF B 2 Bright W_FireShoulderGun(true, true);
            DUMF C 2 Bright W_FireShoulderGun(false, false);
            DUMF B 2 Bright W_FireShoulderGun(false, false);
            DUMF C 2 Bright W_FireShoulderGun(false, false);
            DUMF B 2 Bright W_FireShoulderGun(false, false);
            DUMF C 2 Bright W_FireShoulderGun(false, true);
            DUMA J 3;
            DUMA J 4 A_StartSound("weapons/shoulderGun/stop",6); //zrusit zvuk blesku
            DUMA J 5;
            DUMA J 3;
            DUMA J 3;
            DUMA JIH 4;
            DUMA GFEDCBA 1;
			TNT1 A 0 {
				return resolveState("remove");
			}
			/////////////////////////////////////////////////////////////////////////////
			/*SHCH JIHGFEDCBA 1;
			SHCH AA 1;
			//SHCN A 1 A_StartSound("weapons/shoulderGun/fire", CHAN_7, CHANF_DEFAULT, 1.0, false);
			SHCN A 2;
			SHCN I 2 Bright W_FireShoulderGun(true, true);
			SHCN J 2 Bright W_FireShoulderGun(false, false);
			SHCN I 2 Bright W_FireShoulderGun(false, false);
			SHCN J 2 Bright W_FireShoulderGun(false, false);
			SHCN I 2 Bright W_FireShoulderGun(false, false);
			SHCN J 2 Bright W_FireShoulderGun(false, true);
			SHCN B 3;
			SHCN C 3;
			SHCN D 4 A_StartSound("weapons/shoulderGun/stop",6); //zrusit zvuk blesku
			SHCN E 5;
			SHCN F 4;
			SHCN G 4;
			SHCN H 3;
			SHCN A 3;
			SHCH ABCDEFGHIJ 1;
			TNT1 A 0 {
				return resolveState("remove");
			}*/
		
		remove:
			TNT1 A 0 {
				A_ClearOverlays(6, 6);
			}
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////
//  projectile  ////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class greenArcLightning : FastProjectile {
	Default {
		Speed 50;
		Radius 4;
		Height 4;
		Damage 10;
		Renderstyle "Add";
		//DamageType "Disintegrate";
		MissileType "arcLightningTrailSpawner";
		Decal "DoomImpScorch";

		+CANNOTPUSH
		+BLOODLESSIMPACT
		+THRUGHOST
		+NOEXTREMEDEATH
	}

	states {
		Spawn:
			TNT1 A 2;
		Looplet:
			TNT1 A 0;
			TNT1 A 2 A_ChangeVelocity(frandom(-8,8), frandom(-8,8), frandom(-3, 3), 0);
			TNT1 A 2 A_ChangeVelocity(frandom(-8,8), frandom(-8,8), frandom(-3, 3), 0);
			TNT1 A 2 A_ChangeVelocity(frandom(-6,6), frandom(-6,6), frandom(-3, 3), 0);
			Stop;
		Ded:
			TNT1 A 1;
			stop;
	}
}
class arcLightningTrailSpawner : actor {
	Default {
		+NOINTERACTION
		+NOGRAVITY
		+THRUGHOST
	}

	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 2 A_SpawnItemEx("arcLightningTrail",frandom(2.0,-2.0),frandom(2.0,-2.0),4+frandom(2.0,-2.0),0,0,0,0,0,0);
			Stop;
	}
}
class arcLightningTrail : actor {
	Default {
		RenderStyle "Add";
		Scale 0.175;
		Alpha 0.75;

		+NOINTERACTION
		+NOGRAVITY
		+THRUGHOST
	}

	States {
		Spawn:
			TNT1 A 0;
			PLSG BBCCDD 1 bright A_FadeOut(0.1);
		Trolololo:
			TNT1 A 0 A_SetScale(Scale.X -0.01, Scale.Y -0.01);
			PLSG D 1 bright A_FadeOut(0.08);
			Loop;
	}
}
class redFlashShort : flashBase { //used for light to spawn
	Default {
		+NOINTERACTION;
	}
	States {
		Spawn:
			TNT1 A 3;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
//  weapon/item ammunition  ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class magazine_shoulderGun : CustomInventory {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Shouldercannon Ammo"
		
		-INVENTORY.INVBAR	
		radius 10;
		height 16;
		Tag "$TAG_magazine_shoulderGun";
		inventory.icon "I_SHCC";
		inventory.amount 1;
		Inventory.MaxAmount 32;
		inventory.interhubamount 32;
		Inventory.PickupMessage "$PICKUP_magazine_shoulderGun";
		Mass 0;
	}
	
	States {
		Spawn:
			SHCC AB 6 Bright;
			Loop;
		Use:
			TNT1 A 0;
			Stop;
	}
}
class shoulderGunCharger : wosPickup {
	action void WOS_reloadShoulderGun() {
		if ( player == null ) {
			return;
		}
		int ammoToCharge;
		ammoToCharge = 32 - CountInv("magazine_shoulderGun");
		if ( CountInv("magazine_shoulderGun") == 32 ) {
			A_Log("$M_shouldergunmagfull");
		} else {
			if ( CountInv("EnergyPod") >= ammoToCharge && CountInv("EnergyPod") != 0 ) {
				A_StartSound("weapons/shouldergun/recharge");
				A_GiveInventory("magazine_shoulderGun", ammoToCharge);
				A_TakeInventory("EnergyPod", ammoToCharge);				
				A_Log(string.format("%s%i%s", stringtable.localize("$M_shouldergunReload1"), ammoToCharge, stringtable.localize("$M_shouldergunReload2")));
			} else {
				A_StartSound("weapons/shouldergun/noAmmo");
				A_Log("$M_notenoughenergypods");
			}
		}
	}
	Default {
		//$Category "SoA/Items"
		//$Color 17
		//$Title "ShoulderGun Charger"
		Tag "$T_shoulderGun_charger";
		Inventory.Icon "I_SHMG";
		Inventory.PickupMessage "$F_shoulderGun_charger";
		//Inventory.UseSound "weapons/shouldergun/recharge";
		Mass shoulderGun_chargerWeight;
		//Scale 0.35;
	}
	States {
		Spawn:
			DUMM AAAABBB 6;
			Loop;
		Use:
			TNT1 A 0 WOS_reloadShoulderGun();
			Fail;
	}
}
class shoulderGunMag_item : wosPickup {
	Default {
		//$Category "Ammunition/WoS"
		//$Title "Shouldercannon Ammo pack"
		
		+INVENTORY.INVBAR		
		radius 10;
		height 10;
		//scale 0.55;
		Tag "$TAG_shoulderGunMag_item";
		inventory.icon "I_SHMG";
		inventory.amount 1;
		Inventory.MaxAmount 10;
		inventory.interhubamount 10;
		Inventory.PickupMessage "$PICKUP_shoulderGunMag_item";
		
		Mass shoulderGunMagWeight;
	}
	States {
		Spawn:
			DUMM AAAABBB 6;
			Loop;
		Use:
			TNT1 A 0 A_GiveInventory("magazine_shoulderGun", 32);
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
//  dummy decorative items  ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class shoulderGun1_dummy : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "shoulderGun1 dummy"
		
		-SOLID
		
		radius 10;
		height 10;
		Tag "$TAG_shoulderGun";
	}
	
	States {
		Spawn:
			DUMM A -1;
			Stop;			
	}
}
class shoulderGun2_dummy : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "shoulderGun2 dummy"
		
		-SOLID
		
		radius 10;
		height 10;
		Tag "$TAG_shoulderGun";
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
class shoulderGun3_dummy : actor {
	Default {
		//$Category "Decorations/WoS"
		//$Title "shoulderGun3 dummy"
		
		-SOLID
		
		radius 10;
		height 10;
		Tag "$TAG_shoulderGun";
	}
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////