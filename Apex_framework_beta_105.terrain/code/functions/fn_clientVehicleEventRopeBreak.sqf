/*
File: fn_clientVehicleEventRopeBreak.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/09/2016 A3 1.62 by Quiksilver

Description:

	Event Rope Break
__________________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
if (!local _vehicle) exitWith {};
if (isNull (ropeAttachedTo _attachedObject)) then {
	if ((_attachedObject distance2D (markerPos 'QS_marker_crate_area')) < 500) then {
		if (!isNil {_attachedObject getVariable 'QS_vehicle_isSuppliedFOB'}) then {
			_attachedObject setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
			if (!isNull (driver _vehicle)) then {
				if (alive (driver _vehicle)) then {
					if (player isEqualTo (driver _vehicle)) then {
						_text = format ['%1 reset for FOB resupply',(getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName'))];
						50 cutText [_text,'PLAIN DOWN',0.5];
					};
				};
			};
		};
	};
};