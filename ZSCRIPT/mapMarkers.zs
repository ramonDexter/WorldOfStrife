class markerBase : MapMarker {
    Default {
        //$Category "WoS/map markers"
    }
}
class markerPub : markerBase {
    Default {        
	    //$Title "Hospoda"
    }
	
	States {
		Spawn:
		MK01 A -1;
		Stop;
	}
}
class markerBrewery : markerBase {
    Default {
	    //$Title "Pivovar/palirna"
    }
	States {
		Spawn:
		MK02 A -1;
		Stop;
	}
}
class markerConvent : markerBase {
    Default {
	//$Title "Hrad"
    }
	States {
		Spawn:
		MK03 A -1;
		Stop;
	}
}
class markerMedPotions : markerBase {
    Default {
	//$Title "Med: Potions"
    }
	States {
		Spawn:
		MK04 A -1;
		Stop;
	}
}
class markerFoundry : markerBase {
    Default {
	//$Title "kovar-zbrane"
    }
	States {
		Spawn:
		MK05 A -1;
		Stop;
	}
}
class markerMagical : markerBase {
    Default {
	//$Title "magical"
    }
	States {
		Spawn:
		MK06 A -1;
		Stop;
	}
}
class markerMedDoctor1 : markerBase {
    Default {
	//$Title "doktor 1"
    }
	States {
		Spawn:
		MK07 A -1;
		Stop;
	}
}
class markerMedDoctor2 : markerBase {
    Default {
	//$Title "doktor 2"
    }
	States {
		Spawn:
		MK08 A -1;
		Stop;
	}
}
class markerMine : markerBase {
    Default {
	//$Title "wares shop"
    }
	States {
		Spawn:
		MK09 A -1;
		Stop;
	}
}
class markerPawnShop : markerBase {
    Default {
	//$Title "pawn shop"
    }
	States {
		Spawn:
		MK10 A -1;
		Stop;
	}
}
class markerTechShop : markerBase {
    Default {
	//$Title "tech shop"
    }
	States {
		Spawn:
		MK11 A -1;
		Stop;
	}
}
class markerSkull1 : markerBase {
    Default {
	//$Title "skull 1"
    }
	States
	{
		Spawn:
		MK12 A -1;
		Stop;
	}
}
class markerSkull2 : markerBase {
    Default {
	//$Title "skull 2"
    }
	States {
		Spawn:
		MK16 A -1;
		Stop;
	}
}
class markerRestaurant : markerBase {
    Default {
	//$Title "skull 1"
    }
	States {
		Spawn:
		MK13 A -1;
		Stop;
	}
}
class markerRuins : markerBase {
    Default {
	//$Title "ruins"
    }
	States {
		Spawn:
		MK14 A -1;
		Stop;
	}
}
class markerAlchShop : markerBase {
    Default {
	//$Title "alchemy shop"
    }
	States {
		Spawn:
		MK15 A -1;
		Stop;
	}
}
class markerVillage : markerBase {
    Default {
	//$Title "village-town"
    }
	States {
		Spawn:
		MK17 A -1;
		Stop;
	}
}
class markerStargate : markerBase {
    Default {
	//$Title "stargate"
    }
	States {
		Spawn:
		MK18 A -1;
		Stop;
	}
}
class markerChest : markerBase {
    Default {
	//$Title "chest"
    }
	States {
		Spawn:
		MK19 A -1;
		Stop;
	}
}