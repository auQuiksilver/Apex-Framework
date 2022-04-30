/*/
File: fn_setUnitRole.sqf
Author:

	Quiksilver
	
Last Modified:

	13/10/2018 A3 1.84 by Quiksilver
	
Description:

	Set Unit Role
	
Notes:

	<unit> setVariable ['QS_unit_role','',TRUE];
	Executed only on server, propagated to client
___________________________________________/*/

params ['_unit','_role'];
_uid = getPlayerUID _unit;
_side = side (group _unit);
_rolesData = call (missionNamespace getVariable 'QS_data_roles');
_roles = missionNamespace getVariable ['QS_unit_roles',[]];

_roleIndex = _rolesData findIf {((_x select 0) isEqualTo _role)};

if (_roleIndex isEqualTo -1) exitWith {
	diag_log (format ['***** QS ROLES ***** error role %1 does not exist',_role]);
};
_roleData = _rolesData select _roleIndex;

_roleData params ['_roleData_role','_roleData_roleDisplayName','_roleData_minSlotsNumber','_roleData_maxSlotsNumber','_roleData_unlockCoef','_roleData_whitelist'];

_rolesData_availableSlotsNumber = _roleData_minSlotsNumber max (round ((count allPlayers) / _roleData_unlockCoef)) min _roleData_maxSlotsNumber;

_roles_currentSlotNumber = count (_roles select {((_x select 0) isEqualTo _role)});

if (_roles_currentSlotNumber < _rolesData_availableSlotsNumber) then {
	_unitRoleIndex = (missionNamespace getVariable ['QS_unit_roles',[]]) findIf {((_x select 2) isEqualTo _uid)};
	if (_unitRoleIndex isEqualTo -1) then {
		diag_log (format ['***** QS ROLES ***** error unit %1 is not assigned',_uid]);
	} else {;
		_unitRoleData = (missionNamespace getVariable ['QS_unit_roles',[]]) select _unitRoleIndex;
		_unitRoleData set [0,_role];
		_unitRoleData set [3,serverTime];
		(missionNamespace getVariable ['QS_unit_roles',[]]) set [_unitRoleIndex,_unitRoleData]; //[_role,_unit,_uid,serverTime,-1];
		_unit setVariable ['QS_unit_role',_role,TRUE];
		[16,_role] remoteExec ['QS_fnc_remoteExec',_unit,FALSE];
	};
};