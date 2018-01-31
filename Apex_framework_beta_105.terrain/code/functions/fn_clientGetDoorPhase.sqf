/*
File: fn_clientGetDoorPhase.sqf
Author:
	
	Quiksilver
	
Last Modified:

	3/01/2015 ArmA 3 1.54 by Quiksilver

Description:

	Get Door Phase
__________________________________________________________*/

private ['_type','_cond'];

_vehicle = _this select 0;
_vehicleType = typeOf _vehicle;
_animateDoor = [
	'B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F',
	'B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F','I_Heli_Transport_02_F','C_IDAP_Heli_Transport_02_F',
	'O_Heli_Transport_04_ammo_black_F','O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_bench_black_F',
	'O_Heli_Transport_04_bench_F','O_Heli_Transport_04_black_F','O_Heli_Transport_04_box_black_F',
	'O_Heli_Transport_04_box_F','O_Heli_Transport_04_covered_black_F','O_Heli_Transport_04_covered_F',
	'O_Heli_Transport_04_F','O_Heli_Transport_04_fuel_black_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_black_F',
	'O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_black_F','O_Heli_Transport_04_repair_F','B_CTRG_Heli_Transport_01_tropic_F',
	'B_CTRG_Heli_Transport_01_sand_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F',
	'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
	'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
	'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
];
_animate = ['O_Heli_Light_02_unarmed_F','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_dynamicLoadout_F'];
if ((_vehicleType in _animateDoor) && (_vehicleType in ['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F','B_CTRG_Heli_Transport_01_tropic_F',
	'B_CTRG_Heli_Transport_01_sand_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'
])) exitWith {
	(_vehicle doorPhase 'door_R');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in ['B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F'])) exitWith {
	(_vehicle doorPhase 'Door_R_source');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in ['I_Heli_Transport_02_F','C_IDAP_Heli_Transport_02_F'])) exitWith {
	(_vehicle doorPhase 'Door_Back_R');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in [
		'O_Heli_Transport_04_ammo_black_F','O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_bench_black_F',
		'O_Heli_Transport_04_bench_F','O_Heli_Transport_04_black_F','O_Heli_Transport_04_box_black_F',
		'O_Heli_Transport_04_box_F','O_Heli_Transport_04_covered_black_F','O_Heli_Transport_04_covered_F',
		'O_Heli_Transport_04_F','O_Heli_Transport_04_fuel_black_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_black_F',
		'O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_black_F','O_Heli_Transport_04_repair_F'
])) exitWith {
	(_vehicle doorPhase 'Door_1_source');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in [
	'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
	'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
	'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
])) exitWith {
	(_vehicle doorPhase 'Door_3_source');
};
if (_vehicleType in _animate) exitWith {
	(_vehicle animationSourcePhase 'Doors');
};