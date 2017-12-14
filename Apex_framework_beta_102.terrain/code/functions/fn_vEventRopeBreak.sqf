/*
File: fn_vEventRopeBreak.sqf
Author:

	Quiksilver
	
Last Modified:

	20/05/2016 A3 1.58 by Quiksilver
	
Description:

	Rope Break Event
	
Parameter(s):
	
	object 1: Object - Object to which the event handler is assigned.
	rope: Object - The rope being detached between object 1 and object 2.
	object 2: Object - The object that is being detached from object 1 via rope.
	
	(isNull (ropeAttachedTo _x))
___________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
if (isNull (ropeAttachedTo _attachedObject)) then {
	if ((_attachedObject distance2D (markerPos 'QS_marker_crate_area')) < 500) then {
		if (!isNil {_attachedObject getVariable 'QS_vehicle_isSuppliedFOB'}) then {
			_attachedObject setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
			if (!isNull (driver _vehicle)) then {
				if (alive (driver _vehicle)) then {
					if (isPlayer (driver _vehicle)) then {
						if (isServer) then {
							_text = format ['%1 reset for FOB resupply',(getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName'))];
							['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',(driver _vehicle),FALSE];
						};
					};
				};
			};
		};
	};
};