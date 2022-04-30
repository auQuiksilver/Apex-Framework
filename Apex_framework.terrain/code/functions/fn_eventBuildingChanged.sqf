/*
File: fn_eventBuildingChanged.sqf
Author:

	Quiksilver
	
Last modified:

	13/04/2017 A3 1.68 by Quiksilver
	
Description:

	Building Changed event
__________________________________________________*/

params ['_changedFrom','_changedTo','_isRuin'];
if (_isRuin) then {
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_changedTo,'NOW_DISCREET',(time + 120)];
};
if (_changedFrom isEqualTo (missionNamespace getVariable ['QS_sidemission_building',objNull])) then {
	if (_isRuin) then {
		missionNamespace setVariable ['QS_sidemission_buildingDestroyed',TRUE,FALSE];
	};
};