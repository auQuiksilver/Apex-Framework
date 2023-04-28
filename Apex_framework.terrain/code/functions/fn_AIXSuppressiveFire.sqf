/*/
File: fn_AIXSuppressiveFire.sqf
Author:

	Quiksilver
	
Last modified:

	27/05/2022 A3 2.10 by Quiksilver
	
Description:

	Fired Event Handler - Attempt Suppressive Fire
__________________________________________________/*/

params ['_unit','_weapon','','','','','_projectile'];
_unit removeEventHandler [_thisEvent,_thisEventHandler];
if (
	(_weapon in ['Throw','Put']) ||
	{(!scriptDone (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull]))} ||
	{(_unit getVariable ['QS_AI_disableSuppFire',FALSE])} ||
	{((currentCommand _unit) isEqualTo 'Suppress')}
) exitWith {};
if ((random 1) > 0.5) exitWith {
	_projectile addEventHandler [
		'HitPart',
		{
			params ['_projectile','','_shooter','_pos'];
			_projectile removeEventHandler [_thisEvent,_thisEventHandler];
			if ((_pos distance2D _shooter) > 500) then {
				_pos = _pos vectorAdd [0,0,2];
			};
			if ((random 1) > 0.5) then {
				[_shooter,_pos,selectRandomWeighted [1,0.75,2,0.25],FALSE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
			} else {
				_shooter doSuppressiveFire _pos;
			};
		}
	];
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [20,40,60])),FALSE];
};
private _target = getAttackTarget _unit;
if (!alive _target) then {
	_target = [_unit,selectRandomWeighted [0,1,500,1],TRUE] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
};
if (alive _target) then {
	[_unit,_target,selectRandomWeighted [1,0.75,2,0.25],FALSE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(serverTime + (random [20,40,60])),FALSE];
};