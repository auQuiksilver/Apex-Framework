/*
@filename: fn_conditionSlingAttach.sqf
Author: 

	Quiksilver
	
Last modified:

	23/07/2014 ArmA 1.24 by Quiksilver
	
Description:

	Condition for add-Action
__________________________________________________________________*/

_v = _this select 0;
private _c = FALSE;
if (_v isKindOf 'LandVehicle') then {
	if (((vectorMagnitude (velocity _v)) * 3.6) < 1) then {
		if ((_v getVariable ['QS_tow_veh',-1]) > 0) then {
			if (_v getVariable ['QS_ropeAttached',FALSE]) then {
				_c = TRUE;
			};
		};
	};
};
_c;