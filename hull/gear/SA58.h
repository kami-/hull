class SA58 {
    class Rifleman {
        weapons[] = {"Sa58V_CCO_EP1"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 9},
            {"HandGrenade_East", 2},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Rucksack_EAST";
        ruckWeapons[] = {};
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343"};
        ifak[] = {1, 1, 1};
        code = "";
    };

    class Leader : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"ACE_30Rnd_762x39_T_SA58", 3},
            {"HandGrenade_East", 1},
            {"SmokeShell", 2}
        };
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 3},
            {"ACE_30Rnd_762x39_T_SA58", 3},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular"};
    };

    class Officer : Leader {
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular_Vector", "ItemGPS"};
    };

    class Crew : Rifleman {
        weapons[] = {"ACE_MP7"};
        magazines[] = {
            {"ACE_40Rnd_B_46x30_MP7", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_Rucksack_EAST";
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343"};
    };

    class CO : Officer {
    };

    class XO : Officer {
    };

    class SL : Officer {
    };

    class Medic : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"SmokeShell", 2},
            {"SmokeShellGreen", 2}
        };
        ruck = "ACE_Rucksack_EAST";
        ruckMagazines[] = {
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"SmokeShell", 2},
            {"SmokeShellGreen", 2},
            {"ACE_Morphine", 15},
            {"ACE_LargeBandage", 15},
            {"ACE_Epinephrine", 10},
            {"ACE_Medkit", 8}
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular"};
    };

    class FTL : Leader {
    };

    class AR : Rifleman {
        weapons[] = {"M249_EP1"};
        magazines[] = {
            {"100Rnd_556x45_M249", 6},
            {"ACE_100Rnd_556x45_T_M249", 2},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"HandGrenade_East", 2},
            {"SmokeShell", 2}
        };
    };

    class AAR : Rifleman {
        ruckMagazines[] = {
            {"100Rnd_556x45_M249", 4},
            {"ACE_100Rnd_556x45_T_M249", 2},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        items[] = {"Binocular"};
    };

    class RAT : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1", "ACE_RPG7V_PGO7"};
        ruckMagazines[] = {
            {"PG7V", 2},
        };
    };

    class MMGG : Rifleman {
        weapons[] = {"M60A4_EP1"};
        magazines[] = {
            {"100Rnd_762x51_M240", 5},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class MMGAG : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"100Rnd_762x51_M240", 3}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGG : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1", "ACE_DSHKMProxy"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HMGAG : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1", "ACE_DSHKMTripodProxy"};
        magazines[] = {
            {"30Rnd_762x39_SA58",  8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"ACE_DSHKM_CSWDM", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGAC : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"ACE_DSHKM_CSWDM", 4}
        };
    };

    class MATG : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1", "MAAWS"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"MAAWS_HEAT", 2},
            {"SmokeShell", 1},
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class MATAG : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58",  8},
            {"MAAWS_HEAT", 2},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Backpack_RPG";
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"MAAWS_HEAT", 1},
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class MATAC : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58", 8},
            {"ACE_RPG29_PG29", 1},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Backpack_RPG";
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2},
            {"ACE_MAAWS_HE", 1},
            {"MAAWS_HEAT", 2}
        };
    };

    class HATG : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1", "MetisLauncher"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"AT13", 2},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HATAG : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1"};
        magazines[] = {
            {"30Rnd_762x39_SA58",  8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"AT13", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HATAC : Rifleman {
        weapons[] = {"Sa58V_CCO_EP1"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"AT13", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2}
        };
    };

    class ENG : Rifleman {
        weapons[] = {"AKS_74_U"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"pipebomb", 2},
            {"mine", 3}
        };
        items[] = {"ACRE_PRC343","ACRE_PRC148"};
    };

    class ENGA : Rifleman {
        weapons[] = {"AKS_74_U"};
        magazines[] = {
            {"30Rnd_762x39_SA58", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"pipebomb", 2},
            {"mine", 3}
        };
        items[] = {"ACRE_PRC343"};
    };

    class SN : Rifleman {
        weapons[] = {"ACE_SVD_Bipod", "MakarovSD"};
        magazines[] = {
            {"10Rnd_762x54_SVD",  2},
            {"8Rnd_9x18_MakarovSD",  5},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular_Vector"};
    };

    class SP : Rifleman {
        magazines[] = {
            {"30Rnd_762x39_SA58", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_762x39_SA58", 2},
            {"ACE_30Rnd_762x39_T_SA58", 2}
        };
    };

    class VC : Crew {
        items[] = {"ACRE_PRC343", "ACRE_PRC117F"};
    };

    class VG : Crew {
    };

    class VD : Crew {
    };

    class P : Crew {
        items[] = {"ACRE_PRC343", "ACRE_PRC117F"};
    };

    class PCM : Crew {
    };

    class Vehicle {
        weapons[] = {
            {"Sa58V_CCO_EP1", 2},
            {"ACE_MP7", 2}
        };
        magazines[] = {
            {"30Rnd_762x39_SA58", 20},
            {"ACE_100Rnd_556x45_T_M249", 10},
            {"ACE_30Rnd_762x39_T_SA58", 10},
            {"ACE_40Rnd_B_46x30_MP7", 10},
            {"100Rnd_762x51_M240", 5},
            {"PG7V", 5},
            {"HandGrenade_East", 10},
            {"SmokeShell", 5}
        };
        items[] = {
            {"ACRE_PRC343", 5},
            {"ACRE_PRC148", 5}
        };
        code = "";
    };

    class Car : Vehicle {
    };

    class Truck : Vehicle {
        weapons[] = {
            {"Sa58V_CCO_EP1", 5},
            {"ACE_MP7", 5}
        };
        magazines[] = {
            {"30Rnd_762x39_SA58", 50},
            {"100Rnd_556x45_M249", 20},
            {"ACE_30Rnd_762x39_T_SA58", 25},
            {"ACE_40Rnd_B_46x30_MP7", 10},
            {"100Rnd_762x51_M240", 10},
            {"ACE_DSHKM_CSWDM", 8},
            {"mine", 4},
            {"PG7V", 8},
            {"MAAWS_HEAT", 5},
            {"HandGrenade_East", 10},
            {"SmokeShell", 10}
        };
    };

    class Armored : Vehicle {
        weapons[] = {
        };
        magazines[] = {
            {"30Rnd_762x39_SA58", 20},
            {"100Rnd_556x45_M249", 10},
            {"ACE_30Rnd_762x39_T_SA58", 10},
            {"ACE_40Rnd_B_46x30_MP7", 10},
            {"100Rnd_762x51_M240", 5},
            {"PG7V", 4},
            {"MAAWS_HEAT", 2},
            {"HandGrenade_East", 10},
            {"SmokeShell", 5}
        };
    };
};