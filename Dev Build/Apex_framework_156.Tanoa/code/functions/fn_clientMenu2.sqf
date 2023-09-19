/*
File: fn_clientMenu2.sqf
Author:
	
	Quiksilver
	
Last Modified:

	8/09/2015 ArmA 3 1.50 by Quiksilver

Description:

	Client Menu
__________________________________________________________*/

closeDialog 2;
if (isNull (findDisplay 2000)) then {
	[0] call (missionNamespace getVariable 'QS_fnc_clientMenu');
} else {
	[-1] call (missionNamespace getVariable 'QS_fnc_clientMenu');
};