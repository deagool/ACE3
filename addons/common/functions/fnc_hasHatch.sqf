/*
 * Author: commy2
 * Check if unit has a hatch and can turn out.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit has a hatch? <BOOL>
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit"];

local _vehicle = vehicle _unit;

if (_unit == _vehicle) exitWith {false};

local _config = configFile >> "CfgVehicles" >> typeOf _vehicle;

if (getNumber (_config >> "hideProxyInCombat") != 1) exitWith {false};

if (_unit == driver _vehicle) exitWith {
    getNumber (_config >> "forceHideDriver") == 0; // return
};

local _turret = [_unit] call FUNC(getTurretIndex);

if (_turret isEqualTo []) exitWith {false};

local _turretConfig = [_config, _turret] call FUNC(getTurretConfigPath);

getNumber (_turretConfig >> "forceHideGunner") == 0; // return
