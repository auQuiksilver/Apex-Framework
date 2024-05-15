/*/
File: fn_ragdoll.sqf
Author:

	Quiksilver
	
Last modified:

	17/09/2023 A3 2.14 by Quiksilver
	
Description:

	Ragdoll
	
	[_unit,[[0,1,0],[0,0,0]]] spawn QS_fnc_ragdoll;
__________________________________________________/*/

if !(canSuspend) exitWith {diag_log 'fn_ragdoll must be spawned, not called';};
params [
	['_unit',objNull],
	['_force',[[0,50,0],[0,0,0]]]
];
if (!alive _unit) exitWith {};
if (!scriptDone (_unit getVariable ['QS_unit_ragdoll_script',scriptNull])) exitWith {};
_attached = (attachedObjects _unit) select {!isObjectHidden _x};
if (_attached isNotEqualTo []) exitWith {};
_unit setVariable ['QS_unit_ragdoll_script',_thisScript,FALSE];
if (
	(!isNull (objectParent _unit)) ||
	(!isNull (attachedTo _unit)) ||
	(!((lifeState _unit) in ['HEALTHY','INJURED']))
) exitWith {_unit setVariable ['QS_unit_ragdoll_script',scriptNull,FALSE];};
_unit addForce _force;
_timeout = diag_tickTime + 5;
waitUntil {
	(
		((pose _unit) isEqualTo 'ERROR') ||
		(diag_tickTime > _timeout)
	)
};
if ((lifeState _unit) isEqualTo 'INCAPACITATED') then {
	if (!isNull (attachedTo _unit)) then {
		[0,_unit] call QS_fnc_eventAttach;
	};
	_unit setUnconscious FALSE;
	_unit switchMove ['amovppnemstpsnonwnondnon'];
};
if (diag_tickTime > _timeout) then {
	if (
		(isNull (attachedTo _unit)) &&
		(isNull (objectParent _unit))
	) then {
		_unit switchMove [''];
	};
};
if (!isPlayer _unit) then {
	_unit selectWeapon (primaryWeapon _unit);
};
_unit setVariable ['QS_unit_ragdoll_script',scriptNull,FALSE];