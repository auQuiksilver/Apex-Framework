/*/
File: fn_getAIMotorPool.sqf
Author:

	Quiksilver
	
Last Modified:

	13/12/2022 A3 2.10 by Quiksilver
	
Description:

	AI Motor Pool
__________________________________________________/*/

params ['_case'];
private _return = [];
_allPlayersCount = count allPlayers;
_p_0 = 0.0;
_p_1 = 1.0;
_p_2 = 2.0;
_p_3 = 3.0;
_p_4 = 4.0;
private _tank_modifier = (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',1]) max 1;
private _air_modifier = (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0.5]) max 0.5;
if (_case isEqualTo -1) exitWith {
	// All armed
	[
		'o_mbt_04_command_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
		'o_mbt_04_cannon_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',_p_1,
		'i_lt_01_cannon_f',_p_1,			
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	]
};
if (_case isEqualTo 0) exitWith {
	// Classic AO - armed
	_return = [
		'o_mbt_04_command_f',((_tank_modifier * _p_0) min 0.1),
		'o_mbt_04_cannon_f',((_tank_modifier * _p_0) min 0.1),
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',_p_1,
		'i_lt_01_cannon_f',_p_1,
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	];
	if (_allPlayersCount > 10) then {
		_return = [
			'o_mbt_04_command_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_04_cannon_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
			'o_apc_tracked_02_cannon_f',_p_1,
			'i_apc_tracked_03_cannon_f',_p_1,
			'i_lt_01_aa_f',_air_modifier * _p_1,
			'i_lt_01_at_f',_p_1,
			'i_lt_01_cannon_f',_p_1,
			'i_apc_wheeled_03_cannon_f',_p_1,
			'o_apc_wheeled_02_rcws_v2_f',_p_1,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_2,
			'i_mrap_03_hmg_f',_p_2,
			'o_lsv_02_at_f',_tank_modifier * _p_2,
			'o_lsv_02_armed_f',_p_2,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	if (_allPlayersCount > 20) then {
		_return = [
			'o_mbt_04_command_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_04_cannon_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_2,
			'o_apc_tracked_02_cannon_f',_p_2,
			'i_apc_tracked_03_cannon_f',_p_2,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 30) then {
		_return = [
			'o_mbt_04_command_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_04_cannon_f',(((_tank_modifier * _p_1) * 0.5) min 0.1),
			'o_mbt_02_cannon_f',_tank_modifier * _p_2,
			'i_mbt_03_cannon_f',_tank_modifier * _p_2,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_3,
			'o_apc_wheeled_02_rcws_v2_f',_p_3,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 40) then {
		_return = [
			'o_mbt_04_command_f',(((_tank_modifier * _p_2) * 0.75) min 0.1),
			'o_mbt_04_cannon_f',(((_tank_modifier * _p_2) * 0.75) min 0.1),
			'o_mbt_02_cannon_f',_tank_modifier * _p_3,
			'i_mbt_03_cannon_f',_tank_modifier * _p_3,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		]
	};
	_return;
};
if (_case isEqualTo 1) exitWith {
	// SC AO - armed
	_return = [
		'o_mbt_04_command_f',_tank_modifier * _p_0,
		'o_mbt_04_cannon_f',_tank_modifier * _p_0,
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',_p_1,
		'i_lt_01_cannon_f',_p_1,
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	];
	if (_allPlayersCount > 10) then {
		_return = [
			'o_mbt_04_command_f',_tank_modifier * _p_0,
			'o_mbt_04_cannon_f',_tank_modifier * _p_0,
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
			'o_apc_tracked_02_cannon_f',_p_1,
			'i_apc_tracked_03_cannon_f',_p_1,
			'i_lt_01_aa_f',_air_modifier * _p_1,
			'i_lt_01_at_f',_p_1,
			'i_lt_01_cannon_f',_p_1,
			'i_apc_wheeled_03_cannon_f',_p_1,
			'o_apc_wheeled_02_rcws_v2_f',_p_1,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_2,
			'i_mrap_03_hmg_f',_p_2,
			'o_lsv_02_at_f',_tank_modifier * _p_2,
			'o_lsv_02_armed_f',_p_2,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	if (_allPlayersCount > 20) then {
		_return = [
			'o_mbt_04_command_f',_tank_modifier * _p_0,
			'o_mbt_04_cannon_f',_tank_modifier * _p_1,
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_2,
			'o_apc_tracked_02_cannon_f',_p_2,
			'i_apc_tracked_03_cannon_f',_p_2,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 30) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_2,
			'i_mbt_03_cannon_f',_tank_modifier * _p_2,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_3,
			'o_apc_wheeled_02_rcws_v2_f',_p_3,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 40) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_3,
			'i_mbt_03_cannon_f',_tank_modifier * _p_3,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	_return;
};
if (_case isEqualTo 2) exitWith {
	// Side mission general
	_return = [
		'o_mbt_04_command_f',_tank_modifier * _p_0,
		'o_mbt_04_cannon_f',_tank_modifier * _p_0,
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',_p_1,
		'i_lt_01_cannon_f',_p_1,
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	];
	if (_allPlayersCount > 10) then {
		_return = [
			'o_mbt_04_command_f',_tank_modifier * _p_0,
			'o_mbt_04_cannon_f',_tank_modifier * _p_0,
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
			'o_apc_tracked_02_cannon_f',_p_1,
			'i_apc_tracked_03_cannon_f',_p_1,
			'i_lt_01_aa_f',_air_modifier * _p_1,
			'i_lt_01_at_f',_p_1,
			'i_lt_01_cannon_f',_p_1,
			'i_apc_wheeled_03_cannon_f',_p_1,
			'o_apc_wheeled_02_rcws_v2_f',_p_1,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_2,
			'i_mrap_03_hmg_f',_p_2,
			'o_lsv_02_at_f',_tank_modifier * _p_2,
			'o_lsv_02_armed_f',_p_2,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	if (_allPlayersCount > 20) then {
		_return = [
			'o_mbt_04_command_f',_tank_modifier * _p_0,
			'o_mbt_04_cannon_f',_tank_modifier * _p_0,
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_2,
			'o_apc_tracked_02_cannon_f',_p_2,
			'i_apc_tracked_03_cannon_f',_p_2,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 30) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_2,
			'i_mbt_03_cannon_f',_tank_modifier * _p_2,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_3,
			'o_apc_wheeled_02_rcws_v2_f',_p_3,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 40) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_3,
			'i_mbt_03_cannon_f',_tank_modifier * _p_3,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	_return;
};
if (_case isEqualTo 3) exitWith {
	_return = [
		'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.75),
		'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.75),
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',_p_1,
		'i_lt_01_cannon_f',_p_1,
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	];
	if (_allPlayersCount > 10) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
			'o_apc_tracked_02_cannon_f',_p_1,
			'i_apc_tracked_03_cannon_f',_p_1,
			'i_lt_01_aa_f',_air_modifier * _p_1,
			'i_lt_01_at_f',_p_1,
			'i_lt_01_cannon_f',_p_1,
			'i_apc_wheeled_03_cannon_f',_p_1,
			'o_apc_wheeled_02_rcws_v2_f',_p_1,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_2,
			'i_mrap_03_hmg_f',_p_2,
			'o_lsv_02_at_f',_tank_modifier * _p_2,
			'o_lsv_02_armed_f',_p_2,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	if (_allPlayersCount > 20) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_2,
			'o_apc_tracked_02_cannon_f',_p_2,
			'i_apc_tracked_03_cannon_f',_p_2,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 30) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_2,
			'i_mbt_03_cannon_f',_tank_modifier * _p_2,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_3,
			'o_apc_wheeled_02_rcws_v2_f',_p_3,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 40) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.5),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.5),
			'o_mbt_02_cannon_f',_tank_modifier * _p_3,
			'i_mbt_03_cannon_f',_tank_modifier * _p_3,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_2,
			'i_lt_01_at_f',_p_2,
			'i_lt_01_cannon_f',_p_2,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	_return;
};
if (_case isEqualTo 4) exitWith {
	// Grid/Insurgency AOs
	[
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_2,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_2,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_2
	]
};
if (_case isEqualTo 5) exitWith {
	// Ambient Hostility - low target knowledge
	[
		'o_mbt_04_command_f',0,
		'o_mbt_04_cannon_f',0,
		'o_mbt_02_cannon_f',0.1,
		'i_mbt_03_cannon_f',0.1,
		'o_apc_tracked_02_aa_f',0,
		'o_apc_tracked_02_cannon_f',0.1,
		'i_apc_tracked_03_cannon_f',0.1,
		'i_lt_01_aa_f',1,
		'i_lt_01_at_f',1,
		'i_lt_01_cannon_f',1,			
		'i_apc_wheeled_03_cannon_f',0.5,
		'o_apc_wheeled_02_rcws_v2_f',0.5,
		'o_mrap_02_gmg_f',1,
		'o_mrap_02_hmg_f',1,
		'i_mrap_03_gmg_f',1,
		'i_mrap_03_hmg_f',1,
		'o_lsv_02_at_f',1,
		'o_lsv_02_armed_f',1,
		'o_g_offroad_01_at_f',1,
		'o_g_offroad_01_armed_f',1,
		'i_c_offroad_02_at_f',1,
		'i_c_offroad_02_lmg_f',1
	]
};
if (_case isEqualTo 6) exitWith {
	// Ambient Hostility - higher target knowledge
	[
		'o_mbt_04_command_f',0,
		'o_mbt_04_cannon_f',0,
		'o_mbt_02_cannon_f',0.1,
		'i_mbt_03_cannon_f',0.1,
		'o_apc_tracked_02_aa_f',0,
		'o_apc_tracked_02_cannon_f',0.1,
		'i_apc_tracked_03_cannon_f',0.1,
		'i_lt_01_aa_f',_air_modifier * _p_1,
		'i_lt_01_at_f',2,
		'i_lt_01_cannon_f',2,			
		'i_apc_wheeled_03_cannon_f',1,
		'o_apc_wheeled_02_rcws_v2_f',1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	]
};
if (_case isEqualTo 7) exitWith {
	// Classic AO - armed
	_return = [
		'o_mbt_04_command_f',_tank_modifier * _p_0,
		'o_mbt_04_cannon_f',_tank_modifier * _p_0,
		'o_mbt_02_cannon_f',_tank_modifier * _p_1,
		'i_mbt_03_cannon_f',_tank_modifier * _p_1,
		'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
		'o_apc_tracked_02_cannon_f',_p_1,
		'i_apc_tracked_03_cannon_f',_p_1,
		'i_lt_01_aa_f',_air_modifier * _p_3,
		'i_lt_01_at_f',_p_3,
		'i_lt_01_cannon_f',_p_3,
		'i_apc_wheeled_03_cannon_f',_p_1,
		'o_apc_wheeled_02_rcws_v2_f',_p_1,
		'o_mrap_02_gmg_f',_p_1,
		'o_mrap_02_hmg_f',_p_1,
		'i_mrap_03_gmg_f',_p_1,
		'i_mrap_03_hmg_f',_p_1,
		'o_lsv_02_at_f',_tank_modifier * _p_1,
		'o_lsv_02_armed_f',_p_1,
		'o_g_offroad_01_at_f',_tank_modifier * _p_1,
		'o_g_offroad_01_armed_f',_p_1,
		'i_c_offroad_02_at_f',_tank_modifier * _p_1,
		'i_c_offroad_02_lmg_f',_p_1
	];
	if (_allPlayersCount > 10) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.5),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.5),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_1,
			'o_apc_tracked_02_cannon_f',_p_1,
			'i_apc_tracked_03_cannon_f',_p_1,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_1,
			'o_apc_wheeled_02_rcws_v2_f',_p_1,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_2,
			'i_mrap_03_hmg_f',_p_2,
			'o_lsv_02_at_f',_tank_modifier * _p_2,
			'o_lsv_02_armed_f',_p_2,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	if (_allPlayersCount > 20) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.5),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.5),
			'o_mbt_02_cannon_f',_tank_modifier * _p_1,
			'i_mbt_03_cannon_f',_tank_modifier * _p_1,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_2,
			'o_apc_tracked_02_cannon_f',_p_2,
			'i_apc_tracked_03_cannon_f',_p_2,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_3,
			'i_lt_01_cannon_f',_p_3,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_2,
			'o_mrap_02_hmg_f',_p_2,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 30) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_1) * 0.75),
			'o_mbt_02_cannon_f',_tank_modifier * _p_2,
			'i_mbt_03_cannon_f',_tank_modifier * _p_2,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_3,
			'i_lt_01_at_f',_p_4,
			'i_lt_01_cannon_f',_p_4,
			'i_apc_wheeled_03_cannon_f',_p_3,
			'o_apc_wheeled_02_rcws_v2_f',_p_3,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_0,
			'o_g_offroad_01_armed_f',_p_0,
			'i_c_offroad_02_at_f',_tank_modifier * _p_0,
			'i_c_offroad_02_lmg_f',_p_0
		];
	};
	if (_allPlayersCount > 40) then {
		_return = [
			'o_mbt_04_command_f',((_tank_modifier * _p_2) * 0.5),
			'o_mbt_04_cannon_f',((_tank_modifier * _p_2) * 0.5),
			'o_mbt_02_cannon_f',_tank_modifier * _p_3,
			'i_mbt_03_cannon_f',_tank_modifier * _p_3,
			'o_apc_tracked_02_aa_f',_air_modifier * _p_3,
			'o_apc_tracked_02_cannon_f',_p_3,
			'i_apc_tracked_03_cannon_f',_p_3,
			'i_lt_01_aa_f',_air_modifier * _p_4,
			'i_lt_01_at_f',_p_4,
			'i_lt_01_cannon_f',_p_4,
			'i_apc_wheeled_03_cannon_f',_p_2,
			'o_apc_wheeled_02_rcws_v2_f',_p_2,
			'o_mrap_02_gmg_f',_p_1,
			'o_mrap_02_hmg_f',_p_1,
			'i_mrap_03_gmg_f',_p_1,
			'i_mrap_03_hmg_f',_p_1,
			'o_lsv_02_at_f',_tank_modifier * _p_1,
			'o_lsv_02_armed_f',_p_1,
			'o_g_offroad_01_at_f',_tank_modifier * _p_1,
			'o_g_offroad_01_armed_f',_p_1,
			'i_c_offroad_02_at_f',_tank_modifier * _p_1,
			'i_c_offroad_02_lmg_f',_p_1
		];
	};
	_return;
};
if (_case isEqualTo 8) exitWith {
	[
		'o_mbt_04_command_f',0,
		'o_mbt_04_cannon_f',0,
		'o_mbt_02_cannon_f',0,
		'i_mbt_03_cannon_f',0,
		'o_apc_tracked_02_aa_f',0,
		'o_apc_tracked_02_cannon_f',1,
		'i_lt_01_aa_f',1,
		'i_lt_01_at_f',1,
		'i_lt_01_cannon_f',1,
		'i_apc_wheeled_03_cannon_f',1,
		'o_apc_wheeled_02_rcws_v2_f',1,
		'o_mrap_02_gmg_f',1,
		'o_mrap_02_hmg_f',1,
		'i_mrap_03_gmg_f',1,
		'i_mrap_03_hmg_f',1,
		'o_lsv_02_at_f',1,
		'o_lsv_02_armed_f',1
	]
};
_return;