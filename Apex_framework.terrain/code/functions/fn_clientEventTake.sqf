/*
File: fn_clientEventTake.sqf
Author: 

	Quiksilver
	
Last modified:

	20/01/2017 A3 1.66 by Quiksilver
	
Description:

	Client Event Take
	
	unit: Object - Unit to which the event handler is assigned
	container: Object - The container from which the item was taken (vehicle, box, etc.)
	item: String - The class name of the taken item
___________________________________________________________________*/

params ['_unit','_container','_item'];
if (player getVariable ['QS_client_radioDisabled',FALSE]) then {
	if ((QS_client_assignedItems_lower findAny QS_core_classNames_itemRadios) isNotEqualTo -1) then {
		player unassignItem (QS_client_assignedItems_lower # (QS_client_assignedItems_lower findAny QS_core_classNames_itemRadios));
	};
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};