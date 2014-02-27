#include "hull_macros.h"

parsingNamespace setVariable ["hull_common_fnc_unitInit", {
    FUN_ARGS_3(_unit,_gearConfig,_markerConfig);

    if (local _unit) then {
        [_unit, _gearConfig select 0, _gearConfig select 1] call PNS_GVAR(hull_gear_fnc_assign);
    };
    if (!isNil {_markerConfig} && {isServer || {!isDedicated}}) then {
        [_unit,_gearConfig,_markerConfig] spawn PNS_GVAR(hull_common_fnc_tryAddGroupMarker);
    };
}];

parsingNamespace setVariable ["hull_common_fnc_tryAddGroupMarker", {
    FUN_ARGS_3(_unit,_gearConfig,_markerConfig);
    
    waitUntil {
        !isNull player;
    };
    if (side player == side _unit) then {
        [_unit, _gearConfig select 0, _markerConfig select 0, _markerConfig select 1] call PNS_GVAR(hull_marker_fnc_addMarker);
    };
}];

parsingNamespace setVariable ["hull_common_fnc_tryAddFireTeamMarkers", {
    if (isServer || {!isDedicated}) then {
        waitUntil {
            !isNull player;
        };
        [player] call PNS_GVAR(hull_marker_fnc_addFireTeamMarkers);
    };
}];

hull_common_fnc_unitInit = PNS_GVAR(hull_common_fnc_unitInit);