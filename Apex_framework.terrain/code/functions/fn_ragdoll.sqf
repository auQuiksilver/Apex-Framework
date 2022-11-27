/*/
File: fn_ragdoll.sqf
Author:

	Quiksilver
	
Last modified:

	27/11/2022 A3 2.10 by Quiksilver
	
Description:

	Ragdoll
__________________________________________________/*/

if !(canSuspend) exitWith {
	systemchat 'fn_ragdoll must be spawned, not called';
};
missionNamespace setVariable ['QS_client_ragdoll_script',_thisScript,FALSE];
params [
	['_unit',player],
	['_force',[[0,1,0],[0,0,0]]]
];
_unit addForce _force;
_timeout = diag_tickTime + 20;
waitUntil {
	(
		((pose _unit) isEqualTo 'ERROR') ||
		((lifeState _unit) isNotEqualTo 'INCAPACITATED') ||
		(diag_tickTime > _timeout)
	)
};
if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
	if (!isNull (attachedTo _unit)) then {
		detach _unit;
	};
	_unit setUnconscious FALSE;
};
if (diag_tickTime > _timeout) then {
	if (
		(isNull (attachedTo _unit)) &&
		(isNull (objectParent _unit))
	) then {
		_unit switchMove '';
	};
};
missionNamespace setVariable ['QS_client_ragdoll_script',scriptNull,FALSE];