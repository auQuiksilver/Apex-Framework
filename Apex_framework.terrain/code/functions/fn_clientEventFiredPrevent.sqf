/*/
File: fn_clientEventFiredPrevent.sqf
Author: 

	Quiksilver
	
Last modified:

	10/10/2023 A3 2.12 by Quiksilver
	
Description:

	Handle Fired Event 2
__________________________________________/*/

params ['_mode',['_unit',QS_player]];
if (isNull _unit) exitWith {};
if (_mode isEqualTo 0) exitWith {
	if ((_unit getVariable ['QS_interaction_safezone1',-1]) in (actionIDs _unit)) then {
		_unit removeAction (_unit getVariable ['QS_interaction_safezone1',-1]);
		_unit setVariable ['QS_interaction_safezone1',-1,FALSE];
	};
};
if (_mode isEqualTo 1) exitWith {
	if (!((_unit getVariable ['QS_interaction_safezone1',-1]) in (actionIDs _unit))) then {
		_unit setVariable [
			'QS_interaction_safezone1',
			(_unit addAction [
				localize 'STR_QS_Interact_106',
				{call QS_fnc_clientInteractWeaponSafety},
				nil,
				-99,
				FALSE,
				TRUE,
				'defaultAction',
				'((_target isEqualTo cameraOn) || {(!(cameraOn isKindOf "CAManBase")) && (_target in cameraOn)})'		// A3 2.16 - replace cameraOn with focusOn
			]),
			FALSE
		];
	};
};