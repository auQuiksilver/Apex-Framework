/*/
File: fn_pulsate.sqf
Author:

	Quiksilver (Alias of BIS_fnc_pulsate by Nelson Duarte)
	
Last Modified:

	15/04/2017 A3 1.82 by Quiksilver
	
Description:

	Move a number between 0-1
_____________________________________________________________________/*/

params [['_type',0],['_freq',1]];
if (_type isEqualTo 0) exitWith {
	0.5 * (1 + sin (2 * PI * _freq * time));
};
if (_type isEqualTo 1) exitWith {
	0.5 * (1 + sin (2 * PI * _freq * diag_tickTime));
};
if (_type isEqualTo 2) exitWith {
	0.5 * (1 + sin (2 * PI * _freq * serverTime));
};
0;