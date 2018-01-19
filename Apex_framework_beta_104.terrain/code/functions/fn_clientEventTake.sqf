/*
File: fn_clientEventTake.sqf
Author: 

	Quiksilver
	
Last modified:

	20/01/20167 A3 1.66 by Quiksilver
	
Description:

	Client Event Take
	
	unit: Object - Unit to which the event handler is assigned
	container: Object - The container from which the item was taken (vehicle, box, etc.)
	item: String - The class name of the taken item
___________________________________________________________________*/

params ['_unit','_container','_item'];
if (player getVariable ['QS_client_radioDisabled',FALSE]) then {
	if ('ItemRadio' in (assignedItems player)) then {
		player unassignItem 'ItemRadio';
	};
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};