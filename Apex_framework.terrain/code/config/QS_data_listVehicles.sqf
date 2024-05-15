/*/
File: QS_data_listVehicles.sqf
Author:

	Quiksilver
	
Last modified:

	28/04/2023 A3 2.12 by Quiksilver
	
Description:

	Lists of Vehicle Classnames and Config Classes for various systems
	
Notes:

	- Some Exceptions where lists of assets are still in files:
	
		"code\functions\fn_casRespawn.sqf"
________________________________/*/

params ['_type',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	(QS_hashmap_classLists getOrDefaultCall [format ['v_%1',_type],{[_type,1] call QS_data_listVehicles},TRUE])
};
if (_type isEqualTo 'cas_plane') exitWith {
	// CAS plane types
	[
		'b_plane_cas_01_f',
		'b_plane_cas_01_dynamicloadout_f',
		'b_plane_cas_01_cluster_f',
		'b_plane_fighter_01_f',
		'b_plane_fighter_01_stealth_f',
		'b_plane_fighter_01_cluster_f',
		'o_plane_cas_02_f',
		'o_plane_cas_02_dynamicloadout_f',
		'o_plane_cas_02_cluster_f',
		'o_plane_fighter_02_f',
		'o_plane_fighter_02_stealth_f',
		'o_plane_fighter_02_cluster_f',
		'i_plane_fighter_03_aa_f',
		'i_plane_fighter_03_cas_f',
		'i_plane_fighter_03_dynamicloadout_f',
		'i_plane_fighter_03_cluster_f',
		'i_plane_fighter_04_f',
		'i_plane_fighter_04_cluster_f'
	]
};
if (_type isEqualTo 'crv') exitWith {
	// Bobcat/Mine Clearance/Dozer/etc
	[
		'b_apc_tracked_01_crv_f',
		'b_t_apc_tracked_01_crv_f'
	]
};
if (_type isEqualTo 'enemy_antiair_types_1') exitWith {
	// Enemy anti-air assets, used in Anti-Air battery
	['o_apc_tracked_02_aa_f','o_t_apc_tracked_02_aa_ghex_f','o_sam_system_04_f']
};
if (_type isEqualTo 'enemy_artillery_types_1') exitWith {
	// Enemy anti-air assets, used in Anti-Air battery
	['o_mbt_02_arty_f','o_t_mbt_02_arty_ghex_f','i_truck_02_mrl_f']
};
if (_type isEqualTo 'armored_vehicles_1') exitWith {
	[
		"b_apc_wheeled_01_cannon_f","b_apc_tracked_01_rcws_f","b_mbt_01_cannon_f","b_mbt_01_tusk_f","b_apc_tracked_01_aa_f",
		"b_t_apc_wheeled_01_cannon_f","b_t_apc_tracked_01_rcws_f","b_t_apc_tracked_01_aa_f","b_t_mbt_01_cannon_f","b_t_mbt_01_tusk_f",
		"o_mbt_02_cannon_f","o_apc_tracked_02_cannon_f","o_apc_wheeled_02_rcws_f","o_apc_wheeled_02_rcws_v2_f","o_apc_tracked_02_aa_f",
		"o_t_apc_tracked_02_aa_ghex_f","o_t_apc_tracked_02_cannon_ghex_f","o_t_apc_wheeled_02_rcws_ghex_f","o_t_apc_wheeled_02_rcws_v2_ghex_f",
		"o_t_mbt_02_cannon_ghex_f","i_apc_wheeled_03_cannon_f","i_apc_tracked_03_cannon_f","i_mbt_03_cannon_f"
	]
};
if (_type isEqualTo 'veh_doors_1') exitWith {
	// Player "Open Cargo Doors" user interaction starts here
	[
		'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_attack_02_f',
		'o_heli_attack_02_black_f','b_heli_transport_03_f','b_heli_transport_03_unarmed_f','i_heli_transport_02_f','c_idap_heli_transport_02_f',
		'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
		'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
		'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
		'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
		'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f','b_heli_transport_03_unarmed_green_f',
		'b_ctrg_heli_transport_01_tropic_f','b_ctrg_heli_transport_01_sand_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f',
		'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
		'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
		'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_transport_mp_f','i_e_van_02_transport_f','i_e_van_02_vehicle_f','i_e_van_02_medevac_f'
	]
};
if (_type isEqualTo 'veh_doors_2') exitWith {
	// These ones use "animate" instead of "animateSource"
	['o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_light_02_dynamicloadout_f']
};
if (_type isEqualTo 'veh_doors_3') exitWith {
	// Helicopters with sliding cargo doors
	[	
		'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_attack_02_f','o_heli_attack_02_black_f','b_ctrg_heli_transport_01_tropic_f',
		'b_ctrg_heli_transport_01_sand_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f'
	]
};
if (_type isEqualTo 'veh_doors_4') exitWith {
	['b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f']
};
if (_type isEqualTo 'veh_doors_5') exitWith {
	['i_heli_transport_02_f','c_idap_heli_transport_02_f']
};
if (_type isEqualTo 'veh_doors_6') exitWith {
	[
		'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
		'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
		'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
		'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
		'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f'
	]
};
if (_type isEqualTo 'veh_doors_7') exitWith {
	[
		'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
		'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
		'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f','i_e_van_02_transport_f','i_e_van_02_vehicle_f'
	]
};

if (_type isEqualTo 'offroad_types_1') exitWith {
	// Offroad vehicle types for Beacons/Sirens/etc
	[
		'b_g_offroad_01_f','b_g_offroad_01_armed_f','b_g_offroad_01_repair_f','b_gen_offroad_01_gen_f','o_g_offroad_01_f','o_g_offroad_01_armed_f','o_g_offroad_01_repair_f',
		'i_g_offroad_01_f','i_g_offroad_01_armed_f','i_g_offroad_01_repair_f','c_offroad_01_f','c_offroad_01_repair_f','c_idap_offroad_01_f','c_offroad_01_blue_f','c_offroad_01_bluecustom_f',
		'c_offroad_01_darkred_f','c_offroad_01_red_f','c_offroad_01_sand_f','c_offroad_01_white_f','c_offroad_luxe_f','c_offroad_stripped_f','b_g_offroad_01_at_f','o_g_offroad_01_at_f','i_g_offroad_01_at_f'
	]
};
if (_type isEqualTo 'turret_safety_1') exitWith {
	// List of helis with Turret Safety System applied
	[
		'B_Heli_Transport_01_camo_F','B_Heli_Transport_01_F','B_Heli_Transport_03_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'
	]
};
if (_type isEqualTo 'chair_1') exitWith {
	// List of chair objects for Sit interaction
	[
		'Land_CampingChair_V1_F','Land_CampingChair_V2_F','Land_ChairPlastic_F','Land_RattanChair_01_F','Land_ChairWood_F','Land_OfficeChair_01_F','Land_ArmChair_01_F','Land_DeskChair_01_black_F','Land_DeskChair_01_olive_F','Land_DeskChair_01_sand_F'
	]
};
if (_type isEqualTo 'chair_2') exitWith {
	// List of chair object models for Sit interaction
	[
		'campingchair_v1_f.p3d','campingchair_v2_f.p3d','chairplastic_f.p3d','rattanchair_01_f.p3d','chairwood_f.p3d','officechair_01_f.p3d','armchair_01_f.p3d','deskchair_01_f.p3d'
	]
};
if (_type isEqualTo 'load_cargo_1') exitWith {
	// Vehicles into which stuff can be loaded (vehicle in vehicle)
	if ((missionNamespace getVariable ['QS_mission_vehicleTransportTypes',[]]) isEqualTo []) then {
		missionNamespace setVariable ['QS_mission_vehicleTransportTypes',(("(isClass (_x >> 'VehicleTransport' >> 'Carrier'))" configClasses (configFile >> 'CfgVehicles')) apply {toLowerANSI (configName _x)}),FALSE];
	};
	(missionNamespace getVariable ['QS_mission_vehicleTransportTypes',[]])
};
if (_type isEqualTo 'armed_heli_types_1') exitWith {
	[
		'b_heli_light_01_armed_f','b_heli_attack_01_f','o_heli_light_02_f','o_heli_light_02_v2_f','i_heli_light_03_f',
		'o_heli_attack_02_f','o_heli_attack_02_black_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f',
		'o_heli_attack_02_dynamicloadout_black_f','i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f',
		'b_heli_attack_01_dynamicloadout_f','b_heli_light_01_dynamicloadout_f'
	]
};
if (_type isEqualTo 'basic_heli_types_1') exitWith {
	[
		'heli_light_01_unarmed_base_f','heli_light_03_unarmed_base_f'
	]
};

if (_type isEqualTo 'ugv_types_1') exitWith {
	// List of UGV types
	[
		'b_ugv_01_f','b_t_ugv_01_olive_f','o_ugv_01_f','o_t_ugv_01_ghex_f','i_ugv_01_f','c_idap_ugv_01_f','i_e_ugv_01_f','i_e_ugv_01_rcws_f'
	]
};
if (_type isEqualTo 'base_aa_1') exitWith {
	// Airbase anti-air
	['b_aaa_system_01_f']
};
if (_type isEqualTo 'defend_transporttypes_1') exitWith {
	[
		'O_Truck_03_transport_F','O_Truck_03_covered_F',
		'O_Truck_02_transport_F','O_Truck_02_covered_F',
		'I_Truck_02_transport_F','I_Truck_02_covered_F',
		'O_MRAP_02_F','O_LSV_02_unarmed_F'
	]
};
if (_type isEqualTo 'defend_jettypes_1') exitWith {
	[
		'i_plane_fighter_03_dynamicloadout_f',0.5,
		'i_plane_fighter_04_f',0.4,
		'o_plane_fighter_02_f',0.1
	]
};
if (_type isEqualTo 'defend_helitypes_1') exitWith {
	// Stratis and Small Terrain enemy helis
	[
		'o_heli_light_02_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f','o_heli_light_02_dynamicloadout_f',
		'i_e_heli_light_03_dynamicloadout_f'
	]
};
if (_type isEqualTo 'defend_helitypes_2') exitWith {
	// Higher intensity
	[
		'o_heli_light_02_dynamicloadout_f','i_heli_light_03_dynamicloadout_f',
		'o_heli_light_02_dynamicloadout_f','i_heli_light_03_dynamicloadout_f',
		'O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F','O_VTOL_02_infantry_dynamicLoadout_F'
	]
};
if (_type isEqualTo 'defend_helitypes_3') exitWith {
	// Lower intensity
	[
		'o_heli_light_02_dynamicloadout_f','i_heli_light_03_dynamicloadout_f'
	]
};
if (_type isEqualTo 'defend_paravtypes_1') exitWith {
	[
		'O_MRAP_02_hmg_F','O_MRAP_02_gmg_F','O_G_Offroad_01_armed_F','O_G_Offroad_01_armed_F',
		'I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','Land_Pod_Heli_Transport_04_covered_F','Land_Pod_Heli_Transport_04_bench_F','Land_Pod_Heli_Transport_04_bench_F',
		'Land_Pod_Heli_Transport_04_covered_F'
	]
};
if (_type isEqualTo 'defend_flybytypes_1') exitWith {
	[
		'O_T_VTOL_02_infantry_dynamicLoadout_F',0.333,
		'O_Plane_CAS_02_dynamicLoadout_F',0.333,
		'o_plane_fighter_02_f',0.333
	]
};
if (_type isEqualTo 'defend_uavtypes_1') exitWith {
	['O_UAV_02_dynamicLoadout_F','I_UAV_02_dynamicLoadout_F','O_T_UAV_04_CAS_F']
};
if (_type isEqualTo 'classic_reinforcehelitransport_1') exitWith {
	'O_Heli_Transport_04_covered_F'
};
if (_type isEqualTo 'classic_reinforceheliescort_1') exitWith {
	'O_Heli_Attack_02_dynamicLoadout_F'
};
if (_type isEqualTo 'classic_reinforcevslingable_1') exitWith {
	[
		'o_mrap_02_f','o_mrap_02_gmg_f','o_mrap_02_hmg_f','o_lsv_02_armed_f','o_lsv_02_unarmed_f','o_t_mrap_02_ghex_f','o_t_mrap_02_gmg_ghex_f',
		'o_t_mrap_02_hmg_ghex_f','o_t_lsv_02_armed_f','o_t_lsv_02_unarmed_f',
		'i_mrap_03_f','i_mrap_03_gmg_f','i_mrap_03_hmg_f','o_g_offroad_01_armed_f','o_g_offroad_01_f','i_g_offroad_01_armed_f','i_g_offroad_01_f',
		'i_truck_02_transport_f','i_truck_02_covered_f','o_truck_02_transport_f','o_truck_02_covered_f',
		'o_ugv_01_f','o_ugv_01_rcws_f','o_t_ugv_01_rcws_ghex_f','o_t_ugv_01_ghex_f','i_ugv_01_f','i_ugv_01_rcws_f',
		'o_lsv_02_at_f','o_g_offroad_01_at_f','i_c_offroad_02_at_f','i_c_offroad_02_lmg_f','i_g_offroad_01_at_f','o_t_lsv_02_at_f'
	]
};
if (_type isEqualTo 'classic_reinforcevslinger_1') exitWith {
	// Default enemy sling heli
	'O_Heli_Transport_04_F'
};
if (_type isEqualTo 'classic_reinforcevslinger_2') exitWith {
	// Enemy sling helis
	['i_heli_transport_02_f','o_heli_transport_04_f']
};
if (_type isEqualTo 'fires_wrecktypes_1') exitWith {
	// Night illumination fire wrecks
	[	
		'land_wreck_hunter_f',0.1,
		'land_wreck_truck_f',0.1,
		'land_bulldozer_01_wreck_f',0.1,
		'land_combineharvester_01_wreck_f',0.1,
		'land_excavator_01_wreck_f',0.1,
		'land_bulldozer_01_abandoned_f',0.1,
		'land_wreck_slammer_f',0.3,
		'land_railwaycar_01_tank_f',0.1,
		'land_railwaycar_01_sugarcane_f',0.1,
		'land_wreck_afv_wheeled_01_f',1,
		'land_wreck_mbt_04_f',1,
		'land_wreck_lt_01_f',1,
		'land_mi8_wreck_f',1,
		'land_powergenerator_wreck_f',1,
		'land_wreck_heli_02_wreck_01_f',1
	]
};
if (_type isEqualto 'hq_cache_list_1') exitWith {
	// Crates default
	[
		'Box_East_Ammo_F',
		'Box_East_Wps_F',
		'O_CargoNet_01_ammo_F',
		'Box_East_AmmoOrd_F',
		'Box_East_Grenades_F',
		'Box_East_WpsLaunch_F',
		'Box_East_WpsSpecial_F',
		'O_supplyCrate_F',
		'Box_East_Support_F',
		'Box_East_AmmoVeh_F',
		'Box_NATO_Ammo_F',
		'Box_IND_Ammo_F'
	]
};
if (_type isEqualto 'hq_cache_list_2') exitWith {
	// Crates Tanoa
	[
		'Box_East_Ammo_F',
		'Box_East_Wps_F',
		'O_CargoNet_01_ammo_F',
		'Box_East_AmmoOrd_F',
		'Box_East_Grenades_F',
		'Box_East_WpsLaunch_F',
		'Box_East_WpsSpecial_F',
		'O_supplyCrate_F',
		'Box_East_Support_F',
		'Box_East_AmmoVeh_F',
		'Box_NATO_Ammo_F',
		'Box_IND_Ammo_F'
	]
};
if (_type isEqualto 'hq_cache_list_3') exitWith {
	// Crates Livonia
	[
		'Box_East_Ammo_F',
		'Box_East_Wps_F',
		'O_CargoNet_01_ammo_F',
		'Box_East_AmmoOrd_F',
		'Box_East_Grenades_F',
		'Box_East_WpsLaunch_F',
		'Box_East_WpsSpecial_F',
		'O_supplyCrate_F',
		'Box_East_Support_F',
		'Box_East_AmmoVeh_F',
		'Box_NATO_Ammo_F',
		'Box_IND_Ammo_F'
	]
};
if (_type isEqualTo 'hq_cache_undraggable_1') exitWith {
	['o_supplycrate_f','o_cargonet_01_ammo_f','box_east_ammoveh_f','i_e_cargonet_01_ammo_f']
};
if (_type isEqualTo 'classic_aorandomvehicles_1') exitWith {
	[
		'C_Truck_02_transport_F',0.2,
		'C_Truck_02_covered_F',0.2,
		'B_G_Offroad_01_armed_F',0.5,
		'B_G_Offroad_01_F',0.3,
		'B_G_Van_02_transport_F',0.3,
		'I_C_Offroad_02_LMG_F',0.5,
		'I_C_Offroad_02_AT_F',0.5
	]
};
if (_type isEqualTo 'ao_hvt_housetypes_1') exitWith {
	[
		'Land_i_House_Small_03_V1_F',
		'Land_u_House_Big_02_V1_F',
		'Land_i_House_Big_02_V3_F',
		'Land_i_House_Big_02_V1_F',
		'Land_i_House_Big_02_V2_F',
		'Land_u_House_Big_01_V1_F',
		'Land_i_House_Big_01_V3_F',
		'Land_i_House_Big_01_V1_F',
		'Land_i_House_Big_01_V2_F',
		'Land_u_Shop_02_V1_F',
		'Land_i_Shop_02_V3_F',
		'Land_i_Shop_02_V1_F',
		'Land_i_Shop_02_V2_F',
		'Land_u_Shop_01_V1_F',
		'Land_i_Shop_01_V3_F',
		'Land_i_Shop_01_V1_F',
		'Land_i_Shop_01_V2_F',
		'Land_u_House_Small_01_V1_F',
		'Land_u_House_Small_02_V1_F',
		'Land_i_House_Small_02_V3_F',
		'Land_i_House_Small_02_V1_F',
		'Land_i_House_Small_02_V2_F',
		'Land_i_House_Small_01_V3_F',
		'Land_i_House_Small_01_V1_F',
		'Land_i_House_Small_01_V2_F',
		'Land_i_Stone_HouseBig_V3_F',
		'Land_i_Stone_HouseBig_V1_F',
		'Land_i_Stone_HouseBig_V2_F',
		'Land_i_Stone_HouseSmall_V3_F',
		'Land_i_Stone_HouseSmall_V1_F',
		'Land_i_Stone_Shed_V2_F',
		'Land_i_Stone_Shed_V1_F',
		'Land_i_Stone_Shed_V3_F',
		'Land_i_Stone_HouseSmall_V2_F',
		'Land_i_House_Big_02_b_blue_F',
		'Land_i_House_Big_02_b_pink_F',
		'Land_i_House_Big_02_b_whiteblue_F',
		'Land_i_House_Big_02_b_white_F',
		'Land_i_House_Big_02_b_brown_F',
		'Land_i_House_Big_02_b_yellow_F',
		'Land_i_House_Big_01_b_blue_F',
		'Land_i_House_Big_01_b_pink_F',
		'Land_i_House_Big_01_b_whiteblue_F',
		'Land_i_House_Big_01_b_white_F',
		'Land_i_House_Big_01_b_brown_F',
		'Land_i_House_Big_01_b_yellow_F',
		'Land_i_Shop_02_b_blue_F',
		'Land_i_Shop_02_b_pink_F',
		'Land_i_Shop_02_b_whiteblue_F',
		'Land_i_Shop_02_b_white_F',
		'Land_i_Shop_02_b_brown_F',
		'Land_i_Shop_02_b_yellow_F',
		'Land_Barn_01_brown_F',
		'Land_Barn_01_grey_F',
		'Land_i_House_Small_01_b_blue_F',
		'Land_i_House_Small_01_b_pink_F',
		'Land_i_House_Small_02_b_blue_F',
		'Land_i_House_Small_02_b_pink_F',
		'Land_i_House_Small_02_b_whiteblue_F',
		'Land_i_House_Small_02_b_white_F',
		'Land_i_House_Small_02_b_brown_F',
		'Land_i_House_Small_02_b_yellow_F',
		'Land_i_House_Small_02_c_blue_F',
		'Land_i_House_Small_02_c_pink_F',
		'Land_i_House_Small_02_c_whiteblue_F',
		'Land_i_House_Small_02_c_white_F',
		'Land_i_House_Small_02_c_brown_F',
		'Land_i_House_Small_02_c_yellow_F',
		'Land_i_House_Small_01_b_whiteblue_F',
		'Land_i_House_Small_01_b_white_F',
		'Land_i_House_Small_01_b_brown_F',
		'Land_i_House_Small_01_b_yellow_F',
		'Land_i_Stone_House_Big_01_b_clay_F',
		'Land_i_Stone_Shed_01_b_clay_F',
		'Land_i_Stone_Shed_01_b_raw_F',
		'Land_i_Stone_Shed_01_b_white_F',
		'Land_i_Stone_Shed_01_c_clay_F',
		'Land_i_Stone_Shed_01_c_raw_F',
		'Land_i_Stone_Shed_01_c_white_F',
		'Land_House_Big_04_F',
		'Land_House_Small_04_F',
		'Land_House_Small_05_F',
		'Land_Addon_04_F',
		'Land_House_Big_03_F',
		'Land_House_Small_02_F',
		'Land_House_Big_02_F',
		'Land_House_Small_03_F',
		'Land_House_Small_06_F',
		'Land_House_Big_01_F',
		'Land_Slum_02_F',
		'Land_Slum_01_F',
		'Land_GarageShelter_01_F',
		'Land_House_Small_01_F',
		'Land_Slum_03_F',
		'Land_Temple_Native_01_F',
		'Land_House_Native_02_F',
		'Land_House_Native_01_F',
		"Land_GH_House_1_F",
		"Land_GH_House_2_F",
		"Land_GH_MainBuilding_entry_F",
		"Land_GH_MainBuilding_right_F",
		"Land_GH_MainBuilding_left_F",
		"Land_GH_Gazebo_F",
		"Land_WIP_F"
	]
};
if (_type isEqualTo 'ao_idap_enemyvehicles_1') exitWith {
	[
		'O_G_Offroad_01_F',0.3,
		'O_G_Van_01_transport_F',0.1,
		'I_C_Van_01_transport_F',0.1,
		'I_C_Offroad_02_unarmed_F',0.3
	]
};
if (_type isEqualTo 'mortarsite_trucktypes_1') exitWith {
	[
		'O_G_Offroad_01_F',
		'O_G_Van_01_transport_F',
		'I_C_Van_01_transport_F',
		'C_Truck_02_transport_F'
	]
};
if (_type isEqualTo 'ao_radiotower_types_1') exitWith {
	['Land_TTowerBig_2_F']
};
if (_type isEqualTo 'base_artillery_1') exitWith {
	['B_MBT_01_arty_F','B_MBT_01_mlrs_F']
};
if (_type isEqualTo 'player_mortarlite_01') exitWith {
	'B_Mortar_01_F'
};
if (_type isEqualTo 'draggable_boxes_1') exitWith {
	[
		'box_ind_ammo_f','box_t_east_ammo_f','box_east_ammo_f','box_nato_ammo_f','box_syndicate_ammo_f','box_ind_wps_f','box_t_east_wps_f','box_east_wps_f',
		'box_t_nato_wps_f','box_nato_wps_f','box_syndicate_wps_f','box_aaf_equip_f','box_csat_equip_f','box_nato_equip_f','box_ied_exp_f','box_ind_ammoord_f',
		'box_east_ammoord_f','box_nato_ammoord_f','box_ind_grenades_f','box_east_grenades_f','box_nato_grenades_f','box_ind_wpslaunch_f','box_east_wpslaunch_f',
		'box_nato_wpslaunch_f','box_syndicate_wpslaunch_f','box_ind_wpsspecial_f','box_t_east_wpsspecial_f','box_east_wpsspecial_f','box_t_nato_wpsspecial_f',
		'box_nato_wpsspecial_f','box_gen_equip_f','box_ind_support_f','box_east_support_f','box_nato_support_f','box_aaf_uniforms_f','box_csat_uniforms_f',
		'box_nato_uniforms_f','flexibletank_01_forest_f','flexibletank_01_sand_f','land_plasticcase_01_large_f','land_plasticcase_01_medium_f','land_plasticcase_01_small_f',
		'land_metalcase_01_large_f','land_metalcase_01_medium_f','land_metalcase_01_small_f'
	]
};
if (_type isEqualTo 'noncarryable_objects_1') exitWith {
	[
		'land_portablegenerator_01_f','land_plasticcase_01_large_gray_f','land_plasticcase_01_large_f','land_plasticcase_01_large_idap_f','box_aaf_equip_f',
		'box_csat_equip_f','box_idap_equip_f','box_nato_equip_f','box_nato_uniforms_f','box_idap_uniforms_f','box_csat_uniforms_f','box_aaf_uniforms_f','box_gen_equip_f',
		'flexibletank_01_forest_f','flexibletank_01_sand_f','land_portable_generator_f',
		'land_plasticcase_01_large_black_f','land_plasticcase_01_large_black_cbrn_f','land_plasticcase_01_large_cbrn_f','land_plasticcase_01_large_olive_f','land_plasticcase_01_large_olive_cbrn_f',
		'box_eaf_equip_f','box_eaf_uniforms_f'
	]
};
if (_type isEqualTo 'towable_objects_1') exitWith {
	[
		'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
		'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
		'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
		'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
		'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
		'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f',
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
	]
};
if (_type isEqualTo 'towable_objects_2') exitWith {
[
		'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
		'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
		'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
		'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
		'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
		'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f',
		'b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f',
		'cargonet_01_box_f','cargonet_01_barrels_f',
		'b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f',
		'land_device_slingloadable_f',
		'land_cargobox_v1_f',
		'land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f',
		'land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f',
		'land_watertank_f',
		'land_cargo10_idap_f','land_cargo20_idap_f','land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
		'b_hmg_01_high_f','b_gmg_01_high_f','o_hmg_01_high_f','o_gmg_01_high_f','i_hmg_01_high_f','i_gmg_01_high_f',
		'b_static_aa_f','b_static_at_f','o_static_aa_f','o_static_at_f','i_static_aa_f','i_static_at_f','b_t_static_aa_f','b_t_static_at_f',
		'b_g_mortar_01_f','b_mortar_01_f','b_t_mortar_01_f','o_mortar_01_f','o_g_mortar_01_f','i_mortar_01_f','i_g_mortar_01_f'
	]
};
if (_type isEqualTo 'towable_objects_3') exitWith {
	[
		'Reammobox_F','StaticWeapon',
		'b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f',
		'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
		'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f',
		'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f',
		'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f',
		'box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f',
		'b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f',
		'cargonet_01_box_f','cargonet_01_barrels_f',
		'b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f',
		'land_device_slingloadable_f',
		'land_cargobox_v1_f',
		'land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f',
		'land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f',
		'land_watertank_f',
		'land_cargo10_idap_f','land_cargo20_idap_f','land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
		'land_destroyer_01_boat_rack_01_f'
	]
};


if (_type isEqualTo 'destroyer_helilaunch_1') exitWith {
	// Types of helicopter that can move In/Out of Destroyer Hangar
	[
		'Heli_Transport_01_base_F',
		'Heli_Light_01_base_F',
		'Heli_Attack_01_base_F',
		'Heli_light_03_base_F',
		'Heli_Light_02_base_F'
	]
};
if (_type isEqualTo 'chair_types_1') exitWith {
	[
		'land_campingchair_v1_f',
		'land_campingchair_v2_f',
		'land_chairplastic_f',
		'land_rattanchair_01_f',
		'land_chairwood_f',
		'land_officechair_01_f',
		'land_armchair_01_f',
		'land_deskchair_01_black_f',
		'land_deskchair_01_olive_f',
		'land_deskchair_01_sand_f'
	]
};
if (_type isEqualTo 'chair_models_1') exitWith {
	[
		'campingchair_v1_f.p3d',
		'campingchair_v2_f.p3d',
		'chairplastic_f.p3d',
		'rattanchair_01_f.p3d',
		'chairwood_f.p3d',
		'officechair_01_f.p3d',
		'armchair_01_f.p3d',
		'deskchair_01_f.p3d'
	]
};
if (_type isEqualTo 'stealth_aircraft_1') exitWith {
	[
		'b_plane_fighter_01_stealth_f',
		'o_plane_fighter_02_stealth_f',
		'b_heli_light_01_dynamicloadout_f',
		'b_heli_attack_01_dynamicloadout_f',
		'b_heli_light_01_f',
		'b_heli_transport_01_f',
		'b_ctrg_heli_transport_01_sand_f',
		'b_ctrg_heli_transport_01_tropic_f'
	]
};
if (_type isEqualTo 'stealth_aircraft_2') exitWith {
	[
		'b_ctrg_heli_transport_01_sand_f','b_ctrg_heli_transport_01_tropic_f','b_heli_attack_01_dynamicloadout_f',
		'b_heli_transport_01_f','b_heli_transport_01_camo_f','b_plane_fighter_01_stealth_f',
		'b_t_uav_03_dynamicloadout_f','o_plane_fighter_02_stealth_f'
	]
};
if (_type isEqualTo 'civil_aircraft_1') exitWith {
	['i_c_plane_civil_01_f','c_plane_civil_01_racing_f','c_plane_civil_01_f']
};
if (_type isEqualTo 'easter_eggs_1') exitWith {
	[
		'B_Heli_Light_01_dynamicLoadout_F','C_Heli_Light_01_civil_F','O_Heli_Transport_04_F','B_Heli_Attack_01_dynamicLoadout_F',
		'O_Heli_Attack_02_black_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Light_02_unarmed_F',
		'I_Heli_light_03_dynamicLoadout_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_APC_Wheeled_02_rcws_v2_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
		'O_MBT_04_cannon_F','C_Tractor_01_F'
	]
};
if (_type isEqualTo 'easter_eggs_2') exitWith {
	[
		'C_Heli_Light_01_civil_F','O_Heli_Transport_04_F',
		'O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','I_APC_Wheeled_03_cannon_F','I_APC_tracked_03_cannon_F',
		'B_APC_Tracked_01_AA_F','B_MBT_01_cannon_F','I_MBT_03_cannon_F','O_APC_Wheeled_02_rcws_v2_F','I_LT_01_AT_F','I_LT_01_scout_F','I_LT_01_cannon_F','I_LT_01_AA_F',
		'O_MBT_04_cannon_F','C_Tractor_01_F'
	]
};
if (_type isEqualTo 'repair_depot_models_1') exitWith {
	// These object models can perform all services (repair,refuel,reammo)
	[
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_civ_f.p3d',
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d',
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d'
	]
};
if (_type isEqualTo 'services_all_1') exitWith {
	// These object models can perform all services (repair,refuel,reammo)
	[
		'a3\armor_f_beta\apc_tracked_01\apc_tracked_01_crv_f.p3d',
		'a3\armor_f_beta\apc_tracked_01\apc_tracked_01_crv_f.p3d',
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_civ_f.p3d',
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_green_f.p3d',
		'a3\structures_f_tank\military\repairdepot\repairdepot_01_tan_f.p3d'
	]
};
if (_type isEqualTo 'services_recover_1') exitWith {
	// These vehicle classes can perform Wreck Recovery by themselves, evaluated with "isKindOf"
	[
		'b_apc_tracked_01_crv_f'
	]

};
if (_type isEqualTo 'services_reammo_1') exitWith {
	[
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
	]
};
if (_type isEqualTo 'services_repair_1') exitWith {
	[
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
	]
};
if (_type isEqualTo 'services_refuel_1') exitWith {
	[
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
	]
};
if (_type isEqualTo 'loadable_cargo_objects_1') exitWith {
	[
		'box_ind_ammo_f',
		'box_t_east_ammo_f',
		'box_east_ammo_f',
		'box_nato_ammo_f',
		'box_syndicate_ammo_f',
		'box_ind_wps_f',
		'box_t_east_wps_f',
		'box_east_wps_f',
		'box_t_nato_wps_f',
		'box_nato_wps_f',
		'box_syndicate_wps_f',
		'box_aaf_equip_f',
		'box_csat_equip_f',
		'box_nato_equip_f',
		'box_ied_exp_f',
		'box_ind_ammoord_f',
		'box_east_ammoord_f',
		'box_nato_ammoord_f',
		'box_ind_grenades_f',
		'box_east_grenades_f',
		'box_nato_grenades_f',
		'box_ind_wpslaunch_f',
		'box_east_wpslaunch_f',
		'box_nato_wpslaunch_f',
		'box_syndicate_wpslaunch_f',
		'box_ind_wpsspecial_f',
		'box_t_east_wpsspecial_f',
		'box_east_wpsspecial_f',
		'box_t_nato_wpsspecial_f',
		'box_nato_wpsspecial_f',
		'box_gen_equip_f',
		'box_ind_support_f',
		'box_east_support_f',
		'box_nato_support_f',
		'box_aaf_uniforms_f',
		'box_csat_uniforms_f',
		'box_nato_uniforms_f',
		'flexibletank_01_forest_f',
		'flexibletank_01_sand_f',
		'land_plasticcase_01_large_f',
		'land_plasticcase_01_medium_f',
		'land_plasticcase_01_small_f',
		'land_metalcase_01_large_f',
		'land_metalcase_01_medium_f',
		'land_metalcase_01_small_f',
		'land_plasticcase_01_large_gray_f',
		'land_plasticcase_01_large_idap_f',
		'land_plasticcase_01_medium_gray_f',
		'land_plasticcase_01_medium_idap_f',
		'land_plasticcase_01_small_gray_f',
		'land_plasticcase_01_small_idap_f',
		'land_paperbox_01_small_closed_brown_f',
		'land_paperbox_01_small_closed_brown_idap_f',
		'land_paperbox_01_small_closed_brown_food_f',
		'land_paperbox_01_small_closed_white_med_f',
		'land_paperbox_01_small_closed_white_idap_f',
		'box_i_uav_06_medical_f',
		'box_o_uav_06_medical_f',
		'box_b_uav_06_medical_f',
		'box_i_uav_06_f',
		'box_o_uav_06_f',
		'box_b_uav_06_f',
		'box_c_uav_06_f',
		'box_c_uav_06_medical_f',
		'box_c_idap_uav_06_medical_f',
		'box_c_uav_06_swifd_f',
		'box_c_idap_uav_06_f',
		'box_idap_ammoord_f',
		'box_idap_uniforms_f',
		'box_idap_equip_f',
		'land_canisterfuel_blue_f',
		'land_canisterfuel_f',
		'land_canisterfuel_red_f',
		'land_canisterfuel_white_f',
		'land_suitcase_f',
		'land_carbattery_02_f',
		'land_carbattery_01_f',
		'land_pcset_01_case_f',
		'land_portable_generator_f',
		'land_portablegenerator_01_f',
		'land_plasticcase_01_large_black_f',
		'land_plasticcase_01_large_black_cbrn_f',
		'land_plasticcase_01_large_cbrn_f',
		'land_plasticcase_01_large_olive_f',
		'land_plasticcase_01_large_olive_cbrn_f',
		'cbrncase_01_f',
		'cbrncontainer_01_closed_olive_f',
		'cbrncontainer_01_olive_f',
		'cbrncontainer_01_closed_yellow_f',
		'cbrncontainer_01_yellow_f',
		'land_plasticcase_01_medium_black_f',
		'land_plasticcase_01_medium_black_cbrn_f',
		'land_plasticcase_01_medium_cbrn_f',
		'land_plasticcase_01_medium_olive_f',
		'land_plasticcase_01_medium_olive_cbrn_f',
		'land_plasticcase_01_small_black_f',
		'land_plasticcase_01_small_black_cbrn_f',
		'land_plasticcase_01_small_cbrn_f',
		'land_plasticcase_01_small_olive_f',
		'land_plasticcase_01_small_olive_cbrn_f',
		'land_batterypack_01_closed_black_f',
		'land_batterypack_01_closed_olive_f',
		'land_batterypack_01_closed_sand_f',
		'land_computer_01_black_f',
		'land_computer_01_olive_f',
		'land_computer_01_sand_f',
		'land_laptop_03_closed_black_f',
		'land_laptop_03_closed_olive_f',
		'land_laptop_03_closed_sand_f',
		'land_multiscreencomputer_01_closed_black_f',
		'land_multiscreencomputer_01_closed_olive_f',
		'land_multiscreencomputer_01_closed_sand_f',
		'land_portableserver_01_black_f',
		'land_portableserver_01_olive_f',
		'land_portableserver_01_sand_f',
		'box_eaf_ammo_f',
		'box_eaf_wps_f',
		'box_eaf_equip_f',
		'box_eaf_ammoord_f',
		'box_eaf_grenades_f',
		'box_eaf_wpslaunch_f',
		'box_eaf_wpsspecial_f',
		'box_eaf_support_f',
		'box_eaf_uniforms_f'
	]
};
if (_type isEqualTo 'grid_vehicles_1') exitWith {
	[
		'O_G_Van_01_transport_F',
		'I_C_Van_01_transport_F',
		'I_C_Offroad_02_unarmed_F',
		'O_G_Offroad_01_F'
	]
};
if (_type isEqualTo 'grid_vehicles_2') exitWith {
	[
		'O_G_Offroad_01_armed_F',0.3,
		'O_LSV_02_armed_F',0.2,
		'O_G_Van_01_transport_F',0.1,
		'O_G_Offroad_01_AT_F',0.2,
		'I_C_Offroad_02_AT_F',0.2,
		'I_C_Offroad_02_LMG_F',0.2
	]
};
if (_type isEqualTo 'grid_statics_1') exitWith {
	['o_hmg_02_high_f','o_gmg_01_high_f']
};
if (_type isEqualTo 'tropical_truck_types_1') exitWith {
	['O_T_Truck_03_repair_ghex_F','O_T_Truck_03_repair_ghex_F']
};
if (_type isEqualTo 'arid_truck_types_1') exitWith {
	['O_Truck_03_repair_F','O_Truck_03_repair_F']
};
if (_type isEqualTo 'georgetown_supplies_types_1') exitWith {
	[
		"Box_T_East_Ammo_F",
		"Box_Syndicate_Ammo_F",
		"Box_T_East_Wps_F",
		"Box_T_NATO_Wps_F",
		"Box_Syndicate_Wps_F",
		"Box_IED_Exp_F",
		"Box_Syndicate_WpsLaunch_F",
		"Box_GEN_Equip_F"
	]
};
if (_type isEqualTo 'arid_supplies_types_1') exitWith {
	[
		'Box_IND_Ammo_F',
		'Box_East_Ammo_F',
		'Box_East_Wps_F',
		'Box_IND_Wps_F',
		'Box_CSAT_Equip_F',
		'Box_AAF_Equip_F',
		'Box_East_Grenades_F',
		'Box_East_WpsSpecial_F',
		'Box_IND_WpsSpecial_F',
		'Box_IND_Support_F'
	]
};
if (_type isEqualTo 'fortifications_1') exitWith {
	[
		"Land_BagFence_Corner_F",
		"Land_BagFence_End_F",
		"Land_BagFence_Long_F",
		"Land_BagFence_Round_F",
		"Land_BagFence_Short_F",
		"Land_HBarrier_1_F",
		"Land_HBarrier_3_F",
		"Land_HBarrier_5_F",
		"Land_HBarrier_Big_F",
		"Land_HBarrierTower_F",
		"Land_HBarrierWall_corner_F",
		"Land_HBarrierWall_corridor_F",
		"Land_HBarrierWall4_F",
		"Land_HBarrierWall6_F",
		"Land_Razorwire_F",
		"Land_Shoot_House_Wall_F",
		"Land_Shoot_House_Wall_Stand_F",
		"Land_Shoot_House_Wall_Crouch_F",
		"Land_Shoot_House_Wall_Prone_F",
		"Land_Shoot_House_Wall_Long_F",
		"Land_Shoot_House_Wall_Long_Stand_F",
		"Land_Shoot_House_Wall_Long_Crouch_F",
		"Land_Shoot_House_Wall_Long_Prone_F",
		"Land_Shoot_House_Corner_F",
		"Land_Shoot_House_Corner_Stand_F",
		"Land_Shoot_House_Corner_Crouch_F",
		"Land_Shoot_House_Corner_Prone_F",
		"Land_Shoot_House_Panels_F",
		"Land_Shoot_House_Panels_Crouch_F",
		"Land_Shoot_House_Panels_Prone_F",
		"Land_Shoot_House_Panels_Vault_F",
		"Land_Shoot_House_Panels_Window_F",
		"Land_Shoot_House_Panels_Windows_F",
		"Land_Shoot_House_Tunnel_F",
		"Land_Shoot_House_Tunnel_Stand_F",
		"Land_Shoot_House_Tunnel_Crouch_F",
		"Land_Shoot_House_Tunnel_Prone_F",
		"Land_CncBarrier_F",
		"Land_CncBarrier_stripes_F",
		"Land_CncBarrierMedium_F",
		"Land_CncBarrierMedium4_F",
		"Land_CncShelter_F",
		"Land_CncWall1_F",
		"Land_CncWall4_F",
		"Land_Crash_barrier_F",
		"Land_Mil_ConcreteWall_F",
		"Land_Mil_WallBig_4m_F",
		"Land_Mil_WallBig_Corner_F",
		"Land_Mound01_8m_F",
		"Land_Mound02_8m_F",
		"Land_BagFence_01_corner_green_F",
		"Land_BagFence_01_end_green_F",
		"Land_BagFence_01_long_green_F",
		"Land_BagFence_01_round_green_F",
		"Land_BagFence_01_short_green_F",
		"Land_HBarrier_01_big_4_green_F",
		"Land_HBarrier_01_big_tower_green_F",
		"Land_HBarrier_01_line_1_green_F",
		"Land_HBarrier_01_line_3_green_F",
		"Land_HBarrier_01_line_5_green_F",
		"Land_HBarrier_01_wall_4_green_F",
		"Land_HBarrier_01_wall_6_green_F",
		"Land_HBarrier_01_wall_corner_green_F",
		"Land_HBarrier_01_wall_corridor_green_F",
		"Land_DragonsTeeth_01_1x1_new_F",
		"Land_DragonsTeeth_01_1x1_old_F",
		"Land_DragonsTeeth_01_4x2_new_F",
		"Land_DragonsTeeth_01_4x2_old_F",
		"Land_DragonsTeeth_01_1x1_new_redwhite_F",
		"Land_DragonsTeeth_01_1x1_old_redwhite_F",
		"Land_DragonsTeeth_01_4x2_new_redwhite_F",
		"Land_DragonsTeeth_01_4x2_old_redwhite_F",
		"Land_CzechHedgehog_01_new_F",
		"Land_ConcreteHedgehog_01_F",
		"Land_ConcreteHedgehog_01_half_F",
		"Land_ConcreteHedgehog_01_palette_F",
		"Land_Mound03_8m_F",
		"Land_Mound04_8m_F"
	]
};
if (_type isEqualTo 'air_bombsensors_1') exitWith {
	[
		'Radar_System_01_base_F','Radar_System_02_base_F','B_APC_Tracked_01_base_F','O_APC_Tracked_02_base_F','LT_01_scout_base_F','LT_01_AA_base_F'
	]
};
if (_type isEqualTo 'towing_max_train_1') exitWith {
	[
		'b_truck_01_mover_f',
		'b_t_truck_01_mover_f'
	]
};
if (_type isEqualTo 'backpack_drones_1') exitWith {
	[
		"b_uav_06_f","b_uav_06_medical_f","o_uav_06_f","o_uav_06_medical_f","i_uav_06_f","i_uav_06_medical_f","c_uav_06_f","c_uav_06_medical_f",
		"c_idap_uav_06_antimine_f","c_idap_uav_01_f","c_idap_uav_06_f","c_idap_uav_06_medical_f","b_uav_01_f","o_uav_01_f","i_uav_01_f"
	]
};
if (_type isEqualTo 'chute_types_1') exitWith {
	['nonsteerable_parachute_f','steerable_parachute_f','b_parachute_02_f','o_parachute_02_f','i_parachute_02_f']
};
if (_type isEqualTo 'eject_junk_1') exitWith {
	[
		'b_ejection_seat_plane_cas_01_f',
		'b_ejection_seat_plane_fighter_01_f',
		'i_ejection_seat_plane_fighter_03_f',
		'i_ejection_seat_plane_fighter_04_f',
		'o_ejection_seat_plane_cas_02_f',
		'o_ejection_seat_plane_fighter_02_f',
		'plane_cas_01_canopy_f',
		'plane_cas_02_canopy_f',
		'plane_fighter_01_canopy_f',
		'plane_fighter_02_canopy_f',
		'plane_fighter_03_canopy_f',
		'plane_fighter_04_canopy_f'
	]
};
if (_type isEqualTo 'protected_ruin_types_1') exitWith {
	[
		'land_cargo_tower_v1_ruins_f',
		'land_cargo_tower_v2_ruins_f',
		'land_cargo_tower_v3_ruins_f',
		'land_cargo_tower_v4_ruins_f',
		'land_radar_ruins_f'
	]
};
[];