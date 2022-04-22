class selectPunchDagger {
    
    static void FN_selectPunchDagger (void) {
        wosEventHandler.SendNetworkEvent("selectDagger");
    }
    
}
class wosZSC2ACS {

    static void FN_give10accuracy (void) {
        wosEventHandler.SendNetworkEvent("give_10Accuracy");
    }
    static void FN_give10stamina(void) {
        wosEventHandler.SendNetworkEvent("give_10Stamina");
    }
    static void FN_healPlayer(void) {
        wosEventHandler.SendNetworkEvent("heal_Player");
    }
}

