/*/
File: fn_isNearServiceCargo.sqf
Author: 

	Quiksilver

Last Modified:

	21/12/2022 A3 2.10 by Quiksilver

Description:

	Is near service vehicle
__________________________________________/*/

params ['_cameraOn',['_radius',15]];
private _return = [];
if (
	(_cameraOn isEqualType objNull) && 
	{(isNull _cameraOn)}
) exitWith {
	_return;
};
_radius = _radius max (sizeOf (typeOf _cameraOn));
private _list = _cameraOn nearEntities _radius;
_attachedObjects = attachedObjects _cameraOn;
if (_list isNotEqualTo []) then {
	{
		if (
			(alive _x) &&
			{((_cameraOn distance2D _x) < _radius)} &&
			{(_x isNotEqualTo _cameraOn)} &&
			{(!(_x in _attachedObjects))}
		) then {
			if ((getAmmoCargo _x) > -1) then {
				_return pushBackUnique 'reammo';
				if ((getAmmoCargo _x) > 0) then {
					_x setAmmoCargo 0;
					['setAmmoCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
			if ((getRepairCargo _x) > -1) then {
				_return pushBackUnique 'repair';
				if ((getRepairCargo _x) > 0) then {
					_x setRepairCargo 0;
					['setRepairCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
			if ((getFuelCargo _x) > -1) then {
				_return pushBackUnique 'refuel';
				if ((getFuelCargo _x) > 0) then {
					_x setFuelCargo 0;
					['setFuelCargo',_x,0] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
				};
			};
		};
	} forEach _list;
};
_list = nearestObjects [_cameraOn,[],_radius,TRUE];
if (_list isNotEqualTo []) then {
	_omniModels = [
		'a3\armor_f_beta\apc_tracked_01\apc_tracked_01_crv_f.p3d',
		'a3\armor_f_beta\apc_tracked_01\apc_tracked_01_crv_f.p3d'
	];
	_reammoModels = [
		'a3\soft_f_gamma\truck_01\truck_01_ammo_f.p3d',
		'a3\soft_f_gamma\truck_01\truck_01_ammo_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_box_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\air_f_heli\heli_transport_04\heli_transport_04_ammo_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_box_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\air_f_heli\heli_transport_04\pod_heli_transport_04_ammo_f.p3d',
		'a3\supplies_f_heli\slingload\slingload_01_ammo_f.p3d',
		'a3\weapons_f\ammoboxes\ammoveh_f.p3d'
	] + _omniModels;
	_repairModels = [
		'a3\soft_f_bootcamp\offroad_01\offroad_01_repair_ig_f.p3d',
		'a3\soft_f_gamma\truck_01\truck_01_box_f.p3d',
		'a3\soft_f_gamma\truck_01\truck_01_box_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_repair_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\air_f_heli\heli_transport_04\heli_transport_04_repair_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_repair_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\soft_f_bootcamp\offroad_01\offroad_01_repair_ig_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\soft_f_bootcamp\offroad_01\offroad_01_repair_ig_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_box_f.p3d',
		'a3\air_f_heli\heli_transport_04\pod_heli_transport_04_repair_f.p3d',
		'a3\supplies_f_heli\slingload\slingload_01_repair_f.p3d'
	] + _omniModels;
	_refuelModels = [
		'a3\soft_f_gamma\van_01\van_01_fuel_f.p3d',
		'a3\soft_f_gamma\truck_01\truck_01_fuel_f.p3d',
		'a3\soft_f_gamma\truck_01\truck_01_fuel_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_fuel_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_fuel_f.p3d',
		'a3\air_f_heli\heli_transport_04\heli_transport_04_fuel_f.p3d',
		'a3\soft_f_epc\truck_03\truck_03_fuel_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_fuel_f.p3d',
		'a3\soft_f_gamma\van_01\van_01_fuel_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_fuel_f.p3d',
		'a3\soft_f_gamma\van_01\van_01_fuel_f.p3d',
		'a3\soft_f_gamma\truck_02\truck_02_fuel_f.p3d',
		'a3\air_f_heli\heli_transport_04\pod_heli_transport_04_fuel_f.p3d',
		'a3\supplies_f_heli\slingload\slingload_01_fuel_f.p3d',
		'a3\supplies_f_heli\fuel\flexibletank_01_f.p3d',
		'a3\supplies_f_heli\fuel\flexibletank_01_f.p3d'
	] + _omniModels;
	{
		if (
			((_cameraOn distance2D _x) < _radius) &&
			{(!isNull _x)} &&
			{(isSimpleObject _x)} &&
			{(!(_x in _attachedObjects))}
		) then {
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _reammoModels) then {
				_return pushBackUnique 'reammo';
			};
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _repairModels) then {
				_return pushBackUnique 'repair';
			};
			if ((toLowerANSI ((getModelInfo _x) # 1)) in _refuelModels) then {
				_return pushBackUnique 'refuel';
			};
		};
	} forEach _list;
};
_return;