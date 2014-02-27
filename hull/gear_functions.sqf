#include "hull_macros.h"

parsingNamespace setVariable ["hull_gear_fnc_assign", {
    FUN_ARGS_3(_unit,_class,_manualTemplate);

    if (!([_unit, _class, _manualTemplate] call PNS_GVAR(hull_gear_fnc_validateTemplate))) then {
        private "_template";
        _template = [faction _unit, _manualTemplate] call PNS_GVAR(hull_gear_fnc_getTemplate);
        [_unit] call PNS_GVAR(hull_gear_fnc_assignInit);
        [_unit, _class, _template] call PNS_GVAR(hull_gear_fnc_assignTemplate);
    };
}];

parsingNamespace setVariable ["hull_gear_fnc_assignInit", {
    removeAllWeapons _unit;
    removeBackpack _unit;
    _unit setVariable ["ace_sys_wounds_no_medical_gear", true];
    _unit addWeapon "ACE_Earplugs";
}];

parsingNamespace setVariable ["hull_gear_fnc_getTemplate", {
    FUN_ARGS_2(_faction,_manualTemplate);

    private "_template";
    _template = _manualTemplate;
    if (isNil {_template} || {!isClass (missionConfigFile >> _manualTemplate)}) then {
        _template = [_faction] call PNS_GVAR(hull_gear_fnc_getTemplateByFaction);
    };

    _template;
}];

parsingNamespace setVariable ["hull_gear_fnc_getTemplateByFaction", {
    FUN_ARGS_1(_faction);

    private ["_factions", "_template"];
    _factions = getArray (missionConfigFile >> "FactionMapping" >> "factions");
    {
        if (toLower (_x select 0) == toLower _faction) exitWith {
            _template = _x select 1;
        };
    } foreach _factions;

    _template;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignTemplate", {
    FUN_ARGS_3(_unit,_class,_template);

    private "_config";
    _config = missionConfigFile >> _template >> _class;
    if (!isClass _config) then {
        _config = missionConfigFile >> _template >> "Rifleman";
    };
    [_unit, getText (_config >> "ruck")] call PNS_GVAR(hull_gear_fnc_assignRuck);
    [_unit, getArray (_config >> "magazines")] call PNS_GVAR(hull_gear_fnc_assignMagazines);
    [_unit, getArray (_config >> "weapons")] call PNS_GVAR(hull_gear_fnc_assignWeapons);
    [_unit, getArray (_config >> "ruckWeapons")] call PNS_GVAR(hull_gear_fnc_assignRuckWeapons);
    [_unit, getArray (_config >> "ruckMagazines")] call PNS_GVAR(hull_gear_fnc_assignRuckMagazines);
    [_unit, getArray (_config >> "items")] call PNS_GVAR(hull_gear_fnc_assignNonRadioItems);
    [_unit, getArray (_config >> "items")] spawn PNS_GVAR(hull_gear_fnc_assignRadios);
    [_unit, getArray (_config >> "ifak")] call PNS_GVAR(hull_gear_fnc_assignIFAK);
    [_unit, _class, _template] call compile getText (_config >> "code");
    _unit selectWeapon primaryWeapon _unit;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignRuck", {
    FUN_ARGS_2(_unit,_ruck);

    _unit addWeapon _ruck;
    [_unit, _ruck] call ACE_fnc_PutWeaponOnBack;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignMagazines", {
    FUN_ARGS_2(_unit,_magazines);

    {
        for "_i" from 1 to (_x select 1) do {
            _unit addMagazine (_x select 0);
        };
    } foreach _magazines;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignWeapons", {
    FUN_ARGS_2(_unit,_weapons);

    {
        _unit addWeapon _x;
    } foreach _weapons;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignRuckWeapons", {
    FUN_ARGS_2(_unit,_ruckWeapons);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackWeapon;
    } foreach _ruckWeapons;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignRuckMagazines", {
    FUN_ARGS_2(_unit,_ruckMagazines);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackMagazine;
    } foreach _ruckMagazines;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignNonRadioItems", {
    FUN_ARGS_2(_unit,_items);

    {
        if (!([_x] call acre_api_fnc_isRadio)) then {
            _unit addWeapon _x;
        };
    } foreach _items;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignRadios", {
    FUN_ARGS_2(_unit,_items);

    waitUntil {
        hull_acre_isInitialized;
    };
    [_unit] call PNS_GVAR(hull_gear_fnc_removeRadios);
    {
        _unit addWeapon _x;
    } foreach ([_items] call PNS_GVAR(hull_gear_fnc_getRadios));

}];

parsingNamespace setVariable ["hull_gear_fnc_removeRadios", {
    FUN_ARGS_1(_unit);

    {
        if (_x == "ItemRadio" || {[_x] call acre_api_fnc_isRadio}) then {
            _unit removeWeapon _x;
        };
    } foreach (weapons _unit);
}];

parsingNamespace setVariable ["hull_gear_fnc_getRadios", {
    FUN_ARGS_1(_items);

    private "_radios";
    _radios = [];
    {
        if ([_x] call acre_api_fnc_isRadio) then {
            PUSH(_radios,_x);
        };
    } foreach _items;

    _radios;
}];

parsingNamespace setVariable ["hull_gear_fnc_assignIFAK", {
    FUN_ARGS_2(_unit,_ifak);

    [_unit, _ifak select 0, _ifak select 1, _ifak select 2] call ACE_fnc_PackIFAK;
}];

parsingNamespace setVariable ["hull_gear_fnc_validateTemplate", {
    FUN_ARGS_3(_unit,_class,_manualTemplate);

    private ["_error", "_factionTemplate", "_template", "_config", "_fields"];
    _error = false;
    _factionTemplate = [faction _unit] call PNS_GVAR(hull_gear_fnc_getTemplateByFaction);
    if (!isNil {_manualTemplate} && {!isClass (missionConfigFile >> _manualTemplate)}) then {
        diag_log format ["[GEAR - WARN]: No gear template found with name '%1', using '%2' faction default '%3' instead!", _manualTemplate, faction _unit, _factionTemplate];
    };

    if (isNil {_factionTemplate}) then {
        diag_log format ["[GEAR - WARN]: No gear template found for faction '%1'!", faction _unit];
        _error = true;
    };

    _template = [faction _unit, _manualTemplate] call PNS_GVAR(hull_gear_fnc_getTemplate);
    if (!_error && {!isClass (missionConfigFile >> _template >> _class)}) then {
        diag_log format ["[GEAR - WARN]: Class '%1' not found in gear template '%2', on unit '%3'! Using defalut 'Rifleman' instead.", _class, _template, _unit];
        _class = "Rifleman";
    };
    if (!_error && {!isClass (missionConfigFile >> _template >> _class)}) then {
        diag_log format ["[GEAR - ERROR]: Default class '%1' not found in gear template '%2'!", _class, _template];
        _error = true;
    };

    _config = missionConfigFile >> _template >> _class;
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
            diag_log format ["[GEAR - ERROR]: Field '%1' not found in template '%2' and in class '%3'!", _field, _template, _class];
            _error = true;
        };
    } foreach _fields;

    _error;
}];

/*
parsingNamespace setVariable ["hull_gear_fnc_cleanUp", {
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
}];
/*