/*/
File: fn_AIXThrow.sqf
Author:

	Quiksilver
	
Last modified:

	24/03/2018 A3 1.82 by Quiksilver
	
Description:

	Throw grenade
__________________________________________________/*/

params [['_unit',objNull],['_target',objNull],['_type','SMOKE'],['_turnTo',FALSE]];
if (isNull _target) then {
	_target = _unit findNearestEnemy _unit;
};
_distance = if (!isNull _target) then {_unit distance _target} else {-1};
private _frontPos = _unit getRelPos [10,0];
_frontPos = AGLToASL _frontPos;
_frontPos set [2,((_frontPos select 2) + 2)];
_frontPosVisible = [_unit,'GEOM',objNull] checkVisibility [(eyePos _unit),_frontPos];
if (_frontPosVisible isEqualTo 1) exitWith {};
_fragType = if (_type isEqualTo 'SMOKE') then {['smokeshell','smokeshellmuzzle']} else {if ((_distance isEqualTo -1) || {(_distance > 40)}) then {['minigrenade','minigrenademuzzle']} else {['handgrenade','handgrenademuzzle']};};
_unit setWeaponReloadingTime [_unit,(_fragType select 1),0];
for '_x' from 0 to 2 step 1 do {
	_unit addMagazine (_fragType select 0);
};
if ((!isNull _target) && {(_turnTo)}) then {
	_targetPosition = if ((((_unit targetKnowledge _target) select 6) isEqualTo [0,0,0]) || (((_unit targetKnowledge _target) select 5) > 50)) then {(getPosATL _target)} else {((_unit targetKnowledge _target) select 6)};
	_unit setDir (_unit getDir _targetPosition);
};
_unit forceWeaponFire [(_fragType select 1),(_fragType select 1)];
_unit forceWeaponFire [(_fragType select 1),(_fragType select 1)];
_unit setWeaponReloadingTime [_unit,(_fragType select 1),0];
TRUE;