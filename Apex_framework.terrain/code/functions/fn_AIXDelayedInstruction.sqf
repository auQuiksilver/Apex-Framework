/*/
File: fn_AIXDelayedInstruction.sqf
Author:

	Quiksilver
	
Last modified:

	18/08/2022 A3 2.10 by Quiksilver
	
Description:

	AI Delayed Instructions
	
	After a certain time, do a certain thing
	
	Time measured in "serverTime"
	
Execution:
	
	if ((_unit getVariable ['QS_AI_UNIT_delayedInstructions',[]]) isNotEqualTo []) then {
		_delayedInstructions = _unit getVariable ['QS_AI_UNIT_delayedInstructions',[]];
		if (serverTime > (_delayedInstructions # 0)) then {
			(_delayedInstructions # 1) call QS_fnc_AIXDelayedInstruction;
			_unit setVariable ['QS_AI_UNIT_delayedInstructions',[],QS_system_AI_owners];
		};
	};
__________________________________________________/*/

params ['_unit','_instruction','_repeat'];
if (_instruction isEqualTo 1) exitWith {
	if (!(_unit checkAIFeature 'PATH')) then {
		_unit enableAIFeature ['PATH',TRUE];
	};
	_unit setVariable ['QS_AI_UNIT_delayedInstructions',[],QS_system_AI_owners];
};
if (_instruction isEqualTo 2) exitWith {
	_unit setUnitPos 'Auto';
	_unit setVariable ['QS_AI_UNIT_delayedInstructions',[],QS_system_AI_owners];
};