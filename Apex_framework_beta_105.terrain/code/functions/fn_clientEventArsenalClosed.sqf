/*
File: fn_clientEventArsenalClosed.sqf
Author: 

	Quiksilver

Last Modified:

	12/08/2016 A3 1.62 by Quiksilver

Description:

	Event Arsenal Closed
____________________________________________________________________________*/

_QS_playerClass = typeOf player;
_QS_loadout = getUnitLoadout player;
missionNamespace setVariable ['QS_revive_arsenalInventory',_QS_loadout,FALSE];
private _QS_savedLoadouts = profileNamespace getVariable 'QS_saved_loadouts';
_QS_loadoutIndex = [_QS_savedLoadouts,_QS_playerClass,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
_a = [_QS_playerClass,_QS_loadout];
if (_QS_loadoutIndex isEqualTo -1) then {
	_QS_savedLoadouts pushBack _a;
} else {
	_QS_savedLoadouts set [_QS_loadoutIndex,_a];
};
profileNamespace setVariable ['QS_saved_loadouts',_QS_savedLoadouts];
saveProfileNamespace;
if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	0 spawn {
		uiSleep 0.1;
		if (!((player getVariable 'QS_ClientUTexture2') isEqualTo '')) then {
			if (!((player getVariable 'QS_ClientUTexture2_Uniforms2') isEqualTo [])) then {
				if ((uniform player) in (player getVariable 'QS_ClientUTexture2_Uniforms2')) then {
					player setObjectTextureGlobal [0,(player getVariable 'QS_ClientUTexture2')];
					if (!((vest player) isEqualTo '')) then {
					
					};
					if (!((backpack player) isEqualTo '')) then {
					
					};
				};
			};
		};
		if (!((player getVariable 'QS_ClientUnitInsignia2') isEqualTo '')) then {
			[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
		};
	};
};
/*/===== Correct overfilled containers/*/

_defaultUniform = ['U_B_CombatUniform_mcam','U_B_T_Soldier_F'] select (worldName isEqualTo 'Tanoa');
_backpackWhitelisted = ["","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_ocamo","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_sgg","B_AssaultPack_tna_F","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F","B_Carryall_cbr","B_Carryall_ghex_F","B_Carryall_ocamo","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_HMG_01_high_weapon_F","B_HMG_01_weapon_F","B_GMG_01_high_weapon_F","B_GMG_01_weapon_F","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ghex_F","B_FieldPack_ocamo","B_FieldPack_khk","B_FieldPack_oli","B_FieldPack_oucamo","B_Mortar_01_support_F","B_Mortar_01_weapon_F","B_HMG_01_support_high_F","B_HMG_01_support_F","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_mcamo","B_Kitbag_sgg","B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F","B_Messenger_Black_F","B_Messenger_Coyote_F","B_Messenger_Gray_F","B_Messenger_Olive_F","B_Static_Designator_01_weapon_F","B_AA_01_weapon_F","B_AT_01_weapon_F","B_Parachute","B_TacticalPack_blk","B_TacticalPack_rgr","B_TacticalPack_ocamo","B_TacticalPack_mcamo","B_TacticalPack_oli","B_UAV_06_backpack_F","B_UAV_06_medical_backpack_F","B_UAV_01_backpack_F","B_AssaultPack_Kerry","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_hex_F","B_ViperHarness_khk_F","B_ViperHarness_oli_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","B_Mortar_01_Weapon_grn_F"];
_uniformsWhitelisted = ["","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_3_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_I_G_resistanceLeader_F","U_B_T_Soldier_F","U_B_T_Soldier_AR_F","U_I_CombatUniform","U_I_OfficerUniform","U_I_CombatUniform_shortsleeve","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_Competitor","U_C_ConstructionCoverall_Black_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Vrana_F","U_B_CTRG_1","U_B_CTRG_3","U_B_CTRG_2","U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_3_F","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_urb_1_F","U_B_CTRG_Soldier_urb_3_F","U_B_CTRG_Soldier_urb_2_F","U_O_CombatUniform_oucamo","U_I_FullGhillie_ard","U_O_FullGhillie_ard","U_B_FullGhillie_ard","U_O_T_FullGhillie_tna_F","U_B_T_FullGhillie_tna_F","U_I_FullGhillie_lsh","U_O_FullGhillie_lsh","U_B_FullGhillie_lsh","U_I_FullGhillie_sard","U_O_FullGhillie_sard","U_B_FullGhillie_sard","U_B_GEN_Commander_F","U_B_GEN_Soldier_F","U_B_T_Sniper_F","U_I_GhillieSuit","U_O_GhillieSuit","U_B_GhillieSuit","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla1_2_F","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_leader","U_I_HeliPilotCoveralls","U_B_HeliPilotCoveralls","U_C_HunterBody_grn","U_C_Journalist","U_Marshal","U_C_Mechanic_01_F","U_C_Paramedic_01_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_1_F","U_I_pilotCoveralls","U_O_PilotCoveralls","U_B_PilotCoveralls","U_Rangemaster","U_B_CombatUniform_mcam_vest","U_B_T_Soldier_SL_F","U_C_man_sport_1_F","U_C_man_sport_3_F","U_C_man_sport_2_F","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_B_survival_uniform","U_I_C_Soldier_Camo_F","U_I_Wetsuit","U_O_Wetsuit","U_B_Wetsuit","U_C_WorkerCoveralls","U_C_Poor_1","U_I_G_Story_Protagonist_F","U_B_CombatUniform_mcam_worn"];
_vestsWhitelisted = ["","V_PlateCarrierGL_blk","V_PlateCarrierGL_rgr","V_PlateCarrierGL_mtp","V_PlateCarrierGL_tna_F","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier1_tna_F","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrier2_rgr_noflag_F","V_PlateCarrier2_tna_F","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_rgr","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_tna_F","V_Chestrig_blk","V_Chestrig_rgr","V_Chestrig_khk","V_Chestrig_oli","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_DeckCrew_blue_F","V_DeckCrew_brown_F","V_DeckCrew_green_F","V_DeckCrew_red_F","V_DeckCrew_violet_F","V_DeckCrew_white_F","V_DeckCrew_yellow_F","V_EOD_blue_F","V_EOD_coyote_F","V_EOD_olive_F","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_TacVest_gen_F","V_Plain_crystal_F","V_HarnessOGL_brn","V_HarnessOGL_ghex_F","V_HarnessOGL_gry","V_HarnessO_brn","V_HarnessO_ghex_F","V_HarnessO_gry","V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","V_Pocketed_black_F","V_Pocketed_coyote_F","V_Pocketed_olive_F","V_Rangemaster_belt","V_TacVestIR_blk","V_RebreatherIA","V_RebreatherIR","V_RebreatherB","V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_ghex_F","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_TacChestrig_cbr_F","V_TacChestrig_grn_F","V_TacChestrig_oli_F","V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVest_blk_POLICE","V_I_G_resistanceLeader_F","V_PlateCarrier_Kerry","V_Press_F"];
if (!((backpack player) in _backpackWhitelisted)) then {
	removeBackpack player;
};
if (!((uniform player) in _uniformsWhitelisted)) then {
	player forceAddUniform _defaultUniform;
};
if (!((vest player) in _vestsWhitelisted)) then {
	removeVest player;
};
private _itemToRemove = '';
if (!((backpack player) isEqualTo '')) then {
	_maxLoadBackpack = 1;
	if ((loadBackpack player) > _maxLoadBackpack) then {
		while {((loadBackpack player) > _maxLoadBackpack)} do {
			_itemToRemove = selectRandom ((backpackItems player) + (backpackMagazines player));
			if (!(_itemToRemove in ['ToolKit','Medikit'])) then {
				player removeItemFromBackpack _itemToRemove;
			};
			if (canSuspend) then {
				uiSleep 0.01;
			};
		};
	};
};
if (!((vest player) isEqualTo '')) then {
	_maxLoadVest = 1;
	if ((loadVest player) > _maxLoadVest) then {
		while {((loadVest player) > _maxLoadVest)} do {
			_itemToRemove = selectRandom ((vestItems player) + (vestMagazines player));
			player removeItemFromVest _itemToRemove;
			if (canSuspend) then {
				uiSleep 0.01;
			};
		};
	};
};
if (!((uniform player) isEqualTo '')) then {
	_maxLoadUniform = 1;
	if ((loadUniform player) > _maxLoadUniform) then {
		while {((loadUniform player) > _maxLoadUniform)} do {
			_itemToRemove = selectRandom ((uniformItems player) + (uniformMagazines player));
			player removeItemFromUniform _itemToRemove;
			if (canSuspend) then {
				uiSleep 0.01;
			};
		};
	};	
};
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};