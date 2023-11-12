/*
File: fn_clientVehicleEventEngine.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/11/2023 A3 2.14 by Quiksilver

Description:

	Event Engine
	
	vehicle: Object - Vehicle the event handler is assigned to
	engineState: Boolean - True when the engine is turned on, false when turned off
	
To Do:

	Use this event for vehicle service.
__________________________________________________________*/

if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_engineState'];
if (
	(!_engineState) &&
	{((['LandVehicle','Ship'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1)}
) then {
	(getCruiseControl _vehicle) params ['_speedLimit','_cruiseControlActive'];
	if (_speedLimit isNotEqualTo 0) then {
		_vehicle setCruiseControl [0,FALSE];
	};
};