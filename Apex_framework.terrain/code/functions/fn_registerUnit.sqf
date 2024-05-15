/*/
File: fn_registerAI.sqf
Author:

	Quiksilver
	
Last Modified:

	26/01/2018 A3 1.80 by Quiksilver
	
Description:

	Recruitable AI Registration

Example:
	
	0 = [
		this,
		60,
		false,
		{},
		-1,
		FALSE
	] call QS_fnc_registerUnit;
_____________________________________________________________________/*/

if (!isDedicated) exitWith {0};
_this spawn {
	waitUntil {
		uiSleep (random [0.1,0.125,0.15]);
		((missionNamespace getVariable ['QS_missionConfig_baseLayout',-1]) isNotEqualTo -1)
	};
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) exitWith {};
	if ((missionNamespace getVariable ['QS_missionConfig_recruitableAI',1]) isEqualTo 0) exitWith {};
	params ['_unit','_respawnDelay','_randomize','_initCode','_respawnTickets','_playerThreshold'];
	_unitType = typeOf _unit;
	_unitPos = getPosASL _unit;
	_unitDir = getDir _unit;
	if (missionNamespace isNil 'QS_register_rAI') then {
		missionNamespace setVariable ['QS_register_rAI',[],FALSE];
	};
	(missionNamespace getVariable 'QS_register_rAI') pushBack [
		objNull,
		_respawnDelay,
		_randomize,
		_initCode,
		_unitType,
		_unitPos,
		_unitDir,
		FALSE,
		0,
		_respawnTickets,
		_playerThreshold
	];
	deleteVehicle _unit;
};
0;