/*/
File: fn_vTowable.sqf
Author:

	Quiksilver
	
Last modified:

	15/08/2018 A3 1.82 by Quiksilver
	
Description:

	Check if target is towable
__________________________________________________/*/
params ['_vehicle'];
if (_vehicle getVariable ['QS_ropeAttached',TRUE]) exitWith {FALSE;};
_vehiclePos = getPos _vehicle;
_vehicleRearDir = ((getDir _vehicle) + 180) mod 360;
_vehicleHalfLength = ((boundingBoxReal _vehicle) # 1) # 1;
_findPos = [
	(_vehiclePos # 0) + 2 * _vehicleHalfLength * sin _vehicleRearDir,
	(_vehiclePos # 1) + 2 * _vehicleHalfLength * cos _vehicleRearDir,
	_vehiclePos # 2
];
_towableCargoObjects = [
	'LandVehicle','Air','Ship','Reammobox_F',
	'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
	'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
	'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
	'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f',
	'b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f',
	'cargonet_01_box_f',
	'cargonet_01_barrels_f',
	'b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f',
	'land_device_slingloadable_f',
	'land_cargobox_v1_f',
	'land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f',
	'land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f',
	'land_watertank_f',
	'land_cargo10_idap_f','land_cargo20_idap_f','land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
	'land_destroyer_01_boat_rack_01_f'
];
(!((((_findPos nearEntities [_towableCargoObjects,(2 * _vehicleHalfLength)]) + (nearestObjects [_findPos,_towableCargoObjects,(2 * _vehicleHalfLength),TRUE])) select {((alive _x) && (!(_x isEqualTo _vehicle)))}) isEqualTo []));