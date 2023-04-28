/*
File: fn_clientEventVehicleTurbo.sqf
Author: 

	Quiksilver
	
Last modified:

	16/02/2023 A3 2.12 by Quiksilver
	
Description:

	Vehicle Turbo event
_________________________________________*/

uiNamespace setVariable ['QS_uiaction_vehicleturbo',TRUE];
_cameraOn = cameraOn;
if (!local _cameraOn) exitWith {};
if ((ropes _cameraOn) isNotEqualTo []) then {
	if (isNull (getSlingLoad _cameraOn)) then {
		if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
			['MODE4',_cameraOn] call QS_fnc_simplePull;
		};
	};
} else {
	if (!isNull (ropeAttachedTo _cameraOn)) then {
		if (uiNamespace getVariable ['QS_pulling_brakesToggle',FALSE]) then {
			['MODE3',_cameraOn] call QS_fnc_simpleWinch;
		};
	};
};
if (
	(_cameraOn isKindOf 'LandVehicle') &&
	{(alive _cameraOn)} &&
	{(!isAwake _cameraOn)} &&
	{(((velocityModelSpace _cameraOn) # 1) < 0.1)} &&
	{(canMove _cameraOn)} &&
	{((ropes _cameraOn) isEqualTo [])} &&
	{(isNull (ropeAttachedTo _cameraOn))} &&
	{(isNull (attachedTo _cameraOn))} &&
	{(isNull (isVehicleCargo _cameraOn))} &&
	{((fuel _cameraOn) > 0)} &&
	{((_cameraOn getSoundController 'thrust') isEqualTo 1)}
) then {
	_cameraOn setVelocityModelSpace [0,[3,-3] select (uiNamespace getVariable ['QS_uiaction_carback',FALSE]),0.1];
};