#include "hull_macros.h"

#include "\userconfig\hull\log\settings.h"
#include "logbook.h"

hull_settings_fnc_init = {
    [] call hull_settings_fnc_setStandardAceSettings;
    [] call hull_settings_fnc_setNonStandardAceSettings;
    [] call hull_settings_fnc_setNonStandardGeneralSettings;
    [] call hull_settings_fnc_setModuleVariables;
};

hull_settings_fnc_setStandardAceSettings = {
    DECLARE(_rawVariables) = [
        ["ace_sys_repair_default_tyres", CONFIG_TYPE_BOOL],
        ["ace_sys_wounds_enabled", CONFIG_TYPE_BOOL],
        ["ace_sys_wounds_all_medics", CONFIG_TYPE_BOOL],
        ["ace_sys_wounds_leftdam", CONFIG_TYPE_NUMBER],
        ["ace_sys_aitalk_enabled", CONFIG_TYPE_BOOL],
        ["ace_sys_viewblock_blockgrass", CONFIG_TYPE_BOOL],
        ["ace_sys_destruction_enable_cookoff", CONFIG_TYPE_BOOL],
        ["ace_settings_enable_vd_change", CONFIG_TYPE_BOOL],
        ["ace_sys_aitalk_talkforplayer", CONFIG_TYPE_BOOL],
        ["ACE_sys_tracking_MarkersEnabled", CONFIG_TYPE_BOOL],
        ["ACE_sys_tracking_markers_enabled_override", CONFIG_TYPE_BOOL],
        ["ace_viewdistance_limit", CONFIG_TYPE_NUMBER]
    ];

    {
        private ["_variable", "_value"];
        _variable = _x select 0;
        _value = ["ACE", _variable] call (CONFIG_TYPE_FUNCTIONS select (_x select 1));
        missionNamespace setVariable [_variable, _value];
        DEBUG("hull.settings.ace",FMT_2("ACE variable '%1' is set to '%2'.",_variable,_value));
    } foreach _rawVariables;
};


hull_settings_fnc_setNonStandardAceSettings = {
    if (!(["ACE", "ace_sys_eject_fnc_weaponCheckEnabled"] call hull_config_fnc_getBool)) then {
        ace_sys_eject_fnc_weaponCheckEnabled = {false};
        DEBUG("hull.settings.ace","Pilot weapon storing is disabled.");
    };
    if (!(["ACE", "ace_sys_rotoreffects_fnc_rocko_manshred"] call hull_config_fnc_getBool)) then {
        DEBUG("hull.settings.ace","Tail rotor damage is disabled.");
        ace_sys_rotoreffects_fnc_rocko_manshred = {};
    };
};

hull_settings_fnc_setNonStandardGeneralSettings = {
    if (!(["General", "enableSaving"] call hull_config_fnc_getBool)) then {
        enableSaving [false, false];
        DEBUG("hull.settings","Saving is disabled.");
    };
};

hull_settings_fnc_setUnitGlobalSettings = {
    FUN_ARGS_1(_unit);

    _unit setVariable ["ace_sys_wounds_no_medical_gear", ["ACE", "ace_sys_wounds_no_medical_gear"] call hull_config_fnc_getBool, true];
    DEBUG("hull.settings.ace",FMT_2("Unit '%1' variable 'ace_sys_wounds_no_medical_gear' is set to '%2'.",_unit,AS_ARRAY_2("ACE", "ace_sys_wounds_no_medical_gear") call hull_config_fnc_getBool));
    _unit addRating (["General", "addRating"] call hull_config_fnc_getNumber);
    DEBUG("hull.settings",FMT_3("Added '%1' rating to unit '%2'. New rating is '%3'.",AS_ARRAY_2("General", "addRating") call hull_config_fnc_getNumber,_unit,rating _unit));
    _unit setVariable ["BIS_noCoreConversations", ["General", "BIS_noCoreConversations"] call hull_config_fnc_getBool, true];
    DEBUG("hull.settings",FMT_2("Unit '%1' variable 'BIS_noCoreConversations' is set to '%2'.",_unit,AS_ARRAY_2("General", "BIS_noCoreConversations") call hull_config_fnc_getBool));
};

hull_settings_fnc_setModuleVariables = {
    if (isNil {hull_marker_isGroupEnabled}) then {
        hull_marker_isGroupEnabled = ["Marker", "isGroupEnabled"] call hull_config_fnc_getBool;
        DEBUG("hull.settings.marker",FMT_1("Group marker module was not found. Setting Group Marker enabled from config to '%1'.",AS_ARRAY_2("Marker", "isGroupEnabled") call hull_config_fnc_getBool));
    };
    if (isNil {hull_marker_isFireTeamEnabled}) then {
        hull_marker_isFireTeamEnabled = ["Marker", "isFireTeamEnabled"] call hull_config_fnc_getBool;
        DEBUG("hull.settings.marker",FMT_1("Fire Team Member marker module was not found. Setting Fire Team Member marker enabled from config to '%1'.",AS_ARRAY_2("Marker", "isFireTeamEnabled") call hull_config_fnc_getBool));
    };
};
