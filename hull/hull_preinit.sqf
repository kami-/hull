#include "hull_macros.h"

[] call compile preProcessFileLineNumbers "hull\common_functions.sqf";
[] call compile preProcessFileLineNumbers "hull\acre_functions.sqf";
[] call compile preProcessFileLineNumbers "hull\gear_functions.sqf";
[] call compile preProcessFileLineNumbers "hull\marker_functions.sqf";

[] call PNS_GVAR(hull_acre_fnc_preInit);
[] call PNS_GVAR(hull_marker_fnc_preInit);