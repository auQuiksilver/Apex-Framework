/*/
File: QS_data_listItems.sqf
Author:

	Quiksilver
	
Last modified:

	13/12/2022 A3 2.10 by Quiksilver
	
Description:

	Lists of Items
________________________________/*/

params ['_type',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	(QS_hashmap_classLists getOrDefaultCall [format ['i_%1',_type],{[_type,1] call QS_data_listItems},TRUE])
};
private _return = [];
if (_type isEqualTo 'radio_bags_1') exitWith {
	['b_radiobag_01_black_f','b_radiobag_01_digi_f','b_radiobag_01_eaf_f','b_radiobag_01_ghex_f','b_radiobag_01_hex_f','b_radiobag_01_mtp_f','b_radiobag_01_tropic_f','b_radiobag_01_oucamo_f','b_radiobag_01_wdl_f']
};
if (_type isEqualTo 'mortar_tubes_1') exitWith {
	['i_mortar_01_weapon_f','o_mortar_01_weapon_f','i_e_mortar_01_weapon_f','b_mortar_01_weapon_f','b_mortar_01_weapon_grn_f']
};
if (_type isEqualTo 'lightmachineguns_1') exitWith {
	[
		'lmg_03_f',0.3,
		'lmg_mk200_f',0.3,
		'lmg_mk200_black_f',0.3,
		'lmg_zafir_f',0.3,
		'mmg_01_hex_f',0,
		'mmg_02_black_f',0.1
	]
};
if (_type isEqualTo 'weaponlight_emitters_1') exitWith {
	['acc_pointer_ir','acc_flashlight','acc_flashlight_pistol','laserbatteries']
};
if (_type isEqualTo 'optics_long_1') exitWith {
	[
		'optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex',
		'optic_khs_old','optic_khs_tan','optic_lrps','optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f'
	]
};
if (_type isEqualTo 'optics_normal_1') exitWith {
	[
		'optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps',
		'optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f',
		'optic_arco','optic_arco_arid_f','optic_arco_blk_f','optic_arco_ghex_f','optic_arco_lush_f','optic_arco_ak_arid_f','optic_arco_ak_blk_f',
		'optic_arco_ak_lush_f','optic_erco_blk_f','optic_erco_khk_f','optic_erco_snd_f','optic_mrco','optic_hamr','optic_hamr_khk_f'
	]
};
if (_type isEqualTo 'sniper_rifles_1') exitWith {
	[	// Sniper rifles
		'srifle_gm6_ghex_f','srifle_gm6_f','srifle_gm6_camo_f','srifle_lrr_f','srifle_lrr_camo_f','srifle_lrr_tna_f',
		'srifle_gm6_lrps_f','srifle_gm6_sos_f','srifle_gm6_camo_lrps_f','srifle_gm6_camo_sos_f',
		'srifle_lrr_camo_lrps_f','srifle_lrr_camo_sos_f','srifle_lrr_tna_lrps_f','srifle_gm6_ghex_lrps_f','srifle_lrr_lrps_f','srifle_lrr_sos_f'
	]
};
if (_type isEqualTo 'smokelaunchermags') exitWith {
	['smokelaunchermag','smokelaunchermag_boat','smokelaunchermag_single']
};
if (_type isEqualTo 'air_to_ground_missiles_1') exitWith {
	[
		'pylonmissile_1rnd_lg_scalpel',
		'pylonmissile_missile_agm_02_x1',
		'pylonmissile_missile_agm_02_x2',
		'pylonmissile_missile_agm_kh25_int_x1',
		'pylonmissile_missile_agm_kh25_x1',
		'pylonrack_12rnd_pg_missiles',
		'pylonrack_1rnd_lg_scalpel',
		'pylonrack_1rnd_missile_agm_01_f',
		'pylonrack_1rnd_missile_agm_02_f',
		'pylonrack_3rnd_lg_scalpel',
		'pylonrack_3rnd_missile_agm_02_f',
		'pylonrack_4rnd_lg_scalpel',
		'pylonrack_missile_agm_02_x1',
		'pylonrack_missile_agm_02_x2',
		'pylonmissile_1rnd_mk82_f'
	]
};
_return;