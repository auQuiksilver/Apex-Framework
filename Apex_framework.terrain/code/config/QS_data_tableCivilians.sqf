/*
File: QS_data_tableCivilians.sqf
Author:

	Quiksilver
	
Last modified:

	8/12/2022 A3 2.10 by Quiksilver
	
Description:

	Civilians
_________________________________*/

private _units_table = missionNamespace getVariable ['QS_system_activeDLC_units',''];		// Set your own mod to pull units from
if (_units_table isEqualTo '') then {
	_units_table = missionNamespace getVariable ['QS_system_activeDLC',''];
};

// DLCs and Mods below
// Vanilla at the bottom

if (_units_table == 'YOUR_MOD_HERE') exitWith {
	// YOUR MOD HERE
	// REPLACE THE CIVILIAN CLASSNAMES WITH CIVILIAN CLASSNAMES FROM YOUR MOD
	[
		'C_man_w_worker_F',
		'C_Man_UtilityWorker_01_F',
		'C_Man_Messenger_01_F',
		'C_man_hunter_1_F',
		'C_Man_Fisherman_01_F',
		'C_man_polo_6_F',
		'C_man_polo_5_F',
		'C_man_polo_4_F',
		'C_man_polo_3_F',
		'C_man_polo_2_F',
		'C_man_polo_1_F',
		'C_Man_casual_6_F',
		'C_Man_casual_5_F',
		'C_Man_casual_4_F',
		'C_Man_smart_casual_2_F',
		'C_Man_smart_casual_1_F',
		'C_man_1',
		'C_man_p_beggar_F',
		'C_Man_casual_1_F',
		'C_Man_casual_2_F',
		'C_Man_casual_3_F',
		'C_Farmer_01_enoch_F'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};	
};


if (_units_table == 'WS') exitWith {
	[
		'C_Djella_01_lxWS',
		'C_Djella_02_lxWS',
		'C_Djella_03_lxWS',
		'C_Djella_04_lxWS',
		'C_Djella_05_lxWS',
		'C_Tak_02_A_lxWS',
		'C_Tak_02_B_lxWS',
		'C_Tak_02_C_lxWS',
		'C_Tak_03_A_lxWS',
		'C_Tak_03_B_lxWS',
		'C_Tak_03_C_lxWS',
		'C_Tak_01_A_lxWS',
		'C_Tak_01_B_lxWS',
		'C_Tak_01_C_lxWS'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
if (_units_table == 'VN') exitWith {
	[
		'vn_c_men_13',
		'vn_c_men_22',
		'vn_c_men_23',
		'vn_c_men_24',
		'vn_c_men_25',
		'vn_c_men_26',
		'vn_c_men_27',
		'vn_c_men_28',
		'vn_c_men_29',
		'vn_c_men_30',
		'vn_c_men_31',
		'vn_c_men_14',
		'vn_c_men_32',
		'vn_c_men_15',
		'vn_c_men_16',
		'vn_c_men_17',
		'vn_c_men_18',
		'vn_c_men_19',
		'vn_c_men_20',
		'vn_c_men_21',
		'vn_c_men_05',
		'vn_c_men_06',
		'vn_c_men_07',
		'vn_c_men_08',
		'vn_c_men_01',
		'vn_c_men_02',
		'vn_c_men_03',
		'vn_c_men_04',
		'vn_c_men_09',
		'vn_c_men_10',
		'vn_c_men_11',
		'vn_c_men_12'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
if (_units_table == 'CSLA') exitWith {
	[
		'CSLA_CIV_Citizen',
		'CSLA_CIV_Citizen_V2',
		'CSLA_CIV_Citizen_V3',
		'CSLA_CIV_Citizen_V4',
		'CSLA_CIV_Foreman',
		'CSLA_CIV_Foreman_V2',
		'CSLA_CIV_Woodlander',
		'CSLA_CIV_Woodlander_V2',
		'CSLA_CIV_Woodlander_V3',
		'CSLA_CIV_Woodlander_V4',
		'CSLA_CIV_Functionary',
		'CSLA_CIV_Functionary_V2',
		'CSLA_CIV_Policeman',
		'CSLA_CIV_PoliceManSa61',
		'CSLA_CIV_Villager',
		'CSLA_CIV_Villager_V2',
		'CSLA_CIV_Villager_V3',
		'CSLA_CIV_Villager_V4',
		'CSLA_CIV_Worker',
		'CSLA_CIV_Worker_V2',
		'CSLA_CIV_Worker_V3',
		'CSLA_CIV_Worker_V4'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
if (_units_table == 'GM') exitWith {
	[
		'gm_gc_civ_man_02_80_gry',
		'gm_gc_civ_man_01_80_blk',
		'gm_gc_civ_man_01_80_blu',
		'gm_gc_civ_man_03_80_blu',
		'gm_gc_civ_man_02_80_brn',
		'gm_gc_civ_man_03_80_grn',
		'gm_gc_civ_man_03_80_gry',
		'gm_gc_civ_man_04_80_blu',
		'gm_gc_civ_man_04_80_gry',
		'gm_gc_pol_officer_80_blu'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
if (worldName in ['Tanoa']) exitWith {
	[
		'C_Man_casual_1_F_tanoan',
		'C_Man_casual_2_F_tanoan',
		'C_Man_casual_3_F_tanoan',
		'C_Man_casual_4_F_tanoan',
		'C_Man_casual_5_F_tanoan',
		'C_Man_casual_6_F_tanoan',
		'C_Man_formal_2_F_tanoan',
		'C_man_sport_1_F_tanoan',
		'C_man_sport_2_F_tanoan',
		'C_man_sport_3_F_tanoan'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
if (worldName in ['Enoch']) exitWith {
	[
		'C_Man_1_enoch_F',
		'C_Man_2_enoch_F',
		'C_Man_3_enoch_F',
		'C_Man_4_enoch_F',
		'C_Man_5_enoch_F',
		'C_Man_6_enoch_F',
		'C_Farmer_01_enoch_F',
		'C_Man_formal_4_F_euro',
		'C_Man_formal_2_F_euro',
		'C_scientist_02_formal_F',
		'C_man_p_fugitive_F_euro',
		'C_Man_casual_1_F_euro',
		'C_Man_casual_2_F_euro',
		'C_Man_casual_3_F_euro'
	] apply {
		_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
		_x
	};
};
[
	'C_man_w_worker_F',
	'C_Man_UtilityWorker_01_F',
	'C_Man_Messenger_01_F',
	'C_man_hunter_1_F',
	'C_Man_Fisherman_01_F',
	'C_man_polo_6_F',
	'C_man_polo_5_F',
	'C_man_polo_4_F',
	'C_man_polo_3_F',
	'C_man_polo_2_F',
	'C_man_polo_1_F',
	'C_Man_casual_6_F',
	'C_Man_casual_5_F',
	'C_Man_casual_4_F',
	'C_Man_smart_casual_2_F',
	'C_Man_smart_casual_1_F',
	'C_man_1',
	'C_man_p_beggar_F',
	'C_Man_casual_1_F',
	'C_Man_casual_2_F',
	'C_Man_casual_3_F',
	'C_Farmer_01_enoch_F'
] apply {
	_x call (missionNamespace getVariable 'QS_fnc_prepareClassAddons');
	_x
};