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

	"documentation\Arsenal & Gear Restrictions.txt"
	
Notes:

	- It could take several hours to configure this script to your liking.
	- Hard-coded gear blacklists are inside "code\functions\fn_clientArsenal.sqf", but that file requires mission update to edit while this file only requires server restart to take effect.
	- You do not need to update the mission file to edit this script, it can be done between restarts.
_______________________________________________________/*/

//=========================================== GET PLAYER ROLE

params [
	['_side',WEST],
	['_role','rifleman']
];

//=========================================== At this point you could build up lists of weapons like "normalguns + marksmanguns + sniperguns + LMGguns + HMGguns" and use those variables instead of the default copy-paste used below.
// These variables are just suggestions, you would add them together like this:   (_weaponsBasic + _weaponsMarksman + _weaponsHandgun)
// All weapons including pistols, launchers, binoculars (yes they are classified as a weapon).
_weaponsAll = [
	'','arifle_arx_ghex_f','hgun_pistol_heavy_02_f','arifle_ak12_f','arifle_ak12_gl_f','arifle_akm_f','arifle_aks_f','srifle_dmr_04_f',
	'srifle_dmr_04_tan_f','arifle_ctars_blk_f','arifle_ctars_ghex_f','arifle_ctars_hex_f','arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f',
	'arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f','srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f','srifle_dmr_05_blk_f',
	'srifle_dmr_05_hex_f','srifle_dmr_05_tan_f','srifle_gm6_ghex_f','srifle_gm6_f','srifle_gm6_camo_f','arifle_katiba_f','arifle_katiba_c_f','arifle_katiba_gl_f',
	'lmg_03_f','srifle_lrr_f','srifle_lrr_camo_f','srifle_lrr_tna_f','srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f','srifle_dmr_03_f','srifle_dmr_03_multicam_f',
	'srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f','srifle_dmr_06_camo_f','srifle_dmr_06_olive_f','srifle_ebr_f','arifle_mk20_plain_f','arifle_mk20_f',
	'arifle_mk20_gl_plain_f','arifle_mk20_gl_f','lmg_mk200_f','arifle_mk20c_plain_f','arifle_mk20c_f','arifle_mx_gl_black_f','arifle_mx_gl_khk_f','arifle_mx_gl_f','arifle_mx_black_f',
	'arifle_mx_khk_f','arifle_mx_f','arifle_mx_sw_black_f','arifle_mx_sw_khk_f','arifle_mx_sw_f','arifle_mxc_black_f','arifle_mxc_khk_f','arifle_mxc_f','arifle_mxm_black_f','arifle_mxm_khk_f',
	'arifle_mxm_f','mmg_01_hex_f','mmg_01_tan_f','hgun_pdw2000_f','smg_05_f','srifle_dmr_01_f','arifle_sdar_f','arifle_spar_01_blk_f','arifle_spar_01_khk_f','arifle_spar_01_snd_f',
	'arifle_spar_01_gl_blk_f','arifle_spar_01_gl_khk_f','arifle_spar_01_gl_snd_f','arifle_spar_02_blk_f','arifle_spar_02_khk_f','arifle_spar_02_snd_f','arifle_spar_03_blk_f','arifle_spar_03_khk_f',
	'arifle_spar_03_snd_f','mmg_02_black_f','mmg_02_camo_f','mmg_02_sand_f','smg_02_f','arifle_trg20_f','arifle_trg21_f','arifle_trg21_gl_f','arifle_arx_blk_f','arifle_arx_hex_f','smg_01_f',
	'lmg_zafir_f','hgun_pistol_heavy_01_f','hgun_acpc2_f','hgun_p07_khk_f','hgun_p07_f','hgun_pistol_01_f','hgun_p07_blk_f',
	'smg_03_black','smg_03_camo','smg_03_hex','smg_03_khaki','smg_03_tr_black','smg_03_tr_camo','smg_03_tr_hex','smg_03_tr_khaki',
	'smg_03c_black','smg_03c_camo','smg_03c_hex','smg_03c_khaki','smg_03c_tr_black','smg_03c_tr_camo','smg_03c_tr_hex','smg_03c_tr_khaki',
	'hgun_rook40_f','hgun_pistol_signal_f','binocular','laserdesignator_02_ghex_f','laserdesignator_02','laserdesignator_01_khk_f','laserdesignator_03','laserdesignator','rangefinder',
	'launch_nlaw_f','launch_rpg32_f','launch_rpg32_ghex_f','launch_rpg7_f','launch_i_titan_f','launch_o_titan_ghex_f','launch_o_titan_f','launch_b_titan_f','launch_b_titan_tna_f',
	'launch_o_titan_short_f','launch_o_titan_short_ghex_f','launch_i_titan_short_f','launch_b_titan_short_tna_f','launch_b_titan_short_f',
	'launch_o_vorona_brown_f','launch_o_vorona_green_f','launch_mraws_green_rail_f','launch_mraws_olive_rail_f','launch_mraws_sand_rail_f','launch_mraws_green_f','launch_mraws_olive_f','launch_mraws_sand_f',
	'arifle_ak12_arid_f','arifle_ak12_lush_f','arifle_ak12_gl_arid_f','arifle_ak12_gl_lush_f',
	'arifle_ak12u_f','arifle_ak12u_arid_f','arifle_ak12u_lush_f',
	'sgun_huntershotgun_01_f','sgun_huntershotgun_01_sawedoff_f',
	'srifle_dmr_06_hunter_f',
	'lmg_mk200_black_f',
	'arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f','arifle_msbs65_gl_f','arifle_msbs65_gl_black_f','arifle_msbs65_gl_camo_f','arifle_msbs65_gl_sand_f',
	'arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f','arifle_msbs65_ubs_f','arifle_msbs65_ubs_black_f','arifle_msbs65_ubs_camo_f','arifle_msbs65_ubs_sand_f',
	'arifle_rpk12_f','arifle_rpk12_arid_f','arifle_rpk12_lush_f',
	'launch_rpg32_green_f',
	'launch_i_titan_eaf_f','launch_b_titan_olive_f',
	'hgun_pistol_heavy_01_green_f'	
];

// General infantry rifles + marksman rifles
_weaponsBasic = [
	'','arifle_arx_ghex_f','arifle_ak12_f','arifle_ak12_gl_f','arifle_akm_f','arifle_aks_f','srifle_dmr_04_f',
	'srifle_dmr_04_tan_f','arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f',
	'arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f','srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f',
	'arifle_katiba_f','arifle_katiba_c_f','arifle_katiba_gl_f',
	'srifle_dmr_03_f','srifle_dmr_03_multicam_f',
	'srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f','srifle_dmr_06_camo_f','srifle_dmr_06_olive_f','srifle_ebr_f','arifle_mk20_plain_f','arifle_mk20_f',
	'arifle_mk20_gl_plain_f','arifle_mk20_gl_f','arifle_mk20c_plain_f','arifle_mk20c_f','arifle_mx_gl_black_f','arifle_mx_gl_khk_f','arifle_mx_gl_f','arifle_mx_black_f',
	'arifle_mx_khk_f','arifle_mx_f','arifle_mxc_black_f','arifle_mxc_khk_f','arifle_mxc_f','arifle_mxm_black_f','arifle_mxm_khk_f',
	'arifle_mxm_f','srifle_dmr_01_f','arifle_sdar_f','arifle_spar_01_blk_f','arifle_spar_01_khk_f','arifle_spar_01_snd_f',
	'arifle_spar_01_gl_blk_f','arifle_spar_01_gl_khk_f','arifle_spar_01_gl_snd_f','arifle_spar_03_blk_f','arifle_spar_03_khk_f',
	'arifle_spar_03_snd_f','arifle_trg20_f','arifle_trg21_f','arifle_trg21_gl_f','arifle_arx_blk_f','arifle_arx_hex_f','arifle_sdar_f',
	'smg_03_black','smg_03_camo','smg_03_hex','smg_03_khaki','smg_03_tr_black','smg_03_tr_camo','smg_03_tr_hex','smg_03_tr_khaki',
	'arifle_ak12_arid_f','arifle_ak12_lush_f','arifle_ak12_gl_arid_f','arifle_ak12_gl_lush_f',
	'arifle_ak12u_f','arifle_ak12u_arid_f','arifle_ak12u_lush_f',
	'sgun_huntershotgun_01_f','sgun_huntershotgun_01_sawedoff_f',
	'srifle_dmr_06_hunter_f',
	'arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f','arifle_msbs65_gl_f','arifle_msbs65_gl_black_f','arifle_msbs65_gl_camo_f','arifle_msbs65_gl_sand_f',
	'arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f','arifle_msbs65_ubs_f','arifle_msbs65_ubs_black_f','arifle_msbs65_ubs_camo_f','arifle_msbs65_ubs_sand_f'
];
// marksman rifles
_weaponsMarksman = [
	'srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f',
	'srifle_dmr_03_f','srifle_dmr_03_multicam_f','srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f',
	'srifle_ebr_f'
];
// heavy marksman rifles
_weaponsMarksmanHeavy = [
	'srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f',
	'srifle_dmr_05_blk_f','srifle_dmr_05_hex_f','srifle_dmr_05_tan_f'
];
// Sniper rifles
_weaponsSniper = [
	'srifle_gm6_ghex_f','srifle_gm6_f','srifle_gm6_camo_f','srifle_lrr_f','srifle_lrr_camo_f','srifle_lrr_tna_f',
	'srifle_gm6_lrps_f','srifle_gm6_sos_f','srifle_gm6_camo_lrps_f','srifle_gm6_camo_sos_f',
	'srifle_lrr_camo_lrps_f','srifle_lrr_camo_sos_f','srifle_lrr_tna_lrps_f','srifle_gm6_ghex_lrps_f','srifle_lrr_lrps_f','srifle_lrr_sos_f'
];
// high-capacity variants of rifles (drum magazines, variants with 100 round mags,etc)
_weaponsSW = [
	'arifle_ctars_blk_f','arifle_ctars_ghex_f','arifle_ctars_hex_f','arifle_mx_sw_black_f','arifle_mx_sw_khk_f','arifle_mx_sw_f','arifle_spar_02_blk_f','arifle_spar_02_khk_f','arifle_spar_02_snd_f'
];
// light machine guns
_weaponsLMG = [
	'lmg_03_f','lmg_mk200_f','lmg_zafir_f','arifle_rpk12_f','arifle_rpk12_arid_f','arifle_rpk12_lush_f','lmg_mk200_black_f'
];
// medium machine guns
_weaponsMMG = [
	'mmg_01_hex_f','mmg_01_tan_f','mmg_02_black_f','mmg_02_camo_f','mmg_02_sand_f'
];
// compact weapons
_weaponsCompact = [
	'arifle_aks_f','arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f','arifle_katiba_c_f','arifle_mk20_plain_f','arifle_mk20_f','arifle_mxc_f',
	'arifle_mxc_black_f','arifle_mxc_khk_f','arifle_sdar_f','arifle_spar_01_blk_f','arifle_spar_01_khk_f','arifle_spar_01_snd_f','arifle_trg20_f',
	'arifle_ak12u_f','arifle_ak12u_arid_f','arifle_ak12u_lush_f',
	'arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f'
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
	'launch_nlaw_f','launch_rpg32_f','launch_rpg32_ghex_f','launch_i_titan_f','launch_o_titan_ghex_f','launch_o_titan_f','launch_b_titan_f','launch_b_titan_tna_f',
	'launch_o_titan_short_f','launch_o_titan_short_ghex_f','launch_i_titan_short_f','launch_b_titan_short_tna_f','launch_b_titan_short_f',
	'launch_o_vorona_brown_f','launch_o_vorona_green_f','launch_mraws_green_rail_f','launch_mraws_olive_rail_f','launch_mraws_sand_rail_f','launch_mraws_green_f','launch_mraws_olive_f','launch_mraws_sand_f',
	'launch_rpg32_green_f','launch_i_titan_eaf_f','launch_b_titan_olive_f'
];
// light AT
_weaponsLauncherLAT = [
	'launch_nlaw_f','launch_rpg32_f','launch_rpg32_ghex_f','launch_rpg7_f','launch_i_titan_f','launch_o_titan_ghex_f','launch_o_titan_f','launch_b_titan_f','launch_b_titan_tna_f',
	'launch_mraws_green_rail_f','launch_mraws_olive_rail_f','launch_mraws_sand_rail_f','launch_rpg32_green_f','launch_i_titan_eaf_f','launch_b_titan_olive_f'
];
// heavy AT
_weaponsLauncherHAT = [
	'launch_rpg7_f','launch_i_titan_f','launch_o_titan_ghex_f','launch_o_titan_f','launch_b_titan_f','launch_b_titan_tna_f',
	'launch_o_titan_short_f','launch_o_titan_short_ghex_f','launch_i_titan_short_f','launch_b_titan_short_tna_f','launch_b_titan_short_f','launch_o_vorona_brown_f','launch_o_vorona_green_f',
	'launch_i_titan_eaf_f','launch_b_titan_olive_f'
];
// pistols / handguns
_weaponsHandgun = [
	'hgun_pistol_heavy_02_f','hgun_pistol_heavy_01_f','hgun_acpc2_f','hgun_p07_khk_f','hgun_p07_f','hgun_pistol_01_f','hgun_rook40_f','hgun_pistol_signal_f','arifle_sdar_f','hgun_pistol_heavy_01_green_f','hgun_p07_blk_f'
];
// submachine guns
_weaponsSMG = [
	'smg_01_f','smg_02_f','smg_05_f','hgun_pdw2000_f','arifle_aks_f',
	'smg_03c_black','smg_03c_camo','smg_03c_hex','smg_03c_khaki','smg_03c_tr_black','smg_03c_tr_camo','smg_03c_tr_hex','smg_03c_tr_khaki'
];
// underwater weapons
_weaponsUW = [
	'arifle_sdar_f'
];
// binoculars, rangefinders, designators
_viewersAll = [
	'binocular','laserdesignator_02_ghex_f','laserdesignator_02','laserdesignator_01_khk_f','laserdesignator_03','laserdesignator','rangefinder'
];
// Binoculars and rangefinders (no lasers)
_viewersBasic = [
	'binocular','rangefinder'
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

];
// sniper uniforms
_uniformsSniper = [
	'u_b_t_sniper_f','u_b_ghilliesuit','u_b_fullghillie_ard','u_b_t_fullghillie_tna_f','u_b_fullghillie_lsh','u_b_fullghillie_sard'
];
// pilot uniforms
_uniformsPilot = [
	'u_b_helipilotcoveralls','u_i_helipilotcoveralls','u_i_pilotcoveralls','u_b_pilotcoveralls'
];
// all helmets, except for thermal stuff
_headgearBasic = [
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
	'h_headbandage_bloody_f','h_headset_black_f','h_headset_orange_f','h_headset_red_f','h_headset_white_f','h_headset_yellow_f','h_crewhelmetheli_i','h_crewhelmetheli_b','h_pilothelmetheli_i',
	'h_pilothelmetheli_b','h_helmetb_light','h_helmetb_light_black','h_helmetb_light_desert','h_helmetb_light_grass','h_helmetb_light_sand','h_helmetb_light_snakeskin','h_helmetb_light_tna_f',
	'h_cap_marshal','h_milcap_blue','h_milcap_gen_f','h_milcap_gry','h_milcap_mcamo','h_milcap_tna_f','h_milcap_dgtl','h_helmetia','h_pilothelmetfighter_b','h_pasgt_basic_blue_press_f',
	'h_pasgt_neckprot_blue_press_f','h_cap_headphones','h_hat_safari_olive_f','h_hat_safari_sand_f','h_shemag_olive','h_shemag_olive_hs','h_shemagopen_tan','h_shemagopen_khk','h_helmet_skate',
	'h_helmetb_ti_tna_f','h_strawhat','h_strawhat_dark','h_wirelessearpiece_f',
	'h_tank_black_f','h_helmethbk_headset_f','h_helmethbk_chops_f','h_helmethbk_ear_f','h_helmethbk_f','h_helmetaggressor_f','h_helmetaggressor_cover_f','h_helmetaggressor_cover_taiga_f',
	'h_beret_eaf_01_f','h_booniehat_mgrn','h_booniehat_taiga','h_booniehat_wdl','h_booniehat_eaf','h_helmetb_plain_wdl','h_tank_eaf_f','h_helmetcrew_i_e','h_helmetspecb_wdl',
	'h_crewhelmetheli_i_e','h_pilothelmetheli_i_e','h_helmetb_light_wdl','h_milcap_grn','h_milcap_taiga','h_milcap_wdl','h_milcap_eaf','h_pilothelmetfighter_i_e','h_hat_tinfoil_f','h_helmetb_ti_arid_f'
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
	'b_mortar_01_weapon_grn_f','b_radiobag_01_f',
	'b_assaultpack_eaf_f','b_assaultpack_wdl_f','b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f','b_fieldpack_green_f','b_fieldpack_taiga_f','b_combinationunitrespirator_01_f',
	'b_radiobag_01_black_f','b_radiobag_01_digi_f','b_radiobag_01_eaf_f','b_radiobag_01_ghex_f','b_radiobag_01_hex_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','b_radiobag_01_oucamo_f','b_radiobag_01_wdl_f',
	'b_scba_01_f'
];
// Regular sized backpacks (all backpacks except for the big ones)
_backpacksBasic = [
	'','b_assaultpack_blk','b_assaultpack_cbr','b_assaultpack_dgtl','b_assaultpack_rgr','b_assaultpack_ocamo','b_assaultpack_khk','b_assaultpack_mcamo',
	'b_assaultpack_sgg','b_assaultpack_tna_f','b_bergen_rgr',
	'b_hmg_01_high_weapon_f','b_hmg_01_weapon_f','b_gmg_01_high_weapon_f','b_gmg_01_weapon_f','b_fieldpack_blk',
	'b_fieldpack_cbr','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_fieldpack_khk','b_fieldpack_oli','b_fieldpack_oucamo','b_mortar_01_support_f','b_mortar_01_weapon_f',
	'b_hmg_01_support_high_f','b_hmg_01_support_f','b_kitbag_cbr','b_kitbag_rgr','b_kitbag_mcamo','b_kitbag_sgg','b_legstrapbag_black_f','b_legstrapbag_coyote_f',
	'b_legstrapbag_olive_f','b_messenger_black_f','b_messenger_coyote_f','b_messenger_gray_f','b_messenger_olive_f','b_static_designator_01_weapon_f','b_aa_01_weapon_f',
	'b_at_01_weapon_f','b_parachute','b_tacticalpack_blk','b_tacticalpack_rgr','b_tacticalpack_ocamo','b_tacticalpack_mcamo','b_tacticalpack_oli','b_uav_06_backpack_f',
	'b_uav_06_medical_backpack_f','b_uav_01_backpack_f','b_assaultpack_kerry','b_viperharness_blk_f','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperharness_khk_f',
	'b_viperharness_oli_f','b_viperlightharness_blk_f','b_viperlightharness_ghex_f','b_viperlightharness_hex_f','b_viperlightharness_khk_f','b_viperlightharness_oli_f',
	'b_mortar_01_weapon_grn_f',
	'b_assaultpack_eaf_f','b_assaultpack_wdl_f','b_fieldpack_green_f','b_fieldpack_taiga_f','b_combinationunitrespirator_01_f',
	'b_scba_01_f','b_w_static_designator_01_weapon_f',
	//'b_g_hmg_02_high_weapon_f','b_g_hmg_02_support_f','b_g_hmg_02_support_high_f','b_g_hmg_02_weapon_f'	// these are not arsenal compatible yet (Arma 2.00)
	'i_c_hmg_02_support_f','i_c_hmg_02_weapon_f','i_c_hmg_02_high_weapon_f','i_c_hmg_02_support_high_f'
];
// Large backpacks
_backpacksLarge = [
	'b_bergen_dgtl_f','b_bergen_hex_f','b_bergen_mcamo_f','b_bergen_tna_f',
	'b_carryall_cbr','b_carryall_ghex_f','b_carryall_ocamo','b_carryall_khk','b_carryall_mcamo','b_carryall_oli','b_carryall_oucamo',
	'b_carryall_eaf_f','b_carryall_green_f','b_carryall_taiga_f','b_carryall_wdl_f'
];
// NATO backpacks which can be assembled into static turrets (tripods + weapon)
_backpacksStatic = [
	'b_hmg_01_high_weapon_f','b_hmg_01_weapon_f','b_gmg_01_high_weapon_f','b_gmg_01_weapon_f',
	'b_mortar_01_support_f','b_mortar_01_weapon_f',
	'b_hmg_01_support_high_f','b_hmg_01_support_f',
	'b_static_designator_01_weapon_f','b_w_static_designator_01_weapon_f',
	'b_aa_01_weapon_f','b_at_01_weapon_f',
	'b_mortar_01_weapon_grn_f',
	//'b_g_hmg_02_high_weapon_f','b_g_hmg_02_support_f','b_g_hmg_02_support_high_f','b_g_hmg_02_weapon_f'	// these are not arsenal compatible yet (Arma 2.00)
	'i_c_hmg_02_support_f','i_c_hmg_02_weapon_f','i_c_hmg_02_high_weapon_f','i_c_hmg_02_support_high_f'
];
// UAV backpacks
_backpacksUAV = [
	'b_uav_01_backpack_f','b_uav_06_medical_backpack_f','b_ugv_02_demining_backpack_f','b_ugv_02_science_backpack_f'
];
// Radio backpacks
_backpacksRadio = [
	'b_radiobag_01_black_f','b_radiobag_01_digi_f','b_radiobag_01_eaf_f','b_radiobag_01_ghex_f','b_radiobag_01_hex_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','b_radiobag_01_oucamo_f','b_radiobag_01_wdl_f'
];
// all goggles
_gogglesAll = [
	'','none','g_spectacles','g_spectacles_tinted','g_combat','g_lowprofile','g_shades_black','g_shades_green','g_shades_red','g_squares','g_squares_tinted','g_sport_blackwhite',
	'g_sport_blackyellow','g_sport_greenblack','g_sport_checkered','g_sport_red','g_tactical_black','g_aviator','g_lady_mirror','g_lady_dark','g_lady_red','g_lady_blue','g_diving',
	'g_b_diving','g_o_diving','g_i_diving','g_goggles_vr','g_balaclava_blk','g_balaclava_oli','g_balaclava_combat','g_balaclava_lowprofile','g_bandanna_blk','g_bandanna_oli','g_bandanna_khk',
	'g_bandanna_tan','g_bandanna_beast','g_bandanna_shades','g_bandanna_sport','g_bandanna_aviator','g_shades_blue','g_sport_blackred','g_tactical_clear','g_balaclava_ti_blk_f','g_balaclava_ti_tna_f',
	'g_balaclava_ti_g_blk_f','g_balaclava_ti_g_tna_f','g_combat_goggles_tna_f','g_respirator_base_f','g_respirator_white_f','g_respirator_yellow_f','g_respirator_blue_f','g_eyeprotectors_base_f',
	'g_eyeprotectors_f','g_eyeprotectors_earpiece_f','g_wirelessearpiece_base_f','g_wirelessearpiece_f',
	'g_airpurifyingrespirator_02_black_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_01_f','g_blindfold_01_black_f','g_blindfold_01_white_f','g_regulatormask_f'
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
	'optic_nightstalker','optic_tws','optic_tws_mg',
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
	'bipod_02_f_lush','optic_ico_01_f','optic_ico_01_black_f','optic_ico_01_camo_f','optic_ico_01_sand_f','optic_mrd_black'
];
// all weapon attachments
_attachmentsBasic = [
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
	'bipod_02_f_lush','optic_ico_01_f','optic_ico_01_black_f','optic_ico_01_camo_f','optic_ico_01_sand_f','optic_mrd_black'
];
// thermal weapon attachments
_attachmentsThermal = [
	'optic_nightstalker','optic_tws','optic_tws_mg'
];
// special inventory items + head-mounted displays like NVG, including thermal
_assignedItemsAll = [
	'nvgogglesb_blk_f','nvgogglesb_grn_f','nvgogglesb_gry_f',
	'','itemmap','itemcompass','itemwatch','itemradio','itemgps','chemicaldetector_01_watch_f',
	'nvgoggles_tna_f','o_nvgoggles_ghex_f','o_nvgoggles_hex_f','o_nvgoggles_urb_f','o_nvgoggles_grn_f','nvgoggles_opfor','nvgoggles','nvgoggles_indep'
];
// same as above but with no thermal
_assignedItemsBasic = [
	'','itemmap','itemcompass','itemwatch','itemradio','itemgps','chemicaldetector_01_watch_f',
	'nvgoggles_tna_f','o_nvgoggles_ghex_f','o_nvgoggles_hex_f','o_nvgoggles_urb_f','o_nvgoggles_grn_f','nvgoggles_opfor','nvgoggles','nvgoggles_indep'
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
	'','v_harnessogl_brn','v_harnessogl_ghex_f','v_harnesso_brn','v_harnesso_ghex_f','v_harnesso_gry','v_bandollierb_cbr','v_tacchestrig_cbr_f','v_tacvest_khk'
];
_o_backpacks = [
	'','b_assaultpack_ocamo','b_fieldpack_ghex_f','b_fieldpack_ocamo','b_tacticalpack_ocamo','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperlightharness_blk_f',
	'b_viperlightharness_ghex_f','b_viperlightharness_hex_f'
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
};
// Rifleman role (Grenadier, marksman, engineer, medic, mortar gunner, etc)
if (_role isEqualTo 'rifleman') exitWith {
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
			(_weaponsMMG + _weaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsAll,			// whitelisted UNIFORMS
				_vestsAll,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsAll,		// whitelisted ASSIGNED ITEMS
				_headgearBasic,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_backpacksAll,				// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsMarksmanHeavy + _weaponsHandgun + _weaponsSMG + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Rifleman role (Grenadier, marksman, engineer, medic, mortar gunner, etc)
if (_role in ['engineer','medic','mortar_gunner','medic_WL']) exitWith {
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
			(_weaponsMMG + _weaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_uniformsAll,			// whitelisted UNIFORMS
				_vestsAll,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsAll,		// whitelisted ASSIGNED ITEMS
				_headgearBasic,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_attachmentsAll			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_backpacksAll,				// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsHandgun + _weaponsSMG + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Machine gunner, autorifleman, etc
if (_role isEqualTo 'autorifleman') exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsSW + _weaponsLMG + _weaponsHandgun + _viewersAll + _weaponsUW)	// whitelisted WEAPONS
		]
	]
};
if (_role in ['machine_gunner','machine_gunner_WL']) exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsMMG + _weaponsHandgun + _viewersAll + _weaponsUW)	// whitelisted WEAPONS
		]
	]
};
// AT / AA / Missile soldiers, etc
if (_role isEqualTo 'rifleman_lat') exitWith {
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
			[	// ITEMS
				_uniformsAll,							// whitelisted UNIFORMS
				_vestsAll,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				_assignedItemsAll,						// whitelisted ASSIGNED ITEMS
				_headgearBasic,							// whitelisted HEADGEAR
				_gogglesAll,							// whitelisted goggles
				_attachmentsAll							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			_backpacksAll,								// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsLauncherLAT + _weaponsHandgun + _weaponsSMG + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'rifleman_hat') exitWith {
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
			[	// ITEMS
				_uniformsAll,							// whitelisted UNIFORMS
				_vestsAll,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				_assignedItemsAll,						// whitelisted ASSIGNED ITEMS
				_headgearBasic,							// whitelisted HEADGEAR
				_gogglesAll,							// whitelisted goggles
				_attachmentsAll							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			_backpacksAll,								// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsLauncherHAT + _weaponsHandgun + _weaponsSMG + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Sniper role
if (_role in ['sniper','sniper_WL']) exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsSniper + _weaponsSMG + _weaponsHandgun + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'crewman') exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsCompact + _weaponsSMG + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// JTAC role
if (_role isEqualTo 'jtac') exitWith {
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
			[	// ITEMS
				_uniformsAll,							// whitelisted UNIFORMS
				_vestsAll,								// whitelisted VESTS
				_inventoryAll,							// whitelisted Inventory
				_assignedItemsAll,						// whitelisted ASSIGNED ITEMS
				_headgearBasic,							// whitelisted HEADGEAR
				_gogglesAll,							// whitelisted goggles
				_attachmentsAll							// whitelisted Attachments
			],
			_magazinesAll,								// whitelisted MAGAZINES
			_backpacksRadio,							// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsHandgun + _weaponsSMG + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Pilot role
if (_role in ['pilot','pilot_plane','pilot_cas','pilot_heli','pilot_heli_WL']) exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsHandgun + _weaponsSMG + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Officer/Commander role
if (_role isEqualTo 'commander') exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsHandgun + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Squad leader/Team leader role
if (_role in ['leader']) exitWith {
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
			[	// ITEMS
				_uniformsAll,						// whitelisted UNIFORMS
				_vestsAll,							// whitelisted VESTS
				_inventoryAll,						// whitelisted Inventory
				_assignedItemsAll,					// whitelisted ASSIGNED ITEMS
				_headgearBasic,						// whitelisted HEADGEAR
				_gogglesAll,						// whitelisted goggles
				_attachmentsAll						// whitelisted Attachments
			],
			_magazinesAll,							// whitelisted MAGAZINES
			_backpacksAll,							// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsHandgun + _weaponsSMG + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// UAV Operator role
if (_role isEqualTo 'uav') exitWith {
	[
		[	// -------------------------------------------------------------- BLACKLIST
			[	// ITEMS
				[	// blacklisted uniforms
				
				],
				[	// blacklisted vests
				
				],
				[	// blacklisted inventory
				
				],
				[	// blacklisted assigned items  (we dont blacklist the uav terminal for the uav operator!)
					
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
			[	// ITEMS
				_uniformsAll,								// whitelisted UNIFORMS
				_vestsAll,									// whitelisted VESTS
				_inventoryAll,								// whitelisted Inventory
				(_assignedItemsAll + _assignedItemsUAV),	// whitelisted ASSIGNED ITEMS
				_headgearBasic,								// whitelisted HEADGEAR
				_gogglesAll,								// whitelisted goggles
				_attachmentsAll								// whitelisted Attachments
			],
			_magazinesAll,									// whitelisted MAGAZINES
			_backpacksAll,									// whitelisted BACKPACKS
			(_weaponsBasic + _weaponsHandgun + _weaponsSMG + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_rifleman') exitWith {
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
			(_weaponsMMG + _weaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsAll,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_o_attachments			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			((_o_weapons - [_weaponsSW + _weaponsLMG]) + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
if (_role isEqualTo 'o_autorifleman') exitWith {
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
			(_weaponsMMG + _weaponsSniper + _weaponsLauncherRegular)	// blacklisted WEAPONS
		],
		[	// -------------------------------------------------------------- WHITELIST
			[	// ITEMS
				_o_uniforms,			// whitelisted UNIFORMS
				_o_vests,				// whitelisted VESTS
				_inventoryAll,			// whitelisted Inventory
				_assignedItemsAll,		// whitelisted ASSIGNED ITEMS
				_o_headgear,			// whitelisted HEADGEAR
				_gogglesAll,			// whitelisted goggles
				_o_attachments			// whitelisted Attachments
			],
			_magazinesAll,				// whitelisted MAGAZINES
			_o_backpacks,				// whitelisted BACKPACKS
			(_o_weapons + _weaponsHandgun + _weaponsLauncherBasic + _viewersAll)	// whitelisted WEAPONS
		]
	]
};
// Default
([WEST,'rifleman'] call (missionNamespace getVariable 'QS_data_arsenal'))