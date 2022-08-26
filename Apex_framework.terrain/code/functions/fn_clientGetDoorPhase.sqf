/*
File: fn_clientGetDoorPhase.sqf
Author:
	
	Quiksilver
	
Last Modified:

	21/07/2022 A3 2.10 by Quiksilver

Description:

	Get Door Phase
__________________________________________________________*/

_vehicle = _this # 0;
_vehicleType = toLowerANSI (typeOf _vehicle);
_animateDoor = [
	'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_attack_02_f','o_heli_attack_02_black_f',
	'b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f','i_heli_transport_02_f','c_idap_heli_transport_02_f',
	'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
	'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
	'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
	'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
	'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f','b_ctrg_heli_transport_01_tropic_f',
	'b_ctrg_heli_transport_01_sand_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f',
	'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
	'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f','i_e_van_02_transport_f','i_e_van_02_vehicle_f'
];
_animate = ['o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_light_02_dynamicloadout_f'];
if ((_vehicleType in _animateDoor) && (_vehicleType in ['b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_attack_02_f','o_heli_attack_02_black_f','b_ctrg_heli_transport_01_tropic_f',
	'b_ctrg_heli_transport_01_sand_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f'
])) exitWith {
	(_vehicle doorPhase 'door_R');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in ['b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f'])) exitWith {
	(_vehicle doorPhase 'Door_R_source');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in ['i_heli_transport_02_f','c_idap_heli_transport_02_f'])) exitWith {
	(_vehicle doorPhase 'Door_Back_R');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in [
		'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
		'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
		'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
		'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
		'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f'
])) exitWith {
	(_vehicle doorPhase 'Door_1_source');
};
if ((_vehicleType in _animateDoor) && (_vehicleType in [
	'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
	'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f','i_e_van_02_transport_f','i_e_van_02_vehicle_f'
])) exitWith {
	(_vehicle doorPhase 'Door_3_source');
};
if (_vehicleType in _animate) exitWith {
	(_vehicle animationSourcePhase 'Doors');
};