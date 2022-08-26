/*
File: fn_eventBuildingChanged.sqf
Author:

	Quiksilver
	
Last modified:

	18/08/2022 A3 2.10 by Quiksilver
	
Description:

	Building Changed event
	
	Need to be careful that we aren't deleting terrain object ruins
__________________________________________________*/

params ['_changedFrom','_changedTo','_isRuin'];
if (_isRuin) then {
	if (_changedTo isKindOf 'Land_TTowerBig_2_ruins_F') then {
		(missionNamespace getVariable 'QS_garbageCollector') pushBack [_changedTo,'NOW_DISCREET',(time + 120)];
	};
};
if (_changedFrom isEqualTo (missionNamespace getVariable ['QS_sidemission_building',objNull])) then {
	if (_isRuin) then {
		missionNamespace setVariable ['QS_sidemission_buildingDestroyed',TRUE,FALSE];
	};
};