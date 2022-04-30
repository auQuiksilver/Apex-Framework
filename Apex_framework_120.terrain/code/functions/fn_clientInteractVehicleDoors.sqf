/*
File: fn_clientInteractVehicleDoors.sqf
Author:

	Quiksilver
	
Last Modified:

	11/01/2015 ArmA 3 1.54
	
Description:

	-
_____________________________________________________________*/

(_this select 3) params [
	'_vehicle',
	'_value'
];
_vt = toLower (typeOf _vehicle);
_animateDoor = [
	'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_attack_02_f','o_heli_attack_02_black_f',
	'b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f','i_heli_transport_02_f','c_idap_heli_transport_02_f',
	'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
	'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
	'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
	'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
	'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f','b_ctrg_heli_transport_01_tropic_f','b_ctrg_heli_transport_01_sand_f',
	'o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f',
	'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
	'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f'
];
_animate = ['o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_light_02_dynamicloadout_f'];
if (_vt in _animateDoor) exitWith {
	if (_vt in [
		'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_attack_02_f','o_heli_attack_02_black_f','b_ctrg_heli_transport_01_tropic_f','b_ctrg_heli_transport_01_sand_f',
		'o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f'
	]) then {
		if ((_vehicle doorPhase 'door_R') isEqualTo 0) then {
			_vehicle animateDoor ['door_R',1];
			_vehicle animateDoor ['door_L',1];
		} else {
			if ((_vehicle doorPhase 'door_R') isEqualTo 1) then {
				_vehicle animateDoor ['door_R',0];
				_vehicle animateDoor ['door_L',0];
			};
		};
	} else {
		if (_vt in ['b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f']) then {
			if ((_vehicle doorPhase 'Door_R_source') isEqualTo 0) then {
				_vehicle animateDoor ['Door_R_source',1];
				_vehicle animateDoor ['Door_L_source',1];
			} else {
				if ((_vehicle doorPhase 'Door_R_source') isEqualTo 1) then {
					_vehicle animateDoor ['Door_R_source',0];
					_vehicle animateDoor ['Door_L_source',0];
				};
			};		
		} else {
			if (_vt in ['i_heli_transport_02_f','c_idap_heli_transport_02_f']) then {
				if ((_vehicle doorPhase 'Door_Back_R') isEqualTo 0) then {
					{
						_vehicle animateDoor _x;
					} forEach [
						['Door_Back_R',1],
						['Door_Back_L',1]
					];
				} else {
					if ((_vehicle doorPhase 'Door_Back_R') isEqualTo 1) then {
						{
							_vehicle animateDoor _x;
						} forEach [
							['Door_Back_R',0],
							['Door_Back_L',0]
						];
					};
				};
			} else {
				if (_vt in [
					'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
					'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
					'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
					'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
					'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f'
				]) then {
					if ((_vehicle doorPhase 'Door_1_source') isEqualTo 0) then {
						{
							_vehicle animateDoor _x;
						} forEach [
							['Door_1_source',1],
							['Door_2_source',1],
							['Door_3_source',1]
						];
					} else {
						if ((_vehicle doorPhase 'Door_1_source') isEqualTo 1) then {
							{
								_vehicle animateDoor _x;
							} forEach [
								['Door_1_source',0],
								['Door_2_source',0],
								['Door_3_source',0]
							];
						};
					};
				} else {
					if (_vt in [
						'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
						'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
						'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f'
					]) then {
						if ((_vehicle doorPhase 'Door_3_source') isEqualTo 0) then {
							{
								_vehicle animateDoor _x;
							} forEach [
								['Door_3_source',1],
								['Door_4_source',1]
							];
						} else {
							if ((_vehicle doorPhase 'Door_3_source') isEqualTo 1) then {
								{
									_vehicle animateDoor _x;
								} forEach [
									['Door_3_source',0],
									['Door_4_source',0]
								];
							};
						};
					};
				};
			};
		};
	};
};
if (_vt in _animate) exitWith {
	if ((_vehicle animationSourcePhase 'Doors') isEqualTo 0) then {
		_vehicle animateSource ['Doors',1,1];
		_vehicle animateSource ['Doors',1,1];
	} else {
		if ((_vehicle animationSourcePhase 'Doors') isEqualTo 1) then {
			_vehicle animateSource ['Doors',0,1];
			_vehicle animateSource ['Doors',0,1];
		};
	};
};