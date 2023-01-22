class tokenBase : Inventory {
	Default {
		-inventory.invbar;		
		inventory.amount 1;
		inventory.maxamount 1;
		inventory.interhubamount 1;
		Mass 0;
	}
}

// control tokens //////////////////////////////////////////////////////////////
class removeMainMessage : tokenBase {}

// location tokens - to mark where is player coming from ///////////////////////
class map02token : tokenBase {}
class map05token : tokenBase {}
class map08token : tokenBase {}

// QUEST TOKENS ////////////////////////////////////////////////////////////////

//main quest 01 - kill heretics in castle //////////////////////////////////////
class speakWithLeader : tokenBase {}
class quest01given : tokenBase {}
class rebelsDead : tokenBase {}
class quest01finished : tokenBase {}
class inquisitorPromoted : tokenBase {}
//main quest 02 - find artifact ////////////////////////////////////////////////
class quest02given : tokenBase {}
class quest02_goinside : tokenBase {}
class quest02_artifact_stolen : tokenBase {}
class quest02_finished : tokenBase {}
//go to millport
class quest03_given : tokenBase {}
class quest03_finished : tokenBase {}
//millport main quest
class quest04_millport_given : tokenBase {}
//doplnit
class quest04_millport_finished : tokenBase {}

// combat tutor training ///////////////////////////////////////////////////////
//class m02_combatTutor_trainingDone : tokenBase {}


////////////////////////////////////////////////////////////////////////////////
//  town quests - MAP02  ///////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//quest#1 - pobij pavouky (gang)
class twn_quest01_given : tokenBase {}
class twn_quest01_spidersKilled : tokenBase {}
class twn_quest01_cacheFound : tokenBase {}
class twn_quest01_finished : tokenBase {}

//quest#2
class twn_quest02_given : tokenBase {}
class twn_quest02_poachersKilled : tokenBase {}
//soucastka je v items.zsc - powerplant_powercoupling
class twn_quest02_finished : tokenBase {}

//quest#3
class twn_quest03_given : tokenBase {}
class twn_quest03_powerPlantFixed : tokenBase {}
class twn_quest03_finished : tokenBase {}

//judge q#01
class twn_judgeQ01_rebels_given : tokenBase {}
class twn_judgeQ01_rebels_rowanIsrebel : tokenBase {}
class twn_judgeQ01_rebels_rowanKilled : tokenBase {}
class twn_judgeQ01_rebels_finished : tokenBase {}

//judge q#02 - vrazda v laznich
class twn_judgeQ01_vrazdaVlaznich_given : tokenBase {}
class twn_judgeQ01_vrazdaVlaznich_speakwithgatekeeper : tokenBase {}
class twn_judgeQ01_vrazdaVlaznich_prohledejPrevlekarnu  : tokenBase {}
//detonator se v items.zsc - cityBathMurder_Detonator
class twn_judgeQ01_vrazdaVlaznich_techsmith : tokenBase {}
class twn_judgeQ01_vrazdaVlaznich_obchodnik : tokenBase {}
class twn_judgeQ01_vrazdaVlaznich_usvedcen : tokenBase {}
class twn_judgeQ01_vrazdaVlaznich_finished : tokenBase {}
class twn_judgeQs_solved : tokenBase {}

//bishop q#01 - najdi skrys rebelu ve meste
class twn_bishopQ01_skrysRebelu_given : tokenBase {}
class twn_bishopQ01_skrysRebelu_skladiste : tokenBase {}
class twn_bishopQ01_skrysRebelu_skrys : tokenBase {}
//item v items.zsc: hereticalRelic
//item v items.zsc: infoDisk
class twn_bishopQ01_skrysRebelu_finished : tokenBase {}

//bishop q#02 - pobij rebely ve stare tovarne
class twn_bishopQ02_killRebels_given : tokenBase {}
//vybusne zarizeni na zniceni zdi pro pristup do zakladny rebelu: q_explosiveDevice_01
class twn_bishopQ02_killRebels_rebelsKilled : tokenBase {}
//lebka jejich velitele: hereticLeaderSkull
class twn_bishopQ02_killRebels_finished : tokenBase {}

//tekGuild master quest#01//////////////////////////////////////
class twn_tekGuildMasterQ1_oreDelivery_given : tokenBase {}
class twn_tekGuildMasterQ1_oreDelivery_pickOre : tokenBase {}
class twn_tekGuildMasterQ1_oreDelivery_orePicked : tokenBase {}
class twn_tekGuildMasterQ1_oreDelivery_finished : tokenBase {}
////////////////////////////////////////////////////////////////

//tekGuild master quest#02//////////////////////////////////////
class twn_tekGuildMasterQ2_brokenMachinery_given : tokenBase {}
class twn_tekGuildMasterQ2_brokenMachinery_needFilter : tokenBase {}
//soucastky filter mineMachineFilter
class twn_tekGuildMasterQ2_brokenMachinery_newfilter : tokenBase {}
class twn_tekGuildMasterQ2_brokenMachinery_repaired : tokenBase {}
class twn_tekGuildMasterQ2_brokenMachinery_finished : tokenBase {}
////////////////////////////////////////////////////////////////

//tekGuild master quest#03//////////////////////////////////////
class twn_tekGuildMasterQ3_powerplantTrouble_given : tokenBase {}
class twn_tekGuildMasterQ3_powerplantTrouble_blownTransformer : tokenBase {}
class twn_tekGuildMasterQ3_powerplantTrouble_hereticLeaderKilled : tokenBase {}
class twn_tekGuildMasterQ3_powerplantTrouble_finished : tokenBase {}
////////////////////////////////////////////////////////////////

// binder cook sezen suroviny //////////////////////////////////
class twn_binderCook_sezensuroviny_given : tokenBase {}
class twn_binderCook_sezensuroviny_sehnano : tokenBase {}
class twn_binderCook_sezensuroviny_finished : tokenBase {}
////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  MAP08  /////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//support token - ziskej duveru mistnich
class m08q_duveraMistnich : tokenBase {
	Default {
		-inventory.invbar;		
		inventory.amount 1;
		inventory.maxamount 9;
		inventory.interhubamount 9;
	}
}

//  council club innkeeper - get the chef  /////////////////////////////////////
class m08q_CCinnkeeper_given : tokenBase {}
class m08q_CCinnkeeper_naselkuchare : tokenBase {}
class m08q_CCinnkeeper_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//  MAP14  /////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// starosta quest pobij pavouky ////////////////////////////////////////////////
class m14q_killQueens_given : tokenBase {}
class m14q_killQueens_killed : tokenBase {}
class m14q_killQueens_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// starosta quest pobij bandity ve vodarne /////////////////////////////////////
class m14q_raidedWaterplant_given : tokenBase {}
class m14q_raidedWaterplant_killed : tokenBase {}
class m14q_raidedWaterplant_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// eastcliff vycisti sklep /////////////////////////////////////////////////////
class m14q_cleanTheCellar_given : tokenBase {}
class m14q_cleanTheCellar_killedRats : tokenBase {}
class m14q_cleanTheCellar_findNest : tokenBase {}
class m14q_cleanTheCellar_getPoison : tokenBase {}
class m14q_cleanTheCellar_getFishGuts : tokenBase {}
class m14q_cleanTheCellar_gotfishguts : tokenBase {}
class m14q_cleanTheCellar_gotpoison : tokenBase {}
class m14q_cleanTheCellar_destroyNest : tokenBase {}
class m14q_cleanTheCellar_destroyed : tokenBase {}
class m14q_cleanTheCellar_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// quest eastcliff dones jidlo rybari //////////////////////////////////////////
class wosq_ECdeliverFood_given : tokenBase {}
class wosq_ECdeliverFood_delivered : tokenBase {}
class wosq_ECdeliverFood_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// aeredale quest troubled waters //////////////////////////////////////////////
class m10q_troubledWaters_given : tokenBase {}
class m10q_troubledWaters_go4ore : tokenBase {}
class m10q_troubledWaters_foundOre : tokenBase {}
class m10q_troubledWaters_haveSolution : tokenBase {}
class m10q_troubledWaters_cleanedWater : tokenBase {}
class m10q_troubledWaters_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// aeredale ztracena dcera /////////////////////////////////////////////////////
class m10q_lostDaughter_given : tokenBase {}
class m10q_lostDaughter_found : tokenBase {}
class m10q_lostDaughter_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// millport derwin sezen soucastky /////////////////////////////////////////////
class m08q_derwin_sezensoucastky_given : tokenBase {}
class m08q_derwin_sezensoucastky_aeredale : tokenBase {}
class m08q_derwin_sezensoucastky_sehnaltools : tokenBase {}
class m08q_derwin_sezensoucastky_sehnal : tokenBase {}
class m08q_derwin_sezensoucastky_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// millport quincy ztracena sestra /////////////////////////////////////////////
class m08q_quincy_lostsister_given : tokenBase {}
class m08q_quincy_lostsister_found : tokenBase {}
class m08q_quincy_lostsister_payed : tokenBase {}
class m08q_quincy_lostsister_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// soudce zmeny Afer Valgus Reberio convID 38 //////////////////////////////////
// 1) Dones prikaz Ediktu starostovi Ravenrocku.
class m08q_soudceZmeny_01_deliverEdict_given : tokenBase {}
class m08q_soudceZmeny_01_deliverEdict_delivered : tokenBase {}
class m08q_soudceZmeny_01_deliverEdict_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// soudce zmeny Afer Valgus Reberio convID 38 //////////////////////////////////
// 2) umisti zaznamove zarizeni do autodoca doktora v commons
class m08q_soudceZmeny_02_plantDevice_given : tokenBase {}
class m08q_soudceZmeny_02_plantDevice_planted : tokenBase {}
class m08q_soudceZmeny_02_plantDevice_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////

// # Gregory, techsmith, convID 14 /////////////////////////////////////////////
// quest: 1) sezen dodavatele soucastek 
class m08q_gregory_sezenDodavatele_given : tokenBase {}
class m08q_gregory_sezenDodavatele_domluvil : tokenBase {}
class m08q_gregory_sezenDodavatele_finished : tokenBase {}
////////////////////////////////////////////////////////////////////////////////