/*/
File: fn_AIXCivPanic.sqf
Author:

	Quiksilver
	
Last modified:

	21/09/2022 A3 2.10 by Quiksilver
	
Description:

	Civilian panic event (Explosion + FiredNear)
__________________________________________________/*/

params ['_unit'];
if (
	(!(local _unit)) ||
	{(!(simulationEnabled _unit))}
) exitWith {};
{
	_unit removeEventHandler _x;
} forEach (_unit getVariable ['QS_AI_ENTITY_PANIC_EVENTS',[]]);
{
	_unit setVariable _x;
} forEach [
	['QS_AI_ENTITY_PANIC_DELAY',(diag_tickTime + (30 + (random 60))),FALSE],
	['QS_AI_ENTITY_PANIC_EVENTS',[],FALSE],
	['QS_AI_ENTITY_PANIC',FALSE,FALSE],
	['QS_AI_ENTITY_PANIC_ACTIVE',TRUE,FALSE]
];
_unit doWatch objNull;
if (_thisEvent isEqualTo 'FiredNear') exitWith {
	params ['','_shooter','_distance'];
	_unit playMoveNow (selectRandom ['ApanPknlMsprSnonWnonDf','ApanPercMsprSnonWnonDf']);
	_agent forceSpeed 24;
	_panicPos = _unit getPos [(50 + (random 100)),(selectRandom [(_shooter getDir _unit),(random 360)])];
	if (!surfaceIsWater _panicPos) then {
		_unit setDestination [_panicPos,'LEADER PLANNED',((random 1) > 0.5)];
	};
};
if (_thisEvent isEqualTo 'Explosion') exitWith {
	_unit playMoveNow (selectRandom ['ApanPknlMsprSnonWnonDf','ApanPercMsprSnonWnonDf']);
	_agent forceSpeed 24;
	_panicPos = _unit getPos [(50 + (random 100)),(random 360)];
	if (!surfaceIsWater _panicPos) then {
		_unit setDestination [_panicPos,'LEADER PLANNED',((random 1) > 0.5)];
	};
};