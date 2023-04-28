/*
File: fn_clientGetDoorPhase.sqf
Author:
	
	Quiksilver
	
Last Modified:

	30/12/2022 A3 2.10 by Quiksilver

Description:

	Get Door Phase
__________________________________________________________*/

_vehicle = _this # 0;
_vehicleType = toLowerANSI (typeOf _vehicle);
_animateDoor = ['veh_doors_1'] call QS_data_listVehicles;
_animate = ['veh_doors_2'] call QS_data_listVehicles;
if ((_vehicleType in _animateDoor) && {(_vehicleType in (['veh_doors_3'] call QS_data_listVehicles))}) exitWith {
	(_vehicle doorPhase 'door_R');
};
if ((_vehicleType in _animateDoor) && {(_vehicleType in (['veh_doors_4'] call QS_data_listVehicles))}) exitWith {
	(_vehicle doorPhase 'Door_R_source');
};
if ((_vehicleType in _animateDoor) && {(_vehicleType in (['veh_doors_5'] call QS_data_listVehicles))}) exitWith {
	(_vehicle doorPhase 'Door_Back_R');
};
if ((_vehicleType in _animateDoor) && {(_vehicleType in (['veh_doors_6'] call QS_data_listVehicles))}) exitWith {
	(_vehicle doorPhase 'Door_1_source');
};
if ((_vehicleType in _animateDoor) && {(_vehicleType in (['veh_doors_7'] call QS_data_listVehicles))}) exitWith {
	(_vehicle doorPhase 'Door_3_source');
};
if (_vehicleType in _animate) exitWith {
	(_vehicle animationSourcePhase 'Doors');
};