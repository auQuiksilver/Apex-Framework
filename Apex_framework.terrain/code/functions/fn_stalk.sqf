/*/
File: fn_stalk.sqf
Author:

	Quiksilver
	
Last Modified:

	11/03/2018 A3 1.81 by Quiksilver
	
Description:

	AI group stalks target
	
Example:

	script_stalk = [
		QS_predatorGroup,
		QS_prey,
		{FALSE},
		10,
		'RED',
		'AWARE',
		'FULL',
		'AUTO',
		0,
		FALSE
	] spawn QS_fnc_stalk;
_________________________________________________/*/
scriptName 'QS Stalker Script';
params ['_predatorGrp','_prey','_condition','_refreshRate','_combatMode','_behaviour','_speedMode','_unitPos','_reveal','_stamina'];
if (
	(_predatorGrp isEqualTo []) ||
	{(isNull _prey)} ||
	{(!alive _prey)} ||
	{(!local _predatorGrp)} ||
	{(((units _predatorGrp) findIf {(alive _x)}) isEqualTo -1)} ||
	{(!isNil {_predatorGrp getVariable 'QS_AI_GRP_stalker'})}
) exitWith {};
_predatorGrp setVariable ['QS_AI_GRP_stalker',TRUE,FALSE];
_priorBehaviour = behaviour (leader _predatorGrp);
_priorCombatMode = combatMode _predatorGrp;
_priorUnitPos = unitPos (leader _predatorGrp);
_priorPosition = getPosATL (leader _predatorGrp);
_priorAnimSpeedCoef = getAnimSpeedCoef (leader _predatorGrp);
_predatorGrp allowFleeing 0;
_predatorGrp setVariable ['QS_AI_GRP_stalker_priorPosition',_priorPosition,FALSE];
{
	_x setAnimSpeedCoef 1.1;
} count (units _predatorGrp);
if (!((combatMode _predatorGrp) isEqualTo _combatMode)) then {
	_predatorGrp setCombatMode _combatMode;
};
if (!((behaviour (leader _predatorGrp)) isEqualTo _behaviour)) then {
	{
		_x setBehaviourStrong _behaviour;
	} count (units _predatorGrp);
};
_predatorGrp setSpeedMode _speedMode;
if (!((unitPos (leader _predatorGrp)) isEqualTo _unitPos)) then {
	{
		_x setUnitPosWeak 'AUTO';
	} count (units _predatorGrp);
};
if (_stamina) then {
	if (!isStaminaEnabled (leader _predatorGrp)) then {
		{
			_x enableStamina TRUE;
		} count (units _predatorGrp);
	};
} else {
	if (isStaminaEnabled (leader _predatorGrp)) then {
		{
			_x enableFatigue FALSE;
			_x enableStamina FALSE;
		} count (units _predatorGrp);
	};
};
{
	_x disableAI 'SUPPRESSION';
	_x disableAI 'AUTOCOMBAT';
	_x disableAI 'COVER';
	_x commandTarget objNull;
} forEach (units _predatorGrp);
for '_x' from 0 to 3 step 1 do {
	if ((waypoints _predatorGrp) isEqualTo []) exitWith {};
	deleteWaypoint ((waypoints _predatorGrp) select 0);
};
sleep 3;
for '_x' from 0 to 1 step 0 do {
	if (((units _predatorGrp) findIf {(alive _x)}) isEqualTo -1) exitWith {};
	if ((isNull _prey) || {(!alive _prey)}) exitWith {};
	if (call _condition) exitWith {};
	{
		if (alive _x) then {
			doStop _x;
			_x doMove (getPosATL _prey);
		};
	} forEach (units _predatorGrp);
	sleep _refreshRate;
};
if (!(((units _predatorGrp) findIf {(alive _x)}) isEqualTo -1)) then {
	_predatorGrp setVariable ['QS_AI_GRP_stalker',FALSE,FALSE];
	_predatorGrp setCombatMode _priorCombatMode;
	{
		_x setBehaviourStrong _priorBehaviour;
	} count (units _predatorGrp);	
	{
		_x setAnimSpeedCoef _priorAnimSpeedCoef;
	} count (units _predatorGrp);
} else {
	deleteGroup _predatorGrp;
};