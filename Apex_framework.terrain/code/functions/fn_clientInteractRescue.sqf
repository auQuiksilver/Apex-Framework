/*
File: fn_clientInteractRescue.sqf
Author:

	Quiksilver
	
Last Modified:

	3/09/2015 ArmA 3 1.50
	
Description:

	-
_____________________________________________________________*/

private ['_t'];
_t = cursorTarget;
if (!isNull (objectParent _t)) exitWith {};
if (!alive _t) exitWith {};
if (!(_t isKindOf 'Man')) exitWith {};
if (isNil {_t getVariable 'QS_rescueable'}) exitWith {};
player playAction 'PutDown';
_t setVariable ['QS_rescueable',FALSE,TRUE];
_t setCaptive FALSE;
missionNamespace setVariable ['QS_RD_mission_X_rescued',TRUE,TRUE];

if (missionNamespace getVariable 'QS_sideMission_POW_active') then {
	missionNamespace setVariable ['QS_sideMission_POW_rescued',TRUE,TRUE];
	[1,_t] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
};