#include "hull_macros.h"

#include "\userconfig\hull\log\config.h"
#include "logbook.h"


hull_config_fnc_getConfig = {
    DECLARE(_config) = HULL_MISSION_CONFIG_FILE;
    {
        _config = _config >> _x;
    } foreach _this;
    if (configName _config == "") then {
        _config = HULL_CONFIG_FILE;
        {
            _config = _config >> _x;
        } foreach _this;
    };

    _config;
};

hull_config_fnc_getArray = {
    getArray (_this call hull_config_fnc_getConfig);
};

hull_config_fnc_getText = {
    getText (_this call hull_config_fnc_getConfig);
};

hull_config_fnc_getNumber = {
    getNumber (_this call hull_config_fnc_getConfig);
};

hull_config_fnc_getBool = {
    getNumber (_this call hull_config_fnc_getConfig) == 1;
};

hull_common_fnc_getEventFileResult = {
    FUN_ARGS_2(_fileName,_arguments);

    private ["_file", "_result"];
    _file = ["Events", _fileName] call hull_config_fnc_getText;
    _result = [];
    if (_file != "") then {
        _result = _arguments call compile preprocessFileLineNumbers _file;
    };

    _result;
};

hull_common_fnc_callEventFile = {
    FUN_ARGS_2(_fileName,_arguments);

    DECLARE(_file) = ["Events", _fileName] call hull_config_fnc_getText;
    if (_file != "") then {
        _arguments call compile preprocessFileLineNumbers _file;
    };
};

hull_config_fnc_getCustomConfig = {
    DECLARE(_config) = _this select 0;
    for "_i" from 1 to (count _this) - 1 do {
        _config = _config >> (_this select _i);
    };

    _config;
};

hull_config_fnc_getCustomArray = {
    getArray (_this call hull_config_fnc_getCustomConfig);
};

hull_config_fnc_getCustomText = {
    getText (_this call hull_config_fnc_getCustomConfig);
};

hull_config_fnc_getCustomNumber = {
    getNumber (_this call hull_config_fnc_getCustomConfig);
};

hull_config_fnc_getCustomBool = {
    getNumber (_this call hull_config_fnc_getCustomConfig) == 1;
};