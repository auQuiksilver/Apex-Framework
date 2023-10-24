/*
File: fn_clientInteractEscort.sqf
Author:

	Quiksilver
	
Last Modified:

	15/08/2018 A3 1.84 by Quiksilver
	
Description:

	-
________________________________________________*/

_obj = cursorTarget;
if (
	(isNull _obj) ||
	(!(_obj getVariable ['QS_RD_escortable',FALSE])) ||
	(isPlayer _obj) ||
	(!isNull (attachedTo _obj))
) exitWith {};
private _exit = FALSE;
if ((attachedObjects _obj) isNotEqualTo []) then {
	{
		if (_x isKindOf 'CAManBase') then {
			_exit = TRUE;
		};
	} count (attachedObjects _obj);
};
if (_exit) exitWith {};
player setVariable ['QS_RD_interacting',TRUE,TRUE];
_obj setVariable ['QS_RD_storedAnim',(animationState _obj),TRUE];
_obj setVariable ['QS_RD_interacting',TRUE,TRUE];
_obj setVariable ['QS_RD_escorted',TRUE,TRUE];
[1,_obj,[player,[0.1,-1.1,0]]] call QS_fnc_eventAttach;
{
	_obj enableAIFeature [_x,FALSE];
} forEach [
	'MOVE',
	'FSM',
	'TEAMSWITCH'
];
_obj allowDamage TRUE;
_obj setCaptive FALSE;
50 cutText [localize 'STR_QS_Text_106','PLAIN DOWN',0.3];
TRUE;