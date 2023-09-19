/*
File: fn_monthDays.sqf
Author:

	Jiri Wainar (tweaked by Quiksilver)
	
Last modified:

	18/03/2015 ArmA 1.40 by Quiksilver
	
Description:

	Returns number of days in given month. Takes in account for leap year.

Parameter(s):
	_this # 0: SCALAR - year; a non-decimal number
	_this # 1: SCALAR - month; a non-decimal number between 1-12

Example:
	_days = [2035,7] call BIS_fnc_monthDays;
__________________________________________________*/

private ['_year','_month','_days','_isLeapYear','_QS_fnc_isLeapYear'];

_year = param [0,2035];
_month = param [1,1];

if (_month isEqualTo 12) then {
	_days = 31;
} else {
	if (_month isEqualTo 2) then {
		_days = 28;
	} else {
		_days = 30;
	};
};
_QS_fnc_isLeapYear = {
	if ((_this # 0) / 400 % 1 isEqualTo 0) exitWith {
		true;
	};

	if ((_this # 0) / 100 % 1 isEqualTo 0) exitWith {
		false;
	};

	if ((_this # 0) / 4 % 1 isEqualTo 0) exitWith {
		true;
	};
	false;
};
_isLeapYear = [_year] call _QS_fnc_isLeapYear;
if (_isLeapYear) then {
	if (_month isEqualTo 2) then {
		_days = _days + 1;
	};
};
_days;