/*/
File: fn_customInventory.sqf
Author:

	Quiksilver (thanks soulkobk for lists of items: https://github.com/soulkobk/ArmA_Scripts/blob/master/randomCrateLoadOut/randomCrateLoadOut.sqf)

Last Modified:

	14/06/2018 A3 1.82 by Quiksilver
	
Description:

	Custom Inventory
_____________________________________________________________/*/

params ['_entity','_type','_preset'];
if !(_entity isNil 'QS_vehicle_customInventory') exitWith {};
_entity setVariable ['QS_vehicle_customInventory',TRUE,FALSE];
_whitelistedBackpacks = [];
_allItems = [
	"bipod_01_F_blk", /*/ Bipod (Black) [NATO] BIPOD"/*/
	"bipod_01_F_khk", /*/ Bipod (Khaki) [NATO] BIPOD"/*/
	"bipod_01_F_mtp", /*/ Bipod (MTP) [NATO] BIPOD"/*/
	"bipod_01_F_snd", /*/ Bipod (Sand) [NATO] BIPOD"/*/
	"bipod_02_F_blk", /*/ Bipod (Black) [CSAT] BIPOD"/*/
	"bipod_02_F_hex", /*/ Bipod (Hex) [CSAT] BIPOD"/*/
	"bipod_02_F_tan", /*/ Bipod (Tan) [CSAT] BIPOD"/*/
	"bipod_03_F_blk", /*/ Bipod (Black) [AAF] BIPOD"/*/
	"bipod_03_F_oli", /*/ Bipod (Olive) [AAF] BIPOD"/*/
	"acc_flashlight", /*/ Flashlight/*/
	"acc_pointer_IR", /*/ IR Laser Pointer/*/
	"optic_Aco", /*/ ACO (Red)/*/
	"optic_ACO_grn", /*/ ACO (Green)/*/
	"optic_ACO_grn_smg", /*/ACO SMG (Green)/*/
	"optic_Aco_smg", /*/ ACO SMG (Red)/*/
	"optic_AMS", /*/ AMS (Black)/*/
	"optic_AMS_khk", /*/ AMS (Khaki)/*/
	"optic_AMS_snd", /*/ AMS (Sand)/*/
	"optic_Arco", /*/ ARCO/*/
	"optic_Arco_blk_F", /*/ ARCO (Black)/*/
	"optic_Arco_ghex_F", /*/ ARCO (Green Hex)/*/
	"optic_DMS", /*/ DMS/*/
	"optic_DMS_ghex_F", /*/ DMS (Green Hex)/*/
	"optic_ERCO_blk_F", /*/ ERCO (Black)/*/
	"optic_ERCO_khk_F", /*/ ERCO (Khaki)/*/
	"optic_ERCO_snd_F", /*/ ERCO (Sand)/*/
	"optic_Hamr", /*/ RCO/*/
	"optic_Hamr_khk_F", /*/ RCO (Khaki)/*/
	"optic_Holosight", /*/ Mk17 Holosight/*/
	"optic_Holosight_blk_F", /*/ Mk17 Holosight (Black)/*/
	"optic_Holosight_khk_F", /*/ Mk17 Holosight (Khaki)/*/
	"optic_Holosight_smg", /*/ Mk17 Holosight SMG/*/
	"optic_Holosight_smg_blk_F", /*/ Mk17 Holosight SMG (Black)/*/
	"optic_KHS_blk", /*/ Kahlia (Black)/*/
	"optic_KHS_hex", /*/ Kahlia (Hex)/*/
	"optic_KHS_old", /*/ Kahlia (Old)/*/
	"optic_KHS_tan", /*/ Kahlia (Tan)/*/
	"optic_LRPS", /*/ LRPS/*/
	"optic_LRPS_ghex_F", /*/ LRPS (Green Hex)/*/
	"optic_LRPS_tna_F", /*/ LRPS (Tropic)/*/
	"optic_MRCO", /*/ MRCO/*/
	"optic_MRD", /*/ MRD/*/
	"optic_NVS", /*/ NVS/*/
	"optic_SOS", /*/ MOS/*/
	"optic_SOS_khk_F", /*/ MOS (Khaki)/*/
	"optic_Yorris", /*/ Yorris J2/*/
	"muzzle_snds_338_black", /*/ Sound Suppressor (.338, Black)/*/
	"muzzle_snds_338_green", /*/ Sound Suppressor (.338, Green)/*/
	"muzzle_snds_338_sand", /*/ Sound Suppressor (.338, Sand)/*/
	"muzzle_snds_58_blk_F", /*/ Stealth Sound Suppressor (5.8 mm, Black)/*/
	"muzzle_snds_58_ghex_F", /*/ Stealth Sound Suppressor (5.8 mm, Green Hex)/*/
	"muzzle_snds_58_hex_F", /*/ Sound Suppressor (5.8 mm, Hex)/*/
	"muzzle_snds_65_TI_blk_F", /*/ Stealth Sound Suppressor (6.5 mm, Black)/*/
	"muzzle_snds_65_TI_ghex_F", /*/ Stealth Sound Suppressor (6.5 mm, Green Hex)/*/
	"muzzle_snds_65_TI_hex_F", /*/ Stealth Sound Suppressor (6.5 mm, Hex)/*/
	"muzzle_snds_93mmg", /*/ Sound Suppressor (9.3mm, Black)/*/
	"muzzle_snds_93mmg_tan", /*/ Sound Suppressor (9.3mm, Tan)/*/
	"muzzle_snds_acp", /*/ Sound Suppressor (.45 ACP)/*/
	"muzzle_snds_B", /*/ Sound Suppressor (7.62 mm)/*/
	"muzzle_snds_B_khk_F", /*/ Sound Suppressor (7.62 mm, Khaki)/*/
	"muzzle_snds_B_snd_F", /*/ Sound Suppressor (7.62 mm, Sand)/*/
	"muzzle_snds_H", /*/ Sound Suppressor (6.5 mm)/*/
	"muzzle_snds_H_khk_F", /*/ Sound Suppressor (6.5 mm, Khaki)/*/
	"muzzle_snds_H_snd_F", /*/ Sound Suppressor (6.5 mm, Sand)/*/
	"muzzle_snds_L", /*/ Sound Suppressor (9 mm)/*/
	"muzzle_snds_M", /*/ Sound Suppressor (5.56 mm)/*/
	"muzzle_snds_m_khk_F", /*/ Sound Suppressor (5.56 mm, Khaki)/*/
	"muzzle_snds_m_snd_F" /*/ Sound Suppressor (5.56 mm, Sand)/*/
];
_allWeapons = [
	"hgun_ACPC2_F", /*/ ACP-C2 .45 ACP/*/
	"hgun_ACPC2_snds_F", /*/ ACP-C2 .45 ACP/*/
	"hgun_P07_F",/*/ P07 9 mm/*/
	"hgun_P07_khk_F", /*/ P07 9 mm (Khaki)/*/
	"hgun_P07_snds_F", /*/ P07 9 mm/*/
	"hgun_Pistol_01_F", /*/ PM 9 mm/*/
	"hgun_Pistol_heavy_01_F", /*/ 4-five .45 ACP/*/
	"hgun_Pistol_heavy_01_MRD_F", /*/ 4-five .45 ACP/*/
	"hgun_Pistol_heavy_01_snds_F", /*/ 4-five .45 ACP/*/
	"hgun_Pistol_heavy_02_F", /*/ Zubr .45 ACP/*/
	"hgun_Pistol_heavy_02_Yorris_F", /*/Zubr .45 ACP/*/
	"hgun_Rook40_F", /*/Rook-40 9 mm/*/
	"hgun_Rook40_snds_F", /*/Rook-40 9 mm	/*/
	"arifle_AK12_F", /*/ AK-12 7.62 mm/*/
	"arifle_AK12_GL_F", /*/ AK-12 GL 7.62 mm/*/
	"arifle_AKM_F", /*/ AKM 7.62 mm/*/
	"arifle_AKS_F", /*/ AKS-74U 5.45 mm/*/
	"arifle_ARX_blk_F", /*/ Type 115 6.5 mm (Black)/*/
	"arifle_ARX_ghex_F", /*/ Type 115 6.5 mm (Green Hex)/*/
	"arifle_ARX_hex_F", /*/Type 115 6.5 mm (Hex)/*/
	"arifle_CTARS_blk_F", /*/ CAR-95-1 5.8mm (Black)/*/
	"arifle_CTARS_blk_Pointer_F", /*/CAR-95-1 5.8mm (Black)/*/
	"arifle_CTARS_ghex_F", /*/ CAR-95-1 5.8mm (Green Hex)/*/
	"arifle_CTARS_hex_F", /*/ CAR-95-1 5.8mm (Hex)/*/
	"arifle_CTAR_blk_ACO_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_ACO_Pointer_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_ACO_Pointer_Snds_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_ARCO_F", /*/CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_ARCO_Pointer_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_ARCO_Pointer_Snds_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_blk_Pointer_F", /*/ CAR-95 5.8 mm (Black)/*/
	"arifle_CTAR_ghex_F", /*/ CAR-95 5.8 mm (Green Hex)/*/
	"arifle_CTAR_GL_blk_ACO_F", /*/ CAR-95 GL 5.8 mm (Black)/*/
	"arifle_CTAR_GL_blk_ACO_Pointer_Snds_F", /*/ CAR-95 GL 5.8 mm (Black)/*/
	"arifle_CTAR_GL_blk_F", /*/ CAR-95 GL 5.8 mm (Black)/*/
	"arifle_CTAR_GL_ghex_F", /*/ CAR-95 GL 5.8 mm (Green Hex)/*/
	"arifle_CTAR_GL_hex_F", /*/ CAR-95 GL 5.8 mm (Hex)/*/
	"arifle_CTAR_hex_F", /*/ CAR-95 5.8 mm (Hex)/*/
	"arifle_Katiba_ACO_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_ACO_pointer_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_ACO_pointer_snds_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_ARCO_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_ARCO_pointer_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_ARCO_pointer_snds_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_C_ACO_F", /*/ Katiba Carbine 6.5 mm/*/
	"arifle_Katiba_C_ACO_pointer_F", /*/ Katiba Carbine 6.5 mm/*/
	"arifle_Katiba_C_ACO_pointer_snds_F", /*/ Katiba Carbine 6.5 mm/*/
	"arifle_Katiba_C_F", /*/ Katiba Carbine 6.5 mm/*/
	"arifle_Katiba_F", /*/ Katiba 6.5 mm/*/
	"arifle_Katiba_GL_ACO_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_GL_ACO_pointer_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_GL_ACO_pointer_snds_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_GL_ARCO_pointer_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_GL_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_GL_Nstalker_pointer_F", /*/ Katiba GL 6.5 mm/*/
	"arifle_Katiba_pointer_F", /*/ Katiba 6.5 mm/*/
	"arifle_Mk20C_ACO_F", /*/ Mk20C 5.56 mm (Camo)/*/
	"arifle_Mk20C_ACO_pointer_F", /*/ Mk20C 5.56 mm (Camo)/*/
	"arifle_Mk20C_F", /*/ Mk20C 5.56 mm (Camo)/*/
	"arifle_Mk20C_plain_F", /*/ Mk20C 5.56 mm/*/
	"arifle_Mk20_ACO_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_ACO_pointer_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_GL_ACO_F", /*/ Mk20 EGLM 5.56 mm (Camo)/*/
	"arifle_Mk20_GL_F", /*/ Mk20 EGLM 5.56 mm (Camo)/*/
	"arifle_Mk20_GL_MRCO_pointer_F", /*/ Mk20 EGLM 5.56 mm (Camo)/*/
	"arifle_Mk20_GL_plain_F", /*/ Mk20 EGLM 5.56 mm/*/
	"arifle_Mk20_Holo_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_MRCO_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_MRCO_plain_F", /*/ Mk20 5.56 mm/*/
	"arifle_Mk20_MRCO_pointer_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_Mk20_plain_F", /*/ Mk20 5.56 mm/*/
	"arifle_Mk20_pointer_F", /*/ Mk20 5.56 mm (Camo)/*/
	"arifle_MXC_ACO_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_ACO_pointer_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_ACO_pointer_snds_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_Black_F", /*/ MXC 6.5 mm (Black)/*/
	"arifle_MXC_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_Holo_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_Holo_pointer_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_Holo_pointer_snds_F", /*/ MXC 6.5 mm/*/
	"arifle_MXC_khk_ACO_F", /*/ MXC 6.5 mm (Khaki)/*/
	"arifle_MXC_khk_ACO_Pointer_Snds_F", /*/ MXC 6.5 mm (Khaki)/*/
	"arifle_MXC_khk_F", /*/ MXC 6.5 mm (Khaki)/*/
	"arifle_MXC_khk_Holo_Pointer_F", /*/ MXC 6.5 mm (Khaki)/*/
	"arifle_MXC_SOS_point_snds_F", /*/ MXC 6.5 mm/*/
	"arifle_MXM_Black_F", /*/ MXM 6.5 mm (Black)/*/
	"arifle_MXM_DMS_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_DMS_LP_BI_snds_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_Hamr_LP_BI_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_Hamr_pointer_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_khk_F", /*/ MXM 6.5 mm (Khaki)/*/
	"arifle_MXM_khk_MOS_Pointer_Bipod_F", /*/ MXM 6.5 mm (Khaki)/*/
	"arifle_MXM_RCO_pointer_snds_F", /*/ MXM 6.5 mm/*/
	"arifle_MXM_SOS_pointer_F", /*/ MXM 6.5 mm/*/
	"arifle_MX_ACO_F", /*/ MX 6.5 mm/*/
	"arifle_MX_ACO_pointer_F", /*/ MX 6.5 mm/*/
	"arifle_MX_ACO_pointer_snds_F", /*/ MX 6.5 mm/*/
	"arifle_MX_Black_F", /*/ MX 6.5 mm (Black)/*/
	"arifle_MX_Black_Hamr_pointer_F", /*/ MX 6.5 mm (Black)/*/
	"arifle_MX_F", /*/ MX 6.5 mm/*/
	"arifle_MX_GL_ACO_F", /*/ MX 3GL 6.5 mm/*/
	"arifle_MX_GL_ACO_pointer_F", /*/ MX 3GL 6.5 mm/*/
	"arifle_MX_GL_Black_F", /*/ MX 3GL 6.5 mm (Black)/*/
	"arifle_MX_GL_Black_Hamr_pointer_F", /*/ MX 3GL 6.5 mm (Black)/*/
	"arifle_MX_GL_F", /*/ MX 3GL 6.5 mm/*/
	"arifle_MX_GL_Hamr_pointer_F", /*/ MX 3GL 6.5 mm/*/
	"arifle_MX_GL_Holo_pointer_snds_F", /*/ MX 3GL 6.5 mm/*/
	"arifle_MX_GL_khk_ACO_F", /*/ MX 3GL 6.5 mm (Khaki)/*/
	"arifle_MX_GL_khk_F", /*/ MX 3GL 6.5 mm (Khaki)/*/
	"arifle_MX_GL_khk_Hamr_Pointer_F", /*/ MX 3GL 6.5 mm (Khaki)/*/
	"arifle_MX_GL_khk_Holo_Pointer_Snds_F", /*/ MX 3GL 6.5 mm (Khaki)/*/
	"arifle_MX_Hamr_pointer_F", /*/ MX 6.5 mm/*/
	"arifle_MX_Holo_pointer_F", /*/ MX 6.5 mm/*/
	"arifle_MX_khk_ACO_Pointer_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_ACO_Pointer_Snds_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_Hamr_Pointer_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_Hamr_Pointer_Snds_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_Holo_Pointer_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_khk_Pointer_F", /*/ MX 6.5 mm (Khaki)/*/
	"arifle_MX_pointer_F", /*/ MX 6.5 mm/*/
	"arifle_MX_RCO_pointer_snds_F", /*/ MX 6.5 mm/*/
	"arifle_MX_SW_Black_F", /*/ MX SW 6.5 mm (Black)/*/
	"arifle_MX_SW_Black_Hamr_pointer_F", /*/ MX SW 6.5 mm (Black)/*/
	"arifle_MX_SW_F", /*/ MX SW 6.5 mm/*/
	"arifle_MX_SW_Hamr_pointer_F", /*/ MX SW 6.5 mm/*/
	"arifle_MX_SW_khk_F", /*/ MX SW 6.5 mm (Khaki)/*/
	"arifle_MX_SW_khk_Pointer_F", /*/ MX SW 6.5 mm (Khaki)/*/
	"arifle_MX_SW_pointer_F", /*/ MX SW 6.5 mm/*/
	"arifle_SDAR_F", /*/ SDAR 5.56 mm/*/
	"arifle_SPAR_01_blk_F", /*/ SPAR-16 5.56 mm (Black)/*/
	"arifle_SPAR_01_GL_blk_F", /*/ SPAR-16 GL 5.56 mm (Black)/*/
	"arifle_SPAR_01_GL_khk_F", /*/ SPAR-16 GL 5.56 mm (Khaki)/*/
	"arifle_SPAR_01_GL_snd_F", /*/ SPAR-16 GL 5.56 mm (Sand)/*/
	"arifle_SPAR_01_khk_F", /*/ SPAR-16 5.56 mm (Khaki)/*/
	"arifle_SPAR_01_snd_F", /*/ SPAR-16 5.56 mm (Sand)/*/
	"arifle_SPAR_02_blk_F", /*/ SPAR-16S 5.56 mm (Black)/*/
	"arifle_SPAR_02_khk_F", /*/ SPAR-16S 5.56 mm (Khaki)/*/
	"arifle_SPAR_02_snd_F", /*/ SPAR-16S 5.56 mm (Sand)/*/
	"arifle_SPAR_03_blk_F", /*/ SPAR-17 7.62 mm (Black)/*/
	"arifle_SPAR_03_khk_F", /*/ SPAR-17 7.62 mm (Khaki)/*/
	"arifle_SPAR_03_snd_F", /*/ SPAR-17 7.62 mm (Sand)/*/
	"arifle_TRG20_ACO_F", /*/ TRG-20 5.56 mm/*/
	"arifle_TRG20_ACO_Flash_F", /*/ TRG-20 5.56 mm/*/
	"arifle_TRG20_ACO_pointer_F", /*/ TRG-20 5.56 mm/*/
	"arifle_TRG20_F", /*/ TRG-20 5.56 mm/*/
	"arifle_TRG20_Holo_F", /*/ TRG-20 5.56 mm/*/
	"arifle_TRG21_ACO_pointer_F", /*/ TRG-21 5.56 mm/*/
	"arifle_TRG21_ARCO_pointer_F", /*/ TRG-21 5.56 mm/*/
	"arifle_TRG21_F", /*/ TRG-21 5.56 mm/*/
	"arifle_TRG21_GL_ACO_pointer_F", /*/ TRG-21 EGLM 5.56 mm/*/
	"arifle_TRG21_GL_F", /*/ TRG-21 EGLM 5.56 mm/*/
	"arifle_TRG21_GL_MRCO_F", /*/ TRG-21 EGLM 5.56 mm/*/
	"arifle_TRG21_MRCO_F", /*/ TRG-21 5.56 mm/*/
	"hgun_PDW2000_F", /*/ PDW2000 9 mm/*/
	"hgun_PDW2000_Holo_F", /*/ PDW2000 9 mm/*/
	"hgun_PDW2000_Holo_snds_F", /*/ PDW2000 9 mm/*/
	"hgun_PDW2000_snds_F", /*/ PDW2000 9 mm/*/
	"LMG_03_F", /*/ LIM-85 5.56 mm/*/
	"LMG_Mk200_BI_F", /*/ Mk200 6.5 mm/*/
	"LMG_Mk200_F", /*/ Mk200 6.5 mm/*/
	"LMG_Mk200_LP_BI_F", /*/ Mk200 6.5 mm/*/
	"LMG_Mk200_MRCO_F", /*/ Mk200 6.5 mm/*/
	"LMG_Mk200_pointer_F", /*/ Mk200 6.5 mm/*/
	"LMG_Zafir_ARCO_F", /*/ Zafir 7.62 mm/*/
	"LMG_Zafir_F", /*/ Zafir 7.62 mm/*/
	"LMG_Zafir_pointer_F", /*/ Zafir 7.62 mm/*/
	"MMG_01_hex_ARCO_LP_F", /*/ Navid 9.3 mm (Hex)/*/
	"MMG_01_hex_F", /*/ Navid 9.3 mm (Hex)/*/
	"MMG_01_tan_F", /*/ Navid 9.3 mm (Tan)/*/
	"MMG_02_black_F", /*/ SPMG .338 (Black)/*/
	"MMG_02_black_RCO_BI_F", /*/ SPMG .338 (Black)/*/
	"MMG_02_camo_F", /*/ SPMG .338 (MTP)/*/
	"MMG_02_sand_F", /*/ SPMG .338 (Sand)/*/
	"MMG_02_sand_RCO_LP_F", /*/ SPMG .338 (Sand)/*/
	"SMG_01_ACO_F", /*/ Vermin SMG .45 ACP/*/
	"SMG_01_F", /*/ Vermin SMG .45 ACP/*/
	"SMG_01_Holo_F", /*/ Vermin SMG .45 ACP/*/
	"SMG_01_Holo_pointer_snds_F", /*/ Vermin SMG .45 ACP/*/
	"SMG_02_ACO_F", /*/ Sting 9 mm/*/
	"SMG_02_ARCO_pointg_F", /*/ Sting 9 mm/*/
	"SMG_02_F", /*/ Sting 9 mm/*/
	"SMG_05_F", /*/ Protector 9 mm/*/
	"srifle_DMR_01_ACO_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_ARCO_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_DMS_BI_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_DMS_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_DMS_snds_BI_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_DMS_snds_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_MRCO_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_01_SOS_F", /*/ Rahim 7.62 mm/*/
	"srifle_DMR_02_ACO_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_02_ARCO_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_02_camo_AMS_LP_F", /*/ MAR-10 .338 (Camo)/*/
	"srifle_DMR_02_camo_F", /*/ MAR-10 .338 (Camo)/*/
	"srifle_DMR_02_DMS_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_02_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_02_MRCO_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_02_sniper_AMS_LP_S_F", /*/ MAR-10 .338 (Sand)/*/
	"srifle_DMR_02_sniper_F", /*/ MAR-10 .338 (Sand)/*/
	"srifle_DMR_02_SOS_F", /*/ MAR-10 .338 (Black)/*/
	"srifle_DMR_03_ACO_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_AMS_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_ARCO_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_DMS_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_DMS_snds_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_khaki_F", /*/ Mk-I EMR 7.62 mm (Khaki)/*/
	"srifle_DMR_03_MRCO_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_multicam_F", /*/ Mk-I EMR 7.62 mm (Camo)/*/
	"srifle_DMR_03_SOS_F", /*/ Mk-I EMR 7.62 mm (Black)/*/
	"srifle_DMR_03_tan_AMS_LP_F", /*/ Mk-I EMR 7.62 mm (Sand)/*/
	"srifle_DMR_03_tan_F", /*/ Mk-I EMR 7.62 mm (Sand)/*/
	"srifle_DMR_03_woodland_F", /*/ Mk-I EMR 7.62 mm (Woodland)/*/
	"srifle_DMR_04_ACO_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_ARCO_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_DMS_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_MRCO_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_NS_LP_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_SOS_F", /*/ ASP-1 Kir 12.7 mm (Black)/*/
	"srifle_DMR_04_Tan_F", /*/ ASP-1 Kir 12.7 mm (Tan)/*/
	"srifle_DMR_05_ACO_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_ARCO_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_blk_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_DMS_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_DMS_snds_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_hex_F", /*/ Cyrus 9.3 mm (Hex)/*/
	"srifle_DMR_05_KHS_LP_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_MRCO_F", /*/ Cyrus 9.3 mm (Black)/*/
	"srifle_DMR_05_SOS_F", /*/ Cyrus 9.3 mm (Black/*/
	"srifle_DMR_05_tan_f", /*/ Cyrus 9.3 mm (Tan)/*/
	"srifle_DMR_06_camo_F", /*/ Mk14 7.62 mm (Camo/*/
	"srifle_DMR_06_camo_khs_F", /*/ Mk14 7.62 mm (Camo)/*/
	"srifle_DMR_06_olive_F", /*/ Mk14 7.62 mm (Olive)/*/
	"srifle_DMR_07_blk_DMS_F", /*/ CMR-76 6.5 mm (Black)/*/
	"srifle_DMR_07_blk_DMS_Snds_F", /*/ CMR-76 6.5 mm (Black)/*/
	"srifle_DMR_07_blk_F", /*/ CMR-76 6.5 mm (Black)/*/
	"srifle_DMR_07_ghex_F", /*/ CMR-76 6.5 mm (Green Hex)/*/
	"srifle_DMR_07_hex_F", /*/ CMR-76 6.5 mm (Hex)/*/
	"srifle_EBR_ACO_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_ARCO_pointer_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_ARCO_pointer_snds_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_DMS_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_DMS_pointer_snds_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_Hamr_pointer_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_MRCO_LP_BI_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_MRCO_pointer_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_EBR_SOS_F", /*/ Mk18 ABR 7.62 mm/*/
	"srifle_GM6_camo_F", /*/ GM6 Lynx 12.7 mm (Camo)/*/
	"srifle_GM6_camo_LRPS_F", /*/ GM6 Lynx 12.7 mm (Camo)/*/
	"srifle_GM6_camo_SOS_F", /*/ GM6 Lynx 12.7 mm (Camo)/*/
	"srifle_GM6_F", /*/ GM6 Lynx 12.7 mm/*/
	"srifle_GM6_ghex_F", /*/ GM6 Lynx 12.7 mm (Green Hex)/*/
	"srifle_GM6_ghex_LRPS_F", /*/ GM6 Lynx 12.7 mm (Green Hex)/*/
	"srifle_GM6_LRPS_F", /*/ GM6 Lynx 12.7 mm/*/
	"srifle_GM6_SOS_F", /*/ GM6 Lynx 12.7 mm/*/
	"srifle_LRR_camo_F", /*/ M320 LRR .408 (Camo)/*/
	"srifle_LRR_camo_LRPS_F", /*/ M320 LRR .408 (Camo)/*/
	"srifle_LRR_camo_SOS_F", /*/ M320 LRR .408 (Camo)/*/
	"srifle_LRR_F", /*/ M320 LRR .408/*/
	"srifle_LRR_LRPS_F", /*/ M320 LRR .408/*/
	"srifle_LRR_SOS_F", /*/ M320 LRR .408/*/
	"srifle_LRR_tna_F", /*/ M320 LRR .408 (Tropic)/*/
	"srifle_LRR_tna_LRPS_F" /*/ M320 LRR .408 (Tropic)/*/
];
_allMagazines = [
	"100Rnd_580x42_Mag_F", /*/ 5.8 mm 100Rnd Mag/*/
	"100Rnd_580x42_Mag_Tracer_F", /*/ 5.8 mm 100Rnd Tracer (Green) Mag/*/
	"100Rnd_65x39_caseless_mag", /*/ 6.5 mm 100Rnd Mag/*/
	"100Rnd_65x39_caseless_mag_Tracer", /*/ 6.5 mm 100Rnd Tracer (Red) Mag/*/
	"10Rnd_127x54_Mag", /*/ 12.7mm 10Rnd Mag/*/
	"10Rnd_338_Mag", /*/ .338 LM 10Rnd Mag/*/
	"10Rnd_50BW_Mag_F", /*/ .50 BW 10Rnd Caseless Mag/*/
	"10Rnd_762x51_Mag", /*/ 7.62mm 10Rnd Mag/*/
	"10Rnd_762x54_Mag", /*/ 7.62mm 10Rnd Mag/*/
	"10Rnd_93x64_DMR_05_Mag", /*/ 9.3mm 10Rnd Mag/*/
	"10Rnd_9x21_Mag", /*/ 9 mm 10Rnd Mag/*/
	"11Rnd_45ACP_Mag", /*/ .45 ACP 11Rnd Mag/*/
	"130Rnd_338_Mag", /*/ .338 NM 130Rnd Belt/*/
	"150Rnd_556x45_Drum_Mag_F", /*/ 5.56 mm 150Rnd Mag/*/
	"150Rnd_556x45_Drum_Mag_Tracer_F", /*/ 5.56 mm 150Rnd Tracer (Red) Mag/*/
	"150Rnd_762x51_Box", /*/ 7.62 mm 150Rnd Box/*/
	"150Rnd_762x51_Box_Tracer", /*/ 7.62 mm 150Rnd Tracer (Green) Box/*/
	"150Rnd_762x54_Box", /*/ 7.62 mm 150Rnd Box/*/
	"150Rnd_762x54_Box_Tracer", /*/ 7.62 mm 150Rnd Tracer (Green) Box/*/
	"150Rnd_93x64_Mag", /*/ 9.3mm 150Rnd Belt/*/
	"16Rnd_9x21_green_Mag", /*/ 9 mm 16Rnd Reload Tracer (Green) Mag/*/
	"16Rnd_9x21_Mag", /*/ 9 mm 16Rnd Mag/*/
	"16Rnd_9x21_red_Mag", /*/ 9 mm 16Rnd Reload Tracer (Red) Mag/*/
	"16Rnd_9x21_yellow_Mag", /*/ 9 mm 16Rnd Reload Tracer (Yellow) Mag/*/
	"1Rnd_HE_Grenade_shell", /*/ 40 mm HE Grenade Round/*/
	"1Rnd_SmokeBlue_Grenade_shell", /*/ Smoke Round (Blue)/*/
	"1Rnd_SmokeGreen_Grenade_shell", /*/ Smoke Round (Green)/*/
	"1Rnd_SmokeOrange_Grenade_shell", /*/ Smoke Round (Orange)/*/
	"1Rnd_SmokePurple_Grenade_shell", /*/ Smoke Round (Purple)/*/
	"1Rnd_SmokeRed_Grenade_shell", /*/ Smoke Round (Red)/*/
	"1Rnd_SmokeYellow_Grenade_shell", /*/ Smoke Round (Yellow)/*/
	"1Rnd_Smoke_Grenade_shell", /*/ Smoke Round (White)/*/
	"200Rnd_556x45_Box_F", /*/ 5.56 mm 200Rnd Reload Tracer (Yellow) Box/*/
	"200Rnd_556x45_Box_Red_F", /*/ 5.56 mm 200Rnd Reload Tracer (Red) Box/*/
	"200Rnd_556x45_Box_Tracer_F", /*/ 5.56 mm 200Rnd Tracer (Yellow) Box/*/
	"200Rnd_556x45_Box_Tracer_Red_F", /*/ 5.56 mm 200Rnd Tracer (Red) Box/*/
	"200Rnd_65x39_cased_Box", /*/ 6.5 mm 200Rnd Belt/*/
	"200Rnd_65x39_cased_Box_Tracer", /*/ 6.5 mm 200Rnd Belt Tracer (Yellow)/*/
	"20Rnd_556x45_UW_mag", /*/ 5.56 mm 20Rnd Dual Purpose Mag/*/
	"20Rnd_650x39_Cased_Mag_F", /*/ 6.5 mm 20Rnd Mag/*/
	"20Rnd_762x51_Mag", /*/ 7.62 mm 20Rnd Mag/*/
	"30Rnd_45ACP_Mag_SMG_01", /*/ .45 ACP 30Rnd Vermin Mag/*/
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Green", /*/ .45 ACP 30Rnd Vermin Tracers (Green) Mag/*/
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Red", /*/ .45 ACP 30Rnd Vermin Tracers (Red) Mag/*/
	"30Rnd_45ACP_Mag_SMG_01_Tracer_Yellow", /*/ .45 ACP 30Rnd Vermin Tracers (Yellow) Mag/*/
	"30Rnd_545x39_Mag_F", /*/ 5.45 mm 30Rnd Reload Tracer (Yellow) Mag/*/
	"30Rnd_545x39_Mag_Green_F", /*/ 5.45 mm 30Rnd Reload Tracer (Green) Mag/*/
	"30Rnd_545x39_Mag_Tracer_F", /*/ 5.45 mm 30Rnd Tracer (Yellow) Mag/*/
	"30Rnd_545x39_Mag_Tracer_Green_F", /*/ 5.45 mm 30Rnd Tracer (Green) Mag/*/
	"30Rnd_556x45_Stanag", /*/ 5.56 mm 30rnd STANAG Reload Tracer (Yellow) Mag/*/
	"30Rnd_556x45_Stanag_green", /*/ 5.56 mm 30rnd STANAG Reload Tracer (Green) Mag/*/
	"30Rnd_556x45_Stanag_red", /*/ 5.56 mm 30rnd STANAG Reload Tracer (Red) Mag/*/
	"30Rnd_556x45_Stanag_Tracer_Green", /*/ 5.56 mm 30rnd Tracer (Green) Mag/*/
	"30Rnd_556x45_Stanag_Tracer_Red", /*/ 5.56 mm 30rnd Tracer (Red) Mag/*/
	"30Rnd_556x45_Stanag_Tracer_Yellow", /*/ 5.56 mm 30rnd Tracer (Yellow) Mag/*/
	"30Rnd_580x42_Mag_F", /*/ 5.8 mm 30Rnd Mag/*/
	"30Rnd_580x42_Mag_Tracer_F", /*/ 5.8 mm 30Rnd Tracer (Green) Mag/*/
	"30Rnd_65x39_caseless_green", /*/ 6.5mm 30Rnd Caseless Mag/*/
	"30Rnd_65x39_caseless_green_mag_Tracer", /*/ 6.5 mm 30Rnd Tracer (Green) Caseless Mag/*/
	"30Rnd_65x39_caseless_mag", /*/ 6.5 mm 30Rnd STANAG Mag/*/
	"30Rnd_65x39_caseless_mag_Tracer", /*/ 6.5 mm 30Rnd Tracer (Red) Mag/*/
	"30Rnd_762x39_Mag_F", /*/ 7.62 mm 30Rnd Reload Tracer (Yellow) Mag/*/
	"30Rnd_762x39_Mag_Green_F", /*/ 7.62 mm 30Rnd Reload Tracer (Green) Mag/*/
	"30Rnd_762x39_Mag_Tracer_F", /*/ 7.62 mm 30Rnd Tracer (Yellow) Mag/*/
	"30Rnd_762x39_Mag_Tracer_Green_F", /*/ 7.62 mm 30Rnd Tracer (Green) Mag/*/
	"30Rnd_9x21_Green_Mag", /*/ 9 mm 30Rnd Reload Tracer (Green) Mag/*/
	"30Rnd_9x21_Mag", /*/ 9 mm 30Rnd Mag/*/
	"30Rnd_9x21_Mag_SMG_02", /*/ 9 mm 30Rnd Mag/*/
	"30Rnd_9x21_Mag_SMG_02_Tracer_Green", /*/ 9 mm 30Rnd Reload Tracer (Green) Mag/*/
	"30Rnd_9x21_Mag_SMG_02_Tracer_Red", /*/ 9 mm 30Rnd Reload Tracer (Red) Mag/*/
	"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow", /*/ 9 mm 30Rnd Reload Tracer (Yellow) Mag/*/
	"30Rnd_9x21_Red_Mag", /*/ 9 mm 30Rnd Reload Tracer (Red) Mag/*/
	"30Rnd_9x21_Yellow_Mag", /*/ 9 mm 30Rnd Reload Tracer (Yellow) Mag/*/
	"3Rnd_HE_Grenade_shell", /*/ 40 mm 3Rnd HE Grenade/*/
	"3Rnd_SmokeBlue_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Blue)/*/
	"3Rnd_SmokeGreen_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Green)/*/
	"3Rnd_SmokeOrange_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Orange)/*/
	"3Rnd_SmokePurple_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Purple)/*/
	"3Rnd_SmokeRed_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Red)/*/
	"3Rnd_SmokeYellow_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (Yellow)/*/
	"3Rnd_Smoke_Grenade_shell", /*/ 3Rnd 3GL Smoke Rounds (White)/*/
	"3Rnd_UGL_FlareCIR_F", /*/ 3Rnd 3GL Flares (IR)/*/
	"3Rnd_UGL_FlareGreen_F", /*/ 3Rnd 3GL Flares (Green)/*/
	"3Rnd_UGL_FlareRed_F", /*/ 3Rnd 3GL Flares (Red)/*/
	"3Rnd_UGL_FlareWhite_F", /*/ 3Rnd 3GL Flares (White)/*/
	"3Rnd_UGL_FlareYellow_F", /*/ 3Rnd 3GL Flares (Yellow)/*/
	"5Rnd_127x108_APDS_Mag", /*/ 12.7mm 5Rnd APDS Mag/*/
	"5Rnd_127x108_Mag", /*/ 12.7 mm 5Rnd Mag/*/
	"6Rnd_45ACP_Cylinder", /*/ .45 ACP 6Rnd Cylinder/*/
	"7Rnd_408_Mag", /*/ .408 7Rnd LRR Mag/*/
	"9Rnd_45ACP_Mag", /*/ .45 ACP 9Rnd Mag/*/
	"Laserbatteries", /*/ Designator Batteries/*/
	"NLAW_F", /*/ PCML Missile/*/
	"RPG32_F", /*/ RPG-42 Rocket/*/
	"RPG32_HE_F", /*/ RPG-42 HE Rocket/*/
	"RPG7_F", /*/ PG-7VM HEAT Grenade/*/
	"Titan_AA", /*/ Titan AA Missile/*/
	"Titan_AP", /*/ Titan AP Missile/*/
	"Titan_AT", /*/ Titan AT Missile/*/
	'vorona_heat',
	'vorona_he',
	'mraws_heat_f',
	'mraws_he_f'
];
if (_type isEqualTo 0) then {
	//comment 'Randomize';
	_entityType = toLowerANSI (typeOf _entity);
	private _weaponType = '';
	private _magazineType = '';
	private _backpackType = '';
	private _weaponsToAdd = [];
	private _weaponTypesToAdd = [];
	private _magazinesToAdd = [];
	private _magazineTypesToAdd = [];
	private _backpacksToAdd = [];
	private _backpackTypesToAdd = [];
	private _weaponTypeUnique = '';
	private _magazineTypeUnique = '';
	private _backpackTypeUnique = '';
	private _cfgEntity = configfile >> 'cfgvehicles' >> _entityType;
	private _cfgTransportMaxBackpacks = getNumber (_cfgEntity >> 'transportMaxBackpacks');
	private _cfgTransportMaxMagazines = getNumber (_cfgEntity >> 'transportMaxMagazines');
	private _cfgTransportMaxWeapons = getNumber (_cfgEntity >> 'transportMaxWeapons');
	_maxBackpacks = round (_cfgTransportMaxBackpacks * 0.1);
	_maxMagazines = round (_cfgTransportMaxMagazines * 0.75);
	_maxWeapons = round (_cfgTransportMaxWeapons * 0.25);
	_qtyBackpacks = round (_maxBackpacks / 2);
	_qtyMagazines = round (_maxMagazines / 2); 
	_qtyWeapons = round (_maxWeapons / 2);
		//comment 'Magazines';
		_magazineTypesToAdd = [];
		_magazinesToAdd = [];
		for '_x' from 0 to (_qtyMagazines - 1) step 1 do {
			_magazineType = selectRandom _allMagazines;
			_magazineTypesToAdd pushBackUnique (toLowerANSI _magazineType);
			_magazinesToAdd pushBack (toLowerANSI _magazineType);
		};
		{
			_magazineTypeUnique = _x;
			_entity addMagazineCargoGlobal [_magazineTypeUnique,({_x isEqualTo _magazineTypeUnique} count _magazinesToAdd)];
		} forEach _magazineTypesToAdd;
		//comment 'Items';
		for '_x' from 0 to 5 step 1 do {
			_entity addItemCargoGlobal [(selectRandom _allItems),1];
		};
		//comment 'Weapons';
		_weaponTypesToAdd = [];
		_weaponsToAdd = [];
		for '_x' from 0 to (_qtyWeapons - 1) step 1 do {
			_weaponType = selectRandom _allWeapons;
			_weaponTypesToAdd pushBackUnique (toLowerANSI _weaponType);
			_weaponsToAdd pushBack (toLowerANSI _weaponType);
		};		
		{
			_weaponTypeUnique = _x;
			_entity addWeaponCargoGlobal [_weaponTypeUnique,({_x isEqualTo _weaponTypeUnique} count _weaponsToAdd)];
		} forEach _weaponTypesToAdd;
};
if (_type isEqualTo 1) then {
	//comment 'Preset';
	_entityType = toLowerANSI (typeOf _entity);
	private _weaponType = '';
	private _magazineType = '';
	private _backpackType = '';
	private _weaponsToAdd = [];
	private _weaponTypesToAdd = [];
	private _magazinesToAdd = [];
	private _magazineTypesToAdd = [];
	private _backpacksToAdd = [];
	private _backpackTypesToAdd = [];
	private _weaponTypeUnique = '';
	private _magazineTypeUnique = '';
	private _backpackTypeUnique = '';
	private _cfgEntity = configfile >> 'cfgvehicles' >> _entityType;
	private _cfgTransportMaxBackpacks = getNumber (_cfgEntity >> 'transportMaxBackpacks');
	private _cfgTransportMaxMagazines = getNumber (_cfgEntity >> 'transportMaxMagazines');
	private _cfgTransportMaxWeapons = getNumber (_cfgEntity >> 'transportMaxWeapons');
	//comment 'Fill to 50 percent';
	_maxBackpacks = round (_cfgTransportMaxBackpacks * 0.1);
	_maxMagazines = round (_cfgTransportMaxMagazines * 0.25);
	_maxWeapons = round (_cfgTransportMaxWeapons * 0.15);
	_qtyBackpacks = round (_maxBackpacks / 2);
	_qtyMagazines = round (_maxMagazines / 2); 
	_qtyWeapons = round (_maxWeapons / 2);

	//comment 'Default items';
	if ((_entityType in [
		"b_slingload_01_ammo_f","b_slingload_01_cargo_f","b_slingload_01_fuel_f","b_slingload_01_medevac_f","b_slingload_01_repair_f",
		"i_supplycrate_f","o_supplycrate_f","c_t_supplycrate_f","c_supplycrate_f","ig_supplycrate_f","b_supplycrate_f",
		"b_cargonet_01_ammo_f","i_cargonet_01_ammo_f","o_cargonet_01_ammo_f",'i_e_cargonet_01_ammo_f'
	]) || (_entity isKindOf 'LandVehicle')) then {
		if (_entityType in ["b_cargonet_01_ammo_f","i_cargonet_01_ammo_f","o_cargonet_01_ammo_f"]) then {
			_cfgEntity = configfile >> 'cfgvehicles' >> 'b_supplycrate_f';
			_cfgTransportMaxBackpacks = round ((getNumber (_cfgEntity >> 'transportMaxBackpacks')) * 0.1);
			_cfgTransportMaxMagazines = round ((getNumber (_cfgEntity >> 'transportMaxMagazines')) * 1);
			_cfgTransportMaxWeapons = round ((getNumber (_cfgEntity >> 'transportMaxWeapons')) * 0.5);
		};
		clearItemCargoGlobal _entity;
		clearWeaponCargoGlobal _entity;
		clearMagazineCargoGlobal _entity;
		clearBackpackCargoGlobal _entity;
		//comment 'Items';
		{
			_entity addItemCargoGlobal _x;
		} forEach [
			[QS_core_classNames_itemFirstAidKit,(round (10 + (random 5)))],
			['SmokeShell',(round (5 + (random 5)))],
			['SmokeShellBlue',(round (2 + (random 2)))],
			[(['NVGoggles','NVGoggles_tna_F'] select (worldName isEqualTo 'Tanoa')),2],
			[QS_core_classNames_itemMedikit,1],
			[QS_core_classNames_itemToolKit,1],
			[QS_core_classNames_itemRadio,2]
		];
		//comment 'Magazines';
		for '_x' from 0 to (_maxMagazines - 1) step 1 do {
			_magazineType = selectRandomWeighted [
				'30Rnd_556x45_Stanag_Tracer_Red',0.6,
				'30Rnd_65x39_caseless_mag_Tracer',0.5,
				'20Rnd_762x51_Mag',0.2,
				'NLAW_F',0.1
			];
			_magazineTypesToAdd pushBackUnique (toLowerANSI _magazineType);
			_magazinesToAdd pushBack (toLowerANSI _magazineType);
		};
		{
			_magazineTypeUnique = _x;
			_entity addMagazineCargoGlobal [_magazineTypeUnique,({_x isEqualTo _magazineTypeUnique} count _magazinesToAdd)];
		} forEach _magazineTypesToAdd;
		//comment 'Weapons';
		for '_x' from 0 to (_maxWeapons - 1) step 1 do {
			_weaponType = selectRandomWeighted [
				'arifle_spar_01_blk_erco_pointer_f',0.5,
				'arifle_MX_Black_Hamr_pointer_F',0.4,
				'srifle_DMR_06_olive_F',0.2,
				'launch_nlaw_f',0.2
			];
			_weaponTypesToAdd pushBackUnique (toLowerANSI _weaponType);
			_weaponsToAdd pushBack (toLowerANSI _weaponType);
		};
		{
			_weaponTypeUnique = _x;
			_entity addWeaponCargoGlobal [_weaponTypeUnique,({_x isEqualTo _weaponTypeUnique} count _weaponsToAdd)];
		} forEach _weaponTypesToAdd;		
		//comment 'Backpacks';
		for '_x' from 0 to (_maxBackpacks - 1) step 1 do {
			_backpackType = selectRandomWeighted [
				'B_AssaultPack_rgr',0.25,
				'B_Kitbag_rgr',0.25,
				'B_FieldPack_oli',0.25,
				'B_Bergen_rgr',0.25
			];
			_backpackTypesToAdd pushBackUnique (toLowerANSI _backpackType);
			_backpacksToAdd pushBack (toLowerANSI _backpackType);
		};
		{
			_backpackTypeUnique = _x;
			_entity addBackpackCargoGlobal [_backpackTypeUnique,({_x isEqualTo _backpackTypeUnique} count _backpacksToAdd)];
		} forEach _backpackTypesToAdd;
		
		//comment 'Now randomized';
		//comment 'Magazines';
		_magazineTypesToAdd = [];
		_magazinesToAdd = [];
		for '_x' from 0 to (_qtyMagazines - 1) step 1 do {
			_magazineType = selectRandom _allMagazines;
			_magazineTypesToAdd pushBackUnique (toLowerANSI _magazineType);
			_magazinesToAdd pushBack (toLowerANSI _magazineType);
		};
		{
			_magazineTypeUnique = _x;
			_entity addMagazineCargoGlobal [_magazineTypeUnique,({_x isEqualTo _magazineTypeUnique} count _magazinesToAdd)];
		} forEach _magazineTypesToAdd;
		//comment 'Items';
		for '_x' from 0 to 5 step 1 do {
			_entity addItemCargoGlobal [(selectRandom _allItems),1];
		};
		//comment 'Weapons';
		_weaponTypesToAdd = [];
		_weaponsToAdd = [];
		for '_x' from 0 to (_qtyWeapons - 1) step 1 do {
			_weaponType = selectRandom _allWeapons;
			_weaponTypesToAdd pushBackUnique (toLowerANSI _weaponType);
			_weaponsToAdd pushBack (toLowerANSI _weaponType);
		};		
		{
			_weaponTypeUnique = _x;
			_entity addWeaponCargoGlobal [_weaponTypeUnique,({_x isEqualTo _weaponTypeUnique} count _weaponsToAdd)];
		} forEach _weaponTypesToAdd;		
	};
};