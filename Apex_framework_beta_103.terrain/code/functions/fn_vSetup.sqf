/*/
File: fn_vSetup.sqf
Author:

	Quiksilver
	
Last Modified:

	26/06/2017 A3 1.72 by Quiksilver
	
Description:

	Server-side player-accessible vehicle setup
_____________________________________________________/*/

private ['_u','_t','_cargoseats','_isSimpleObject'];

_u = _this select 0;
_t = typeOf _u;
_u setVariable ['QS_vehicle',TRUE,FALSE];
_z = FALSE;
_isSimpleObject = isSimpleObject _u;
if ((count _this) > 1) then {_z = _this select 1;};

/*/============================================= ARRAYS/*/

_orca = ['O_Heli_Light_02_unarmed_F','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Light_02_dynamicLoadout_F'];
_ghosthawk = ["B_Heli_Transport_01_camo_F","B_Heli_Transport_01_F","B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"]; 						/*/ghosthawk/*/
_strider = ["I_MRAP_03_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"];								/*/ strider/*/
_blackVehicles = ["B_Heli_Light_01_F","B_Heli_Light_01_armed_F",'B_Heli_Light_01_dynamicLoadout_F'];							/*/black skin/*/
_mobileArmory = ["B_Truck_01_ammo_F","B_T_Truck_01_ammo_F","Land_Pod_Heli_Transport_04_ammo_F","B_Slingload_01_Ammo_F","O_Truck_03_ammo_F","I_Truck_02_ammo_F","O_Truck_02_Ammo_F",'Land_Pod_Heli_Transport_04_ammo_black_F'];											/*/Mobile Armory/*/
_noAmmoCargo = [];																	/*/ Bobcat CRV/*/
_huronUnarmed = ["B_Heli_Transport_03_unarmed_green_F","B_Heli_Transport_03_unarmed_F"];
_huronArmed = ["B_Heli_Transport_03_F"];
_towVs = [
	"b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f","c_offroad_01_f","c_offroad_01_repair_f",
	"o_g_offroad_01_f","b_g_offroad_01_f","i_g_offroad_01_f","o_g_offroad_01_repair_f","i_g_offroad_01_repair_f","b_g_offroad_01_repair_f","b_gen_offroad_01_gen_f",'c_idap_offroad_01_f',
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
];
_towLite = [
	"c_offroad_01_f","c_offroad_01_repair_f","o_g_offroad_01_f","b_g_offroad_01_f","i_g_offroad_01_f","o_g_offroad_01_repair_f","i_g_offroad_01_repair_f","b_g_offroad_01_repair_f",
	"b_gen_offroad_01_gen_f",'c_idap_offroad_01_f',
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	"b_g_van_01_transport_f","o_g_van_01_transport_f","i_g_van_01_transport_f","i_c_van_01_transport_f","i_c_van_01_transport_brown_f",
	"i_c_van_01_transport_olive_f","c_van_01_transport_f","c_van_01_transport_red_f","c_van_01_transport_white_f"
];
_towMed = ["B_Truck_01_Repair_F","B_T_Truck_01_Repair_F","O_Truck_03_repair_F","I_Truck_02_box_F","O_Truck_02_box_F"];
_towHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
_towSHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
_utility = ["C_Offroad_01_repair_F","B_G_Offroad_01_repair_F"];
_startLocked = ['B_MBT_01_TUSK_F','B_APC_Wheeled_01_cannon_F','B_MBT_01_cannon_F','B_APC_Tracked_01_rcws_F','B_APC_Tracked_01_AA_F','I_APC_tracked_03_cannon_F'];
_hemttAmmo = ['B_Truck_01_ammo_F','B_T_Truck_01_ammo_F'];
_bobcat = ['B_APC_Tracked_01_CRV_F','B_T_APC_Tracked_01_CRV_F'];
_taru_default = ['O_Heli_Transport_04_F','O_Heli_Transport_04_black_F'];
_taru_with_pod = ['O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_box_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_F','O_Heli_Transport_04_covered_F','O_Heli_Transport_04_covered_black_F'];
_taru = _taru_default + _taru_with_pod;
_taru_pod = ['Land_Pod_Heli_Transport_04_ammo_F','Land_Pod_Heli_Transport_04_box_F','Land_Pod_Heli_Transport_04_fuel_F','Land_Pod_Heli_Transport_04_medevac_F','Land_Pod_Heli_Transport_04_repair_F','Land_Pod_Heli_Transport_04_covered_F','Land_Pod_Heli_Transport_04_covered_black_F'];
_taru_bench = ['Land_Pod_Heli_Transport_04_bench_F','Land_Pod_Heli_Transport_04_bench_black_F'];
_taru_with_bench = ['O_Heli_Transport_04_bench_F'];
_fuelCargo = ['FlexibleTank_01_sand_F','FlexibleTank_01_forest_F','B_Slingload_01_Fuel_F','B_APC_Tracked_01_CRV_F','B_T_APC_Tracked_01_CRV_F','B_G_Van_01_fuel_F','B_Truck_01_fuel_F','B_T_Truck_01_fuel_F','Land_Pod_Heli_Transport_04_fuel_F','O_Heli_Transport_04_fuel_F','O_Truck_03_fuel_F','O_Truck_02_fuel_F','I_Truck_02_fuel_F','C_Van_01_fuel_F'];
_ammoCargo = ['B_APC_Tracked_01_CRV_F','B_T_APC_Tracked_01_CRV_F','B_Truck_01_ammo_F','B_T_Truck_01_ammo_F','O_Truck_03_ammo_F','O_Truck_02_Ammo_F','I_Truck_02_ammo_F','O_Heli_Transport_04_ammo_F','Land_Pod_Heli_Transport_04_ammo_F','B_Slingload_01_Ammo_F'];
_repairCargo = ['C_Offroad_01_repair_F','B_APC_Tracked_01_CRV_F','B_T_APC_Tracked_01_CRV_F','B_Truck_01_Repair_F','B_T_Truck_01_Repair_F','B_Slingload_01_Repair_F','B_G_Offroad_01_repair_F','Land_Pod_Heli_Transport_04_repair_F','O_Truck_03_repair_F','I_Truck_02_box_F','O_Truck_02_box_F'];
_gorgon = ['I_APC_Wheeled_03_cannon_F'];
_mora = ['I_APC_tracked_03_cannon_F'];
_vtol_west = [
	"B_T_VTOL_01_armed_blue_F","B_T_VTOL_01_armed_F","B_T_VTOL_01_armed_olive_F","B_T_VTOL_01_infantry_blue_F",
	"B_T_VTOL_01_infantry_F","B_T_VTOL_01_infantry_olive_F","B_T_VTOL_01_vehicle_blue_F","B_T_VTOL_01_vehicle_F",
	"B_T_VTOL_01_vehicle_olive_F"
];
_vtol_east = [
	"O_T_VTOL_02_infantry_F","O_T_VTOL_02_infantry_ghex_F","O_T_VTOL_02_infantry_grey_F","O_T_VTOL_02_infantry_hex_F","O_T_VTOL_02_vehicle_F","O_T_VTOL_02_vehicle_ghex_F",
	"O_T_VTOL_02_vehicle_grey_F","O_T_VTOL_02_vehicle_hex_F","O_T_VTOL_02_infantry_dynamicLoadout_F","O_T_VTOL_02_vehicle_dynamicLoadout_F"
];
_lsv_west = [
	"B_CTRG_LSV_01_light_F","B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_CTRG_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F",
	"B_T_LSV_01_armed_sand_F","B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_CTRG_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F",
	"B_T_LSV_01_unarmed_sand_F"
];
_marid = ['O_T_APC_Wheeled_02_rcws_ghex_F','O_APC_Wheeled_02_rcws_F'];
_t100 = ['O_MBT_02_cannon_F','O_T_MBT_02_cannon_ghex_F'];
_ambulances = ['C_IDAP_Van_02_medevac_F','C_Van_02_medevac_F'];
_idap = ['C_IDAP_Van_02_medevac_F','C_IDAP_Offroad_02_unarmed_F','C_IDAP_Offroad_01_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F','C_IDAP_Truck_02_transport_F','C_IDAP_Truck_02_F','C_IDAP_Truck_02_water_F','C_IDAP_UGV_01_F','C_IDAP_Heli_Transport_02_F'];
_van = [
	'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
	'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
	'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
];

/*/============================================= SORT/*/

if (!(_isSimpleObject)) then {
	if (!(_z)) then {
		_u lock 0;
	};
};

/*/===== black camo/*/
if (_t in _blackVehicles) then {
	for '_i' from 0 to 9 do {_u setObjectTextureGlobal [_i,'#(argb,8,8,3)color(0,0,0,0.6)'];};
};

/*/===== strider nato skin/*/
if (_t in _strider) then {
	if (!(_z)) then {
		_u setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
		_u setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa'];
	};
};
if (_t in _mora) then {
	if (!(_z)) then {
		//_u setObjectTextureGlobal [0,'media\images\vskins\fv720\apc_tracked_03_ext_blufor_co.paa'];	// enable this if skin is active
		//_u setObjectTextureGlobal [1,'media\images\vskins\fv720\apc_tracked_03_ext2_blufor_co.paa'];	// enable this if skin is active
	};
};

/*/===== kuma/*/
if (_t in ['I_MBT_03_cannon_F']) then {
	if (!(_z)) then {	
		{
			//_u setObjectTextureGlobal _x;		// enable this if skin is active
		} forEach [
			[0,'media\images\vskins\mbt52\mbt_03_ext01_blufor_co.paa'],
			[1,'media\images\vskins\mbt52\mbt_03_ext02_blufor_co.paa'],
			[2,'media\images\vskins\mbt52\mbt_03_rcws_blufor_co.paa']
		];
	};
};

/*/===== Laser Targetted/*/
if (!(_isSimpleObject)) then {
	if (!(_z)) then {
		if ((_t in _mobileArmory) || {(_t in ['I_MBT_03_cannon_F','B_MBT_01_cannon_F','B_MBT_01_TUSK_F','B_APC_Wheeled_01_cannon_F','I_APC_Wheeled_03_cannon_F','B_APC_Tracked_01_rcws_F','O_T_APC_Wheeled_02_rcws_ghex_F'])}) then {
			if (!isNil {missionNamespace getVariable 'QS_HVT_totalList'}) then {
				if ((random 1) > 0.666) then {
					QS_HVT_totalList pushBack _u;
				};
			};
		};
	};
};

if (!(_isSimpleObject)) then {
	private _t2 = toLower _t;
	if (_t in _ghosthawk) then {
		_u setVariable ['turretL_locked',FALSE,TRUE];
		_u setVariable ['turretR_locked',FALSE,TRUE];
		_u animateDoor ['door_R',1];
		_u animateDoor ['door_L',1];
	};
	if (_t in _orca) then {
		_u animateSource ['Doors',1,1];
		_u animateSource ['Doors',1,1];
	};
	if (_t in _huronArmed) then {
		_u setVariable ['turretL_locked',FALSE,TRUE];
		_u setVariable ['turretR_locked',FALSE,TRUE];
	};
	if (_t in _utility) then {
		_u animate ['HideServices',0,1];
	};
	if (_u isKindOf 'SUV_01_base_F') then {
		private ['_com'];
		_com = getCenterOfMass _u;
		_com set [2,-0.656];
		_u setCenterOfMass _com;
	};
	if (_t2 in [
		"b_slingload_01_ammo_f","b_slingload_01_cargo_f","b_slingload_01_fuel_f","b_slingload_01_medevac_f","b_slingload_01_repair_f",
		"i_supplycrate_f","o_supplycrate_f","c_t_supplycrate_f","c_supplycrate_f","ig_supplycrate_f","b_supplycrate_f",
		"b_cargonet_01_ammo_f","i_cargonet_01_ammo_f","o_cargonet_01_ammo_f"
	]) then {
		[_u,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
	};
	if (_t2 in _towVs) then {
		_u setVariable ['QS_tow_veh',1,TRUE];
		_towLite = [
			"c_offroad_01_f","c_offroad_01_repair_f","o_g_offroad_01_f","b_g_offroad_01_f","i_g_offroad_01_f","o_g_offroad_01_repair_f","i_g_offroad_01_repair_f","b_g_offroad_01_repair_f",
			"b_gen_offroad_01_gen_f",'c_idap_offroad_01_f',
			'b_ugv_01_f',
			'o_ugv_01_f',
			'o_t_ugv_01_ghex_f',
			'i_ugv_01_f',
			'c_idap_ugv_01_f'
		];
		_towMed = [];
		_towHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
		_towSHeavy = ["b_apc_tracked_01_crv_f","b_truck_01_mover_f","b_t_apc_tracked_01_crv_f","b_t_truck_01_mover_f"];
		if (_t2 in _towLite) then {_u setVariable ['QS_tow_veh',2,TRUE];};
		if (_t2 in _towMed) then {_u setVariable ['QS_tow_veh',3,TRUE];};
		if (_t2 in _towHeavy) then {_u setVariable ['QS_tow_veh',4,TRUE];};
		if (_t2 in _towSHeavy) then {_u setVariable ['QS_tow_veh',5,TRUE];};
	};
};
if (!(_isSimpleObject)) then {
	_u setVariable ['QS_ropeAttached',FALSE,TRUE];
};
/*/===== Start as locked/*/
if (_t in _startLocked) then {
	/*/_u setVariable ['QS_vehicle_lockable',TRUE,TRUE];/*/
	/*/_u lock 2;/*/
};

if (!(_isSimpleObject)) then {
	if (_t in _hemttAmmo) then {
		_u setVariable ['QS_vehicle_lockable',TRUE,TRUE];
	};
};

/*/===== MSE-3 Marid/*/

if (_t in _marid) then {
	if (!(_z)) then {
		{
			//_u setObjectTextureGlobal _x;		// enable this if skin is active
		} forEach [
			[0,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_01_blufor_co.paa'],
			[1,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_02_blufor_co.paa'],
			[2,'a3\data_f\vehicles\turret_co.paa']
		];
	};
};

/*/===== T100 Varsuk/*/

if (_t in _t100) then {
	if (!(_z)) then {
		{
			//_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\t100\mbt_02_greengrey_body_co.paa'],
			[1,'media\images\vskins\t100\mbt_02_greengrey_turret_co.paa'],
			[2,'media\images\vskins\t100\mbt_02_greengrey_co.paa']
		];
	};
};

/*/===== Taru/*/

if (!(_z)) then {
	if (_t in _taru_default) then {
		_u setObjectTextureGlobal [0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_01_black_CO.paa'];
		_u setObjectTextureGlobal [1,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_02_black_CO.paa'];
	};
	if (_t in _taru_pod) then {
		_u setObjectTextureGlobal [0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext01_black_CO.paa'];
		_u setObjectTextureGlobal [1,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext02_black_CO.paa'];
	};
	if (_t in _taru_bench) then {
		_u setObjectTextureGlobal [0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_bench_black_CO.paa'];
	};
	if (_t in _taru_with_bench) then {
	
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_01_black_CO.paa'],
			[1,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_02_black_CO.paa'],
			[2,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_bench_black_CO.paa']
		];
		_u animateSource ['Bench_default_hide',1];
		_u animateSource ['Bench_black_hide',0];
	};
};

if (_t in ['Land_Pod_Heli_Transport_04_medevac_black_F']) then {
	/*/_u setObjectTextureGlobal [0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext01_black_CO.paa'];/*/
	/*/_u setObjectTextureGlobal [1,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext02_black_CO.paa'];/*/
};

if (!(_z)) then {
	if (_t in _taru_with_pod) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_01_black_CO.paa'],
			[1,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_base_02_black_CO.paa'],
			[2,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext01_black_CO.paa'],
			[3,'A3\Air_F_Heli\Heli_Transport_04\Data\Heli_Transport_04_Pod_Ext02_black_CO.paa']
		];
	};
};
if (!(_isSimpleObject)) then {
	if (_t in ['FlexibleTank_01_sand_F','FlexibleTank_01_forest_F']) then {
		_u setVariable ['QS_inventory_disabled',TRUE,TRUE];
	};
};
if (!(_isSimpleObject)) then {
	if (_t in [
		'Land_Pod_Heli_Transport_04_ammo_black_F','Land_Pod_Heli_Transport_04_ammo_F','Land_Pod_Heli_Transport_04_box_black_F','Land_Pod_Heli_Transport_04_box_F',
		'Land_Pod_Heli_Transport_04_fuel_black_F','Land_Pod_Heli_Transport_04_fuel_F','Land_Pod_Heli_Transport_04_medevac_black_F','Land_Pod_Heli_Transport_04_medevac_F',
		'Land_Pod_Heli_Transport_04_repair_black_F','Land_Pod_Heli_Transport_04_repair_F'
	]) then {
		private _newMass = -1;
		if (_t in ['Land_Pod_Heli_Transport_04_ammo_black_F','Land_Pod_Heli_Transport_04_ammo_F']) then {
			_newMass = 8000;
		};
		if (_t in ['Land_Pod_Heli_Transport_04_box_black_F','Land_Pod_Heli_Transport_04_box_F']) then {
			_newMass = 7500;
		};
		if (_t in ['Land_Pod_Heli_Transport_04_fuel_black_F','Land_Pod_Heli_Transport_04_fuel_F']) then {
			_newMass = 8500;
		};
		if (_t in ['Land_Pod_Heli_Transport_04_medevac_black_F','Land_Pod_Heli_Transport_04_medevac_F']) then {
			_newMass = 3500;
		};
		if (_t in ['Land_Pod_Heli_Transport_04_repair_black_F','Land_Pod_Heli_Transport_04_repair_F']) then {
			_newMass = 7000;
		};
		if (!(_newMass isEqualTo -1)) then {
			if (local _u) then {
				_u setMass _newMass;
			} else {
				['setMass',_u,_newMass] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
	};
};
if (_t in _bobcat) then {
	/*/cursorTarget setObjectTextureGlobal [0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'];/*/
	/*/_u lockTurret [[0],TRUE];/*/
	/*/_u animateSource ['hideturret',1];/*/
};

if (_t in _gorgon) then {
	if (!(_z)) then {
		if (isNull (driver _u)) then {
			{
				_u setObjectTextureGlobal _x;
			} forEach [
				[0,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_co.paa'],
				[1,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext2_co.paa'],
				[2,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\rcws30_co.paa'],
				[3,'A3\Armor_F_Gamma\APC_Wheeled_03\Data\apc_wheeled_03_ext_alpha_co.paa']
			];
		};
	};
};
if ((toLower _t) in ['i_plane_fighter_03_cas_f','i_plane_fighter_03_aa_f','i_plane_fighter_03_dynamicloadout_f','i_plane_fighter_03_cluster_f']) then {	
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t >> 'TextureSources' >> 'Grey' >> 'textures'));
};
if (!(_isSimpleObject)) then {
	if (_t in _van) then {
		{
			_u animateSource _x;
		} forEach [
			['front_protective_frame_hide',0,1],
			['side_protective_frame_hide',0,1],
			/*/['ladder_hide',0,1],/*/
			['rearsteps_hide',0,1],
			/*/['roof_rack_hide',0,1],/*/
			/*/['spare_tyre_holder_hide',0,1],/*/
			/*/['spare_tyre_hide',0,1],/*/
			['sidesteps_hide',0,1]
		];
		if (['medevac',_t,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_u animateSource ['reflective_tape_hide',0,1];
		};
	};
	/*/[_u] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');   // players might not like this? /*/
	if ((toLower _t) in ['c_idap_ugv_01_f']) then {
		_u addEventHandler [
			'Deleted',
			{
				params ['_vehicle'];
				if (!((attachedObjects _vehicle) isEqualTo [])) then {
					{
						detach _x;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};
			}
		];
		_u addEventHandler [
			'Killed',
			{
				params ['_vehicle'];
				if (!((attachedObjects _vehicle) isEqualTo [])) then {
					{
						detach _x;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _vehicle);
				};			
			}
		];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher1 attachTo [_u,[0,-0.75,-0.7]];
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher2 attachTo [_u,[0.85,-0.75,-0.7]];
	};
	/*/
	if (_t in ['Box_East_AmmoVeh_F','Box_IND_AmmoVeh_F','Box_NATO_AmmoVeh_F']) then {
		if (local _u) then {
			_u setMass 3500;
		} else {
			['setMass',_u,3500] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
		};
	};
	/*/
	if (!(unitIsUav _u)) then {
		if (!(_z)) then {
			_u addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled')];
		};
	};
	if (_t in _fuelCargo) then {
		_u setFuelCargo 1;
	};
	if (_t in _ammoCargo) then {
		_u setAmmoCargo 1;
	};
	if (_t in _repairCargo) then {
		_u setRepairCargo 1;
	};
	if (_u isKindOf 'Helicopter') then {
		_u setVariable ['QS_heli_spawnPosition',(position _u),FALSE];
		if (_t in ['B_T_UAV_03_F']) then {
			clearItemCargoGlobal _u;
			_u addItemCargoGlobal ['DemoCharge_Remote_Mag',2];
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};	
		} else {
			clearItemCargoGlobal _u;
			_u addItemCargoGlobal ['DemoCharge_Remote_Mag',2];
			_u setVariable ['QS_ST_drawEmptyVehicle',FALSE,TRUE];
			{
				_u addEventHandler _x;
			} forEach [
				['GetIn',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetIn')}],
				['GetOut',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetOut')}],
				['ControlsShifted',(missionNamespace getVariable 'QS_fnc_vEventControlsShifted')]
			];
		};
	};
	_u setUnloadInCombat [TRUE,FALSE];
	if (_t in _taru) then {
		_u addEventHandler ['SeatSwitched',(missionNamespace getVariable 'QS_fnc_clientEventSeatSwitched')];
	};
	if ((_u isKindOf 'LandVehicle') || {(_u isKindOf 'Air')} || {(_u isKindOf 'Ship')}) then {
		_u addEventHandler ['Engine',{}];
		_u addEventHandler ['Fuel',{}];
	};
	if (_u isKindOf 'Ship') then {
		if ((getMass _u) > 1000) then {
			clearWeaponCargoGlobal _u;
			clearMagazineCargoGlobal _u;
			clearItemCargoGlobal _u;
			clearBackpackCargoGlobal _u;
			_quant = getNumber (configFile >> 'CfgVehicles' >> _t >> 'transportSoldier');
			_u addWeaponCargoGlobal ['arifle_SDAR_F',_quant];
			_u addMagazineCargoGlobal ['20Rnd_556x45_UW_mag',(round(_quant * 3))];
			{
				_u addItemCargoGlobal _x;
			} forEach [
				['G_B_Diving',_quant],
				['V_RebreatherB',_quant],
				['U_B_Wetsuit',_quant]
			];
		};
	};
	if (_u isKindOf 'Air') then {
		_u setVehicleReceiveRemoteTargets FALSE;
		_u setVehicleReportRemoteTargets FALSE;
		_u setVehicleReportOwnPosition FALSE;
		[_u,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		['setFeatureType',_u,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_u];
	};
	if (_u isKindOf 'Plane') then {
		_u addEventHandler ['Gear',{}];
		_u addEventHandler ['LandedTouchDown',{}];
		_u addEventHandler ['LandedStopped',{}];
		if (_u isKindOf 'I_Plane_Fighter_03_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'B_Plane_CAS_01_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'Missile_AGM_02_Plane_CAS_01_F';
			} else {
				['removeWeapon',_u,'Missile_AGM_02_Plane_CAS_01_F'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'O_Plane_CAS_02_dynamicLoadout_F') then {
			_u disableTIEquipment TRUE;
			if (local _u) then {
				_u removeWeapon 'Missile_AGM_01_Plane_CAS_02_F';
			} else {
				['removeWeapon',_u,'Missile_AGM_01_Plane_CAS_02_F'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if (_u isKindOf 'B_UAV_02_F') then {
			if (local _u) then {
				_u removeWeapon 'missiles_SCALPEL';
			} else {
				['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
		if ((_t in _vtol_west) || {(_t in _vtol_east)}) then {
			{
				_u addEventHandler _x;
			} forEach [
				['GetIn',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetIn')}],
				['GetOut',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetOut')}],
				['ControlsShifted',(missionNamespace getVariable 'QS_fnc_vEventControlsShifted')]
			];
			comment 'vtol';
			if (_t in _vtol_east) then {
				if (local _u) then {
					_u removeWeapon 'missiles_SCALPEL';
				} else {
					['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
				};	
			};
			_u addBackpackCargoGlobal ['B_Parachute',(getNumber (configFile >> 'CfgVehicles' >> _t >> 'transportSoldier'))];
			if (['vehicle',_t,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_u addEventHandler [
					'Killed',
					{
						params ['_killed','_killer'];
						if (!((getVehicleCargo _killed) isEqualTo [])) then {
							(_this select 0) setVehicleCargo objNull;
						};
					}
				];
			};
		};
	};
	if ((['medical',_t,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',_t,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
		private _cargoseats = getNumber (configFile >> 'CfgVehicles' >> _t >> 'transportSoldier');
		if (_cargoseats > 0) then {
			if (_cargoseats isEqualTo 4) then {
				_cargoseats = 8;
			} else {
				_cargoseats = round (_cargoseats * 1.5);
			};
			if (_t in _ambulances) then {
				_cargoseats = 2;
			};
			for '_x' from 0 to 1 step 1 do {
				_u setVariable ['QS_medicalVehicle_reviveTickets',_cargoseats,TRUE];
			};
		} else {
			for '_x' from 0 to 1 step 1 do {
				_u setVariable ['QS_medicalVehicle_reviveTickets',4,TRUE];
			};
		};
		_u setVariable ['QS_isMedicalVehicle',(_u getVariable ['QS_medicalVehicle_reviveTickets',4]),FALSE];
	};
	_u addEventHandler [
		'Deleted',
		{
			params ['_vehicle'];
			if (!((attachedObjects _vehicle) isEqualTo [])) then {
				{
					missionNamespace setVariable [
						'QS_analytics_entities_deleted',
						((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
						FALSE
					];
					detach _x;
					deleteVehicle _x;
				} count (attachedObjects _vehicle);
			};
			if (_vehicle isKindOf 'Plane') then {
				if (!((getVehicleCargo _vehicle) isEqualTo [])) then {
					_vehicle setVehicleCargo objNull;
				};
			};
		}
	];
	_u setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
	_u setVariable ['QS_transporter',nil,FALSE];
	_u addEventHandler ['Local',{}];
	if (!(_z)) then {
		for '_x' from 0 to 1 step 1 do {
			_u setVariable ['QS_RD_vehicleRespawnable',TRUE,TRUE];
		};
	};
	if (_u isKindOf 'LandVehicle') then {
		if (!(['medevac',_t,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
			[_u,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
		};
		_u setConvoySeparation 50;
		_u forceFollowRoad TRUE;
	};
};