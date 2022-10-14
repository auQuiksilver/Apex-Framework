/*
File: fn_waterIntersect.sqf
Author: 

	Quiksilver

Last Modified:

	19/09/2022 A3 2.10 by Quiksilver

Description:

	Simple check for water intersection between two points
____________________________________________________________________________*/

params ['_position1','_position2','_increment'];
private _position = [0,0,0];
private _incrementDistance = 0;
private _return = FALSE;
for '_x' from 0 to (( (_position1 distance2D _position2) / _increment) - 1) step 1 do {
	_position = _position1 getPos [_incrementDistance,(_position1 getDir _position2)];
	_incrementDistance = _incrementDistance + _increment;
	if (surfaceIsWater _position) exitWith {
		_return = TRUE;
	};
};
_return;