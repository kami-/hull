#include "hull_macros.h"

//#include "\userconfig\hull\log\gc.h"
#include "logbook.h"


hull_gc_fnc_preInit = {
    hull_gc_corpseManagerMode = [missionConfigFile, "corpseManagerMode"] call hull_config_fnc_getCustomNumber;
    hull_gc_corpseLimit = [missionConfigFile, "corpseLimit"] call hull_config_fnc_getCustomNumber;
    hull_gc_corpseRemovalMinTime = [missionConfigFile, "corpseRemovalMinTime"] call hull_config_fnc_getCustomNumber;
    hull_gc_corpseRemovalMaxTime = [missionConfigFile, "corpseRemovalMaxTime"] call hull_config_fnc_getCustomNumber;
    hull_gc_wreckManagerMode = [missionConfigFile, "wreckManagerMode"] call hull_config_fnc_getCustomNumber;
    hull_gc_wreckLimit = [missionConfigFile, "wreckLimit"] call hull_config_fnc_getCustomNumber;
    hull_gc_wreckRemovalMinTime = [missionConfigFile, "wreckRemovalMinTime"] call hull_config_fnc_getCustomNumber;
    hull_gc_wreckRemovalMaxTime = [missionConfigFile, "wreckRemovalMaxTime"] call hull_config_fnc_getCustomNumber;
};

hull_gc_fnc_postInit = {
    [] spawn hull_gc_fnc_monitorCorpses;
    [] spawn hull_gc_fnc_monitorWrecks;
};

hull_gc_fnc_monitorCorpses = {
    while {hull_gc_corpseManagerMode == 1} do {
        DEBUG("hull.gc","Starting next Corpse GC check.");
        [hull_gc_corpseLimit, hull_gc_corpseRemovalMinTime, hull_gc_corpseRemovalMaxTime, {_x isKindOf "Man"}] call hull_gc_fnc_tryRemovingObjects;
        sleep hull_gc_corpseRemovalMinTime;
    };
};

hull_gc_fnc_monitorWrecks = {
    while {hull_gc_wreckManagerMode == 1} do {
        DEBUG("hull.gc","Starting next Wreck GC check.");
        [hull_gc_wreckLimit, hull_gc_wreckRemovalMinTime, hull_gc_wreckRemovalMaxTime, {!(_x isKindOf "Man")}] call hull_gc_fnc_tryRemovingObjects;
        sleep hull_gc_wreckRemovalMinTime;
    };
};

hull_gc_fnc_tryRemovingObjects = {
    FUN_ARGS_4(_limit,_minTime,_maxTime,_isKindOfFunc);

    DECLARE(_objects) = [];
    FILTER_PUSH_ALL(_objects,allDead,_isKindOfFunc);
    DEBUG("hull.gc",FMT_1("Removable objects '%1'.",_objects));
    if (count _objects > _limit) then {
        {
            _x setVariable ["hull_gc_lastCheck", time, false];
            if ([_x, _minTime, _maxTime] call hull_gc_fnc_canRemoveObject) then {
                DEBUG("hull.gc",FMT_1("Removing object '%1'.",_x));
                deleteVehicle _x;
            };
        } foreach _objects;
    };
};

hull_gc_fnc_canRemoveObject = {
    FUN_ARGS_3(_object,_minTime,_maxTime);

    private ["_canRemove", "_timeSinceLastCheck"];
    _canRemove = _object getVariable ["hull_gc_canRemove", true];
    _timeSinceLastCheck = (_object getVariable ["hull_gc_lastCheck", time]) - _minTime;

    _canRemove && {_timeSinceLastCheck >= _minTime || {_timeSinceLastCheck + _minTime >= _maxTime}};
};