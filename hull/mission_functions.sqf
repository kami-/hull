#include "hull_macros.h"

#define LOGGING_LEVEL_ERROR
#define LOGGING_TO_RPT
#include "logbook.h"


hull_mission_fnc_preInit = {
    hull_mission_isJip = false;
    [] call hull_mission_fnc_addEventHandlers;
};

hull_mission_fnc_addEventHandlers = {
    ["player.initialized", hull_mission_fnc_getJipState] call hull_event_fnc_addEventHandler;
};

hull_mission_fnc_init = {
    [] call hull_mission_fnc_evaluateParams;
    [] call hull_mission_fnc_readMissionParamValues;
    [] call hull_mission_fnc_setEnviroment;
    hull_mission_safetyTimerAbort = false;
};

hull_mission_fnc_evaluateParams = {
    if (!isNil {paramsArray}) then {
        {
            private ["_name", "_code"];
            _name = configName ((missionConfigFile >> "Params") select _forEachIndex);
            _code = getText (missionConfigFile >> "Params" >> _name >> "code");
            call compile format [_code, _x];
        } foreach paramsArray;
    };
};

hull_mission_fnc_readMissionParamValues = {
    if (!isNil {hull_mission_date}) then {
        hull_mission_date = (["MissionParams", "date"] call hull_config_fnc_getArray) select hull_mission_date;
    };
    if (!isNil {hull_mission_timeOfDay}) then {
        hull_mission_timeOfDay = (["MissionParams", "time"] call hull_config_fnc_getArray) select hull_mission_timeOfDay;
    };
    if (!isNil {hull_mission_weather}) then {
        hull_mission_weather = (["MissionParams", "weather"] call hull_config_fnc_getArray) select hull_mission_weather;
    };
};

hull_mission_fnc_getDateTime = {
    if (isNil {hull_mission_date}) then {
        hull_mission_date = [2014, 1, 31];
    };
    if (isNil {hull_mission_timeOfDay}) then {
        hull_mission_timeOfDay = [12, 0];
    };

    [hull_mission_date select 0, hull_mission_date select 1, hull_mission_date select 2, hull_mission_timeOfDay select 0, hull_mission_timeOfDay select 1];
};

hull_mission_fnc_getWeather = {
    if (isNil {hull_mission_weather}) then {
        hull_mission_weather = [0, 0, 0];
    };
    if (hull_mission_weather select 0 == -1) then {
        DECLARE(_weathers) = ["MissionParams", "weather"] call hull_config_fnc_getArray;
        hull_mission_weather = _weathers select ((floor random ((count _weathers) - 1)) + 1);
    };

    [hull_mission_weather select 0, hull_mission_weather select 1, hull_mission_weather select 2];
};

hull_mission_fnc_setWeather = {
    FUN_ARGS_2(_time,_weather);

    _time setOvercast (_weather select 0);
    _time setFog (_weather select 1);
    _time setRain (_weather select 2);
};

hull_mission_fnc_setEnviroment = {
    setDate ([] call hull_mission_fnc_getDateTime);
    [0, [] call hull_mission_fnc_getWeather] call hull_mission_fnc_setWeather;
};

hull_mission_fnc_broadcastEnviroment = {
    while {true} do {
        hull_mission_syncEnviroment = [overcast, fog, rain];
        publicVariable "hull_mission_syncEnviroment";
        sleep 60;
    };
};

hull_mission_fnc_addPlayerEHs = {
    "hull_mission_syncEnviroment" addPublicVariableEventHandler {
        [10, _this select 1] call hull_mission_fnc_setWeather;
    };
    "hull_mission_jipPacket" addPublicVariableEventHandler {
        (_this select 1) call hull_mission_fnc_receiveJipState;
    };
    "hull_mission_safetyTimer" addPublicVariableEventHandler {
        (_this select 1) call hull_mission_fnc_handleSafetyTimeChange;
    };
};

hull_mission_fnc_addServerEHs = {
    if (isDedicated) then {
        "hull_mission_jipPacket" addPublicVariableEventHandler {
            (_this select 1) call hull_mission_fnc_sendJipState;
        };
    };
    "hull_mission_safetyTimerAbort" addPublicVariableEventHandler {
        [_this select 1] spawn hull_mission_fnc_serverSafetyTimerCountDown;
    };
};

hull_mission_fnc_serverSafetyTimerLoop = {
    if (!isNil {hull_mission_safetyTimerEnd} && {hull_mission_safetyTimerEnd > 0}) then {
        hull_mission_safetyTimer = [false, -1];
        while {(hull_mission_safetyTimer select 1) < hull_mission_safetyTimerEnd && {!hull_mission_safetyTimerAbort}} do {
            hull_mission_safetyTimer set [1, (hull_mission_safetyTimer select 1) + 1];
            publicVariable "hull_mission_safetyTimer";
            sleep 60;
        };
        if (!hull_mission_safetyTimerAbort) then {
            [true] spawn hull_mission_fnc_serverSafetyTimerCountDown;
        };
    };
};

hull_mission_fnc_serverSafetyTimerCountDown = {
    FUN_ARGS_1(_isAborted);

    if (_isAborted) then {
        hull_mission_safetyTimer = [true, 10];
        for "_i" from 10 to 0 step -1 do {
            hull_mission_safetyTimer set [1, _i];
            publicVariable "hull_mission_safetyTimer";
            sleep 1;
        };
    };
};

hull_mission_fnc_clientSafetyTimerLoop = {
    if (!isNil {hull_mission_safetyTimerEnd} && {hull_mission_safetyTimerEnd > 0}) then {
        [] call hull_mission_fnc_addHostSafetyTimerStopAction;
        [player] call hull_unit_fnc_addFiredEHs;
        while {!([] call hull_mission_fnc_hasSafetyTimerEnded)} do {
            TRY_ADD_WEAPON(player,"ACE_Safe");
            player selectWeapon "ACE_Safe";
        };
        player removeEventHandler ["Fired", player getVariable "hull_eh_fired"];
    };
};

hull_mission_fnc_handleSafetyTimeChange = {
    FUN_ARGS_2(_isCountDown,_timeValue);

    DECLARE(_message) = "Game is not live. Waiting for host to start it. (%1 minutes)";
    if (_isCountDown) then {
        call {
            if (_timeValue == 0) exitWith {
                _message = "Game is live!";
            };
            if (_timeValue <= 5) exitWith {_message = "Game will be live in %1 seconds!";};
            _message = "";
        };
    };
    if (_message != "") then {
        player globalChat format [_message, _timeValue];
    };
};

hull_mission_fnc_hasSafetyTimerEnded = {
    (hull_mission_safetyTimer select 0) && {(hull_mission_safetyTimer select 1) <= 0};
};

hull_mission_fnc_addHostSafetyTimerStopAction = {
    if (serverCommandAvailable "#kick") then {
        player addAction ["Disable weapon safety", ADDON_PATH(mission_host_safetytimer_stop.sqf), [], 3, false, false, "", "driver _target == _this && {!(hull_mission_safetyTimer select 0)} && {(hull_mission_safetyTimer select 1) < hull_mission_safetyTimerEnd}"];
    };
};

hull_mission_fnc_getJipState = {
    hull_mission_jipPacket = [player, time];
    DEBUG("hull.mission.jip",FMT_2("Sending JIP state request for server from client '%1' with time '%2'.",player,time));
    publicVariableServer "hull_mission_jipPacket";
};

hull_mission_fnc_sendJipState = {
    FUN_ARGS_2(_client,_clientTime);

    DEBUG("hull.mission.jip",FMT_4("Sending JIP state for client '%1' with client time '%2' and server time '%3'. Client's JIP state is '%5'.",_client,_clientTime,time,time != 0 && _clientTime > 0));
    DECLARE(_isJip) = time != 0 && _clientTime > 0;
    hull_mission_jipPacket = [_isJip];
    if (_isJip) then {
        DECLARE(_weather) = [overcast, fog, rain];
        PUSH(hull_mission_jipPacket,date);
        PUSH(hull_mission_jipPacket,_weather);
        PUSH(hull_mission_jipPacket,hull_mission_safetyTimer);
        PUSH(hull_mission_jipPacket,hull_mission_safetyTimerAbort);
    };
    DEBUG("hull.mission.jip",FMT_2("Sending JIP state for client '%1' with packet '%2'.",_client,hull_mission_jipPacket));
    (owner _client) publicVariableClient "hull_mission_jipPacket";
};

hull_mission_fnc_receiveJipState = {
    FUN_ARGS_1(_isJip);

    DEBUG("hull.mission.jip",FMT_2("Received JIP state from server for client '%1' with JIP state '%2'.",owner player,_isJip));
    hull_mission_isJip = _isJip;
    if (_isJip) then {
        setDate (_this select 1);
        [10, (_this select 2)] call hull_mission_fnc_setWeather;
        hull_mission_safetyTimer = _this select 3;
        hull_mission_safetyTimerAbort = _this select 4;
        DEBUG("hull.mission.jip",FMT_2("Client '%1' is JIP, setting environment and safety timer from packet '%2'.",owner player,_this));
    };
};