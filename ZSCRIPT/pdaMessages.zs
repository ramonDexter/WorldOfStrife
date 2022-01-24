////////////////////////////////////////////////////////////////////////////////
// pda actor classes ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
/*
//old decorate example by nash--------------------------------------------------
class TestPDA : PDA 
{
	Tag "$PDA_TestPDA_Title"
	PDA.Text "$PDA_TestPDA_Text"
	PDA.Image "graphics/PDA/images/Test PDA Image.png"
	PDA.Audio "PDA/TestPDAAudio"

	States
	{
		Spawn:
			PMAP A -1
			Stop
	}
}
//example by nash---------------------------------------------------------------



//my example--------------------------------------------------------------------
class noteTest : PDA {
    Default {
        Tag "$PDA_noteTest_TITLE";
        PDA.Text "$PDA_noteTest_TEXT";
        PDA.Image "graphics/pda/images/image.png";
        PDA.Audio "PDA/testPDAaudio";
    }
	
	
	States {
		Spawn:
			DUMM A -1;
			Stop;
	}
}
//my example--------------------------------------------------------------------
*/
////////////////////////////////////////////////////////////////////////////////

// base class //////////////////////////////////////////////////////////////////
class PDA : CustomInventory {
    Default {
        -INVENTORY.INVBAR;
        +INVENTORY.ALWAYSPICKUP;
        -COUNTITEM;
        //Tag ""
        radius 12;
        height 12;
        Inventory.PickupSound "sounds/itemPickup";
        Mass 0;
    }	
	States {
		Spawn:
			DUMM A -1;
			Stop;
		Use:
			TNT1 A -1;
			Fail;
	}
}
////////////////////////////////////////////////////////////////////////////////

// notes actors ////////////////////////////////////////////////////////////////
class notePrayers : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: prayers"
        Tag "$PDA_notePrayers_TITLE";
        //PDA.Text "$PDA_notePrayers_TEXT"
        //scale 0.5
    }
}
class noteSHmedical : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH medical"
        Tag "$PDA_noteSHmedical_TITLE";
        //PDA.Text "$PDA_noteSHmedical_TEXT"
        //scale 0.5
    }
}
class noteSHshouldergun : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH shouldergun"
        Tag "$PDA_noteSHshouldergun_TITLE";
        //PDA.Image "graphics/pda/images/pdaI_binderstaff.png"
        //scale 0.5
    }
}
class noteSHbinderStavesTechnical : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH binder staves technical"
        Tag "$PDA_noteSHbinderStavesTechnical_TITLE";
        //PDA.Text "$PDA_noteSHbinderStavesTechnical_TEXT"
        //scale 0.5
    }
}
class noteSHbinderNote01 : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH binder 01"
        Tag "$PDA_noteSHbinderNote01_TITLE";
        //PDA.Text "$PDA_noteSHbinderNote01_TEXT"
        //scale 0.5
    }
}
class noteSHsilentHillsTouristGuide : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH tourist guide"
        Tag "$PDA_noteSHsilentHillsTouristGuide_TITLE";
        //PDA.Text "$PDA_noteSHsilentHillsTouristGuide_TEXT"
        //scale 0.5
    }
}
class noteSHminesReport : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH mines report"
        Tag "$PDA_noteSHminesReport_TITLE";
        //PDA.Text "$PDA_noteSHminesReport_TEXT"
        //scale 0.5
    }
}
class noteSHbindersOath : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH binder's oath"
        Tag "$PDA_noteSHbindersOath_TITLE";
        //PDA.Text "$PDA_noteSHbindersOath_TEXT"
        //scale 0.5
    }
}
class noteCommonDogmas : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: SH binder's oath"
        Tag "$PDA_noteCommonDogmas_Title";
        //PDA.Text "$PDA_noteCommonDogmas_text"
        //scale 0.5
    }
}
class noteCoastalRegion : PDA {
    Default {
        //$category "ZSCRIPT/PDAnotes"
        //$title "note: Coastal Region"
        Tag "$PDA_noteCoastalRegion_title";
    }
}
////////////////////////////////////////////////////////////////////////////////