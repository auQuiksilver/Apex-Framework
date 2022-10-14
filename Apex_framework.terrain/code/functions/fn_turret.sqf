/*
File: fn_turret.sqf
Author:

	Quiksilver
	
Last modified:

	24/10/2014 ArmA 1.32 by Quiksilver
	
Description:

	Send across network
___________________________________________________*/

params ['_v','_t','_w','_type'];
if (_type isEqualTo 0) then {
	_v removeWeaponTurret [_w,[_t]];
};
if (_type isEqualTo 1) then {
	_v addWeaponTurret [_w,[_t]];
};
TRUE;