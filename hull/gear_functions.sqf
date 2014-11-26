#include "hull_macros.h"

#include "\userconfig\hull\log\gear.h"
#include "logbook.h"


hull_gear_fnc_preInit = {
    hull_gear_unitBaseClass = ["Gear", "unitBaseClass"] call hull_config_fnc_getText;
    hull_gear_vehicleBaseClass = ["Gear", "vehicleBaseClass"] call hull_config_fnc_getText;
    [] call hull_gear_fnc_addEventHandlers;
    DEBUG("hull.gear","Gear functions preInit finished.");
};

hull_gear_fnc_addEventHandlers = {
    ["acre.initialized", hull_gear_fnc_tryAssignRadios] call hull_event_fnc_addEventHandler;
};

hull_gear_fnc_assign = {
    FUN_ARGS_3(_unit,_manualClass,_manualTemplateOrFaction);

    if (_unit isKindOf "CAManBase") then {
        [
            _unit, _manualClass, _manualTemplateOrFaction, GEAR_UNIT_FIELDS,
            hull_gear_unitBaseClass, hull_gear_fnc_assignUnitInit, hull_gear_fnc_assignUnitTemplate
        ] call hull_gear_fnc_assignByType;
    } else {
        [
            _unit, _manualClass, [faction _unit, _manualTemplateOrFaction] call hull_gear_fnc_getVehicleTemplate, GEAR_VEHICLE_FIELDS,
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
    DEBUG("hull.gear.assign",FMT_1("Initialized unit '%1' gear.",_unit));
};

hull_gear_fnc_assignVehicleInit = {
    FUN_ARGS_1(_vehicle);

    clearMagazineCargoGlobal _vehicle;
    clearWeaponCargoGlobal _vehicle;
    DEBUG("hull.gear.assign",FMT_1("Initialized vehicle '%1' gear.",_vehicle));
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

hull_gear_fnc_getVehicleTemplate = {
    FUN_ARGS_2(_faction,_manualTemplateOrFaction);

    DECLARE(_template) = [_manualTemplateOrFaction] call hull_gear_fnc_getTemplateByFaction;
    if (isNil {_template}) then {
        _template = [_faction, _manualTemplateOrFaction] call hull_gear_fnc_getTemplate;
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

    DECLARE(_assignables) = [
        ["ruck",            CONFIG_TYPE_TEXT,   hull_gear_fnc_assignRuck],
        ["magazines",       CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignMagazines],
        ["weapons",         CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignWeapons],
        ["ruckWeapons",     CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignRuckWeapons],
        ["ruckMagazines",   CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignRuckMagazines],
        ["items",           CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignNonRadioItems],
        ["ifak",            CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignIFAK]
    ];
    [_unit, _class, _template, _assignables] call hull_gear_fnc_assignObjectTemplate;
    _unit selectWeapon primaryWeapon _unit;
    DEBUG("hull.gear.assign",FMT_3("Assigned gear class '%1' from template '%2' to unit '%3'.",_class,_template,_unit));
};

hull_gear_fnc_assignVehicleTemplate = {
    FUN_ARGS_3(_vehicle,_class,_template);

    DECLARE(_assignables) = [
        ["magazines",       CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignVehicleMagazines],
        ["weapons",         CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignVehicleWeapons],
        ["items",           CONFIG_TYPE_ARRAY,  hull_gear_fnc_assignVehicleWeapons]
    ];
    [_vehicle, _class, _template, _assignables] call hull_gear_fnc_assignObjectTemplate;
    DEBUG("hull.gear.assign",FMT_3("Assigned gear class '%1' from template '%2' to vehicle '%3'.",_class,_template,_vehicle));
};

hull_gear_fnc_assignObjectTemplate = {
    FUN_ARGS_4(_object,_class,_template,_assignables);

    {
        DECLARE(_configValue) = ["Gear", _template, _class, _x select 0] call (CONFIG_TYPE_FUNCTIONS select (_x select 1));
        [_object, _configValue] call (_x select 2);
    } foreach _assignables;
    [_object, _class, _template] call compile (["Gear", _template, _class, "code"] call hull_config_fnc_getText);
};

hull_gear_fnc_assignRuck = {
    FUN_ARGS_2(_unit,_ruck);

    if (_ruck != "") then {
        _unit addWeapon _ruck;
        [_unit, _ruck] call ACE_fnc_PutWeaponOnBack;
        _unit setVariable ["ACE_RuckWepContents", [], true];
        _unit setVariable ["ACE_RuckMagContents", [], true];
        TRACE("hull.gear.assign",FMT_2("Assigned ruck '%1' to unit '%2'.",_ruck,_unit));
    };
};

hull_gear_fnc_assignMagazines = {
    FUN_ARGS_2(_unit,_magazines);

    {
        for "_i" from 1 to (_x select 1) do {
            _unit addMagazine (_x select 0);
        };
    } foreach _magazines;
    TRACE("hull.gear.assign",FMT_2("Assigned magazines '%1' to unit '%2'.",_magazines,_unit));
};

hull_gear_fnc_assignVehicleMagazines = {
    FUN_ARGS_2(_vehicle,_magazines);

    {
        _vehicle addMagazineCargoGlobal _x;
    } foreach _magazines;
    TRACE("hull.gear.assign",FMT_2("Assigned magazines '%1' to vehicle '%2'.",_magazines,_vehicle));
};

hull_gear_fnc_assignWeapons = {
    FUN_ARGS_2(_unit,_weapons);

    {
        _unit addWeapon _x;
    } foreach _weapons;
    TRACE("hull.gear.assign",FMT_2("Assigned weapons '%1' to unit '%2'.",_weapons,_unit));
};

hull_gear_fnc_assignVehicleWeapons = {
    FUN_ARGS_2(_vehicle,_weapons);

    {
        _vehicle addWeaponCargoGlobal _x;
    } foreach _weapons;
    TRACE("hull.gear.assign",FMT_2("Assigned weapons '%1' to vehicle '%2'.",_weapons,_vehicle));
};

hull_gear_fnc_assignRuckWeapons = {
    FUN_ARGS_2(_unit,_ruckWeapons);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackWeapon;
    } foreach _ruckWeapons;
    TRACE("hull.gear.assign",FMT_2("Assigned ruck weapons '%1' to unit '%2'.",_ruckWeapons,_unit));
    _unit setVariable ["ACE_RuckWepContents", _unit getVariable ["ACE_RuckWepContents", []], true];
    TRACE("hull.gear.assign",FMT_1("Broadcasted unit '%1' ruck weapons to all machines.",_unit));
};

hull_gear_fnc_assignRuckMagazines = {
    FUN_ARGS_2(_unit,_ruckMagazines);

    {
        [_unit, _x select 0, _x select 1] call ACE_fnc_PackMagazine;
    } foreach _ruckMagazines;
    TRACE("hull.gear.assign",FMT_2("Assigned ruck magazines '%1' to unit '%2'.",_ruckMagazines,_unit));
    _unit setVariable ["ACE_RuckMagContents", _unit getVariable ["ACE_RuckMagContents", []], true];
    TRACE("hull.gear.assign",FMT_1("Broadcasted unit '%1' ruck magazines to all machines.",_unit));
};

hull_gear_fnc_assignNonRadioItems = {
    FUN_ARGS_2(_unit,_items);

    {
        if (!([_x] call acre_api_fnc_isRadio)) then {
            TRY_ADD_WEAPON(_unit,_x);
        };
    } foreach _items;
    TRACE("hull.gear.assign",FMT_2("Assigned non-radio items '%1' to unit '%2'.",_items,_unit));
};

hull_gear_fnc_tryAssignRadios = {
    FUN_ARGS_1(_unit);

    private ["_gearClass", "_gearTemplate"];
    _gearClass = _unit getVariable "hull_gear_class";
    _gearTemplate = _unit getVariable "hull_gear_template";
    if (!isNil {_gearClass} && {!isNil {_gearTemplate}}) then {
        [_unit, ["Gear", _gearTemplate, _gearClass, "items"] call hull_config_fnc_getArray] spawn hull_gear_fnc_assignRadios;
    };
};

hull_gear_fnc_assignRadios = {
    FUN_ARGS_2(_unit,_items);

    sleep 1;
    [_unit] call hull_gear_fnc_removeRadios;
    DECLARE(_radios) = [_items] call hull_gear_fnc_getRadios;
    {
        _unit addWeapon _x;
    } foreach _radios;
    TRACE("hull.gear.assign",FMT_2("Assigned radios '%1' to unit '%2'.",[_items] call hull_gear_fnc_getRadios,_unit));
    DEBUG("hull.gear.assign",FMT_1("Assigned radios to unit '%1'.",_unit));
    ["gear.radio.assigned", [_unit]] call hull_event_fnc_emitEvent;
    sleep 30;
    [_unit, _radios] call hull_gear_fnc_removeExtraRadios;
};

hull_gear_fnc_removeRadios = {
    FUN_ARGS_1(_unit);

    {
        if (_x == "ItemRadio" || {[_x] call acre_api_fnc_isRadio}) then {
            _unit removeWeapon _x;
        };
    } foreach (weapons _unit);
    TRACE("hull.gear.assign",FMT_1("Removed radios from unit '%1'.",_unit));
};

hull_gear_fnc_removeExtraRadios = {
    FUN_ARGS_2(_unit,_radios);

    {
        private ["_radio", "_assignedCount", "_currentCount", "_toBeRemovedCount"];
        _radio = _x;
        _assignedCount = {_radio == _x} count _radios;
        _currentCount = {[_x, _radio] call acre_api_fnc_isKindOf} count items _unit;
        _toBeRemovedCount = _currentCount - _assignedCount;
        {
            if ([_x, _radio] call acre_api_fnc_isKindOf) then {
                _unit removeWeapon _x;
                DEC(_toBeRemovedCount);
            };
            if (_toBeRemovedCount <= 0) exitWith {};
        } foreach items _unit;
        if (_currentCount - _assignedCount > 0) then {
            _unit globalChat format ["Hull - Removed '%1' extra '%2' radios. Be sure to recheck '%2' channels!", _currentCount - _assignedCount, _radio];
        };
    } foreach _radios;
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

    _unit setVariable ["ACE_IFAK_Contents", [0,0,0], true];
    [_unit, _ifak select 0, _ifak select 1, _ifak select 2, true] call ACE_fnc_PackIFAK;
    TRACE("hull.gear.assign",FMT_2("Assigned IFAK array '%1' to unit '%2'.",_ifak,_unit));
    _unit setVariable ["ACE_IFAK_Contents", _unit getVariable ["ACE_IFAK_Contents", [0,0,0]], true];
    TRACE("hull.gear.assign",FMT_1("Broadcasted unit '%1' IFAK array to all machines.",_unit));
};

hull_gear_fnc_validateTemplate = {
    FUN_ARGS_5(_unit,_manualClass,_manualTemplate,_baseClass,_fields);

    private ["_error", "_factionTemplate", "_template"];
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
        WARN("hull.gear.validate",FMT_4("Class '%1' not found in gear template '%2', on unit '%3'! Using default '%4' instead.",_manualClass,_template,_unit,_baseClass));
        _manualClass = _baseClass;
    };
    if (!_error && {!isClass (["Gear", _template, _manualClass] call hull_config_fnc_getConfig)}) then {
        ERROR("hull.gear.validate",FMT_2("Default class '%1' not found in gear template '%2'!",_manualClass,_template));
        _error = true;
    };

    {
        DECLARE(_config) = ["Gear", _template, _manualClass, _x select 0] call hull_config_fnc_getConfig;
        if (!_error && {!call (_x select 1)}) then {
            ERROR("hull.gear.validate",FMT_3("Field '%1' not found in template '%2' and in class '%3'!",_field,_template,_manualClass));
            _error = true;
        };
    } foreach _fields;
    DEBUG("hull.gear.validate",FMT_2("There were %1 errors while validating unit '%2'.",if (_error) then {""} else {"no"},_unit));

    _error;
};