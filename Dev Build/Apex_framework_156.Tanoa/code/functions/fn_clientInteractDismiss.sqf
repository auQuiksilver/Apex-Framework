/*
File: fn_clientInteractDismiss.sqf
Author:

	Quiksilver
	
Last Modified:

	31/05/2023 A3 2.12
	
Description:

	-
____________________________________________*/

_t = cursorTarget;
if (
	(!alive _t) ||
	(!(_t isKindOf 'CAManBase')) ||
	(!(_t in (units (group player))))
) exitWith {};
50 cutText [(format [localize 'STR_QS_Text_104',(name _t)]),'PLAIN DOWN',0.5];
player playActionNow 'gestureHi';
_virtualParent = _t getVariable ['QS_virtualCargoParent',objNull];
if (
	(_t getVariable ['QS_logistics_virtual',FALSE]) &&
	{(alive _virtualParent)}
) exitWith {
	['DISASSEMBLE',_t] call QS_fnc_virtualVehicleCargo;
};
if (alive _t) then {
	[17,_t] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
TRUE;