/*/
File: fn_AIDoSuppressiveFire.sqf
Author:

	Quiksilver
	
Last modified:

	24/10/2022 A3 2.10 by Quiksilver
	
Description:

	Do Suppressive Fire
__________________________________________________/*/

params [
	['_unit',objNull],
	['_target',objNull],
	['_type',1],
	['_watch',FALSE],
	['_doTarget',FALSE],
	['_checkTerrain',FALSE],
	['_checkVisibility',-1]
];
_objectParent = objectParent _unit;
_unitOnFoot = isNull _objectParent;
_targetIsObject = _target isEqualType objNull;
private _eyePos = if (_unitOnFoot) then {
	(eyePos _unit)
} else {
	(_objectParent modelToWorldWorld ([_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd')))
};
if (
	((currentCommand _unit) isEqualTo 'Suppress') ||
	{((behaviour _unit) isEqualTo 'STEALTH')} ||
	{(_unitOnFoot && {((primaryWeapon _unit) isEqualTo '')})} ||
	{(!_unitOnFoot && {((currentMuzzle _unit) isEqualTo '')})} ||
	{(_checkTerrain && {_targetIsObject} && {terrainIntersectASL [_eyePos,aimPos _target]})} ||
	{(_checkTerrain && {!_targetIsObject} && {terrainIntersectASL [_eyePos,_target]})} ||
	{(_unitOnFoot && {(_checkVisibility isNotEqualTo -1)} && {_targetIsObject} && {(!([_unit,'VIEW',_target] checkVisibility [_eyePos,aimPos _target] >= _checkVisibility))})} ||
	{(!_unitOnFoot && {(_checkVisibility isNotEqualTo -1)} && {_targetIsObject} && {(!([_objectParent,'VIEW',_target] checkVisibility [_eyePos,aimPos _target] >= _checkVisibility))})}
) exitWith {FALSE};
if (_watch || (!_unitOnFoot)) then {
	if (_targetIsObject) then {
		_unit doWatch _target;
	} else {
		_unit doWatch (ASLToAGL _target);
	};
};
if (_doTarget && {_targetIsObject}) then {_unit doTarget _target;};
if (_unitOnFoot) then {
	_unit setAmmo [primaryWeapon _unit,500];
} else {
	_objectParent setAmmo [currentMuzzle _unit,500];
};
if (_type isEqualTo 1) exitWith {
	_unit doSuppressiveFire _target;
	TRUE;
};
if (_type isEqualTo 2) exitWith {
	if (_unitOnFoot) then {
		if (_targetIsObject) then {
			_unit doSuppressiveFire ((_unit modelToWorldWorld (_unit selectionPosition 'righthand')) vectorAdd ((vectorNormalized ((aimPos _target) vectorDiff (_unit modelToWorldWorld (_unit selectionPosition 'righthand')))) vectorMultiply (25 + (random 40))));
		} else {
			_unit doSuppressiveFire ((_unit modelToWorldWorld (_unit selectionPosition 'righthand')) vectorAdd ((vectorNormalized (_target vectorDiff (_unit modelToWorldWorld (_unit selectionPosition 'righthand')))) vectorMultiply (25 + (random 40))));
		};
	} else {
		if (_targetIsObject) then {
			[_objectParent,_unit,_target] spawn {
				params ['_objectParent','_unit','_target'];
				_timeout = diag_tickTime + 3;
				waitUntil {
					_unit doWatch _target;
					(
						((_objectParent aimedAtTarget [_target]) > 0.8) ||
						(diag_tickTime > _timeout)
					)
				};
				_eyePos = _objectParent modelToWorldWorld ([_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd'));
				_unit doSuppressiveFire (_eyePos vectorAdd ((vectorNormalized ((aimPos _target) vectorDiff _eyePos)) vectorMultiply (25 + (random 40))));
			};
		} else {
			[_objectParent,_unit,_target] spawn {
				params ['_objectParent','_unit','_target'];
				_timeout = diag_tickTime + 2;
				waitUntil {	
					_unit doWatch _target;
					(diag_tickTime > _timeout)
				};
				_eyePos = _objectParent modelToWorldWorld ([_objectParent,0] call (missionNamespace getVariable 'QS_fnc_getVehicleGunEnd'));
				_unit doSuppressiveFire (_eyePos vectorAdd ((vectorNormalized (_target vectorDiff _eyePos)) vectorMultiply (25 + (random 40))));
			};
		};
	};
	TRUE;
};
FALSE;