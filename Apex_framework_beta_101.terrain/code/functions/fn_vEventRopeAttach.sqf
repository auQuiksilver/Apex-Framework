/*
File: fn_vEventRopeAttach.sqf
Author:

	Quiksilver
	
Last Modified:

	23/05/2016 A3 1.58 by Quiksilver
	
Description:

	Rope Break Event
	
Parameter(s):
	
	object 1: Object - Object to which the event handler is assigned.
	rope: Object - The rope being attached between object 1 and object 2.
	object 2: Object - The object that is being attached to object 1 via rope.
___________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
_count = count (getArray (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'slingLoadCargoMemoryPoints'));
if ((count (ropes _vehicle)) isEqualTo _count) then {
	if (!isNull (driver _vehicle)) then {
		if (alive (driver _vehicle)) then {
			if (isPlayer (driver _vehicle)) then {
				_attachedObject setVariable ['QS_transporter',[(name (driver _vehicle)),(driver _vehicle),(getPlayerUID (driver _vehicle))],FALSE];
				_text = format ['Sling Loading a(n) %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName'))];
				['hint',_text] remoteExec ['QS_fnc_remoteExecCmd',(driver _vehicle),FALSE];
			};
		};
	};
};