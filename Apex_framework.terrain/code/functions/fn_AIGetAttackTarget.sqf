/*/
File: fn_AIGetAttackTarget.sqf
Author:

	Quiksilver
	
Last Modified:

	7/07/2021 A3 2.04 by Quiksilver
	
Description:

	AI get attack target
__________________________________________/*/

params ['_unit',['_radius',300]];
private _attackTarget = getAttackTarget _unit;
if (!alive _attackTarget) then {
	_attackTarget = assignedTarget _unit;
	if (!alive _attackTarget) then {
		_attackTarget = _unit findNearestEnemy _unit;
		if (!alive _attackTarget) then {
			private _testTargets = _unit targets [true, _radius];
			if (_testTargets isNotEqualTo []) then {
				_attackTarget = selectRandom _testTargets;		// could filter knowsabout but too lazy
			};
		};
	};
};
_attackTarget;