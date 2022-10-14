/*/
File: fn_clientEventCuratorObjectDeleted.sqf
Author:

	Quiksilver
	
Last modified:

	21/09/2022 A3 2.10 by Quiksilver
	
Description:

	Event Curator Object Deleted
__________________________________________________/*/

params ['_module','_entity'];
if (
	(_entity isKindOf 'CAManBase') &&
	(!isNull (group _entity)) &&
	(!isNull (objectParent _entity)) &&
	((objectParent _entity) isKindOf 'AllVehicles')
) then {
	if ((local _entity) && (local (objectParent _entity))) then {
		(objectParent _entity) deleteVehicleCrew _entity;
	} else {
		['deleteVehicleCrew',(objectParent _entity),_entity] remoteExec ['QS_fnc_remoteExecCmd',(objectParent _entity),FALSE];
	};
};