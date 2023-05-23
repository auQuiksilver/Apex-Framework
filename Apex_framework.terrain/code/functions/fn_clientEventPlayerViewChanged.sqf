/*
File: fn_clientEventPlayerViewChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	21/05/2023 A3 2.12 by Quiksilver
	
Description:

	View Changed
_____________________________________________*/

params ['_oldBody','_newBody','_vehicleIn','_oldCameraOn','_newCameraOn','_uav'];
if (
	(_newCameraOn isEqualTo player) &&
	{(_oldCameraOn isKindOf 'CAManBase')} &&
	{(_oldCameraOn isNotEqualTo player)}
) then {
	if ((actionIDs _oldCameraOn) isNotEqualTo []) then {
		// removeAllActions
		{
			_oldCameraOn removeAction _x;
		} forEach (actionIds _oldCameraOn);
	};
};
if (
	(_oldCameraOn isNotEqualTo _newCameraOn) &&
	{(local _newCameraOn)} &&
	{(_oldCameraOn isKindOf 'CAManBase')} &&
	{((attachedObjects _newCameraOn) isNotEqualTo [])} &&
	{(!isNull (_newCameraOn getVariable ['QS_logistics_child',objNull]))} &&
	{((_newCameraOn getVariable ['QS_logistics_child',objNull]) in (attachedObjects _newCameraOn))}
) then {
	[_newCameraOn,_oldCameraOn] spawn {
		uiSleep 0.25;
		params ['_newCameraOn','_oldCameraOn'];
		[
			_newCameraOn,
			(_newCameraOn getVariable ['QS_logistics_child',objNull]),
			FALSE,
			FALSE,
			FALSE,
			TRUE,
			TRUE,
			TRUE,
			_oldCameraOn,
			FALSE,
			TRUE
		] call QS_fnc_unloadCargoPlacementMode;
	};
};
uiNamespace setVariable ['QS_client_playerViewChanged',TRUE];
QS_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',player];
QS_player setVariable ['QS_unit_enemySides',QS_player call QS_fnc_enemySides,FALSE];
if (_oldBody isNotEqualTo _newBody) then {
	[0,_oldBody] call QS_fnc_clientEventFiredPrevent;
};
if (
	(_oldCameraOn isNotEqualTo _newCameraOn) &&
	{(_newCameraOn isKindOf 'B_APC_Tracked_01_CRV_F')}
) then {
	['INIT'] call QS_fnc_bobcatClearance;
};