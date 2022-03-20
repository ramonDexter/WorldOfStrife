class wosDebugCommands {
    
    static void dbg_GiveBinderHeavy(actor activator) {
        if ( activator && activator.player ) {            
            activator.A_giveInventory("binder_helmet", 1);
	        activator.A_GiveInventory("shoulderGun", 1);
            activator.A_GiveInventory("shldrGunMag", 32);
            activator.A_GiveInventory("StaffBlaster", 1);
            activator.A_GiveInventory("laserpistol", 1);
            //armor
            activator.A_GiveInventory("wosKineticArmor", 1);
            //ammo
            activator.A_GiveInventory("EnergyPod", 400);
            activator.A_GiveInventory("wosenergykit", 10);
            activator.A_GiveInventory("shoulderGunCharger", 1);
            //grenades
            activator.A_GiveInventory("wosGrenadeE", 15);
            activator.A_GiveInventory("wosGrenadeF", 15);
            activator.A_GiveInventory("wosGrenadeG", 15);
            activator.A_GiveInventory("wosArmorShard", 10);
            //medical
            activator.A_GiveInventory("wosHyposprej", 30);
            activator.A_GiveInventory("wosKombopack", 10);
            activator.A_GiveInventory("wosInstaLek", 5);
            //BlasterTurret_item
            activator.A_GiveInventory("wosInterceptordrone", 5);	
            //DeployableShieldItem
            activator.A_GiveInventory("wosDeployableShield", 1);
            //Swarmers_item
            activator.A_GiveInventory("wosSwarmers", 5);
            // goldCoin x2500
            activator.A_GiveInventory("goldCoin", 2500);
        }
    }

    static void dbg_GiveShoulderGun(actor activator) {
        if ( activator && activator.player ) {
            activator.A_GiveInventory("shoulderGun", 1);
	        activator.A_GiveInventory("shldrGunMag", 32);
	        activator.A_GiveInventory("shoulderGunCgarger", 1);
        }
    }

    static void dbg_GiveBinderLight(actor activator) {
        if ( activator && activator.player ) {
            activator.A_GiveInventory("binder_helmet", 1);
            // weapons
            activator.A_GiveInventory("shoulderGun", 1);
            activator.A_GiveInventory("shldrGunMag", 32);
            activator.A_GiveInventory("StaffBlaster", 1);
            // armor
            activator.A_GiveInventory("wosKineticArmor", 1);
            // ammo
            activator.A_GiveInventory("EnergyPod", 400);
            activator.A_GiveInventory("wosenergykit", 10);
            activator.A_GiveInventory("shoulderGunCharger", 1);
            // medical
            activator.A_GiveInventory("wosHyposprej", 20);
            activator.A_GiveInventory("wosKombopack", 5);
            activator.A_GiveInventory("wosInstaLek", 2);
            // grenades
            activator.A_GiveInventory("wosGrenadeE", 5);
            activator.A_GiveInventory("wosGrenadeF", 5);
            activator.A_GiveInventory("wosInstaLek", 5);
            // gold
            activator.A_GiveInventory("goldCoin", 2500);
            //
        }
    }

    static void dbg_GiveAllWeapons(actor activator) {
        if ( activator && activator.player ) {
            activator.A_GiveInventory("zscStrifeCrossbow", 1);
            activator.A_GiveInventory("StormPistol", 1);
            activator.A_GiveInventory("laserPistol", 1);
            activator.A_GiveInventory("zscAssaultGun", 1);
            activator.A_GiveInventory("staffBlaster", 1);
            activator.A_GiveInventory("zscMiniMissileLauncher", 1);
            activator.A_GiveInventory("zscFlameThrower", 1);
            activator.A_GiveInventory("zscStrifeGrenadeLauncher", 1);
            activator.A_GiveInventory("zscMauler", 1);
        }
    }

    static void dbg_GiveAllArmor(actor activator) {
        if ( activator && activator.player ) {
            activator.A_GiveInventory("wosLeatherArmor", 1);
            activator.A_GiveInventory("wosMetalArmor", 1);
            activator.A_GiveInventory("wosBinderArmorBasic", 1);
            activator.A_GiveInventory("wosBinderArmorAdvanced", 1);
            activator.A_GiveInventory("wosKineticArmor", 1);
        }
    }
}