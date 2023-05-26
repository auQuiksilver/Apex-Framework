/*/
File: fn_clientEventHandleDamage.sqf
Author: 

	Quiksilver
	
Last modified:

	24/05/2023 A3 2.12 by Quiksilver
	
Description:

	-
___________________________________________________________________/*/

params ['_unit','','_damage','_source','','_hitPartIndex','_instigator','','_directHit'];
if ((!local _unit) || {(!((lifeState _unit) in ['HEALTHY','INJURED']))} || {(!(isDamageAllowed _unit))}) exitWith {
	((if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)}) min 0.89)
};
_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)};
_damage = _oldDamage + ((_damage - _oldDamage) * (_this call (missionNamespace getVariable 'QS_fnc_clientDamageModifier')));
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_hitArray',_this,FALSE],
	['BIS_wasHit',TRUE,FALSE]
];
_enemySides = _unit getVariable ['QS_unit_enemySides',[EAST,RESISTANCE]];
if (isNull _source) then {
	_source = missionNamespace getVariable ['QS_revive_lastSource',objNull];
} else {
	if (
		(_source isKindOf 'CAManBase') &&
		{((side _source) in _enemySides)}
	) then {
		if (isObjectHidden _source) then {
			if (diag_tickTime > (uiNamespace getVariable ['QS_forceUnhideDelay',-1])) then {
				uiNamespace setVariable ['QS_forceUnhideDelay',diag_tickTime + 30];
				['hideObjectGlobal',_source,FALSE] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
			};
		};
		if (!isDamageAllowed _source) then {
			_source allowDamage TRUE;
		};
		_unit setVariable ['QS_client_lastCombatDamageTime',diag_tickTime + 660,FALSE];
	};
	missionNamespace setVariable ['QS_revive_lastSource',_source,FALSE];
};
if (isNull _instigator) then {
	_instigator = missionNamespace getVariable ['QS_revive_lastInstigator',objNull];
} else {
	if (
		(_instigator isKindOf 'CAManBase') &&
		{(!isNull (group _instigator))} &&
		{((side (group _instigator)) in _enemySides)}
	) then {
		_unit setVariable ['QS_client_lastCombatDamageTime',diag_tickTime + 660,FALSE];
	};
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