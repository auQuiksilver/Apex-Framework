/*
File: fn_clientInteractDismiss.sqf
Author:

	Quiksilver
	
Last Modified:

	17/10/2015 ArmA 3 1.52
	
Description:

	-
_____________________________________________________________*/

_t = cursorTarget;
if (!alive _t) exitWith {};
if (!(_t isKindOf 'Man')) exitWith {};
if (!(_t in (units (group player)))) exitWith {};
50 cutText [(format ['%1 %2',(name _t),localize 'STR_QS_Text_104']),'PLAIN DOWN',0.5];
player playActionNow 'gestureHi';
[17,_t] remoteExec ['QS_fnc_remoteExec',2,FALSE];
TRUE;