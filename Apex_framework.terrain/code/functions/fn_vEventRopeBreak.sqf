/*
File: fn_vEventRopeBreak.sqf
Author:

	Quiksilver
	
Last Modified:

	26/01/2024 A3 2.16 by Quiksilver
	
Description:

	Rope Break Event
	
Parameter(s):
	
	object 1: Object - Object to which the event handler is assigned.
	rope: Object - The rope being detached between object 1 and object 2.
	object 2: Object - The object that is being detached from object 1 via rope.
___________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
if (
	(isNull (ropeAttachedTo _attachedObject)) &&
	{((_attachedObject distance2D (markerPos 'QS_marker_crate_area')) < 500)} &&
	{!(_attachedObject isNil 'QS_vehicle_isSuppliedFOB')}
) then {
	_attachedObject setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
	if (
		isDedicated &&
		{(alive (driver _vehicle))} &&
		{(isPlayer (driver _vehicle))}
	) then {
		_text = format ['%1 %2',(getText ((configOf _attachedObject) >> 'displayName')),localize 'STR_QS_Chat_162'];
		['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',(driver _vehicle),FALSE];
	};
};