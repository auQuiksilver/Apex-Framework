/*/
File: fn_AIGroupEventEnemyDetected.sqf
Author:

	Quiksilver
	
Last Modified:

	28/08/2022 A3 2.10 by Quiksilver
	
Description:

	AI Group Event Enemy Detected
___________________________________________/*/

params [['_grp',grpNull],['_target',objNull]];
_grp removeEventHandler [_thisEvent,_thisEventHandler];
_grp setVariable ['QS_AI_GRP_EH_ED_cooldown',(serverTime + (60 + (random 120))),FALSE];
if (
	(alive _target) &&
	{
		(
			((_target distance2D (leader _grp)) > 1000)
			||
			{
				(
					!(isTouchingGround (vehicle _target))
				)
			}
			||
			{
				(
					(_target isKindOf 'CAManBase') &&
					{!((lifeState _target) in ['HEALTHY','INJURED'])}
				)
			}
		)
	}
) exitWith {};
//===== Analyze target
_isVehicle = _target isKindOf 'LandVehicle';
_isTank = _target isKindOf 'Tank';
_isAir = (_target isKindOf 'Air') && (!isTouchingGround _target);
private _unit = objNull;
private _doingSomething = FALSE;
if (
	((behaviour (leader _grp)) in ['SAFE','AWARE']) ||
	((random 1) > 0.5)
) then {
	_grp setFormDir ((leader _grp) getDir _target);
};
if ((random 1) > 0.5) then {
	_grp setFormation 'LINE';
};
{
	if (_x isNotEqualTo (leader _grp)) then {
		_unit = _x;
		_doingSomething = FALSE;
		if ((_isTank) || (_isAir)) then {
			if ((secondaryWeapon _unit) isNotEqualTo '') then {
				_unit doTarget _target;
			};
		};
		if (
			(_unit getVariable ['QS_AI_UNIT_isMG',FALSE]) || 
			{(_unit getVariable ['QS_AI_UNIT_isGL',FALSE])}
		) then {
			// SUPPRESS
			if (
				((random 1) > 0.5) &&
				{(!_isTank)} &&
				{(!_isAir)} &&
				{((currentCommand _unit) isNotEqualTo 'Suppress')} &&
				{(([_unit,'VIEW',_target] checkVisibility [eyePos _unit,aimPos _target]) > 0)}
			) then {
				_doingSomething = TRUE;
				[_unit,_target,1,TRUE,TRUE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
			};
		};
		if (
			(!(_doingSomething)) && 
			((random 1) > 0.666)
		) then {
			if ((random 1) > 0.5) then {
				// SMOKE
				if (
					(serverTime > (_unit getVariable ['QS_AI_UNIT_lastSmoke',-1])) &&
					{(((_unit distance2D _target) < 300) || {((getSuppression _unit) > 0)})}
				) then {
					QS_AI_managed_smoke = QS_AI_managed_smoke select {(serverTime < _x)};
					if ((count QS_AI_managed_smoke) < QS_AI_managed_smoke_max) then {
						QS_AI_managed_smoke pushBack (serverTime + 45);
						_unit setVariable ['QS_AI_UNIT_lastSmoke',(serverTime + (random [15,30,45])),FALSE];
						[_unit,_target,'SMOKE',TRUE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
					};
				};
			} else {
				// FRAG
				if (
					(serverTime > (_unit getVariable ['QS_AI_UNIT_lastFrag',-1])) &&
					{((_unit distance2D _target) < 65)}
				) then {
					QS_AI_managed_frags = QS_AI_managed_frags select {(serverTime < _x)};
					if ((count QS_AI_managed_frags) < QS_AI_managed_frags_max) then {
						QS_AI_managed_frags pushBack (serverTime + 15);
						_unit setVariable ['QS_AI_UNIT_lastFrag',(serverTime + (random [15,45,65])),FALSE];
						[_unit,_target,'FRAG',TRUE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
					};
				};
			};
		};
	};
} forEach (units _grp);