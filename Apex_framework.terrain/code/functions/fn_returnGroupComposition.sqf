/*/
File: fn_returnGroupComposition.sqf
Author:

	Quiksilver
	
Last Modified:

	22/07/2019 A3 1.94 by Quiksilver

Description:

	Return Group Composition
___________________________________________________/*/

params ['_side','_type'];
private _return = [];
if (_side isEqualTo EAST) exitWith {
	scopeName 'main';
	if (worldName in ['Tanoa','Enoch']) then {
		if (_type isEqualTo 'OI_reconPatrol') then {_return = [['O_T_recon_TL_F','SERGEANT'],['O_T_recon_M_F','CORPORAL'],['O_T_recon_medic_F','PRIVATE'],['O_T_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_reconSentry') then {_return = [['O_T_recon_M_F','CORPORAL'],['O_T_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_reconTeam') then {_return = [['O_T_recon_TL_F','SERGEANT'],['O_T_recon_M_F','CORPORAL'],['O_T_recon_medic_F','PRIVATE'],['O_T_recon_LAT_F','CORPORAL'],['O_T_recon_JTAC_F','PRIVATE'],['O_T_recon_exp_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_SniperTeam') then {_return = [['O_T_ghillie_tna_F','CORPORAL'],['O_T_spotter_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_SniperTeam_2') then {_return = [['O_T_ghillie_tna_F','CORPORAL'],['O_T_ghillie_tna_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfAssault') then {_return = [['O_T_Soldier_SL_F','SERGEANT'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Engineer_F','PRIVATE'],['O_T_Soldier_M_F','PRIVATE'],['O_T_Soldier_AR_F','CORPORAL'],['O_T_Soldier_LAT_F','PRIVATE'],['O_T_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSentry') then {_return = [['O_T_soldier_GL_F','CORPORAL'],['O_T_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad') then {_return = [['O_T_Soldier_SL_F','SERGEANT'],['O_T_Soldier_F','PRIVATE'],['O_T_Soldier_LAT_F','CORPORAL'],['O_T_Soldier_M_F','PRIVATE'],['O_T_Soldier_AR_F','SERGEANT'],['O_T_Soldier_AR_F','CORPORAL'],['O_T_Engineer_F','PRIVATE'],['O_T_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad_Weapons') then {_return = [['O_T_Soldier_SL_F','SERGEANT'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_GL_F','CORPORAL'],['O_T_Soldier_M_F','SERGEANT'],['O_T_Soldier_AT_F','PRIVATE'],['O_T_Engineer_F','PRIVATE'],['O_T_Soldier_AAT_F','PRIVATE'],['O_T_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad_L') then {_return = [['O_T_Soldier_M_F','SERGEANT'],['O_T_Soldier_M_F','CORPORAL'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_AR_F','PRIVATE'],['O_T_Soldier_M_F','PRIVATE'],['O_T_Soldier_M_F','PRIVATE'],['O_T_Soldier_LAT_F','PRIVATE'],['O_T_Soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_soldier_AR_F','CORPORAL'],['O_T_soldier_GL_F','PRIVATE'],['O_T_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_AA') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_soldier_AA_F','CORPORAL'],['O_T_soldier_AA_F','PRIVATE'],['O_T_soldier_AAA_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_AT') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_soldier_AT_F','CORPORAL'],['O_T_soldier_AT_F','PRIVATE'],['O_T_soldier_AAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_LAT') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_soldier_LAT_F','CORPORAL'],['O_T_soldier_LAT_F','PRIVATE'],['O_T_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_HAT') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_Soldier_HAT_F','CORPORAL'],['O_T_Soldier_HAT_F','PRIVATE'],['O_T_Soldier_HAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_ReconSquad') then {_return = [['O_T_recon_TL_F','SERGEANT'],['O_T_recon_M_F','CORPORAL'],['O_T_recon_medic_F','PRIVATE'],['O_T_recon_F','PRIVATE'],['O_T_recon_LAT_F','PRIVATE'],['O_T_recon_JTAC_F','PRIVATE'],['O_T_recon_exp_F','PRIVATE'],['O_T_recon_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardSentry') then {_return = [['O_soldierU_GL_F','CORPORAL'],['O_soldierU_GL_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardSquad') then {_return = [['O_SoldierU_SL_F','SERGEANT'],['O_soldierU_GL_F','PRIVATE'],['O_SoldierU_LAT_F','CORPORAL'],[(selectRandomWeighted ['O_SoldierU_M_F',0.75,'O_Urban_Sharpshooter_F',0.25]),'PRIVATE'],['O_SoldierU_TL_F','SERGEANT'],[(selectRandomWeighted ['O_SoldierU_AR_F',0.75,'O_Urban_HeavyGunner_F',0.25]),'CORPORAL'],['O_SoldierU_A_F','PRIVATE'],['O_SoldierU_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardTeam') then {_return = [['O_soldierU_TL_F','SERGEANT'],[(selectRandomWeighted ['O_SoldierU_AR_F',0.75,'O_Urban_HeavyGunner_F',0.25]),'CORPORAL'],['O_soldierU_GL_F','PRIVATE'],['O_soldierU_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_ARTeam') then {_return = [['O_T_soldier_AR_F','SERGEANT'],['O_T_soldier_AR_F','CORPORAL'],['O_T_soldier_AR_F','PRIVATE'],['O_T_soldier_AR_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_diverTeam') then {_return = [['O_T_diver_TL_F','SERGEANT'],['O_T_diver_exp_F','CORPORAL'],['O_T_diver_F','PRIVATE'],['O_T_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_diverSentry') then {_return = [['O_T_diver_F','CORPORAL'],['O_T_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'O_T_ViperTeam') then {_return = [['O_V_Soldier_TL_ghex_F','SERGEANT'],['O_V_Soldier_JTAC_ghex_F','CORPORAL'],['O_V_Soldier_M_ghex_F','PRIVATE'],['O_V_Soldier_Exp_ghex_F','PRIVATE'],['O_V_Soldier_LAT_ghex_F','PRIVATE'],['O_V_Soldier_Medic_ghex_F','PRIVATE']];breakTo 'main';};	
		if (_type isEqualTo 'O_T_ViperPatrol') then {_return = [['O_V_Soldier_TL_ghex_F','SERGEANT'],['O_V_Soldier_M_ghex_F','CORPORAL'],['O_V_Soldier_LAT_ghex_F','PRIVATE'],['O_V_Soldier_Medic_ghex_F','PRIVATE']];breakTo 'main';};			
		if (_type isEqualTo 'O_T_ViperSentry') then {_return = [['O_V_Soldier_M_ghex_F','CORPORAL'],['O_V_Soldier_LAT_ghex_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_support_ENG') then {_return = [['O_T_soldier_TL_F','SERGEANT'],['O_T_Engineer_F','CORPORAL'],['O_T_Engineer_F','PRIVATE'],['O_T_Engineer_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfAssault') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_2_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSentry') then {_return = [['I_C_Soldier_Para_1_F','CORPORAL'],['I_C_Soldier_Para_8_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSquad') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_3_F','CORPORAL'],['I_C_Soldier_Para_4_F','PRIVATE'],['I_C_Soldier_Para_4_F','SERGEANT'],['I_C_Soldier_Para_6_F','CORPORAL'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSquad_Weapons') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_6_F','CORPORAL'],['I_C_Soldier_Para_7_F','SERGEANT'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfTeam') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_8_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_7_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfTeam_AT') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_8_F','CORPORAL'],['I_C_Soldier_Para_5_F','PRIVATE'],['I_C_Soldier_Para_7_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_ReconSentry') then {_return = [['I_C_Soldier_Para_1_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_SniperTeam_M') then {_return = [['O_G_Sharpshooter_F','SERGEANT'],['O_G_Sharpshooter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfAssaultTeam') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_2_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
	} else {
		if (_type isEqualTo 'OI_reconPatrol') then {_return = [['O_recon_TL_F','SERGEANT'],['O_recon_M_F','CORPORAL'],['O_recon_medic_F','PRIVATE'],['O_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_reconSentry') then {_return = [['O_recon_M_F','CORPORAL'],['O_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_reconTeam') then {_return = [['O_recon_TL_F','SERGEANT'],['O_recon_M_F','CORPORAL'],['O_recon_medic_F','PRIVATE'],['O_recon_LAT_F','CORPORAL'],['O_recon_JTAC_F','PRIVATE'],['O_recon_exp_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_SniperTeam') then {_return = [[(selectRandom ['O_sniper_F','O_ghillie_ard_F','O_ghillie_sard_F']),'CORPORAL'],['O_spotter_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_SniperTeam_2') then {_return = [[(selectRandom ['O_sniper_F','O_ghillie_ard_F','O_ghillie_sard_F']),'CORPORAL'],[(selectRandom ['O_sniper_F','O_ghillie_ard_F','O_ghillie_sard_F']),'PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfAssault') then {_return = [['O_Soldier_SL_F','SERGEANT'],['O_Soldier_AR_F','PRIVATE'],['O_HeavyGunner_F','CORPORAL'],['O_engineer_F','PRIVATE'],['O_Soldier_M_F','PRIVATE'],['O_Sharpshooter_F','CORPORAL'],['O_Soldier_LAT_F','PRIVATE'],['O_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSentry') then {_return = [['O_soldier_GL_F','CORPORAL'],['O_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad') then {_return = [['O_Soldier_SL_F','SERGEANT'],['O_Soldier_F','PRIVATE'],['O_Soldier_LAT_F','CORPORAL'],['O_Soldier_M_F','PRIVATE'],['O_Soldier_AR_F','SERGEANT'],['O_Soldier_AR_F','CORPORAL'],['O_engineer_F','PRIVATE'],['O_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad_Weapons') then {_return = [['O_Soldier_SL_F','SERGEANT'],['O_Soldier_AR_F','PRIVATE'],['O_Soldier_GL_F','CORPORAL'],['O_Soldier_M_F','SERGEANT'],['O_Soldier_AT_F','PRIVATE'],['O_engineer_F','PRIVATE'],['O_Soldier_AAT_F','PRIVATE'],['O_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfSquad_L') then {_return = [['O_soldier_M_F','SERGEANT'],['O_soldier_M_F','CORPORAL'],['O_Soldier_AR_F','PRIVATE'],['O_Sharpshooter_F','PRIVATE'],['O_HeavyGunner_F','PRIVATE'],['O_Soldier_AR_F','PRIVATE'],['O_HeavyGunner_F','PRIVATE'],['O_Sharpshooter_F','PRIVATE'],['O_Soldier_HAT_F','PRIVATE'],['O_Soldier_HAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_soldier_AR_F','CORPORAL'],['O_soldier_GL_F','PRIVATE'],['O_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_AA') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_soldier_AA_F','CORPORAL'],['O_soldier_AA_F','PRIVATE'],['O_soldier_AAA_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_AT') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_soldier_AT_F','CORPORAL'],['O_soldier_AT_F','PRIVATE'],['O_soldier_AAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_LAT') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_soldier_LAT_F','CORPORAL'],['O_soldier_LAT_F','PRIVATE'],['O_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_InfTeam_HAT') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_Soldier_HAT_F','CORPORAL'],['O_Soldier_HAT_F','PRIVATE'],['O_Soldier_HAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_ReconSquad') then {_return = [['O_recon_TL_F','SERGEANT'],['O_recon_M_F','CORPORAL'],['O_recon_medic_F','PRIVATE'],['O_recon_F','PRIVATE'],['O_recon_LAT_F','PRIVATE'],['O_recon_JTAC_F','PRIVATE'],['O_recon_exp_F','PRIVATE'],['O_Pathfinder_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardSentry') then {_return = [['O_soldierU_GL_F','CORPORAL'],['O_soldierU_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardSquad') then {_return = [['O_SoldierU_SL_F','SERGEANT'],['O_SoldierU_F','PRIVATE'],['O_SoldierU_LAT_F','CORPORAL'],[(selectRandomWeighted ['O_SoldierU_M_F',0.75,'O_Urban_Sharpshooter_F',0.25]),'PRIVATE'],['O_SoldierU_TL_F','SERGEANT'],[(selectRandomWeighted ['O_SoldierU_AR_F',0.75,'O_Urban_HeavyGunner_F',0.25]),'CORPORAL'],['O_SoldierU_A_F','PRIVATE'],['O_SoldierU_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_GuardTeam') then {_return = [['O_soldierU_TL_F','SERGEANT'],[(selectRandomWeighted ['O_SoldierU_AR_F',0.75,'O_Urban_HeavyGunner_F',0.25]),'CORPORAL'],['O_soldierU_GL_F','PRIVATE'],['O_soldierU_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OIA_ARTeam') then {_return = [['O_Soldier_AR_F','SERGEANT'],[(selectRandom ['O_HeavyGunner_F','O_Soldier_AR_F']),'CORPORAL'],['O_Soldier_AR_F','PRIVATE'],['O_Soldier_AR_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_diverTeam') then {_return = [['O_diver_TL_F','SERGEANT'],['O_diver_exp_F','CORPORAL'],['O_diver_F','PRIVATE'],['O_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_diverSentry') then {_return = [['O_diver_F','CORPORAL'],['O_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'O_T_ViperTeam') then {_return = [['O_V_Soldier_TL_hex_F','SERGEANT'],['O_V_Soldier_JTAC_hex_F','CORPORAL'],['O_V_Soldier_M_hex_F','PRIVATE'],['O_V_Soldier_Exp_hex_F','PRIVATE'],['O_V_Soldier_LAT_hex_F','PRIVATE'],['O_V_Soldier_Medic_hex_F','PRIVATE']];breakTo 'main';};	
		if (_type isEqualTo 'O_T_ViperPatrol') then {_return = [['O_V_Soldier_TL_hex_F','SERGEANT'],['O_V_Soldier_M_hex_F','CORPORAL'],['O_V_Soldier_LAT_hex_F','PRIVATE'],['O_V_Soldier_Medic_hex_F','PRIVATE']];breakTo 'main';};			
		if (_type isEqualTo 'O_T_ViperSentry') then {_return = [['O_V_Soldier_M_hex_F','CORPORAL'],['O_V_Soldier_LAT_hex_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OI_support_ENG') then {_return = [['O_soldier_TL_F','SERGEANT'],['O_engineer_F','CORPORAL'],['O_engineer_F','PRIVATE'],['O_engineer_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfAssault') then {_return = [['O_G_Soldier_SL_F','SERGEANT'],['O_G_Sharpshooter_F','CORPORAL'],['O_G_Soldier_AR_F','PRIVATE'],['O_G_Soldier_A_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSentry') then {_return = [['O_G_soldier_GL_F','CORPORAL'],['O_G_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSquad') then {_return = [['O_G_Soldier_SL_F','SERGEANT'],['O_G_Soldier_F','PRIVATE'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'CORPORAL'],['O_G_Soldier_M_F','PRIVATE'],['O_G_Soldier_TL_F','SERGEANT'],['O_G_Soldier_AR_F','CORPORAL'],['O_G_Soldier_A_F','PRIVATE'],['O_G_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfSquad_Weapons') then {_return = [['O_G_Soldier_SL_F','SERGEANT'],['O_G_Soldier_AR_F','PRIVATE'],['O_G_Soldier_GL_F','CORPORAL'],['O_G_Soldier_M_F','SERGEANT'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'PRIVATE'],['O_G_Soldier_A_F','PRIVATE'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'PRIVATE'],['O_G_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfTeam') then {_return = [['O_G_soldier_TL_F','SERGEANT'],['O_G_soldier_AR_F','CORPORAL'],['O_G_soldier_GL_F','PRIVATE'],['O_G_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfTeam_AT') then {_return = [['O_G_soldier_TL_F','SERGEANT'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'CORPORAL'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'PRIVATE'],[(selectRandom ['O_G_Soldier_LAT_F','O_G_Soldier_LAT2_F']),'PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_ReconSentry') then {_return = [['O_G_soldier_M_F','CORPORAL'],['O_G_soldier_M_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'OG_SniperTeam_M') then {_return = [['O_G_Sharpshooter_F','SERGEANT'],['O_G_Sharpshooter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'OG_InfAssaultTeam') then {_return = [['O_G_soldier_TL_F','SERGEANT'],['O_G_soldier_AR_F','CORPORAL'],['O_G_soldier_GL_F','PRIVATE'],['O_G_Soldier_A_F','PRIVATE']];breakTo 'main';};
	};
	if (_type isEqualTo 'O_R_InfSentry') then {_return = [['O_R_Soldier_GL_F','CORPORAL'],['O_R_soldier_M_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'O_R_InfSquad') then {_return = [['O_R_Soldier_TL_F','SERGEANT'],['O_R_Soldier_AR_F','PRIVATE'],['O_R_medic_F','CORPORAL'],['O_R_Soldier_LAT_F','PRIVATE'],['O_R_Soldier_GL_F','SERGEANT'],['O_R_Soldier_AR_F','CORPORAL'],['O_R_Soldier_LAT_F','PRIVATE'],['O_R_soldier_M_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'O_R_InfTeam') then {_return = [['O_R_Soldier_TL_F','SERGEANT'],['O_R_Soldier_AR_F','CORPORAL'],['O_R_soldier_M_F','PRIVATE'],['O_R_Soldier_LAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'O_R_reconSentry') then {_return = [['O_R_recon_GL_F','CORPORAL'],['O_R_recon_M_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'O_R_reconSquad') then {_return = [['O_R_recon_TL_F','SERGEANT'],['O_R_recon_JTAC_F','PRIVATE'],['O_R_recon_medic_F','CORPORAL'],['O_R_recon_exp_F','PRIVATE'],['O_R_recon_GL_F','SERGEANT'],['O_R_recon_AR_F','CORPORAL'],['O_R_recon_M_F','PRIVATE'],['O_R_recon_LAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'O_R_reconTeam') then {_return = [['O_R_recon_TL_F','SERGEANT'],['O_R_recon_M_F','CORPORAL'],['O_R_recon_AR_F','PRIVATE'],['O_R_recon_LAT_F','PRIVATE']];breakTo 'main';};
	_return;
};
if (_side isEqualTo WEST) exitWith {
	scopeName 'main';
	// not 100% configured, still altis units on tanoa
	if (worldName isEqualTo 'Tanoa') then {
		if (_type isEqualTo 'BUS_InfAssault') then {_return = [['B_T_Soldier_SL_F','SERGEANT'],['B_T_Soldier_AR_F','PRIVATE'],['B_HeavyGunner_F','CORPORAL'],['B_T_Soldier_AAR_F','PRIVATE'],['B_T_Soldier_M_F','PRIVATE'],['B_Sharpshooter_F','CORPORAL'],['B_T_Soldier_LAT_F','PRIVATE'],['B_T_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSentry') then {_return = [['B_T_soldier_GL_F','CORPORAL'],['B_T_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSquad') then {_return = [['B_T_Soldier_SL_F','SERGEANT'],['B_T_Soldier_F','PRIVATE'],['B_T_Soldier_LAT_F','CORPORAL'],['B_T_Soldier_M_F','PRIVATE'],['B_T_Soldier_AR_F','SERGEANT'],['B_Soldier_AR_F','CORPORAL'],['B_Soldier_A_F','PRIVATE'],['B_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSquad_Weapons') then {_return = [['B_Soldier_SL_F','SERGEANT'],['B_Soldier_AR_F','PRIVATE'],['B_Soldier_GL_F','CORPORAL'],['B_Soldier_M_F','SERGEANT'],['B_Soldier_AT_F','PRIVATE'],['B_Soldier_A_F','PRIVATE'],['B_Soldier_AAT_F','PRIVATE'],['B_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AR_F','CORPORAL'],['B_soldier_GL_F','PRIVATE'],['B_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam_AA') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AA_F','CORPORAL'],['B_soldier_AA_F','PRIVATE'],['B_soldier_AAA_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam_AT') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AT_F','CORPORAL'],['B_soldier_AT_F','PRIVATE'],['B_soldier_AAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconPatrol') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconSentry') then {_return = [['B_recon_M_F','CORPORAL'],['B_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconSquad') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_F','PRIVATE'],['B_recon_LAT_F','PRIVATE'],['B_recon_JTAC_F','PRIVATE'],['B_recon_exp_F','PRIVATE'],['B_Recon_Sharpshooter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconTeam') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_LAT_F','CORPORAL'],['B_recon_JTAC_F','PRIVATE'],['B_recon_exp_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_SniperTeam') then {_return = [['B_sniper_F','SERGEANT'],['B_spotter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'BUS_DiverTeam') then {_return = [['B_diver_TL_F','SERGEANT'],['B_diver_exp_F','CORPORAL'],['B_diver_F','PRIVATE'],['B_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_DiverSentry') then {_return = [['B_diver_F','CORPORAL'],['B_diver_F','PRIVATE']];breakTo 'main';};	
		if (_type isEqualTo 'BUS_ARTeam') then {_return = [['B_T_soldier_AR_F','SERGEANT'],['B_T_soldier_AR_F','CORPORAL'],['B_T_soldier_AR_F','PRIVATE'],['B_T_soldier_AR_F','PRIVATE']];breakTo 'main';};
	} else {
		if (_type isEqualTo 'BUS_InfAssault') then {_return = [['B_Soldier_SL_F','SERGEANT'],['B_Soldier_AR_F','PRIVATE'],['B_HeavyGunner_F','CORPORAL'],['B_Soldier_AAR_F','PRIVATE'],['B_Soldier_M_F','PRIVATE'],['B_Sharpshooter_F','CORPORAL'],['B_Soldier_LAT_F','PRIVATE'],['B_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSentry') then {_return = [['B_soldier_GL_F','CORPORAL'],['B_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSquad') then {_return = [['B_Soldier_SL_F','SERGEANT'],['B_Soldier_F','PRIVATE'],['B_Soldier_LAT_F','CORPORAL'],['B_Soldier_M_F','PRIVATE'],['B_Soldier_AR_F','SERGEANT'],['B_Soldier_AR_F','CORPORAL'],['B_Soldier_A_F','PRIVATE'],['B_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfSquad_Weapons') then {_return = [['B_Soldier_SL_F','SERGEANT'],['B_Soldier_AR_F','PRIVATE'],['B_Soldier_GL_F','CORPORAL'],['B_Soldier_M_F','SERGEANT'],['B_Soldier_AT_F','PRIVATE'],['B_Soldier_A_F','PRIVATE'],['B_Soldier_AAT_F','PRIVATE'],['B_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AR_F','CORPORAL'],['B_soldier_GL_F','PRIVATE'],['B_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam_AA') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AA_F','CORPORAL'],['B_soldier_AA_F','PRIVATE'],['B_soldier_AAA_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_InfTeam_AT') then {_return = [['B_soldier_TL_F','SERGEANT'],['B_soldier_AT_F','CORPORAL'],['B_soldier_AT_F','PRIVATE'],['B_soldier_AAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconPatrol') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconSentry') then {_return = [['B_recon_M_F','CORPORAL'],['B_recon_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconSquad') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_F','PRIVATE'],['B_recon_LAT_F','PRIVATE'],['B_recon_JTAC_F','PRIVATE'],['B_recon_exp_F','PRIVATE'],['B_Recon_Sharpshooter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ReconTeam') then {_return = [['B_recon_TL_F','SERGEANT'],['B_recon_M_F','CORPORAL'],['B_recon_medic_F','PRIVATE'],['B_recon_LAT_F','CORPORAL'],['B_recon_JTAC_F','PRIVATE'],['B_recon_exp_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_SniperTeam') then {_return = [['B_sniper_F','SERGEANT'],['B_spotter_F','CORPORAL']];breakTo 'main';};
		if (_type isEqualTo 'BUS_DiverTeam') then {_return = [['B_diver_TL_F','SERGEANT'],['B_diver_exp_F','CORPORAL'],['B_diver_F','PRIVATE'],['B_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_DiverSentry') then {_return = [['B_diver_F','CORPORAL'],['B_diver_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'BUS_ARTeam') then {_return = [['B_soldier_AR_F','SERGEANT'],['B_soldier_AR_F','CORPORAL'],['B_soldier_AR_F','PRIVATE'],['B_soldier_AR_F','PRIVATE']];breakTo 'main';};
	};
	if (_type isEqualTo 'IRG_InfAssault') then {_return = [['B_G_Soldier_SL_F','SERGEANT'],['B_G_Sharpshooter_F','CORPORAL'],['B_G_Soldier_AR_F','PRIVATE'],['B_G_Soldier_A_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_InfSentry') then {_return = [['B_G_soldier_GL_F','CORPORAL'],['B_G_soldier_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_InfSquad') then {_return = [['B_G_Soldier_SL_F','SERGEANT'],['B_G_Soldier_F','PRIVATE'],['B_G_Soldier_LAT_F','CORPORAL'],['B_G_Soldier_M_F','PRIVATE'],['B_G_Soldier_TL_F','SERGEANT'],['B_G_Soldier_AR_F','CORPORAL'],['B_G_Soldier_A_F','PRIVATE'],['B_G_medic_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_InfSquad_Weapons') then {_return = [['B_G_Soldier_SL_F','SERGEANT'],['B_G_Soldier_AR_F','PRIVATE'],['B_G_Soldier_GL_F','CORPORAL'],['B_G_Soldier_M_F','SERGEANT'],['B_G_Soldier_LAT_F','PRIVATE'],['B_G_Soldier_A_F','PRIVATE'],['B_G_Soldier_LAT_F','PRIVATE'],['B_G_medic_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_InfTeam') then {_return = [['B_G_soldier_TL_F','SERGEANT'],['B_G_soldier_AR_F','CORPORAL'],['B_G_soldier_GL_F','PRIVATE'],['B_G_soldier_LAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_InfTeam_AT') then {_return = [['B_G_soldier_TL_F','SERGEANT'],['B_G_soldier_LAT_F','CORPORAL'],['B_G_soldier_LAT_F','PRIVATE'],['B_G_soldier_LAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_ReconSentry') then {_return = [['B_G_soldier_M_F','CORPORAL'],['B_G_soldier_M_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'IRG_SniperTeam_M') then {_return = [['B_G_Sharpshooter_F','SERGEANT'],['B_G_Sharpshooter_F','CORPORAL']];breakTo 'main';};
	if (_type isEqualTo 'IRG_ARTeam') then {_return = [['B_G_soldier_AR_F','SERGEANT'],['B_G_soldier_AR_F','CORPORAL'],['B_G_soldier_AR_F','PRIVATE'],['B_G_soldier_AR_F','PRIVATE']];breakTo 'main';};
	_return;
};
if (_side isEqualTo RESISTANCE) exitWith {
	scopeName 'main';
	if (_type isEqualTo 'HAF_InfSentry') then {_return = [['I_soldier_GL_F','CORPORAL'],['I_soldier_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_InfSquad') then {_return = [['I_Soldier_SL_F','SERGEANT'],['I_Soldier_F','PRIVATE'],[(selectRandom ['I_Soldier_LAT_F','I_Soldier_LAT2_F']),'CORPORAL'],['I_Soldier_M_F','PRIVATE'],['I_Soldier_AR_F','SERGEANT'],['I_Soldier_AR_F','CORPORAL'],['I_Soldier_A_F','PRIVATE'],['I_medic_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_InfSquad_Weapons') then {_return = [['I_Soldier_SL_F','SERGEANT'],['I_Soldier_AR_F','PRIVATE'],['I_Soldier_GL_F','CORPORAL'],['I_Soldier_M_F','SERGEANT'],['I_Soldier_AT_F','PRIVATE'],['I_Soldier_A_F','PRIVATE'],['I_Soldier_AAT_F','PRIVATE'],['I_medic_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_InfTeam') then {_return = [['I_soldier_TL_F','SERGEANT'],['I_soldier_AR_F','CORPORAL'],['I_soldier_GL_F','PRIVATE'],[(selectRandom ['I_Soldier_LAT_F','I_Soldier_LAT2_F']),'PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_InfTeam_AA') then {_return = [['I_soldier_TL_F','SERGEANT'],['I_soldier_AA_F','CORPORAL'],['I_soldier_AA_F','PRIVATE'],['I_soldier_AAA_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_InfTeam_AT') then {_return = [['I_soldier_TL_F','SERGEANT'],['I_soldier_AT_F','CORPORAL'],['I_soldier_AT_F','PRIVATE'],['I_soldier_AAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_ARTeam') then {_return = [['I_soldier_AR_F','SERGEANT'],['I_soldier_AR_F','CORPORAL'],['I_soldier_AR_F','PRIVATE'],['I_soldier_AR_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_SniperTeam') then {_return = [['I_sniper_F','SERGEANT'],['I_spotter_F','CORPORAL']];breakTo 'main';};
	if (_type isEqualTo 'HAF_DiverTeam') then {_return = [['I_diver_TL_F','SERGEANT'],['I_diver_exp_F','CORPORAL'],['I_diver_F','PRIVATE'],['I_diver_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_DiverSentry') then {_return = [['I_diver_F','CORPORAL'],['I_diver_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'HAF_support_ENG') then {_return = [['I_soldier_TL_F','SERGEANT'],['I_engineer_F','CORPORAL'],['I_engineer_F','PRIVATE'],['I_engineer_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'I_E_InfSentry') then {_return = [['I_E_Soldier_GL_F','CORPORAL'],['I_E_Soldier_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'I_E_InfSquad') then {_return = [['I_E_Soldier_SL_F','SERGEANT'],['I_E_Soldier_AR_F','PRIVATE'],['I_E_Soldier_LAT_F','CORPORAL'],['I_E_soldier_M_F','PRIVATE'],['I_E_Soldier_TL_F','SERGEANT'],['I_E_Soldier_AR_F','CORPORAL'],['I_E_Soldier_AR_F','PRIVATE'],['I_E_Medic_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'I_E_InfTeam') then {_return = [['I_E_Soldier_TL_F','SERGEANT'],['I_E_Soldier_AR_F','CORPORAL'],['I_E_Soldier_GL_F','PRIVATE'],['I_E_Soldier_LAT_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'I_L_CriminalGang') then {_return = [['I_L_Looter_Pistol_F','SERGEANT'],['I_L_Looter_SG_F','PRIVATE'],['I_L_Looter_Rifle_F','CORPORAL'],['I_L_Looter_SMG_F','PRIVATE'],['I_L_Criminal_SG_F','SERGEANT'],['I_L_Criminal_SMG_F','CORPORAL']];breakTo 'main';};
	if (_type isEqualTo 'I_L_CriminalSentry') then {_return = [['I_L_Looter_SG_F','SERGEANT'],['I_L_Looter_Rifle_F','PRIVATE']];breakTo 'main';};
	if (_type isEqualTo 'I_L_LooterGang') then {_return = [['I_L_Looter_Pistol_F','SERGEANT'],['I_L_Looter_SG_F','PRIVATE'],['I_L_Looter_Rifle_F','CORPORAL']];breakTo 'main';};
	if (worldName isEqualTo 'Tanoa') then {
		if (_type isEqualTo 'IG_InfAssault') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_2_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSentry') then {_return = [['I_C_Soldier_Para_1_F','CORPORAL'],['I_C_Soldier_Para_8_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSquad') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_3_F','CORPORAL'],['I_C_Soldier_Para_4_F','PRIVATE'],['I_C_Soldier_Para_4_F','SERGEANT'],['I_C_Soldier_Para_6_F','CORPORAL'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSquad_Weapons') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_6_F','CORPORAL'],['I_C_Soldier_Para_7_F','SERGEANT'],['I_C_Soldier_Para_7_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE'],['I_C_Soldier_Para_2_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfTeam') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_4_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE'],['I_C_Soldier_Para_7_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfTeam_AT') then {_return = [['I_C_Soldier_Para_1_F','SERGEANT'],['I_C_Soldier_Para_8_F','CORPORAL'],['I_C_Soldier_Para_5_F','PRIVATE'],['I_C_Soldier_Para_7_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_ReconSentry') then {_return = [['I_C_Soldier_Para_1_F','CORPORAL'],['I_C_Soldier_Para_3_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_ARTeam') then {_return = [['I_C_Soldier_Para_4_F','SERGEANT'],['I_C_Soldier_Para_4_F','CORPORAL'],['I_C_Soldier_Para_4_F','PRIVATE'],['I_C_Soldier_Para_4_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_SniperTeam_M') then {_return = [['O_G_Sharpshooter_F','SERGEANT'],['O_G_Sharpshooter_F','CORPORAL']];breakTo 'main';};
	} else {
		if (_type isEqualTo 'IG_InfAssault') then {_return = [['I_G_Soldier_SL_F','SERGEANT'],['I_G_Sharpshooter_F','CORPORAL'],['I_G_Soldier_AR_F','PRIVATE'],['I_G_Soldier_A_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSentry') then {_return = [['I_G_soldier_GL_F','CORPORAL'],['I_G_soldier_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSquad') then {_return = [['I_G_Soldier_SL_F','SERGEANT'],['I_G_Soldier_F','PRIVATE'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'CORPORAL'],['I_G_Soldier_M_F','PRIVATE'],['I_G_Soldier_TL_F','SERGEANT'],['I_G_Soldier_AR_F','CORPORAL'],['I_G_Soldier_A_F','PRIVATE'],['I_G_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfSquad_Weapons') then {_return = [['I_G_Soldier_SL_F','SERGEANT'],['I_G_Soldier_AR_F','PRIVATE'],['I_G_Soldier_GL_F','CORPORAL'],['I_G_Soldier_M_F','SERGEANT'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'PRIVATE'],['I_G_Soldier_A_F','PRIVATE'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'PRIVATE'],['I_G_medic_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfTeam') then {_return = [['I_G_soldier_TL_F','SERGEANT'],['I_G_soldier_AR_F','CORPORAL'],['I_G_soldier_GL_F','PRIVATE'],['I_G_soldier_LAT_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_InfTeam_AT') then {_return = [['I_G_soldier_TL_F','SERGEANT'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'CORPORAL'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'PRIVATE'],[(selectRandom ['I_G_Soldier_LAT_F','I_G_Soldier_LAT2_F']),'PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_ReconSentry') then {_return = [['I_G_soldier_M_F','CORPORAL'],['I_G_soldier_M_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_ARTeam') then {_return = [['I_G_soldier_AR_F','SERGEANT'],['I_G_soldier_AR_F','CORPORAL'],['I_G_soldier_AR_F','PRIVATE'],['I_G_soldier_AR_F','PRIVATE']];breakTo 'main';};
		if (_type isEqualTo 'IG_SniperTeam_M') then {_return = [['I_G_Sharpshooter_F','SERGEANT'],['I_G_Sharpshooter_F','CORPORAL']];breakTo 'main';};
	};
	_return;
};