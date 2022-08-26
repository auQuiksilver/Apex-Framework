/*/
File: fn_AIXSuppressiveFire.sqf
Author:

	Quiksilver
	
Last modified:

	27/05/2022 A3 2.10 by Quiksilver
	
Description:

	Fired Event Handler - Attempt Suppressive Fire
__________________________________________________/*/

params ['_unit','_weapon'];
_unit removeEventHandler [_thisEvent,_thisEventHandler];
_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [20,40,60])),FALSE];
if (
	(_weapon in ['Throw','Put']) ||
	{(!scriptDone (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull]))} ||
	{(_unit getVariable ['QS_AI_disableSuppFire',FALSE])} ||
	{((currentCommand _unit) isEqualTo 'Suppress')}
) exitWith {};
private _target = getAttackTarget _unit;
if (!alive _target) then {
	_target = [_unit,500,TRUE] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
};
if (alive _target) then {
	[_unit,_target,selectRandomWeighted [1,0.75,2,0.25],TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [20,40,60])),FALSE];
} else {
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [5,10,15])),FALSE];
};