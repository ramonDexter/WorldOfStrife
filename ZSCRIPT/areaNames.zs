//area name markers based on m8f's hellscape navigator
//==============================================================================
/*
//base
//-----------------------------------------------------
class m8f_hn_AreaNameMarker_????? : areaMarkerBase
{
	Default
	{
		//$Title "?????"	
		Tag "?????";
		Health 256; //radius of area
	}
}
//-----------------------------------------------------
// 1. Copy this class to your wad/pk3 ZScript code;
// 2. Give the class a unique name, e.g. my_own_hn_AreaNameMarker_something
//    The name can by anything, but it must contain substring "hn_AreaNameMarker"
//    to be recognized by Hellscape Navigator.
// 3. Area name is stored in "Tag" property, so put it there.
// 4. Area radius is stored in "Health" property, so put it there.
// 5. Put an object of this class on the map.
*/
class areaMarkerBase : Actor {
	Default {
		//$Category "Area markers"
		//$Color 9
	
		+NOBLOCKMAP;
		+NOGRAVITY;
		+DONTSPLASH;
		+NOTONAUTOMAP;
		+DONTTHRUST;
	}
	/*
	States {
		Spawn:
		KPK1 A -1;
		Stop;
	}*/
}
//------------------------------------------------------------------------------
/*
class m8f_hn_AreaNameMarker_M1001_ZAKLADNARANGERU : areaMarkerBase
{
	Default
	{
		//$Title "M1001_ZAKLADNARANGERU"	
		Tag "$M1001_ZAKLADNARANGERU";
		Health 512; //radius of area
	}
}
*/
//SILENT HILLS------------------------------------------------------------------
class m8f_hn_AreaNameMarker_SH_binderBase : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Binder Base"	
		Tag "Silent Hills, Binder Base";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_westBank : areaMarkerBase {
	Default {
		//$Title "Silent Hills, West bank"	
		Tag "Silent Hills, West bank";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_eastBank : areaMarkerBase {
	Default {
		//$Title "Silent Hills, East bank"	
		Tag "Silent Hills, East bank";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_tavern : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Tavern"	
		Tag "Silent Hills, Tavern";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_townHall : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Town Hall"	
		Tag "Silent Hills, Town Hall";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_governorOffice : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Governor's office"	
		Tag "Silent Hills, Governor's office";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_townGuard : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Town guard"
		Tag "Silent Hills, Town guard";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_port : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Port"	
		Tag "Silent Hills, Port";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_grenadeVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Grenade vendor"
		Tag "Silent Hills, Grenade vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_grocery : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Grocery"
		Tag "Silent Hills, Grocery";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_techSmith : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Techsmith"
		Tag "Silent Hills, Techsmith";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_armorVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Armor Vendor"
		Tag "Silent Hills, Armor Vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_temple : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Temple"
		Tag "Silent Hills, Temple";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_specialityVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Specialty vendor"
		Tag "Silent Hills, Specialty vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_explosiveWeapsVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Explosive weapons vendor"
		Tag "Silent Hills, Explosive weapons vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_weaponsVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Weapons vendor"
		Tag "Silent Hills, Weapons vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_energyweaponsVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Energy weapons vendor"
		Tag "Silent Hills, Energy weapons vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_surgery : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Surgery"
		Tag "Silent Hills, Surgery";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_supportVendor : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Support vendor"
		Tag "Silent Hills, Support vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_bathHouse : areaMarkerBase {
	Default {
		//$Title "Silent Hills, City bathhouse"
		Tag "Silent Hills, City bathhouse";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_shoppingCenter : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Shopping center"
		Tag "Silent Hills, Shopping center";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_powerplant : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Powerplant"
		Tag "Silent Hills, Powerplant";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_wasteTreatment : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Waste treatment"
		Tag "Silent Hills, Waste treatment";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_marketplace : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Marketplace"
		Tag "Silent Hills, Marketplace";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_natatio : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Natatio"
		Tag "Bathhouse, Natatio";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_entranceHall : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Entrance Hall"
		Tag "Bathhouse, Entrance Hall";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_frigidarium : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Frigidarium"
		Tag "Bathhouse, Frigidarium";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_apodyterium : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Apodyterium"
		Tag "Bathhouse, Apodyterium";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_tepidarium : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Tepidarium"
		Tag "Bathhouse, Tepidarium";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_calidarium : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Calidarium"
		Tag "Bathhouse, Calidarium";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_latrine : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Latrine"
		Tag "Bathhouse, Latrine";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_supervisorOffice : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Supervisor's Office"
		Tag "Bathhouse, Supervisor's Office";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_hipBaths : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Hip baths"
		Tag "Bathhouse, Hip baths";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_technical : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Technical"
		Tag "Bathhouse, Technical";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_BH_palaestra : areaMarkerBase {
	Default {
		//$Title "Bathhouse, Palaestra"
		Tag "Bathhouse, Palaestra";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_residential : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Residential"
		Tag "Silent Hills, Residential";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_SH_historian : areaMarkerBase {
	Default {
		//$Title "Silent Hills, Historian"
		Tag "Silent Hills, Historian";
		Health 256; //radius of area
	}
}
//SILENT HILLS------------------------------------------------------------------

//MILLPORT----------------------------------------------------------------------
class m8f_hn_AreaNameMarker_MP_binderBase : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base"
		Tag "Binder Base";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_yourFlat : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Personal Dormitory"
		Tag "Binder Base, Personal Dormitory";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_mainCommand : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Main command"
		Tag "Binder Base, Main command";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_millport : areaMarkerBase {
	Default {
		//$Title "Millport"
		Tag "Millport";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_techsmith : areaMarkerBase {
	Default {
		//$Title "Millport, TechSmith"
		Tag "Millport, TechSmith";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_blackPub : areaMarkerBase {
	Default {
		//$Title "Millport, Black Pub"
		Tag "Millport, Black Pub";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_gunsmith : areaMarkerBase {
	Default {
		//$Title "Millport, GunSmith"
		Tag "Millport, GunSmith";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_hostel : areaMarkerBase {
	Default {
		//$Title "Millport, Hostel"
		Tag "Millport, Hostel";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_publicClinic : areaMarkerBase {
	Default {
		//$Title "Millport, Public Clinic"
		Tag "Millport, Public Clinic";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_commons : areaMarkerBase {
	Default {
		//$Title "Millport Commons"
		Tag "Millport Commons";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_commons_Tavern : areaMarkerBase {
	Default {
		//$Title "Millport Commons, Tavern"
		Tag "Millport Commons, Tavern";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_commons_butcher : areaMarkerBase {
	Default {
		//$Title "Millport Commons, Butcher"
		Tag "Millport Commons, Butcher";
		Health 128; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_commons_library : areaMarkerBase {
	Default {
		//$Title "Millport Commons, Library"
		Tag "Millport Commons, Library";
		Health 128; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_temple : areaMarkerBase {
	Default {
		//$Title "Millport, Temple"
		Tag "Millport, Temple";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_villa : areaMarkerBase {
	Default {
		//$Title "Millport, The Villa"
		Tag "Millport, The Villa";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_port : areaMarkerBase {
	Default {
		//$Title "Millport, Harbor"
		Tag "Millport, Harbor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_westernGate : areaMarkerBase {
	Default {
		//$Title "Millport, Western Gate"
		Tag "Millport, Western Gate";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_easternGate : areaMarkerBase {
	Default {
		//$Title "Millport, Eastern Gate"
		Tag "Millport, Eastern Gate";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_townHall : areaMarkerBase {
	Default {
		//$Title "Millport, Town Hall"
		Tag "Millport, Town Hall";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_tekGuildHQ : areaMarkerBase {
	Default {
		//$Title "Millport, TekGuild HQ"
		Tag "Millport, TekGuild HQ";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_thePlaza : areaMarkerBase {
	Default {
		//$Title "Millport, Plaza"
		Tag "Millport, Plaza";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_armorVendor : areaMarkerBase {
	Default {
		//$Title "Millport, Armor Vendor"
		Tag "Millport, Armor Vendor";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_butcher : areaMarkerBase {
	Default {
		//$Title "Millport, Butcher"
		Tag "Millport, Butcher";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_technic : areaMarkerBase {
	Default {
		//$Title "Millport, Technician"
		Tag "Millport, Technician";
		Health 256; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_clinic : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Clinic"
		Tag "Binder Base, Clinic";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_weaponsVendor : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Weapons Vendor"
		Tag "Binder Base, Weapons Vendor";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_underground : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Underground"
		Tag "Binder Base, Underground";
		Health 512; //radius of area
	}
}
class m8f_hn_AreaNameMarker_MP_binderBase_undergroundTemple : areaMarkerBase {
	Default {
		//$Title "Millport, Binder Base, Underground Temple"
		Tag "Binder Base, Underground Temple";
		Health 512; //radius of area
	}
}
//MILLPORT----------------------------------------------------------------------




















