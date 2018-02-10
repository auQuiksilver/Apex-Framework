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
_vt = typeOf _vehicle;
_animateDoor = [
	'B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F',
	'B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F','I_Heli_Transport_02_F','C_IDAP_Heli_Transport_02_F',
	'O_Heli_Transport_04_ammo_black_F','O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_bench_black_F',
	'O_Heli_Transport_04_bench_F','O_Heli_Transport_04_black_F','O_Heli_Transport_04_box_black_F',
	'O_Heli_Transport_04_box_F','O_Heli_Transport_04_covered_black_F','O_Heli_Transport_04_covered_F',
	'O_Heli_Transport_04_F','O_Heli_Transport_04_fuel_black_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_black_F',
	'O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_black_F','O_Heli_Transport_04_repair_F','B_CTRG_Heli_Transport_01_tropic_F','B_CTRG_Heli_Transport_01_sand_F',
	'O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F',
	'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
	'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
	'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
];
_animate = ['O_Heli_Light_02_unarmed_F','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_dynamicLoadout_F'];
if (_vt in _animateDoor) exitWith {
	if (_vt in [
		'B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Attack_02_F','O_Heli_Attack_02_black_F','B_CTRG_Heli_Transport_01_tropic_F','B_CTRG_Heli_Transport_01_sand_F',
		'O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'
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
		if (_vt in ['B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_green_F']) then {
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
			if (_vt in ['I_Heli_Transport_02_F','C_IDAP_Heli_Transport_02_F']) then {
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
					'O_Heli_Transport_04_ammo_black_F','O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_bench_black_F',
					'O_Heli_Transport_04_bench_F','O_Heli_Transport_04_black_F','O_Heli_Transport_04_box_black_F',
					'O_Heli_Transport_04_box_F','O_Heli_Transport_04_covered_black_F','O_Heli_Transport_04_covered_F',
					'O_Heli_Transport_04_F','O_Heli_Transport_04_fuel_black_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_black_F',
					'O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_black_F','O_Heli_Transport_04_repair_F'
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
						'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
						'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
						'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
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