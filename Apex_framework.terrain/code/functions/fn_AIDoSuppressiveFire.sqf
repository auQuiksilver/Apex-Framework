/*/
File: fn_AIXSuppressiveFire.sqf
Author:

	Quiksilver
	
Last modified:

	12/06/2022 A3 2.10 by Quiksilver
	
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
_targetIsObject = _target isEqualType objNull;
if (
	((currentCommand _unit) isEqualTo 'Suppress') ||
	{((behaviour _unit) isEqualTo 'STEALTH')} ||
	{((primaryWeapon _unit) isEqualTo '')} ||
	{(_checkTerrain && {_targetIsObject} && {terrainIntersectASL [eyePos _unit,aimPos _target]})} ||
	{(_checkTerrain && {!_targetIsObject} && {terrainIntersectASL [eyePos _unit,_target]})} ||
	{((_checkVisibility isNotEqualTo -1) && {_targetIsObject} && {(!([_unit,'VIEW',_target] checkVisibility [eyePos _unit,aimPos _target] >= _checkVisibility))})}
) exitWith {};
if (_watch) then {
	if (_targetIsObject) then {
		_unit doWatch _target;
	} else {
		_unit doWatch (ASLToAGL _target);
	};
};
if (_doTarget && {_targetIsObject}) then {_unit doTarget _target;};
if (isNull (objectParent _unit)) then {
	_unit setAmmo [primaryWeapon _unit,500];
} else {
	(objectParent _unit) setAmmo [currentWeapon (objectParent _unit),500];
};
if (_type isEqualTo 1) exitWith {
	_unit doSuppressiveFire _target;
};
if (_type isEqualTo 2) exitWith {
	_startPos = _unit modelToWorldWorld (_unit selectionPosition 'righthand');
	if (_targetIsObject) then {
		_unit doSuppressiveFire (_startPos vectorAdd ((vectorNormalized ((aimPos _target) vectorDiff _startPos)) vectorMultiply (25 + (random 40))));
	} else {
		_unit doSuppressiveFire (_startPos vectorAdd ((vectorNormalized (_target vectorDiff _startPos)) vectorMultiply (25 + (random 40))));
	};
};