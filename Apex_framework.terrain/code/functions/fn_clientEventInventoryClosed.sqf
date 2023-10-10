/*
File: fn_clientEventInventoryClosed.sqf
Author: 

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Inventory Closed Event
___________________________________________________________________*/

params ['_unit','_inventory'];
if (QS_player getVariable ['QS_client_radioDisabled',FALSE]) then {
	if ((QS_player getSlotItemName 611) isNotEqualTo '') then {
		QS_player unassignItem (QS_player getSlotItemName 611);
	};
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};