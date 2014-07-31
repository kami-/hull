#include "hull_macros.h"

class CfgPatches {
    class Hull {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.0;
        requiredAddons[] = {"CBA_MAIN"};
        author[] = {"Kami", "soju","Ark"};
        authorUrl = "https://github.com/kami-";
    };
};

class Extended_PreInit_EventHandlers {
    class Hull {
        init = "[] call compile preProcessFileLineNumbers 'x\ark\addons\hull\hull_preinit.sqf';";
    };
};

class Extended_PostInit_EventHandlers {
    class Hull {
        init = "[] call compile preProcessFileLineNumbers 'x\ark\addons\hull\hull_init.sqf';";
    };
};

class CfgVehicles {
    class Logic;

    class Hull_DisableGroupMarkers_Module : Logic {
        displayName = "Hull: Disable Group Markers";
        icon = ADDON_PATH(resources\hull_module.paa);
        model = "\ca\weapons\empty";
        vehicleClass = "Modules";
        class Eventhandlers {
            init = "hull_marker_isGroupEnabled = false;";
        };
    };

    class Hull_DisableFireTeamMarkers_Module : Logic {
        displayName = "Hull: Disable Fire Team Member Markers";
        icon = ADDON_PATH(resources\hull_module.paa);
        model = "\ca\weapons\empty";
        vehicleClass = "Modules";
        class Eventhandlers {
            init = "hull_marker_isFireTeamEnabled = false;";
        };
    };
};

class Hull {
    isEnabled = 1;
    
    #include "mission_params.h"

    class Gear {
        #include "gear\factions.h"

        #include "gear\Default.h"
        #include "gear\AK103.h"
        #include "gear\AK74.h"
        #include "gear\AK74M.h"
        #include "gear\AK74P.h"
        #include "gear\AKM.h"
        #include "gear\HK416.h"
        #include "gear\L85.h"
        #include "gear\M16A2.h"
        #include "gear\M16A4.h"
        #include "gear\M4SOC.h"
        #include "gear\SCAR.h"
        #include "gear\XM8.h"

        unitBaseClass = "Rifleman";
        vehicleBaseClass = "Vehicle";
    };

    class Briefing {
        blufor = ADDON_PATH(briefing\blufor.sqf);
        opfor = ADDON_PATH(briefing\opfor.sqf);
        indfor = ADDON_PATH(briefing\indfor.sqf);
        civilian = ADDON_PATH(briefing\civilian.sqf);
    };

    class Group {
        assignedTeams[] = {
            {"FTL", "RED"},
            {"AR", "BLUE"},
            {"AAR", "BLUE"},
            {"RAT", "RED"}
        };
    };

    class Marker {
        isGroupEnabled = 1;
        isFireTeamEnabled = 1;

        defaultDelay = 4;

        class MedicMarker {
            size[] = {0.5, 0.5};
        };

        class FireTeamMemberMarker {
            color = "ColorYellow";
            size[] = {0.6, 0.6};
        };

        class DefaultCustomMarker {
            shape = "ICON";
            type = "Dot";
            color = "ColorPink";
            size[] = {1, 1};
            text = "";
        };
    };

    class ACRE {
        class ShortRange {
            default = "ACRE_PRC343";
            radios[] = {"ACRE_PRC343"};
            baseFrequency = 2400;
        };

        class LongRange {
            default = "ACRE_PRC343";
            radios[] = {"ACRE_PRC148", "ACRE_PRC148_UHF", "ACRE_PRC117F", "ACRE_PRC119", "ACRE_PRC152"};
            baseFrequency = 32;
        };

        class Steps {
            channel = 1;
            west = 0.2;
            east = 0.4;
            resistance = 0.6;
            default = 0.8;
        };
    };

    class ACE {
        ace_sys_repair_default_tyres = 1;               // Enable spare tyres in vehicles
        ace_sys_wounds_enabled = 1;                     // Enable ACE Wounds
        ace_sys_wounds_all_medics = 1;                  // Everyone can use medkits
        ace_sys_wounds_leftdam = 0;                     // Full heal in the field
        ace_sys_aitalk_enabled = 1;                     // Enable AI talk
        ace_sys_viewblock_blockgrass = 1;               // Enable AI grass viewblock
        ace_sys_destruction_enable_cookoff = 1;         // Enable ammo cookoff
        ace_settings_enable_vd_change = 1;              // Enable ACE view distance change
        ace_sys_aitalk_talkforplayer = 0;               // Disable dynamic shouting and speaking for AI
        ACE_sys_tracking_MarkersEnabled = 0;            // Disables ACE group markers
        ACE_sys_tracking_markers_enabled_override = 1;  // Disables ACE group markers
        ace_viewdistance_limit = 8000;                  // View distance limit

        ace_sys_wounds_no_medical_gear = 1;             // Removes default ACE medical gear given at start of mission
        ace_sys_eject_fnc_weaponCheckEnabled = 0;       // Disables weapon removal for pilots
        ace_sys_rotoreffects_fnc_rocko_manshred = 0;    // Disables rotor damage
    };

    class General {
        addRating = 999999;                             // Rating added to units, to supress negative ratings
        BIS_noCoreConversations = 1;                    // Disables BIS unit conversations
        enableSaving = 0;                               // Enables game saving
    };
};