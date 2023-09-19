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
if (
	(unitIsUav cameraOn) &&
	((toLowerANSI (typeOf cameraOn)) in (['ugv_types_1'] call QS_data_listVehicles))
) then {
	_vehicle = cameraOn;
};
_attachedObjects = attachedObjects _vehicle;
private _towedVehicle = objNull;
private _vTransport = objNull;
if (alive _vehicle) then {
	if (_attachedObjects isNotEqualTo []) then {
		{
			if ((_x isKindOf 'Reammobox_F') || {(_x isKindOf 'AllVehicles')}) then {
				_towedVehicle = _x;
			};
			if (!isNull _towedVehicle) exitWith {};
		} count _attachedObjects;
	};
};
private _array = [];
if (!isNull _towedVehicle) then {
	_nearViVTransports = (getPosATL _towedVehicle) nearEntities [['Air','LandVehicle','Ship'],20];
	if (_nearViVTransports isNotEqualTo []) then {
		{
			if (
				(vehicleCargoEnabled _x) &&
				{((toLowerANSI (typeOf _x)) in (['load_cargo_1'] call QS_data_listVehicles))}
			) exitWith {
				_vTransport = _x;
				_array = [_towedVehicle,_vTransport];
			};
		} count _nearViVTransports;
	};
};
if (isNull _vTransport) exitWith {};
_array params ['_child','_parent'];
if ((!alive _parent) || {(!alive _child)}) exitWith {
	50 cutText [localize 'STR_QS_Text_116','PLAIN DOWN',0.5];
};
if (!(vehicleCargoEnabled _child)) then {
	_child enableVehicleCargo TRUE;
};
if (([_parent,_child] call QS_fnc_canVehicleCargo) isNotEqualTo [TRUE,TRUE]) exitWith {
	_outcome = [_parent,_child] call QS_fnc_canVehicleCargo;
	//[Possible to load cargo inside vehicle, possible to load cargo into empty vehicle]
	if (!(_outcome # 1)) then {
		50 cutText [(format [localize 'STR_QS_Text_156',(getText ((configOf _child) >> 'displayName')),(getText ((configOf _parent) >> 'displayName'))]),'PLAIN',0.5];
	} else {
		50 cutText [localize 'STR_QS_Text_157','PLAIN',0.5];
	};
};
_child setVariable ['QS_loadCargoIn',_parent,FALSE];