/*/
File: QS_data_arsenalCDLC.sqf
Author:

	Quiksilver
	
Last modified:

	1/12/2022 A3 2.10 by Quiksilver
	
Description:

	CDLC Arsenal
_______________________________________________/*/

QS_array = [];
onEachFrame {
	{
		QS_array pushBackUnique _x;
	} forEach (handgunItems QS_unit);
};
copyToClipboard str QS_array;

author = "Global Mobilization";

QS_array2 = [];
_config = configFile >> 'CfgMagazines';
private _configClass = '';
private _configName = '';
private _text = '';
private _type = 0;
for '_i' from 0 to ((count _config) - 1) step 1 do {
	_configClass = _config select _i;
	_configName = configName _configClass;
	_text = getText (_config >> _configName >> 'author');
	_type = getNumber (_config >> _configName >> 'type');
	if (_text == "Global Mobilization") then {
		if (_type >= 256) then {
			QS_array2 pushBack _configName;
		};
	};
};
copyToClipboard str QS_array2;






// Western Sahara

// Uniforms
["U_lxWS_Djella_02_Sand","U_lxWS_Djella_02_Brown","U_lxWS_Djella_02_Grey","U_lxWS_Djella_03_Green","U_lxWS_B_CombatUniform_desert","U_lxWS_B_CombatUniform_desert_tshirt","U_lxWS_SFIA_soldier_2_O","U_lxWS_SFIA_Officer_1_O","U_lxWS_SFIA_soldier_1_O","U_lxWS_UN_Camo2","U_lxWS_UN_Camo1","U_lxWS_UN_Camo3","U_lxWS_C_Djella_03","U_lxWS_C_Djella_06","U_lxWS_C_Djella_02","U_lxWS_C_Djella_02a","U_lxWS_C_Djella_07","U_lxWS_C_Djella_05","U_lxWS_C_Djella_04","U_lxWS_C_Djella_01","U_lxWS_Tak_02_B","U_lxWS_Tak_02_C","U_lxWS_Tak_02_A","U_lxWS_Tak_03_B","U_lxWS_Tak_03_A","U_lxWS_Tak_03_C","U_lxWS_Tak_01_C","U_lxWS_Tak_01_B","U_lxWS_Tak_01_A","U_lxWS_ION_Casual3","U_lxWS_ION_Casual6","U_lxWS_ION_Casual5","U_lxWS_ION_Casual2","U_lxWS_ION_Casual4","U_B_CTRG_3_lxWS","U_B_CTRG_4_lxWS","U_SFIA_deserter_lxWS","U_lxWS_SFIA_deserter","U_O_LCF_noInsignia_hex_lxws","U_lxWS_SFIA_pilot_O","U_lxWS_UN_Pilot","U_lxWS_B_CombatUniform_desert_vest","U_lxWS_SFIA_Tanker_O"]

// Vest
["","V_lxWS_PlateCarrierGL_desert","V_lxWS_PlateCarrier1_desert","V_lxWS_PlateCarrier2_desert","V_lxWS_PlateCarrierSpec_desert","V_PlateCarrier_CTRG_lxWS","V_lxWS_UN_Vest_Lite_F","V_lxWS_UN_Vest_F","V_lxWS_HarnessO_oli","V_lxWS_TacVestIR_oli"]

// Backpack
["","B_AssaultPack_desert_lxWS","B_Carryall_desert_lxWS","B_Kitbag_desert_lxWS","I_shield_backpack_lxWS","B_shield_backpack_lxWS","O_shield_backpack_GHEX_lxWS","O_shield_backpack_lxWS","ION_UAV_02_backpack_lxWS","I_UAV_02_backpack_lxWS","O_UAV_02_backpack_lxWS","B_UAV_02_backpack_lxWS","ION_UAV_01_backpack_lxWS","B_G_UAV_02_IED_backpack_lxWS","B_Tura_UAV_02_IED_backpack_lxWS","CIV_UAV_01_backpack_lxWS"]

//Headgear
["","lxWS_H_bmask_base","H_turban_02_mask_black_lxws","lxWS_H_bmask_ghex","lxWS_H_bmask_hex","H_turban_02_mask_hex_lxws","lxWS_H_bmask_camo01","H_bmask_snake_lxws","H_turban_02_mask_snake_lxws","lxWS_H_bmask_white","lxWS_H_bmask_camo02","lxWS_H_bmask_yellow","lxWS_H_Bandanna_blk_hs","lxWS_H_PASGT_goggles_UN_F","lxWS_H_PASGT_goggles_black_F","lxWS_H_PASGT_goggles_olive_F","lxWS_H_PASGT_goggles_white_F","lxWS_H_Booniehat_desert","lxWS_H_Beret_Colonel","H_Cap_headphones_ion_lxws","lxWS_H_CapB_rvs_blk_ION","lxWS_H_HelmetCrew_I","lxWS_H_HelmetCrew_Blue","lxWS_H_Tank_tan_F","lxWS_H_MilCap_desert","lxWS_H_Headset","lxWS_H_ssh40_black","lxWS_H_ssh40_blue","lxWS_H_ssh40_green","lxWS_H_ssh40_sand","lxWS_H_ssh40_white","lxWS_H_ssh40_un","lxWS_H_cloth_5_A","lxWS_H_cloth_5_C","lxWS_H_cloth_5_B","lxWS_H_turban_03_black","lxWS_H_turban_03_blue","lxWS_H_turban_03_blue_una","lxWS_H_turban_03_green","lxWS_H_turban_03_green_pattern","lxWS_H_turban_03_orange","lxWS_H_turban_03_red","lxWS_H_turban_03_sand","lxWS_H_turban_03_gray","lxWS_H_turban_03_yellow","lxWS_H_turban_04_black","lxWS_H_turban_04_blue","lxWS_H_turban_04_blue_una","lxWS_H_turban_04_green","lxWS_H_turban_04_red","lxWS_H_turban_04_sand","lxWS_H_turban_04_gray","lxWS_H_turban_04_yellow","lxWS_H_turban_02_black","lxWS_H_turban_02_blue","lxWS_H_turban_02_blue_una","lxWS_H_turban_02_green","lxWS_H_turban_02_green_pattern","lxWS_H_turban_02_orange","lxWS_H_turban_02_red","lxWS_H_turban_02_sand","lxWS_H_turban_02_gray","lxWS_H_turban_02_yellow","lxWS_H_turban_01_black","lxWS_H_turban_01_blue","lxWS_H_turban_01_blue_una","lxWS_H_turban_01_green","lxWS_H_turban_01_red","lxWS_H_turban_01_sand","lxWS_H_turban_01_gray","lxWS_H_turban_01_yellow"]

// Goggles
["","G_Balaclava_blk_lxWS","G_Balaclava_oli_lxWS","G_Balaclava_snd_lxWS","G_Combat_lxWS","G_Headset_lxWS"]

// Binocular (camera)
"Camera_lxWS"

// Primary Weapons
["","sgun_aa40_lxWS","sgun_aa40_snake_lxWS","sgun_aa40_tan_lxWS","arifle_Galat_lxWS","arifle_Galat_worn_lxWS","glaunch_GLX_lxWS","glaunch_GLX_camo_lxWS","glaunch_GLX_ghex_lxWS","glaunch_GLX_hex_lxWS","glaunch_GLX_snake_lxWS","glaunch_GLX_tan_lxWS","srifle_EBR_blk_lxWS","srifle_EBR_snake_lxWS","LMG_S77_lxWS","LMG_S77_AAF_lxWS","LMG_S77_Desert_lxWS","LMG_S77_GHex_lxWS","LMG_S77_Hex_lxWS","LMG_S77_Compact_lxWS","LMG_S77_Compact_Snakeskin_lxWS","arifle_SLR_V_lxWS","arifle_SLR_D_lxWS","arifle_SLR_V_camo_lxWS","arifle_SLR_lxWS","arifle_SLR_V_GL_lxWS","arifle_SLR_GL_lxWS","arifle_Velko_lxWS","arifle_VelkoR5_lxWS","arifle_VelkoR5_snake_lxWS","arifle_VelkoR5_GL_lxWS","arifle_VelkoR5_GL_snake_lxWS","arifle_XMS_Base_lxWS","arifle_XMS_Base_khk_lxWS","arifle_XMS_Base_Sand_lxWS","arifle_XMS_GL_lxWS","arifle_XMS_GL_khk_lxWS","arifle_XMS_GL_Sand_lxWS","arifle_XMS_Shot_lxWS","arifle_XMS_Shot_khk_lxWS","arifle_XMS_Shot_Sand_lxWS","arifle_XMS_M_lxWS","arifle_XMS_M_khk_lxWS","arifle_XMS_M_Sand_lxWS"]

// Secondary Weapons

// Handgun Weapons


//Primary weapon items
["","arifle_XMS_M_Sand_lxWS","optic_Arco_hex_lxWS","optic_Holosight_snake_lxWS","optic_Holosight_smg_snake_lxWS","optic_Hamr_arid_lxWS","optic_Hamr_lush_lxWS","optic_Hamr_sand_lxWS","optic_Hamr_snake_lxWS","optic_r1_high_arid_lxWS","optic_r1_high_lxWS","optic_r1_high_khaki_lxWS","optic_r1_high_lush_lxWS","optic_r1_high_sand_lxWS","optic_r1_high_snake_lxWS","optic_r1_low_arid_lxWS","optic_r1_low_lxWS","optic_r1_low_khaki_lxWS","optic_r1_low_lush_lxWS","optic_r1_low_sand_lxWS","optic_r1_low_snake_lxWS","acc_pointer_IR_arid_lxWS","acc_pointer_IR_lush_lxWS","acc_pointer_IR_sand_lxWS","acc_pointer_IR_snake_lxWS","saber_light_lxWS","saber_light_arid_lxWS","saber_light_khaki_lxWS","saber_light_lush_lxWS","saber_light_sand_lxWS","saber_light_snake_lxWS","saber_light_ir_lxWS","saber_light_ir_arid_lxWS","saber_light_ir_khaki_lxWS","saber_light_ir_lush_lxWS","saber_light_ir_sand_lxWS","saber_light_ir_snake_lxWS","suppressor_l_lxWS","suppressor_l_arid_lxWS","suppressor_l_khaki_lxWS","suppressor_l_lush_lxWS","suppressor_l_sand_lxWS","suppressor_l_snake_lxWS"]
["muzzle_snds_12Gauge_snake_lxWS","saber_light_ir_snake_lxWS","optic_r1_low_snake_lxWS","","sgun_aa40_tan_lxWS","muzzle_snds_12Gauge_lxWS"]

// Magazines
[
	"30Rnd_762x51_slr_lxWS",
	"30Rnd_762x51_slr_reload_tracer_green_lxWS",
	"30Rnd_762x51_slr_desert_lxWS",
	"30Rnd_762x51_slr_desert_reload_tracer_green_lxWS",
	"20Rnd_762x51_slr_lxWS",
	"20Rnd_762x51_slr_reload_tracer_green_lxWS",
	"20Rnd_762x51_slr_desert_lxWS",
	"20Rnd_762x51_slr_desert_reload_tracer_green_lxWS",
	"30Rnd_762x51_slr_tracer_green_lxWS",
	"30Rnd_762x51_slr_desert_tracer_green_lxWS",
	"20Rnd_762x51_slr_tracer_green_lxWS",
	"20Rnd_762x51_slr_desert_tracer_green_lxWS",
	"75Rnd_556x45_Stanag_lxWS",
	"75Rnd_556x45_Stanag_green_lxWS",
	"75Rnd_556x45_Stanag_red_lxWS",
	"6rnd_Smoke_Mag_lxWS",
	"6rnd_HE_Mag_lxWS",
	"2rnd_HE_Mag_lxWS",
	"2rnd_Smoke_Mag_lxWS",
	"PropCamera_lxWS",
	"35Rnd_556x45_Velko_lxWS",
	"35Rnd_556x45_Velko_snake_lxWS",
	"50Rnd_556x45_Velko_lxWS",
	"50Rnd_556x45_Velko_snake_lxWS",
	"35Rnd_556x45_Velko_reload_tracer_yellow_lxWS",
	"35Rnd_556x45_Velko_snake_reload_tracer_yellow_lxWS",
	"50Rnd_556x45_Velko_reload_tracer_yellow_lxWS",
	"50Rnd_556x45_Velko_snake_reload_tracer_yellow_lxWS",
	"35Rnd_556x45_Velko_tracer_yellow_lxWS",
	"35Rnd_556x45_Velko_snake_tracer_yellow_lxWS",
	"50Rnd_556x45_Velko_tracer_yellow_lxWS",
	"50Rnd_556x45_Velko_snake_tracer_yellow_lxWS",
	"35Rnd_556x45_Velko_reload_tracer_red_lxWS",
	"35Rnd_556x45_Velko_snake_reload_tracer_red_lxWS",
	"50Rnd_556x45_Velko_reload_tracer_red_lxWS",
	"50Rnd_556x45_Velko_snake_reload_tracer_red_lxWS",
	"35Rnd_556x45_Velko_tracer_red_lxWS",
	"50Rnd_556x45_Velko_tracer_red_lxWS",
	"35Rnd_556x45_Velko_snake_tracer_red_lxWS",
	"50Rnd_556x45_Velko_snake_tracer_red_lxWS",
	"35Rnd_556x45_Velko_reload_tracer_green_lxWS",
	"35Rnd_556x45_Velko_snake_reload_tracer_green_lxWS",
	"50Rnd_556x45_Velko_reload_tracer_green_lxWS",
	"50Rnd_556x45_Velko_snake_reload_tracer_green_lxWS",
	"35Rnd_556x45_Velko_tracer_green_lxWS",
	"50Rnd_556x45_Velko_tracer_green_lxWS",
	"35Rnd_556x45_Velko_snake_tracer_green_lxWS",
	"50Rnd_556x45_Velko_snake_tracer_green_lxWS",
	"100Rnd_762x51_S77_Red_lxWS",
	"100Rnd_762x51_S77_Red_Tracer_lxWS",
	"100Rnd_762x51_S77_Green_lxWS",
	"100Rnd_762x51_S77_Green_Tracer_lxWS",
	"100Rnd_762x51_S77_Yellow_lxWS",
	"100Rnd_762x51_S77_Yellow_Tracer_lxWS",
	"20Rnd_12Gauge_AA40_Pellets_lxWS",
	"8Rnd_12Gauge_AA40_Pellets_lxWS",
	"20Rnd_12Gauge_AA40_Slug_lxWS",
	"8Rnd_12Gauge_AA40_Slug_lxWS",
	"20Rnd_12Gauge_AA40_HE_lxWS",
	"8Rnd_12Gauge_AA40_HE_lxWS",
	"20Rnd_12Gauge_AA40_Smoke_lxWS",
	"8Rnd_12Gauge_AA40_Smoke_lxWS",
	"20Rnd_12Gauge_AA40_Pellets_Tan_lxWS",
	"8Rnd_12Gauge_AA40_Pellets_Tan_lxWS",
	"20Rnd_12Gauge_AA40_Slug_Tan_lxWS",
	"8Rnd_12Gauge_AA40_Slug_Tan_lxWS",
	"20Rnd_12Gauge_AA40_HE_Tan_lxWS",
	"8Rnd_12Gauge_AA40_HE_Tan_lxWS",
	"20Rnd_12Gauge_AA40_Smoke_Tan_lxWS",
	"8Rnd_12Gauge_AA40_Smoke_Tan_lxWS",
	"20Rnd_12Gauge_AA40_Pellets_Snake_lxWS",
	"8Rnd_12Gauge_AA40_Pellets_Snake_lxWS",
	"20Rnd_12Gauge_AA40_Slug_Snake_lxWS",
	"8Rnd_12Gauge_AA40_Slug_Snake_lxWS",
	"20Rnd_12Gauge_AA40_HE_Snake_lxWS",
	"8Rnd_12Gauge_AA40_HE_Snake_lxWS",
	"20Rnd_12Gauge_AA40_Smoke_Snake_lxWS",
	"8Rnd_12Gauge_AA40_Smoke_Snake_lxWS",
	"10Rnd_Mk14_762x51_Mag_blk_lxWS",
	"20Rnd_762x51_Mag_blk_lxWS",
	"10Rnd_Mk14_762x51_Mag_snake_lxWS",
	"20Rnd_762x51_Mag_snake_lxWS",
	"30Rnd_762x39_Mag_worn_lxWS"
]



// Prairie Fire

// Uniforms
["","vn_b_uniform_macv_01_17","vn_b_uniform_macv_02_17","vn_b_uniform_macv_03_17","vn_b_uniform_macv_04_17","vn_b_uniform_macv_05_17","vn_b_uniform_macv_06_17","vn_b_uniform_aus_01_01","vn_b_uniform_aus_10_01","vn_b_uniform_aus_02_01","vn_b_uniform_aus_03_01","vn_b_uniform_aus_04_01","vn_b_uniform_aus_05_01","vn_b_uniform_aus_06_01","vn_b_uniform_aus_07_01","vn_b_uniform_aus_08_01","vn_b_uniform_aus_09_01","vn_b_uniform_macv_01_03","vn_b_uniform_macv_01_15","vn_b_uniform_macv_01_06","vn_b_uniform_macv_01_08","vn_b_uniform_macv_01_07","vn_b_uniform_macv_01_01","vn_b_uniform_macv_01_04","vn_b_uniform_macv_01_05","vn_b_uniform_macv_01_02","vn_b_uniform_macv_02_15","vn_b_uniform_macv_02_06","vn_b_uniform_macv_02_08","vn_b_uniform_macv_02_07","vn_b_uniform_macv_02_01","vn_b_uniform_macv_02_05","vn_b_uniform_macv_02_02","vn_b_uniform_macv_03_15","vn_b_uniform_macv_03_06","vn_b_uniform_macv_03_08","vn_b_uniform_macv_03_07","vn_b_uniform_macv_03_01","vn_b_uniform_macv_03_05","vn_b_uniform_macv_03_02","vn_b_uniform_macv_04_15","vn_b_uniform_macv_04_21","vn_b_uniform_macv_04_06","vn_b_uniform_macv_04_08","vn_b_uniform_macv_04_07","vn_b_uniform_macv_04_01","vn_b_uniform_macv_04_05","vn_b_uniform_macv_04_02","vn_b_uniform_macv_04_20","vn_b_uniform_macv_05_15","vn_b_uniform_macv_05_06","vn_b_uniform_macv_05_08","vn_b_uniform_macv_05_07","vn_b_uniform_macv_05_01","vn_b_uniform_macv_05_05","vn_b_uniform_macv_05_02","vn_b_uniform_macv_06_15","vn_b_uniform_macv_06_06","vn_b_uniform_macv_06_08","vn_b_uniform_macv_06_07","vn_b_uniform_macv_06_01","vn_b_uniform_macv_06_05","vn_b_uniform_macv_06_02","vn_b_uniform_nz_01_01","vn_b_uniform_nz_02_01","vn_b_uniform_nz_03_01","vn_b_uniform_nz_04_01","vn_b_uniform_nz_05_01","vn_b_uniform_nz_06_01","vn_b_uniform_macv_01_16","vn_b_uniform_macv_02_16","vn_b_uniform_macv_03_16","vn_b_uniform_macv_04_16","vn_b_uniform_macv_05_16","vn_b_uniform_macv_06_16","vn_b_uniform_macv_01_18","vn_b_uniform_macv_02_18","vn_b_uniform_macv_03_18","vn_b_uniform_macv_04_18","vn_b_uniform_macv_05_18","vn_b_uniform_macv_06_18","vn_b_uniform_sas_01_06","vn_b_uniform_sas_02_06","vn_b_uniform_sas_03_06","vn_b_uniform_sog_01_03","vn_b_uniform_sog_01_01","vn_b_uniform_sog_01_04","vn_b_uniform_sog_01_06","vn_b_uniform_sog_01_02","vn_b_uniform_sog_01_05","vn_b_uniform_sog_02_03","vn_b_uniform_sog_02_01","vn_b_uniform_sog_02_04","vn_b_uniform_sog_02_06","vn_b_uniform_sog_02_02","vn_b_uniform_sog_02_05","vn_b_uniform_heli_01_01","vn_b_uniform_k2b_03_01","vn_b_uniform_k2b_03_02","vn_b_uniform_k2b_02_01","vn_b_uniform_k2b_01_01","vn_b_uniform_k2b_02_02","vn_b_uniform_k2b_02_05","vn_b_uniform_k2b_02_04","vn_b_uniform_k2b_01_02","vn_b_uniform_k2b_01_05","vn_b_uniform_k2b_01_04","vn_b_uniform_k2b_02_03","vn_o_uniform_nva_army_01_01","vn_o_uniform_nva_army_01_02","vn_o_uniform_nva_army_12_01","vn_o_uniform_nva_army_12_02","vn_o_uniform_nva_army_02_01","vn_o_uniform_nva_army_02_02","vn_o_uniform_nva_army_03_01","vn_o_uniform_nva_army_03_02","vn_o_uniform_nva_army_04_01","vn_o_uniform_nva_army_04_02","vn_o_uniform_nva_army_09_01","vn_o_uniform_nva_army_09_02","vn_o_uniform_nva_dc_13_07","vn_o_uniform_nva_dc_13_08","vn_o_uniform_nva_dc_13_04","vn_o_uniform_nva_dc_13_02","vn_o_uniform_nva_dc_14_01","vn_o_uniform_nva_dc_14_04","vn_o_uniform_nva_army_01_03","vn_o_uniform_nva_army_01_04","vn_o_uniform_nva_army_10_03","vn_o_uniform_nva_army_10_04","vn_o_uniform_nva_army_11_03","vn_o_uniform_nva_army_11_04","vn_o_uniform_nva_army_12_03","vn_o_uniform_nva_army_12_04","vn_o_uniform_nva_army_02_03","vn_o_uniform_nva_army_02_04","vn_o_uniform_nva_army_03_03","vn_o_uniform_nva_army_03_04","vn_o_uniform_nva_army_04_03","vn_o_uniform_nva_army_04_04","vn_o_uniform_nva_army_05_03","vn_o_uniform_nva_army_05_04","vn_o_uniform_nva_army_06_03","vn_o_uniform_nva_army_06_04","vn_o_uniform_nva_army_07_03","vn_o_uniform_nva_army_07_04","vn_o_uniform_nva_army_08_03","vn_o_uniform_nva_army_08_04","vn_o_uniform_nva_army_09_03","vn_o_uniform_nva_army_09_04","vn_o_uniform_nva_air_01","U_I_pilotCoveralls","U_O_PilotCoveralls","vn_o_uniform_pl_army_01_11","vn_o_uniform_pl_army_01_12","vn_o_uniform_pl_army_01_13","vn_o_uniform_pl_army_01_14","vn_o_uniform_pl_army_02_11","vn_o_uniform_pl_army_02_12","vn_o_uniform_pl_army_02_13","vn_o_uniform_pl_army_02_14","vn_o_uniform_pl_army_03_11","vn_o_uniform_pl_army_03_12","vn_o_uniform_pl_army_03_13","vn_o_uniform_pl_army_03_14","vn_o_uniform_pl_army_04_11","vn_o_uniform_pl_army_04_12","vn_o_uniform_pl_army_04_13","vn_o_uniform_pl_army_04_14","vn_b_uniform_seal_01_06","vn_b_uniform_seal_01_01","vn_b_uniform_seal_01_07","vn_b_uniform_seal_01_05","vn_b_uniform_seal_01_02","vn_b_uniform_seal_02_06","vn_b_uniform_seal_02_01","vn_b_uniform_seal_02_07","vn_b_uniform_seal_02_05","vn_b_uniform_seal_02_02","vn_b_uniform_seal_03_01","vn_b_uniform_seal_04_01","vn_b_uniform_seal_05_06","vn_b_uniform_seal_05_01","vn_b_uniform_seal_05_07","vn_b_uniform_seal_05_05","vn_b_uniform_seal_05_02","vn_b_uniform_seal_06_06","vn_b_uniform_seal_06_01","vn_b_uniform_seal_06_07","vn_b_uniform_seal_06_05","vn_b_uniform_seal_06_02","vn_b_uniform_seal_07_01","vn_b_uniform_seal_07_02","vn_b_uniform_seal_07_03","vn_b_uniform_seal_07_04","vn_b_uniform_seal_08_01","vn_b_uniform_seal_08_02","vn_b_uniform_seal_08_03","vn_b_uniform_seal_08_04","vn_b_uniform_seal_09_01","vn_o_uniform_vc_mf_01_07","vn_o_uniform_vc_01_01","vn_o_uniform_vc_01_02","vn_o_uniform_vc_01_04","vn_o_uniform_vc_01_07","vn_o_uniform_vc_01_06","vn_o_uniform_vc_01_03","vn_o_uniform_vc_01_05","vn_o_uniform_vc_mf_10_07","vn_o_uniform_vc_mf_11_07","vn_o_uniform_vc_reg_11_08","vn_o_uniform_vc_reg_11_09","vn_o_uniform_vc_reg_11_10","vn_o_uniform_vc_mf_12_07","vn_o_uniform_vc_reg_12_08","vn_o_uniform_vc_reg_12_09","vn_o_uniform_vc_reg_12_10","vn_o_uniform_vc_mf_02_07","vn_o_uniform_vc_02_01","vn_o_uniform_vc_02_02","vn_o_uniform_vc_02_04","vn_o_uniform_vc_02_07","vn_o_uniform_vc_02_06","vn_o_uniform_vc_02_03","vn_o_uniform_vc_02_05","vn_o_uniform_vc_mf_03_07","vn_o_uniform_vc_03_01","vn_o_uniform_vc_03_02","vn_o_uniform_vc_03_04","vn_o_uniform_vc_03_07","vn_o_uniform_vc_03_06","vn_o_uniform_vc_03_03","vn_o_uniform_vc_03_05","vn_o_uniform_vc_mf_04_07","vn_o_uniform_vc_04_01","vn_o_uniform_vc_04_02","vn_o_uniform_vc_04_04","vn_o_uniform_vc_04_07","vn_o_uniform_vc_04_06","vn_o_uniform_vc_04_03","vn_o_uniform_vc_04_05","vn_o_uniform_vc_05_01","vn_o_uniform_vc_05_04","vn_o_uniform_vc_05_03","vn_o_uniform_vc_05_02","vn_o_uniform_vc_mf_09_07","vn_o_uniform_nva_navy_01","vn_o_uniform_nva_navy_02","vn_o_uniform_nva_navy_03","vn_o_uniform_nva_navy_04"]
// Vest
["","vn_b_vest_aircrew_01","vn_b_vest_anzac_09","vn_b_vest_anzac_10","vn_b_vest_anzac_04","vn_b_vest_anzac_06","vn_b_vest_anzac_05","vn_b_vest_anzac_07","vn_b_vest_anzac_08","vn_b_vest_anzac_01","vn_b_vest_anzac_02","vn_b_vest_anzac_03","vn_b_vest_usarmy_11","vn_b_vest_usarmy_12","vn_b_vest_usarmy_13","vn_b_vest_usarmy_14","vn_b_vest_usarmy_10","vn_b_vest_usarmy_05","vn_b_vest_usarmy_08","vn_b_vest_usarmy_07","vn_b_vest_usarmy_06","vn_b_vest_usarmy_09","vn_b_vest_aircrew_03","vn_b_vest_aircrew_05","vn_b_vest_usarmy_02","vn_b_vest_usarmy_03","vn_b_vest_usarmy_04","vn_b_vest_usarmy_01","vn_o_vest_01","vn_o_vest_06","vn_o_vest_03","vn_o_vest_07","vn_o_vest_02","vn_o_vest_08","vn_b_vest_sas_02","vn_b_vest_sas_03","vn_b_vest_sas_04","vn_b_vest_sas_01","vn_b_vest_seal_01","vn_b_vest_seal_07","vn_b_vest_seal_06","vn_b_vest_seal_03","vn_b_vest_seal_04","vn_b_vest_seal_05","vn_b_vest_seal_02","vn_b_vest_sog_03","vn_b_vest_sog_05","vn_b_vest_sog_06","vn_b_vest_sog_02","vn_b_vest_sog_01","vn_b_vest_sog_04","vn_b_vest_aircrew_02","vn_b_vest_aircrew_04","vn_b_vest_aircrew_06","vn_b_vest_aircrew_07","vn_o_vest_vc_01","vn_o_vest_vc_05","vn_o_vest_vc_04","vn_o_vest_vc_03","vn_o_vest_vc_02","vn_o_vest_04","vn_o_vest_05"]
// Backpack
["","vn_b_pack_pfield_01","vn_b_pack_pfield_02","vn_b_pack_p08_01","vn_b_pack_p08_02","vn_b_pack_p08_03","vn_b_pack_p44_01","vn_b_pack_p44_02","vn_b_pack_p44_03","vn_b_pack_static_tow","vn_b_pack_lw_04","vn_b_pack_static_m1919a4_low_01","vn_b_pack_static_m1919a4_high_01","vn_b_pack_static_m1919a6_01","vn_b_pack_static_m2_high_01","vn_b_pack_static_m2_low_01","vn_b_pack_static_m2_01","vn_b_pack_static_m29_01","vn_b_pack_static_m60_high_01","vn_b_pack_static_m60_low_01","vn_b_pack_m5_01","vn_b_pack_lw_07","vn_b_pack_lw_05","vn_b_pack_lw_02","vn_b_pack_static_mk18","vn_b_pack_lw_01","vn_b_pack_lw_06","vn_b_pack_prc77_01","vn_b_pack_lw_03","vn_b_pack_trp_03_02","vn_b_pack_trp_01_02","vn_b_pack_trp_04_02","vn_b_pack_trp_02_02","vn_b_pack_static_base_01","vn_b_pack_05_02","vn_b_pack_02_02","vn_b_pack_03_02","vn_b_pack_04_02","vn_b_pack_01_02","vn_o_pack_04","vn_o_pack_static_at3_01","vn_o_pack_static_dp28_01","vn_o_pack_static_dshkm_high_02","vn_o_pack_static_dshkm_low_02","vn_o_pack_static_dshkm_high_01","vn_o_pack_static_dshkm_low_01","vn_o_pack_static_mg42_high","vn_o_pack_static_mg42_low","vn_o_pack_08","vn_o_pack_static_pk_high_01","vn_o_pack_static_pk_low_01","vn_o_pack_06","vn_o_pack_07","vn_o_pack_static_rpd_01","vn_o_pack_03","vn_o_pack_05","vn_o_pack_static_sgm_high_01","vn_o_pack_static_sgm_low_02","vn_o_pack_static_sgm_low_01","vn_o_pack_static_type53_01","vn_o_pack_static_type56rr_01","vn_o_pack_static_type63_01","vn_o_pack_static_base_01","vn_o_pack_01","vn_o_pack_02","vn_o_pack_t884_01","vn_b_pack_seal_01","vn_b_pack_05","vn_b_pack_02","vn_b_pack_03","vn_b_pack_04","vn_b_pack_01","vn_b_pack_trp_03","vn_b_pack_trp_01","vn_b_pack_trp_04","vn_b_pack_trp_02","vn_c_pack_01","vn_c_pack_02","vn_o_pack_parachute_01","vn_i_pack_parachute_01","vn_b_pack_ba18_01","vn_b_pack_ba22_01"]
//Headgear
["","vn_b_bandana_03","vn_b_bandana_06","vn_b_bandana_08","vn_b_bandana_01","vn_b_bandana_07","vn_b_bandana_04","vn_b_bandana_05","vn_b_bandana_02","vn_i_beret_03_03","vn_i_beret_01_01","vn_i_beret_03_02","vn_i_beret_03_04","vn_i_beret_03_01","vn_b_beret_01_02","vn_b_beret_01_01","vn_b_beret_01_05","vn_b_beret_01_08","vn_b_beret_01_04","vn_b_beret_01_03","vn_b_beret_04_01","vn_b_beret_01_07","vn_b_beret_01_06","vn_b_beret_03_01","vn_b_boonie_08_02","vn_b_boonie_08_01","vn_b_boonie_07_02","vn_b_boonie_07_01","vn_b_boonie_06_02","vn_b_boonie_06_01","vn_b_boonie_02_03","vn_b_boonie_02_06","vn_b_boonie_02_08","vn_b_boonie_02_01","vn_b_boonie_02_07","vn_b_boonie_02_04","vn_b_boonie_02_05","vn_b_boonie_02_02","vn_b_boonie_03_06","vn_b_boonie_03_03","vn_b_boonie_03_08","vn_b_boonie_03_01","vn_b_boonie_03_07","vn_b_boonie_03_04","vn_b_boonie_03_05","vn_b_boonie_03_02","vn_b_boonie_04_03","vn_b_boonie_04_06","vn_b_boonie_04_08","vn_b_boonie_04_01","vn_b_boonie_04_07","vn_b_boonie_04_04","vn_b_boonie_04_05","vn_b_boonie_04_02","vn_b_boonie_05_03","vn_b_boonie_05_06","vn_b_boonie_05_08","vn_b_boonie_05_01","vn_b_boonie_05_07","vn_b_boonie_05_04","vn_b_boonie_05_05","vn_b_boonie_05_02","vn_b_boonie_01_03","vn_b_boonie_01_06","vn_b_boonie_01_08","vn_b_boonie_01_01","vn_b_boonie_01_07","vn_b_boonie_01_04","vn_b_boonie_01_05","vn_b_boonie_01_02","vn_o_boonie_vc_01_02","vn_o_boonie_vc_01_01","vn_o_boonie_nva_02_02","vn_o_boonie_nva_02_01","vn_o_boonie_vc_02_02","vn_o_boonie_vc_02_01","vn_o_pl_cap_02_02","vn_o_pl_cap_02_01","vn_o_pl_cap_01_01","vn_o_cap_navy_01","vn_o_cap_03","vn_o_cap_01","vn_o_cap_02","vn_b_headband_03","vn_c_headband_04","vn_c_headband_03","vn_b_headband_05","vn_b_headband_08","vn_c_headband_02","vn_b_headband_01","vn_c_headband_01","vn_b_headband_04","vn_b_headband_02","vn_b_helmet_aph6_01_02","vn_b_helmet_aph6_02_02","vn_b_helmet_aph6_01_05","vn_b_helmet_aph6_02_05","vn_b_helmet_aph6_01_03","vn_b_helmet_aph6_02_03","vn_b_helmet_aph6_01_04","vn_b_helmet_aph6_02_04","vn_b_helmet_aph6_01_01","vn_b_helmet_aph6_02_01","vn_b_helmet_m1_01_02","vn_i_helmet_m1_01_01","vn_i_helmet_m1_02_01","vn_i_helmet_m1_03_01","vn_i_helmet_m1_01_02","vn_b_helmet_m1_12_01","vn_b_helmet_m1_12_02","vn_b_helmet_m1_01_01","vn_i_helmet_m1_02_02","vn_i_helmet_m1_03_02","vn_b_helmet_m1_02_02","vn_b_helmet_m1_02_01","vn_b_helmet_m1_03_02","vn_b_helmet_m1_03_01","vn_b_helmet_m1_05_02","vn_b_helmet_m1_05_01","vn_b_helmet_m1_06_02","vn_b_helmet_m1_06_01","vn_b_helmet_m1_07_02","vn_b_helmet_m1_07_01","vn_b_helmet_m1_09_02","vn_b_helmet_m1_09_01","vn_b_helmet_m1_04_02","vn_b_helmet_m1_04_01","vn_b_helmet_m1_08_02","vn_b_helmet_m1_08_01","vn_b_helmet_m1_10_01","vn_b_helmet_m1_11_01","vn_o_helmet_nva_10","vn_o_helmet_shl61_02","vn_o_helmet_shl61_01","vn_o_helmet_nva_09","vn_b_helmet_svh4_01_01","vn_b_helmet_svh4_02_01","vn_b_helmet_svh4_01_04","vn_b_helmet_svh4_02_04","vn_b_helmet_svh4_01_02","vn_b_helmet_svh4_02_02","vn_b_helmet_svh4_01_05","vn_b_helmet_svh4_02_05","vn_b_helmet_svh4_01_06","vn_b_helmet_svh4_02_06","vn_b_helmet_svh4_01_03","vn_b_helmet_svh4_02_03","vn_b_helmet_t56_01_01","vn_b_helmet_t56_02_01","vn_b_helmet_t56_01_02","vn_b_helmet_t56_02_02","vn_b_helmet_t56_01_03","vn_b_helmet_t56_02_03","vn_o_helmet_tsh3_02","vn_o_helmet_tsh3_01","vn_o_helmet_zsh3_01","vn_o_helmet_zsh3_02","vn_c_conehat_02","vn_c_conehat_01","vn_o_helmet_nva_01","vn_o_helmet_nva_04","vn_o_helmet_nva_03","vn_o_helmet_nva_05","vn_o_helmet_nva_07","vn_o_helmet_nva_02","vn_b_helmet_sog_01","vn_o_helmet_vc_01","vn_o_helmet_vc_04","vn_o_helmet_vc_03","vn_o_helmet_vc_05","vn_o_helmet_vc_02","vn_o_helmet_nva_06","vn_o_helmet_nva_08"]
// Goggles
["","vn_b_aviator","vn_b_bandana_a","vn_o_bandana_b","vn_o_bandana_g","vn_o_acc_goggles_01","vn_b_acc_seal_01","vn_b_acc_m17_01","vn_b_acc_m17_02","vn_b_acc_goggles_01","vn_o_acc_km32_01","vn_b_acc_ms22001_01","vn_b_acc_ms22001_02","vn_o_acc_goggles_02","vn_o_acc_goggles_03","vn_o_poncho_01_01","vn_b_scarf_01_03","vn_o_scarf_01_04","vn_o_scarf_01_03","vn_o_scarf_01_02","vn_b_scarf_01_01","vn_o_scarf_01_01","vn_b_acc_rag_01","vn_b_acc_rag_02","vn_b_spectacles","vn_g_spectacles_02","vn_g_spectacles_01","vn_b_squares","vn_b_squares_tinted","vn_g_glasses_01","vn_b_spectacles_tinted","vn_b_acc_towel_01","vn_b_acc_towel_02"]
// Binocular (camera)
["","vn_m19_binocs_grn","vn_m19_binocs_grey","vn_mk21_binocs","vn_anpvs2_binoc"]
// Primary Weapons
["","vn_dp28","vn_f1_smg","vn_gau5a","vn_izh54","vn_izh54_shorty","vn_k50m","vn_l1a1_01","vn_l1a1_01_camo","vn_l1a1_01_gl","vn_l1a1_02","vn_l1a1_02_camo","vn_l1a1_02_gl","vn_l1a1_03","vn_l1a1_03_camo","vn_l1a1_xm148","vn_l1a1_xm148_camo","vn_l2a1_01","vn_m45","vn_m45_camo","vn_m45_fold","vn_m1carbine","vn_m1carbine_gl","vn_m1_garand","vn_m1_garand_gl","vn_m14","vn_m14_camo","vn_m14a1","vn_m16_usaf","vn_m16","vn_m16_camo","vn_m16_m203_camo","vn_m16_m203","vn_m16_xm148","vn_m1891","vn_m1897","vn_m1918","vn_m1928_tommy","vn_m1928a1_tommy","vn_m1a1_tommy","vn_m1a1_tommy_so","vn_m2carbine","vn_m2carbine_gl","vn_m3carbine","vn_m38","vn_m3a1","vn_m40a1","vn_m40a1_camo","vn_m4956","vn_m4956_gl","vn_m60","vn_m60_shorty","vn_m60_shorty_camo","vn_m63a","vn_m63a_cdo","vn_m63a_lmg","vn_m79","vn_m9130","vn_mat49","vn_mat49_f","vn_mat49_vc","vn_mc10","vn_mk1_udg","vn_mp40","vn_mpu","vn_pk","vn_pps43","vn_pps52","vn_ppsh41","vn_rpd","vn_rpd_shorty_01","vn_rpd_shorty","vn_sks","vn_sks_gl","vn_sten","vn_type56","vn_vz61","vn_vz54","vn_xm16e1","vn_xm16e1_xm148","vn_xm177e1","vn_xm177e1_camo","vn_xm177","vn_xm177_camo","vn_xm177_fg","vn_xm177_short","vn_xm177_stock","vn_xm177_stock_camo","vn_xm177_xm148","vn_xm177_xm148_camo"]
// Secondary Weapons
["","vn_sa7","vn_sa7b","vn_rpg2","vn_rpg7","vn_m127","vn_m72"]
// Handgun Weapons
["","vn_p38s","vn_fkb1","vn_fkb1_red","vn_hd","vn_hp","vn_izh54_p","vn_m1895","vn_m1911","vn_mx991_m1911","vn_m712","vn_m79_p","vn_mk22","vn_m10","vn_mx991","vn_mx991_red","vn_pm","vn_fkb1_pm","vn_tt33","vn_vz61_p","vn_welrod"]

//Primary weapon items
["","vn_o_anpvs2_m16","vn_bipod_m16","vn_o_3x_l1a1","vn_b_l1a1","vn_s_m45_camo","vn_s_m45","vn_o_3x_m84","vn_b_carbine","vn_b_camo_m1_garand","vn_b_m1_garand","vn_b_camo_m14","vn_o_9x_m14","vn_o_anpvs2_m14","vn_b_m14","vn_s_m14","vn_bipod_m14","vn_b_camo_m14a1","vn_o_9x_m16","vn_o_4x_m16","vn_o_1x_sp_m16","vn_b_m16","vn_s_m16","vn_b_m38","vn_b_m1897","vn_bipod_m1918","vn_s_m3a1","vn_o_9x_m40a1","vn_o_anpvs2_m40a1","vn_b_camo_m40a1","vn_o_4x_m4956","vn_b_m4956","vn_b_camo_m9130","vn_o_3x_m9130","vn_s_mat49","vn_s_mc10","vn_s_mpu","vn_b_sks","vn_s_sten","vn_b_type56","vn_o_3x_vz54","vn_b_camo_vz54"]

// Handgun weapon items
["","vn_s_m1895","vn_s_m1911","vn_s_mk22","vn_s_pm"]


// Magazines
["vn_vmagazine",
"vn_magazine",
"vn_lmagazine",
"vn_pistolmag_base",
"vn_riflemag_base",
"vn_shotgunmag_base",
"vn_smgmag_base",
"vn_lmgmag_base",
"vn_handgrenade_base",
"vn_prop_base",
"vn_prop_fort_mag",
"vn_prop_med_base",
"vn_prop_med_antibiotics",
"vn_prop_med_antimalaria",
"vn_prop_med_antivenom",
"vn_prop_med_painkillers",
"vn_prop_med_wormpowder",
"vn_prop_med_dysentery",
"vn_prop_drink_01",
"vn_prop_drink_02",
"vn_prop_drink_03",
"vn_prop_drink_04",
"vn_prop_drink_05",
"vn_prop_drink_06",
"vn_prop_drink_10",
"vn_prop_food_meal_01",
"vn_prop_food_fresh_01",
"vn_prop_food_fresh_02",
"vn_prop_food_fresh_03",
"vn_prop_food_fresh_04",
"vn_prop_food_fresh_05",
"vn_prop_food_fresh_06",
"vn_prop_food_fresh_07",
"vn_prop_food_fresh_08",
"vn_prop_food_fresh_09",
"vn_prop_food_fresh_10",
"vn_prop_food_sack_01",
"vn_prop_food_sack_02",
"vn_prop_food_lrrp_01_01",
"vn_prop_food_lrrp_01_02",
"vn_prop_food_lrrp_01_03",
"vn_prop_food_lrrp_01_04",
"vn_prop_food_lrrp_01_05",
"vn_prop_food_lrrp_01_06",
"vn_prop_food_lrrp_01_07",
"vn_prop_food_lrrp_01_08",
"vn_prop_food_pir_01_01",
"vn_prop_food_pir_01_02",
"vn_prop_food_pir_01_03",
"vn_prop_food_pir_01_04",
"vn_prop_food_pir_01_05",
"vn_prop_food_can_01_01",
"vn_prop_food_can_01_02",
"vn_prop_food_can_01_03",
"vn_prop_food_can_01_04",
"vn_prop_food_can_01_05",
"vn_prop_food_can_01_06",
"vn_prop_food_can_01_07",
"vn_prop_food_can_01_08",
"vn_prop_food_can_01_09",
"vn_prop_food_can_01_10",
"vn_prop_food_can_01_11",
"vn_prop_food_can_01_12",
"vn_prop_food_can_01_13",
"vn_prop_food_can_01_14",
"vn_prop_food_can_01_15",
"vn_prop_food_can_01_16",
"vn_prop_food_can_02_01",
"vn_prop_food_can_02_02",
"vn_prop_food_can_02_03",
"vn_prop_food_can_02_04",
"vn_prop_food_can_02_05",
"vn_prop_food_can_02_06",
"vn_prop_food_can_02_07",
"vn_prop_food_can_02_08",
"vn_prop_food_can_03_01",
"vn_prop_food_can_03_02",
"vn_prop_food_can_03_03",
"vn_prop_food_can_03_04",
"vn_prop_food_box_01_01",
"vn_prop_food_box_01_02",
"vn_prop_food_box_01_03",
"vn_prop_food_box_02_01",
"vn_prop_food_box_02_02",
"vn_prop_food_box_02_03",
"vn_prop_food_box_02_04",
"vn_prop_food_box_02_05",
"vn_prop_food_box_02_06",
"vn_prop_food_box_02_07",
"vn_prop_food_box_02_08",
"vn_prop_drink_08_01",
"vn_prop_drink_07_01",
"vn_prop_drink_07_02",
"vn_prop_drink_07_03",
"vn_prop_drink_09_01",
"vn_prop_food_meal_01_01",
"vn_prop_food_meal_01_02",
"vn_prop_food_meal_01_03",
"vn_prop_food_meal_01_04",
"vn_prop_food_meal_01_05",
"vn_prop_food_meal_01_06",
"vn_prop_food_meal_01_07",
"vn_prop_food_meal_01_08",
"vn_prop_food_meal_01_09",
"vn_prop_food_meal_01_10",
"vn_prop_food_meal_01_11",
"vn_prop_food_meal_01_12",
"vn_prop_food_meal_01_13",
"vn_prop_food_meal_01_14",
"vn_prop_food_meal_01_15",
"vn_prop_food_meal_01_16",
"vn_prop_food_meal_01_17",
"vn_prop_food_meal_01_18",
"vn_prop_food_meal_02_01",
"vn_prop_food_meal_02_02",
"vn_prop_food_meal_02_03",
"vn_prop_food_meal_02_04",
"vn_prop_food_meal_02_05",
"vn_prop_food_meal_02_06",
"vn_b_item_bandage_01",
"vn_b_item_bugjuice_01",
"vn_b_item_cigs_01",
"vn_b_item_gunoil_01",
"vn_b_item_lighter_01",
"vn_b_item_rations_01",
"vn_mine_m18_mag",
"vn_mine_m18_range_mag",
"vn_mine_m18_x3_mag",
"vn_mine_m18_x3_range_mag",
"vn_mine_ammobox_range_mag",
"vn_mine_m14_mag",
"vn_mine_m16_mag",
"vn_mine_tripwire_m16_02_mag",
"vn_mine_tripwire_m16_04_mag",
"vn_mine_tripwire_f1_02_mag",
"vn_mine_tripwire_f1_04_mag",
"vn_mine_tripwire_m49_02_mag",
"vn_mine_tripwire_m49_04_mag",
"vn_mine_tripwire_arty_mag",
"vn_mine_satchel_remote_02_mag",
"vn_mine_tm57_mag",
"vn_mine_m15_mag",
"vn_mine_m112_remote_mag",
"vn_mine_punji_01_mag",
"vn_mine_punji_02_mag",
"vn_mine_punji_03_mag",
"vn_m61_grenade_mag",
"vn_v40_grenade_mag",
"vn_m67_grenade_mag",
"vn_m14_grenade_mag",
"vn_m14_early_grenade_mag",
"vn_m7_grenade_mag",
"vn_m34_grenade_mag",
"vn_molotov_grenade_mag",
"vn_rkg3_grenade_mag",
"vn_t67_grenade_mag",
"vn_chicom_grenade_mag",
"vn_f1_grenade_mag",
"vn_rg42_grenade_mag",
"vn_rgd5_grenade_mag",
"vn_rgd33_grenade_mag",
"vn_m18_red_mag",
"vn_rdg2_mag",
"vn_m18_white_mag",
"vn_m18_green_mag",
"vn_m18_yellow_mag",
"vn_m18_purple_mag",
"vn_m72_mag",
"vn_rpg2_mag",
"vn_rpg7_mag",
"vn_sa7_mag",
"vn_sa7b_mag",
"vn_m127_mag",
"vn_m128_mag",
"vn_m129_mag",
"vn_hd_mag",
"vn_welrod_mag",
"vn_m1911_mag",
"vn_hp_mag",
"vn_mk22_mag",
"vn_m10_mag",
"vn_m1895_mag",
"vn_pm_mag",
"vn_tt33_mag",
"vn_m712_mag",
"vn_izh54_mag",
"vn_izh54_so_mag",
"vn_m1897_buck_mag",
"vn_m1897_fl_mag",
"vn_m45_mag",
"vn_m45_t_mag",
"vn_m3a1_mag",
"vn_m3a1_t_mag",
"vn_sten_mag",
"vn_sten_t_mag",
"vn_mat49_mag",
"vn_mat49_t_mag",
"vn_mp40_mag",
"vn_mp40_t_mag",
"vn_mat49_vc_mag",
"vn_m16_mag_base",
"vn_m16_20_mag",
"vn_m16_30_mag",
"vn_m16_40_mag",
"vn_m16_20_t_mag",
"vn_m16_30_t_mag",
"vn_m16_40_t_mag",
"vn_m63a_30_mag",
"vn_m63a_30_t_mag",
"vn_m14_mag",
"vn_m14_t_mag",
"vn_m14_10_mag",
"vn_m14_10_t_mag",
"vn_m40a1_mag",
"vn_m40a1_t_mag",
"vn_m60_100_mag",
"vn_carbine_15_mag",
"vn_carbine_15_t_mag",
"vn_carbine_30_mag",
"vn_carbine_30_t_mag",
"vn_m4956_10_mag",
"vn_m4956_10_t_mag",
"vn_mc10_mag",
"vn_mc10_t_mag",
"vn_pps_mag",
"vn_pps_t_mag",
"vn_ppsh41_35_mag",
"vn_ppsh41_35_t_mag",
"vn_ppsh41_71_mag",
"vn_ppsh41_71_t_mag",
"vn_type56_mag",
"vn_type56_t_mag",
"vn_sks_mag",
"vn_sks_t_mag",
"vn_m38_mag",
"vn_m38_t_mag",
"vn_rpd_100_mag",
"vn_rpd_125_mag",
"vn_dp28_mag",
"vn_pk_100_mag",
"vn_mk1_udg_mag",
"vn_mpu_mag",
"vn_mpu_t_mag",
"vn_vz61_mag",
"vn_vz61_t_mag",
"vn_m1a1_20_mag",
"vn_m1a1_20_t_mag",
"vn_m1a1_30_mag",
"vn_m1a1_30_t_mag",
"vn_m1928_mag",
"vn_m1928_t_mag",
"vn_m63a_100_mag",
"vn_m63a_100_t_mag",
"vn_m63a_150_mag",
"vn_m63a_150_t_mag",
"vn_mine_bike_mag",
"vn_mine_bike_range_mag",
"vn_mine_cartridge_mag",
"vn_mine_lighter_mag",
"vn_mine_pot_mag",
"vn_mine_pot_range_mag",
"vn_mine_jerrycan_mag",
"vn_mine_jerrycan_range_mag",
"vn_mine_punji_04_mag",
"vn_mine_punji_05_mag",
"vn_mine_mortar_range_mag",
"vn_mine_limpet_01_mag",
"vn_mine_limpet_02_mag",
"vn_mine_chicom_no8_mag",
"vn_mine_dh10_mag",
"vn_mine_dh10_range_mag",
"vn_mine_gboard_range_mag",
"vn_mine_satchelcharge_02_mag",
"vn_mine_bangalore_mag",
"vn_satchelcharge_02_throw_mag",
"vn_f1_smg_mag",
"vn_f1_smg_t_mag",
"vn_m1_garand_mag",
"vn_m1_garand_t_mag",
"vn_l1a1_10_mag",
"vn_l1a1_10_t_mag",
"vn_l1a1_20_mag",
"vn_l1a1_20_t_mag",
"vn_l1a1_30_mag",
"vn_l1a1_30_t_mag",
"vn_l1a1_30_02_mag",
"vn_l1a1_30_02_t_mag",
"vn_m1918_mag",
"vn_m1918_t_mag",
"vn_type56_v_12_he_mag",
"vn_type56_v_12_heat_mag"]

















QS_array = [];
onEachFrame {
	QS_array pushBackUnique (handgunWeapon QS_unit);
};
copyToClipboard str QS_array;



QS_array = [];
onEachFrame {
	{
		QS_array pushBackUnique _x;
	} forEach (handgunItems QS_unit);
};
copyToClipboard str QS_array;



// CSLA

// Uniforms
["AFMC_uniWLD","FIA_uniCitizen","FIA_uniCitizen2","FIA_uniCitizen3","FIA_uniCitizen4","FIA_uniDoctor","FIA_uniwld12","CSLA_uni60wld","CSLA_uni60lrr","FIA_uniwld11","US85_uniCrew","FIA_uniWoodlander","FIA_uniWoodlander2","FIA_uniWoodlander3","FIA_uniWoodlander4","FIA_uniFunctionary","FIA_uniFunctionary2","AFMC_uniGhillie","CSLA_uniGhillie","US85_uniGhillie","CSLA_uniPlt","US85_uniPlt","CSLA_uniPoliceman","FIA_uniVillager","FIA_uniVillager2","FIA_uniVillager3","FIA_uniVillager4","US85_uniKHK","AFMC_uniSF","US85_uniBDU","US85_uniPt","US85_uniSF","FIA_uniwld","FIA_uniwld1","FIA_uniwld10","FIA_uniwld2","FIA_uniwld3","FIA_uniwld4","FIA_uniwld5","FIA_uniwld6","FIA_uniwld7","FIA_uniWld8","FIA_uniwld9","CSLA_uniSrv","FIA_uniWorker","FIA_uniWorker2","FIA_uniWorker3","FIA_uniWorker4","FIA_uniForeman","FIA_uniForeman2"]
// Vest
["AFMC_grV_M16","CSLA_gr60harness","CSLA_gr60Sa24harm","CSLA_gr60brr","CSLA_gr60base","CSLA_gr60emp","CSLA_gr60Sa24base","CSLA_gr60bnt","CSLA_gr60drv","CSLA_gr60crw","CSLA_gr60svc","CSLA_gr60medic","CSLA_gr60ofc3","CSLA_gr60ofc1","CSLA_gr60ofc2","CSLA_gr60ofc4","CSLA_gr60OP63","CSLA_gr60rfl","FIA_gr60_Sa58","CSLA_gr60RPG7","CSLA_gr60RPG7r","CSLA_gr60sgt","CSLA_gr60tankPi82","CSLA_gr60tankSa61","CSLA_gr60UK59","CSLA_gr85harness","FIA_gr85_Sa58","CSLA_gr85ptCrw","CSLA_gr85ptMdc","CSLA_gr85ptOfc","CSLA_gr85ptOfcUa","CSLA_gr85ptOP63","CSLA_gr85ptBase","CSLA_gr85lrrSa61","CSLA_gr85lrrOP63","CSLA_gr85lrrBase","CSLA_gr85lrrBino","CSLA_gr85ptSgt","CSLA_gr85ptMg","CSLA_gr85lrrUTON","FIA_gr85_Sa61","CSLA_gr85Uah61","CSLA_grUah61","AFMC_grVest","AFMC_grV_M24","AFMC_grV_MG","AFMC_grV_ofc","US85_grVest","US85_grV_M16GL","US85_grVm_M16GL","US85_grV_M16","US85_grV_M24","US85_grV_M9","US85_grV_MG","US85_grV_MPV","US85_grV_ofc","US85_grSF_M16GL","US85_grSF_M9","US85_grSF_MG","US85_grSF_TLBV","US85_grSF_M16","US85_grSF_M24","US85_grYHarness","AFMC_grY_FAL","US85_grY_M16","US85_grY_M24","US85_grY_M9","FIA_grY_MG","AFMC_grY_MG","US85_grY_MG","FIA_grY_MPV","US85_grY_MPV","US85_grY_snp"]
// Backpack
["AFMC_bpAliceFAL","CSLA_bpWp9P135m","CSLA_bpWp9P135w","CSLA_bpKnapsack","CSLA_bp2xCan","FIA_bpPack","US85_bpAlice","CSLA_bpCorcJacket","CSLA_bpWpM52h","CSLA_bpWpM52b","US85_bpWpM2","US85_bpWpM252","CSLA_bp85Lrr","CSLA_bp61","CSLA_bp85","CSLA_bp85RF10","CSLA_bp60","CSLA_bp85msn","US85_bpPRC77","CSLA_bpWpR129","CSLA_bpWpRF10","CSLA_bpRPG7","US85_bpSf","CSLA_bpWpT21","US85_bpWpTOW","US85_bpWpMount","CSLA_bpWpUK59m"]
//Headgear
["US85_beanie","AFMC_beretBk","AFMC_beretBe","AFMC_beretGn","AFMC_beretCo","AFMC_beretRd","CSLA_beretM","CSLA_beretR","AFMC_booniehatLizard","US85_hat","FIA_hat85Clds","CSLA_hat85Clds","FIA_hat85bClds","CSLA_hat85bClds","FIA_hat85Gn","CSLA_hat85Gn","FIA_hat85bGn","CSLA_hat85bGn","FIA_hat85Mlok","CSLA_hat85Mlok","FIA_hat85bMlok","CSLA_hat85bMlok","FIA_Hairs_Brown","US85_ptCap","US85_marineCap","US85_patrolCap","FIA_capBk","CSLA_capBk","FIA_capClds","CSLA_capClds","FIA_capGn","CSLA_capGn","FIA_cap","CSLA_cap","FIA_capMlok","CSLA_capMlok","CSLA_RadiovkaBk","CSLA_RadiovkaGy","FIA_Radiovka","FIA_Usanka","CSLA_helmetT28","CSLA_helmetT28G","CSLA_helmetT28G_on","US85_helmetDH132","US85_helmetDH132G","US85_helmetDH132G_on","CSLA_helmetPOP6","US85_helmetM1g","AFMC_helmetM1c","US85_helmetM1c","AFMC_helmetMk6","AFMC_helmetMk6para","AFMC_helmetMk6r","CSLA_helmetPara","US85_helmetPASGT","US85_helmetPASGTr","US85_helmetPASGTG","US85_helmetSFL","US85_helmetSFLG","US85_helmetSFLG_on","US85_helmetPltC","US85_helmetPlt","US85_helmetPltAttackC","US85_helmetPltAttack","CSLA_helmet53","CSLA_helmet53d","CSLA_helmet53j","CSLA_helmet53m","CSLA_helmet53G","CSLA_helmet53G_on","CSLA_helmetZSh5c","CSLA_helmetZSh5o","CSLA_helmetZSh5Hc","CSLA_helmetZSh5Ho","CSLA_policeCap","FIA_Hairs_Silver","CSLA_BudajkaBk","CSLA_BudajkaGy","FIA_Budajka"]
// Goggles
["","CSLA_glsPlscSpring"]
// HMD
["","US85_ANPVS5_Goggles","CSLA_nokto"]
// Binocular (camera)
["","CSLA_bino","US85_bino"]


// Primary Weapons
["US85_FALf","US85_FAL","CSLA_HuntingRifle","US85_M14","US85_M16A2CAR","US85_M16A2CARGL","US85_M16A1","US85_M16A2","US85_M16A2GL","US85_M21","US85_M249","US85_M60","US85_MPVN","US85_MPVSD","CSLA_VG70","CSLA_Sa58P","CSLA_Sa58V","CSLA_rSa61","CSLA_Sa24","CSLA_Sa26","CSLA_UK59L"]
// Secondary Weapons
["","CSLA_9K32","US85_FIM92","US85_M136","US85_M47","US85_LAW72","US85_MAAWS","CSLA_RPG7","CSLA_RPG75","US85_SMAW"]
// Handgun Weapons
["","US85_1911","US85_M9","CSLA_Pi52","CSLA_Pi75lr","CSLA_Pi75sr","CSLA_Pi82","CSLA_Sa61"]

//Primary weapon items
["","US85_ANPVS4_FAL","US85_scFAL","US85_FALbpd","US85_ANPVS4_M21","US85_scM21","US85_M14bpd","US85_sc4x20_M16","US85_ANPVS4_M16","US85_sc2000_M16","US85_M16fl","US85_M16tlm","US85_M21tlm","US85_sc4x20M249","US85_sc2000M249","US85_ANPVS4_M60","muzzle_snds_L","CSLA_PSO1_OP63","CSLA_NSPU_OP63","CSLA_Sa58bnt","CSLA_NSPU","CSLA_ZD4x8","CSLA_Sa58bpd","CSLA_Sa61tlm","CSLA_UK59_ZD4x8"]
// Handgun weapon items
["","US85_M9tlm","CSLA_Sa61tlm"]

// Magazines
["CSLA_Magazine",
"CSLA_LauncherMagazine",
"CSLA_IVZmagazine",
"CSLA_Sa24_32rnd_7_62Pi52",
"CSLA_Sa58_30rnd_7_62vz43",
"CSLA_Sa58_30rnd_7_62Sv43",
"CSLA_Sa58_30rnd_7_62Cv43",
"CSLA_Sa58_0rnd",
"CSLA_OP63_10rnd_7_62Odst59",
"CSLA_OP63_10rnd_7_62PZ59",
"CSLA_OP63_10rnd_7_62Cv59",
"CSLA_10Rnd_762hunt",
"CSLA_UK59_50rnd_7_62vz59",
"CSLA_UK59_50rnd_7_62Sv59",
"CSLA_UK59_50rnd_7_62PZ59",
"CSLA_UK59_50rnd_7_62Tz59",
"CSLA_UK59_50rnd_7_62TzSv59",
"CSLA_UK59_50rnd_7_62Cv59",
"CSLA_250rnd_7_62vz59",
"CSLA_250rnd_7_62Sv59",
"CSLA_250rnd_7_62PZ59",
"CSLA_250rnd_7_62Tz59",
"CSLA_250rnd_7_62TzSv59",
"CSLA_250rnd_7_62Cv59",
"CSLA_RG4o",
"CSLA_RG4u",
"CSLA_URG86o",
"CSLA_URG86u",
"CSLA_F1",
"CSLA_3D6",
"CSLA_3D17",
"CSLA_902V",
"CSLA_150rnd_23x115BRT",
"CSLA_250rnd_23x115BRT",
"CSLA_100rnd_30JPZSv53",
"CSLA_PG15V",
"CSLA_20rnd_PG15V",
"CSLA_40rnd_PG15V",
"CSLA_76rnd_PG15V",
"CSLA_152EPrSv",
"CSLA_6Rnd_152EPrSv",
"CSLA_152EOF",
"CSLA_54Rnd_152EOF",
"CSLA_152ECv",
"CSLA_6Rnd_152ECv",
"CSLA_54Rnd_152ECv",
"CSLA_3rnd_82EOM52",
"CSLA_4rnd_82EOM52",
"CSLA_6rnd_82EOM52",
"CSLA_8rnd_82EOM52",
"CSLA_PG7M110",
"CSLA_PG7M110V",
"CSLA_RPG75_Mag",
"CSLA_9M32M",
"CSLA_3rnd_82JOFZ47",
"CSLA_6rnd_82JOFZ47",
"CSLA_12rnd_82JOFZ47",
"CSLA_9M14M",
"CSLA_4rnd_9M14M",
"CSLA_6rnd_9M14M",
"CSLA_7rnd_9M14M",
"CSLA_9M113",
"CSLA_9M114M1",
"CSLA_2rnd_9M114M1",
"CSLA_4rnd_9M114M1",
"CSLA_8rnd_9M114M1",
"CSLA_R73",
"CSLA_PtMiBa3_mag",
"CSLA_PPMiNa_mag",
"CSLA_IVZ",
"CSLA_UK59th",
"US85_Magazine",
"US85_LauncherMagazine",
"US85_30Rnd_556x45",
"US85_20Rnd_556x45",
"US85_20Rnd_762x51",
"US85_20Rnd_762M61",
"US85_6Rnd_9Mk217",
"US85_12GaugeSlug",
"US85_8Rnd_12GaugeSlug",
"US85_200Rnd_556x45",
"US85_100Rnd_762x51",
"US85_M60_100Rnd_762x51",
"US85_100Rnd_127x99",
"US85_M67",
"US85_LAW72_Mag",
"US85_M136_Mag",
"US85_SMAW_HEDP",
"US85_SMAW_HEAA",
"US85_MAAWS_HEDP",
"US85_MAAWS_HEAT",
"US85_M47_Mag",
"US85_FIM92_Mag",
"US85_M43A1",
"US85_4Rnd_M43A1",
"US85_8Rnd_81mmHE",
"US85_ATMine_mag",
"US85_M14Mine_mag",
"US85_SatchelCharge_Mag",
"US85_50Rnd_762x51",
"US85_200Rnd_762x51",
"US85_220Rnd_762x51",
"US85_440Rnd_762x51",
"US85_AIM9M",
"US85_AGM65",
"US85_TOW_Mag"
]














QS_array = [];
onEachFrame {
	QS_array pushBackUnique (handgunWeapon QS_unit);
};
copyToClipboard str QS_array;




// Global Mobilization

// Uniforms
["gm_dk_army_uniform_soldier_84_m84","gm_xx_uniform_soldier_bdu_nogloves_80_wdl","gm_xx_uniform_soldier_bdu_80_wdl","gm_xx_uniform_soldier_bdu_rolled_80_wdl","gm_ge_bgs_uniform_soldier_80_smp","gm_gc_civ_uniform_man_01_80_blk","gm_gc_civ_uniform_man_01_80_blu","gm_gc_civ_uniform_man_02_80_brn","gm_ge_civ_uniform_blouse_80_gry","gm_ge_uniform_soldier_90_flk","gm_ge_uniform_soldier_90_trp","gm_ge_uniform_soldier_tshirt_90_trp","gm_ge_uniform_soldier_rolled_90_flk","gm_ge_uniform_soldier_rolled_90_trp","gm_ge_uniform_soldier_tshirt_90_flk","gm_dk_army_uniform_soldier_84_oli","gm_dk_army_uniform_soldier_84_win","gm_gc_army_uniform_dress_80_gry","gm_gc_pol_uniform_dress_80_blu","gm_ge_army_uniform_soldier_80_ols","gm_ge_army_uniform_soldier_80_oli","gm_ge_army_uniform_soldier_gloves_80_ols","gm_ge_army_uniform_soldier_parka_80_ols","gm_ge_army_uniform_soldier_parka_80_oli","gm_ge_army_uniform_soldier_parka_80_win","gm_gc_army_uniform_soldier_80_blk","gm_gc_army_uniform_soldier_80_str","gm_gc_army_uniform_soldier_80_win","gm_gc_army_uniform_soldier_gloves_80_str","gm_pl_army_uniform_soldier_80_moro","gm_pl_army_uniform_soldier_autumn_80_moro","gm_pl_army_uniform_soldier_rolled_80_moro","gm_pl_army_uniform_soldier_80_win","gm_ge_ff_uniform_man_80_orn","gm_ge_pol_uniform_pilot_grn","gm_ge_pol_uniform_pilot_rolled_grn","gm_ge_army_uniform_pilot_oli","gm_ge_army_uniform_pilot_rolled_oli","gm_ge_army_uniform_pilot_sar","gm_ge_army_uniform_pilot_rolled_sar","gm_gc_civ_uniform_pilot_80_blk","gm_gc_airforce_uniform_pilot_80_blu","gm_pl_airforce_uniform_pilot_80_gry","gm_ge_pol_uniform_blouse_80_blk","gm_ge_pol_uniform_suit_80_grn","gm_gc_civ_uniform_man_03_80_blu","gm_gc_civ_uniform_man_03_80_grn","gm_gc_civ_uniform_man_03_80_gry","gm_ge_army_uniform_crew_90_trp","gm_ge_army_uniform_crew_90_flk","gm_ge_army_uniform_crew_80_oli","gm_ge_dbp_uniform_suit_80_blu","gm_gc_civ_uniform_man_04_80_blu","gm_gc_civ_uniform_man_04_80_gry"]
// Vest
["gm_dk_army_vest_54_rifleman","gm_ge_army_vest_pilot_oli","gm_ge_army_vest_pilot_pads_oli","gm_gc_army_vest_80_belt_str","gm_ge_army_vest_80_belt","gm_ge_vest_90_crew_flk","gm_ge_vest_90_demolition_flk","gm_ge_vest_90_leader_flk","gm_ge_vest_90_machinegunner_flk","gm_ge_vest_90_medic_flk","gm_ge_vest_90_officer_flk","gm_ge_vest_90_rifleman_flk","gm_gc_vest_combatvest3_str","gm_ge_vest_armor_90_flk","gm_ge_vest_armor_90_crew_flk","gm_ge_vest_armor_90_demolition_flk","gm_ge_vest_armor_90_leader_flk","gm_ge_vest_armor_90_machinegunner_flk","gm_ge_vest_armor_90_medic_flk","gm_ge_vest_armor_90_officer_flk","gm_ge_vest_armor_90_rifleman_flk","gm_dk_army_vest_m00_m84","gm_dk_army_vest_m00_blu","gm_dk_army_vest_m00_win","gm_dk_army_vest_m00_wdl","gm_dk_army_vest_m00_m84_machinegunner","gm_dk_army_vest_m00_win_machinegunner","gm_dk_army_vest_m00_m84_rifleman","gm_dk_army_vest_m00_win_rifleman","gm_dk_army_vest_m00_wdl_rifleman","gm_ge_army_vest_80_bag","gm_gc_army_vest_80_at_str","gm_gc_bgs_vest_80_border_str","gm_ge_bgs_vest_80_rifleman","gm_ge_army_vest_80_crew","gm_dk_army_vest_54_crew","gm_ge_army_vest_80_demolition","gm_ge_army_vest_80_leader","gm_gc_army_vest_80_leader_str","gm_ge_army_vest_80_leader_smg","gm_ge_army_vest_80_machinegunner","gm_gc_army_vest_80_lmg_str","gm_dk_army_vest_54_machinegunner","gm_ge_army_vest_80_medic","gm_ge_army_vest_80_mp_wht","gm_ge_army_vest_80_officer","gm_ge_pol_vest_80_wht","gm_ge_army_vest_80_rifleman","gm_gc_army_vest_80_rifleman_str","gm_ge_army_vest_80_rifleman_smg","gm_pl_army_vest_80_rig_gry","gm_pl_army_vest_80_at_gry","gm_pl_army_vest_80_crew_gry","gm_pl_army_vest_80_leader_gry","gm_pl_army_vest_80_mg_gry","gm_pl_army_vest_80_marksman_gry","gm_pl_army_vest_80_rifleman_gry","gm_pl_army_vest_80_rifleman_smg_gry"]
// Backpack
["","gm_dk_army_backpack_73_oli","gm_gc_army_backpack_80_assaultpack_empty_str","gm_gc_army_backpack_80_assaultpack_lmg_str","gm_ge_army_backpack_90_flk","gm_ge_army_backpack_90_trp","gm_ge_army_backpack_90_cover_win","gm_fagot_launcher_weaponBag","gm_ge_army_backpack_80_oli","gm_pl_army_backpack_80_oli","gm_milan_launcher_weaponBag","gm_gc_army_backpack_80_lmg_str","gm_mg3_aatripod_weaponBag","gm_gc_backpack_r105m_brn","gm_ge_backpack_sem35_oli","gm_gc_army_backpack_80_at_str","gm_pl_army_backpack_at_80_gry","gm_backpack_rs9_parachute","gm_ge_backpack_satchel_80_blk","gm_ge_backpack_satchel_80_san","gm_backpack_t10_parachute"]
//Headgear
["gm_dk_headgear_m52_net_oli","gm_ge_headgear_beret_red_antiair","gm_ge_headgear_beret_blk_antitank","gm_ge_headgear_beret_blk_armor","gm_ge_headgear_beret_blk_armorrecon","gm_ge_headgear_beret_bdx_armyaviation","gm_ge_headgear_beret_red_artillery","gm_ge_headgear_beret_un","gm_ge_headgear_beret_mrb","gm_gc_headgear_beret_blk","gm_ge_headgear_beret_red_engineer","gm_ge_headgear_beret_grn_guardbtl","gm_ge_headgear_beret_grn_infantry","gm_ge_headgear_beret_bdx_lrrp","gm_ge_headgear_beret_red_maintenance","gm_ge_headgear_beret_grn_mechinf","gm_ge_headgear_beret_blu_medical","gm_ge_headgear_beret_red_militarypolice","gm_ge_headgear_beret_grn_music","gm_ge_headgear_beret_red_nbc","gm_gc_headgear_beret_officer_blk","gm_gc_headgear_beret_officer_orn","gm_gc_headgear_beret_officer_str","gm_ge_headgear_beret_red_opcom","gm_gc_headgear_beret_orn","gm_ge_headgear_beret_bdx_paratrooper","gm_pl_headgear_beret_blk","gm_pl_headgear_beret_blu","gm_pl_headgear_beret_bdx","gm_ge_headgear_beret_blk_recon","gm_ge_headgear_beret_red_signals","gm_ge_headgear_beret_bdx_specop","gm_gc_headgear_beret_str","gm_ge_headgear_beret_red_supply","gm_ge_headgear_beret_red_geoinfo","gm_ge_headgear_hat_boonie_trp","gm_ge_headgear_hat_boonie_flk","gm_dk_headgear_hat_boonie_m84","gm_ge_headgear_hat_boonie_oli","gm_ge_headgear_hat_boonie_wdl","gm_dk_headgear_m96_oli","gm_dk_headgear_m96_blu","gm_dk_headgear_m96_cover_m84","gm_dk_headgear_m96_cover_wht","gm_dk_headgear_m96_cover_wdl","gm_ge_headgear_crewhat_80_blk","gm_gc_army_headgear_crewhat_80_blk","gm_ge_headgear_headset_crew_oli","gm_ge_headgear_beret_crew_red_antiair","gm_ge_headgear_beret_crew_blk_antitank","gm_ge_headgear_beret_crew_blk_armor","gm_ge_headgear_beret_crew_blk_armorrecon","gm_ge_headgear_beret_crew_red_artillery","gm_ge_headgear_beret_crew_red_engineer","gm_ge_headgear_beret_crew_red_maintenance","gm_ge_headgear_beret_crew_grn_mechinf","gm_ge_headgear_beret_crew_red_militarypolice","gm_ge_headgear_beret_crew_red_nbc","gm_ge_headgear_beret_crew_red_opcom","gm_ge_headgear_beret_crew_bdx_paratrooper","gm_ge_headgear_beret_crew_blk_recon","gm_ge_headgear_beret_crew_red_signals","gm_ge_headgear_beret_crew_red_supply","gm_ge_headgear_hat_90_trp","gm_ge_headgear_hat_90_flk","gm_ge_headgear_hat_80_gry","gm_ge_headgear_hat_80_m62_oli","gm_ge_headgear_hat_80_oli","gm_pl_army_headgear_cap_80_moro","gm_gc_headgear_fjh_model4_oli","gm_gc_headgear_fjh_model4_wht","gm_dk_headgear_m52_oli","gm_dk_headgear_m52_net_win","gm_ge_bgs_headgear_m35_53_blk","gm_ge_bgs_headgear_m35_53_net_blk","gm_ge_ff_headgear_m35_53_tan","gm_ge_headgear_m62","gm_ge_headgear_m62_cover_blu","gm_ge_headgear_m62_net","gm_ge_headgear_m62_cover_win","gm_ge_headgear_m62_win_pap_01","gm_ge_headgear_m62_cover_wdl","gm_ge_headgear_m92_flk","gm_ge_headgear_m92_trp","gm_ge_headgear_m92_glasses_trp","gm_ge_headgear_m92_glasses_flk","gm_ge_headgear_m92_cover_win","gm_ge_headgear_m92_cover_glasses_win","gm_ge_headgear_sph4_oli","gm_pl_army_headgear_wz63_oli","gm_pl_army_headgear_wz63_net_oli","gm_pl_army_headgear_wz67_oli","gm_pl_army_headgear_wz67_net_oli","gm_pl_headgear_wz67_cover_win","gm_gc_army_headgear_cap_80_gry","gm_gc_pol_headgear_cap_80_blu","gm_ge_pol_headgear_cap_80_grn","gm_ge_pol_headgear_cap_80_wht","gm_ge_dbp_headgear_cap_80_blu","gm_gc_bgs_headgear_hat_80_gry","gm_gc_army_headgear_hat_80_grn","gm_gc_army_headgear_m56","gm_gc_army_headgear_m56_cover_blu","gm_gc_army_headgear_m56_net","gm_gc_army_headgear_m56_cover_str","gm_gc_army_headgear_m56_cover_win","gm_ge_headgear_winterhat_80_oli","gm_ge_headgear_hat_beanie_blk","gm_gc_headgear_zsh3_wht","gm_gc_headgear_zsh3_blu","gm_gc_headgear_zsh3_orn"]
// Goggles
["","gm_ge_facewear_dustglasses","gm_gc_army_facewear_dustglasses","gm_headgear_foliage_summer_forest_01","gm_headgear_foliage_summer_forest_02","gm_headgear_foliage_summer_forest_03","gm_headgear_foliage_summer_forest_04","gm_ge_facewear_m65","gm_gc_army_facewear_schm41m","gm_headgear_foliage_summer_grass_01","gm_headgear_foliage_summer_grass_02","gm_headgear_foliage_summer_grass_03","gm_headgear_foliage_summer_grass_04","gm_ge_facewear_sunglasses"]
// Binocular (camera)
["","gm_df7x40_blk","gm_ferod16_des","gm_ferod16_oli","gm_ferod16_win","gm_photocamera_01_blk"]
// Primary Weapons
["gm_gvm75_oli_feroz24","gm_akm_wud","gm_akm_pallad_wud","gm_akmn_wud","gm_c7a1_oli","gm_c7a1_blk","gm_g36a1_blk","gm_g36a1_des","gm_g36e_blk","gm_g3a3_oli","gm_g3a3_blk","gm_g3a3_grn","gm_g3a3_des","gm_g3a3_dmr_oli","gm_g3a3_dmr_blk","gm_g3a3_dmr_des","gm_g3a4_oli","gm_g3a4_blk","gm_g3a4_grn","gm_g3a4_des","gm_g3a4_ebr_oli","gm_g3a4_ebr_blk","gm_g3a4_ebr_des","gm_hk69a1_blk","gm_gvm75_oli","gm_gvm75_blk","gm_gvm75_grn","gm_gvm75carb_oli","gm_gvm75carb_blk","gm_gvm75carb_grn","gm_gvm95_blk","gm_hmgpkm_prp","gm_lmgm62_blk","gm_lmgrpk74n_brn","gm_lmgrpk74n_prp","gm_lmgrpk_brn","gm_lmgrpk_prp","gm_m16a1_blk","gm_m16a2_blk","gm_mg3_blk","gm_mg3_des","gm_mp2a1_blk","gm_mpiak74n_brn","gm_mpiak74n_prp","gm_mpiaks74n_brn","gm_mpiaks74n_prp","gm_mpiaks74nk_brn","gm_mpiaks74nk_prp","gm_mpikm72_brn","gm_mpikm72_prp","gm_mpikms72_brn","gm_mpikms72_prp","gm_pm63_blk","gm_mp5a2_blk","gm_mp5a3_blk","gm_mp5sd2_blk","gm_mp5sd3_blk","gm_svd_wud","gm_pallad_d_brn"]
// Secondary Weapons
["","gm_fim43_oli","gm_m72a3_oli","gm_p2a1_launcher_blk","gm_pzf3_blk","gm_pzf44_2_oli","gm_pzf44_2_des","gm_pzf44_2_win","gm_pzf84_oli","gm_pzf84_des","gm_pzf84_win","gm_rpg7_wud","gm_rpg7_prp","gm_9k32m_oli"]
// Handgun Weapons
["","gm_lp1_blk","gm_p1_blk","gm_p2a1_blk","gm_pm_blk","gm_wz78_blk"]

//Primary weapon items
["","gm_zvn64_rear_ak","gm_zvn64_front","gm_bayonet_6x3_wud","gm_bayonet_6x3_blk","gm_pgo7v_blk","gm_zfk4x25_blk","gm_c79a1_blk","gm_c79a1_oli","gm_feroz24_blk","gm_feroz24_des","gm_zvn64_rear_rpk","gm_suppressor_safloryt_blk","gm_pso1_gry"]
//Handgun weapon items
["","muzzle_snds_L"]

// Magazines
[
"gm_1Rnd_hot_heat_dm72",
"gm_1Rnd_hot_heat_dm72_blk",
"gm_1Rnd_hot_heat_dm72_red",
"gm_1Rnd_hot_heat_dm72_yel",
"gm_1Rnd_hot_heat_dm102",
"gm_1Rnd_hot_heat_dm102_blk",
"gm_1Rnd_hot_heat_dm102_red",
"gm_1Rnd_hot_heat_dm102_yel",
"gm_1Rnd_hot_heat_dm102_hornetarrow",
"gm_1Rnd_hot_heat_dm102_hornet",
"gm_1Rnd_luna_he_3r9",
"gm_1Rnd_luna_nuc_3r10",
"gm_1Rnd_milan_heat_dm82",
"gm_1Rnd_milan_heat_dm92",
"gm_36Rnd_mlrs_110mm_he_dm21",
"gm_36Rnd_mlrs_110mm_icm_dm602",
"gm_36Rnd_mlrs_110mm_mine_dm711",
"gm_36Rnd_mlrs_110mm_smoke_dm15",
"gm_40Rnd_mlrs_122mm_he_9m22u",
"gm_40Rnd_mlrs_122mm_icm_9m218",
"gm_40Rnd_mlrs_122mm_mine_9m28k",
"gm_40Rnd_mlrs_122mm_mine_9m22k",
"gm_40Rnd_mlrs_122mm_smoke_9m43",
"gm_1Rnd_265mm_flare_single_wht_gc",
"gm_1Rnd_265mm_flare_single_grn_gc",
"gm_1Rnd_265mm_flare_single_red_gc",
"gm_1Rnd_265mm_flare_multi_red_gc",
"gm_1Rnd_265mm_smoke_single_yel_gc",
"gm_1Rnd_265mm_smoke_single_blu_gc",
"gm_1Rnd_265mm_smoke_single_blk_gc",
"gm_1Rnd_265mm_flare_para_yel_DM16",
"gm_1Rnd_265mm_flare_single_wht_DM15",
"gm_1Rnd_265mm_flare_single_red_DM13",
"gm_1Rnd_265mm_flare_single_grn_DM11",
"gm_1Rnd_265mm_flare_single_yel_DM10",
"gm_1Rnd_265mm_flare_multi_wht_DM25",
"gm_1Rnd_265mm_flare_multi_red_DM23",
"gm_1Rnd_265mm_flare_multi_grn_DM21",
"gm_1Rnd_265mm_flare_multi_yel_DM20",
"gm_1Rnd_265mm_smoke_single_yel_DM19",
"gm_1Rnd_265mm_smoke_single_org_DM22",
"gm_1Rnd_265mm_smoke_single_vlt_DM24",
"gm_1Rnd_265mm_flare_multi_nbc_DM47",
"gm_1Rnd_bastion_heat_9M117",
"gm_1Rnd_bastion_heat_9M117M",
"gm_1Rnd_bastion_heat_9M117M1",
"gm_1Rnd_2650mm_potato_dm11",
"gm_1Rnd_84x245mm_heat_t_DM12_carlgustaf",
"gm_1Rnd_84x245mm_heat_t_DM12a1_carlgustaf",
"gm_1Rnd_84x245mm_heat_t_DM22_carlgustaf",
"gm_1Rnd_84x245mm_heat_t_DM32_carlgustaf",
"gm_1Rnd_84x245mm_ILLUM_DM16_carlgustaf",
"gm_1Rnd_fagot_heat_9m111",
"gm_1Rnd_70mm_he_m585_fim43",
"gm_1Rnd_70mm_he_m585_fim43_dummy",
"gm_1Rnd_66mm_heat_m72a3",
"gm_1Rnd_66mm_heat_m72a3_dummy",
"gm_1Rnd_maljutka_heat_9m14",
"gm_1Rnd_maljutka_heat_9m14m",
"gm_1Rnd_maljutka_heat_9m14_pylon",
"gm_1Rnd_maljutka_heat_9m14m_pylon",
"gm_16rnd_55mm_mars2_base",
"gm_16rnd_55mm_he_s5_mars2_base",
"gm_16rnd_55mm_he_s5_mars2_grn",
"gm_16rnd_55mm_he_s5_mars2_bge",
"gm_16rnd_55mm_he_s5_mars2_gry",
"gm_16rnd_55mm_he_s5_mars2_blu",
"gm_16rnd_55mm_he_s5_mars2_oli",
"gm_16rnd_55mm_heat_s5k_mars2_base",
"gm_16rnd_55mm_heat_s5k_mars2_grn",
"gm_16rnd_55mm_heat_s5k_mars2_bge",
"gm_16rnd_55mm_heat_s5k_mars2_gry",
"gm_16rnd_55mm_heat_s5k_mars2_blu",
"gm_16rnd_55mm_heat_s5k_mars2_oli",
"gm_16rnd_55mm_illum_s5O_mars2_base",
"gm_16rnd_55mm_illum_s5O_mars2_grn",
"gm_16rnd_55mm_illum_s5O_mars2_bge",
"gm_16rnd_55mm_illum_s5O_mars2_gry",
"gm_16rnd_55mm_illum_s5O_mars2_blu",
"gm_16rnd_55mm_illum_s5O_mars2_oli",
"gm_1Rnd_60mm_heat_dm12_pzf3",
"gm_1Rnd_60mm_heat_dm22_pzf3",
"gm_1Rnd_60mm_heat_dm32_pzf3",
"gm_1Rnd_44x537mm_heat_dm32_pzf44_2",
"gm_1Rnd_40mm_heat_pg7v_rpg7",
"gm_1Rnd_40mm_heat_pg7vl_rpg7",
"gm_1Rnd_72mm_he_9m32m",
"gm_1Rnd_72mm_he_9m32m_dummy",
"gm_2rnd_72mm_he_9m32m_gad",
"gm_2rnd_72mm_he_9m32m_gad_mi2_left",
"gm_2rnd_72mm_he_9m32m_gad_mi2_right",
"gm_120Rnd_762x51mm_B_T_DM21_mg3_grn",
"gm_120Rnd_762x51mm_B_T_DM21A1_mg3_grn",
"gm_120Rnd_762x51mm_B_T_DM21A2_mg3_grn",
"gm_100Rnd_762x54mmR_B_T_7t2_pk_grn",
"gm_100Rnd_762x54mmR_API_7bz3_pk_grn",
"gm_100Rnd_762x54mm_B_T_t46_pk_grn",
"gm_100Rnd_762x54mm_API_b32_pk_grn",
"gm_32Rnd_9x19mm_B_DM51_mp2_blk",
"gm_32Rnd_9x19mm_B_DM11_mp2_blk",
"gm_32Rnd_9x19mm_AP_DM91_mp2_blk",
"gm_30Rnd_9x19mm_B_DM51_mp5_blk",
"gm_30Rnd_9x19mm_B_DM11_mp5_blk",
"gm_30Rnd_9x19mm_AP_DM91_mp5_blk",
"gm_30Rnd_9x19mm_B_DM51_mp5a3_blk",
"gm_30Rnd_9x19mm_B_DM11_mp5a3_blk",
"gm_30Rnd_9x19mm_AP_DM91_mp5a3_blk",
"gm_15Rnd_9x18mm_B_pst_pm63_blk",
"gm_25Rnd_9x18mm_B_pst_pm63_blk",
"gm_8Rnd_9x19mm_B_DM11_p1_blk",
"gm_8Rnd_9x19mm_B_DM51_p1_blk",
"gm_8Rnd_9x18mm_B_pst_pm_blk",
"gm_mine_at_dm21",
"gm_mine_at_dm1233",
"gm_mine_at_tm46",
"gm_mine_at_ptm3",
"gm_mine_ap_dm31",
"gm_mine_ap_pfm1",
"gm_explosive_petn_charge",
"gm_explosive_petn_charge_dummy",
"gm_explosive_plnp_charge",
"gm_30Rnd_762x39mm_B_57N231_ak47_blk",
"gm_30Rnd_762x39mm_B_T_57N231P_ak47_blk",
"gm_30Rnd_762x39mm_AP_7N23_ak47_blk",
"gm_30Rnd_762x39mm_B_M43_ak47_blk",
"gm_30Rnd_762x39mm_B_T_M43_ak47_blk",
"gm_75Rnd_762x39mm_B_57N231_ak47_blk",
"gm_75Rnd_762x39mm_B_T_57N231P_ak47_blk",
"gm_75Rnd_762x39mm_AP_7N23_ak47_blk",
"gm_75Rnd_762x39mm_B_M43_ak47_blk",
"gm_75Rnd_762x39mm_B_T_M43_ak47_blk",
"gm_30Rnd_545x39mm_B_7N6_ak74_prp",
"gm_30Rnd_545x39mm_B_T_7T3_ak74_prp",
"gm_30Rnd_545x39mm_B_7N6_ak74_org",
"gm_30Rnd_545x39mm_B_T_7T3_ak74_org",
"gm_45Rnd_545x39mm_B_7N6_ak74_prp",
"gm_45Rnd_545x39mm_B_T_7T3_ak74_prp",
"gm_45Rnd_545x39mm_B_7N6_ak74_org",
"gm_45Rnd_545x39mm_B_T_7T3_ak74_org",
"gm_30Rnd_556x45mm_B_DM11_g36_blk",
"gm_30Rnd_556x45mm_B_T_DM21_g36_blk",
"gm_30Rnd_556x45mm_B_DM11_g36_des",
"gm_30Rnd_556x45mm_B_T_DM21_g36_des",
"gm_20Rnd_762x51mm_B_T_DM21_g3_blk",
"gm_20Rnd_762x51mm_B_T_DM21A1_g3_blk",
"gm_20Rnd_762x51mm_B_T_DM21A2_g3_blk",
"gm_20Rnd_762x51mm_B_DM111_g3_blk",
"gm_20Rnd_762x51mm_B_DM41_g3_blk",
"gm_20Rnd_762x51mm_AP_DM151_g3_blk",
"gm_20Rnd_762x51mm_B_T_DM21_g3_des",
"gm_20Rnd_762x51mm_B_T_DM21A1_g3_des",
"gm_20Rnd_762x51mm_B_T_DM21A2_g3_des",
"gm_20Rnd_762x51mm_B_DM111_g3_des",
"gm_20Rnd_762x51mm_B_DM41_g3_des",
"gm_20Rnd_762x51mm_AP_DM151_g3_des",
"gm_30Rnd_556x45mm_B_M855_stanag_gry",
"gm_30Rnd_556x45mm_B_M193_stanag_gry",
"gm_30Rnd_556x45mm_B_T_M856_stanag_gry",
"gm_30Rnd_556x45mm_B_T_M196_stanag_gry",
"gm_20Rnd_556x45mm_B_M855_stanag_gry",
"gm_20Rnd_556x45mm_B_M193_stanag_gry",
"gm_20Rnd_556x45mm_B_T_M856_stanag_gry",
"gm_20Rnd_556x45mm_B_T_M196_stanag_gry",
"gm_10Rnd_762x54mmR_AP_7N1_svd_blk",
"gm_10Rnd_762x54mmR_API_7bz3_svd_blk",
"gm_10Rnd_762x54mmR_B_T_7t2_svd_blk",
"gm_handgrenade_frag_dm51",
"gm_handgrenade_frag_dm51a1",
"gm_handgrenade_pracfrag_dm58",
"gm_handgrenade_conc_dm51",
"gm_handgrenade_conc_dm51a1",
"gm_handgrenade_pracconc_dm58",
"gm_handgrenade_frag_rgd5",
"gm_smokeshell_grn_dm21",
"gm_smokeshell_red_dm23",
"gm_smokeshell_yel_dm26",
"gm_smokeshell_org_dm32",
"gm_smokeshell_wht_dm25",
"gm_smokeshell_grn_gc",
"gm_smokeshell_blk_gc",
"gm_smokeshell_red_gc",
"gm_smokeshell_yel_gc",
"gm_smokeshell_blu_gc",
"gm_smokeshell_org_gc",
"gm_smokeshell_wht_gc",
"gm_mine_at_mn111",
"gm_mine_kt_dino"
]























// Prairie Fire

// Uniforms

// Vest

// Backpack

//Headgear

// Goggles

// Binocular (camera)

// Primary Weapons

// Secondary Weapons

// Handgun Weapons


//Primary weapon items

// Magazines


















