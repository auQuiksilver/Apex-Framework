/*/
File: fn_AIGetAttackTarget.sqf
Author:

	Quiksilver
	
Last Modified:

	28/05/2022 A3 2.10 by Quiksilver
	
Description:

	AI get attack target
__________________________________________/*/

params [
	['_unit',objNull],
	['_radius',300],
	['_grounded',TRUE]
];
if (!alive _unit) exitWith {objNull};
private _attackTarget = getAttackTarget _unit;
if (!alive _attackTarget) then {
	_attackTarget = assignedTarget _unit;
	if (!alive _attackTarget) then {
		_attackTarget = _unit findNearestEnemy _unit;
		if (
			(alive _attackTarget) &&
			{(!((_unit distance2D _attackTarget) <= _radius))}
		) then {
			_attackTarget = objNull;
		};
		if (!alive _attackTarget) then {
			private _testTargets = _unit targets [TRUE,_radius];
			if (_testTargets isNotEqualTo []) then {
				if (_grounded) then {
					_testTargets = _testTargets select {(isTouchingGround (vehicle _x))};
				};
				if (_testTargets isNotEqualTo []) then {
					_testTargets = _testTargets apply { [_unit knowsAbout _x,_x] };
					_testTargets sort FALSE;
					_attackTarget = (_testTargets # 0) # 1;
				};
			};
		};
	};
};
if (
	(alive _attackTarget) &&
	{
		(
			(
				(_radius isNotEqualTo 0) && 
				{((_attackTarget distance2D _unit) > _radius)}
			) 
			||
			{
				(
					_grounded &&
					{!(isTouchingGround (vehicle _attackTarget))}
				)
			}
			||
			{
				(
					(_attackTarget getEntityInfo 0) &&
					{!((lifeState _attackTarget) in ['HEALTHY','INJURED'])}
				)
			}
		)
	}
) exitWith {objNull};
_attackTarget;