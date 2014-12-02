private "_action";
_action = _this select 3 select 0;
call {
    if (_action == "activated") exitWith {
        [] call hull_mission_fnc_removeSafetyTimerActions;
        [] call hull_mission_fnc_addSafetyTimerConfirmActions;
    };
    if (_action == "confirm") exitWith {
        [] call hull_mission_fnc_removeSafetyTimerActions;
        hull_mission_safetyTimerAbort = true;
        if (isServer) then {
            [true] spawn hull_mission_fnc_serverSafetyTimerCountDown;
        } else {
            publicVariable "hull_mission_safetyTimerAbort";
        };
    };
    if (_action == "cancel") exitWith {
        [] call hull_mission_fnc_removeSafetyTimerActions;
        [] call hull_mission_fnc_addHostSafetyTimerStopAction;
    };
};