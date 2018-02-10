/*/
File: fn_clientEventHandleDamage.sqf
Author: 

	Quiksilver
	
Last modified:

	18/12/2017 A3 1.80 by Quiksilver
	
Description:

	-
___________________________________________________________________/*/

params ['_unit','','_damage','_source','','_hitPartIndex','_instigator',''];
if ((!local _unit) || {(!((lifeState _unit) in ['HEALTHY','INJURED']))} || {(!(isDamageAllowed _unit))}) exitWith {
	((if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)}) min 0.89)
};
_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)};
_damage = _oldDamage + (_damage - _oldDamage) * (_this call (missionNamespace getVariable 'QS_fnc_clientDamageModifier'));
if (isNull _source) then {
	_source = missionNamespace getVariable ['QS_revive_lastSource',objNull];
} else {
	missionNamespace setVariable ['QS_revive_lastSource',_source,FALSE];
};
if (isNull _instigator) then {
	_instigator = missionNamespace getVariable ['QS_revive_lastInstigator',objNull];
} else {
	missionNamespace setVariable ['QS_revive_lastInstigator',_instigator,FALSE];
};
if (_hitPartIndex in [-1,2,7]) then {
	if (_damage > 0.89) then {
		if (scriptDone (missionNamespace getVariable 'QS_script_incapacitated')) then {
			if (isDamageAllowed _unit) then {
				_unit allowDamage FALSE;
			};
			missionNamespace setVariable ['QS_script_incapacitated',(_this spawn (missionNamespace getVariable 'QS_fnc_incapacitated')),FALSE];
		};
		_damage = 0.89;
	};
};
(_damage min 0.89)