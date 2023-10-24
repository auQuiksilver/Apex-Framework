/*
File: fn_serverDetector.sqf
Author:

	Quiksilver
	
Last modified:

	21/10/2023 A3 2.14 by Quiksilver
	
Description:

	Detect units in area
____________________________________________________________*/

params ['_origin','_rad','_sides','_pool','_type'];
if (_type isEqualTo 0) exitWith {
	((_pool select {((side _x) in _sides)}) inAreaArray [_origin,_rad,_rad,0,FALSE,-1]);
};
if (_type isEqualTo -1) exitWith {
	(count ((units EAST) inAreaArray [_origin,_rad,_rad,0,FALSE,-1]))
};
(count ((_pool select {((side _x) in _sides)}) inAreaArray [_origin,_rad,_rad,0,FALSE,-1]));