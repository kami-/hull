#include "hull_macros.h"

#define GEAR_CONFIG                         HULL_CONFIGFILE >> "Gear"
#define GEAR_TEMPLATE_BASE_CLASS            "Rifleman"



hull_gear_fnc_assign = {
    FUN_ARGS_3(_unit,_manualClass,_manualTemplate);

    if (!([_unit, _manualClass, _manualTemplate] call hull_gear_fnc_validateTemplate)) then {
        private ["_template", "_class"];
        _template = [faction _unit, _manualTemplate] call hull_gear_fnc_getTemplate;
        _class = [_template, _manualClass] call hull_gear_fnc_getClass;
        [_unit, _class, _template] call hull_gear_fnc_assignInit;
        [_unit, _class, _template] call hull_gear_fnc_assignTemplate;
    };
};

hull_gear_fnc_assignInit = {
    FUN_ARGS_3(_unit,_class,_template);

    _unit setVariable ["hull_gear_class", _class, true];
    _unit setVariable ["hull_gear_template", _template, true];
    removeAllWeapons _unit;
    removeBackpack _unit;
    _unit setVariable ["ace_sys_wounds_no_medical_gear", true, false];
    TRY_ADD_WEAPON(_unit,"ACE_Earplugs");
};

hull_gear_fnc_getTemplate = {
    FUN_ARGS_2(_faction,_manualTemplate);

    private "_template";
    _template = _manualTemplate;
    if (isNil {_template} || {!isClass (GEAR_CONFIG >> _manualTemplate)}) then {
        _template = [_faction] call hull_gear_fnc_getTemplateByFaction;
    };

    _template;
};

hull_gear_fnc_getClass = {
    FUN_ARGS_2(_template,_manualClass);

    if (!isClass (GEAR_CONFIG >> _template >> _manualClass)) then {
        GEAR_TEMPLATE_BASE_CLASS;
    } else {
        _manualClass;
    };
};

hull_gear_fnc_getTemplateByFaction = {
    FUN_ARGS_1(_faction);

    private ["_factions", "_template"];
    _factions = getArray (GEAR_CONFIG >> "factions");
    {
        if (toLower (_x select 0) == toLower _faction) exitWith {
            _template = _x select 1;
        };
    } foreach _factions;

    _template;
};

hull_gear_fnc_assignTemplate = {
    FUN_ARGS_3(_unit,_class,_template);

    private "_config";
    _config = GEAR_CONFIG >> _template >> _class;
    [_unit, getText (_config >> "ruck")] call hull_gear_fnc_assignRuck;
    [_unit, getArray (_config >> "magazines")] call hull_gear_fnc_assignMagazines;
    [_unit, getArray (_config >> "weapons")] call hull_gear_fnc_assignWeapons;
    [_unit, getArray (_config >> "ruckWeapons")] call hull_gear_fnc_assignRuckWeapons;
    [_unit, getArray (_config >> "ruckMagazines")] call hull_gear_fnc_assignRuckMagazines;
    [_unit, getArray (_config >> "items")] call hull_gear_fnc_assignNonRadioItems;
    [_unit, getArray (_config >> "ifak")] call hull_gear_fnc_assignIFAK;
    [_unit, _class, _template] call compile getText (_config >> "code");
    _unit selectWeapon primaryWeapon _unit;
};

hull_gear_fnc_assignRuck = {
    FUN_ARGS_2(_unit,_ruck);

    _unit addWeapon _ruck;
    [_unit, _ruck] call ACE_fnc_PutWeaponOnBack;
};

hull_gear_fnc_assignMagazines = {
    FUN_ARGS_2(_unit,_magazines);

    {
        for "_i" from 1 to (_x select 1) do {
            _unit addMagazine (_x select 0);
        };
    } foreach _magazines;
};

hull_gear_fnc_assignWeapons = {
    FUN_ARGS_2(_unit,_weapons);

    {
        _unit addWeapon _x;
    } foreach _weapons;
};

hull_gear_fnc_assignRuckWeapons = {
    FUN_ARGS_2(_unit,_ruckWeapons);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackWeapon;
    } foreach _ruckWeapons;
    _unit setVariable ["ACE_RuckWepContents", _unit getVariable ["ACE_RuckWepContents", []], true];
};

hull_gear_fnc_assignRuckMagazines = {
    FUN_ARGS_2(_unit,_ruckMagazines);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackMagazine;
    } foreach _ruckMagazines;
    _unit setVariable ["ACE_RuckMagContents", _unit getVariable ["ACE_RuckMagContents", []], true];
};

hull_gear_fnc_assignNonRadioItems = {
    FUN_ARGS_2(_unit,_items);

    {
        if (!([_x] call acre_api_fnc_isRadio)) then {
            TRY_ADD_WEAPON(_unit,_x);
        };
    } foreach _items;
};

hull_gear_fnc_tryAssignRadios = {
    FUN_ARGS_1(_unit);

    private ["_gearClass", "_gearTemplate"];
    _gearClass = _unit getVariable "hull_gear_class";
    _gearTemplate = _unit getVariable "hull_gear_template";
    if (!isNil {_gearClass} && {!isNil {_gearTemplate}}) then {
        [_unit, getArray (GEAR_CONFIG >> _gearTemplate >> _gearClass >> "items")] spawn hull_gear_fnc_assignRadios;
    } else {
        diag_log LOG_MSG_3("ERROR", "Gear - No gear template ('%1') or class ('%2') was found for unit '%3'!", _gearTemplate, _gearClass, _unit);
    };
};

hull_gear_fnc_assignRadios = {
    FUN_ARGS_2(_unit,_items);

    waitUntil {
        hull_acre_isInitialized;
    };
    [_unit] call hull_gear_fnc_removeRadios;
    {
        _unit addWeapon _x;
    } foreach ([_items] call hull_gear_fnc_getRadios);
};

hull_gear_fnc_removeRadios = {
    FUN_ARGS_1(_unit);

    {
        if (_x == "ItemRadio" || {[_x] call acre_api_fnc_isRadio}) then {
            _unit removeWeapon _x;
        };
    } foreach (weapons _unit);
};

hull_gear_fnc_getRadios = {
    FUN_ARGS_1(_items);

    private "_radios";
    _radios = [];
    {
        if ([_x] call acre_api_fnc_isRadio) then {
            PUSH(_radios,_x);
        };
    } foreach _items;

    _radios;
};

hull_gear_fnc_assignIFAK = {
    FUN_ARGS_2(_unit,_ifak);

    [_unit, _ifak select 0, _ifak select 1, _ifak select 2, true] call ACE_fnc_PackIFAK;
    _unit setVariable ["ACE_IFAK_Contents", _unit getVariable ["ACE_IFAK_Contents", [0,0,0]], true];
};

hull_gear_fnc_validateTemplate = {
    FUN_ARGS_3(_unit,_manualClass,_manualTemplate);

    private ["_error", "_factionTemplate", "_template", "_config", "_fields"];
    _error = false;
    _factionTemplate = [faction _unit] call hull_gear_fnc_getTemplateByFaction;
    if (!isNil {_manualTemplate} && {!isClass (GEAR_CONFIG >> _manualTemplate)}) then {
        diag_log LOG_MSG_3("WARN", "Gear - No gear template found with name '%1', using '%2' faction default '%3' instead!", _manualTemplate, faction _unit, _factionTemplate);
    };

    if (isNil {_factionTemplate}) then {
        diag_log LOG_MSG_1("WARN", "Gear - No gear template found for faction '%1'!", faction _unit);
        _error = true;
    };

    _template = [faction _unit, _manualTemplate] call hull_gear_fnc_getTemplate;
    if (!_error && {!isClass (GEAR_CONFIG >> _template >> _manualClass)}) then {
        diag_log LOG_MSG_3("WARN", "Gear - Class '%1' not found in gear template '%2', on unit '%3'! Using defalut 'Rifleman' instead.", _manualClass, _template, _unit);
        _manualClass = "Rifleman";
    };
    if (!_error && {!isClass (GEAR_CONFIG >> _template >> _manualClass)}) then {
        diag_log LOG_MSG_2("ERROR", "Gear - Default class '%1' not found in gear template '%2'!", _manualClass, _template);
        _error = true;
    };

    _config = GEAR_CONFIG >> _template >> _manualClass;
    _fields = [
        ["ruck", {isText (_config >> _field)}],
        ["magazines", {isArray (_config >> _field)}],
        ["weapons", {isArray (_config >> _field)}],
        ["ruckWeapons", {isArray (_config >> _field)}],
        ["ruckMagazines", {isArray (_config >> _field)}],
        ["items", {isArray (_config >> _field)}],
        ["ifak", {isArray (_config >> _field)}],
        ["code", {isText (_config >> _field)}]
    ];
    {
        private "_field";
        _field = _x select 0;
        if (!_error && {!call (_x select 1)}) then {
            diag_log LOG_MSG_3("ERROR", "Gear - Field '%1' not found in template '%2' and in class '%3'!", _field, _template, _manualClass);
            _error = true;
        };
    } foreach _fields;

    _error;
};

/*
hull_gear_fnc_cleanUp = {
    _globalVars = [
        hull_gear_fnc_assign, hull_gear_fnc_assignInit, hull_gear_fnc_getTemplate,
        hull_gear_fnc_getTemplateByFaction, hull_gear_fnc_assignTemplate, hull_gear_fnc_assignRuck,
        hull_gear_fnc_assignMagazines, hull_gear_fnc_assignWeapons, hull_gear_fnc_assignRuckWeapons,
        hull_gear_fnc_assignRuckMagazines, hull_gear_fnc_assignItems, hull_gear_fnc_assignIFAK,
        hull_gear_fnc_validateTemplate
    ];
    {
        _x = nil;
    } foreach _globalVars;
};
/*