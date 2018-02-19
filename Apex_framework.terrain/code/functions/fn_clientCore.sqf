/*/
File: fn_clientCore.sqf
Author:

	Quiksilver
	
Last Modified:

	13/02/2018 A3 1.80 by Quiksilver
	
Description:

	Client Core Thread
__________________________________________________________________________/*/
private [
	'_timeNow','_puid','_playerClass','_fps','_missionStart','_QS_module_liveFeed','_QS_module_liveFeed_checkDelay','_QS_liveFeed_display','_terrainGrid',
	'_QS_liveFeed_vehicle','_QS_liveFeed_vehicle_current','_QS_liveFeed_camera','_QS_nullPos','_screenPos','_QS_liveFeed_text','_QS_module_liveFeed_noSignalFile',
	'_QS_liveFeed_action_1','_QS_liveFeed_action_2','_QS_module_liveFeed_delay','_displayPos','_QS_fpsArray','_QS_fpsAvgSamples','_QS_module_viewSettings',
	'_QS_RD_client_viewSettings_saveDelay','_QS_RD_client_viewSettings_saveCheckDelay','_revalidate','_QS_RD_client_viewSettings','_QS_RD_client_viewSettings_overall',
	'_QS_RD_client_viewSettings_object','_QS_RD_client_viewSettings_shadow','_QS_RD_client_viewSettings_grass','_QS_RD_client_viewSettings_environment',
	'_QS_module_menues','_mainMenuOpen','_QS_clientHp','_QS_clientMass','_QS_fpsLastPull','_mainMenuIDD','_QS_clientSideScore','_QS_clientScore',
	'_QS_rating','_viewMenuOpen','_viewMenuIDD','_viewDistance','_objectViewDistance','_shadowDistance','_clientViewSettings','_QS_module_crewIndicator',
	'_QS_module_crewIndicator_delay','_QS_module_crewIndicator_checkDelay','_QS_crewIndicatorIDD','_QS_crewIndicatorIDC','_QS_crewIndicator','_QS_crewIndicatorUI',
	'_QS_crewIndicator_imgDriver','_QS_crewIndicator_imgGunner','_QS_crewIndicator_imgCommander','_QS_crewIndicator_imgCargo','_QS_crewIndicator_imgSize','_QS_crewIndicator_color',
	'_QS_crewIndicator_colorHTML','_QS_crewIndicator_imgColor','_QS_crewIndicator_textColor','_QS_crewIndicator_textFont','_QS_crewIndicator_textSize','_crewManifest',
	'_QS_crewIndicator_shown','_fullCrew','_index','_QS_module_fuelConsumption','_QS_module_fuelConsumption_checkDelay','_QS_module_fuelConsumption_factor_2',
	'_QS_module_fuelConsumption_factor_1','_QS_module_fuelConsumption_delay','_unit','_role','_cargoIndex','_turretPath','_personTurret','_text','_roleImg','_unitName',
	'_QS_module_gearManager','_QS_module_gearManager_checkDelay','_QS_module_gearManager_delay','_QS_module_safezone','_QS_module_safezone_checkDelay',
	'_QS_module_safezone_pos','_QS_module_safezone_radius','_QS_module_safezone_isInSafezone','_QS_firstRun','_QS_module_safezone_playerProtection',
	'_QS_safeZoneText_leaving','_QS_module_safezone_delay','_playerThreshold','_QS_safeZoneText_entering','_QS_side','_QS_firstRun2',
	'_QS_clientATManager','_QS_clientATManager_delay','_QS_tto','_QS_artyEnabled','_QS_underEnforcement','_QS_enforcement_loop',
	'_QS_decayRate','_QS_decayDelay','_QS_fpsCheckDelay','_QS_fpsDelay','_pilotCheck','_QS_action_serviceVehicle','_QS_action_serviceVehicle_text',
	'_QS_action_serviceVehicle_array','_QS_interaction_serviceVehicle','_nearSite','_QS_action_clearVehicleInventory','_QS_action_clearVehicleInventory_text',
	'_QS_action_clearVehicleInventory_array','_QS_interaction_clearVehicleInventory','_posInFront','_listOfFrontStuff','_mines','_obj','_objType','_profileName',
	'_profileNameSteam','_iAmPilot','_loadedAtBase','_loadedAtMission','_newArray','_loadedInField','_QS_action_unflipVehicle','_QS_action_unflipVehicle_text',
	'_QS_action_unflipVehicle_array','_QS_interaction_unflipVehicle','_QS_action_revive','_QS_action_revive_text','_QS_action_revive_array','_QS_interaction_revive',
	'_QS_medics','_QS_iAmMedic','_QS_revive_injuredAnims','_QS_module_animState','_QS_module_animState_delay','_QS_module_animState_checkDelay','_QS_animState',
	'_QS_action_arsenal','_QS_action_arsenal_text','_QS_action_arsenal_array','_QS_interaction_arsenal','_cursorDistance','_difficultyEnabledRTD','_QS_action_utilityOffroad',
	'_QS_action_utilityOffroad_textOn','_QS_action_utilityOffroad_textOff','_QS_action_utilityOffroad_array','_QS_interaction_utilityOffroad','_s0','_s2','_QS_module_texture',
	'_QS_module_texture_delay','_QS_module_texture_checkDelay','_QS_action_tow','_QS_action_tow_text','_QS_action_tow_array','_QS_interaction_tow','_engineers','_iamengineer',
	'_thermalOptics','_hasThermals','_myV','_QS_action_commandSurrender','_QS_action_commandSurrender_text','_QS_action_commandSurrender_array','_QS_interaction_commandSurrender',
	'_cursorTarget','_cursorTargetDistance','_objectParent','_QS_action_rescue','_QS_action_rescue_text','_QS_action_rescue_array','_QS_interaction_rescue','_QS_player',
	'_QS_action_secure','_QS_action_secure_text','_QS_action_secure_array','_QS_interaction_secure','_QS_action_civilian','_QS_action_civilian_text','_QS_action_civilian_array',
	'_QS_interaction_civilian','_allPlayers','_QS_action_turretSafety','_QS_action_turretSafety_text','_QS_action_turretSafety_array','_QS_interaction_turretSafety',
	'_QS_turretSafety_heliTypes','_QS_module_opsec_detected','_QS_module_opsec','_QS_module_opsec_delay','_QS_module_opsec_checkDelay','_QS_module_opsec_recoilSway',
	'_QS_module_opsec_menus','_QS_module_opsec_memory','_QS_module_opsec_vars','_QS_module_opsec_whitelist','_QS_module_opsec_hidden','_QS_module_opsec_patches',
	'_detected','_onLoad','_onUnload','_QS_module_opsec_displays','_QS_module_opsec_memArray','_binConfigPatches','_patchEntry','_patchList','_i','_children',
	'_child','_allowedChildren','_display','_validCommMenus','_commMenu','_namePlayer','_QS_module_opsec_memCheckDelay','_QS_module_opsec_memDelay','_targetFlag',
	'_QS_action_ears','_QS_action_ears_text','_QS_action_ears_array','_QS_interaction_ears','_QS_action_teeth','_QS_action_teeth_text','_QS_action_teeth_array',
	'_QS_interaction_teeth','_QS_module_opsec_checkScripts','_baseMarkers','_pr','_clientDifficulty','_QS_parsingNamespace',
	'_playerNetId','_QS_action_joinGroup','_QS_action_joinGroup_text','_QS_action_joinGroup_array','_QS_interaction_joinGroup','_QS_joinGroup_privateVar',
	'_posATLPlayer','_bis_fnc_diagkey','_uiNamespace_dynamicText','_QS_module_handleHeal','_QS_module_handleHeal_delay','_QS_module_handleHeal_checkDelay',
	'_QS_handleHeal_unit','_isCurator','_curatorDisplay','_curatorDisplay_loaded','_restrictions_AT_msg','_restrictions_SNIPER_msg','_restrictions_AUTOTUR_msg',
	'_restrictions_UAV_msg','_restrictions_OPTICS_msg','_restrictions_MG_msg','_restrictions_MMG_msg','_restrictions_SOPT_msg','_restrictions_MK_msg',
	'_restrictions_PACK_msg','_restrictions_FIRED_msg','_QS_weapons','_QS_playerType','_QS_objectTypes','_QS_objectRange','_cursorObject','_cursorObjectDistance',
	'_directPlayID','_playerClassDName','_grpTarget','_pilotAtBase','_QS_module_pilotSafezone_radius','_QS_module_pilotSafezone_checkDelay','_QS_module_pilotSafezone_delay',
	'_QS_module_pilotSafezone_isInSafezone','_QS_action_fob_status','_QS_action_fob_status_text','_QS_action_fob_status_array','_QS_interaction_fob_status','_QS_action_fob_terminals',
	'_QS_action_fob_activate','_QS_action_fob_activate_text','_QS_action_fob_activate_array','_QS_interaction_fob_activate','_QS_action_fob_respawn',
	'_QS_action_fob_respawn_text','_QS_action_fob_respawn_array','_QS_interaction_fob_respawn','_QS_action_crate_customize','_QS_action_crate_customize_text',
	'_QS_action_crate_array','_QS_interaction_customizeCrate','_nearInvSite','_QS_module_fuelConsumption_factor_3','_QS_interaction_worldName',
	'_checkworldtime','_QS_action_names','_QS_allMines','_QS_cameraOn','_QS_baseAreaPolygon','_QS_clientRankManager','_QS_clientRankManager_delay',
	'_QS_module_gearManager_defaultRifle','_QS_radioChannels','_QS_module_radioChannelManager','_QS_module_radioChannelManager_delay','_QS_module_radioChannelManager_checkDelay',
	'_QS_module_radioChannelManager_nearPrimary','_QS_module_radioChannelManager_nearSecondary','_QS_module_radioChannelManager_nearPrimaryRadius','_QS_module_radioChannelManager_nearSecondaryRadius',
	'_QS_module_radioChannelManager_primaryChannel','_QS_module_radioChannelManager_secondaryChannel','_QS_module_radioChannelManager_commandChannel',
	'_QS_module_radioChannelManager_notPilot','_QS_module_radioChannelManager_aircraftChannel','_QS_module_radioChannelManager_checkState','_QS_terminalVelocity','_d49','_QS_buttonCtrl',
	'_QS_module_49Opened','_defaultUniform','_QS_worldName','_QS_worldSize','_QS_pilotBabysitter','_QS_maxTimeOnGround','_QS_warningTimeOnGround','_QS_currentTimeOnGround',
	'_QS_secondsCounter','_QS_productVersion','_QS_productVersionSync','_QS_action_pushVehicle','_QS_action_pushVehicle_text','_QS_action_pushVehicle_array',
	'_QS_interaction_pushVehicle','_QS_afkTimer','_QS_afkTimer_playerThreshold','_QS_posWorldPlayer','_QS_action_createBoat','_QS_action_createBoat_text','_QS_action_createBoat_array','_QS_interaction_createBoat',
	'_QS_clientDynamicGroups','_QS_clientDynamicGroups_delay','_QS_clientDynamicGroups_checkDelay','_QS_playerGroup','_QS_clientDynamicGroups_testGrp','_QS_module_swayManager','_QS_module_swayManager_delay',
	'_QS_module_swayManager_checkDelay','_QS_module_swayManager_secWepSwayCoef','_QS_module_swayManager_isAT','_QS_action_sit','_QS_action_sit_text','_QS_action_sit_array','_QS_interaction_sit',
	'_QS_action_sit_chairTypes','_QS_clientOwner','_QS_module_taskManager','_QS_module_taskManager_delay','_QS_module_taskManager_checkDelay','_QS_module_taskManager_simpleTasks','_QS_moveTime','_QS_module_taskManager_currentTask',
	'_QS_module_opsec_checkActions','_opsec_actionTitle','_opsec_actionCode','_opsec_actionArgs','_opsec_actionPriority','_opsec_actionShowWindow','_opsec_actionHideOnUse','_opsec_actionShortcut',
	'_opsec_actionCondition','_opsec_actionRadius','_opsec_actionUnconscious','_opsec_actionTextWindowB','_opsec_actionTextWindowF','_opsec_actionIDs',
	'_opsec_actionParams','_opsec_actionWhitelist','_nearCargoVehicles','_QS_action_loadCargo','_QS_action_loadCargo_text','_QS_action_loadCargo_array',
	'_QS_interaction_loadCargo','_QS_action_loadCargo_vTypes','_QS_action_loadCargo_cargoTypes','_QS_action_loadCargo_validated','_QS_action_loadCargo_vehicle','_thermalsEnabled','_QS_module_revealPlayers',
	'_QS_module_revealPlayers_delay','_QS_module_revealPlayers_checkDelay','_QS_lbRank','_QS_modelInfoPlayer','_QS_rappelling','_QS_action_rappelSelf','_QS_action_rappelSelf_text','_QS_action_rappelSelf_array',
	'_QS_action_rappelAI','_QS_action_rappelAI_text','_QS_action_rappelAI_array','_QS_action_rappelDetach','_QS_action_rappelDetach_text','_QS_action_rappelDetach_array','_QS_interaction_rappelSelf',
	'_QS_interaction_rappelAI','_QS_interaction_rappelDetach','_commandingMenu','_kicked','_QS_module_opsec_memCheck_script','_QS_objectTypePlayer','_QS_action_sit_chairModels','_QS_action_rappelSafety',
	'_QS_action_rappelSafety_textDisable','_QS_action_rappelSafety_textEnable','_QS_action_rappelSafety_array','_QS_interaction_rappelSafety','_QS_arsenal_model','_QS_resolution','_QS_module_opsec_displays_default',
	'_QS_clientDLCs','_QS_module_opsec_return','_QS_module_opsec_checkMarkers','_QS_module_opsec_chatIntercept','_QS_module_opsec_chatIntercept_IDD','_QS_module_opsec_chatIntercept_IDC',
	'_QS_module_opsec_chatIntercept_script','_QS_module_opsec_chatIntercept_code','_allDisplays','_QS_module_opsec_displayIDDstr','_QS_module_opsec_iguiDisplays',
	'_QS_module_opsec_memArrayIGUI','_QS_module_opsec_iguiDisplays_delay','_QS_module_opsec_iguiDisplays_checkDelay',
	'_QS_module_opsec_memArrayMission','_QS_module_opsec_memArrayTitles','_QS_module_opsec_memArrayTitlesMission','_QS_module_opsec_rsctitles',
	'_QS_module_opsec_rsctitles_delay','_QS_module_opsec_rsctitles_checkDelay','_QS_module_opsec_rsctitlesMission_delay','_QS_module_opsec_rsctitlesMission_checkDelay','_QS_module_opsec_rsctitlesMission',
	'_QS_module_opsec_memArrayMission_delay','_QS_module_opsec_memArrayMission_checkDelay','_QS_module_opsec_memoryMission',
	'_QS_module_opsec_memCheck_WorkingArray','_QS_uiTime','_QS_isAdmin','_playerClassL','_QS_safezone_action','_QS_action_safezone','_QS_action_safezone_text','_QS_action_safezone_array',
	'_QS_action_activateVehicle','_QS_action_activateVehicle_text','_QS_action_activateVehicle_array','_QS_interaction_activateVehicle','_QS_cursorIntersections',
	'_QS_action_unloadCargo','_QS_action_unloadCargo_text','_QS_action_unloadCargo_array','_QS_interaction_unloadCargo','_QS_action_unloadCargo_vTypes','_QS_action_unloadCargo_cargoTypes',
	'_QS_action_unloadCargo_validated','_QS_action_unloadCargo_vehicle','_nearUnloadCargoVehicles','_QS_interaction_load2','_object','_QS_action_huronContainer','_QS_action_huronContainer_text',
	'_QS_action_huronContainer_array','_QS_interaction_huronContainer','_QS_action_huronContainer_models','_QS_helmetCam_helperType','_QS_module_swayManager_heavyWeapons','_QS_module_swayManager_heavyWeaponCoef_crouch',
	'_QS_module_swayManager_heavyWeaponCoef_stand','_QS_customAimCoef','_QS_recoilCoef','_QS_module_swayManager_recoilCoef_crouch','_QS_module_swayManager_recoilCoef_stand','_QS_module_scAssistant',
	'_QS_module_scAssistant_delay','_QS_module_scAssistant_checkDelay','_sectorFlag','_sectorPhase','_QS_viewSettings_var','_QS_isTanoa','_QS_tanoa_delay','_QS_tanoa_checkDelay',
	'_QS_inGeorgetown','_QS_georgetown_polygon','_QS_georgetown_priorVD','_QS_georgetown_priorOVD','_QS_georgetown_VD','_QS_georgetown_OVD','_QS_laserTarget','_QS_miscDelay5','_backpackWhitelisted','_QS_buttonAction',
	'_QS_module_groupIndicator','_QS_module_groupIndicator_delay','_QS_module_groupIndicator_checkDelay','_QS_module_groupIndicator_radius','_QS_module_groupIndicator_units','_QS_module_groupIndicator_types',
	'_QS_module_groupIndicator_filter','_QS_action_sensorTarget','_QS_action_sensorTarget_text','_QS_action_sensorTarget_array','_QS_interaction_sensorTarget','_QS_virtualSectors_data_public','_QS_toDelete',
	'_QS_module_fuelConsumption_vehicle','_QS_module_fuelConsumption_rpmIdle','_QS_module_fuelConsumption_rpmRed','_QS_module_fuelConsumption_factor','_QS_module_fuelConsumption_rpm','_QS_module_fuelConsumption_rpmDiff',
	'_QS_module_fuelConsumption_rpmFactor','_QS_module_fuelConsumption_useRPMFactor','_offroadTypes','_QS_action_examine','_QS_action_examine_text','_QS_action_examine_array','_QS_interaction_examine',
	'_QS_medicIcons_radius','_QS_medicIcons_delay','_QS_medicIcons_checkDelay','_QS_action_attachExp','_QS_action_attachExp_text','_QS_action_attachExp_array','_QS_interaction_attachExp','_QS_action_attachExp_textReal',
	'_QS_userActionText','_QS_action_stabilise','_QS_action_stabilise_text','_QS_action_stabilise_array','_QS_interaction_stabilise','_QS_cO','_QS_action_ugv_types',
	'_QS_ugv','_QS_action_ugv_stretcherModel','_QS_action_ugvLoad','_QS_action_ugvLoad_text','_QS_action_ugvLoad_array','_QS_interaction_ugvLoad','_QS_action_ugvUnload',
	'_QS_action_ugvUnload_text','_QS_action_ugvUnload_array','_QS_interaction_ugvUnload','_QS_uav','_QS_interaction_serviceDrone','_QS_interaction_towUGV','_QS_action_towUGV','_QS_ugvTow',
	'_QS_v2Type','_QS_v2TypeL','_QS_action_uavSelfDestruct','_QS_action_uavSelfDestruct_text','_QS_action_uavSelfDestruct_array','_QS_interaction_uavSelfDestruct','_QS_ugvSD',
	'_QS_action_carrierLaunch','_QS_action_carrierLaunch_text','_QS_action_carrierLaunch_array','_QS_interaction_carrierLaunch','_QS_carrier_cameraOn','_QS_carrier_inPolygon',
	'_QS_carrierPolygon','_QS_carrierLaunchData','_QS_carrierPos','_fn_data_carrierLaunch','_serverTime','_hintsQueue','_hintData','_hintDelay','_hintCheckDelay','_hintActive','_hintActiveDuration',
	'_hintPriority','_hintUseSound','_hintDuration','_hintPreset','_hintText','_hintOtherData','_hintIrrelevantWhen','_hintTextPrevious','_hintPriorClosedAt','_true','_false','_enemysides',
	'_isAltis','_isTanoa','_QS_carrierEnabled','_array'
];
disableSerialization;
_QS_productVersion = productVersion;
_QS_resolution = getResolution;
_missionStart = missionStart;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_QS_clientDLCs = [(getDLCs 0),(getDLCs 1),(getDLCs 2)]; /*/275700 - Arma 3 Zeus 249860 - Arma 3 Soundtrack 304400 - Arma 3 DLC Bundle 249861 - Arma 3 Maps 249862 - Arma 3 Tactical Guide 288520 - Arma 3 Karts 304380 - Arma 3 Helicopters 332350 - Arma 3 Marksmen/*/
_timeNow = time;
_serverTime = serverTime;
_QS_uiTime = diag_tickTime;
_QS_player = player;
_namePlayer = name player;
_puid = getPlayerUID player;
_allPlayers = allPlayers;
_QS_clientOwner = clientOwner;
_playerClass = typeOf player;
_playerClassL = toLower _playerClass;
_objectParent = objectParent player;
_QS_v2 = vehicle player;
_QS_v2Type = typeOf _QS_v2;
_QS_v2TypeL = toLower _QS_v2Type;
_QS_cameraOn = cameraOn;
_QS_cO = cameraOn;
_playerClassDName = getText (configFile >> 'CfgVehicles' >> _playerClass >> 'displayName');
_QS_fpsLastPull = round diag_fps;
_profileName = profileName;
_profileNameSteam = profileNameSteam;
_playerNetId = netId player;
_QS_posWorldPlayer = getPosWorld player;
_QS_moveTime = moveTime player;
_QS_objectTypePlayer = getObjectType player;
_QS_modelInfoPlayer = getModelInfo player;
_QS_side = playerSide;
_directPlayID = player getVariable ['QS_directPlayID',-1];
_QS_nullPos = [0,0,0];
_QS_firstRun = TRUE;
_QS_module_menues = TRUE;
_mainMenuIDD = 2000;
_mainMenuOpen = FALSE;
_viewMenuIDD = 3000;
_viewMenuOpen = FALSE;
_QS_module_49Opened = FALSE;
_QS_buttonAction = "[] call (missionNamespace getVariable 'QS_fnc_clientMenu2')";
_QS_fpsArray = [];
_QS_fpsAvgSamples = 60;
_QS_fpsDelay = 0.5;
_QS_fpsCheckDelay = _timeNow + _QS_fpsDelay;
_QS_terminalVelocity = [10e10,10e14,10e18];
_QS_isAdmin = _puid in (['ALL'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]));
_QS_helmetCam_helperType = 'sign_sphere10cm_f';
_true = TRUE;
_false = FALSE;
_enemysides = [EAST,RESISTANCE,sideEnemy];
_isAltis = _QS_worldName isEqualTo 'Altis';
_isTanoa = _QS_worldName isEqualTo 'Tanoa';
_fn_inString = missionNamespace getVariable 'QS_fnc_inString';
if (_QS_isAdmin) then {
	{
		_x setMarkerAlphaLocal 0.25;
	} forEach [
		'QS_marker_fpsMarker',
		'QS_marker_curators'
	];
	if (_puid in (['ALL'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]))) then {
		missionNamespace setVariable ['QS_armedAirEnabled',TRUE,FALSE];
	};
};
private _QS_isUAVOperator = player getUnitTrait 'uavhacker';
missionNamespace setVariable ['QS_client_heartbeat',_timeNow,FALSE];

/*/========================= View settings module/*/

_QS_module_viewSettings = TRUE;
_QS_RD_client_viewSettings_saveDelay = 600;
_QS_RD_client_viewSettings_saveCheckDelay = time + _QS_RD_client_viewSettings_saveDelay;
player setVariable ['QS_RD_client_viewSettings_currentMode',0,FALSE];
player setVariable ['QS_RD_viewSettings_update',TRUE,FALSE];
_QS_viewSettings_var = format ['QS_RD_client_viewSettings_%1',_QS_worldName];
if (isNil {profileNamespace getVariable _QS_viewSettings_var}) then {
	_revalidate = TRUE;
} else {
	_QS_RD_client_viewSettings = profileNamespace getVariable [_QS_viewSettings_var,[]];
	if (!(_QS_RD_client_viewSettings isEqualType [])) then {
		_revalidate = TRUE;
	} else {
		if (!((count _QS_RD_client_viewSettings) isEqualTo 5)) then {
			_revalidate = TRUE;
		} else {
			_QS_RD_client_viewSettings params [
				'_QS_RD_client_viewSettings_overall',
				'_QS_RD_client_viewSettings_object',
				'_QS_RD_client_viewSettings_shadow',
				'_QS_RD_client_viewSettings_grass',
				'_QS_RD_client_viewSettings_environment'
			];
			_revalidate = FALSE;
			{
				if (!(_x isEqualType 0)) then {
					_revalidate = TRUE;
				};
			} count _QS_RD_client_viewSettings_overall;
			{
				if (!(_x isEqualType 0)) then {
					_revalidate = TRUE;
				};
			} count _QS_RD_client_viewSettings_object;
			{
				if (!(_x isEqualType 0)) then {
					_revalidate = TRUE;
				};
			} count _QS_RD_client_viewSettings_shadow;
			{
				if (!(_x isEqualType 0)) then {
					_revalidate = TRUE;
				};
			} count _QS_RD_client_viewSettings_grass;
			{
				if (!(_x isEqualType TRUE)) then {
					_revalidate = TRUE;
				};
			} count _QS_RD_client_viewSettings_environment;
		};
	};
};
if (_revalidate) then {
	if (_QS_worldName isEqualTo 'Tanoa') then {
		player setVariable [
			_QS_viewSettings_var,
			[
				[1000,2000,3000,4000],
				[800,1400,2400,3000],
				[50,50,50,50],
				[45,45,45,45],
				[TRUE,TRUE,FALSE,FALSE]
			],
			FALSE
		];
	} else {
		player setVariable [
			_QS_viewSettings_var,
			[
				[1000,2400,3200,4000],
				[800,1400,2400,3000],
				[50,50,50,50],
				[45,45,45,45],
				[TRUE,TRUE,FALSE,FALSE]
			],
			FALSE
		];	
	};
	profileNamespace setVariable [_QS_viewSettings_var,(player getVariable _QS_viewSettings_var)];
	saveProfileNamespace;
} else {
	player setVariable [
		_QS_viewSettings_var,
		(profileNamespace getVariable [_QS_viewSettings_var,[]]),
		FALSE
	];
};

/*/=========================== Action manager module/*/
_QS_module_action = TRUE;
{
	player setVariable _x;
} forEach [
	['QS_RD_interacting',FALSE,TRUE],
	['QS_RD_interacted',FALSE,TRUE],
	['QS_RD_draggable',FALSE,TRUE],
	['QS_RD_carryable',FALSE,TRUE],
	['QS_RD_escorting',FALSE,TRUE],
	['QS_RD_escorted',FALSE,TRUE],
	['QS_RD_escortable',FALSE,TRUE],
	['QS_RD_interaction_busy',FALSE,FALSE],
	['QS_RD_canRespawnVehicle',-1,FALSE],
	['QS_RD_draggable',FALSE,TRUE],
	['QS_RD_carryable',FALSE,TRUE],
	['QS_RD_loadable',FALSE,TRUE]
];
_cursorTarget = cursorTarget;
_cursorObject = cursorObject;
_QS_nearEntities_revealDelay = 5;
_QS_nearEntities_revealCheckDelay = time + _QS_nearEntities_revealDelay;
_QS_entityTypes = ['Man','LandVehicle','Air','Ship'];
_QS_entityRange = 5;
_QS_objectTypes = 'All';
_QS_objectRange = 4;
_QS_actions = [];
_QS_interaction_escort = FALSE;
_QS_action_escort = nil;
_QS_action_escort_text = 'Escort';
_QS_action_escort_array = [_QS_action_escort_text,(missionNamespace getVariable 'QS_fnc_clientInteractEscort'),[],95,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_load = FALSE;
_QS_interaction_load2 = FALSE;
_QS_action_load = nil;
_QS_action_load_text = 'Load';
_QS_action_load_array = [_QS_action_load_text,(missionNamespace getVariable 'QS_fnc_clientInteractLoad'),[],94,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_unload = FALSE;
_QS_action_unload = nil;
_QS_action_unload_text = 'Unload';
_QS_action_unload_array = [_QS_action_unload_text,(missionNamespace getVariable 'QS_fnc_clientInteractUnload'),[],-10,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_questionCivilian = FALSE;
_QS_action_questionCivilian = nil;
_QS_action_questionCivilian_text = 'Question civilian';
_QS_action_questionCivilian_array = [_QS_action_questionCivilian_text,(missionNamespace getVariable 'QS_fnc_clientInteractCivilian'),[],92,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_drag = FALSE;
_QS_action_drag = nil;
_QS_action_drag_text = 'Drag';
_QS_action_drag_array = [_QS_action_drag_text,(missionNamespace getVariable 'QS_fnc_clientInteractDrag'),[],-9,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_carry = FALSE;
_QS_action_carry = nil;
_QS_action_carry_text = 'Carry';
_QS_action_carry_array = [_QS_action_carry_text,(missionNamespace getVariable 'QS_fnc_clientInteractCarry'),[],-10,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_follow = FALSE;
_QS_action_follow = nil;
_QS_action_follow_text = 'Command Follow';
_QS_action_follow_array = [_QS_action_follow_text,(missionNamespace getVariable 'QS_fnc_clientInteractFollow'),[],89,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_recruit = FALSE;
_QS_action_recruit = nil;
_QS_action_recruit_text = 'Command Recruit';
_QS_action_recruit_array = [_QS_action_recruit_text,(missionNamespace getVariable 'QS_fnc_clientInteractRecruit'),[],88,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_dismiss = FALSE;
_QS_action_dismiss = nil;
_QS_action_dismiss_text = 'Command Dismiss';
_QS_action_dismiss_array = [_QS_action_dismiss_text,(missionNamespace getVariable 'QS_fnc_clientInteractDismiss'),[],-81,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_release = FALSE;
_QS_action_release = nil;
_QS_action_release_text = 'Release';
_QS_action_release_array = [_QS_action_release_text,(missionNamespace getVariable 'QS_fnc_clientInteractRelease'),[],88,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_respawnVehicle = FALSE;
_QS_action_respawnVehicle = nil;
_QS_action_respawnVehicle_text = 'Respawn vehicle';
_QS_action_respawnVehicle_array = [_QS_action_respawnVehicle_text,(missionNamespace getVariable 'QS_fnc_clientInteractRespawnVehicle'),[],-80,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_vehDoors = FALSE;				
_QS_action_vehDoors = nil;
_QS_action_vehDoors_textOpen = 'Open cargo doors';
_QS_action_vehDoors_textClose = 'Close cargo doors';
_QS_action_vehDoors_array = [_QS_action_vehDoors_textOpen,(missionNamespace getVariable 'QS_fnc_clientInteractVehicleDoors'),[],-10,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_action_vehDoors_vehicles = [
	'B_Heli_Transport_01_F','B_Heli_Transport_01_camo_F','O_Heli_Light_02_unarmed_F','O_Heli_Light_02_F','O_Heli_Light_02_v2_F','O_Heli_Attack_02_F',
	'O_Heli_Attack_02_black_F','B_Heli_Transport_03_F','B_Heli_Transport_03_unarmed_F','I_Heli_Transport_02_F','C_IDAP_Heli_Transport_02_F',
	'O_Heli_Transport_04_ammo_black_F','O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_bench_black_F',
	'O_Heli_Transport_04_bench_F','O_Heli_Transport_04_black_F','O_Heli_Transport_04_box_black_F',
	'O_Heli_Transport_04_box_F','O_Heli_Transport_04_covered_black_F','O_Heli_Transport_04_covered_F',
	'O_Heli_Transport_04_F','O_Heli_Transport_04_fuel_black_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_black_F',
	'O_Heli_Transport_04_medevac_F','O_Heli_Transport_04_repair_black_F','O_Heli_Transport_04_repair_F','B_Heli_Transport_03_unarmed_green_F',
	'B_CTRG_Heli_Transport_01_tropic_F','B_CTRG_Heli_Transport_01_sand_F','O_Heli_Light_02_dynamicLoadout_F','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F',
	'C_Van_02_medevac_F','C_Van_02_vehicle_F','C_Van_02_service_F','C_Van_02_transport_F','C_IDAP_Van_02_medevac_F','C_IDAP_Van_02_vehicle_F','C_IDAP_Van_02_transport_F',
	'B_G_Van_02_vehicle_F','B_G_Van_02_transport_F','O_G_Van_02_vehicle_F','O_G_Van_02_transport_F','I_C_Van_02_vehicle_F','I_C_Van_02_transport_F','I_G_Van_02_vehicle_F','I_G_Van_02_transport_F',
	'B_GEN_Van_02_vehicle_F','B_GEN_Van_02_transport_F'
];
_QS_action_serviceVehicle = nil;
_QS_action_serviceVehicle_text = 'Service vehicle';
_QS_action_serviceVehicle_array = [_QS_action_serviceVehicle_text,(missionNamespace getVariable 'QS_fnc_clientInteractServiceVehicle'),[],10,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_serviceVehicle = FALSE;
if (['SG',missionName,FALSE] call (missionNamespace getVariable 'BIS_fnc_inString')) then {
	_QS_interaction_worldName = [(toString [65,108,116,105,115])];
} else {
	_QS_interaction_worldName = ['Altis','Tanoa'];
};
_QS_action_unflipVehicle = nil;
_QS_action_unflipVehicle_text = 'Unflip';
_QS_action_unflipVehicle_array = [_QS_action_unflipVehicle_text,(missionNamespace getVariable 'QS_fnc_clientInteractUnflipVehicle'),[],10,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_unflipVehicle = FALSE;
/*/== Revive Anim/*/
_QS_action_revive = nil;
_QS_action_revive_text = 'Revive';
_QS_action_revive_array = [_QS_action_revive_text,(missionNamespace getVariable 'QS_fnc_clientInteractRevive'),[],99,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_revive = FALSE;
_QS_revive_injuredAnims = [
	'acts_injuredlyingrifle01','acts_injuredlyingrifle02','ainjppnemstpsnonwrfldnon','ainjppnemstpsnonwnondnon','ainjpfalmstpsnonwrfldnon_carried_down',
	'unconscious','amovppnemstpsnonwnondnon','ainjpfalmstpsnonwnondnon_carried_down','unconsciousrevivedefault','unconsciousrevivedefault','unconsciousrevivedefault_a',
	'unconsciousrevivedefault_b','unconsciousrevivedefault_base','unconsciousrevivedefault_c'
];
_QS_medics = [
	'B_medic_F','B_recon_medic_F','B_G_medic_F','O_G_medic_F','I_G_medic_F','O_medic_F','I_medic_F','O_recon_medic_f',
	'B_CTRG_soldier_M_medic_F','B_soldier_universal_f','O_soldier_universal_f','I_soldier_universal_f',"B_T_Medic_F","B_T_Recon_Medic_F",'B_CTRG_Soldier_Medic_tna_F'
];
_checkworldtime = time + 30 + (random 600);
_QS_iAmMedic = FALSE;
if ((_playerClass in _QS_medics) || (player getUnitTrait 'medic')) then {
	_QS_iAmMedic = TRUE;
	[43,[player,_puid]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
_QS_medics = nil;
/*/===== Stabilise/*/
_QS_action_stabilise = nil;
_QS_action_stabilise_text = 'Stabilise';
_QS_action_stabilise_array = [_QS_action_stabilise_text,(missionNamespace getVariable 'QS_fnc_clientInteractStabilise'),nil,91,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_stabilise = FALSE;
/*/===== Arsenal/*/
_QS_action_arsenal = nil;
_QS_action_arsenal_text = 'Arsenal';
_QS_action_arsenal_array = [_QS_action_arsenal_text,(missionNamespace getVariable 'QS_fnc_clientInteractArsenal'),[],90,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_arsenal = FALSE;
_QS_arsenal_model = 'a3\weapons_f\ammoboxes\supplydrop.p3d';
/*/===== Utility offroad/*/
_QS_action_utilityOffroad = nil;
_QS_action_utilityOffroad_textOn = 'Beacons On';
_QS_action_utilityOffroad_textOff = 'Beacons Off';
_QS_action_utilityOffroad_array = [_QS_action_utilityOffroad_textOn,(missionNamespace getVariable 'QS_fnc_clientInteractUtilityOffroad'),[],-10,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_utilityOffroad = FALSE;
_offroadTypes = ["b_g_offroad_01_f","b_g_offroad_01_armed_f","b_g_offroad_01_repair_f","b_gen_offroad_01_gen_f","o_g_offroad_01_f","o_g_offroad_01_armed_f","o_g_offroad_01_repair_f","i_g_offroad_01_f","i_g_offroad_01_armed_f","i_g_offroad_01_repair_f","c_offroad_01_f","c_offroad_01_repair_f","c_idap_offroad_01_f",'c_offroad_01_blue_f','c_offroad_01_bluecustom_f','c_offroad_01_darkred_f','c_offroad_01_red_f','c_offroad_01_sand_f','c_offroad_01_white_f','c_offroad_luxe_f','c_offroad_stripped_f'];
/*/===== Tow/*/
_engineers = [
	'B_soldier_repair_F','B_engineer_F','B_G_engineer_F','O_engineer_F','O_soldier_repair_F','I_engineer_F',
	'I_Soldier_repair_F','O_engineer_U_F','O_soldierU_repair_F','C_man_w_worker_F','B_T_Engineer_F'
];
_iamengineer = ((_playerClass in _engineers) || (player getUnitTrait 'engineer'));
_engineers = nil;
_QS_action_tow = nil;
_QS_action_tow_text = 'Tow';
_QS_action_tow_array = [_QS_action_tow_text,(missionNamespace getVariable 'QS_fnc_vTow'),[],21,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_tow = FALSE;
/*/===== Surrender/*/
_QS_action_commandSurrender = nil;
_QS_action_commandSurrender_text = 'Command Surrender';
_QS_action_commandSurrender_array = [_QS_action_commandSurrender_text,(missionNamespace getVariable 'QS_fnc_clientInteractSurrender'),[],90,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_commandSurrender = FALSE;
/*/===== Rescue/*/
_QS_action_rescue = nil;
_QS_action_rescue_text = 'Rescue';
_QS_action_rescue_array = [_QS_action_rescue_text,(missionNamespace getVariable 'QS_fnc_clientInteractRescue'),[],95,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_rescue = FALSE;
/*/===== Secure/*/
_QS_action_secure = nil;
_QS_action_secure_text = 'Secure';
_QS_action_secure_array = [_QS_action_secure_text,(missionNamespace getVariable 'QS_fnc_clientInteractSecure'),[],95,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_secure = FALSE;
/*/===== Examine/*/
_QS_action_examine = nil;
_QS_action_examine_text = 'Examine';
_QS_action_examine_array = [_QS_action_examine_text,(missionNamespace getVariable 'QS_fnc_clientInteractExamine'),[],94,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_examine = FALSE;
/*/===== Turret safety/*/
_QS_action_turretSafety = nil;
_QS_action_turretSafety_text = 'Turret safety';
_QS_action_turretSafety_array = [_QS_action_turretSafety_text,(missionNamespace getVariable 'QS_fnc_clientInteractTurretControl'),[],-50,FALSE,FALSE,'','TRUE',5,FALSE,''];
_QS_interaction_turretSafety = FALSE;
missionNamespace setVariable ['QS_inturretloop',FALSE,FALSE];
_QS_turretSafety_heliTypes = ['B_Heli_Transport_01_camo_F','B_Heli_Transport_01_F','B_Heli_Transport_03_F',"B_CTRG_Heli_Transport_01_sand_F","B_CTRG_Heli_Transport_01_tropic_F"];
/*/===== Ear collector/*/
_QS_action_ears = nil;
_QS_action_ears_text = 'Collect ear';
_QS_action_ears_array = [_QS_action_ears_text,(missionNamespace getVariable 'QS_fnc_clientInteractEar'),[],-51,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_ears = FALSE;
/*/===== Teeth collector/*/
_QS_action_teeth = nil;
_QS_action_teeth_text = 'Collect gold tooth';
_QS_action_teeth_array = [_QS_action_teeth_text,(missionNamespace getVariable 'QS_fnc_clientInteractTooth'),[],-52,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_teeth = FALSE;
/*/===== Join group/*/
_QS_action_joinGroup = nil;
_QS_action_joinGroup_text = 'Join group';
_QS_action_joinGroup_array = [_QS_action_joinGroup_text,(missionNamespace getVariable 'QS_fnc_clientInteractJoinGroup'),[],-50,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_joinGroup = FALSE;
_QS_joinGroup_privateVar = 'BIS_dg_pri';
_grpTarget = grpNull;
/*/===== Fob status terminal/*/
_QS_action_fob_terminals = [];
_QS_action_fob_status = nil;
_QS_action_fob_status_text = 'FOB Status';
_QS_action_fob_status_array = [_QS_action_fob_status_text,(missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal'),1,25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_fob_status = FALSE;
/*/===== Activate FOB/*/
_QS_action_names = worldName;
_QS_action_fob_activate = nil;
_QS_action_fob_activate_text = 'Activate FOB';
_QS_action_fob_activate_array = [_QS_action_fob_activate_text,(missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal'),2,25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_fob_activate = FALSE;
/*/===== Enable FOB Respawn/*/
_QS_action_fob_respawn = nil;
_QS_action_fob_respawn_text = 'Enable FOB Respawn';
_QS_action_fob_respawn_array = [_QS_action_fob_respawn_text,(missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal'),3,25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_fob_respawn = FALSE;
/*/===== Crate Customization/*/
_QS_action_crate_customize = nil;
_QS_action_crate_customize_text = 'Edit Inventory';
_QS_action_crate_array = [_QS_action_crate_customize_text,(missionNamespace getVariable 'QS_fnc_clientInteractCustomizeInventory'),[],25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_customizeCrate = FALSE;
_nearInvSite = FALSE;
/*/===== Push Vehicle/*/
_QS_action_pushVehicle = nil;
_QS_action_pushVehicle_text = 'Push vehicle';
_QS_action_pushVehicle_array = [_QS_action_pushVehicle_text,(missionNamespace getVariable 'QS_fnc_clientInteractPush'),[],25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_pushVehicle = FALSE;
/*/===== Create Boat/*/
_QS_action_createBoat = nil;
_QS_action_createBoat_text = 'Inflate boat';
_QS_action_createBoat_array = [_QS_action_createBoat_text,(missionNamespace getVariable 'QS_fnc_clientInteractCreateBoat'),[],25,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_createBoat = FALSE;
/*/===== Sit/*/
_QS_action_sit = nil;
_QS_action_sit_text = 'Sit';
_QS_action_sit_array = [_QS_action_sit_text,(missionNamespace getVariable 'QS_fnc_clientInteractSit'),1,50,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_sit = FALSE;
_QS_action_sit_chairTypes = ['Land_CampingChair_V1_F','Land_CampingChair_V2_F','Land_ChairPlastic_F','Land_RattanChair_01_F','Land_ChairWood_F','Land_OfficeChair_01_F','Land_ArmChair_01_F'];
_QS_action_sit_chairModels = ['campingchair_v1_f.p3d','campingchair_v2_f.p3d','chairplastic_f.p3d','rattanchair_01_f.p3d','chairwood_f.p3d','officechair_01_f.p3d','armchair_01_f.p3d'];
/*/===== Load Cargo/*/
_QS_action_loadCargo = nil;
_QS_action_loadCargo_text = 'Load cargo';
_QS_action_loadCargo_array = [_QS_action_loadCargo_text,(missionNamespace getVariable 'QS_fnc_clientInteractLoadCargo'),[],50,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_loadCargo = FALSE;
_QS_action_loadCargo_vTypes = [
	'c_idap_van_02_vehicle_f','c_van_02_vehicle_f',
	'b_t_vtol_01_vehicle_blue_f','b_t_vtol_01_vehicle_f','b_t_vtol_01_vehicle_olive_f',
	'o_t_vtol_02_vehicle_dynamicLoadout_f','o_t_vtol_02_vehicle_f','o_t_vtol_02_vehicle_ghex_f','o_t_vtol_02_vehicle_grey_f','o_t_vtol_02_vehicle_hex_f',
	'b_g_van_02_vehicle_f','o_g_van_02_vehicle_f','i_g_van_02_vehicle_f','b_gen_van_02_vehicle_f'
];
_QS_action_loadCargo_cargoTypes = [];
_QS_action_loadCargo_validated = FALSE;
_QS_action_loadCargo_vehicle = objNull;
_nearCargoVehicles = [];
/*/===== Unload Cargo/*/
_QS_action_unloadCargo = nil;
_QS_action_unloadCargo_text = 'Unload cargo';
_QS_action_unloadCargo_array = [_QS_action_unloadCargo_text,(missionNamespace getVariable 'QS_fnc_clientInteractUnloadCargo'),[],-30,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_unloadCargo = FALSE;
_QS_action_unloadCargo_vTypes = [];
_QS_action_unloadCargo_cargoTypes = [];
_QS_action_unloadCargo_validated = FALSE;
_QS_action_unloadCargo_vehicle = objNull;
_nearUnloadCargoVehicles = [];
/*/===== Interact Activate Vehicle/*/
_QS_action_activateVehicle = nil;
_QS_action_activateVehicle_text = 'Activate vehicle';
_QS_action_activateVehicle_array = [_QS_action_activateVehicle_text,(missionNamespace getVariable 'QS_fnc_clientInteractActivateVehicle'),nil,49,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_activateVehicle = FALSE;
/*/===== Huron Medical Container (Simple Object)/*/
_QS_action_huronContainer = nil;
_QS_action_huronContainer_text = 'Treat at Medical Station';
_QS_action_huronContainer_array = [_QS_action_huronContainer_text,(missionNamespace getVariable 'QS_fnc_clientInteractMedStation'),nil,48,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_huronContainer = FALSE;
_QS_action_medevac_models = [
	'a3\supplies_f_heli\slingload\slingload_01_medevac_f.p3d',
	'a3\props_f_orange\humanitarian\camps\firstaidkit_01_closed_f.p3d',
	'a3\props_f_orange\humanitarian\camps\firstaidkit_01_open_f.p3d',
	'a3\air_f_heli\heli_transport_04\pod_heli_transport_04_medevac_f.p3d',
	'a3\soft_f_orange\van_02\van_02_medevac_f.p3d',
	'a3\air_f_heli\heli_transport_04\heli_transport_04_medevac_f.p3d',
	'a3\soft_f_gamma\truck_02\truck_02_medevac_f.p3d',
	'a3\soft_f_epc\truck_03\truck_03_medevac_f.p3d',
	'a3\soft_f_gamma\truck_01\truck_01_medevac_f.p3d',
	'a3\air_f_orange\uav_06\box_uav_06_f.p3d'
];
/*/===== Sensor Target/*/
_QS_action_sensorTarget = nil;
_QS_action_sensorTarget_text = ['Report target','Confirm target'] select (player getUnitTrait 'QS_trait_JTAC');
_QS_action_sensorTarget_array = [_QS_action_sensorTarget_text,(missionNamespace getVariable 'QS_fnc_clientInteractSensorTarget'),nil,60,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_sensorTarget = FALSE;
_QS_interaction_sensorTarget_canReport = ((player getUnitTrait 'QS_trait_leader') || (player getUnitTrait 'QS_trait_JTAC'));
/*/===== Attach Explosive (underwater)/*/
_QS_action_attachExp = nil;
_QS_action_attachExp_text = 'Put Explosive Charge';
_QS_action_attachExp_textReal = '';
_QS_action_attachExp_array = [_QS_action_attachExp_text,(missionNamespace getVariable 'QS_fnc_clientInteractUnderwaterDemo'),nil,59,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_attachExp = FALSE;
/*/===== UGV/*/
_QS_action_ugv_types = [
	'b_ugv_01_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f'
];
_QS_uav = objNull;
_QS_ugv = objNull;
_QS_ugvTow = objNull;
_QS_action_ugv_stretcherModel = 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d';
_QS_action_ugvLoad = nil;
_QS_action_ugvLoad_text = 'Load';
_QS_action_ugvLoad_array = [_QS_action_ugvLoad_text,{(_this select 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,4],50,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_ugvLoad = FALSE;
_QS_action_ugvUnload = nil;
_QS_action_ugvUnload_text = 'Unload';
_QS_action_ugvUnload_array = [_QS_action_ugvUnload_text,{(_this select 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,5],50,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_ugvUnload = FALSE;
_QS_interaction_serviceDrone = FALSE;
_QS_interaction_towUGV = FALSE;
_QS_action_towUGV = nil;
_QS_action_uavSelfDestruct = nil;
_QS_action_uavSelfDestruct_text = 'Self destruct';
_QS_action_uavSelfDestruct_array = [_QS_action_uavSelfDestruct_text,(missionNamespace getVariable 'QS_fnc_clientInteractUAVSelfDestruct'),nil,-20,FALSE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_uavSelfDestruct = FALSE;
_QS_ugvSD = objNull;
/*/===== Carrier Launch/*/
_QS_action_carrierLaunch = nil;
_QS_action_carrierLaunch_text = 'Initiate Launch Sequence';
_QS_action_carrierLaunch_array = [_QS_action_carrierLaunch_text,(missionNamespace getVariable 'QS_fnc_clientInteractCarrierLaunch'),nil,85,TRUE,TRUE,'','TRUE',5,FALSE,''];
_QS_interaction_carrierLaunch = FALSE;
_QS_carrier_cameraOn = objNull;
_QS_carrier_inPolygon = FALSE;
_QS_carrierPolygon = [];
_QS_carrierLaunchData = [];
_QS_carrierPos = [0,0,0];
_QS_carrierEnabled = missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0];
/*/===== Advanced Rappelling/*/
_QS_rappelling = TRUE;
if (_QS_rappelling) then {
	_QS_action_rappelSelf = nil;
	_QS_action_rappelSelf_text = 'Fastrope';
	_QS_action_rappelSelf_array = [_QS_action_rappelSelf_text,(missionNamespace getVariable 'QS_fnc_clientInteractRappel'),1,-10,TRUE,TRUE,'','TRUE',5,FALSE,''];
	_QS_interaction_rappelSelf = FALSE;
	_QS_action_rappelAI = nil;
	_QS_action_rappelAI_text = 'Fastrope AI units';
	_QS_action_rappelAI_array = [_QS_action_rappelAI_text,(missionNamespace getVariable 'QS_fnc_clientInteractRappel'),2,-11,FALSE,TRUE,'','TRUE',5,FALSE,''];
	_QS_interaction_rappelAI = FALSE;
	_QS_action_rappelDetach = nil;
	_QS_action_rappelDetach_text = 'Detach fastrope';
	_QS_action_rappelDetach_array = [_QS_action_rappelDetach_text,(missionNamespace getVariable 'QS_fnc_clientInteractRappel'),3,48,TRUE,TRUE,'','TRUE',5,FALSE,''];
	_QS_interaction_rappelDetach = FALSE;
	_QS_action_rappelSafety = nil;
	_QS_action_rappelSafety_textDisable = 'Disable fastrope';
	_QS_action_rappelSafety_textEnable = 'Enable fastrope';
	_QS_action_rappelSafety_array = [_QS_action_rappelSafety_textDisable,(missionNamespace getVariable 'QS_fnc_clientInteractRappel'),4,-12,FALSE,TRUE,'','TRUE',5,FALSE,''];
	_QS_interaction_rappelSafety = FALSE;
};
/*/============================ Live feed module/*/
_QS_module_liveFeed = TRUE;
if (_QS_module_liveFeed) then {
	_QS_module_liveFeed_delay = 5;
	_QS_module_liveFeed_checkDelay = _timeNow + 5;
	_QS_module_liveFeed_noSignalFile = 'media\images\billboards\billboard3.jpg';
	_QS_liveFeed_display = missionNamespace getVariable ['QS_Billboard_02',objNull];
	_QS_liveFeed_camera = 'Camera' camCreate _QS_nullPos;
	_QS_liveFeed_camera cameraEffect ['Internal','Back','qs_rd_lfe'];
	_QS_liveFeed_camera camSetFov 0.6;
	_QS_liveFeed_display setObjectTexture [0,'#(argb,512,512,1)r2t(qs_rd_lfe,1)'];
	_displayPos = getPosATL _QS_liveFeed_display;
	'qs_rd_lfe' setPiPEffect [3,1,0.8,1,0.1,[0.3,0.3,0.3,-0.5],[1.0,0.0,1.0,1.0],[0,0,0,0]];
	'qs_rd_lfe' setPiPEffect [0];
	_QS_liveFeed_camera_offset = [-0.18,0.08,0.05];
	_QS_liveFeed_vehicle_current = objNull;
	_QS_liveFeed_text = 'Helmet Cam (Live Feed):';
	player setVariable ['QS_RD_client_liveFeed',FALSE,TRUE];
	_QS_liveFeed_action_1 = _QS_liveFeed_display addAction [
		'Turn on live feed',
		{
			if (isPipEnabled) then {
				player setVariable ['QS_RD_client_liveFeed',TRUE,FALSE];
				50 cutText ['Acquiring signal, please wait ...','PLAIN DOWN',0.5];
			} else {
				50 cutText ['Enable PiP to view the live feed','PLAIN DOWN',0.5];
			};
		},
		[],
		90,
		TRUE,
		TRUE,
		'',
		'(!(player getVariable "QS_RD_client_liveFeed"))',
		5,
		FALSE,
		''
	];
	_QS_liveFeed_display setUserActionText [_QS_liveFeed_action_1,'Turn on live feed',(format ["<t size='3'>%1</t>",'Turn on live feed'])];
	_QS_liveFeed_action_2 = _QS_liveFeed_display addAction [
		'Turn off live feed',
		{
			player setVariable ['QS_RD_client_liveFeed',FALSE,FALSE];
			50 cutText ['Live feed off','PLAIN DOWN',0.5];
		},
		[],
		89,
		FALSE,
		TRUE,
		'',
		'(player getVariable "QS_RD_client_liveFeed")',
		5,
		FALSE,
		''
	];
	_QS_liveFeed_display setUserActionText [_QS_liveFeed_action_2,'Turn off live feed',(format ["<t size='3'>%1</t>",'Turn off live feed'])];
};

/*/======================= Vehicle manifest module/*/
_QS_module_crewIndicator = TRUE;
if (_QS_module_crewIndicator) then {
	_QS_module_crewIndicator_delay = 0.666;
	_QS_module_crewIndicator_checkDelay = time + _QS_module_crewIndicator_delay;
	_QS_crewIndicatorIDD = 6000;
	_QS_crewIndicatorIDC = 1001;
	_QS_crewIndicator = controlNull;
	_QS_crewIndicatorUI = uiNamespace getVariable ['QS_RD_client_dialog_crewIndicator',nil];
	_QS_crewIndicator_imgDriver = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa';
	_QS_crewIndicator_imgGunner = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa';
	_QS_crewIndicator_imgCommander = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa';
	_QS_crewIndicator_imgCargo = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa';
	_QS_crewIndicator_imgSize = 0.55;
	_QS_crewIndicator_color = [(profileNamespace getVariable ['GUI_BCG_RGB_R',0.3843]),(profileNamespace getVariable ['GUI_BCG_RGB_G',0.7019]),(profileNamespace getVariable ['GUI_BCG_RGB_B',0.8862]),(profileNamespace getVariable ['GUI_BCG_RGB_A',0.7])];
	_QS_crewIndicator_colorHTML = _QS_crewIndicator_color call (missionNamespace getVariable 'BIS_fnc_colorRGBAtoHTML');
	_QS_crewIndicator_imgColor = '#3C501B';
	_QS_crewIndicator_textColor = '#3C501B';
	_QS_crewIndicator_textFont = str 'RobotoCondensed';
	_QS_crewIndicator_textSize = 0.75;
	_crewManifest = '';
	_QS_crewIndicator_shown = FALSE;
};
/*/====================== Fuel consumption module/*/
_QS_module_fuelConsumption = TRUE;
_QS_module_fuelConsumption_delay = 5;
_QS_module_fuelConsumption_checkDelay = time + _QS_module_fuelConsumption_delay;
_QS_module_fuelConsumption_factor_1 = 0.99775; 									/*/0.99833;/*/
_QS_module_fuelConsumption_factor_2 = 0.99850;									/*/0.99900;/*/
_QS_module_fuelConsumption_factor_3 = 0.99700;									/*/0.99775;/*/
_QS_module_fuelConsumption_vehicle = objNull;
_QS_module_fuelConsumption_factor = 1;
_QS_module_fuelConsumption_rpm = 0;
_QS_module_fuelConsumption_rpmIdle = 0;
_QS_module_fuelConsumption_rpmRed = 0;
_QS_module_fuelConsumption_rpmDiff = 0;
_QS_module_fuelConsumption_rpmFactor = 0;
_QS_module_fuelConsumption_useRPMFactor = FALSE;
/*/===================== Gear manager module/*/
_QS_module_gearManager = TRUE;
_QS_module_gearManager_delay = 3;
_QS_module_gearManager_checkDelay = time + _QS_module_gearManager_delay;
_QS_module_gearManager_defaultRifle = 'arifle_MX_Hamr_pointer_F';
if (_QS_worldName isEqualTo 'Tanoa') then {
	_QS_module_gearManager_defaultRifle = 'arifle_MX_khk_Hamr_Pointer_F';
};
_restrictions_AT_msg = 'Only AT Soldiers may use this weapon system. Launcher removed.';
_restrictions_SNIPER_msg = 'Only Snipers may use this weapon system. Sniper rifle removed.';
_restrictions_AUTOTUR_msg = 'You are not allowed to use this weapon system, Backpack removed.';
_restrictions_UAV_msg = 'Only UAV operator may use this Item, UAV terminal removed.';
_restrictions_OPTICS_msg = 'Thermal optics such as TWS and Nightstalker are available only to Recon soldiers and Spotters.';
_restrictions_MG_msg = 'Only Autoriflemen may use this weapon system. LMG removed.';
_restrictions_MMG_msg = 'Only Heavy Gunners may use this weapon system. MMG removed.';
_restrictions_SOPT_msg = 'SOS and LRPS are designated for Snipers and Spotters only. Optic removed.';
_restrictions_MK_msg = 'Only Marksmen, sharpshooters and snipers may use this weapon system. Weapon removed.';
_restrictions_PACK_msg = 'Restricted backpack. Removed. Please ensure you use the NATO variant.';
_restrictions_FIRED_msg = 'This area is currently a safe zone. Operation of small-arms is prohibited!!!';
_restrictions_UNIFORM_msg = 'Restricted uniform types: VR, Racing, Enemy (to reduce friendly fire)';
/*/===== UAV TERMINAL/*/
_uavRestricted = ['B_UavTerminal','O_UavTerminal','I_UavTerminal','C_UavTerminal'];
/*/===== AT / MISSILE LAUNCHERS (excl RPG)/*/
_missileSoldiers = ['B_soldier_LAT_F','B_soldier_AA_F','B_soldier_AT_F','B_officer_F','B_recon_LAT_F',"B_T_Recon_LAT_F","B_T_Soldier_LAT_F","B_T_Soldier_AT_F","B_T_Soldier_AA_F"];
_missileSpecialised = [
	'launch_NLAW_F','launch_Titan_F','launch_B_Titan_F','launch_O_Titan_F',
	'launch_I_Titan_F','launch_Titan_short_F','launch_B_Titan_short_F',
	'launch_O_Titan_short_F','launch_I_Titan_short_F','launch_O_Titan_short_ghex_F',
	'launch_O_Titan_ghex_F','launch_B_Titan_tna_F','launch_B_Titan_short_tna_F'
];
/*/===== SNIPER RIFLES/*/
_snipers = ['B_sniper_F','B_officer_F','B_ghillie_ard_F','B_T_Sniper_F','B_T_ghillie_tna_F','B_T_Officer_F'];
_sniperSpecialised = [
	'srifle_GM6_F','srifle_GM6_LRPS_F',"srifle_GM6_SOS_F","srifle_LRR_F","srifle_LRR_LRPS_F","srifle_LRR_SOS_F","srifle_GM6_camo_F","srifle_GM6_camo_LRPS_F",
	"srifle_GM6_camo_SOS_F","srifle_LRR_camo_F","srifle_LRR_camo_LRPS_F","srifle_LRR_camo_SOS_F",
	'srifle_LRR_tna_F','srifle_GM6_ghex_F','srifle_LRR_tna_LRPS_F','srifle_GM6_ghex_LRPS_F'
];
/*/===== THERMAL OPTICS/*/
_opticsAllowed = [
	'B_T_Officer_F',"B_recon_TL_F","B_recon_medic_F","B_recon_LAT_F","B_recon_exp_F","B_recon_JTAC_F","B_recon_F","B_recon_M_F",
	"B_spotter_F","B_T_Diver_F","B_T_Diver_Exp_F","B_T_Diver_TL_F","B_T_Recon_Exp_F","B_T_Recon_JTAC_F","B_T_Recon_M_F","B_T_Recon_Medic_F",
	"B_T_Recon_F","B_T_Recon_LAT_F","B_T_Recon_TL_F","B_T_Sniper_F","B_T_ghillie_tna_F","B_T_Spotter_F"
];
_specialisedOptics = ["optic_Nightstalker","optic_tws","optic_tws_mg"];
/*/===== CLOTHING/*/
_defaultUniform = ['U_B_CombatUniform_mcam','U_B_T_Soldier_F'] select (_QS_worldName isEqualTo 'Tanoa');
_backpackWhitelisted = ["","B_AssaultPack_blk","B_AssaultPack_cbr","B_AssaultPack_dgtl","B_AssaultPack_rgr","B_AssaultPack_ocamo","B_AssaultPack_khk","B_AssaultPack_mcamo","B_AssaultPack_sgg","B_AssaultPack_tna_F","B_Bergen_dgtl_F","B_Bergen_hex_F","B_Bergen_mcamo_F","B_Bergen_tna_F","B_Carryall_cbr","B_Carryall_ghex_F","B_Carryall_ocamo","B_Carryall_khk","B_Carryall_mcamo","B_Carryall_oli","B_Carryall_oucamo","B_HMG_01_high_weapon_F","B_HMG_01_weapon_F","B_GMG_01_high_weapon_F","B_GMG_01_weapon_F","B_FieldPack_blk","B_FieldPack_cbr","B_FieldPack_ghex_F","B_FieldPack_ocamo","B_FieldPack_khk","B_FieldPack_oli","B_FieldPack_oucamo","B_Mortar_01_support_F","B_Mortar_01_weapon_F","B_HMG_01_support_high_F","B_HMG_01_support_F","B_Kitbag_cbr","B_Kitbag_rgr","B_Kitbag_mcamo","B_Kitbag_sgg","B_LegStrapBag_black_F","B_LegStrapBag_coyote_F","B_LegStrapBag_olive_F","B_Messenger_Black_F","B_Messenger_Coyote_F","B_Messenger_Gray_F","B_Messenger_Olive_F","B_Static_Designator_01_weapon_F","B_AA_01_weapon_F","B_AT_01_weapon_F","B_Parachute","B_TacticalPack_blk","B_TacticalPack_rgr","B_TacticalPack_ocamo","B_TacticalPack_mcamo","B_TacticalPack_oli","B_UAV_06_backpack_F","B_UAV_06_medical_backpack_F","B_UAV_01_backpack_F","B_AssaultPack_Kerry","B_ViperHarness_blk_F","B_ViperHarness_ghex_F","B_ViperHarness_hex_F","B_ViperHarness_khk_F","B_ViperHarness_oli_F","B_ViperLightHarness_blk_F","B_ViperLightHarness_ghex_F","B_ViperLightHarness_hex_F","B_ViperLightHarness_khk_F","B_ViperLightHarness_oli_F","B_Mortar_01_Weapon_grn_F"];
_uniformsWhitelisted = ["","U_I_C_Soldier_Bandit_4_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_3_F","U_C_Man_casual_2_F","U_C_Man_casual_3_F","U_C_Man_casual_1_F","U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_I_G_resistanceLeader_F","U_B_T_Soldier_F","U_B_T_Soldier_AR_F","U_I_CombatUniform","U_I_OfficerUniform","U_I_CombatUniform_shortsleeve","U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_Competitor","U_C_ConstructionCoverall_Black_F","U_C_ConstructionCoverall_Blue_F","U_C_ConstructionCoverall_Red_F","U_C_ConstructionCoverall_Vrana_F","U_B_CTRG_1","U_B_CTRG_3","U_B_CTRG_2","U_B_CTRG_Soldier_F","U_B_CTRG_Soldier_3_F","U_B_CTRG_Soldier_2_F","U_B_CTRG_Soldier_urb_1_F","U_B_CTRG_Soldier_urb_3_F","U_B_CTRG_Soldier_urb_2_F","U_O_CombatUniform_oucamo","U_I_FullGhillie_ard","U_O_FullGhillie_ard","U_B_FullGhillie_ard","U_O_T_FullGhillie_tna_F","U_B_T_FullGhillie_tna_F","U_I_FullGhillie_lsh","U_O_FullGhillie_lsh","U_B_FullGhillie_lsh","U_I_FullGhillie_sard","U_O_FullGhillie_sard","U_B_FullGhillie_sard","U_B_GEN_Commander_F","U_B_GEN_Soldier_F","U_B_T_Sniper_F","U_I_GhillieSuit","U_O_GhillieSuit","U_B_GhillieSuit","U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla1_2_F","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_BG_leader","U_I_HeliPilotCoveralls","U_B_HeliPilotCoveralls","U_C_HunterBody_grn","U_C_Journalist","U_Marshal","U_C_Mechanic_01_F","U_C_Paramedic_01_F","U_I_C_Soldier_Para_2_F","U_I_C_Soldier_Para_3_F","U_I_C_Soldier_Para_5_F","U_I_C_Soldier_Para_4_F","U_I_C_Soldier_Para_1_F","U_I_pilotCoveralls","U_O_PilotCoveralls","U_B_PilotCoveralls","U_Rangemaster","U_B_CombatUniform_mcam_vest","U_B_T_Soldier_SL_F","U_C_man_sport_1_F","U_C_man_sport_3_F","U_C_man_sport_2_F","U_C_Man_casual_6_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_B_survival_uniform","U_I_C_Soldier_Camo_F","U_I_Wetsuit","U_O_Wetsuit","U_B_Wetsuit","U_C_WorkerCoveralls","U_C_Poor_1","U_I_G_Story_Protagonist_F","U_B_CombatUniform_mcam_worn"];
_vestsWhitelisted = ["","V_PlateCarrierGL_blk","V_PlateCarrierGL_rgr","V_PlateCarrierGL_mtp","V_PlateCarrierGL_tna_F","V_PlateCarrier1_blk","V_PlateCarrier1_rgr","V_PlateCarrier1_rgr_noflag_F","V_PlateCarrier1_tna_F","V_PlateCarrier2_blk","V_PlateCarrier2_rgr","V_PlateCarrier2_rgr_noflag_F","V_PlateCarrier2_tna_F","V_PlateCarrierSpec_blk","V_PlateCarrierSpec_rgr","V_PlateCarrierSpec_mtp","V_PlateCarrierSpec_tna_F","V_Chestrig_blk","V_Chestrig_rgr","V_Chestrig_khk","V_Chestrig_oli","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_DeckCrew_blue_F","V_DeckCrew_brown_F","V_DeckCrew_green_F","V_DeckCrew_red_F","V_DeckCrew_violet_F","V_DeckCrew_white_F","V_DeckCrew_yellow_F","V_EOD_blue_F","V_EOD_coyote_F","V_EOD_olive_F","V_PlateCarrierIAGL_dgtl","V_PlateCarrierIAGL_oli","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_TacVest_gen_F","V_Plain_crystal_F","V_HarnessOGL_brn","V_HarnessOGL_ghex_F","V_HarnessOGL_gry","V_HarnessO_brn","V_HarnessO_ghex_F","V_HarnessO_gry","V_LegStrapBag_black_F","V_LegStrapBag_coyote_F","V_LegStrapBag_olive_F","V_Pocketed_black_F","V_Pocketed_coyote_F","V_Pocketed_olive_F","V_Rangemaster_belt","V_TacVestIR_blk","V_RebreatherIA","V_RebreatherIR","V_RebreatherB","V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F","V_BandollierB_blk","V_BandollierB_cbr","V_BandollierB_ghex_F","V_BandollierB_rgr","V_BandollierB_khk","V_BandollierB_oli","V_TacChestrig_cbr_F","V_TacChestrig_grn_F","V_TacChestrig_oli_F","V_TacVest_blk","V_TacVest_brn","V_TacVest_camo","V_TacVest_khk","V_TacVest_oli","V_TacVest_blk_POLICE","V_I_G_resistanceLeader_F","V_PlateCarrier_Kerry","V_Press_F"];
/*/===== LMG/*/
_autoRiflemen = ["B_soldier_AR_F",'B_officer_F','B_HeavyGunner_F','B_T_Soldier_AR_F','B_T_Officer_F'];
_autoSpecialised = [
	"LMG_Mk200_F","LMG_Mk200_MRCO_F","LMG_Mk200_pointer_F","LMG_Zafir_F","LMG_Zafir_pointer_F",'MMG_01_base_F','MMG_01_hex_ARCO_LP_F',
	'MMG_01_hex_F','MMG_01_tan_F','MMG_02_base_F','MMG_02_black_F',
	'MMG_02_black_RCO_BI_F','MMG_02_camo_F','MMG_02_sand_F','MMG_02_sand_RCO_LP_F',
	'LMG_03_F'
];
/*/===== Sniper optics/*/
_sniperTeam = ["B_sniper_F","B_spotter_F",'B_ghillie_ard_F',"B_T_Sniper_F","B_T_ghillie_tna_F",'B_T_Officer_F'];
_sniperOpt = ["optic_SOS","optic_LRPS"];
/*/===== Marksman/*/
_marksmen = [
	'B_soldier_M_F','B_sniper_F','B_recon_M_F','B_Sharpshooter_F','B_Recon_Sharpshooter_F','B_officer_F','B_ghillie_ard_F',"B_T_Sniper_F",
	"B_T_ghillie_tna_F",'B_CTRG_Soldier_M_tna_F'
];
_marksmenSpecialised = [
	"DMR_01_base_F","DMR_02_base_F","DMR_03_base_F","DMR_04_base_F","DMR_05_base_F","DMR_06_base_F","srifle_DMR_01_ACO_F","srifle_DMR_01_ARCO_F","srifle_DMR_01_DMS_BI_F",
	"srifle_DMR_01_DMS_F","srifle_DMR_01_DMS_snds_BI_F","srifle_DMR_01_DMS_snds_F","srifle_DMR_01_F","srifle_DMR_01_MRCO_F","srifle_DMR_01_SOS_F","srifle_DMR_02_ACO_F",
	"srifle_DMR_02_ARCO_F","srifle_DMR_02_camo_AMS_LP_F","srifle_DMR_02_camo_F","srifle_DMR_02_DMS_F","srifle_DMR_02_F","srifle_DMR_02_MRCO_F","srifle_DMR_02_sniper_AMS_LP_S_F",
	"srifle_DMR_02_sniper_F","srifle_DMR_02_SOS_F","srifle_DMR_03_ACO_F","srifle_DMR_03_AMS_F","srifle_DMR_03_ARCO_F","srifle_DMR_03_DMS_F","srifle_DMR_03_DMS_snds_F",
	"srifle_DMR_03_F","srifle_DMR_03_khaki_F","srifle_DMR_03_MRCO_F","srifle_DMR_03_multicam_F","srifle_DMR_03_SOS_F","srifle_DMR_03_spotter_F","srifle_DMR_03_tan_AMS_LP_F",
	"srifle_DMR_03_tan_F","srifle_DMR_03_woodland_F","srifle_DMR_04_ACO_F","srifle_DMR_04_ARCO_F","srifle_DMR_04_DMS_F","srifle_DMR_04_F","srifle_DMR_04_MRCO_F","srifle_DMR_04_NS_LP_F",
	"srifle_DMR_04_SOS_F","srifle_DMR_04_Tan_F","srifle_DMR_05_ACO_F","srifle_DMR_05_ARCO_F","srifle_DMR_05_blk_F","srifle_DMR_05_DMS_F","srifle_DMR_05_DMS_snds_F","srifle_DMR_05_hex_F",
	"srifle_DMR_05_KHS_LP_F","srifle_DMR_05_MRCO_F","srifle_DMR_05_SOS_F","srifle_DMR_05_tan_f","srifle_DMR_06_camo_F","srifle_DMR_06_camo_khs_F","srifle_DMR_06_olive_F"
];
/*/===== Heavy gunner/*/
_hmg = ['B_HeavyGunner_F','B_officer_F','B_T_Officer_F'];
_hmgSpecialised = [
	'MMG_01_base_F','MMG_01_hex_ARCO_LP_F','MMG_01_hex_F','MMG_01_tan_F','MMG_02_base_F','MMG_02_black_F',
	'MMG_02_black_RCO_BI_F','MMG_02_camo_F','MMG_02_sand_F','MMG_02_sand_RCO_LP_F'
];
/*/===== Mine Dispenser/*/
_mineDispenser = 'APERSMineDispenser_Mag';
_szmkr = markerPos 'QS_marker_base_marker';
if (_QS_firstRun) then {
	_QS_firstRun = FALSE;
	if ((player distance _szmkr) <= 300) then {
		_insideSafezone = TRUE;
		_outsideSafezone = FALSE;
	} else {
		_outsideSafezone = TRUE;
		_insideSafezone = FALSE;
	};
};
_QS_baseAreaPolygon = missionNamespace getVariable ['QS_base_safePolygon',[ [0,0,0] , [1,0,0] , [1,1,0] , [0,1,0] ]];
{
	missionNamespace setVariable _x;
} forEach [
	['QS_restrict_Thermal',FALSE,FALSE],
	['QS_restrict_LMG',TRUE,FALSE],
	['QS_restrict_sOptics',FALSE,FALSE],
	['QS_restrict_HMG',FALSE,FALSE],
	['QS_restrict_Marksmen',FALSE,FALSE]
];
_playerThreshold = 0;
if (!isNil {missionNamespace getVariable 'QS_airdefense_laptop'}) then {
	_airDefenseLaptop = missionNamespace getVariable ['QS_airdefense_laptop',objNull];
	if (_airDefenseLaptop isEqualType objNull) then {
		if (!isNull _airDefenseLaptop) then {
			_QS_airbaseDefense_action_1 = _airDefenseLaptop addAction [
				'Activate air defense',
				{
					if (missionNamespace getVariable ['QS_airbaseDefense',FALSE]) exitWith {
						50 cutText ['Air Defense on cooldown','PLAIN DOWN',0.5];
					};
					missionNamespace setVariable ['QS_airbaseDefense',TRUE,TRUE];
					player playAction 'PutDown';
					playSound ['Orange_Access_FM',FALSE];
					50 cutText ['Activating Air Defense','PLAIN DOWN',0.5];
				},
				[],
				90,
				TRUE,
				TRUE,
				'',
				'(isNull (objectParent player))',
				4,
				FALSE,
				''
			];
			_airDefenseLaptop setUserActionText [_QS_airbaseDefense_action_1,'Activate air defense',(format ["<t size='3'>%1</t>",'Activate air defense'])];
		};
	};
};
if (player getUnitTrait 'QS_trait_fighterPilot') then {
	if (!isNil {missionNamespace getVariable 'QS_cas_laptop'}) then {
		_casLaptop = missionNamespace getVariable ['QS_cas_laptop',objNull];
		if (_casLaptop isEqualType objNull) then {
			if (!isNull _casLaptop) then {
				player setVariable ['QS_cas_lastRequestTime',diag_tickTime,FALSE];
				_QS_casLaptop_action = _casLaptop addAction [
					'Spawn plane',
					{
						if (diag_tickTime > (player getVariable ['QS_cas_lastRequestTime',(diag_tickTime - 1)])) then {
							[74,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							player setVariable ['QS_cas_lastRequestTime',(diag_tickTime + 10),FALSE];
							player playAction 'PutDown';
							50 cutText ['Requesting plane ...','PLAIN DOWN',0.25];
						} else {
							50 cutText ['Too soon since last request (10s cooldown) ...','PLAIN DOWN',0.25];
						};
					},
					[],
					90,
					TRUE,
					TRUE,
					'',
					'(isNull (objectParent player))',
					5,
					FALSE,
					''
				];
				_casLaptop setUserActionText [_QS_casLaptop_action,'Spawn plane',(format ["<t size='3'>%1</t>",'Spawn plane'])];
			};
		};
	};
	_carrierLaptop = missionNamespace getVariable ['QS_carrier_casLaptop',objNull];
	if (!isNull _carrierLaptop) then {
		player setVariable ['QS_cas_lastRequestTime',diag_tickTime,FALSE];
		_QS_carrierLaptop_action = _carrierLaptop addAction [
			'Spawn plane',
			{
				if (diag_tickTime > (player getVariable ['QS_cas_lastRequestTime',(diag_tickTime - 1)])) then {
					[74,player] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					player setVariable ['QS_cas_lastRequestTime',(diag_tickTime + 10),FALSE];
					player playAction 'PutDown';
					50 cutText ['Requesting plane ...','PLAIN DOWN',0.25];
				} else {
					50 cutText ['Too soon since last request (10s cooldown) ...','PLAIN DOWN',0.25];
				};
			},
			[],
			90,
			TRUE,
			TRUE,
			'',
			'(isNull (objectParent player))',
			5,
			FALSE,
			''
		];
		_carrierLaptop setUserActionText [_QS_carrierLaptop_action,'Spawn plane',(format ["<t size='3'>%1</t>",'Spawn plane'])];
	};
};
/*/
if (!isNil {missionNamespace getVariable 'QS_panel_support'}) then {
	if (!isNull (missionNamespace getVariable 'QS_panel_support')) then {
		_supportActionID = (missionNamespace getVariable 'QS_panel_support') addAction [
			'About Us',
			{
			
			},
			[],
			50,
			TRUE,
			TRUE,
			'',
			'TRUE',
			5,
			FALSE,
			''
		];
		(missionNamespace getVariable 'QS_panel_support') setUserActionText [_supportActionID,'About Us',(format ["<t size='3'>%1</t>",'About Us'])];
	};
};
/*/

/*/=============== Safezone module/*/

_QS_module_safezone = TRUE;
_QS_module_safezone_delay = 2;
_QS_module_safezone_checkDelay = time + _QS_module_safezone_delay;
_QS_module_safezone_isInSafezone = FALSE;
_QS_module_safezone_pos = markerPos 'QS_marker_base_marker';
_QS_module_safezone_radius = 500;
_QS_module_safezone_playerProtection = 1;
_QS_safeZoneText_entering = 'Entering safezone';
_QS_safeZoneText_leaving = 'Leaving safezone';
_QS_firstRun2 = TRUE;
player addRating (0 - (rating player));
_QS_safezone_action = -1;
_QS_action_safezone = nil;
_QS_action_safezone_text = 'Weapons safe on base';
_QS_action_safezone_array = [_QS_action_safezone_text,(missionNamespace getVariable 'QS_fnc_clientInteractWeaponSafety'),nil,-99,FALSE,TRUE,'DefaultAction','TRUE',5,FALSE];
_QS_module_safezone_speedlimit_enabled = TRUE;
_QS_module_safezone_speedlimit_event = nil;
_QS_module_safezone_speedlimit_code = {
	if (!isNull (objectParent player)) then {
		_vehicle = vehicle player;
		if (_vehicle isKindOf 'LandVehicle') then {
			if (local _vehicle) then {
				_vPos = getPosATL _vehicle;
				if (!((missionNamespace getVariable ['QS_baseProtection_polygons',[]]) isEqualTo [])) then {
					if (!(({(_vPos inPolygon _x)} count (missionNamespace getVariable 'QS_baseProtection_polygons')) isEqualTo 0)) then {
						if (isTouchingGround _vehicle) then {
							_vectorSpeed = (vectorMagnitude (velocityModelSpace _vehicle)) * 3.6;
							if (_vectorSpeed > 10) then {
								private _pos1 = [0,0,0];
								private _pos2 = [0,0,0];
								{
									private _polygon = _x;
									for '_i' from 0 to ((count _polygon) - 1) step 1 do {
										_pos1 = _polygon select _i;
										if (_i isEqualTo ((count _polygon) - 1)) then {
											_pos2 = _polygon select 0;
										} else {
											_pos2 = _polygon select (_i + 1);
										};
										{
											drawLine3D _x;
										} forEach [
											[_pos1,_pos2,[1,0,0,1]],
											[[_pos1 select 0,_pos1 select 1,((_pos1 select 2) + 0.5)],[_pos2 select 0,_pos2 select 1,((_pos2 select 2) + 0.5)],[1,0,0,1]],
											[[_pos1 select 0,_pos1 select 1,((_pos1 select 2) + 0.25)],[_pos2 select 0,_pos2 select 1,((_pos2 select 2) + 0.25)],[1,0,0,1]],
											[[_pos1 select 0,_pos1 select 1,((_pos1 select 2) - 0.5)],[_pos2 select 0,_pos2 select 1,((_pos2 select 2) - 0.5)],[1,0,0,1]],
											[[_pos1 select 0,_pos1 select 1,((_pos1 select 2) - 0.25)],[_pos2 select 0,_pos2 select 1,((_pos2 select 2) - 0.25)],[1,0,0,1]]
										];
									};
								} forEach (missionNamespace getVariable 'QS_baseProtection_polygons');
								if (_vectorSpeed > 15) then {
									if (!(profileNamespace getVariable ['QS_system_speedLimitMsg',FALSE])) then {
										profileNamespace setVariable ['QS_system_speedLimitMsg',TRUE];
										saveProfileNamespace;
										50 cutText ['<t color="#ff0000">This is a speed-restricted area.</t>','PLAIN',1,FALSE,TRUE];
									};
									_velocityModelSpace = velocityModelSpace _vehicle;
									_newVelocity = _velocityModelSpace vectorMultiply 0.90;
									_vehicle setVelocityModelSpace _newVelocity;
								};
							};
						};
					};
				};
			};
		};
	};
};

/*/============= CLIENT RATING MANAGER/*/
_QS_clientRatingManager = TRUE;
_QS_clientRatingManager_delay = _timeNow + 5;
/*/============= CLIENT RANK MANAGER /*/
_QS_clientRankManager = TRUE;
_QS_clientRankManager_delay = _timeNow + 10;
player setRank 'PRIVATE';
/*/============= CLIENT GROUP MANAGER/*/
_QS_clientDynamicGroups = TRUE;
_QS_clientDynamicGroups_delay = 30;
_QS_clientDynamicGroups_checkDelay = _timeNow + _QS_clientDynamicGroups_delay;
_QS_playerGroup = group player;
_QS_clientDynamicGroups_testGrp = grpNull;
/*/============= CLIENT A-T MANAGER/*/
_QS_clientATManager = TRUE;
_QS_clientATManager_delay = _timeNow + 5;
_QS_tto = nil;
_QS_artyEnabled = TRUE;
_QS_underEnforcement = FALSE;
_QS_decayRate = 20 * 60;
_QS_decayDelay = _timeNow + _QS_decayRate;
_thermalsEnabled = (player getVariable ['QS_tto',0]) < 1.5;
_s0 = EAST;
_s2 = RESISTANCE;
/*/===== Pilot Check /*/
_pilotCheck = TRUE;
_iAmPilot = FALSE;
if (player getUnitTrait 'QS_trait_pilot') then {
	_iAmPilot = TRUE;
	_pilotAtBase = TRUE;
	[44,[player,_puid]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	_difficultyEnabledRTD = difficultyEnabledRTD;
	player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,time],TRUE];
};
_QS_module_pilotSafezone_radius = 2000;
_QS_module_pilotSafezone_checkDelay = time + 0;
_QS_module_pilotSafezone_delay = 5;
_QS_module_pilotSafezone_isInSafezone = FALSE;
_QS_pilotBabysitter = TRUE;
_QS_maxTimeOnGround = 600;
_QS_warningTimeOnGround = 180;
_QS_currentTimeOnGround = 0;
_QS_secondsCounter = time + 1;
_QS_afkTimer = 900;
if (_iAmPilot) then {
	_QS_afkTimer = 600;
};
_kicked = FALSE;
_QS_afkTimer_playerThreshold = 40;
_QS_afkTimer_playerPos = _QS_posWorldPlayer;
/*/===== Leaderboards module/*/
_QS_module_leaderboards = TRUE;
_QS_module_leaderboards_delay = 2.5;
_QS_module_leaderboards_checkDelay = _timeNow + _QS_module_leaderboards_delay;
_QS_module_leaderboards_pilots = TRUE;
if (_iAmPilot) then {
	_QS_lbRank = [player,'TRANSPORT'] call (missionNamespace getVariable 'QS_fnc_clientGetLBRank');
	if (_QS_lbRank isEqualTo 9999) then {
		_QS_lbRank = 0;
	};
	player setVariable ['QS_IA_PP',_QS_lbRank,TRUE];
	player setVariable ['QS_IA_PP_loadedAtBase',[],TRUE];
	player setVariable ['QS_IA_PP_loadedAtMission',[],TRUE];
	player setVariable ['QS_IA_PP_loadedInField',[],TRUE];
};
/*/Register collector/*/
[45,[player,_puid]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
/*/===== Difficulties propagation/*/
_QS_reportDifficulty = TRUE;
_QS_reportDifficulty_delay = 25;
_QS_reportDifficulty_checkDelay = _timeNow + _QS_reportDifficulty_delay;
_thermalOptics = ['optic_Nightstalker','optic_tws','optic_tws_mg'];
_hasThermals = ({(_x in _thermalOptics)} count (primaryWeaponItems player)) isEqualTo 0;
player setVariable ['QS_stamina_multiplier',[(isStaminaEnabled player),time],FALSE];
player setVariable [
	'QS_clientDifficulty',
	[
		(isStaminaEnabled player),
		(getCustomAimCoef player),
		(primaryWeapon player),
		_hasThermals,
		cameraView,
		difficultyEnabledRTD,
		isStressDamageEnabled,
		(isAutoTrimOnRTD (vehicle player)),
		(difficultyEnabled 'roughLanding'),
		(difficultyEnabled 'windEnabled')
	],
	TRUE
];
_clientDifficulty = player getVariable 'QS_clientDifficulty';
if (!(_clientDifficulty select 0)) then {
	player setVariable ['QS_stamina_multiplier',[FALSE,(time + 900)],FALSE];
} else {
	if (!((player getVariable 'QS_stamina_multiplier') select 0)) then {
		if (time > ((player getVariable 'QS_stamina_multiplier') select 1)) then {
			player setVariable ['QS_stamina_multiplier',[TRUE,time],FALSE];
		};
	};
};
/*/===== Module animation state manager/*/
_QS_module_animState = FALSE;
_QS_module_animState_delay = 10;
_QS_module_animState_checkDelay = _timeNow + _QS_module_animState_delay;
_QS_animState = '';
/*/===== HUD Manager/*/
_QS_module_manageHUD = TRUE;
_QS_module_manageHUD_delay = 5;
_QS_module_manageHUD_checkDelay = _timeNow + _QS_module_manageHUD_delay;
_QS_module_manageHUD_noRadar = [];
/*/===== Texture manager/*/
_QS_module_texture = TRUE;
_QS_module_texture_delay = 20;
_QS_module_texture_checkDelay = _timeNow + _QS_module_texture_delay;
_myV = objNull;
if (isNil {player getVariable 'QS_ClientUnitInsignia2'}) then {
	player setVariable ['QS_ClientUnitInsignia2','',TRUE];
};
if (isNil {player getVariable 'QS_ClientUTexture2'}) then {
	player setVariable ['QS_ClientUTexture2','',FALSE];
};
if (isNil {player getVariable 'QS_ClientUTexture2_Uniforms2'}) then {
	player setVariable ['QS_ClientUTexture2_Uniforms2',[],FALSE];
};
player setVariable ['QS_ClientVTexture',[_myV,_puid,'',(_timeNow + 5)],TRUE];
/*/===== HandleHeal Handler/*/
_QS_module_handleHeal = TRUE;
_QS_module_handleHeal_delay = 30;
_QS_module_handleHeal_checkDelay = _timeNow + _QS_module_handleHeal_delay;
_QS_handleHeal_unit = objNull;
/*/===== Radio Channel Manager/*/
_QS_module_radioChannelManager = TRUE;
_QS_module_radioChannelManager_delay = 3;
_QS_module_radioChannelManager_checkDelay = _timeNow + _QS_module_radioChannelManager_delay;
_QS_module_radioChannelManager_primaryChannel = 3;
_QS_module_radioChannelManager_nearPrimary = FALSE;
_QS_module_radioChannelManager_nearPrimaryRadius = 2000;
_QS_module_radioChannelManager_secondaryChannel = 4;
_QS_module_radioChannelManager_nearSecondary = FALSE;
_QS_module_radioChannelManager_nearSecondaryRadius = 1000;
_QS_module_radioChannelManager_commandChannel = -1;
_QS_module_radioChannelManager_notPilot = ((!(player getUnitTrait 'QS_trait_pilot')) && (!(_QS_isUAVOperator)) && (!(player getUnitTrait 'QS_trait_HQ')));
_QS_module_radioChannelManager_aircraftChannel = 2;
_QS_module_radioChannelManager_checkState = {
	params ['_atcMarkerPos','_tocMarkerPos'];
	private _c = FALSE;
	if ((player distance2D _atcMarkerPos) < 12) then {
		if (((getPosATL player) select 2) > 5) then {
			if (isNull (objectParent player)) then {
				_c = TRUE;
			};
		};
	};
	if ((player distance2D _tocMarkerPos) < 10) then {
		if (((getPosATL player) select 2) < 7) then {
			if (isNull (objectParent player)) then {
				_c = TRUE;
			};
		};
	};
	_c;
};
_atcMarkerPos = markerPos 'QS_marker_base_atc';
_tocMarkerPos = markerPos 'QS_marker_base_toc';
/*/===== Weapon Sway module/*/
_QS_module_swayManager = TRUE;
_QS_module_swayManager_delay = 0.25;
_QS_module_swayManager_checkDelay = _timeNow + _QS_module_swayManager_delay;
_QS_module_swayManager_secWepSwayCoef = 2.25;
_QS_module_swayManager_isAT = (((toLower _playerClass) in ['b_t_recon_lat_f','b_t_soldier_at_f','b_recon_lat_f','b_soldier_at_f']) || (player getUnitTrait 'QS_trait_AT'));
_QS_module_swayManager_heavyWeapons = [
	"srifle_gm6_f","srifle_gm6_lrps_f","srifle_gm6_sos_f","srifle_lrr_f","srifle_lrr_lrps_f","srifle_lrr_sos_f","srifle_gm6_camo_f",
	"srifle_gm6_camo_lrps_f","srifle_gm6_camo_sos_f","srifle_lrr_camo_f","srifle_lrr_camo_lrps_f","srifle_lrr_camo_sos_f",
	"srifle_lrr_tna_f","srifle_gm6_ghex_f","srifle_lrr_tna_lrps_f","srifle_gm6_ghex_lrps_f","mmg_01_base_f","mmg_01_hex_arco_lp_f",
	"mmg_01_hex_f","mmg_01_tan_f","mmg_02_base_f","mmg_02_black_f","mmg_02_black_rco_bi_f","mmg_02_camo_f","mmg_02_sand_f","mmg_02_sand_rco_lp_f"
];
_QS_module_swayManager_heavyWeaponCoef_crouch = 1.2;
_QS_module_swayManager_heavyWeaponCoef_stand = 1.5;
_QS_module_swayManager_recoilCoef_crouch = 1.2;
_QS_module_swayManager_recoilCoef_stand = 1.5;
_QS_customAimCoef = getCustomAimCoef player;
_QS_recoilCoef = unitRecoilCoefficient player;
/*/===== Task Manager module/*/
_QS_module_taskManager = TRUE;
_QS_module_taskManager_delay = 15;
_QS_module_taskManager_checkDelay = -1;
_QS_module_taskManager_simpleTasks = [];
_QS_module_taskManager_currentTask = taskNull;
/*/===== Module Reveal Players/*/
_QS_module_revealPlayers = TRUE;
_QS_module_revealPlayers_delay = 15;
_QS_module_revealPlayers_checkDelay = _timeNow + _QS_module_revealPlayers_delay;
/*/===== Module SC Assistant/*/
_QS_module_scAssistant = TRUE;
_QS_module_scAssistant_delay = 2.49;
_QS_module_scAssistant_checkDelay = _QS_uiTime + _QS_module_scAssistant_delay;
_sectorFlag = objNull;
_sectorPhase = 0;
_QS_virtualSectors_data_public = [];
/*/===== Module Tanoa (Georgetown, Kavala, etc)/*/
_QS_isTanoa = FALSE;
if (_QS_worldName in ['Altis','Tanoa']) then {
	_QS_isTanoa = TRUE;	/*/ whatever /*/
	_QS_tanoa_delay = 5;
	_QS_tanoa_checkDelay = _QS_uiTime + _QS_tanoa_delay;
	_QS_inGeorgetown = FALSE;
	_QS_georgetown_polygon = [
		[[3481.62,13370.2,0],[3577.57,13285.5,0],[3664.88,13279.3,0],[3625.13,13136.5,0],[3614.42,12940.3,0],[3543.96,12859.9,0],[3446.32,12885.4,0],[3395.27,12872.1,0],[3267.38,13073.3,0],[3266.97,13184.7,0]],
		[[5588.88,10242.2,4.16775],[5807.1,10171,0.00125599],[5895.19,10388.9,0.0247574],[5844.87,10701.6,0.110656],[5724.18,10706,0.00174642],[5634.55,10656.1,8.57687]]
	] select (_QS_worldName isEqualTo 'Tanoa');
	_QS_georgetown_priorVD = viewDistance;
	_QS_georgetown_priorOVD = getObjectViewDistance select 0;
	_QS_georgetown_VD = 500;
	_QS_georgetown_OVD = 500;
};
/*/===== Module Group Indicator/*/
_QS_module_groupIndicator = TRUE;
_QS_module_groupIndicator_delay = 0.5;
_QS_module_groupIndicator_checkDelay = _QS_uiTime + _QS_module_groupIndicator_delay;
_QS_module_groupIndicator_radius = 45;
_QS_module_groupIndicator_types = ['CAManBase'];
_QS_module_groupIndicator_units = [];
_QS_module_groupIndicator_filter = {((alive _x) && ((group _x) isEqualTo (group player)))};
_posATLPlayer = getPosATL player;
missionNamespace setVariable ['QS_client_groupIndicator_units',[],FALSE];
/*/===== Medic Icons/*/
_QS_medicIcons_radius = 500;
_QS_medicIcons_delay = 10;
_QS_medicIcons_checkDelay = _QS_uiTime + _QS_medicIcons_delay;
/*/===== Client AI/*/
_QS_module_clientAI = TRUE;
_QS_module_clientAI_script = scriptNull;
_QS_module_clientAI_delay = 10;
_QS_module_clientAI_checkDelay = _QS_uiTime + _QS_module_clientAI_delay;
/*/===== Operational Security Module - will detect some low-hanging fruit. To date it has caught around 30 cheaters./*/
_QS_productVersionSync = ((_QS_productVersion select 2) isEqualTo (call (missionNamespace getVariable 'QS_fnc_getAHCompat')));
_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
if (_QS_module_opsec) then {
	_QS_module_opsec_delay = 15;
	_QS_module_opsec_checkDelay = _timeNow + _QS_module_opsec_delay;
	_QS_module_opsec_recoilSway = TRUE;											/*/ check recoil and sway and anim speed /*/
	_QS_module_opsec_hidden = TRUE;												/*/ check hidden /*/
	_QS_module_opsec_menus = TRUE;												/*/ check menus /*/
	_QS_module_opsec_vars = FALSE;												/*/ check variables /*/
	_QS_module_opsec_patches = _QS_productVersionSync;							/*/ check patches /*/
	_QS_module_opsec_checkScripts = FALSE;										/*/ check scripts /*/
	_QS_module_opsec_checkActions = TRUE;										/*/ check action menu /*/
	_QS_module_opsec_checkMarkers = FALSE;										/*/ check map markers /*/
	_QS_module_opsec_chatIntercept = TRUE;										/*/ check chat box /*/
	_QS_module_opsec_memory = _QS_productVersionSync;								/*/ check memory editing /*/
	_QS_module_opsec_memoryMission = TRUE;										/*/ check memory editing of mission displays /*/
	_QS_module_opsec_iguiDisplays = _QS_productVersionSync;						/*/ check memory editing of igui displays/*/
	_QS_module_opsec_rsctitles = _QS_productVersionSync;							/*/ check memory editing of titles /*/
	_QS_module_opsec_rsctitlesMission = TRUE;									/*/ check memory editing of titles (mission)/*/
	_QS_module_opsec_detected = 0;
	_detected = '';
	_QS_module_opsec_chatIntercept_IDD = 24;
	_QS_module_opsec_chatIntercept_IDC = 101; 
	_QS_module_opsec_chatIntercept_script = scriptNull;
	_QS_module_opsec_chatIntercept_code = {
		disableSerialization;
		params ['_display','_fn_inString'];
		_display = _this select 0;
		scriptName 'QS OPSEC Chat Intercept';
		private _allControls = allControls _display;
		private _chatCtrl = _display displayCtrl 101;
		private _chatText = toLower (ctrlText _chatCtrl);
		private _chatTextLower = '';
		private _maxCharacters = 140;
		for '_x' from 0 to 1 step 0 do {
			if (isNull (findDisplay 24)) exitWith {};
			_allControls = allControls _display;
			if ((count _allControls) > 2) then {
				comment 'Too many controls';
				if (!isNull (findDisplay 24)) then {
					(findDisplay 24) closeDisplay 2;
				};
			};
			if (isNull (findDisplay 24)) exitWith {};
			_chatText = ctrlText ((findDisplay 24) displayCtrl 101);
			_chatTextLower = toLower _chatText;
			if ((count _chatText) > _maxCharacters) then {
				comment 'Too many characters';
				50 cutText [(format ['Character limit (140) exceeded',(count _chatText),_maxCharacters]),'PLAIN DOWN',1];
				((findDisplay 24) displayCtrl 101) ctrlSetText (_chatText select [0,140]);
			};
			if ([_chatTextLower,0,_fn_inString] call (missionNamespace getVariable 'QS_fnc_ahScanString')) then {
				comment 'Blacklisted string in chat';
				if (!isNull (findDisplay 24)) then {
					(findDisplay 24) closeDisplay 2;
				};
			};
			if (!('ItemRadio' in (assignedItems player))) then {
				if (!(currentChannel isEqualTo 5)) then {
					50 cutText ['You need a radio to use the radio channels!','PLAIN DOWN',1];
					if (!isNull (findDisplay 24)) then {
						(findDisplay 24) closeDisplay 2;
					};
				};
			};
			if (isNull (findDisplay 24)) exitWith {};
			uiSleep 0.001;
		};
	};
	_QS_module_opsec_memDelay = 60;	/*/360/*/
	_QS_module_opsec_memCheckDelay = _timeNow + _QS_module_opsec_memDelay;
	_QS_module_opsec_memCheck_script = {
		scriptName 'QS OPSEC - 3';
		private ['_QS_module_opsec_detected','_detected','_onLoad','_onUnload','_canSuspend','_type'];
		_type = _this select 0;
		_QS_module_opsec_detected = 0;
		_detected = '';
		_canSuspend = canSuspend;
		if (_type isEqualTo 'RscDisplay') then {
			{
				_onLoad = toArray (getText (configFile >> (_x select 1) >> 'onLoad'));
				if ((!(_onLoad isEqualTo (_x select 2))) && (!(_onLoad isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified Display Method OL: %1 (Memory Hack)',(_x select 1)];
				};
				_onUnload = toArray (getText (configFile >> (_x select 1) >> 'onUnload'));
				if ((!(_onUnload isEqualTo (_x select 3))) && (!(_onUnload isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified Display Method OUL: %1 (Memory Hack)',(_x select 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.005;
				};
			} forEach (_this select 5);
		};
		if (_type isEqualTo 'IGUIDisplay') then {
			{
				_onLoad = toArray (getText (configFile >> 'RscInGameUI' >> (_x select 1) >> 'onLoad'));
				if ((!(_onLoad isEqualTo (_x select 2))) && (!(_onLoad isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					if (['RscUnitInfoAirRTDFullDigital',(_x select 1),FALSE] call _fn_inString) then {
						_QS_module_opsec_detected = 1;
					};
					_detected = format ['Modified IGUI Method OL: %1 (Memory Hack)',(_x select 1)];
				};
				_onUnload = toArray (getText (configFile >> 'RscInGameUI' >> (_x select 1) >> 'onUnload'));
				if ((!(_onUnload isEqualTo (_x select 3))) && (!(_onUnload isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					if (['RscUnitInfoAirRTDFullDigital',(_x select 1),FALSE] call _fn_inString) then {
						_QS_module_opsec_detected = 1;
					};
					_detected = format ['Modified IGUI Method OUL: %1 (Memory Hack)',(_x select 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this select 5);		
		};
		if (_type isEqualTo 'MissionDisplay') then {
			{
				_onLoad = toArray (getText (missionConfigFile >> (_x select 1) >> 'onLoad'));
				if ((!(_onLoad isEqualTo (_x select 2))) && (!(_onLoad isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified MissionDisplay Method OL: %1 (Memory Hack)',(_x select 1)];
				};
				_onUnload = toArray (getText (missionConfigFile >> (_x select 1) >> 'onUnload'));
				if ((!(_onUnload isEqualTo (_x select 3))) && (!(_onUnload isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified MissionDisplay Method OUL: %1 (Memory Hack)',(_x select 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this select 5);		
		};
		if (_type isEqualTo 'RscTitles') then {
			{
				_onLoad = toArray (getText (configFile >> 'RscTitles' >> (_x select 1) >> 'onLoad'));
				if ((!(_onLoad isEqualTo (_x select 2))) && (!(_onLoad isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OL: %1 (Memory Hack)',(_x select 1)];
				};
				_onUnload = toArray (getText (configFile >> 'RscTitles' >> (_x select 1) >> 'onUnload'));
				if ((!(_onUnload isEqualTo (_x select 3))) && (!(_onUnload isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OUL: %1 (Memory Hack)',(_x select 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this select 5);
		};
		if (_type isEqualTo 'MissionTitles') then {
			{
				_onLoad = toArray (getText (missionConfigFile >> 'RscTitles' >> (_x select 1) >> 'onLoad'));
				if ((!(_onLoad isEqualTo (_x select 2))) && (!(_onLoad isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OL: %1 (Memory Hack)',(_x select 1)];
				};
				_onUnload = toArray (getText (missionConfigFile >> 'RscTitles' >> (_x select 1) >> 'onUnload'));
				if ((!(_onUnload isEqualTo (_x select 3))) && (!(_onUnload isEqualTo ''))) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OUL: %1 (Memory Hack)',(_x select 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this select 5);		
		};
		if (!(_QS_module_opsec_detected isEqualTo 0)) then {
			[
				40,
				[
					time,
					serverTime,
					(_this select 1),
					(_this select 2),
					(_this select 3),
					(_this select 4),
					_QS_module_opsec_detected,
					_detected,
					player
				]
			] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
		[_QS_module_opsec_detected,_detected];
	};
	_opsec_actionWhitelist = [] call (missionNamespace getVariable 'QS_data_actions');
	_QS_module_opsec_displays_default = ['Display #0','Display #8','Display #18','Display #70','Display #46','Display #12','Display #313'];
	if (_puid in (['DEVELOPER'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		{
			_QS_module_opsec_displays_default pushBack _x;
		} forEach [
			'Display #15000'
		];
	};
	if (_puid in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		{
			_QS_module_opsec_displays_default pushBack _x;
		} forEach [
			'Display #312'
		];
	};
	_QS_module_opsec_displays = [
		['BIS_fnc_arsenal_display','RscDisplayArsenal',0],
		[3030,'BIS_configviewer_display',0],
		[2928,'RscDisplayConfigViewer',0],
		['RscDisplayMultiplayer','RscDisplayMultiplayer',0],
		[17,'RscDisplayRemoteMissions',0],
		[56,'RscDisplayDebug',0],
		[316000,'RscDisplayDebugPublic',0],
		[125,'RscDisplayEditDiaryRecord',0],
		[69,'RscDisplayPort',0],
		[19,'RscDisplayIPAddress',0],
		[71,'RscDisplayFilter',0],
		[45,'UnknownDisplay',0],
		[132,'RscDisplayHostSettings',0],
		[32,'RscDisplayIntel',0],
		[2727,'RscDisplayLocWeaponInfo',0],
		['RscDisplayMovieInterrupt','RscDisplayMovieInterrupt',0],
		[157,'UnknownDisplay',0],
		[30,'RscDisplayTemplateLoad',0],
		[166,'RscDisplayPublishMissionSelectTags',0],
		[167,'RscDisplayFileSelect',0],
		[314,'RscDisplayCamera',0],
		[164,'RscDisplayChooseEditorLayout',0],
		[64,'RscDisplayPassword',0],
		[456,'DisplayTest',0],
		[313,'Display3DEN',0],
		[319,'Display3DENCopy',0],
		[315,'Display3DENEditAttributes',0],
		[317,'Display3DENEditComposition',0],
		[316,'Display3DENNew',0],
		[321,'Display3DENPlace',0],
		[165,'display3DENPublishMission',0],
		[167,'display3DENPublishMissionSelectImage',0],
		[166,'display3DENPublishMissionSelectTags',0],
		[320,'Display3DENRename',0],
		[322,'Display3DENRequiredAddons',0],
		[318,'Display3DENTutorial',0],
		[330,'Display3DENUpdates',0]
	];
	_allDisplays = allDisplays;
	_commandingMenu = '';
	_validCommMenus = [
		"RscMainMenu","RscMoveHigh","#WATCH","#WATCH0","RscWatchDir","RscWatchMoveDir","#GETIN","#RscStatus","RscCallSupport","#ACTION",
		"RscCombatMode","RscFormations","RscTeam","RscSelectTeam","RscReply","#User:BIS_Menu_GroupCommunication","#CUSTOM_RADIO",
		"RscRadio","RscGroupRootMenu","RscMenuReply","RscMenuStatus","","#User:BIS_fnc_addCommMenuItem_menu","RscMenuMove","RscMenuFormations",
		"#GET_IN","#GET_IN371","RscMenuCombatMode","#WATCH712","RscMenuEngage","#GET_INT0","#WATCH95",'#ACTION16','RscMenuTeam','#GET_IN52','RscMenuWatchDir','RscMenuWatchMoveDir',
		'RscBurst','#ARTILLERY','RscMenuSelectTeam'
	];
	_QS_module_opsec_memArray = [0] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayIGUI = [1] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayMission = [2] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayTitles = [3] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayTitlesMission = [4] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	if (_QS_module_opsec_patches) then {
		_patchList = [] call (missionNamespace getVariable 'QS_data_patches');
		_binConfigPatches = configFile >> 'CfgPatches';
		for '_i' from 0 to ((count _binConfigPatches) - 1) step 1 do {
			_patchEntry = _binConfigPatches select _i;
			if (isClass _patchEntry) then {
				if (!((configName _patchEntry) in _patchList)) then {
					if ((!(['jsrs',(configName _patchEntry),FALSE] call _fn_inString)) && (!(['jpex',(configName _patchEntry),FALSE] call _fn_inString))) then {
						if (!(['blastcore',(configName _patchEntry),FALSE] call _fn_inString)) then {
							if (!(['aegis',(configName _patchEntry),FALSE] call _fn_inString)) then {
								_detected = format ['Unknown Addon Patch: %1',(configName _patchEntry)];
								_QS_module_opsec_detected = 1;
							};
						};
					};
				};
			};
		};
		_binConfigPatches = nil;
		_patchEntry = nil;
		_patchList = nil;
	};
	{
		uiNamespace setVariable [_x,nil];
	} forEach [
		'RscDisplayRemoteMissions',
		'RscDisplayDebugPublic',
		'RscDisplayMovieInterrupt',
		'RscDisplayArsenal',
		'RscDisplayMultiplayer'
	];
	_children = [(configFile >> 'RscDisplayMPInterrupt' >> 'controls'),0] call (missionNamespace getVariable 'BIS_fnc_returnChildren');
	_allowedChildren = [
		'Title','MissionTitle','DifficultyTitle','PlayersName','ButtonCancel','ButtonSAVE','ButtonSkip','ButtonRespawn','ButtonOptions',
		'ButtonVideo','ButtonAudio','ButtonControls','ButtonGame','ButtonTutorialHints','ButtonAbort','DebugConsole','Feedback','MessageBox',
		'CBA_CREDITS_M_P','CBA_CREDITS_CONT_C','Version','TrafficLight','TraffLight'
	];
	{
		_child = _x;
		if (!((configName _x) in _allowedChildren)) exitWith {
			_QS_module_opsec_detected = 1;
			_detected = _child;
		};
	} forEach _children;
	_allowedChildren = nil;
	_children = nil;
	if (!((toLower (getText (configFile >> 'CfgFunctions' >> 'init'))) isEqualTo 'a3\functions_f\initfunctions.sqf')) then {
		_QS_module_opsec_detected = 2;
		_detected = format ['Modified_Functions_Init: %1',(getText (configFile >> 'CfgFunctions' >> 'init'))];
	};
	_bis_fnc_diagkey = uiNamespace getVariable ['BIS_fnc_diagKey',{FALSE}];
	if (!isNil '_bis_fnc_diagkey') then {
		if !((str _bis_fnc_diagkey) in ['{false}','{}']) then {
			_QS_module_opsec_detected = 2;
			_detected = 'BIS_fnc_DiagKey';
		};
	};
	{
		if (!((profileNamespace getVariable [_x,0]) isEqualType 0)) then {
			profileNamespace setVariable [_x,0.4];
			_QS_module_opsec_detected = 2;
			_detected = _x;
		};
	} forEach [
		'igui_bcg_rgb_a','igui_bcg_rgb_r','igui_bcg_rgb_g','igui_bcg_rgb_b','IGUI_grid_mission_X',
		'IGUI_grid_mission_Y','IGUI_grid_mission_W','IGUI_grid_mission_H'
	];
	_QS_module_opsec_memCheck_WorkingArray = [];
	if (_QS_module_opsec_memory) then {
		['RscDisplay',_namePlayer,_profileName,_profileNameSteam,_puid,_QS_module_opsec_memArray] spawn _QS_module_opsec_memCheck_script;
		_QS_module_opsec_memCheck_WorkingArray pushBack ['RscDisplay',_QS_module_opsec_memArray];
	};
	if (_QS_module_opsec_memoryMission) then {
		['MissionDisplay',_namePlayer,_profileName,_profileNameSteam,_puid,_QS_module_opsec_memArrayMission] spawn _QS_module_opsec_memCheck_script;
		_QS_module_opsec_memCheck_WorkingArray pushBack ['MissionDisplay',_QS_module_opsec_memArrayMission];
	};
	if (_QS_module_opsec_iguiDisplays) then {
		['IGUIDisplay',_namePlayer,_profileName,_profileNameSteam,_puid,_QS_module_opsec_memArrayIGUI] spawn _QS_module_opsec_memCheck_script;
		_QS_module_opsec_memCheck_WorkingArray pushBack ['IGUIDisplay',_QS_module_opsec_memArrayIGUI];
	};
	if (_QS_module_opsec_rsctitles) then {
		['RscTitles',_namePlayer,_profileName,_profileNameSteam,_puid,_QS_module_opsec_memArrayTitles] spawn _QS_module_opsec_memCheck_script;
		_QS_module_opsec_memCheck_WorkingArray pushBack ['RscTitles',_QS_module_opsec_memArrayTitles];
	};
	if (_QS_module_opsec_rsctitlesMission) then {
		['MissionTitles',_namePlayer,_profileName,_profileNameSteam,_puid,_QS_module_opsec_memArrayTitlesMission] spawn _QS_module_opsec_memCheck_script;
		_QS_module_opsec_memCheck_WorkingArray pushBack ['MissionTitles',_QS_module_opsec_memArrayTitlesMission];
	};
	if (!(_QS_module_opsec_detected isEqualTo 0)) then {
		[
			40,
			[
				time,
				serverTime,
				_namePlayer,
				_profileName,
				_profileNameSteam,
				_puid,
				_QS_module_opsec_detected,
				_detected,
				player
			]		
		] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
};
/*/===== Markers around base/*/
_baseMarkers = [
	'QS_marker_airbaseDefense',
	'QS_marker_airbaseArtillery',
	'QS_marker_casJet_spawn',
	'QS_marker_crate_area',
	'QS_marker_heli_spawn',
	'QS_marker_veh_spawn',
	'QS_marker_side_rewards',
	'QS_marker_veh_baseservice_01',
	'QS_marker_veh_baseservice_02',
	'QS_marker_veh_baseservice_03',
	'QS_marker_gitmo',
	'QS_marker_medevac_hq',
	'QS_marker_base_toc',
	'QS_marker_base_atc',
	'QS_marker_veh_inventoryService_01',
	'QS_marker_veh_fieldservice_04',
	'QS_marker_veh_fieldservice_01'
];
/*/========== UI loading/*/
{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"],
	['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];
0 spawn {
	scriptName 'QS - Add KeyDown Event';
	if (!isNil {missionNamespace getVariable 'QS_uiEvent_magRepack'}) then {
		(findDisplay 46) displayRemoveEventHandler ['KeyDown',(missionNamespace getVariable 'QS_uiEvent_magRepack')];
		systemChat 'Magazine repack detected, mod terminated';
	};
	for '_x' from 0 to 1 step 0 do {
		_ID1 = (findDisplay 46) displayAddEventHandler ['KeyDown',{_this call (missionNamespace getVariable 'QS_fnc_clientEventKeyDown')}];
		_ID2 = (findDisplay 46) displayAddEventHandler ['KeyUp',{_this call (missionNamespace getVariable 'QS_fnc_clientEventKeyUp')}];
		if (!(_ID1 isEqualTo -1)) exitWith {
			missionNamespace setVariable ['QS_client_keyEvents',[_ID1,_ID2],FALSE];
		};
		uiSleep 1;
	};
};
player setVariable ['BIS_dg_ini',TRUE,TRUE];
/*/
if (((leader (group player)) isEqualTo player) && (!(['IsGroupRegistered',[group player]] call (missionNamespace getVariable 'BIS_fnc_dynamicGroups')))) then {
	['SendClientMessage',['RegisterGroup', [group player, player]]] call (missionNamespace getVariable 'BIS_fnc_dynamicGroups');
};
/*/
[''] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
/*/========== Transfer third-party loadouts to Arsenal/*/
[] spawn (missionNamespace getVariable 'QS_fnc_clientVAS2VA');
/*/===== Generate client owner ID/*/
for '_x' from 0 to 1 step 1 do {
	player setVariable ['QS_clientOwner',clientOwner,TRUE];
};
if (_puid in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	0 spawn {
		scriptName 'QS - Connect to Curator';
		[27,player,(getPlayerUID player),clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		uiSleep 10;
		if (isNull (getAssignedCuratorLogic player)) then {
			for '_x' from 0 to 2 step 1 do {
				if (!isNull (getAssignedCuratorLogic player)) exitWith {};
				[27,player,(getPlayerUID player),clientOwner] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				uiSleep 5;
			};
			if (isNull (getAssignedCuratorLogic player)) exitWith {systemChat 'Curator Module initialization failed. Please abort to lobby and reconnect';};
		};
	};
};
if (!((damage player) isEqualTo 0)) then {
	player setDamage [0,FALSE];
};
/*/===== Entry Dialog/*/
[(((player getVariable _QS_viewSettings_var) select 0) select 0)] spawn {
	scriptName 'QS - Ramp View Distance';
	_targetViewDistance = _this select 0;
	for '_x' from 0 to 1 step 0 do { 
		setViewDistance (viewDistance + 1);
		uiSleep 0.004;
		if (viewDistance >= _targetViewDistance) exitWith {};
	};
};
endLoadingScreen;
/*/===== Set Player Position/*/
_position = AGLToASL (markerPos 'QS_marker_base_marker');
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (_QS_worldName isEqualTo 'Altis') then {
		_position = [((_position select 0) + 10 - (random 20)),((_position select 1) + 10 - (random 20)),(_position select 2)];
	};
	if (_QS_worldName isEqualTo 'Tanoa') then {
		_position = [((_position select 0) + 6 - (random 12)),((_position select 1) + 6 - (random 12)),(_position select 2)];
	};
	if (_QS_worldName isEqualTo 'Malden') then {
		_position = selectRandom (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingPos -1);
		_position = AGLToASL _position;
		player setDir (_position getDir (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingExit 0));
	};
};
if (!(simulationEnabled player)) then {
	player enableSimulation TRUE;
};
waitUntil {
	uiSleep 0.01;
	(preloadCamera _position) ||
	(time > (_timeNow + 3))
};
player setPosWorld _position;
if ((damage player) > 0) then {
	player setDamage [0,FALSE];
};
call (missionNamespace getVariable 'QS_fnc_respawnPilot');
[(((player getVariable _QS_viewSettings_var) select 1) select 0),_position,_QS_viewSettings_var] spawn {
	_position = _this select 1;
	_QS_viewSettings_var = _this select 2;
	scriptName 'QS - Ramp Object View Distance';
	private _timeout = diag_tickTime + 1;
	waitUntil {
		uiSleep 0.01;
		(diag_tickTime > _timeout)
	};
	uiSleep 0.01;
	_soundVolume = soundVolume;
	1 fadeSound (_soundVolume / 2);
	_targetObjectViewDistance = ((player getVariable _QS_viewSettings_var) select 1) select 0;
	startLoadingScreen [''];
	_t = diag_tickTime + 60;
	private _currentObjectViewDistance = getObjectViewDistance select 0;
	for '_x' from 0 to 1 step 0 do {
		_currentObjectViewDistance = getObjectViewDistance select 0;
		setObjectViewDistance ((getObjectViewDistance select 0) + 1);
		if ((getObjectViewDistance select 0) isEqualTo _currentObjectViewDistance) exitWith {};
		progressLoadingScreen ((getObjectViewDistance select 0) / _targetObjectViewDistance);
		uiSleep 0.004;
		if ((getObjectViewDistance select 0) >= _targetObjectViewDistance) exitWith {};
		if (diag_tickTime > _t) exitWith {};
	};
	endLoadingScreen;
	50 cutText ['','BLACK IN',1,TRUE];
	1 fadeSound _soundVolume;
	uiSleep 0.01;
	player switchMove '';
	createDialog 'QS_RD_client_dialog_menu_entry';
};
uiSleep 0.25;
0 spawn (missionNamespace getVariable 'QS_fnc_clientMissionStatus');

/*/===== Misc 5 second delay/*/
_QS_miscDelay5 = _QS_uiTime + 60;
_QS_module_soundControllers = TRUE;
_QS_module_soundControllers_delay = 5;
_QS_module_soundControllers_checkDelay = _QS_uiTime + _QS_module_soundControllers_delay;
/*/===== Comm Menu module/*/
_QS_module_commMenu = FALSE;
_QS_module_commMenu_delay = 0.1;
_QS_module_commMenu_checkDelay = _QS_uiTime + _QS_module_commMenu_delay;
/*/===== Player Area/*/
_QS_module_playerInArea = TRUE;
_QS_module_playerInArea_delay = 10;
_QS_module_playerInArea_checkDelay = _QS_uiTime + _QS_module_playerInArea_delay;
/*/===== Managed Hints/*/
_hintsQueue = [];
_hintData = [];
_hintDelay = 1;
_hintCheckDelay = _QS_uiTime + _hintDelay;
_hintActive = FALSE;
_hintActiveDuration = 0;
_hintPriority = 0;
_hintUseSound = FALSE;
_hintDuration = 0;
_hintPreset = -1;
_hintText = '';
_hintTextPrevious = '';
_hintOtherData = [];
_hintIrrelevantWhen = 0;
_hintPriorClosedAt = -1;
/*/===== Functions Preload/*/
_fn_getCustomCargoParams = missionNamespace getVariable 'QS_fnc_getCustomCargoParams';
_fn_clientInteractUGV = missionNamespace getVariable 'QS_fnc_clientInteractUGV';
_fn_clientRadio = missionNamespace getVariable 'QS_fnc_clientRadio';
_fn_clientGetDoorPhase = missionNamespace getVariable 'QS_fnc_clientGetDoorPhase';
_fn_vTowable = missionNamespace getVariable 'QS_fnc_vTowable';
_fn_isValidCargoV = missionNamespace getVariable 'QS_fnc_isValidCargoV';
_fn_showNotification = missionNamespace getVariable 'QS_fnc_showNotification';
_fn_clientSetUnitInsignia = missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia';
_fn_clientAIBehaviours = missionNamespace getVariable 'QS_fnc_clientAIBehaviours';
_fn_ARRappelFromHeliActionCheck = missionNamespace getVariable 'AR_Rappel_From_Heli_Action_Check';
_fn_ARRappelAIUnitsFromHeliActionCheck = missionNamespace getVariable 'AR_Rappel_AI_Units_From_Heli_Action_Check';
_fn_AIRappelDetachActionCheck = missionNamespace getVariable 'AR_Rappel_Detach_Action_Check';
_fn_uidStaff = missionNamespace getVariable 'QS_fnc_whitelist';
_fn_data_carrierLaunch = call (missionNamespace getVariable 'QS_data_carrierLaunch');
_fn_carrier = missionNamespace getVariable 'QS_fnc_carrier';
_fn_clientHintPresets = missionNamespace getVariable 'QS_fnc_clientHintPresets';
_fn_secondsToString = missionNamespace getVariable 'BIS_fnc_secondsToString';
_fn_gearRestrictions = missionNamespace getVariable 'QS_fnc_gearRestrictions';
/*/================================================================================================================= LOOP/*/
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_QS_uiTime = diag_tickTime;
	_serverTime = serverTime;
	if (!(_QS_player isEqualTo player)) then {
		_QS_player = player;
	};
	_QS_posWorldPlayer = getPosWorld _QS_player;
	_posATLPlayer = getPosATL _QS_player;
	if (!(_QS_cO isEqualTo cameraOn)) then {
		_QS_cO = cameraOn;
	};
	if (!(_QS_v2 isEqualTo (vehicle _QS_player))) then {
		_QS_v2 = vehicle _QS_player;
		_QS_v2Type = typeOf _QS_v2;
		_QS_v2TypeL = toLower _QS_v2Type;
	};
	if (!(_objectParent isEqualTo (objectParent _QS_player))) then {
		_objectParent = objectParent _QS_player;
	};
	missionNamespace setVariable ['QS_client_heartbeat',_timeNow,FALSE];
	if (_QS_module_menues) then {
		if (dialog) then {
			if (!(_mainMenuOpen)) then {
				if (!isNull (findDisplay _mainMenuIDD)) then {
					_mainMenuOpen = TRUE;
				};
			} else {
				if (isNull (findDisplay _mainMenuIDD)) then {
					_mainMenuOpen = FALSE;
				} else {
					_QS_clientHp = round ((1 - (damage _QS_player)) * (10 ^ 2));
					_QS_clientMass = (loadAbs _QS_player) / 10;
					if (_timeNow > _QS_fpsCheckDelay) then {
						_QS_fpsLastPull = round diag_fps;
						_QS_fpsCheckDelay = _timeNow + _QS_fpsDelay;
					};
					((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetToolTip 'FPS, Time to server restart (estimated)';
					((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetText format ['FPS: %1 | Restart: %2h',_QS_fpsLastPull,([(estimatedEndServerTime - _serverTime),'HH:MM'] call _fn_secondsToString)];
					_QS_clientScore = score _QS_player;
					_QS_rating = rating _QS_player;
					((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetToolTip 'Score, Rating, Health, Equipment';
					((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetText format ['Score: %1 | Rating: %2 | Hp: %3 | Load: %4/100',_QS_clientScore,_QS_rating,_QS_clientHp,_QS_clientMass];
				};
			};
			if (!(_viewMenuOpen)) then {
				if (!isNull (findDisplay _viewMenuIDD)) then {
					_viewMenuOpen = TRUE;
				};
			} else {
				if (isNull (findDisplay _viewMenuIDD)) then {
					_viewMenuOpen = FALSE;
				} else {
					((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetToolTip 'FPS, Time to server restart (estimated)';
					((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetText format ['FPS: %1 | Restart: %2h',_QS_fpsLastPull,([(estimatedEndServerTime - _serverTime),'HH:MM'] call _fn_secondsToString)];
				};
			};
		};
	};
	
	if (_QS_module_liveFeed) then {
		if (_timeNow > _QS_module_liveFeed_checkDelay) then {
			if (!isNil {_QS_player getVariable 'QS_RD_client_liveFeed'}) then {
				if ((_QS_player getVariable 'QS_RD_client_liveFeed') isEqualType TRUE) then {
					if (_QS_player getVariable 'QS_RD_client_liveFeed') then {
						if (isPipEnabled) then {
							_QS_liveFeed_display = missionNamespace getVariable ['QS_Billboard_02',objNull];
							if (!isNull _QS_liveFeed_display) then {
								if ((_QS_player distance _QS_liveFeed_display) < 30) then {
									_QS_liveFeed_vehicle = missionNamespace getVariable ['QS_RD_liveFeed_vehicle',objNull];
									if (_QS_liveFeed_vehicle isEqualType objNull) then {
										if (!isNull _QS_liveFeed_vehicle) then {
											if (alive _QS_liveFeed_vehicle) then {
												if (!(_QS_liveFeed_vehicle isEqualTo _QS_liveFeed_vehicle_current)) then {
													_QS_liveFeed_vehicle_current = _QS_liveFeed_vehicle;
													if (_QS_liveFeed_vehicle isKindOf 'Man') then {
														_QS_liveFeed_camera attachTo [(missionNamespace getVariable 'QS_RD_liveFeed_neck'),[0.25,-0.10,0.05]];
													} else {
														_QS_liveFeed_camera attachTo [(missionNamespace getVariable 'QS_RD_liveFeed_neck'),[2,-4,2]];
													};
													_QS_liveFeed_camera cameraEffect ['Internal','Back','qs_rd_lfe'];
													_QS_liveFeed_camera camSetTarget (missionNamespace getVariable 'QS_RD_liveFeed_target');
													_QS_liveFeed_display setObjectTexture [0,'#(argb,512,512,1)r2t(qs_rd_lfe,1)'];
													if (sunOrMoon < 0.25) then {
														'qs_rd_lfe' setPiPEffect [1];
													} else {
														'qs_rd_lfe' setPiPEffect [0];
													};
													_QS_liveFeed_camera camCommit 1;
													_screenPos = worldToScreen _displayPos;
													if (!(_screenPos isEqualTo [])) then {
														if (isNull (objectParent _QS_player)) then {
															[format [_QS_liveFeed_text + ' %1',(name (effectiveCommander _QS_liveFeed_vehicle_current))],((_screenPos select 0) - 0.25),((_screenPos select 1) + 0.1),2.75,0.25] spawn (missionNamespace getVariable 'BIS_fnc_dynamicText');
														};
													};
												};
											} else {
												_QS_liveFeed_display setObjectTexture [0,_QS_module_liveFeed_noSignalFile];
											};
										} else {
											_QS_liveFeed_display setObjectTexture [0,_QS_module_liveFeed_noSignalFile];
										};
									} else {
										_QS_liveFeed_display setObjectTexture [0,_QS_module_liveFeed_noSignalFile];
									};
								} else {
									_QS_liveFeed_display setObjectTexture [0,_QS_module_liveFeed_noSignalFile];
								};
							};
						};
					} else {
						_QS_liveFeed_display setObjectTexture [0,_QS_module_liveFeed_noSignalFile];
					};
				};
			};
			_QS_module_liveFeed_checkDelay = _timeNow + _QS_module_liveFeed_delay;
		};
	};
	
	/*/===== View Distance/*/
	
	if (_QS_module_viewSettings) then {
		if ((!(cameraOn isEqualTo _QS_cameraOn)) || {(player getVariable ['QS_RD_viewSettings_update',FALSE])}) then {
			if (player getVariable ['QS_RD_viewSettings_update',FALSE]) then {
				player setVariable ['QS_RD_viewSettings_update',FALSE,FALSE];
			};
			_QS_cameraOn = cameraOn;
			if (!isNil {player getVariable _QS_viewSettings_var}) then {
				_viewDistance = viewDistance;
				_objectViewDistance = getObjectViewDistance select 0;
				_shadowDistance = getShadowDistance;
				_terrainGrid = getTerrainGrid;
				_clientViewSettings = player getVariable _QS_viewSettings_var;
				if (!isNull _QS_cameraOn) then {
					if (_QS_cameraOn isKindOf 'Man') then {
						if (!(_viewDistance isEqualTo ((_clientViewSettings select 0) select 0))) then {
							setViewDistance ((_clientViewSettings select 0) select 0);
						};
						if (!(_objectViewDistance isEqualTo ((_clientViewSettings select 1) select 0))) then {
							setObjectViewDistance ((_clientViewSettings select 1) select 0);
						};
						if (!(_shadowDistance isEqualTo ((_clientViewSettings select 2) select 0))) then {
							setShadowDistance ((_clientViewSettings select 2) select 0);
						};
						if (!(_terrainGrid isEqualTo ((_clientViewSettings select 3) select 0))) then {
							setTerrainGrid ((_clientViewSettings select 3) select 0);
						};
					} else {	
						if ((_QS_cameraOn isKindOf 'LandVehicle') || {(_QS_cameraOn isKindOf 'Ship')}) then {
							if (!(_viewDistance isEqualTo ((_clientViewSettings select 0) select 1))) then {
								setViewDistance ((_clientViewSettings select 0) select 1);
							};
							if (!(_objectViewDistance isEqualTo ((_clientViewSettings select 1) select 1))) then {
								setObjectViewDistance ((_clientViewSettings select 1) select 1);
							};
							if (!(_shadowDistance isEqualTo ((_clientViewSettings select 2) select 1))) then {
								setShadowDistance ((_clientViewSettings select 2) select 1);
							};
							if (!(_terrainGrid isEqualTo ((_clientViewSettings select 3) select 1))) then {
								setTerrainGrid ((_clientViewSettings select 3) select 1);
							};
						} else {
							if (_QS_cameraOn isKindOf 'Helicopter') then {
								if (!(_viewDistance isEqualTo ((_clientViewSettings select 0) select 2))) then {
									setViewDistance ((_clientViewSettings select 0) select 2);
								};
								if (!(_objectViewDistance isEqualTo ((_clientViewSettings select 1) select 2))) then {
									setObjectViewDistance ((_clientViewSettings select 1) select 2);
								};
								if (!(_shadowDistance isEqualTo ((_clientViewSettings select 2) select 2))) then {
									setShadowDistance ((_clientViewSettings select 2) select 2);
								};
								if (!(_terrainGrid isEqualTo ((_clientViewSettings select 3) select 2))) then {
									setTerrainGrid ((_clientViewSettings select 3) select 2);
								};
							} else {
								if (_QS_cameraOn isKindOf 'Plane') then {
									if (!(_viewDistance isEqualTo ((_clientViewSettings select 0) select 3))) then {
										setViewDistance ((_clientViewSettings select 0) select 3);
									};
									if (!(_objectViewDistance isEqualTo ((_clientViewSettings select 1) select 3))) then {
										setObjectViewDistance ((_clientViewSettings select 1) select 3);
									};
									if (!(_shadowDistance isEqualTo ((_clientViewSettings select 2) select 3))) then {
										setShadowDistance ((_clientViewSettings select 2) select 3);
									};
									if (!(_terrainGrid isEqualTo ((_clientViewSettings select 3) select 3))) then {
										setTerrainGrid ((_clientViewSettings select 3) select 3);
									};
								};
							};
						};
					};
				};
			} else {
				player setVariable [
					_QS_viewSettings_var,
					[
						[1000,2400,3200,4000],
						[800,1400,2400,3000],
						[50,50,50,50],
						[45,45,45,45],
						[TRUE,TRUE,FALSE,FALSE]
					],
					FALSE
				];
			};
		};
		if (_timeNow > _QS_RD_client_viewSettings_saveCheckDelay) then {
			profileNamespace setVariable [_QS_viewSettings_var,(player getVariable _QS_viewSettings_var)];
			saveProfileNamespace;
			_QS_RD_client_viewSettings_saveCheckDelay = _timeNow + _QS_RD_client_viewSettings_saveDelay;
		};
	};
	
	/*/===== Action Manager/*/
	
	if (_QS_module_action) then {
		if (alive _QS_player) then {
			if ((lifeState _QS_player) in ['HEALTHY','INJURED']) then {
				if (!(_QS_player getVariable 'QS_RD_interaction_busy')) then {
					_cursorTarget = cursorTarget;
					_cursorDistance = _QS_player distance _cursorTarget;
					getCursorObjectParams params [
						'_cursorObject',
						'_cursorObjectNamedSel',
						'_cursorObjectDistance'
					];
					if (isNull _cursorObject) then {
						_cursorObject = cursorObject;
					};
					if (!isNull _cursorObject) then {
						if (_cursorObject isKindOf 'CAManBase') then {
							if (_cursorObjectDistance < 15) then {
								if ((_QS_player knowsAbout _cursorObject) < 1) then {
									_QS_player reveal [_cursorObject,4];
								};
							};
						};
					};
					if (_timeNow > _QS_nearEntities_revealCheckDelay) then {
						if (isNull _objectParent) then {
							{
								if (simulationEnabled _x) then {
									if ((_QS_player knowsAbout _x) < 1) then {
										_QS_player reveal [_x,3.9];
									};
								};
							} count ((_posATLPlayer nearEntities [_QS_entityTypes,_QS_entityRange]) + (_posATLPlayer nearObjects [_QS_objectTypes,_QS_objectRange]));
							{
								if (!isNull (_x select 0)) then {
									if ((_x select 1) < 5) then {
										if (simulationEnabled (_x select 0)) then {
											if ((_QS_player knowsAbout (_x select 0)) < 1) then {
												_QS_player reveal [(_x select 0),3.9];
											};
										};
									};
								};
							} count [
								[_cursorTarget,_cursorDistance],
								[_cursorObject,_cursorObjectDistance]
							];
						};
						_QS_nearEntities_revealCheckDelay = _timeNow + _QS_nearEntities_revealDelay;
					};
					
					/*/===== Action Escort/*/
					if (isNull _objectParent) then {
						if (_cursorDistance < 2) then {
							if (_cursorTarget isKindOf 'Man') then {
								if (alive _cursorTarget) then {
									if (isNull (attachedTo _cursorTarget)) then {
										if (!isNil {_cursorTarget getVariable 'QS_RD_escortable'}) then {
											if (_cursorTarget getVariable 'QS_RD_escortable') then {
												if (!(_QS_interaction_escort)) then {
													_QS_interaction_escort = TRUE;
													_QS_action_escort = player addAction _QS_action_escort_array;
													player setUserActionText [_QS_action_escort,((player actionParams _QS_action_escort) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_escort) select 0)])];
												};
											} else {
												if (_QS_interaction_escort) then {
													_QS_interaction_escort = FALSE;
													player removeAction _QS_action_escort;
												};
											};
										} else {
											if (_QS_interaction_escort) then {
												_QS_interaction_escort = FALSE;
												player removeAction _QS_action_escort;
											};
										};
									} else {
										if (_QS_interaction_escort) then {
											_QS_interaction_escort = FALSE;
											player removeAction _QS_action_escort;
										};
									};
								} else {
									if (_QS_interaction_escort) then {
										_QS_interaction_escort = FALSE;
										player removeAction _QS_action_escort;
									};
								};
							} else {
								if (_QS_interaction_escort) then {
									_QS_interaction_escort = FALSE;
									player removeAction _QS_action_escort;
								};
							};
						} else {
							if (_QS_interaction_escort) then {
								_QS_interaction_escort = FALSE;
								player removeAction _QS_action_escort;
							};
						};
					} else {
						if (_QS_interaction_escort) then {
							_QS_interaction_escort = FALSE;
							player removeAction _QS_action_escort;
						};
					};

					/*/========== REVIVE/*/
		
					if (_QS_iAmMedic) then {
						if (_cursorDistance < 1.9) then {
							if (isNull _objectParent) then {
								if (({(_x isKindOf 'Man')} count (attachedObjects player)) isEqualTo 0) then {
									if (_cursorTarget isKindOf 'Man') then {
										if (alive _cursorTarget) then {
											if (((toLower (animationState _cursorTarget)) in _QS_revive_injuredAnims) || {((lifeState _cursorTarget) isEqualTo 'INCAPACITATED')}) then {
												if ((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') then {
													if ((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') then {
														if (!(_QS_interaction_revive)) then {
															_QS_interaction_revive = TRUE;
															_QS_action_revive = player addAction _QS_action_revive_array;
															player setUserActionText [_QS_action_revive,((player actionParams _QS_action_revive) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_revive) select 0)])];
														};
													} else {
														if (_QS_interaction_revive) then {
															_QS_interaction_revive = FALSE;
															player removeAction _QS_action_revive;
														};
													};
												} else {
													if (_QS_interaction_revive) then {
														_QS_interaction_revive = FALSE;
														player removeAction _QS_action_revive;
													};
												};
											} else {
												if (_QS_interaction_revive) then {
													_QS_interaction_revive = FALSE;
													player removeAction _QS_action_revive;
												};
											};
										} else {
											if (_QS_interaction_revive) then {
												_QS_interaction_revive = FALSE;
												player removeAction _QS_action_revive;
											};
										};
									} else {
										if (_QS_interaction_revive) then {
											_QS_interaction_revive = FALSE;
											player removeAction _QS_action_revive;
										};
									};
								} else {
									if (_QS_interaction_revive) then {
										_QS_interaction_revive = FALSE;
										player removeAction _QS_action_revive;
									};
								};
							} else {
								if (_QS_interaction_revive) then {
									_QS_interaction_revive = FALSE;
									player removeAction _QS_action_revive;
								};
							};
						} else {
							if (_QS_interaction_revive) then {
								_QS_interaction_revive = FALSE;
								player removeAction _QS_action_revive;
							};
						};
					};
					
					/*/===== Stabilise/*/

					if (_cursorDistance < 1.9) then {
						if (isNull _objectParent) then {
							if (({(_x isKindOf 'CAManBase')} count (attachedObjects player)) isEqualTo 0) then {
								if (_cursorTarget isKindOf 'CAManBase') then {
									if (alive _cursorTarget) then {
										if (_cursorTarget getVariable ['QS_interact_stabilise',FALSE]) then {
											if (!(_cursorTarget getVariable ['QS_interact_stabilised',TRUE])) then {
												if (!(_QS_interaction_stabilise)) then {
													_QS_interaction_stabilise = TRUE;
													_QS_action_stabilise = player addAction _QS_action_stabilise_array;
													player setUserActionText [_QS_action_stabilise,((player actionParams _QS_action_stabilise) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_stabilise) select 0)])];
												};
											} else {
												if (_QS_interaction_stabilise) then {
													_QS_interaction_stabilise = FALSE;
													player removeAction _QS_action_stabilise;
												};
											};
										} else {
											if (_QS_interaction_stabilise) then {
												_QS_interaction_stabilise = FALSE;
												player removeAction _QS_action_stabilise;
											};
										};
									} else {
										if (_QS_interaction_stabilise) then {
											_QS_interaction_stabilise = FALSE;
											player removeAction _QS_action_stabilise;
										};
									};
								} else {
									if (_QS_interaction_stabilise) then {
										_QS_interaction_stabilise = FALSE;
										player removeAction _QS_action_stabilise;
									};
								};
							} else {
								if (_QS_interaction_stabilise) then {
									_QS_interaction_stabilise = FALSE;
									player removeAction _QS_action_stabilise;
								};
							};
						} else {
							if (_QS_interaction_stabilise) then {
								_QS_interaction_stabilise = FALSE;
								player removeAction _QS_action_stabilise;
							};
						};
					} else {
						if (_QS_interaction_stabilise) then {
							_QS_interaction_stabilise = FALSE;
							player removeAction _QS_action_stabilise;
						};
					};									
								
					/*/===== Action Load/*/
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if ((_cursorTarget isKindOf 'LandVehicle') || {(_cursorTarget isKindOf 'Air')} || {(_cursorTarget isKindOf 'Ship')}) then {
									if (alive _cursorTarget) then {
										if (((_cursorTarget emptyPositions 'Cargo') > 0) || {((unitIsUav _cursorTarget) && (([_cursorTarget,1] call _fn_clientInteractUGV) > 0))}) then {
											if ((locked _cursorTarget) in [-1,0,1]) then {
												if (({(_x isKindOf 'Man')} count (attachedObjects player)) > 0) then {
													{
														if (!isNull _x) then {
															if (_x isKindOf 'Man') then {
																if (alive _x) then {
																	if (!(_QS_interaction_load)) then {
																		_QS_interaction_load = TRUE;
																		_QS_action_load = player addAction _QS_action_load_array;
																		player setUserActionText [_QS_action_load,((player actionParams _QS_action_load) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_load) select 0)])];
																	};
																} else {
																	if (_QS_interaction_load) then {
																		_QS_interaction_load = FALSE;
																		player removeAction _QS_action_load;
																	};
																};
															};
														};
													} count (attachedObjects player);
												} else {
													if (_QS_interaction_load) then {
														_QS_interaction_load = FALSE;
														player removeAction _QS_action_load;
													};
												};
											} else {
												if (_QS_interaction_load) then {
													_QS_interaction_load = FALSE;
													player removeAction _QS_action_load;
												};
											};	
										} else {
											if (_QS_interaction_load) then {
												_QS_interaction_load = FALSE;
												player removeAction _QS_action_load;
											};
										};	
									} else {
										if (_QS_interaction_load) then {
											_QS_interaction_load = FALSE;
											player removeAction _QS_action_load;
										};
									};	
								} else {
									if (_QS_interaction_load) then {
										_QS_interaction_load = FALSE;
										player removeAction _QS_action_load;
									};
								};	
							} else {
								if (_QS_interaction_load) then {
									_QS_interaction_load = FALSE;
									player removeAction _QS_action_load;
								};
							};
						} else {
							if (_QS_interaction_load) then {
								_QS_interaction_load = FALSE;
								player removeAction _QS_action_load;
							};
						};
					} else {
						if (_QS_interaction_load) then {
							_QS_interaction_load = FALSE;
							player removeAction _QS_action_load;
						};
					};
					
					/*/===== Action Unload/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if ((_cursorTarget isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Ship')}) then {
									if ((({(alive _x)} count (crew _cursorObject)) > 0) || ((unitIsUav _cursorObject) && ([_cursorObject,0] call _fn_clientInteractUGV) && (({((_x isKindOf 'CAManBase') && (alive _x))} count (attachedObjects _cursorObject)) > 0))) then {
										if ((!(({(!isNil {_x getVariable 'QS_RD_loaded'}) && (_x getVariable 'QS_RD_loaded')} count (crew _cursorObject)) isEqualTo 0)) || {(!(({((lifeState _x) isEqualTo 'INCAPACITATED')} count (crew _cursorObject)) isEqualTo 0))} || {(({((_x isKindOf 'CAManBase') && (alive _x) && (_x getVariable ['QS_RD_loaded',FALSE]))} count (attachedObjects _cursorObject)) > 0)}) then {
											{
												if (!(_QS_interaction_unload)) then {
													if ((!isNil {_x getVariable 'QS_RD_loaded'}) || {((lifeState _x) isEqualTo 'INCAPACITATED')}) then {
														if ((_x getVariable 'QS_RD_loaded') || {((lifeState _x) isEqualTo 'INCAPACITATED')}) then {
															if (alive _x) then {
																_QS_interaction_unload = TRUE;
																_QS_action_unload = player addAction _QS_action_unload_array;
																player setUserActionText [_QS_action_unload,((player actionParams _QS_action_unload) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unload) select 0)])];
															} else {
																if (_QS_interaction_unload) then {
																	_QS_interaction_unload = FALSE;
																	player removeAction _QS_action_unload;
																};
															};
														} else {
															if (_QS_interaction_unload) then {
																_QS_interaction_unload = FALSE;
																player removeAction _QS_action_unload;
															};
														};
													} else {
														if (_QS_interaction_unload) then {
															_QS_interaction_unload = FALSE;
															player removeAction _QS_action_unload;
														};
													};
												};
											} count ((crew _cursorObject) + (attachedObjects _cursorObject));
										} else {
											if (_QS_interaction_unload) then {
												_QS_interaction_unload = FALSE;
												player removeAction _QS_action_unload;
											};
										};
									} else {
										if (_QS_interaction_unload) then {
											_QS_interaction_unload = FALSE;
											player removeAction _QS_action_unload;
										};
									};
								} else {
									if (_QS_interaction_unload) then {
										_QS_interaction_unload = FALSE;
										player removeAction _QS_action_unload;
									};
								};
							} else {
								if (_QS_interaction_unload) then {
									_QS_interaction_unload = FALSE;
									player removeAction _QS_action_unload;
								};
							};
						} else {
							if (_QS_interaction_unload) then {
								_QS_interaction_unload = FALSE;
								player removeAction _QS_action_unload;
							};
						};
					} else {
						if (_QS_interaction_unload) then {
							_QS_interaction_unload = FALSE;
							player removeAction _QS_action_unload;
						};
					};
					
					/*/===== Action Question Civilian/*/
					
					if (_cursorDistance < 10) then {
						if (_cursorTarget isKindOf 'Man') then {
							if ((side _cursorTarget) isEqualTo CIVILIAN) then {
								if (alive _cursorTarget) then {
									if (!isNil {_cursorTarget getVariable 'QS_civilian_interactable'}) then {
										if (_cursorTarget getVariable 'QS_civilian_interactable') then {
											if (!(_QS_interaction_questionCivilian)) then {
												_QS_interaction_questionCivilian = TRUE;
												_QS_action_questionCivilian = player addAction _QS_action_questionCivilian_array;
												player setUserActionText [_QS_action_questionCivilian,((player actionParams _QS_action_questionCivilian) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_questionCivilian) select 0)])];
											};
										} else {
											if (_QS_interaction_questionCivilian) then {
												_QS_interaction_questionCivilian = FALSE;
												player removeAction _QS_action_questionCivilian;
											};
										};
									} else {
										if (_QS_interaction_questionCivilian) then {
											_QS_interaction_questionCivilian = FALSE;
											player removeAction _QS_action_questionCivilian;
										};
									};
								} else {
									if (_QS_interaction_questionCivilian) then {
										_QS_interaction_questionCivilian = FALSE;
										player removeAction _QS_action_questionCivilian;
									};
								};
							} else {
								if (_QS_interaction_questionCivilian) then {
									_QS_interaction_questionCivilian = FALSE;
									player removeAction _QS_action_questionCivilian;
								};
							};
						} else {
							if (_QS_interaction_questionCivilian) then {
								_QS_interaction_questionCivilian = FALSE;
								player removeAction _QS_action_questionCivilian;
							};
						};
					} else {
						if (_QS_interaction_questionCivilian) then {
							_QS_interaction_questionCivilian = FALSE;
							player removeAction _QS_action_questionCivilian;
						};
					};
					/*/===== Action Drag/*/
					
					if (isNull _objectParent) then {
						if (_cursorDistance < 1.9) then {
							if (({((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))} count (attachedObjects player)) isEqualTo 0) then {
								if (isNull (attachedTo _cursorTarget)) then {
									/*/if (isTouchingGround _cursorTarget) then {/*/
										if (alive _cursorTarget) then {
											if (_cursorTarget isKindOf 'Man') then {
												if ((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') then {
													if ((isNull (attachedTo _cursorTarget)) && (isNull (objectParent _cursorTarget))) then {
														if (!(_QS_interaction_drag)) then {
															_QS_interaction_drag = TRUE;
															_QS_action_drag = player addAction _QS_action_drag_array;
															player setUserActionText [_QS_action_drag,((player actionParams _QS_action_drag) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_drag) select 0)])];
														};
													} else {
														if (_QS_interaction_drag) then {
															_QS_interaction_drag = FALSE;
															player removeAction _QS_action_drag;
														};
													};
												} else {
													if (_QS_interaction_drag) then {
														_QS_interaction_drag = FALSE;
														player removeAction _QS_action_drag;
													};
												};
											} else {
												if (([0,_cursorTarget,objNull] call _fn_getCustomCargoParams) || {((!isNil {_cursorTarget getVariable 'QS_RD_draggable'}) && (_cursorTarget getVariable ['QS_RD_draggable',FALSE]))}) then {
													if (!(_QS_interaction_drag)) then {
														_QS_interaction_drag = TRUE;
														_QS_action_drag = player addAction _QS_action_drag_array;
														player setUserActionText [_QS_action_drag,((player actionParams _QS_action_drag) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_drag) select 0)])];
													};
												} else {
													if (_QS_interaction_drag) then {
														_QS_interaction_drag = FALSE;
														player removeAction _QS_action_drag;
													};
												};
											};
										} else {
											if (_QS_interaction_drag) then {
												_QS_interaction_drag = FALSE;
												player removeAction _QS_action_drag;
											};
										};
										/*/
									} else {
										if (_QS_interaction_drag) then {
											_QS_interaction_drag = FALSE;
											player removeAction _QS_action_drag;
										};
									};
									/*/
								} else {
									if (_QS_interaction_drag) then {
										_QS_interaction_drag = FALSE;
										player removeAction _QS_action_drag;
									};
								};
							} else {
								if (_QS_interaction_drag) then {
									_QS_interaction_drag = FALSE;
									player removeAction _QS_action_drag;
								};
							};
						} else {
							if (_QS_interaction_drag) then {
								_QS_interaction_drag = FALSE;
								player removeAction _QS_action_drag;
							};
						};
					} else {
						if (_QS_interaction_drag) then {
							_QS_interaction_drag = FALSE;
							player removeAction _QS_action_drag;
						};
					};

					/*/===== Action Carry/*/
					if (isNull _objectParent) then {
						if (_cursorDistance < 1.9) then {
							if ((isNull (attachedTo _cursorTarget)) && (isNull (objectParent _cursorTarget))) then {
								if (_cursorTarget isKindOf 'CAManBase') then {
									if (alive _cursorTarget) then {
										if ((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') then {
											if (!(_QS_interaction_carry)) then {
												_QS_interaction_carry = TRUE;
												_QS_action_carry = player addAction _QS_action_carry_array;
												player setUserActionText [_QS_action_carry,((player actionParams _QS_action_carry) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_carry) select 0)])];
											};
										} else {
											if (_QS_interaction_carry) then {
												_QS_interaction_carry = FALSE;
												player removeAction _QS_action_carry;
											};
										};
									} else {
										if (_QS_interaction_carry) then {
											_QS_interaction_carry = FALSE;
											player removeAction _QS_action_carry;
										};
									};
								} else {
									if (([0,_cursorTarget,objNull] call _fn_getCustomCargoParams) && ([4,_cursorTarget,_QS_v2] call _fn_getCustomCargoParams)) then {
										if (!(_QS_interaction_carry)) then {
											_QS_interaction_carry = TRUE;
											_QS_action_carry = player addAction _QS_action_carry_array;
											player setUserActionText [_QS_action_carry,((player actionParams _QS_action_carry) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_carry) select 0)])];
										};
									} else {
										if (_QS_interaction_carry) then {
											_QS_interaction_carry = FALSE;
											player removeAction _QS_action_carry;
										};
									};
								};
							} else {
								if (_QS_interaction_carry) then {
									_QS_interaction_carry = FALSE;
									player removeAction _QS_action_carry;
								};
							};
						} else {
							if (_QS_interaction_carry) then {
								_QS_interaction_carry = FALSE;
								player removeAction _QS_action_carry;
							};
						};
					} else {
						if (_QS_interaction_carry) then {
							_QS_interaction_carry = FALSE;
							player removeAction _QS_action_carry;
						};
					};
					
					/*/===== Action Follow/*/
					
					if (_cursorDistance < 3) then {
						if (_cursorTarget isKindOf 'Man') then {
							if (alive _cursorTarget) then {
								if (!(_cursorTarget isEqualTo player)) then {
									if (!(_cursorTarget in (units (group player)))) then {
										if (!isNil {_cursorTarget getVariable 'QS_RD_followable'}) then {
											if (_cursorTarget getVariable 'QS_RD_followable') then {
												if (!(_QS_interaction_follow)) then {
													_QS_interaction_follow = TRUE;
													_QS_action_follow = player addAction _QS_action_follow_array;
													player setUserActionText [_QS_action_follow,((player actionParams _QS_action_follow) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_follow) select 0)])];
												};
											} else {
												if (_QS_interaction_follow) then {
													_QS_interaction_follow = FALSE;
													player removeAction _QS_action_follow;
												};
											};
										} else {
											if (_QS_interaction_follow) then {
												_QS_interaction_follow = FALSE;
												player removeAction _QS_action_follow;
											};
										};
									} else {
										if (_QS_interaction_follow) then {
											_QS_interaction_follow = FALSE;
											player removeAction _QS_action_follow;
										};
									};
								} else {
									if (_QS_interaction_follow) then {
										_QS_interaction_follow = FALSE;
										player removeAction _QS_action_follow;
									};
								};
							} else {
								if (_QS_interaction_follow) then {
									_QS_interaction_follow = FALSE;
									player removeAction _QS_action_follow;
								};
							};
						} else {
							if (_QS_interaction_follow) then {
								_QS_interaction_follow = FALSE;
								player removeAction _QS_action_follow;
							};
						};
					} else {
						if (_QS_interaction_follow) then {
							_QS_interaction_follow = FALSE;
							player removeAction _QS_action_follow;
						};
					};
					
					/*/===== Action Recruit/*/

					if (_cursorDistance < 3) then {
						if (_cursorTarget isKindOf 'Man') then {
							if (alive _cursorTarget) then {
								if (isNull _objectParent) then {
									if (!(_cursorTarget isEqualTo player)) then {
										if (player isEqualTo (leader (group player))) then {
											if (!((group _cursorTarget) isEqualTo (group player))) then {
												if (!isNil {_cursorTarget getVariable 'QS_RD_recruitable'}) then {
													if (_cursorTarget getVariable 'QS_RD_recruitable') then {
														if (!(_QS_interaction_recruit)) then {
															_QS_interaction_recruit = TRUE;
															_QS_action_recruit = player addAction _QS_action_recruit_array;
															player setUserActionText [_QS_action_recruit,((player actionParams _QS_action_recruit) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_recruit) select 0)])];
														};
													} else {
														if (_QS_interaction_recruit) then {
															_QS_interaction_recruit = FALSE;
															player removeAction _QS_action_recruit;
														};
													};
												} else {
													if (_QS_interaction_recruit) then {
														_QS_interaction_recruit = FALSE;
														player removeAction _QS_action_recruit;
													};
												};
											} else {
												if (_QS_interaction_recruit) then {
													_QS_interaction_recruit = FALSE;
													player removeAction _QS_action_recruit;
												};
											};
										} else {
											if (_QS_interaction_recruit) then {
												_QS_interaction_recruit = FALSE;
												player removeAction _QS_action_recruit;
											};								
										};
									} else {
										if (_QS_interaction_recruit) then {
											_QS_interaction_recruit = FALSE;
											player removeAction _QS_action_recruit;
										};
									};
								} else {
									if (_QS_interaction_recruit) then {
										_QS_interaction_recruit = FALSE;
										player removeAction _QS_action_recruit;
									};
								};
							} else {
								if (_QS_interaction_recruit) then {
									_QS_interaction_recruit = FALSE;
									player removeAction _QS_action_recruit;
								};
							};
						} else {
							if (_QS_interaction_recruit) then {
								_QS_interaction_recruit = FALSE;
								player removeAction _QS_action_recruit;
							};
						};
					} else {
						if (_QS_interaction_recruit) then {
							_QS_interaction_recruit = FALSE;
							player removeAction _QS_action_recruit;
						};
					};
					
					/*/===== Action Dismiss/*/

					if (_cursorDistance < 3.5) then {
						if (_cursorTarget isKindOf 'Man') then {
							if (alive _cursorTarget) then {
								if (!(_cursorTarget isEqualTo player)) then {
									if (player isEqualTo (leader (group player))) then {
										if ((group _cursorTarget) isEqualTo (group player)) then {
											if (!isNil {_cursorTarget getVariable 'QS_RD_dismissable'}) then {
												if (_cursorTarget getVariable 'QS_RD_dismissable') then {
													if (!(_QS_interaction_dismiss)) then {
														_QS_interaction_dismiss = TRUE;
														_QS_action_dismiss = player addAction _QS_action_dismiss_array;
														player setUserActionText [_QS_action_dismiss,((player actionParams _QS_action_dismiss) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_dismiss) select 0)])];
													};
												} else {
													if (_QS_interaction_dismiss) then {
														_QS_interaction_dismiss = FALSE;
														player removeAction _QS_action_dismiss;
													};
												};
											} else {
												if (_QS_interaction_dismiss) then {
													_QS_interaction_dismiss = FALSE;
													player removeAction _QS_action_dismiss;
												};
											};
										} else {
											if (_QS_interaction_dismiss) then {
												_QS_interaction_dismiss = FALSE;
												player removeAction _QS_action_dismiss;
											};
										};
									} else {
										if (_QS_interaction_dismiss) then {
											_QS_interaction_dismiss = FALSE;
											player removeAction _QS_action_dismiss;
										};								
									};
								} else {
									if (_QS_interaction_dismiss) then {
										_QS_interaction_dismiss = FALSE;
										player removeAction _QS_action_dismiss;
									};
								};
							} else {
								if (_QS_interaction_dismiss) then {
									_QS_interaction_dismiss = FALSE;
									player removeAction _QS_action_dismiss;
								};
							};
						} else {
							if (_QS_interaction_dismiss) then {
								_QS_interaction_dismiss = FALSE;
								player removeAction _QS_action_dismiss;
							};
						};
					} else {
						if (_QS_interaction_dismiss) then {
							_QS_interaction_dismiss = FALSE;
							player removeAction _QS_action_dismiss;
						};
					};
					
					/*/===== Action Respawn Vehicle/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if (_QS_uiTime > (player getVariable ['QS_RD_canRespawnVehicle',-1])) then {
									if (!isNil {_cursorObject getVariable 'QS_RD_vehicleRespawnable'}) then {
										if (_cursorObject getVariable 'QS_RD_vehicleRespawnable') then {
											if (isNil {_cursorObject getVariable 'QS_disableRespawnAction'}) then {
												if ((crew _cursorObject) isEqualTo []) then {
													if (local _cursorObject) then {
														if (!(_QS_interaction_respawnVehicle)) then {
															_QS_interaction_respawnVehicle = TRUE;
															_QS_action_respawnVehicle = player addAction _QS_action_respawnVehicle_array;
															player setUserActionText [_QS_action_respawnVehicle,((player actionParams _QS_action_respawnVehicle) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_respawnVehicle) select 0)])];
														};
													} else {
														if (_QS_interaction_respawnVehicle) then {
															_QS_interaction_respawnVehicle = FALSE;
															player removeAction _QS_action_respawnVehicle;
														};
													};
												} else {
													if (_QS_interaction_respawnVehicle) then {
														_QS_interaction_respawnVehicle = FALSE;
														player removeAction _QS_action_respawnVehicle;
													};
												};
											} else {
												if (_QS_interaction_respawnVehicle) then {
													_QS_interaction_respawnVehicle = FALSE;
													player removeAction _QS_action_respawnVehicle;
												};
											};
										} else {
											if (_QS_interaction_respawnVehicle) then {
												_QS_interaction_respawnVehicle = FALSE;
												player removeAction _QS_action_respawnVehicle;
											};
										};
									} else {
										if (_QS_interaction_respawnVehicle) then {
											_QS_interaction_respawnVehicle = FALSE;
											player removeAction _QS_action_respawnVehicle;
										};
									};
								} else {
									if (_QS_interaction_respawnVehicle) then {
										_QS_interaction_respawnVehicle = FALSE;
										player removeAction _QS_action_respawnVehicle;
									};						
								};
							} else {
								if (_QS_interaction_respawnVehicle) then {
									_QS_interaction_respawnVehicle = FALSE;
									player removeAction _QS_action_respawnVehicle;
								};
							};
						} else {
							if (_QS_interaction_respawnVehicle) then {
								_QS_interaction_respawnVehicle = FALSE;
								player removeAction _QS_action_respawnVehicle;
							};
						};
					} else {
						if (_QS_interaction_respawnVehicle) then {
							_QS_interaction_respawnVehicle = FALSE;
							player removeAction _QS_action_respawnVehicle;
						};
					};
					
					/*/===== Vehicle Doors/*/
					
					if (!isNull _objectParent) then {
						if (_QS_v2Type in _QS_action_vehDoors_vehicles) then {
							if (player isEqualTo (effectiveCommander _QS_v2)) then {
								if (!(_QS_interaction_vehDoors)) then {
									_QS_interaction_vehDoors = TRUE;
									if (([_QS_v2] call _fn_clientGetDoorPhase) isEqualTo 1) then {
										_QS_action_vehDoors_array set [0,_QS_action_vehDoors_textClose];
										_QS_action_vehDoors_array set [2,[_QS_v2,0]];
									} else {
										_QS_action_vehDoors_array set [0,_QS_action_vehDoors_textOpen];
										_QS_action_vehDoors_array set [2,[_QS_v2,1]];
									};
									_QS_action_vehDoors = player addAction _QS_action_vehDoors_array;
									player setUserActionText [_QS_action_vehDoors,((player actionParams _QS_action_vehDoors) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_vehDoors) select 0)])];
								} else {
									if (([_QS_v2] call _fn_clientGetDoorPhase) isEqualTo 1) then {
										if ((_QS_action_vehDoors_array select 0) isEqualTo _QS_action_vehDoors_textOpen) then {
											_QS_interaction_vehDoors = FALSE;
											player removeAction _QS_action_vehDoors;
										};
									} else {
										if ((_QS_action_vehDoors_array select 0) isEqualTo _QS_action_vehDoors_textClose) then {
											_QS_interaction_vehDoors = FALSE;
											player removeAction _QS_action_vehDoors;									
										};
									};								
								};
							} else {
								if (_QS_interaction_vehDoors) then {
									_QS_interaction_vehDoors = FALSE;
									player removeAction _QS_action_vehDoors;
								};
							};
						} else {
							if (_QS_interaction_vehDoors) then {
								_QS_interaction_vehDoors = FALSE;
								player removeAction _QS_action_vehDoors;
							};
						};
					} else {
						if (_QS_interaction_vehDoors) then {
							_QS_interaction_vehDoors = FALSE;
							player removeAction _QS_action_vehDoors;
						};
					};
					
					/*/===== Vehicle Service/*/
					
					if ((_cursorObjectDistance < 7) || {(!isNull _objectParent)}) then {
						if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_QS_v2 isKindOf 'LandVehicle')} || {(_QS_v2 isKindOf 'Air')}) then {
							if (!(missionNamespace getVariable 'QS_repairing_vehicle')) then {
								if (((speed _QS_v2) < 1) && ((speed _QS_v2) > -1)) then {
									_nearSite = FALSE;
									{
										if ((_QS_v2 distance (markerPos _x)) < 12) exitWith {
											_nearSite = TRUE;
										};
									} count (missionNamespace getVariable 'QS_veh_repair_mkrs');
									if ((_nearSite) || ((!(_QS_carrierEnabled isEqualTo 0)) && (['INPOLYGON_FOOT',player] call _fn_carrier))) then {
										if (!(_QS_interaction_serviceVehicle)) then {
											_QS_interaction_serviceVehicle = TRUE;
											if (['INPOLYGON_FOOT',player] call _fn_carrier) then {
												_QS_action_serviceVehicle_array set [3,-1];
											} else {
												_QS_action_serviceVehicle_array set [3,10];
											};
											_QS_action_serviceVehicle = player addAction _QS_action_serviceVehicle_array;
											player setUserActionText [_QS_action_serviceVehicle,((player actionParams _QS_action_serviceVehicle) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_serviceVehicle) select 0)])];
										};
									} else {
										if (_QS_interaction_serviceVehicle) then {
											_QS_interaction_serviceVehicle = FALSE;
											player removeAction _QS_action_serviceVehicle;
										};
									};
								} else {
									if (_QS_interaction_serviceVehicle) then {
										_QS_interaction_serviceVehicle = FALSE;
										player removeAction _QS_action_serviceVehicle;
									};
								};
							} else {
								if (_QS_interaction_serviceVehicle) then {
									_QS_interaction_serviceVehicle = FALSE;
									player removeAction _QS_action_serviceVehicle;
								};
							};
						} else {
							if (_QS_interaction_serviceVehicle) then {
								_QS_interaction_serviceVehicle = FALSE;
								player removeAction _QS_action_serviceVehicle;
							};
						};
					} else {
						if (_QS_interaction_serviceVehicle) then {
							_QS_interaction_serviceVehicle = FALSE;
							player removeAction _QS_action_serviceVehicle;
						};
					};
					
					/*/===== Unflip vehicle/*/
					
					if (alive _cursorObject) then {
						if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Reammobox_F')}) then {
							if (((_cursorObjectDistance <= 2) && (_cursorObject isEqualTo _cursorTarget)) || {(( (toLower _QS_v2Type) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) && (_cursorObjectDistance <= 10))}) then {
								if (((vectorUp _cursorObject) select 2) < 0.1) then {
									if (!(_QS_interaction_unflipVehicle)) then {
										_QS_interaction_unflipVehicle = TRUE;
										_QS_action_unflipVehicle = player addAction _QS_action_unflipVehicle_array;
										player setUserActionText [_QS_action_unflipVehicle,((player actionParams _QS_action_unflipVehicle) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unflipVehicle) select 0)])];
									};
								} else {
									if (_QS_interaction_unflipVehicle) then {
										_QS_interaction_unflipVehicle = FALSE;
										player removeAction _QS_action_unflipVehicle;
									};
								};
							} else {
								if (_QS_interaction_unflipVehicle) then {
									_QS_interaction_unflipVehicle = FALSE;
									player removeAction _QS_action_unflipVehicle;
								};
							};
						} else {
							if (_QS_interaction_unflipVehicle) then {
								_QS_interaction_unflipVehicle = FALSE;
								player removeAction _QS_action_unflipVehicle;
							};
						};
					} else {
						if (_QS_interaction_unflipVehicle) then {
							_QS_interaction_unflipVehicle = FALSE;
							player removeAction _QS_action_unflipVehicle;
						};
					};
					
					/*/===== Arsenal/*/
	
					if (isNull _objectParent) then {
						if (_cursorObjectDistance < 20) then {
							if (((((getModelInfo _cursorObject) select 1) isEqualTo _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(!isNil {_cursorTarget getVariable 'QS_arsenal_object'})}) then {
								if (((((getModelInfo _cursorObject) select 1) isEqualTo _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorTarget getVariable 'QS_arsenal_object')}) then {
									if ((speed player) isEqualTo 0) then {
										if (!(_QS_interaction_arsenal)) then {
											_QS_interaction_arsenal = TRUE;
											_QS_action_arsenal = player addAction _QS_action_arsenal_array;
											player setUserActionText [_QS_action_arsenal,((player actionParams _QS_action_arsenal) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_arsenal) select 0)])];
										};
									} else {
										if (_QS_interaction_arsenal) then {
											_QS_interaction_arsenal = FALSE;
											player removeAction _QS_action_arsenal;
										};
									};
								} else {
									if (_QS_interaction_arsenal) then {
										_QS_interaction_arsenal = FALSE;
										player removeAction _QS_action_arsenal;
									};
								};
							} else {
								if (_QS_interaction_arsenal) then {
									_QS_interaction_arsenal = FALSE;
									player removeAction _QS_action_arsenal;
								};
							};
						} else {
							if (_QS_interaction_arsenal) then {
								_QS_interaction_arsenal = FALSE;
								player removeAction _QS_action_arsenal;
							};
						};
					} else {
						if (_QS_interaction_arsenal) then {
							_QS_interaction_arsenal = FALSE;
							player removeAction _QS_action_arsenal;
						};
					};

					/*/===== Action Tow/*/
					
					if (!isNull _objectParent) then {
						if (_QS_v2 isKindOf 'LandVehicle') then {
							if (((vectorMagnitude (velocity _QS_v2)) * 3.6) < 1) then {
								if ((_QS_v2 getVariable ['QS_tow_veh',-1]) > 0) then {
									if (canMove _QS_v2) then {
										if (((vectorUp _QS_v2) select 2) > 0.1) then {
											if (isNull (isVehicleCargo _QS_v2)) then {
												if (isNull (ropeAttachedTo _QS_v2)) then {
													if ([_QS_v2] call _fn_vTowable) then {
														if (!(_QS_interaction_tow)) then {
															_QS_interaction_tow = TRUE;
															_QS_action_tow = player addAction _QS_action_tow_array;
															player setUserActionText [_QS_action_tow,((player actionParams _QS_action_tow) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_tow) select 0)])];
														};
													} else {
														if (_QS_interaction_tow) then {
															_QS_interaction_tow = FALSE;
															player removeAction _QS_action_tow;
														};
													};
												} else {
													if (_QS_interaction_tow) then {
														_QS_interaction_tow = FALSE;
														player removeAction _QS_action_tow;
													};
												};
											} else {
												if (_QS_interaction_tow) then {
													_QS_interaction_tow = FALSE;
													player removeAction _QS_action_tow;
												};
											};
										} else {
											if (_QS_interaction_tow) then {
												_QS_interaction_tow = FALSE;
												player removeAction _QS_action_tow;
											};
										};
									} else {
										if (_QS_interaction_tow) then {
											_QS_interaction_tow = FALSE;
											player removeAction _QS_action_tow;
										};
									};
								} else {
									if (_QS_interaction_tow) then {
										_QS_interaction_tow = FALSE;
										player removeAction _QS_action_tow;
									};
								};
							} else {
								if (_QS_interaction_tow) then {
									_QS_interaction_tow = FALSE;
									player removeAction _QS_action_tow;
								};
							};
						} else {
							if (_QS_interaction_tow) then {
								_QS_interaction_tow = FALSE;
								player removeAction _QS_action_tow;
							};
						};
					} else {
						if (_QS_interaction_tow) then {
							_QS_interaction_tow = FALSE;
							player removeAction _QS_action_tow;
						};
					};
					
					/*/===== Action Command Surrender/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorTarget) then {
							if (_cursorDistance < 6) then {
								if (_cursorTarget isKindOf 'Man') then {
									if (alive _cursorTarget) then {
										if (!(captive _cursorTarget)) then {
											if ((lifeState _cursorTarget) in ['HEALTHY','INJURED']) then {
												if (isNull (objectParent _cursorTarget)) then {
													if (_cursorTarget getVariable ['QS_surrenderable',FALSE]) then {
														if (!(weaponLowered player)) then {
															if (!(underwater player)) then {
																if ((stance player) in ['STAND','CROUCH']) then {
																	if ((lineIntersectsSurfaces [(eyePos player),(aimPos _cursorTarget),player,_cursorTarget,TRUE,-1,'FIRE','VIEW',TRUE]) isEqualTo []) then {
																		if (!(uiNamespace getVariable ['QS_client_progressVisualization_active',FALSE])) then {
																			if (!(_QS_interaction_commandSurrender)) then {
																				_QS_interaction_commandSurrender = TRUE;
																				_QS_action_commandSurrender = player addAction _QS_action_commandSurrender_array;
																				player setUserActionText [_QS_action_commandSurrender,((player actionParams _QS_action_commandSurrender) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_commandSurrender) select 0)])];
																			};
																		} else {
																			if (_QS_interaction_commandSurrender) then {
																				_QS_interaction_commandSurrender = FALSE;
																				player removeAction _QS_action_commandSurrender;
																			};
																		};
																	} else {
																		if (_QS_interaction_commandSurrender) then {
																			_QS_interaction_commandSurrender = FALSE;
																			player removeAction _QS_action_commandSurrender;
																		};
																	};
																} else {
																	if (_QS_interaction_commandSurrender) then {
																		_QS_interaction_commandSurrender = FALSE;
																		player removeAction _QS_action_commandSurrender;
																	};
																};
															} else {
																if (_QS_interaction_commandSurrender) then {
																	_QS_interaction_commandSurrender = FALSE;
																	player removeAction _QS_action_commandSurrender;
																};
															};
														} else {
															if (_QS_interaction_commandSurrender) then {
																_QS_interaction_commandSurrender = FALSE;
																player removeAction _QS_action_commandSurrender;
															};
														};
													} else {
														if (_QS_interaction_commandSurrender) then {
															_QS_interaction_commandSurrender = FALSE;
															player removeAction _QS_action_commandSurrender;
														};
													};
												} else {
													if (_QS_interaction_commandSurrender) then {
														_QS_interaction_commandSurrender = FALSE;
														player removeAction _QS_action_commandSurrender;
													};
												};
											} else {
												if (_QS_interaction_commandSurrender) then {
													_QS_interaction_commandSurrender = FALSE;
													player removeAction _QS_action_commandSurrender;
												};
											};
										} else {
											if (_QS_interaction_commandSurrender) then {
												_QS_interaction_commandSurrender = FALSE;
												player removeAction _QS_action_commandSurrender;
											};
										};
									} else {
										if (_QS_interaction_commandSurrender) then {
											_QS_interaction_commandSurrender = FALSE;
											player removeAction _QS_action_commandSurrender;
										};
									};
								} else {
									if (_QS_interaction_commandSurrender) then {
										_QS_interaction_commandSurrender = FALSE;
										player removeAction _QS_action_commandSurrender;
									};
								};
							} else {
								if (_QS_interaction_commandSurrender) then {
									_QS_interaction_commandSurrender = FALSE;
									player removeAction _QS_action_commandSurrender;
								};
							};
						} else {
							if (_QS_interaction_commandSurrender) then {
								_QS_interaction_commandSurrender = FALSE;
								player removeAction _QS_action_commandSurrender;
							};
						};
					} else {
						if (_QS_interaction_commandSurrender) then {
							_QS_interaction_commandSurrender = FALSE;
							player removeAction _QS_action_commandSurrender;
						};
					};

					/*/===== Action Rescue/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorTarget) then {
							if (_cursorDistance < 4) then {
								if (_cursorTarget isKindOf 'Man') then {
									if (alive _cursorTarget) then {
										if (captive _cursorTarget) then {
											if (isNull (objectParent _cursorTarget)) then {
												if (isNull (attachedTo _cursorTarget)) then {
													if (!isNil {_cursorTarget getVariable 'QS_rescueable'}) then {
														if (_cursorTarget getVariable 'QS_rescueable') then {
															if (!(_QS_interaction_rescue)) then {
																_QS_interaction_rescue = TRUE;
																_QS_action_rescue = player addAction _QS_action_rescue_array;
																player setUserActionText [_QS_action_rescue,((player actionParams _QS_action_rescue) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rescue) select 0)])];
															};
														} else {
															if (_QS_interaction_rescue) then {
																_QS_interaction_rescue = FALSE;
																player removeAction _QS_action_rescue; 
															};
														};
													} else {
														if (_QS_interaction_rescue) then {
															_QS_interaction_rescue = FALSE;
															player removeAction _QS_action_rescue; 
														};
													};
												} else {
													if (_QS_interaction_rescue) then {
														_QS_interaction_rescue = FALSE;
														player removeAction _QS_action_rescue; 
													};
												};
											} else {
												if (_QS_interaction_rescue) then {
													_QS_interaction_rescue = FALSE;
													player removeAction _QS_action_rescue; 
												};
											};
										} else {
											if (_QS_interaction_rescue) then {
												_QS_interaction_rescue = FALSE;
												player removeAction _QS_action_rescue; 
											};
										};
									} else {
										if (_QS_interaction_rescue) then {
											_QS_interaction_rescue = FALSE;
											player removeAction _QS_action_rescue; 
										};
									};
								} else {
									if (_QS_interaction_rescue) then {
										_QS_interaction_rescue = FALSE;
										player removeAction _QS_action_rescue; 
									};
								};
							} else { 
								if (_QS_interaction_rescue) then {
									_QS_interaction_rescue = FALSE;
									player removeAction _QS_action_rescue; 
								};
							};
						} else {
							if (_QS_interaction_rescue) then {
								_QS_interaction_rescue = FALSE;
								player removeAction _QS_action_rescue; 
							};
						};
					} else {
						if (_QS_interaction_rescue) then {
							_QS_interaction_rescue = FALSE;
							player removeAction _QS_action_rescue; 
						};
					};

					/*/===== Action Secure/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if (_cursorObject getVariable ['QS_secureable',FALSE]) then {
									if (isNil {_cursorObject getVariable 'QS_secured'}) then {
										if (!isObjectHidden _cursorObject) then {
											if (!(_QS_interaction_secure)) then {
												_QS_interaction_secure = TRUE;
												_QS_action_secure_array set [2,[_cursorTarget,_cursorObject]];
												_QS_action_secure = player addAction _QS_action_secure_array;
												player setUserActionText [_QS_action_secure,((player actionParams _QS_action_secure) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_secure) select 0)])];
											};
										} else {
											if (_QS_interaction_secure) then {
												_QS_interaction_secure = FALSE;
												player removeAction _QS_action_secure;
											};
										};
									} else {
										if (_QS_interaction_secure) then {
											_QS_interaction_secure = FALSE;
											player removeAction _QS_action_secure;
										};
									};
								} else {
									if (_QS_interaction_secure) then {
										_QS_interaction_secure = FALSE;
										player removeAction _QS_action_secure;
									};
								};
							} else {
								if (_QS_interaction_secure) then {
									_QS_interaction_secure = FALSE;
									player removeAction _QS_action_secure;
								};
							};
						} else {
							if (_QS_interaction_secure) then {
								_QS_interaction_secure = FALSE;
								player removeAction _QS_action_secure;
							};
						};
					} else {
						if (_QS_interaction_secure) then {
							_QS_interaction_secure = FALSE;
							player removeAction _QS_action_secure;
						};
					};
					
					/*/===== Action Examine/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if ((_cursorObjectDistance < 2.7) || {((!alive _cursorObject) && (_cursorObject isKindOf 'Man') && ((player distance2D _cursorObject) < 3.2))}) then {
								if (_cursorObject getVariable ['QS_entity_examine',FALSE]) then {
									if (!(_cursorObject getVariable ['QS_entity_examined',FALSE])) then {
										if (!(player getVariable ['QS_client_examining',FALSE])) then {
											if (!isObjectHidden _cursorObject) then {
												if (!(_QS_interaction_examine)) then {
													_QS_interaction_examine = TRUE;
													_QS_action_examine_array set [2,[_cursorTarget,_cursorObject]];
													_QS_action_examine = player addAction _QS_action_examine_array;
													player setUserActionText [_QS_action_examine,((player actionParams _QS_action_examine) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_examine) select 0)])];
												};
											} else {
												if (_QS_interaction_examine) then {
													_QS_interaction_examine = FALSE;
													player removeAction _QS_action_examine;
												};
											};
										} else {
											if (_QS_interaction_examine) then {
												_QS_interaction_examine = FALSE;
												player removeAction _QS_action_examine;
											};
										};
									} else {
										if (_QS_interaction_examine) then {
											_QS_interaction_examine = FALSE;
											player removeAction _QS_action_examine;
										};
									};
								} else {
									if (_QS_interaction_examine) then {
										_QS_interaction_examine = FALSE;
										player removeAction _QS_action_examine;
									};
								};
							} else {
								if (_QS_interaction_examine) then {
									_QS_interaction_examine = FALSE;
									player removeAction _QS_action_examine;
								};
							};
						} else {
							if (_QS_interaction_examine) then {
								_QS_interaction_examine = FALSE;
								player removeAction _QS_action_examine;
							};
						};
					} else {
						if (_QS_interaction_examine) then {
							_QS_interaction_examine = FALSE;
							player removeAction _QS_action_examine;
						};
					};
					
					
					/*/===== Action turret safety/*/

					if (!isNull _objectParent) then {
						if (_QS_v2Type in _QS_turretSafety_heliTypes) then {
							if (player isEqualTo (driver _QS_v2)) then {
								if (!(missionNamespace getVariable 'QS_inturretloop')) then {
									if (!(_QS_interaction_turretSafety)) then {
										_QS_interaction_turretSafety = TRUE;
										_QS_action_turretSafety = player addAction _QS_action_turretSafety_array;
										player setUserActionText [_QS_action_turretSafety,((player actionParams _QS_action_turretSafety) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_turretSafety) select 0)])];
									};
								} else {
									if (_QS_interaction_turretSafety) then {
										_QS_interaction_turretSafety = FALSE;
										player removeAction _QS_action_turretSafety;
									};
								};
							} else {
								if (_QS_interaction_turretSafety) then {
									_QS_interaction_turretSafety = FALSE;
									player removeAction _QS_action_turretSafety;
								};
							};
						} else {
							if (_QS_interaction_turretSafety) then {
								_QS_interaction_turretSafety = FALSE;
								player removeAction _QS_action_turretSafety;
							};
						};
					} else {
						if (_QS_interaction_turretSafety) then {
							_QS_interaction_turretSafety = FALSE;
							player removeAction _QS_action_turretSafety;
						};
					};

					/*/===== Ear Collector/*/
		
					if (isNull _objectParent) then {
						if (!isNull _cursorTarget) then {
							if (_cursorDistance < 3) then {
								if (_cursorTarget isKindOf 'Man') then {
									if (!alive _cursorTarget) then {
										if (!isNil {_cursorTarget getVariable 'QS_collectible_ears'}) then {
											if (_cursorTarget getVariable 'QS_collectible_ears') then {
												if (!isNil {_cursorTarget getVariable 'QS_ears_remaining'}) then {
													if ((_cursorTarget getVariable 'QS_ears_remaining') > 0) then {
														if (!(_QS_interaction_ears)) then {
															_QS_interaction_ears = TRUE;
															_QS_action_ears = player addAction _QS_action_ears_array;
															player setUserActionText [_QS_action_ears,((player actionParams _QS_action_ears) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_ears) select 0)])];
														};
													} else {
														if (_QS_interaction_ears) then {
															_QS_interaction_ears = FALSE;
															player removeAction _QS_action_ears;
														};
													};
												} else {
													if (_QS_interaction_ears) then {
														_QS_interaction_ears = FALSE;
														player removeAction _QS_action_ears;
													};
												};
											} else {
												if (_QS_interaction_ears) then {
													_QS_interaction_ears = FALSE;
													player removeAction _QS_action_ears;
												};
											};
										} else {
											if (_QS_interaction_ears) then {
												_QS_interaction_ears = FALSE;
												player removeAction _QS_action_ears;
											};
										};
									} else {
										if (_QS_interaction_ears) then {
											_QS_interaction_ears = FALSE;
											player removeAction _QS_action_ears;
										};
									};
								} else {
									if (_QS_interaction_ears) then {
										_QS_interaction_ears = FALSE;
										player removeAction _QS_action_ears;
									};
								};
							} else {
								if (_QS_interaction_ears) then {
									_QS_interaction_ears = FALSE;
									player removeAction _QS_action_ears;
								};
							};
						} else {
							if (_QS_interaction_ears) then {
								_QS_interaction_ears = FALSE;
								player removeAction _QS_action_ears;
							};
						};
					} else {
						if (_QS_interaction_ears) then {
							_QS_interaction_ears = FALSE;
							player removeAction _QS_action_ears;
						};
					};
					
					/*/===== Tooth Collector/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorTarget) then {
							if (_cursorDistance < 3) then {
								if (_cursorTarget isKindOf 'Man') then {
									if (!alive _cursorTarget) then {
										if (!isNil {_cursorTarget getVariable 'QS_collectible_tooth'}) then {
											if (_cursorTarget getVariable 'QS_collectible_tooth') then {
												if (!(_QS_interaction_teeth)) then {
													_QS_interaction_teeth = TRUE;
													_QS_action_teeth = player addAction _QS_action_teeth_array;
													player setUserActionText [_QS_action_teeth,((player actionParams _QS_action_teeth) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_teeth) select 0)])];
												};
											} else {
												if (_QS_interaction_teeth) then {
													_QS_interaction_teeth = FALSE;
													player removeAction _QS_action_teeth;
												};
											};
										} else {
											if (_QS_interaction_teeth) then {
												_QS_interaction_teeth = FALSE;
												player removeAction _QS_action_teeth;
											};
										};
									} else {
										if (_QS_interaction_teeth) then {
											_QS_interaction_teeth = FALSE;
											player removeAction _QS_action_teeth;
										};
									};
								} else {
									if (_QS_interaction_teeth) then {
										_QS_interaction_teeth = FALSE;
										player removeAction _QS_action_teeth;
									};
								};
							} else {
								if (_QS_interaction_teeth) then {
									_QS_interaction_teeth = FALSE;
									player removeAction _QS_action_teeth;
								};
							};
						} else {
							if (_QS_interaction_teeth) then {
								_QS_interaction_teeth = FALSE;
								player removeAction _QS_action_teeth;
							};
						};
					} else {
						if (_QS_interaction_teeth) then {
							_QS_interaction_teeth = FALSE;
							player removeAction _QS_action_teeth;
						};
					};
					
					/*/===== Join Group/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorTarget) then {
							if (_cursorDistance < 5) then {
								if (_cursorTarget isKindOf 'Man') then {
									if (alive _cursorTarget) then {
										if (isPlayer _cursorTarget) then {
											if (!((group _cursorTarget) isEqualTo (group player))) then {
												_grpTarget = group _cursorTarget;
												if ((isNil {_grpTarget getVariable _QS_joinGroup_privateVar}) || ((!isNil {_grpTarget getVariable _QS_joinGroup_privateVar}) && (!(_grpTarget getVariable _QS_joinGroup_privateVar)))) then {
													if (!(_QS_interaction_joinGroup)) then {
														_QS_interaction_joinGroup = TRUE;
														_QS_action_joinGroup = player addAction _QS_action_joinGroup_array;
														player setUserActionText [_QS_action_joinGroup,((player actionParams _QS_action_joinGroup) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_joinGroup) select 0)])];
													};
												} else {
													if (_QS_interaction_joinGroup) then {
														_QS_interaction_joinGroup = FALSE;
														player removeAction _QS_action_joinGroup;
													};
												};
											} else {
												if (_QS_interaction_joinGroup) then {
													_QS_interaction_joinGroup = FALSE;
													player removeAction _QS_action_joinGroup;
												};
											};
										} else {
											if (_QS_interaction_joinGroup) then {
												_QS_interaction_joinGroup = FALSE;
												player removeAction _QS_action_joinGroup;
											};
										};
									} else {
										if (_QS_interaction_joinGroup) then {
											_QS_interaction_joinGroup = FALSE;
											player removeAction _QS_action_joinGroup;
										};
									};
								} else {
									if (_QS_interaction_joinGroup) then {
										_QS_interaction_joinGroup = FALSE;
										player removeAction _QS_action_joinGroup;
									};
								};
							} else {
								if (_QS_interaction_joinGroup) then {
									_QS_interaction_joinGroup = FALSE;
									player removeAction _QS_action_joinGroup;
								};
							};
						} else {
							if (_QS_interaction_joinGroup) then {
								_QS_interaction_joinGroup = FALSE;
								player removeAction _QS_action_joinGroup;
							};
						};
					} else {
						if (_QS_interaction_joinGroup) then {
							_QS_interaction_joinGroup = FALSE;
							player removeAction _QS_action_joinGroup;
						};
					};

					/*/===== Action Terminal FOB Status/*/

					if (!isNull _cursorObject) then {
						if (_cursorObjectDistance < 3) then {
							_QS_action_fob_terminals = [];
							{
								if (!isNull _x) then {
									0 = _QS_action_fob_terminals pushBack _x;
								};
							} count [
								(missionNamespace getVariable 'QS_module_fob_dataTerminal'),
								(missionNamespace getVariable 'QS_module_fob_baseDataTerminal')
							];
							if (!(_QS_action_fob_terminals isEqualTo [])) then {
								if (_cursorObject in _QS_action_fob_terminals) then {
									if (!(_QS_interaction_fob_status)) then {
										_QS_interaction_fob_status = TRUE;
										_QS_action_fob_status = player addAction _QS_action_fob_status_array;
										player setUserActionText [_QS_action_fob_status,((player actionParams _QS_action_fob_status) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_status) select 0)])];
									};
								} else {
									if (_QS_interaction_fob_status) then {
										_QS_interaction_fob_status = FALSE;
										player removeAction _QS_action_fob_status;
									};
								};
							} else {
								if (_QS_interaction_fob_status) then {
									_QS_interaction_fob_status = FALSE;
									player removeAction _QS_action_fob_status;
								};
							};
						} else {
							if (_QS_interaction_fob_status) then {
								_QS_interaction_fob_status = FALSE;
								player removeAction _QS_action_fob_status;
							};
						};
					} else {
						if (_QS_interaction_fob_status) then {
							_QS_interaction_fob_status = FALSE;
							player removeAction _QS_action_fob_status;
						};
					};
					
					/*/===== Action Activate FOB/*/
					
					if (!isNull _cursorObject) then {
						if (_cursorObjectDistance < 3) then {
							if (_cursorObject isEqualTo (missionNamespace getVariable 'QS_module_fob_dataTerminal')) then {
								if (!((missionNamespace getVariable 'QS_module_fob_side') isEqualTo WEST)) then {
									if (!(_QS_interaction_fob_activate)) then {
										_QS_interaction_fob_activate = TRUE;
										_QS_action_fob_activate = player addAction _QS_action_fob_activate_array;
										player setUserActionText [_QS_action_fob_activate,((player actionParams _QS_action_fob_activate) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_activate) select 0)])];
									};
								} else {
									if (_QS_interaction_fob_activate) then {
										_QS_interaction_fob_activate = FALSE;
										player removeAction _QS_action_fob_activate;
									};
								};
							} else {
								if (_QS_interaction_fob_activate) then {
									_QS_interaction_fob_activate = FALSE;
									player removeAction _QS_action_fob_activate;
								};
							};
						} else {
							if (_QS_interaction_fob_activate) then {
								_QS_interaction_fob_activate = FALSE;
								player removeAction _QS_action_fob_activate;
							};
						};
					} else {
						if (_QS_interaction_fob_activate) then {
							_QS_interaction_fob_activate = FALSE;
							player removeAction _QS_action_fob_activate;
						};
					};
					
					/*/===== Action Enable Player Respawn/*/

					if (!isNull _cursorObject) then {
						if (_cursorObjectDistance < 3) then {
							if (_cursorObject isEqualTo (missionNamespace getVariable 'QS_module_fob_dataTerminal')) then {
								if (!(missionNamespace getVariable 'QS_module_fob_client_respawnEnabled')) then {
									if (!(_QS_interaction_fob_respawn)) then {
										_QS_interaction_fob_respawn = TRUE;
										_QS_action_fob_respawn = player addAction _QS_action_fob_respawn_array;
										player setUserActionText [_QS_action_fob_respawn,((player actionParams _QS_action_fob_respawn) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_respawn) select 0)])];
									};
								} else {
									if (_QS_interaction_fob_respawn) then {
										_QS_interaction_fob_respawn = FALSE;
										player removeAction _QS_action_fob_respawn;
									};
								};
							} else {
								if (_QS_interaction_fob_respawn) then {
									_QS_interaction_fob_respawn = FALSE;
									player removeAction _QS_action_fob_respawn;
								};
							};
						} else {
							if (_QS_interaction_fob_respawn) then {
								_QS_interaction_fob_respawn = FALSE;
								player removeAction _QS_action_fob_respawn;
							};
						};
					} else {
						if (_QS_interaction_fob_respawn) then {
							_QS_interaction_fob_respawn = FALSE;
							player removeAction _QS_action_fob_respawn;
						};
					};
					
					/*/===== Customize Crates/*/
					
					if (isNull _objectParent) then {
						if (_cursorObjectDistance < 3) then {
							if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Reammobox_F')}) then {
								if (simulationEnabled _cursorObject) then {
									if (!(_cursorObject getVariable ['QS_inventory_disabled',FALSE])) then {
										_nearInvSite = FALSE;
										{
											if ((_x isEqualTo 'QS_marker_veh_inventoryService_01') && ((_cursorObject distance2D (markerPos _x)) < 5)) exitWith {
												_nearInvSite = TRUE;
											};
											if ((_x isEqualTo 'QS_marker_crate_area') && ((_cursorObject distance2D (markerPos _x)) < 50)) exitWith {
												_nearInvSite = TRUE;
											};							
										} count (missionNamespace getVariable 'QS_veh_inventory_mkrs');
										if (_nearInvSite) then {
											if (!(_QS_interaction_customizeCrate)) then {
												_QS_interaction_customizeCrate = TRUE;
												_QS_action_crate_customize = player addAction _QS_action_crate_array;
												player setUserActionText [_QS_action_crate_customize,((player actionParams _QS_action_crate_customize) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_crate_customize) select 0)])];
											};
										} else {
											if (_QS_interaction_customizeCrate) then {
												_QS_interaction_customizeCrate = FALSE;
												player removeAction _QS_action_crate_customize;
											};
										};
									} else {
										if (_QS_interaction_customizeCrate) then {
											_QS_interaction_customizeCrate = FALSE;
											player removeAction _QS_action_crate_customize;
										};
									};
								} else {
									if (_QS_interaction_customizeCrate) then {
										_QS_interaction_customizeCrate = FALSE;
										player removeAction _QS_action_crate_customize;
									};
								};
							} else {
								if (_QS_interaction_customizeCrate) then {
									_QS_interaction_customizeCrate = FALSE;
									player removeAction _QS_action_crate_customize;
								};
							};
						} else {
							if (_QS_interaction_customizeCrate) then {
								_QS_interaction_customizeCrate = FALSE;
								player removeAction _QS_action_crate_customize;
							};
						};
					} else {
						if (_QS_interaction_customizeCrate) then {
							_QS_interaction_customizeCrate = FALSE;
							player removeAction _QS_action_crate_customize;
						};
					};
					
					/*/===== Action push vehicle/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObject isKindOf 'Ship') then {
								if ((_cursorObjectDistance <= 2) && (_cursorObject isEqualTo _cursorTarget)) then {
									if (alive _cursorObject) then {
										if (({(alive _x)} count (crew _cursorObject)) isEqualTo 0) then {
											if (!(_QS_interaction_pushVehicle)) then {
												_QS_interaction_pushVehicle = TRUE;
												_QS_action_pushVehicle = player addAction _QS_action_pushVehicle_array;
												player setUserActionText [_QS_action_pushVehicle,((player actionParams _QS_action_pushVehicle) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_pushVehicle) select 0)])];
											};
										} else {
											if (_QS_interaction_pushVehicle) then {
												_QS_interaction_pushVehicle = FALSE;
												player removeAction _QS_action_pushVehicle;
											};
										};
									} else {
										if (_QS_interaction_pushVehicle) then {
											_QS_interaction_pushVehicle = FALSE;
											player removeAction _QS_action_pushVehicle;
										};
									};
								} else {
									if (_QS_interaction_pushVehicle) then {
										_QS_interaction_pushVehicle = FALSE;
										player removeAction _QS_action_pushVehicle;
									};
								};
							} else {
								if (_QS_interaction_pushVehicle) then {
									_QS_interaction_pushVehicle = FALSE;
									player removeAction _QS_action_pushVehicle;
								};
							};
						} else {
							if (_QS_interaction_pushVehicle) then {
								_QS_interaction_pushVehicle = FALSE;
								player removeAction _QS_action_pushVehicle;
							};
						};
					} else {
						if (_QS_interaction_pushVehicle) then {
							_QS_interaction_pushVehicle = FALSE;
							player removeAction _QS_action_pushVehicle;
						};
					};
					
					/*/===== Action Create Boat/*/
					
					if (_iamengineer) then {
						if (isNull _objectParent) then {
							if (surfaceIsWater _QS_posWorldPlayer) then {
								if ('ToolKit' in (items player)) then {
									if (((getPosASL player) select 2) < 0) then {
										if (!(_QS_interaction_createBoat)) then {
											_QS_interaction_createBoat = TRUE;
											_QS_action_createBoat = player addAction _QS_action_createBoat_array;
											player setUserActionText [_QS_action_createBoat,((player actionParams _QS_action_createBoat) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_createBoat) select 0)])];
										};
									} else {
										if (_QS_interaction_createBoat) then {
											_QS_interaction_createBoat = FALSE;
											player removeAction _QS_action_createBoat;
										};						
									};
								} else {
									if (_QS_interaction_createBoat) then {
										_QS_interaction_createBoat = FALSE;
										player removeAction _QS_action_createBoat;
									};
								};
							} else {
								if (_QS_interaction_createBoat) then {
									_QS_interaction_createBoat = FALSE;
									player removeAction _QS_action_createBoat;
								};
							};
						} else {
							if (_QS_interaction_createBoat) then {
								_QS_interaction_createBoat = FALSE;
								player removeAction _QS_action_createBoat;
							};
						};
					};
					
					/*/===== Sit/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance < 2) then {
								if ((stance _QS_player) isEqualTo 'STAND') then {
									if (((typeOf _cursorObject) in _QS_action_sit_chairTypes) || {(((getModelInfo _cursorObject) select 0) in _QS_action_sit_chairModels)}) then {
										if (isNull (attachedTo _cursorObject)) then {
											if ((attachedObjects _cursorObject) isEqualTo []) then {
												if (!(_QS_interaction_sit)) then {
													_QS_interaction_sit = TRUE;
													_QS_action_sit = player addAction _QS_action_sit_array;
													player setUserActionText [_QS_action_sit,((player actionParams _QS_action_sit) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_sit) select 0)])];
												};
											} else {
												if (_QS_interaction_sit) then {
													_QS_interaction_sit = FALSE;
													player removeAction _QS_action_sit;
												};
											};
										} else {
											if (_QS_interaction_sit) then {
												_QS_interaction_sit = FALSE;
												player removeAction _QS_action_sit;
											};
										};
									} else {
										if (_QS_interaction_sit) then {
											_QS_interaction_sit = FALSE;
											player removeAction _QS_action_sit;
										};
									};
								} else {
									if (_QS_interaction_sit) then {
										_QS_interaction_sit = FALSE;
										player removeAction _QS_action_sit;
									};
								};
							} else {
								if (_QS_interaction_sit) then {
									_QS_interaction_sit = FALSE;
									player removeAction _QS_action_sit;
								};
							};
						} else {
							if (_QS_interaction_sit) then {
								_QS_interaction_sit = FALSE;
								player removeAction _QS_action_sit;
							};
						};
					} else {
						if (_QS_interaction_sit) then {
							_QS_interaction_sit = FALSE;
							player removeAction _QS_action_sit;
						};
					};
					
					/*/===== Cargo Load/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance < 4) then {
								if ((_cursorObject isKindOf 'Reammobox_F') || {((typeOf _cursorObject) in _QS_action_loadCargo_cargoTypes)}) then {
									if (alive _cursorObject) then {
										if (simulationEnabled _cursorObject) then {
											if (isNull (attachedTo _cursorObject)) then {
												if (!(isSimpleObject _cursorObject)) then {
													if (isNull (isVehicleCargo _cursorObject)) then {
														_nearCargoVehicles = (getPosATL _cursorObject) nearEntities [['Air','LandVehicle'],21];
														if (!(_nearCargoVehicles isEqualTo [])) then {
															if (_QS_action_loadCargo_validated) then {
																_QS_action_loadCargo_validated = FALSE;
																_QS_action_loadCargo_vehicle = objNull;
															};
															{
																if ((!isNil {_x getVariable 'QS_ViV_v'}) || {((toLower (typeOf _x)) in _QS_action_loadCargo_vTypes)} || {(isClass (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'VehicleTransport' >> 'Carrier'))}) exitWith {
																	if (vehicleCargoEnabled _x) then {
																		if (isNil {_x getVariable 'QS_ViV_v'}) then {
																			_x setVariable ['QS_ViV_v',TRUE,TRUE];
																		};
																		_QS_action_loadCargo_validated = TRUE;
																		_QS_action_loadCargo_vehicle = _x;
																	};
																};
															} count _nearCargoVehicles;
															if (_QS_action_loadCargo_validated) then {
																if (!(_QS_interaction_loadCargo)) then {
																	_QS_interaction_loadCargo = TRUE;
																	_QS_action_loadCargo_array set [2,[_cursorObject,_QS_action_loadCargo_vehicle]];
																	_QS_action_loadCargo = player addAction _QS_action_loadCargo_array;
																	player setUserActionText [_QS_action_loadCargo,((player actionParams _QS_action_loadCargo) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_loadCargo) select 0)])];
																};
															} else {
																if (_QS_interaction_loadCargo) then {
																	_QS_interaction_loadCargo = FALSE;
																	_QS_action_loadCargo_array set [2,[]];
																	player removeAction _QS_action_loadCargo;
																};
															};
														} else {
															if (_QS_interaction_loadCargo) then {
																_QS_interaction_loadCargo = FALSE;
																_QS_action_loadCargo_array set [2,[]];
																player removeAction _QS_action_loadCargo;
															};
														};
													} else {
														if (_QS_interaction_loadCargo) then {
															_QS_interaction_loadCargo = FALSE;
															_QS_action_loadCargo_array set [2,[]];
															player removeAction _QS_action_loadCargo;
														};
													};
												} else {
													if (_QS_interaction_loadCargo) then {
														_QS_interaction_loadCargo = FALSE;
														_QS_action_loadCargo_array set [2,[]];
														player removeAction _QS_action_loadCargo;
													};
												};
											} else {
												if (_QS_interaction_loadCargo) then {
													_QS_interaction_loadCargo = FALSE;
													_QS_action_loadCargo_array set [2,[]];
													player removeAction _QS_action_loadCargo;
												};
											};
										} else {
											if (_QS_interaction_loadCargo) then {
												_QS_interaction_loadCargo = FALSE;
												_QS_action_loadCargo_array set [2,[]];
												player removeAction _QS_action_loadCargo;
											};
										};
									} else {
										if (_QS_interaction_loadCargo) then {
											_QS_interaction_loadCargo = FALSE;
											_QS_action_loadCargo_array set [2,[]];
											player removeAction _QS_action_loadCargo;
										};
									};
								} else {
									if (_QS_interaction_loadCargo) then {
										_QS_interaction_loadCargo = FALSE;
										_QS_action_loadCargo_array set [2,[]];
										player removeAction _QS_action_loadCargo;
									};
								};
							} else {
								if (_QS_interaction_loadCargo) then {
									_QS_interaction_loadCargo = FALSE;
									_QS_action_loadCargo_array set [2,[]];
									player removeAction _QS_action_loadCargo;
								};
							};
						} else {
							if (_QS_interaction_loadCargo) then {
								_QS_interaction_loadCargo = FALSE;
								_QS_action_loadCargo_array set [2,[]];
								player removeAction _QS_action_loadCargo;
							};
						};
					} else {
						if (_QS_interaction_loadCargo) then {
							_QS_interaction_loadCargo = FALSE;
							_QS_action_loadCargo_array set [2,[]];
							player removeAction _QS_action_loadCargo;
						};
					};
					
					/*/===== Action Load 2/*/
					
					if (!isNull _cursorObject) then {
						if (isNull _objectParent) then {
							if (_cursorObjectDistance <= 4) then {
								if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'Air')}) then {
									if (alive _cursorObject) then {
										if ((locked _cursorObject) in [-1,0,1]) then {
											if ((!((attachedObjects player) isEqualTo [])) && (({([0,_x,_cursorObject] call _fn_getCustomCargoParams)} count (attachedObjects player)) > 0)) then {
												{
													_object = _x;
													if (!isNull _object) then {
														if (!((toLower (typeOf _object)) isEqualTo _QS_helmetCam_helperType)) then {
															if (([0,_object,_cursorObject] call _fn_getCustomCargoParams) || {([_cursorObject,_object] call _fn_isValidCargoV)}) then {
																if (([1,_object,_cursorObject] call _fn_getCustomCargoParams) || {([_cursorObject,_object] call _fn_isValidCargoV)}) then {
																	if (!(_QS_interaction_load2)) then {
																		_QS_interaction_load2 = TRUE;
																		_QS_action_load_array set [2,[_object,_cursorObject]];
																		_QS_action_load = player addAction _QS_action_load_array;
																		player setUserActionText [_QS_action_load,((player actionParams _QS_action_load) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_load) select 0)])];
																	};
																} else {
																	if (_QS_interaction_load2) then {
																		_QS_interaction_load2 = FALSE;
																		_QS_action_load_array set [2,[]];
																		player removeAction _QS_action_load;
																	};
																};
															} else {
																if (_QS_interaction_load2) then {
																	_QS_interaction_load2 = FALSE;
																	_QS_action_load_array set [2,[]];
																	player removeAction _QS_action_load;
																};
															};
														};
													};
												} count (attachedObjects player);
											} else {
												if (_QS_interaction_load2) then {
													_QS_interaction_load2 = FALSE;
													_QS_action_load_array set [2,[]];
													player removeAction _QS_action_load;
												};
											};	
										} else {
											if (_QS_interaction_load2) then {
												_QS_interaction_load2 = FALSE;
												_QS_action_load_array set [2,[]];
												player removeAction _QS_action_load;
											};
										};
									} else {
										if (_QS_interaction_load2) then {
											_QS_interaction_load2 = FALSE;
											_QS_action_load_array set [2,[]];
											player removeAction _QS_action_load;
										};
									};	
								} else {
									if (_QS_interaction_load2) then {
										_QS_interaction_load2 = FALSE;
										_QS_action_load_array set [2,[]];
										player removeAction _QS_action_load;
									};
								};	
							} else {
								if (_QS_interaction_load2) then {
									_QS_interaction_load2 = FALSE;
									_QS_action_load_array set [2,[]];
									player removeAction _QS_action_load;
								};
							};
						} else {
							if (_QS_interaction_load2) then {
								_QS_interaction_load2 = FALSE;
								_QS_action_load_array set [2,[]];
								player removeAction _QS_action_load;
							};
						};
					} else {
						if (_QS_interaction_load2) then {
							_QS_interaction_load2 = FALSE;
							_QS_action_load_array set [2,[]];
							player removeAction _QS_action_load;
						};
					};
					
					/*/===== Action Unload Cargo/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {				
								if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'Air')}) then {
									if (simulationEnabled _cursorObject) then {
										if (!((attachedObjects _cursorObject) isEqualTo [])) then {
											if (!(({(([0,_x,_cursorObject] call _fn_getCustomCargoParams) && (!(_x getVariable ['QS_interaction_disabled',FALSE])))} count (attachedObjects _cursorObject)) isEqualTo 0)) then {
												if (!(_QS_interaction_unloadCargo)) then {
													_QS_interaction_unloadCargo = TRUE;
													_QS_action_unloadCargo = player addAction _QS_action_unloadCargo_array;
													player setUserActionText [_QS_action_unloadCargo,((player actionParams _QS_action_unloadCargo) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unloadCargo) select 0)])];
												};
											} else {
												if (_QS_interaction_unloadCargo) then {
													_QS_interaction_unloadCargo = FALSE;
													player removeAction _QS_action_unloadCargo;
												};
											};
										} else {
											if (_QS_interaction_unloadCargo) then {
												_QS_interaction_unloadCargo = FALSE;
												player removeAction _QS_action_unloadCargo;
											};
										};
									} else {
										if (_QS_interaction_unloadCargo) then {
											_QS_interaction_unloadCargo = FALSE;
											player removeAction _QS_action_unloadCargo;
										};
									};
								} else {
									if (_QS_interaction_unloadCargo) then {
										_QS_interaction_unloadCargo = FALSE;
										player removeAction _QS_action_unloadCargo;
									};
								};
							} else {
								if (_QS_interaction_unloadCargo) then {
									_QS_interaction_unloadCargo = FALSE;
									player removeAction _QS_action_unloadCargo;
								};
							};
						} else {
							if (_QS_interaction_unloadCargo) then {
								_QS_interaction_unloadCargo = FALSE;
								player removeAction _QS_action_unloadCargo;
							};
						};
					} else {
						if (_QS_interaction_unloadCargo) then {
							_QS_interaction_unloadCargo = FALSE;
							player removeAction _QS_action_unloadCargo;
						};
					};

					/*/===== Action Activate Vehicle/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 3) then {
								if (isSimpleObject _cursorObject) then {
									if (!((typeOf _cursorObject) isEqualTo '')) then {
										if (_cursorObject isKindOf 'AllVehicles') then {
											if (((_isTanoa) && ((_cursorObject distance2D [5762,10367,0]) > 500)) || {((_isAltis) && ((_cursorObject distance2D [3476.77,13108.7,0]) > 500))} || {((!(_isAltis)) && (!(_isTanoa)))}) then {
												if (!(_cursorObject getVariable ['QS_v_disableProp',FALSE])) then {
													if (!(_QS_interaction_activateVehicle)) then {
														_QS_interaction_activateVehicle = TRUE;
														_QS_action_activateVehicle = player addAction _QS_action_activateVehicle_array;
														player setUserActionText [_QS_action_activateVehicle,((player actionParams _QS_action_activateVehicle) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_activateVehicle) select 0)])];
													};
												} else {
													if (_QS_interaction_activateVehicle) then {
														_QS_interaction_activateVehicle = FALSE;
														player removeAction _QS_action_activateVehicle;
													};
												};
											} else {
												if (_QS_interaction_activateVehicle) then {
													_QS_interaction_activateVehicle = FALSE;
													player removeAction _QS_action_activateVehicle;
												};
											};
										} else {
											if (_QS_interaction_activateVehicle) then {
												_QS_interaction_activateVehicle = FALSE;
												player removeAction _QS_action_activateVehicle;
											};
										};
									} else {
										if (_QS_interaction_activateVehicle) then {
											_QS_interaction_activateVehicle = FALSE;
											player removeAction _QS_action_activateVehicle;
										};
									};
								} else {
									if (_QS_interaction_activateVehicle) then {
										_QS_interaction_activateVehicle = FALSE;
										player removeAction _QS_action_activateVehicle;
									};
								};
							} else {
								if (_QS_interaction_activateVehicle) then {
									_QS_interaction_activateVehicle = FALSE;
									player removeAction _QS_action_activateVehicle;
								};
							};
						} else {
							if (_QS_interaction_activateVehicle) then {
								_QS_interaction_activateVehicle = FALSE;
								player removeAction _QS_action_activateVehicle;
							};
						};
					} else {
						if (_QS_interaction_activateVehicle) then {
							_QS_interaction_activateVehicle = FALSE;
							player removeAction _QS_action_activateVehicle;
						};
					};
					
					/*/===== Action Med Station/*/
					
					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if (isSimpleObject _cursorObject) then {
									if ((toLower ((getModelInfo _cursorObject) select 1)) in _QS_action_medevac_models) then {
										if ((({(!(_x isEqualTo 0))} count ((getAllHitPointsDamage player) select 2)) > 0) || {((damage player) > 0)}) then {
											if (!(_QS_interaction_huronContainer)) then {
												_QS_interaction_huronContainer = TRUE;
												_QS_action_huronContainer = player addAction _QS_action_huronContainer_array;
												player setUserActionText [_QS_action_huronContainer,((player actionParams _QS_action_huronContainer) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_huronContainer) select 0)])];
											};
										} else {
											if (_QS_interaction_huronContainer) then {
												_QS_interaction_huronContainer = FALSE;
												player removeAction _QS_action_huronContainer;
											};
										};
									} else {
										if (_QS_interaction_huronContainer) then {
											_QS_interaction_huronContainer = FALSE;
											player removeAction _QS_action_huronContainer;
										};
									};
								} else {
									if (_QS_interaction_huronContainer) then {
										_QS_interaction_huronContainer = FALSE;
										player removeAction _QS_action_huronContainer;
									};
								};
							} else {
								if (_QS_interaction_huronContainer) then {
									_QS_interaction_huronContainer = FALSE;
									player removeAction _QS_action_huronContainer;
								};
							};
						} else {
							if (_QS_interaction_huronContainer) then {
								_QS_interaction_huronContainer = FALSE;
								player removeAction _QS_action_huronContainer;
							};
						};
					} else {
						if (_QS_interaction_huronContainer) then {
							_QS_interaction_huronContainer = FALSE;
							player removeAction _QS_action_huronContainer;
						};
					};
					
					/*/===== Action Sensor Target/*/

					if (_QS_interaction_sensorTarget_canReport) then {
						if (!((binocular player) isEqualTo '')) then {
							if ((currentWeapon player) isEqualTo (binocular player)) then {
								if ((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'StaticWeapon')}) then {
									if (({(alive _x)} count (crew _cursorObject)) > 0) then {
										if (alive (effectiveCommander _cursorObject)) then {
											if ((side (effectiveCommander _cursorObject)) in [EAST,RESISTANCE]) then {
												if (!(_QS_interaction_sensorTarget)) then {
													_QS_interaction_sensorTarget = TRUE;
													_QS_action_sensorTarget = player addAction _QS_action_sensorTarget_array;
													player setUserActionText [_QS_action_sensorTarget,((player actionParams _QS_action_sensorTarget) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_sensorTarget) select 0)])];
												};
											} else {
												if (_QS_interaction_sensorTarget) then {
													_QS_interaction_sensorTarget = FALSE;
													player removeAction _QS_action_sensorTarget;
												};
											};
										} else {
											if (_QS_interaction_sensorTarget) then {
												_QS_interaction_sensorTarget = FALSE;
												player removeAction _QS_action_sensorTarget;
											};
										};
									} else {
										if (_QS_interaction_sensorTarget) then {
											_QS_interaction_sensorTarget = FALSE;
											player removeAction _QS_action_sensorTarget;
										};
									};
								} else {
									if (_QS_interaction_sensorTarget) then {
										_QS_interaction_sensorTarget = FALSE;
										player removeAction _QS_action_sensorTarget;
									};
								};
							} else {
								if (_QS_interaction_sensorTarget) then {
									_QS_interaction_sensorTarget = FALSE;
									player removeAction _QS_action_sensorTarget;
								};
							};
						} else {
							if (_QS_interaction_sensorTarget) then {
								_QS_interaction_sensorTarget = FALSE;
								player removeAction _QS_action_sensorTarget;
							};
						};
					};
					
					/*/===== Action Attach Exp (Underwater)/*/

					if (isNull _objectParent) then {
						if (!isNull _cursorObject) then {
							if (_cursorObjectDistance <= 2) then {
								if (((side _cursorObject) in [EAST,RESISTANCE]) || {(_cursorObject getVariable ['QS_client_canAttachExp',FALSE])}) then {
									if (((getPosASL player) select 2) < 0) then {
										if ('DemoCharge_Remote_Mag' in (magazines player)) then {
											if (!(_QS_interaction_attachExp)) then {
												_QS_interaction_attachExp = TRUE;
												_QS_userActionText = format ['%1 (%2 left)',_QS_action_attachExp_text,({(_x isEqualTo 'DemoCharge_Remote_Mag')} count (magazines player))];
												_QS_action_attachExp_array set [0,_QS_userActionText];
												_QS_action_attachExp = player addAction _QS_action_attachExp_array;
												player setUserActionText [_QS_action_attachExp,_QS_userActionText,(format ["<t size='3'>%1</t>",_QS_userActionText])];
											} else {
												_QS_userActionText = format ['%1 (%2 left)',_QS_action_attachExp_text,({(_x isEqualTo 'DemoCharge_Remote_Mag')} count (magazines player))];
												player setUserActionText [_QS_action_attachExp,_QS_userActionText,(format ["<t size='3'>%1</t>",_QS_userActionText])];
											};
										} else {
											if (_QS_interaction_attachExp) then {
												_QS_interaction_attachExp = FALSE;
												player removeAction _QS_action_attachExp;
											};
										};
									} else {
										if (_QS_interaction_attachExp) then {
											_QS_interaction_attachExp = FALSE;
											player removeAction _QS_action_attachExp;
										};
									};
								} else {
									if (_QS_interaction_attachExp) then {
										_QS_interaction_attachExp = FALSE;
										player removeAction _QS_action_attachExp;
									};
								};
							} else {
								if (_QS_interaction_attachExp) then {
									_QS_interaction_attachExp = FALSE;
									player removeAction _QS_action_attachExp;
								};
							};
						} else {
							if (_QS_interaction_attachExp) then {
								_QS_interaction_attachExp = FALSE;
								player removeAction _QS_action_attachExp;
							};
						};
					} else {
						if (_QS_interaction_attachExp) then {
							_QS_interaction_attachExp = FALSE;
							player removeAction _QS_action_attachExp;
						};
					};

					/*/===== UGV/*/
					
					if ((_QS_isUAVOperator) || {(!isNull (getAssignedCuratorLogic _QS_player))}) then {
						if (unitIsUav _QS_cO) then {
							if ((toLower (typeOf _QS_cO)) in _QS_action_ugv_types) then {
								if (isTouchingGround _QS_cO) then {
									if (((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1) then {
										if (!((attachedObjects _QS_cO) isEqualTo [])) then {
											if (!(({(((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel) && (!(isObjectHidden _x)))} count (attachedObjects _QS_cO)) isEqualTo 0)) then {
												if (!(_QS_ugv isEqualTo _QS_cO)) then {
													_QS_ugv = _QS_cO;
												};
												comment 'Load';
												if (({(_x isKindOf 'CAManBase')} count (attachedObjects _QS_cO)) < ({((toLower ((getModelInfo _x) select 1)) isEqualTo _QS_action_ugv_stretcherModel)} count (attachedObjects _QS_cO))) then {
													_listOfFrontStuff = ((_QS_cO getRelPos [3,0]) nearEntities ['CAManBase',3]) select {(((lifeState _x) isEqualTo 'INCAPACITATED') && (isNull (attachedTo _x)) && (isNull (objectParent _x)) && (!(_x getVariable ['QS_unit_needsStabilise',FALSE])))};	/*/unit needs to be stabilised first?/*/
													if (!(_listOfFrontStuff isEqualTo [])) then {
														if (!(_QS_interaction_ugvLoad)) then {
															_QS_interaction_ugvLoad = TRUE;
															_QS_action_ugvLoad_array set [2,[_QS_ugv,4]];
															_QS_action_ugvLoad = _QS_ugv addAction _QS_action_ugvLoad_array;
															_QS_ugv setUserActionText [_QS_action_ugvLoad,((_QS_ugv actionParams _QS_action_ugvLoad) select 0),(format ["<t size='3'>%1</t>",((_QS_ugv actionParams _QS_action_ugvLoad) select 0)])];
														};
													} else {
														if (_QS_interaction_ugvLoad) then {
															_QS_interaction_ugvLoad = FALSE;
															_QS_ugv removeAction _QS_action_ugvLoad;
														};
													};
												} else {
													if (_QS_interaction_ugvLoad) then {
														_QS_interaction_ugvLoad = FALSE;
														_QS_ugv removeAction _QS_action_ugvLoad;
													};
												};
												
												comment 'Unload';
												
												if (!(({((_x isKindOf 'CAManBase') && (alive _x))} count (attachedObjects _QS_cO)) isEqualTo 0)) then {
													if (!(_QS_interaction_ugvUnload)) then {
														_QS_interaction_ugvUnload = TRUE;
														_QS_action_ugvUnload_array set [2,[_QS_ugv,5]];
														_QS_action_ugvUnload = _QS_ugv addAction _QS_action_ugvUnload_array;
														_QS_ugv setUserActionText [_QS_action_ugvUnload,((_QS_ugv actionParams _QS_action_ugvUnload) select 0),(format ["<t size='3'>%1</t>",((_QS_ugv actionParams _QS_action_ugvUnload) select 0)])];
													};
												} else {
													if (_QS_interaction_ugvUnload) then {
														_QS_interaction_ugvUnload = FALSE;
														_QS_ugv removeAction _QS_action_ugvUnload;
													};
												};
												
											} else {
												if (_QS_interaction_ugvLoad) then {
													_QS_interaction_ugvLoad = FALSE;
													_QS_ugv removeAction _QS_action_ugvLoad;
												};
												if (_QS_interaction_ugvUnload) then {
													_QS_interaction_ugvUnload = FALSE;
													_QS_ugv removeAction _QS_action_ugvUnload;
												};
											};
										} else {
											if (_QS_interaction_ugvLoad) then {
												_QS_interaction_ugvLoad = FALSE;
												_QS_ugv removeAction _QS_action_ugvLoad;
											};
											if (_QS_interaction_ugvUnload) then {
												_QS_interaction_ugvUnload = FALSE;
												_QS_ugv removeAction _QS_action_ugvUnload;
											};
										};
									} else {
										if (_QS_interaction_ugvLoad) then {
											_QS_interaction_ugvLoad = FALSE;
											_QS_ugv removeAction _QS_action_ugvLoad;
										};
										if (_QS_interaction_ugvUnload) then {
											_QS_interaction_ugvUnload = FALSE;
											_QS_ugv removeAction _QS_action_ugvUnload;
										};
									};
								} else {
									if (_QS_interaction_ugvLoad) then {
										_QS_interaction_ugvLoad = FALSE;
										_QS_ugv removeAction _QS_action_ugvLoad;
									};
									if (_QS_interaction_ugvUnload) then {
										_QS_interaction_ugvUnload = FALSE;
										_QS_ugv removeAction _QS_action_ugvUnload;
									};
								};
							} else {
								if (_QS_interaction_ugvLoad) then {
									_QS_interaction_ugvLoad = FALSE;
									_QS_ugv removeAction _QS_action_ugvLoad;
								};
								if (_QS_interaction_ugvUnload) then {
									_QS_interaction_ugvUnload = FALSE;
									_QS_ugv removeAction _QS_action_ugvUnload;
								};
							};
						} else {
							if (_QS_interaction_ugvLoad) then {
								_QS_interaction_ugvLoad = FALSE;
								_QS_ugv removeAction _QS_action_ugvLoad;
							};
							if (_QS_interaction_ugvUnload) then {
								_QS_interaction_ugvUnload = FALSE;
								_QS_ugv removeAction _QS_action_ugvUnload;
							};
						};
						
						/*/===== UAV Service/*/

						if (unitIsUav _QS_cO) then {
							if (!(_QS_uav isEqualTo _QS_cO)) then {
								_QS_uav = _QS_cO;
							};
							if (!(missionNamespace getVariable 'QS_repairing_vehicle')) then {
								if (((speed _QS_uav) < 1) && ((speed _QS_uav) > -1)) then {
									_nearSite = FALSE;
									{
										if ((_QS_uav distance (markerPos _x)) < 12) exitWith {
											_nearSite = TRUE;
										};
									} count (missionNamespace getVariable 'QS_veh_repair_mkrs');
									if (_nearSite) then {
										if (!(_QS_interaction_serviceDrone)) then {
											_QS_interaction_serviceDrone = TRUE;
											_QS_action_serviceVehicle = _QS_uav addAction _QS_action_serviceVehicle_array;
											_QS_uav setUserActionText [_QS_action_serviceVehicle,((_QS_uav actionParams _QS_action_serviceVehicle) select 0),(format ["<t size='3'>%1</t>",((_QS_uav actionParams _QS_action_serviceVehicle) select 0)])];
										};
									} else {
										if (_QS_interaction_serviceDrone) then {
											_QS_interaction_serviceDrone = FALSE;
											_QS_uav removeAction _QS_action_serviceVehicle;
										};
									};
								} else {
									if (_QS_interaction_serviceDrone) then {
										_QS_interaction_serviceDrone = FALSE;
										_QS_uav removeAction _QS_action_serviceVehicle;
									};
								};
							} else {
								if (_QS_interaction_serviceDrone) then {
									_QS_interaction_serviceDrone = FALSE;
									_QS_uav removeAction _QS_action_serviceVehicle;
								};
							};
						} else {
							if (_QS_interaction_serviceDrone) then {
								_QS_interaction_serviceDrone = FALSE;
								_QS_uav removeAction _QS_action_serviceVehicle;
							};
						};
						
						/*/===== UGV Tow/*/
						if (unitIsUav _QS_cO) then {
							if (!(_QS_ugvTow isEqualTo _QS_cO)) then {
								_QS_ugvTow = _QS_cO;
							};
							if ((toLower (typeOf _QS_ugvTow)) in _QS_action_ugv_types) then {
								if (((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1) then {
									if ((_QS_ugvTow getVariable ['QS_tow_veh',-1]) > 0) then {
										if (canMove _QS_ugvTow) then {
											if (({((alive _x) && (_x isKindOf 'Man'))} count (attachedObjects _QS_ugvTow)) isEqualTo 0) then {
												if ([_QS_ugvTow] call _fn_vTowable) then {
													if (!(_QS_interaction_towUGV)) then {
														_QS_interaction_towUGV = TRUE;
														_QS_action_towUGV = _QS_ugvTow addAction _QS_action_tow_array;
														_QS_ugvTow setUserActionText [_QS_action_towUGV,((_QS_ugvTow actionParams _QS_action_towUGV) select 0),(format ["<t size='3'>%1</t>",((_QS_ugvTow actionParams _QS_action_towUGV) select 0)])];
													};
												} else {
													if (_QS_interaction_towUGV) then {
														_QS_interaction_towUGV = FALSE;
														_QS_ugvTow removeAction _QS_action_towUGV;
													};
												};
											} else {
												if (_QS_interaction_towUGV) then {
													_QS_interaction_towUGV = FALSE;
													_QS_ugvTow removeAction _QS_action_towUGV;
												};
											};
										} else {
											if (_QS_interaction_towUGV) then {
												_QS_interaction_towUGV = FALSE;
												_QS_ugvTow removeAction _QS_action_towUGV;
											};
										};		
									} else {
										if (_QS_interaction_towUGV) then {
											_QS_interaction_towUGV = FALSE;
											_QS_ugvTow removeAction _QS_action_towUGV;
										};
									};
								} else {
									if (_QS_interaction_towUGV) then {
										_QS_interaction_towUGV = FALSE;
										_QS_ugvTow removeAction _QS_action_towUGV;
									};
								};
							} else {
								if (_QS_interaction_towUGV) then {
									_QS_interaction_towUGV = FALSE;
									_QS_ugvTow removeAction _QS_action_towUGV;
								};
							};
						} else {
							if (_QS_interaction_towUGV) then {
								_QS_interaction_towUGV = FALSE;
								_QS_ugvTow removeAction _QS_action_towUGV;
							};
						};
						/*/UAV self destruct/*/
						if (unitIsUav _QS_cO) then {
							if (!(_QS_ugvSD isEqualTo _QS_cO)) then {
								_QS_ugvSD = _QS_cO;
							};
							if (local _QS_ugvSD) then {
								if ((!(canMove _QS_ugvSD)) || {((fuel _QS_ugvSD) isEqualTo 0)}) then {
									if ((_QS_ugvSD distance2D _QS_module_safezone_pos) > 600) then {
										if (!(_QS_interaction_uavSelfDestruct)) then {
											_QS_interaction_uavSelfDestruct = TRUE;
											_QS_action_uavSelfDestruct = _QS_ugvSD addAction _QS_action_uavSelfDestruct_array;
											_QS_ugvSD setUserActionText [_QS_action_uavSelfDestruct,((_QS_ugvSD actionParams _QS_action_uavSelfDestruct) select 0),(format ["<t size='3'>%1</t>",((_QS_ugvSD actionParams _QS_action_uavSelfDestruct) select 0)])];
										};
									} else {
										if (_QS_interaction_uavSelfDestruct) then {
											_QS_interaction_uavSelfDestruct = FALSE;
											_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
										};
									};
								} else {
									if (_QS_interaction_uavSelfDestruct) then {
										_QS_interaction_uavSelfDestruct = FALSE;
										_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
									};
								};
							} else {
								if (_QS_interaction_uavSelfDestruct) then {
									_QS_interaction_uavSelfDestruct = FALSE;
									_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
								};
							};
						} else {
							if (_QS_interaction_uavSelfDestruct) then {
								_QS_interaction_uavSelfDestruct = FALSE;
								_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
							};
						};
					};

					if ((!(_QS_carrierEnabled isEqualTo 0)) && (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull]))) then {
						if (_QS_cO isKindOf 'Plane') then {
							if (unitIsUav _QS_cO) then {
								_QS_carrier_cameraOn = _QS_cO;
							} else {
								if ((alive (driver _QS_cO)) && (local (driver _QS_cO))) then {
								/*/if (player isEqualTo (driver _QS_cO)) then {/*/
									_QS_carrier_cameraOn = _QS_cO;
								};
							};
							if (canMove _QS_carrier_cameraOn) then {
								if (((vectorMagnitude (velocity _QS_carrier_cameraOn)) * 3.6) < 30) then {
									if ((_QS_carrier_cameraOn distance2D (missionNamespace getVariable 'QS_carrierObject')) < 150) then {
										if ((_QS_carrier_cameraOn animationPhase 'wing_fold_l') isEqualTo 0) then {
											if (_QS_carrier_inPolygon) then {
												_QS_carrier_inPolygon = FALSE;
											};
											_QS_carrierPos = getPosWorld _QS_carrier_cameraOn;
											{
												_QS_carrierLaunchData = _x;
												_QS_carrierPolygon = (_QS_carrierLaunchData select 0) apply {((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x)};
												if (_QS_carrierPos inPolygon _QS_carrierPolygon) exitWith {
													_QS_carrier_inPolygon = TRUE;
												};
											} forEach _fn_data_carrierLaunch;
											if (_QS_carrier_inPolygon) then {
												if (!(_QS_interaction_carrierLaunch)) then {
													_QS_interaction_carrierLaunch = TRUE;
													_QS_action_carrierLaunch = _QS_carrier_cameraOn addAction _QS_action_carrierLaunch_array;
													_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Initiate Launch Sequence','<t size="3">Initiate Launch Sequence</t>'];
												};
												if (_QS_carrier_cameraOn getVariable ['QS_carrier_launch',FALSE]) then {
													if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) select 0) isEqualTo 'Initiate Launch Sequence') then {
														_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Launch','<t size="3">Launch</t>'];
													};
												} else {
													if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) select 0) isEqualTo 'Launch') then {
														_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Initiate Launch Sequence','<t size="3">Initiate Launch Sequence</t>'];
													};
												};
											} else {
												if (_QS_interaction_carrierLaunch) then {
													_QS_interaction_carrierLaunch = FALSE;
													_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
												};
											};
										} else {
											if (_QS_interaction_carrierLaunch) then {
												_QS_interaction_carrierLaunch = FALSE;
												_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
											};
										};
									} else {
										if (_QS_interaction_carrierLaunch) then {
											_QS_interaction_carrierLaunch = FALSE;
											_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
										};
									};
								} else {
									if (_QS_interaction_carrierLaunch) then {
										_QS_interaction_carrierLaunch = FALSE;
										_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
									};
								};
							} else {
								if (_QS_interaction_carrierLaunch) then {
									_QS_interaction_carrierLaunch = FALSE;
									_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
								};
							};
						} else {
							if (_QS_interaction_carrierLaunch) then {
								_QS_interaction_carrierLaunch = FALSE;
								_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
							};
						};
					} else {
						if (_QS_interaction_carrierLaunch) then {
							_QS_interaction_carrierLaunch = FALSE;
							_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
						};
					};

					/*/===== Action Rappelling/*/
					
					if (_QS_rappelling) then {
						/*/===== Action Rappel Self/*/
						if (!isNull _objectParent) then {
							if (_QS_v2 isKindOf 'Air') then {
								if ((_QS_v2 distance2D _QS_module_safezone_pos) > 500) then {
									if ([player,_QS_v2] call _fn_ARRappelFromHeliActionCheck) then {
										if (!(_QS_interaction_rappelSelf)) then {
											_QS_interaction_rappelSelf = TRUE;
											_QS_action_rappelSelf = player addAction _QS_action_rappelSelf_array;
											player setUserActionText [_QS_action_rappelSelf,((player actionParams _QS_action_rappelSelf) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelSelf) select 0)])];
										};
									} else {
										if (_QS_interaction_rappelSelf) then {
											_QS_interaction_rappelSelf = FALSE;
											player removeAction _QS_action_rappelSelf;
										};
									};
									if ([player] call _fn_ARRappelAIUnitsFromHeliActionCheck) then {
										if (!(_QS_interaction_rappelAI)) then {
											_QS_interaction_rappelAI = TRUE;
											_QS_action_rappelAI = player addAction _QS_action_rappelAI_array;
											player setUserActionText [_QS_action_rappelAI,((player actionParams _QS_action_rappelAI) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelAI) select 0)])];
										};
									} else {
										if (_QS_interaction_rappelAI) then {
											_QS_interaction_rappelAI = FALSE;
											player removeAction _QS_action_rappelAI;
										};
									};
									if (_iAmPilot) then {
										if (_QS_v2 isKindOf 'Helicopter') then {
											if (player isEqualTo (effectiveCommander _QS_v2)) then {
												if (!(_QS_interaction_rappelSafety)) then {
													_QS_interaction_rappelSafety = TRUE;
													if (isNil {_QS_v2 getVariable 'QS_rappellSafety'}) then {
														_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textDisable];
													} else {
														_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textEnable];
													};
													_QS_action_rappelSafety = player addAction _QS_action_rappelSafety_array;
													player setUserActionText [_QS_action_rappelSafety,((player actionParams _QS_action_rappelSafety) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelSafety) select 0)])];
												} else {
													if (isNil {_QS_v2 getVariable 'QS_rappellSafety'}) then {
														if ((_QS_action_rappelSafety_array select 0) isEqualTo _QS_action_rappelSafety_textEnable) then {
															_QS_interaction_rappelSafety = FALSE;
															player removeAction _QS_action_rappelSafety;
														};
													} else {
														if ((_QS_action_rappelSafety_array select 0) isEqualTo _QS_action_rappelSafety_textDisable) then {
															_QS_interaction_rappelSafety = FALSE;
															player removeAction _QS_action_rappelSafety;
														};
													};
												};
											} else {
												if (_QS_interaction_rappelSafety) then {
													_QS_interaction_rappelSafety = FALSE;
													player removeAction _QS_action_rappelSafety;
												};
											};	
										} else {
											if (_QS_interaction_rappelSafety) then {
												_QS_interaction_rappelSafety = FALSE;
												player removeAction _QS_action_rappelSafety;
											};
										};
									};
								} else {
									if (_QS_interaction_rappelSelf) then {
										_QS_interaction_rappelSelf = FALSE;
										player removeAction _QS_action_rappelSelf;
									};
									if (_QS_interaction_rappelAI) then {
										_QS_interaction_rappelAI = FALSE;
										player removeAction _QS_action_rappelAI;
									};
									if (_QS_interaction_rappelSafety) then {
										_QS_interaction_rappelSafety = FALSE;
										player removeAction _QS_action_rappelSafety;
									};
								};
							} else {
								if (_QS_interaction_rappelSelf) then {
									_QS_interaction_rappelSelf = FALSE;
									player removeAction _QS_action_rappelSelf;
								};
								if (_QS_interaction_rappelAI) then {
									_QS_interaction_rappelAI = FALSE;
									player removeAction _QS_action_rappelAI;
								};
								if (_QS_interaction_rappelSafety) then {
									_QS_interaction_rappelSafety = FALSE;
									player removeAction _QS_action_rappelSafety;
								};
							};
						} else {
							if (_QS_interaction_rappelSelf) then {
								_QS_interaction_rappelSelf = FALSE;
								player removeAction _QS_action_rappelSelf;
							};
							if (_QS_interaction_rappelAI) then {
								_QS_interaction_rappelAI = FALSE;
								player removeAction _QS_action_rappelAI;
							};
							if (_QS_interaction_rappelSafety) then {
								_QS_interaction_rappelSafety = FALSE;
								player removeAction _QS_action_rappelSafety;
							};
						};				
						/*/===== Action Rappel Detach/*/

						if ([player] call _fn_AIRappelDetachActionCheck) then {
							if (!(_QS_interaction_rappelDetach)) then {
								_QS_interaction_rappelDetach = TRUE;
								_QS_action_rappelDetach = player addAction _QS_action_rappelDetach_array;
								player setUserActionText [_QS_action_rappelDetach,((player actionParams _QS_action_rappelDetach) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelDetach) select 0)])];
							};
						} else {
							if (_QS_interaction_rappelDetach) then {
								_QS_interaction_rappelDetach = FALSE;
								player removeAction _QS_action_rappelDetach;
							};
						};	
					};
					
					/*/===== Action Release/*/
					
					if (({((!isNull _x) && ((_x isKindOf 'Man') || {([0,_x,objNull] call _fn_getCustomCargoParams)} || {(_x isKindOf 'StaticWeapon')}))} count (attachedObjects player)) > 0) then {
						{
							if ((_x isKindOf 'Man') || {([0,_x,objNull] call _fn_getCustomCargoParams)} || {(_x isKindOf 'StaticWeapon')}) then {
								if (!(_QS_interaction_release)) then {
									_QS_interaction_release = TRUE;
									_QS_action_release = player addAction _QS_action_release_array;
									player setUserActionText [_QS_action_release,((player actionParams _QS_action_release) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_release) select 0)])];
								};
								if (!isNil {_x getVariable 'QS_RD_escorted'}) then {
									if (_x getVariable 'QS_RD_escorted') then {
										if (!(_QS_interaction_release)) then {
											_QS_interaction_release = TRUE;
											_QS_action_release = player addAction _QS_action_release_array;
											player setUserActionText [_QS_action_release,((player actionParams _QS_action_release) select 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_release) select 0)])];
										};						
									};
								};
							};
						} count (attachedObjects player);
					} else {
						if (_QS_interaction_release) then {
							_QS_interaction_release = FALSE;
							player removeAction _QS_action_release;
							if (!isNil {player getVariable 'QS_RD_interacting'}) then {
								if (player getVariable 'QS_RD_interacting') then {
									player setVariable ['QS_RD_interacting',FALSE,TRUE];
								};
							};
							if (!isNil {player getVariable 'QS_RD_escorting'}) then {
								if (player getVariable 'QS_RD_escorting') then {
									player setVariable ['QS_RD_escorting',FALSE,TRUE];
								};
							};
							if (!isNil {player getVariable 'QS_RD_dragging'}) then {
								if (player getVariable 'QS_RD_dragging') then {
									player setVariable ['QS_RD_dragging',FALSE,TRUE];
									player playAction 'released';
								};
							};
							if (!isNil {player getVariable 'QS_RD_carrying'}) then {
								if (player getVariable 'QS_RD_carrying') then {
									player setVariable ['QS_RD_carrying',FALSE,TRUE];
									player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
								};
							};
						};
					};
				};
			};
		} else {
			if (!isNil {player getVariable 'QS_RD_interacting'}) then {
				if (player getVariable 'QS_RD_interacting') then {
					player setVariable ['QS_RD_interacting',FALSE,TRUE];
				};
			};
			if (!isNil {player getVariable 'QS_RD_carrying'}) then {
				if (player getVariable 'QS_RD_carrying') then {
					player setVariable ['QS_RD_carrying',FALSE,TRUE];
				};
			};
			if (!isNil {player getVariable 'QS_RD_dragging'}) then {
				if (player getVariable 'QS_RD_dragging') then {
					player setVariable ['QS_RD_dragging',FALSE,TRUE];
				};
			};
			if (!isNil {player getVariable 'QS_RD_escorting'}) then {
				if (player getVariable 'QS_RD_escorting') then {
					if (({((!isNull _x) && (_x isKindOf 'Man'))} count (attachedObjects player)) > 0) then {
						{
							if (_x isKindOf 'Man') then {
								_x setVariable ['QS_RD_escorted',FALSE,TRUE];
								_x setVariable ['QS_RD_interacted',FALSE,TRUE];
								_x setVariable ['QS_RD_interacting',FALSE,TRUE];
								detach _x;
							};
						} count (attachedObjects player);
					};
					player setVariable ['QS_RD_escorting',FALSE,TRUE];
				};
			};
		};
		if (!isNil {player getVariable 'QS_RD_interacting'}) then {
			if (player getVariable 'QS_RD_interacting') then {
				if (!isNil {player getVariable 'QS_RD_carrying'}) then {
					if (player getVariable 'QS_RD_carrying') then {
						if (((attachedObjects player) isEqualTo []) || {(({((!isNull _x) && (_x isKindOf 'Man'))} count (attachedObjects player)) isEqualTo 0)}) then {
							player setVariable ['QS_RD_carrying',FALSE,TRUE];
							player setVariable ['QS_RD_interacting',FALSE,TRUE];
							player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
						} else {
							{
								if (!isNull _x) then {
									if (_x isKindOf 'Man') then {
										if (!alive _x) then {
											detach _x;
											['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
											if (!isNil {_x getVariable 'QS_RD_carried'}) then {
												if (_x getVariable 'QS_RD_carried') then {
													player setVariable ['QS_RD_carrying',FALSE,TRUE];
													player setVariable ['QS_RD_interacting',FALSE,TRUE];
												};
											};
										};
									};
								};
							} count (attachedObjects player);
						};
					};
				};
				if (!isNil {player getVariable 'QS_RD_dragging'}) then {
					if (player getVariable 'QS_RD_dragging') then {
						if ((attachedObjects player) isEqualTo []) then {
							player setVariable ['QS_RD_dragging',FALSE,TRUE];
							player setVariable ['QS_RD_interacting',FALSE,TRUE];
							player playAction 'released';
						} else {
							if (({(!isNull _x)} count (attachedObjects player)) isEqualTo 0) then {
								player setVariable ['QS_RD_dragging',FALSE,TRUE];
								player setVariable ['QS_RD_interacting',FALSE,TRUE];
								player playAction 'released';						
							} else {
								{
									if (!isNull _x) then {
										if (_x isKindOf 'Man') then {
											if (!alive _x) then {
												detach _x;
												if (!isNil {_x getVariable 'QS_RD_dragged'}) then {
													if (_x getVariable 'QS_RD_dragged') then {
														player setVariable ['QS_RD_dragging',FALSE,TRUE];
														player setVariable ['QS_RD_interacting',FALSE,TRUE];
														player playAction 'released';
													};
												};
											};
										};
									};
								} count (attachedObjects player);							
							};
						};
					};
				};
				if (!isNil {player getVariable 'QS_RD_escorting'}) then {
					if (player getVariable 'QS_RD_escorting') then {
						if (((attachedObjects player) isEqualTo []) || {(({((!isNull _x) && (_x isKindOf 'Man'))} count (attachedObjects player)) isEqualTo 0)}) then {
							player setVariable ['QS_RD_escorting',FALSE,TRUE];
						} else {
							{
								if (_x isKindOf 'Man') then {
									if (!isNil {_x getVariable 'QS_RD_escorted'}) then {
										if (_x getVariable 'QS_RD_escorted') then {
											if ((isNull _x) || {(!alive _x)}) then {
												detach _x;
												player setVariable ['QS_RD_escorting',FALSE,TRUE];
											};
										};
									};
								};
							} count (attachedObjects player);
						};
						if (!(isNull (objectParent player))) then {
							if (({(!isNull _x)} count (attachedObjects player)) > 0) then {
								{
									if (_x isKindOf 'Man') then {
										detach _x;
										_x setVariable ['QS_RD_escorted',FALSE,TRUE];
										_x setVariable ['QS_RD_interacted',FALSE,TRUE];
										_x setVariable ['QS_RD_interacting',FALSE,TRUE];
										player setVariable ['QS_RD_escorting',FALSE,TRUE];
										player setVariable ['QS_RD_interacting',FALSE,TRUE];
									};
								} count (attachedObjects player);
							};
						};
					};
				};
			};
		};
	};
	
	/*/========== Fuel consumption module/*/

	if (_QS_module_fuelConsumption) then {
		if (_timeNow > _QS_module_fuelConsumption_checkDelay) then {
			if (!(isNull _objectParent)) then {
				if (local _QS_v2) then {
					if (!(_QS_module_fuelConsumption_vehicle isEqualTo _QS_v2)) then {
						_QS_module_fuelConsumption_vehicle = _QS_v2;
						if (isClass (configFile >> 'CfgVehicles' >> (typeOf _QS_module_fuelConsumption_vehicle) >> 'idleRpm')) then {
							_QS_module_fuelConsumption_rpmIdle = configFile >> 'CfgVehicles' >> (typeOf _QS_module_fuelConsumption_vehicle) >> 'idleRpm';
						} else {
							_QS_module_fuelConsumption_rpmIdle = 0;
						};
						if (isClass (configFile >> 'CfgVehicles' >> (typeOf _QS_module_fuelConsumption_vehicle) >> 'redRpm')) then {
							_QS_module_fuelConsumption_rpmRed = configFile >> 'CfgVehicles' >> (typeOf _QS_module_fuelConsumption_vehicle) >> 'redRpm';
						} else {
							_QS_module_fuelConsumption_rpmRed = 0;
						};
						if ((!(_QS_module_fuelConsumption_rpmIdle isEqualTo 0)) && (!(_QS_module_fuelConsumption_rpmRed isEqualTo 0))) then {
							_QS_module_fuelConsumption_useRPMFactor = TRUE;
						} else {
							_QS_module_fuelConsumption_useRPMFactor = FALSE;
						};
						_QS_module_fuelConsumption_rpmDiff = _QS_module_fuelConsumption_rpmRed - _QS_module_fuelConsumption_rpmIdle;
					};
					if (isEngineOn _QS_module_fuelConsumption_vehicle) then {
						if ((velocity _QS_module_fuelConsumption_vehicle) isEqualTo [0,0,0]) then {
							_QS_module_fuelConsumption_factor = _QS_module_fuelConsumption_factor_2;
						} else {
							if ((!isNull (getSlingLoad _QS_module_fuelConsumption_vehicle)) || {(!((getVehicleCargo _QS_module_fuelConsumption_vehicle) isEqualTo []))}) then {
								_QS_module_fuelConsumption_factor = _QS_module_fuelConsumption_factor_3;
							} else {
								_QS_module_fuelConsumption_factor = _QS_module_fuelConsumption_factor_1;
							};
							if (_QS_module_fuelConsumption_useRPMFactor) then {
								_QS_module_fuelConsumption_rpm = _QS_module_fuelConsumption_vehicle getSoundController 'rpm';
								_QS_module_fuelConsumption_factor = _QS_module_fuelConsumption_factor * ((_QS_module_fuelConsumption_rpm - _QS_module_fuelConsumption_rpmIdle) / _QS_module_fuelConsumption_rpmDiff);
							};
						};
						_QS_module_fuelConsumption_vehicle setFuel ((fuel _QS_module_fuelConsumption_vehicle) * _QS_module_fuelConsumption_factor);
					};
				};
			};
			_QS_module_fuelConsumption_checkDelay = time + _QS_module_fuelConsumption_delay;
		};
	};
	
	/*/========== Vehicle manifest display/*/
	
	if (_QS_module_crewIndicator) then {
		if (time > _QS_module_crewIndicator_checkDelay) then {
			if (!isNull _objectParent) then {
				if (!visibleMap) then {
					if (!('CrewDisplay' in ((infoPanel 'left') + (infoPanel 'right')))) then {
						if (!isStreamFriendlyUIEnabled) then {
							if (!(_QS_crewIndicator_shown)) then {
								_QS_crewIndicator_shown = TRUE;
								_QS_crewIndicatorIDD cutRsc ['QS_RD_dialog_crewIndicator','PLAIN'];
							};
							_QS_crewIndicatorUI = uiNamespace getVariable 'QS_RD_client_dialog_crewIndicator';
							if (!isNil {_QS_crewIndicatorUI}) then {
								_QS_crewIndicator = _QS_crewIndicatorUI displayCtrl _QS_crewIndicatorIDC;
								if (!isNull _objectParent) then {
									_fullCrew = fullCrew _QS_v2;
									if (!(_fullCrew isEqualTo [])) then {
										if (({(alive (_x select 0))} count _fullCrew) > 1) then {
											_crewManifest = '';
											for '_y' from 0 to ((count _fullCrew) - 1) do {
												_unit = (_fullCrew select _y) select 0;
												_role = toUpper ((_fullCrew select _y) select 1);
												_cargoIndex = (_fullCrew select _y) select 2;
												_turretPath = (_fullCrew select _y) select 3;
												_personTurret = (_fullCrew select _y) select 4;
												_text = '';
												_roleImg = '';
												_unitName = name _unit;
												if (!(_unitName isEqualTo 'Error: No unit')) then {
													if (_role isEqualTo 'DRIVER') then {
														_roleImg = _QS_crewIndicator_imgDriver;
													} else {
														if (_role isEqualTo 'COMMANDER') then {
															_roleImg = _QS_crewIndicator_imgCommander;
														} else {
															if (_role isEqualTo 'GUNNER') then {
																_roleImg = _QS_crewIndicator_imgGunner;
															} else {
																if (_role isEqualTo 'TURRET') then {
																	if (_personTurret) then {
																		_roleImg = _QS_crewIndicator_imgCargo;
																	} else {
																		_roleImg = _QS_crewIndicator_imgGunner;
																	};
																} else {
																	if (_role isEqualTo 'CARGO') then {
																		_roleImg = _QS_crewIndicator_imgCargo;
																	};
																};
															};
														};
													};
													if (!(_role isEqualTo 'DRIVER')) then {
														if (!(_turretPath isEqualTo [])) then {
															_text = format ["<img image=%1/><t size='0.666'>%2</t> <t size='0.75'>%3</t><br/>",_roleImg,(_turretPath select 0),_unitName];
														} else {
															_text = format ["<img image=%1/> <t size='0.75'>%2</t> <br/>",_roleImg,_unitName];
														};
													} else {
														_text = format ["<img image=%1/> <t size='1'>%2</t><br/>",_roleImg,_unitName];
													};
													_crewManifest = _crewManifest + _text;
												};
											};
											_QS_crewIndicator ctrlSetTextColor _QS_crewIndicator_color;
											_QS_crewIndicator ctrlSetStructuredText (parseText _crewManifest);
										} else {
											if (_QS_crewIndicator_shown) then {
												_QS_crewIndicator_shown = FALSE;
												_QS_crewIndicatorIDD cutText ['','PLAIN'];
											};
										};
									} else {
										if (_QS_crewIndicator_shown) then {
											_QS_crewIndicator_shown = FALSE;
											_QS_crewIndicatorIDD cutText ['','PLAIN'];
										};
									};
								} else {
									if (_QS_crewIndicator_shown) then {
										_QS_crewIndicator_shown = FALSE;
										_QS_crewIndicatorIDD cutText ['','PLAIN'];
									};
								};
							};
						} else {
							if (_QS_crewIndicator_shown) then {
								_QS_crewIndicator_shown = FALSE;
								_QS_crewIndicatorIDD cutText ['','PLAIN'];
							};
						};
					} else {
						if (_QS_crewIndicator_shown) then {
							_QS_crewIndicator_shown = FALSE;
							_QS_crewIndicatorIDD cutText ['','PLAIN'];
						};
					};
				} else {
					if (_QS_crewIndicator_shown) then {
						_QS_crewIndicator_shown = FALSE;
						_QS_crewIndicatorIDD cutText ['','PLAIN'];
					};				
				};
			} else {
				if (_QS_crewIndicator_shown) then {
					_QS_crewIndicator_shown = FALSE;
					_QS_crewIndicatorIDD cutText ['','PLAIN'];
				};
			};
			_QS_module_crewIndicator_checkDelay = _timeNow + _QS_module_crewIndicator_delay;
		};
	};
	
	if (_QS_module_gearManager) then {
		if (missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE]) then {
			missionNamespace setVariable ['QS_client_triggerGearCheck',FALSE,FALSE];
			//call _fn_gearRestrictions;	// not ready yet
			_QS_weapons = weapons player;
			_assignedItems = assignedItems player;
			_optics = primaryWeaponItems player;
			
			/*/===== Launchers/*/

			if (({(_x in _QS_weapons)} count _missileSpecialised) > 0) then {
				if (!(_playerClass in _missileSoldiers)) then {
					player removeWeapon (secondaryWeapon player);
					50 cutText [_restrictions_AT_msg,'PLAIN'];
				};
			};
			
			/*/===== Sniper Rifles/*/

			if (({(_x in _QS_weapons)} count _sniperSpecialised) > 0) then {
				if (!(_playerClass in _snipers)) then {
					player removeWeapon (primaryWeapon player);
					50 cutText [_restrictions_SNIPER_msg,'PLAIN'];
				};
			};
			/*/===== UAV Terminal/*/
			
			if (!(_QS_isUAVOperator)) then {
				if (({(_x in _assignedItems)} count _uavRestricted) > 0) then {
					if ('B_UavTerminal' in _assignedItems) then {
						player unassignItem 'B_UavTerminal';
						player removeItem 'B_UavTerminal';
					} else {
						if ('O_UavTerminal' in _assignedItems) then {
							player unassignItem 'O_UavTerminal';
							player removeItem 'O_UavTerminal';
						} else {
							if ('I_UavTerminal' in _assignedItems) then {
								player unassignItem 'I_UavTerminal';
								player removeItem 'I_UavTerminal';
							} else {
								if (!(_QS_side isEqualTo CIVILIAN)) then {
									if ('C_UavTerminal' in _assignedItems) then {
										player unassignItem 'C_UavTerminal';
										player removeItem 'C_UavTerminal';
									};
								};
							};
						};
					};
					50 cutText [_restrictions_UAV_msg,'PLAIN'];
				};
			} else {
				if (!(_QS_side isEqualTo CIVILIAN)) then {
					if ('C_UavTerminal' in _assignedItems) then {
						player unassignItem 'C_UavTerminal';
						player removeItem 'C_UavTerminal';
					};
				};
			};
			/*/===== Thermal optics/*/

			if (missionNamespace getVariable 'QS_restrict_Thermal') then {
				if (({_x in _optics} count _specialisedOptics) > 0) then {
					if (!(_playerClass in _opticsAllowed)) then {
						{player removePrimaryWeaponItem  _x;} count _specialisedOptics;
						if (_playerClass in ['B_sniper_F','B_ghillie_ard_F','B_ghillie_tna_F','B_T_sniper_F']) then {
							player addPrimaryWeaponItem 'optic_SOS';
						} else {
							player addPrimaryWeaponItem 'optic_Hamr';
						};
						50 cutText [_restrictions_OPTICS_msg,'PLAIN'];
					};
				};
			};
			
			/*/===== Sniper optics/*/

			if (missionNamespace getVariable 'QS_restrict_sOptics') then {
				if (({_x in _optics} count _sniperOpt) > 0) then {
					if (!(_playerClass in _sniperTeam)) then {
						{player removePrimaryWeaponItem  _x;} count _sniperOpt;
						player addPrimaryWeaponItem 'optic_DMS';
						50 cutText [_restrictions_SOPT_msg,'PLAIN'];
					};
				};
			};

			/*/===== LMG/*/
				
			if (missionNamespace getVariable 'QS_restrict_LMG') then {
				if (({(_x in _QS_weapons)} count _autoSpecialised) > 0) then {
					if (!(_playerClass in _autoRiflemen)) then {
						player removeWeapon (primaryWeapon player);
						50 cutText [_restrictions_MG_msg,'PLAIN'];
					};
				};
			};
			
			/*/===== Heavy MG/*/
			
			if (missionNamespace getVariable 'QS_restrict_HMG') then {
				if (({(_x in _QS_weapons)} count _hmgSpecialised) > 0) then {
					if (!(_playerClass in _hmg)) then {
						player removeWeapon (primaryWeapon player);
						50 cutText [_restrictions_MMG_msg,'PLAIN'];
					};
				};
			};
			
			/*/===== Marksmen/*/
			
			if (missionNamespace getVariable 'QS_restrict_Marksmen') then {
				if (({(_x in _QS_weapons)} count _marksmenSpecialised) > 0) then {
					if (!(_playerClass in _marksmen)) then {
						player removeWeapon (primaryWeapon player);
						50 cutText [_restrictions_MK_msg,'PLAIN'];
					};
				};
			};
			if (!((uniform player) in _uniformsWhitelisted)) then {
				player forceAddUniform _defaultUniform;
				50 cutText ['Uniform not whitelisted for use.','PLAIN',0.5];
			};
			if (!((backpack player) in _backpackWhitelisted)) then {
				removeBackpack player;
				50 cutText ['Backpack not whitelisted for use.','PLAIN',0.5];
			};
			if (!((vest player) in _vestsWhitelisted)) then {
				removeVest player;
				50 cutText ['Vest not whitelisted for use.','PLAIN',0.5];
			};
			if (_mineDispenser in (magazines player)) then {
				while {(_mineDispenser in (magazines player))} do {
					player removeMagazine _mineDispenser;
				};
			};
			_QS_module_gearManager_checkDelay = _timeNow + _QS_module_gearManager_delay;
		};
	};
	
	/*/========== Base safezone module/*/
	
	if (_QS_module_safezone) then {
		if (_timeNow > _QS_module_safezone_checkDelay) then {
			_allPlayers = allPlayers;
			if (((player distance2D _QS_module_safezone_pos) < _QS_module_safezone_radius) && (!(_QS_v2 isEqualTo (missionNamespace getVariable 'QS_arty')))) then {
				if (_QS_posWorldPlayer inPolygon _QS_baseAreaPolygon) then {
					if (!(_QS_v2 isKindOf 'Man')) then {
						if (local _QS_v2) then {
							if (isTouchingGround _QS_v2) then {
								[17,_QS_v2] remoteExec ['QS_fnc_remoteExec',2,FALSE];
								50 cutText ['Vehicles in the spawn area are prohibited.','PLAIN',1];
							};
						};
					};
				};
				if (!(_QS_safezone_action in (actionIDs player))) then {
					_QS_safezone_action = player addAction _QS_action_safezone_array;
					player setUserActionText [_QS_safezone_action,((player actionParams _QS_safezone_action) select 0),'',''];
				};
				if (isDamageAllowed player) then {
					player allowDamage FALSE;
				};
				if (!(_QS_module_safezone_isInSafezone)) then {
					_QS_module_safezone_isInSafezone = TRUE;
					if (_QS_module_safezone_playerProtection isEqualTo 1) then {
						if (_QS_module_safezone_speedlimit_enabled) then {
							_QS_module_safezone_speedlimit_event = addMissionEventHandler ['EachFrame',_QS_module_safezone_speedlimit_code];
						};
					};
				};	
			} else {
				if (_QS_module_safezone_isInSafezone) then {
					_QS_module_safezone_isInSafezone = FALSE;
					if (_QS_module_safezone_playerProtection isEqualTo 1) then {
						player removeAction _QS_safezone_action;
						/*/50 cutText ['Exiting safezone','PLAIN DOWN',0.25];/*/   /*/ ugly and intrusive on screen, IMO /*/
						_QS_safezone_action = -1;
						if (!isDamageAllowed player) then {
							player allowDamage TRUE;
						};
						if (_QS_module_safezone_speedlimit_enabled) then {
							removeMissionEventHandler ['EachFrame',_QS_module_safezone_speedlimit_event];
						};
					};
				};
			};
			_QS_module_safezone_checkDelay = _timeNow + _QS_module_safezone_delay;
		};
	};
	
	/*/=========== CLIENT RATING MANAGER/*/
	
	if (_QS_clientRatingManager) then {
		if (_timeNow > _QS_clientRatingManager_delay) then {
			if ((rating _QS_player) < 0) then {
				_QS_player addRating (0 - (rating _QS_player));
			};
			_QS_clientRatingManager_delay = _timeNow + 5;
		};
	};
	
	/*/=========== CLIENT RANK MANAGER /*/
	
	if (_QS_clientRankManager) then {
		if (_timeNow > _QS_clientRankManager_delay) then {
			if (_QS_player isEqualTo (leader (group _QS_player))) then {
				if ((count (units (group _QS_player))) > 1) then {
					if (!((rank _QS_player) isEqualTo 'LIEUTENANT')) then {
						_QS_player setRank 'LIEUTENANT';
					};
				} else {
					if (!((rank _QS_player) isEqualTo 'PRIVATE')) then {
						_QS_player setRank 'PRIVATE';
					};
				};
			} else {
				if (!((rank _QS_player) isEqualTo 'PRIVATE')) then {
					_QS_player setRank 'PRIVATE';
				};
			};
			_QS_clientRankManager_delay = _timeNow + 10;
		};
	};
	
	/*/=========== CLIENT GROUP MANAGER /*/

	if (_QS_clientDynamicGroups) then {
		if (_timeNow > _QS_clientDynamicGroups_checkDelay) then {
			if (isNull (findDisplay 60490)) then {
				if ((count _allPlayers) > 3) then {
					_QS_playerGroup = group player;
					if ((count (units _QS_playerGroup)) < 2) then {
						if (!(_QS_playerGroup getVariable [_QS_joinGroup_privateVar,FALSE])) then {
							if ((player distance2D _QS_module_safezone_pos) > 1000) then {
								{
									_QS_clientDynamicGroups_testGrp = group _x;
									if (!(_QS_clientDynamicGroups_testGrp getVariable [_QS_joinGroup_privateVar,FALSE])) then {
										if ((count (units _QS_clientDynamicGroups_testGrp)) > 2) exitWith {
											[player] joinSilent _QS_clientDynamicGroups_testGrp;
										};
									};
								} count _allPlayers;
							};
						};
					};
				};
				_QS_clientDynamicGroups_checkDelay = _timeNow + _QS_clientDynamicGroups_delay;
			};
		};
	};
	
	/*/=========== ROBOCOP /*/

	if (_QS_clientATManager) then {
		if (_timeNow > _QS_clientATManager_delay) then {
			if (!isNull (laserTarget player)) then {
				_QS_laserTarget = laserTarget player;
				if ((_QS_laserTarget distance2D _QS_module_safezone_pos) < 500) then {
					deleteVehicle _QS_laserTarget;
				};
			};
			if (!isNull (laserTarget _QS_v2)) then {
				_QS_laserTarget = laserTarget _QS_v2;
				if (local _QS_laserTarget) then {
					if ((_QS_laserTarget distance2D _QS_module_safezone_pos) < 500) then {
						[17,_QS_laserTarget] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
				};
			};
			if (!isNil {player getVariable 'QS_tto'}) then {
				_QS_tto = player getVariable 'QS_tto';
				if (_QS_tto > 7) then {
					/*/	Too risky now that code is exposed
					[_QS_terminalVelocity] spawn {
						_QS_terminalVelocity = _this select 0;
						if (!(userInputDisabled)) then {
							disableUserInput TRUE;
						};
						moveOut player;
						detach player;
						uiSleep 1.5;
						for '_x' from 0 to 1 step 0 do {
							(vehicle player) setVelocity _QS_terminalVelocity;
						};
					};
					/*/
				} else {
					if (_QS_tto > 6) then {
						if (!(userInputDisabled)) then {
							disableUserInput TRUE;
						};
					} else {
						if (_QS_tto > 5) then {
							endMission 'END1';
						};
					};
				};
				if (_QS_tto > 3) then {
					if (!(_QS_underEnforcement)) then {
						_QS_underEnforcement = TRUE;
						_QS_enforcement_loop = [_profileName,_QS_terminalVelocity] spawn {
							private ['_QS_v','_QS_tto','_QS_exitingEnforcedVehicle','_QS_exitingEnforcedVehicle_loop'];
							_n = _this select 0;
							_QS_terminalVelocity = _this select 1;
							_QS_exitingEnforcedVehicle = FALSE;
							_QS_exitingEnforcedVehicle_loop = nil;
							for '_x' from 0 to 1 step 0 do {
								_QS_tto = player getVariable 'QS_tto';
								_QS_v = vehicle player;
								if (!isNull (objectParent player)) then {
									if (
										(player isEqualTo (driver _QS_v)) ||
										{(player isEqualTo (gunner _QS_v))} ||
										{(player isEqualTo (commander _QS_v))} ||
										{(player isEqualTo (_QS_v turretUnit [0]))} ||
										{(player isEqualTo (_QS_v turretUnit [1]))} ||
										{(player isEqualTo (_QS_v turretUnit [2]))} ||
										{(player isEqualTo (effectiveCommander _QS_v))}
									) then {
										if (!(_QS_exitingEnforcedVehicle)) then {
											_QS_exitingEnforcedVehicle = TRUE;
											_QS_exitingEnforcedVehicle_loop = [] spawn {
												moveOut player;
												uiSleep 1.5;
											};
										} else {
											if (scriptDone _QS_exitingEnforcedVehicle_loop) then {
												_QS_exitingEnforcedVehicle = FALSE;
											};
										};
									};
								};
								if (_QS_tto > 7) then {
									[_QS_terminalVelocity] spawn {
										_QS_terminalVelocity = _this select 0;
										if (!(userInputDisabled)) then {
											disableUserInput TRUE;
										};
										moveOut player;
										detach player;
										uiSleep 1.5;
										for '_x' from 0 to 1 step 0 do {
											player setVelocity _QS_terminalVelocity;
										};
									};
								} else {
									if (_QS_tto > 6) then {
										if (!(userInputDisabled)) then {
											disableUserInput TRUE;
										};
									} else {
										if (_QS_tto > 5) then {
											endMission 'END1';
										};
									};
								};
								if (_QS_tto <= 3) exitWith {};
								uiSleep 0.025;
							};
						};
					} else {
						if (scriptDone _QS_enforcement_loop) then {
							_QS_underEnforcement = FALSE;
						};
					};
				} else {
					if (_QS_tto > 1) then {
						if (_thermalsEnabled) then {
							_thermalsEnabled = FALSE;
							player disableTIEquipment TRUE;
						};
						if (_QS_artyEnabled) then {
							_QS_artyEnabled = FALSE;
							enableEngineArtillery FALSE;
						};
					};
				};
			};
			_QS_clientATManager_delay = _timeNow + 5;
		};
	};
	
	/*/========== 3PV/*/
	
	if (cameraView isEqualTo 'EXTERNAL') then {
		if (!isNull _QS_cO) then {
			if ((side _QS_cO) in _enemysides) then {
				if (!((lifeState _QS_player) isEqualTo 'INCAPACITATED')) then {
					_QS_player switchCamera 'INTERNAL';
				};
			};
		};
		if ((_QS_player getVariable 'QS_1PV') select 0) then {
			if (!((lifeState _QS_player) isEqualTo 'INCAPACITATED')) then {
				_QS_player switchCamera 'INTERNAL';
			};
		};
	};
	
	/*/========== Boot non-pilots out of pilot seats where necessary/*/
	
	if (_pilotCheck) then {
		if ((count _allPlayers) > 20) then {
			if (_QS_v2 isKindOf 'Air') then {
				if (!(_QS_v2Type in ['B_Heli_Light_01_F','Steerable_Parachute_F'])) then {
					if (player in [(driver _QS_v2)]) then {
						if (!(_playerClass in ['B_Helipilot_F','B_pilot_F','B_T_Helipilot_F','B_T_pilot_F'])) then {
							if (!(player getUnitTrait 'QS_trait_pilot')) then {
								if (((getPosATL _QS_v2) select 2) < 5) then {
									moveOut player;
									_playerClassDName spawn {
										uiSleep 2;
										_role = getText (configFile >> 'CfgVehicles' >> _this >> 'displayName');
										systemChat format ['You are not a pilot. Play your role (***** %1 *****) or re-assign!',_role];
									};
								};
							};
						};
					};
				} else {
					if (!(_QS_v2Type in ['Steerable_Parachute_F'])) then {
						if (player in [(driver _QS_v2)]) then {
							if (!(_playerClass in ['B_Helipilot_F','B_pilot_F','B_T_Helipilot_F','B_T_pilot_F'])) then {
								if (!(player getUnitTrait 'QS_trait_pilot')) then {
									if (((getPosATL _QS_v2) select 2) < 5) then {
										moveOut player;
										_playerClassDName spawn { 
											uiSleep 2;
											_role = getText (configFile >> 'CfgVehicles' >> _this >> 'displayName');
											systemChat format ['You are not a pilot. Play your role (***** %1 *****) or re-assign!',_role];
										};
									};
								};
							};
						};
					};
				};
			};
			/*/===== Pilot babysitter/*/
			
			if (_QS_pilotBabysitter) then {
				if ((count _allPlayers) >= 30) then {
					if (_iAmPilot) then {
						if (time > _QS_secondsCounter) then {
							_QS_secondsCounter = time + 1;
							if (!((vehicle player) isKindOf 'Air')) then {
								if ((player distance2D _QS_module_safezone_pos) > 1000) then {
									_QS_currentTimeOnGround = _QS_currentTimeOnGround + 1;
									if (_QS_currentTimeOnGround > _QS_maxTimeOnGround) then {
										forceRespawn player;
									} else {
										if (_QS_currentTimeOnGround > _QS_warningTimeOnGround) then {
											(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,10,-1,'You are a pilot. Please play your role or re-assign. There are over 30 players on the server, please respawn if timely evac is not available.',[],(serverTime + 20)];
										};
									};
								} else {
									if (_QS_currentTimeOnGround > 0) then {
										_QS_currentTimeOnGround = 0;
									};
								};
							} else {
								if (_QS_currentTimeOnGround > 0) then {
									_QS_currentTimeOnGround = 0;
								};
							};
						};
					};
					if ((_timeNow - _QS_afkTimer) >= (player getVariable 'QS_client_afkTimeout')) then {
						if (!(_QS_isAdmin)) then {
							if (!(_kicked)) then {
								_kicked = TRUE;
								with uiNamespace do {
									0 spawn {
										[
											'Auto-kicked for AFK timeout.',
											'Robocop',
											TRUE, 
											FALSE, 
											(findDisplay 46), 
											FALSE, 
											FALSE 
										] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
									};
								};
								[33,_QS_clientOwner,_profileName] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							};
						};
					} else {
						if (!(_QS_posWorldPlayer isEqualTo _QS_afkTimer_playerPos)) then {
							player setVariable ['QS_client_afkTimeout',time,FALSE];
							_QS_afkTimer_playerPos = _QS_posWorldPlayer;
						};
					};
				};
			};
		};
	};

	/*/===== Bobcat cleanup module/*/
	
	if (_QS_v2TypeL in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
		if (_QS_player isEqualTo (driver _QS_v2)) then {
			if ((_QS_v2 animationSourcePhase 'MovePlow') isEqualTo 1) then {
				_posInFront = _QS_v2 modelToWorld [0,6,0];
				_listOfFrontStuff = _posInFront nearObjects ['All',4];
				_array = lineIntersectsSurfaces [
					(_QS_v2 modelToWorldWorld (_QS_v2 selectionPosition 'plow')), 
					(AGLToASL _posInFront), 
					_QS_v2, 
					objNull, 
					TRUE, 
					-1, 
					'GEOM', 
					'VIEW', 
					TRUE
				];
				{
					if (!isNull (_x select 3)) then {
						if ((_x select 3) isKindOf 'AllVehicles') then {
							if (!alive (_x select 3)) then {
								_listOfFrontStuff pushBack (_x select 3);
							};
						};
					};
				} forEach _array;
				_mines = ['IEDUrbanSmall_F','IEDLandSmall_F','SLAMDirectionalMine','IEDUrbanBig_F','IEDLandBig_F','SatchelCharge_F','DemoCharge_F','Claymore_F'] apply {(toLower _x)};
				if (!(_listOfFrontStuff isEqualTo [])) then {
					_QS_allMines = allMines;
					_QS_toDelete = [];
					{
						_obj = vehicle _x;
						_objType = typeOf _obj;
						if (_x in allDead) then {
							if (isNull (attachedTo _x)) then {
								0 = _QS_toDelete pushBack _x;
							};
						};
						if ((_x isKindOf 'CraterLong') || {(_x isKindOf 'CraterLong_small')}) then {
							0 = _QS_toDelete pushBack _x;
							[46,[player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',[format ['Cleaning up %1',_QS_worldName],'1']] call _fn_showNotification;
							uiSleep 1;
						};
						if (_x in _QS_allMines) then {
							[46,[player,1]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
							['ScoreBonus',['Mine clearance','1']] call _fn_showNotification;
							_x setDamage [1,TRUE];
							uiSleep 1;
						};
						if ((_x isKindOf 'WeaponHolder') || {(_x isKindOf 'WeaponHolderSimulated')} || {(_x isKindOf 'GroundWeaponHolder')}) then {
							0 = _QS_toDelete pushBack _x;
						};
						if (_x isKindOf 'Land_Razorwire_F') then {
							_x setDamage [1,TRUE];
						};
						if ((toLower _objType) in _mines) then {
							_x setDamage [1,TRUE];
							0 = _QS_toDelete pushBack _x;
						};
					} count _listOfFrontStuff;
					if (!(_QS_toDelete isEqualTo [])) then {
						[17,_QS_toDelete] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						_QS_toDelete = [];
					};
				};
			};
		};
	};

	/*/===== Leaderboards module/*/
	
	if (_QS_module_leaderboards) then {
		if (_timeNow > _QS_module_leaderboards_checkDelay) then {
		
			/*/===== Pilot scoring/*/
		
			if (_QS_module_leaderboards_pilots) then {
				if (_iAmPilot) then {
				
					/*/===== Is advanced flight model enabled?/*/
			
					_difficultyEnabledRTD = difficultyEnabledRTD;
					if (!((player getVariable 'QS_PP_difficultyEnabledRTD') select 0)) then {
						if (_timeNow > ((player getVariable 'QS_PP_difficultyEnabledRTD') select 1)) then {
							player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,(_timeNow + 900)],TRUE];
						};
					} else {
						if (!(_difficultyEnabledRTD)) then {
							player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,(_timeNow + 900)],TRUE];
						};
					};

					_loadedAtBase = player getVariable 'QS_IA_PP_loadedAtBase';
					if (!(_loadedAtBase isEqualTo [])) then {
						{
							if ((isNull _x) || {(!alive _x)}) then {
								_newArray = (player getVariable 'QS_IA_PP_loadedAtBase') - [_x];
								player setVariable ['QS_IA_PP_loadedAtBase',_newArray,TRUE];
							};
						} count _loadedAtBase;
					};
					_loadedAtMission = player getVariable 'QS_IA_PP_loadedAtMission';
					if (!(_loadedAtMission isEqualTo [])) then {
						{
							if ((isNull _x) || {(!alive _x)}) then {
								_newArray = (player getVariable 'QS_IA_PP_loadedAtMission') - [_x];
								player setVariable ['QS_IA_PP_loadedAtMission',_newArray,TRUE];
							};
						} count _loadedAtMission;
					};
					_loadedInField = player getVariable 'QS_IA_PP_loadedInField';
					if (!(_loadedInField isEqualTo [])) then {
						{
							if ((isNull _x) || {(!alive _x)}) then {
								_newArray = (player getVariable 'QS_IA_PP_loadedInField') - [_x];
								player setVariable ['QS_IA_PP_loadedInField',_newArray,TRUE];
							};
						} count _loadedInField;
					};
				};
			};
			_QS_module_leaderboards_checkDelay = _timeNow + _QS_module_leaderboards_delay;
		};
		
		if (_QS_reportDifficulty) then {
			if (_timeNow > _QS_reportDifficulty_checkDelay) then {
				if (!((primaryWeapon player) isEqualTo '')) then {
					_hasThermals = ({(_x in _thermalOptics)} count (primaryWeaponItems player)) isEqualTo 0;
				} else {
					_hasThermals = FALSE;
				};
				player setVariable [
					'QS_clientDifficulty',
					[
						(isStaminaEnabled player),
						(getCustomAimCoef player),
						(primaryWeapon player),
						_hasThermals,
						cameraView,
						difficultyEnabledRTD,
						isStressDamageEnabled,
						(isAutoTrimOnRTD _QS_v2),
						(difficultyEnabled 'roughLanding'),
						(difficultyEnabled 'windEnabled')
					],
					((random 1) > 0.9)
				];
				_clientDifficulty = player getVariable 'QS_clientDifficulty';
				if (!(_clientDifficulty select 0)) then {
					player setVariable ['QS_stamina_multiplier',[FALSE,(time + 900)],FALSE];
				} else {
					if (!((player getVariable 'QS_stamina_multiplier') select 0)) then {
						if (time > ((player getVariable 'QS_stamina_multiplier') select 1)) then {
							player setVariable ['QS_stamina_multiplier',[TRUE,time],FALSE];
						};
					};
				};
				_QS_reportDifficulty_checkDelay = _timeNow + _QS_reportDifficulty_delay;
			};
		};		
	};

	/*/========== Animation state manager/*/

	if (_QS_module_animState) then {
		if (_timeNow > _QS_module_animState_checkDelay) then {
			_QS_animState = toLower (animationState player);
			if (_QS_animState in ['ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwrfldnon_carried_still','ainjpfalmstpsnonwnondnon_carried_up']) then {
				if (!(player getVariable 'QS_RD_interacting')) then {
					if (player getVariable 'QS_animDone') then {
						uiSleep 0.25;
						if (isNull (attachedTo player)) then {
							if ((lifeState player) isEqualTo 'INCAPACITATED') then {
								['switchMove',player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							} else {
								['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
							};
						} else {
							if (!alive (attachedTo player)) then {
								if ((lifeState player) isEqualTo 'INCAPACITATED') then {
									['switchMove',player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
								} else {
									['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
								};
							};
						};
					};
				};
			};
			if (_QS_animState in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still']) then {
				if (isNull (attachedTo player)) then {
					if ((lifeState player) isEqualTo 'INCAPACITATED') then {
						['switchMove',player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					} else {
						['switchMove',player,''] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					};
				};
			};
			if (_QS_animState in ['amovppnemstpsnonwnondnon']) then {
				if (isNull (attachedTo player)) then {
					if ((lifeState player) isEqualTo 'INCAPACITATED') then {
						['switchMove',player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					};
				};
			};
			_QS_module_animState_checkDelay = _timeNow + _QS_module_animState_delay;
		};
	};
	
	/*/========== HUD Manager/*/

	if (_QS_module_manageHUD) then {
		if (_timeNow > _QS_module_manageHUD_checkDelay) then {
			if (!((lifeState player) isEqualTo 'INCAPACITATED')) then {
				if (!(shownHud isEqualTo (missionNamespace getVariable (format ['QS_allowedHUD_%1',_QS_side])))) then {
					showHud (missionNamespace getVariable [(format ['QS_allowedHUD_%1',_QS_side]),WEST]);
				};
			};
			if (!isNil {missionNamespace getVariable 'QS_draw3D_projectiles'}) then {
				if ((missionNamespace getVariable 'QS_draw3D_projectiles') isEqualType []) then {
					if (!((missionNamespace getVariable 'QS_draw3D_projectiles') isEqualTo [])) then {
						missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') select {(!isNull _x)}),FALSE];
					};
				};
			};
			_QS_module_manageHUD_checkDelay = _timeNow + _QS_module_manageHUD_delay;
		};
	};

	/*/========== Texture Manager/*/
	
	if (_QS_module_texture) then {
		if (_timeNow > _QS_module_texture_checkDelay) then {
			if (!((player getVariable 'QS_ClientUnitInsignia2') isEqualTo '#(argb,8,8,3)color(0,0,0,0)')) then {
				[(player getVariable 'QS_ClientUnitInsignia2')] call _fn_clientSetUnitInsignia;
			};
			if (!isNull ((player getVariable 'QS_ClientVTexture') select 0)) then {
				_myV = (player getVariable 'QS_ClientVTexture') select 0;
				if (alive _myV) then {
					if (!(_QS_v2 isEqualTo _myV)) then {
						if ((player distance _myV) > 100) then {
							{
								_myV setObjectTextureGlobal [_forEachIndex,_x];
							} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _myV) >> 'hiddenSelectionsTextures'));
							_myV setVariable ['QS_ClientVTexture_owner',nil,TRUE];
							player setVariable ['QS_ClientVTexture',[objNull,_puid,'',(_timeNow + 5)],TRUE];
						};
					};
				};
			};
			_QS_module_texture_checkDelay = _timeNow + _QS_module_texture_delay;
		};
	};
	
	/*/========== Map scale manager/*/
	
	if (visibleMap) then {
		if ((ctrlMapScale ((findDisplay 12) displayCtrl 51)) < 0.07) then {
			{
				if (!((markerAlpha _x) isEqualTo 0.75)) then {
					_x setMarkerAlphaLocal 0.75;
				};
			} count _baseMarkers;
		} else {
			{
				if ((markerAlpha _x) > 0) then {
					_x setMarkerAlphaLocal 0;
				};
			} count _baseMarkers;
		};
	};
	
	/*/========== HandleHeal Handler/*/
	
	if (_QS_module_handleHeal) then {
		if (_timeNow > _QS_module_handleHeal_checkDelay) then {
			if (!(({(!isPlayer _x)} count (units (group _QS_player))) isEqualTo 0)) then {
				{
					_unit = _x;
					if (isNil {_unit getVariable 'QS_event_handleHeal'}) then {
						_unit setVariable [
							'QS_event_handleHeal',
							(
								_unit addEventHandler [
									'HandleHeal',
									{
										if ((local (_this select 0)) || {(local (_this select 1))}) then {
											_this spawn (missionNamespace getVariable 'QS_fnc_clientEventHandleHeal');
										};
									}
								]
							),
							FALSE
						];
						uiSleep 0.005;
					};
				} forEach _allPlayers;
			};
			_QS_module_handleHeal_checkDelay = _timeNow + _QS_module_handleHeal_delay;
		};
	};
	
	/*/========== Radio Channel Manager /*/
	
	if (_QS_module_radioChannelManager) then {
		if (_timeNow > _QS_module_radioChannelManager_checkDelay) then {
			if ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 0) then {
				if (!(_QS_module_radioChannelManager_nearPrimary)) then {
					if (((player distance2D (markerPos 'QS_marker_aoMarker')) < _QS_module_radioChannelManager_nearPrimaryRadius) || {((player distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < _QS_module_radioChannelManager_nearPrimaryRadius)}) then {
						_QS_module_radioChannelManager_nearPrimary = TRUE;
						[1,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
					};
				} else {
					if (((player distance2D (markerPos 'QS_marker_aoMarker')) > _QS_module_radioChannelManager_nearPrimaryRadius) && ((player distance2D (missionNamespace getVariable 'QS_evacPosition_1')) > _QS_module_radioChannelManager_nearPrimaryRadius)) then {
						_QS_module_radioChannelManager_nearPrimary = FALSE;
						[0,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
					};
				};
			} else {
				if (_QS_module_radioChannelManager_primaryChannel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
				};
			};
			if ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') select 1) then {
				if (!(_QS_module_radioChannelManager_nearSecondary)) then {
					if (((player distance2D (markerPos 'QS_marker_sideMarker')) < _QS_module_radioChannelManager_nearSecondaryRadius) || {((player distance2D (missionNamespace getVariable 'QS_evacPosition_2')) < _QS_module_radioChannelManager_nearSecondaryRadius)}) then {
						_QS_module_radioChannelManager_nearSecondary = TRUE;
						[1,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
					};
				} else {
					if (((player distance2D (markerPos 'QS_marker_sideMarker')) > _QS_module_radioChannelManager_nearSecondaryRadius) && ((player distance2D (missionNamespace getVariable 'QS_evacPosition_2')) > _QS_module_radioChannelManager_nearSecondaryRadius)) then {
						_QS_module_radioChannelManager_nearSecondary = FALSE;
						[0,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
					};
				};
			} else {
				if (_QS_module_radioChannelManager_secondaryChannel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
					[0,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
				};
			};
			/*/AIRCRAFT/*/
			if (_QS_module_radioChannelManager_notPilot) then {
				if ([_atcMarkerPos,_tocMarkerPos] call _QS_module_radioChannelManager_checkState) then {
					if (!(_QS_module_radioChannelManager_aircraftChannel in (missionNamespace getVariable 'QS_client_radioChannels'))) then {
						[1,_QS_module_radioChannelManager_aircraftChannel] call _fn_clientRadio;
					};
				} else {
					if (_QS_module_radioChannelManager_aircraftChannel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
						[0,_QS_module_radioChannelManager_aircraftChannel] call _fn_clientRadio;
					};
				};
			};
			_QS_module_radioChannelManager_checkDelay = _timeNow + _QS_module_radioChannelManager_delay;
		};
		if ((getPlayerChannel player) in [0,1]) then {
			if (!(_puid in (['ALL'] call _fn_uidStaff))) then {
				setCurrentChannel 5;
			};
		};
		if (currentChannel isEqualTo 6) then {
			if (!isNull (findDisplay 55)) then {
				if (!(_puid in (['ALL'] call _fn_uidStaff))) then {
					50 cutText ['Use General channel for general voice communications. Press [Home] >> [Comm-Link] >> [Radio Management] to subscribe.','PLAIN DOWN'];
					setCurrentChannel 5;
				};
			};
		};
		if (_QS_module_radioChannelManager_notPilot) then {
			if (currentChannel isEqualTo 7) then {
				if (!isNull (findDisplay 55)) then {
					if (!(_puid in (['ALL'] call _fn_uidStaff))) then {
						setCurrentChannel 5;
					};
				};
			};
		};
		if (!(currentChannel isEqualTo 5)) then {
			if (!isNull (findDisplay 55)) then {
				if (!('ItemRadio' in (assignedItems player))) then {
					50 cutText ['You need a Radio to transmit over radio channels!','PLAIN DOWN'];
					setCurrentChannel 5;
				};
			};
		};
		if (player getVariable ['QS_client_radioDisabled',FALSE]) then {
			if ('ItemRadio' in (assignedItems player)) then {
				player unassignItem 'ItemRadio'; 
			};
		};
	};
	
	/*/========== Sway Module/*/

	if (_QS_module_swayManager) then {
		if (_QS_uiTime > _QS_module_swayManager_checkDelay) then {
			_QS_customAimCoef = getCustomAimCoef player;
			if (!(_QS_module_swayManager_isAT)) then {
				if (isNull _objectParent) then {
					if (!((secondaryWeapon player) isEqualTo '')) then {
						if ((currentWeapon player) isEqualTo (secondaryWeapon player)) then {
							if (!(_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef)) then {
								player setCustomAimCoef _QS_module_swayManager_secWepSwayCoef;
							};
						} else {
							if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
								if (!isNil {player getVariable 'QS_stamina'}) then {
									if ((player getVariable 'QS_stamina') isEqualType []) then {
										if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
											if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
												player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
											};
										};
									};
								};
							};
						};
					} else {
						if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
							if (!isNil {player getVariable 'QS_stamina'}) then {
								if ((player getVariable 'QS_stamina') isEqualType []) then {
									if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
										if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
											player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
										};
									};
								};
							};
						};
					};
				} else {
					if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
						if (!isNil {player getVariable 'QS_stamina'}) then {
							if ((player getVariable 'QS_stamina') isEqualType []) then {
								if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
									if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
										player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
									};
								};
							};
						};
					};
				};
			};
			_QS_customAimCoef = getCustomAimCoef player;
			_QS_recoilCoef = unitRecoilCoefficient player;
			if ((toLower (currentWeapon player)) in _QS_module_swayManager_heavyWeapons) then {
				if ((stance player) isEqualTo 'STAND') then {
					if ((!(isWeaponDeployed player)) && (!(isWeaponRested player))) then {
						if (!(_QS_customAimCoef isEqualTo _QS_module_swayManager_heavyWeaponCoef_stand)) then {
							player setCustomAimCoef _QS_module_swayManager_heavyWeaponCoef_stand;
						};
						if (!(_QS_recoilCoef isEqualTo _QS_module_swayManager_recoilCoef_stand)) then {
							player setUnitRecoilCoefficient _QS_module_swayManager_recoilCoef_stand;
						};
					} else {
						if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
							if (!isNil {player getVariable 'QS_stamina'}) then {
								if ((player getVariable 'QS_stamina') isEqualType []) then {
									if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
										if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
											player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
										};
									};
								};
							};
						};
						if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
							player setUnitRecoilCoefficient 1;
						};
					};
				} else {
					if ((stance player) isEqualTo 'CROUCH') then {
						if ((!(isWeaponDeployed player)) && (!(isWeaponRested player))) then {
							if (!(_QS_customAimCoef isEqualTo _QS_module_swayManager_heavyWeaponCoef_crouch)) then {
								player setCustomAimCoef _QS_module_swayManager_heavyWeaponCoef_crouch;
							};
							if (!(_QS_recoilCoef isEqualTo _QS_module_swayManager_recoilCoef_crouch)) then {
								player setUnitRecoilCoefficient _QS_module_swayManager_recoilCoef_crouch;
							};
						} else {
							if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
								if (!isNil {player getVariable 'QS_stamina'}) then {
									if ((player getVariable 'QS_stamina') isEqualType []) then {
										if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
											if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
												player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
											};
										};
									};
								};
							};
							if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
								player setUnitRecoilCoefficient 1;
							};
						};
					} else {
						if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
							if (!isNil {player getVariable 'QS_stamina'}) then {
								if ((player getVariable 'QS_stamina') isEqualType []) then {
									if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
										if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
											player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
										};
									};
								};
							};
						};
						if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
							player setUnitRecoilCoefficient 1;
						};
					};
				};
			} else {
				if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
					if (!isNil {player getVariable 'QS_stamina'}) then {
						if ((player getVariable 'QS_stamina') isEqualType []) then {
							if (((player getVariable 'QS_stamina') select 1) isEqualType 0) then {
								if (!(_QS_customAimCoef isEqualTo ((player getVariable 'QS_stamina') select 1))) then {
									player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
								};
							};
						};
					};
				};
				if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
					player setUnitRecoilCoefficient 1;
				};
			};
			_QS_module_swayManager_checkDelay = diag_tickTime + _QS_module_swayManager_delay;
		};
	};
	
	/*/========== Task Manager Module/*/

	if (_QS_module_taskManager) then {
		if (_timeNow > _QS_module_taskManager_checkDelay) then {
			_QS_module_taskManager_simpleTasks = simpleTasks player;
			if (!(_QS_module_taskManager_simpleTasks isEqualTo [])) then {
				_QS_module_taskManager_currentTask = currentTask player;
				{
					if (!isNull _QS_module_taskManager_currentTask) then {
						if (_x isEqualTo _QS_module_taskManager_currentTask) then {
							if (!(taskAlwaysVisible _x)) then {
								_x setSimpleTaskAlwaysVisible TRUE;
							};
						} else {
							if (taskAlwaysVisible _x) then {
								_x setSimpleTaskAlwaysVisible FALSE;
							};
						};
					} else {
						if (taskAlwaysVisible _x) then {
							_x setSimpleTaskAlwaysVisible FALSE;
						};
					};
				} count _QS_module_taskManager_simpleTasks;
			};
			_QS_module_taskManager_checkDelay = _timeNow + _QS_module_taskManager_delay;
		};
	};
	
	/*/========== Reveal Players module/*/

	if (_QS_module_revealPlayers) then {
		if (_timeNow > _QS_module_revealPlayers_checkDelay) then {
			if ((_QS_player distance2D _QS_module_safezone_pos) > 1000) then {
				if ((count _allPlayers) > 1) then {
					{
						if (!((toLower (speaker _x)) isEqualTo 'novoice')) then {
							_x setSpeaker 'NoVoice';
						};
						if ((player knowsAbout _x) <= 1) then {
							player reveal [_x,2];
						};
					} count ((_QS_posWorldPlayer nearEntities ['CAManBase',500]) select {(isPlayer _x)});
				};
			};
			_QS_module_revealPlayers_checkDelay = _timeNow + _QS_module_revealPlayers_delay;
		};
	};
	
	/*/========== SC Assistant Module/*/

	if (_QS_module_scAssistant) then {
		if (_QS_uiTime > _QS_module_scAssistant_checkDelay) then {
			if (!isNil {missionNamespace getVariable 'QS_virtualSectors_data_public'}) then {
				if ((missionNamespace getVariable 'QS_virtualSectors_data_public') isEqualType []) then {
					if (!((missionNamespace getVariable 'QS_virtualSectors_data_public') isEqualTo [])) then {
						_QS_virtualSectors_data_public = missionNamespace getVariable ['QS_virtualSectors_data_public',[]];
						{
							_sectorFlag = (_x select 17) select 0;
							_sectorPhase = _x select 26;
							if (_sectorFlag isEqualType objNull) then {
								if (!isNull _sectorFlag) then {
									if (_sectorPhase isEqualType 0) then {
										if (!((flagAnimationPhase _sectorFlag) isEqualTo _sectorPhase)) then {
											_sectorFlag setFlagAnimationPhase _sectorPhase;
										};
									};
								};
							};
						} forEach _QS_virtualSectors_data_public;
					};
				};
			};
			_QS_module_scAssistant_checkDelay = _QS_uiTime + _QS_module_scAssistant_delay;
		};
	};
	
	/*/========== Module Georgetown/*/
	
	if (_QS_isTanoa) then {
		if (_QS_uiTime > _QS_tanoa_checkDelay) then {
			if (missionNamespace getVariable 'QS_customAO_GT_active') then {
				if (!(_QS_inGeorgetown)) then {
					if (_QS_posWorldPlayer inPolygon _QS_georgetown_polygon) then {
						if (!isNull (objectParent player)) then {
							if (local _QS_v2) then {
								if ((isNull (attachedTo _QS_v2)) && (isNull (isVehicleCargo _QS_v2))) then {
									if (_QS_v2 isKindOf 'LandVehicle') then {
										if ((fuel _QS_v2) > 0) then {
											_QS_v2 setFuel 0;
										};
									};
									if (({(alive _x)} count (crew _QS_v2)) > 0) then {
										['setVehicleAmmo',_QS_v2,0] remoteExec ['QS_fnc_remoteExecCmd',(crew _QS_v2),FALSE];
									};
								};
							};
						};
						if ((((getPosATL player) select 2) < 50) && (isNull (objectParent player))) then {
							_QS_inGeorgetown = TRUE;
							_QS_georgetown_priorVD = viewDistance;
							_QS_georgetown_priorOVD = getObjectViewDistance select 0;
							50 cutText [(format ['Lowering view distance (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa'))]),'PLAIN DOWN',0.25];
							[_QS_georgetown_priorVD,_QS_georgetown_priorOVD,_QS_georgetown_VD,_QS_georgetown_OVD] spawn {
								params ['_QS_georgetown_priorVD','_QS_georgetown_priorOVD','_QS_georgetown_VD','_QS_georgetown_OVD'];
								if (_QS_georgetown_priorVD > _QS_georgetown_VD) then {
									_time = diag_tickTime + 3;
									for '_x' from 0 to 1 step 0 do {
										setViewDistance (viewDistance - 10);
										if (viewDistance <= _QS_georgetown_VD) exitWith {};
										if (diag_tickTime > _time) exitWith {
											setViewDistance _QS_georgetown_VD; 
										};
										uiSleep 0.05;
									};
								};
								if (_QS_georgetown_priorOVD > _QS_georgetown_OVD) then {
									_time = diag_tickTime + 3;
									for '_x' from 0 to 1 step 0 do {
										setObjectViewDistance ((getObjectViewDistance select 0) - 10);
										if ((getObjectViewDistance select 0) <= _QS_georgetown_OVD) exitWith {};
										if (diag_tickTime > _time) exitWith {
											setObjectViewDistance _QS_georgetown_OVD; 
										};
										uiSleep 0.05;
									};
								};
							};
						};
					};
				} else {
					if (!isNull (objectParent player)) then {
						if (local _QS_v2) then {
							if ((isNull (attachedTo _QS_v2)) && (isNull (isVehicleCargo _QS_v2))) then {
								if (_QS_v2 isKindOf 'LandVehicle') then {
									if ((fuel _QS_v2) > 0) then {
										_QS_v2 setFuel 0;
									};
								};
							};
						};
					};
					if ((!(_QS_posWorldPlayer inPolygon _QS_georgetown_polygon)) || {(!isNull (objectParent player))} || {(((getPosATL player) select 2) >= 50)}) then {
						_QS_inGeorgetown = FALSE;
						50 cutText [(format ['Restoring view distance (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa'))]),'PLAIN DOWN',0.25];
						[_QS_georgetown_priorVD,_QS_georgetown_priorOVD] spawn {
							params ['_QS_georgetown_priorVD','_QS_georgetown_priorOVD'];
							if (viewDistance < _QS_georgetown_priorVD) then {
								_time = diag_tickTime + 3;
								for '_x' from 0 to 1 step 0 do {
									setViewDistance (viewDistance + 10);
									if (viewDistance >= _QS_georgetown_priorVD) exitWith {};
									if (diag_tickTime > _time) exitWith {
										setViewDistance _QS_georgetown_priorVD; 
									};
									uiSleep 0.05;
								};
							};
							if ((getObjectViewDistance select 0) < _QS_georgetown_priorOVD) then {
								_time = diag_tickTime + 3;
								for '_x' from 0 to 1 step 0 do {
									setObjectViewDistance ((getObjectViewDistance select 0) + 10);
									if ((getObjectViewDistance select 0) >= _QS_georgetown_priorOVD) exitWith {};
									if (diag_tickTime > _time) exitWith {
										setObjectViewDistance _QS_georgetown_priorOVD; 
									};
									uiSleep 0.05;
								};
							};
						};
					};
				};
			} else {
				if (_QS_inGeorgetown) then {
					_QS_inGeorgetown = FALSE;
					50 cutText [(format ['Restoring view distance (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa'))]),'PLAIN DOWN',0.25];
					[_QS_georgetown_priorVD,_QS_georgetown_priorOVD] spawn {
						params ['_QS_georgetown_priorVD','_QS_georgetown_priorOVD'];
						if (viewDistance < _QS_georgetown_priorVD) then {
							_time = diag_tickTime + 3;
							for '_x' from 0 to 1 step 0 do {
								setViewDistance (viewDistance + 10);
								if (viewDistance >= _QS_georgetown_priorVD) exitWith {};
								if (diag_tickTime > _time) exitWith {
									setViewDistance _QS_georgetown_priorVD; 
								};
								uiSleep 0.05;
							};
						};
						if ((getObjectViewDistance select 0) < _QS_georgetown_priorOVD) then {
							_time = diag_tickTime + 3;
							for '_x' from 0 to 1 step 0 do {
								setObjectViewDistance ((getObjectViewDistance select 0) + 10);
								if ((getObjectViewDistance select 0) >= _QS_georgetown_priorOVD) exitWith {};
								if (diag_tickTime > _time) exitWith {
									setObjectViewDistance _QS_georgetown_priorOVD; 
								};
								uiSleep 0.05;
							};
						};
					};
				};
			};
			_QS_tanoa_checkDelay = _QS_uiTime + _QS_tanoa_delay;
		};
	};
	
	/*/===== Module Group Indicator/*/
	
	if (_QS_module_groupIndicator) then {
		if (_QS_uiTime > _QS_module_groupIndicator_checkDelay) then {
			if (isNull _objectParent) then {
				if (!isNil {player getVariable ['QS_HUD_3',nil]}) then {
					missionNamespace setVariable ['QS_client_groupIndicator_units',((_posATLPlayer nearEntities [_QS_module_groupIndicator_types,_QS_module_groupIndicator_radius]) select _QS_module_groupIndicator_filter),FALSE];
				};
			};
			_QS_module_groupIndicator_checkDelay = _QS_uiTime + _QS_module_groupIndicator_delay;
		};
	};
	
	/*/===== Medic Revive icons/*/
	
	if (_QS_iAmMedic) then {
		if (_QS_uiTime > _QS_medicIcons_checkDelay) then {
			missionNamespace setVariable ['QS_client_medicIcons_units',(_posATLPlayer nearEntities ['CAManBase',_QS_medicIcons_radius]),FALSE];
			_QS_medicIcons_checkDelay = _QS_uiTime + _QS_medicIcons_delay;
		};
	};
	
	/*/===== Client AI/*/
	
	if (_QS_module_clientAI) then {
		if (_QS_uiTime > _QS_module_clientAI_checkDelay) then {
			if (_QS_player isEqualTo (leader (group _QS_player))) then {
				if (({((alive _x) && (!(isPlayer _x)) && (!(unitIsUav _x)))} count (units (group _QS_player))) > 0) then {
					if (scriptDone _QS_module_clientAI_script) then {
						_QS_module_clientAI_script = 0 spawn _fn_clientAIBehaviours;
					};
				};
			};
			_QS_module_clientAI_checkDelay = _QS_uiTime + _QS_module_clientAI_delay;
		};
	};
	
	/*/========== Operational Security Module/*/
	
	if (_QS_module_opsec) then {
		if (_QS_uiTime > _QS_module_opsec_checkDelay) then {
			_QS_module_opsec_detected = 0;
			if (_QS_module_opsec_detected < 2) then {
				if (_QS_module_opsec_recoilSway) then {
					if (((unitRecoilCoefficient player) < 1) || {((getCustomAimCoef player) < 0.1)} || {((getAnimSpeedCoef player) > 1.1)}) then {
						_QS_module_opsec_detected = 2;
						_detected = format ['Recoil: %1 (min 1) Sway: %2 (min 0.1) AnimSpeed: %3 (max 1.1)',(unitRecoilCoefficient player),(getCustomAimCoef player),(getAnimSpeedCoef player)];
					};
				};
				if (isFilePatchingEnabled) then {
					_QS_module_opsec_detected = 2;
					_detected = 'FilePatchingEnabled';
				};
				if (cheatsEnabled) then {
					_QS_module_opsec_detected = 1;
					_detected = 'Cheats Enabled (BI Dev?, use discretion)';
				};
				if (_QS_module_opsec_hidden) then {
					if (isObjectHidden player) then {
						_QS_module_opsec_detected = 2;
						_detected = 'IsInvisible';
					};
				};
				if (!(simulationEnabled player)) then {
					player enableSimulation TRUE;
				};
				if (!(clientOwner isEqualTo _QS_clientOwner)) then {
					_QS_module_opsec_detected = 1;
					_detected = 'Client Network ID Changed (bug? Use discretion)';
				};
				if (serverCommandAvailable '#logout') then {
					_QS_module_opsec_detected = 2;
					_detected = 'Admin Logged';
				};
				_bis_fnc_diagkey = uiNamespace getVariable ['BIS_fnc_diagKey',{FALSE}];
				if (!isNil '_bis_fnc_diagkey') then {
					if (!((str _bis_fnc_diagkey) in ['{false}','{}'])) then {
						_QS_module_opsec_detected = 2;
						_detected = 'BIS_fnc_DiagKey';
					};
				};
				_commandingMenu = commandingMenu;
				if (!(_commandingMenu isEqualTo '')) then {
					if(!(_commandingMenu in _validCommMenus)) then {
						if ((!(['#GET_IN',_commandingMenu,FALSE] call _fn_inString)) && {(!(['#WATCH',_commandingMenu,FALSE] call _fn_inString))} && {(!(['#ACTION',_commandingMenu,FALSE] call _fn_inString))}) then {
							_detected = format ['CMD_Menu_Hack_%1 (Use Discretion)',_commandingMenu];
							_QS_module_opsec_detected = 2;
						};
					};
				};
				if (_QS_module_opsec_menus) then {
					{
						(_QS_module_opsec_displays select _forEachIndex) params [
							'_targetDisplay',
							'_targetName',
							'_targetFlag'
						];
						if (_targetFlag isEqualTo 0) then {
							if (_targetDisplay isEqualType '') then {
								if (!isNull (uiNamespace getVariable [_targetDisplay,displayNull])) then {
									if (_targetDisplay isEqualTo 'BIS_fnc_arsenal_display') then {
										if ((count (allControls (uiNamespace getVariable 'BIS_fnc_arsenal_display'))) > 203) then {
											_QS_module_opsec_detected = 1;
											_detected = format ['MenuHack_%1_CtrlCnt_%2',_targetName,(count (allControls (uiNamespace getVariable 'BIS_fnc_arsenal_display')))];
											_targetFlag = 1;
											_QS_module_opsec_displays set [_forEachIndex,[_targetDisplay,_targetName,_targetFlag]];
										};
									} else {
										_QS_module_opsec_detected = 2;
										_detected = format ['MenuHack_%1',_targetName];
										_targetFlag = 1;
										_QS_module_opsec_displays set [_forEachIndex,[_targetDisplay,_targetName,_targetFlag]];
									};
								};
							} else {
								if (_targetDisplay isEqualType 0) then {
									if (!isNull (findDisplay _targetDisplay)) then {
										_QS_module_opsec_detected = 2;
										_detected = format ['MenuHack_%1',_targetName];
										_targetFlag = 1;
										_QS_module_opsec_displays set [_forEachIndex,[_targetDisplay,_targetName,_targetFlag]];
									};
								};
							};
							if (_QS_module_opsec_detected > 0) exitWith {};
						};
						uiSleep 0.005;
					} forEach _QS_module_opsec_displays;
					_allDisplays = allDisplays;
					{
						_display = _x;
						if (!((str _display) in _QS_module_opsec_displays_default)) then {
							_QS_module_opsec_displayIDDstr = ((str _display) splitString '#') select 1;
							if (_QS_module_opsec_displayIDDstr isEqualTo '148') then {
								uiSleep 0.025;
								if (((lbSize 104) - 1) > 3) exitWith {
									_detected = 'MenuHack_RscDisplayConfigureControllers (JME 313)';
									_QS_module_opsec_detected = 2;
								};
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '157') then {
								if (isNull (uiNamespace getVariable ['RscDisplayModLauncher',displayNull])) then {
									_detected = 'RscDisplayPhysX3Debug';
									_QS_module_opsec_detected = 1;
								};
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '602') then {
								if ((count (allControls _display)) > 90) then {		/*/88/*/
									_QS_module_opsec_detected = 2;
									_detected = format ['MenuHack_RscDisplayInventory_Controls_%1',(count (allControls _display))];
								};									
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '163') then {
								uiSleep 0.025;
								{
									if (_x && (!isNull _display)) exitWith {
										_detected = 'RscDisplayControlSchemes';
										_QS_module_opsec_detected = 2;
									};
								} forEach [
									((toLower (ctrlText (_display displayCtrl 1000))) != (toLower (localize 'STR_DISP_OPTIONS_SCHEME'))),
									{
										if (buttonAction (_display displayCtrl _x) != '') exitWith {TRUE}; 
										FALSE
									} forEach [1,2]
								];
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '131') then {
								uiSleep 0.025;
								{
									if (_x && (!isNull _display)) exitWith {
										_detected = 'MenuHack_RscDisplayConfigureAction';
										_QS_module_opsec_detected = 2;
									};
								} forEach [
									((toLower (ctrlText (_display displayCtrl 1000))) != (toLower (localize 'STR_A3_RscDisplayConfigureAction_Title'))),
									({if (buttonAction (_display displayCtrl _x) != '') exitWith {TRUE}; false} forEach [1,104,105,106,107,108,109])
								];
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '54') then {
								uiSleep 0.025;
								{
									if (_x && (!isNull _display)) exitWith {
										_detected = 'MenuHack_RscDisplayInsertMarker';
										_QS_module_opsec_detected = 2;
									};
								} forEach [
									((toLower (ctrlText (_display displayCtrl 1001))) != (toLower (localize 'STR_A3_RscDisplayInsertMarker_Title'))),
									({if (buttonAction (_display displayCtrl _x) != '') exitWith {TRUE}; false} forEach [1,2])
								];
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '129') then {
								/*/
								_detected = 'ROBOCOP: Diary display is opened (Use Discretion)';
								_display closeDisplay 1;
								_QS_module_opsec_detected = 1;
								/*/
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '162') then {
								/*/
								_detected = 'ROBOCOP: Field manual is opened (Use Discretion)';
								_display closeDisplay 1;
								_QS_module_opsec_detected = 1;
								/*/
							};									
							if (_QS_module_opsec_displayIDDstr isEqualTo '49') then {
								if (!isNull (_display displayCtrl 0)) then {
									_detected = 'MenuHack_DISPLAY_49_C_0';
									_QS_module_opsec_detected = 1;
								};
								{
									for '_i' from 0 to ((count _x) - 1) step 1 do {
										_ctrlCfg = _x select _i;
										if (((getText (_ctrlCfg >> 'action')) != '') || {((getText (_ctrlCfg >> 'onButtonClick')) != '')}) exitWith {
											_detected = format ['Unknown Escape Menu button: %1',(getText (_ctrlCfg >> 'text'))];
											_QS_module_opsec_detected = 2;
										};
									};
								} forEach [
									(configFile >> 'RscDisplayMPInterrupt' >> 'controls'),
									(configFile >> 'RscDisplayMPInterrupt' >> 'controlsBackground')
								];
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '15000') then {
								if (!(_puid in (['DEVELOPER'] call _fn_uidStaff))) then {
									_QS_module_opsec_detected = 2;
									_detected = 'Unauthorized Dev Terminal access';
								};
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '312') then {
								if (!(_puid in (['CURATOR'] call _fn_uidStaff))) then {
									_QS_module_opsec_detected = 2;
									_detected = 'Unauthorized Curator access';
								};
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '316000') then {
								_QS_module_opsec_detected = 2;
								_detected = 'Debug Console';
							};
						};
					} count _allDisplays;
				};
				if (_QS_uiTime > _QS_module_opsec_memCheckDelay) then {
					_QS_module_opsec_memCheckDelay = _QS_uiTime + _QS_module_opsec_memDelay;
					if (!(_QS_module_opsec_memCheck_WorkingArray isEqualTo [])) then {
						[((_QS_module_opsec_memCheck_WorkingArray select 0) select 0),_namePlayer,_profileName,_profileNameSteam,_puid,((_QS_module_opsec_memCheck_WorkingArray select 0) select 1)] spawn _QS_module_opsec_memCheck_script;
						_QS_module_opsec_memCheck_WorkingArray set [0,FALSE];
						_QS_module_opsec_memCheck_WorkingArray deleteAt 0;
					} else {
						if (_QS_module_opsec_memory) then {
							_QS_module_opsec_memCheck_WorkingArray pushBack ['RscDisplay',_QS_module_opsec_memArray];
						};
						if (_QS_module_opsec_memoryMission) then {
							_QS_module_opsec_memCheck_WorkingArray pushBack ['MissionDisplay',_QS_module_opsec_memArrayMission];
						};
						if (_QS_module_opsec_iguiDisplays) then {
							_QS_module_opsec_memCheck_WorkingArray pushBack ['IGUIDisplay',_QS_module_opsec_memArrayIGUI];
						};
						if (_QS_module_opsec_rsctitles) then {
							_QS_module_opsec_memCheck_WorkingArray pushBack ['RscTitles',_QS_module_opsec_memArrayTitles];
						};
						if (_QS_module_opsec_rsctitlesMission) then {
							_QS_module_opsec_memCheck_WorkingArray pushBack ['MissionTitles',_QS_module_opsec_memArrayTitlesMission];
						};
						uiSleep 0.05;
					};
				};
				if (_QS_module_opsec_vars) then {
					_QS_module_opsec_vars = FALSE;
					/*/ Scan UI and Mission namespaces for illicit vars and var value types/*/
				};
				if (_QS_module_opsec_checkScripts) then {
					_QS_module_opsec_checkScripts = FALSE;
				};
				if (_QS_module_opsec_checkActions) then {
					_opsec_actionIDs = actionIDs player;
					_opsec_actionParams = [];
					if (!(_opsec_actionIDs isEqualTo [])) then {
						{
							_opsec_actionParams = player actionParams _forEachIndex;
							if (!(isNil '_opsec_actionParams')) then {
								if (!(_opsec_actionParams isEqualTo [])) then {
									_opsec_actionParams params [
										'_opsec_actionTitle',
										'_opsec_actionCode'
									];
									if (!(_opsec_actionTitle in _opsec_actionWhitelist)) then {
										if (!(_puid in (['DEVELOPER'] call _fn_uidStaff))) then {
											if ((!(['ROBOCOP',_opsec_actionTitle,FALSE] call _fn_inString)) && (!(['Put Explosive Charge',_opsec_actionTitle,FALSE] call _fn_inString))) then {
												_QS_module_opsec_return = [_QS_module_opsec_memArray,_namePlayer,_profileName,_profileNameSteam,_puid] call _QS_module_opsec_memCheck_script;
												if (!((_QS_module_opsec_return select 0) isEqualTo 0)) then {
													_detected = format ['%1 + %2',_detected,(_QS_module_opsec_return select 1)];
												};
												[
													40,
													[
														time,
														serverTime,
														_namePlayer,
														_profileName,
														_profileNameSteam,
														_puid,
														2,
														(format ['Anti-Hack * Non-whitelisted scroll action text: "%1" %2',_opsec_actionTitle,_opsec_actionCode]),
														player
													]
												] remoteExec ['QS_fnc_remoteExec',2,FALSE];
												_co = player;
												removeAllActions _co;
											} else {
												comment 'Robocop is in action text, now what?';
											};
										};
									};
								};
							};
						} forEach _opsec_actionIDs;
					};
				};
				_bis_fnc_diagkey = uiNamespace getVariable ['BIS_fnc_diagKey',{false}];
				if (!isNil '_bis_fnc_diagkey') then {
					if (!((str _bis_fnc_diagkey) in ['{false}','{}'])) then {
						_QS_module_opsec_detected = 2;
						_detected = 'BIS_fnc_DiagKey (wat?)';
					};
				};
				if (!(_QS_module_opsec_detected isEqualTo 0)) then {
					if (_QS_module_opsec_detected > 1) then {
						_QS_module_opsec_return = [_QS_module_opsec_memArray,_namePlayer,_profileName,_profileNameSteam,_puid] call _QS_module_opsec_memCheck_script;
						if (!((_QS_module_opsec_return select 0) isEqualTo 0)) then {
							_detected = format ['%1 + %2',_detected,(_QS_module_opsec_return select 1)];
						};
					};
					[
						40,
						[
							time,
							serverTime,
							_namePlayer,
							_profileName,
							_profileNameSteam,
							_puid,
							_QS_module_opsec_detected,
							_detected,
							player
						]
					] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
			_QS_module_opsec_checkDelay = _QS_uiTime + _QS_module_opsec_delay;
		};
		if (_QS_module_opsec_chatIntercept) then {
			if (!isNull (findDisplay 24)) then {
				if (scriptDone _QS_module_opsec_chatIntercept_script) then {
					_QS_module_opsec_chatIntercept_script = [(findDisplay 24),_fn_inString] spawn _QS_module_opsec_chatIntercept_code;
				};
			};
		};
	};
	if (!((lifeState _QS_player) isEqualTo 'INCAPACITATED')) then {
		if (!(_QS_module_49Opened)) then {
			_d49 = findDisplay 49;
			if (!isNull _d49) then {
				if (!(isStreamFriendlyUIEnabled)) then {
					if (shownChat) then {
						showChat FALSE;
					};
				};
				_QS_module_49Opened = TRUE;
				{
					_QS_buttonCtrl = _d49 displayCtrl _x;
					if (!isNull _QS_buttonCtrl) then {
						_QS_buttonCtrl ctrlSetText 'Player Menu';
						_QS_buttonCtrl buttonSetAction _QS_buttonAction;
						_QS_buttonCtrl ctrlSetTooltip 'Invade & Annex player menu';
						_QS_buttonCtrl ctrlCommit 0;
					};
				} forEach [16700,2];
				(_d49 displayCtrl 103) ctrlEnable FALSE;
				(_d49 displayCtrl 103) ctrlSetText '';
				(_d49 displayCtrl 103) ctrlEnable FALSE;
				(_d49 displayCtrl 523) ctrlSetText (format ['%1',_profileName]);
				(_d49 displayCtrl 109) ctrlSetText (format ['%1',_playerClassDName]);
				(_d49 displayCtrl 104) ctrlEnable TRUE;
				(_d49 displayCtrl 104) ctrlSetText 'Abort';
				(_d49 displayCtrl 104) ctrlSetTooltip 'Abort to role assignment (lobby).';
			};
		} else {
			_d49 = findDisplay 49;
			if (isNull _d49) then {
				if (!(isStreamFriendlyUIEnabled)) then {
					if (!(shownChat)) then {
						showChat TRUE;
					};
				};
				_QS_module_49Opened = FALSE;
			};
		};
	};

	if (_QS_uiTime > _QS_miscDelay5) then {
		if (!isNil {missionNamespace getVariable 'QS_draw2D_projectiles'}) then {
			if ((missionNamespace getVariable 'QS_draw2D_projectiles') isEqualType []) then {
				if (!((missionNamespace getVariable 'QS_draw2D_projectiles') isEqualTo [])) then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') select {(!isNull _x)}),FALSE];
				};
			};
		};
		if ((uiNamespace getVariable ['RscMissionStatus_display',displayNull]) isEqualTo (findDisplay 46)) then {
			uiNamespace setVariable ['RscMissionStatus_display',(findDisplay 46)];
		};
		_QS_miscDelay5 = _QS_uiTime + 60;
	};
	if (_QS_module_soundControllers) then {
		if (_QS_uiTime > _QS_module_soundControllers_checkDelay) then {
			player setVariable ['QS_client_soundControllers',[(getAllSoundControllers _QS_v2),(getAllEnvSoundControllers _QS_posWorldPlayer)],FALSE];
			_QS_module_soundControllers_checkDelay = _QS_uiTime + (_QS_module_soundControllers_delay + (random 1));
		};
	};
	if (_QS_module_playerInArea) then {
		if (_QS_uiTime > _QS_module_playerInArea_checkDelay) then {
			if ((_QS_posWorldPlayer distance2D _QS_module_safezone_pos) < _QS_module_safezone_radius) then {
				if (!(_QS_player getVariable ['QS_client_inBaseArea',FALSE])) then {
					_QS_player setVariable ['QS_client_inBaseArea',TRUE,FALSE];
				};
				if (_QS_player getVariable ['QS_client_inFOBArea',FALSE]) then {
					_QS_player setVariable ['QS_client_inFOBArea',FALSE,FALSE];
				};
				if (_QS_player getVariable ['QS_client_inCarrierArea',FALSE]) then {
					_QS_player setVariable ['QS_client_inCarrierArea',FALSE,FALSE];
					if (!(_QS_carrierEnabled isEqualTo 0)) then {
						if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
							if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
								(missionNamespace getVariable 'QS_carrierObject') enableSimulation FALSE;
								{
									if (!isNull (_x select 0)) then {
										if (simulationEnabled (_x select 0)) then {
											(_x select 0) enableSimulation FALSE;
										};
									};
								} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
							};
						};
					};
				};
				if (!(_QS_module_playerInArea_delay isEqualTo 5)) then {
					_QS_module_playerInArea_delay = 5;
				};
			} else {
				if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_module_fob')) < 300) then {
					if (_QS_player getVariable ['QS_client_inBaseArea',FALSE]) then {
						_QS_player setVariable ['QS_client_inBaseArea',FALSE,FALSE];
					};
					if (!(_QS_player getVariable ['QS_client_inFOBArea',FALSE])) then {
						_QS_player setVariable ['QS_client_inFOBArea',TRUE,FALSE];
					};
					if (_QS_player getVariable ['QS_client_inCarrierArea',FALSE]) then {
						_QS_player setVariable ['QS_client_inCarrierArea',FALSE,FALSE];
						if (!(_QS_carrierEnabled isEqualTo 0)) then {
							if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
								if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
									(missionNamespace getVariable 'QS_carrierObject') enableSimulation FALSE;
									{
										if (!isNull (_x select 0)) then {
											if (simulationEnabled (_x select 0)) then {
												(_x select 0) enableSimulation FALSE;
											};
										};
									} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
								};
							};
						};
					};
					if (!(_QS_module_playerInArea_delay isEqualTo 5)) then {
						_QS_module_playerInArea_delay = 5;
					};
				} else {
					if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_carrier_1')) < 300) then {
						if (_QS_player getVariable ['QS_client_inBaseArea',FALSE]) then {
							_QS_player setVariable ['QS_client_inBaseArea',FALSE,FALSE];
						};
						if (_QS_player getVariable ['QS_client_inFOBArea',FALSE]) then {
							_QS_player setVariable ['QS_client_inFOBArea',FALSE,FALSE];
						};
						if (!(_QS_player getVariable ['QS_client_inCarrierArea',FALSE])) then {
							_QS_player setVariable ['QS_client_inCarrierArea',TRUE,FALSE];
							if (!(_QS_carrierEnabled isEqualTo 0)) then {
								if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
									if (!simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
										(missionNamespace getVariable 'QS_carrierObject') enableSimulation TRUE;
										{
											if (!isNull (_x select 0)) then {
												if (!simulationEnabled (_x select 0)) then {
													(_x select 0) enableSimulation TRUE;
												};
											};
										} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
									};
								};
							};
						};
						if (!(_QS_module_playerInArea_delay isEqualTo 5)) then {
							_QS_module_playerInArea_delay = 5;
						};
					} else {
						if (_QS_player getVariable ['QS_client_inBaseArea',FALSE]) then {
							_QS_player setVariable ['QS_client_inBaseArea',FALSE,FALSE];
						};
						if (_QS_player getVariable ['QS_client_inFOBArea',FALSE]) then {
							_QS_player setVariable ['QS_client_inFOBArea',FALSE,FALSE];
						};
						if (_QS_player getVariable ['QS_client_inCarrierArea',FALSE]) then {
							_QS_player setVariable ['QS_client_inCarrierArea',FALSE,FALSE];
							if (!(_QS_carrierEnabled isEqualTo 0)) then {
								if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
									if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
										(missionNamespace getVariable 'QS_carrierObject') enableSimulation FALSE;
										{
											if (!isNull (_x select 0)) then {
												if (simulationEnabled (_x select 0)) then {
													(_x select 0) enableSimulation FALSE;
												};
											};
										} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
									};
								};
							};
						};
						if (!(_QS_module_playerInArea_delay isEqualTo 5)) then {
							_QS_module_playerInArea_delay = 20;
						};
					};
				};
			};
			_QS_module_playerInArea_checkDelay = _QS_uiTime + _QS_module_playerInArea_delay;
		};
	};
	if (_QS_uiTime > _hintCheckDelay) then {
		if (!((missionNamespace getVariable 'QS_managed_hints') isEqualTo [])) then {
			{
				_hintsQueue pushBack _x;
			} forEach (missionNamespace getVariable 'QS_managed_hints');
			missionNamespace setVariable ['QS_managed_hints',[],FALSE];
		};
		if (!(_hintActive)) then {
			if (!(_hintsQueue isEqualTo [])) then {
				_hintsQueue sort TRUE;
				_hintData = _hintsQueue select 0;
				_hintData params [
					'_hintPriority',
					'_hintUseSound',
					'_hintDuration',
					'_hintPreset',
					'_hintText',
					'_hintOtherData',
					'_hintIrrelevantWhen'
				];
				_hintsQueue set [0,FALSE];
				_hintsQueue deleteAt 0;
				if (((!((toLower (str _hintText)) isEqualTo (toLower (str _hintTextPrevious)))) && (_QS_uiTime > (_hintPriorClosedAt + 30))) || {(_QS_uiTime > (_hintPriorClosedAt + 30))}) then {
					if ((_hintIrrelevantWhen isEqualTo -1) || {(_serverTime < _hintIrrelevantWhen)}) then {
						if (!(_hintPreset isEqualTo -1)) then {
							[_hintPreset,_hintOtherData] call _fn_clientHintPresets;
						} else {
							if (!(isStreamFriendlyUIEnabled)) then {
								if (_hintUseSound) then {
									hint _hintText;
								} else {
									hintSilent _hintText;
								};
							};
						};
						_hintTextPrevious = _hintText;
						_hintActive = TRUE;
						_hintActiveDuration = _QS_uiTime + _hintDuration;
					};
				};
			};
		} else {
			if (_QS_uiTime > _hintActiveDuration) then {
				_hintActive = FALSE;
				_hintPriorClosedAt = _QS_uiTime;
				hintSilent '';
			};
		};
		_hintCheckDelay = _QS_uiTime + _hintDelay;
	};
	uiSleep 0.1;
};
hint parseText 'Uho! It appears something has gone wrong. Please report this error code to staff:<br/><br/>456<br/><br/>Thank you for your assistance.';