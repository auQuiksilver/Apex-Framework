/*/
File: fn_moveInCargoMedical.sqf
Author:
	
	Quiksilver
	
Last Modified:

	10/11/2017 A3 1.76 by Quiksilver

Description:

	-
__________________________________________________________/*/

params ['_unit','_vehicle'];
_vehicleType = toLowerANSI (typeOf _vehicle);
private _medicalCargoIndex = [-1];
private _moveInCargoIndex = -1;
if (_vehicleType in [
	'b_truck_01_medical_f',
	'b_t_truck_01_medical_f'
]) then {
	_medicalCargoIndex = [1,2,3,4,5,6,7];
};
if (_vehicleType in [
	'o_truck_02_medical_f',
	'i_truck_02_medical_f'
]) then {
	_medicalCargoIndex = [9,10,11,12,13,14,15];
};
if (_vehicleType in [
	'o_t_truck_03_medical_ghex_f',
	'o_truck_03_medical_f'
]) then {
	_medicalCargoIndex = [1,2,3];
};
if (_vehicleType in [
	'o_heli_transport_04_medevac_f',
	'o_heli_transport_04_medevac_black_f',
	'land_pod_heli_transport_04_medevac_f',
	'land_pod_heli_transport_04_medevac_black_f'
]) then {
	_medicalCargoIndex = [0,1,2];
};
if (_vehicleType in [
	'c_van_02_medevac_f',
	'c_idap_van_02_medevac_f',
	'i_e_van_02_medevac_f'
]) then {
	_medicalCargoIndex = [3,4];
};
scopeName 'main';
{
	_x params ['_crewUnit','','_crewIndex','',''];
	if (isNull _crewUnit) then {
		if (_crewIndex in _medicalCargoIndex) then {
			if (!(_vehicle lockedCargo _crewIndex)) then {
				_moveInCargoIndex = _crewIndex;
				breakTo 'main';
			};
		};
	};
} forEach (fullCrew [_vehicle,'cargo',TRUE]);
if (_moveInCargoIndex isEqualTo -1) then {
	_unit assignAsCargo _vehicle;
	_unit moveInCargo _vehicle;
} else {
	_unit assignAsCargoIndex [_vehicle,_moveInCargoIndex];
	_unit moveInCargo [_vehicle,_moveInCargoIndex];
};