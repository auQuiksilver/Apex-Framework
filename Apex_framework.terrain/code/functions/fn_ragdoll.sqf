/*/
File: fn_ragdoll.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 2.10 by Quiksilver
	
Description:

	Ragdoll
	
	
	[_unit,[[0,1,0],[0,0,0]]] call QS_fnc_ragdoll;
__________________________________________________/*/

if (!scriptDone (missionNamespace getVariable ['QS_client_ragdoll_script',scriptNull])) exitWith {};
if !(canSuspend) exitWith {diag_log localize 'STR_QS_DiagLogs_140';};
_attached = attachedObjects
params [
	['_unit',player],
	['_force',[[0,50,0],[0,0,0]]]
];
_attached = (attachedObjects _unit) select {!isObjectHidden _x};
if (_attached isNotEqualTo []) exitWith {};
missionNamespace setVariable ['QS_client_ragdoll_script',_thisScript,FALSE];
if (
	(!isNull (objectParent _unit)) ||
	(!isNull (attachedTo _unit)) ||
	(!((lifeState _unit) in ['HEALTHY','INJURED']))
) exitWith {missionNamespace setVariable ['QS_client_ragdoll_script',scriptNull,FALSE];};
_unit addForce _force;
_timeout = diag_tickTime + 10;
waitUntil {
	(
		((pose _unit) isEqualTo 'ERROR') ||
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