/*
File: fn_clientVehicleEventLocal.sqf
Author:
	
	Quiksilver
	
Last Modified:

	22/01/2023 A3 2.10 by Quiksilver

Description:

	Event Local
________________________________________________*/

params ['_vehicle','_isLocal'];
if (_isLocal) then {
	[1,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
	_simulation = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_simulation',toLowerANSI (typeOf _vehicle)],
		{toLowerANSI (getText ((configOf _vehicle) >> 'simulation'))},
		TRUE
	];
	if (
		(_simulation in ['tankx','carx']) &&
		((ropes _vehicle) isNotEqualTo [])
	) then {
		['MODE17'] call QS_fnc_simplePull;
	};
} else {
	[0,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
};