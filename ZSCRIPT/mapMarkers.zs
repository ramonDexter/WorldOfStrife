class markerBase : MapMarker {
    Default {
        //$Category "WoS/map markers"
    }
}
class markerPub : markerBase {
    Default {        
	    //$Title "pub"
    }
	
	States {
		Spawn:
		M030 A -1;
		Stop;
	}
}
class markerBrewery : markerBase {
    Default {
	    //$Title "brewery"
    }
	States {
		Spawn:
		M032 A -1;
		Stop;
	}
}
class markerConvent : markerBase {
    Default {
	//$Title "castle"
    }
	States {
		Spawn:
		M009 A -1;
		Stop;
	}
}
class markerMedPotions : markerBase {
    Default {
	//$Title "burgers"
    }
	States {
		Spawn:
		M003 A -1;
		Stop;
	}
}
class markerFoundry : markerBase {
    Default {
	//$Title "blacksmith"
    }
	States {
		Spawn:
		M033 A -1;
		Stop;
	}
}
class markerMagical : markerBase {
    Default {
	//$Title "church/cathedral"
    }
	States {
		Spawn:
		M015 A -1;
		Stop;
	}
}
class markerMedDoctor1 : markerBase {
    Default {
	//$Title "doctor"
    }
	States {
		Spawn:
		M019 A -1;
		Stop;
	}
}
class markerMedDoctor2 : markerBase {
    Default {
	//$Title "cemetery"
    }
	States {
		Spawn:
		M006 A -1;
		Stop;
	}
}
class markerMine : markerBase {
    Default {
	//$Title "tools shop"
    }
	States {
		Spawn:
		M027 A -1;
		Stop;
	}
}
class markerPawnShop : markerBase {
    Default {
	//$Title "grocery store"
    }
	States {
		Spawn:
		M013 A -1;
		Stop;
	}
}
class markerTechShop : markerBase {
    Default {
	//$Title "tech shop"
    }
	States {
		Spawn:
		M022 A -1;
		Stop;
	}
}
class markerSkull1 : markerBase {
    Default {
	//$Title "chapel"
    }
	States
	{
		Spawn:
		M014 A -1;
		Stop;
	}
}
class markerSkull2 : markerBase {
    Default {
	//$Title "powerplant"
    }
	States {
		Spawn:
		M023 A -1;
		Stop;
	}
}
class markerRestaurant : markerBase {
    Default {
	//$Title "restaurant"
    }
	States {
		Spawn:
		M031 A -1;
		Stop;
	}
}
class markerRuins : markerBase {
    Default {
	//$Title "ruins"
    }
	States {
		Spawn:
		M047 A -1;
		Stop;
	}
}
class markerAlchShop : markerBase {
    Default {
	//$Title "techsmith"
    }
	States {
		Spawn:
		M026 A -1;
		Stop;
	}
}
class markerVillage : markerBase {
    Default {
	//$Title "city-town"
    }
	States {
		Spawn:
		M001 A -1;
		Stop;
	}
}
class markerStargate : markerBase {
    Default {
	//$Title "circle"
    }
	States {
		Spawn:
		M010 A -1;
		Stop;
	}
}
class markerChest : markerBase {
    Default {
	//$Title "point of interest"
    }
	States {
		Spawn:
		M021 A -1;
		Stop;
	}
}
class markerGlobe : markerBase {
    Default {
	//$Title "globe"
    }
	States {
		Spawn:
		M029 A -1;
		Stop;
	}
}
class markerMarket : markerBase {
    Default {
	//$Title "market"
    }
	States {
		Spawn:
		M008 A -1;
		Stop;
	}
}
class markerPOI2 : markerBase {
    Default {
	//$Title "POI2"
    }
	States {
		Spawn:
		M024 A -1;
		Stop;
	}
}
class markerBinder : markerBase {
	Default {
		//$title "binder"
	}
	States {
		Spawn:
		M035 A -1;
		Stop;
	}
}
class markerHouse : markerBase {
	Default {
		//$title "house"
	}
	States {
		Spawn:
		M036 A -1;
		Stop;
	}
}
class markerEstate : markerBase {
	Default {
		//$title "estate"
	}
	States {
		Spawn:
		M037 A -1;
		Stop;
	}
}
class markerApartment : markerBase {
	Default {
		//$title "apartment"
	}
	States {
		Spawn:
		M038 A -1;
		Stop;
	}
}
class markerPlaza : markerBase {
	Default {
		//$title "plaza"
	}
	States {
		Spawn:
		M007 A -1;
		Stop;
	}
}
class markerVillageSmallCity : markerBase {
	Default {
		//$title "village - small city"
	}
	States {
		Spawn:
		M048 A -1;
		Stop;
	}
}
class markerFarm : markerBase {
	Default {
		//$title "farm"
	}
	States {
		Spawn:
		M039 A -1;
		Stop;
	}
}
class markerFields : markerBase {
	Default {
		//$title "fields"
	}
	States {
		Spawn:
		M040 A -1;
		Stop;
	}
}
class markerDrinkingWater : markerBase {
	Default {
		//$title "drinking water"
	}
	States {
		Spawn:
		M041 A -1;
		Stop;
	}
}
class markerWaterWell : markerBase {
	Default {
		//$title "water well"
	}
	States {
		Spawn:
		M042 A -1;
		Stop;
	}
}
class markerBarbedWire : markerBase {
	Default {
		//$title "banditos"
	}
	States {
		Spawn:
		M043 A -1;
		Stop;
	}
}
class markerDanger : markerBase {
	Default {
		//$title "danger"
	}
	States {
		Spawn:
		M044 A -1;
		Stop;
	}
}
class markerDangerDeadly : markerBase {
	Default {
		//$title "danger deadly"
	}
	States {
		Spawn:
		M045 A -1;
		Stop;
	}
}
class markerDistillery : markerBase {
	Default {
		//$title "distillery"
	}
	States {
		Spawn:
		M046 A -1;
		Stop;
	}
}
class markerGhostTown : markerBase {
	Default {
		//$title "ghost town"
	}
	States {
		Spawn:
		M012 A -1;
		Stop;
	}
}
class markerTriangle : markerBase {
	Default {
		//$title "triangle"
	}
	States {
		Spawn:
		M049 A -1;
		Stop;
	}
}
///////////////////////////////////////////////////////////////////////////////////////
// marker names ///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
/*class markerNamed_binderPlaza : MarkerBase {
	Default {
		//$Title "name: Binder Plaza"
	}
	States {
		Spawn:
		MT01 A -1;
		Stop;
	}
}
class markerNamed_mainplaza : MarkerBase {
	Default {
		//$Title "name: Main Plaza"
	}
	States {
		Spawn:
		MT02 A -1;
		Stop;
	}
}
class markerNamed_oldplaza : MarkerBase {
	Default {
		//$Title "name: Old Plaza"
	}
	States {
		Spawn:
		MT03 A -1;
		Stop;
	}
}
class markerNamed_tekguildplaza : MarkerBase {
	Default {
		//$Title "name: TekGuild Plaza"
	}
	States {
		Spawn:
		MT04 A -1;
		Stop;
	}
}
class markerNamed_BinderBase : MarkerBase {
	Default {
		//$Title "name: Binder Base"
	}
	States {
		Spawn:
		MT05 A -1;
		Stop;
	}
}
class markerNamed_insulaNorth : MarkerBase {
	Default {
		//$Title "name: insula north"
	}
	States {
		Spawn:
		MT06 A -1;
		Stop;
	}
}
class markerNamed_insulaWest : MarkerBase {
	Default {
		//$Title "name: insula west"
	}
	States {
		Spawn:
		MT07 A -1;
		Stop;
	}
}
class markerNamed_powerStation : MarkerBase {
	Default {
		//$Title "name: power station"
	}
	States {
		Spawn:
		MT08 A -1;
		Stop;
	}
}
class markerNamed_temple : MarkerBase {
	Default {
		//$Title "name: temple"
	}
	States {
		Spawn:
		MT09 A -1;
		Stop;
	}
}
class markerNamed_thecastle : MarkerBase {
	Default {
		//$Title "name: the castle"
	}
	States {
		Spawn:
		MT10 A -1;
		Stop;
	}
}
class markerNamed_thecommons : MarkerBase {
	Default {
		//$Title "name: the commons"
	}
	States {
		Spawn:
		MT11 A -1;
		Stop;
	}
}
class markerNamed_thevilla : MarkerBase {
	Default {
		//$Title "name: the villa"
	}
	States {
		Spawn:
		MT12 A -1;
		Stop;
	}
}
class markerNamed_townbath : MarkerBase {
	Default {
		//$Title "name: town bath"
	}
	States {
		Spawn:
		MT13 A -1;
		Stop;
	}
}
class markerNamed_market : MarkerBase {
	Default {
		//$Title "name: market"
	}
	States {
		Spawn:
		MT14 A -1;
		Stop;
	}
}
class markerNamed_blackpub : MarkerBase {
	Default {
		//$Title "name: black pub"
	}
	States {
		Spawn:
		MT15 A -1;
		Stop;
	}
}
class markerNamed_councilclub : MarkerBase {
	Default {
		//$Title "name: council club"
	}
	States {
		Spawn:
		MT16 A -1;
		Stop;
	}
}
class markerNamed_store : MarkerBase {
	Default {
		//$Title "name: store"
	}
	States {
		Spawn:
		MT17 A -1;
		Stop;
	}
}
class markerNamed_tavern : MarkerBase {
	Default {
		//$Title "name: tavern"
	}
	States {
		Spawn:
		MT18 A -1;
		Stop;
	}
}
class markerNamed_blacksmith : MarkerBase {
	Default {
		//$Title "name: blacksmith"
	}
	States {
		Spawn:
		MT19 A -1;
		Stop;
	}
}
class markerNamed_gunsmith : MarkerBase {
	Default {
		//$Title "name: gunsmith"
	}
	States {
		Spawn:
		MT20 A -1;
		Stop;
	}
}
class markerNamed_techsmith : MarkerBase {
	Default {
		//$Title "name: techsmith"
	}
	States {
		Spawn:
		MT21 A -1;
		Stop;
	}
}
class markerNamed_medic : MarkerBase {
	Default {
		//$Title "name: medic"
	}
	States {
		Spawn:
		MT22 A -1;
		Stop;
	}
}*/