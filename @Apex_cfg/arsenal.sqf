/*/
File: arsenal.sqf
Author:

	Quiksilver
	
Last Modified:

	15/10/2020 A3 2.00 by Quiksilver
	
Description:

	Arsenal Whitelisting & Blacklisting for each player role/class
	
Format of this script:

	1. Sort player into Roles from classname
	2. Sort game assets (weapons/backpacks/magazines/items) into basic categories (you can add/modify/etc).
	3. Configure a blacklist and a whitelist for each Role, using the categories created in #2, using the provided format.

Documentation File:

	'documentation\Arsenal & Gear Restrictions.txt'
	
Notes:

	- It could take several hours to configure this script to your liking.
	- Hard-coded gear blacklists are inside 'code\functions\fn_clientArsenal.sqf', but that file requires mission update to edit while this file only requires server restart to take effect.
	- You do not need to update the mission file to edit this script, it can be done between restarts.
_______________________________________________________/*/
//=========================================== GET PLAYER ROLE
params [
	['_side',WEST],
	['_role','rifleman']
];
//=========================================== At this point you could build up lists of weapons like 'normalguns + marksmanguns + sniperguns + LMGguns + HMGguns' and use those variables instead of the default copy-paste used below.
// These variables are just suggestions, you would add them together like this:   (_weaponsBasic + _weaponsMarksman + _weaponsHandgun)
// All weapons including pistols, launchers, binoculars (yes they are classified as a weapon).
_weaponsAll = [
	'','arifle_MX_ACO_F','arifle_MX_ACO_pointer_F','arifle_MX_ACO_pointer_snds_F','arifle_MX_Black_ACO_FL_F','arifle_MX_Black_ACO_Pointer_F','arifle_MX_Black_ACO_Pointer_Snds_F','arifle_MX_Black_F','arifle_MX_Black_FL_EMP_F','arifle_MX_Black_Hamr_pointer_F','arifle_MX_Black_Hamr_Pointer_Snds_F','arifle_MX_Black_Holo_Pointer_F','arifle_MX_Black_Pointer_EMP_F','arifle_MX_Black_Pointer_F','arifle_MX_Black_RCO_FL_F','arifle_MX_Black_RCO_Pointer_EMP_F','arifle_MX_F','arifle_MX_Hamr_pointer_F','arifle_MX_Holo_pointer_F','arifle_MX_khk_ACO_Pointer_F','arifle_MX_khk_ACO_Pointer_Snds_F','arifle_MX_khk_F','arifle_MX_khk_Hamr_Pointer_F','arifle_MX_khk_Hamr_Pointer_Snds_F','arifle_MX_khk_Holo_Pointer_F','arifle_MX_khk_Pointer_F','arifle_MX_pointer_F','arifle_MX_RCO_pointer_snds_F','arifle_SPAR_01_blk_ACO_Pointer_F','arifle_SPAR_01_blk_ERCO_Pointer_F','arifle_SPAR_01_blk_F','arifle_SPAR_01_khk_F','arifle_SPAR_01_snd_F','B_Patrol_Soldier_Specialist_weapon_F','srifle_EBR_ACO_F','srifle_EBR_ARCO_pointer_F','srifle_EBR_ARCO_pointer_snds_F','srifle_EBR_DMS_F','srifle_EBR_DMS_pointer_snds_F','srifle_EBR_F','srifle_EBR_Hamr_pointer_F','srifle_EBR_MRCO_LP_BI_F','srifle_EBR_MRCO_pointer_F','srifle_EBR_SOS_F','arifle_MX_GL_ACO_F','arifle_MX_GL_ACO_pointer_F','arifle_MX_GL_Black_F','arifle_MX_GL_Black_Hamr_pointer_F','arifle_MX_GL_Black_RCO_Pointer_EMP_F','arifle_MX_GL_F','arifle_MX_GL_Hamr_pointer_F','arifle_MX_GL_Holo_pointer_snds_F','arifle_MX_GL_khk_ACO_F','arifle_MX_GL_khk_F','arifle_MX_GL_khk_Hamr_Pointer_F','arifle_MX_GL_khk_Holo_Pointer_Snds_F','arifle_SPAR_01_GL_blk_ACO_Pointer_F','arifle_SPAR_01_GL_blk_ERCO_Pointer_F','arifle_SPAR_01_GL_blk_F','arifle_SPAR_01_GL_khk_F','arifle_SPAR_01_GL_snd_F','arifle_MXM_Black_F','arifle_MXM_Black_MOS_Pointer_Bipod_EMP_F','arifle_MXM_Black_MOS_Pointer_Bipod_F','arifle_MXM_Black_MOS_Pointer_Bipod_Snds_F','arifle_MXM_DMS_F','arifle_MXM_DMS_LP_BI_snds_F','arifle_MXM_F','arifle_MXM_Hamr_LP_BI_F','arifle_MXM_Hamr_pointer_F','arifle_MXM_khk_F','arifle_MXM_khk_MOS_Pointer_Bipod_F','arifle_MXM_khk_MOS_Pointer_Bipod_Snds_F','arifle_MXM_RCO_pointer_snds_F','arifle_MXM_SOS_pointer_F','arifle_SPAR_03_blk_F','arifle_SPAR_03_blk_MOS_Pointer_Bipod_F','arifle_SPAR_03_khk_F','arifle_SPAR_03_snd_F','srifle_DMR_03_ACO_F','srifle_DMR_03_AMS_F','srifle_DMR_03_ARCO_F','srifle_DMR_03_DMS_F','srifle_DMR_03_DMS_snds_F','srifle_DMR_03_F','srifle_DMR_03_khaki_F','srifle_DMR_03_MRCO_F','srifle_DMR_03_multicam_F','srifle_DMR_03_SOS_F','srifle_DMR_03_tan_AMS_LP_F','srifle_DMR_03_tan_F','srifle_DMR_03_woodland_F','srifle_DMR_02_ACO_F','srifle_DMR_02_ARCO_F','srifle_DMR_02_camo_AMS_LP_F','srifle_DMR_02_camo_F','srifle_DMR_02_DMS_F','srifle_DMR_02_F','srifle_DMR_02_MRCO_F','srifle_DMR_02_sniper_AMS_LP_S_F','srifle_DMR_02_sniper_F','srifle_DMR_02_SOS_F','arifle_MX_SW_Black_F','arifle_MX_SW_Black_Hamr_pointer_F','arifle_MX_SW_Black_Pointer_EMP_F','arifle_MX_SW_Black_Pointer_F','arifle_MX_SW_F','arifle_MX_SW_Hamr_pointer_F','arifle_MX_SW_khk_F','arifle_MX_SW_khk_Pointer_F','arifle_MX_SW_pointer_F','arifle_SPAR_02_blk_ERCO_Pointer_F','arifle_SPAR_02_blk_F','arifle_SPAR_02_blk_Pointer_F','arifle_SPAR_02_khk_F','arifle_SPAR_02_snd_F','B_Patrol_Soldier_Autorifleman_weapon_F','B_Patrol_Soldier_HeavyGunner_weapon_F','B_Patrol_Soldier_MachineGunner_weapon_F','MMG_02_camo_F','MMG_02_black_F','MMG_02_sand_F','MMG_02_sand_RCO_LP_F','MMG_02_black_RCO_BI_F','arifle_mxc_f','arifle_mxc_black_f','arifle_mxc_khk_f','arifle_spar_01_blk_f','arifle_spar_01_khk_f','arifle_spar_01_snd_f','hgun_PDW2000_F','hgun_PDW2000_Holo_F','hgun_PDW2000_Holo_snds_F','hgun_PDW2000_snds_F','SMG_01_ACO_F','SMG_01_F','SMG_01_Holo_F','SMG_01_Holo_pointer_snds_F','SMG_05_F','B_Patrol_Soldier_Pistol_F','hgun_ACPC2_F','hgun_ACPC2_snds_F','hgun_P07_blk_F','hgun_P07_blk_Snds_F','hgun_P07_F','hgun_P07_khk_F','hgun_P07_khk_Snds_F','hgun_P07_snds_F','hgun_Pistol_01_F','hgun_Pistol_heavy_01_F','hgun_Pistol_heavy_01_green_F','hgun_Pistol_heavy_01_green_snds_F','hgun_Pistol_heavy_01_MRD_F','hgun_Pistol_heavy_01_snds_F','hgun_Pistol_heavy_02_F','hgun_Pistol_heavy_02_Yorris_F','hgun_Rook40_F','hgun_Rook40_snds_F','arifle_sdar_f','sgun_HunterShotgun_01_F','sgun_HunterShotgun_01_sawedoff_F'	
];
_OweaponsAll = [
    '','arifle_AK12_arid_F','arifle_AK12_F','arifle_AK12_lush_arco_pointer_F','arifle_AK12_lush_arco_snds_pointer_bipod_F','arifle_AK12_lush_arco_snds_pointer_F','arifle_AK12_lush_F','arifle_AK12_lush_snds_pointer_F','arifle_AK12U_arid_F','arifle_AK12U_F','arifle_AK12U_lush_F','arifle_AK12U_lush_holo_F','arifle_AK12U_lush_holo_fl_F','arifle_AK12U_lush_holo_pointer_F','arifle_AK12U_lush_holo_snds_pointer_F','arifle_AK12U_lush_snds_pointer_F','arifle_AKM_F','arifle_AKM_FL_F','arifle_AKS_F','arifle_ARX_blk_F','arifle_ARX_ghex_ACO_Pointer_Snds_F','arifle_ARX_ghex_ARCO_Pointer_Snds_F','arifle_ARX_ghex_DMS_Pointer_Snds_Bipod_F','arifle_ARX_ghex_F','arifle_ARX_hex_ACO_Pointer_Snds_F','arifle_ARX_hex_ARCO_Pointer_Snds_F','arifle_ARX_hex_DMS_Pointer_Snds_Bipod_F','arifle_ARX_hex_F','arifle_ARX_Viper_F','arifle_ARX_Viper_hex_F','arifle_CTAR_blk_ACO_F','arifle_CTAR_blk_aco_flash_F','arifle_CTAR_blk_ACO_Pointer_F','arifle_CTAR_blk_ACO_Pointer_Snds_F','arifle_CTAR_blk_ARCO_F','arifle_CTAR_blk_arco_flash_F','arifle_CTAR_blk_ARCO_Pointer_F','arifle_CTAR_blk_ARCO_Pointer_Snds_F','arifle_CTAR_blk_F','arifle_CTAR_blk_flash_F','arifle_CTAR_blk_Pointer_F','arifle_CTAR_ghex_F','arifle_CTAR_hex_F','arifle_Katiba_ACO_F','arifle_Katiba_ACO_pointer_F','arifle_Katiba_ACO_pointer_snds_F','arifle_Katiba_ARCO_F','arifle_Katiba_ARCO_pointer_F','arifle_Katiba_ARCO_pointer_snds_F','arifle_Katiba_C_ACO_F','arifle_Katiba_C_ACO_pointer_F','arifle_Katiba_C_ACO_pointer_snds_F','arifle_Katiba_C_F','arifle_Katiba_F','arifle_Katiba_pointer_F','arifle_Mk20_ACO_F','arifle_Mk20_ACO_pointer_F','arifle_Mk20_F','arifle_Mk20_Holo_F','arifle_Mk20_MRCO_F','arifle_Mk20_MRCO_plain_F','arifle_Mk20_MRCO_pointer_F','arifle_Mk20_plain_F','arifle_Mk20_pointer_F','arifle_Mk20C_ACO_F','arifle_Mk20C_ACO_pointer_F','arifle_Mk20C_F','arifle_Mk20C_plain_F','arifle_RPK12_arid_F','arifle_RPK12_F','arifle_RPK12_lush_arco_pointer_F','arifle_RPK12_lush_arco_snds_pointer_F','arifle_RPK12_lush_F','arifle_RPK12_lush_holo_snds_pointer_F','arifle_TRG20_ACO_F','arifle_TRG20_ACO_Flash_F','arifle_TRG20_ACO_pointer_F','arifle_TRG20_F','arifle_TRG20_Holo_F','arifle_TRG21_ACO_pointer_F','arifle_TRG21_ARCO_pointer_F','arifle_TRG21_F','arifle_TRG21_MRCO_F','arifle_AK12_GL_arid_F','arifle_AK12_GL_F','arifle_AK12_GL_lush_arco_pointer_F','arifle_AK12_GL_lush_arco_snds_pointer_F','arifle_AK12_GL_lush_F','arifle_AK12_GL_lush_holo_pointer_F','arifle_AK12_GL_lush_holo_snds_pointer_F','arifle_CTAR_GL_blk_ACO_F','arifle_CTAR_GL_blk_ACO_Pointer_Snds_F','arifle_CTAR_GL_blk_ARCO_Pointer_F','arifle_CTAR_GL_blk_F','arifle_CTAR_GL_ghex_F','arifle_CTAR_GL_hex_F','arifle_Katiba_GL_ACO_F','arifle_Katiba_GL_ACO_pointer_F','arifle_Katiba_GL_ACO_pointer_snds_F','arifle_Katiba_GL_ARCO_pointer_F','arifle_Katiba_GL_F','arifle_Katiba_GL_Nstalker_pointer_F','arifle_Mk20_GL_ACO_F','arifle_Mk20_GL_F','arifle_Mk20_GL_MRCO_pointer_F','arifle_Mk20_GL_plain_F','arifle_MSBS65_GL_black_F','arifle_MSBS65_GL_black_ico_F','arifle_MSBS65_GL_black_ico_FL_EMP_f','arifle_MSBS65_GL_black_ico_pointer_EMP_f','arifle_MSBS65_GL_black_ico_pointer_f','arifle_MSBS65_GL_camo_F','arifle_MSBS65_GL_F','arifle_MSBS65_GL_ico_F','arifle_MSBS65_GL_ico_FL_EMP_f','arifle_MSBS65_GL_ico_pointer_EMP_f','arifle_MSBS65_GL_ico_pointer_f','arifle_MSBS65_GL_sand_F','arifle_TRG21_GL_ACO_pointer_F','arifle_TRG21_GL_F','arifle_TRG21_GL_MRCO_F','srifle_DMR_06_camo_F','srifle_DMR_06_camo_khs_F','srifle_DMR_06_hunter_F','srifle_DMR_06_hunter_khs_F','srifle_DMR_06_olive_F','srifle_DMR_07_blk_DMS_F','srifle_DMR_07_blk_DMS_Snds_F','srifle_DMR_07_blk_F','srifle_DMR_07_blk_F_arco_flash_F','srifle_DMR_07_ghex_F','srifle_DMR_07_hex_F','srifle_DMR_04_ACO_F','srifle_DMR_04_ARCO_F','srifle_DMR_04_DMS_F','srifle_DMR_04_DMS_weathered_Kir_F_F','srifle_DMR_04_F','srifle_DMR_04_MRCO_F','srifle_DMR_04_NS_LP_F','srifle_DMR_04_SOS_F','srifle_DMR_04_Tan_F','srifle_DMR_05_ACO_F','srifle_DMR_05_ARCO_F','srifle_DMR_05_blk_F','srifle_DMR_05_DMS_F','srifle_DMR_05_DMS_snds_F','srifle_DMR_05_hex_F','srifle_DMR_05_KHS_LP_F','srifle_DMR_05_MRCO_F','srifle_DMR_05_SOS_F','srifle_DMR_05_tan_f','srifle_GM6_camo_F','srifle_GM6_camo_LRPS_F','srifle_GM6_camo_SOS_F','srifle_GM6_F','srifle_GM6_ghex_F','srifle_GM6_ghex_LRPS_F','srifle_GM6_LRPS_F','srifle_GM6_SOS_F','arifle_CTARS_blk_F','arifle_CTARS_blk_flash_F','arifle_CTARS_blk_Pointer_F','arifle_CTARS_ghex_F','arifle_CTARS_hex_F','LMG_03_F','LMG_Mk200_BI_F','LMG_Mk200_black_ACO_pointer_F','LMG_Mk200_black_BI_F','LMG_Mk200_black_F','LMG_Mk200_black_FL_EMP_F','LMG_Mk200_black_LP_BI_F','LMG_Mk200_F','LMG_Mk200_LP_BI_F','LMG_Mk200_MRCO_F','LMG_Mk200_pointer_F','LMG_Zafir_ARCO_F','LMG_Zafir_F','LMG_Zafir_pointer_F','MMG_01_hex_F','MMG_01_tan_F','MMG_01_hex_ARCO_LP_F','SMG_02_ACO_F','SMG_02_ARCO_pointg_F','SMG_02_F','SMG_02_flash_F','SMG_03_black','SMG_03_camo','SMG_03_hex','SMG_03_khaki','SMG_03_TR_black','SMG_03_TR_camo','SMG_03_TR_hex','SMG_03_TR_khaki','SMG_03C_black','SMG_03C_camo','SMG_03C_hex','SMG_03C_khaki','SMG_03C_TR_black','SMG_03C_TR_camo','SMG_03C_TR_hex','SMG_03C_TR_khaki','B_Patrol_Soldier_Pistol_F','hgun_ACPC2_F','hgun_ACPC2_snds_F','hgun_P07_blk_F','hgun_P07_blk_Snds_F','hgun_P07_F','hgun_P07_khk_F','hgun_P07_khk_Snds_F','hgun_P07_snds_F','hgun_Pistol_01_F','hgun_Pistol_heavy_01_F','hgun_Pistol_heavy_01_green_F','hgun_Pistol_heavy_01_green_snds_F','hgun_Pistol_heavy_01_MRD_F','hgun_Pistol_heavy_01_snds_F','hgun_Pistol_heavy_02_F','hgun_Pistol_heavy_02_Yorris_F','hgun_Rook40_F','hgun_Rook40_snds_F','arifle_sdar_f','sgun_HunterShotgun_01_F','sgun_HunterShotgun_01_sawedoff_F'
];
_weaponsShutGun = [
    '','sgun_HunterShotgun_01_F','sgun_HunterShotgun_01_sawedoff_F'
];	
// General infantry rifles + marksman rifles
_weaponsBasic = [
	'','arifle_MX_ACO_F','arifle_MX_ACO_pointer_F','arifle_MX_ACO_pointer_snds_F','arifle_MX_Black_ACO_FL_F','arifle_MX_Black_ACO_Pointer_F','arifle_MX_Black_ACO_Pointer_Snds_F','arifle_MX_Black_F','arifle_MX_Black_FL_EMP_F','arifle_MX_Black_Hamr_pointer_F','arifle_MX_Black_Hamr_Pointer_Snds_F','arifle_MX_Black_Holo_Pointer_F','arifle_MX_Black_Pointer_EMP_F','arifle_MX_Black_Pointer_F','arifle_MX_Black_RCO_FL_F','arifle_MX_Black_RCO_Pointer_EMP_F','arifle_MX_F','arifle_MX_Hamr_pointer_F','arifle_MX_Holo_pointer_F','arifle_MX_khk_ACO_Pointer_F','arifle_MX_khk_ACO_Pointer_Snds_F','arifle_MX_khk_F','arifle_MX_khk_Hamr_Pointer_F','arifle_MX_khk_Hamr_Pointer_Snds_F','arifle_MX_khk_Holo_Pointer_F','arifle_MX_khk_Pointer_F','arifle_MX_pointer_F','arifle_MX_RCO_pointer_snds_F','arifle_SPAR_01_blk_ACO_Pointer_F','arifle_SPAR_01_blk_ERCO_Pointer_F','arifle_SPAR_01_blk_F','arifle_SPAR_01_khk_F','arifle_SPAR_01_snd_F','B_Patrol_Soldier_Specialist_weapon_F','srifle_EBR_ACO_F','srifle_EBR_ARCO_pointer_F','srifle_EBR_ARCO_pointer_snds_F','srifle_EBR_DMS_F','srifle_EBR_DMS_pointer_snds_F','srifle_EBR_F','srifle_EBR_Hamr_pointer_F','srifle_EBR_MRCO_LP_BI_F','srifle_EBR_MRCO_pointer_F','srifle_EBR_SOS_F'
];
_OweaponsBasic = [
	'','arifle_AK12_arid_F','arifle_AK12_F','arifle_AK12_lush_arco_pointer_F','arifle_AK12_lush_arco_snds_pointer_bipod_F','arifle_AK12_lush_arco_snds_pointer_F','arifle_AK12_lush_F','arifle_AK12_lush_snds_pointer_F','arifle_AK12U_arid_F','arifle_AK12U_F','arifle_AK12U_lush_F','arifle_AK12U_lush_holo_F','arifle_AK12U_lush_holo_fl_F','arifle_AK12U_lush_holo_pointer_F','arifle_AK12U_lush_holo_snds_pointer_F','arifle_AK12U_lush_snds_pointer_F','arifle_AKM_F','arifle_AKM_FL_F','arifle_AKS_F','arifle_ARX_blk_F','arifle_ARX_ghex_ACO_Pointer_Snds_F','arifle_ARX_ghex_ARCO_Pointer_Snds_F','arifle_ARX_ghex_DMS_Pointer_Snds_Bipod_F','arifle_ARX_ghex_F','arifle_ARX_hex_ACO_Pointer_Snds_F','arifle_ARX_hex_ARCO_Pointer_Snds_F','arifle_ARX_hex_DMS_Pointer_Snds_Bipod_F','arifle_ARX_hex_F','arifle_ARX_Viper_F','arifle_ARX_Viper_hex_F','arifle_CTAR_blk_ACO_F','arifle_CTAR_blk_aco_flash_F','arifle_CTAR_blk_ACO_Pointer_F','arifle_CTAR_blk_ACO_Pointer_Snds_F','arifle_CTAR_blk_ARCO_F','arifle_CTAR_blk_arco_flash_F','arifle_CTAR_blk_ARCO_Pointer_F','arifle_CTAR_blk_ARCO_Pointer_Snds_F','arifle_CTAR_blk_F','arifle_CTAR_blk_flash_F','arifle_CTAR_blk_Pointer_F','arifle_CTAR_ghex_F','arifle_CTAR_hex_F','arifle_Katiba_ACO_F','arifle_Katiba_ACO_pointer_F','arifle_Katiba_ACO_pointer_snds_F','arifle_Katiba_ARCO_F','arifle_Katiba_ARCO_pointer_F','arifle_Katiba_ARCO_pointer_snds_F','arifle_Katiba_C_ACO_F','arifle_Katiba_C_ACO_pointer_F','arifle_Katiba_C_ACO_pointer_snds_F','arifle_Katiba_C_F','arifle_Katiba_F','arifle_Katiba_pointer_F','arifle_Mk20_ACO_F','arifle_Mk20_ACO_pointer_F','arifle_Mk20_F','arifle_Mk20_Holo_F','arifle_Mk20_MRCO_F','arifle_Mk20_MRCO_plain_F','arifle_Mk20_MRCO_pointer_F','arifle_Mk20_plain_F','arifle_Mk20_pointer_F','arifle_Mk20C_ACO_F','arifle_Mk20C_ACO_pointer_F','arifle_Mk20C_F','arifle_Mk20C_plain_F','arifle_RPK12_arid_F','arifle_RPK12_F','arifle_RPK12_lush_arco_pointer_F','arifle_RPK12_lush_arco_snds_pointer_F','arifle_RPK12_lush_F','arifle_RPK12_lush_holo_snds_pointer_F','arifle_TRG20_ACO_F','arifle_TRG20_ACO_Flash_F','arifle_TRG20_ACO_pointer_F','arifle_TRG20_F','arifle_TRG20_Holo_F','arifle_TRG21_ACO_pointer_F','arifle_TRG21_ARCO_pointer_F','arifle_TRG21_F','arifle_TRG21_MRCO_F'
];
// GL Weapons
_weaponsGL = [
	'','arifle_MX_GL_ACO_F','arifle_MX_GL_ACO_pointer_F','arifle_MX_GL_Black_F','arifle_MX_GL_Black_Hamr_pointer_F','arifle_MX_GL_Black_RCO_Pointer_EMP_F','arifle_MX_GL_F','arifle_MX_GL_Hamr_pointer_F','arifle_MX_GL_Holo_pointer_snds_F','arifle_MX_GL_khk_ACO_F','arifle_MX_GL_khk_F','arifle_MX_GL_khk_Hamr_Pointer_F','arifle_MX_GL_khk_Holo_Pointer_Snds_F','arifle_SPAR_01_GL_blk_ACO_Pointer_F','arifle_SPAR_01_GL_blk_ERCO_Pointer_F','arifle_SPAR_01_GL_blk_F','arifle_SPAR_01_GL_khk_F','arifle_SPAR_01_GL_snd_F'
];
// O GL Weapons
_OweaponsGL = [
	'','arifle_AK12_GL_arid_F','arifle_AK12_GL_F','arifle_AK12_GL_lush_arco_pointer_F','arifle_AK12_GL_lush_arco_snds_pointer_F','arifle_AK12_GL_lush_F','arifle_AK12_GL_lush_holo_pointer_F','arifle_AK12_GL_lush_holo_snds_pointer_F','arifle_CTAR_GL_blk_ACO_F','arifle_CTAR_GL_blk_ACO_Pointer_Snds_F','arifle_CTAR_GL_blk_ARCO_Pointer_F','arifle_CTAR_GL_blk_F','arifle_CTAR_GL_ghex_F','arifle_CTAR_GL_hex_F','arifle_Katiba_GL_ACO_F','arifle_Katiba_GL_ACO_pointer_F','arifle_Katiba_GL_ACO_pointer_snds_F','arifle_Katiba_GL_ARCO_pointer_F','arifle_Katiba_GL_F','arifle_Katiba_GL_Nstalker_pointer_F','arifle_Mk20_GL_ACO_F','arifle_Mk20_GL_F','arifle_Mk20_GL_MRCO_pointer_F','arifle_Mk20_GL_plain_F','arifle_MSBS65_GL_black_F','arifle_MSBS65_GL_black_ico_F','arifle_MSBS65_GL_black_ico_FL_EMP_f','arifle_MSBS65_GL_black_ico_pointer_EMP_f','arifle_MSBS65_GL_black_ico_pointer_f','arifle_MSBS65_GL_camo_F','arifle_MSBS65_GL_F','arifle_MSBS65_GL_ico_F','arifle_MSBS65_GL_ico_FL_EMP_f','arifle_MSBS65_GL_ico_pointer_EMP_f','arifle_MSBS65_GL_ico_pointer_f','arifle_MSBS65_GL_sand_F','arifle_TRG21_GL_ACO_pointer_F','arifle_TRG21_GL_F','arifle_TRG21_GL_MRCO_F'
];
// marksman rifles
_weaponsMarksman = [
	'','arifle_MXM_Black_F','arifle_MXM_Black_MOS_Pointer_Bipod_EMP_F','arifle_MXM_Black_MOS_Pointer_Bipod_F','arifle_MXM_Black_MOS_Pointer_Bipod_Snds_F','arifle_MXM_DMS_F','arifle_MXM_DMS_LP_BI_snds_F','arifle_MXM_F','arifle_MXM_Hamr_LP_BI_F','arifle_MXM_Hamr_pointer_F','arifle_MXM_khk_F','arifle_MXM_khk_MOS_Pointer_Bipod_F','arifle_MXM_khk_MOS_Pointer_Bipod_Snds_F','arifle_MXM_RCO_pointer_snds_F','arifle_MXM_SOS_pointer_F','arifle_SPAR_03_blk_F','arifle_SPAR_03_blk_MOS_Pointer_Bipod_F','arifle_SPAR_03_khk_F','arifle_SPAR_03_snd_F','srifle_DMR_03_ACO_F','srifle_DMR_03_AMS_F','srifle_DMR_03_ARCO_F','srifle_DMR_03_DMS_F','srifle_DMR_03_DMS_snds_F','srifle_DMR_03_F','srifle_DMR_03_khaki_F','srifle_DMR_03_MRCO_F','srifle_DMR_03_multicam_F','srifle_DMR_03_SOS_F','srifle_DMR_03_tan_AMS_LP_F','srifle_DMR_03_tan_F','srifle_DMR_03_woodland_F'
];
// O marksman rifles
_OweaponsMarksman = [
	'','srifle_DMR_06_camo_F','srifle_DMR_06_camo_khs_F','srifle_DMR_06_hunter_F','srifle_DMR_06_hunter_khs_F','srifle_DMR_06_olive_F','srifle_DMR_07_blk_DMS_F','srifle_DMR_07_blk_DMS_Snds_F','srifle_DMR_07_blk_F','srifle_DMR_07_blk_F_arco_flash_F','srifle_DMR_07_ghex_F','srifle_DMR_07_hex_F'
];
// heavy marksman rifles
_weaponsMarksmanHeavy = [
	'','srifle_DMR_02_ACO_F','srifle_DMR_02_ARCO_F','srifle_DMR_02_camo_AMS_LP_F','srifle_DMR_02_camo_F','srifle_DMR_02_DMS_F','srifle_DMR_02_F','srifle_DMR_02_MRCO_F','srifle_DMR_02_sniper_AMS_LP_S_F','srifle_DMR_02_sniper_F','srifle_DMR_02_SOS_F'
];
// O heavy marksman rifles
_OweaponsMarksmanHeavy = [
	'','srifle_DMR_04_ACO_F','srifle_DMR_04_ARCO_F','srifle_DMR_04_DMS_F','srifle_DMR_04_DMS_weathered_Kir_F_F','srifle_DMR_04_F','srifle_DMR_04_MRCO_F','srifle_DMR_04_NS_LP_F','srifle_DMR_04_SOS_F','srifle_DMR_04_Tan_F','srifle_DMR_05_ACO_F','srifle_DMR_05_ARCO_F','srifle_DMR_05_blk_F','srifle_DMR_05_DMS_F','srifle_DMR_05_DMS_snds_F','srifle_DMR_05_hex_F','srifle_DMR_05_KHS_LP_F','srifle_DMR_05_MRCO_F','srifle_DMR_05_SOS_F','srifle_DMR_05_tan_f'
];
// Sniper rifles
_weaponsSniper = [	
    '','srifle_LRR_camo_F','srifle_LRR_camo_LRPS_F','srifle_LRR_camo_SOS_F','srifle_LRR_F','srifle_LRR_LRPS_F','srifle_LRR_SOS_F','srifle_LRR_tna_F','srifle_LRR_tna_LRPS_F'
];
// O Sniper rifles
_OweaponsSniper = [	
    '','srifle_GM6_camo_F','srifle_GM6_camo_LRPS_F','srifle_GM6_camo_SOS_F','srifle_GM6_F','srifle_GM6_ghex_F','srifle_GM6_ghex_LRPS_F','srifle_GM6_LRPS_F','srifle_GM6_SOS_F'
];
// high-capacity variants of rifles (drum magazines, variants with 100 round mags,etc)
_weaponsSW = [
	'arifle_ctars_blk_f','arifle_ctars_ghex_f','arifle_ctars_hex_f'
];
_weaponsHMG = [
	'arifle_ctars_blk_f','arifle_ctars_ghex_f','arifle_ctars_hex_f'
];
// light machine guns
_weaponsLMG = [
	'','arifle_MX_SW_Black_F','arifle_MX_SW_Black_Hamr_pointer_F','arifle_MX_SW_Black_Pointer_EMP_F','arifle_MX_SW_Black_Pointer_F','arifle_MX_SW_F','arifle_MX_SW_Hamr_pointer_F','arifle_MX_SW_khk_F','arifle_MX_SW_khk_Pointer_F','arifle_MX_SW_pointer_F','arifle_SPAR_02_blk_ERCO_Pointer_F','arifle_SPAR_02_blk_F','arifle_SPAR_02_blk_Pointer_F','arifle_SPAR_02_khk_F','arifle_SPAR_02_snd_F','B_Patrol_Soldier_Autorifleman_weapon_F','B_Patrol_Soldier_HeavyGunner_weapon_F','B_Patrol_Soldier_MachineGunner_weapon_F'
];
// O light machine guns
_OweaponsLMG = [
	'','arifle_CTARS_blk_F','arifle_CTARS_blk_flash_F','arifle_CTARS_blk_Pointer_F','arifle_CTARS_ghex_F','arifle_CTARS_hex_F','LMG_03_F','LMG_Mk200_BI_F','LMG_Mk200_black_ACO_pointer_F','LMG_Mk200_black_BI_F','LMG_Mk200_black_F','LMG_Mk200_black_FL_EMP_F','LMG_Mk200_black_LP_BI_F','LMG_Mk200_F','LMG_Mk200_LP_BI_F','LMG_Mk200_MRCO_F','LMG_Mk200_pointer_F','LMG_Zafir_ARCO_F','LMG_Zafir_F','LMG_Zafir_pointer_F'
];
// medium machine guns
_weaponsMMG = [
	'','MMG_02_camo_F','MMG_02_black_F','MMG_02_sand_F','MMG_02_sand_RCO_LP_F','MMG_02_black_RCO_BI_F'
];
// O medium machine guns
_OweaponsMMG = [
	'','MMG_01_hex_F','MMG_01_tan_F','MMG_01_hex_ARCO_LP_F'
];
// compact weapons
_weaponsCompact = [
	'','arifle_mxc_f','arifle_mxc_black_f','arifle_mxc_khk_f','arifle_spar_01_blk_f','arifle_spar_01_khk_f','arifle_spar_01_snd_f'
];
// pistols / handguns
_weaponsHandgun = [
	'','B_Patrol_Soldier_Pistol_F','hgun_ACPC2_F','hgun_ACPC2_snds_F','hgun_P07_blk_F','hgun_P07_blk_Snds_F','hgun_P07_F','hgun_P07_khk_F','hgun_P07_khk_Snds_F','hgun_P07_snds_F','hgun_Pistol_01_F','hgun_Pistol_heavy_01_F','hgun_Pistol_heavy_01_green_F','hgun_Pistol_heavy_01_green_snds_F','hgun_Pistol_heavy_01_MRD_F','hgun_Pistol_heavy_01_snds_F','hgun_Pistol_heavy_02_F','hgun_Pistol_heavy_02_Yorris_F','hgun_Rook40_F','hgun_Rook40_snds_F'
];
// submachine guns
_weaponsSMG = [
	'','hgun_PDW2000_F','hgun_PDW2000_Holo_F','hgun_PDW2000_Holo_snds_F','hgun_PDW2000_snds_F','SMG_01_ACO_F','SMG_01_F','SMG_01_Holo_F','SMG_01_Holo_pointer_snds_F','SMG_05_F'
];
// O submachine guns
_OweaponsSMG = [
	'','SMG_02_ACO_F','SMG_02_ARCO_pointg_F','SMG_02_F','SMG_02_flash_F','SMG_03_black','SMG_03_camo','SMG_03_hex','SMG_03_khaki','SMG_03_TR_black','SMG_03_TR_camo','SMG_03_TR_hex','SMG_03_TR_khaki','SMG_03C_black','SMG_03C_camo','SMG_03C_hex','SMG_03C_khaki','SMG_03C_TR_black','SMG_03C_TR_camo','SMG_03C_TR_hex','SMG_03C_TR_khaki'
];
// underwater weapons
_weaponsUW = [
	'arifle_sdar_f'
];
// all launchers
_weaponsLauncherAll = [
	'launch_nlaw_f','launch_rpg32_f','launch_rpg32_ghex_f','launch_rpg7_f','launch_i_titan_f','launch_o_titan_ghex_f','launch_o_titan_f','launch_b_titan_f','launch_b_titan_tna_f',
	'launch_o_titan_short_f','launch_o_titan_short_ghex_f','launch_i_titan_short_f','launch_b_titan_short_tna_f','launch_b_titan_short_f',
	'launch_o_vorona_brown_f','launch_o_vorona_green_f','launch_mraws_green_rail_f','launch_mraws_olive_rail_f','launch_mraws_sand_rail_f','launch_mraws_green_f','launch_mraws_olive_f','launch_mraws_sand_f',
	'launch_rpg32_green_f','launch_i_titan_eaf_f','launch_b_titan_olive_f'
];
// basic launchers (rpg)
_weaponsLauncherBasic = [
	'launch_rpg7_f'
];
// regular launchers 
_weaponsLauncherRegular = [
	'launch_NLAW_F'
];
// light AT
_weaponsLauncherLAT = [
	'','launch_MRAWS_green_broken_F','launch_MRAWS_green_F','launch_MRAWS_green_rail_F','launch_MRAWS_olive_F','launch_MRAWS_olive_rail_F','launch_MRAWS_sand_F','launch_MRAWS_sand_rail_F','launch_NLAW_F','launch_RPG7_F'
];
// heavy AT
_weaponsLauncherHAT = [
	'','launch_B_Titan_F','launch_B_Titan_olive_F','launch_B_Titan_short_F','launch_B_Titan_short_tna_F','launch_B_Titan_tna_F','launch_Titan_F','launch_Titan_short_F'

];
// O light AT
_OweaponsLauncherLAT = [
	'','launch_O_Vorona_brown_F','launch_O_Vorona_green_F','launch_RPG32_camo_F','launch_RPG32_F','launch_RPG32_ghex_F','launch_RPG32_green_F','launch_RPG7_F'
];
// O heavy AT
_OweaponsLauncherHAT = [
	'','launch_O_Titan_F','launch_O_Titan_ghex_F','launch_O_Titan_short_F','launch_O_Titan_short_ghex_F','launch_I_Titan_eaf_F','launch_I_Titan_F','launch_I_Titan_short_F'
];
// binoculars, rangefinders, designators
_viewersAll = [
	'binocular','laserdesignator_02_ghex_f','laserdesignator_02','laserdesignator_01_khk_f','laserdesignator_03','laserdesignator','rangefinder'
];
// Binoculars and rangefinders (no lasers)
_viewersBasic = [
	'binocular'
];
// rangefinders (no lasers)
_viewersRange = [
	'rangefinder'
];
// Laser designators
_viewersLaser = [
	'laserdesignator_02_ghex_f','laserdesignator_02','laserdesignator_01_khk_f','laserdesignator_03','laserdesignator'
];
// all uniforms
_uniformsAll = [
	'','u_i_c_soldier_bandit_4_f','u_i_c_soldier_bandit_1_f','u_i_c_soldier_bandit_2_f','u_i_c_soldier_bandit_5_f','u_i_c_soldier_bandit_3_f','u_c_man_casual_2_f',
	'u_c_man_casual_3_f','u_c_man_casual_1_f','u_b_combatuniform_mcam','u_b_combatuniform_mcam_tshirt','u_i_g_resistanceleader_f','u_b_t_soldier_f','u_b_t_soldier_ar_f',
	'u_i_combatuniform','u_i_officeruniform','u_i_combatuniform_shortsleeve','u_c_poloshirt_blue','u_c_poloshirt_burgundy','u_c_poloshirt_redwhite','u_c_poloshirt_salmon',
	'u_c_poloshirt_stripped','u_c_poloshirt_tricolour','u_competitor','u_c_constructioncoverall_black_f','u_c_constructioncoverall_blue_f','u_c_constructioncoverall_red_f',
	'u_c_constructioncoverall_vrana_f','u_b_ctrg_1','u_b_ctrg_3','u_b_ctrg_2','u_b_ctrg_soldier_f','u_b_ctrg_soldier_3_f','u_b_ctrg_soldier_2_f','u_b_ctrg_soldier_urb_1_f',
	'u_b_ctrg_soldier_urb_3_f','u_b_ctrg_soldier_urb_2_f','u_b_fullghillie_ard','u_b_t_fullghillie_tna_f','u_b_fullghillie_lsh','u_b_fullghillie_sard','u_b_gen_commander_f',
	'u_b_gen_soldier_f','u_b_t_sniper_f','u_b_ghilliesuit','u_bg_guerrilla_6_1','u_bg_guerilla1_1','u_bg_guerilla1_2_f','u_bg_guerilla2_2','u_bg_guerilla2_1','u_bg_guerilla2_3',
	'u_bg_guerilla3_1','u_bg_leader','u_b_helipilotcoveralls','u_i_helipilotcoveralls','u_c_hunterbody_grn','u_i_ghilliesuit','u_o_ghilliesuit','u_c_journalist','u_marshal',
	'u_c_mechanic_01_f','u_c_paramedic_01_f','u_i_c_soldier_para_2_f','u_i_c_soldier_para_3_f','u_i_c_soldier_para_5_f','u_i_c_soldier_para_4_f','u_i_c_soldier_para_1_f','u_i_pilotcoveralls',
	'u_b_pilotcoveralls','u_rangemaster','u_b_combatuniform_mcam_vest','u_b_t_soldier_sl_f','u_c_man_casual_6_f','u_c_man_casual_4_f','u_c_man_casual_5_f','u_b_survival_uniform',
	'u_i_c_soldier_camo_f','u_b_wetsuit','u_i_wetsuit','u_c_workercoveralls','u_c_poor_1','u_i_g_story_protagonist_f','u_b_combatuniform_mcam_worn',
	'u_tank_green_f','u_c_cbrn_suit_01_blue_f','u_b_cbrn_suit_01_mtp_f','u_b_cbrn_suit_01_tropic_f','u_c_cbrn_suit_01_white_f','u_b_cbrn_suit_01_wdl_f','u_i_cbrn_suit_01_aaf_f',
	'u_i_e_cbrn_suit_01_eaf_f','u_i_e_uniform_01_officer_f','u_i_e_uniform_01_shortsleeve_f','u_i_e_uniform_01_tanktop_f','u_b_combatuniform_mcam_wdl_f','u_b_combatuniform_tshirt_mcam_wdl_f',
	'u_i_e_uniform_01_f','u_c_uniform_farmer_01_f','u_o_r_gorka_01_f','u_o_r_gorka_01_brown_f','u_o_r_gorka_01_camo_f','u_i_e_uniform_01_coveralls_f','u_i_l_uniform_01_camo_f','u_i_l_uniform_01_deserter_f',
	'u_c_e_looterjacket_01_f','u_i_l_uniform_01_tshirt_black_f','u_i_l_uniform_01_tshirt_olive_f','u_i_l_uniform_01_tshirt_skull_f','u_i_l_uniform_01_tshirt_sport_f','u_c_uniform_scientist_01_formal_f',
	'u_c_uniform_scientist_01_f','u_c_uniform_scientist_02_f','u_c_uniform_scientist_02_formal_f','u_o_r_gorka_01_black_f','u_b_ctrg_soldier_arid_f','u_b_ctrg_soldier_3_arid_f','u_b_ctrg_soldier_2_arid_f'
];
// basic uniforms
_uniformsBasic = [
    '','u_b_combatuniform_mcam','u_b_combatuniform_mcam_tshirt','u_b_t_soldier_f','u_b_t_soldier_ar_f','u_b_wetsuit'
];
// sniper uniforms
_uniformsSniper = [
	'','u_b_t_sniper_f','u_b_ghilliesuit','u_b_fullghillie_ard','u_b_t_fullghillie_tna_f','u_b_fullghillie_lsh','u_b_fullghillie_sard'
];
// pilot uniforms
_uniformsPilot = [
	'','u_b_pilotcoveralls'
];
_uniformsHeliPilot = [
	'','u_b_helipilotcoveralls'
];
// O pilot uniforms
_OuniformsPilot = [
	'','U_O_PilotCoveralls'
];
_OuniformsHeliPilot = [
	'','U_I_HeliPilotCoveralls'
];
// all helmets, except for thermal stuff
_headgearAll = [
	'','h_bandanna_gry','h_bandanna_blu','h_bandanna_cbr','h_bandanna_khk_hs','h_bandanna_khk','h_bandanna_mcamo','h_bandanna_sgg','h_bandanna_sand',
	'h_bandanna_surfer','h_bandanna_surfer_blk','h_bandanna_surfer_grn','h_bandanna_camo','h_pasgt_basic_black_f','h_pasgt_basic_blue_f','h_pasgt_basic_olive_f',
	'h_pasgt_basic_white_f','h_watchcap_blk','h_watchcap_cbr','h_watchcap_camo','h_watchcap_khk','h_beret_blk','h_beret_gen_f','h_beret_02','h_beret_colonel',
	'h_booniehat_khk_hs','h_booniehat_khk','h_booniehat_mcamo','h_booniehat_oli','h_booniehat_tan','h_booniehat_tna_f','h_booniehat_dgtl','h_cap_grn_bi','h_cap_blk',
	'h_cap_black_idap_f','h_cap_blu','h_cap_blk_cmmg','h_cap_grn','h_cap_blk_ion','h_cap_oli','h_cap_oli_hs','h_cap_orange_idap_f','h_cap_police','h_cap_press','h_cap_red',
	'h_cap_surfer','h_cap_tan','h_cap_khaki_specops_uk','h_cap_usblack','h_cap_tan_specops_us','h_cap_white_idap_f','h_cap_blk_raven','h_cap_brn_specops','h_helmetb','h_helmetb_black',
	'h_helmetb_camo','h_helmetb_desert','h_helmetb_grass','h_helmetb_sand','h_helmetb_snakeskin','h_helmetb_tna_f','h_helmetcrew_i','h_helmetcrew_b','h_earprotectors_black_f',
	'h_earprotectors_orange_f','h_earprotectors_red_f','h_earprotectors_white_f','h_earprotectors_yellow_f','h_helmetspecb','h_helmetspecb_blk','h_helmetspecb_paint2','h_helmetspecb_paint1',
	'h_helmetspecb_sand','h_helmetspecb_snakeskin','h_helmetb_enh_tna_f','h_construction_basic_black_f','h_construction_earprot_black_f','h_construction_headset_black_f','h_construction_basic_orange_f',
	'h_construction_earprot_orange_f','h_construction_headset_orange_f','h_construction_basic_red_f','h_construction_earprot_red_f','h_construction_headset_red_f','h_construction_basic_vrana_f',
	'h_construction_earprot_vrana_f','h_construction_headset_vrana_f','h_construction_basic_white_f','h_construction_earprot_white_f','h_construction_headset_white_f','h_construction_basic_yellow_f',
	'h_construction_earprot_yellow_f','h_construction_headset_yellow_f','h_hat_blue','h_hat_brown','h_hat_camo','h_hat_checker','h_hat_grey','h_hat_tan','h_headbandage_clean_f','h_headbandage_stained_f',
	'h_headbandage_bloody_f','h_headset_black_f','h_headset_orange_f','h_headset_red_f','h_headset_white_f','h_headset_yellow_f',
	'h_pilothelmetheli_b','h_helmetb_light','h_helmetb_light_black','h_helmetb_light_desert','h_helmetb_light_grass','h_helmetb_light_sand','h_helmetb_light_snakeskin','h_helmetb_light_tna_f',
	'h_cap_marshal','h_milcap_blue','h_milcap_gen_f','h_milcap_gry','h_milcap_mcamo','h_milcap_tna_f','h_milcap_dgtl','h_helmetia','h_pasgt_basic_blue_press_f',
	'h_pasgt_neckprot_blue_press_f','h_cap_headphones','h_hat_safari_olive_f','h_hat_safari_sand_f','h_shemag_olive','h_shemag_olive_hs','h_shemagopen_tan','h_shemagopen_khk','h_helmet_skate',
	'h_helmetb_ti_tna_f','h_strawhat','h_strawhat_dark','h_wirelessearpiece_f',
	'h_tank_black_f','h_helmethbk_headset_f','h_helmethbk_chops_f','h_helmethbk_ear_f','h_helmethbk_f','h_helmetaggressor_f','h_helmetaggressor_cover_f','h_helmetaggressor_cover_taiga_f',
	'h_beret_eaf_01_f','h_booniehat_mgrn','h_booniehat_taiga','h_booniehat_wdl','h_booniehat_eaf','h_helmetb_plain_wdl','h_tank_eaf_f','h_helmetcrew_i_e','h_helmetspecb_wdl',
	'h_helmetb_light_wdl','h_milcap_grn','h_milcap_taiga','h_milcap_wdl','h_milcap_eaf','h_hat_tinfoil_f','h_helmetb_ti_arid_f'
];
_headgearBasic = [
    '','H_HelmetSpecB','h_helmetspecb_blk','h_helmetspecb_paint2','h_helmetspecb_paint1','h_helmetspecb_sand','h_helmetspecb_snakeskin','h_helmetb_enh_tna_f','h_helmetspecb_snakeskin','H_HelmetspecB_wdl',
	'h_helmethbk_headset_f','h_helmethbk_chops_f','h_helmethbk_ear_f','h_helmethbk_f',
	'h_helmetb','h_helmetb_black','h_helmetb_camo','h_helmetb_desert','h_helmetb_grass','h_helmetb_sand','h_helmetb_snakeskin','h_helmetb_tna_f',
	'h_helmetb_light','h_helmetb_light_black','h_helmetb_light_desert','h_helmetb_light_grass','h_helmetb_light_sand','h_helmetb_light_snakeskin','h_helmetb_light_tna_f'
];
_headgearMortar = [
    '','h_helmetcrew_b'
];
_headgearJtac = [
    '','h_booniehat_khk_hs','h_booniehat_khk','h_booniehat_mcamo','h_booniehat_oli','h_booniehat_tan','h_booniehat_tna_f','h_watchcap_blk','h_watchcap_cbr','h_watchcap_camo','h_watchcap_khk'
];
_headgearSniper = [
    '','h_cap_headphones'
];
_headgearCommander = [
    '','h_milcap_grn','h_milcap_taiga','h_milcap_wdl','h_milcap_mcamo','h_milcap_tna_f'
];
_headgearCrew = [
    '','h_helmetcrew_b','h_beret_blk'
];
_headgearHeli = [
    '','H_CrewHelmetHeli_B','H_PilotHelmetHeli_B'
];
_OheadgearHeli = [
   '','H_CrewHelmetHeli_I','H_CrewHelmetHeli_I_E','H_CrewHelmetHeli_O','H_PilotHelmetHeli_I','H_PilotHelmetHeli_I_E','H_PilotHelmetHeli_O'
];
_headgearPilot = [
    '','H_PilotHelmetFighter_B'
];
_OheadgearPilot = [
   '','H_PilotHelmetFighter_I','H_PilotHelmetFighter_I_E','H_PilotHelmetFighter_O'
];
// thermal helmets
_headgearThermal = [
	'h_helmeto_vipersp_ghex_f','h_helmeto_vipersp_hex_f'
];
// all vests
_vestsAll = [
	'','v_platecarrier2_rgr_noflag_f','v_platecarriergl_blk','v_platecarriergl_rgr','v_platecarriergl_mtp','v_platecarriergl_tna_f','v_platecarrier1_blk','v_platecarrier1_rgr',
	'v_platecarrier1_rgr_noflag_f','v_platecarrier1_tna_f','v_platecarrier2_blk','v_platecarrier2_rgr','v_platecarrier2_tna_f','v_platecarrierspec_blk','v_platecarrierspec_rgr',
	'v_platecarrierspec_mtp','v_platecarrierspec_tna_f','v_chestrig_blk','v_chestrig_rgr','v_chestrig_khk','v_chestrig_oli','v_platecarrierl_ctrg','v_platecarrierh_ctrg',
	'v_deckcrew_blue_f','v_deckcrew_brown_f','v_deckcrew_green_f','v_deckcrew_red_f','v_deckcrew_violet_f','v_deckcrew_white_f','v_deckcrew_yellow_f','v_eod_blue_f',
	'v_eod_coyote_f','v_eod_olive_f','v_platecarrieriagl_dgtl','v_platecarrieriagl_oli','v_platecarrieria1_dgtl','v_platecarrieria2_dgtl','v_tacvest_gen_f','v_plain_crystal_f',
	'v_harnessogl_brn','v_harnessogl_ghex_f','v_harnessogl_gry','v_harnesso_brn','v_harnesso_ghex_f','v_harnesso_gry','v_legstrapbag_black_f','v_legstrapbag_coyote_f','v_legstrapbag_olive_f',
	'v_pocketed_black_f','v_pocketed_coyote_f','v_pocketed_olive_f','v_rangemaster_belt','v_tacvestir_blk','v_rebreatherb','v_safety_blue_f','v_safety_orange_f','v_safety_yellow_f',
	'v_bandollierb_blk','v_bandollierb_cbr','v_bandollierb_ghex_f','v_bandollierb_rgr','v_bandollierb_khk','v_bandollierb_oli','v_tacchestrig_cbr_f','v_tacchestrig_grn_f','v_tacchestrig_oli_f',
	'v_tacvest_blk','v_tacvest_brn','v_tacvest_camo','v_tacvest_khk','v_tacvest_oli','v_tacvest_blk_police','v_i_g_resistanceleader_f','v_platecarrier_kerry','v_press_f',
	'v_carrierrigkbt_01_eaf_f','v_platecarriergl_wdl','v_platecarrier1_wdl','v_platecarrier2_wdl','v_platecarrierspec_wdl','v_smershvest_01_f','v_smershvest_01_radio_f','v_carrierrigkbt_01_heavy_eaf_f',
	'v_carrierrigkbt_01_heavy_olive_f','v_carrierrigkbt_01_light_eaf_f','v_carrierrigkbt_01_light_olive_f','v_carrierrigkbt_01_eaf_f','v_carrierrigkbt_01_olive_f'
];
_vestsBasic = [
	'','v_platecarrier2_rgr_noflag_f','v_platecarriergl_blk','v_platecarriergl_rgr','v_platecarriergl_mtp','v_platecarriergl_tna_f','v_platecarrier1_blk','v_platecarrier1_rgr',
	'v_platecarrier1_rgr_noflag_f','v_platecarrier1_tna_f','v_platecarrier2_blk','v_platecarrier2_rgr','v_platecarrier2_tna_f','v_platecarrierspec_blk','v_platecarrierspec_rgr',
	'v_platecarrierspec_mtp','v_platecarrierspec_tna_f','v_chestrig_blk','v_chestrig_rgr','v_chestrig_khk','v_chestrig_oli',
	'v_platecarrieriagl_dgtl','v_platecarrieriagl_oli','v_platecarrieria1_dgtl','v_platecarrieria2_dgtl',
	'v_harnessogl_brn','v_harnessogl_ghex_f','v_harnessogl_gry','v_harnesso_brn','v_harnesso_ghex_f','v_harnesso_gry','v_legstrapbag_black_f','v_legstrapbag_coyote_f','v_legstrapbag_olive_f',
	'v_pocketed_black_f','v_pocketed_coyote_f','v_pocketed_olive_f','v_rangemaster_belt','v_rebreatherb',
	'v_bandollierb_blk','v_bandollierb_cbr','v_bandollierb_ghex_f','v_bandollierb_rgr','v_bandollierb_khk','v_bandollierb_oli','v_tacchestrig_cbr_f','v_tacchestrig_grn_f','v_tacchestrig_oli_f',
	'v_tacvest_blk','v_tacvest_brn','v_tacvest_camo','v_tacvest_khk','v_tacvest_oli','v_tacvest_blk_police','v_i_g_resistanceleader_f',
	'v_carrierrigkbt_01_eaf_f','v_platecarriergl_wdl','v_platecarrier1_wdl','v_platecarrier2_wdl','v_platecarrierspec_wdl','v_smershvest_01_f','v_smershvest_01_radio_f','v_carrierrigkbt_01_heavy_eaf_f',
	'v_carrierrigkbt_01_heavy_olive_f','v_carrierrigkbt_01_light_eaf_f','v_carrierrigkbt_01_light_olive_f','v_carrierrigkbt_01_eaf_f','v_carrierrigkbt_01_olive_f'
];
_vestsPilot = [
	'','v_platecarrier2_rgr_noflag_f','v_platecarrier1_blk','v_platecarrier1_rgr',
	'v_platecarrier1_rgr_noflag_f','v_platecarrier1_tna_f','v_platecarrier2_blk','v_platecarrier2_rgr','v_platecarrier2_tna_f','v_platecarrierspec_blk','v_platecarrierspec_rgr',
	'v_platecarrierspec_mtp','v_platecarrierspec_tna_f','v_chestrig_blk','v_chestrig_rgr','v_chestrig_khk','v_chestrig_oli',
	'v_legstrapbag_black_f','v_legstrapbag_coyote_f','v_legstrapbag_olive_f',
	'v_bandollierb_blk','v_bandollierb_cbr','v_bandollierb_ghex_f','v_bandollierb_rgr','v_bandollierb_khk','v_bandollierb_oli','v_tacchestrig_cbr_f','v_tacchestrig_grn_f','v_tacchestrig_oli_f',
	'v_tacvest_blk','v_tacvest_brn','v_tacvest_camo','v_tacvest_khk','v_tacvest_oli','v_tacvest_blk_police','v_i_g_resistanceleader_f',
	'v_carrierrigkbt_01_eaf_f','v_platecarrier1_wdl','v_platecarrier2_wdl','v_platecarrierspec_wdl','v_carrierrigkbt_01_heavy_eaf_f',
	'v_carrierrigkbt_01_heavy_olive_f','v_carrierrigkbt_01_light_eaf_f','v_carrierrigkbt_01_light_olive_f','v_carrierrigkbt_01_eaf_f','v_carrierrigkbt_01_olive_f'
];
// all backpacks
_backpacksAll = [
	'','b_bergen_mcamo_f','b_assaultpack_blk','b_assaultpack_cbr','b_assaultpack_dgtl','b_assaultpack_rgr','b_assaultpack_ocamo','b_assaultpack_khk','b_assaultpack_mcamo',
	'b_assaultpack_sgg','b_assaultpack_tna_f','b_bergen_dgtl_f','b_bergen_hex_f','b_bergen_tna_f','b_bergen_rgr','b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk',
	'b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo','b_hmg_01_high_weapon_f','b_hmg_01_weapon_f','b_gmg_01_high_weapon_f','b_gmg_01_weapon_f','b_fieldpack_blk',
	'b_fieldpack_cbr','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_fieldpack_khk','b_fieldpack_oli','b_fieldpack_oucamo','b_mortar_01_support_f','b_mortar_01_weapon_f',
	'b_hmg_01_support_high_f','b_hmg_01_support_f','b_kitbag_cbr','b_kitbag_rgr','b_kitbag_mcamo','b_kitbag_sgg','b_legstrapbag_black_f','b_legstrapbag_coyote_f',
	'b_legstrapbag_olive_f','b_messenger_black_f','b_messenger_coyote_f','b_messenger_gray_f','b_messenger_olive_f','b_static_designator_01_weapon_f','b_aa_01_weapon_f',
	'b_at_01_weapon_f','b_parachute','b_tacticalpack_blk','b_tacticalpack_rgr','b_tacticalpack_ocamo','b_tacticalpack_mcamo','b_tacticalpack_oli','b_uav_06_backpack_f',
	'b_uav_06_medical_backpack_f','b_uav_01_backpack_f','b_assaultpack_kerry','b_viperharness_blk_f','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperharness_khk_f',
	'b_viperharness_oli_f','b_viperlightharness_blk_f','b_viperlightharness_ghex_f','b_viperlightharness_hex_f','b_viperlightharness_khk_f','b_viperlightharness_oli_f',
	'b_mortar_01_weapon_grn_f','b_radiobag_01_f','b_ugv_02_demining_backpack_f','b_ugv_02_science_backpack_f',
	'b_assaultpack_eaf_f','b_assaultpack_wdl_f','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f','b_fieldpack_green_f','b_fieldpack_taiga_f','b_combinationunitrespirator_01_f',
	'b_radiobag_01_black_f','b_radiobag_01_digi_f','b_radiobag_01_eaf_f','b_radiobag_01_ghex_f','b_radiobag_01_hex_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','b_radiobag_01_oucamo_f','b_radiobag_01_wdl_f',
	'b_scba_01_f','i_c_hmg_02_support_f','i_c_hmg_02_weapon_f','i_c_hmg_02_high_weapon_f','i_c_hmg_02_support_high_f'
];
// Regular sized backpacks (all backpacks except for the big ones)
_backpacksBasic = [
	'','b_assaultpack_blk','b_assaultpack_cbr','b_assaultpack_dgtl','b_assaultpack_rgr','b_assaultpack_ocamo','b_assaultpack_khk','b_assaultpack_mcamo','b_assaultpack_sgg','b_assaultpack_tna_f','b_assaultpack_eaf_f','b_assaultpack_wdl_f',
	'b_fieldpack_blk','b_fieldpack_cbr','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_fieldpack_khk','b_fieldpack_oli','b_fieldpack_oucamo','b_fieldpack_green_f','b_fieldpack_taiga_f',
	'b_kitbag_cbr','b_kitbag_rgr','b_kitbag_mcamo','b_kitbag_sgg',
	'b_legstrapbag_black_f','b_legstrapbag_coyote_f','b_legstrapbag_olive_f',
	'b_tacticalpack_blk','b_tacticalpack_rgr','b_tacticalpack_ocamo','b_tacticalpack_mcamo','b_tacticalpack_oli',
	'b_viperharness_blk_f','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperharness_khk_f','b_viperharness_oli_f','b_viperlightharness_blk_f','b_viperlightharness_ghex_f','b_viperlightharness_hex_f','b_viperlightharness_khk_f','b_viperlightharness_oli_f',
	'b_combinationunitrespirator_01_f','b_scba_01_f','b_parachute',
	//'b_g_hmg_02_high_weapon_f','b_g_hmg_02_support_f','b_g_hmg_02_support_high_f','b_g_hmg_02_weapon_f'	// these are not arsenal compatible yet (Arma 2.00)
	'b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk','b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f'
];
_ObackpacksBasic = [
	'','b_assaultpack_blk','b_assaultpack_cbr','b_assaultpack_dgtl','b_assaultpack_rgr','b_assaultpack_ocamo','b_assaultpack_khk','b_assaultpack_mcamo','b_assaultpack_sgg','b_assaultpack_tna_f','b_assaultpack_eaf_f','b_assaultpack_wdl_f',
	'b_fieldpack_blk','b_fieldpack_cbr','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_fieldpack_khk','b_fieldpack_oli','b_fieldpack_oucamo','b_fieldpack_green_f','b_fieldpack_taiga_f',
	'b_kitbag_cbr','b_kitbag_rgr','b_kitbag_mcamo','b_kitbag_sgg',
	'b_legstrapbag_black_f','b_legstrapbag_coyote_f','b_legstrapbag_olive_f',
	'b_tacticalpack_blk','b_tacticalpack_rgr','b_tacticalpack_ocamo','b_tacticalpack_mcamo','b_tacticalpack_oli',
	'b_viperharness_blk_f','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperharness_khk_f','b_viperharness_oli_f','b_viperlightharness_blk_f','b_viperlightharness_ghex_f','b_viperlightharness_hex_f','b_viperlightharness_khk_f','b_viperlightharness_oli_f',
	'b_combinationunitrespirator_01_f','b_scba_01_f','b_parachute',
	//'b_g_hmg_02_high_weapon_f','b_g_hmg_02_support_f','b_g_hmg_02_support_high_f','b_g_hmg_02_weapon_f'	// these are not arsenal compatible yet (Arma 2.00)
	'b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk','b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f'
];
// Large backpacks
_backpacksLarge = [
	'b_bergen_dgtl_f','b_bergen_hex_f','b_bergen_mcamo_f','b_bergen_tna_f','b_bergen_rgr',
	'b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk','b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f'
];
// NATO backpacks which can be assembled into static turrets (tripods + weapon)
_backpacksStatic = [
	'b_hmg_01_high_weapon_f','b_hmg_01_weapon_f','b_gmg_01_high_weapon_f','b_gmg_01_weapon_f',
	'b_hmg_01_support_high_f','b_hmg_01_support_f',
	'b_static_designator_01_weapon_f','b_w_static_designator_01_weapon_f',
	'b_aa_01_weapon_f','b_at_01_weapon_f'
	//'b_g_hmg_02_high_weapon_f','b_g_hmg_02_support_f','b_g_hmg_02_support_high_f','b_g_hmg_02_weapon_f'	// these are not arsenal compatible yet (Arma 2.00)
];
// UAV backpacks
_backpacksUAV = [
	'','b_uav_01_backpack_f','b_uav_06_medical_backpack_f','b_ugv_02_demining_backpack_f','b_ugv_02_science_backpack_f','b_uav_06_backpack_f'
];
// Mortar backpacks
_backpacksMortar = [
	'','b_mortar_01_weapon_grn_f','b_mortar_01_support_f','b_mortar_01_weapon_f',
	'b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk','b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f'
];
// Radio backpacks
_backpacksRadio = [
	'b_radiobag_01_black_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','TFAR_rt1523g','TFAR_mr3000','TFAR_anprc155','Item_TFAR_rt1523g','Item_TFAR_mr3000','Item_TFAR_anprc155','tf_rt1523g','tf_rt1523g_big','tf_rt1523g_sage','tf_rt1523g_green','tf_rt1523g_black','tf_rt1523g_fabric','tf_rt1523g_bwmod','tf_rt1523g_big_bwmod','tf_rt1523g_big_bwmod_tropen','tf_rt1523g_big_rhs','tf_rt1523g_rhs','tf_anprc155','tf_anprc155_coyote'
];
_ObackpacksRadio = [
	'b_radiobag_01_black_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','TFAR_rt1523g','TFAR_mr3000','TFAR_anprc155','Item_TFAR_rt1523g','Item_TFAR_mr3000','Item_TFAR_anprc155','tf_mr3000_multicam','tf_mr3000_bwmod','tf_mr3000_bwmod_tropen','tf_mr3000_rhs','tf_bussole','tf_anprc155','tf_anprc155','tf_anprc155_coyote'
];
// all goggles
_gogglesAll = [
	'','g_spectacles','g_spectacles_tinted','g_combat','g_lowprofile','g_shades_black','g_shades_green','g_shades_red','g_squares','g_squares_tinted','g_sport_blackwhite',
	'g_sport_blackyellow','g_sport_greenblack','g_sport_checkered','g_sport_red','g_tactical_black','g_aviator','g_lady_mirror','g_lady_dark','g_lady_red','g_lady_blue','g_diving',
	'g_b_diving','g_o_diving','g_i_diving','g_goggles_vr','g_balaclava_blk','g_balaclava_oli','g_balaclava_combat','g_balaclava_lowprofile','g_bandanna_blk','g_bandanna_oli','g_bandanna_khk',
	'g_bandanna_tan','g_bandanna_beast','g_bandanna_shades','g_bandanna_sport','g_bandanna_aviator','g_shades_blue','g_sport_blackred','g_tactical_clear','g_balaclava_ti_blk_f','g_balaclava_ti_tna_f',
	'g_balaclava_ti_g_blk_f','g_balaclava_ti_g_tna_f','g_combat_goggles_tna_f','g_respirator_base_f','g_respirator_white_f','g_respirator_yellow_f','g_respirator_blue_f','g_eyeprotectors_base_f',
	'g_eyeprotectors_f','g_eyeprotectors_earpiece_f','g_wirelessearpiece_base_f','g_wirelessearpiece_f',
	'g_airpurifyingrespirator_02_black_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_01_f','g_blindfold_01_black_f','g_blindfold_01_white_f','g_regulatormask_f'
];
_gogglesBasic = [
	'','g_combat','g_combat_goggles_tna_f','g_tactical_black','g_tactical_clear','g_aviator','g_diving','g_b_diving','g_lowprofile',
	'g_balaclava_blk','g_balaclava_oli','g_balaclava_combat','g_balaclava_lowprofile','g_balaclava_ti_blk_f','g_balaclava_ti_tna_f','g_balaclava_ti_g_blk_f','g_balaclava_ti_g_tna_f',
	'g_bandanna_blk','g_bandanna_oli','g_bandanna_khk','g_bandanna_tan','g_bandanna_beast','g_bandanna_shades','g_bandanna_sport','g_bandanna_aviator'
];
// armor piercing missiles
_magazinesAT = [
	'vorona_heat','mraws_heat_f','titan_at'
];
// all magazines and ammo
_magazinesAll = [
	'','30rnd_65x39_caseless_green','6rnd_45acp_cylinder','smokeshellyellow','smokeshell','smokeshellred','smokeshellpurple','smokeshellorange','smokeshellgreen','smokeshellblue','handgrenade',
	'minigrenade','b_ir_grenade','chemlight_blue','chemlight_green','chemlight_red','chemlight_yellow','o_ir_grenade','i_ir_grenade','titan_at','10rnd_338_mag','130rnd_338_mag','7rnd_408_mag',
	'11rnd_45acp_mag','30rnd_45acp_mag_smg_01','30rnd_45acp_mag_smg_01_tracer_green','30rnd_45acp_mag_smg_01_tracer_red','30rnd_45acp_mag_smg_01_tracer_yellow','9rnd_45acp_mag','10rnd_50bw_mag_f',
	'5rnd_127x108_mag','10rnd_127x54_mag','5rnd_127x108_apds_mag','3rnd_ugl_flaregreen_f','3rnd_ugl_flarecir_f','3rnd_ugl_flarered_f','3rnd_ugl_flarewhite_f','3rnd_ugl_flareyellow_f',
	'3rnd_smokeblue_grenade_shell','3rnd_smokegreen_grenade_shell','3rnd_smokeorange_grenade_shell','3rnd_smokepurple_grenade_shell','3rnd_smokered_grenade_shell','3rnd_smoke_grenade_shell',
	'3rnd_smokeyellow_grenade_shell','3rnd_he_grenade_shell','1rnd_he_grenade_shell','30rnd_545x39_mag_green_f','30rnd_545x39_mag_f','30rnd_545x39_mag_tracer_green_f','30rnd_545x39_mag_tracer_f',
	'150rnd_556x45_drum_mag_f','150rnd_556x45_drum_mag_tracer_f','titan_ap','titan_aa','1rnd_smokeyellow_grenade_shell','1rnd_smoke_grenade_shell','1rnd_smokered_grenade_shell',
	'1rnd_smokepurple_grenade_shell','1rnd_smokeorange_grenade_shell','1rnd_smokegreen_grenade_shell','1rnd_smokeblue_grenade_shell','rpg32_f','rpg32_he_f','rpg7_f','nlaw_f',
	'ugl_flareyellow_f','ugl_flarewhite_f','ugl_flarered_f','ugl_flarecir_f','ugl_flaregreen_f','flareyellow_f','flarewhite_f','flaregreen_f','flarered_f','laserbatteries',
	'150rnd_93x64_mag','10rnd_93x64_dmr_05_mag','30rnd_9x21_mag_smg_02_tracer_yellow','30rnd_9x21_yellow_mag','30rnd_9x21_mag_smg_02_tracer_red','30rnd_9x21_red_mag',
	'30rnd_9x21_mag_smg_02_tracer_green','30rnd_9x21_green_mag','30rnd_9x21_mag_smg_02','200rnd_556x45_box_red_f','200rnd_556x45_box_f','200rnd_556x45_box_tracer_red_f',
	'200rnd_556x45_box_tracer_f','20rnd_556x45_uw_mag','30rnd_556x45_stanag_red','30rnd_556x45_stanag_green','30rnd_556x45_stanag','30rnd_556x45_stanag_tracer_green',
	'30rnd_556x45_stanag_tracer_red','30rnd_556x45_stanag_tracer_yellow','100rnd_580x42_mag_f','100rnd_580x42_mag_tracer_f','30rnd_580x42_mag_f','30rnd_580x42_mag_tracer_f',
	'100rnd_65x39_caseless_mag','100rnd_65x39_caseless_mag_tracer','200rnd_65x39_cased_box','200rnd_65x39_cased_box_tracer','20rnd_650x39_cased_mag_f','30rnd_65x39_caseless_mag',
	'30rnd_65x39_caseless_green_mag_tracer','30rnd_65x39_caseless_mag_tracer','6rnd_greensignal_f','6rnd_redsignal_f','150rnd_762x54_box','150rnd_762x51_box','150rnd_762x54_box_tracer',
	'150rnd_762x51_box_tracer','20rnd_762x51_mag','30rnd_762x39_mag_green_f','30rnd_762x39_mag_f','30rnd_762x39_mag_tracer_green_f','30rnd_762x39_mag_tracer_f','10rnd_762x51_mag',
	'10rnd_762x54_mag','10rnd_9x21_mag','16rnd_9x21_mag','16rnd_9x21_green_mag','16rnd_9x21_red_mag','16rnd_9x21_yellow_mag','30rnd_9x21_mag','50rnd_570x28_smg_03',
	'apersboundingmine_range_mag','apersmine_range_mag','aperstripmine_wire_mag','atmine_range_mag','claymoredirectionalmine_remote_mag','democharge_remote_mag',
	'satchelcharge_remote_mag','iedlandbig_remote_mag','iedurbanbig_remote_mag','slamdirectionalmine_wire_mag','iedlandsmall_remote_mag','iedurbansmall_remote_mag',
	'vorona_he','mraws_heat_f','mraws_he_f',
	'30rnd_762x39_ak12_mag_f','30rnd_762x39_ak12_mag_tracer_f','30rnd_556x45_stanag_sand','30rnd_556x45_stanag_sand_green','30rnd_556x45_stanag_sand_red','30rnd_556x45_stanag_sand_tracer_red',
	'30rnd_556x45_stanag_sand_tracer_green','30rnd_556x45_stanag_sand_tracer_yellow','150rnd_556x45_drum_sand_mag_f','150rnd_556x45_drum_sand_mag_tracer_f','150rnd_556x45_drum_green_mag_f',
	'150rnd_556x45_drum_green_mag_tracer_f','30rnd_65x39_caseless_khaki_mag','30rnd_65x39_caseless_black_mag','30rnd_65x39_caseless_khaki_mag_tracer','30rnd_65x39_caseless_black_mag_tracer',
	'100rnd_65x39_caseless_khaki_mag','100rnd_65x39_caseless_black_mag','100rnd_65x39_caseless_khaki_mag_tracer','100rnd_65x39_caseless_black_mag_tracer','100rnd_580x42_hex_mag_f',
	'100rnd_580x42_hex_mag_tracer_f','100rnd_580x42_ghex_mag_f','100rnd_580x42_ghex_mag_tracer_f',
	'30rnd_65x39_caseless_msbs_mag','30rnd_65x39_caseless_msbs_mag_tracer','2rnd_12gauge_pellets','2rnd_12gauge_slug',
	'30rnd_762x39_ak12_arid_mag_f','30rnd_762x39_ak12_arid_mag_tracer_f','30rnd_762x39_ak12_lush_mag_f','30rnd_762x39_ak12_lush_mag_tracer_f','30rnd_762x39_ak12_mag_green_f','30rnd_762x39_ak12_mag_tracer_green_f',
	'75rnd_762x39_mag_tracer_f','75rnd_762x39_mag_f','75rnd_762x39_ak12_mag_tracer_f','75rnd_762x39_ak12_mag_f','75rnd_762x39_ak12_lush_mag_tracer_f','75rnd_762x39_ak12_lush_mag_f',
	'75rnd_762x39_ak12_arid_mag_tracer_f','75rnd_762x39_ak12_arid_mag_f',
	'6rnd_12gauge_pellets','6rnd_12gauge_slug'
];
// all weapon attachments
_attachmentsAll = [
	'','optic_aco_grn','optic_aco','optic_aco_grn_smg','optic_aco_smg','optic_ams','optic_ams_khk','optic_ams_snd','optic_arco','optic_arco_blk_f','optic_arco_ghex_f',
	'optic_dms','optic_dms_ghex_f','optic_erco_blk_f','optic_erco_khk_f','optic_erco_snd_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps',
	'optic_lrps_ghex_f','optic_lrps_tna_f','optic_holosight','optic_holosight_blk_f','optic_holosight_khk_f','optic_holosight_smg','optic_holosight_smg_blk_f',
	'optic_holosight_smg_khk_f','optic_sos','optic_sos_khk_f','optic_mrco','optic_nvs','optic_hamr','optic_hamr_khk_f',
	'acc_flashlight','acc_pointer_ir','muzzle_snds_b_khk_f','muzzle_snds_b_snd_f','muzzle_snds_b','bipod_03_f_blk','bipod_02_f_blk','bipod_01_f_blk','bipod_02_f_hex',
	'bipod_01_f_khk','bipod_01_f_mtp','bipod_03_f_oli','bipod_01_f_snd','bipod_02_f_tan','muzzle_snds_m','muzzle_snds_m_khk_f','muzzle_snds_m_snd_f','muzzle_snds_93mmg',
	'muzzle_snds_93mmg_tan','muzzle_snds_l','muzzle_snds_58_blk_f','muzzle_snds_58_ghex_f','muzzle_snds_58_hex_f','muzzle_snds_65_ti_blk_f','muzzle_snds_65_ti_ghex_f',
	'muzzle_snds_65_ti_hex_f','muzzle_snds_h_snd_f','muzzle_snds_h_khk_f','muzzle_snds_h','muzzle_snds_338_black','muzzle_snds_338_green','muzzle_snds_338_sand','muzzle_snds_acp',
	'optic_mrd','acc_flashlight_pistol','acc_flashlight_smg_01','optic_yorris','muzzle_snds_570',
	'optic_arco_arid_f','optic_arco_lush_f','optic_arco_ak_arid_f','optic_arco_ak_blk_f','optic_arco_ak_lush_f','optic_dms_weathered_f',
	'optic_dms_weathered_kir_f','optic_holosight_arid_f','optic_holosight_lush_f','muzzle_snds_b_arid_f','muzzle_snds_b_lush_f','bipod_02_f_arid',
	'bipod_02_f_lush','optic_ico_01_f','optic_ico_01_black_f','optic_ico_01_camo_f','optic_ico_01_sand_f','optic_mrd_black','optic_nightstalker','optic_tws','optic_tws_mg'
];
// all weapon attachments
_attachmentsBasic = [
	'','optic_aco_grn','optic_aco','optic_aco_grn_smg','optic_aco_smg','optic_arco','optic_arco_blk_f','optic_arco_ghex_f',
	'optic_erco_blk_f','optic_erco_khk_f','optic_erco_snd_f','optic_holosight','optic_holosight_blk_f','optic_holosight_khk_f','optic_holosight_smg','optic_holosight_smg_blk_f',
	'optic_holosight_smg_khk_f','optic_mrco','optic_nvs','optic_hamr','optic_hamr_khk_f',
	'acc_flashlight','acc_pointer_ir','muzzle_snds_b_khk_f','muzzle_snds_b_snd_f','muzzle_snds_b','bipod_01_f_blk',
	'bipod_01_f_khk','bipod_01_f_mtp','bipod_01_f_snd','muzzle_snds_m','muzzle_snds_m_khk_f','muzzle_snds_m_snd_f','muzzle_snds_93mmg',
	'muzzle_snds_93mmg_tan','muzzle_snds_l','muzzle_snds_58_blk_f','muzzle_snds_58_ghex_f','muzzle_snds_58_hex_f','muzzle_snds_65_ti_blk_f','muzzle_snds_65_ti_ghex_f',
	'muzzle_snds_65_ti_hex_f','muzzle_snds_h_snd_f','muzzle_snds_h_khk_f','muzzle_snds_h','muzzle_snds_338_black','muzzle_snds_338_green','muzzle_snds_338_sand','muzzle_snds_acp',
	'optic_mrd','acc_flashlight_pistol','acc_flashlight_smg_01','optic_yorris','muzzle_snds_570',
	'optic_arco_arid_f','optic_arco_lush_f','optic_arco_ak_arid_f','optic_arco_ak_blk_f','optic_arco_ak_lush_f','optic_holosight_arid_f','optic_holosight_lush_f','muzzle_snds_b_arid_f','muzzle_snds_b_lush_f','optic_ico_01_f','optic_ico_01_black_f','optic_ico_01_camo_f','optic_ico_01_sand_f','optic_mrd_black',
	'optic_AMS','optic_AMS_snd','optic_DMS','optic_SOS','optic_sos_khk_f'
];
// sniper weapon attachments
_attachmentsSniper = [
	'','optic_aco_grn','optic_aco','optic_aco_grn_smg','optic_aco_smg','optic_arco','optic_arco_blk_f','optic_arco_ghex_f','optic_mrco','optic_AMS','optic_AMS_snd','optic_ams_khk','optic_DMS','optic_dms_ghex_f','optic_dms_weathered_f','optic_DMS_weathered_Kir_F','optic_KHS_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_LRPS','optic_LRPS_ghex_F','optic_LRPS_tna_F','optic_SOS','optic_sos_khk_f',
	'acc_flashlight','acc_pointer_ir','muzzle_snds_b_khk_f','muzzle_snds_b_snd_f','muzzle_snds_b','bipod_01_f_blk',
	'bipod_01_f_khk','bipod_01_f_mtp','bipod_01_f_snd','muzzle_snds_m','muzzle_snds_m_khk_f','muzzle_snds_m_snd_f','muzzle_snds_93mmg',
	'muzzle_snds_93mmg_tan','muzzle_snds_l','muzzle_snds_58_blk_f','muzzle_snds_58_ghex_f','muzzle_snds_58_hex_f','muzzle_snds_65_ti_blk_f','muzzle_snds_65_ti_ghex_f',
	'muzzle_snds_65_ti_hex_f','muzzle_snds_h_snd_f','muzzle_snds_h_khk_f','muzzle_snds_h','muzzle_snds_338_black','muzzle_snds_338_green','muzzle_snds_338_sand','muzzle_snds_acp',
	'optic_mrd','acc_flashlight_pistol','acc_flashlight_smg_01','optic_yorris','muzzle_snds_570'
];
// thermal weapon attachments
_attachmentsThermal = [
	'optic_nightstalker','optic_tws','optic_tws_mg'
];
// special inventory items + head-mounted displays like NVG, including thermal
_assignedItemsAll = [
	'','itemmap','itemcompass','itemwatch','itemradio','itemgps','chemicaldetector_01_watch_f','nvgoggles_tna_f','o_nvgoggles_ghex_f','o_nvgoggles_hex_f','o_nvgoggles_urb_f','o_nvgoggles_grn_f','nvgoggles_opfor','nvgoggles','nvgoggles_indep','nvgogglesb_blk_f','nvgogglesb_grn_f','nvgogglesb_gry_f','TFAR_anprc152','TFAR_anarc210','TFAR_rf7800str','TFAR_microdagr','TFAR_fadak','TFAR_pnr1000a','TFAR_anprc148jem','TFAR_anprc154','TFAR_mr6000l','TFAR_anarc164','Item_TFAR_anprc152','Item_TFAR_anarc210','Item_TFAR_rf7800str','Item_TFAR_fadak','Item_TFAR_pnr1000a','Item_TFAR_anprc148jem','Item_TFAR_anprc154','Item_TFAR_mr6000l','Item_TFAR_microdagr','tf_anprc152','tf_rf7800str','tf_fadak','tf_pnr1000a','tf_anprc148jem','tf_anprc154','tf_microdagr'
];
// same as above but with no thermal
_assignedItemsBasic = [
	'','itemmap','itemcompass','itemwatch','itemradio','itemgps','chemicaldetector_01_watch_f','nvgoggles_tna_f','nvgoggles','nvgoggles_indep','nvgoggles_opfor','TFAR_anprc152','TFAR_anarc210','TFAR_microdagr','TFAR_rf7800str','Item_TFAR_anprc152','Item_TFAR_anarc210','Item_TFAR_rf7800str','Item_TFAR_microdagr','tf_anprc152','tf_rf7800str','tf_anprc148jem','tf_anprc154','tf_microdagr'
];
// O same as above but with no thermal
_OassignedItemsBasic = [
	'','itemmap','itemcompass','itemwatch','itemradio','itemgps','o_nvgoggles_ghex_f','o_nvgoggles_hex_f','o_nvgoggles_urb_f','o_nvgoggles_grn_f','nvgoggles_opfor','TFAR_fadak','TFAR_pnr1000a','TFAR_anprc148jem','TFAR_anprc154','TFAR_mr6000l','TFAR_anarc164','TFAR_microdagr','Item_TFAR_fadak','Item_TFAR_pnr1000a','Item_TFAR_anprc148jem','Item_TFAR_anprc154','Item_TFAR_mr6000l','Item_TFAR_microdagr','tf_fadak','tf_pnr1000a','tf_anprc148jem','tf_anprc154','tf_microdagr'
];
// uav terminal
_assignedItemsUAV = [
	'b_uavterminal'
];
// thermal head-mounted displays
_assignedItemsThermal = [
	'nvgogglesb_blk_f','nvgogglesb_grn_f','nvgogglesb_gry_f'
];
// other inventory items
_inventoryAll = [
	'','firstaidkit','medikit','minedetector','toolkit'
];
_o_weapons = [
	'','arifle_ak12_f','arifle_ak12_gl_f','arifle_akm_f','arifle_aks_f','arifle_ctars_blk_f','arifle_ctars_ghex_f','arifle_ctars_hex_f','arifle_ctar_blk_f','arifle_ctar_ghex_f',
	'arifle_ctar_hex_f','arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f','srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f','arifle_katiba_f',
	'arifle_katiba_c_f','arifle_katiba_gl_f','lmg_03_f','arifle_mk20_plain_f','arifle_mk20_f','arifle_mk20_gl_plain_f','arifle_mk20_gl_f','arifle_mk20c_plain_f','arifle_mk20c_f',
	'hgun_pdw2000_f','smg_05_f','smg_02_f','arifle_trg20_f','arifle_trg21_f','arifle_trg21_gl_f','arifle_arx_blk_f','arifle_arx_ghex_f','arifle_arx_hex_f','smg_01_f'
];
_o_uniforms = [
	'','u_i_c_soldier_bandit_4_f','u_i_c_soldier_bandit_1_f','u_i_c_soldier_bandit_2_f','u_i_c_soldier_bandit_5_f','u_i_c_soldier_bandit_3_f','u_o_t_soldier_f',
	'u_o_combatuniform_ocamo','u_o_combatuniform_oucamo','u_o_fullghillie_ard','u_o_t_fullghillie_tna_f','u_o_fullghillie_lsh','u_o_fullghillie_sard','u_o_t_sniper_f',
	'u_o_ghilliesuit','u_bg_guerrilla_6_1','u_bg_guerilla1_1','u_bg_guerilla1_2_f','u_bg_guerilla2_2','u_bg_guerilla2_1','u_bg_guerilla2_3','u_bg_guerilla3_1','u_bg_leader',
	'u_o_officer_noinsignia_hex_f','u_o_t_officer_f','u_o_officeruniform_ocamo','u_i_c_soldier_para_2_f','u_i_c_soldier_para_3_f','u_i_c_soldier_para_5_f','u_i_c_soldier_para_4_f',
	'u_i_c_soldier_para_1_f','u_o_pilotcoveralls','u_o_specopsuniform_ocamo','u_i_c_soldier_camo_f'
];
_o_vests = [
	'','v_harnessogl_brn','v_harnessogl_ghex_f','v_harnesso_brn','v_harnesso_ghex_f','v_harnesso_gry','v_bandollierb_cbr','v_tacchestrig_cbr_f','v_tacvest_khk','V_PlateCarrier2_rgr','V_PlateCarrier2_tna_F'
];
_o_backpacks = [
	'','b_assaultpack_ocamo','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_tacticalpack_ocamo','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperlightharness_blk_f',
	'b_viperlightharness_ghex_f','b_viperlightharness_hex_f','b_carryall_ocamo','b_carryall_ghex_F'
];
_o_headgear = [
	'','h_helmetspeco_blk','h_helmetspeco_ghex_f','h_helmetspeco_ocamo','h_bandanna_gry','h_bandanna_blu','h_bandanna_cbr','h_bandanna_khk_hs','h_bandanna_khk',
	'h_bandanna_mcamo','h_cap_brn_specops','h_helmetcrew_o','h_helmetleadero_ghex_f','h_helmetleadero_ocamo','h_helmetleadero_oucamo','h_milcap_ghex_f','h_milcap_ocamo',
	'h_milcap_dgtl','h_helmeto_ghex_f','h_helmeto_ocamo','h_helmeto_oucamo','h_shemag_olive','h_shemag_olive_hs','h_shemagopen_tan','h_shemagopen_khk'
];
_o_magazines = [
	''
];
_o_attachments = [
	''
];
//=========================================== GET [BLACKLIST + WHITELIST] FOR PLAYER ROLE
/*
// Undefined role (not used, kept here as an example/template).
if (_role isEqualTo '') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[	// blacklisted uniforms
				
				],
				[	// blacklisted vests
				
				],
				[	// blacklisted inventory
				
				],
				[	// blacklisted assigned items
					'b_uavterminal'
				],
				_headgearThermal,	// blacklisted Headgear
				[	// blacklisted goggles
				
				],
				[	// blacklisted attachments
				
				]
			],
			[	// blacklisted MAGAZINES
				
			],
			[	// blacklisted BACKPACKS
			
			],
			[	// blacklisted WEAPONS
			
			]
		],
		[	// -------------------------------------------------------------- WHITELIST
			[								// ITEMS
				_uniformsAll,				// whitelisted UNIFORMS
				_vestsAll,					// whitelisted VESTS
				_inventoryAll,					// whitelisted Inventory
				_assignedItemsAll,			// whitelisted ASSIGNED ITEMS
				_headgearBasic,				// whitelisted HEADGEAR
				_gogglesAll,				// whitelisted goggles
				_attachmentsAll				// whitelisted Attachments
			],
			_magazinesAll,					// whitelisted MAGAZINES
			_backpacksAll,					// whitelisted BACKPACKS
			_weaponsAll						// whitelisted WEAPONS
		]
	]
};*/
if (_role isEqualTo 'rifleman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS,
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,			// whitelisted UNIFORMS
				_vestsBasic,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_headgearBasic,			// whitelisted HEADGEAR
				_gogglesBasic,			// whitelisted goggles
				_attachmentsBasic			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_backpacksBasic,				// whitelisted BACKPACKS
			(_weaponsShutGun + _weaponsBasic + _weaponsMarksman + _weaponsHandgun + _weaponsLauncherBasic + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'autorifleman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsHMG + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsBasic,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksStatic),						// whitelisted BACKPACKS
			(_weaponsLMG + _weaponsMarksman + _weaponsHandgun + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['machine_gunner','machine_gunner_WL']) exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsBasic,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksStatic),							// whitelisted BACKPACKS
			(_weaponsMMG + _weaponsMarksman +  _weaponsHandgun + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'rifleman_lat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,							// whitelisted UNIFORMS
				_vestsBasic,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				_assignedItemsBasic,						// whitelisted ASSIGNED ITEMS
				_headgearBasic,							// whitelisted HEADGEAR
				_gogglesBasic,							// whitelisted goggles
				_attachmentsBasic							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksStatic),								// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsLauncherLAT + _weaponsHandgun + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'rifleman_hat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,							// whitelisted UNIFORMS
				_vestsBasic,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				_assignedItemsBasic,						// whitelisted ASSIGNED ITEMS
				_headgearBasic,							// whitelisted HEADGEAR
				_gogglesBasic,							// whitelisted goggles
				_attachmentsBasic							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksStatic),								// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsLauncherHAT + _weaponsHandgun + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'engineer') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,			// whitelisted UNIFORMS
				_vestsBasic,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearMortar),		// whitelisted HEADGEAR
				_gogglesBasic,			// whitelisted goggles
				_attachmentsBasic			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_backpacksBasic,			// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsHandgun + _weaponsLauncherBasic + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'crewman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsMarksman + _weaponsMarksmanHeavy + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsBasic,					// whitelisted ASSIGNED ITEMS
				_headgearCrew,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,							// whitelisted BACKPACKS
			(_weaponsCompact + _weaponsSMG + _weaponsHandgun + _weaponsLauncherBasic + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['medic','medic_WL']) exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,			// whitelisted UNIFORMS
				_vestsBasic,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearMortar),		// whitelisted HEADGEAR
				_gogglesBasic,			// whitelisted goggles
				_attachmentsBasic			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_backpacksBasic,			// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsHandgun + _weaponsLauncherBasic + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'mortar_gunner') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,			// whitelisted UNIFORMS
				_vestsBasic,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearMortar),		// whitelisted HEADGEAR
				_gogglesBasic,			// whitelisted goggles
				_attachmentsBasic			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_backpacksMortar + _backpacksLarge),				// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['sniper','sniper_WL']) exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsLMG + _weaponsHMG + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsSniper,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearSniper),						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				(_attachmentsSniper + _attachmentsThermal)	// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,							// whitelisted BACKPACKS
			(_weaponsSniper + _weaponsMarksmanHeavy + _weaponsHandgun + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'spotter') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsLMG + _weaponsHMG + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsSniper,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearSniper),						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic	// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,						// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsHandgun + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'sat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,					// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksRadio),							// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsCompact + _weaponsMarksman + _weaponsHandgun + _weaponsLauncherBasic + _weaponsUW + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'leader') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksRadio),							// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksman + _weaponsGL + _weaponsHandgun + _weaponsLauncherBasic + _viewersLaser)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'jtac') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,							// whitelisted UNIFORMS
				_vestsBasic,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),						// whitelisted ASSIGNED ITEMS
				(_headgearBasic + _headgearJtac),							// whitelisted HEADGEAR
				_gogglesBasic,							// whitelisted goggles
				_attachmentsAll							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksRadio),							// whitelisted BACKPACKS
			(_weaponsShutGun + _weaponsBasic + _weaponsMarksman + _weaponsGL + _weaponsHandgun + _weaponsLauncherBasic +  _weaponsUW + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'uav') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				[],	// blacklisted assigned items  (we dont blacklist the uav terminal for the uav operator!)
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksman + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsBasic,								// whitelisted UNIFORMS
				_vestsBasic,									// whitelisted VESTS
				_inventoryAll,								// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsUAV),	// whitelisted ASSIGNED ITEMS
				_headgearSniper,								// whitelisted HEADGEAR
				_gogglesBasic,								// whitelisted goggles
				_attachmentsBasic								// whitelisted Attachments
			],
			_magazinesAll,									// whitelisted MAGAZINES
			(_backpacksUAV + _backpacksBasic + _backpacksRadio),								// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsCompact + _weaponsHandgun + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['pilot_heli','pilot_heli_WL']) exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsBasic + _weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksman + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsHeliPilot,						// whitelisted UNIFORMS
				_vestsPilot,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearHeli,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,							// whitelisted BACKPACKS
			(_weaponsHandgun + _weaponsCompact + _weaponsSMG + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'pilot_cas') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsBasic + _weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksman + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsHeliPilot,						// whitelisted UNIFORMS
				_vestsPilot,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearHeli,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,							// whitelisted BACKPACKS
			(_weaponsHandgun + _weaponsCompact + _weaponsSMG + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['pilot','pilot_plane']) exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[(_weaponsBasic + _weaponsSniper + _weaponsLMG + _weaponsHMG + _weaponsMarksman + _weaponsMarksmanHeavy + _weaponsLauncherLAT + _weaponsLauncherHAT + _weaponsLauncherRegular)]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsPilot,						// whitelisted UNIFORMS
				_vestsPilot,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearPilot,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsBasic						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksBasic,							// whitelisted BACKPACKS
			(_weaponsHandgun + _weaponsCompact + _weaponsSMG + _viewersBasic)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'commander') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[],	// blacklisted BACKPACKS
			[]	// blacklisted WEAPONS	
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsBasic,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				(_assignedItemsBasic + _assignedItemsThermal),					// whitelisted ASSIGNED ITEMS
				_headgearCommander,						// whitelisted HEADGEAR
				_gogglesBasic,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			(_backpacksBasic + _backpacksRadio),							// whitelisted BACKPACKS
			(_weaponsHandgun + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
//OPFOR
if (_role isEqualTo 'o_rifleman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_autorifleman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_OweaponsAll + _o_weapons + _OweaponsLMG + _weaponsHandgun + _OweaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_machine_gunner') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_rifleman_lat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_rifleman_hat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_engineer') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_crewman') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_medic') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_mortar_gunner') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_ObackpacksBasic + _ObackpacksRadio + _o_backpacks),				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_sniper') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_spotter') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_sat') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_ObackpacksBasic + _ObackpacksRadio + _o_backpacks),				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_leader') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_ObackpacksBasic + _ObackpacksRadio + _o_backpacks),				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_jtac') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_ObackpacksBasic + _ObackpacksRadio + _o_backpacks),				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_uav') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			(_ObackpacksBasic + _ObackpacksRadio + _o_backpacks),				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_pilot_heli') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_OuniformsHeliPilot,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_pilot_cas') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_OuniformsHeliPilot,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_pilot_plane') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[], // blacklisted uniforms
				[], // blacklisted vests
				[], // blacklisted inventory
				['b_uavterminal'],	// blacklisted assigned items			
				_headgearThermal,	// blacklisted Headgear
				[], // blacklisted goggles
				[]	// blacklisted attachments
            ],
			[],	// blacklisted MAGAZINES
			[]	// blacklisted BACKPACKS
			//(_OweaponsMMG + _OweaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				U_O_PilotCoveralls,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_OassignedItemsBasic,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_weaponsShutGun + _OweaponsAll + _o_weapons + _OweaponsBasic  + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Default
([WEST,'rifleman'] call (missionNamespace getVariable 'QS_data_arsenal'))