/*/
File: fn_getCustomAttachPoint.sqf
Author: 

	Quiksilver

Last Modified:

	19/04/2023 A3 2.12 by Quiksilver

Description:

	Custom attach points for vehicles
	
Notes:
	
	copyToClipboard str (<parent> worldToModel (position <child>));
____________________________________________________/*/

params [
	['_detachAttach',FALSE],
	['_parent',objNull],
	['_child',objNull],
	['_attachPoint',[[0,-10,0],0]]
];
if (_parent isEqualType objNull) then {
	_parent = typeOf _parent;
};
if (_child isEqualType objNull) then {
	_child = typeOf _child;
};
_parent = toLowerANSI _parent;
_child = toLowerANSI _child;
if (_parent isKindOf 'b_truck_01_mover_f') exitWith {
	if (_child in ['b_slingload_01_repair_f','b_slingload_01_medevac_f','b_slingload_01_fuel_f','b_slingload_01_ammo_f','b_slingload_01_cargo_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,1],0];
		} else {
			_attachPoint = [0.139404,-9.21729,-1.72065];
		};
	};
	if (_child in [
		'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_repair_f',
		'land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_covered_black_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_repair_black_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.5,0.9],0];
		} else {
			_attachPoint = [0.00512695,-9.45349,-1.74052];
		};
	};
	if (_child in [
		'land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_fuel_black_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.75,1],0];
		} else {
			_attachPoint = [0.105713,-8.90381,-1.72377];
		};
	};
	if (_child in [
		'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.15,-3.6,0.95],0];
		} else {
			_attachPoint = [0.179199,-8.35583,-1.80251];
		};
	};
	if (_child in ['box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3,0.4],0];
		} else {
			_attachPoint = [0.0349121,-6.88416,-1.67472];
		};
	};
	if (_child in ['b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3,0.4],0];
		} else {
			_attachPoint = [0.0927734,-6.72534,-1.70423];
		};
	};
	if (_child in ['cargonet_01_box_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3,0.25],0];
		} else {
			_attachPoint = [0.0692139,-6.75977,-1.70436];
		};
	};
	if (_child in ['cargonet_01_barrels_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3,0.2],0];
		} else {
			_attachPoint = [0.0203857,-6.60645,-1.70345];
		};
	};
	if (_child in ['b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,0.5],0];
		} else {
			_attachPoint = [0.0090332,-6.42297,-1.70078];
		};
	};
	if (_child in ['land_device_slingloadable_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-4,0.5],0];
		} else {
			_attachPoint = [0.0341797,-8.34705,-1.67805];
		};
	};
	if (_child in ['land_cargobox_v1_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3,0.4],0];
		} else {
			_attachPoint = [0.0151367,-6.23706,-1.677];
		};
	};
	if (_child in ['land_cargo10_yellow_f','land_cargo10_white_f','land_cargo10_sand_f','land_cargo10_red_f','land_cargo10_orange_f','land_cargo10_military_green_f','land_cargo10_light_green_f','land_cargo10_light_blue_f','land_cargo10_grey_f','land_cargo10_cyan_f','land_cargo10_brick_red_f','land_cargo10_blue_f','land_cargo10_idap_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.4,1],270];
		} else {
			_attachPoint = [0.129883,-7.21118,-1.71386];
		};
	};
	if (_child in ['land_cargo20_yellow_f','land_cargo20_white_f','land_cargo20_sand_f','land_cargo20_red_f','land_cargo20_orange_f','land_cargo20_military_green_f','land_cargo20_light_green_f','land_cargo20_light_blue_f','land_cargo20_grey_f','land_cargo20_cyan_f','land_cargo20_brick_red_f','land_cargo20_blue_f','land_cargo20_idap_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,0.95],270];
		} else {
			_attachPoint = [-0.0400391,-8.89111,-1.72491];
		};
	};
	if (_child in ['land_watertank_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,0.3],90];
		} else {
			_attachPoint = [0.0561523,-6.90479,-1.7119];
		};
	};
	if (_child in ['land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.7,0.25],0];
		} else {
			_attachPoint = [0.13623,-6.52686,-1.67839];
		};	
	};
	if (_child in ['b_sam_system_02_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,1.6],0];
		} else {
			_attachPoint = [0.11377,-8.44922,-1.81292];
		};
	};
	if (_child in ['b_sam_system_01_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-3.2,1.4],0];
		} else {
			_attachPoint = [0.0810547,-8.57422,-1.81535];
		};
	};
	if (_child in ['b_aaa_system_01_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.9,2.15],0];
		} else {
			_attachPoint = [0.0810547,-8.57422,-1.81535];
		};
	};
	if (_child in [
		'b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f','b_t_vtol_01_infantry_blue_f','b_t_vtol_01_infantry_f',
		'b_t_vtol_01_infantry_olive_f','b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_f','b_t_vtol_01_vehicle_olive_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-17,5],0];
		} else {
			_attachPoint = [0.162598,-18.8606,-1.83932];
		};
	};
	if (_child in [
		'b_heli_transport_03_black_f','b_heli_transport_03_f','b_heli_transport_03_unarmed_f','b_heli_transport_03_unarmed_green_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-10,2],0];
		} else {
			_attachPoint = [-0.00830078,-12.7734,-2.0284];
		};
	};
	if (_child in [
		'o_t_vtol_02_infantry_dynamicloadout_f','o_t_vtol_02_infantry_f','o_t_vtol_02_infantry_ghex_f','o_t_vtol_02_infantry_grey_f','o_t_vtol_02_infantry_hex_f',
		'o_t_vtol_02_vehicle_dynamicloadout_f','o_t_vtol_02_vehicle_f','o_t_vtol_02_vehicle_ghex_f','o_t_vtol_02_vehicle_grey_f','o_t_vtol_02_vehicle_hex_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-12,1.3],0];
		} else {
			_attachPoint = [0.00488281,-12.624,-1.92691];
		};
	};
	if (_child in [
		'b_sam_system_03_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.03,-7.3,2],0,0];
		} else {
			_attachPoint = [0.0571289,-9.15479,-1.95839];
		};
	};
	if (_child in [
		'b_radar_system_01_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.03,-7,1],0,0];
		} else {
			_attachPoint = [0.0317383,-9.14307,-1.95822];
		};
	};		
	if (_child in [
		'o_sam_system_04_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.03,-7.1,0.3],0,0];
		} else {
			_attachPoint = [0.0366211,-8.9917,-1.9519];
		};
	};
	if (_child in [
		'o_radar_system_02_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.03,-5.5,1.98],0,0];
		} else {
			_attachPoint = [0.0473633,-7.97949,-3.73414];
		};
	};
	if (_child in [
		'land_destroyer_01_boat_rack_01_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0.0126953,-9.56494,-2],0,0];
		} else {
			_attachPoint = [0.0126953,-9.56494,-1.5];
		};	
	};
	_attachPoint
};
if (_parent isKindOf 'Offroad_01_base_F') exitWith {
	if (_child in ['b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.1,0.25],90];
		} else {
			_attachPoint = [-0.0697021,-5.31775,-1.54134];
		};
	};
	if (_child in ['b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[-0.03,-2.1,0.15],0];
		} else {
			_attachPoint = [-0.0563965,-5.10864,-1.53924];
		};
	};
	if (_child in ['cargonet_01_box_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[-0.03,-2.1,-0.025],0];
		} else {
			_attachPoint = [-0.0499268,-5.13037,-1.53947];
		};
	};
	if (_child in ['cargonet_01_barrels_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[-0.03,-2.1,-0.15],0];
		} else {
			_attachPoint = [-0.0394287,-5.04114,-1.53859];
		};
	};
	if (_child in ['land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2,0],0];
		} else {
			_attachPoint = [0.00219727,-5.27832,-1.40842];
		};	
	};
	if (_child in [
		'land_destroyer_01_boat_rack_01_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[-0.0263672,-8.23633,-1.67117],0,0];
		} else {
			_attachPoint = [-0.0263672,-8.23633,-1.67117];
		};	
	};
	_attachPoint
};
if (_parent in [
	'b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'
]) exitWith {
	if (_child in [
		'land_destroyer_01_boat_rack_01_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[-0.00488281,-10.1553,-2.60176],0,0];
		} else {
			_attachPoint = [-0.00488281,-10.1553,-2.2];
		};
	};
	_attachPoint
};

if (_parent isKindOf 'UGV_01_base_F') exitWith {
	if (_child isKindOf 'Slingload_01_Base_F') then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,0,0.65],0];
		} else {
			_attachPoint = [0.43,-5.5,0.65];
		};
	};
	if (_child isKindOf 'Cargo10_base_F') then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.5,0.65],90];
		} else {
			_attachPoint = [0.43,-4,0.65];
		};
	};
	if (_child in ['b_supplycrate_f','o_supplycrate_f','i_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','c_idap_supplycrate_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.54,0.2],0];
		} else {
			_attachPoint = [0.43,-3.73389,-1.92198];
		};
	};
	if (_child in ['b_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_cargonet_01_ammo_f','c_idap_cargonet_01_supplies_f','i_e_cargonet_01_ammo_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.45,0.10],0];
		} else {
			_attachPoint = [0.43,-4.30127,-1.92299];
		};
	};
	if (_child in ['cargonet_01_box_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.45,-0.069],0];
		} else {
			_attachPoint = [0.43,-3.93823,-1.9223];
		};
	};
	if (_child in ['cargonet_01_barrels_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.45,-0.175],0];
		} else {
			_attachPoint = [0.43,-4.12476,-1.92268];
		};
	};
	if (_child in ['land_paperbox_01_small_stacked_f','land_waterbottle_01_stack_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.45,-0.069],0];
		} else {
			_attachPoint = [0.43,-4.13208,-1.92251];
		};	
	};
	if (_child in ['box_nato_ammoveh_f','box_ind_ammoveh_f','box_east_ammoveh_f','box_eaf_ammoveh_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.4,0.12],0];
		} else {
			_attachPoint = [0.43,-4.11475,-1.89199];
		};
	};
	if (_child in ['b_sdv_01_f','o_sdv_01_f','i_sdv_01_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,0.5,1.2],0];
		} else {
			_attachPoint = [0.43,-5.55127,-1.99849];
		};
	};
	if (['heli_light_01',_child,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
		if (_detachAttach) then {
			_attachPoint = [
				[[0.43,-1.25,1],0],
				[[0.43,-2,-0.2],0]
			] select (['c_heli',_child,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'));
		} else {
			_attachPoint = [0.43,-7.87402,-1.95889];
		};
	};
	if (_child in ['b_uav_05_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-1,0.5],0];
		} else {
			_attachPoint = [0.43,-7,-2];
		};
	};
	if (_child in ['o_t_uav_04_cas_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0.43,-0.5,0.5],0];
		} else {
			_attachPoint = [0.43,-5.9,-2];
		};	
	};
	_attachPoint
};
if (_parent isKindOf 'van_01_transport_base_F') exitWith {
	if (_child in [
		'b_hmg_01_high_f','b_gmg_01_high_f','o_hmg_01_high_f','o_gmg_01_high_f','i_hmg_01_high_f','i_gmg_01_high_f','i_e_gmg_01_high_f',
		'b_g_hmg_02_high_f','o_g_hmg_02_high_f','i_hmg_02_high_f','i_g_hmg_02_high_f','i_e_hmg_02_high_f','i_c_hmg_02_high_f'
	]) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.5,1],0];
		} else {
			_attachPoint = [-0.0332031,-6.5061,-1.97767];
		};
	};
	if (_child in ['b_static_aa_f','b_static_at_f','o_static_aa_f','o_static_at_f','i_static_aa_f','i_static_at_f','b_t_static_aa_f','b_t_static_at_f','i_e_static_aa_f','i_e_static_at_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.5,0.375],180];
		} else {
			_attachPoint = [-0.0205078,-5.62256,-1.94009];
		};
	};
	if (_child in ['b_g_mortar_01_f','b_mortar_01_f','b_t_mortar_01_f','o_mortar_01_f','o_g_mortar_01_f','i_mortar_01_f','i_g_mortar_01_f','i_e_mortar_01_f']) then {
		if (_detachAttach) then {
			_attachPoint = [[0,-2.25,0.1],0];
		} else {
			_attachPoint = [0.0551758,-6.72046,-1.93928];
		};
	};
	_attachPoint
};
_attachPoint;