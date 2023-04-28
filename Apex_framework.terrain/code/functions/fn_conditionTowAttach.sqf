/*
File: fn_conditionTowAttach.sqf
Author: 

	Quiksilver
	
Last modified:

	30/12/2022 A3 2.10 by Quiksilver
	
Description:

	Condition for add-Action
__________________________________________________*/

_v = cameraOn;
(
	(_v isKindOf 'LandVehicle') &&
	{((_v getVariable ['QS_tow_veh',-1]) > 0)} &&
	{(((vectorMagnitude (velocity _v)) * 3.6) < 1)} &&
	{([_v] call (missionNamespace getVariable 'QS_fnc_vTowable'))}
)