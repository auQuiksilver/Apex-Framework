/*/
File: fn_eventEntityDeleted.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/10/2023 A3 2.14 by Quiksilver
	
Description:

	Entity Deleted Event
	
	Only available from A3 2.16 and onward
______________________________________________________/*/

params ['_entity'];
QS_analytics_entities_deleted = QS_analytics_entities_deleted + 1;
if (unitIsUav _entity) then {
	deleteVehicleCrew _entity;
};