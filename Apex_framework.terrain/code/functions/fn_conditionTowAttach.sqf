/*
File: fn_conditionTowAttach.sqf
Author: 

	Quiksilver
	
Last modified:

	2/01/2015 ArmA 1.36 by Quiksilver
	
Description:

	Condition for add-Action
__________________________________________________________________*/

private ['_v','_c'];
_v = vehicle player;
_c = FALSE;
if (_v isKindOf 'LandVehicle') then {
	if ((speed _v) < 1) then {
		if ((speed _v) > -1) then {
			if ((_v getVariable 'QS_tow_veh') > 0) then {
				if ([_v] call (missionNamespace getVariable 'QS_fnc_vTowable')) then {
					_c = TRUE;
				};	
			};
		};
	};
};
_c;