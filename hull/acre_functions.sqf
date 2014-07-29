#include "hull_macros.h"

hull_acre_fnc_preInit = {
    hull_acre_isInitialized = false;
    if (isDedicated) then {
        hull_acre_isInitialized = true;
    };
};

hull_acre_fnc_setPlayerFrequencies = {
    waitUntil {
        !isNil {acre_sys_radio_currentRadioList};
    };
    [] call hull_acre_fnc_setFrequencies;
    hull_acre_isInitialized = true;
    ["acre.initialized", [player]] call hull_event_fnc_emitEvent;
};

hull_acre_fnc_setFrequencies = {
    [
        ["ACRE", "ShortRange", "default"] call hull_config_fnc_getText,
        ["ACRE", "ShortRange", "radios"] call hull_config_fnc_getArray,
        ["ACRE", "ShortRange", "baseFrequency"] call hull_config_fnc_getNumber,
        ["ACRE", "Steps", "channel"] call hull_config_fnc_getNumber
    ] call hull_acre_fnc_setChannels;
    [
        ["ACRE", "LongRange", "default"] call hull_config_fnc_getText,
        ["ACRE", "LongRange", "radios"] call hull_config_fnc_getArray,
        ["ACRE", "LongRange", "baseFrequency"] call hull_config_fnc_getNumber,
        ["ACRE", "Steps", "channel"] call hull_config_fnc_getNumber
    ] call hull_acre_fnc_setChannels;
};

hull_acre_fnc_setChannels = {
    FUN_ARGS_4(_defaultRadio,_radios,_baseFreq,_channelStep);

    private ["_sideStep", "_channelCount", "_calculatedChannels"];
    _sideStep = [player] call hull_acre_fnc_getSideStep;
    _channelCount = count ([_defaultRadio] call acre_api_fnc_getDefaultChannels);
    _calculatedChannels = [_channelCount, _baseFreq, _channelStep, _sideStep] call hull_acre_fnc_getCalculatedChannels;
    {
        [_x, _calculatedChannels] call acre_api_fnc_setDefaultChannels;
    } foreach _radios;
};

hull_acre_fnc_getCalculatedChannels = {
    FUN_ARGS_4(_channelCount,_baseFreq,_channelStep,_sideStep);

    private ["_newChannels"];
    _newChannels = [];
    for "_i" from 1 to _channelCount do {
        PUSH(_newChannels,_baseFreq + _i * _channelStep + _sideStep);
    };

    _newChannels;
};

hull_acre_fnc_getSideStep = {
    FUN_ARGS_1(_unit);
    call {
        if (side player == WEST) exitWith {["ACRE", "Steps", "west"] call hull_config_fnc_getNumber};
        if (side player == EAST) exitWith {["ACRE", "Steps", "east"] call hull_config_fnc_getNumber};
        if (side player == RESISTANCE) exitWith {["ACRE", "Steps", "resistance"] call hull_config_fnc_getNumber};
        ["ACRE", "Steps", "default"] call hull_config_fnc_getNumber;
    };
};