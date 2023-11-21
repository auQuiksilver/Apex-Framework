/*/
File: fn_clientInteractRecruit.sqf
Author:

	Quiksilver
	
Last Modified:

	4/09/2022 A3 2.10
	
Description:

	-
____________________________________________________/*/

private _exit = FALSE;
private _t = cursorTarget;
if ((!isNull (objectParent _t)) || {(isPlayer _t)} || {(!alive _t)}) exitWith {};
if (!(_t isKindOf 'CAManBase')) exitWith {
	((crew _t) select {!isPlayer _x}) joinSilent (group player);
	50 cutText [localize 'STR_QS_Text_119','PLAIN DOWN',0.5];
	(group player) setBehaviourStrong 'AWARE';
	player playActionNow 'gestureHi';
};
private _text = '';
if (['heli',(typeOf _t),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	if ((!(player getUnitTrait 'QS_trait_pilot')) && (!(player getUnitTrait 'QS_trait_fighterPilot'))) then {
		_exit = TRUE;
		_text = format ['%3 %1 ( %2 )',(name _t),(getText ((configOf _t) >> 'displayName')),localize 'STR_QS_Hints_051'];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,_text,[],-1];
	};
} else {
	if ((player getUnitTrait 'QS_trait_pilot') || (player getUnitTrait 'QS_trait_fighterPilot')) then {
		_exit = TRUE;
		_text = format ['%3 %1 ( %2 )',(name _t),(getText ((configOf _t) >> 'displayName')),localize 'STR_QS_Hints_052'];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,_text,[],-1];
	};	
};
if (player getUnitTrait 'QS_trait_HQ') exitWith {
	50 cutText [localize 'STR_QS_Text_118','PLAIN',0.5];
};
if (_exit) exitWith {};
player playActionNow 'gestureHi';
[_t] joinSilent (group player);
_text = format ['%3 %1 ( %2 )',(name _t),(getText ((configOf _t) >> 'displayName')),localize 'STR_QS_Text_119'];
50 cutText [_text,'PLAIN DOWN',0.5];
_t enableStamina FALSE;
_t setAnimSpeedCoef 1.1;
{
	_t enableAIFeature [_x,TRUE];
} count [
	'FSM',
	'TEAMSWITCH',
	'AIMINGERROR',
	'SUPPRESSION',
	'TARGET',
	'AUTOTARGET',
	'MOVE',
	'CHECKVISIBLE'
];
_t setName ['AI','AI','AI'];
_t enableAIFeature ['AUTOCOMBAT',FALSE];
_t enableAIFeature ['COVER',FALSE];
{
	if (['heli',(typeOf _x),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
		_x setSkill 0.1;
		_x setSkill ['aimingAccuracy',0.1];
	} else {
		_x setSkill 0.5;
		_x setSkill ['aimingAccuracy',0.3];
	};
} forEach (units (group player));
(group _t) setBehaviourStrong 'AWARE';
(group player) setBehaviourStrong 'AWARE';
(group _t) setSpeedMode 'FULL';
[_t] call (missionNamespace getVariable 'QS_fnc_clientArsenal');
_t setVariable ['QS_unit_isRecruited',TRUE,TRUE];
_t addEventHandler [
	'HandleDamage',
	{
		params ['_unit','','_damage','_source','','_hitPartIndex','_instigator',''];
		_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _unit)} else {(_unit getHitIndex _hitPartIndex)};
		_damage = _oldDamage + (_damage - _oldDamage) * 0.333;
		_damage;
	}
];
_t addEventHandler [
	'FiredMan',
	{
		if (alive (getAttackTarget (_this # 0))) then {
			_assignedTarget = getAttackTarget (_this # 0);
			if ((isPlayer _assignedTarget) || {(isPlayer (effectiveCommander _assignedTarget))}) then {
				deleteVehicle (_this # 6);
			};
		};
	}
];
_t addEventHandler [
	'Killed',
	{
		params ['_entity','_killer','_instigator'];
		if (
			(isNull _killer) ||
			{(isPlayer _killer)} ||
			{(isPlayer (effectiveCommander _killer))} ||
			{(isPlayer _instigator)}
		) then {
			removeAllWeapons _entity;
			removeAllAssignedItems _entity;
			removeAllItems _entity;
			{
				_entity removeMagazine _x;
			} forEach (magazines _entity);
		};
	}
];
[19,_t,player] remoteExec ['QS_fnc_remoteExec',0,FALSE];
TRUE;