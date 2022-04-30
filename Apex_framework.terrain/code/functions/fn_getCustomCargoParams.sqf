/*/
File: fn_getCustomCargoParams.sqf
Author: 

	Quiksilver

Last Modified:

	15/10/2017 A3 1.76 by Quiksilver

Description:

	Custom Cargo Data
	
Notes:

	QS_array = [];
	{
		QS_array pushBack (toLower (typeOf _x));
	} forEAch (curatorSelected select 0);
	copyToClipboard str QS_array;
	if ([0,object,objnull] call QS_fnc_getCustomCargoParams)
	
Notes 2:

	Lot of scope to flesh out this system with cost tables and stuff for better vehicle capacity
____________________________________________________________________________/*/

params [
	['_type',0],
	['_child',objNull],
	['_parent',objNull]
];
if (_type isEqualTo 0) exitWith {
	//comment 'Loadable object types';
	private _return = FALSE;
	_childType = toLower (typeOf _child);
	_loadableObjects = [
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
	];
	if (_childType in _loadableObjects) then {_return = TRUE;};
	_return;
};
if (_type isEqualTo 1) exitWith {
	//comment 'Can load to parent';
	private _return = FALSE;
	private _capacity = 0;
	private _count = 0;
	if ([0,_child,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
		if (_parent isKindOf 'Kart_01_Base_F') then {
			_capacity = 0;
		} else {
			if (_parent isKindOf 'Quadbike_01_base_F') then {
				_capacity = 1;
			} else {
				if ((getMass _parent) > 5000) then {
					if ((getMass _parent) > 15000) then {
						_capacity = 4;
					} else {
						_capacity = 3;
					};
				} else {
					_capacity = 2;
				};
			};
		};
	} else {
		_capacity = 0;
	};
	{
		if ([0,_x,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
			_count = _count + 1;
		};
	} count (attachedObjects _parent);
	_return = (_count < _capacity);
	_return;
};
if (_type isEqualTo 2) exitWith {
	//comment 'Towable non-vehicle object types';
	private _return = FALSE;
	_towableCargoObjects = [
		"b_slingload_01_repair_f","b_slingload_01_medevac_f","b_slingload_01_fuel_f","b_slingload_01_ammo_f","b_slingload_01_cargo_f",
		"land_pod_heli_transport_04_medevac_f","land_pod_heli_transport_04_covered_f","land_pod_heli_transport_04_ammo_f","land_pod_heli_transport_04_box_f","land_pod_heli_transport_04_repair_f",
		"land_pod_heli_transport_04_medevac_black_f","land_pod_heli_transport_04_covered_black_f","land_pod_heli_transport_04_ammo_black_f","land_pod_heli_transport_04_box_black_f","land_pod_heli_transport_04_repair_black_f",
		"land_pod_heli_transport_04_fuel_f","land_pod_heli_transport_04_fuel_black_f",
		"land_pod_heli_transport_04_bench_f","land_pod_heli_transport_04_bench_black_f",
		"box_nato_ammoveh_f","box_ind_ammoveh_f","box_east_ammoveh_f","box_eaf_ammoveh_f",
		"b_cargonet_01_ammo_f","o_cargonet_01_ammo_f","i_cargonet_01_ammo_f","c_idap_cargonet_01_supplies_f",'i_e_cargonet_01_ammo_f',
		"cargonet_01_box_f","cargonet_01_barrels_f",
		"b_supplycrate_f","o_supplycrate_f","i_supplycrate_f","c_t_supplycrate_f","c_supplycrate_f","ig_supplycrate_f","c_idap_supplycrate_f",
		"land_device_slingloadable_f",
		"land_cargobox_v1_f",
		"land_cargo10_yellow_f","land_cargo10_white_f","land_cargo10_sand_f","land_cargo10_red_f","land_cargo10_orange_f","land_cargo10_military_green_f","land_cargo10_light_green_f","land_cargo10_light_blue_f","land_cargo10_grey_f","land_cargo10_cyan_f","land_cargo10_brick_red_f","land_cargo10_blue_f",
		"land_cargo20_yellow_f","land_cargo20_white_f","land_cargo20_sand_f","land_cargo20_red_f","land_cargo20_orange_f","land_cargo20_military_green_f","land_cargo20_light_green_f","land_cargo20_light_blue_f","land_cargo20_grey_f","land_cargo20_cyan_f","land_cargo20_brick_red_f","land_cargo20_blue_f",
		"land_watertank_f",
		"land_cargo10_idap_f","land_cargo20_idap_f",'land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f',
		"b_hmg_01_high_f","b_gmg_01_high_f","o_hmg_01_high_f","o_gmg_01_high_f","i_hmg_01_high_f","i_gmg_01_high_f",
		"b_static_aa_f","b_static_at_f","o_static_aa_f","o_static_at_f","i_static_aa_f","i_static_at_f","b_t_static_aa_f","b_t_static_at_f",
		"b_g_mortar_01_f","b_mortar_01_f","b_t_mortar_01_f","o_mortar_01_f","o_g_mortar_01_f","i_mortar_01_f","i_g_mortar_01_f"
	];
	if (_childType in _towableCargoObjects) then {_return = TRUE;};
	_return;
};
if (_type isEqualTo 3) exitWith {
	//comment 'Return capacity';
	private _return = FALSE;
	private _capacity = 0;
	private _count = 0;
	if (_parent isKindOf 'Kart_01_Base_F') then {
		_capacity = 0;
	} else {
		if (_parent isKindOf 'Quadbike_01_base_F') then {
			_capacity = 1;
		} else {
			if ((getMass _parent) > 5000) then {
				if ((getMass _parent) > 15000) then {
					_capacity = 4;
				} else {
					_capacity = 3;
				};
			} else {
				_capacity = 2;
			};
		};
	};
	{
		if ([0,_x,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
			_count = _count + 1;
		};
	} count (attachedObjects _parent);
	_return = [_count,_capacity];
	_return;
};
if (_type isEqualTo 4) exitWith {
	//comment 'carry-ability';
	private _return = TRUE;
	_childType = toLower (typeOf _child);
	_nonCarryable = [
		'land_portablegenerator_01_f','land_plasticcase_01_large_gray_f','land_plasticcase_01_large_f','land_plasticcase_01_large_idap_f','box_aaf_equip_f',
		'box_csat_equip_f','box_idap_equip_f','box_nato_equip_f','box_nato_uniforms_f','box_idap_uniforms_f','box_csat_uniforms_f','box_aaf_uniforms_f','box_gen_equip_f',
		'flexibletank_01_forest_f','flexibletank_01_sand_f','land_portable_generator_f',
		'land_plasticcase_01_large_black_f','land_plasticcase_01_large_black_cbrn_f','land_plasticcase_01_large_cbrn_f','land_plasticcase_01_large_olive_f','land_plasticcase_01_large_olive_cbrn_f',
		'box_eaf_equip_f','box_eaf_uniforms_f'
	];
	if ((vehicle _parent) isKindOf 'CAManBase') then {
		if (_childType in _nonCarryable) then {
			_return = FALSE;
		};
	};
	_return;
};
FALSE;