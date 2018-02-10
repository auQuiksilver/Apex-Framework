/*
@filename: fn_isLockable.sqf
Author:

	Quiksilver
	
Last modified:

	26/05/2015 ArmA 3 1.44 by Quiksilver
	
Description:

	Is vehicle lockable
__________________________________________________*/

private ['_c'];

_c = FALSE;
_t = cursorTarget;

if ((vehicle player) isKindOf 'Man') then {
	if ((player distance _t) < 15) then {
		if (!isNil {_t getVariable 'QS_vehicle_lockable'}) then {
			if (_t getVariable 'QS_vehicle_lockable') then {
				if ((count (crew _t)) isEqualTo 0) then {
					_c = TRUE;
				};
			};
		};
	};
};
_c;