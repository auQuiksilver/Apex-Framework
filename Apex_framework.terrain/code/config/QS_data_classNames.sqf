/*/
File: QS_data_classNames_DLC.sqf
Author:

	Quiksilver
	
Last modified:

	1/12/2022 A3 2.10 by Quiksilver
	
Description:

	DLC Class Names
	
Notes:
	
	WS - Western Sahara
	VN - Prairie Fire
	CSLA - CSLA
	GM - Global Mobilization
	
Other Files with Many Classnames:

	"code\functions\fn_customInventory.sqf"
	"code\functions\fn_downgradeVehicleWeapons.sqf"
	"code\functions\fn_getAIMotorPool.sqf"
	"code\functions\fn_getCustomAttachPoint.sqf"
	"code\functions\fn_moveInCargoMedical.sqf"
	"code\functions\fn_scEnemy.sqf"
	"code\functions\fn_vRandom.sqf"
	"code\functions\fn_vSetup.sqf"
	"code\functions\fn_vSetup2.sqf"
	"code\functions\fn_vTow.sqf"
	
______________________________________________/*/

_active_Mod = missionNamespace getVariable ['QS_system_activeDLC',''];

// Vanilla
qs_core_classnames_itemtoolkit = 'toolkit';
qs_core_classnames_itemtoolkits = ['toolkit'];
qs_core_classnames_itemfirstaidkit = 'firstaidkit';
qs_core_classnames_itemfirstaidkits = ['firstaidkit'];
qs_core_classnames_itemmedikit = 'medikit';
qs_core_classnames_itemmedikits = ['medikit'];
qs_core_classnames_itemcompass = 'itemcompass';
qs_core_classnames_itemcompasses = ['itemcompass'];
qs_core_classnames_itemgps = 'itemgps';
qs_core_classnames_itemgpss = ['itemgps'];
qs_core_classnames_itemterminal = 'b_uavterminal';
qs_core_classnames_itemterminals = ['b_uavterminal','i_uavterminal','c_uavterminal','o_uavterminal','i_e_uavterminal'];
qs_core_classnames_itemwatch = 'itemwatch';
qs_core_classnames_itemwatches = ['itemwatch'];
qs_core_classnames_itemradio = 'itemradio';
qs_core_classnames_itemradios = ['itemradio'];
qs_core_classnames_itemmap = 'itemmap';
qs_core_classnames_itemmaps = ['itemmap'];
qs_core_classnames_itemminedetector = 'minedetector';
qs_core_classnames_itemminedetectors = ['minedetector'];
qs_core_classnames_laserbatteries = ['laserbatteries'];

qs_core_classnames_smokeshells = ['smokeshell','smokeshellblue','smokeshellgreen','smokeshellorange','smokeshellpurple','smokeshellred','smokeshellyellow'];

qs_core_classnames_democharge = 'democharge_remote_mag';
qs_core_classnames_demochargeammo = 'democharge_remote_ammo';
qs_core_classnames_democharges = ['democharge_remote_mag'];
qs_core_classnames_parachute = 'b_parachute';
qs_core_classnames_parachutes = ['b_parachute'];
qs_core_classnames_steerablep = 'steerable_parachute_f';
qs_core_classnames_steerableps = ['steerable_parachute_f'];
qs_core_classnames_vehicleparachute = 'b_parachute_02_f';
qs_core_classnames_vehicleparachutes = ['b_parachute_02_f'];
qs_core_classnames_handgrenade = 'handgrenade';
qs_core_classnames_minigrenade = 'minigrenade';
qs_core_classnames_grenades = ['handgrenade','minigrenade'];
qs_core_classnames_radiobags = ['b_radiobag_01_wdl_f','b_radiobag_01_oucamo_f','b_radiobag_01_tropic_f','b_radiobag_01_mtp_f','b_radiobag_01_hex_f','b_radiobag_01_ghex_f','b_radiobag_01_eaf_f','b_radiobag_01_digi_f','b_radiobag_01_black_f'];
QS_core_classNames_combatGoggles_lower = ['g_combat','g_combat_goggles_tna_f','g_balaclava_combat'];
QS_core_classNames_planeTypesCarrier = ['b_plane_fighter_01_f','b_plane_fighter_01_stealth_f'];
QS_core_classNames_planeTypesCAS_lower = [
	'b_plane_cas_01_f',
	'b_plane_cas_01_dynamicloadout_f',
	'b_plane_cas_01_cluster_f',
	'b_plane_fighter_01_f',
	'b_plane_fighter_01_stealth_f',
	'b_plane_fighter_01_cluster_f',
	'o_plane_cas_02_f',
	'o_plane_cas_02_dynamicloadout_f',
	'o_plane_cas_02_cluster_f',
	'o_plane_fighter_02_f',
	'o_plane_fighter_02_stealth_f',
	'o_plane_fighter_02_cluster_f',
	'i_plane_fighter_03_aa_f',
	'i_plane_fighter_03_cas_f',
	'i_plane_fighter_03_dynamicloadout_f',
	'i_plane_fighter_03_cluster_f',
	'i_plane_fighter_04_f',
	'i_plane_fighter_04_cluster_f',
	'i_c_plane_civil_01_f'
];
QS_core_classNames_planeTypesEnemy_lower = [
	'o_plane_cas_02_dynamicloadout_f',
	'o_plane_fighter_02_f',
	'o_plane_fighter_02_stealth_f',
	'i_plane_fighter_03_aa_f',
	'i_plane_fighter_03_dynamicloadout_f',
	'i_plane_fighter_04_f'
];
QS_core_classNames_heliTypesCAS_lower = [
	'b_heli_light_01_armed_f','b_heli_attack_01_f','o_heli_light_02_f','o_heli_light_02_v2_f','i_heli_light_03_f','o_heli_attack_02_f',
	'o_heli_attack_02_black_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_black_f',
	'i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f','b_heli_attack_01_dynamicloadout_f','b_heli_light_01_dynamicloadout_f'
];

// DLC and Mod alternatives

if (_active_Mod == 'WS') exitWith {
	qs_core_classnames_laserbatteries = ['laserbatteries'];
	// Western Sahara
	QS_core_classNames_planeTypesCAS_lower = [
		'b_plane_cas_01_f',
		'b_plane_cas_01_dynamicloadout_f',
		'b_plane_cas_01_cluster_f',
		'b_plane_fighter_01_f',
		'b_plane_fighter_01_stealth_f',
		'b_plane_fighter_01_cluster_f',
		'o_plane_cas_02_f',
		'o_plane_cas_02_dynamicloadout_f',
		'o_plane_cas_02_cluster_f',
		'o_plane_fighter_02_f',
		'o_plane_fighter_02_stealth_f',
		'o_plane_fighter_02_cluster_f',
		'i_plane_fighter_03_aa_f',
		'i_plane_fighter_03_cas_f',
		'i_plane_fighter_03_dynamicloadout_f',
		'i_plane_fighter_03_cluster_f',
		'i_plane_fighter_04_f',
		'i_plane_fighter_04_cluster_f',
		'i_c_plane_civil_01_f',
		'b_d_plane_cas_01_dynamicloadout_lxws'
	];
	QS_core_classNames_heliTypesCAS_lower = [
		'b_heli_light_01_armed_f','b_heli_attack_01_f','o_heli_light_02_f','o_heli_light_02_v2_f','i_heli_light_03_f','o_heli_attack_02_f',
		'o_heli_attack_02_black_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_black_f',
		'i_heli_light_03_dynamicloadout_f','i_e_heli_light_03_dynamicloadout_f','b_heli_attack_01_dynamicloadout_f','b_heli_light_01_dynamicloadout_f',
		'b_ion_heli_light_02_dynamicloadout_lxws',
		'b_d_heli_light_01_dynamicloadout_lxws',
		'b_d_heli_attack_01_dynamicloadout_lxws',
		'o_sfia_heli_attack_02_dynamicloadout_lxws'
	];
};
if (_active_Mod == 'VN') exitWith {
	// Prairie Fire
	qs_core_classnames_itemtoolkit = 'toolkit';
	qs_core_classnames_itemtoolkits = ['toolkit','vn_b_item_toolkit'];
	qs_core_classnames_itemfirstaidkit = 'firstaidkit';
	qs_core_classnames_itemfirstaidkits = ['firstaidkit','vn_o_item_firstaidkit','vn_b_item_firstaidkit'];
	qs_core_classnames_itemmedikit = 'medikit';
	qs_core_classnames_itemmedikits = ['medikit','vn_b_item_medikit_01'];
	qs_core_classnames_itemcompass = 'itemcompass';
	qs_core_classnames_itemcompasses = ['itemcompass','vn_b_item_compass','vn_b_item_compass_sog'];
	qs_core_classnames_itemgps = 'itemgps';
	qs_core_classnames_itemgpss = ['itemgps'];
	qs_core_classnames_itemterminal = 'b_uavterminal';
	qs_core_classnames_itemterminals = ['b_uavterminal','i_uavterminal','c_uavterminal','o_uavterminal','i_e_uavterminal'];
	qs_core_classnames_itemwatch = 'itemwatch';
	qs_core_classnames_itemwatches = ['itemwatch','vn_b_item_watch'];
	qs_core_classnames_itemradio = 'itemradio';
	qs_core_classnames_itemradios = ['itemradio','vn_o_item_radio_m252','vn_b_item_radio_urc10'];
	qs_core_classnames_itemmap = 'itemmap';
	qs_core_classnames_itemmaps = ['itemmap','vn_o_item_map','vn_b_item_map'];
	qs_core_classnames_itemminedetector = 'minedetector';
	qs_core_classnames_itemminedetectors = ['minedetector','vn_b_item_trapkit'];
	qs_core_classnames_laserbatteries = ['laserbatteries'];

	qs_core_classnames_democharge = 'vn_mine_satchel_remote_02_mag';
	qs_core_classnames_demochargeammo = 'vn_mine_satchel_remote_02_ammo';
	qs_core_classnames_democharges = ['democharge_remote_mag','vn_mine_satchel_remote_02_mag'];
	qs_core_classnames_parachute = 'vn_b_pack_ba22_01';
	qs_core_classnames_parachutes = ['b_parachute','vn_o_pack_parachute_01','vn_i_pack_parachute_01','vn_b_pack_ba18_01','vn_b_pack_ba22_01'];
	qs_core_classnames_steerablep = 'vn_b_parachute_01';
	qs_core_classnames_steerableps = ['steerable_parachute_f','vn_b_parachute_01'];
	qs_core_classnames_handgrenade = 'vn_f1_grenade_mag';
	qs_core_classnames_minigrenade = 'vn_m61_grenade_mag';
	qs_core_classnames_grenades = ['handgrenade','minigrenade','vn_molotov_grenade_mag','vn_chicom_grenade_mag','vn_f1_grenade_mag','vn_m14_grenade_mag','vn_m14_early_grenade_mag','vn_m34_grenade_mag','vn_m61_grenade_mag','vn_m67_grenade_mag','vn_m7_grenade_mag','vn_rg42_grenade_mag','vn_rgd33_grenade_mag','vn_rgd5_grenade_mag','vn_rkg3_grenade_mag','vn_t67_grenade_mag','vn_v40_grenade_mag','vn_satchelcharge_02_throw_mag'];
	qs_core_classnames_radiobags = ['vn_b_pack_lw_06','vn_b_pack_prc77_01','vn_b_pack_trp_04_02','vn_b_pack_03_02','vn_o_pack_t884_01','vn_b_pack_03','vn_b_pack_trp_04'];
	
	QS_core_classNames_planeTypesCarrier = ['vn_b_air_f4b_navy_mr','vn_b_air_f4b_navy_cap'];
	QS_core_classNames_planeTypesCAS_lower = [
		'vn_b_air_f4b_navy_at',
		'vn_b_air_f4b_navy_bmb',
		'vn_b_air_f4b_navy_cap',
		'vn_b_air_f4b_navy_cas',
		'vn_b_air_f4b_navy_cbu',
		'vn_b_air_f4b_navy_ehcas',
		'vn_b_air_f4b_navy_gbu',
		'vn_b_air_f4b_navy_hbmb',
		'vn_b_air_f4b_navy_hcas',
		'vn_b_air_f4b_navy_lbmb',
		'vn_b_air_f4b_navy_lrbmb',
		'vn_b_air_f4b_navy_mbmb',
		'vn_b_air_f4b_navy_mr',
		'vn_b_air_f4b_navy_sead',
		'vn_b_air_f4b_navy_ucas',
		'vn_b_air_f100d_at',
		'vn_b_air_f100d_bmb',
		'vn_b_air_f100d_cap',
		'vn_b_air_f100d_cas',
		'vn_b_air_f100d_cbu',
		'vn_b_air_f100d_ehcas',
		'vn_b_air_f100d_hbmb',
		'vn_b_air_f100d_hcas',
		'vn_b_air_f100d_lbmb',
		'vn_b_air_f100d_mbmb',
		'vn_b_air_f100d_mr',
		'vn_b_air_f100d_sead',
		'vn_b_air_f4c_at',
		'vn_b_air_f4c_bmb',
		'vn_b_air_f4c_cap',
		'vn_b_air_f4c_cas',
		'vn_b_air_f4c_cbu',
		'vn_b_air_f4c_chico',
		'vn_b_air_f4c_ehcas',
		'vn_b_air_f4c_gbu',
		'vn_b_air_f4c_hbmb',
		'vn_b_air_f4c_hcas',
		'vn_b_air_f4c_lbmb',
		'vn_b_air_f4c_lrbmb',
		'vn_b_air_f4c_mbmb',
		'vn_b_air_f4c_mr',
		'vn_b_air_f4c_sead',
		'vn_b_air_f4c_ucas',
		'vn_b_air_f4b_usmc_at',
		'vn_b_air_f4b_usmc_bmb',
		'vn_b_air_f4b_usmc_cap',
		'vn_b_air_f4b_usmc_cas',
		'vn_b_air_f4b_usmc_cbu',
		'vn_b_air_f4b_usmc_ehcas',
		'vn_b_air_f4b_usmc_gbu',
		'vn_b_air_f4b_usmc_hbmb',
		'vn_b_air_f4b_usmc_hcas',
		'vn_b_air_f4b_usmc_lbmb',
		'vn_b_air_f4b_usmc_lrbmb',
		'vn_b_air_f4b_usmc_mbmb',
		'vn_b_air_f4b_usmc_mr',
		'vn_b_air_f4b_usmc_sead',
		'vn_b_air_f4b_usmc_ucas',
		'vn_o_air_mig19_at',
		'vn_o_air_mig19_bmb',
		'vn_o_air_mig19_cap',
		'vn_o_air_mig19_cas',
		'vn_o_air_mig19_gun',
		'vn_o_air_mig19_hbmb',
		'vn_o_air_mig19_mr'
	];
	QS_core_classNames_planeTypesEnemy_lower = [
		'vn_o_air_mig19_bmb',
		'vn_o_air_mig19_cap',
		'vn_o_air_mig19_cas',
		'vn_o_air_mig19_mr'
	];
	QS_core_classNames_heliTypesCAS_lower = [
		'vn_b_air_ah1g_02',
		'vn_b_air_ah1g_03',
		'vn_b_air_ah1g_04',
		'vn_b_air_ah1g_05',
		'vn_b_air_ah1g_01',
		'vn_b_air_ah1g_07',
		'vn_b_air_ah1g_08',
		'vn_b_air_ah1g_09',
		'vn_b_air_ah1g_10',
		'vn_b_air_ah1g_06',
		'vn_b_air_oh6a_06',
		'vn_b_air_oh6a_05',
		'vn_b_air_oh6a_04',
		'vn_b_air_oh6a_07',
		'vn_b_air_uh1b_02_05',
		'vn_b_air_uh1c_01_03',
		'vn_b_air_uh1c_03_01',
		'vn_b_air_ah1g_02_usmc',
		'vn_b_air_ah1g_03_usmc',
		'vn_b_air_ah1g_04_usmc',
		'vn_b_air_ah1g_05_usmc',
		'vn_b_air_ah1g_01_usmc',
		'vn_b_air_ah1g_07_usmc',
		'vn_b_air_ah1g_08_usmc',
		'vn_b_air_ah1g_09_usmc',
		'vn_b_air_ah1g_10_usmc',
		'vn_b_air_ah1g_06_usmc',
		'vn_b_air_uh1e_01_04',
		'vn_b_air_uh1e_02_04',
		'vn_b_air_ch34_04_03',
		'vn_b_air_ch34_04_02',
		'vn_b_air_ch34_04_04',
		'vn_b_air_ch34_04_01',
		'vn_b_air_uh1d_03_06',
		'vn_o_air_mi2_04_05',
		'vn_o_air_mi2_04_06',
		'vn_o_air_mi2_04_01',
		'vn_o_air_mi2_04_02',
		'vn_o_air_mi2_04_03',
		'vn_o_air_mi2_04_04',
		'vn_o_air_mi2_05_05',
		'vn_o_air_mi2_05_06',
		'vn_o_air_mi2_05_01',
		'vn_o_air_mi2_05_02',
		'vn_o_air_mi2_05_03',
		'vn_o_air_mi2_03_05',
		'vn_o_air_mi2_03_06',
		'vn_o_air_mi2_03_03',
		'vn_o_air_mi2_03_04'
	];
};
if (_active_Mod == 'CSLA') exitWith {
	// CSLA
	qs_core_classnames_itemtoolkit = 'toolkit';
	qs_core_classnames_itemtoolkits = ['toolkit','csla_toolkit','us85_toolkit_b','csla_toolkit_komze','us85_toolkit_s'];
	qs_core_classnames_itemfirstaidkit = 'firstaidkit';
	qs_core_classnames_itemfirstaidkits = ['firstaidkit','us85_fak','csla_ob80'];
	qs_core_classnames_itemmedikit = 'medikit';
	qs_core_classnames_itemmedikits = ['medikit','us85_medikit','csla_medikit_z80'];
	qs_core_classnames_itemcompass = 'itemcompass';
	qs_core_classnames_itemcompasses = ['itemcompass'];
	qs_core_classnames_itemgps = 'itemgps';
	qs_core_classnames_itemgpss = ['itemgps'];
	qs_core_classnames_itemterminal = 'b_uavterminal';
	qs_core_classnames_itemterminals = ['b_uavterminal','i_uavterminal','c_uavterminal','o_uavterminal','i_e_uavterminal'];
	qs_core_classnames_itemwatch = 'itemwatch';
	qs_core_classnames_itemwatches = ['itemwatch','us85_watch','csla_prim_enl'];
	qs_core_classnames_itemradio = 'itemradio';
	qs_core_classnames_itemradios = ['itemradio','csla_r123m','csla_r129','csla_rf10','csla_rf12'];
	qs_core_classnames_itemmap = 'itemmap';
	qs_core_classnames_itemmaps = ['itemmap'];
	qs_core_classnames_itemminedetector = 'minedetector';
	qs_core_classnames_itemminedetectors = ['minedetector','csla_w3p_detector','us85_anprs8_detector'];
	qs_core_classnames_laserbatteries = ['laserbatteries'];
	qs_core_classnames_democharge = 'us85_satchelcharge_mag';
	qs_core_classnames_demochargeammo = 'US85_SatchelCharge_Ammo';
	qs_core_classnames_democharges = ['us85_satchelcharge_mag','csla_ivz'];
	qs_core_classnames_parachute = 'b_parachute';
	qs_core_classnames_parachutes = ['b_parachute'];
	qs_core_classnames_steerablep = 'steerable_parachute_f';
	qs_core_classnames_steerableps = ['steerable_parachute_f'];
	qs_core_classnames_handgrenade = 'us85_m67';
	qs_core_classnames_minigrenade = 'csla_f1';
	qs_core_classnames_grenades = ['csla_f1','us85_m67','csla_rg4o','csla_rg4u','csla_urg86u','csla_urg86o'];
	qs_core_classnames_radiobags = ['csla_bp85rf10','us85_bpprc77','csla_bpwpr129','csla_bpwprf10'];
	QS_core_classNames_heliTypesCAS_lower = [
		'afmc_ah1f',
		'us85_ah1f',
		'us85_mh60ffar',
		'csla_mi17pylons',
		'csla_mi24v'
	];	
};
if (_active_Mod == 'GM') exitWith {
	// Global Mobilization
	qs_core_classnames_itemtoolkit = 'gm_repairkit_01';
	qs_core_classnames_itemtoolkits = ['gm_repairkit_01'];
	qs_core_classnames_itemfirstaidkit = 'gm_gc_army_gauzebandage';
	qs_core_classnames_itemfirstaidkits = ['gm_ge_army_gauzebandage','gm_ge_army_burnbandage','gm_gc_army_gauzebandage','gm_ge_army_gauzecompress'];
	qs_core_classnames_itemmedikit = 'gm_gc_army_medbox';
	qs_core_classnames_itemmedikits = ['gm_ge_army_medkit_80','gm_gc_army_medkit','gm_gc_army_medbox'];
	qs_core_classnames_itemcompass = 'gm_gc_compass_f73';
	qs_core_classnames_itemcompasses = ['gm_ge_army_conat2','gm_gc_compass_f73'];
	qs_core_classnames_itemgps = 'itemgps';
	qs_core_classnames_itemgpss = ['itemgps'];
	qs_core_classnames_itemterminal = 'b_uavterminal';
	qs_core_classnames_itemterminals = ['b_uavterminal','i_uavterminal','c_uavterminal','o_uavterminal','i_e_uavterminal'];
	qs_core_classnames_itemwatch = 'itemwatch';
	qs_core_classnames_itemwatches = ['itemwatch'];
	qs_core_classnames_itemradio = 'itemradio';
	qs_core_classnames_itemradios = ['itemradio'];
	qs_core_classnames_itemmap = 'itemmap';
	qs_core_classnames_itemmaps = ['itemmap'];
	qs_core_classnames_democharge = 'gm_explosive_petn_charge';
	qs_core_classnames_democharges = ['gm_explosive_petn_charge','gm_explosive_plnp_charge'];
	qs_core_classnames_parachute = 'gm_backpack_t10_parachute';
	qs_core_classnames_parachutes = ['gm_backpack_t10_parachute','gm_backpack_rs9_parachute'];
	qs_core_classnames_steerablep = 'gm_parachute_t10';
	qs_core_classnames_steerableps = ['steerable_parachute_f','gm_parachute_t10','gm_parachute_rs9'];
	qs_core_classnames_handgrenade = 'handgrenade';
	qs_core_classnames_minigrenade = 'minigrenade';
	qs_core_classnames_grenades = ['gm_handgrenade_conc_dm51','gm_handgrenade_conc_dm51a1','gm_handgrenade_frag_dm51','gm_handgrenade_frag_dm51a1','gm_handgrenade_frag_rgd5'];
	qs_core_classnames_radiobags = ['gm_gc_backpack_r105m_brn','gm_ge_backpack_sem35_oli'];
	qs_core_classnames_combatgoggles_lower = [];
	QS_core_classNames_heliTypesCAS_lower = [
		'gm_ge_army_bo105p_pah1',
		'gm_ge_army_bo105p_pah1a1',
		'gm_gc_airforce_mi2urn',
		'gm_gc_airforce_mi2us',
		'gm_pl_airforce_mi2urn',
		'gm_pl_airforce_mi2urp',
		'gm_pl_airforce_mi2urpg',
		'gm_pl_airforce_mi2urs',
		'gm_pl_airforce_mi2us'
	];
	qs_core_classnames_laserbatteries = ['laserbatteries'];
};