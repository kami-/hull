#include "hull_macros.h"

hull_settings_fnc_preInit = {
    [] call hull_settings_fnc_addEventHandlers;
};

hull_settings_fnc_init = {
    [] call hull_settings_fnc_setStandardAceSettings;
    [] call hull_settings_fnc_setNonStandardAceSettings;
    [] call hull_settings_fnc_setNonStandardGeneralSettings;
    [] call hull_settings_fnc_setModuleVariables;
};

hull_settings_fnc_addEventHandlers = {
    ["player.initialized", hull_settings_fnc_setPlayerSettings] call hull_event_fnc_addEventHandler;
};

hull_settings_fnc_setStandardAceSettings = {
    private ["_typeFunctions" ,"_rawVariables"];
    _typeFunctions = CONFIG_TYPE_FUNCTIONS;
    _rawVariables = [
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
        missionNamespace setVariable [_x select 0, ["ACE", _x select 0] call (_typeFunctions select (_x select 1))];
    } foreach _rawVariables;
};


hull_settings_fnc_setNonStandardAceSettings = {
    if (!(["ACE", "ace_sys_eject_fnc_weaponCheckEnabled"] call hull_config_fnc_getBool)) then {
        ace_sys_eject_fnc_weaponCheckEnabled = {false};
    };
    if (!(["ACE", "ace_sys_rotoreffects_fnc_rocko_manshred"] call hull_config_fnc_getBool)) then {
        ace_sys_rotoreffects_fnc_rocko_manshred = {};
    };
};

hull_settings_fnc_setNonStandardGeneralSettings = {
    if (!(["General", "enableSaving"] call hull_config_fnc_getBool)) then {
        enableSaving [false, false];
    };
};

hull_settings_fnc_setPlayerSettings = {
    player setVariable ["ace_sys_wounds_no_medical_gear", ["ACE", "ace_sys_wounds_no_medical_gear"] call hull_config_fnc_getBool];
    player addRating (["General", "addRating"] call hull_config_fnc_getNumber);
    player setVariable ["BIS_noCoreConversations", ["General", "BIS_noCoreConversations"] call hull_config_fnc_getBool];
};

hull_settings_fnc_setModuleVariables = {
    if (isNil {hull_marker_isGroupEnabled}) then {hull_marker_isGroupEnabled = ["Marker", "isGroupEnabled"] call hull_config_fnc_getBool;};
    if (isNil {hull_marker_isFireTeamEnabled}) then {hull_marker_isFireTeamEnabled = ["Marker", "isFireTeamEnabled"] call hull_config_fnc_getBool;};
};
