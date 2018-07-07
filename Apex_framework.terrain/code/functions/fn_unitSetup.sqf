/*/
File: fn_unitSetup.sqf
Author: 

	Quiksilver

Last Modified:

	18/02/2017 A3 1.80 by Quiksilver
	
Description:

	Setup unit
______________________________________________________/*/

_unit = _this;
_unitType = toLower (typeOf _unit);
if ((side _unit) in [EAST,RESISTANCE]) then {
	private _weapons = [];
	if (_unitType in ['o_t_soldier_ar_f','o_soldier_ar_f','o_g_soldier_ar_f','i_g_soldier_ar_f','i_c_soldier_bandit_3_f','i_c_soldier_para_4_f','i_soldier_ar_f']) then {
		if ((random 1) > 0.333) then {
			if ((backpack _unit) isEqualTo '') then {
				_unit addBackpack (['b_fieldpack_ocamo','b_fieldpack_ghex_f'] select (worldName isEqualTo 'Tanoa'));
			};
			_weapons = [
				'LMG_03_F',
				'LMG_Mk200_F'
			];
			if (!(worldName isEqualTo 'Tanoa')) then {
				_weapons pushBack 'LMG_Zafir_F';
				if ((random 1) > 0.75) then {
					_weapons pushBack 'MMG_01_hex_F';
				};
			};
			{
				_unit removeMagazine _x;
			} forEach (magazines _unit);
			[_unit,(selectRandom _weapons),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
			if (!((handgunWeapon _unit) isEqualTo '')) then {
				[_unit,(handgunWeapon _unit),3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
			};
			_unit selectWeapon (primaryWeapon _unit);
		};
	} else {
		if (!(_unitType in [
			"o_v_soldier_exp_hex_f","o_v_soldier_jtac_hex_f","o_v_soldier_m_hex_f","o_v_soldier_hex_f","o_v_soldier_medic_hex_f","o_v_soldier_lat_hex_f",
			"o_v_soldier_tl_hex_f","o_v_soldier_exp_ghex_f","o_v_soldier_jtac_ghex_f","o_v_soldier_m_ghex_f","o_v_soldier_ghex_f","o_v_soldier_medic_ghex_f",
			"o_v_soldier_lat_ghex_f","o_v_soldier_tl_ghex_f","o_recon_exp_f","o_recon_jtac_f","o_recon_m_f","o_recon_medic_f","o_pathfinder_f","o_recon_f",
			"o_recon_lat_f","o_recon_tl_f","o_sniper_f","o_ghillie_ard_f","o_ghillie_lsh_f","o_ghillie_sard_f","o_spotter_f","o_t_recon_exp_f","o_t_recon_jtac_f",
			"o_t_recon_m_f","o_t_recon_medic_f","o_t_recon_f","o_t_recon_lat_f","o_t_recon_tl_f","o_t_sniper_f","o_t_ghillie_tna_f","o_t_spotter_f",
			"o_diver_f","o_diver_exp_f","o_diver_tl_f","o_t_diver_f","o_t_diver_exp_f","o_t_diver_tl_f",'i_spotter_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f'
		])) then {
			if ((random 1) > 0.666) then {
				if (['_GL_',_unitType,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
					_weapons = [
						"arifle_TRG21_GL_F",
						"arifle_Mk20_GL_F"
					];
					{
						_unit removeMagazine _x;
					} forEach (magazines _unit);
					[_unit,(selectRandom _weapons),8] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS','optic_Arco_blk_F','optic_Hamr','optic_ERCO_blk_F','optic_Arco']);
					if (!((handgunWeapon _unit) isEqualTo '')) then {
						[_unit,(handgunWeapon _unit),3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					};
					_unit selectWeapon (primaryWeapon _unit);
				} else {
					_weapons = [
						"arifle_TRG20_F",
						"arifle_TRG21_F",
						"arifle_Mk20C_F",
						"arifle_Mk20_F"
					];
					if (_unitType in ['o_soldier_m_f','o_t_soldier_m_f','o_g_soldier_m_f','i_soldier_m_f','i_g_soldier_m_f']) then {
						_weapons = [
							'srifle_DMR_07_blk_F',
							'srifle_DMR_05_blk_F',
							'srifle_DMR_02_F',
							'srifle_DMR_06_camo_F',
							'srifle_DMR_01_F',
							'srifle_DMR_06_olive_F'
						];
					};
					{
						_unit removeMagazine _x;
					} forEach (magazines _unit);
					[_unit,(selectRandom _weapons),8] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					if (!((handgunWeapon _unit) isEqualTo '')) then {
						[_unit,(handgunWeapon _unit),3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					};
					_unit selectWeapon (primaryWeapon _unit);
					if (_unitType in ['o_soldier_m_f','o_t_soldier_m_f','o_g_soldier_m_f','i_soldier_m_f','i_g_soldier_m_f']) then {
						_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS']);
					} else {
						if ((random 1) > 0.333) then {
							_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS','optic_Arco_blk_F','optic_Hamr','optic_ERCO_blk_F']);
						} else {
							if ((toLower (primaryWeapon _unit)) in ['arifle_trg20_f','arifle_trg21_f','arifle_mk20c_f','arifle_mk20_f']) then {
								_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS','optic_Arco_blk_F','optic_Hamr','optic_ERCO_blk_F','optic_Arco']);
							};
						};
					};
				};
			};
		} else {
			if (['spotter',_unitType,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
				_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS','optic_Arco_blk_F','optic_Hamr','optic_ERCO_blk_F']);
				_unit addPrimaryWeaponItem 'muzzle_snds_H';
			};
		};
	};
};
if ('acc_pointer_IR' in (primaryWeaponItems _unit)) then {
	_unit removePrimaryWeaponItem 'acc_pointer_IR';
} else {
	if ('acc_flashlight' in (primaryWeaponItems _unit)) then {
		_unit removePrimaryWeaponItem 'acc_flashlight';
	};
};
if (dayTime < 16) then {
	if (sunOrMoon isEqualTo 1) then {
		if (!((hmd _unit) isEqualTo '')) then {
			_unit unlinkItem (hmd _unit);
		};
	};
};
if ((random 1) > 0.5) then {
	if (!(_unitType in [
		'o_v_soldier_exp_hex_f','o_v_soldier_jtac_hex_f','o_v_soldier_m_hex_f','o_v_soldier_hex_f','o_v_soldier_medic_hex_f','o_v_soldier_lat_hex_f',
		'o_v_soldier_tl_hex_f','o_v_soldier_exp_ghex_f','o_v_soldier_jtac_ghex_f','o_v_soldier_m_ghex_f','o_v_soldier_ghex_f','o_v_soldier_medic_ghex_f',
		'o_v_soldier_lat_ghex_f','o_v_soldier_tl_ghex_f','o_recon_exp_f','o_recon_jtac_f','o_recon_m_f','o_recon_medic_f','o_pathfinder_f','o_recon_f',
		'o_recon_lat_f','o_recon_tl_f','o_sniper_f','o_ghillie_ard_f','o_ghillie_lsh_f','o_ghillie_sard_f','o_spotter_f','o_t_recon_exp_f','o_t_recon_jtac_f',
		'o_t_recon_m_f','o_t_recon_medic_f','o_t_recon_f','o_t_recon_lat_f','o_t_recon_tl_f','o_t_sniper_f','o_t_ghillie_tna_f','o_t_spotter_f',
		'o_diver_f','o_diver_exp_f','o_diver_tl_f','o_t_diver_f','o_t_diver_exp_f','o_t_diver_tl_f','i_spotter_f','i_sniper_f','i_ghillie_ard_f','i_ghillie_lsh_f','i_ghillie_sard_f'
	])) then {
		_unit addHeadgear (selectRandom [
			'H_Bandanna_gry','H_Bandanna_cbr','H_Bandanna_khk','H_Bandanna_sand','H_Bandanna_surfer','H_Bandanna_surfer_blk','H_Bandanna_surfer_grn','H_Booniehat_khk','H_Booniehat_dgtl','H_Cap_blk','H_Cap_grn','H_Cap_red',
			'H_Cap_blk_Raven','H_Cap_brn_SPECOPS','H_HelmetCrew_O_ghex_F','H_Hat_camo','H_CrewHelmetHeli_I','H_CrewHelmetHeli_O','H_HelmetB_Light_tna_F','H_MilCap_ghex_F','H_MilCap_gry','H_MilCap_tna_F','H_MilCap_dgtl','H_Shemag_olive',
			'H_ShemagOpen_tan','H_ShemagOpen_khk','H_Helmet_Skate','H_PASGT_basic_black_F','H_PASGT_basic_blue_F','H_PASGT_basic_olive_F','H_PASGT_basic_white_F'
		]);
	};
};
if ((random 1) > 0.333) then {
	if (!(((primaryWeaponItems _unit) findIf {((toLower _x) in ['optic_aco','optic_aco_grn'])}) isEqualTo -1)) then {
		_unit addPrimaryWeaponItem 'optic_Arco';
	};
};
if ((random 1) > 0.25) then {
	if (_unit hasWeapon 'Binocular') then {
		_unit removeWeapon 'Binocular';
	};
};
if ((random 1) > 0.75) then {
	_unit removeWeapon (handgunWeapon _unit);
};
if ((['recon',_unitType,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(_unitType in [
	"o_v_soldier_exp_hex_f","o_v_soldier_jtac_hex_f","o_v_soldier_m_hex_f","o_v_soldier_hex_f","o_v_soldier_medic_hex_f","o_v_soldier_lat_hex_f",
	"o_v_soldier_tl_hex_f","o_v_soldier_exp_ghex_f","o_v_soldier_jtac_ghex_f","o_v_soldier_m_ghex_f","o_v_soldier_ghex_f","o_v_soldier_medic_ghex_f",
	"o_v_soldier_lat_ghex_f","o_v_soldier_tl_ghex_f"
])}) then {
	if ((random 1) > 0.5) then {
		_unit addPrimaryWeaponItem (selectRandom ['optic_Nightstalker','optic_tws']);
	};
	if (!(_unitType in [
		"o_v_soldier_exp_hex_f","o_v_soldier_jtac_hex_f","o_v_soldier_m_hex_f","o_v_soldier_hex_f","o_v_soldier_medic_hex_f","o_v_soldier_lat_hex_f",
		"o_v_soldier_tl_hex_f","o_v_soldier_exp_ghex_f","o_v_soldier_jtac_ghex_f","o_v_soldier_m_ghex_f","o_v_soldier_ghex_f","o_v_soldier_medic_ghex_f",
		"o_v_soldier_lat_ghex_f","o_v_soldier_tl_ghex_f"
	])) then {
		if ((side _unit) isEqualTo EAST) then {
			_unit addHeadgear 'H_HelmetSpecO_blk';
		};
	};
};
if (_unitType in [
	"i_c_soldier_para_4_f","i_c_soldier_bandit_3_f","i_g_soldier_ar_f","i_soldier_ar_f","b_ctrg_soldier_ar_tna_f","b_g_soldier_ar_f",
	"b_soldier_ar_f","b_heavygunner_f","b_t_soldier_ar_f","o_soldier_ar_f","o_heavygunner_f","o_soldieru_ar_f","o_urban_heavygunner_f",
	"o_t_soldier_ar_f","o_g_soldier_ar_f"
]) then {
	if ((random 1) > 0.5) then {
		_unit addPrimaryWeaponItem (selectRandom ['optic_Hamr','optic_MRCO','optic_DMS','optic_Holosight']);
	} else {
		_unit addPrimaryWeaponItem (selectRandom ['optic_AMS','optic_DMS','optic_KHS_blk','optic_LRPS','optic_SOS','optic_Arco_blk_F','optic_Hamr','optic_ERCO_blk_F']);
	};
};
private _toRemove = [];
private _container = [];
{
	if (!isNil '_x') then {
		_container = _x;
		if (!isNil '_container') then {
			if (!(_container isEqualTo [])) then {
				{
					if ((toLower _x) in [
						'chemlight_blue','chemlight_green','chemlight_red','chemlight_yellow'
					]) then {
						_toRemove pushBack _x;
					};
				} forEach _container;
			};
		};
	};
} forEach [
	(uniformItems _unit),
	(vestItems _unit),
	(backpackItems _unit),
	(items _unit)
];
if (!(_toRemove isEqualTo [])) then {
	{
		
		_unit removeItem _x;
	} forEach _toRemove;
};
_unit enableFatigue FALSE;
_unit enableStamina FALSE;
[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
if (missionNamespace getVariable ['QS_HC_Active',FALSE]) then {
	_unit setVariable ['QS_AI_UNIT_enabled',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
} else {
	_unit setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
};
if (!((vehicle _unit) isKindOf 'Man')) then {
	_unit setSpeaker 'NoVoice';
};
_unit;