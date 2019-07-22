/*/
File: fn_clientInteractTowLoadCargo.sqf
Author:

	Quiksilver
	
Last Modified:

	13/02/2018 A3 1.80 by Quiksilver
	
Description:

	-
_____________________________________________________________/*/

private _vehicle = vehicle player;
if (unitIsUav cameraOn) then {
	if ((toLower (typeOf cameraOn)) in [
		'b_ugv_01_f',
		'b_t_ugv_01_olive_f',
		'o_ugv_01_f',
		'o_t_ugv_01_ghex_f',
		'i_ugv_01_f',
		'c_idap_ugv_01_f',
		'i_e_ugv_01_f',
		'i_e_ugv_01_rcws_f'
	]) then {
		_vehicle = cameraOn;
	};
};
_attachedObjects = attachedObjects _vehicle;
private _towedVehicle = objNull;
private _vTransport = objNull;
if (alive _vehicle) then {
	if (!(_attachedObjects isEqualTo [])) then {
		{
			if (_x getVariable ['QS_ropeAttached',FALSE]) then {
				if ((_x isKindOf 'Reammobox_F') || {(_x isKindOf 'AllVehicles')}) then {
					_towedVehicle = _x;
				};
			};
			if (!isNull _towedVehicle) exitWith {};
		} count _attachedObjects;
	};
};
private _array = [];
if (!isNull _towedVehicle) then {
	_nearViVTransports = (getPosATL _towedVehicle) nearEntities [['Air','LandVehicle','Ship'],20];
	if (!(_nearViVTransports isEqualTo [])) then {
		{
			if ((!isNil {_x getVariable 'QS_ViV_v'}) || {(isClass (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'vehicleTransport' >> 'Carrier'))}) exitWith {
				if (vehicleCargoEnabled _x) then {
					if (isNil {_x getVariable 'QS_ViV_v'}) then {
						_x setVariable ['QS_ViV_v',TRUE,TRUE];
					};
					_vTransport = _x;
					_array = [_towedVehicle,_vTransport];
				};
			};
		} count _nearViVTransports;
	};
};
if (isNull _vTransport) exitWith {};
_array params ['_child','_parent'];
if ((!alive _parent) || {(!alive _child)}) exitWith {
	50 cutText ['Load failed','PLAIN DOWN',0.5];
};
if (!(vehicleCargoEnabled _child)) then {
	_child enableVehicleCargo TRUE;
};
if (!((_parent canVehicleCargo _child) isEqualTo [TRUE,TRUE])) exitWith {
	_outcome = _parent canVehicleCargo _child;
	//[Possible to load cargo inside vehicle, possible to load cargo into empty vehicle]
	if (!(_outcome select 1)) then {
		50 cutText [(format ['%1 cannot be loaded into %2',(getText (configFile >> 'CfgVehicles' >> (typeOf _child) >> 'displayName')),(getText (configFile >> 'CfgVehicles' >> (typeOf _parent) >> 'displayName'))]),'PLAIN',0.5];
	} else {
		50 cutText ['Please unload other cargo to load this cargo','PLAIN',0.5];
	};
};
_child setVariable ['QS_loadCargoIn',_parent,FALSE];