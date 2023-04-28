/*/
File: fn_AIXThrow.sqf
Author:

	Quiksilver
	
Last modified:

	1/06/2022 A3 2.08 by Quiksilver
	
Description:

	Throw grenade
__________________________________________________/*/

params [['_unit',objNull],['_target',objNull],['_type','SMOKE'],['_turnTo',FALSE]];
if (!(_target isEqualType objNull)) then {
	_target = _unit findNearestEnemy _unit;
};
if (!alive _target) then {
	_target = [_unit,500,TRUE] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
};
_distance = if (alive _target) then {_unit distance _target} else {-1};
if (
	(([_unit,'GEOM',objNull] checkVisibility [(eyePos _unit),(eyePos _unit) vectorAdd [0,5,0]]) isNotEqualTo 1) ||
	{(([_unit,(getPosWorld _unit)] call (missionNamespace getVariable 'QS_fnc_inHouse')) # 0)}
) exitWith {};
_fragType = if (_type isEqualTo 'SMOKE') then {['smokeshell','smokeshellmuzzle']} else {if ((_distance isEqualTo -1) || {(_distance > 40)}) then {[QS_core_classNames_miniGrenade,'minigrenademuzzle']} else {[QS_core_classNames_handGrenade,'handgrenademuzzle']};};
_unit setWeaponReloadingTime [_unit,(_fragType # 1),0];
for '_x' from 0 to 2 step 1 do {
	_unit addMagazine (_fragType # 0);
};
if ((alive _target) && _turnTo) then {
	_targetPosition = (_unit targetKnowledge _target) # 6;
	_unit setDir (_unit getDir _targetPosition);
};
_unit forceWeaponFire [(_fragType # 1),(_fragType # 1)];
_unit forceWeaponFire [(_fragType # 1),(_fragType # 1)];	// yes, twice
_unit setWeaponReloadingTime [_unit,(_fragType # 1),0];
TRUE;