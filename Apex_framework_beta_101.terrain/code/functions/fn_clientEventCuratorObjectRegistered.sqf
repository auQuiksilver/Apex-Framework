/*
File: fn_clientEventCuratorObjectRegistered.sqf
Author:

	Quiksilver
	
Last modified:

	27/01/2017 A3 1.66 by Quiksilver
	
Description:

	Curator Object Registered
__________________________________________________*/

params ['_module','_input'];
[_module,_input] spawn {
	scriptName 'QS EventCuratorObjectRegistered';
	waitUntil {(!isNull (findDisplay 312))};
	if (!(commandingMenu isEqualTo '')) then {
		showCommandingMenu '';
	};
	(findDisplay 312) displayAddEventHandler ['KeyDown',{_this call (missionNamespace getVariable ['QS_fnc_clientEventCuratorKeyDown',{}]);}];
	_uid = getPlayerUID player;
	for '_x' from 0 to 1 step 0 do {
		if (isNull (findDisplay 312)) exitWith {
			uiNamespace setVariable ['RscMissionStatus_display',(findDisplay 46)];
		};
		uiSleep 0.1;
	};
};