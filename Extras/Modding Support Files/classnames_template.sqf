// Vanilla classname lists, for Mod/DLC support
// v1.0
// These classnames are used by the framework in various systems
// They can be adjusted to support modded/DLC variants
// Relevant file:
// 		"code\config\QS_data_classNames.sqf"

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
QS_core_classNames_zeusDisabledModules_lower = [
	'modulepostprocess_f','moduleskiptime_f','moduletimemultiplier_f','moduleweather_f',
	'modulebootcampstage_f','modulehint_f','modulediary_f','modulecountdown_f','moduleendmission_f',
	'modulerespawntickets_f','modulemissionname_f','modulerespawninventory_f','modulerespawnpositionwest_f',
	'modulerespawnpositionciv_f','modulerespawnpositionguer_f','modulerespawnpositioneast_f','modulevehiclerespawnpositionwest_f',
	'modulevehiclerespawnpositionciv_f','modulevehiclerespawnpositionguer_f','modulevehiclerespawnpositioneast_f',
	'moduleobjectiveattackdefend_f','moduleobjectivesector_f','moduleobjectiveracecp_f','moduleobjectiveracefinish_f',
	'moduleobjectiveracestart_f','moduleanimalsbutterflies_f'
];
QS_core_classNames_zeusDisabledAddons_lower = [
	'a3_modules_f_curator_respawn',
	'a3_modules_f_curator_multiplayer',
	'a3_modules_f_kart',
	'a3_modules_f_mark_firingdrills',
	'a3_modules_f_curator_intel',
	'a3_modules_f_curator_environment',
	'a3_modules_f_curator_effects',
	'a3_characters_f_bootcamp',
	'a3_structures_f_bootcamp_vr_blocks',
	'a3_structures_f_bootcamp_vr_coverobjects',
	'a3_structures_f_bootcamp_vr_helpers',
	'a3_structures_f_exp_a_vr_blocks',
	'a3_structures_f_exp_a_vr_helpers',
	'a3_structures_f_mark_vr_helpers',
	'a3_structures_f_mark_vr_shapes',
	'a3_structures_f_mark_vr_targets',
	'a3_structures_f_heli_vr_helpers',
	'a3_modules_f_curator_lightning',
	'a3_data_f_curator_respawn',
	'curatoronly_modules_f_curator_environment',
	'curatoronly_modules_f_curator_lightning'
];