/*
@filename: fn_isLockable.sqf
Author:

	Quiksilver
	
Last modified:

	30/12/2022 A3 2.10 by Quiksilver
	
Description:

	Is vehicle lockable
__________________________________________________*/

_t = cursorTarget;
(
	(isNull (objectParent player)) &&
	{((player distance _t) < 15)} &&
	{(_t getVariable ['QS_vehicle_lockable',FALSE])} &&
	{((crew _t) isEqualTo [])} &&
	{((locked _t) isEqualTo 0)}
)