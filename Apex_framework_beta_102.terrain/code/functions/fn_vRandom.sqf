/*
File: fn_vRandom.sqf
Author:

	Quiksilver
	
Last Modified:

	23/02/2016 A3 1.56 by Quiksilver

Description:

	Vehicle RandomiZZZation
_____________________________________________*/

/*/============================================= CONFIG/*/

private ['_u','_t'];

_u = _this select 0;
_t = _u;
_apcs = [
	'B_APC_Wheeled_01_cannon_F','I_APC_Wheeled_03_cannon_F','B_APC_Wheeled_01_cannon_F','B_APC_Wheeled_01_cannon_F',
	'B_APC_Tracked_01_rcws_F','O_T_APC_Wheeled_02_rcws_ghex_F','O_T_APC_Wheeled_02_rcws_ghex_F','I_APC_tracked_03_cannon_F'
];
_medHelis = ['B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Light_02_unarmed_F','I_Heli_light_03_unarmed_F','B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F','B_Heli_Light_01_F','O_Heli_Transport_04_black_F'];
_dlcHelis = ['B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','O_Heli_Transport_04_black_F','B_Heli_Transport_03_unarmed_F','B_Heli_Transport_03_unarmed_F'];
_mbts = ['I_MBT_03_cannon_F','B_MBT_01_cannon_F','B_MBT_01_TUSK_F','B_MBT_01_TUSK_F','O_T_MBT_02_cannon_ghex_F'];
_civ = ['C_Offroad_01_F','C_SUV_01_F','C_Van_01_transport_F','C_Hatchback_01_F'];
_civBoat = ['C_Boat_Civil_01_F','C_Boat_Civil_01_police_F','C_Boat_Civil_01_rescue_F','C_Rubberboat'];
_hunterArmed = ['B_MRAP_01_gmg_F','B_MRAP_01_hmg_F'];
_jeeps_civ = ['c_offroad_02_unarmed_blue_f','c_offroad_02_unarmed_green_f','c_offroad_02_unarmed_orange_f','c_offroad_02_unarmed_red_f','c_offroad_02_unarmed_white_f','i_c_offroad_02_unarmed_olive_f'];
_lsv_west_armed = [
	"B_T_LSV_01_armed_black_F","B_T_LSV_01_armed_CTRG_F","B_T_LSV_01_armed_F","B_T_LSV_01_armed_olive_F",
	"B_T_LSV_01_armed_sand_F"
];
_lsv_west_unarmed = [
	"B_T_LSV_01_unarmed_black_F","B_T_LSV_01_unarmed_CTRG_F","B_T_LSV_01_unarmed_F","B_T_LSV_01_unarmed_olive_F","B_T_LSV_01_unarmed_sand_F"
];
_lsv_east_armed = [
	"O_T_LSV_02_armed_black_F"
];
_lsv_east_unarmed = [
	"O_T_LSV_02_unarmed_black_F"
];

if (_u in _apcs) exitWith {
	_t = selectRandom _apcs;_t;
};
if (_u in _medHelis) exitWith {
	_t = selectRandom _medHelis;_t;
};
if (_u in _dlcHelis) exitWith {
	_t = selectRandom _dlcHelis;_t;
};
if (_u in _mbts) exitWith {
	_t = selectRandom _mbts;_t;
};
if (_u in _civ) exitWith {
	_t = selectRandom _civ;_t;
};
if (_u in _civBoat) exitWith {
	_t = selectRandom _civBoat;_t;
};
if (_u in _hunterArmed) exitWith {
	_t = selectRandom _hunterArmed;_t;
};
if ((toLower _u) in _jeeps_civ) exitWith {
	_t = selectRandom _jeeps_civ;_t;
};
if (_u in _lsv_west_armed) exitWith {
	_t = selectRandom _lsv_west_armed;_t;
};
if (_u in _lsv_west_unarmed) exitWith {
	_t = selectRandom _lsv_west_unarmed;_t;
};
_t;