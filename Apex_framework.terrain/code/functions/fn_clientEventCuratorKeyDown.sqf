/*
File: fn_clientEventCuratorKeyDown.sqf
Author:

	Quiksilver
	
Last modified:

	1/09/2022 A3 2.10 by Quiksilver
	
Description:

	Curator KeyDown Event
__________________________________________________*/

_key = _this # 1;
_shift = _this # 2;
private _c = FALSE;
player setVariable ['QS_client_afkTimeout',time,FALSE];
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
	// Numpad
	if (_key in [82,79,80,81,75,76,77,71,72,73]) then {
		[_key] call (missionNamespace getVariable 'QS_fnc_curatorFunctions');
		_c = TRUE;
	};
};
_c;