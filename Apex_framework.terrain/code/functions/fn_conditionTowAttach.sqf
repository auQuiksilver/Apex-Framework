/*
File: fn_conditionTowAttach.sqf
Author: 

	Quiksilver
	
Last modified:

	2/01/2015 ArmA 1.36 by Quiksilver
	
Description:

	Condition for add-Action
__________________________________________________________________*/

_v = vehicle player;
private _c = FALSE;
if (_v isKindOf 'LandVehicle') then {
	if (((vectorMagnitude (velocity _v)) * 3.6) < 1) then {
		if ((_v getVariable 'QS_tow_veh') > 0) then {
			if ([_v] call (missionNamespace getVariable 'QS_fnc_vTowable')) then {
				_c = TRUE;
			};
		};
	};
};
_c;