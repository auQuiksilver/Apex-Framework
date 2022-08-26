/*/
File: fn_slingData.sqf
Author:

	Quiksilver
	
Last Modified:

	6/05/2018 A3 1.82 by Quiksilver
	
Description:

	Sling Data
___________________________________________/*/

params [['_vehicle',objNull],['_slingLoad',objNull]];
private _vehicleType = toLowerANSI (typeOf _vehicle);
private _slingType = toLowerANSI (typeOf _slingLoad);
private _return = [_vehicleType,_slingType,FALSE,[0,0,0],5,25,2,4];
if (_vehicle isKindOf 'heli_transport_04_base_f') then {
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,50,3,6];
	if (_slingType in ['land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f']) then {
		_return = [_vehicleType,_slingType,TRUE,[0.05,-0.282,-1.25],4,50,3,6];
		if ((getMass _slingLoad) > 1000) then {
			if (local _slingLoad) then {
				_slingLoad setMass 1000;
			} else {
				['setMass',_slingLoad,1000] remoteExec ['QS_fnc_remoteExecCmd',_slingLoad,FALSE];
			};
		};
	};
	if (_slingType in ['land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_repair_f','land_pod_heli_transport_04_repair_black_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_box_black_f']) then {
		_return = [_vehicleType,_slingType,TRUE,[0,-1.05,-1.25],4,50,3,6];
	};
	if (_slingType in ['land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_covered_black_f']) then {
		_return = [_vehicleType,_slingType,TRUE,[0,-1.05,-0.95],4,50,3,6];
	};
	if (_slingType in ['land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_medevac_black_f']) then {
		_return = [_vehicleType,_slingType,TRUE,[-0.04,-1.05,-1.06],4,50,3,6];
	};
	if (_slingType in ['land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f']) then {
		_return = [_vehicleType,_slingType,TRUE,[0.11,0.1,-1.35],4,50,3,6];
	};
	if ((_slingLoad isKindOf 'ugv_01_base_f') && (!(_slingLoad isKindOf 'ugv_01_rcws_base_f'))) then {
		_return = [_vehicleType,_slingType,TRUE,[-0.42,0.25,-0.5],4,50,3,6];
	};
	if (_slingLoad isKindOf 'ugv_01_rcws_base_f') then {
		_return = [_vehicleType,_slingType,TRUE,[-0.42,0.25,-0.8],4,50,3,6];
	};
};
if (_vehicle isKindOf 'heli_transport_01_base_f') then {
	// ghosthawk
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,25,2,4];
};
if (_vehicle isKindOf 'heli_transport_02_base_f') then {
	// mohawk
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,25,2,4];
};
if (_vehicle isKindOf 'heli_transport_03_base_f') then {
	// huron
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,35,2,4];
};
if (_vehicle isKindOf 'heli_light_01_base_f') then {
	// hummingbird
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,15,2,4];
};
if (_vehicle isKindOf 'heli_light_02_base_f') then {
	// orca
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,25,2,4];
};
if (_vehicle isKindOf 'heli_light_03_base_f') then {
	// hellcat
	_return = [_vehicleType,_slingType,FALSE,[0,0,0],5,15,2,4];
};
_return;