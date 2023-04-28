/*/
File: QS_data_listUnits.sqf
Author:

	Quiksilver
	
Last modified:

	27/12/2022 A3 2.10 by Quiksilver
	
Description:

	Lists of Units
________________________________/*/

params ['_type',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	(QS_hashmap_classLists getOrDefaultCall [format ['u_%1',_type],{[_type,1] call QS_data_listUnits},TRUE])
};
private _return = [];
if (_type isEqualTo 'o_heli_insert_1') exitWith {
	[
		'o_soldier_f',1,
		'o_soldier_ar_f',3,
		'o_soldier_gl_f',2,
		'o_soldier_lite_f',1,
		'o_sharpshooter_f',2,
		'o_soldier_m_f',2,
		'o_soldier_lat_f',1,
		'o_medic_f',1
	]
};
if (_type isEqualTo 'b_heli_insert_1') exitWith {
	['b_soldier_f',1]
};
if (_type isEqualTo 'i_heli_insert_1') exitWith {
	['i_soldier_f',1]
};
if (_type isEqualTo 'ambient_hostility_1') exitWith {
	[
		'O_G_Soldier_A_F',1,
		'O_G_Soldier_AR_F',3,
		'O_G_medic_F',1,
		'O_G_engineer_F',1,
		'O_G_Soldier_exp_F',1,
		'O_G_Soldier_GL_F',1,
		'O_G_Soldier_M_F',1,
		'O_G_Soldier_F',1,
		'O_G_Soldier_LAT_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_LAT2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_lite_F',1,
		'O_G_Sharpshooter_F',3,
		'O_G_Soldier_TL_F',1,
		'I_C_Soldier_Bandit_7_F',1,
		'I_C_Soldier_Bandit_3_F',3,
		'I_C_Soldier_Bandit_2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'I_C_Soldier_Bandit_5_F',2,
		'I_C_Soldier_Bandit_6_F',2,
		'I_C_Soldier_Bandit_1_F',2,
		'I_C_Soldier_Bandit_8_F',2,
		'I_C_Soldier_Bandit_4_F',2,
		'I_C_Soldier_Para_7_F',1,
		'I_C_Soldier_Para_2_F',1,
		'I_C_Soldier_Para_3_F',1,
		'I_C_Soldier_Para_4_F',3,
		'I_C_Soldier_Para_6_F',1,
		'I_C_Soldier_Para_8_F',1,
		'I_C_Soldier_Para_1_F',1,
		'I_C_Soldier_Para_5_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4)
	]
};
if (_type isEqualTo 'defend_grptypes_1') exitWith {
	[
		'OIA_InfTeam_AA',0.25,
		'OIA_InfTeam_AT',0.084,
		'OIA_InfSquad',0.25,
		'OIA_InfSquad_Weapons',0.2,
		'OIA_InfAssault',0.25,
		'OIA_InfSquad_L',0.333
	]
};
if (_type isEqualTo 'defend_grptypes_2') exitWith {
	// STRATIS terrain
	[
		'OIA_InfTeam_AA',0.25,
		'OIA_InfTeam_AT',0.084,
		'OIA_InfSquad',0.25,
		'OIA_InfSquad_Weapons',0.2,
		'OIA_InfAssault',0.25,
		'OIA_InfSquad_L',0.333
	]
};
if (_type isEqualTo 'defend_unittypes_1') exitWith {
	[
		'O_Soldier_SL_F','O_Soldier_F','O_Soldier_LAT_F','O_Soldier_M_F','O_Soldier_AR_F',
		'O_Soldier_A_F','O_medic_F'
	]
};
if (_type isEqualTo 'defend_paratypes_1') exitWith {
	['o_soldier_pg_f']
};
if (_type isEqualTo 'classic_enemyinftypes_1') exitWith {
	// Main groups list to spawn for classic AO
	[
		'OIA_InfSquad',4,
		'OIA_InfTeam',2,
		'OIA_InfAssault',2,
		'OIA_InfTeam_AA',3,
		'OIA_InfTeam_AT',0.5,
		'OIA_InfTeam_HAT',1,
		'OI_reconPatrol',1,
		'OIA_ReconSquad',1,
		'OIA_InfTeam_LAT',2,
		'OIA_ARTeam',2
	]
};
if (_type isEqualTo 'classic_enemyinftypes_stratis_1') exitWith {
	[
		'OIA_InfSquad',5,
		'OIA_InfAssault',1,
		'OIA_InfTeam_AA',1,
		'OI_reconPatrol',0.5,
		'OIA_InfTeam_LAT',0.25,
		'OIA_ARTeam',4
	]
};
if (_type isEqualTo 'classic_enemygarrisontypes_1') exitWith {
	// Main ao garrisoned group types (at HQ, etc)
	[
		'OIA_ARTeam',2,
		'OIA_InfTeam_AT',1,
		'OIA_InfTeam_LAT',1
	]
};
if (_type isEqualTo 'classic_enemygarrisontypes_stratis_1') exitWith {
	[
		'OIA_ARTeam',2,
		//'OIA_InfTeam_AT',1,
		'OIA_InfTeam_LAT',1
	]
};
if (_type isEqualTo 'classic_enemyofficertype_1') exitWith {
	'O_officer_F'
};
if (_type isEqualTo 'classic_garrisonindarray_1') exitWith {
	// Garrisoned enemies on most terrains
	[
		'o_soldieru_a_f','o_soldieru_aar_f','o_soldieru_ar_f','o_soldieru_medic_f','o_engineer_u_f','o_soldieru_exp_f','o_soldieru_gl_f',
		'o_urban_heavygunner_f','o_soldieru_m_f','o_soldieru_at_f','o_soldieru_f','o_soldieru_lat_f','o_urban_sharpshooter_f',
		'o_soldieru_sl_f','o_soldieru_tl_f','o_g_engineer_f','o_g_medic_f','o_g_soldier_a_f','o_g_soldier_ar_f','o_g_soldier_exp_f','o_g_soldier_f','o_g_soldier_f',
		'o_g_soldier_gl_f','o_g_soldier_lat_f','o_g_soldier_lite_f','o_g_soldier_m_f','o_g_soldier_sl_f','o_g_soldier_tl_f',
		'o_g_sharpshooter_f','o_g_soldier_ar_f'
	]
};
if (_type isEqualTo 'classic_garrisonindarray_2') exitWith {
	// Garrisoned enemies on Tanoa/Livonia
	[
		'i_c_soldier_para_1_f','i_c_soldier_para_2_f','i_c_soldier_para_3_f','i_c_soldier_para_4_f',
		'i_c_soldier_para_5_f','i_c_soldier_para_6_f',
		'i_c_soldier_para_7_f','i_c_soldier_para_8_f'
	]
};
if (_type isEqualTo 'classic_garrisonindarray_3') exitWith {
	// HQ guards
	[
		'o_soldieru_ar_f','o_soldieru_medic_f','o_engineer_u_f','o_soldieru_exp_f','o_soldieru_gl_f',
		'o_urban_heavygunner_f','o_soldieru_m_f','o_soldieru_aa_f','o_soldieru_at_f','o_soldieru_lat_f','o_urban_sharpshooter_f'
	]
};
if (_type isEqualTo 'classic_reinforcearray_1') exitWith {
	[
		'OIA_InfSquad',2,
		'OIA_InfTeam',2,
		'OI_reconPatrol',1,
		'OIA_InfAssault',2,
		'OG_InfSquad',1,
		'OG_InfAssaultTeam',1,
		'OIA_ARTeam',2,
		'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
		'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
		'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
	]
};
if (_type isEqualTo 'classic_reinforcearray_stratis') exitWith {
	[
		'OIA_InfSquad',5,
		'OIA_InfAssault',2,
		'OIA_InfTeam_AA',(0.5 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 2),
		'OI_reconPatrol',0.5,
		'OIA_ARTeam',4
	]
};
if (_type isEqualTo 'forest_camp_1') exitWith {
	// most terrains
	['HAF_InfSentry',1,'IG_SniperTeam_M',1]
};
if (_type isEqualTo 'forest_camp_2') exitWith {
	// Tanoa
	['IG_InfSentry',1,'IG_ReconSentry',1]
};
if (_type isEqualTo 'forest_camp_3') exitWith {
	// Livonia
	['I_E_InfSentry',1,'I_L_CriminalSentry',1]
};
if (_type isEqualto 'ao_hvt_units_1') exitWith {
	[
		'C_man_p_fugitive_F','C_man_p_shorts_1_F','C_man_p_fugitive_F_afro','C_man_p_shorts_1_F_afro',
		'C_man_p_fugitive_F_asia','C_man_p_shorts_1_F_asia','C_man_p_fugitive_F_euro','C_man_p_shorts_1_F_euro'
	]
};
if (_type isEqualto 'ao_hvt_guards_1') exitWith {
	[
		"I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_1_F",
		"I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F",
		"I_C_Soldier_base_unarmed_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F"
	]
};
if (_type isEqualTo 'ao_idap_units_1') exitWith {
	[
		'C_IDAP_Man_AidWorker_01_F',
		'C_IDAP_Man_AidWorker_07_F',
		'C_IDAP_Man_AidWorker_08_F',
		'C_IDAP_Man_AidWorker_09_F',
		'C_IDAP_Man_AidWorker_02_F',
		'C_IDAP_Man_AidWorker_05_F',
		'C_IDAP_Man_AidWorker_06_F',
		'C_IDAP_Man_AidWorker_04_F',
		'C_IDAP_Man_AidWorker_03_F'
	]
};
if (_type isEqualTo 'ao_idap_enemies_1') exitWith {
	[
		"I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F",
		"I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F"
	]
};
if (_type isEqualto 'ao_taskkill_enemies_1') exitWith {
	['O_V_Soldier_M_hex_F','O_V_Soldier_hex_F']
};
if (_type isEqualTo 'ao_taskmedevac_units_1') exitwith {
	['B_recon_TL_F','B_recon_M_F','B_recon_medic_F','B_recon_F','B_recon_LAT_F','B_recon_JTAC_F','B_recon_exp_F','B_Recon_Sharpshooter_F']
};
if (_type isEqualTo 'urbanspawn_units_1') exitWith {
	[
		'o_soldieru_a_f','o_soldieru_aar_f','o_soldieru_ar_f','o_soldieru_medic_f','o_engineer_u_f','o_soldieru_exp_f','o_soldieru_gl_f',
		'o_urban_heavygunner_f','o_soldieru_m_f','o_soldieru_at_f','o_soldieru_f','o_soldieru_lat_f','o_urban_sharpshooter_f',
		'o_soldieru_sl_f','o_soldieru_tl_f','o_g_engineer_f','o_g_medic_f','o_g_soldier_a_f','o_g_soldier_ar_f','o_g_soldier_exp_f','o_g_soldier_f','o_g_soldier_f',
		'o_g_soldier_gl_f','o_g_soldier_lat_f','o_g_soldier_lite_f','o_g_soldier_m_f','o_g_soldier_sl_f','o_g_soldier_tl_f',
		'o_g_sharpshooter_f','o_g_soldier_ar_f'
	]
};
if (_type isEqualTo 'urbanspawn_nodes_1') exitWith {
	[
		"i_c_soldier_para_1_f","i_c_soldier_para_2_f","i_c_soldier_para_3_f",
		"i_c_soldier_para_4_f","i_c_soldier_para_5_f","i_c_soldier_para_6_f",
		"i_c_soldier_para_7_f","i_c_soldier_para_8_f"
	]
};
if (_type isEqualTo 'urbanspawn_groups_1') exitWith {
	[
		'OIA_InfSquad',2,
		'OIA_InfTeam',2,
		'OI_reconPatrol',1,
		'OIA_InfAssault',2,
		'OG_InfSquad',1,
		'OG_InfAssaultTeam',1,
		'OIA_ARTeam',2,
		'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
		'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
		'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
	]
};
if (_type isEqualTo 'urbanspawn_groups_stratis_1') exitWith {
	[
		'OIA_InfSquad',2,
		'OIA_InfTeam',2,
		'OI_reconPatrol',1,
		'OIA_InfAssault',2,
		'OG_InfSquad',1,
		'OG_InfAssaultTeam',1,
		'OIA_ARTeam',2,
		//'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
		'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3)//,
		//'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
	]
};
if (_type isEqualTo 'urbanspawn_groups_2') exitWith {
	[
		'OIA_InfSquad',4,
		'OIA_ARTeam',2,
		'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3)
	]
};
if (_type isEqualTo 'civilians_fugitives') exitWith {
	[
		'c_man_p_fugitive_f','c_man_p_shorts_1_f','c_man_p_fugitive_f_afro','c_man_p_shorts_1_f_afro',
		'c_man_p_fugitive_f_asia','c_man_p_shorts_1_f_asia','c_man_p_fugitive_f_euro','c_man_p_shorts_1_f_euro'
	]
};
if (_type isEqualTo 'b_autoriflemen_1') exitWith {
	[
		'b_soldier_ar_f','b_patrol_soldier_ar_f','b_patrol_heavygunner_f','b_patrol_soldier_mg_f','b_t_soldier_ar_f','b_w_soldier_ar_f'
	]
};
if (_type isEqualTo 'vr_entities_1') exitWith {
	['c_soldier_vr_f','b_soldier_vr_f','o_soldier_vr_f','i_soldier_vr_f','b_protagonist_vr_f','o_protagonist_vr_f','i_protagonist_vr_f']
};
if (_type isEqualTo 'enemy_sniper_types_1') exitWith {
	['o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_t_sniper_f','o_t_ghillie_tna_f']
};
if (_type isEqualTo 'fob_assault_1') exitWith {
	[
		'OG_ReconSentry',2,
		'OG_InfAssaultTeam',2,
		'OG_SniperTeam_M',2,
		'OG_InfTeam',2
	]
};
if (_type isEqualTo 'hidden_enemy_types_1') exitWith {
	// Enemy who dont show on map
	[
		'b_ctrg_soldier_ar_tna_f','b_ctrg_soldier_exp_tna_f','b_ctrg_soldier_jtac_tna_f','b_ctrg_soldier_m_tna_f','b_ctrg_soldier_medic_tna_f','b_ctrg_soldier_lat2_tna_f',
		'b_ctrg_soldier_tna_f','b_ctrg_soldier_lat_tna_f','b_ctrg_soldier_tl_tna_f','b_ctrg_miller_f','b_diver_f','b_diver_exp_f','b_diver_tl_f','b_recon_exp_f','b_recon_jtac_f','b_recon_m_f',
		'b_recon_medic_f','b_recon_f','b_recon_lat_f','b_recon_sharpshooter_f','b_recon_tl_f','b_sniper_f','b_ghillie_ard_f','b_ghillie_lsh_f','b_ghillie_sard_f','b_spotter_f','b_t_diver_f',
		'b_t_diver_exp_f','b_t_diver_tl_f','b_t_recon_exp_f','b_t_recon_jtac_f','b_t_recon_m_f','b_t_recon_medic_f','b_t_recon_f','b_t_recon_lat_f','b_t_recon_tl_f','b_t_sniper_f',
		'b_t_ghillie_tna_f','b_t_spotter_f','i_diver_f','i_diver_exp_f','i_diver_tl_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f','i_spotter_f',
		'o_v_soldier_exp_hex_f','o_v_soldier_jtac_hex_f','o_v_soldier_m_hex_f','o_v_soldier_hex_f','o_v_soldier_medic_hex_f','o_v_soldier_lat_hex_f',
		'o_v_soldier_tl_hex_f','o_v_soldier_exp_ghex_f','o_v_soldier_jtac_ghex_f','o_v_soldier_m_ghex_f','o_v_soldier_ghex_f','o_v_soldier_medic_ghex_f',
		'o_v_soldier_lat_ghex_f','o_v_soldier_tl_ghex_f','o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f',
		'o_recon_lat_f','o_recon_tl_f','o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_spotter_f','o_t_recon_exp_f','o_t_recon_jtac_f',
		'o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f','o_t_sniper_f','o_t_ghillie_tna_f','o_t_spotter_f',
		'o_plane_fighter_02_stealth_f','o_diver_f','o_diver_exp_f','o_diver_tl_f','o_t_diver_f','o_t_diver_exp_f','o_t_diver_tl_f','o_uav_01_f','o_t_uav_04_cas_f',
		'o_uav_02_dynamicloadout_f','o_uav_02_cas_f','i_uav_02_dynamicloadout_f','i_uav_02_cas_f','b_plane_fighter_01_stealth_f','b_uav_05_f','b_t_uav_03_dynamicloadout_f',
		'o_r_soldier_ar_f','o_r_medic_f','o_r_soldier_exp_f','o_r_soldier_gl_f','o_r_jtac_f','o_r_soldier_m_f','o_r_soldier_lat_f','o_r_soldier_tl_f',
		'o_r_recon_ar_f','o_r_recon_exp_f','o_r_recon_gl_f','o_r_recon_jtac_f','o_r_recon_m_f','o_r_recon_medic_f','o_r_recon_lat_f','o_r_recon_tl_f'
	]
};
if (_type isEqualTo 'grid_units_1') exitWith {
	[
		'O_G_Soldier_A_F',0.2,
		'O_G_Soldier_AR_F',0.4,
		'O_G_medic_F',0.2,
		'O_G_engineer_F',0.2,
		'O_G_Soldier_exp_F',0.2,
		'O_G_Soldier_GL_F',0.2,
		'O_G_Soldier_M_F',0.2,
		'O_G_Soldier_F',0.2,
		'O_G_Soldier_LAT_F',0.2,
		'O_G_Soldier_lite_F',0.2,
		'O_G_Sharpshooter_F',0.2,
		'O_G_Soldier_TL_F',0.2,
		'I_C_Soldier_Bandit_7_F',0.2,
		'I_C_Soldier_Bandit_3_F',0.4,
		'I_C_Soldier_Bandit_2_F',0.2,
		'I_C_Soldier_Bandit_5_F',0.2,
		'I_C_Soldier_Bandit_6_F',0.2,
		'I_C_Soldier_Bandit_1_F',0.2,
		'I_C_Soldier_Bandit_8_F',0.2,
		'I_C_Soldier_Bandit_4_F',0.2,
		'I_C_Soldier_Para_7_F',0.1,
		'I_C_Soldier_Para_2_F',0.1,
		'I_C_Soldier_Para_3_F',0.1,
		'I_C_Soldier_Para_4_F',0.3,
		'I_C_Soldier_Para_6_F',0.1,
		'I_C_Soldier_Para_8_F',0.1,
		'I_C_Soldier_Para_1_F',0.1,
		'I_C_Soldier_Para_5_F',0.1
	]
};
if (_type isEqualTo 'grid_units_2') exitWith {
	[
		'O_G_Soldier_A_F',1,
		'O_G_Soldier_AR_F',4,
		'O_G_medic_F',1,
		'O_G_engineer_F',1,
		'O_G_Soldier_exp_F',1,
		'O_G_Soldier_GL_F',1,
		'O_G_Soldier_M_F',1,
		'O_G_Soldier_F',1,
		'O_G_Soldier_LAT_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_LAT2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_lite_F',1,
		'O_G_Sharpshooter_F',3,
		'O_G_Soldier_TL_F',1,
		'I_C_Soldier_Bandit_7_F',1,
		'I_C_Soldier_Bandit_3_F',3,
		'I_C_Soldier_Bandit_2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'I_C_Soldier_Bandit_5_F',2,
		'I_C_Soldier_Bandit_6_F',2,
		'I_C_Soldier_Bandit_1_F',2,
		'I_C_Soldier_Bandit_8_F',2,
		'I_C_Soldier_Bandit_4_F',2,
		'I_C_Soldier_Para_7_F',1,
		'I_C_Soldier_Para_2_F',1,
		'I_C_Soldier_Para_3_F',1,
		'I_C_Soldier_Para_4_F',3,
		'I_C_Soldier_Para_6_F',1,
		'I_C_Soldier_Para_8_F',1,
		'I_C_Soldier_Para_1_F',1,
		'I_C_Soldier_Para_5_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4)
	]
};
if (_type isEqualTo 'grid_units_3') exitWith {
	[
		'O_G_Soldier_A_F',1,
		'O_G_Soldier_AR_F',3,
		'O_G_medic_F',1,
		'O_G_engineer_F',1,
		'O_G_Soldier_exp_F',1,
		'O_G_Soldier_GL_F',1,
		'O_G_Soldier_M_F',1,
		'O_G_Soldier_F',1,
		'O_G_Soldier_LAT_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_LAT2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_lite_F',1,
		'O_G_Sharpshooter_F',3,
		'O_G_Soldier_TL_F',1,
		'I_C_Soldier_Bandit_7_F',1,
		'I_C_Soldier_Bandit_3_F',3,
		'I_C_Soldier_Bandit_2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'I_C_Soldier_Bandit_5_F',2,
		'I_C_Soldier_Bandit_6_F',2,
		'I_C_Soldier_Bandit_1_F',2,
		'I_C_Soldier_Bandit_8_F',2,
		'I_C_Soldier_Bandit_4_F',2,
		'I_C_Soldier_Para_7_F',1,
		'I_C_Soldier_Para_2_F',1,
		'I_C_Soldier_Para_3_F',1,
		'I_C_Soldier_Para_4_F',3,
		'I_C_Soldier_Para_6_F',1,
		'I_C_Soldier_Para_8_F',1,
		'I_C_Soldier_Para_1_F',1,
		'I_C_Soldier_Para_5_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4)
	]
};
if (_type isEqualTo 'georgetown_units_1') exitWith {
	[
		"I_C_Soldier_Para_1_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F",
		"I_C_Soldier_Para_4_F","I_C_Soldier_Para_5_F","I_C_Soldier_Para_6_F",
		"I_C_Soldier_Para_7_F","I_C_Soldier_Para_8_F"
	]
};
if (_type isEqualTo 'georgetown_civilians_1') exitWith {
	[
		"C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F",
		"C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F","C_man_p_shorts_1_F",
		"C_man_hunter_1_F","C_man_w_worker_F","C_man_shorts_2_F","C_man_shorts_3_F","C_man_shorts_4_F","C_man_p_beggar_F_afro",
		"C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro",
		"C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro",
		"C_man_shorts_4_F_afro","C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F",
		"C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_shorts_1_F",
		"C_man_hunter_1_F","C_man_p_beggar_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia",
		"C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia","C_man_p_shorts_1_F_asia",
		"C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia","C_man_p_beggar_F_euro","C_man_polo_1_F_euro",
		"C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro",
		"C_man_shorts_1_F_euro","C_man_p_shorts_1_F_euro","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro"
	]
};
if (_type isEqualTo 'georgetown_civilians_2') exitWith {
	[
		"C_Man_casual_1_F_tanoan","C_Man_casual_2_F_tanoan","C_Man_casual_3_F_tanoan","C_Man_casual_4_F_tanoan","C_Man_casual_5_F_tanoan",
		"C_Man_casual_6_F_tanoan","C_man_sport_1_F_tanoan"
	]
};
if (_type isEqualTo 'georgetown_aa_types') exitWith {
	['O_soldier_AA_F']
};
if (_type isEqualTo 'georgetown_sniper_types') exitWith {
	['O_G_Sharpshooter_F','O_Recon_F','O_Recon_M_F','O_Recon_LAT_F']
};
if (_type isEqualTo 'georgetown_at_types') exitWith {
	['O_Soldier_LAT_F']
};
if (_type isEqualTo 'viper_types_2') exitWith {
	[
		'o_v_soldier_tl_hex_f',0.1,
		'o_v_soldier_jtac_hex_f',0.1,
		'o_v_soldier_m_hex_f',0.3,
		'o_v_soldier_exp_hex_f',0.3,
		'o_v_soldier_lat_hex_f',0.3,
		'o_v_soldier_medic_hex_f',0.2,
		'o_v_soldier_hex_f',0.6
	]
};
_return;