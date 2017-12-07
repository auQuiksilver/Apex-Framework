/*
File: fn_clientInteractAlert.sqf
Author:
	
	Quiksilver
	
Last Modified:

	18/09/2015 ArmA 3 1.50 by Quiksilver

Description:

	Alarm Toggle
__________________________________________________________*/

private _onOrOff = missionNamespace getVariable ['QS_RD_missionAlert',FALSE];
if (_onOrOff) then {
	missionNamespace setVariable ['QS_RD_missionAlert',FALSE,TRUE];
	playSound 'clickSoft';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Alert now OFF',[],-1];
	player playAction 'putdown';
} else {
	missionNamespace setVariable ['QS_RD_missionAlert',TRUE,TRUE];
	playSound 'clickSoft';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,5,-1,'Alert now ON',[],-1];
	player playAction 'putdown';
};