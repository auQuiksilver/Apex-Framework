/*/
File: fn_vSetup.sqf
Author:

	Quiksilver
	
Last Modified:

	16/04/2018 A3 1.82 by Quiksilver
	
Description:

	Server-side player-accessible vehicle setup
_____________________________________________________/*/

params ['_u',['_z',FALSE]];
_t = typeOf _u;
_t2 = toLower _t;
_isSimpleObject = isSimpleObject _u;
_u setVariable ['QS_vehicle',TRUE,(!isDedicated)];

/*/============================================= Classname lists/*/

_orca = [
	'o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_light_02_dynamicloadout_f'
];
_ghosthawk = [
	'b_heli_transport_01_camo_f','b_heli_transport_01_f','b_ctrg_heli_transport_01_sand_f','b_ctrg_heli_transport_01_tropic_f'
]; 						/*/ghosthawk/*/
_strider = [
	'i_mrap_03_f','i_mrap_03_hmg_f','i_mrap_03_gmg_f'
];								/*/ strider/*/
_blackvehicles = [
	'b_heli_light_01_f','b_heli_light_01_armed_f','b_heli_light_01_dynamicloadout_f','b_heli_light_01_stripped_f'
];							/*/black skin/*/
_mobilearmory = [
	'b_truck_01_ammo_f','b_t_truck_01_ammo_f','land_pod_heli_transport_04_ammo_f','b_slingload_01_ammo_f','o_truck_03_ammo_f','i_truck_02_ammo_f','o_truck_02_ammo_f','land_pod_heli_transport_04_ammo_black_f'
];											/*/mobile armory/*/
_noammocargo = [];																	/*/ bobcat crv/*/
_huronunarmed = [
	'b_heli_transport_03_unarmed_green_f','b_heli_transport_03_unarmed_f'
];
_huronarmed = [
	'b_heli_transport_03_f'
];
_towvs = [
	'b_apc_tracked_01_crv_f','b_truck_01_mover_f','b_t_apc_tracked_01_crv_f','b_t_truck_01_mover_f','c_offroad_01_f','c_offroad_01_repair_f',
	'o_g_offroad_01_f','b_g_offroad_01_f','i_g_offroad_01_f','o_g_offroad_01_repair_f','i_g_offroad_01_repair_f','b_g_offroad_01_repair_f','b_gen_offroad_01_gen_f','c_idap_offroad_01_f',
	'b_ugv_01_f','b_t_ugv_01_olive_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'b_g_van_01_transport_f','o_g_van_01_transport_f','i_g_van_01_transport_f','i_c_van_01_transport_f','i_c_van_01_transport_brown_f',
	'i_c_van_01_transport_olive_f','c_van_01_transport_f','c_van_01_transport_red_f','c_van_01_transport_white_f',
	'i_e_ugv_01_f'
];
_towLite = [
	'c_offroad_01_f','c_offroad_01_repair_f','o_g_offroad_01_f','b_g_offroad_01_f','i_g_offroad_01_f','o_g_offroad_01_repair_f','i_g_offroad_01_repair_f','b_g_offroad_01_repair_f',
	'b_gen_offroad_01_gen_f','c_idap_offroad_01_f',
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'b_g_van_01_transport_f','o_g_van_01_transport_f','i_g_van_01_transport_f','i_c_van_01_transport_f','i_c_van_01_transport_brown_f',
	'i_c_van_01_transport_olive_f','c_van_01_transport_f','c_van_01_transport_red_f','c_van_01_transport_white_f'
];
_towMed = [
	'b_truck_01_repair_f','b_t_truck_01_repair_f','o_truck_03_repair_f','i_truck_02_box_f','o_truck_02_box_f'
];
_towHeavy = [
	'b_apc_tracked_01_crv_f','b_truck_01_mover_f','b_t_apc_tracked_01_crv_f','b_t_truck_01_mover_f'
];
_towSHeavy = [
	'b_apc_tracked_01_crv_f','b_truck_01_mover_f','b_t_apc_tracked_01_crv_f','b_t_truck_01_mover_f'
];
_utility = [
	'c_offroad_01_repair_f','b_g_offroad_01_repair_f'
];
_startLocked = [
	'b_mbt_01_tusk_f','b_apc_wheeled_01_cannon_f','b_mbt_01_cannon_f','b_apc_tracked_01_rcws_f','b_apc_tracked_01_aa_f','i_apc_tracked_03_cannon_f'
];
_hemttAmmo = [
	'b_truck_01_ammo_f','b_t_truck_01_ammo_f'
];
_bobcat = [
	'b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f'
];
_taru_default = [
	'o_heli_transport_04_f','o_heli_transport_04_black_f'
];
_taru_with_pod = [
	'o_heli_transport_04_ammo_f','o_heli_transport_04_box_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_f','o_heli_transport_04_repair_f',
	'o_heli_transport_04_covered_f','o_heli_transport_04_covered_black_f'
];
_taru = _taru_default + _taru_with_pod;
_taru_pod = [
	'land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_repair_f','land_pod_heli_transport_04_repair_black_f','land_pod_heli_transport_04_box_f','land_pod_heli_transport_04_box_black_f',
	'land_pod_heli_transport_04_covered_f','land_pod_heli_transport_04_covered_black_f',
	'land_pod_heli_transport_04_medevac_f','land_pod_heli_transport_04_medevac_black_f',
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f'
];
_taru_bench = [
	'land_pod_heli_transport_04_bench_f','land_pod_heli_transport_04_bench_black_f'
];
_taru_with_bench = [
	'o_heli_transport_04_bench_f'
];
_fuelCargo = [
	'flexibletank_01_sand_f','flexibletank_01_forest_f','b_slingload_01_fuel_f','b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f',
	'b_g_van_01_fuel_f','b_truck_01_fuel_f','b_t_truck_01_fuel_f','land_pod_heli_transport_04_fuel_f','o_heli_transport_04_fuel_f',
	'o_truck_03_fuel_f','o_truck_02_fuel_f','i_truck_02_fuel_f','c_van_01_fuel_f'
];
_ammoCargo = [
	'b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f','b_truck_01_ammo_f','b_t_truck_01_ammo_f','o_truck_03_ammo_f','o_truck_02_ammo_f',
	'i_truck_02_ammo_f','o_heli_transport_04_ammo_f','land_pod_heli_transport_04_ammo_f','b_slingload_01_ammo_f'
];
_repairCargo = [
	'c_offroad_01_repair_f','b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f','b_truck_01_repair_f','b_t_truck_01_repair_f','b_slingload_01_repair_f',
	'b_g_offroad_01_repair_f','land_pod_heli_transport_04_repair_f','o_truck_03_repair_f','i_truck_02_box_f','o_truck_02_box_f'
];
_gorgon = [
	'i_apc_wheeled_03_cannon_f','b_apc_wheeled_03_cannon_f'
];
_mora = [
	'i_apc_tracked_03_cannon_f'
];
_vtol_west = [
	'b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f','b_t_vtol_01_infantry_blue_f',
	'b_t_vtol_01_infantry_f','b_t_vtol_01_infantry_olive_f','b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_f',
	'b_t_vtol_01_vehicle_olive_f'
];
_vtol_east = [
	'o_t_vtol_02_infantry_f','o_t_vtol_02_infantry_ghex_f','o_t_vtol_02_infantry_grey_f','o_t_vtol_02_infantry_hex_f','o_t_vtol_02_vehicle_f','o_t_vtol_02_vehicle_ghex_f',
	'o_t_vtol_02_vehicle_grey_f','o_t_vtol_02_vehicle_hex_f','o_t_vtol_02_infantry_dynamicloadout_f','o_t_vtol_02_vehicle_dynamicloadout_f'
];
_lsv_west = [
	'b_ctrg_lsv_01_light_f','b_t_lsv_01_armed_black_f','b_t_lsv_01_armed_ctrg_f','b_t_lsv_01_armed_f','b_t_lsv_01_armed_olive_f',
	'b_t_lsv_01_armed_sand_f','b_t_lsv_01_unarmed_black_f','b_t_lsv_01_unarmed_ctrg_f','b_t_lsv_01_unarmed_f','b_t_lsv_01_unarmed_olive_f',
	'b_t_lsv_01_unarmed_sand_f'
];
_marid = [
	'o_t_apc_wheeled_02_rcws_v2_ghex_f','o_apc_wheeled_02_rcws_f','o_apc_wheeled_02_rcws_v2_f','o_t_apc_wheeled_02_rcws_ghex_f'
];
_t100 = [
	'o_mbt_02_cannon_f','o_t_mbt_02_cannon_ghex_f'
];
_ambulances = [
	'c_idap_van_02_medevac_f','c_van_02_medevac_f'
];
_idap = [
	'c_idap_van_02_medevac_f','c_idap_offroad_02_unarmed_f','c_idap_offroad_01_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'c_idap_truck_02_transport_f','c_idap_truck_02_f','c_idap_truck_02_water_f','c_idap_ugv_01_f','c_idap_heli_transport_02_f'
];
_van = [
	'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
	'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f'
];
_armoredvehicles = [
	'i_mbt_03_cannon_f','b_mbt_01_cannon_f','b_mbt_01_tusk_f','b_apc_wheeled_01_cannon_f','i_apc_wheeled_03_cannon_f','b_apc_tracked_01_rcws_f','b_apc_wheeled_03_cannon_f',
	'o_t_apc_wheeled_02_rcws_v2_ghex_f','o_t_apc_wheeled_02_rcws_ghex_f','o_mbt_02_cannon_f','o_t_mbt_02_cannon_ghex_f',
	'o_mbt_04_cannon_f','o_mbt_04_command_f','o_t_mbt_04_cannon_f','o_t_mbt_04_command_f',
	'b_afv_wheeled_01_cannon_f','b_afv_wheeled_01_up_cannon_f','b_t_afv_wheeled_01_cannon_f','b_t_afv_wheeled_01_up_cannon_f'
];
_nyx = ['i_lt_01_aa_f','i_lt_01_at_f','i_lt_01_scout_f','i_lt_01_cannon_f'];
_angara = ['o_mbt_04_cannon_f','o_mbt_04_command_f','o_t_mbt_04_cannon_f','o_t_mbt_04_command_f'];
_buzzard = ['i_plane_fighter_03_cas_f','i_plane_fighter_03_aa_f','i_plane_fighter_03_dynamicloadout_f','i_plane_fighter_03_cluster_f'];
_offroadServices = [
	'c_offroad_01_repair_f','c_van_02_service_f','b_g_offroad_01_repair_f','o_g_offroad_01_repair_f','i_g_offroad_01_repair_f'
];
_offroadPolice = [
	'b_gen_offroad_01_gen_f','b_gen_van_02_vehicle_f','b_gen_van_02_transport_f'
];
_offroad = ['b_g_offroad_01_f','b_g_offroad_01_at_f','b_g_offroad_01_armed_f','b_g_offroad_01_repair_f','o_g_offroad_01_f','o_g_offroad_01_at_f','o_g_offroad_01_armed_f','o_g_offroad_01_repair_f','i_g_offroad_01_f','i_g_offroad_01_at_f','i_g_offroad_01_armed_f','i_g_offroad_01_repair_f'];
_hellcat = ['i_heli_light_03_f','i_heli_light_03_dynamicloadout_f','i_heli_light_03_unarmed_f','i_e_heli_light_03_dynamicloadout_f','i_e_heli_light_03_unarmed_f'];

/*/============================================= APPLY/*/
if (_t2 in _blackVehicles) then {
	for '_i' from 0 to 9 do {_u setObjectTextureGlobal [_i,'#(argb,8,8,3)color(0,0,0,0.6)'];};
};
if (_t2 in _bobcat) then {
	/*/_u setObjectTextureGlobal [0,'A3\armor_f_beta\apc_tracked_01\data\apc_tracked_01_crv_opfor_co.paa'];/*/
	/*/_u lockTurret [[0],TRUE];/*/
	/*/_u animateSource ['hideturret',1];/*/
};
if (_t2 in _buzzard) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Grey' >> 'textures'));
	};
};
if (_t2 in _angara) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Grey' >> 'textures'));
	};
};
if (_t2 in _nyx) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Indep_Olive' >> 'textures'));	
	};
};
if (_t2 in _strider) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'],
			[1,'\A3\data_f\vehicles\turret_co.paa']
		];
	};
};
if (_t2 in _mora) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\fv720\apc_tracked_03_ext_blufor_co.paa'],
			[1,'media\images\vskins\fv720\apc_tracked_03_ext2_blufor_co.paa']
		];
	};
};
if (_t2 in ['i_mbt_03_cannon_f']) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\mbt52\mbt_03_ext01_blufor_co.paa'],
			[1,'media\images\vskins\mbt52\mbt_03_ext02_blufor_co.paa'],
			[2,'media\images\vskins\mbt52\mbt_03_rcws_blufor_co.paa']
		];
	};
};
if (_t2 in _gorgon) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
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
if (_t2 in _marid) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_01_blufor_co.paa'],
			[1,'media\images\vskins\mse3\nato\apc_wheeled_02_ext_02_blufor_co.paa'],
			[2,'a3\data_f\vehicles\turret_co.paa']
		];
	};
};
if (_t2 in ['o_t_apc_wheeled_02_rcws_ghex_f']) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'GreenHex' >> 'textures'));
	};
};
if (_t2 in _t100) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{
			_u setObjectTextureGlobal _x;
		} forEach [
			[0,'media\images\vskins\t100\mbt_02_greengrey_body_co.paa'],
			[1,'media\images\vskins\t100\mbt_02_greengrey_turret_co.paa'],
			[2,'media\images\vskins\t100\mbt_02_greengrey_co.paa']
		];
	};
};
if (_t2 in _hellcat) then {
	if (_isSimpleObject || {(isNull (driver _u))}) then {
		{ 
			_u setObjectTextureGlobal [_forEachIndex,_x]; 
		} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Green' >> 'textures'));
	};
};
if (_t2 in _taru_default) then {
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Black' >> 'textures'));
};
if (_t2 in _taru_pod) then {
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Black' >> 'textures'));
};
if (_t2 in _taru_bench) then {
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Black' >> 'textures'));
};
if (_t2 in _taru_with_bench) then {
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Black' >> 'textures'));
	_u animateSource ['Bench_default_hide',1];
	_u animateSource ['Bench_black_hide',0];
};
if (_t2 in _taru_with_pod) then {
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Black' >> 'textures'));
};
if (_t2 in _offroad) then {
	_u animateSource ['HideBackpacks',(selectRandom [0,1]),1];
	{ 
		_u setObjectTextureGlobal [_forEachIndex,_x]; 
	} forEach (getArray (configFile >> 'CfgVehicles' >> 'b_g_offroad_01_f' >> 'TextureSources' >> (format ['Guerilla_%1',(selectRandom ['01','02','03','04','05','06','07','08','09','10','11','12'])]) >> 'textures'));
};
if (_t2 in ['o_sam_system_04_f','o_radar_system_02_f']) then {
	if (!isSimpleObject _u) then {
		_u setVehicleRadar 1;
	};
	{
		_u setObjectTextureGlobal [_forEachIndex,_x];
	} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> (['AridHex','JungleHex'] select (worldName in ['Tanoa','Lingor3'])) >> 'textures'));
};
if (!(_isSimpleObject)) then {
	_u lock 0;
	_u setVariable ['QS_ropeAttached',FALSE,TRUE];
	if (_t2 in _startLocked) then {
		/*/_u setVariable ['QS_vehicle_lockable',TRUE,TRUE];/*/
		/*/_u lock 2;/*/
	};
	if (!(_z)) then {
		_u setVariable ['QS_RD_vehicleRespawnable',TRUE,TRUE];
		if (!(unitIsUav _u)) then {
			_u addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled')];
		};
		if ((_t2 in _mobileArmory) || {(_t2 in _armoredVehicles)}) then {
			if (!isNil {missionNamespace getVariable 'QS_HVT_totalList'}) then {
				if ((random 1) > 0.666) then {
					(missionNamespace getVariable 'QS_HVT_totalList') pushBack _u;
				};
			};
		};
	};
	if (_u isKindOf 'AFV_Wheeled_01_base_F') then {
		_u animateSource ['showslathull',0,1];
	};
	if (_t2 in _offroadServices) then {
		_u animate ['hidePolice',1,1];
		_u animate ['hideServices',0,1];
	};
	if (_t2 in _offroadPolice) then {
		_u animate ['hidePolice',0,1];
		_u animate ['hideServices',1,1];	
	};
	if (_t2 in ['b_t_afv_wheeled_01_up_cannon_f','b_afv_wheeled_01_up_cannon_f']) then {
		_u animateSource ['showslathull',0,1];
	};
	if (_t2 in _ghosthawk) then {
		_u setVariable ['turretL_locked',FALSE,TRUE];
		_u setVariable ['turretR_locked',FALSE,TRUE];
		_u animateDoor ['door_R',1];
		_u animateDoor ['door_L',1];
	};
	if (_t2 in _orca) then {
		_u animateSource ['Doors',1,1];
		_u animateSource ['Doors',1,1];
	};
	if (_t2 in _huronArmed) then {
		_u setVariable ['turretL_locked',FALSE,TRUE];
		_u setVariable ['turretR_locked',FALSE,TRUE];
	};
	if (_t2 in _utility) then {
		_u animate ['HideServices',0,1];
	};
	if (_u isKindOf 'SUV_01_base_F') then {
		_com = getCenterOfMass _u;
		_com set [2,-0.656];
		_u setCenterOfMass _com;
	};
	if (_t2 in _marid) then {
		{
			_u animateSource _x;
		} forEach [
			['showTools',1,1],
			['showCanisters',1,1]
		];
	};
	if (_t2 in ['i_mbt_03_cannon_f']) then {
		if (isNull (driver _u)) then {
			{
				_u animateSource _x;
			} forEach [
				['hidehull',1,1],
				['hideturret',1,1]
			];
		};
	};
	if (_t2 in [
		'b_slingload_01_ammo_f','b_slingload_01_cargo_f','b_slingload_01_fuel_f','b_slingload_01_medevac_f','b_slingload_01_repair_f',
		'i_supplycrate_f','o_supplycrate_f','c_t_supplycrate_f','c_supplycrate_f','ig_supplycrate_f','b_supplycrate_f',
		'b_cargonet_01_ammo_f','i_cargonet_01_ammo_f','o_cargonet_01_ammo_f','i_e_cargonet_01_ammo_f'
	]) then {
		[_u,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
	};
	if (_t2 in _towVs) then {
		_u setVariable ['QS_tow_veh',1,TRUE];
		_towLite = [
			'c_offroad_01_f','c_offroad_01_repair_f','o_g_offroad_01_f','b_g_offroad_01_f','i_g_offroad_01_f','o_g_offroad_01_repair_f','i_g_offroad_01_repair_f','b_g_offroad_01_repair_f',
			'b_gen_offroad_01_gen_f','c_idap_offroad_01_f',
			'b_ugv_01_f',
			'o_ugv_01_f',
			'o_t_ugv_01_ghex_f',
			'i_ugv_01_f',
			'c_idap_ugv_01_f',
			'i_e_ugv_01_f'
		];
		_towMed = [];
		_towHeavy = ['b_apc_tracked_01_crv_f','b_truck_01_mover_f','b_t_apc_tracked_01_crv_f','b_t_truck_01_mover_f'];
		_towSHeavy = ['b_apc_tracked_01_crv_f','b_truck_01_mover_f','b_t_apc_tracked_01_crv_f','b_t_truck_01_mover_f'];
		if (_t2 in _towLite) then {_u setVariable ['QS_tow_veh',2,TRUE];};
		if (_t2 in _towMed) then {_u setVariable ['QS_tow_veh',3,TRUE];};
		if (_t2 in _towHeavy) then {_u setVariable ['QS_tow_veh',4,TRUE];};
		if (_t2 in _towSHeavy) then {_u setVariable ['QS_tow_veh',5,TRUE];};
	};
	
	if (_t2 in _hemttAmmo) then {
		_u setVariable ['QS_vehicle_lockable',TRUE,TRUE];
	};	
	if (_t2 in ['flexibletank_01_sand_f','flexibletank_01_forest_f']) then {
		_u setVariable ['QS_inventory_disabled',TRUE,TRUE];
	};
	if (_t2 in [
		'land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_ammo_f','land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_box_f',
		'land_pod_heli_transport_04_fuel_black_f','land_pod_heli_transport_04_fuel_f','land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_medevac_f',
		'land_pod_heli_transport_04_repair_black_f','land_pod_heli_transport_04_repair_f'
	]) then {
		private _newmass = -1;
		if (_t2 in ['land_pod_heli_transport_04_ammo_black_f','land_pod_heli_transport_04_ammo_f']) then {
			_newmass = 8000;
		};
		if (_t2 in ['land_pod_heli_transport_04_box_black_f','land_pod_heli_transport_04_box_f']) then {
			_newmass = 7500;
		};
		if (_t2 in ['land_pod_heli_transport_04_fuel_black_f','land_pod_heli_transport_04_fuel_f']) then {
			_newmass = 8500;
		};
		if (_t2 in ['land_pod_heli_transport_04_medevac_black_f','land_pod_heli_transport_04_medevac_f']) then {
			_newmass = 3500;
		};
		if (_t2 in ['land_pod_heli_transport_04_repair_black_f','land_pod_heli_transport_04_repair_f']) then {
			_newmass = 7000;
		};
		if (!(_newMass isEqualTo -1)) then {
			if (local _u) then {
				_u setMass _newMass;
			} else {
				['setMass',_u,_newMass] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
			};
		};
	};
	
	if (_t2 in _van) then {
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
		if (['medevac',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
			_u animateSource ['reflective_tape_hide',0,1];
		};
	};
	/*/[_u] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');   // players might not like this? /*/
	if ((_u isKindOf 'ugv_01_base_f') && (!(_u isKindOf 'ugv_01_rcws_base_f'))) then {
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
		_stretcher1 setVariable ['QS_ropeAttached',FALSE,TRUE];
		_stretcher1 setVariable ['QS_tow_veh',2,TRUE];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher1 attachTo [_u,[0,-0.75,-0.7]];
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher2 attachTo [_u,[0.85,-0.75,-0.7]];
	};
	if (_t2 in _fuelCargo) then {
		_u setFuelCargo 1;
	};
	if (_t2 in _ammoCargo) then {
		_u setAmmoCargo 1;
	};
	if (_t2 in _repairCargo) then {
		_u setRepairCargo 1;
	};
	if (_u isKindOf 'Helicopter') then {
		_u setVariable ['QS_heli_spawnPosition',(position _u),FALSE];
		if (_t2 in ['b_t_uav_03_f']) then {
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
	if (_t2 in _taru) then {
		_u addEventHandler ['SeatSwitched',(missionNamespace getVariable 'QS_fnc_clientEventSeatSwitched')];
	};
	if ((_u isKindOf 'LandVehicle') || {(_u isKindOf 'Air')} || {(_u isKindOf 'Ship')}) then {
		[_u] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
		_u addEventHandler ['Engine',{}];
		_u addEventHandler ['Fuel',{}];
	};
	if (_u isKindOf 'Ship') then {
		if ((getMass _u) > 1000) then {
			clearWeaponCargoGlobal _u;
			clearMagazineCargoGlobal _u;
			clearItemCargoGlobal _u;
			clearBackpackCargoGlobal _u;
			_quant = getNumber (configFile >> 'CfgVehicles' >> _t2 >> 'transportSoldier');
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
	_u setVehicleReportRemoteTargets ((_u isKindOf 'i_lt_01_scout_f') || (_t2 in ['b_radar_system_01_f','o_radar_system_02_f']));
	if (_u isKindOf 'Air') then {
		_u setVehicleReceiveRemoteTargets TRUE;
		_u setVehicleReportOwnPosition TRUE;
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
		if (_t2 in ['b_t_vtol_01_vehicle_f','b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_olive_f','b_t_vtol_01_armed_blue_f','b_t_vtol_01_armed_f','b_t_vtol_01_armed_olive_f']) then {
			{ 
				_u setObjectTextureGlobal [_forEachIndex,_x]; 
			} forEach (getArray (configFile >> 'CfgVehicles' >> _t2 >> 'TextureSources' >> 'Blue' >> 'textures'));
		};
		if ((_t2 in _vtol_west) || {(_t2 in _vtol_east)}) then {
			{
				_u addEventHandler _x;
			} forEach [
				['GetIn',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetIn')}],
				['GetOut',{_this call (missionNamespace getVariable 'QS_fnc_clientEventGetOut')}],
				['ControlsShifted',(missionNamespace getVariable 'QS_fnc_vEventControlsShifted')]
			];
			comment 'vtol';
			if (_t2 in _vtol_east) then {
				if (local _u) then {
					_u removeWeapon 'missiles_SCALPEL';
				} else {
					['removeWeapon',_u,'missiles_SCALPEL'] remoteExec ['QS_fnc_remoteExecCmd',_u,FALSE];
				};	
			};
			_u addBackpackCargoGlobal ['B_Parachute',(getNumber (configFile >> 'CfgVehicles' >> _t2 >> 'transportSoldier'))];
			if (['vehicle',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
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
	if ((['medical',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
		private _cargoseats = getNumber (configFile >> 'CfgVehicles' >> _t2 >> 'transportSoldier');
		if (_cargoseats > 0) then {
			if (_cargoseats isEqualTo 4) then {
				_cargoseats = 8;
			} else {
				_cargoseats = round (_cargoseats * 1.5);
			};
			if (_t2 in _ambulances) then {
				_cargoseats = 2;
			};
			for '_x' from 0 to 1 step 1 do {
				_u setVariable ['QS_medicalVehicle_reviveTickets',_cargoseats,TRUE];
			};
		} else {
			if (!(_u isKindOf 'UAV_06_base_F')) then {
				for '_x' from 0 to 1 step 1 do {
					_u setVariable ['QS_medicalVehicle_reviveTickets',4,TRUE];
				};
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
	if (_u isKindOf 'LandVehicle') then {
		//_u setPlateNumber 'abc123';
		if ((!(['medical',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) && (!(['medevac',_t2,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))) then {
			[_u,1,nil] call (missionNamespace getVariable 'QS_fnc_customInventory');
		};
		_u setConvoySeparation 50;
		_u forceFollowRoad TRUE;
	};
};