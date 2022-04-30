/*
File: fn_clientInteractTowLoadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	4/07/2017 A3 1.72 by Quiksilver
	
Description:

	-
_____________________________________________________________*/
private _c = FALSE;
_vehicle = _this select 0;
_attachedObjects = attachedObjects _vehicle;
private _towedVehicle = objNull;
if (alive _vehicle) then {
	if (_attachedObjects isNotEqualTo []) then {
		{
			if (_x getVariable ['QS_ropeAttached',FALSE]) then {
				if ((_x isKindOf 'Reammobox_F') || {(_x isKindOf 'AllVehicles')}) then {
					_towedVehicle = _x;
				};
			};
			if (!isNull _towedVehicle) exitWith {};
		} count _attachedObjects;
		if (alive _towedVehicle) then {
			_nearViVTransports = (getPosATL _towedVehicle) nearEntities [['Air','LandVehicle','Ship'],20];
			private _relDir = 0;
			if (_nearViVTransports isNotEqualTo []) then {
				{
					if ((!isNil {_x getVariable 'QS_ViV_v'}) || {(isClass (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'vehicleTransport' >> 'Carrier'))}) exitWith {
						if (vehicleCargoEnabled _x) then {
							if (isNil {_x getVariable 'QS_ViV_v'}) then {
								_x setVariable ['QS_ViV_v',TRUE,TRUE];
							};
							_relDir = _x getRelDir _towedVehicle;
							if ((_relDir > 150) && (_relDir < 210)) then {
								_c = TRUE;
							};
						};
					};
				} count _nearViVTransports;
			};
		};
	};
};
_c;