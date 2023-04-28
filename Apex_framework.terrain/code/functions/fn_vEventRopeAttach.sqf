/*
File: fn_vEventRopeAttach.sqf
Author:

	Quiksilver
	
Last Modified:

	19/09/2022 A3 2.10 by Quiksilver
	
Description:

	Rope Break Event
	
Parameter(s):
	
	object 1: Object - Object to which the event handler is assigned.
	rope: Object - The rope being attached between object 1 and object 2.
	object 2: Object - The object that is being attached to object 1 via rope.
___________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
private _count = _attachedObject getVariable ['QS_ropes_slingLoadCargoMemoryPoints',-1];
if (_count isEqualTo -1) then {
	_count = count (getArray ((configOf _attachedObject) >> 'slingLoadCargoMemoryPoints'));
	_attachedObject setVariable ['QS_ropes_slingLoadCargoMemoryPoints',_count,FALSE];
};
if (
	((count (ropes _vehicle)) isEqualTo _count) &&
	{(alive (driver _vehicle))} &&
	{(isPlayer (driver _vehicle))}
) then {
	_attachedObject setVariable ['QS_transporter',[(name (driver _vehicle)),(driver _vehicle),(getPlayerUID (driver _vehicle))],FALSE];
	_text = format ['%2 %1',(getText ((configOf _attachedObject) >> 'displayName')),localize 'STR_QS_Text_201'];
	['hint',_text] remoteExec ['QS_fnc_remoteExecCmd',(driver _vehicle),FALSE];
};