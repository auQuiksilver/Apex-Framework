/*
File: fn_waterInRadius.sqf
Author: 

	Quiksilver

Last Modified:

	14/04/2017 A3 1.68 by Quiksilver

Description:

	Simple check for water in radius
____________________________________________________________________________*/

params ['_position','_radius',['_increment',4]];
if (_increment < 4) then {_increment = 4;};
private _return = FALSE;
private _dir = 0;
_dirIncrement = 360 / _increment;
for '_x' from 0 to (_increment - 1) step 1 do {
	if (surfaceIsWater (_position getPos [_radius,_dir])) exitWith {_return = TRUE;};
	_dir = _dir + _dirIncrement;
};
_return;