#include "hull_macros.h"

#define LOGGING_LEVEL_WARN
#define LOGGING_TO_RPT
#include "logbook.h"

hull_gear_fnc_preInit = {
    hull_gear_unitBaseClass = ["Gear", "unitBaseClass"] call hull_config_fnc_getText;
    hull_gear_vehicleBaseClass = ["Gear", "vehicleBaseClass"] call hull_config_fnc_getText;
    [] call hull_gear_fnc_addEventHandlers;
};

hull_gear_fnc_addEventHandlers = {
    ["acre.initialized", hull_gear_fnc_tryAssignRadios] call hull_event_fnc_addEventHandler;
};

hull_gear_fnc_assign = {
    FUN_ARGS_3(_unit,_manualClass,_manualTemplate);

    if (_unit isKindOf "CAManBase") then {
        [
            _unit, _manualClass, _manualTemplate, GEAR_UNIT_FIELDS,
            hull_gear_unitBaseClass, hull_gear_fnc_assignUnitInit, hull_gear_fnc_assignUnitTemplate
        ] call hull_gear_fnc_assignByType;
    } else {
        [
            _unit, _manualClass, _manualTemplate, GEAR_VEHICLE_FIELDS,
            hull_gear_vehicleBaseClass, hull_gear_fnc_assignVehicleInit, hull_gear_fnc_assignVehicleTemplate
        ] call hull_gear_fnc_assignByType;
    };
};

hull_gear_fnc_assignByType = {
    FUN_ARGS_7(_unit,_manualClass,_manualTemplate,_fields,_baseClass,_initFunc,_assignFunc);

    if (!([_unit, _manualClass, _manualTemplate, _baseClass, _fields] call hull_gear_fnc_validateTemplate)) then {
        private ["_template", "_class"];
        _template = [faction _unit, _manualTemplate] call hull_gear_fnc_getTemplate;
        _class = [_template, _manualClass, _baseClass] call hull_gear_fnc_getClass;
        [_unit, _class, _template] call _initFunc;
        [_unit, _class, _template] call _assignFunc;
    };
    ["gear.assigned", [_unit]] call hull_event_fnc_emitEvent;
};

hull_gear_fnc_assignUnitInit = {
    FUN_ARGS_3(_unit,_class,_template);

    _unit setVariable ["hull_gear_class", _class, true];
    _unit setVariable ["hull_gear_template", _template, true];
    removeAllWeapons _unit;
    removeBackpack _unit;
    _unit setVariable ["ace_sys_wounds_no_medical_gear", true, false];
    TRY_ADD_WEAPON(_unit,"ACE_Earplugs");
};

hull_gear_fnc_assignVehicleInit = {
    FUN_ARGS_1(_vehicle);

    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
};

hull_gear_fnc_getTemplate = {
    FUN_ARGS_2(_faction,_manualTemplate);

    private "_template";
    _template = _manualTemplate;
    if (isNil {_template} || {!isClass (["Gear", _manualTemplate] call hull_config_fnc_getConfig)}) then {
        _template = [_faction] call hull_gear_fnc_getTemplateByFaction;
    };

    _template;
};

hull_gear_fnc_getClass = {
    FUN_ARGS_3(_template,_manualClass,_baseClass);

    if (!isClass (["Gear", _template, _manualClass] call hull_config_fnc_getConfig)) then {
        _baseClass;
    } else {
        _manualClass;
    };
};

hull_gear_fnc_getTemplateByFaction = {
    FUN_ARGS_1(_faction);

    private ["_factions", "_template", "_isFound"];
    _factions = getArray (HULL_MISSION_CONFIG_FILE >> "Gear" >> "factions");
    PUSH_ALL(_factions,getArray (HULL_CONFIG_FILE >> "Gear" >> "factions"));
    _isFound = false;
    {
        if (toLower (_x select 0) == toLower _faction) exitWith {
            _template = _x select 1;
        };
    } foreach _factions;

    _template;
};

hull_gear_fnc_assignUnitTemplate = {
    FUN_ARGS_3(_unit,_class,_template);

    private "_config";
    _config = ["Gear", _template, _class] call hull_config_fnc_getConfig;
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

hull_gear_fnc_assignVehicleTemplate = {
    FUN_ARGS_3(_vehicle,_class,_template);

    private "_config";
    _config = ["Gear", _template, _class] call hull_config_fnc_getConfig;
    [_vehicle, getArray (_config >> "magazines")] call hull_gear_fnc_assignVehicleMagazines;
    [_vehicle, getArray (_config >> "weapons")] call hull_gear_fnc_assignVehicleWeapons;
    [_vehicle, getArray (_config >> "items")] call hull_gear_fnc_assignVehicleWeapons;
    [_vehicle, _class, _template] call compile getText (_config >> "code");
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

hull_gear_fnc_assignVehicleMagazines = {
    FUN_ARGS_2(_unit,_magazines);

    {
        _vehicle addMagazineCargoGlobal _x;
    } foreach _magazines;
};

hull_gear_fnc_assignWeapons = {
    FUN_ARGS_2(_unit,_weapons);

    {
        _unit addWeapon _x;
    } foreach _weapons;
};

hull_gear_fnc_assignVehicleWeapons = {
    FUN_ARGS_2(_unit,_weapons);

    {
        _vehicle addWeaponCargoGlobal _x;
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
        [_unit, ["Gear", _gearTemplate, _gearClass, "items"] call hull_config_fnc_getArray] call hull_gear_fnc_assignRadios;
    };
    ["gear.radio.assigned", [_unit]] call hull_event_fnc_emitEvent;
};

hull_gear_fnc_assignRadios = {
    FUN_ARGS_2(_unit,_items);

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
    FUN_ARGS_5(_unit,_manualClass,_manualTemplate,_baseClass,_fields);

    private ["_error", "_factionTemplate", "_template", "_config"];
    _error = false;
    _factionTemplate = [faction _unit] call hull_gear_fnc_getTemplateByFaction;
    if (!isNil {_manualTemplate} && {!isClass (["Gear", _manualTemplate] call hull_config_fnc_getConfig)}) then {
        WARN("hull.gear.validate",FMT_3("No gear template found with name '%1', using '%2' faction default '%3' instead!",_manualTemplate,faction _unit,_factionTemplate));
    };

    if (isNil {_factionTemplate}) then {
        WARN("hull.gear.validate",FMT_1("No gear template found for faction '%1'!",faction _unit));
        _error = true;
    };

    _template = [faction _unit, _manualTemplate] call hull_gear_fnc_getTemplate;
    if (!_error && {!isClass (["Gear", _template, _manualClass] call hull_config_fnc_getConfig)}) then {
        WARN("hull.gear.validate",FMT_4("Class '%1' not found in gear template '%2', on unit '%3'! Using defalut '%4' instead.",_manualClass,_template,_unit,_baseClass));
        _manualClass = _baseClass;
    };
    if (!_error && {!isClass (["Gear", _template, _manualClass] call hull_config_fnc_getConfig)}) then {
        ERROR("hull.gear.validate",FMT_2("Default class '%1' not found in gear template '%2'!",_manualClass,_template));
        _error = true;
    };

    _config = ["Gear", _template, _manualClass] call hull_config_fnc_getConfig;
    {
        private "_field";
        _field = _x select 0;
        if (!_error && {!call (_x select 1)}) then {
            ERROR("hull.gear.validate",FMT_3("Field '%1' not found in template '%2' and in class '%3'!",_field,_template,_manualClass));
            _error = true;
        };
    } foreach _fields;

    _error;
};