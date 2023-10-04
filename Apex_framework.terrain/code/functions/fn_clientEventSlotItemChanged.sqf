/*/
File: fn_clientEventSlotItemChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	28/08/2023 A3 2.12 by Quiksilver
	
Description:

	Slot Item Changed Event

Notes:

	unit: Object - unit EH assigned to.
	name: String - name of the item/weapon/container (see getSlotItemName).
	slot: Number - slot id (see getSlotItemName).
	assigned: Boolean - true assign action, false unassign action.
__________________________________________________/*/

params ['_unit','_name','_slot','_assigned'];
//systemChat str _this;		// Debug