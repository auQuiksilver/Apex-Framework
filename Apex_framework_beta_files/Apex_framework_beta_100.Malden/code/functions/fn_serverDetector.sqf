/*
File: fn_serverDetector.sqf
Author:

	Quiksilver
	
Last modified:

	4/12/2016 A3 1.66 by Quiksilver
	
Description:

	QS_fnc_serverDetector
__________________________________________________________________________*/

params ['_pos1','_rad','_sides','_pool','_type'];
_arr = (_pool select {((side _x) in _sides)}) inAreaArray [_pos1,_rad,_rad,0,FALSE,-1];
if (_type isEqualTo 0) exitWith {
	_arr;
};
(count _arr);