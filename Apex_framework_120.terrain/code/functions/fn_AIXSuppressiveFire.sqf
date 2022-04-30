/*/
File: fn_AIXSuppressiveFire.sqf
Author:

	Quiksilver
	
Last modified:

	8/04/2018 A3 1.82 by Quiksilver
	
Description:

	Attempt suppressive fire
__________________________________________________/*/

params ['_unit'];
_target = getAttackTarget _unit;
if (alive _target) then {
	_unit removeEventHandler ['FiredMan',_thisEventHandler];
	_unit setVariable ['QS_AI_UNIT_sfEvent',FALSE,FALSE];
	if ((combatMode _unit) isNotEqualTo 'RED') then {
		_unit setCombatMode 'RED';
	};
	if ((behaviour _unit) isNotEqualTo 'COMBAT') then {
		_unit setBehaviour 'COMBAT';
	};
	_unit doSuppressiveFire (aimPos _target);
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime + (random [20,40,60])),FALSE];
} else {
	_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',(diag_tickTime + (random [5,10,15])),FALSE];
};