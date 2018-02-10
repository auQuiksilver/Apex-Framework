/*
File: fn_clientInteractEscort.sqf
Author:

	Quiksilver
	
Last Modified:

	1/08/2015 A3 1.62 by Quiksilver
	
Description:

	-
_____________________________________________________________*/

private ['_obj','_exit'];
_exit = FALSE;
_obj = cursorTarget;
if (isNull _obj) exitWith {};
if (isNil {_obj getVariable 'QS_RD_escortable'}) exitWith {};
if (!((attachedObjects _obj) isEqualTo [])) then {
	{
		if (_x isKindOf 'Man') then {
			_exit = TRUE;
		};
	} count (attachedObjects _obj);
};
if (!isNull (attachedTo _obj)) exitWith {};
if (_exit) exitWith {};
player setVariable ['QS_RD_interacting',TRUE,TRUE];
_obj setVariable ['QS_RD_storedAnim',(animationState _obj),TRUE];
_obj setVariable ['QS_RD_interacting',TRUE,TRUE];
_obj setVariable ['QS_RD_escorted',TRUE,TRUE];
_obj attachTo [player,[0.1,-1.1,0]];
_obj disableAI 'MOVE';
_obj disableAI 'FSM';
_obj disableAI 'TEAMSWITCH';
_obj allowDamage TRUE;
_obj setCaptive FALSE;
50 cutText ['Escorting','PLAIN DOWN',0.3];
TRUE;