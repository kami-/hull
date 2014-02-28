#include "hull_macros.h"

hull_common_fnc_unitInit = {
    FUN_ARGS_3(_unit,_gearConfig,_markerConfig);

    if (local _unit) then {
        [_unit, _gearConfig select 0, _gearConfig select 1] call hull_gear_fnc_assign;
    };
    if (!isNil {_markerConfig} && {isServer || {!isDedicated}}) then {
        [_unit,_gearConfig,_markerConfig] spawn hull_common_fnc_tryAddGroupMarker;
    };
};

hull_common_fnc_tryAddGroupMarker = {
    FUN_ARGS_3(_unit,_gearConfig,_markerConfig);
    
    waitUntil {
        !isNull player;
    };
    if (side player == side _unit) then {
        [_unit, _gearConfig select 0, _markerConfig select 0, _markerConfig select 1] call hull_marker_fnc_addMarker;
    };
};

hull_common_fnc_tryAddFireTeamMarkers = {
    if (isServer || {!isDedicated}) then {
        waitUntil {
            !isNull player;
        };
        [player] call hull_marker_fnc_addFireTeamMarkers;
    };
};