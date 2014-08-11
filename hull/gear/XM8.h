class XM8 {
    class Rifleman {
        weapons[] = {"m8_carbine"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 9},
            {"HandGrenade_West", 2},
            {"SmokeShell", 1}
        };
        ruck = "ACE_CharliePack";
        ruckWeapons[] = {};
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343"};
        ifak[] = {1, 1, 1};
        code = "";
    };

    class Leader : Rifleman {
        weapons[] = {"m8_carbineGL"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"ACE_30Rnd_556x45_T_Stanag", 3},
            {"HandGrenade_West", 1},
            {"SmokeShell", 2},
            {"1Rnd_HE_M203", 4},
            {"1Rnd_Smoke_M203", 2},
            {"1Rnd_SmokeRed_M203", 1},
            {"1Rnd_SmokeGreen_M203", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 3},
            {"ACE_30Rnd_556x45_T_Stanag", 3},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1},
            {"1Rnd_Smoke_M203", 2},
            {"1Rnd_SmokeRed_M203", 1},
            {"1Rnd_SmokeGreen_M203", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular"};
    };

    class Officer : Leader {
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular_Vector", "ItemGPS"};
    };

    class Crew : Rifleman {
        weapons[] = {"MP5A5"};
        magazines[] = {
            {"30Rnd_9x19_MP5", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_CharliePack";
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
            {"30Rnd_556x45_Stanag", 6},
            {"SmokeShell", 2},
            {"SmokeShellGreen", 2}
        };
        ruck = "ACE_Rucksack_MOLLE_Brown_Medic";
        ruckMagazines[] = {
            {"ACE_30Rnd_556x45_T_Stanag", 2},
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
            {"100Rnd_556x45_M249", 3},
            {"ACE_100Rnd_556x45_T_M249", 3},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"HandGrenade_West", 2},
            {"SmokeShell", 2}
        };
    };

    class AAR : Rifleman {
        ruckMagazines[] = {
            {"100Rnd_556x45_M249", 2},
            {"ACE_100Rnd_556x45_T_M249", 2},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular"};
    };

    class RAT : Rifleman {
        weapons[] = {"m8_carbine", "M136"};
    };

    class MMGG : Rifleman {
        weapons[] = {"M240"};
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
            {"30Rnd_556x45_Stanag", 8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"100Rnd_762x51_M240", 3}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGG : Rifleman {
        weapons[] = {"m8_carbine", "ACE_M2HBProxy"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HMGAG : Rifleman {
        weapons[] = {"m8_carbine", "ACE_M3TripodProxy"};
        magazines[] = {
            {"30Rnd_556x45_Stanag",  8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_VTAC_RUSH72_OD";
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"ACE_M2_CSWDM", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGAC : Rifleman {
        magazines[] = {
            {"30Rnd_556x45_Stanag", 8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruck = "ACE_VTAC_RUSH72_OD";
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"ACE_M2_CSWDM", 3}
        };
    };

    class MATG : Rifleman {
        weapons[] = {"m8_carbine", "SMAW"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"SMAW_HEAA", 2},
            {"SmokeShell", 1},
            {"ACE_SMAW_Spotting", 3}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class MATAG : Rifleman {
        magazines[] = {
            {"30Rnd_556x45_Stanag",  8},
            {"SMAW_HEAA", 1},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"SMAW_HEAA", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class MATAC : Rifleman {
        magazines[] = {
            {"30Rnd_556x45_Stanag", 8},
            {"SMAW_HEAA", 1},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"SMAW_HEAA", 2}
        };
    };

    class HATG : Rifleman {
        weapons[] = {"m8_carbine", "ACE_Javelin_Direct"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HATAG : Rifleman {
        weapons[] = {"m8_carbine", "ACE_Javelin_Direct"};
        magazines[] = {
            {"30Rnd_556x45_Stanag",  8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
        code = "[_this select 0] spawn {waitUntil {(_this select 0) hasWeapon 'ACE_Javelin_CLU'}; (_this select 0) removeWeapon 'ACE_Javelin_CLU';}";
    };

    class HATAC : Rifleman {
        weapons[] = {"m8_carbine", "ACE_Javelin_Direct"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2}
        };
        code = "[_this select 0] spawn {waitUntil {(_this select 0) hasWeapon 'ACE_Javelin_CLU'}; (_this select 0) removeWeapon 'ACE_Javelin_CLU';}";
    };

    class ENG : Rifleman {
        weapons[] = {"ACE_MP5A5"};
        magazines[] = {
            {"30Rnd_9x19_MP5", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_VTAC_RUSH72_OD";
        ruckMagazines[] = {
            {"pipebomb", 2},
            {"mine", 3}
        };
        items[] = {"ACRE_PRC343","ACRE_PRC148"};
    };

    class ENGA : Rifleman {
        weapons[] = {"ACE_MP5A5"};
        magazines[] = {
            {"30Rnd_9x19_MP5", 6},
            {"SmokeShell", 1},
            {"SmokeShellGreen", 1}
        };
        ruck = "ACE_VTAC_RUSH72_OD";
        ruckMagazines[] = {
            {"pipebomb", 2},
            {"mine", 3}
        };
        items[] = {"ACRE_PRC343"};
    };

    class SN : Rifleman {
        weapons[] = {"M24_des_EP1", "M9SD"};
        magazines[] = {
            {"5Rnd_762x51_M24",  2},
            {"15Rnd_9x19_M9SD",  5},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148", "Binocular_Vector"};
    };

    class SP : Rifleman {
        magazines[] = {
            {"30Rnd_556x45_Stanag", 8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2}
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
            {"m8_carbine", 2},
            {"M136", 2},
            {"MP5A5", 2}
        };
        magazines[] = {
            {"30Rnd_556x45_Stanag", 20},
            {"ACE_100Rnd_556x45_T_M249", 10},
            {"ACE_30Rnd_556x45_T_Stanag", 10},
            {"30Rnd_9x19_MP5", 10},
            {"100Rnd_762x51_M240", 5},
            {"1Rnd_SmokeRed_M203", 5},
            {"1Rnd_SmokeGreen_M203", 5},
            {"HandGrenade_West", 10},
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
            {"m8_carbine", 5},
            {"M136", 5},
            {"MP5A5", 5}
        };
        magazines[] = {
            {"30Rnd_556x45_Stanag", 50},
            {"ACE_100Rnd_556x45_T_M249", 20},
            {"ACE_30Rnd_556x45_T_Stanag", 25},
            {"30Rnd_9x19_MP5", 10},
            {"100Rnd_762x51_M240", 10},
            {"ACE_M2_CSWDM", 5},
            {"mine", 4},
            {"SMAW_HEAA", 5},
            {"1Rnd_SmokeRed_M203", 10},
            {"1Rnd_SmokeGreen_M203", 10},
            {"HandGrenade_West", 10},
            {"SmokeShell", 10}
        };
    };

    class Armored : Vehicle {
        weapons[] = {
            {"M136", 4}
        };
        magazines[] = {
            {"30Rnd_556x45_Stanag", 20},
            {"ACE_100Rnd_556x45_T_M249", 10},
            {"ACE_30Rnd_556x45_T_Stanag", 10},
            {"100Rnd_762x51_M240", 5},
            {"SMAW_HEAA", 2},
            {"1Rnd_SmokeRed_M203", 10},
            {"1Rnd_SmokeGreen_M203", 10},
            {"HandGrenade_West", 10},
            {"SmokeShell", 5}
        };
    };
};