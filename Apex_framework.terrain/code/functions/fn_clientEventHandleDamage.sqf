/*/
File: fn_clientEventHandleDamage.sqf
Author: 

	Quiksilver
	
Last modified:

	26/01/2024 A3 2.16 by Quiksilver
	
Description:

	-

Context:

	0 : TotalDamage - total damage adjusted before iteration through hitpoints
	1 : HitPoint - some hit point processed during iteration
	2 : LastHitPoint - the last hitpoint from iteration is processed
	3 : HeadHit - head hit is additionally adjusted
	4 : TotalDamageBeforeBleeding - total damage is adjusted before calculating bleeding
___________________________________________________________________/*/

params ['_unit','','_damage','_source','_projectile','_hitPartIndex','_instigator','','_directHit','_context'];
if ((!local _unit) || {(!((lifeState _unit) in ['HEALTHY','INJURED']))} || {(!(isDamageAllowed _unit))}) exitWith {
	((if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)}) min 0.89)
};
_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)};
_damage = _oldDamage + ((_damage - _oldDamage) * (_this call (missionNamespace getVariable 'QS_fnc_clientDamageModifier')));
if (
	(_damage > ((_unit getVariable ['QS_impactPoint',[0,'']]) # 0)) &&
	(_hitPartIndex isNotEqualTo -1)
) then {
	_unit setVariable ['QS_impactPoint',[_damage,_this # 1],FALSE];
};
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
private _incap = FALSE;
_isEnemy = FALSE;
if (isNull _instigator) then {
	_instigator = missionNamespace getVariable ['QS_revive_lastInstigator',objNull];
} else {
	if (
		(_instigator isKindOf 'CAManBase') &&
		{(!isNull (group _instigator))} &&
		{((side (group _instigator)) in _enemySides)}
	) then {
		_isEnemy = TRUE;
		_unit setVariable ['QS_client_lastCombatDamageTime',diag_tickTime + 660,FALSE];
	};
	missionNamespace setVariable ['QS_revive_lastInstigator',_instigator,FALSE];
};
if (_hitPartIndex in [-1,2,7]) then {
	if (_damage > 0.89) then {
		if (scriptDone (missionNamespace getVariable 'QS_script_incapacitated')) then {
			_incap = TRUE;
			if (isDamageAllowed _unit) then {
				_unit allowDamage FALSE;
			};
			missionNamespace setVariable ['QS_script_incapacitated',(_this spawn (missionNamespace getVariable 'QS_fnc_incapacitated')),FALSE];
		};
		_damage = 0.89;
	};
};
if (
	(_hitPartIndex isEqualTo 11) &&
	{_isEnemy} &&
	{!_incap} &&
	{(missionNamespace getVariable ['QS_debug_staggerEnabled',FALSE])}
) then {
	if (
		_directHit &&
		{!isNull _source} &&
		{((missionNamespace getVariable ['QS_debug_staggerChance',0.25]) > (random 1))} &&
		{(isDamageAllowed _unit)} &&
		{(isNull (objectParent _unit))} &&
		{(!((pose _unit) in ['Dead']))} &&
		{((stance _unit) in ['STAND'])} &&				// only when standing
		{(scriptDone (localNamespace getVariable ['QS_script_incapacitated',scriptNull]))} &&
		{(scriptDone (localNamespace getVariable ['QS_client_ragdollScript',scriptNull]))} &&
		{(!([_unit] call QS_fnc_isBusyAttached))}
	) then {
		localNamespace setVariable [
			'QS_client_ragdollScript',
			([
				_unit,
				[
					(((getPosWorld _source) vectorFromTo (getPosWorld _unit)) vectorMultiply 500),
					(_unit selectionPosition ((_unit getVariable ['QS_impactPoint',[0,'']]) # 1))
				]
			] spawn QS_fnc_ragdoll)
		];
		_unit setVariable ['QS_impactPoint',[0,''],FALSE];
	};
};
(_damage min 0.89)