/*/
File: fn_baseBackpack.sqf
Author:

	Quiksilver (Alias of BIS_fnc_basicBackpack by Jiri Wainar)
	
Last Modified:

	15/04/2018 A3 1.82 by Quiksilver
	
Description:

	Return class of given backpack without a bakened-in equipment (an empty backpack).
	
Example:

	"b_assaultpack_rgr" = "b_assaultpack_rgr_medic" call BIS_fnc_basicBackpack;
	
Notes:

	'(isclass _x && ((getnumber (_x >> "isBackpack")) isEqualTo 1))' configClasses (configfile >> 'cfgvehicles');
	
_fn_debug = {
	private _class = '';
	{
		_class = toLower(_x call (missionNamespace getVariable 'QS_fnc_baseBackpack'));
		if (!(_class isEqualTo _x)) then {
			['[ ] %2 <- %1',_x,_class] call BIS_fnc_logFormat;
		};
	} forEach [
		'bag_base','b_assaultpack_base','b_assaultpack_khk','b_assaultpack_dgtl','b_assaultpack_rgr','b_assaultpack_sgg','b_assaultpack_blk','b_assaultpack_cbr','b_assaultpack_mcamo',
		'b_assaultpack_ocamo','b_kitbag_base','b_kitbag_rgr','b_kitbag_mcamo','b_kitbag_sgg','b_kitbag_cbr','b_tacticalpack_base','b_tacticalpack_rgr','b_tacticalpack_mcamo','b_tacticalpack_ocamo',
		'b_tacticalpack_blk','b_tacticalpack_oli','b_fieldpack_base','b_fieldpack_khk','b_fieldpack_ocamo','b_fieldpack_oucamo','b_fieldpack_cbr','b_fieldpack_blk','b_carryall_base','b_carryall_ocamo',
		'b_carryall_oucamo','b_carryall_mcamo','b_carryall_khk','b_carryall_cbr','b_bergen_base','b_bergen_sgg','b_bergen_mcamo','b_bergen_rgr','b_bergen_blk','b_outdoorpack_base','b_outdoorpack_blk',
		'b_outdoorpack_tan','b_outdoorpack_blu','b_huntingbackpack','b_assaultpackg','b_bergeng','b_bergenc_base','b_bergenc_red','b_bergenc_grn','b_bergenc_blu','b_parachute','b_fieldpack_oli','b_carryall_oli',
		'g_assaultpack','g_bergen','c_bergen_base','c_bergen_red','c_bergen_grn','c_bergen_blu','b_assaultpack_kerry','b_assaultpack_rgr_lat','b_assaultpack_rgr_medic','b_assaultpack_rgr_repair','b_assault_diver',
		'b_assaultpack_blk_diverexp','b_kitbag_rgr_exp','b_assaultpack_mcamo_at','b_assaultpack_rgr_reconmedic','b_assaultpack_rgr_reconexp','b_assaultpack_rgr_reconlat','b_assaultpack_mcamo_aa','b_assaultpack_mcamo_aar',
		'b_assaultpack_mcamo_ammo','b_kitbag_mcamo_eng','b_carryall_mcamo_aaa','b_carryall_mcamo_aat','b_kitbag_rgr_aar','b_fieldpack_blk_diverexp','o_assault_diver','b_fieldpack_ocamo_medic','b_fieldpack_cbr_lat',
		'b_fieldpack_cbr_repair','b_carryall_ocamo_exp','b_fieldpack_ocamo_aa','b_fieldpack_ocamo_aar','b_fieldpack_ocamo_reconmedic','b_fieldpack_cbr_at','b_fieldpack_cbr_aat','b_fieldpack_cbr_aa','b_fieldpack_cbr_aaa',
		'b_fieldpack_cbr_medic','b_fieldpack_ocamo_reconexp','b_fieldpack_cbr_ammo','b_fieldpack_cbr_rpg_at','b_carryall_ocamo_aaa','b_carryall_ocamo_eng','b_carryall_cbr_aat','b_fieldpack_oucamo_at',
		'b_fieldpack_oucamo_lat','b_carryall_oucamo_aat','b_fieldpack_oucamo_aa','b_carryall_oucamo_aaa','b_fieldpack_oucamo_aar','b_fieldpack_oucamo_medic','b_fieldpack_oucamo_ammo','b_fieldpack_oucamo_repair',
		'b_carryall_oucamo_exp','b_carryall_oucamo_eng','b_carryall_ocamo_aar','b_carryall_oucamo_aar','i_fieldpack_oli_aa','i_assault_diver','i_fieldpack_oli_ammo','i_fieldpack_oli_medic','i_fieldpack_oli_repair',
		'i_fieldpack_oli_lat','i_fieldpack_oli_at','i_fieldpack_oli_aar','i_carryall_oli_aat','i_carryall_oli_exp','i_carryall_oli_aaa','i_carryall_oli_eng','g_tacticalpack_eng','g_fieldpack_medic','g_fieldpack_lat',
		'g_carryall_ammo','g_carryall_exp','b_tacticalpack_oli_aar','b_bergeng_test_b_soldier_overloaded','weapon_bag_base','b_hmg_01_support_f','o_hmg_01_support_f','i_hmg_01_support_f','b_hmg_01_support_high_f',
		'o_hmg_01_support_high_f','i_hmg_01_support_high_f','b_hmg_01_weapon_f','o_hmg_01_weapon_f','i_hmg_01_weapon_f','b_hmg_01_a_weapon_f','o_hmg_01_a_weapon_f','i_hmg_01_a_weapon_f','b_gmg_01_weapon_f',
		'o_gmg_01_weapon_f','i_gmg_01_weapon_f','b_gmg_01_a_weapon_f','o_gmg_01_a_weapon_f','i_gmg_01_a_weapon_f','b_hmg_01_high_weapon_f','o_hmg_01_high_weapon_f','i_hmg_01_high_weapon_f','b_gmg_01_high_weapon_f',
		'o_gmg_01_high_weapon_f','i_gmg_01_high_weapon_f','b_mortar_01_support_f','o_mortar_01_support_f','i_mortar_01_support_f','b_mortar_01_weapon_f','o_mortar_01_weapon_f','i_mortar_01_weapon_f',
		'b_b_parachute_02_f','b_o_parachute_02_f','b_i_parachute_02_f','b_aa_01_weapon_f','o_aa_01_weapon_f','i_aa_01_weapon_f','b_at_01_weapon_f','o_at_01_weapon_f','i_at_01_weapon_f','b_uav_01_backpack_f',
		'o_uav_01_backpack_f','i_uav_01_backpack_f','b_respawn_tentdome_f','b_respawn_tenta_f','b_respawn_sleeping_bag_f','b_respawn_sleeping_bag_blue_f','b_respawn_sleeping_bag_brown_f','b_static_designator_01_weapon_f',
		'o_static_designator_02_weapon_f','b_bergen_base_f','b_bergen_mcamo_f','b_bergen_dgtl_f','b_bergen_hex_f','b_bergen_tna_f','b_assaultpack_tna_f','b_carryall_ghex_f','b_fieldpack_ghex_f','b_viperharness_base_f',
		'b_viperharness_blk_f','b_viperharness_ghex_f','b_viperharness_hex_f','b_viperharness_khk_f','b_viperharness_oli_f','b_viperlightharness_base_f','b_viperlightharness_blk_f','b_viperlightharness_ghex_f',
		'b_viperlightharness_hex_f','b_viperlightharness_khk_f','b_viperlightharness_oli_f','b_carryall_oli_btammo_f','b_carryall_oli_btaaa_f','b_carryall_oli_btaat_f','b_assaultpack_tna_btmedic_f',
		'b_kitbag_rgr_bteng_f','b_kitbag_rgr_btexp_f','b_kitbag_rgr_btaa_f','b_kitbag_rgr_btat_f','b_assaultpack_tna_btrepair_f','b_assaultpack_rgr_btlat_f','b_kitbag_rgr_btreconexp_f','b_assaultpack_rgr_btreconmedic',
		'b_hmg_01_support_grn_f','b_mortar_01_support_grn_f','b_gmg_01_weapon_grn_f','b_hmg_01_weapon_grn_f','b_mortar_01_weapon_grn_f','b_kitbag_rgr_ctrgexp_f','b_assaultpack_rgr_ctrgmedic_f',
		'b_assaultpack_rgr_ctrglat_f','b_carryall_ghex_otammo_f','b_carryall_ghex_otaar_aar_f','b_carryall_ghex_otaaa_f','b_carryall_ghex_otaat_f','b_fieldpack_ghex_otmedic_f','b_carryall_ghex_oteng_f',
		'b_carryall_ghex_otexp_f','b_fieldpack_ghex_otaa_f','b_fieldpack_ghex_otat_f','b_fieldpack_ghex_otrepair_f','b_fieldpack_ghex_otlat_f','b_carryall_ghex_otreconexp_f','b_fieldpack_ghex_otreconmedic_f',
		'b_fieldpack_ghex_otrpg_at_f','b_viperharness_hex_tl_f','b_viperharness_ghex_tl_f','b_viperharness_hex_exp_f','b_viperharness_ghex_exp_f','b_viperharness_hex_medic_f','b_viperharness_ghex_medic_f',
		'b_viperharness_hex_m_f','b_viperharness_ghex_m_f','b_viperharness_hex_lat_f','b_viperharness_ghex_lat_f','b_viperharness_hex_jtac_f','b_viperharness_ghex_jtac_f','b_kitbag_rgr_para_3_f','b_kitbag_cbr_para_5_f',
		'b_kitbag_rgr_para_8_f','b_fieldpack_cb_bandit_3_f','b_kitbag_cbr_bandit_2_f','b_fieldpack_khk_bandit_1_f','b_fieldpack_blk_bandit_8_f','b_patrol_medic_bag_f','b_patrol_leader_bag_f','b_patrol_supply_bag_f',
		'b_patrol_launcher_bag_f','b_patrol_respawn_bag_f','b_messenger_base_f','b_messenger_coyote_f','b_messenger_olive_f','b_messenger_black_f','b_messenger_gray_f','b_messenger_gray_medical_f','b_messenger_idap_f',
		'b_messenger_idap_medical_f','b_messenger_idap_trainingmines_f','c_idap_uav_01_backpack_f','uav_06_backpack_base_f','uav_06_medical_backpack_base_f','b_uav_06_backpack_f','o_uav_06_backpack_f','i_uav_06_backpack_f',
		'c_idap_uav_06_backpack_f','c_uav_06_backpack_f','c_idap_uav_06_antimine_backpack_f','b_uav_06_medical_backpack_f','o_uav_06_medical_backpack_f','i_uav_06_medical_backpack_f','c_idap_uav_06_medical_backpack_f',
		'c_uav_06_medical_backpack_f','b_legstrapbag_base_f','b_legstrapbag_black_f','b_legstrapbag_coyote_f','b_legstrapbag_olive_f','b_legstrapbag_black_repair_f','b_legstrapbag_coyote_repair_f',
		'b_legstrapbag_olive_repair_f','b_carryall_oucamo_repair','b_kitbag_rgr_mine','b_carryall_khk_mine','b_carryall_oli_mine','b_carryall_ocamo_mine','b_carryall_ghex_mine','b_fieldpack_cbr_ammo_f',
		'b_assaultpack_ocamo_medic_f','b_fieldpack_ocamo_lat_f','b_tacticalpack_ocamo_aa_f','b_tacticalpack_ocamo_at_f','b_assaultpack_rgr_lat2','b_assaultpack_rgr_btlat2_f','b_assaultpack_rgr_ctrglat2_f',
		'g_fieldpack_lat2','i_fieldpack_oli_lat2','b_fieldpack_cbr_hat','b_fieldpack_ghex_othat_f','b_carryall_cbr_ahat','b_carryall_ghex_otahat_f'
	];
};

________________________________________________/*/

params [
	['_input','',['']]
];
private _output = '';
if (_input isEqualTo '') exitWith {/*/call _fn_debug;/*/''};
_fn_hasCargo = {
	private _hasCargo = FALSE;
	private _cargo = [];
	{
		_cargo = _x call (missionNamespace getVariable 'BIS_fnc_getCfgSubClasses');
		if (_cargo isNotEqualTo []) exitWith {
			_hasCargo = TRUE;
		};
	} forEach [
		(configfile >> 'CfgVehicles' >> _this >> 'TransportItems'),
		(configfile >> 'CfgVehicles' >> _this >> 'TransportMagazines'),
		(configfile >> 'CfgVehicles' >> _this >> 'TransportWeapons')
	];
	_hasCargo;
};
if (!(_input call _fn_hasCargo)) exitWith {_input};
_parents = [configfile >> 'CfgVehicles' >> _input,TRUE] call (missionNamespace getVariable 'BIS_fnc_returnParents');
private _hasCargo = FALSE;
private _scope = -1;
{
	_hasCargo = _x call _fn_hasCargo;
	_scope = getNumber (configfile >> 'CfgVehicles' >> _x >> 'scope');
	if ((!(_hasCargo)) && (_scope isEqualTo 2)) exitWith {
		_output = _x;
	};
} forEach _parents;
_output;