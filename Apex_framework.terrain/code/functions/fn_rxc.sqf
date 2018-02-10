/*
File: fn_rxc.sqf
Author:

	Quiksilver
	
Last modified:

	16/01/2015 ArmA 1.36 by Quiksilver
	
Description:

	- 
_______________________________________________________*/

if (((_this select 1) select 1) isEqualTo 0) exitWith {};
if (((_this select 1) select 1) isEqualTo 1) then {[] call ((_this select 1) select 0);};
if (((_this select 1) select 1) isEqualTo 2) then {[] spawn ((_this select 1) select 0);};