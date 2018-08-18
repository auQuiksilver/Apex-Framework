/*
File: fn_serverDetector.sqf
Author:

	Quiksilver
	
Last modified:

	15/07/2018 A3 1.84 by Quiksilver
	
Description:

	Detect units in area
____________________________________________________________*/

params ['_pos1','_rad','_sides','_pool','_type'];
if (_type isEqualTo 0) exitWith {
	((_pool select {((side _x) in _sides)}) inAreaArray [_pos1,_rad,_rad,0,FALSE,-1]);
};
(count ((_pool select {((side _x) in _sides)}) inAreaArray [_pos1,_rad,_rad,0,FALSE,-1]));