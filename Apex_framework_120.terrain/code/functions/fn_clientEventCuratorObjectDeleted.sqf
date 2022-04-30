/*/
File: fn_clientEventCuratorObjectDeleted.sqf
Author:

	Quiksilver
	
Last modified:

	30/10/2018 A3 1.84 by Quiksilver
	
Description:

	Event Curator Object Deleted
__________________________________________________/*/

params ['_module','_entity'];
if (_entity isKindOf 'CAManBase') then {
	if (!isNull (group _entity)) then {
		if (!isNull (objectParent _entity)) then {
			if ((objectParent _entity) isKindOf 'AllVehicles') then {
				if ((local _entity) && (local (objectParent _entity))) then {
					(objectParent _entity) deleteVehicleCrew _entity;
				} else {
					['deleteVehicleCrew',(objectParent _entity),_entity] remoteExec ['QS_fnc_remoteExecCmd',(objectParent _entity),FALSE];
				};
			};
		};
	};
};