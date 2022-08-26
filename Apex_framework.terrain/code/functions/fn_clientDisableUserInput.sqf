/*
File: fn_clientDisableUserInput.sqf
Author:
	
	Quiksilver
	
Last Modified:

	14/09/2015 ArmA 3 1.50 by Quiksilver

Description:

	Disable user input for a set amount of time, spawn dont call
__________________________________________________________*/

_duration = _this # 0;
if (isDedicated) exitWith {};
if (!(_duration isEqualType 0)) exitWith {};
if (_duration > 15) exitWith {};
if (!(userInputDisabled)) then {
	disableUserInput TRUE;
};
uiSleep _duration;
if (userInputDisabled) then {
	disableUserInput FALSE;
};