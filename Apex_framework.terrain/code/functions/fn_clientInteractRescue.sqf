/*
File: fn_clientInteractRescue.sqf
Author:

	Quiksilver
	
Last Modified:

	24/01/2024 A3 2.16
	
Description:

	-
_____________________________________________________________*/

private ['_t'];
_t = cursorTarget;
if (
	(!alive _t) ||
	(!isNull (objectParent _t)) ||
	(!(_t isKindOf 'CAManBase')) ||
	(_t isNil 'QS_rescueable')
) exitWith {};
player playAction 'PutDown';
_t setVariable ['QS_rescueable',FALSE,TRUE];
_t setCaptive FALSE;
missionNamespace setVariable ['QS_RD_mission_X_rescued',TRUE,TRUE];
if (missionNamespace getVariable 'QS_sideMission_POW_active') then {
	missionNamespace setVariable ['QS_sideMission_POW_rescued',TRUE,TRUE];
	[1,_t] remoteExec ['QS_fnc_remoteExec',_t,FALSE];
};