///////////////////////////////////////////////////////////////////////////////////////
// various scripts to support ACS /////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
class selectPunchDagger {    
    static void FN_selectPunchDagger (void) { wosEventHandler.SendNetworkEvent("selectDagger"); }    
}
// zscript to ACS transfer scripts ////////////////////////////////////////////////////
class wosZSC2ACS {

    static void FN_give10accuracy (void) {
        wosEventHandler.SendNetworkEvent("give_10Accuracy");
    }
    static void FN_give10stamina(void) {
        wosEventHandler.SendNetworkEvent("give_10Stamina");
    }
    static void FN_give10mind(void) {
        wosEventHandler.SendNetworkEvent("give_10Mind");
    }
    static void FN_healPlayer(void) {
        wosEventHandler.SendNetworkEvent("heal_Player");
    }
    /*static void FN_initTrade() {
        //m8f_tl_init_trade
        m8f_tl_KeyboardHandler.SendNetworkEvent("m8f_tl_init_trade");
    }*/
}
///////////////////////////////////////////////////////////////////////////////////////

