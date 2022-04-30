/*
File: fn_clientEventCuratorKeyDown.sqf
Author:

	Quiksilver
	
Last modified:

	28/02/2016 A3 1.56 by Quiksilver
	
Description:

	Curator KeyDown Event
__________________________________________________*/

_key = _this select 1;
private _c = FALSE;
player setVariable ['QS_client_afkTimeout',time,FALSE];
if (_key isEqualTo 61) then {
	if (_this select 2) then {
		if (alive player) then {
			if ((lifeState player) isNotEqualTo 'INCAPACITATED') then {
				['Curator'] call (missionNamespace getVariable 'QS_fnc_clientMenuStaff');
				_c = TRUE;
			};
		};
	};
};
if (_key in [82,79,80,81,75,76,77,71,72,73]) then {
	if (alive player) then {
		if ((lifeState player) isNotEqualTo 'INCAPACITATED') then {
			0 = [_key] call (missionNamespace getVariable 'QS_fnc_curatorFunctions');
			_c = TRUE;
		};
	};
};
_c;