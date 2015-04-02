#include "hull_macros.h"

//#include "\userconfig\hull\log\gc.h"
#include "logbook.h"

#define GC_CAN_REMOVE(UNIT)                 (UNIT getVariable ["hull_gc_canRemove", true])



hull_gc_fnc_preInit = {
    hull_gc_isEnabled = ["GarbageCollector", "isEnabled"] call hull_config_fnc_getBool;
    hull_gc_canRemoveCorpses = ["GarbageCollector", "canRemoveCorpses"] call hull_config_fnc_getBool;
    hull_gc_canRemoveWrecks = ["GarbageCollector", "canRemoveWrecks"] call hull_config_fnc_getBool;
    hull_gc_canRemoveGroups = ["GarbageCollector", "canRemoveGroups"] call hull_config_fnc_getBool;
    hull_gc_corpseLimit = ["GarbageCollector", "corpseLimit"] call hull_config_fnc_getNumber;
    hull_gc_corpseMaxTime = ["GarbageCollector", "corpseMaxTime"] call hull_config_fnc_getNumber;
    hull_gc_wreckLimit = ["GarbageCollector", "wreckLimit"] call hull_config_fnc_getNumber;
    hull_gc_wreckMaxTime = ["GarbageCollector", "wreckMaxTime"] call hull_config_fnc_getNumber;
    hull_gc_groupMaxTime = ["GarbageCollector", "groupMaxTime"] call hull_config_fnc_getNumber;
    hull_gc_maxTimeModifier = ["GarbageCollector", "maxTimeModifier"] call hull_config_fnc_getNumber;
};

hull_gc_fnc_start = {
    {
        _x setVariable ["hull_gc_canRemove", false];
    } foreach playableUnits;
    if (hull_gc_isEnabled) then {
        hull_gc_canRemoveCorpses = true;
        hull_gc_canRemoveWrecks = true;
        hull_gc_canRemoveGroups = true;
        [] spawn hull_gc_fnc_monitorCorpses;
        [] spawn hull_gc_fnc_monitorWrecks;
        [] spawn hull_gc_fnc_monitorGroups;
    };
};

hull_gc_fnc_stop = {
    hull_gc_canRemoveCorpses = false;
    hull_gc_canRemoveWrecks = false;
    hull_gc_canRemoveGroups = false;
};

hull_gc_fnc_monitorCorpses = {
    while {hull_gc_canRemoveCorpses} do {
        DEBUG("hull.gc","Starting next corpse GC check.");
        [hull_gc_corpseLimit, hull_gc_corpseMaxTime, {_x isKindOf "Man"}] call hull_gc_fnc_tryRemovingUnits;
        sleep (hull_gc_corpseMaxTime * hull_gc_maxTimeModifier);
    };
};

hull_gc_fnc_monitorWrecks = {
    while {hull_gc_canRemoveWrecks} do {
        DEBUG("hull.gc","Starting next wreck GC check.");
        [hull_gc_wreckLimit, hull_gc_wreckMaxTime, {!(_x isKindOf "Man")}] call hull_gc_fnc_tryRemovingUnits;
        sleep (hull_gc_wreckMaxTime * hull_gc_maxTimeModifier);
    };
};

hull_gc_fnc_tryRemovingUnits = {
    FUN_ARGS_3(_limit,_maxTime,_isKindOfFunc);

    DECLARE(_units) = [];
    FILTER_PUSH_ALL(_units,allDead,{GC_CAN_REMOVE(_x) && _isKindOfFunc});
    DEBUG("hull.gc",FMT_1("'%1' dead units.",{GC_CAN_REMOVE(_x)} count _units));
    if ({GC_CAN_REMOVE(_x)} count _units > _limit) then {
        DEBUG("hull.gc",FMT_1("Limit '%1' reached, starting to remove units.",_limit));
        DECLARE(_removeCount) = 0;
        {
            if (isNil {_x getVariable "hull_gc_firstCheck"}) then {
                _x setVariable ["hull_gc_firstCheck", time, false];
                TRACE("hull.gc",FMT_2("Setting 'firstCheck' of unit '%1' to '%2'.",_x,time));
            };
            if ([_x, _maxTime] call hull_gc_fnc_canRemoveUnit) then {
                TRACE("hull.gc",FMT_1("Removing unit '%1'.",_x));
                deleteVehicle _x;
                INC(_removeCount);
            };
        } foreach _units;
        DEBUG("hull.gc",FMT_1("Removed '%1' units.",_removeCount));
    };
};

hull_gc_fnc_canRemoveUnit = {
    FUN_ARGS_2(_unit,_maxTime);

    private ["_canRemove", "_timeSinceFirstCheck"];
    _canRemove = GC_CAN_REMOVE(_unit);
    _timePassed = time - (_unit getVariable ["hull_gc_firstCheck", time]);

    _canRemove && {_timePassed >= _maxTime};
};

hull_gc_fnc_monitorGroups = {
    while {hull_gc_canRemoveGroups} do {
        private ["_removeCount", "_remoteGroups"];
        DEBUG("hull.gc","Starting next group GC check.");
        _remoteGroups = [];
        _removeCount = 0;
        {
            if (count units _x == 0) then {
                // TODO local on groups only work in A3
                PUSH(_remoteGroups,_x);
                INC(_removeCount);
                if (!isNull _x) then {
                    deleteGroup _x;
                };
            };
        } foreach allGroups;
        DEBUG("hull.gc",FMT_2("Removing total '%1' groups of which '%2' are remote.",_removeCount,count _remoteGroups));
        [_remoteGroups] call hull_gc_fnc_removeRemoteGroups;
        sleep (hull_gc_groupMaxTime * hull_gc_maxTimeModifier);
    };
};

hull_gc_fnc_removeRemoteGroups = {
    FUN_ARGS_1(_groups);

    [-1, {
        {
            // TODO local on groups only work in A3
            if (!isNull _x) then {
                deleteGroup _x;
            };
        } foreach _this;
    }, _groups] call CBA_fnc_globalExecute;
};