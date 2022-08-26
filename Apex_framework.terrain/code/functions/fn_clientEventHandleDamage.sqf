/*/
File: fn_clientEventHandleDamage.sqf
Author: 

	Quiksilver
	
Last modified:

	21/08/2022 A3 2.10 by Quiksilver
	
Description:

	-
___________________________________________________________________/*/

params ['_unit','','_damage','_source','','_hitPartIndex','_instigator',''];
if ((!local _unit) || {(!((lifeState _unit) in ['HEALTHY','INJURED']))} || {(!(isDamageAllowed _unit))}) exitWith {
	((if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)}) min 0.95)
};
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_hitArray',_this,FALSE],
	['BIS_wasHit',TRUE,FALSE]
];
_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)};
_damage = _oldDamage + (_damage - _oldDamage) * (_this call (missionNamespace getVariable 'QS_fnc_clientDamageModifier'));
if (isNull _source) then {
	_source = missionNamespace getVariable ['QS_revive_lastSource',objNull];
} else {
	if (
		(_source isKindOf 'Man') &&
		{((side _source) in [EAST,RESISTANCE])}
	) then {
		if (isObjectHidden _source) then {
			_source hideObject FALSE;
		};
	};
	missionNamespace setVariable ['QS_revive_lastSource',_source,FALSE];
};
if (isNull _instigator) then {
	_instigator = missionNamespace getVariable ['QS_revive_lastInstigator',objNull];
} else {
	missionNamespace setVariable ['QS_revive_lastInstigator',_instigator,FALSE];
};
if (_hitPartIndex in [-1,2,7]) then {
	if (_damage > 0.95) then {
		if (scriptDone (missionNamespace getVariable 'QS_script_incapacitated')) then {
			if (isDamageAllowed _unit) then {
				_unit allowDamage FALSE;
			};
			missionNamespace setVariable ['QS_script_incapacitated',(_this spawn (missionNamespace getVariable 'QS_fnc_incapacitated')),FALSE];
		};
		_damage = 0.95;
	};
};
(_damage min 0.95)