#include "hull_macros.h"

#include "\userconfig\hull\log\mission.h"
#include "logbook.h"


hull_mission_fnc_preInit = {
    hull_mission_isJip = false;
    [] call hull_mission_fnc_addEventHandlers;
    DEBUG("hull.mission","Mission functions preInit finished.");
};

hull_mission_fnc_addEventHandlers = {
    ["player.initialized", hull_mission_fnc_clientInit] call hull_event_fnc_addEventHandler;
};

hull_mission_fnc_init = {
    [] call hull_mission_fnc_evaluateParams;
    [] call hull_mission_fnc_readMissionParamValues;
    [] call hull_mission_fnc_setEnviroment;
    hull_mission_safetyTimerAbort = false;
};

hull_mission_fnc_serverInit = {
    [] call hull_mission_fnc_addServerEHs;
    [] spawn hull_mission_fnc_serverSafetyTimerLoop;
    [] spawn hull_mission_fnc_broadcastEnviromentLoop;
    DEBUG("hull.mission","Server init finished.");
};

hull_mission_fnc_clientInit = {
    hull_mission_isJip = SLX_XEH_MACHINE select 1;
    if (hull_mission_isJip) then {
        [] call hull_mission_fnc_getJipSync;
    };
    DEBUG("hull.mission","Client init finished.");
};

hull_mission_fnc_evaluateParams = {
    if (!isNil {paramsArray}) then {
        {
            private ["_name", "_code"];
            _name = configName ((missionConfigFile >> "Params") select _forEachIndex);
            _code = getText (missionConfigFile >> "Params" >> _name >> "code");
            call compile format [_code, _x];
        } foreach paramsArray;
        TRACE("hull.mission.params",FMT_1("ParamsArray '%1' have been evaluated.",paramsArray));
    };
};

hull_mission_fnc_readMissionParamValues = {
    INIT_MISSION_VAR(hull_mission_date,"date",AS_ARRAY_3(2014,1,31));
    INIT_MISSION_VAR(hull_mission_timeOfDay,"time",AS_ARRAY_2(12,0));
    INIT_MISSION_VAR(hull_mission_weather,"weather",AS_ARRAY_3(0,0,0));
    if (isNil {hull_mission_safetyTimerEnd}) then {
        hull_mission_safetyTimerEnd = 9999;
        TRACE("hull.mission.safetytimer",FMT_1("Mission param 'hull_mission_safetyTimerEnd' was not set, using default '%1'.",hull_mission_safetyTimerEnd));
    };
};

hull_mission_fnc_getDateTime = {
    [hull_mission_date select 0, hull_mission_date select 1, hull_mission_date select 2, hull_mission_timeOfDay select 0, hull_mission_timeOfDay select 1];
};

hull_mission_fnc_getWeather = {
    if (hull_mission_weather select 0 == -1 && {isServer}) then {
        DECLARE(_weathers) = ["MissionParams", "weather"] call hull_config_fnc_getArray;
        hull_mission_weather = _weathers select ((floor random ((count _weathers) - 1)) + 1);
        TRACE("hull.mission.weather",FMT_1("Random weather was selected. Generated random weather '%1' for server.",hull_mission_weather));
    } else {
        if (!isDedicated && !isServer) then {
            hull_mission_weather = [0, 0, 0];
            TRACE("hull.mission.weather",FMT_1("Random weather was selected. Using default weather '%1' for client.",hull_mission_weather));
        };
    };

    hull_mission_weather;
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
    DEBUG("hull.mission.weather",FMT_2("Environment was set. Date to '%1' and weather to '%2'.",[] call hull_mission_fnc_getDateTime,[] call hull_mission_fnc_getWeather));
};

hull_mission_fnc_broadcastEnviromentLoop = {
    sleep 0.1;
    hull_mission_syncEnviroment = [overcast, fog, rain];
    DEBUG("hull.mission.weather",FMT_1("Weather '%1' init is broadcasted.",hull_mission_syncEnviroment));
    publicVariable "hull_mission_syncEnviroment";
    while {true} do {
        hull_mission_syncEnviroment = [overcast, fog, rain];
        publicVariable "hull_mission_syncEnviroment";
        DEBUG("hull.mission.weather",FMT_1("Weather '%1' is broadcasted.",hull_mission_syncEnviroment));
        sleep 60;
    };
};

hull_mission_fnc_addPlayerEHs = {
    "hull_mission_syncEnviroment" addPublicVariableEventHandler {
        DEBUG("hull.mission.weather",FMT_1("Weather is received '%1'.",_this select 1));
        hull_mission_weather = _this select 1;
        [0, _this select 1] call hull_mission_fnc_setWeather;
    };
    if (hull_mission_isJip) then {
        "hull_mission_jipPacket" addPublicVariableEventHandler {
            (_this select 1) call hull_mission_fnc_receiveJipSync;
        };
    };
    "hull_mission_safetyTimer" addPublicVariableEventHandler {
        (_this select 1) call hull_mission_fnc_handleSafetyTimeChange;
    };
    DEBUG("hull.mission.ehs","Player event handlers were added.");
};

hull_mission_fnc_addServerEHs = {
    if (isDedicated) then {
        "hull_mission_jipPacket" addPublicVariableEventHandler {
            (_this select 1) call hull_mission_fnc_sendJipSync;
        };
    };
    "hull_mission_safetyTimerAbort" addPublicVariableEventHandler {
        [_this select 1] spawn hull_mission_fnc_serverSafetyTimerCountDown;
    };
    DEBUG("hull.mission.ehs","Server event handlers were added.");
};

hull_mission_fnc_serverSafetyTimerLoop = {
    if (!isNil {hull_mission_safetyTimerEnd} && {hull_mission_safetyTimerEnd > 0}) then {
        hull_mission_safetyTimer = [false, -1];
        DEBUG("hull.mission.safetytimer",FMT_1("Safety timer has been initialized with value '%1'.",hull_mission_safetyTimer));
        while {(hull_mission_safetyTimer select 1) < hull_mission_safetyTimerEnd && {!hull_mission_safetyTimerAbort}} do {
            hull_mission_safetyTimer set [1, (hull_mission_safetyTimer select 1) + 1];
            publicVariable "hull_mission_safetyTimer";
            DEBUG("hull.mission.safetytimer",FMT_1("Safety timer has been published to clients with value '%1'.",hull_mission_safetyTimer));
            if (!isDedicated) then {
                hull_mission_safetyTimer call hull_mission_fnc_handleSafetyTimeChange;
            };
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
        DEBUG("hull.mission.safetytimer",FMT_1("Safety timer has been aborted. Starting countdown from '%1' seconds.",hull_mission_safetyTimer select 1));
        for "_i" from 10 to 0 step -1 do {
            hull_mission_safetyTimer set [1, _i];
            publicVariable "hull_mission_safetyTimer";
            TRACE("hull.mission.safetytimer",FMT_1("Safety timer has been published to clients with countdown time at '%1' seconds.",hull_mission_safetyTimer select 1));
            if (!isDedicated) then {
                hull_mission_safetyTimer call hull_mission_fnc_handleSafetyTimeChange;
            };
            sleep 1;
        };
        ["mission.safetytimer.ended", []] call hull_event_fnc_emitEvent;
    };
};

hull_mission_fnc_clientSafetyTimerLoop = {
    if (!isNil {hull_mission_safetyTimerEnd} && {hull_mission_safetyTimerEnd > 0}) then {
        [] call hull_mission_fnc_addHostSafetyTimerStopAction;
        [player] call hull_unit_fnc_addFiredEHs;
        DEBUG("hull.mission.safetytimer","Starting safety timer loop.");
        while {!([] call hull_mission_fnc_hasSafetyTimerEnded)} do {
            TRY_ADD_WEAPON(player,"ACE_Safe");
            player selectWeapon "ACE_Safe";
        };
        player removeEventHandler ["Fired", player getVariable "hull_eh_fired"];
        DEBUG("hull.mission.safetytimer","Safety timer has ended. Removed fired EH.");
        if (!isServer) then {
            ["mission.safetytimer.ended", []] call hull_event_fnc_emitEvent;
        };
    };
};

hull_mission_fnc_handleSafetyTimeChange = {
    FUN_ARGS_2(_isCountDown,_timeValue);

    DEBUG("hull.mission.safetytimer",FMT_1("Safety timer has been changed. Received value '%1'.",AS_ARRAY_2(_isCountDown,_timeValue)));
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
    if (serverCommandAvailable "#kick" || {!isMultiplayer}) then {
        player addAction ["Disable weapon safety", ADDON_PATH(mission_host_safetytimer_stop.sqf), [], 3, false, false, "", "driver _target == _this && {!(hull_mission_safetyTimer select 0)} && {(hull_mission_safetyTimer select 1) < hull_mission_safetyTimerEnd}"];
        DEBUG("hull.mission.safetytimer","Added safety timer abort action to player.");
    };
};

hull_mission_fnc_getJipSync = {
    if (hull_mission_isJip) then {
        hull_mission_jipPacket = [player];
        DEBUG("hull.mission.jip",FMT_2("Sending JIP state request for server from client '%1' with time '%2'.",player,time));
        publicVariableServer "hull_mission_jipPacket";
    };
};

hull_mission_fnc_sendJipSync = {
    FUN_ARGS_1(_client);

    hull_mission_jipPacket = [date];
    DECLARE(_weather) = [overcast, fog, rain];
    PUSH(hull_mission_jipPacket,_weather);
    PUSH(hull_mission_jipPacket,hull_mission_safetyTimer);
    PUSH(hull_mission_jipPacket,hull_mission_safetyTimerAbort);
    DEBUG("hull.mission.jip",FMT_2("Sending JIP sync for client '%1' with packet '%2'.",_client,hull_mission_jipPacket));
    (owner _client) publicVariableClient "hull_mission_jipPacket";
};

hull_mission_fnc_receiveJipSync = {
    FUN_ARGS_4(_date,_weather,_safetyTimer,_safetyTimerAbort);

    DEBUG("hull.mission.jip",FMT_2("Received JIP sync '%1' from server for client '%2'.",owner player,_this));
    setDate _date;
    hull_mission_date = _date;
    hull_mission_weather = _weather;
    [0, _weather] call hull_mission_fnc_setWeather;
    hull_mission_safetyTimer = _safetyTimer;
    hull_mission_safetyTimerAbort = _safetyTimerAbort;
};