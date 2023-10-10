/*
File: fn_clientEventCuratorKeyDown.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Curator KeyDown Event
__________________________________________________*/

params ['','_key','_shift','_ctrl','_alt'];
private _c = FALSE;
uiNamespace setVariable ['QS_client_afkTimeout',diag_tickTime];
if ((lifeState player) in ['HEALTHY','INJURED']) then {
	if (_shift) then {
		// F3
		if (_key isEqualTo 61) then {
			[_key] call (missionNamespace getVariable 'QS_fnc_curatorFunctions');
			_c = TRUE;
		};
		// F4
		if (_key isEqualTo 62) then {
			[_key] call (missionNamespace getVariable 'QS_fnc_curatorFunctions');
			_c = TRUE;
		};
	};
	_validKeys = (
		[82,79,80,81,75,76,77,71,72,73] +		// Numpad
		(actionKeys 'User1') + 
		(actionKeys 'User2') + 
		(actionKeys 'User3') +
		(actionKeys 'User4') + 
		(actionKeys 'User5') +
		(actionKeys 'User6') + 
		(actionKeys 'User7') +
		(actionKeys 'User8') + 
		(actionKeys 'User9') +
		(actionKeys 'User10') + 
		(actionKeys 'User11') +
		(actionKeys 'User12') + 
		(actionKeys 'User13') +
		(actionKeys 'User14') + 
		(actionKeys 'User15') +
		(actionKeys 'User16') + 
		(actionKeys 'User17') +
		(actionKeys 'User18') +
		(actionKeys 'User19') + 
		(actionKeys 'User20')
	);
	// Numpad and custom keys
	if (_key in _validKeys) then {
		[_key,_validKeys] call (missionNamespace getVariable 'QS_fnc_curatorFunctions');
		_c = TRUE;
	};
};
_c;