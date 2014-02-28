class M4SOC {
    class Rifleman {
        weapons[] = {"ACE_SOC_M4A1_Aim"};
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
        weapons[] = {"ACE_SOC_M4A1_GL_AIMPOINT"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"ACE_30Rnd_556x45_T_Stanag", 3},
            {"HandGrenade_West", 1},
            {"SmokeShell", 2},
            {"1Rnd_HE_M203", 2},
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
    
    class DC : Officer {
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
            {"ACE_Morphine", 20},
            {"ACE_LargeBandage", 20},
            {"ACE_Epinephrine", 20},
            {"ACE_Medkit", 8}
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
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
    };

    class AAR : Rifleman {
        ruckMagazines[] = {
            {"100Rnd_556x45_M249", 2},
            {"ACE_100Rnd_556x45_T_M249", 2},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
    };

    class RAT : Rifleman {
        weapons[] = {"ACE_SOC_M4A1_Aim", "M136"};
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
        weapons[] = {"ACE_SOC_M4A1_Aim", "ACE_M2HBProxy"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HMGAG : Rifleman {
        weapons[] = {"ACE_SOC_M4A1_Aim", "ACE_M3TripodProxy"};
        magazines[] = {
            {"30Rnd_556x45_Stanag",  8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"ACE_M2_CSWDM", 1}
        };
        items[] = {"ACRE_PRC343", "Binocular_Vector"};
    };

    class HMGAC : Rifleman {
        magazines[] = {
            {"30Rnd_556x45_Stanag", 8},
            {"HandGrenade_West", 1},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
            {"30Rnd_556x45_Stanag", 2},
            {"ACE_30Rnd_556x45_T_Stanag", 2},
            {"ACE_M2_CSWDM", 3}
        };
    };

    class MATG : Rifleman {
        weapons[] = {"ACE_SOC_M4A1_Aim", "SMAW"};
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
        weapons[] = {"ACE_SOC_M4A1_Aim", "ACE_Javelin_Direct"};
        magazines[] = {
            {"30Rnd_556x45_Stanag", 6},
            {"SMAW_HEAA", 2},
            {"SmokeShell", 1}
        };
        ruckMagazines[] = {
        };
        items[] = {"ACRE_PRC343", "ACRE_PRC148"};
    };

    class HATAG : Rifleman {
        weapons[] = {"ACE_SOC_M4A1_Aim", "ACE_Javelin_Direct"};
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
        weapons[] = {"ACE_SOC_M4A1_Aim", "ACE_Javelin_Direct"};
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

    class PC : Crew {
        items[] = {"ACRE_PRC343", "ACRE_PRC117F"};
    };

    class PCM : Crew {
    };
};