#include "hull_macros.h"

hull_common_fnc_unitInit = {
    FUN_ARGS_3(_unit,_gearConfig,_markerConfig);

    if (local _unit) then {
        [_unit, _gearConfig select 0, _gearConfig select 1] call hull_gear_fnc_assign;
    };
    if (!isNil {_markerConfig} && {!isDedicated}) then {
        [_unit, _markerConfig select 0, _markerConfig select 1] call hull_marker_fnc_initMarker;
    };
};

hull_common_waitForPlayer = {
    waitUntil {
        !isNull player;
    };
};

hull_common_playerInit = {
    [] call hull_common_waitForPlayer;

    [] spawn hull_acre_fnc_setPlayerFrequencies;
    [] call hull_marker_fnc_addMarkers;
    [] spawn hull_marker_fnc_updateAllMarkers;
    [] call hull_briefing_fnc_addNotes;
};