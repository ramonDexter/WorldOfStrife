////////////////////////////////////////////////////////////////////////////////
//  WoS weapons main definition  ///////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// weapons weights /////////////////////////////////////////////////////////////
const stormPistolBaseWeight = 50;
const laserPistolBaseWeight = 55;
const xBowBaseWeight = 45;
const assaultGunBaseWeight = 110;
const blasterStaffBaseWeight = 175;
const executorRifleWeight = 320;
const missileLauncherBaseWeight = 420;
const grenadeLauncherBaseWeight = 570;
const flamerBaseWeight = 470;
const maulerBaseWeight = 750;
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  weapon base class  /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
class wosWeapon : StrifeWeapon {
	// vars&properties /////////////////////////////////////////////////////////
	//int magazine; 
	//property Magazine : magazine;
	//int magazineMax;
	//property magazineMax : magazineMax;
    //class<wosAmmo> magazineType;
    //property magazineType : magazineType;	
	
	//  staffBlaster actions  //////////////////////////////////////////////////
	action void W_FireStaffBlaster(string projectileType, string flashType, bool alertMonsters) {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			// tahle cast odebira naboje; pokud vykomentuju, nebere naboje
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		//let ownr = binderPlayer(invoker.owner);
		//player.mo.PlayAttacking2 ();
		double angl = Random2[projectileType]() * (7.625 / 256) * AccuracyFactor();
		//A_FireProjectile (projectileType, angl, false, 6.5, 3, FPF_NOAUTOAIM);	
		A_FireProjectile (projectileType, angl, false, 5.5, 3, FPF_NOAUTOAIM);	
		//SpawnPlayerMissile(projectileType);
		//ownr.takeInventory("magazine_blasterStaff", 1);
		A_StartSound("weapons/staffShoot", 0);
		if ( flashType ) { A_SpawnItemEx(flashType, 8, 0, 16, 0); } else {}
		if ( alertMonsters ) { A_AlertMonsters(); }
	}
	//  staffswing  ////////////////////////////////////////////////////////////
	action void W_StaffSwing(string puffType) {
		FTranslatedLineTarget t;
		int damage;		
		if(FindInventory("SVETalismanPowerup")) {
			damage = 1000;
		}
		else {
			int power = MIN(10, stamina / 10);
			damage = (random[StaffSwing]() % (power + 5)) * (power + 2);

			if(FindInventory("PowerStrength")) {
				damage *= 10;
			}
		}
		double angl = angle + random2[StaffSwing]() * (7.625 / 256);
		double pitch = AimLineAttack (angle, 80.);
		LineAttack (angl, 80., pitch, damage, 'Melee', puffType, true, t);
		A_RadiusThrust(256, 64, 0, 32);
		// turn to face target
		if(t.linetarget) {
			A_StartSound (t.linetarget.bNoBlood ? sound("weapons/staffswing") : sound("weapons/staffhit"), CHAN_WEAPON);
			angle = t.angleFromSource;
			bJustAttacked = true;
			t.linetarget.DaggerAlert (self);
		}
		else {
			A_StartSound ("weapons/staffswing", CHAN_WEAPON);
		}
	}
	////////////////////////////////////////////////////////////////////////////
		
	//  crossbow actions  //////////////////////////////////////////////////////
	action void W_ShootArrow (class<Actor> projectileType) {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		if (projectileType) {
			//double savedangle = angle;
			//angle += Random2[xbowArrow]() * (5.625/256) * AccuracyFactor();
			//player.mo.PlayAttacking2 ();
			//SpawnPlayerMissile (proj);
			double angl = Random2[projectileType]() * (7.625 / 256) * AccuracyFactor();
			A_FireProjectile (projectileType, angl, false, 0, 0, FPF_NOAUTOAIM);
			//angle = savedangle;
			A_StartSound ("weapons/xbowshoot", CHAN_WEAPON);
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	//  shoot laser pistol  ////////////////////////////////////////////////////
	action void W_FireLaserPistol(string projectileType, string flashType) {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		//let ownr = binderPlayer(invoker.owner);
		//player.mo.PlayAttacking2 ();
		double angl = Random2[projectileType]() * (7.625 / 256) * AccuracyFactor();
		A_FireProjectile (projectileType, angl, false, 7, 5, FPF_NOAUTOAIM);	
		//ownr.takeInventory("magazine_blasterStaff", 1);
		A_StartSound("weapons/staffShoot", 0);
		A_SpawnItemEx(flashType, 8, 0, 16, 0);		
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////	
	// custom firearm action with strife accuracy //////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_ShootFirearm(int damageMultiplier, string weapsnd) {
		if(player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if(weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		player.mo.PlayAttacking2 ();
		int damage = damageMultiplier*(random[StrifeGun]() % 3 + 1);
		double ang = angle;
		if(player.refire) {
			ang += Random2[StrifeGun]() * (22.5 / 256) * AccuracyFactor();
		}
		A_StartSound (weapsnd, CHAN_WEAPON); //default "weapons/assaultgun"
		LineAttack (ang, PLAYERMISSILERANGE, BulletSlope (), damage, 'Hitscan', "zscStrifePuff");
		A_AlertMonsters();
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_zscFireMiniMissile(string miniMissileType) {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		//let ownr = binderPlayer(invoker.owner);
		//double savedangle = angle;
		//angle += Random2[MiniMissile]() * (11.25 / 256) * AccuracyFactor();
		//player.mo.PlayAttacking2 ();
		double angl = Random2[miniMissileType]() * (7.625 / 256) * AccuracyFactor();
		A_FireProjectile (miniMissileType, angl, false, 5, 0, FPF_NOAUTOAIM);
		//ownr.takeInventory("magazine_missileLauncher", 1);
		//angle = savedangle;
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_FirewosMauler1() {
		if (player == null) {
			return;
		}
		A_StartSound ("weapons/mauler1", CHAN_WEAPON);
		Weapon weap = player.ReadyWeapon;
		if (weap != null) {
			if (!weap.DepleteAmmo (weap.bAltFire, true, 2))
				return;			
		}
		player.mo.PlayAttacking2 ();
		double pitch = BulletSlope ();			
		for (int i = 0 ; i < 20 ; i++) {
			int damage = 5 * random[Mauler1](1, 3);
			double ang = angle + Random2[Mauler1]() * (7.625 / 256);
			// Strife used a range of 2112 units for the mauler to signal that
			// it should use a different puff. ZDoom's default range is longer
			// than this, so let's not handicap it by being too faithful to the
			// original.
			LineAttack (ang, PLAYERMISSILERANGE, pitch + Random2[Mauler1]() * (7.097 / 256), damage, 'Hitscan', "MaulerPuff", 0, null, 0, 97, 0);
			A_AlertMonsters();
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
	// A_FireMauler2Pre ////////////////////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_FirewosMauler2Pre() {
		A_StartSound ("weapons/mauler2charge", CHAN_WEAPON);
		if (player != null) {
			PSprite psp = player.GetPSprite(PSP_WEAPON);
			psp.x += Random2[Mauler2]() / 64.;
			psp.y += Random2[Mauler2]() / 64.;
		}
	}
	////////////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////////////////
	// A_FireMauler2Pre ////////////////////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_FirewosMauler2 () {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;
		}
		player.mo.PlayAttacking2 ();		
		SpawnPlayerMissile ("wosMaulerTorpedo");
		DamageMobj (self, null, 15, 'Disintegrate');
		Thrust(7.8125, Angle+180.);
		A_AlertMonsters();
	}
	////////////////////////////////////////////////////////////////////////////	
	
	////////////////////////////////////////////////////////////////////////////
	// A_stabDagger(); A_stabDaggerAlt (); /////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_stabDagger () {
		FTranslatedLineTarget t;
		int damage;		
		if (FindInventory("SVETalismanPowerup")) {
			damage = 1000;
		}
		else {
			int power = MIN(10, stamina / 10);
			damage = random[JabDagger](0, power + 8) * (power + 2);
			if (FindInventory("PowerStrength")) {
				damage *= 10;
			}
		}
		double angle = angle + random2[JabDagger]() * (5.625 / 256);
		double pitch = AimLineAttack (angle, 80.);
		LineAttack (angle, 80., pitch, damage, 'Melee', "StrifeSpark", true, t);
		// turn to face target
		if (t.linetarget) {
			A_StartSound (t.linetarget.bNoBlood ? sound("misc/metalhit") : sound("misc/meathit"), CHAN_WEAPON);
			angle = t.angleFromSource;
			bJustAttacked = true;
			t.linetarget.DaggerAlert (self);
		}
		else {
			A_StartSound ("misc/swish", CHAN_WEAPON);
		}
	}
	action void W_stabDaggerAlt () {
		FTranslatedLineTarget t;
		int damage;		
		if (FindInventory("SVETalismanPowerup")) {
			damage = 1000;
		}
		else {
			int power = MIN(10, stamina / 10);
			damage = random[JabDagger](0, power + 16) * (power + 4);
			if (FindInventory("PowerStrength")) {
				damage *= 10;
			}
		}
		// draw stamina with alt attack //
		let pawn = binderPlayer(self);
		pawn.stamin -= 100;		
		//////////////////////////////////
		double angle = angle + random2[JabDagger]() * (5.625 / 256);
		double pitch = AimLineAttack (angle, 80.);
		LineAttack (angle, 80., pitch, damage, 'Melee', "StrifeSpark", true, t);
		// turn to face target
		if (t.linetarget) {
			A_StartSound (t.linetarget.bNoBlood ? sound("misc/metalhit") : sound("misc/meathit"), CHAN_WEAPON);
			angle = t.angleFromSource;
			bJustAttacked = true;
			t.linetarget.DaggerAlert (self);
		}
		else {
			A_StartSound ("misc/swish", CHAN_WEAPON);
		}
	}
	////////////////////////////////////////////////////////////////////////////
		
		
	//  grenade launcher actions  //////////////////////////////////////////////
	action void W_ShootGrenade (class<Actor> grenadetype, double angleofs, statelabel flash) {
		if (player == null) {
			return;
		}
		Weapon weapon = player.ReadyWeapon;
		if (weapon != null) {
			if (!weapon.DepleteAmmo (weapon.bAltFire))
				return;

			player.SetPsprite (PSP_FLASH, weapon.FindState(flash), true);
		}
		if (grenadetype != null) {
			AddZ(32);
			Actor grenade = SpawnSubMissile (grenadetype, self);
			AddZ(-32);
			if (grenade == null)
				return;

			if (grenade.SeeSound != 0) {
				grenade.A_StartSound(grenade.SeeSound, CHAN_VOICE);
			}

			grenade.Vel.Z = (-clamp(tan(Pitch), -5, 5)) * grenade.Speed + 8;

			Vector2 offset = AngleToVector(angle, radius + grenade.radius);
			double an = Angle + angleofs;
			offset += AngleToVector(an, 15);
			grenade.SetOrigin(grenade.Vec3Offset(offset.X, offset.Y, 0.), false);
			A_AlertMonsters();
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	
	// reload actions //////////////////////////////////////////////////////////	 
	action void W_reloadCheck() {
		if ( player == null ) {
			return;
		}
		// check if no ammo and default to dagger
		if ( CountInv(invoker.ammoType1) == 0 && CountInv(invoker.ammoType2) == 0 ) {
			A_Log("\c[red]Ammo depleted!");
			player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetDownState());
			A_SelectWeapon("wospunchdagger");
			//Player.SetPSprite(PSP_WEAPON,invoker.FindState("Nope"));
			return;
		} else {
			// check if magazine is full or not && if player has ammo to reload
			if ( CountInv(invoker.ammoType2) > 0 && CountInv(invoker.ammoType1) < FindInventory (invoker.ammoType1).maxAmount ) {
				Player.SetPSprite(PSP_WEAPON,invoker.FindState("DoReload"));
			} else {
				// if magazine is full, return to ready
				if (CheckInventory(invoker.ammoType1, FindInventory(invoker.ammoType1).maxAmount)) {
					//.. vrati se do 'ready'
					A_Log("\c[green]Ammo full!");
					Player.SetPSprite(PSP_WEAPON,invoker.FindState("Ready"));
				}
			}
		}
	}
	action void W_Reload() {
		if ( player == null ) {
			return;
		}	
		if ( CheckInventory (invoker.ammoType1, 0) || !CheckInventory (invoker.ammoType2, 1) ) {
			//return ResolveState("Ready");
			A_Log("\c[red]Not enough ammo!");
			player.SetPsprite(PSP_WEAPON, player.readyWeapon.GetDownState());
			A_SelectWeapon("wospunchdagger");
		} 
		//ammoAmount = min (FindInventory (invoker.ammoType1).maxAmount - CountInv (invoker.ammoType1), CountInv (invoker.ammoType2));
		int ammoAmount = FindInventory(invoker.ammoType1).maxAmount - CountInv(invoker.ammoType1);
		if (ammoAmount <= 0) { 
		//do nothing
		} else { 
			GiveInventory (invoker.ammoType1, ammoAmount);
			TakeInventory (invoker.ammoType2, ammoAmount);
		}
		//return ResolveState ("ReloadFinish");
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////
	// take down worn armor from Lost Frontier /////////////////////////////////
	// credits: jarewill ///////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void wos_stripArmor() {
        let pawn = binderPlayer(self);
        if ( pawn.currentarmor > 0 ) {
            if ( CountInv("wosPowerMask") ) { 
                A_Log("\c[red][ Take off your environmental suit first! ]"); 
            } else {
                string toSpawn;
                if ( pawn.currentArmor == 1 ) { toSpawn = "wosLeatherArmor"; }
                if ( pawn.currentArmor == 2 ) { toSpawn = "wosMetalArmor"; }
                if ( pawn.currentArmor == 3 ) { toSpawn = "wosBinderArmorBasic"; }
                if ( pawn.currentArmor == 4 ) { toSpawn = "wosBinderArmorAdvanced"; }
                if ( pawn.currentArmor == 5 ) { toSpawn = "wosKineticArmor"; }
                bool spawn1;
                actor spawn2;
                [spawn1, spawn2] = A_SpawnItemEx(toSpawn, 0, 0, 0, 8.25);
				A_StartSound("sounds/armorLight", CHAN_BODY);
                let armored = wosArmorBase(spawn2);
                armored.armorammo = pawn.armoramount;
                pawn.armoramount = 0;
            }
        } else {
            A_Log("\c[red][ You are not wearing any armor ]");
        }
    }
	////////////////////////////////////////////////////////////////////////////

	//##########################################################################
	//##########################################################################
	//##########################################################################
	
	
	////////////////////////////////////////////////////////////////////////////
	// old mostly obsolete /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////////////////////////////////////
	// A_Kicking(string puffType); /////////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_Kicking(string puffType) {
		FTranslatedLineTarget t;
		int damage;
		
		if(FindInventory("SVETalismanPowerup")) {
			damage = 1000;
		}
		else {
			int power = MIN(10, stamina / 10);
			damage = (random[StaffSwing]() % (power + 6)) * (power + 1);

			if(FindInventory("PowerStrength")) {
				damage *= 10;
			}
		}
		double angle = angle + random2[StaffSwing]() * (6.625 / 256);
		double pitch = AimLineAttack (angle, 80.);
		LineAttack (angle, 80., pitch, damage, 'Melee', puffType, true, t);
		A_RadiusThrust(256, 64, 0, 32);
		// turn to face target
		if(t.linetarget) {
			A_StartSound (t.linetarget.bNoBlood ? sound("weapons/staffswing") : sound("weapons/staffhit"), CHAN_WEAPON);
			angle = t.angleFromSource;
			bJustAttacked = true;
			t.linetarget.DaggerAlert (self);
		}
		else {
			A_StartSound ("weapons/staffswing", CHAN_WEAPON);
		}
	}
	////////////////////////////////////////////////////////////////////////////
	
	////////////////////////////////////////////////////////////////////////////	
	// A_uderPesti(string puffType); ///////////////////////////////////////////
	// credits: gzdoom.pk3 /////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////
	action void W_uderPesti(string puffType) {
		FTranslatedLineTarget t;
		int damage;		
		if(FindInventory("SVETalismanPowerup")) {
			damage = 1000;
		}
		else {
			int power = MIN(10, stamina / 10);
			damage = (random[StaffSwing]() % (power + 4)) * (power + 1);

			if(FindInventory("PowerStrength")) {
				damage *= 10;
			}
		}
		double angle = angle + random2[StaffSwing]() * (6.625 / 256);
		double pitch = AimLineAttack (angle, 80.);
		LineAttack (angle, 80., pitch, damage, 'Melee', puffType, true, t);
		// turn to face target
		if(t.linetarget) {
			A_StartSound (t.linetarget.bNoBlood ? sound("weapons/staffswing") : sound("weapons/staffhit"), CHAN_WEAPON);
			angle = t.angleFromSource;
			bJustAttacked = true;
			t.linetarget.DaggerAlert (self);
		}
		else {
			A_StartSound ("weapons/staffswing", CHAN_WEAPON);
		}
	}
	////////////////////////////////////////////////////////////////////////////

	/*
    Ejects a bullet casing to the side.
    Params:
     - casingType: Type of actor to eject.
     - left: If true, casing ejects to the left. Otherwise it ejects to the right.
     - ejectPitch: Pitch at which casing ejects, relative to view direction.
     - speed: Speed at which casing ejects.
     - accuracy: Random spread, in degrees.
     - offset: Offset from which casing is ejected, relative to center of view.
    */
    action void ZWL_EjectCasing(class<Actor> casingType, bool left = false, double ejectPitch = -45, double speed = 4, double accuracy = 8, Vector3 offset = (24, 0, -10)) {
        // Find offset vector
        // +y axis is to the right for offsets
        offset.y *= -1;

        // Rotate offset by pitch
        Vector2 xz = RotateVector((offset.x, offset.z), -pitch);
        offset.x = xz.x;
        offset.z = xz.y;

        // Rotate vector by angle
        offset.xy = RotateVector(offset.xy, angle);

        // Move to player camera
        offset.xy += pos.xy;
        offset.z += player.viewZ;

        // Find velocity vector
        Vector3 side = (Cos(angle + (left ? 90 : -90)), Sin(angle + (left ? 90 : -90)), 0);
        Vector3 up = (Cos(pitch-90) * Cos(angle), Cos(pitch-90) * Sin(angle), -Sin(pitch-90));
        Vector3 baseDirection = Cos(-ejectPitch) * side + Sin(-ejectPitch) * up;

        double baseAngle = VectorAngle(baseDirection.x, baseDirection.y);
        baseDirection.xy = RotateVector(baseDirection.xy, -baseAngle);
        double basePitch = -VectorAngle(baseDirection.x, baseDirection.z);

        double casAngle, casPitch;
        [casAngle, casPitch] = invoker.BulletAngle(accuracy, baseAngle, basePitch);

        let casing = Spawn(casingType, offset);
        casing.Vel3dFromAngle(speed, casAngle, casPitch);
        casing.vel += vel;
    }
	// Returns random angle and pitch within cone
    // I have no idea if there's a better way of doing this ¯\_(ツ)_/¯
    // Params:
    //  - accuracy: maximum angle b/w cone's axis, and bullet trajectory
    //  - angle: angle of axis
    //  - pitch: pitch of axis
    double, double BulletAngle(double accuracy, double angle, double pitch) {
        Vector3 v = (0, 0, 0);

        if (accuracy > 10) {
            // Generate random vector in sphere section
            Vector3 axis = (Cos(pitch) * Cos(angle), Cos(pitch) * Sin(angle), -Sin(pitch));
            while (v == (0, 0, 0) || v.Length() > 1 || ACos(axis dot v.Unit()) > accuracy) {
                v = (FRandom(-1, 1), FRandom(-1, 1), FRandom(-1, 1));
            }

            // Extract angle and pitch from trajectory
            angle = VectorAngle(v.x, v.y);
            pitch = -ASin(v.z / v.Length());
        }
        else if (accuracy > 0)
        {
            // Generate random vector in sphere around end of axis
            double r = Sin(accuracy);
            while (v == (0, 0, 0) || v.Length() > r)
            {
                v = (FRandom(-r, r), FRandom(-r, r), FRandom(-r, r));
            }

            Vector3 axis = (Cos(pitch) * Cos(angle), Cos(pitch) * Sin(angle), -Sin(pitch));
            v += axis;

            // Extract angle and pitch from trajectory
            angle = VectorAngle(v.x, v.y);
            pitch = -ASin(v.z / v.Length());
        }

        return angle, pitch;
    }
	
	
	//  LF encumbrance system  /////////////////////////////////////////////////
	override void AttachToOwner (Actor other) {
        super.AttachToOwner(other);
        let pawn = binderPlayer(owner);
        pawn.encumbrance+=self.mass;
    }
    override void DoEffect() {
        super.DoEffect();
        let pawn = binderPlayer(owner);
        //if (onlyone==0) {
        //    pawn.encumbrance+=self.mass*self.amount;
        //}
        //else {
            pawn.encumbrance+=self.mass;
        //}
    } 
	////////////////////////////////////////////////////////////////////////////
	
	Default {
		Inventory.PickupSound "sounds/itemPickup";
		Mass 0;
	}
	
	
	/*States {
		//global bootknife attack 4 all weapons !!!
		// - just add WRF_ALLOWUSER1 flag to A_WeaponReady()
		//----------------------------------------------------------------------
		
		User4: 
			"----" A 1 Offset(0,35);
			//"----" A 1 Offset(0,38);
			"----" A 1 Offset(0,44);
			//"----" A 1 Offset(0,52);
			"----" A 1 Offset(0,62);
			//"----" A 1 Offset(0,72);
			"----" A 1 Offset(0,82);
			KICK ABCD 2;
			KICK EFG 1;
			KICK H 2 W_Kicking("staffBlasterMeleePuff");//A_KnifeSlash();
			KICK GFED 1;
			KICK CBA 2;
			TNT1 A 0 {
				return ResolveState("Select");
			}
		
		//----------------------------------------------------------------------
		Reload:
			TNT1 A 0 
			{
				if (
					CheckInventory (invoker.ammoType1, 0) 
					|| 
					!CheckInventory (invoker.ammoType2, 1)
					)
					return ResolveState ("Ready");

				int ammoAmount = min (FindInventory (invoker.ammoType1).maxAmount - CountInv (invoker.ammoType1), CountInv (invoker.ammoType2));
				if (ammoAmount <= 0)
					return ResolveState ("Ready");

				GiveInventory (invoker.ammoType1, ammoAmount);
				TakeInventory (invoker.ammoType2, ammoAmount);

				return ResolveState ("ReloadFinish");
			}
	}*/
	
}
////////////////////////////////////////////////////////////////////////////////

//  nodecal puffs  /////////////////////////////////////////////////////////////
class nodecalStrifeSpark : StrifeSpark {
	Default {
		+NODECAL
	}
}
class zscStrifePuff : StrifePuff {
	Default {
		Decal "SVEbulletScorch";
	}
}
////////////////////////////////////////////////////////////////////////////////

//  weapon flash base  /////////////////////////////////////////////////////////
class gunFlash : flashBase {
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


//  ammo casings  //////////////////////////////////////////////////////////////
//Debris&stuff
class GenericDebris : actor {
	Default {
		+MISSILE
		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		+NOTELEPORT
		+FORCEXYBILLBOARD
		+NOTDMATCH
		+GHOST
		
		Radius 1;
		Height 1;
		Mass 1;
		Damage 0;
	}
}
class NoAdvDebris : Inventory {
	Default {
		+INVENTORY.UNDROPPABLE 
		+INVENTORY.UNTOSSABLE
		-COUNTITEM
		-INVENTORY.INVBAR
		+INVENTORY.PERSISTENTPOWER
		
		inventory.amount 1;
		inventory.maxamount 1;
	}
}
class NoAdvBleeding : Inventory {
	Default {
		+INVENTORY.UNDROPPABLE 
		+INVENTORY.UNTOSSABLE
		-COUNTITEM
		-INVENTORY.INVBAR
		+INVENTORY.PERSISTENTPOWER
		
		inventory.amount 1;
		inventory.maxamount 1;
	}
}
class NoAdvGibbing : Inventory {
	Default {		
		+INVENTORY.UNDROPPABLE 
		+INVENTORY.UNTOSSABLE
		-COUNTITEM
		-INVENTORY.INVBAR
		+INVENTORY.PERSISTENTPOWER
		
		inventory.amount 1;
		inventory.maxamount 1;
	}
}

class NoAdvFlames : Inventory {
	Default {
		+INVENTORY.UNDROPPABLE 
		+INVENTORY.UNTOSSABLE
		-COUNTITEM
		-INVENTORY.INVBAR
		+INVENTORY.PERSISTENTPOWER
		
		inventory.amount 1;
		inventory.maxamount 1;
	}
}

class DebrisGeneral : actor {
	Default {
		+NOTAUTOAIMED
		+MISSILE
		+NOBLOCKMAP 
		+MOVEWITHSECTOR
		+NOGRAVITY
		+DROPOFF
		+NOTELEPORT
		+FORCEXYBILLBOARD
		+NOTDMATCH
		+GHOST
		
		renderstyle "Translucent";
		alpha 1.0;
		radius 1;
		height 1;
		mass 1;
		damage 0;
	}
	
	states {
		Disappear:
			TNT1 A 0;
			stop;
	}
}

class Casing_General : DebrisGeneral {
	Default {
		//-NOBLOCKMAP
		-NOGRAVITY
		
		bouncetype "doom";
		seesound "";
		Radius 1;
		Height 1;
		bouncefactor 0.5;
		Scale .15;
		renderstyle "translucent";
		alpha 1.0;
	}
}
class Casing9mm : Casing_General {
	Default {
		Scale 0.15;
		bouncesound "weapons/casing";
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 0 A_Jump(256,1,2,3,4,5,6,7,8);
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,"Disappear",AAPTR_PLAYER1);
			CAS1 ABCDEFGH 1 A_JumpIf(waterlevel > 0, "Death");
			goto spawn+2;
		Death:
			TNT1 A 0;
			TNT1 A 0 A_Jump(128,2);
			TNT1 A 0 A_SetScale(-0.15,0.15);
			TNT1 A 0;
			TNT1 A 0 A_jump(256,"death1","death2","death3");
		Death1:
			CAS1 IIIIIIIIIIIIIIIIIIIIIIIIIIIIII 100 A_JumpIfInventory("NoAdvBleeding",1,"Disappear",AAPTR_PLAYER1);
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,"Disappear",AAPTR_PLAYER1);
			CAS1 I 1 A_CheckSight("Disappear");
			goto Death1+30;
		Death2:
			CAS1 JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ 100 A_JumpIfInventory("NoAdvBleeding",1,"Disappear",AAPTR_PLAYER1);
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,"Disappear",AAPTR_PLAYER1);
			CAS1 J 1 A_CheckSight("Disappear");
			goto Death2+30;
		Death3:
			CAS1 KKKKKKKKKKKKKKKKKKKKKKKKKKKKKK 100 A_JumpIfInventory("NoAdvBleeding",1,"Disappear",AAPTR_PLAYER1);
			TNT1 A 0 A_JumpIfInventory("NoAdvDebris",1,"Disappear",AAPTR_PLAYER1);
			CAS1 K 1 A_CheckSight("Disappear");
			goto Death3+30;
	}
}

class pistolCasingSpawner : GenericDebris {
	Default {
		+NOINTERACTION
		
		Speed 15;
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1 Thing_ChangeTID(0,390);
			//TNT1 A 0 A_SpawnProjectile("Casing9mm", 0, 0, random(-100,-130),10, random(20,45));
			TNT1 A 0 A_SpawnItemEx("Casing9mm",random(3,4),cos(pitch)*-25,sin(-pitch)*5+random(12,13), random(1,3),0,random(4,6), random(-80,-90),0, SXF_ABSOLUTEMOMENTUM);			
			Stop;
	}
}
class CasingStaff : Casing_General {
	Default {
		bouncesound "weapons/shell2";		
		scale 0.25;
	}
	
	States {
		Spawn:
			
		Death:
			SECL A 700;
			Stop;
	}
}
class staffCasingSpawner : GenericDebris {
	Default {
		+NOINTERACTION
	}
	
	States {
		Spawn:
			TNT1 A 0;
			TNT1 A 1;
			TNT1 A 0 A_SpawnItemEx("CasingStaff", 0, 0, random(-100,-130),10, random(20,45));
			Stop;
	}
}

// zwl casing //////////////////////////////////////////////////////////////////
class pistolCasing : zCasing {
	Default {
		Scale 0.15;
		BounceSound "weapons/casing";
		ZCasing.SpriteName "CASA";
		+ROLLSPRITE
	}
}
class rifleCasing : zcasing {
	Default {
		Scale 0.2;
		BounceSound "weapons/casing";
		ZCasing.SpriteName "CASC";
		+ROLLSPRITE
	}	
	States {
		Dummy:
		CASC A 0;
		Stop;
		
		Spawn:
		CASC A 1 nodelay {
			//sprite = GetSpriteIndex(spriteName);
			A_SetRoll((vel.x,vel.y,vel.z).Length() * -50,SPF_INTERPOLATE);
		}
		Loop;
		
		Death:
        CASC A -1 {
			//sprite = GetSpriteIndex(spriteName);
			//console.printf("%f, %f",roll,roll % 360);
			if(roll % 360 < 180) {
				bXFLIP = true;
			}
			A_SetRoll(0);
		}
        Stop;
	}
}
class shotgunCasing : zcasing {
	Default {
		Scale 0.2;
		BounceSound "weapons/shotgunshells";
		ZCasing.SpriteName "CASB";
		+ROLLSPRITE
	}	
	States {
		Dummy:
		CASB A 0;
		Stop;
		
		Spawn:
		CASB A 1 nodelay {
			//sprite = GetSpriteIndex(spriteName);
			A_SetRoll((vel.x,vel.y,vel.z).Length() * -50,SPF_INTERPOLATE);
		}
		Loop;
		
		Death:
        CASB A -1 {
			//sprite = GetSpriteIndex(spriteName);
			//console.printf("%f, %f",roll,roll % 360);
			if(roll % 360 < 180) {
				bXFLIP = true;
			}
			A_SetRoll(0);
		}
        Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  deprecated stuff  //////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*class kulka : FastProjectile
{
	Default
	{
		+RANDOMIZE;
		+FORCEXYBILLBOARD;
		+DONTSPLASH;
		+NOEXTREMEDEATH;
		Projectile;
		damage 9;
		radius 2;
		height 2;
		speed 140;
		renderstyle "add";
		alpha 0.9;
		scale 0.15;
	}
	States
	{
	Spawn:
		TRAC A 1 BRIGHT;
		Loop;
	Death:
		Stop;
	XDeath:
		TNT1 A 0;
		Stop;
	}
}
////////////////////////////////////////////////////////////////////////////////


class knifePuff : actor
{
	Default
	{
		seeSound "weapons/knifehit";
		attacksound "weapons/knifemiss";
		activesound "weapons/knifeswing";
	}
}*/
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////