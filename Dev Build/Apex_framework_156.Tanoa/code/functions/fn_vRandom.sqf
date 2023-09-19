/*/
File: fn_vRandom.sqf
Author:

	Quiksilver
	
Last Modified:

	10/04/2018 A3 1.82 by Quiksilver

Description:

	Vehicle Randomization
_____________________________________________/*/

params ['_type'];
private _typeL = toLowerANSI _type;
_isTropical = worldName in ['Tanoa','Lingor3'];
//----- MBTs
_mbts =	[
	'i_mbt_03_cannon_f',0.2,
	'b_mbt_01_cannon_f',0.5,
	'b_mbt_01_tusk_f',0.3,
	'o_mbt_02_cannon_f',0.1,
	'o_mbt_04_cannon_f',0.05,
	'o_mbt_04_command_f',0.0		//--- Maybe reserve this one for side mission reward
];
//----- APCs
_apcs = [
	'b_apc_wheeled_01_cannon_f',0.1,
	'b_apc_wheeled_03_cannon_f',0.1,
	'b_apc_tracked_01_rcws_f',0.1,
	'o_apc_wheeled_02_rcws_v2_f',0.1,
	'b_afv_wheeled_01_cannon_f',0.5,
	'b_afv_wheeled_01_up_cannon_f',0.5
];
//----- Nyx
_nyx = [
	'i_lt_01_aa_f',0.2,
	'i_lt_01_at_f',0.3,
	'i_lt_01_scout_f',0.1,
	'i_lt_01_cannon_f',0.5
];
//----- Medium Helis
_medhelis = [
	'b_heli_transport_01_f',0.1,
	'b_heli_transport_01_camo_f',0.1,
	'o_heli_light_02_unarmed_f',0.1,
	'i_heli_light_03_unarmed_f',0.1,
	'b_ctrg_heli_transport_01_sand_f',0.1,
	'b_ctrg_heli_transport_01_tropic_f',0.1,
	'b_heli_light_01_f',0.1,
	'o_heli_transport_04_black_f',0.1
];
//----- DLC Helis
_dlchelis = [
	'b_heli_transport_03_f',0.1,
	'b_heli_transport_03_unarmed_f',0.1,
	'o_heli_transport_04_black_f',0.1
];
//----- Civ vehicles
_civ = [
	'c_offroad_01_f',0.1,
	'c_suv_01_f',0.1,
	'c_van_01_transport_f',0.1,
	'c_hatchback_01_f',0.1
];
//----- Civ boats
_civboat = [
	'c_boat_civil_01_f',0.1,
	'c_boat_civil_01_police_f',0.1,
	'c_boat_civil_01_rescue_f',0.1,
	'c_rubberboat',0.1
];
//----- Technical
_technicals = [
	'b_g_offroad_01_at_f',0.1,
	'b_g_offroad_01_armed_f',0.2,
	'i_c_offroad_02_at_f',0.1,
	'i_c_offroad_02_lmg_f',0.2
];
//----- Hunter Armed
_hunterarmed = [
	'b_mrap_01_gmg_f',0.1,
	'b_mrap_01_hmg_f',0.1
];
//----- Civ Jeeps
_jeeps_civ = [
	'c_offroad_02_unarmed_blue_f',0.1,
	'c_offroad_02_unarmed_green_f',0.1,
	'c_offroad_02_unarmed_orange_f',0.1,
	'c_offroad_02_unarmed_red_f',0.1,
	'c_offroad_02_unarmed_white_f',0.1,
	'i_c_offroad_02_unarmed_olive_f',0.1
];
//----- Prowler Armed
_lsv_west_armed = [
	'b_t_lsv_01_armed_black_f',0.1,
	'b_t_lsv_01_armed_sand_f',0.1,
	'b_lsv_01_at_f',0.1
];
//----- Prowler Unarmed
_lsv_west_unarmed = [
	'b_t_lsv_01_unarmed_black_f',0.1,
	'b_t_lsv_01_unarmed_sand_f',0.1
];
//----- Qilin Armed
_lsv_east_armed = [
	'o_lsv_02_armed_black_f',0.1,
	'o_lsv_02_at_f',0.1
];
//----- Qilin Unarmed
_lsv_east_unarmed = [
	'o_lsv_02_unarmed_black_f',0.1
];
if (_typeL in _apcs) exitWith {
	_type = selectRandomWeighted _apcs;_type;
};
if (_typeL in _medHelis) exitWith {
	_type = selectRandomWeighted _medHelis;_type;
};
if (_typeL in _dlcHelis) exitWith {
	_type = selectRandomWeighted _dlcHelis;_type;
};
if (_typeL in _mbts) exitWith {
	_type = selectRandomWeighted _mbts;_type;
};
if (_typeL in _nyx) exitWith {
	_type = selectRandomWeighted _nyx;_type;
};
if (_typeL in _civ) exitWith {
	_type = selectRandomWeighted _civ;_type;
};
if (_typeL in _civBoat) exitWith {
	_type = selectRandomWeighted _civBoat;_type;
};
if (_typeL in _hunterArmed) exitWith {
	_type = selectRandomWeighted _hunterArmed;_type;
};
if (_typeL in _jeeps_civ) exitWith {
	_type = selectRandomWeighted _jeeps_civ;_type;
};
if (_typeL in _lsv_west_armed) exitWith {
	_type = selectRandomWeighted _lsv_west_armed;_type;
};
if (_typeL in _lsv_west_unarmed) exitWith {
	_type = selectRandomWeighted _lsv_west_unarmed;_type;
};
if (_typeL in _technicals) exitWith {
	_type = selectRandomWeighted _technicals;_type;
};
_type;