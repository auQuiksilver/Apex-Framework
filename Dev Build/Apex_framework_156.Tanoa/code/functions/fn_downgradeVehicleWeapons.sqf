/*/
File: fn_downgradeVehicleWeapons.sqf
Author: 

	Quiksilver

Last Modified:

	7/9/2018 A3 1.84 by Quiksilver

Description:

	Downgrade vehicle weapons (from .50 cal to 7.62 or 6.5)
	
To Do:

	Split tracers by faction
	https://community.bistudio.com/wiki/Arma_3_CfgMagazines#1000Rnd_65x39_Belt_Tracer_Red
____________________________________________________________________________/*/

params ['_vehicle',['_forced',FALSE]];
if (((random 1) < ([0.666,0.333] select (worldName in ['Tanoa','Lingor3']))) && (!(_forced))) exitWith {};
_type = toLowerANSI (typeOf _vehicle);
//comment 'Slammer UP';
if (_type in [
	'b_mbt_01_tusk_f',
	'b_t_mbt_01_tusk_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_MBT',[0,0]];
	_vehicle addWeaponTurret ['LMG_coax',[0,0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['200Rnd_762x51_Belt_Red',[0,0]],
		['200Rnd_762x51_Belt_Red',[0,0]]
	];
	_vehicle removeWeaponTurret ['LMG_M200_body',[0]];
	_vehicle addWeaponTurret ['LMG_RCWS',[0]];
	{
		_vehicle removeMagazineTurret _x;
	} forEach [
		['2000Rnd_65x39_Belt',[0]],
		['2000Rnd_65x39_Belt',[0]]
	];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_65x39_Belt_Tracer_Red',[0]],
		['1000Rnd_65x39_Belt_Tracer_Red',[0]]
	];
};
//comment 'Panther';
if (_type in [
	'b_apc_tracked_01_rcws_f',
	'b_t_apc_tracked_01_rcws_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_APC',[0]];
	_vehicle addWeaponTurret ['LMG_RCWS',[0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_65x39_Belt_Tracer_Red',[0]],
		['1000Rnd_65x39_Belt_Tracer_Red',[0]]
	];
};
//comment 'MRAPs';
if (_type in [
	'b_mrap_01_hmg_f',
	'b_t_mrap_01_hmg_f',
	'o_mrap_02_hmg_f',
	'o_t_mrap_02_hmg_ghex_f',
	'i_mrap_03_hmg_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127',[0]];
	_vehicle addWeaponTurret ['LMG_coax',[0]];
	private _magazine = '200Rnd_762x51_Belt_T_Red';
	if (_type in ['o_mrap_02_hmg_f','o_t_mrap_02_hmg_ghex_f']) then {
		_magazine = '200Rnd_762x51_Belt_T_Green';
	};
	if (_type in ['i_mrap_03_hmg_f']) then {
		_magazine = '200Rnd_762x51_Belt_T_Yellow';
	};
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		[_magazine,[0]],
		[_magazine,[0]]
	];	
};
//comment 'LSV';
if (_type in [
	'b_lsv_01_armed_black_f',
	'b_lsv_01_armed_f',
	'b_lsv_01_armed_olive_f',
	'b_lsv_01_armed_sand_f',
	'b_t_lsv_01_armed_black_f',
	'b_t_lsv_01_armed_ctrg_f',
	'b_t_lsv_01_armed_f',
	'b_t_lsv_01_armed_olive_f',
	'b_t_lsv_01_armed_sand_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_LSV_01',[0]];
	_vehicle addWeaponTurret ['HMG_M2',[0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['100Rnd_127x99_mag_Tracer_Red',[0]]
	];
};
//comment 'Artillery';
if (_type in [
	'o_mbt_02_arty_f',
	'b_mbt_01_arty_f',
	'b_t_mbt_01_arty_f',
	'o_t_mbt_02_arty_ghex_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_APC',[0,0]];
	_vehicle addWeaponTurret ['LMG_RCWS',[0,0]];
	private _magazine = '1000Rnd_65x39_Belt_Tracer_Red';
	if (_type in [
		'o_mbt_02_arty_f',
		'o_t_mbt_02_arty_ghex_f'
	]) then {
		_magazine = '1000Rnd_65x39_Belt_Tracer_Green';
	};
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		[_magazine,[0,0]],
		[_magazine,[0,0]]
	];
};
//comment 'Marid';
if (_type in [
	'o_apc_wheeled_02_rcws_f',
	'o_apc_wheeled_02_rcws_v2_f',
	'o_t_apc_wheeled_02_rcws_ghex_f',
	'o_t_apc_wheeled_02_rcws_v2_ghex_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_APC',[0]];
	_vehicle addWeaponTurret ['LMG_RCWS',[0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_65x39_Belt_Tracer_Green',[0]],
		['1000Rnd_65x39_Belt_Tracer_Green',[0]]
	];
};
//comment 'T100';
if (_type in [
	'o_t_mbt_02_cannon_ghex_f',
	'o_mbt_02_cannon_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_NSVT',[0,0]];
	_vehicle addWeaponTurret ['LMG_coax',[0,0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_762x51_Belt_T_Green',[0,0]],
		['1000Rnd_762x51_Belt_T_Green',[0,0]]
	];
};
//comment 'Kuma';
if (_type in [
	'i_mbt_03_cannon_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_127_APC',[0,0]];
	_vehicle addWeaponTurret ['LMG_coax',[0,0]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_762x51_Belt_T_Yellow',[0,0]],
		['1000Rnd_762x51_Belt_T_Yellow',[0,0]]
	];
};
//comment 'Boats';
if (_type in [
	'o_boat_armed_01_hmg_f',
	'o_t_boat_armed_01_hmg_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_01',[1]];
	_vehicle addWeaponTurret ['LMG_coax',[1]];
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		['1000Rnd_762x51_Belt_T_Green',[1]],
		['1000Rnd_762x51_Belt_T_Green',[1]]
	];
};
//comment 'Statics';
if (_type in [
	'b_hmg_01_f',
	'b_hmg_01_high_f',
	'b_hmg_01_a_f',
	'b_t_hmg_01_f',
	'o_hmg_01_f',
	'o_hmg_01_high_f',
	'o_hmg_01_a_f',
	'i_hmg_01_f',
	'i_hmg_01_high_f',
	'i_hmg_01_a_f',
	'b_g_hmg_02_f',
	'b_g_hmg_02_high_f',
	'o_g_hmg_02_f',
	'o_g_hmg_02_high_f',
	'i_hmg_02_f',
	'i_hmg_02_high_f',
	'i_g_hmg_02_f',
	'i_g_hmg_02_high_f',
	'i_e_hmg_02_f',
	'i_e_hmg_02_high_f',
	'i_c_hmg_02_f',
	'i_c_hmg_02_high_f'
]) then {
	_vehicle removeWeaponTurret ['HMG_static',[0]];
	_vehicle addWeaponTurret ['LMG_coax',[0]];
	private _magazine = '1000Rnd_762x51_Belt_T_Red';
	if (_type in [
		'o_hmg_01_f',
		'o_hmg_01_high_f',
		'o_hmg_01_a_f'
	]) then {
		_magazine = '1000Rnd_762x51_Belt_T_Green';
	};
	if (_type in [
		'i_hmg_01_f',
		'i_hmg_01_high_f',
		'i_hmg_01_a_f'
	]) then {
		_magazine = '1000Rnd_762x51_Belt_T_Yellow';
	};
	{
		_vehicle addMagazineTurret _x;
	} forEach [
		[_magazine,[0]]
	];	
};