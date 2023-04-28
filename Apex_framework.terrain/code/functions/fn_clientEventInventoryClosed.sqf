/*
File: fn_clientEventInventoryClosed.sqf
Author: 

	Quiksilver
	
Last modified:

	20/01/2017 A3 1.66 by Quiksilver
	
Description:

	Inventory Closed Event
___________________________________________________________________*/

params ['_unit','_inventory'];
if (player getVariable ['QS_client_radioDisabled',FALSE]) then {
	if ((QS_client_assignedItems_lower findAny QS_core_classNames_itemRadios) isNotEqualTo -1) then {
		player unassignItem (QS_client_assignedItems_lower # (QS_client_assignedItems_lower findAny QS_core_classNames_itemRadios));
	};
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};