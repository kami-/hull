#include "hull_macros.h"

#define HULL_MARKER_MEDIC_SIZE [0.5, 0.5]
#define HULL_MARKER_FIRETEAM_SIZE [0.6, 0.6]
#define HULL_MARKER_FIRETEAM_COLOR "ColorYellow"



hull_marker_fnc_preInit = {
    if (isServer || !isDedicated) then {
        hull_groupMarkers = [];
        hull_medicMarkers = [];
        hull_fireTeamMarkers = [];
        [] spawn hull_marker_fnc_updateAllMarkers;
    };
};

hull_marker_fnc_updateAllMarkers = {
    private ["_hull_groupMarkers", "_hull_medicMarkers", "_hull_fireTeamMarkers"];
    _hull_groupMarkers = hull_groupMarkers;
    _hull_medicMarkers = hull_medicMarkers;
    _hull_fireTeamMarkers = hull_fireTeamMarkers;
    waitUntil {
        [_hull_groupMarkers] call hull_marker_fnc_updateGroupMarkers;
        [_hull_medicMarkers] call hull_marker_fnc_updateMedicMarkers;
        [_hull_fireTeamMarkers] call hull_marker_fnc_updateFireTeamMarkers;
        sleep 4;
        false;
    };
};

hull_marker_fnc_updateGroupMarkers = {
    FUN_ARGS_1(_hull_groupMarkers);

    {
        private ["_markerName", "_group"];
        _markerName = _x select 0;
        _group = _x select 1;
        if ({alive _x} count units _group > 0) then {
            _markerName setMarkerPosLocal getPosASL leader _group;
        }
    } foreach _hull_groupMarkers;
};

hull_marker_fnc_updateMedicMarkers = {
    FUN_ARGS_1(_hull_medicMarkers);

    {
        private ["_markerName", "_unit"];
        _markerName = _x select 0;
        _unit = _x select 1;
        if (alive _unit) then {
            _markerName setMarkerPosLocal getPosASL _unit;
        }
    } foreach _hull_medicMarkers;
};

hull_marker_fnc_updateFireTeamMarkers = {
    FUN_ARGS_1(_hull_fireTeamMarkers);

    {
        private ["_markerName", "_unit"];
        _markerName = _x select 0;
        _unit = _x select 1;
        if (alive _unit) then {
            _markerName setMarkerPosLocal getPosASL _unit;
            _markerName setMarkerDirLocal getDir _unit;
        }
    } foreach _hull_fireTeamMarkers;
};

hull_marker_fnc_addMarker = {
    FUN_ARGS_4(_unit,_gearClass,_markerText,_markerColor);

    private "_markerName";
    call {
        if (toLower _gearClass == "ftl") exitWith {
            _markerName = format ["hull_groupMarker_%1_%2", _markerText, group _unit];
            [_markerName, getPosATL _unit, "ICON", "b_recon", _markerColor, _markerText] call hull_marker_fnc_createMarker;
            PUSH(hull_groupMarkers,AS_ARRAY_2(_markerName,group _unit));
        };
        if (toLower _gearClass == "m") exitWith {
            _markerName = format ["hull_medicMarker_%1_%2", _markerText, _unit];
            [_markerName, getPosATL _unit, "ICON", "b_med", _markerColor, _markerText, HULL_MARKER_MEDIC_SIZE] call hull_marker_fnc_createMarker;
            PUSH(hull_medicMarkers,AS_ARRAY_2(_markerName,_unit));
        };
        _markerName = format ["hull_groupMarker_%1_%2", _markerText, group _unit];
        [_markerName, getPosATL _unit, "ICON", "b_empty", _markerColor, _markerText] call hull_marker_fnc_createMarker;
        PUSH(hull_groupMarkers,AS_ARRAY_2(_markerName,group _unit));
    };
};

hull_marker_fnc_addFireTeamMarkers = {
    FUN_ARGS_1(_unit);

    {
        [_x] call hull_marker_fnc_addFireTeamMarker;
    } foreach (units group _unit);
};

hull_marker_fnc_addFireTeamMarker = {
    FUN_ARGS_1(_unit);

    _markerName = format ["hull_fireTeamMarker_%1_%2", _markerText, _unit];
    [_markerName, getPosATL _unit, "ICON", "mil_triangle", HULL_MARKER_FIRETEAM_COLOR, "", HULL_MARKER_FIRETEAM_SIZE] call hull_marker_fnc_createMarker;
    PUSH(hull_fireTeamMarkers,AS_ARRAY_2(_markerName,_unit));
};

hull_marker_fnc_createMarker = {
    FUN_ARGS_7(_name,_position,_shape,_type,_color,_text,_size);

    createMarkerLocal [_name, _position];
    _name setMarkerShapeLocal _shape;
    _name setMarkerTypeLocal _type;
    _name setMarkerColorLocal _color;
    _name setMarkerTextLocal _text;
    if (!isNil "_size") then {
        _name setMarkerSizeLocal _size;
    };

    _name;
};
