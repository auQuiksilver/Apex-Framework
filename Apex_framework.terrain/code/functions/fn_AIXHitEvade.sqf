/*/
File: fn_AIXHitEvade.sqf
Author:

	Quiksilver
	
Last modified:

	10/05/2022 A3 2.08 by Quiksilver
	
Description:

	Evade hits
__________________________________________________/*/
params ['_u','_s','',''];
if (local _u) then {
	if (
		((random 1) > 0.5) && 
		(_u checkAIFeature 'PATH')
	) then {
		if (
			(_s isEqualType objNull) &&
			{(alive _s)} &&
			{(isPlayer _s)} &&
			{(((vectorMagnitude (velocity _u)) * 3.6) < 0.5)}
		) then {
			_u playAction (selectRandom ['TactLB','TactRB','TactL','TactR','TactLF','TactRf']);
			if ((random 1) > 0.5) then {
				_u spawn {
					sleep 2;
					_this playAction (selectRandom ['TactLB','TactRB','TactL','TactR','TactLF','TactRf']);
				};
			} else {
				if ((stance _u) isEqualTo 'STAND') then {
					_u setUnitPos 'Down';
				};
			};
		};
	} else {
		if (
			((random 1) > 0.5) &&
			{(serverTime > (_u getVariable ['QS_AI_UNIT_lastSmoke',-1]))}
		) then {
			_u setVariable ['QS_AI_UNIT_lastSmoke',(serverTime + (random [15,30,45])),FALSE];
			[_u,_s,'SMOKE',FALSE] call (missionNamespace getVariable 'QS_fnc_AIXThrow');
		};
	};
	if ((random 1) > 0.5) then {
		_u removeEventHandler [_thisEvent,_thisEventHandler];
		_u setVariable ['QS_AI_UNIT_gestureEvent',FALSE,FALSE];
	};
};