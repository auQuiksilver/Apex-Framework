/*/
File: fn_unitSetup.sqf
Author: 

	Quiksilver

Last Modified:

	30/03/2023 A3 2.12 by Quiksilver
	
Description:

	Setup unit
______________________________________________________/*/

_unit = _this;
if (
	(!(missionNamespace getVariable ['QS_missionConfig_enemyRandGear',TRUE])) ||
	{((missionNamespace getVariable ['QS_system_activeDLC','']) isNotEqualTo '')} ||
	{((missionNamespace getVariable ['QS_missionConfig_dlcUnits','']) isNotEqualTo '')}
) exitWith {
	_unit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
	_unit
};
_unit = _this;
_unitType = toLowerANSI (typeOf _unit);
private _weapons = [];
private _optics = [];
private _backpacks = [];
private _weaponHandled = FALSE;
// Randomize primary weapon
if ((side _unit) in [EAST,RESISTANCE]) then {
	_excluded = [
		'o_v_soldier_exp_hex_f','o_v_soldier_jtac_hex_f','o_v_soldier_m_hex_f','o_v_soldier_hex_f','o_v_soldier_medic_hex_f','o_v_soldier_lat_hex_f',
		'o_v_soldier_tl_hex_f','o_v_soldier_exp_ghex_f','o_v_soldier_jtac_ghex_f','o_v_soldier_m_ghex_f','o_v_soldier_ghex_f','o_v_soldier_medic_ghex_f',
		'o_v_soldier_lat_ghex_f','o_v_soldier_tl_ghex_f','o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f',
		'o_recon_lat_f','o_recon_tl_f','o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_spotter_f','o_t_recon_exp_f','o_t_recon_jtac_f',
		'o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f','o_t_sniper_f','o_t_ghillie_tna_f','o_t_spotter_f',
		'o_diver_f','o_diver_exp_f','o_diver_tl_f','o_t_diver_f','o_t_diver_exp_f','o_t_diver_tl_f','i_spotter_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f',
		'i_diver_f','i_diver_exp_f','i_diver_tl_f',
		'o_r_soldier_ar_f','o_r_medic_f','o_r_soldier_exp_f','o_r_soldier_gl_f','o_r_jtac_f','o_r_soldier_m_f','o_r_soldier_lat_f','o_r_soldier_tl_f',
		'o_r_recon_ar_f','o_r_recon_exp_f','o_r_recon_gl_f','o_r_recon_jtac_f','o_r_recon_m_f','o_r_recon_medic_f','o_r_recon_lat_f','o_r_recon_tl_f',
		'o_heavygunner_f','o_urban_heavygunner_f','o_r_patrol_soldier_a_f','o_r_patrol_soldier_ar2_f','o_r_patrol_soldier_ar_f',
		'o_r_patrol_soldier_medic','o_r_patrol_soldier_engineer_f','o_r_patrol_soldier_gl_f','o_r_patrol_soldier_m2_f','o_r_patrol_soldier_lat_f','o_r_patrol_soldier_m_f','o_r_patrol_soldier_tl_f'
	];
	// Add radio backpack
	if (_unitType in [
		'o_soldier_sl_f','o_recon_jtac_f','o_recon_tl_f','o_v_soldier_jtac_hex_f','o_v_soldier_tl_hex_f','o_t_soldier_sl_f','o_t_recon_jtac_f','o_t_recon_tl_f','o_v_soldier_jtac_ghex_f',
		'o_v_soldier_tl_ghex_f','o_r_jtac_f','o_r_soldier_tl_f','o_r_recon_jtac_f','o_r_recon_tl_f','i_soldier_sl_f','o_soldieru_sl_f'
	]) then {
		if (_unitType in [
			'o_soldier_sl_f','o_recon_jtac_f','o_recon_tl_f','o_v_soldier_jtac_hex_f','o_v_soldier_tl_hex_f'
		]) then {
			_unit addBackpack 'B_RadioBag_01_hex_F';
		};
		if (_unitType in [
			'o_r_jtac_f','o_r_soldier_tl_f','o_r_recon_jtac_f','o_r_recon_tl_f'
		]) then {
			_unit addBackpack 'B_RadioBag_01_eaf_F';
		};
		if (_unitType in [
			'o_t_soldier_sl_f','o_t_recon_jtac_f','o_t_recon_tl_f','o_v_soldier_jtac_ghex_f','o_v_soldier_tl_ghex_f'
		]) then {
			_unit addBackpack 'B_RadioBag_01_ghex_F';
		};
		if (_unitType in [
			'i_soldier_sl_f'
		]) then {
			_unit addBackpack 'B_RadioBag_01_digi_F';
		};
		if (_unitType in [
			'o_soldieru_sl_f'
		]) then {
			_unit addBackpack 'B_RadioBag_01_oucamo_F';
		};
	};
	// autoriflemen
	if (_unitType in [
		'o_t_soldier_ar_f','o_soldier_ar_f','o_g_soldier_ar_f','i_g_soldier_ar_f','i_c_soldier_bandit_3_f','i_c_soldier_para_4_f','i_soldier_ar_f','i_e_soldier_ar_f','o_soldieru_ar_f'
	]) then {
		_weaponHandled = TRUE;
		_weapons = [
			'lmg_03_f',0.25,
			'lmg_mk200_f',0.125,
			'lmg_mk200_black_f',0.125,
			'lmg_zafir_f',0.25,
			'mmg_01_hex_f',0.1
		];
		_backpacks = [
			'b_fieldpack_cbr',
			'b_fieldpack_ocamo',
			'b_fieldpack_khk',
			'b_kitbag_tan',
			'b_tacticalpack_ocamo',
			'b_viperharness_hex_f',
			'b_viperlightharness_hex_f'
		];
		if (worldName in ['Tanoa']) then {
			_weapons = [
				'lmg_03_f',0.25,
				'lmg_mk200_f',0.125,
				'lmg_mk200_black_f',0.125,
				'lmg_zafir_f',0.25,
				'mmg_01_hex_f',0.05
			];
			_backpacks = [
				'b_fieldpack_taiga_f',
				'b_assaultpack_wdl_f',
				'b_assaultpack_eaf_f',
				'b_fieldpack_taiga_f',
				'b_fieldpack_green_f',
				'b_fieldpack_ghex_f',
				'b_viperharness_ghex_f',
				'b_viperharness_oli_f',
				'b_viperlightharness_oli_f',
				'b_viperlightharness_ghex_f'
			];
		};
		if (worldName in ['Enoch']) then {
			_weapons = [
				'lmg_03_f',0.25,
				'lmg_mk200_f',0.125,
				'lmg_mk200_black_f',0.125,
				'lmg_zafir_f',0.25,
				'mmg_01_hex_f',0.1
			];
			_backpacks = [
				'b_fieldpack_taiga_f',
				'b_assaultpack_wdl_f',
				'b_assaultpack_eaf_f',
				'b_fieldpack_taiga_f',
				'b_fieldpack_green_f',
				'b_fieldpack_ghex_f',
				'b_viperharness_ghex_f',
				'b_viperharness_oli_f',
				'b_viperlightharness_oli_f',
				'b_viperlightharness_ghex_f'
			];
		};
		if ((backpack _unit) isEqualTo '') then {
			_unit addBackpack (selectRandom _backpacks);
		};
		_unit removeWeapon (handgunWeapon _unit);
		_unit removeWeapon (primaryWeapon _unit);
		{
			_unit removeMagazine _x;
		} forEach (magazines _unit);
		[_unit,(selectRandomWeighted _weapons),5] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		_unit addPrimaryWeaponItem (selectRandom ['optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps','optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f']);
	};
	// grenade launcher
	if (_unitType in [
		'o_soldier_gl_f','o_soldier_tl_f','o_soldieru_gl_f','o_soldieru_tl_f','o_t_soldier_gl_f','o_t_soldier_tl_f','o_g_soldier_gl_f','o_g_soldier_tl_f','i_soldier_gl_f','i_soldier_tl_f',
		'i_g_soldier_gl_f','i_g_soldier_tl_f','i_e_soldier_gl_f','i_e_soldier_tl_f','i_c_soldier_bandit_6_f','i_c_soldier_para_6_f'
	]) then {
		_weaponHandled = TRUE;
		_weapons = [
			(selectRandom ['arifle_ak12_gl_f','arifle_ak12_gl_arid_f','arifle_ak12_gl_lush_f']),0.3,
			(selectRandom ['arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f']),0.1,
			'arifle_katiba_gl_f',0.1,
			(selectRandom ['arifle_mk20_gl_plain_f','arifle_mk20_gl_f']),0.05,
			(selectRandom ['arifle_msbs65_gl_f','arifle_msbs65_gl_black_f','arifle_msbs65_gl_camo_f','arifle_msbs65_gl_sand_f']),0.2,
			'arifle_trg21_gl_f',0.05
		];
		_backpacks = [
			'b_fieldpack_cbr',
			'b_fieldpack_ocamo',
			'b_fieldpack_khk',
			'b_kitbag_tan',
			'b_tacticalpack_ocamo',
			'b_viperharness_hex_f',
			'b_viperlightharness_hex_f'
		];
		if (worldName in ['Tanoa']) then {
			_weapons = [
				(selectRandom ['arifle_ak12_gl_f','arifle_ak12_gl_arid_f','arifle_ak12_gl_lush_f']),0.1,
				(selectRandom ['arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f']),0.1,
				'arifle_katiba_gl_f',0.1,
				(selectRandom ['arifle_mk20_gl_plain_f','arifle_mk20_gl_f']),0.1,
				(selectRandom ['arifle_msbs65_gl_f','arifle_msbs65_gl_black_f','arifle_msbs65_gl_camo_f','arifle_msbs65_gl_sand_f']),0.1,
				'arifle_trg21_gl_f',0.1
			];
			_backpacks = [
				'b_fieldpack_taiga_f',
				'b_assaultpack_wdl_f',
				'b_assaultpack_eaf_f',
				'b_fieldpack_taiga_f',
				'b_fieldpack_green_f',
				'b_fieldpack_ghex_f',
				'b_viperharness_ghex_f',
				'b_viperharness_oli_f',
				'b_viperlightharness_oli_f',
				'b_viperlightharness_ghex_f'
			];
		};
		if (worldName in ['Enoch']) then {
			_weapons = [
				(selectRandom ['arifle_ak12_gl_f','arifle_ak12_gl_arid_f','arifle_ak12_gl_lush_f']),0.3,
				(selectRandom ['arifle_ctar_gl_blk_f','arifle_ctar_gl_ghex_f','arifle_ctar_gl_hex_f']),0.1,
				'arifle_katiba_gl_f',0.1,
				(selectRandom ['arifle_mk20_gl_plain_f','arifle_mk20_gl_f']),0.1,
				(selectRandom ['arifle_msbs65_gl_f','arifle_msbs65_gl_black_f','arifle_msbs65_gl_camo_f','arifle_msbs65_gl_sand_f']),0.2,
				'arifle_trg21_gl_f',0.1
			];
			_backpacks = [
				'b_fieldpack_taiga_f',
				'b_assaultpack_wdl_f',
				'b_assaultpack_eaf_f',
				'b_fieldpack_taiga_f',
				'b_fieldpack_green_f',
				'b_fieldpack_ghex_f',
				'b_viperharness_ghex_f',
				'b_viperharness_oli_f',
				'b_viperlightharness_oli_f',
				'b_viperlightharness_ghex_f'
			];
		};
		{
			if (!((toLowerANSI _x) in ['1rnd_he_grenade_shell'])) then {
				_unit removeMagazine _x;
			};
		} forEach (magazines _unit);
		if ((backpack _unit) isEqualTo '') then {
			_unit addBackpack (selectRandom _backpacks);
		};
		[_unit,(selectRandomWeighted _weapons),10] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		_unit addPrimaryWeaponItem (selectRandom [
			'optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps',
			'optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f',
			'optic_arco','optic_arco_arid_f','optic_arco_blk_f','optic_arco_ghex_f','optic_arco_lush_f','optic_arco_ak_arid_f','optic_arco_ak_blk_f',
			'optic_arco_ak_lush_f','optic_erco_blk_f','optic_erco_khk_f','optic_erco_snd_f','optic_mrco','optic_hamr','optic_hamr_khk_f'
		]);
		for '_x' from 0 to 29 step 1 do {
			_unit addMagazine '1rnd_he_grenade_shell';
		};
		if ((handgunWeapon _unit) isNotEqualTo '') then {
			[_unit,(handgunWeapon _unit),2] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		};
	};
	// marksmen
	if (_unitType in [
		'o_soldier_m_f','o_soldieru_m_f','o_sharpshooter_f','o_urban_sharpshooter_f','o_t_soldier_m_f','o_g_soldier_m_f','o_g_sharpshooter_f','i_soldier_m_f','i_g_soldier_m_f','i_g_sharpshooter_f','i_e_soldier_m_f'
	]) then {
		_weaponHandled = TRUE;
		_weapons = [
			(selectRandom ['srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f']),0.05,
			(selectRandom ['srifle_dmr_05_blk_f','srifle_dmr_05_hex_f','srifle_dmr_05_tan_f']),0.3,
			(selectRandom ['srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f']),0.3,
			(selectRandom ['srifle_dmr_03_f','srifle_dmr_03_multicam_f','srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f']),0.1,
			(selectRandom ['srifle_dmr_06_camo_f','srifle_dmr_06_olive_f']),0.1,
			(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.1,
			'srifle_ebr_f',0.1,
			'srifle_dmr_01_f',0.3
		];
		if (worldName in ['Tanoa']) then {
			_weapons = [
				(selectRandom ['srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f']),0.3,
				(selectRandom ['srifle_dmr_05_blk_f','srifle_dmr_05_hex_f','srifle_dmr_05_tan_f']),0.1,
				(selectRandom ['srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f']),0.1,
				(selectRandom ['srifle_dmr_03_f','srifle_dmr_03_multicam_f','srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f']),0.1,
				(selectRandom ['srifle_dmr_06_camo_f','srifle_dmr_06_olive_f']),0.3,
				(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.3,
				'srifle_ebr_f',0.1,
				'srifle_dmr_01_f',0.1
			];
		};
		if (worldName in ['Enoch']) then {
			_weapons = [
				(selectRandom ['srifle_dmr_07_blk_f','srifle_dmr_07_ghex_f','srifle_dmr_07_hex_f']),0.1,
				(selectRandom ['srifle_dmr_05_blk_f','srifle_dmr_05_hex_f','srifle_dmr_05_tan_f']),0.1,
				(selectRandom ['srifle_dmr_02_f','srifle_dmr_02_camo_f','srifle_dmr_02_sniper_f']),0.1,
				(selectRandom ['srifle_dmr_03_f','srifle_dmr_03_multicam_f','srifle_dmr_03_khaki_f','srifle_dmr_03_tan_f','srifle_dmr_03_woodland_f']),0.1,
				(selectRandom ['srifle_dmr_06_camo_f','srifle_dmr_06_olive_f']),0.1,
				(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.5,
				'srifle_ebr_f',0.1,
				'srifle_dmr_01_f',0.1
			];
		};
		[_unit,(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_removeWeapon');
		[_unit,(selectRandomWeighted _weapons),12] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		if ((handgunWeapon _unit) isNotEqualTo '') then {
			[_unit,(handgunWeapon _unit),2] call (missionNamespace getVariable 'QS_fnc_addWeapon');
		};
		_unit addPrimaryWeaponItem (selectRandom ['optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps','optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f']);
	};
	// spotter
	if (_unitType in [
		'o_spotter_f','o_t_spotter_f','i_spotter_f'
	]) then {
		_weaponHandled = TRUE;
		_unit addPrimaryWeaponItem (selectRandom ['optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps','optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f']);
		_unit addPrimaryWeaponItem 'muzzle_snds_H';
	};
	if (!(_weaponHandled)) then {
		if (!(_unitType in _excluded)) then {
			// regular units
			_weaponHandled = TRUE;
			_weapons = [
				(selectRandom ['arifle_ak12_f','arifle_ak12_arid_f','arifle_ak12_lush_f']),0.5,
				'arifle_akm_f',0.1,
				(selectRandom ['arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f']),0.1,
				'arifle_katiba_f',0.5,
				(selectRandom ['arifle_mk20_plain_f','arifle_mk20_f']),0.1,
				(selectRandom ['arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f']),0.1,
				(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.1,
				'arifle_trg21_f',0.1
			];
			if (worldName in ['Tanoa']) then {
				_weapons = [
					(selectRandom ['arifle_ak12_f','arifle_ak12_arid_f','arifle_ak12_lush_f']),0.1,
					'arifle_akm_f',0.3,
					(selectRandom ['arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f']),0.3,
					'arifle_katiba_f',0.1,
					(selectRandom ['arifle_mk20_plain_f','arifle_mk20_f']),0.3,
					(selectRandom ['arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f']),0.1,
					(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.1,
					'arifle_trg21_f',0.3
				];
			};
			if (worldName in ['Enoch']) then {
				_weapons = [
					(selectRandom ['arifle_ak12_f','arifle_ak12_arid_f','arifle_ak12_lush_f']),0.3,
					'arifle_akm_f',0.2,
					(selectRandom ['arifle_ctar_blk_f','arifle_ctar_ghex_f','arifle_ctar_hex_f']),0.1,
					'arifle_katiba_f',0.1,
					(selectRandom ['arifle_mk20_plain_f','arifle_mk20_f']),0.1,
					(selectRandom ['arifle_msbs65_f','arifle_msbs65_black_f','arifle_msbs65_camo_f','arifle_msbs65_sand_f']),0.3,
					(selectRandom ['arifle_msbs65_mark_f','arifle_msbs65_mark_black_f','arifle_msbs65_mark_camo_f','arifle_msbs65_mark_sand_f']),0.3,
					'arifle_trg21_f',0.1
				];
			};
			[_unit,(primaryWeapon _unit)] call (missionNamespace getVariable 'QS_fnc_removeWeapon');
			[_unit,(selectRandomWeighted _weapons),8] call (missionNamespace getVariable 'QS_fnc_addWeapon');
			_unit addPrimaryWeaponItem (selectRandom [
				'optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps',
				'optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f',
				'optic_arco','optic_arco_arid_f','optic_arco_blk_f','optic_arco_ghex_f','optic_arco_lush_f','optic_arco_ak_arid_f','optic_arco_ak_blk_f',
				'optic_arco_ak_lush_f','optic_erco_blk_f','optic_erco_khk_f','optic_erco_snd_f','optic_mrco','optic_hamr','optic_hamr_khk_f'
			]);
			for '_x' from 0 to 1 step 1 do {
				_unit addMagazine QS_core_classNames_miniGrenade;
				_unit addMagazine QS_core_classNames_handGrenade;
			};
		};
	};
	// Randomize Headgear
	if (!(_unitType in _excluded)) then {
		private _headgear = [
			'h_helmetspeco_ocamo',0.1,
			'h_helmethbk_headset_f',0.1,
			'h_helmethbk_chops_f',0.1,
			'h_helmethbk_ear_f',0.1,
			'h_helmethbk_f',0.1,
			'h_helmetaggressor_f',0.1,
			'h_helmetaggressor_cover_f',0.1,
			'h_helmetaggressor_cover_taiga_f',0.1,
			'h_helmetcrew_i',0.1,
			'h_helmetcrew_o',0.1,
			'h_helmetleadero_ocamo',0.1,
			'h_helmetleadero_oucamo',0.1,
			'h_helmetia',0.1,
			'h_helmeto_ocamo',0.1,
			'h_helmeto_oucamo',0.1
		];
		if (worldName in ['Tanoa','Enoch']) then {
			_headgear = [
				'h_helmethbk_headset_f',0.1,
				'h_helmethbk_chops_f',0.1,
				'h_helmethbk_ear_f',0.1,
				'h_helmethbk_f',0.1,
				'h_helmetspeco_ghex_f',0.1,
				'h_helmetaggressor_cover_taiga_f',0.1,
				'h_helmetaggressor_f',0.1,
				'h_helmetaggressor_cover_f',0.1,
				'h_helmetcrew_o_ghex_f',0.1,
				'h_helmetcrew_i',0.1,
				'h_helmetleadero_ghex_f',0.1,
				'h_helmetia',0.1,
				'h_helmeto_ghex_f',0.1
			];
		};
		// Add unconventional hats sometimes
		if ((random 1) > 0.85) then {
			_headgear = _headgear + [
				'h_bandanna_khk',0.1,
				'h_bandanna_cbr',0.1,
				'h_bandanna_camo',0.1,
				'h_watchcap_blk',0.1,
				'h_watchcap_cbr',0.1,
				'h_watchcap_khk',0.1,
				'h_milcap_ghex_f',0.1,
				'h_milcap_ocamo',0.1,
				'h_milcap_wdl',0.1
			];
		};
		_unit addHeadgear (selectRandomWeighted _headgear);
	};
	if (_unitType in [
		'o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f','o_recon_lat_f','o_recon_tl_f',
		'o_t_recon_exp_f','o_t_recon_jtac_f','o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f'
	]) then {
		_unit setUnitTrait ['audibleCoef',0.333];
		_unit setUnitTrait ['camouflageCoef ',0.333];
		_unit addHeadgear 'h_helmetspeco_blk';
	};
	if (_unitType in [
		'o_v_soldier_exp_hex_f',
		'o_v_soldier_jtac_hex_f',
		'o_v_soldier_m_hex_f',
		'o_v_soldier_hex_f',
		'o_v_soldier_medic_hex_f',
		'o_v_soldier_lat_hex_f',
		'o_v_soldier_tl_hex_f',
		'o_v_soldier_exp_ghex_f',
		'o_v_soldier_jtac_ghex_f',
		'o_v_soldier_m_ghex_f',
		'o_v_soldier_ghex_f',
		'o_v_soldier_medic_ghex_f',
		'o_v_soldier_lat_ghex_f',
		'o_v_soldier_tl_ghex_f',
		'o_r_soldier_ar_f',
		'o_r_medic_f',
		'o_r_soldier_exp_f',
		'o_r_soldier_gl_f',
		'o_r_jtac_f',
		'o_r_soldier_m_f',
		'o_r_soldier_lat_f',
		'o_r_soldier_tl_f',
		'o_r_patrol_soldier_a_f',
		'o_r_patrol_soldier_ar2_f',
		'o_r_patrol_soldier_ar_f',
		'o_r_patrol_soldier_medic',
		'o_r_patrol_soldier_engineer_f',
		'o_r_patrol_soldier_gl_f',
		'o_r_patrol_soldier_m2_f',
		'o_r_patrol_soldier_lat_f',
		'o_r_patrol_soldier_m_f',
		'o_r_patrol_soldier_tl_f',
		'o_r_recon_ar_f',
		'o_r_recon_exp_f',
		'o_r_recon_gl_f',
		'o_r_recon_jtac_f',
		'o_r_recon_m_f',
		'o_r_recon_medic_f',
		'o_r_recon_lat_f',
		'o_r_recon_tl_f'
	]) then {
		_unit setUnitTrait ['audibleCoef',0];
		_unit setUnitTrait ['camouflageCoef ',0];
		if (_unitType in [
			'o_r_soldier_ar_f',
			'o_r_patrol_soldier_ar2_f',
			'o_r_patrol_soldier_ar_f',
			'o_r_recon_ar_f'
		]) then {
			_unit setUnitLoadout [['lmg_mk200_black_f','muzzle_snds_65_ti_blk_f','acc_pointer_ir','optic_dms_weathered_f',['200rnd_65x39_cased_box',200],[],'bipod_02_f_lush'],[],['hgun_rook40_f','','','',['16rnd_9x21_mag',16],[],''],['u_o_r_gorka_01_camo_f',[[QS_core_classNames_itemFirstAidKit,1],['16rnd_9x21_mag',2,16]]],['v_smershvest_01_f',[[QS_core_classNames_itemFirstAidKit,2],['handgrenade',2,1],['smokeshell',1,1],['smokeshellred',1,1],['200rnd_65x39_cased_box',2,200]]],['b_fieldpack_taiga_f',[['200rnd_65x39_cased_box',3,200],['minigrenade',2,1],['handgrenade',2,1],['smokeshell',2,1]]],'h_helmetaggressor_cover_taiga_f','g_balaclava_oli',[],[QS_core_classNames_itemMap,'',QS_core_classNames_itemRadio,QS_core_classNames_itemCompass,QS_core_classNames_itemWatch,'o_nvgoggles_grn_f']];
		};
	};
} else {
	if ((side _unit) in [WEST]) then {
		if (_unitType in [
			'b_soldier_ar_f','b_patrol_soldier_ar_f','b_patrol_heavygunner_f','b_patrol_soldier_mg_f','b_t_soldier_ar_f','b_w_soldier_ar_f'
		]) then {
			_weapons = [
				'lmg_03_f',0.3,
				'lmg_mk200_f',0.3,
				'lmg_mk200_black_f',0.3,
				'lmg_zafir_f',0,
				'mmg_01_hex_f',0,
				'mmg_02_black_f',0.1
			];
			if ((backpack _unit) isEqualTo '') then {
				_unit addBackpack 'b_kitbag_rgr';
			};
			_unit removeWeapon (handgunWeapon _unit);
			_unit removeWeapon (primaryWeapon _unit);
			{
				_unit removeMagazine _x;
			} forEach (magazines _unit);
			[_unit,(selectRandomWeighted _weapons),8] call (missionNamespace getVariable 'QS_fnc_addWeapon');
			_unit addPrimaryWeaponItem (selectRandom ['optic_ams','optic_ams_khk','optic_ams_snd','optic_dms','optic_dms_ghex_f','optic_dms_weathered_f','optic_khs_blk','optic_khs_hex','optic_khs_old','optic_khs_tan','optic_lrps','optic_lrps_ghex_f','optic_lrps_tna_f','optic_sos','optic_sos_khk_f']);
		};
	};
};
if (_unitType in [
	'b_g_soldier_unarmed_f',
	'b_soldier_unarmed_f',
	'b_t_soldier_unarmed_f',
	'b_w_soldier_unarmed_f',
	'o_soldier_unarmed_f',
	'o_soldieru_unarmed_f',
	'o_t_soldier_unarmed_f',
	'o_g_soldier_unarmed_f',
	'i_soldier_unarmed_f',
	'i_g_soldier_unarmed_f',
	'i_e_soldier_unarmed_f',
	'i_c_soldier_base_unarmed_f'
]) then {
	removeAllWeapons _unit;
};
// Remove proxies
if ('acc_pointer_IR' in (primaryWeaponItems _unit)) then {
	_unit removePrimaryWeaponItem 'acc_pointer_IR';
} else {
	if ('acc_flashlight' in (primaryWeaponItems _unit)) then {
		_unit removePrimaryWeaponItem 'acc_flashlight';
	};
};
if (dayTime < 16) then {
	if (([0,0,0] getEnvSoundController 'night') isEqualTo 0) then {
		if ((hmd _unit) isNotEqualTo '') then {
			_unit unlinkItem (hmd _unit);
		};
	};
};
if (!(_unitType in [
	'o_soldier_sl_f','o_recon_jtac_f','o_recon_tl_f','o_v_soldier_jtac_hex_f','o_v_soldier_tl_hex_f','o_t_soldier_sl_f','o_t_recon_jtac_f','o_t_recon_tl_f','o_v_soldier_jtac_ghex_f',
	'o_v_soldier_tl_ghex_f','o_r_jtac_f','o_r_soldier_tl_f','o_r_recon_jtac_f','o_r_recon_tl_f','i_soldier_sl_f','o_soldieru_sl_f'
])) then {
	if (
		((binocular _unit) isNotEqualTo '') &&
		(_unit isNotEqualTo (leader (group _unit)))
	) then {
		_unit removeWeapon (binocular _unit);
	};
};
{
	_unit removeMagazines _x;
} forEach ['chemlight_blue','chemlight_green','chemlight_red','chemlight_yellow'];
_unit enableAIFeature ['AUTOCOMBAT',TRUE];
_unit enableFatigue FALSE;
_unit enableStamina FALSE;
_unit selectWeapon (primaryWeapon _unit);
if (!(missionNamespace getVariable ['QS_defendActive',FALSE])) then {
	[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
};
if ((!isDedicated) && hasInterface ) exitWith {_unit};
_unit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
if (!isNull (objectParent _unit)) then {
	_unit enableAIFeature ['RADIOPROTOCOL',FALSE];
};
_unit;