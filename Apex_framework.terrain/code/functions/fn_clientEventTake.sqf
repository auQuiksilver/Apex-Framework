/*
File: fn_clientEventTake.sqf
Author: 

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Client Event Take
	
	unit: Object - Unit to which the event handler is assigned
	container: Object - The container from which the item was taken (vehicle, box, etc.)
	item: String - The class name of the taken item
___________________________________________________________________*/

params ['_unit','_container','_item'];
if (QS_player getVariable ['QS_client_radioDisabled',FALSE]) then {
	if ((QS_player getSlotItemName 611) isNotEqualTo '') then {
		QS_player unassignItem (QS_player getSlotItemName 611);
	};
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};