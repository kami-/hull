class AK74 {
    class Rifleman {
        weapons[] = {"AK_74"};
        magazines[] = {
            {"30Rnd_545x39_AK", 9},
            {"HandGrenade_East", 2},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Rucksack_EAST";
        ruckWeapons[] = {};
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 6},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343"};
        ifak[] = {1, 1, 1};
        code = "";
    };

    class Leader : Rifleman {
        weapons[] = {"AK_74_GL"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
            {"ACE_30Rnd_545x39_T_AK", 3},
            {"HandGrenade_East", 1},
            {"SmokeShell", 2},
            {"1Rnd_HE_GP25", 4},
            {"1Rnd_SMOKE_GP25", 2},
            {"1Rnd_SmokeRed_GP25", 1},
            {"1Rnd_SmokeGreen_GP25", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 3},
            {"ACE_30Rnd_545x39_T_AK", 3},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1},
            {"1Rnd_SMOKE_GP25", 2},
            {"1Rnd_SmokeRed_GP25", 1},
            {"1Rnd_SmokeGreen_GP25", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular"};
    };

    class Officer : Leader {
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular_Vector", "ItemGPS"};
    };

    class Crew : Rifleman {
        weapons[] = {"AKS_74_U"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
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
            {"30Rnd_545x39_AK", 6},
            {"SmokeShell", 2},
            {"SmokeShellGreen", 2}
        };
        ruck = "ACE_Rucksack_EAST";
        ruckMagazines[] = {
            {"ACE_30Rnd_545x39_T_AK", 2},
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
        weapons[] = {"RPK_74"};
        magazines[] = {
            {"ACE_75Rnd_545x39_T_RPK", 9},
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
            {"ACE_75Rnd_545x39_T_RPK", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular"};
    };

    class RAT : Rifleman {
        weapons[] = {"AKS_74", "ACE_RPG7V_PGO7"};
        ruckMagazines[] = {
            {"PG7V", 2}
        };
    };

    class MMGG : Rifleman {
        weapons[] = {"PK"};
        magazines[] = {
            {"100Rnd_762x54_PK", 5},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class MMGAG : Rifleman {
        magazines[] = {
            {"30Rnd_545x39_AK", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2},
            {"100Rnd_762x54_PK", 3}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGG : Rifleman {
        weapons[] = {"AKS_74", "ACE_DSHKMProxy"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HMGAG : Rifleman {
        weapons[] = {"AKS_74", "ACE_DSHKMTripodProxy"};
        magazines[] = {
            {"30Rnd_545x39_AK",  8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2},
            {"ACE_DSHKM_CSWDM", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGAC : Rifleman {
        magazines[] = {
            {"30Rnd_545x39_AK", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_BackPack_ACR";
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2},
            {"ACE_DSHKM_CSWDM", 4}
        };
    };

    class MATG : Rifleman {
        weapons[] = {"AKS_74", "ACE_RPG29"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
            {"ACE_RPG29_PG29", 2},
            {"SmokeShell", 1},
        };
        ruckMagazines[] = {
            {"SmokeShell", 1},
            {"30Rnd_545x39_AK", 3},
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class MATAG : Rifleman {
        magazines[] = {
            {"30Rnd_545x39_AK",  8},
            {"ACE_RPG29_PG29", 1},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Backpack_RPG";
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2},
            {"ACE_RPG29_PG29", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class MATAC : Rifleman {
        magazines[] = {
            {"30Rnd_545x39_AK", 8},
            {"ACE_RPG29_PG29", 1},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_Backpack_RPG";
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2},
            {"ACE_RPG29_PG29", 2}
        };
    };

    class HATG : Rifleman {
        weapons[] = {"AKS_74", "MetisLauncher"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
            {"AT13", 2},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HATAG : Rifleman {
        weapons[] = {"AKS_74"};
        magazines[] = {
            {"30Rnd_545x39_AK",  8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"AT13", 2},
            {"ACE_30Rnd_545x39_T_AK", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HATAC : Rifleman {
        weapons[] = {"AKS_74"};
        magazines[] = {
            {"30Rnd_545x39_AK", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"AT13", 2},
            {"ACE_30Rnd_545x39_T_AK", 2}
        };
    };

    class ENG : Rifleman {
        weapons[] = {"AKS_74_U"};
        magazines[] = {
            {"30Rnd_545x39_AK", 6},
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
            {"30Rnd_545x39_AK", 6},
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
            {"30Rnd_545x39_AK", 8},
            {"HandGrenade_East", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_545x39_AK", 2},
            {"ACE_30Rnd_545x39_T_AK", 2}
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
            {"AK_74", 2},
            {"AKS_74_U", 2}
        };
        magazines[] = {
            {"30Rnd_545x39_AK", 20},
            {"ACE_30Rnd_545x39_T_AK", 10},
            {"ACE_75Rnd_545x39_T_RPK", 15},
            {"100Rnd_762x54_PK", 5},
            {"PG7V", 5},
            {"1Rnd_SmokeRed_GP25", 5},
            {"1Rnd_SmokeGreen_M203", 5},
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
            {"AK_74", 5},
            {"AKS_74_U", 5}
        };
        magazines[] = {
            {"30Rnd_545x39_AK", 50},
            {"ACE_30Rnd_545x39_T_AK", 25},
            {"ACE_75Rnd_545x39_T_RPK", 30},
            {"100Rnd_762x54_PK", 10},
            {"ACE_DSHKM_CSWDM", 8},
            {"mine", 4},
            {"PG7V", 8},
            {"ACE_RPG29_PG29", 5},
            {"1Rnd_SmokeRed_GP25", 10},
            {"1Rnd_SmokeGreen_GP25", 10},
            {"HandGrenade_East", 10},
            {"SmokeShell", 10}
        };
    };

    class Armored : Vehicle {
        weapons[] = {
        };
        magazines[] = {
            {"30Rnd_545x39_AK", 20},
            {"ACE_30Rnd_545x39_T_AK", 10},
            {"ACE_75Rnd_545x39_T_RPK", 15},
            {"100Rnd_762x54_PK", 5},
            {"PG7V", 4},
            {"ACE_RPG29_PG29", 2},
            {"1Rnd_SmokeRed_GP25", 10},
            {"1Rnd_SmokeGreen_GP25", 10},
            {"HandGrenade_East", 10},
            {"SmokeShell", 5}
        };
    };
};