/*
File: fn_waterIntersect.sqf
Author: 

	Quiksilver

Last Modified:

	14/04/2017 A3 1.68 by Quiksilver

Description:

	Simple check for water intersection between two points
____________________________________________________________________________*/

params ['_position1','_position2','_increment'];
_distance2D = _position1 distance2D _position2;
_direction = _position1 getDir _position2;
private _position = [0,0,0];
private _incrementDistance = 0;
private _return = FALSE;
scopeName 'main';
for '_x' from 0 to ((_distance2D / _increment) - 1) step 1 do {
	_position = _position1 getPos [_incrementDistance,_direction];
	_incrementDistance = _incrementDistance + _increment;
	if (surfaceIsWater _position) then {
		if (!(_return)) then {
			_return = TRUE;
			breakTo 'main';
		};
	};
};
_return;