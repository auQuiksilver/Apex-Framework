/*/
File: fn_clientCore.sqf
Author:

	Quiksilver
	
Last Modified:

	19/10/2020 A3 2.00 by Quiksilver
	
Description:

	Client Core
________________________________________________/*/
private [
	'_timeNow','_puid','_fps','_missionStart','_QS_module_liveFeed','_QS_module_liveFeed_checkDelay','_QS_liveFeed_display','_terrainGrid',
	'_QS_liveFeed_vehicle','_QS_liveFeed_vehicle_current','_QS_liveFeed_camera','_QS_nullPos','_screenPos','_QS_liveFeed_text','_QS_module_liveFeed_noSignalFile',
	'_QS_liveFeed_action_1','_QS_liveFeed_action_2','_QS_module_liveFeed_delay','_displayPos','_QS_fpsArray','_QS_fpsAvgSamples','_QS_module_viewSettings',
	'_QS_RD_client_viewSettings_saveDelay','_QS_RD_client_viewSettings_saveCheckDelay','_revalidate','_QS_RD_client_viewSettings','_QS_RD_client_viewSettings_overall',
	'_QS_RD_client_viewSettings_object','_QS_RD_client_viewSettings_shadow','_QS_RD_client_viewSettings_grass','_QS_RD_client_viewSettings_environment',
	'_mainMenuOpen','_QS_clientHp','_QS_clientMass','_QS_fpsLastPull','_mainMenuIDD','_QS_clientSideScore','_QS_clientScore',
	'_QS_rating','_viewMenuOpen','_viewMenuIDD','_viewDistance','_objectViewDistance','_shadowDistance','_clientViewSettings','_QS_module_crewIndicator',
	'_QS_module_crewIndicator_delay','_QS_module_crewIndicator_checkDelay','_QS_crewIndicatorIDD','_QS_crewIndicatorIDC','_QS_crewIndicator','_QS_crewIndicatorUI',
	'_QS_crewIndicator_imgDriver','_QS_crewIndicator_imgGunner','_QS_crewIndicator_imgCommander','_QS_crewIndicator_imgCargo','_QS_crewIndicator_imgSize','_QS_crewIndicator_color',
	'_QS_crewIndicator_colorHTML','_QS_crewIndicator_imgColor','_QS_crewIndicator_textColor','_QS_crewIndicator_textFont','_QS_crewIndicator_textSize','_crewManifest',
	'_QS_crewIndicator_shown','_fullCrew','_index','_QS_module_fuelConsumption','_QS_module_fuelConsumption_checkDelay','_QS_module_fuelConsumption_factor_2',
	'_QS_module_fuelConsumption_factor_1','_QS_module_fuelConsumption_delay','_unit','_role','_cargoIndex','_turretPath','_personTurret','_text','_roleImg','_roleIcon','_unitName',
	'_QS_module_gearManager','_QS_module_gearManager_checkDelay','_QS_module_gearManager_delay','_QS_module_safezone','_QS_module_safezone_checkDelay',
	'_QS_module_safezone_pos','_QS_module_safezone_radius','_QS_module_safezone_isInSafezone','_QS_firstRun','_QS_module_safezone_playerProtection',
	'_QS_safeZoneText_leaving','_QS_module_safezone_delay','_playerThreshold','_QS_safeZoneText_entering','_QS_side','_QS_firstRun2',
	'_QS_clientATManager','_QS_clientATManager_delay','_QS_tto','_QS_artyEnabled','_QS_underEnforcement','_QS_enforcement_loop',
	'_QS_decayRate','_QS_decayDelay','_QS_fpsCheckDelay','_QS_fpsDelay','_pilotCheck','_QS_action_serviceVehicle','_QS_action_serviceVehicle_text',
	'_QS_action_serviceVehicle_array','_QS_interaction_serviceVehicle','_nearSite','_nearSite2','_nearSite3','_QS_action_clearVehicleInventory','_QS_action_clearVehicleInventory_text',
	'_QS_action_clearVehicleInventory_array','_QS_interaction_clearVehicleInventory','_posInFront','_listOfFrontStuff','_mines','_obj','_objType','_profileName',
	'_profileNameSteam','_iAmPilot','_loadedAtBase','_loadedAtMission','_newArray','_loadedInField','_QS_action_unflipVehicle','_QS_action_unflipVehicle_text',
	'_QS_action_unflipVehicle_array','_QS_interaction_unflipVehicle','_QS_action_revive','_QS_action_revive_text','_QS_action_revive_array','_QS_interaction_revive',
	'_QS_revive_injuredAnims','_QS_module_animState','_QS_module_animState_delay','_QS_module_animState_checkDelay','_QS_animState',
	'_QS_action_arsenal','_QS_action_arsenal_text','_QS_action_arsenal_array','_QS_interaction_arsenal','_cursorDistance','_difficultyEnabledRTD','_QS_action_utilityOffroad',
	'_QS_action_utilityOffroad_textOn','_QS_action_utilityOffroad_textOff','_QS_action_utilityOffroad_array','_QS_interaction_utilityOffroad','_s0','_s2','_QS_module_texture',
	'_QS_module_texture_delay','_QS_module_texture_checkDelay','_QS_action_tow','_QS_action_tow_text','_QS_action_tow_array','_QS_interaction_tow',
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
	'_grpTarget','_pilotAtBase','_QS_module_pilotSafezone_radius','_QS_module_pilotSafezone_checkDelay','_QS_module_pilotSafezone_delay',
	'_QS_module_pilotSafezone_isInSafezone','_QS_action_fob_status','_QS_action_fob_status_text','_QS_action_fob_status_array','_QS_interaction_fob_status','_QS_action_fob_terminals',
	'_QS_action_fob_activate','_QS_action_fob_activate_text','_QS_action_fob_activate_array','_QS_interaction_fob_activate','_QS_action_fob_respawn',
	'_QS_action_fob_respawn_text','_QS_action_fob_respawn_array','_QS_interaction_fob_respawn','_QS_action_crate_customize','_QS_action_crate_customize_text',
	'_QS_action_crate_array','_QS_interaction_customizeCrate','_nearInvSite','_QS_module_fuelConsumption_factor_3',
	'_checkworldtime','_QS_action_names','_QS_allMines','_QS_cameraOn','_QS_baseAreaPolygon','_QS_clientRankManager','_QS_clientRankManager_delay',
	'_QS_module_gearManager_defaultRifle','_QS_radioChannels','_QS_module_radioChannelManager','_QS_module_radioChannelManager_delay','_QS_module_radioChannelManager_checkDelay',
	'_QS_module_radioChannelManager_nearPrimary','_QS_module_radioChannelManager_nearSecondary','_QS_module_radioChannelManager_nearPrimaryRadius','_QS_module_radioChannelManager_nearSecondaryRadius',
	'_QS_module_radioChannelManager_primaryChannel','_QS_module_radioChannelManager_secondaryChannel','_QS_module_radioChannelManager_commandChannel',
	'_QS_module_radioChannelManager_aircraftChannel','_QS_module_radioChannelManager_checkState','_QS_terminalVelocity','_d49','_QS_buttonCtrl',
	'_QS_module_49Opened','_defaultUniform','_QS_worldName','_QS_worldSize','_QS_pilotBabysitter','_QS_maxTimeOnGround','_QS_warningTimeOnGround','_QS_currentTimeOnGround',
	'_QS_secondsCounter','_QS_productVersion','_QS_productVersionSync','_QS_action_pushVehicle','_QS_action_pushVehicle_text','_QS_action_pushVehicle_array',
	'_QS_interaction_pushVehicle','_QS_afkTimer','_QS_afkTimer_playerThreshold','_QS_posWorldPlayer','_QS_action_createBoat','_QS_action_createBoat_text','_QS_action_createBoat_array','_QS_interaction_createBoat',
	'_QS_clientDynamicGroups','_QS_clientDynamicGroups_delay','_QS_clientDynamicGroups_checkDelay','_QS_playerGroup','_QS_clientDynamicGroups_testGrp','_QS_module_swayManager','_QS_module_swayManager_delay',
	'_QS_module_swayManager_checkDelay','_QS_module_swayManager_secWepSwayCoef','_QS_action_sit','_QS_action_sit_text','_QS_action_sit_array','_QS_interaction_sit',
	'_QS_action_sit_chairTypes','_QS_clientOwner','_QS_module_taskManager','_QS_module_taskManager_delay','_QS_module_taskManager_checkDelay','_QS_module_taskManager_simpleTasks','_QS_moveTime','_QS_module_taskManager_currentTask',
	'_QS_module_opsec_checkActions','_opsec_actionTitle','_opsec_actionCode','_opsec_actionArgs','_opsec_actionPriority','_opsec_actionShowWindow','_opsec_actionHideOnUse','_opsec_actionShortcut',
	'_opsec_actionCondition','_opsec_actionRadius','_opsec_actionUnconscious','_opsec_actionTextWindowB','_opsec_actionTextWindowF','_opsec_actionIDs',
	'_opsec_actionParams','_opsec_actionWhitelist','_nearCargoVehicles','_QS_action_loadCargo','_QS_action_loadCargo_text','_QS_action_loadCargo_array',
	'_QS_interaction_loadCargo','_QS_action_loadCargo_vTypes','_QS_action_loadCargo_cargoTypes','_QS_action_loadCargo_validated','_QS_action_loadCargo_vehicle','_thermalsEnabled','_QS_module_revealPlayers',
	'_QS_module_revealPlayers_delay','_QS_module_revealPlayers_checkDelay','_QS_modelInfoPlayer','_QS_rappelling','_QS_action_rappelSelf','_QS_action_rappelSelf_text','_QS_action_rappelSelf_array',
	'_QS_action_rappelAI','_QS_action_rappelAI_text','_QS_action_rappelAI_array','_QS_action_rappelDetach','_QS_action_rappelDetach_text','_QS_action_rappelDetach_array','_QS_interaction_rappelSelf',
	'_QS_interaction_rappelAI','_QS_interaction_rappelDetach','_commandingMenu','_kicked','_QS_module_opsec_memCheck_script','_QS_objectTypePlayer','_QS_action_sit_chairModels','_QS_action_rappelSafety',
	'_QS_action_rappelSafety_textDisable','_QS_action_rappelSafety_textEnable','_QS_action_rappelSafety_array','_QS_interaction_rappelSafety','_QS_arsenal_model','_QS_resolution','_QS_module_opsec_displays_default',
	'_QS_clientDLCs','_QS_module_opsec_return','_QS_module_opsec_checkMarkers','_QS_module_opsec_chatIntercept','_QS_module_opsec_chatIntercept_IDD','_QS_module_opsec_chatIntercept_IDC',
	'_QS_module_opsec_chatIntercept_script','_QS_module_opsec_chatIntercept_code','_allDisplays','_QS_module_opsec_displayIDDstr','_QS_module_opsec_iguiDisplays',
	'_QS_module_opsec_memArrayIGUI','_QS_module_opsec_iguiDisplays_delay','_QS_module_opsec_iguiDisplays_checkDelay',
	'_QS_module_opsec_memArrayMission','_QS_module_opsec_memArrayTitles','_QS_module_opsec_memArrayTitlesMission','_QS_module_opsec_rsctitles',
	'_QS_module_opsec_rsctitles_delay','_QS_module_opsec_rsctitles_checkDelay','_QS_module_opsec_rsctitlesMission_delay','_QS_module_opsec_rsctitlesMission_checkDelay','_QS_module_opsec_rsctitlesMission',
	'_QS_module_opsec_memArrayMission_delay','_QS_module_opsec_memArrayMission_checkDelay','_QS_module_opsec_memoryMission',
	'_QS_module_opsec_memCheck_WorkingArray','_QS_uiTime','_QS_isAdmin','_QS_safezone_action','_QS_action_safezone','_QS_action_safezone_text','_QS_action_safezone_array',
	'_QS_action_activateVehicle','_QS_action_activateVehicle_text','_QS_action_activateVehicle_array','_QS_interaction_activateVehicle','_QS_cursorIntersections',
	'_QS_action_unloadCargo','_QS_action_unloadCargo_text','_QS_action_unloadCargo_array','_QS_interaction_unloadCargo','_QS_action_unloadCargo_vTypes','_QS_action_unloadCargo_cargoTypes',
	'_QS_action_unloadCargo_validated','_QS_action_unloadCargo_vehicle','_nearUnloadCargoVehicles','_QS_interaction_load2','_object','_QS_action_huronContainer','_QS_action_huronContainer_text',
	'_QS_action_huronContainer_array','_QS_interaction_huronContainer','_QS_action_huronContainer_models','_QS_helmetCam_helperType','_QS_module_swayManager_heavyWeapons','_QS_module_swayManager_heavyWeaponCoef_crouch',
	'_QS_module_swayManager_heavyWeaponCoef_stand','_QS_customAimCoef','_QS_recoilCoef','_QS_module_swayManager_recoilCoef_crouch','_QS_module_swayManager_recoilCoef_stand','_QS_module_scAssistant',
	'_QS_module_scAssistant_delay','_QS_module_scAssistant_checkDelay','_sectorFlag','_sectorPhase','_QS_viewSettings_var','_QS_isTanoa','_QS_tanoa_delay','_QS_tanoa_checkDelay',
	'_QS_inGeorgetown','_QS_georgetown_polygon','_QS_georgetown_priorVD','_QS_georgetown_priorOVD','_QS_georgetown_VD','_QS_georgetown_OVD','_QS_laserTarget','_QS_miscDelay5','_backpackWhitelisted','_QS_buttonAction',
	'_QS_module_groupIndicator','_QS_module_groupIndicator_delay','_QS_module_groupIndicator_checkDelay','_QS_module_groupIndicator_radius','_QS_module_groupIndicator_units','_QS_module_groupIndicator_types',
	'_QS_module_groupIndicator_filter','_QS_action_sensorTarget','_QS_action_sensorTarget_array','_QS_interaction_sensorTarget','_QS_virtualSectors_data_public','_QS_toDelete',
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
	'_isAltis','_isTanoa','_QS_carrierEnabled','_array','_QS_action_camonetArmor','_QS_action_camonetArmor_textA','_QS_action_camonetArmor_textB','_QS_action_camonetArmor_array',
	'_QS_interaction_camonetArmor','_QS_action_camonetArmor_anims','_QS_action_camonetArmor_vAnims','_animationSources','_animationSource','_QS_module_highCommand','_QS_module_highCommand_delay',
	'_QS_module_highCommand_checkDelay','_QS_module_highCommand_waypoints','_civSide','_QS_module_gpsJammer','_QS_module_gpsJammer_delay','_QS_module_gpsJammer_checkDelay','_QS_module_gpsJammer_signalDelay',
	'_QS_module_gpsJammer_signalCheck','_QS_module_gpsJammer_ctrlPlayer','_QS_module_gpsJammer_inArea','_isNearRepairDepot','_isNearRepairDepot2','_uavNearRepairDepot','_viewDistance_target','_objectViewDistance_target',
	'_shadowDistance_target','_terrainGrid_target','_deltaVD_script','_fadeView','_arsenalType','_noObjectParent','_parsedText','_QS_module_opsec_hints','_ahHintText','_ahHintList',
	'_QS_destroyerEnabled','_lifeState','_QS_action_RSS','_QS_action_RSS_text','_QS_action_RSS_array','_QS_interaction_RSS'
];
disableSerialization;
_QS_productVersion = productVersion;
_QS_missionVersion = missionNamespace getVariable ['QS_system_devBuild_text',''];
_QS_resolution = getResolution;
_missionStart = systemTime;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_QS_clientDLCs = [(getDLCs 0),(getDLCs 1),(getDLCs 2)];
_timeNow = time;
_serverTime = serverTime;
_QS_uiTime = diag_tickTime;
_QS_player = player;
_namePlayer = name player;
_puid = getPlayerUID player;
_allPlayers = allPlayers;
_QS_clientOwner = clientOwner;
_roleSelectionSystem = missionNamespace getVariable ['QS_RSS_enabled',TRUE];
private _playerRole = player getVariable ['QS_unit_role','rifleman'];
private _roleDisplayName = ['GET_ROLE_DISPLAYNAME',_playerRole] call (missionNamespace getVariable ['QS_fnc_roles',{'Rifleman'}]);
private _roleDisplayNameL = toLower _roleDisplayName;
private _RSS_MenuButton = ((missionNamespace getVariable ['QS_missionConfig_RSS_MenuButton',0]) isNotEqualTo 0);
_objectParent = objectParent player;
_QS_v2 = vehicle player;
_QS_v2Type = typeOf _QS_v2;
_QS_v2TypeL = toLower _QS_v2Type;
_QS_cameraOn = cameraOn;
_QS_cO = cameraOn;
_QS_fpsLastPull = round diag_fps;
_profileName = profileName;
_profileNameSteam = profileNameSteam;
_playerNetId = netId player;
_QS_posWorldPlayer = getPosWorld player;
private _QS_cameraPosition2D = (positionCameraToWorld [0,0,0]) select [0,2];
_QS_moveTime = moveTime player;
_QS_objectTypePlayer = getObjectType player;
_QS_modelInfoPlayer = getModelInfo player;
_lifeState = lifeState player;
_west = WEST;
_QS_side = player getVariable ['QS_unit_side',_west];
_dNull = displayNull;
_objNull = objNull;
_QS_nullPos = [0,0,0];
_QS_firstRun = TRUE;
_mainMenuIDD = 2000;
_mainMenuOpen = FALSE;
_viewMenuIDD = 3000;
_viewMenuOpen = FALSE;
_QS_module_49Opened = FALSE;
_QS_buttonAction = "[] call (missionNamespace getVariable 'QS_fnc_clientMenu2')";
_QS_buttonAction2 = "closeDialog 2; 0 spawn {uiSleep 0.1;createDialog 'QS_client_dialog_menu_roles';};";
_QS_fpsArray = [];
_QS_fpsAvgSamples = 60;
_QS_fpsDelay = 0.5;
_QS_fpsCheckDelay = _timeNow + _QS_fpsDelay;
_QS_terminalVelocity = [10e10,10e14,10e18];
_QS_isAdmin = _puid in (['ALL'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]));
_QS_helmetCam_helperType = 'sign_sphere10cm_f';
_true = TRUE;
_false = FALSE;
_parsedText = parseText '';
_enemysides = _QS_side call (missionNamespace getVariable 'QS_fnc_enemySides');
_civSide = CIVILIAN;
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
missionNamespace setVariable ['QS_client_heartbeat',_timeNow,FALSE];

//===== UI FEEDBACK

0 spawn (missionNamespace getVariable 'QS_fnc_feedback');

/*/========================= View settings module/*/

_QS_module_viewSettings = TRUE;
_QS_RD_client_viewSettings_saveDelay = 600;
_QS_RD_client_viewSettings_saveCheckDelay = time + _QS_RD_client_viewSettings_saveDelay;
player setVariable ['QS_RD_client_viewSettings_currentMode',0,FALSE];
player setVariable ['QS_RD_viewSettings_update',TRUE,FALSE];
_deltaVD_script = scriptNull;
_fadeView = FALSE;
_QS_viewSettings_var = format ['QS_RD_client_viewSettings_%1',_QS_worldName];
if (isNil {profileNamespace getVariable _QS_viewSettings_var}) then {
	_revalidate = TRUE;
} else {
	_QS_RD_client_viewSettings = profileNamespace getVariable [_QS_viewSettings_var,[]];
	if (!(_QS_RD_client_viewSettings isEqualType [])) then {
		_revalidate = TRUE;
	} else {
		if ((count _QS_RD_client_viewSettings) isNotEqualTo 5) then {
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
{
	player setVariable _x;
} forEach [
	['QS_RD_interacting',FALSE,TRUE],
	['QS_RD_canRespawnVehicle',-1,FALSE]
];
_cursorTarget = cursorTarget;
_cursorObject = cursorObject;
_QS_nearEntities_revealDelay = 5;
_QS_nearEntities_revealCheckDelay = time + _QS_nearEntities_revealDelay;
_QS_entityTypes = ['Man','LandVehicle','Air','Ship'];
_QS_entityRange = 5;
_QS_objectTypes = 'All';
_QS_objectRange = 4;
_noObjectParent = TRUE;
private _QS_medicCameraOn = objNull;
_QS_actions = [];
_QS_interaction_escort = FALSE;
_QS_action_escort = nil;
_QS_action_escort_text = 'Escort';
_QS_action_escort_array = [_QS_action_escort_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractEscort')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_load = FALSE;
_QS_interaction_load2 = FALSE;
_QS_action_load = nil;
_QS_action_load_text = 'Load';
_QS_action_load_array = [_QS_action_load_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractLoad')},[],94,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_unload = FALSE;
_QS_action_unload = nil;
_QS_action_unload_text = 'Unload';
_QS_action_unload_array = [_QS_action_unload_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnload')},[],-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_questionCivilian = FALSE;
_QS_action_questionCivilian = nil;
_QS_action_questionCivilian_text = 'Question civilian';
_QS_action_questionCivilian_array = [_QS_action_questionCivilian_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCivilian')},[],92,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_drag = FALSE;
_QS_action_drag = nil;
_QS_action_drag_text = 'Drag';
_QS_action_drag_array = [_QS_action_drag_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractDrag')},[],-9,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_carry = FALSE;
_QS_action_carry = nil;
_QS_action_carry_text = 'Carry';
_QS_action_carry_array = [_QS_action_carry_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCarry')},[],-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_follow = FALSE;
_QS_action_follow = nil;
_QS_action_follow_text = 'Command Follow';
_QS_action_follow_array = [_QS_action_follow_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFollow')},[],89,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_recruit = FALSE;
_QS_action_recruit = nil;
_QS_action_recruit_text = 'Command Recruit';
_QS_action_recruit_array = [_QS_action_recruit_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRecruit')},[],88,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_dismiss = FALSE;
_QS_action_dismiss = nil;
_QS_action_dismiss_text = 'Command Dismiss';
_QS_action_dismiss_array = [_QS_action_dismiss_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractDismiss')},[],-81,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_release = FALSE;
_QS_action_release = nil;
_QS_action_release_text = 'Release';
_QS_action_release_array = [_QS_action_release_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRelease')},[],88,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_respawnVehicle = FALSE;
_QS_action_respawnVehicle = nil;
_QS_action_respawnVehicle_text = 'Respawn vehicle';
_QS_action_respawnVehicle_array = [_QS_action_respawnVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRespawnVehicle')},[],-80,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_vehDoors = FALSE;				
_QS_action_vehDoors = nil;
_QS_action_vehDoors_textOpen = 'Open cargo doors';
_QS_action_vehDoors_textClose = 'Close cargo doors';
_QS_action_vehDoors_array = [_QS_action_vehDoors_textOpen,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractVehicleDoors')},[],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_action_vehDoors_vehicles = [
	'b_heli_transport_01_f','b_heli_transport_01_camo_f','o_heli_light_02_unarmed_f','o_heli_light_02_f','o_heli_light_02_v2_f','o_heli_attack_02_f',
	'o_heli_attack_02_black_f','b_heli_transport_03_f','b_heli_transport_03_unarmed_f','i_heli_transport_02_f','c_idap_heli_transport_02_f',
	'o_heli_transport_04_ammo_black_f','o_heli_transport_04_ammo_f','o_heli_transport_04_bench_black_f',
	'o_heli_transport_04_bench_f','o_heli_transport_04_black_f','o_heli_transport_04_box_black_f',
	'o_heli_transport_04_box_f','o_heli_transport_04_covered_black_f','o_heli_transport_04_covered_f',
	'o_heli_transport_04_f','o_heli_transport_04_fuel_black_f','o_heli_transport_04_fuel_f','o_heli_transport_04_medevac_black_f',
	'o_heli_transport_04_medevac_f','o_heli_transport_04_repair_black_f','o_heli_transport_04_repair_f','b_heli_transport_03_unarmed_green_f',
	'b_ctrg_heli_transport_01_tropic_f','b_ctrg_heli_transport_01_sand_f','o_heli_light_02_dynamicloadout_f','o_heli_attack_02_dynamicloadout_black_f','o_heli_attack_02_dynamicloadout_f',
	'c_van_02_medevac_f','c_van_02_vehicle_f','c_van_02_service_f','c_van_02_transport_f','c_idap_van_02_medevac_f','c_idap_van_02_vehicle_f','c_idap_van_02_transport_f',
	'b_g_van_02_vehicle_f','b_g_van_02_transport_f','o_g_van_02_vehicle_f','o_g_van_02_transport_f','i_c_van_02_vehicle_f','i_c_van_02_transport_f','i_g_van_02_vehicle_f','i_g_van_02_transport_f',
	'b_gen_van_02_vehicle_f','b_gen_van_02_transport_f','i_e_van_02_medevac_f','i_e_van_02_transport_mp_f'
];
_QS_action_serviceVehicle = nil;
_QS_action_serviceVehicle_text = 'Service';
_QS_action_serviceVehicle_array = [_QS_action_serviceVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractServiceVehicle')},[],10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_serviceVehicle = FALSE;
_isNearRepairDepot = FALSE;
_isNearRepairDepot2 = FALSE;
_nearSite = FALSE;
_nearSite2 = FALSE;
_nearSite3 = FALSE;
_QS_action_unflipVehicle = nil;
_QS_action_unflipVehicle_text = 'Unflip';
_QS_action_unflipVehicle_array = [_QS_action_unflipVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnflipVehicle')},[],10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_unflipVehicle = FALSE;

/*/== Revive Anim/*/
_QS_action_revive = nil;
_QS_action_revive_text = 'Revive';
_QS_action_revive_array = [_QS_action_revive_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRevive')},[],99,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_action_AIrevive_array = [_QS_action_revive_text,{_this spawn (missionNamespace getVariable 'QS_fnc_rcAIRevive')},[],99,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_revive = FALSE;
_QS_revive_injuredAnims = [
	'acts_injuredlyingrifle01','acts_injuredlyingrifle02','ainjppnemstpsnonwrfldnon','ainjppnemstpsnonwnondnon','ainjpfalmstpsnonwrfldnon_carried_down',
	'unconscious','amovppnemstpsnonwnondnon','ainjpfalmstpsnonwnondnon_carried_down','unconsciousrevivedefault','unconsciousrevivedefault','unconsciousrevivedefault_a',
	'unconsciousrevivedefault_b','unconsciousrevivedefault_base','unconsciousrevivedefault_c'
];
_checkworldtime = time + 30 + (random 600);
/*/===== Stabilise/*/
_QS_action_stabilise = nil;
_QS_action_stabilise_text = 'Stabilise';
_QS_action_stabilise_array = [_QS_action_stabilise_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractStabilise')},nil,91,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_stabilise = FALSE;
/*/===== Arsenal/*/
_QS_action_arsenal = nil;
_QS_action_arsenal_text = localize 'STR_A3_Arsenal';
_QS_action_arsenal_array = [_QS_action_arsenal_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractArsenal')},[],90,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_arsenal = FALSE;
_QS_arsenal_model = 'a3\weapons_f\ammoboxes\supplydrop.p3d';
/*/===== Role Selection/*/
_QS_action_RSS = nil;
_QS_action_RSS_text = 'Role Selection';
_QS_action_RSS_array = [_QS_action_RSS_text,{closeDialog 2;uiSleep 0.1;createDialog 'QS_client_dialog_menu_roles';},[],89,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_RSS = FALSE;

/*/===== Utility offroad/*/
_QS_action_utilityOffroad = nil;
_QS_action_utilityOffroad_textOn = 'Beacons On';
_QS_action_utilityOffroad_textOff = 'Beacons Off';
_QS_action_utilityOffroad_array = [_QS_action_utilityOffroad_textOn,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUtilityOffroad')},[],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_utilityOffroad = FALSE;
_offroadTypes = [
	'b_g_offroad_01_f','b_g_offroad_01_armed_f','b_g_offroad_01_repair_f','b_gen_offroad_01_gen_f','o_g_offroad_01_f','o_g_offroad_01_armed_f','o_g_offroad_01_repair_f',
	'i_g_offroad_01_f','i_g_offroad_01_armed_f','i_g_offroad_01_repair_f','c_offroad_01_f','c_offroad_01_repair_f','c_idap_offroad_01_f','c_offroad_01_blue_f','c_offroad_01_bluecustom_f',
	'c_offroad_01_darkred_f','c_offroad_01_red_f','c_offroad_01_sand_f','c_offroad_01_white_f','c_offroad_luxe_f','c_offroad_stripped_f','b_g_offroad_01_at_f','o_g_offroad_01_at_f','i_g_offroad_01_at_f'
];
/*/===== Tow/*/
_QS_action_tow = nil;
_QS_action_tow_text = 'Tow';
_QS_action_tow_array = [_QS_action_tow_text,{_this spawn (missionNamespace getVariable 'QS_fnc_vTow')},[],21,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_tow = FALSE;
/*/===== Surrender/*/
_QS_action_commandSurrender = nil;
_QS_action_commandSurrender_text = 'Command Surrender';
_QS_action_commandSurrender_array = [_QS_action_commandSurrender_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSurrender')},[],90,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_commandSurrender = FALSE;
/*/===== Rescue/*/
_QS_action_rescue = nil;
_QS_action_rescue_text = 'Rescue';
_QS_action_rescue_array = [_QS_action_rescue_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRescue')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_rescue = FALSE;
/*/===== Secure/*/
_QS_action_secure = nil;
_QS_action_secure_text = 'Secure';
_QS_action_secure_array = [_QS_action_secure_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSecure')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_secure = FALSE;
/*/===== Examine/*/
_QS_action_examine = nil;
_QS_action_examine_text = 'Examine';
_QS_action_examine_array = [_QS_action_examine_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractExamine')},[],94,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_examine = FALSE;
/*/===== Turret safety/*/
_QS_action_turretSafety = nil;
_QS_action_turretSafety_text = 'Turret safety';
_QS_action_turretSafety_array = [_QS_action_turretSafety_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractTurretControl')},[],-50,FALSE,FALSE,'','TRUE',-1,FALSE,''];
_QS_interaction_turretSafety = FALSE;
missionNamespace setVariable ['QS_inturretloop',FALSE,FALSE];
_QS_turretSafety_heliTypes = ['B_Heli_Transport_01_camo_F','B_Heli_Transport_01_F','B_Heli_Transport_03_F','B_CTRG_Heli_Transport_01_sand_F','B_CTRG_Heli_Transport_01_tropic_F'];
/*/===== Ear collector/*/
_QS_action_ears = nil;
_QS_action_ears_text = 'Collect ear';
_QS_action_ears_array = [_QS_action_ears_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractEar')},[],-51,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_ears = FALSE;
/*/===== Teeth collector/*/
_QS_action_teeth = nil;
_QS_action_teeth_text = 'Collect gold tooth';
_QS_action_teeth_array = [_QS_action_teeth_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractTooth')},[],-52,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_teeth = FALSE;
/*/===== Join group/*/
_QS_action_joinGroup = nil;
_QS_action_joinGroup_text = 'Join group';
_QS_action_joinGroup_array = [_QS_action_joinGroup_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractJoinGroup')},[],-50,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_joinGroup = FALSE;
_QS_joinGroup_privateVar = 'BIS_dg_pri';
_grpTarget = grpNull;
/*/===== Fob status terminal/*/
_QS_action_fob_terminals = [];
_QS_action_fob_status = nil;
_QS_action_fob_status_text = 'FOB Status';
_QS_action_fob_status_array = [_QS_action_fob_status_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},1,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_status = FALSE;
/*/===== Activate FOB/*/
_QS_action_names = worldName;
_QS_action_fob_activate = nil;
_QS_action_fob_activate_text = 'Activate FOB';
_QS_action_fob_activate_array = [_QS_action_fob_activate_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},2,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_activate = FALSE;
/*/===== Enable FOB Respawn/*/
_QS_action_fob_respawn = nil;
_QS_action_fob_respawn_text = 'Enable FOB Respawn';
_QS_action_fob_respawn_array = [_QS_action_fob_respawn_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},3,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_respawn = FALSE;
/*/===== Crate Customization/*/
_QS_action_crate_customize = nil;
_QS_action_crate_customize_text = 'Edit Inventory';
_QS_action_crate_array = [_QS_action_crate_customize_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCustomizeInventory')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_customizeCrate = FALSE;
_nearInvSite = FALSE;
/*/===== Push Vehicle/*/
_QS_action_pushVehicle = nil;
_QS_action_pushVehicle_text = 'Push vehicle';
_QS_action_pushVehicle_array = [_QS_action_pushVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractPush')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_pushVehicle = FALSE;
/*/===== Create Boat/*/
_QS_action_createBoat = nil;
_QS_action_createBoat_text = 'Inflate boat';
_QS_action_createBoat_array = [_QS_action_createBoat_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCreateBoat')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_createBoat = FALSE;
/*/===== Recover Boat (boat rack)/*/
_QS_action_recoverBoat = nil;
_QS_action_recoverBoat_text = if (isLocalized 'STR_A3_action_Recover_Boat') then {localize 'STR_A3_action_Recover_Boat'} else {'Recover boat'};
_QS_action_recoverBoat_array = [_QS_action_recoverBoat_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRecoverBoat')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_recoverBoat = FALSE;
/*/===== Sit/*/
_QS_action_sit = nil;
_QS_action_sit_text = 'Sit';
_QS_action_sit_array = [_QS_action_sit_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSit')},1,50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_sit = FALSE;
_QS_action_sit_chairTypes = ['Land_CampingChair_V1_F','Land_CampingChair_V2_F','Land_ChairPlastic_F','Land_RattanChair_01_F','Land_ChairWood_F','Land_OfficeChair_01_F','Land_ArmChair_01_F'];
_QS_action_sit_chairModels = ['campingchair_v1_f.p3d','campingchair_v2_f.p3d','chairplastic_f.p3d','rattanchair_01_f.p3d','chairwood_f.p3d','officechair_01_f.p3d','armchair_01_f.p3d'];
/*/===== Load Cargo/*/
_QS_action_loadCargo = nil;
_QS_action_loadCargo_text = 'Load cargo';
_QS_action_loadCargo_array = [_QS_action_loadCargo_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractLoadCargo')},[],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
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
_QS_action_unloadCargo_array = [_QS_action_unloadCargo_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnloadCargo')},[],-30,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_unloadCargo = FALSE;
_QS_action_unloadCargo_vTypes = [];
_QS_action_unloadCargo_cargoTypes = [];
_QS_action_unloadCargo_validated = FALSE;
_QS_action_unloadCargo_vehicle = objNull;
_nearUnloadCargoVehicles = [];
/*/===== Interact Activate Vehicle/*/
_QS_action_activateVehicle = nil;
_QS_action_activateVehicle_text = 'Activate vehicle';
_QS_action_activateVehicle_array = [_QS_action_activateVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractActivateVehicle')},nil,49,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_activateVehicle = FALSE;
/*/===== Huron Medical Container (Simple Object)/*/
_QS_action_huronContainer = nil;
_QS_action_huronContainer_text = 'Treat at Medical Station';
_QS_action_huronContainer_array = [_QS_action_huronContainer_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractMedStation')},nil,48,TRUE,TRUE,'','TRUE',-1,FALSE,''];
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
	'a3\air_f_orange\uav_06\box_uav_06_f.p3d',
	'a3\props_f_enoch\military\camps\portablecabinet_01_medical_f.p3d'
];
/*/===== Sensor Target/*/
_QS_action_sensorTarget = nil;
_QS_action_sensorTarget_array = ['Report target',{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSensorTarget')},nil,60,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_sensorTarget = FALSE;
/*/===== Attach Explosive (underwater)/*/
_QS_action_attachExp = nil;
_QS_action_attachExp_text = 'Put Explosive Charge';
_QS_action_attachExp_textReal = '';
_QS_action_attachExp_array = [_QS_action_attachExp_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnderwaterDemo')},nil,59,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_attachExp = FALSE;
/*/===== Cruise control/*/
private _QS_interaction_cc = FALSE;
private _QS_action_cc = nil;
private _QS_action_cc_array = ['Set Cruise Control',{_this spawn (missionNamespace getVariable 'QS_fnc_setCruiseControl')},[],-50,FALSE,FALSE,'','TRUE',-1,FALSE,''];
/*/===== UGV/*/
_QS_action_ugv_types = [
	'b_ugv_01_f',
	'b_t_ugv_01_olive_f',
	'o_ugv_01_f',
	'o_t_ugv_01_ghex_f',
	'i_ugv_01_f',
	'c_idap_ugv_01_f',
	'i_e_ugv_01_f',
	'i_e_ugv_01_rcws_f'
];
_QS_uav = objNull;
_QS_ugv = objNull;
_QS_ugvTow = objNull;
_QS_action_ugv_stretcherModel = 'a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d';
_QS_action_ugvLoad = nil;
_QS_action_ugvLoad_text = 'Load';
_QS_action_ugvLoad_array = [_QS_action_ugvLoad_text,{(_this # 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,4],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_ugvLoad = FALSE;
_QS_action_ugvUnload = nil;
_QS_action_ugvUnload_text = 'Unload';
_QS_action_ugvUnload_array = [_QS_action_ugvUnload_text,{(_this # 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,5],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_ugvUnload = FALSE;
_QS_interaction_serviceDrone = FALSE;
_QS_interaction_towUGV = FALSE;
_QS_action_towUGV = nil;
_QS_action_uavSelfDestruct = nil;
_QS_action_uavSelfDestruct_text = 'Self destruct';
_QS_action_uavSelfDestruct_array = [_QS_action_uavSelfDestruct_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUAVSelfDestruct')},nil,-20,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_uavSelfDestruct = FALSE;
_QS_ugvSD = objNull;
/*/===== Carrier Launch/*/
_QS_action_carrierLaunch = nil;
_QS_action_carrierLaunch_text = 'Initiate Launch Sequence';
_QS_action_carrierLaunch_array = [_QS_action_carrierLaunch_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCarrierLaunch')},nil,85,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_carrierLaunch = FALSE;
_QS_carrier_cameraOn = objNull;
_QS_carrier_inPolygon = FALSE;
_QS_carrierPolygon = [];
_QS_carrierLaunchData = [];
_QS_carrierPos = [0,0,0];
_QS_carrierEnabled = missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0];
_QS_destroyerEnabled = missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0];
/*/===== Armor Camonets/*/
_QS_action_camonetArmor = nil;
_QS_action_camonetArmor_textA = 'Deploy camo net';
_QS_action_camonetArmor_textB = 'Remove camo net';
_QS_action_camonetArmor_array = [_QS_action_camonetArmor_textA,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCamoNet')},[objNull,0],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_camonetArmor = FALSE;
_QS_action_camonetArmor_anims = ['showcamonethull','showcamonetcannon','showcamonetcannon1','showcamonetturret','showcamonetplates1','showcamonetplates2'];
_QS_action_camonetArmor_vAnims = [];
/*/===== Armor Slat/*/
_QS_action_slatArmor = nil;
_QS_action_slatArmor_textA = 'Mount slat armor';
_QS_action_slatArmor_textB = 'Remove slat armor';
_QS_action_slatArmor_array = [_QS_action_slatArmor_textA,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSlatArmor')},[objNull,0],9,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_slatArmor = FALSE;
_QS_action_slatArmor_anims = ['showslathull','showslatturret'];
_QS_action_slatArmor_vAnims = [];
_animationSources = [];
_animationSource = configNull;
/*/===== Advanced Rappelling/*/
_QS_rappelling = TRUE;
if (_QS_rappelling) then {
	_QS_action_rappelSelf = nil;
	_QS_action_rappelSelf_text = 'Fastrope';
	_QS_action_rappelSelf_array = [_QS_action_rappelSelf_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},1,-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelSelf = FALSE;
	_QS_action_rappelAI = nil;
	_QS_action_rappelAI_text = 'Fastrope AI units';
	_QS_action_rappelAI_array = [_QS_action_rappelAI_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},2,-11,FALSE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelAI = FALSE;
	_QS_action_rappelDetach = nil;
	_QS_action_rappelDetach_text = 'Detach fastrope';
	_QS_action_rappelDetach_array = [_QS_action_rappelDetach_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},3,48,TRUE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelDetach = FALSE;
	_QS_action_rappelSafety = nil;
	_QS_action_rappelSafety_textDisable = 'Disable fastrope';
	_QS_action_rappelSafety_textEnable = 'Enable fastrope';
	_QS_action_rappelSafety_array = [_QS_action_rappelSafety_textDisable,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},4,-12,FALSE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelSafety = FALSE;
};
/*/============================ Sandbags/*/
_QS_action_sandbagDeploy = nil;
_QS_action_sandbagDeploy_text = 'Deploy sandbag wall';
_QS_action_sandbagDeploy_array = [];
_QS_interaction_sandbagDeploy = FALSE;

_QS_action_sandbagRetract = nil;
_QS_action_sandbagRetract_text = 'Pick up';
_QS_action_sandbagRetract_array = [];
_QS_interaction_sandbagRetract = FALSE;

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
	player setVariable ['QS_RD_client_liveFeed',FALSE,FALSE];
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
_QS_module_gearManager = TRUE && ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isNotEqualTo 3);
_arsenalType = missionNamespace getVariable ['QS_missionConfig_Arsenal',1];
missionNamespace setVariable ['QS_client_arsenalData',([(player getVariable ['QS_unit_side',WEST]),(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_data_arsenal')),FALSE];
_QS_module_gearManager_delay = 3;
_QS_module_gearManager_checkDelay = time + _QS_module_gearManager_delay;
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
_playerThreshold = 0;
if (!isNull (missionNamespace getVariable ['QS_airdefense_laptop',objNull])) then {
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
				5,
				FALSE,
				''
			];
			_airDefenseLaptop setUserActionText [_QS_airbaseDefense_action_1,'Activate air defense',(format ["<t size='3'>%1</t>",'Activate air defense'])];
		};
	};
};

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
_QS_action_safezone_array = [_QS_action_safezone_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractWeaponSafety')},nil,-99,FALSE,TRUE,'DefaultAction','TRUE',-1,FALSE];
_QS_module_safezone_speedlimit_enabled = TRUE;
_QS_module_safezone_speedlimit_event = nil;
_QS_module_safezone_speedlimit_code = {
	if (!isNull (objectParent player)) then {
		_vehicle = vehicle player;
		if (_vehicle isKindOf 'LandVehicle') then {
			if (local _vehicle) then {
				_vPos = getPosATL _vehicle;
				if ((missionNamespace getVariable ['QS_baseProtection_polygons',[]]) isNotEqualTo []) then {
					if (((missionNamespace getVariable 'QS_baseProtection_polygons') findIf {(_vPos inPolygon _x)}) isNotEqualTo -1) then {
						if (isTouchingGround _vehicle) then {
							_vectorSpeed = (vectorMagnitude (velocityModelSpace _vehicle)) * 3.6;
							if (_vectorSpeed > 10) then {
								private _pos1 = [0,0,0];
								private _pos2 = [0,0,0];
								{
									private _polygon = _x;
									for '_i' from 0 to ((count _polygon) - 1) step 1 do {
										_pos1 = _polygon # _i;
										if (_i isEqualTo ((count _polygon) - 1)) then {
											_pos2 = _polygon # 0;
										} else {
											_pos2 = _polygon # (_i + 1);
										};
										{
											drawLine3D _x;
										} forEach [
											[_pos1,_pos2,[1,0,0,1]],
											[[_pos1 # 0,_pos1 # 1,((_pos1 # 2) + 0.5)],[_pos2 # 0,_pos2 # 1,((_pos2 # 2) + 0.5)],[1,0,0,1]],
											[[_pos1 # 0,_pos1 # 1,((_pos1 # 2) + 0.25)],[_pos2 # 0,_pos2 # 1,((_pos2 # 2) + 0.25)],[1,0,0,1]],
											[[_pos1 # 0,_pos1 # 1,((_pos1 # 2) - 0.5)],[_pos2 # 0,_pos2 # 1,((_pos2 # 2) - 0.5)],[1,0,0,1]],
											[[_pos1 # 0,_pos1 # 1,((_pos1 # 2) - 0.25)],[_pos2 # 0,_pos2 # 1,((_pos2 # 2) - 0.25)],[1,0,0,1]]
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
_pilotAtBase = TRUE;
_difficultyEnabledRTD = difficultyEnabledRTD;
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
_QS_module_leaderboards_delay = 5;
_QS_module_leaderboards_checkDelay = _timeNow + _QS_module_leaderboards_delay;
_QS_module_leaderboards_pilots = TRUE;
/*/===== Difficulties propagation/*/
_QS_reportDifficulty = TRUE;
_QS_reportDifficulty_delay = 25;
_QS_reportDifficulty_checkDelay = _timeNow + _QS_reportDifficulty_delay;
_thermalOptics = ['optic_Nightstalker','optic_tws','optic_tws_mg'];
_hasThermals = ((primaryWeaponItems player) findIf {(_x in _thermalOptics)}) isEqualTo -1;
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
	FALSE
];
_clientDifficulty = player getVariable 'QS_clientDifficulty';
if (!(_clientDifficulty # 0)) then {
	player setVariable ['QS_stamina_multiplier',[FALSE,(time + 900)],FALSE];
} else {
	if (!((player getVariable 'QS_stamina_multiplier') # 0)) then {
		if (time > ((player getVariable 'QS_stamina_multiplier') # 1)) then {
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
if (isNil {player getVariable 'QS_ClientUTexture2'}) then {
	player setVariable ['QS_ClientUTexture2','',FALSE];
};
if (isNil {player getVariable 'QS_ClientUTexture2_Uniforms2'}) then {
	player setVariable ['QS_ClientUTexture2_Uniforms2',[],FALSE];
};
player setVariable ['QS_ClientVTexture',[_myV,_puid,'',(_timeNow + 5)],FALSE];
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
_QS_module_radioChannelManager_aircraftChannel = 2;
_QS_module_radioChannelManager_checkState = {
	params ['_atcMarkerPos','_tocMarkerPos'];
	private _c = FALSE;
	if ((player distance2D _atcMarkerPos) < 12) then {
		if (((getPosATL player) # 2) > 5) then {
			if (isNull (objectParent player)) then {
				_c = TRUE;
			};
		};
	};
	if ((player distance2D _tocMarkerPos) < 10) then {
		if (((getPosATL player) # 2) < 7) then {
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
_QS_module_swayManager_heavyWeapons = [
	'srifle_gm6_f','srifle_gm6_lrps_f','srifle_gm6_sos_f','srifle_lrr_f','srifle_lrr_lrps_f','srifle_lrr_sos_f','srifle_gm6_camo_f',
	'srifle_gm6_camo_lrps_f','srifle_gm6_camo_sos_f','srifle_lrr_camo_f','srifle_lrr_camo_lrps_f','srifle_lrr_camo_sos_f',
	'srifle_lrr_tna_f','srifle_gm6_ghex_f','srifle_lrr_tna_lrps_f','srifle_gm6_ghex_lrps_f','mmg_01_base_f','mmg_01_hex_arco_lp_f',
	'mmg_01_hex_f','mmg_01_tan_f','mmg_02_base_f','mmg_02_black_f','mmg_02_black_rco_bi_f','mmg_02_camo_f','mmg_02_sand_f','mmg_02_sand_rco_lp_f'
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
_QS_tanoa_delay = 5;
_QS_tanoa_checkDelay = _QS_uiTime + _QS_tanoa_delay;
if (_QS_worldName in ['Altis','Tanoa']) then {
	_QS_isTanoa = TRUE;	/*/ whatever /*/
	_QS_inGeorgetown = FALSE;
	_QS_georgetown_polygon = [
		[[3481.62,13370.2,0],[3577.57,13285.5,0],[3664.88,13279.3,0],[3625.13,13136.5,0],[3614.42,12940.3,0],[3543.96,12859.9,0],[3446.32,12885.4,0],[3395.27,12872.1,0],[3267.38,13073.3,0],[3266.97,13184.7,0]],
		[[5588.88,10242.2,4.16775],[5807.1,10171,0.00125599],[5895.19,10388.9,0.0247574],[5844.87,10701.6,0.110656],[5724.18,10706,0.00174642],[5634.55,10656.1,8.57687]]
	] select (_QS_worldName isEqualTo 'Tanoa');
	_QS_georgetown_priorVD = viewDistance;
	_QS_georgetown_priorOVD = getObjectViewDistance # 0;
	_QS_georgetown_VD = 500;
	_QS_georgetown_OVD = 500;
};
/*/===== Module Group Indicator/*/
_QS_module_groupIndicator = TRUE;
_QS_module_groupIndicator_delay = 0.5;
_QS_module_groupIndicator_checkDelay = _QS_uiTime + _QS_module_groupIndicator_delay;
_QS_module_groupIndicator_radius = 50;	// 45, but seems to be clipped off with nearentities command
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

/*/===== GPS Jammer helper/*/
_QS_module_gpsJammer = TRUE;
_QS_module_gpsJammer_delay = 3;
_QS_module_gpsJammer_checkDelay = _QS_uiTime + _QS_module_gpsJammer_delay;
_QS_module_gpsJammer_signalDelay = 10;
_QS_module_gpsJammer_signalCheck = _QS_uiTime + _QS_module_gpsJammer_signalDelay;
_QS_module_gpsJammer_ctrlPlayer = (findDisplay 12) displayCtrl 1202;
_QS_module_gpsJammer_inArea = FALSE;
/*/===== Operational Security Module - will detect some low-hanging fruit. To date it has caught around 60 cheaters./*/
if (!((uiNamespace getVariable ['BIS_shownChat',TRUE]) isEqualType TRUE)) exitWith {
	[
		40,
		[
			time,
			serverTime,
			(name player),
			profileName,
			profileNameSteam,
			(getPlayerUID player),
			2,
			(format ['Anti-Hack * BIS_shownChat : %1',(uiNamespace getVariable 'BIS_shownChat'),2]),
			player,
			productVersion
		]
	] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	//disableUserInput TRUE;
	endMission 'QS_RD_end_2';
};
_QS_productVersionSync = ((_QS_productVersion # 2) isEqualTo (call (missionNamespace getVariable 'QS_fnc_getAHCompat')));
_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
if (_QS_module_opsec) then {
	_QS_module_opsec_delay = 15;
	_QS_module_opsec_checkDelay = _timeNow + _QS_module_opsec_delay;
	_QS_module_opsec_recoilSway = TRUE;											/*/ check recoil and sway and anim speed /*/
	_QS_module_opsec_hidden = TRUE;												/*/ check hidden /*/
	_QS_module_opsec_menus = TRUE;												/*/ check menus /*/
	_QS_module_opsec_vars = FALSE;												/*/ check variables /*/
	_QS_module_opsec_patches = TRUE && _QS_productVersionSync;							/*/ check patches /*/
	_QS_module_opsec_checkScripts = FALSE;										/*/ check scripts /*/
	_QS_module_opsec_checkActions = TRUE;										/*/ check action menu /*/
	_QS_module_opsec_checkMarkers = FALSE;										/*/ check map markers /*/
	_QS_module_opsec_chatIntercept = TRUE;										/*/ check chat box /*/
	_QS_module_opsec_memory = TRUE && _QS_productVersionSync;					/*/ check memory editing /*/
	_QS_module_opsec_memoryMission = TRUE;										/*/ check memory editing of mission displays /*/
	_QS_module_opsec_iguiDisplays = TRUE && _QS_productVersionSync;				/*/ check memory editing of igui displays/*/
	_QS_module_opsec_rsctitles = TRUE && _QS_productVersionSync;				/*/ check memory editing of titles /*/
	_QS_module_opsec_rsctitlesMission = TRUE;									/*/ check memory editing of titles (mission)/*/
	_QS_module_opsec_hints = TRUE && (!(_puid in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))));
	_QS_module_opsec_detected = 0;
	_detected = '';
	_QS_module_opsec_chatIntercept_IDD = 24;
	_QS_module_opsec_chatIntercept_IDC = 101; 
	_QS_module_opsec_chatIntercept_script = scriptNull;
	_QS_module_opsec_chatIntercept_code = {
		disableSerialization;
		params ['_display','_fn_inString'];
		_display = _this # 0;
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
				//comment 'Too many controls';
				if (!isNull (findDisplay 24)) then {
					(findDisplay 24) closeDisplay 2;
				};
			};
			if (isNull (findDisplay 24)) exitWith {};
			_chatText = ctrlText ((findDisplay 24) displayCtrl 101);
			_chatTextLower = toLower _chatText;
			if ((count _chatText) > _maxCharacters) then {
				//comment 'Too many characters';
				50 cutText [(format ['Character limit (140) exceeded',(count _chatText),_maxCharacters]),'PLAIN DOWN',1];
				((findDisplay 24) displayCtrl 101) ctrlSetText (_chatText select [0,140]);
			};
			if ([_chatTextLower,0,_fn_inString] call (missionNamespace getVariable 'QS_fnc_ahScanString')) then {
				//comment 'Blacklisted string in chat';
				if (!isNull (findDisplay 24)) then {
					(findDisplay 24) closeDisplay 2;
				};
			};
			if (!('ItemRadio' in (assignedItems player))) then {
				if (currentChannel isNotEqualTo 5) then {
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
		params ['_type','','','','',''];
		private _QS_module_opsec_detected = 0;
		private _detected = '';
		private _onLoad = [];
		private _onUnload = [];
		_canSuspend = canSuspend;
		if (_type isEqualTo 'RscDisplay') then {
			{
				_onLoad = toArray (getText (configFile >> (_x # 1) >> 'onLoad'));
				if ((_onLoad isNotEqualTo (_x # 2)) && (_onLoad isNotEqualTo '') && (_onLoad isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified Display Method OL: %1 (Memory Hack)',(_x # 1)];
				};
				_onUnload = toArray (getText (configFile >> (_x # 1) >> 'onUnload'));
				if ((_onUnload isNotEqualTo (_x # 3)) && (_onUnload isNotEqualTo '') && (_onUnload isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified Display Method OUL: %1 (Memory Hack)',(_x # 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.005;
				};
			} forEach (_this # 5);
		};
		if (_type isEqualTo 'IGUIDisplay') then {
			{
				_onLoad = toArray (getText (configFile >> 'RscInGameUI' >> (_x # 1) >> 'onLoad'));
				if ((_onLoad isNotEqualTo (_x # 2)) && (_onLoad isNotEqualTo '') && (_onLoad isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					if (['RscUnitInfoAirRTDFullDigital',(_x # 1),FALSE] call _fn_inString) then {
						_QS_module_opsec_detected = 1;
					};
					_detected = format ['Modified IGUI Method OL: %1 (Memory Hack)',(_x # 1)];
				};
				_onUnload = toArray (getText (configFile >> 'RscInGameUI' >> (_x # 1) >> 'onUnload'));
				if ((_onUnload isNotEqualTo (_x # 3)) && (_onUnload isNotEqualTo '') && (_onUnload isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					if (['RscUnitInfoAirRTDFullDigital',(_x # 1),FALSE] call _fn_inString) then {
						_QS_module_opsec_detected = 1;
					};
					_detected = format ['Modified IGUI Method OUL: %1 (Memory Hack)',(_x # 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this # 5);		
		};
		if (_type isEqualTo 'MissionDisplay') then {
			{
				_onLoad = toArray (getText (missionConfigFile >> (_x # 1) >> 'onLoad'));
				if ((_onLoad isNotEqualTo (_x # 2)) && (_onLoad isNotEqualTo '') && (_onLoad isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified MissionDisplay Method OL: %1 (Memory Hack)',(_x # 1)];
				};
				_onUnload = toArray (getText (missionConfigFile >> (_x # 1) >> 'onUnload'));
				if ((_onUnload isNotEqualTo (_x # 3)) && (_onUnload isNotEqualTo '') && (_onUnload isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified MissionDisplay Method OUL: %1 (Memory Hack)',(_x # 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this # 5);		
		};
		if (_type isEqualTo 'RscTitles') then {
			{
				_onLoad = toArray (getText (configFile >> 'RscTitles' >> (_x # 1) >> 'onLoad'));
				if ((_onLoad isNotEqualTo (_x # 2)) && (_onLoad isNotEqualTo '') && (_onLoad isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OL: %1 (Memory Hack)',(_x # 1)];
				};
				_onUnload = toArray (getText (configFile >> 'RscTitles' >> (_x # 1) >> 'onUnload'));
				if ((_onUnload isNotEqualTo (_x # 3)) && (_onUnload isNotEqualTo '') && (_onUnload isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OUL: %1 (Memory Hack)',(_x # 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this # 5);
		};
		if (_type isEqualTo 'MissionTitles') then {
			{
				_onLoad = toArray (getText (missionConfigFile >> 'RscTitles' >> (_x # 1) >> 'onLoad'));
				if ((_onLoad isNotEqualTo (_x # 2)) && (_onLoad isNotEqualTo '') && (_onLoad isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OL: %1 (Memory Hack)',(_x # 1)];
				};
				_onUnload = toArray (getText (missionConfigFile >> 'RscTitles' >> (_x # 1) >> 'onUnload'));
				if ((_onUnload isNotEqualTo (_x # 3)) && (_onUnload isNotEqualTo '') && (_onUnload isNotEqualTo [])) then {
					_QS_module_opsec_detected = 2;
					_detected = format ['Modified RscTitles Method OUL: %1 (Memory Hack)',(_x # 1)];
				};
				if (_canSuspend) then {
					uiSleep 0.01;
				};
			} forEach (_this # 5);		
		};
		if (_QS_module_opsec_detected isNotEqualTo 0) then {
			[
				40,
				[
					time,
					serverTime,
					(_this # 1),
					(_this # 2),
					(_this # 3),
					(_this # 4),
					_QS_module_opsec_detected,
					_detected,
					player,
					productVersion
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
		'','rscmainmenu','rscmovehigh','#watch','#watch0','rscwatchdir','rscwatchmovedir','#getin','#rscstatus','rsccallsupport','#action',
		'rsccombatmode','rscformations','rscteam','rscselectteam','rscreply','#user:bis_menu_groupcommunication','#custom_radio',
		'rscradio','rscgrouprootmenu','rscmenureply','rscmenustatus','#user:bis_fnc_addcommmenuitem_menu','rscmenumove','rscmenuformations',
		'#get_in','#get_in371','rscmenucombatmode','#watch712','rscmenuengage','#get_int0','#watch95','#action16','rscmenuteam','#get_in52','rscmenuwatchdir','rscmenuwatchmovedir',
		'rscburst','#artillery','rscmenuselectteam',
		'#user:hc_targets_0','#user:hc_missions_0','#user:hc_custom_0','#user:hcwpwaituntil','#user:hcwpwaitradio',
		'rschcmainmenu','rschcmovehigh','rschcwatchdir','rschcspeedmode',
		'rschccombatmode','rschcformations','rschcteam',
		'rschcreply','rschcgrouprootmenu','rschcwprootmenu',
		'rschcwptype','rschcwpcombatmode','rschcwpformations',
		'rschcwpspeedmode','rschcwpwait'
	];
	/*/===== blacklist of text for hints/*/
	_ahHintList = [
		'god',
		'teleport',
		'cheat',
		'hack'
	];
	_QS_module_opsec_memArray = [0] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayIGUI = [1] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayMission = [2] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayTitles = [3] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	_QS_module_opsec_memArrayTitlesMission = [4] call (missionNamespace getVariable 'QS_fnc_clientMemArrays');
	if (_QS_module_opsec_patches) then {
		_patchList = (call (missionNamespace getVariable 'QS_data_patches')) apply { (toLower _x) };
		_binConfigPatches = configFile >> 'CfgPatches';
		private _patchConfigName = '';
		for '_i' from 0 to ((count _binConfigPatches) - 1) step 1 do {
			_patchEntry = _binConfigPatches select _i;
			if (isClass _patchEntry) then {
				_patchConfigName = toLower (configName _patchEntry);
				if (!(_patchConfigName in _patchList)) then {
					if ((!(['jsrs',_patchConfigName,FALSE] call _fn_inString)) && (!(['jpex',_patchConfigName,FALSE] call _fn_inString)) && (!(['blastcore',_patchConfigName,FALSE] call _fn_inString)) && (!(['aegis',_patchConfigName,FALSE] call _fn_inString))) then {
						_detected = format ['Unknown Addon Patch: %1',_patchConfigName];
						_QS_module_opsec_detected = 1;	// change this to 2 to force a kick instead
					};
				};
			};
		};
		_patchConfigName = nil;
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
		'title','missiontitle','difficultytitle','playersname','buttoncancel','buttonsave','buttonskip','buttonrespawn','buttonoptions',
		'buttonvideo','buttonaudio','buttoncontrols','buttongame','buttontutorialhints','buttonabort','debugconsole','feedback','messagebox',
		'cba_credits_m_p','cba_credits_cont_c','version','trafficlight','trafflight'
	];
	{
		_child = _x;
		if (!((toLower (configName _child)) in _allowedChildren)) exitWith {
			_QS_module_opsec_detected = 1;
			_detected = configName _child;
		};
	} forEach _children;
	_allowedChildren = nil;
	_children = nil;
	if ((toLower (getText (configFile >> 'CfgFunctions' >> 'init'))) isNotEqualTo 'a3\functions_f\initfunctions.sqf') then {
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
		'igui_bcg_rgb_a','igui_bcg_rgb_r','igui_bcg_rgb_g','igui_bcg_rgb_b','igui_grid_mission_x',
		'igui_grid_mission_y','igui_grid_mission_w','igui_grid_mission_h'
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
	if (_QS_module_opsec_detected isNotEqualTo 0) then {
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
				player,
				_QS_productVersion
			]		
		] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	};
} else {
	_QS_module_opsec_hints = FALSE;
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
	};
	for '_x' from 0 to 1 step 0 do {
		_ID1 = (findDisplay 46) displayAddEventHandler ['KeyDown',{call (missionNamespace getVariable 'QS_fnc_clientEventKeyDown')}];
		_ID2 = (findDisplay 46) displayAddEventHandler ['KeyUp',{call (missionNamespace getVariable 'QS_fnc_clientEventKeyUp')}];
		if (_ID1 isNotEqualTo -1) exitWith {
			missionNamespace setVariable ['QS_client_keyEvents',[_ID1,_ID2],FALSE];
		};
		uiSleep 1;
	};
};
player setVariable ['BIS_dg_ini',TRUE,TRUE];
[''] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
/*/========== Transfer third-party loadouts to Arsenal/*/
0 spawn (missionNamespace getVariable 'QS_fnc_clientVAS2VA');
//player setVariable ['QS_clientOwner',clientOwner,TRUE];
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
			if (isNull (getAssignedCuratorLogic player)) exitWith {systemChat 'Curator Module initialization failed. Please abort to server browser and reconnect';};
		};
	};
};
if ((damage player) isNotEqualTo 0) then {
	player setDamage [0,FALSE];
};
[(((player getVariable _QS_viewSettings_var) # 0) # 0)] spawn {
	scriptName 'QS - Ramp View Distance';
	_targetViewDistance = _this # 0;
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
		_position = [((_position # 0) + 10 - (random 20)),((_position # 1) + 10 - (random 20)),(_position # 2)];
	};
	if (_QS_worldName isEqualTo 'Tanoa') then {
		_position = [((_position # 0) + 6 - (random 12)),((_position # 1) + 6 - (random 12)),(_position # 2)];
	};
	if (_QS_worldName isEqualTo 'Malden') then {
		_position = selectRandom (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingPos -1);
		_position = AGLToASL _position;
		player setDir (_position getDir (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingExit 0));
	};
	if (_QS_worldName isEqualTo 'Enoch') then {
		_position = [((_position # 0) + 6 - (random 12)),((_position # 1) + 6 - (random 12)),(_position # 2)];
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
[(((player getVariable _QS_viewSettings_var) # 1) # 0),_position,_QS_viewSettings_var] spawn {
	_position = _this # 1;
	_QS_viewSettings_var = _this # 2;
	scriptName 'QS - Ramp Object View Distance';
	private _timeout = diag_tickTime + 1;
	waitUntil {
		uiSleep 0.01;
		(diag_tickTime > _timeout)
	};
	uiSleep 0.01;
	_soundVolume = soundVolume;
	1 fadeSound (_soundVolume / 2);
	_targetObjectViewDistance = ((player getVariable _QS_viewSettings_var) # 1) # 0;
	startLoadingScreen [''];
	_t = diag_tickTime + 60;
	private _currentObjectViewDistance = getObjectViewDistance # 0;
	for '_x' from 0 to 1 step 0 do {
		_currentObjectViewDistance = getObjectViewDistance # 0;
		setObjectViewDistance ((getObjectViewDistance # 0) + 1);
		if ((getObjectViewDistance # 0) isEqualTo _currentObjectViewDistance) exitWith {};
		progressLoadingScreen ((getObjectViewDistance # 0) / _targetObjectViewDistance);
		uiSleep 0.004;
		if ((getObjectViewDistance # 0) >= _targetObjectViewDistance) exitWith {};
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

private _QS_miscDelay1 = 0;
private _QS_miscDelay2 = 0;

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
/*/===== High Command support/*/
_QS_module_highCommand = TRUE;
_QS_module_highCommand_delay = 5;
_QS_module_highCommand_checkDelay = _QS_uiTime + _QS_module_highCommand_delay;
_QS_module_highCommand_waypoints = [];
/*/===== Roles module/*/
private _QS_module_roleAssignment = (getMissionConfigValue ['skipLobby',1]) isEqualTo 1;
private _QS_display1Opened = FALSE;
private _QS_display2Opened = FALSE;
private _display1_drawID = 0;
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
_fn_uidStaff = missionNamespace getVariable 'QS_fnc_whitelist';
_fn_data_carrierLaunch = call (missionNamespace getVariable 'QS_data_carrierLaunch');
_fn_carrier = missionNamespace getVariable 'QS_fnc_carrier';
_fn_destroyer = missionNamespace getVariable 'QS_fnc_destroyer';
_fn_clientHintPresets = missionNamespace getVariable 'QS_fnc_clientHintPresets';
_fn_secondsToString = missionNamespace getVariable 'QS_fnc_secondsToString';
_fn_gearRestrictions = missionNamespace getVariable 'QS_fnc_gearRestrictions';
_fn_gpsJammer = missionNamespace getVariable 'QS_fnc_gpsJammer';
_fn_isNearRepairDepot = missionNamespace getVariable 'QS_fnc_isNearRepairDepot';
_fn_deltaVD = missionNamespace getVariable 'QS_fnc_deltaVD';
_fn_hint = missionNamespace getVariable 'QS_fnc_hint';
_fn_enemySides = missionNamespace getVariable 'QS_fnc_enemySides';
_fn_getNearbyIncapacitated = missionNamespace getVariable 'QS_fnc_getNearbyIncapacitated';
_fn_roles = missionNamespace getVariable 'QS_fnc_roles';
_fn_mapDraw = (call (missionNamespace getVariable 'QS_ST_X')) # 49;
_fn_ARRappelFromHeliActionCheck = missionNamespace getVariable 'AR_Rappel_From_Heli_Action_Check';
_fn_ARRappelAIUnitsFromHeliActionCheck = missionNamespace getVariable 'AR_Rappel_AI_Units_From_Heli_Action_Check';
_fn_AIRappelDetachActionCheck = missionNamespace getVariable 'AR_Rappel_Detach_Action_Check';

/*/================================================================================================================= LOOP/*/
for 'x' from 0 to 1 step 0 do {
	if (diag_tickTime > _QS_miscDelay1) then {
		_QS_miscDelay1 = _QS_uiTime + 0.5;
		_QS_uiTime = diag_tickTime;
		_timeNow = time;
		_serverTime = serverTime;
		if (_QS_player isNotEqualTo player) then {
			_QS_player = player;
		};
		_QS_posWorldPlayer = getPosWorld _QS_player;
		_posATLPlayer = getPosATL _QS_player;
		if (_QS_cO isNotEqualTo cameraOn) then {
			_QS_cO = cameraOn;
		};
		if (_QS_v2 isNotEqualTo (vehicle _QS_player)) then {
			_QS_v2 = vehicle _QS_player;
			_QS_v2Type = typeOf _QS_v2;
			_QS_v2TypeL = toLower _QS_v2Type;
		};
		if (_objectParent isNotEqualTo (objectParent _QS_player)) then {
			_objectParent = objectParent _QS_player;
		};
		_lifeState = lifeState _QS_player;
		missionNamespace setVariable ['QS_client_heartbeat',_timeNow,_false];
	};
	if (dialog) then {
		if (!(_mainMenuOpen)) then {
			if (!isNull (findDisplay _mainMenuIDD)) then {
				_mainMenuOpen = _true;
				_viewMenuOpen = _false;
			};
		} else {
			if (isNull (findDisplay _mainMenuIDD)) then {
				_mainMenuOpen = _false;
			} else {
				_QS_clientHp = round ((1 - (damage _QS_player)) * (10 ^ 2));
				_QS_clientMass = (loadAbs _QS_player) / 10;
				if (_timeNow > _QS_fpsCheckDelay) then {
					_QS_fpsLastPull = round diag_fps;
					_QS_fpsCheckDelay = _timeNow + _QS_fpsDelay;
				};
				((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetToolTip 'FPS, Time to server restart (estimated)';
				((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetText format ['FPS: %1 | Restart: %2h',_QS_fpsLastPull,([(0 max (estimatedEndServerTime - _serverTime) min 36000),'HH:MM'] call _fn_secondsToString)];
				((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetToolTip 'Score, Rating, Health, Equipment';
				((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetText format ['Score: %1 | Rating: %2 | Hp: %3 | Load: %4/100',(score _QS_player),(rating _QS_player),_QS_clientHp,_QS_clientMass];
				((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlCommit 0;
				((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlCommit 0;
			};
		};
		if (!(_viewMenuOpen)) then {
			if (!isNull (findDisplay _viewMenuIDD)) then {
				_viewMenuOpen = _true;
				_mainMenuOpen = _false;
			};
		} else {
			if (isNull (findDisplay _viewMenuIDD)) then {
				_viewMenuOpen = _false;
			} else {
				((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetToolTip 'FPS, Time to server restart (estimated)';
				((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetText format ['FPS: %1 | Restart: %2h',_QS_fpsLastPull,([(0 max (estimatedEndServerTime - _serverTime) min 36000),'HH:MM'] call _fn_secondsToString)];
			};
		};
	};
	if (!(_QS_display1Opened)) then {
		if (!isNull ((findDisplay 160) displayCtrl 51)) then {
			_QS_display1Opened = _true;
			_display1_drawID = ((findDisplay 160) displayCtrl 51) ctrlAddEventHandler ['Draw',(format ['_this call %1',_fn_mapDraw])];
		};
	} else {
		if (isNull ((findDisplay 160) displayCtrl 51)) then {
			_QS_display1Opened = _false;
			((findDisplay 160) displayCtrl 51) ctrlRemoveEventHandler ['Draw',_display1_drawID];
			_display1_drawID = 0;
		};
	};
	if (!(_QS_display2Opened)) then {
		if (!isNull ((findDisplay -1) displayCtrl 500)) then {
			_QS_display2Opened = _true;
			_display1_drawID = ((findDisplay -1) displayCtrl 500) ctrlAddEventHandler ['Draw',(format ['_this call %1',_fn_mapDraw])];
		};
	} else {
		if (isNull ((findDisplay -1) displayCtrl 500)) then {
			_QS_display2Opened = _false;
			((findDisplay -1) displayCtrl 500) ctrlRemoveEventHandler ['Draw',_display1_drawID];
			_display1_drawID = 0;
		};
	};
	if (_QS_module_liveFeed) then {
		if (_timeNow > _QS_module_liveFeed_checkDelay) then {
			if (_QS_player getVariable ['QS_RD_client_liveFeed',_false]) then {
				if (isPipEnabled) then {
					_QS_liveFeed_display = missionNamespace getVariable ['QS_Billboard_02',_objNull];
					if (!isNull _QS_liveFeed_display) then {
						if ((_QS_player distance2D _QS_liveFeed_display) < 30) then {
							_QS_liveFeed_vehicle = missionNamespace getVariable ['QS_RD_liveFeed_vehicle',_objNull];
							if (_QS_liveFeed_vehicle isEqualType _objNull) then {
								if (!isNull _QS_liveFeed_vehicle) then {
									if (alive _QS_liveFeed_vehicle) then {
										if (_QS_liveFeed_vehicle isNotEqualTo _QS_liveFeed_vehicle_current) then {
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
											if (_screenPos isNotEqualTo []) then {
												if (isNull (objectParent _QS_player)) then {
													[format [_QS_liveFeed_text + ' %1',(name (effectiveCommander _QS_liveFeed_vehicle_current))],((_screenPos # 0) - 0.25),((_screenPos # 1) + 0.1),2.75,0.25] spawn (missionNamespace getVariable 'BIS_fnc_dynamicText');
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
			_QS_module_liveFeed_checkDelay = _timeNow + _QS_module_liveFeed_delay;
		};
	};
	
	/*/===== View Distance/*/
	
	if (_QS_module_viewSettings) then {
		if (scriptDone _deltaVD_script) then {
			if ((cameraOn isNotEqualTo _QS_cameraOn) || {(_QS_player getVariable ['QS_RD_viewSettings_update',_false])}) then {
				if (_QS_player getVariable ['QS_RD_viewSettings_update',_false]) then {
					_QS_player setVariable ['QS_RD_viewSettings_update',_false,_false];
				};
				_fadeView = cameraOn isNotEqualTo _QS_cameraOn;
				_QS_cameraOn = cameraOn;
				if (!isNil {_QS_player getVariable _QS_viewSettings_var}) then {
					_viewDistance = viewDistance;
					_objectViewDistance = getObjectViewDistance # 0;
					_shadowDistance = getShadowDistance;
					_terrainGrid = getTerrainGrid;
					_viewDistance_target = _viewDistance;
					_objectViewDistance_target = _objectViewDistance;
					_shadowDistance_target = _shadowDistance;
					_terrainGrid_target = _terrainGrid;
					_clientViewSettings = _QS_player getVariable _QS_viewSettings_var;
					if (!isNull _QS_cameraOn) then {
						if (_QS_cameraOn isKindOf 'Man') then {
							if (_viewDistance isNotEqualTo ((_clientViewSettings # 0) # 0)) then {
								if (_fadeView) then {
									_viewDistance_target = ((_clientViewSettings # 0) # 0);
								} else {
									setViewDistance ((_clientViewSettings # 0) # 0);
								};
							};
							if (_objectViewDistance isNotEqualTo ((_clientViewSettings # 1) # 0)) then {
								if (_fadeView) then {
									_objectViewDistance_target = ((_clientViewSettings # 1) # 0);
								} else {
									setObjectViewDistance ((_clientViewSettings # 1) # 0);
								};
							};
							if (_shadowDistance isNotEqualTo ((_clientViewSettings # 2) # 0)) then {
								if (_fadeView) then {
									_shadowDistance_target = ((_clientViewSettings # 2) # 0);
								} else {
									setShadowDistance ((_clientViewSettings # 2) # 0);
								};
							};
							if (_terrainGrid isNotEqualTo ((_clientViewSettings # 3) # 0)) then {
								setTerrainGrid ((_clientViewSettings # 3) # 0);
							};
						} else {	
							if ((_QS_cameraOn isKindOf 'LandVehicle') || {(_QS_cameraOn isKindOf 'Ship')}) then {
								if (_viewDistance isNotEqualTo ((_clientViewSettings # 0) # 1)) then {
									if (_fadeView) then {
										_viewDistance_target = ((_clientViewSettings # 0) # 1);
									} else {
										setViewDistance ((_clientViewSettings # 0) # 1);
									};
								};
								if (_objectViewDistance isNotEqualTo ((_clientViewSettings # 1) # 1)) then {
									if (_fadeView) then {
										_objectViewDistance_target = ((_clientViewSettings # 1) # 1);
									} else {
										setObjectViewDistance ((_clientViewSettings # 1) # 1);
									};
								};
								if (_shadowDistance isNotEqualTo ((_clientViewSettings # 2) # 1)) then {
									if (_fadeView) then {
										_shadowDistance_target = ((_clientViewSettings # 2) # 1);
									} else {
										setShadowDistance ((_clientViewSettings # 2) # 1);
									};
								};
								if (_terrainGrid isNotEqualTo ((_clientViewSettings # 3) # 1)) then {
									setTerrainGrid ((_clientViewSettings # 3) # 1);
								};
							} else {
								if (_QS_cameraOn isKindOf 'Helicopter') then {
									if (_viewDistance isNotEqualTo ((_clientViewSettings # 0) # 2)) then {
										if (_fadeView) then {
											_viewDistance_target = ((_clientViewSettings # 0) # 2);
										} else {
											setViewDistance ((_clientViewSettings # 0) # 2);
										};
									};
									if (_objectViewDistance isNotEqualTo ((_clientViewSettings # 1) # 2)) then {
										if (_fadeView) then {
											_objectViewDistance_target = ((_clientViewSettings # 1) # 2);
										} else {
											setObjectViewDistance ((_clientViewSettings # 1) # 2);
										};
									};
									if (_shadowDistance isNotEqualTo ((_clientViewSettings # 2) # 2)) then {
										if (_fadeView) then {
											_shadowDistance_target = ((_clientViewSettings # 2) # 2);
										} else {
											setShadowDistance ((_clientViewSettings # 2) # 2);
										};
									};
									if (_terrainGrid isNotEqualTo ((_clientViewSettings # 3) # 2)) then {
										setTerrainGrid ((_clientViewSettings # 3) # 2);
									};
								} else {
									if (_QS_cameraOn isKindOf 'Plane') then {
										if (_viewDistance isNotEqualTo ((_clientViewSettings # 0) # 3)) then {
											if (_fadeView) then {
												_viewDistance_target = ((_clientViewSettings # 0) # 3);
											} else {
												setViewDistance ((_clientViewSettings # 0) # 3);
											};
										};
										if (_objectViewDistance isNotEqualTo ((_clientViewSettings # 1) # 3)) then {
											if (_fadeView) then {
												_objectViewDistance_target = ((_clientViewSettings # 1) # 3);
											} else {
												setObjectViewDistance ((_clientViewSettings # 1) # 3);
											};
										};
										if (_shadowDistance isNotEqualTo ((_clientViewSettings # 2) # 3)) then {
											if (_fadeView) then {
												_shadowDistance_target = ((_clientViewSettings # 2) # 3);
											} else {
												setShadowDistance ((_clientViewSettings # 2) # 3);
											};
										};
										if (_terrainGrid isNotEqualTo ((_clientViewSettings # 3) # 3)) then {
											setTerrainGrid ((_clientViewSettings # 3) # 3);
										};
									} else {
										_viewDistance_target = viewDistance;
										_objectViewDistance_target = getObjectViewDistance # 0;
										_shadowDistance_target = getShadowDistance;
										_terrainGrid_target = getTerrainGrid;
									};
								};
							};
						};
					} else {
						_viewDistance_target = viewDistance;
						_objectViewDistance_target = getObjectViewDistance # 0;
						_shadowDistance_target = getShadowDistance;
						_terrainGrid_target = getTerrainGrid;
					};
					if (_fadeView) then {
						_deltaVD_script = [
							[_viewDistance,_viewDistance_target,10],
							[_objectViewDistance,_objectViewDistance_target,10],
							[_shadowDistance,_shadowDistance_target,1],
							[_terrainGrid,_terrainGrid_target,0.25]
						] spawn _fn_deltaVD;
					};
				} else {
					_QS_player setVariable [
						_QS_viewSettings_var,
						[
							[1000,2400,3200,4000],
							[800,1400,2400,3000],
							[50,50,50,50],
							[45,45,45,45],
							[_true,_true,_false,_false]
						],
						_false
					];
				};
			};
		};
	};
	
	/*/===== Action Manager/*/
	
	if (alive _QS_player) then {
		if (_lifeState in ['HEALTHY','INJURED']) then {
			_cursorTarget = cursorTarget;
			_cursorDistance = _QS_player distance _cursorTarget;
			getCursorObjectParams params ['_cursorObject','_cursorObjectNamedSel','_cursorObjectDistance'];
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
			_noObjectParent = isNull _objectParent;
			if (_timeNow > _QS_nearEntities_revealCheckDelay) then {
				if (_noObjectParent) then {
					{
						if (simulationEnabled _x) then {
							if ((_QS_player knowsAbout _x) < 1) then {
								_QS_player reveal [_x,3.9];
							};
						};
					} count (((_posATLPlayer select [0,2]) nearEntities [_QS_entityTypes,_QS_entityRange]) + (_posATLPlayer nearObjects [_QS_objectTypes,_QS_objectRange]));
					{
						if (!isNull (_x # 0)) then {
							if ((_x # 1) < 5) then {
								if (simulationEnabled (_x # 0)) then {
									if ((_QS_player knowsAbout (_x # 0)) < 1) then {
										_QS_player reveal [(_x # 0),3.9];
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
			
			if (
				(_noObjectParent) &&
				{(_cursorDistance < 2)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(_cursorTarget getVariable ['QS_RD_escortable',_false])}
			) then {
				if (!(_QS_interaction_escort)) then {
					_QS_interaction_escort = _true;
					_QS_action_escort = player addAction _QS_action_escort_array;
					player setUserActionText [_QS_action_escort,((player actionParams _QS_action_escort) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_escort) # 0)])];
				};
			} else {
				if (_QS_interaction_escort) then {
					_QS_interaction_escort = _false;
					player removeAction _QS_action_escort;
				};
			};
			
			/*/========== REVIVE/*/
			/*/
			if (
				(_noObjectParent) &&
				{(_QS_player getUnitTrait 'medic')} &&
				{(_cursorDistance < 1.9)} &&
				{(((attachedObjects _QS_player) findIf {(_x isKindOf 'CAManBase')}) isEqualTo -1)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{((lifeState _cursorTarget) isEqualTo 'INCAPACITATED')} &&
				{(!(['medic',(animationState _QS_player),_false] call _fn_inString))}
			) then {
				if (!(_QS_interaction_revive)) then {
					_QS_interaction_revive = _true;
					_QS_action_revive = player addAction _QS_action_revive_array;
					player setUserActionText [_QS_action_revive,((player actionParams _QS_action_revive) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_revive) # 0)])];
				};
			} else {
				if (_QS_interaction_revive) then {
					_QS_interaction_revive = _false;
					player removeAction _QS_action_revive;
				};
			};
			/*/
			
			/*/========== REVIVE/*/
			
			if (
				(_noObjectParent) &&
				{(_QS_cO getUnitTrait 'medic')} &&
				{((_QS_cO distance _cursorTarget) < 1.9)} &&
				{(((attachedObjects _QS_cO) findIf {(_x isKindOf 'CAManBase')}) isEqualTo -1)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{((lifeState _cursorTarget) isEqualTo 'INCAPACITATED')} &&
				{(!(['medic',(animationState _QS_cO),FALSE] call _fn_inString))}
			) then {
				if (_QS_medicCameraOn isNotEqualTo _QS_cO) then {
					_QS_medicCameraOn = _QS_cO;
				};
				if (!(_QS_interaction_revive)) then {
					_QS_interaction_revive = TRUE;
					if (_QS_medicCameraOn isEqualTo _QS_player) then {
						_QS_action_revive = _QS_medicCameraOn addAction _QS_action_revive_array;
					} else {
						_QS_action_revive = _QS_medicCameraOn addAction _QS_action_AIrevive_array;
					};
					_QS_medicCameraOn setUserActionText [_QS_action_revive,((_QS_medicCameraOn actionParams _QS_action_revive) # 0),(format ["<t size='3'>%1</t>",((_QS_medicCameraOn actionParams _QS_action_revive) # 0)])];
				};
			} else {
				if (_QS_interaction_revive) then {
					_QS_interaction_revive = FALSE;
					_QS_medicCameraOn removeAction _QS_action_revive;
				};
			};
			
			/*/===== Stabilise/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorDistance < 1.9)} &&
				{(((attachedObjects _QS_player) findIf {(_x isKindOf 'CAManBase')}) isEqualTo -1)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(_cursorTarget getVariable ['QS_interact_stabilise',_false])} &&
				{(!(_cursorTarget getVariable ['QS_interact_stabilised',_true]))}
			) then {
				if (!(_QS_interaction_stabilise)) then {
					_QS_interaction_stabilise = _true;
					_QS_action_stabilise = player addAction _QS_action_stabilise_array;
					player setUserActionText [_QS_action_stabilise,((player actionParams _QS_action_stabilise) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_stabilise) # 0)])];
				};
			} else {
				if (_QS_interaction_stabilise) then {
					_QS_interaction_stabilise = _false;
					player removeAction _QS_action_stabilise;
				};
			};
						
			/*/===== Action Load/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{((_cursorTarget isKindOf 'LandVehicle') || {(_cursorTarget isKindOf 'Air')} || {(_cursorTarget isKindOf 'Ship')})} &&
				{(alive _cursorTarget)} &&
				{(((_cursorTarget emptyPositions 'Cargo') > 0) || {((unitIsUav _cursorTarget) && (([_cursorTarget,1] call _fn_clientInteractUGV) > 0))})} &&
				{((locked _cursorTarget) in [-1,0,1])} &&
				{(((attachedObjects _QS_player) findIf {(_x isKindOf 'CAManBase')}) isNotEqualTo -1)}
			) then {
				{
					if (!isNull _x) then {
						if (_x isKindOf 'Man') then {
							if (alive _x) then {
								if (!(_QS_interaction_load)) then {
									_QS_interaction_load = _true;
									_QS_action_load = player addAction _QS_action_load_array;
									player setUserActionText [_QS_action_load,((player actionParams _QS_action_load) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_load) # 0)])];
								};
							} else {
								if (_QS_interaction_load) then {
									_QS_interaction_load = _false;
									player removeAction _QS_action_load;
								};
							};
						};
					};
				} count (attachedObjects _QS_player);
			} else {
				if (_QS_interaction_load) then {
					_QS_interaction_load = _false;
					player removeAction _QS_action_load;
				};
			};
			
			/*/===== Action Unload/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{((_cursorTarget isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Ship')})} &&
				{((((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1) || ((unitIsUav _cursorObject) && ([_cursorObject,0] call _fn_clientInteractUGV) && (((attachedObjects _cursorObject) findIf {((_x isKindOf 'CAManBase') && (alive _x))}) isNotEqualTo -1)))} &&
				{((((crew _cursorObject) findIf {(_x getVariable ['QS_RD_loaded',_false])}) isNotEqualTo -1) || {(((crew _cursorObject) findIf {((lifeState _x) isEqualTo 'INCAPACITATED')}) isNotEqualTo -1)} || {(((attachedObjects _cursorObject) findIf {((_x isKindOf 'CAManBase') && (alive _x) && (_x getVariable ['QS_RD_loaded',_false]))}) isNotEqualTo -1)})}
			) then {
				{
					if (!(_QS_interaction_unload)) then {
						if ((_x getVariable ['QS_RD_loaded',_false]) || {((lifeState _x) isEqualTo 'INCAPACITATED')}) then {
							if (alive _x) then {
								_QS_interaction_unload = _true;
								_QS_action_unload = player addAction _QS_action_unload_array;
								player setUserActionText [_QS_action_unload,((player actionParams _QS_action_unload) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unload) # 0)])];
							} else {
								if (_QS_interaction_unload) then {
									_QS_interaction_unload = _false;
									player removeAction _QS_action_unload;
								};
							};
						} else {
							if (_QS_interaction_unload) then {
								_QS_interaction_unload = _false;
								player removeAction _QS_action_unload;
							};
						};
					};
				} count ((crew _cursorObject) + (attachedObjects _cursorObject));
			} else {
				if (_QS_interaction_unload) then {
					_QS_interaction_unload = _false;
					player removeAction _QS_action_unload;
				};
			};
			
			/*/===== Action Question Civilian/*/
			
			if (
				(_cursorDistance < 10) &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{((side _cursorTarget) isEqualTo _civSide)} &&
				{(alive _cursorTarget)} &&
				{(_cursorTarget getVariable ['QS_civilian_interactable',_false])}
			) then {
				if (!(_QS_interaction_questionCivilian)) then {
					_QS_interaction_questionCivilian = _true;
					_QS_action_questionCivilian = player addAction _QS_action_questionCivilian_array;
					player setUserActionText [_QS_action_questionCivilian,((player actionParams _QS_action_questionCivilian) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_questionCivilian) select 0)])];
				};
			} else {
				if (_QS_interaction_questionCivilian) then {
					_QS_interaction_questionCivilian = _false;
					player removeAction _QS_action_questionCivilian;
				};
			};
			
			/*/===== Action Drag/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorDistance < 1.9)} &&
				{(((attachedObjects _QS_player) findIf {((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))}) isEqualTo -1)} &&
				{(alive _cursorTarget)} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(isNull (ropeAttachedTo _cursorTarget))}
			) then {
				if (_cursorTarget isKindOf 'Man') then {
					if (((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') && {((isNull (attachedTo _cursorTarget)) && (isNull (objectParent _cursorTarget)))}) then {
						if (!(_QS_interaction_drag)) then {
							_QS_interaction_drag = _true;
							_QS_action_drag = player addAction _QS_action_drag_array;
							player setUserActionText [_QS_action_drag,((player actionParams _QS_action_drag) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_drag) # 0)])];
						};
					} else {
						if (_QS_interaction_drag) then {
							_QS_interaction_drag = _false;
							player removeAction _QS_action_drag;
						};
					};
				} else {
					if (([0,_cursorTarget,_objNull] call _fn_getCustomCargoParams) || {(_cursorTarget getVariable ['QS_RD_draggable',_false])}) then {
						if (!(_QS_interaction_drag)) then {
							_QS_interaction_drag = _true;
							_QS_action_drag = player addAction _QS_action_drag_array;
							player setUserActionText [_QS_action_drag,((player actionParams _QS_action_drag) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_drag) # 0)])];
						};
					} else {
						if (_QS_interaction_drag) then {
							_QS_interaction_drag = _false;
							player removeAction _QS_action_drag;
						};
					};
				};
			} else {
				if (_QS_interaction_drag) then {
					_QS_interaction_drag = _false;
					player removeAction _QS_action_drag;
				};
			};

			/*/===== Action Carry/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorDistance < 1.9)} &&
				{(((attachedObjects _QS_player) findIf {((!isNull _x) && (!(_x isKindOf 'Sign_Sphere10cm_F')))}) isEqualTo -1)} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(isNull (objectParent _cursorTarget))}
			) then {
				if (_cursorTarget isKindOf 'CAManBase') then {
					if ((alive _cursorTarget) && {((lifeState _cursorTarget) isEqualTo 'INCAPACITATED')}) then {
						if (!(_QS_interaction_carry)) then {
							_QS_interaction_carry = _true;
							_QS_action_carry = player addAction _QS_action_carry_array;
							player setUserActionText [_QS_action_carry,((player actionParams _QS_action_carry) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_carry) # 0)])];
						};
					} else {
						if (_QS_interaction_carry) then {
							_QS_interaction_carry = _false;
							player removeAction _QS_action_carry;
						};
					};
				} else {
					if (([0,_cursorTarget,_objNull] call _fn_getCustomCargoParams) && {([4,_cursorTarget,_QS_v2] call _fn_getCustomCargoParams)}) then {
						if (!(_QS_interaction_carry)) then {
							_QS_interaction_carry = _true;
							_QS_action_carry = player addAction _QS_action_carry_array;
							player setUserActionText [_QS_action_carry,((player actionParams _QS_action_carry) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_carry) # 0)])];
						};
					} else {
						if (_QS_interaction_carry) then {
							_QS_interaction_carry = _false;
							player removeAction _QS_action_carry;
						};							
					};
				};
			} else {
				if (_QS_interaction_carry) then {
					_QS_interaction_carry = _false;
					player removeAction _QS_action_carry;
				};
			};
			
			/*/===== Action Recruit/*/

			if (
				(_noObjectParent) &&
				{(_cursorDistance < 3)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(_cursorTarget isNotEqualTo _QS_player)} &&
				{(_QS_player isEqualTo (leader (group _QS_player)))} &&
				{((group _cursorTarget) isNotEqualTo (group _QS_player))} &&
				{(_cursorTarget getVariable ['QS_RD_recruitable',_false])}
			) then {
				if (!(_QS_interaction_recruit)) then {
					_QS_interaction_recruit = _true;
					_QS_action_recruit = player addAction _QS_action_recruit_array;
					player setUserActionText [_QS_action_recruit,((player actionParams _QS_action_recruit) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_recruit) # 0)])];
				};
			} else {
				if (_QS_interaction_recruit) then {
					_QS_interaction_recruit = _false;
					player removeAction _QS_action_recruit;
				};
			};

			/*/===== Action Dismiss/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorDistance < 3.5)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(_cursorTarget isNotEqualTo _QS_player)} &&
				{(_QS_player isEqualTo (leader (group _QS_player)))} &&
				{((group _cursorTarget) isEqualTo (group _QS_player))} &&
				{(_cursorTarget getVariable ['QS_RD_dismissable',_false])}
			) then {
				if (!(_QS_interaction_dismiss)) then {
					_QS_interaction_dismiss = _true;
					_QS_action_dismiss = player addAction _QS_action_dismiss_array;
					player setUserActionText [_QS_action_dismiss,((player actionParams _QS_action_dismiss) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_dismiss) # 0)])];
				};
			} else {
				if (_QS_interaction_dismiss) then {
					_QS_interaction_dismiss = _false;
					player removeAction _QS_action_dismiss;
				};
			};
			
			/*/===== Action Respawn Vehicle/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{(_cursorObjectDistance <= 2)} &&
				{(_QS_uiTime > (player getVariable ['QS_RD_canRespawnVehicle',-1]))} &&
				{(_cursorObject getVariable ['QS_RD_vehicleRespawnable',_false])} &&
				{(!(_cursorObject getVariable ['QS_disableRespawnAction',_false]))} &&
				{((crew _cursorObject) isEqualTo [])} &&
				{(local _cursorObject)}
			) then {
				if (!(_QS_interaction_respawnVehicle)) then {
					_QS_interaction_respawnVehicle = _true;
					_QS_action_respawnVehicle = player addAction _QS_action_respawnVehicle_array;
					player setUserActionText [_QS_action_respawnVehicle,((player actionParams _QS_action_respawnVehicle) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_respawnVehicle) # 0)])];
				};
			} else {
				if (_QS_interaction_respawnVehicle) then {
					_QS_interaction_respawnVehicle = _false;
					player removeAction _QS_action_respawnVehicle;
				};
			};
			
			/*/===== Vehicle Doors/*/
			
			if (
				(!(_noObjectParent)) &&
				{(_QS_v2TypeL in _QS_action_vehDoors_vehicles)} &&
				{(_QS_player isEqualTo (effectiveCommander _QS_v2))}
			) then {
				if (!(_QS_interaction_vehDoors)) then {
					_QS_interaction_vehDoors = _true;
					if (([_QS_v2] call _fn_clientGetDoorPhase) isEqualTo 1) then {
						_QS_action_vehDoors_array set [0,_QS_action_vehDoors_textClose];
						_QS_action_vehDoors_array set [2,[_QS_v2,0]];
					} else {
						_QS_action_vehDoors_array set [0,_QS_action_vehDoors_textOpen];
						_QS_action_vehDoors_array set [2,[_QS_v2,1]];
					};
					_QS_action_vehDoors = player addAction _QS_action_vehDoors_array;
					player setUserActionText [_QS_action_vehDoors,((player actionParams _QS_action_vehDoors) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_vehDoors) # 0)])];
				} else {
					if (([_QS_v2] call _fn_clientGetDoorPhase) isEqualTo 1) then {
						if ((_QS_action_vehDoors_array # 0) isEqualTo _QS_action_vehDoors_textOpen) then {
							_QS_interaction_vehDoors = _false;
							player removeAction _QS_action_vehDoors;
						};
					} else {
						if ((_QS_action_vehDoors_array # 0) isEqualTo _QS_action_vehDoors_textClose) then {
							_QS_interaction_vehDoors = _false;
							player removeAction _QS_action_vehDoors;
						};
					};
				};
			} else {
				if (_QS_interaction_vehDoors) then {
					_QS_interaction_vehDoors = _false;
					player removeAction _QS_action_vehDoors;
				};
			};
			
			/*/===== Vehicle Service/*/
			
			if (
				((_cursorObjectDistance < 7) || {(!(_noObjectParent))}) &&
				{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_QS_v2 isKindOf 'LandVehicle')} || {(_QS_v2 isKindOf 'Air')})} &&
				{(!(missionNamespace getVariable ['QS_repairing_vehicle',_false]))} &&
				{(((vectorMagnitude (velocity _QS_v2)) * 3.6) <= 1)}
			) then {
				_isNearRepairDepot = (([_QS_v2] call _fn_isNearRepairDepot) || {([_cursorObject] call _fn_isNearRepairDepot)});
				_nearSite = _false;
				{
					if ((_QS_v2 distance2D (markerPos _x)) < 12) exitWith {
						_nearSite = _true;
					};
				} count (missionNamespace getVariable 'QS_veh_repair_mkrs');
				if ((_nearSite) || {(_isNearRepairDepot)} || {((_QS_carrierEnabled isNotEqualTo 0) && (['INPOLYGON_FOOT',_QS_player] call _fn_carrier))} || {((_QS_destroyerEnabled isNotEqualTo 0) && (['INPOLYGON_FOOT',_QS_player] call _fn_destroyer))}) then {
					if (!(_QS_interaction_serviceVehicle)) then {
						_QS_interaction_serviceVehicle = _true;
						if ((['INPOLYGON_FOOT',_QS_player] call _fn_carrier) || {(['INPOLYGON_FOOT',_QS_player] call _fn_destroyer)}) then {
							_QS_action_serviceVehicle_array set [3,-1];
						} else {
							_QS_action_serviceVehicle_array set [3,10];
						};
						_QS_action_serviceVehicle = player addAction _QS_action_serviceVehicle_array;
						player setUserActionText [_QS_action_serviceVehicle,((player actionParams _QS_action_serviceVehicle) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_serviceVehicle) # 0)])];
					};
				} else {
					if (_QS_interaction_serviceVehicle) then {
						_QS_interaction_serviceVehicle = _false;
						player removeAction _QS_action_serviceVehicle;
					};
				};
			} else {
				if (_QS_interaction_serviceVehicle) then {
					_QS_interaction_serviceVehicle = _false;
					player removeAction _QS_action_serviceVehicle;
				};
			};
			
			/*/===== Unflip vehicle/*/
			
			if (
				(alive _cursorObject) &&
				{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Reammobox_F')})} &&
				{(((_cursorObjectDistance <= 2) && (_cursorObject isEqualTo _cursorTarget)) || {(((toLower _QS_v2Type) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) && (_cursorObjectDistance <= 10))})} &&
				{(((vectorUp _cursorObject) # 2) < 0.1)}
			) then {
				if (!(_QS_interaction_unflipVehicle)) then {
					_QS_interaction_unflipVehicle = _true;
					_QS_action_unflipVehicle = player addAction _QS_action_unflipVehicle_array;
					player setUserActionText [_QS_action_unflipVehicle,((player actionParams _QS_action_unflipVehicle) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unflipVehicle) # 0)])];
				};
			} else {
				if (_QS_interaction_unflipVehicle) then {
					_QS_interaction_unflipVehicle = _false;
					player removeAction _QS_action_unflipVehicle;
				};
			};
			
			/*/===== Arsenal/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorObjectDistance < 20)} &&
				{(((((getModelInfo _cursorObject) # 1) isEqualTo _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorTarget getVariable ['QS_arsenal_object',_false])})} &&
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_arsenal)) then {
					_QS_interaction_arsenal = _true;
					_QS_action_arsenal = player addAction _QS_action_arsenal_array;
					player setUserActionText [_QS_action_arsenal,((player actionParams _QS_action_arsenal) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_arsenal) # 0)])];
				};
			} else {
				if (_QS_interaction_arsenal) then {
					_QS_interaction_arsenal = _false;
					player removeAction _QS_action_arsenal;
				};
			};
			
			/*/===== Action Role Selection/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorObjectDistance < 20)} &&
				{(((((getModelInfo _cursorObject) # 1) isEqualTo _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorTarget getVariable ['QS_arsenal_object',_false])})} &&
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_RSS)) then {
					_QS_interaction_RSS = _true;
					_QS_action_RSS = player addAction _QS_action_RSS_array;
					player setUserActionText [_QS_action_RSS,((player actionParams _QS_action_RSS) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_RSS) # 0)])];
				};
			} else {
				if (_QS_interaction_RSS) then {
					_QS_interaction_RSS = _false;
					player removeAction _QS_action_RSS;
				};
			};

			/*/===== Action Tow/*/
			
			if (
				(!(_noObjectParent)) &&
				{(_QS_v2 isKindOf 'LandVehicle')} &&
				{(((vectorMagnitude (velocity _QS_v2)) * 3.6) < 1)} &&
				{((_QS_v2 getVariable ['QS_tow_veh',-1]) > 0)} &&
				{(canMove _QS_v2)} &&
				{(((vectorUp _QS_v2) # 2) > 0.1)} &&
				{(isNull (isVehicleCargo _QS_v2))} &&
				{(isNull (ropeAttachedTo _QS_v2))} &&
				{(isNull (attachedTo _QS_v2))} &&
				{([_QS_v2] call _fn_vTowable)}
			) then {
				if (!(_QS_interaction_tow)) then {
					_QS_interaction_tow = _true;
					_QS_action_tow = player addAction _QS_action_tow_array;
					player setUserActionText [_QS_action_tow,((player actionParams _QS_action_tow) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_tow) # 0)])];
				};
			} else {
				if (_QS_interaction_tow) then {
					_QS_interaction_tow = _false;
					player removeAction _QS_action_tow;
				};
			};

			/*/===== Action Command Surrender/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 6)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(!(captive _cursorTarget))} &&
				{((side _cursorTarget) in (_enemysides + [CIVILIAN]))} &&
				{((lifeState _cursorTarget) in ['HEALTHY','INJURED'])} &&
				{(isNull (objectParent _cursorTarget))} &&
				{(_cursorTarget getVariable ['QS_surrenderable',_false])} &&
				{(!((currentWeapon _QS_player) in ['',(binocular _QS_player),(secondaryWeapon _QS_player)]))} &&
				{(!(weaponLowered _QS_player))} &&
				{(!(underwater _QS_player))} &&
				{((stance _QS_player) in ['STAND','CROUCH'])} &&
				{((lineIntersectsSurfaces [(eyePos _QS_player),(aimPos _cursorTarget),_QS_player,_cursorTarget,_true,-1,'FIRE','VIEW',_true]) isEqualTo [])} &&
				{(!(uiNamespace getVariable ['QS_client_progressVisualization_active',_false]))}
			) then {
				if (!(_QS_interaction_commandSurrender)) then {
					_QS_interaction_commandSurrender = _true;
					_QS_action_commandSurrender = player addAction _QS_action_commandSurrender_array;
					player setUserActionText [_QS_action_commandSurrender,((player actionParams _QS_action_commandSurrender) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_commandSurrender) # 0)])];
				};
			} else {
				if (_QS_interaction_commandSurrender) then {
					_QS_interaction_commandSurrender = _false;
					player removeAction _QS_action_commandSurrender;
				};
			};

			/*/===== Action Rescue/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 4)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(captive _cursorTarget)} &&
				{(isNull (objectParent _cursorTarget))} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(_cursorTarget getVariable ['QS_rescueable',_false])}
			) then {
				if (!(_QS_interaction_rescue)) then {
					_QS_interaction_rescue = _true;
					_QS_action_rescue = player addAction _QS_action_rescue_array;
					player setUserActionText [_QS_action_rescue,((player actionParams _QS_action_rescue) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rescue) # 0)])];
				};
			} else {
				if (_QS_interaction_rescue) then {
					_QS_interaction_rescue = _false;
					player removeAction _QS_action_rescue;
				};
			};

			/*/===== Action Secure/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{(_cursorObject getVariable ['QS_secureable',_false])} &&
				{(!(_cursorObject getVariable ['QS_secured',_false]))} &&
				{(!isObjectHidden _cursorObject)}
			) then {
				if (!(_QS_interaction_secure)) then {
					_QS_interaction_secure = _true;
					_QS_action_secure_array set [2,[_cursorTarget,_cursorObject]];
					_QS_action_secure = player addAction _QS_action_secure_array;
					player setUserActionText [_QS_action_secure,((player actionParams _QS_action_secure) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_secure) # 0)])];
				};
			} else {
				if (_QS_interaction_secure) then {
					_QS_interaction_secure = _false;
					player removeAction _QS_action_secure;
				};
			};
			
			/*/===== Action Examine/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{((_cursorDistance < 5) || {(_cursorObjectDistance < 5)} || {((!alive _cursorObject) && (_cursorObject isKindOf 'CAManBase') && (_cursorDistance < 5))})} &&
				{(_cursorObject getVariable ['QS_entity_examine',_false])} &&
				{(!(_cursorObject getVariable ['QS_entity_examined',_false]))} &&
				{(!(player getVariable ['QS_client_examining',_false]))} &&
				{(!isObjectHidden _cursorObject)}
			) then {
				if (!(_QS_interaction_examine)) then {
					_QS_interaction_examine = _true;
					_QS_action_examine_array set [2,[_cursorTarget,_cursorObject]];
					_QS_action_examine = player addAction _QS_action_examine_array;
					player setUserActionText [_QS_action_examine,((player actionParams _QS_action_examine) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_examine) # 0)])];
				};
			} else {
				if (_QS_interaction_examine) then {
					_QS_interaction_examine = _false;
					player removeAction _QS_action_examine;
				};
			};
			
			/*/===== Action turret safety/*/
			
			if (
				(!(_noObjectParent)) &&
				{(_QS_v2Type in _QS_turretSafety_heliTypes)} &&
				{(_QS_player isEqualTo (currentPilot _QS_v2))} &&
				{(!(missionNamespace getVariable 'QS_inturretloop'))}
			) then {
				if (!(_QS_interaction_turretSafety)) then {
					_QS_interaction_turretSafety = _true;
					_QS_action_turretSafety = player addAction _QS_action_turretSafety_array;
					player setUserActionText [_QS_action_turretSafety,((player actionParams _QS_action_turretSafety) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_turretSafety) # 0)])];
				};
			} else {
				if (_QS_interaction_turretSafety) then {
					_QS_interaction_turretSafety = _false;
					player removeAction _QS_action_turretSafety;
				};
			};

			/*/===== Ear Collector/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 3)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(!alive _cursorTarget)} &&
				{(_cursorTarget getVariable ['QS_collectible_ears',_false])} &&
				{((_cursorTarget getVariable ['QS_ears_remaining',0]) > 0)}
			) then {
				if (!(_QS_interaction_ears)) then {
					_QS_interaction_ears = _true;
					_QS_action_ears = player addAction _QS_action_ears_array;
					player setUserActionText [_QS_action_ears,((player actionParams _QS_action_ears) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_ears) # 0)])];
				};
			} else {
				if (_QS_interaction_ears) then {
					_QS_interaction_ears = _false;
					player removeAction _QS_action_ears;
				};
			};
			
			/*/===== Tooth Collector/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 3)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(!alive _cursorTarget)} &&
				{(_cursorTarget getVariable ['QS_collectible_tooth',_false])}
			) then {
				if (!(_QS_interaction_teeth)) then {
					_QS_interaction_teeth = _true;
					_QS_action_teeth = player addAction _QS_action_teeth_array;
					player setUserActionText [_QS_action_teeth,((player actionParams _QS_action_teeth) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_teeth) # 0)])];
				};
			} else {
				if (_QS_interaction_teeth) then {
					_QS_interaction_teeth = _false;
					player removeAction _QS_action_teeth;
				};
			};
			
			/*/===== Join Group/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 5)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(isPlayer _cursorTarget)} &&
				{((group _cursorTarget) isNotEqualTo (group _QS_player))} &&
				{(!(_grpTarget getVariable [_QS_joinGroup_privateVar,_false]))}
			) then {
				if (!(_QS_interaction_joinGroup)) then {
					_QS_interaction_joinGroup = _true;
					_QS_action_joinGroup = player addAction _QS_action_joinGroup_array;
					player setUserActionText [_QS_action_joinGroup,((player actionParams _QS_action_joinGroup) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_joinGroup) # 0)])];
				};
			} else {
				if (_QS_interaction_joinGroup) then {
					_QS_interaction_joinGroup = _false;
					player removeAction _QS_action_joinGroup;
				};
			};

			/*/===== Action Terminal FOB Status/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance < 3)} &&
				{(_cursorObject in ([(missionNamespace getVariable ['QS_module_fob_dataTerminal',_objNull]),(missionNamespace getVariable ['QS_module_fob_baseDataTerminal',_objNull])] select {(!isNull _x)}))}
			) then {
				if (!(_QS_interaction_fob_status)) then {
					_QS_interaction_fob_status = _true;
					_QS_action_fob_status = player addAction _QS_action_fob_status_array;
					player setUserActionText [_QS_action_fob_status,((player actionParams _QS_action_fob_status) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_status) # 0)])];
				};
			} else {
				if (_QS_interaction_fob_status) then {
					_QS_interaction_fob_status = _false;
					player removeAction _QS_action_fob_status;
				};
			};

			/*/===== Action Activate FOB/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance < 3)} &&
				{(_cursorObject isEqualTo (missionNamespace getVariable ['QS_module_fob_dataTerminal',_objNull]))} &&
				{((missionNamespace getVariable 'QS_module_fob_side') isNotEqualTo WEST)}
			) then {
				if (!(_QS_interaction_fob_activate)) then {
					_QS_interaction_fob_activate = _true;
					_QS_action_fob_activate = player addAction _QS_action_fob_activate_array;
					player setUserActionText [_QS_action_fob_activate,((player actionParams _QS_action_fob_activate) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_activate) # 0)])];
				};
			} else {
				if (_QS_interaction_fob_activate) then {
					_QS_interaction_fob_activate = _false;
					player removeAction _QS_action_fob_activate;
				};
			};
			
			/*/===== Action Enable Player Respawn/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance < 3)} &&
				{(_cursorObject isEqualTo (missionNamespace getVariable 'QS_module_fob_dataTerminal'))} &&
				{(!(_QS_player getVariable ['QS_module_fob_client_respawnEnabled',_true]))}
			) then {
				if (!(_QS_interaction_fob_respawn)) then {
					_QS_interaction_fob_respawn = _true;
					_QS_action_fob_respawn = player addAction _QS_action_fob_respawn_array;
					player setUserActionText [_QS_action_fob_respawn,((player actionParams _QS_action_fob_respawn) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_fob_respawn) # 0)])];
				};
			} else {
				if (_QS_interaction_fob_respawn) then {
					_QS_interaction_fob_respawn = _false;
					player removeAction _QS_action_fob_respawn;
				};
			};
			
			/*/===== Customize Crates/*/
			
			if (
				(_noObjectParent) &&
				{(_cursorObjectDistance < 3)} &&
				{(simulationEnabled _cursorObject)} &&
				{(alive _cursorObject)} &&
				{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'Reammobox_F')})} &&
				{(!(_cursorObject getVariable ['QS_inventory_disabled',_false]))}
			) then {
				_nearInvSite = _false;
				{
					if ((_x isEqualTo 'QS_marker_veh_inventoryService_01') && ((_cursorObject distance2D (markerPos _x)) < 5)) exitWith {
						_nearInvSite = _true;
					};
					if ((_x isEqualTo 'QS_marker_crate_area') && ((_cursorObject distance2D (markerPos _x)) < 50)) exitWith {
						_nearInvSite = _true;
					};
				} count (missionNamespace getVariable 'QS_veh_inventory_mkrs');
				if (_nearInvSite) then {
					if (!(_QS_interaction_customizeCrate)) then {
						_QS_interaction_customizeCrate = _true;
						_QS_action_crate_customize = player addAction _QS_action_crate_array;
						player setUserActionText [_QS_action_crate_customize,((player actionParams _QS_action_crate_customize) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_crate_customize) # 0)])];
					};
				} else {
					if (_QS_interaction_customizeCrate) then {
						_QS_interaction_customizeCrate = _false;
						player removeAction _QS_action_crate_customize;
					};
				};
			} else {
				if (_QS_interaction_customizeCrate) then {
					_QS_interaction_customizeCrate = _false;
					player removeAction _QS_action_crate_customize;
				};
			};
			
			/*/===== Action push vehicle/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(alive _cursorObject)} &&
				{(_cursorObject isKindOf 'Ship')} &&
				{((_cursorObjectDistance <= 2) && (_cursorObject isEqualTo _cursorTarget))} &&
				{(((crew _cursorObject) findIf {((alive _x) && (isPlayer _x))}) isEqualTo -1)} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{(isNull (attachedTo _cursorObject))}
			) then {
				if (!(_QS_interaction_pushVehicle)) then {
					_QS_interaction_pushVehicle = _true;
					_QS_action_pushVehicle = player addAction _QS_action_pushVehicle_array;
					player setUserActionText [_QS_action_pushVehicle,((player actionParams _QS_action_pushVehicle) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_pushVehicle) # 0)])];
				};
			} else {
				if (_QS_interaction_pushVehicle) then {
					_QS_interaction_pushVehicle = _false;
					player removeAction _QS_action_pushVehicle;
				};
			};
			
			/*/===== Action Create Boat/*/
			
			if (
				(_noObjectParent) &&
				{(_QS_player getUnitTrait 'engineer')} &&
				{(surfaceIsWater _QS_posWorldPlayer)} &&
				{('ToolKit' in (items _QS_player))} &&
				{(((getPosASL _QS_player) # 2) < 0)}
			) then {
				if (!(_QS_interaction_createBoat)) then {
					_QS_interaction_createBoat = _true;
					_QS_action_createBoat = player addAction _QS_action_createBoat_array;
					player setUserActionText [_QS_action_createBoat,((player actionParams _QS_action_createBoat) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_createBoat) # 0)])];
				};
			} else {
				if (_QS_interaction_createBoat) then {
					_QS_interaction_createBoat = _false;
					player removeAction _QS_action_createBoat;
				};
			};
			
			/*/===== Action Recover Boat/*/
			
			if (
				(!(_noObjectParent)) &&
				{(_objectParent isKindOf 'Ship')} &&
				{(alive _objectParent)} &&
				{(_QS_player isEqualTo (effectiveCommander _objectParent))} &&
				{(((vectorMagnitude (velocity _objectParent)) * 3.6) < 10)} &&
				{(isNull (attachedTo _objectParent))} &&
				{(isNull (isVehicleCargo _objectParent))} &&
				{(isNull (ropeAttachedTo _objectParent))} &&
				{(((nearestObjects [_objectParent,['land_destroyer_01_boat_rack_01_f'],20,_true]) select {((getVehicleCargo _x) isEqualTo [])}) isNotEqualTo [])}
			) then {
				if (!(_QS_interaction_recoverBoat)) then {
					_QS_interaction_recoverBoat = _true;
					_QS_action_recoverBoat = player addAction _QS_action_recoverBoat_array;
					player setUserActionText [_QS_action_recoverBoat,((player actionParams _QS_action_recoverBoat) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_recoverBoat) # 0)])];
				};
			} else {
				if (_QS_interaction_recoverBoat) then {
					_QS_interaction_recoverBoat = _false;
					player removeAction _QS_action_recoverBoat;
				};				
			};
			
			/*/===== Sit/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance < 2.2)} &&
				{((stance _QS_player) isEqualTo 'STAND')} &&
				{(((typeOf _cursorObject) in _QS_action_sit_chairTypes) || {(((getModelInfo _cursorObject) # 0) in _QS_action_sit_chairModels)})} &&
				{(isNull (attachedTo _cursorObject))} &&
				{((attachedObjects _cursorObject) isEqualTo [])}
			) then {
				if (!(_QS_interaction_sit)) then {
					_QS_interaction_sit = _true;
					_QS_action_sit = player addAction _QS_action_sit_array;
					player setUserActionText [_QS_action_sit,((player actionParams _QS_action_sit) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_sit) # 0)])];
				};
			} else {
				if (_QS_interaction_sit) then {
					_QS_interaction_sit = _false;
					player removeAction _QS_action_sit;
				};
			};
			
			/*/===== Cargo Load/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(simulationEnabled _cursorObject)} &&
				{(_cursorObjectDistance < 4)} &&
				{((_cursorObject isKindOf 'Reammobox_F') || {((typeOf _cursorObject) in _QS_action_loadCargo_cargoTypes)})} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(!(isSimpleObject _cursorObject))} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{(((getPosATL _cursorObject) nearEntities [['Air','LandVehicle'],21]) isNotEqualTo [])}
			) then {
				if (_QS_action_loadCargo_validated) then {
					_QS_action_loadCargo_validated = _false;
					_QS_action_loadCargo_vehicle = _objNull;
				};
				{
					if ((!isNil {_x getVariable 'QS_ViV_v'}) || {((toLower (typeOf _x)) in _QS_action_loadCargo_vTypes)} || {(isClass (configFile >> 'CfgVehicles' >> (typeOf _x) >> 'VehicleTransport' >> 'Carrier'))}) exitWith {
						if (vehicleCargoEnabled _x) then {
							if (isNil {_x getVariable 'QS_ViV_v'}) then {
								_x setVariable ['QS_ViV_v',_true,_true];
							};
							_QS_action_loadCargo_validated = _true;
							_QS_action_loadCargo_vehicle = _x;
						};
					};
				} count ((getPosATL _cursorObject) nearEntities [['Air','LandVehicle'],21]);
				if (_QS_action_loadCargo_validated) then {
					if (!(_QS_interaction_loadCargo)) then {
						_QS_interaction_loadCargo = _true;
						_QS_action_loadCargo_array set [2,[_cursorObject,_QS_action_loadCargo_vehicle]];
						_QS_action_loadCargo = player addAction _QS_action_loadCargo_array;
						player setUserActionText [_QS_action_loadCargo,((player actionParams _QS_action_loadCargo) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_loadCargo) # 0)])];
					};
				} else {
					if (_QS_interaction_loadCargo) then {
						_QS_interaction_loadCargo = _false;
						_QS_action_loadCargo_array set [2,[]];
						player removeAction _QS_action_loadCargo;
					};
				};
			} else {
				if (_QS_interaction_loadCargo) then {
					_QS_interaction_loadCargo = _false;
					_QS_action_loadCargo_array set [2,[]];
					player removeAction _QS_action_loadCargo;
				};
			};
			
			/*/===== Action Load 2/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(_cursorObjectDistance <= 4)} &&
				{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'Air')})} &&
				{((locked _cursorObject) in [-1,0,1])} &&
				{(((attachedObjects _QS_player) isNotEqualTo []) && (((attachedObjects _QS_player) findIf {([0,_x,_cursorObject] call _fn_getCustomCargoParams)}) isNotEqualTo -1))}
			) then {
				{
					_object = _x;
					if (!isNull _object) then {
						if ((toLower (typeOf _object)) isNotEqualTo _QS_helmetCam_helperType) then {
							if (([0,_object,_cursorObject] call _fn_getCustomCargoParams) || {([_cursorObject,_object] call _fn_isValidCargoV)}) then {
								if (([1,_object,_cursorObject] call _fn_getCustomCargoParams) || {([_cursorObject,_object] call _fn_isValidCargoV)}) then {
									if (!(_QS_interaction_load2)) then {
										_QS_interaction_load2 = _true;
										_QS_action_load_array set [2,[_object,_cursorObject]];
										_QS_action_load = player addAction _QS_action_load_array;
										player setUserActionText [_QS_action_load,((player actionParams _QS_action_load) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_load) # 0)])];
									};
								} else {
									if (_QS_interaction_load2) then {
										_QS_interaction_load2 = _false;
										_QS_action_load_array set [2,[]];
										player removeAction _QS_action_load;
									};
								};
							} else {
								if (_QS_interaction_load2) then {
									_QS_interaction_load2 = _false;
									_QS_action_load_array set [2,[]];
									player removeAction _QS_action_load;
								};
							};
						};
					};
				} count (attachedObjects _QS_player);
			} else {
				if (_QS_interaction_load2) then {
					_QS_interaction_load2 = _false;
					_QS_action_load_array set [2,[]];
					player removeAction _QS_action_load;
				};
			};
			
			/*/===== Action Unload Cargo/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'Air')})} &&
				{(simulationEnabled _cursorObject)} &&
				{((attachedObjects _cursorObject) isNotEqualTo [])} &&
				{(((attachedObjects _cursorObject) findIf {(([0,_x,_cursorObject] call _fn_getCustomCargoParams) && (!(_x getVariable ['QS_interaction_disabled',_false])))}) isNotEqualTo -1)}
			) then {
				if (!(_QS_interaction_unloadCargo)) then {
					_QS_interaction_unloadCargo = _true;
					_QS_action_unloadCargo = player addAction _QS_action_unloadCargo_array;
					player setUserActionText [_QS_action_unloadCargo,((player actionParams _QS_action_unloadCargo) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_unloadCargo) # 0)])];
				};
			} else {
				if (_QS_interaction_unloadCargo) then {
					_QS_interaction_unloadCargo = _false;
					player removeAction _QS_action_unloadCargo;
				};
			};

			/*/===== Action Activate Vehicle/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 3)} &&
				{((isSimpleObject _cursorObject) || ((!simulationEnabled _cursorObject) && (_cursorObject getVariable ['QS_vehicle_activateLocked',_true])))} &&
				{((typeOf _cursorObject) isNotEqualTo '')} &&
				{(_cursorObject isKindOf 'AllVehicles')} &&
				{(!(missionNamespace getVariable ['QS_customAO_GT_active',_false])) || ((missionNamespace getVariable ['QS_customAO_GT_active',_false]) && {(((_isAltis) && ((_cursorObject distance2D [3476.77,13108.7,0]) > 500)) || {((_isTanoa) && ((_cursorObject distance2D [5762,10367,0]) > 500))})}) || ((!(_isAltis)) && (!(_isTanoa)))} &&
				//{(((_isTanoa) && ((_cursorObject distance2D [5762,10367,0]) > 500)) || {((_isAltis) && ((_cursorObject distance2D [3476.77,13108.7,0]) > 500))} || {((!(_isAltis)) && (!(_isTanoa)))})} &&
				{(!(_cursorObject getVariable ['QS_v_disableProp',_false]))}
			) then {
				if (!(_QS_interaction_activateVehicle)) then {
					_QS_interaction_activateVehicle = _true;
					_QS_action_activateVehicle = player addAction _QS_action_activateVehicle_array;
					player setUserActionText [_QS_action_activateVehicle,((player actionParams _QS_action_activateVehicle) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_activateVehicle) # 0)])];
				};
			} else {
				if (_QS_interaction_activateVehicle) then {
					_QS_interaction_activateVehicle = _false;
					player removeAction _QS_action_activateVehicle;
				};
			};
			
			/*/===== Action Med Station/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{(isSimpleObject _cursorObject)} &&
				{((toLower ((getModelInfo _cursorObject) # 1)) in _QS_action_medevac_models)} &&
				{(((damage _QS_player) > 0) || {((((getAllHitPointsDamage _QS_player) # 2) findIf {(_x isNotEqualTo 0)}) isNotEqualTo -1)})}
			) then {
				if (!(_QS_interaction_huronContainer)) then {
					_QS_interaction_huronContainer = _true;
					_QS_action_huronContainer = player addAction _QS_action_huronContainer_array;
					player setUserActionText [_QS_action_huronContainer,((player actionParams _QS_action_huronContainer) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_huronContainer) # 0)])];
				};
			} else {
				if (_QS_interaction_huronContainer) then {
					_QS_interaction_huronContainer = _false;
					player removeAction _QS_action_huronContainer;
				};
			};
			
			/*/===== Action Sensor Target/*/
			
			if (
				((_QS_player isEqualTo (leader (group _QS_player))) && ((count (units (group _QS_player))) > 3)) ||
				{(_QS_player getUnitTrait 'QS_trait_leader')} || 
				{(_QS_player getUnitTrait 'QS_trait_JTAC')}
			) then {
				if (
					((binocular _QS_player) isNotEqualTo '') &&
					{((currentWeapon _QS_player) isEqualTo (binocular _QS_player))} &&
					{((_cursorObject isKindOf 'LandVehicle') || {(_cursorObject isKindOf 'Air')} || {(_cursorObject isKindOf 'Ship')} || {(_cursorObject isKindOf 'StaticWeapon')})} &&
					{(((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1)} &&
					{(alive (effectiveCommander _cursorObject))} &&
					{((side (group (effectiveCommander _cursorObject))) in _enemysides)}
				) then {
					if (!(_QS_interaction_sensorTarget)) then {
						_QS_interaction_sensorTarget = _true;
						_QS_action_sensorTarget_array set [0,(['Report target','Confirm target'] select (_QS_player getUnitTrait 'QS_trait_JTAC'))];
						_QS_action_sensorTarget = player addAction _QS_action_sensorTarget_array;
						player setUserActionText [_QS_action_sensorTarget,((player actionParams _QS_action_sensorTarget) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_sensorTarget) # 0)])];
					};
				} else {
					if (_QS_interaction_sensorTarget) then {
						_QS_interaction_sensorTarget = _false;
						player removeAction _QS_action_sensorTarget;
					};
				};
			};
			
			/*/===== Action Attach Exp (Underwater)/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 2)} &&
				{(((side _cursorObject) in _enemysides) || {(_cursorObject getVariable ['QS_client_canAttachExp',_false])})} &&
				{(((getPosASL _QS_player) # 2) < 0)} &&
				{('DemoCharge_Remote_Mag' in (magazines _QS_player))}
			) then {
				if (!(_QS_interaction_attachExp)) then {
					_QS_interaction_attachExp = _true;
					_QS_userActionText = format ['%1 (%2 left)',_QS_action_attachExp_text,({(_x isEqualTo 'DemoCharge_Remote_Mag')} count (magazines _QS_player))];
					_QS_action_attachExp_array set [0,_QS_userActionText];
					_QS_action_attachExp = player addAction _QS_action_attachExp_array;
					player setUserActionText [_QS_action_attachExp,_QS_userActionText,(format ["<t size='3'>%1</t>",_QS_userActionText])];
				} else {
					_QS_userActionText = format ['%1 (%2 left)',_QS_action_attachExp_text,({(_x isEqualTo 'DemoCharge_Remote_Mag')} count (magazines _QS_player))];
					player setUserActionText [_QS_action_attachExp,_QS_userActionText,(format ["<t size='3'>%1</t>",_QS_userActionText])];
				};
			} else {
				if (_QS_interaction_attachExp) then {
					_QS_interaction_attachExp = _false;
					player removeAction _QS_action_attachExp;
				};
			};
			
			//===== Cruise Control

			if (
				(!isNull _objectParent) &&
				{((_objectParent isKindOf 'Car') || (_objectParent isKindOf 'Tank') || (_objectParent isKindOf 'Ship'))} &&
				{(local _objectParent)} &&
				{((lifeState _QS_player) in ['HEALTHY','INJURED'])} &&
				{(((vectorMagnitude (velocity _objectParent)) * 3.6) > 5)}
			) then {
				if (!(_QS_interaction_cc)) then {
					_QS_interaction_cc = TRUE;
					_QS_action_cc = player addAction _QS_action_cc_array;
					player setUserActionText [_QS_action_cc,((player actionParams _QS_action_cc) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_cc) # 0)])];
				};
			} else {
				if (_QS_interaction_cc) then {
					_QS_interaction_cc = FALSE;
					player removeAction _QS_action_cc;
				};
			};

			/*/===== UGV/*/
			
			if ((_QS_player getUnitTrait 'uavhacker') || {(!isNull (getAssignedCuratorLogic _QS_player))}) then {
				if (
					(unitIsUav _QS_cO) &&
					{((toLower (typeOf _QS_cO)) in _QS_action_ugv_types)} &&
					{(isTouchingGround _QS_cO)} &&
					{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)} &&
					{((attachedObjects _QS_cO) isNotEqualTo [])} &&
					{(((attachedObjects _QS_cO) findIf {(((toLower ((getModelInfo _x) # 1)) isEqualTo _QS_action_ugv_stretcherModel) && (!(isObjectHidden _x)))}) isNotEqualTo -1)}
				) then {
					if (_QS_ugv isNotEqualTo _QS_cO) then {
						_QS_ugv = _QS_cO;
					};
					if (({(_x isKindOf 'CAManBase')} count (attachedObjects _QS_cO)) < ({((toLower ((getModelInfo _x) # 1)) isEqualTo _QS_action_ugv_stretcherModel)} count (attachedObjects _QS_cO))) then {
						_listOfFrontStuff = ((_QS_cO getRelPos [3,0]) nearEntities ['CAManBase',3]) select {(((lifeState _x) isEqualTo 'INCAPACITATED') && (isNull (attachedTo _x)) && (isNull (objectParent _x)) && (!(_x getVariable ['QS_unit_needsStabilise',_false])))};	/*/unit needs to be stabilised first?/*/
						if (_listOfFrontStuff isNotEqualTo []) then {
							if (!(_QS_interaction_ugvLoad)) then {
								_QS_interaction_ugvLoad = _true;
								_QS_action_ugvLoad_array set [2,[_QS_ugv,4]];
								_QS_action_ugvLoad = _QS_ugv addAction _QS_action_ugvLoad_array;
								_QS_ugv setUserActionText [_QS_action_ugvLoad,((_QS_ugv actionParams _QS_action_ugvLoad) # 0),(format ["<t size='3'>%1</t>",((_QS_ugv actionParams _QS_action_ugvLoad) # 0)])];
							};
						} else {
							if (_QS_interaction_ugvLoad) then {
								_QS_interaction_ugvLoad = _false;
								_QS_ugv removeAction _QS_action_ugvLoad;
							};
						};
					} else {
						if (_QS_interaction_ugvLoad) then {
							_QS_interaction_ugvLoad = _false;
							_QS_ugv removeAction _QS_action_ugvLoad;
						};
					};
					if (((attachedObjects _QS_cO) findIf {((_x isKindOf 'CAManBase') && (alive _x))}) isNotEqualTo -1) then {
						if (!(_QS_interaction_ugvUnload)) then {
							_QS_interaction_ugvUnload = _true;
							_QS_action_ugvUnload_array set [2,[_QS_ugv,5]];
							_QS_action_ugvUnload = _QS_ugv addAction _QS_action_ugvUnload_array;
							_QS_ugv setUserActionText [_QS_action_ugvUnload,((_QS_ugv actionParams _QS_action_ugvUnload) # 0),(format ["<t size='3'>%1</t>",((_QS_ugv actionParams _QS_action_ugvUnload) # 0)])];
						};
					} else {
						if (_QS_interaction_ugvUnload) then {
							_QS_interaction_ugvUnload = _false;
							_QS_ugv removeAction _QS_action_ugvUnload;
						};
					};
				} else {
					if (_QS_interaction_ugvLoad) then {
						_QS_interaction_ugvLoad = _false;
						_QS_ugv removeAction _QS_action_ugvLoad;
					};
					if (_QS_interaction_ugvUnload) then {
						_QS_interaction_ugvUnload = _false;
						_QS_ugv removeAction _QS_action_ugvUnload;
					};
				};
				
				/*/===== UAV Service/*/
				
				if (unitIsUav _QS_cO) then {
					if (_QS_uav isNotEqualTo _QS_cO) then {
						_QS_uav = _QS_cO;
					};
					if (!(missionNamespace getVariable 'QS_repairing_vehicle')) then {
						if (((vectorMagnitude (velocity _QS_uav)) * 3.6) < 1) then {
							_nearSite2 = _false;
							_uavNearRepairDepot = [_QS_uav] call _fn_isNearRepairDepot;
							{
								if ((_QS_uav distance2D (markerPos _x)) < 12) exitWith {
									_nearSite2 = _true;
								};
							} count (missionNamespace getVariable 'QS_veh_repair_mkrs');
							if ((_nearSite2) || {(_uavNearRepairDepot)}) then {
								if (!(_QS_interaction_serviceDrone)) then {
									_QS_interaction_serviceDrone = _true;
									_QS_action_serviceVehicle = _QS_uav addAction _QS_action_serviceVehicle_array;
									_QS_uav setUserActionText [_QS_action_serviceVehicle,((_QS_uav actionParams _QS_action_serviceVehicle) # 0),(format ["<t size='3'>%1</t>",((_QS_uav actionParams _QS_action_serviceVehicle) # 0)])];
								};
							} else {
								if (_QS_interaction_serviceDrone) then {
									_QS_interaction_serviceDrone = _false;
									_QS_uav removeAction _QS_action_serviceVehicle;
								};
							};
						} else {
							if (_QS_interaction_serviceDrone) then {
								_QS_interaction_serviceDrone = _false;
								_QS_uav removeAction _QS_action_serviceVehicle;
							};
						};
					} else {
						if (_QS_interaction_serviceDrone) then {
							_QS_interaction_serviceDrone = _false;
							_QS_uav removeAction _QS_action_serviceVehicle;
						};
					};
				} else {
					if (_QS_interaction_serviceDrone) then {
						_QS_interaction_serviceDrone = _false;
						_QS_uav removeAction _QS_action_serviceVehicle;
					};
				};
				
				/*/===== UGV Tow/*/
				
				if (unitIsUav _QS_cO) then {
					if (_QS_ugvTow isNotEqualTo _QS_cO) then {
						_QS_ugvTow = _QS_cO;
					};
					if (
						((toLower (typeOf _QS_ugvTow)) in _QS_action_ugv_types) &&
						{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)} &&
						{((_QS_ugvTow getVariable ['QS_tow_veh',-1]) > 0)} &&
						{(canMove _QS_ugvTow)} &&
						{(((attachedObjects _QS_ugvTow) findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)} &&
						{([_QS_ugvTow] call _fn_vTowable)}
					) then {
						if (!(_QS_interaction_towUGV)) then {
							_QS_interaction_towUGV = _true;
							_QS_action_towUGV = _QS_ugvTow addAction _QS_action_tow_array;
							_QS_ugvTow setUserActionText [_QS_action_towUGV,((_QS_ugvTow actionParams _QS_action_towUGV) # 0),(format ["<t size='3'>%1</t>",((_QS_ugvTow actionParams _QS_action_towUGV) # 0)])];
						};
					} else {
						if (_QS_interaction_towUGV) then {
							_QS_interaction_towUGV = _false;
							_QS_ugvTow removeAction _QS_action_towUGV;
						};
					};
				} else {
					if (_QS_interaction_towUGV) then {
						_QS_interaction_towUGV = _false;
						_QS_ugvTow removeAction _QS_action_towUGV;
					};
				};
				/*/UAV self destruct/*/
				if (unitIsUav _QS_cO) then {
					if (_QS_ugvSD isNotEqualTo _QS_cO) then {
						_QS_ugvSD = _QS_cO;
					};
					if (local _QS_ugvSD) then {
						if ((!(canMove _QS_ugvSD)) || {((fuel _QS_ugvSD) isEqualTo 0)} || {(!(_QS_ugvSD isKindOf 'UAV_01_base_F')) && {(!((((getAllHitPointsDamage _QS_ugvSD) # 2) findIf {(_x > 0.5)}) isEqualTo -1))}} || {(((vectorUp _QS_ugvSD) # 2) < 0.1)}) then {
							if ((_QS_ugvSD distance2D _QS_module_safezone_pos) > 500) then {
								if (!(_QS_interaction_uavSelfDestruct)) then {
									_QS_interaction_uavSelfDestruct = _true;
									_QS_action_uavSelfDestruct = _QS_ugvSD addAction _QS_action_uavSelfDestruct_array;
									_QS_ugvSD setUserActionText [_QS_action_uavSelfDestruct,((_QS_ugvSD actionParams _QS_action_uavSelfDestruct) # 0),(format ["<t size='3'>%1</t>",((_QS_ugvSD actionParams _QS_action_uavSelfDestruct) # 0)])];
								};
							} else {
								if (_QS_interaction_uavSelfDestruct) then {
									_QS_interaction_uavSelfDestruct = _false;
									_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
								};
							};
						} else {
							if (_QS_interaction_uavSelfDestruct) then {
								_QS_interaction_uavSelfDestruct = _false;
								_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
							};
						};
					} else {
						if (_QS_interaction_uavSelfDestruct) then {
							_QS_interaction_uavSelfDestruct = _false;
							_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
						};
					};
				} else {
					if (_QS_interaction_uavSelfDestruct) then {
						_QS_interaction_uavSelfDestruct = _false;
						_QS_ugvSD removeAction _QS_action_uavSelfDestruct;
					};
				};
			};

			if ((_QS_carrierEnabled isNotEqualTo 0) && (!isNull (missionNamespace getVariable ['QS_carrierObject',_objNull]))) then {
				if (_QS_cO isKindOf 'Plane') then {
					if (unitIsUav _QS_cO) then {
						_QS_carrier_cameraOn = _QS_cO;
					} else {
						if ((alive (driver _QS_cO)) && (local (driver _QS_cO))) then {
							_QS_carrier_cameraOn = _QS_cO;
						};
					};
					if (canMove _QS_carrier_cameraOn) then {
						if (((vectorMagnitude (velocity _QS_carrier_cameraOn)) * 3.6) < 30) then {
							if ((_QS_carrier_cameraOn distance2D (missionNamespace getVariable 'QS_carrierObject')) < 150) then {
								if ((_QS_carrier_cameraOn animationPhase 'wing_fold_l') isEqualTo 0) then {
									if (_QS_carrier_inPolygon) then {
										_QS_carrier_inPolygon = _false;
									};
									_QS_carrierPos = getPosWorld _QS_carrier_cameraOn;
									{
										_QS_carrierLaunchData = _x;
										_QS_carrierPolygon = (_QS_carrierLaunchData # 0) apply {((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x)};
										if (_QS_carrierPos inPolygon _QS_carrierPolygon) exitWith {
											_QS_carrier_inPolygon = _true;
										};
									} forEach _fn_data_carrierLaunch;
									if (_QS_carrier_inPolygon) then {
										if (!(_QS_interaction_carrierLaunch)) then {
											_QS_interaction_carrierLaunch = _true;
											_QS_action_carrierLaunch = _QS_carrier_cameraOn addAction _QS_action_carrierLaunch_array;
											_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Initiate Launch Sequence','<t size="3">Initiate Launch Sequence</t>'];
										};
										if (_QS_carrier_cameraOn getVariable ['QS_carrier_launch',_false]) then {
											if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) # 0) isEqualTo 'Initiate Launch Sequence') then {
												_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Launch','<t size="3">Launch</t>'];
											};
										} else {
											if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) # 0) isEqualTo 'Launch') then {
												_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,'Initiate Launch Sequence','<t size="3">Initiate Launch Sequence</t>'];
											};
										};
									} else {
										if (_QS_interaction_carrierLaunch) then {
											_QS_interaction_carrierLaunch = _false;
											_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
										};
									};
								} else {
									if (_QS_interaction_carrierLaunch) then {
										_QS_interaction_carrierLaunch = _false;
										_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
									};
								};
							} else {
								if (_QS_interaction_carrierLaunch) then {
									_QS_interaction_carrierLaunch = _false;
									_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
								};
							};
						} else {
							if (_QS_interaction_carrierLaunch) then {
								_QS_interaction_carrierLaunch = _false;
								_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
							};
						};
					} else {
						if (_QS_interaction_carrierLaunch) then {
							_QS_interaction_carrierLaunch = _false;
							_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
						};
					};
				} else {
					if (_QS_interaction_carrierLaunch) then {
						_QS_interaction_carrierLaunch = _false;
						_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
					};
				};
			} else {
				if (_QS_interaction_carrierLaunch) then {
					_QS_interaction_carrierLaunch = _false;
					_QS_carrier_cameraOn removeAction _QS_action_carrierLaunch;
				};
			};
			
			/*/===== Armor Camonets (Tanks DLC)/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(_cursorObjectDistance < 3)} &&
				{((_cursorObject isKindOf 'Tank') || {(_cursorObject isKindOf 'Wheeled_APC_F')})} &&
				{(canMove _cursorObject)} &&
				{(!(isSimpleObject _cursorObject))} &&
				{((locked _cursorObject) in [0,1])} &&
				{(((crew _cursorObject) findIf {((side (group _x)) in _enemysides)}) isEqualTo -1)}
			) then {
				_QS_action_camonetArmor_vAnims = _cursorObject getVariable ['QS_vehicle_camonetAnims',-1];
				if (_QS_action_camonetArmor_vAnims isEqualTo -1) then {
					_array = [];
					_animationSources = configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'animationSources';
					_i = 0;
					for '_i' from 0 to ((count _animationSources) - 1) step 1 do {
						_animationSource = _animationSources select _i;
						if (((toLower (configName _animationSource)) in _QS_action_camonetArmor_anims) || {(['showcamo',(configName _animationSource),_false] call _fn_inString)}) then {
							0 = _array pushBack (toLower (configName _animationSource));
						};
					};
					{
						if (_x isEqualType '') then {
							if (!((toLower _x) in _array)) then {
								if (((toLower _x) in _QS_action_camonetArmor_anims) || {(['showcamo',_x,_false] call _fn_inString)}) then {
									_array pushBack (toLower _x);
								};
							};
						};
					} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'animationList'));
					_cursorObject setVariable ['QS_vehicle_camonetAnims',_array,_false];
				} else {
					if (_QS_action_camonetArmor_vAnims isEqualType []) then {
						if (_QS_action_camonetArmor_vAnims isNotEqualTo []) then {
							if (!(_QS_interaction_camonetArmor)) then {
								if ((_QS_action_camonetArmor_vAnims findIf {((_cursorObject animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
									_QS_action_camonetArmor_array set [0,_QS_action_camonetArmor_textB];
									_QS_action_camonetArmor_array set [2,[_cursorObject,0,_QS_action_camonetArmor_vAnims]];
								} else {
									_QS_action_camonetArmor_array set [0,_QS_action_camonetArmor_textA];
									_QS_action_camonetArmor_array set [2,[_cursorObject,1,_QS_action_camonetArmor_vAnims]];
								};
								_QS_interaction_camonetArmor = _true;
								_QS_action_camonetArmor = player addAction _QS_action_camonetArmor_array;
								player setUserActionText [_QS_action_camonetArmor,((player actionParams _QS_action_camonetArmor) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_camonetArmor) # 0)])];
							} else {
								if ((_QS_action_camonetArmor_vAnims findIf {((_cursorObject animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
									if ((_QS_action_camonetArmor_array # 0) isEqualTo _QS_action_camonetArmor_textA) then {
										_QS_interaction_camonetArmor = _false;
										player removeAction _QS_action_camonetArmor;
									};
								} else {
									if ((_QS_action_camonetArmor_array # 0) isEqualTo _QS_action_camonetArmor_textB) then {
										_QS_interaction_camonetArmor = _false;
										player removeAction _QS_action_camonetArmor;
									};
								};
							};
						} else {
							if (_QS_interaction_camonetArmor) then {
								_QS_interaction_camonetArmor = _false;
								player removeAction _QS_action_camonetArmor;
							};
						};
					} else {
						if (_QS_interaction_camonetArmor) then {
							_QS_interaction_camonetArmor = _false;
							player removeAction _QS_action_camonetArmor;
						};
					};
				};
			} else {
				if (_QS_interaction_camonetArmor) then {
					_QS_interaction_camonetArmor = _false;
					player removeAction _QS_action_camonetArmor;
				};
			};
			
			/*/===== Armor Slat (Tanks DLC)/*/
			
			if (
				(!(_noObjectParent)) &&
				{(alive _QS_v2)} &&
				{((_QS_v2 isKindOf 'Tank') || {(_QS_v2 isKindOf 'Wheeled_APC_F')})} &&
				{(_QS_player isEqualTo (effectiveCommander _QS_v2))} &&
				{(!(missionNamespace getVariable ['QS_repairing_vehicle',_false]))} &&
				{(((vectorMagnitude (velocity _QS_v2)) * 3.6) < 2)}
			) then {
				_isNearRepairDepot2 = (([_QS_v2] call _fn_isNearRepairDepot) || {([_cursorObject] call _fn_isNearRepairDepot)});
				_nearSite3 = _false;
				{
					if ((_QS_v2 distance2D (markerPos _x)) < 12) exitWith {
						_nearSite3 = _true;
					};
				} count (missionNamespace getVariable 'QS_veh_repair_mkrs');
				if ((_nearSite3) || (_isNearRepairDepot2)) then {
					_QS_action_slatArmor_vAnims = _QS_v2 getVariable ['QS_vehicle_slatarmorAnims',-1];
					if (_QS_action_slatArmor_vAnims isEqualTo -1) then {
						_array = [];
						_animationSources = configFile >> 'CfgVehicles' >> (typeOf _QS_v2) >> 'animationSources';
						_i = 0;
						for '_i' from 0 to ((count _animationSources) - 1) step 1 do {
							_animationSource = _animationSources select _i;
							if (((toLower (configName _animationSource)) in _QS_action_slatArmor_anims) || {(['showslat',(configName _animationSource),_false] call _fn_inString)}) then {
								0 = _array pushBack (toLower (configName _animationSource));
							};
						};
						{
							if (_x isEqualType '') then {
								if (!((toLower _x) in _array)) then {
									if (((toLower _x) in _QS_action_slatArmor_anims) || {(['showslat',_x,_false] call _fn_inString)}) then {
										_array pushBack (toLower _x);
									};
								};
							};
						} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _QS_v2) >> 'animationList'));
						_QS_v2 setVariable ['QS_vehicle_slatarmorAnims',_array,_false];
					} else {
						if (_QS_action_slatArmor_vAnims isEqualType []) then {
							if (_QS_action_slatArmor_vAnims isNotEqualTo []) then {
								if (!(_QS_interaction_slatArmor)) then {
									if ((_QS_action_slatArmor_vAnims findIf {((_QS_v2 animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
										_QS_action_slatArmor_array set [0,_QS_action_slatArmor_textB];
										_QS_action_slatArmor_array set [2,[_QS_v2,0,_QS_action_slatArmor_vAnims]];
									} else {
										_QS_action_slatArmor_array set [0,_QS_action_slatArmor_textA];
										_QS_action_slatArmor_array set [2,[_QS_v2,1,_QS_action_slatArmor_vAnims]];
									};
									_QS_interaction_slatArmor = _true;
									_QS_action_slatArmor = player addAction _QS_action_slatArmor_array;
									player setUserActionText [_QS_action_slatArmor,((player actionParams _QS_action_slatArmor) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_slatArmor) # 0)])];
								} else {
									if ((_QS_action_slatArmor_vAnims findIf {((_QS_v2 animationSourcePhase _x) isEqualTo 1)}) isEqualTo -1) then {
										if ((_QS_action_slatArmor_array # 0) isEqualTo _QS_action_slatArmor_textA) then {
											_QS_interaction_slatArmor = _false;
											player removeAction _QS_action_slatArmor;
										};
									} else {
										if ((_QS_action_slatArmor_array # 0) isEqualTo _QS_action_slatArmor_textB) then {
											_QS_interaction_slatArmor = _false;
											player removeAction _QS_action_slatArmor;
										};
									};
								};
							} else {
								if (_QS_interaction_slatArmor) then {
									_QS_interaction_slatArmor = _false;
									player removeAction _QS_action_slatArmor;
								};
							};
						} else {
							if (_QS_interaction_slatArmor) then {
								_QS_interaction_slatArmor = _false;
								player removeAction _QS_action_slatArmor;
							};
						};
					};
				} else {
					if (_QS_interaction_slatArmor) then {
						_QS_interaction_slatArmor = _false;
						player removeAction _QS_action_slatArmor;
					};
				};
			} else {
				if (_QS_interaction_slatArmor) then {
					_QS_interaction_slatArmor = _false;
					player removeAction _QS_action_slatArmor;
				};
			};
			
			/*/===== Action Rappelling/*/
			
			if (_QS_rappelling) then {
				/*/===== Action Rappel Self/*/
				if (!(_noObjectParent)) then {
					if (_QS_v2 isKindOf 'Air') then {
						if ((_QS_v2 distance2D _QS_module_safezone_pos) > 500) then {
							if ([_QS_player,_QS_v2] call _fn_ARRappelFromHeliActionCheck) then {
								if (!(_QS_interaction_rappelSelf)) then {
									_QS_interaction_rappelSelf = _true;
									_QS_action_rappelSelf = player addAction _QS_action_rappelSelf_array;
									player setUserActionText [_QS_action_rappelSelf,((player actionParams _QS_action_rappelSelf) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelSelf) # 0)])];
								};
							} else {
								if (_QS_interaction_rappelSelf) then {
									_QS_interaction_rappelSelf = _false;
									player removeAction _QS_action_rappelSelf;
								};
							};
							if ([_QS_player] call _fn_ARRappelAIUnitsFromHeliActionCheck) then {
								if (!(_QS_interaction_rappelAI)) then {
									_QS_interaction_rappelAI = _true;
									_QS_action_rappelAI = player addAction _QS_action_rappelAI_array;
									player setUserActionText [_QS_action_rappelAI,((player actionParams _QS_action_rappelAI) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelAI) # 0)])];
								};
							} else {
								if (_QS_interaction_rappelAI) then {
									_QS_interaction_rappelAI = _false;
									player removeAction _QS_action_rappelAI;
								};
							};
							if (_iAmPilot) then {
								if (_QS_v2 isKindOf 'Helicopter') then {
									if (_QS_player isEqualTo (effectiveCommander _QS_v2)) then {
										if (!(_QS_interaction_rappelSafety)) then {
											_QS_interaction_rappelSafety = _true;
											if (isNil {_QS_v2 getVariable 'QS_rappellSafety'}) then {
												_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textDisable];
											} else {
												_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textEnable];
											};
											_QS_action_rappelSafety = player addAction _QS_action_rappelSafety_array;
											player setUserActionText [_QS_action_rappelSafety,((player actionParams _QS_action_rappelSafety) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelSafety) # 0)])];
										} else {
											if (isNil {_QS_v2 getVariable 'QS_rappellSafety'}) then {
												if ((_QS_action_rappelSafety_array # 0) isEqualTo _QS_action_rappelSafety_textEnable) then {
													_QS_interaction_rappelSafety = _false;
													player removeAction _QS_action_rappelSafety;
												};
											} else {
												if ((_QS_action_rappelSafety_array # 0) isEqualTo _QS_action_rappelSafety_textDisable) then {
													_QS_interaction_rappelSafety = _false;
													player removeAction _QS_action_rappelSafety;
												};
											};
										};
									} else {
										if (_QS_interaction_rappelSafety) then {
											_QS_interaction_rappelSafety = _false;
											player removeAction _QS_action_rappelSafety;
										};
									};	
								} else {
									if (_QS_interaction_rappelSafety) then {
										_QS_interaction_rappelSafety = _false;
										player removeAction _QS_action_rappelSafety;
									};
								};
							};
						} else {
							if (_QS_interaction_rappelSelf) then {
								_QS_interaction_rappelSelf = _false;
								player removeAction _QS_action_rappelSelf;
							};
							if (_QS_interaction_rappelAI) then {
								_QS_interaction_rappelAI = _false;
								player removeAction _QS_action_rappelAI;
							};
							if (_QS_interaction_rappelSafety) then {
								_QS_interaction_rappelSafety = _false;
								player removeAction _QS_action_rappelSafety;
							};
						};
					} else {
						if (_QS_interaction_rappelSelf) then {
							_QS_interaction_rappelSelf = _false;
							player removeAction _QS_action_rappelSelf;
						};
						if (_QS_interaction_rappelAI) then {
							_QS_interaction_rappelAI = _false;
							player removeAction _QS_action_rappelAI;
						};
						if (_QS_interaction_rappelSafety) then {
							_QS_interaction_rappelSafety = _false;
							player removeAction _QS_action_rappelSafety;
						};
					};
				} else {
					if (_QS_interaction_rappelSelf) then {
						_QS_interaction_rappelSelf = _false;
						player removeAction _QS_action_rappelSelf;
					};
					if (_QS_interaction_rappelAI) then {
						_QS_interaction_rappelAI = _false;
						player removeAction _QS_action_rappelAI;
					};
					if (_QS_interaction_rappelSafety) then {
						_QS_interaction_rappelSafety = _false;
						player removeAction _QS_action_rappelSafety;
					};
				};				
				/*/===== Action Rappel Detach/*/

				if ([_QS_player] call _fn_AIRappelDetachActionCheck) then {
					if (!(_QS_interaction_rappelDetach)) then {
						_QS_interaction_rappelDetach = _true;
						_QS_action_rappelDetach = player addAction _QS_action_rappelDetach_array;
						player setUserActionText [_QS_action_rappelDetach,((player actionParams _QS_action_rappelDetach) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_rappelDetach) # 0)])];
					};
				} else {
					if (_QS_interaction_rappelDetach) then {
						_QS_interaction_rappelDetach = _false;
						player removeAction _QS_action_rappelDetach;
					};
				};
			};
			
			/*/===== Action Release/*/

			if (((attachedObjects _QS_player) findIf {((!isNull _x) && ((_x isKindOf 'Man') || {([0,_x,_objNull] call _fn_getCustomCargoParams)} || {(_x isKindOf 'StaticWeapon')}))}) isNotEqualTo -1) then {
				{
					if ((_x isKindOf 'Man') || {([0,_x,_objNull] call _fn_getCustomCargoParams)} || {(_x isKindOf 'StaticWeapon')}) then {
						if (!(_QS_interaction_release)) then {
							_QS_interaction_release = _true;
							_QS_action_release = player addAction _QS_action_release_array;
							player setUserActionText [_QS_action_release,((player actionParams _QS_action_release) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_release) # 0)])];
						};
						if (_x getVariable ['QS_RD_escorted',_false]) then {
							if (!(_QS_interaction_release)) then {
								_QS_interaction_release = _true;
								_QS_action_release = player addAction _QS_action_release_array;
								player setUserActionText [_QS_action_release,((player actionParams _QS_action_release) # 0),(format ["<t size='3'>%1</t>",((player actionParams _QS_action_release) # 0)])];
							};
						};
					};
				} count (attachedObjects _QS_player);
			} else {
				if (_QS_interaction_release) then {
					_QS_interaction_release = _false;
					player removeAction _QS_action_release;
					if (!isNil {_QS_player getVariable 'QS_RD_interacting'}) then {
						if (_QS_player getVariable 'QS_RD_interacting') then {
							_QS_player setVariable ['QS_RD_interacting',_false,_true];
						};
					};
					if (!isNil {_QS_player getVariable 'QS_RD_dragging'}) then {
						if (_QS_player getVariable 'QS_RD_dragging') then {
							_QS_player setVariable ['QS_RD_dragging',_false,_true];
							_QS_player playAction 'released';
						};
					};
					if (!isNil {_QS_player getVariable 'QS_RD_carrying'}) then {
						if (_QS_player getVariable 'QS_RD_carrying') then {
							_QS_player setVariable ['QS_RD_carrying',_false,_true];
							_QS_player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
						};
					};
				};
			};
		};
	} else {
		if (!isNil {_QS_player getVariable 'QS_RD_interacting'}) then {
			if (_QS_player getVariable 'QS_RD_interacting') then {
				_QS_player setVariable ['QS_RD_interacting',_false,_true];
			};
		};
		if (!isNil {_QS_player getVariable 'QS_RD_carrying'}) then {
			if (_QS_player getVariable 'QS_RD_carrying') then {
				_QS_player setVariable ['QS_RD_carrying',_false,_true];
			};
		};
		if (!isNil {_QS_player getVariable 'QS_RD_dragging'}) then {
			if (_QS_player getVariable 'QS_RD_dragging') then {
				_QS_player setVariable ['QS_RD_dragging',_false,_true];
			};
		};
	};
	if (_timeNow > _QS_miscDelay2) then {
		_QS_miscDelay2 = _timeNow + (random [3,4,5]);
		_allPlayers = allPlayers;
		_QS_cameraPosition2D = (positionCameraToWorld [0,0,0]) select [0,2];
		if (_QS_player getVariable ['QS_RD_interacting',_false]) then {
			if (!isNil {_QS_player getVariable 'QS_RD_carrying'}) then {
				if (_QS_player getVariable 'QS_RD_carrying') then {
					if (((attachedObjects _QS_player) isEqualTo []) || {(((attachedObjects _QS_player) findIf {((!isNull _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)}) then {
						_QS_player setVariable ['QS_RD_carrying',_false,_true];
						_QS_player setVariable ['QS_RD_interacting',_false,_true];
						_QS_player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
					} else {
						{
							if (!isNull _x) then {
								if (_x isKindOf 'Man') then {
									if (!alive _x) then {
										detach _x;
										['switchMove',_QS_player,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
										if (!isNil {_x getVariable 'QS_RD_carried'}) then {
											if (_x getVariable 'QS_RD_carried') then {
												_QS_player setVariable ['QS_RD_carrying',_false,_true];
												_QS_player setVariable ['QS_RD_interacting',_false,_true];
											};
										};
									};
								};
							};
						} count (attachedObjects _QS_player);
					};
				};
			};
			if (!isNil {_QS_player getVariable 'QS_RD_dragging'}) then {
				if (_QS_player getVariable 'QS_RD_dragging') then {
					if ((attachedObjects _QS_player) isEqualTo []) then {
						_QS_player setVariable ['QS_RD_dragging',_false,_true];
						_QS_player setVariable ['QS_RD_interacting',_false,_true];
						_QS_player playAction 'released';
					} else {
						if (((attachedObjects _QS_player) findIf {(!isNull _x)}) isEqualTo -1) then {
							_QS_player setVariable ['QS_RD_dragging',_false,_true];
							_QS_player setVariable ['QS_RD_interacting',_false,_true];
							_QS_player playAction 'released';
						} else {
							{
								if (!isNull _x) then {
									if (_x isKindOf 'Man') then {
										if (!alive _x) then {
											detach _x;
											if (!isNil {_x getVariable 'QS_RD_dragged'}) then {
												if (_x getVariable 'QS_RD_dragged') then {
													_QS_player setVariable ['QS_RD_dragging',_false,_true];
													_QS_player setVariable ['QS_RD_interacting',_false,_true];
													_QS_player playAction 'released';
												};
											};
										};
									};
								};
							} count (attachedObjects _QS_player);
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
					if (_QS_module_fuelConsumption_vehicle isNotEqualTo _QS_v2) then {
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
						if ((_QS_module_fuelConsumption_rpmIdle isNotEqualTo 0) && (_QS_module_fuelConsumption_rpmRed isNotEqualTo 0)) then {
							_QS_module_fuelConsumption_useRPMFactor = _true;
						} else {
							_QS_module_fuelConsumption_useRPMFactor = _false;
						};
						_QS_module_fuelConsumption_rpmDiff = _QS_module_fuelConsumption_rpmRed - _QS_module_fuelConsumption_rpmIdle;
					};
					if (isEngineOn _QS_module_fuelConsumption_vehicle) then {
						if ((velocity _QS_module_fuelConsumption_vehicle) isEqualTo [0,0,0]) then {
							_QS_module_fuelConsumption_factor = _QS_module_fuelConsumption_factor_2;
						} else {
							if ((!isNull (getSlingLoad _QS_module_fuelConsumption_vehicle)) || {((getVehicleCargo _QS_module_fuelConsumption_vehicle) isNotEqualTo [])}) then {
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
		if (_timeNow > _QS_module_crewIndicator_checkDelay) then {
			if (
				(alive _QS_cO) &&
				{(!visibleMap)} &&
				{(!('CrewDisplay' in ((infoPanel 'left') + (infoPanel 'right'))))} &&
				{(!isStreamFriendlyUIEnabled)} &&
				{(isNull curatorCamera)}
			) then {
				if (!(_QS_crewIndicator_shown)) then {
					_QS_crewIndicator_shown = _true;
					_QS_crewIndicatorIDD cutRsc ['QS_RD_dialog_crewIndicator','PLAIN'];
				};
				_QS_crewIndicatorUI = uiNamespace getVariable 'QS_RD_client_dialog_crewIndicator';
				if (!isNil {_QS_crewIndicatorUI}) then {
					_QS_crewIndicator = _QS_crewIndicatorUI displayCtrl _QS_crewIndicatorIDC;
					if (alive _QS_cO) then {
						_fullCrew = fullCrew _QS_cO;
						if (_fullCrew isNotEqualTo []) then {
							if (({(alive (_x # 0))} count _fullCrew) > 1) then {
								_crewManifest = '';
								for '_y' from 0 to ((count _fullCrew) - 1) step 1 do {
									(_fullCrew # _y) params ['_unit','_role','','_turretPath','_personTurret'];
									_text = '';
									_roleImg = '';
									_roleIcon = '';
									if (isPlayer _unit) then {
										_roleIcon = str (_unit getVariable ['QS_unit_role_icon','\a3\ui_f\data\map\vehicleicons\iconMan_ca.paa']);
									} else {
										_roleIcon = _unit getVariable ['QS_unit_role_icon',''];
										if (_roleIcon isEqualTo '') then {
											_roleIcon = format ['a3\ui_f\data\map\vehicleicons\%1_ca.paa',(getText (configFile >> 'CfgVehicles' >> (typeOf _unit) >> 'icon'))];
											_unit setVariable ['QS_unit_role_icon',_roleIcon,_false];
										};
										_roleIcon = str _roleIcon;
									};
									_unitName = name _unit;
									if (
										(_unitName isNotEqualTo 'Error: No unit') &&
										(!('UAV' in (typeOf _unit)))
									) then {
										if ((_role isEqualTo 'driver') || {(_unit isEqualTo (currentPilot _QS_cO))}) then {
											_roleImg = _QS_crewIndicator_imgDriver;
										} else {
											if (_role isEqualTo 'commander') then {
												_roleImg = _QS_crewIndicator_imgCommander;
											} else {
												if (_role isEqualTo 'gunner') then {
													_roleImg = _QS_crewIndicator_imgGunner;
												} else {
													if (_role isEqualTo 'turret') then {
														if (_personTurret) then {
															_roleImg = _QS_crewIndicator_imgCargo;
														} else {
															_roleImg = _QS_crewIndicator_imgGunner;
														};
													} else {
														if (_role isEqualTo 'cargo') then {
															_roleImg = _QS_crewIndicator_imgCargo;
														};
													};
												};
											};
										};
										if (_role isNotEqualTo 'driver') then {
											if (_turretPath isNotEqualTo []) then {
												_text = format ["<img image=%1/><t size='0.666'>%2</t> <img size='0.75' image=%3/> <t size='0.75'>%4</t><br/>",_roleImg,(_turretPath # 0),_roleIcon,_unitName];
											} else {
												_text = format ["<img image=%1/> <img size='0.75' image=%2/> <t size='0.75'>%3</t> <br/>",_roleImg,_roleIcon,_unitName];
											};
										} else {
											_text = format ["<img image=%1/> <img size='0.75' image=%2/> <t size='1'>%3</t><br/>",_roleImg,_roleIcon,_unitName];
										};
										_crewManifest = _crewManifest + _text;
									};
								};
								_QS_crewIndicator ctrlSetTextColor _QS_crewIndicator_color;
								_QS_crewIndicator ctrlSetStructuredText (parseText _crewManifest);
							} else {
								if (_QS_crewIndicator_shown) then {
									_QS_crewIndicator_shown = _false;
									_QS_crewIndicatorIDD cutText ['','PLAIN'];
								};
							};
						} else {
							if (_QS_crewIndicator_shown) then {
								_QS_crewIndicator_shown = _false;
								_QS_crewIndicatorIDD cutText ['','PLAIN'];
							};
						};
					} else {
						if (_QS_crewIndicator_shown) then {
							_QS_crewIndicator_shown = _false;
							_QS_crewIndicatorIDD cutText ['','PLAIN'];
						};
					};
				};			
			} else {
				if (_QS_crewIndicator_shown) then {
					_QS_crewIndicator_shown = _false;
					_QS_crewIndicatorIDD cutText ['','PLAIN'];
				};
			};
			_QS_module_crewIndicator_checkDelay = _timeNow + _QS_module_crewIndicator_delay;
		};
	};
	
	if (_QS_module_gearManager) then {
		if (missionNamespace getVariable ['QS_client_triggerGearCheck',_false]) then {
			missionNamespace setVariable ['QS_client_triggerGearCheck',_false,_false];
			[_QS_player,_arsenalType,(missionNamespace getVariable 'QS_client_arsenalData')] call _fn_gearRestrictions;
		};
	};
	
	/*/========== Base safezone module/*/
	
	if (_QS_module_safezone) then {
		if (_timeNow > _QS_module_safezone_checkDelay) then {
			if (((_QS_player distance2D _QS_module_safezone_pos) < _QS_module_safezone_radius) && (_QS_v2 isNotEqualTo (missionNamespace getVariable 'QS_arty'))) then {
				if (_QS_posWorldPlayer inPolygon _QS_baseAreaPolygon) then {
					if (!(_QS_v2 isKindOf 'Man')) then {
						if (local _QS_v2) then {
							if (isTouchingGround _QS_v2) then {
								[17,_QS_v2] remoteExec ['QS_fnc_remoteExec',2,_false];
								50 cutText ['Vehicles in the spawn area are prohibited.','PLAIN',1];
							};
						};
					};
				};
				if (!(_QS_safezone_action in (actionIDs _QS_player))) then {
					_QS_safezone_action = player addAction _QS_action_safezone_array;
					player setUserActionText [_QS_safezone_action,((player actionParams _QS_safezone_action) # 0),'',''];
				};
				if (isDamageAllowed _QS_player) then {
					_QS_player allowDamage _false;
				};
				if (!(_QS_module_safezone_isInSafezone)) then {
					_QS_module_safezone_isInSafezone = _true;
					if (_QS_module_safezone_playerProtection isEqualTo 1) then {
						if (_QS_module_safezone_speedlimit_enabled) then {
							_QS_module_safezone_speedlimit_event = addMissionEventHandler ['EachFrame',_QS_module_safezone_speedlimit_code];
						};
					};
				};	
			} else {
				if (_QS_module_safezone_isInSafezone) then {
					_QS_module_safezone_isInSafezone = _false;
					if (_QS_module_safezone_playerProtection isEqualTo 1) then {
						player removeAction _QS_safezone_action;
						/*/50 cutText ['Exiting safezone','PLAIN DOWN',0.25];/*/   /*/ ugly and intrusive on screen, IMO /*/
						_QS_safezone_action = -1;
						if (!isDamageAllowed _QS_player) then {
							_QS_player allowDamage _true;
						};
						if (_QS_module_safezone_speedlimit_enabled) then {
							removeMissionEventHandler ['EachFrame',_QS_module_safezone_speedlimit_event];
						};
					};
				};
			};
			_QS_module_safezone_checkDelay = _timeNow + _QS_module_safezone_delay;
		};
		if (!isNull _objectParent) then {
			if (local _objectParent) then {
				if (isManualFire _objectParent) then {
					if ((_objectParent distance2D _QS_module_safezone_pos) < _QS_module_safezone_radius) then {
						_QS_player action ['manualFireCancel',_objectParent];
					};
				};
			};
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
					if ((rank _QS_player) isNotEqualTo 'LIEUTENANT') then {
						_QS_player setRank 'LIEUTENANT';
					};
				} else {
					if ((rank _QS_player) isNotEqualTo 'PRIVATE') then {
						_QS_player setRank 'PRIVATE';
					};
				};
			} else {
				if ((rank _QS_player) isNotEqualTo 'PRIVATE') then {
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
					_QS_playerGroup = group _QS_player;
					if ((count (units _QS_playerGroup)) < 2) then {
						if (!(_QS_playerGroup getVariable [_QS_joinGroup_privateVar,_false])) then {
							if ((_QS_player distance2D _QS_module_safezone_pos) > 1000) then {
								{
									_QS_clientDynamicGroups_testGrp = group _x;
									if (!(_QS_clientDynamicGroups_testGrp getVariable [_QS_joinGroup_privateVar,_false])) then {
										if ((count (units _QS_clientDynamicGroups_testGrp)) > 2) exitWith {
											[_QS_player] joinSilent _QS_clientDynamicGroups_testGrp;
										};
									};
								} count _allPlayers;
							};
						};
					};
					if (!(_QS_player getUnitTrait 'QS_trait_leader')) then {
						if ((count (units (group _QS_player))) > 3) then {
							_QS_player setUnitTrait ['QS_trait_leader',_true,_true];
						};
					} else {
						if ((count (units (group _QS_player))) <= 3) then {
							_QS_player setUnitTrait ['QS_trait_leader',_false,_true];
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
			if (!isNull (laserTarget _QS_player)) then {
				_QS_laserTarget = laserTarget _QS_player;
				if ((_QS_laserTarget distance2D _QS_module_safezone_pos) < 500) then {
					deleteVehicle _QS_laserTarget;
				};
			};
			if (!isNull (laserTarget _QS_v2)) then {
				_QS_laserTarget = laserTarget _QS_v2;
				if (local _QS_laserTarget) then {
					if ((_QS_laserTarget distance2D _QS_module_safezone_pos) < 500) then {
						[17,_QS_laserTarget] remoteExec ['QS_fnc_remoteExec',2,_false];
					};
				};
			};
			if (!isNil {_QS_player getVariable 'QS_tto'}) then {
				_QS_tto = _QS_player getVariable ['QS_tto',0];
				if (_QS_tto > 7) then {

				} else {
					if (_QS_tto > 6) then {
						if (!(userInputDisabled)) then {
							disableUserInput _true;
						};
					} else {
						if (_QS_tto > 5) then {
							endMission 'END1';
						};
					};
				};
				if (_QS_tto > 3) then {
					if (!(_QS_underEnforcement)) then {
						_QS_underEnforcement = _true;
						_QS_enforcement_loop = [_profileName,_QS_terminalVelocity] spawn {
							private ['_QS_v','_QS_tto','_QS_exitingEnforcedVehicle','_QS_exitingEnforcedVehicle_loop'];
							_n = _this # 0;
							_QS_terminalVelocity = _this # 1;
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
										_QS_terminalVelocity = _this # 0;
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
							_QS_underEnforcement = _false;
						};
					};
				} else {
					if (_QS_tto > 1) then {
						if (_thermalsEnabled) then {
							_thermalsEnabled = _false;
							player disableTIEquipment _true;
						};
						if (_QS_artyEnabled) then {
							_QS_artyEnabled = _false;
							enableEngineArtillery _false;	/*/ Disable arty computer if robocop detects trolling/friendly fire/*/
						};
					};
				};
			};
			_QS_clientATManager_delay = _timeNow + 5;
		};
	};
	
	/*/========== 3PV/*/
	
	if (cameraView isEqualTo 'EXTERNAL') then {
		if ((_QS_player getVariable 'QS_1PV') # 0) then {
			if (_lifeState isNotEqualTo 'INCAPACITATED') then {
				_QS_player switchCamera 'INTERNAL';
			};
		};
	};
	
	/*/========== Boot non-pilots out of pilot seats where necessary/*/
	
	if (_pilotCheck) then {
		if ((count _allPlayers) > 20) then {
			if (_QS_v2 isKindOf 'Air') then {
				if (!(_QS_v2Type in ['B_Heli_Light_01_F','Steerable_Parachute_F'])) then {
					if (_QS_player in [driver _QS_v2,currentPilot _QS_v2]) then {
						if ((!(_QS_player getUnitTrait 'QS_trait_pilot')) && {(!(_QS_player getUnitTrait 'QS_trait_fighterPilot'))}) then {
							if (((getPosATL _QS_v2) # 2) < 5) then {
								moveOut _QS_player;
								(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,'You are not in a pilot role',[],(serverTime + 20),_true,'Role Restriction',_false];
							};
						};
					};
				} else {
					if (!(_QS_v2Type in ['Steerable_Parachute_F'])) then {
						if (_QS_player in [(driver _QS_v2)]) then {
							if ((!(_QS_player getUnitTrait 'QS_trait_pilot')) && {(!(_QS_player getUnitTrait 'QS_trait_fighterPilot'))}) then {
								if (((getPosATL _QS_v2) # 2) < 5) then {
									moveOut _QS_player;
									(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,'You are not in a pilot role',[],(serverTime + 20),_true,'Role Restriction',_false];
								};
							};
						};
					};
				};
			};
			/*/===== Pilot babysitter/*/
			
			if (_QS_pilotBabysitter) then {
				if ((count _allPlayers) >= 20) then {
					if (_QS_player getUnitTrait 'QS_trait_pilot') then {
						if (time > _QS_secondsCounter) then {
							_QS_secondsCounter = time + 1;
							if (!(_QS_v2 isKindOf 'Air')) then {
								if ((_QS_player distance2D _QS_module_safezone_pos) > 1000) then {
									_QS_currentTimeOnGround = _QS_currentTimeOnGround + 1;
									if (_QS_currentTimeOnGround > _QS_maxTimeOnGround) then {
										forceRespawn _QS_player;
									} else {
										if (_QS_currentTimeOnGround > _QS_warningTimeOnGround) then {
											(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,'You are a pilot. Please play your role or re-assign. There are over 30 players on the server, please respawn if timely evac is not available.',[],(serverTime + 20),_true,'Role Restriction',_false];
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
					if ((_timeNow - _QS_afkTimer) >= (_QS_player getVariable 'QS_client_afkTimeout')) then {
						if (!(_QS_isAdmin)) then {
							if (!(_kicked)) then {
								_kicked = _true;
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
								[33,_QS_clientOwner,_profileName] remoteExec ['QS_fnc_remoteExec',2,_false];
							};
						};
					} else {
						if (
							(_QS_posWorldPlayer isNotEqualTo _QS_afkTimer_playerPos) ||
							(_QS_cameraPosition2D isNotEqualTo ((positionCameraToWorld [0,0,0]) select [0,2]))
						) then {
							_QS_player setVariable ['QS_client_afkTimeout',time,_false];
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
					_objNull, 
					_true, 
					-1, 
					'GEOM', 
					'VIEW', 
					_true
				];
				{
					if (!isNull (_x # 3)) then {
						if ((_x # 3) isKindOf 'AllVehicles') then {
							if (!alive (_x # 3)) then {
								_listOfFrontStuff pushBack (_x # 3);
							};
						};
					};
				} forEach _array;
				_mines = ['iedurbansmall_f','iedlandsmall_f','slamdirectionalmine','iedurbanbig_f','iedlandbig_f','satchelcharge_f','democharge_f','claymore_f'];
				if (_listOfFrontStuff isNotEqualTo []) then {
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
							[46,[_QS_player,1]] remoteExec ['QS_fnc_remoteExec',2,_false];
							['ScoreBonus',[format ['Cleaning up %1',_QS_worldName],'1']] call _fn_showNotification;
							uiSleep 1;
						};
						if (_x in _QS_allMines) then {
							[46,[_QS_player,1]] remoteExec ['QS_fnc_remoteExec',2,_false];
							['ScoreBonus',['Mine clearance','1']] call _fn_showNotification;
							_x setDamage [1,_true];
							uiSleep 1;
						};
						if ((_x isKindOf 'WeaponHolder') || {(_x isKindOf 'WeaponHolderSimulated')} || {(_x isKindOf 'GroundWeaponHolder')}) then {
							0 = _QS_toDelete pushBack _x;
						};
						if (_x isKindOf 'Land_Razorwire_F') then {
							_x setDamage [1,_true];
						};
						if ((toLower _objType) in _mines) then {
							_x setDamage [1,_true];
							0 = _QS_toDelete pushBack _x;
						};
					} count _listOfFrontStuff;
					if (_QS_toDelete isNotEqualTo []) then {
						[17,_QS_toDelete] remoteExec ['QS_fnc_remoteExec',2,_false];
						_QS_toDelete = [];
					};
				};
			};
		};
	};

	/*/===== Leaderboards module/*/
	
	if (_QS_module_leaderboards) then {
		if (_timeNow > _QS_module_leaderboards_checkDelay) then {
			if (_QS_module_leaderboards_pilots) then {
				if (_iAmPilot) then {
					_difficultyEnabledRTD = difficultyEnabledRTD;
					if (!((_QS_player getVariable 'QS_PP_difficultyEnabledRTD') # 0)) then {
						if (_timeNow > ((_QS_player getVariable 'QS_PP_difficultyEnabledRTD') # 1)) then {
							_QS_player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,(_timeNow + 900)],_true];
						};
					} else {
						if (!(_difficultyEnabledRTD)) then {
							_QS_player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,(_timeNow + 900)],_true];
						};
					};
				};
			};
			_QS_module_leaderboards_checkDelay = _timeNow + _QS_module_leaderboards_delay;
		};
		
		if (_QS_reportDifficulty) then {
			if (_timeNow > _QS_reportDifficulty_checkDelay) then {
				if ((primaryWeapon _QS_player) isNotEqualTo '') then {
					_hasThermals = ((primaryWeaponItems _QS_player) findIf {(_x in _thermalOptics)}) isEqualTo -1;
				} else {
					_hasThermals = _false;
				};
				_QS_player setVariable [
					'QS_clientDifficulty',
					[
						(isStaminaEnabled _QS_player),
						(getCustomAimCoef _QS_player),
						(primaryWeapon _QS_player),
						_hasThermals,
						cameraView,
						difficultyEnabledRTD,
						isStressDamageEnabled,
						(isAutoTrimOnRTD _QS_v2),
						(difficultyEnabled 'roughLanding'),
						(difficultyEnabled 'windEnabled')
					],
					_false
				];
				_clientDifficulty = _QS_player getVariable 'QS_clientDifficulty';
				if (!(_clientDifficulty # 0)) then {
					_QS_player setVariable ['QS_stamina_multiplier',[_false,(_timeNow + 900)],_false];
				} else {
					if (!((_QS_player getVariable 'QS_stamina_multiplier') # 0)) then {
						if (_timeNow > ((_QS_player getVariable 'QS_stamina_multiplier') # 1)) then {
							_QS_player setVariable ['QS_stamina_multiplier',[_true,_timeNow],_false];
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
			_QS_animState = toLower (animationState _QS_player);
			if (_QS_animState in ['ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwrfldnon_carried_still','ainjpfalmstpsnonwnondnon_carried_up']) then {
				if (!(_QS_player getVariable 'QS_RD_interacting')) then {
					if (_QS_player getVariable 'QS_animDone') then {
						uiSleep 0.25;
						if (isNull (attachedTo _QS_player)) then {
							if (_lifeState isEqualTo 'INCAPACITATED') then {
								['switchMove',_QS_player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
							} else {
								['switchMove',_QS_player,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
							};
						} else {
							if (!alive (attachedTo _QS_player)) then {
								if (_lifeState isEqualTo 'INCAPACITATED') then {
									['switchMove',_QS_player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
								} else {
									['switchMove',_QS_player,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
								};
							};
						};
					};
				};
			};
			if (_QS_animState in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still']) then {
				if (isNull (attachedTo _QS_player)) then {
					if (_lifeState isEqualTo 'INCAPACITATED') then {
						['switchMove',_QS_player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
					} else {
						['switchMove',_QS_player,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
					};
				};
			};
			if (_QS_animState in ['amovppnemstpsnonwnondnon']) then {
				if (isNull (attachedTo _QS_player)) then {
					if (_lifeState isEqualTo 'INCAPACITATED') then {
						['switchMove',_QS_player,'acts_injuredlyingrifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
					};
				};
			};
			_QS_module_animState_checkDelay = _timeNow + _QS_module_animState_delay;
		};
	};
	
	/*/========== HUD Manager/*/

	if (_QS_module_manageHUD) then {
		if (_timeNow > _QS_module_manageHUD_checkDelay) then {
			if (_lifeState isNotEqualTo 'INCAPACITATED') then {
				if (shownHud isNotEqualTo (missionNamespace getVariable (format ['QS_allowedHUD_%1',_QS_side]))) then {
					showHud (missionNamespace getVariable [(format ['QS_allowedHUD_%1',_QS_side]),WEST]);
				};
			};
			if ((missionNamespace getVariable 'QS_draw2D_projectiles') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') select {(!isNull _x)}),_false];
			};
			if ((missionNamespace getVariable 'QS_draw3D_projectiles') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') select {(!isNull _x)}),_false];
			};
			_QS_module_manageHUD_checkDelay = _timeNow + _QS_module_manageHUD_delay;
		};
	};

	/*/========== Texture Manager/*/
	
	if (_QS_module_texture) then {
		if (_timeNow > _QS_module_texture_checkDelay) then {
			if ((_QS_player getVariable 'QS_ClientUnitInsignia2') isNotEqualTo '#(argb,8,8,3)color(0,0,0,0)') then {
				[(_QS_player getVariable 'QS_ClientUnitInsignia2')] call _fn_clientSetUnitInsignia;
			};
			if (!isNull ((_QS_player getVariable 'QS_ClientVTexture') # 0)) then {
				_myV = (_QS_player getVariable 'QS_ClientVTexture') # 0;
				if (alive _myV) then {
					if (_QS_v2 isNotEqualTo _myV) then {
						if ((_QS_player distance2D _myV) > 100) then {
							{
								_myV setObjectTextureGlobal [_forEachIndex,_x];
							} forEach (getArray (configFile >> 'CfgVehicles' >> (typeOf _myV) >> 'hiddenSelectionsTextures'));
							_myV setVariable ['QS_ClientVTexture_owner',nil,_true];
							_QS_player setVariable ['QS_ClientVTexture',[_objNull,_puid,'',(_timeNow + 5)],_true];
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
				if ((markerAlpha _x) isNotEqualTo 0.75) then {
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
			if (((units (group _QS_player)) findIf {(!isPlayer _x)}) isNotEqualTo -1) then {
				{
					_unit = _x;
					if (isNil {_unit getVariable 'QS_event_handleHeal'}) then {
						_unit setVariable [
							'QS_event_handleHeal',
							(
								_unit addEventHandler [
									'HandleHeal',
									{
										if ((local (_this # 0)) || {(local (_this # 1))}) then {
											_this spawn (missionNamespace getVariable 'QS_fnc_clientEventHandleHeal');
										};
									}
								]
							),
							_false
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
			if (isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) then {
				if ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') # 0) then {
					if (!(_QS_module_radioChannelManager_nearPrimary)) then {
						if (((_QS_player distance2D (markerPos 'QS_marker_aoMarker')) < _QS_module_radioChannelManager_nearPrimaryRadius) || {((_QS_player distance2D (missionNamespace getVariable 'QS_evacPosition_1')) < _QS_module_radioChannelManager_nearPrimaryRadius)}) then {
							_QS_module_radioChannelManager_nearPrimary = _true;
							[1,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
						};
					} else {
						if (((_QS_player distance2D (markerPos 'QS_marker_aoMarker')) > _QS_module_radioChannelManager_nearPrimaryRadius) && ((_QS_player distance2D (missionNamespace getVariable 'QS_evacPosition_1')) > _QS_module_radioChannelManager_nearPrimaryRadius)) then {
							_QS_module_radioChannelManager_nearPrimary = _false;
							[0,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
						};
					};
				} else {
					if (_QS_module_radioChannelManager_primaryChannel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
						[0,_QS_module_radioChannelManager_primaryChannel] call _fn_clientRadio;
					};
				};
				if ((missionNamespace getVariable 'QS_client_radioChannels_dynamic') # 1) then {
					if (!(_QS_module_radioChannelManager_nearSecondary)) then {
						if (((_QS_player distance2D (markerPos 'QS_marker_sideMarker')) < _QS_module_radioChannelManager_nearSecondaryRadius) || {((_QS_player distance2D (missionNamespace getVariable 'QS_evacPosition_2')) < _QS_module_radioChannelManager_nearSecondaryRadius)}) then {
							_QS_module_radioChannelManager_nearSecondary = _true;
							[1,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
						};
					} else {
						if (((_QS_player distance2D (markerPos 'QS_marker_sideMarker')) > _QS_module_radioChannelManager_nearSecondaryRadius) && ((_QS_player distance2D (missionNamespace getVariable 'QS_evacPosition_2')) > _QS_module_radioChannelManager_nearSecondaryRadius)) then {
							_QS_module_radioChannelManager_nearSecondary = _false;
							[0,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
						};
					};
				} else {
					if (_QS_module_radioChannelManager_secondaryChannel in (missionNamespace getVariable 'QS_client_radioChannels')) then {
						[0,_QS_module_radioChannelManager_secondaryChannel] call _fn_clientRadio;
					};
				};
				/*/AIRCRAFT/*/
				if ((!(_QS_player getUnitTrait 'QS_trait_pilot')) && (!(_QS_player getUnitTrait 'uavhacker')) && (!(_QS_player getUnitTrait 'QS_trait_HQ')) && (!(_QS_player getUnitTrait 'QS_trait_fighterPilot')) && (!(_QS_player getUnitTrait 'QS_trait_CAS')) && (!(_QS_player getUnitTrait 'QS_trait_JTAC'))) then {
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
		};
		if ((getPlayerChannel _QS_player) in [0,1]) then {
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
		if (isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) then {
			if ((!(_QS_player getUnitTrait 'QS_trait_pilot')) && (!(_QS_player getUnitTrait 'uavhacker')) && (!(_QS_player getUnitTrait 'QS_trait_HQ')) && (!(_QS_player getUnitTrait 'QS_trait_fighterPilot')) && (!(_QS_player getUnitTrait 'QS_trait_CAS')) && (!(_QS_player getUnitTrait 'QS_trait_JTAC'))) then {
				if (currentChannel isEqualTo 7) then {
					if (!isNull (findDisplay 55)) then {
						if (!(_puid in (['ALL'] call _fn_uidStaff))) then {
							setCurrentChannel 5;
						};
					};
				};
			};
		};
		if (currentChannel isNotEqualTo 5) then {
			if (!isNull (findDisplay 55)) then {
				if (!('ItemRadio' in (assignedItems _QS_player))) then {
					50 cutText ['You need a Radio to transmit over radio channels!','PLAIN DOWN'];
					setCurrentChannel 5;
				};
			};
		};
		if (_QS_player getVariable ['QS_client_radioDisabled',_false]) then {
			if ('ItemRadio' in (assignedItems _QS_player)) then {
				_QS_player unassignItem 'ItemRadio'; 
			};
		};
	};
	
	/*/========== Sway Module/*/

	if (_QS_module_swayManager) then {
		if (_QS_uiTime > _QS_module_swayManager_checkDelay) then {
			_QS_customAimCoef = getCustomAimCoef _QS_player;
			if (!(_QS_player getUnitTrait 'QS_trait_AT')) then {
				if (isNull _objectParent) then {
					if ((secondaryWeapon _QS_player) isNotEqualTo '') then {
						if ((currentWeapon _QS_player) isEqualTo (secondaryWeapon _QS_player)) then {
							if (_QS_customAimCoef isNotEqualTo _QS_module_swayManager_secWepSwayCoef) then {
								_QS_player setCustomAimCoef _QS_module_swayManager_secWepSwayCoef;
							};
						} else {
							if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
								if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
									if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
										if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
											if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
												_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
											};
										};
									};
								};
							};
						};
					} else {
						if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
							if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
								if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
									if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
										if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
											_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
										};
									};
								};
							};
						};
					};
				} else {
					if (_QS_customAimCoef isEqualTo _QS_module_swayManager_secWepSwayCoef) then {
						if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
							if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
								if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
									if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
										_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
									};
								};
							};
						};
					};
				};
			};
			_QS_customAimCoef = getCustomAimCoef _QS_player;
			_QS_recoilCoef = unitRecoilCoefficient _QS_player;
			if ((toLower (currentWeapon _QS_player)) in _QS_module_swayManager_heavyWeapons) then {
				if ((stance _QS_player) isEqualTo 'STAND') then {
					if (
						(!(isWeaponDeployed _QS_player)) && 
						{(!(isWeaponRested _QS_player))} &&
						{(!(canDeployWeapon _QS_player))}
					) then {
						if (_QS_customAimCoef isNotEqualTo _QS_module_swayManager_heavyWeaponCoef_stand) then {
							_QS_player setCustomAimCoef _QS_module_swayManager_heavyWeaponCoef_stand;
						};
						if (_QS_recoilCoef isNotEqualTo _QS_module_swayManager_recoilCoef_stand) then {
							_QS_player setUnitRecoilCoefficient _QS_module_swayManager_recoilCoef_stand;
						};
					} else {
						if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
							if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
								if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
									if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
										if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
											_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
										};
									};
								};
							};
						};
						if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
							_QS_player setUnitRecoilCoefficient 1;
						};
					};
				} else {
					if ((stance _QS_player) isEqualTo 'CROUCH') then {
						if (
							(!(isWeaponDeployed _QS_player)) && 
							{(!(isWeaponRested _QS_player))} &&
							{(!(canDeployWeapon _QS_player))}
						) then {
							if (_QS_customAimCoef isNotEqualTo _QS_module_swayManager_heavyWeaponCoef_crouch) then {
								_QS_player setCustomAimCoef _QS_module_swayManager_heavyWeaponCoef_crouch;
							};
							if (_QS_recoilCoef isNotEqualTo _QS_module_swayManager_recoilCoef_crouch) then {
								_QS_player setUnitRecoilCoefficient _QS_module_swayManager_recoilCoef_crouch;
							};
						} else {
							if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
								if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
									if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
										if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
											if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
												_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
											};
										};
									};
								};
							};
							if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
								_QS_player setUnitRecoilCoefficient 1;
							};
						};
					} else {
						if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
							if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
								if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
									if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
										if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
											_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
										};
									};
								};
							};
						};
						if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
							_QS_player setUnitRecoilCoefficient 1;
						};
					};
				};
			} else {
				if (_QS_customAimCoef in [_QS_module_swayManager_heavyWeaponCoef_stand,_QS_module_swayManager_heavyWeaponCoef_crouch]) then {
					if (!isNil {_QS_player getVariable 'QS_stamina'}) then {
						if ((_QS_player getVariable 'QS_stamina') isEqualType []) then {
							if (((_QS_player getVariable 'QS_stamina') # 1) isEqualType 0) then {
								if (_QS_customAimCoef isNotEqualTo ((_QS_player getVariable 'QS_stamina') # 1)) then {
									_QS_player setCustomAimCoef ((_QS_player getVariable 'QS_stamina') # 1);
								};
							};
						};
					};
				};
				if (_QS_recoilCoef in [_QS_module_swayManager_recoilCoef_stand,_QS_module_swayManager_recoilCoef_crouch]) then {
					_QS_player setUnitRecoilCoefficient 1;
				};
			};
			_QS_module_swayManager_checkDelay = diag_tickTime + _QS_module_swayManager_delay;
		};
	};
	
	/*/========== Task Manager Module/*/

	if (_QS_module_taskManager) then {
		if (_timeNow > _QS_module_taskManager_checkDelay) then {
			_QS_module_taskManager_simpleTasks = simpleTasks _QS_player;
			if (_QS_module_taskManager_simpleTasks isNotEqualTo []) then {
				_QS_module_taskManager_currentTask = currentTask _QS_player;
				{
					if (!isNull _QS_module_taskManager_currentTask) then {
						if (_x isEqualTo _QS_module_taskManager_currentTask) then {
							if (!(taskAlwaysVisible _x)) then {
								_x setSimpleTaskAlwaysVisible _true;
							};
						} else {
							if (taskAlwaysVisible _x) then {
								_x setSimpleTaskAlwaysVisible _false;
							};
						};
					} else {
						if (taskAlwaysVisible _x) then {
							_x setSimpleTaskAlwaysVisible _false;
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
						if ((toLower (speaker _x)) isNotEqualTo 'novoice') then {
							_x setSpeaker 'NoVoice';
						};
						if ((_QS_player knowsAbout _x) <= 1) then {
							_QS_player reveal [_x,2];
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
			if ((missionNamespace getVariable ['QS_virtualSectors_data_public',[]]) isEqualType []) then {
				if ((missionNamespace getVariable 'QS_virtualSectors_data_public') isNotEqualTo []) then {
					_QS_virtualSectors_data_public = missionNamespace getVariable ['QS_virtualSectors_data_public',[]];
					{
						_sectorFlag = (_x # 17) # 0;
						_sectorPhase = _x # 26;
						if (_sectorFlag isEqualType _objNull) then {
							if (!isNull _sectorFlag) then {
								if (_sectorPhase isEqualType 0) then {
									if ((flagAnimationPhase _sectorFlag) isNotEqualTo _sectorPhase) then {
										_sectorFlag setFlagAnimationPhase _sectorPhase;
									};
								};
							};
						};
					} forEach _QS_virtualSectors_data_public;
				};
			};
			_QS_module_scAssistant_checkDelay = _QS_uiTime + _QS_module_scAssistant_delay;
		};
	};
	
	/*/========== Module Georgetown/*/
	
	if (_QS_isTanoa) then {
		if (_QS_uiTime > _QS_tanoa_checkDelay) then {
			if (missionNamespace getVariable ['QS_customAO_GT_active',_false]) then {
				if (!(_QS_inGeorgetown)) then {
					if (_QS_posWorldPlayer inPolygon _QS_georgetown_polygon) then {
						if (!isNull _objectParent) then {
							if (local _QS_v2) then {
								if ((isNull (attachedTo _QS_v2)) && (isNull (isVehicleCargo _QS_v2))) then {
									if (_QS_v2 isKindOf 'LandVehicle') then {
										if ((fuel _QS_v2) > 0) then {
											_QS_v2 setFuel 0;
										};
									};
									if (((crew _QS_v2) findIf {(alive _x)}) isNotEqualTo -1) then {
										['setVehicleAmmo',_QS_v2,0] remoteExec ['QS_fnc_remoteExecCmd',(crew _QS_v2),_false];
									};
								};
							};
						};
						if (((_posATLPlayer # 2) < 50) && (isNull _objectParent)) then {
							_QS_inGeorgetown = _true;
							_QS_georgetown_priorVD = viewDistance;
							_QS_georgetown_priorOVD = getObjectViewDistance # 0;
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
										setObjectViewDistance ((getObjectViewDistance # 0) - 10);
										if ((getObjectViewDistance # 0) <= _QS_georgetown_OVD) exitWith {};
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
					if (!isNull _objectParent) then {
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
					if ((!(_QS_posWorldPlayer inPolygon _QS_georgetown_polygon)) || {(!isNull _objectParent)} || {((_posATLPlayer # 2) >= 50)}) then {
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
							if ((getObjectViewDistance # 0) < _QS_georgetown_priorOVD) then {
								_time = diag_tickTime + 3;
								for '_x' from 0 to 1 step 0 do {
									setObjectViewDistance ((getObjectViewDistance # 0) + 10);
									if ((getObjectViewDistance # 0) >= _QS_georgetown_priorOVD) exitWith {};
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
					_QS_inGeorgetown = _false;
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
						if ((getObjectViewDistance # 0) < _QS_georgetown_priorOVD) then {
							_time = diag_tickTime + 3;
							for '_x' from 0 to 1 step 0 do {
								setObjectViewDistance ((getObjectViewDistance # 0) + 10);
								if ((getObjectViewDistance # 0) >= _QS_georgetown_priorOVD) exitWith {};
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
				if (!isNil {_QS_player getVariable ['QS_HUD_3',nil]}) then {
					missionNamespace setVariable ['QS_client_groupIndicator_units',(((_posATLPlayer select [0,2]) nearEntities [_QS_module_groupIndicator_types,_QS_module_groupIndicator_radius]) select _QS_module_groupIndicator_filter),_false];
				};
			};
			_QS_module_groupIndicator_checkDelay = _QS_uiTime + _QS_module_groupIndicator_delay;
		};
	};
	
	/*/===== Medic Revive icons/*/
	
	if (_QS_player getUnitTrait 'medic') then {
		if (_QS_uiTime > _QS_medicIcons_checkDelay) then {
			[_posATLPlayer,500,_fn_enemySides] spawn _fn_getNearbyIncapacitated;
			_QS_medicIcons_checkDelay = _QS_uiTime + _QS_medicIcons_delay;
		};
	};
	
	/*/===== Client AI/*/
	
	if (_QS_module_clientAI) then {
		if (_QS_uiTime > _QS_module_clientAI_checkDelay) then {
			if (_QS_player isEqualTo (leader (group _QS_player))) then {
				if (((units (group _QS_player)) findIf {((alive _x) && (!(isPlayer _x)) && (!(unitIsUav _x)))}) isNotEqualTo -1) then {
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
		if ((_QS_uiTime > _QS_module_opsec_checkDelay) || {isGamePaused} || {!isGameFocused})  then {
			_QS_module_opsec_detected = 0;
			if (_QS_module_opsec_detected < 2) then {
				if (_QS_module_opsec_recoilSway) then {
					if (((unitRecoilCoefficient _QS_player) < 1) || {((getCustomAimCoef _QS_player) < 0.1)} || {((getAnimSpeedCoef _QS_player) > 1.1)}) then {
						_QS_module_opsec_detected = 2;
						_detected = format ['Recoil: %1 (min 1) Sway: %2 (min 0.1) AnimSpeed: %3 (max 1.1)',(unitRecoilCoefficient _QS_player),(getCustomAimCoef _QS_player),(getAnimSpeedCoef _QS_player)];
					};
				};
				if (isFilePatchingEnabled) then {
					_QS_module_opsec_detected = 2;
					_detected = 'FilePatchingEnabled';
				};
				if (cheatsEnabled) then {
					_QS_module_opsec_detected = 1;
					_detected = 'Cheats Enabled (Use discretion)';
				};
				if (_QS_module_opsec_hidden) then {
					if (isObjectHidden _QS_player) then {
						_QS_module_opsec_detected = 2;
						_detected = 'IsInvisible';
					};
				};
				if (!(simulationEnabled _QS_player)) then {
					_QS_player enableSimulation _true;
				};
				if (clientOwner isNotEqualTo _QS_clientOwner) then {
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
				_commandingMenu = toLower commandingMenu;
				if (_commandingMenu isNotEqualTo '') then {
					if(!(_commandingMenu in _validCommMenus)) then {
						if ((!(['#GET_IN',_commandingMenu,_false] call _fn_inString)) && {(!(['#WATCH',_commandingMenu,_false] call _fn_inString))} && {(!(['#ACTION',_commandingMenu,_false] call _fn_inString))}) then {
							_detected = format ['CMD_Menu_Hack_%1 (Use Discretion)',_commandingMenu];
							_QS_module_opsec_detected = 2;
						};
					};
				};
				if (_QS_module_opsec_menus) then {
					{
						(_QS_module_opsec_displays # _forEachIndex) params [
							'_targetDisplay',
							'_targetName',
							'_targetFlag'
						];
						if (_targetFlag isEqualTo 0) then {
							if (_targetDisplay isEqualType '') then {
								if (!isNull (uiNamespace getVariable [_targetDisplay,_dNull])) then {
									if (_targetDisplay isEqualTo 'BIS_fnc_arsenal_display') then {
										if ((count (allControls (uiNamespace getVariable 'BIS_fnc_arsenal_display'))) > 205) then {
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
							_QS_module_opsec_displayIDDstr = ((str _display) splitString '#') # 1;
							if (_QS_module_opsec_displayIDDstr isEqualTo '148') then {
								uiSleep 0.025;
								if (((lbSize 104) - 1) > 3) exitWith {
									_detected = 'MenuHack_RscDisplayConfigureControllers (JME 313)';
									_QS_module_opsec_detected = 2;
								};
							};
							if (_QS_module_opsec_displayIDDstr isEqualTo '157') then {
								if (isNull (uiNamespace getVariable ['RscDisplayModLauncher',_dNull])) then {
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
										_false
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
									({if (buttonAction (_display displayCtrl _x) != '') exitWith {TRUE}; _false} forEach [1,104,105,106,107,108,109])
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
									({if (buttonAction (_display displayCtrl _x) != '') exitWith {TRUE}; _false} forEach [1,2])
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
										_ctrlCfg = _x # _i;
										if (((getText (_ctrlCfg >> 'action')) != '') || {((getText (_ctrlCfg >> 'onButtonClick')) != '')}) exitWith {
											_detected = format ['Unknown Escape Menu button: %1',(getText (_ctrlCfg >> 'text'))];
											_QS_module_opsec_detected = 2;
										};
									};
								} forEach [
									(getArray (configFile >> 'RscDisplayMPInterrupt' >> 'controls')),
									(getArray (configFile >> 'RscDisplayMPInterrupt' >> 'controlsBackground'))
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
					if (_QS_module_opsec_memCheck_WorkingArray isNotEqualTo []) then {
						[((_QS_module_opsec_memCheck_WorkingArray # 0) # 0),_namePlayer,_profileName,_profileNameSteam,_puid,((_QS_module_opsec_memCheck_WorkingArray # 0) # 1)] spawn _QS_module_opsec_memCheck_script;
						_QS_module_opsec_memCheck_WorkingArray set [0,_false];
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
				if (_QS_module_opsec_hints) then {
					_display = uiNamespace getVariable ['QS_hint_display_1',_dNull];
					if (!isNull _display) then {
						_ahHintText = toLower (ctrlText (_display displayCtrl 101));
						if (_ahHintText isNotEqualTo '') then {
							{
								if ([_x,_ahHintText,_false] call _fn_inString) exitWith {
									_QS_module_opsec_detected = 1;
									_detected = format ['Blacklisted text in hint display: %1 * %2',_x,_ahHintText];
									[''] call _fn_hint;
								};
							} forEach _ahHintList;
						};
					};
				};
				if (_QS_module_opsec_vars) then {
					_QS_module_opsec_vars = _false;
					/*/ Scan UI and Mission namespaces for illicit vars and var value types/*/
				};
				if (_QS_module_opsec_checkScripts) then {
					_QS_module_opsec_checkScripts = _false;
				};
				if (_QS_module_opsec_checkActions) then {
					_opsec_actionIDs = actionIDs player;
					_opsec_actionParams = [];
					if (_opsec_actionIDs isNotEqualTo []) then {
						{
							_opsec_actionParams = player actionParams _forEachIndex;
							_opsec_actionParams = [];
							if (!(isNil '_opsec_actionParams')) then {
								if (_opsec_actionParams isNotEqualTo []) then {
									_opsec_actionParams params [
										'_opsec_actionTitle',
										'_opsec_actionCode'
									];
									if (!(_opsec_actionTitle in _opsec_actionWhitelist)) then {
										if (!(_puid in (['DEVELOPER'] call _fn_uidStaff))) then {
											if ((!(['ROBOCOP',_opsec_actionTitle,_false] call _fn_inString)) && (!(['Put Explosive Charge',_opsec_actionTitle,_false] call _fn_inString))) then {
												_QS_module_opsec_return = [_QS_module_opsec_memArray,_namePlayer,_profileName,_profileNameSteam,_puid] call _QS_module_opsec_memCheck_script;
												if ((_QS_module_opsec_return # 0) isNotEqualTo 0) then {
													_detected = format ['%1 + %2',_detected,(_QS_module_opsec_return # 1)];
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
														player,
														_QS_productVersion
													]
												] remoteExec ['QS_fnc_remoteExec',2,_false];
												_co = player;
												removeAllActions _co;
											} else {
												
											};
										};
									};
								};
							};
						} forEach _opsec_actionIDs;
					};
				};
				_bis_fnc_diagkey = uiNamespace getVariable ['BIS_fnc_diagKey',{FALSE}];
				if (!isNil '_bis_fnc_diagkey') then {
					if (!((str _bis_fnc_diagkey) in ['{false}','{FALSE}','{}'])) then {
						_QS_module_opsec_detected = 2;
						_detected = 'BIS_fnc_DiagKey (wat?)';
					};
				};
				if (_QS_module_opsec_detected isNotEqualTo 0) then {
					if (_QS_module_opsec_detected > 1) then {
						_QS_module_opsec_return = [_QS_module_opsec_memArray,_namePlayer,_profileName,_profileNameSteam,_puid] call _QS_module_opsec_memCheck_script;
						if ((_QS_module_opsec_return # 0) isNotEqualTo 0) then {
							_detected = format ['%1 + %2',_detected,(_QS_module_opsec_return # 1)];
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
							player,
							_QS_productVersion
						]
					] remoteExec ['QS_fnc_remoteExec',2,_false];
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
		if (_QS_module_opsec_checkActions) then {
			if (isActionMenuVisible) then {
				_opsec_actionIDs = actionIDs player;
				_opsec_actionParams = [];
				if (_opsec_actionIDs isNotEqualTo []) then {
					{
						_opsec_actionParams = player actionParams _forEachIndex;
						_opsec_actionParams = [];
						if (!(isNil '_opsec_actionParams')) then {
							if (_opsec_actionParams isNotEqualTo []) then {
								_opsec_actionParams params [
									'_opsec_actionTitle',
									'_opsec_actionCode'
								];
								if (!(_opsec_actionTitle in _opsec_actionWhitelist)) then {
									if (!(_puid in (['DEVELOPER'] call _fn_uidStaff))) then {
										if ((!(['ROBOCOP',_opsec_actionTitle,_false] call _fn_inString)) && (!(['Put Explosive Charge',_opsec_actionTitle,_false] call _fn_inString))) then {
											_QS_module_opsec_return = [_QS_module_opsec_memArray,_namePlayer,_profileName,_profileNameSteam,_puid] call _QS_module_opsec_memCheck_script;
											if ((_QS_module_opsec_return # 0) isNotEqualTo 0) then {
												_detected = format ['%1 + %2',_detected,(_QS_module_opsec_return # 1)];
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
													player,
													_QS_productVersion
												]
											] remoteExec ['QS_fnc_remoteExec',2,_false];
											_co = player;
											removeAllActions _co;
										} else {
											
										};
									};
								};
							};
						};
					} forEach _opsec_actionIDs;
				};
			};
		};
	};
	if (_lifeState isNotEqualTo 'INCAPACITATED') then {
		if (!(_QS_module_49Opened)) then {
			_d49 = findDisplay 49;
			if (!isNull _d49) then {
				if (!(isStreamFriendlyUIEnabled)) then {
					if (shownChat) then {
						showChat _false;
					};
				};
				_QS_module_49Opened = _true;
				{
					_QS_buttonCtrl = _d49 displayCtrl _x;
					if (!isNull _QS_buttonCtrl) then {
						_QS_buttonCtrl ctrlSetText 'Player Menu';
						_QS_buttonCtrl buttonSetAction _QS_buttonAction;
						_QS_buttonCtrl ctrlSetTooltip 'Invade & Annex player menu';
						_QS_buttonCtrl ctrlSetBackgroundColor [1,0.5,0.5,1];
						_QS_buttonCtrl ctrlCommit 0;
					};
				} forEach [16700,2];
				_QS_buttonCtrl = _d49 displayCtrl 103;
				_QS_buttonCtrl ctrlEnable (([_false,_true] select _roleSelectionSystem) && _RSS_MenuButton);
				_QS_buttonCtrl ctrlShow (([_false,_true] select _roleSelectionSystem) && _RSS_MenuButton);
				_QS_buttonCtrl ctrlSetText (['','Role Selection'] select _roleSelectionSystem);
				if (_roleSelectionSystem) then {
					_QS_buttonCtrl buttonSetAction _QS_buttonAction2;
					_QS_buttonCtrl ctrlSetTooltip 'Change player role';
					_QS_buttonCtrl ctrlSetBackgroundColor [1,0.5,0.5,1];
					_QS_buttonCtrl ctrlCommit 0;
				};
				(_d49 displayCtrl 523) ctrlSetText (format ['%1',_profileName]);
				(_d49 displayCtrl 109) ctrlSetText (format ['%1',_roleDisplayName]);
				(_d49 displayCtrl 104) ctrlEnable _true;
				(_d49 displayCtrl 104) ctrlSetText (['Abort','Exit'] select _roleSelectionSystem);
				(_d49 displayCtrl 104) ctrlSetTooltip (['Abort to lobby.','Leave server.'] select _roleSelectionSystem);
				(_d49 displayCtrl 1005) ctrlSetText (format ['%1 - A3 %2',_QS_missionVersion,(format ['%1.%2',(_QS_productVersion # 2),(_QS_productVersion # 3)])]);
			};
		} else {
			_d49 = findDisplay 49;
			if (isNull _d49) then {
				if (!(isStreamFriendlyUIEnabled)) then {
					if (!(shownChat)) then {
						showChat _true;
					};
				};
				_QS_module_49Opened = _false;
			};
		};
	};

	if (_QS_uiTime > _QS_miscDelay5) then {
		if ((missionNamespace getVariable ['QS_vehicle_incomingMissiles',[]]) isNotEqualTo []) then {
			missionNamespace setVariable ['QS_vehicle_incomingMissiles',((missionNamespace getVariable 'QS_vehicle_incomingMissiles') select {(!isNull (_x # 0))}),_false];
		};
		if ((missionNamespace getVariable ['QS_draw2D_projectiles',[]]) isNotEqualTo []) then {
			missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') select {(!isNull _x)}),_false];
		};
		if ((uiNamespace getVariable ['RscMissionStatus_display',_dNull]) isEqualTo (findDisplay 46)) then {
			uiNamespace setVariable ['RscMissionStatus_display',(findDisplay 46)];
		};
		_QS_miscDelay5 = _QS_uiTime + 10;
	};
	if (_QS_module_soundControllers) then {
		if (_QS_uiTime > _QS_module_soundControllers_checkDelay) then {
			_QS_player setVariable ['QS_client_soundControllers',[(getAllSoundControllers _QS_v2),(getAllEnvSoundControllers _QS_posWorldPlayer)],_false];
			_QS_module_soundControllers_checkDelay = _QS_uiTime + (_QS_module_soundControllers_delay + (random 1));
		};
	};
	if (_QS_module_playerInArea) then {
		if (_QS_uiTime > _QS_module_playerInArea_checkDelay) then {
			if ((_QS_posWorldPlayer distance2D _QS_module_safezone_pos) < _QS_module_safezone_radius) then {
				if (!(_QS_player getVariable ['QS_client_inBaseArea',_false])) then {
					_QS_player setVariable ['QS_client_inBaseArea',_true,_false];
				};
				if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
					_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
				};
				if (_QS_player getVariable ['QS_client_inCarrierArea',_false]) then {
					_QS_player setVariable ['QS_client_inCarrierArea',_false,_false];
					if (_QS_carrierEnabled isNotEqualTo 0) then {
						if (!isNull (missionNamespace getVariable ['QS_carrierObject',_objNull])) then {
							if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
								(missionNamespace getVariable 'QS_carrierObject') enableSimulation _false;
								{
									if (!isNull (_x # 0)) then {
										if (simulationEnabled (_x # 0)) then {
											(_x # 0) enableSimulation _false;
										};
									};
								} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
							};
						};
					};
				};
				if (_QS_module_playerInArea_delay isNotEqualTo 5) then {
					_QS_module_playerInArea_delay = 5;
				};
			} else {
				if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_module_fob')) < 300) then {
					if (_QS_player getVariable ['QS_client_inBaseArea',_false]) then {
						_QS_player setVariable ['QS_client_inBaseArea',_false,_false];
					};
					if (!(_QS_player getVariable ['QS_client_inFOBArea',_false])) then {
						_QS_player setVariable ['QS_client_inFOBArea',_true,_false];
					};
					if (_QS_player getVariable ['QS_client_inCarrierArea',_false]) then {
						_QS_player setVariable ['QS_client_inCarrierArea',_false,_false];
						if (_QS_carrierEnabled isNotEqualTo 0) then {
							if (!isNull (missionNamespace getVariable ['QS_carrierObject',_objNull])) then {
								if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
									(missionNamespace getVariable 'QS_carrierObject') enableSimulation _false;
									{
										if (!isNull (_x # 0)) then {
											if (simulationEnabled (_x # 0)) then {
												(_x # 0) enableSimulation _false;
											};
										};
									} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
								};
							};
						};
					};
					if (_QS_module_playerInArea_delay isNotEqualTo 5) then {
						_QS_module_playerInArea_delay = 5;
					};
				} else {
					if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_carrier_1')) < 300) then {
						if (_QS_player getVariable ['QS_client_inBaseArea',_false]) then {
							_QS_player setVariable ['QS_client_inBaseArea',_false,_false];
						};
						if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
							_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
						};
						if (!(_QS_player getVariable ['QS_client_inCarrierArea',_false])) then {
							_QS_player setVariable ['QS_client_inCarrierArea',_true,_false];
							if (_QS_carrierEnabled isNotEqualTo 0) then {
								if (!isNull (missionNamespace getVariable ['QS_carrierObject',_objNull])) then {
									if (!simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
										(missionNamespace getVariable 'QS_carrierObject') enableSimulation _true;
										{
											if (!isNull (_x # 0)) then {
												if (!simulationEnabled (_x # 0)) then {
													(_x # 0) enableSimulation _true;
												};
											};
										} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
									};
								};
							};
						};
						if (_QS_module_playerInArea_delay isNotEqualTo 5) then {
							_QS_module_playerInArea_delay = 5;
						};
					} else {
						if (_QS_player getVariable ['QS_client_inBaseArea',_false]) then {
							_QS_player setVariable ['QS_client_inBaseArea',_false,_false];
						};
						if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
							_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
						};
						if (_QS_player getVariable ['QS_client_inCarrierArea',_false]) then {
							_QS_player setVariable ['QS_client_inCarrierArea',_false,_false];
							if (_QS_carrierEnabled isNotEqualTo 0) then {
								if (!isNull (missionNamespace getVariable ['QS_carrierObject',_objNull])) then {
									if (simulationEnabled (missionNamespace getVariable 'QS_carrierObject')) then {
										(missionNamespace getVariable 'QS_carrierObject') enableSimulation _false;
										{
											if (!isNull (_x # 0)) then {
												if (simulationEnabled (_x # 0)) then {
													(_x # 0) enableSimulation _false;
												};
											};
										} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['bis_carrierParts',[]]);
									};
								};
							};
						};
						if (_QS_module_playerInArea_delay isNotEqualTo 5) then {
							_QS_module_playerInArea_delay = 20;
						};
					};
				};
			};
			_QS_module_playerInArea_checkDelay = _QS_uiTime + _QS_module_playerInArea_delay;
		};
	};
	if (_QS_uiTime > _hintCheckDelay) then {
		if ((missionNamespace getVariable 'QS_managed_hints') isNotEqualTo []) then {
			{
				_hintsQueue pushBack _x;
			} forEach (missionNamespace getVariable 'QS_managed_hints');
			missionNamespace setVariable ['QS_managed_hints',[],_false];
		};
		if (!(_hintActive)) then {
			if (_hintsQueue isNotEqualTo []) then {
				_hintsQueue sort _true;
				_hintData = _hintsQueue deleteAt 0;
				_hintData params [
					'_hintPriority',
					'_hintUseSound',
					'_hintDuration',
					'_hintPreset',
					'_hintText',
					'_hintOtherData',
					'_hintIrrelevantWhen',
					['_hintAdv',_false,[_false]],
					['_advTitle','',['',_parsedText]],
					['_advRecall',_false,[_false]]
				];	
				if (((toLower (str _hintText)) isNotEqualTo (toLower (str _hintTextPrevious))) || {(_QS_uiTime > (_hintPriorClosedAt + 15))} || {(_hintsQueue isEqualTo [])}) then {
					if ((_hintIrrelevantWhen isEqualTo -1) || {(_serverTime < _hintIrrelevantWhen)}) then {
						if (_hintPreset isNotEqualTo -1) then {
							[_hintPreset,_hintOtherData] call _fn_clientHintPresets;
						} else {
							if (!(isStreamFriendlyUIEnabled)) then {
								[_hintText,_hintUseSound,_hintAdv,_advTitle,_advRecall] call _fn_hint;
							};
						};
						_hintTextPrevious = _hintText;
						_hintActive = _true;
						_hintActiveDuration = _QS_uiTime + _hintDuration;
					};
				};
			};
		} else {
			if (_QS_uiTime > _hintActiveDuration) then {
				_hintActive = _false;
				_hintPriorClosedAt = _QS_uiTime;
				[''] call _fn_hint;
			};
		};
		if (_QS_module_opsec_hints) then {
			_display = uiNamespace getVariable ['QS_hint_display_1',_dNull];
			if (!isNull _display) then {
				_ahHintText = toLower (ctrlText (_display displayCtrl 101));
				if (_ahHintText isNotEqualTo '') then {
					{
						if ([_x,_ahHintText,_false] call _fn_inString) exitWith {
							_QS_module_opsec_detected = 1;
							_detected = format ['Blacklisted text in hint display: %1 * %2',_x,_ahHintText];
							[''] call _fn_hint;
						};
					} forEach _ahHintList;
				};
			};
		};
		_hintCheckDelay = _QS_uiTime + _hintDelay;
	};
	if (_QS_module_highCommand) then {
		if (_QS_uiTime > _QS_module_highCommand_checkDelay) then {
			_QS_module_highCommand_waypoints = waypoints (group _QS_player);
			if (_QS_module_highCommand_waypoints isNotEqualTo []) then {
				{
					if (!(waypointVisible _x)) then {
						_x setWaypointVisible _true;
					};
					if ((waypointPosition _x) isEqualTo [0,0,0]) then {
						deleteWaypoint _x;
					};
				} forEach _QS_module_highCommand_waypoints;
			};
			_QS_module_highCommand_checkDelay = _QS_uiTime + _QS_module_highCommand_delay;
		};
	};
	if (_QS_module_gpsJammer) then {
		if (_QS_uiTime > _QS_module_gpsJammer_checkDelay) then {
			_QS_module_gpsJammer_inArea = [0,_QS_player] call _fn_gpsJammer;
			if (_QS_module_gpsJammer_inArea) then {
				if (_QS_uiTime > _QS_module_gpsJammer_signalCheck) then {
					[3,_QS_player,_true] call _fn_gpsJammer;
					_QS_module_gpsJammer_signalCheck = _QS_uiTime + _QS_module_gpsJammer_signalDelay;
				};
				if (ctrlEnabled _QS_module_gpsJammer_ctrlPlayer) then {
					_QS_module_gpsJammer_ctrlPlayer ctrlEnable _false;
				};
			} else {
				if (!(ctrlEnabled _QS_module_gpsJammer_ctrlPlayer)) then {
					_QS_module_gpsJammer_ctrlPlayer ctrlEnable _true;
				};
			};
			_QS_module_gpsJammer_checkDelay = _QS_uiTime + _QS_module_gpsJammer_delay;
		};
	};
	if (_QS_module_roleAssignment) then {
		{
			if (_x getVariable ['QS_unit_role_netUpdate',_false]) then {
				['UPDATE_UI',_x] call _fn_roles;
			};
		} count _allPlayers;
		if (_QS_side isNotEqualTo (_QS_player getVariable ['QS_unit_side',_west])) then {
			_QS_side = _QS_player getVariable ['QS_unit_side',_west];
			_enemysides = _QS_side call _fn_enemySides;
			setPlayerRespawnTime ([15,5] select (_QS_side isEqualTo _west));
		};
		if (_playerRole isNotEqualTo (_QS_player getVariable ['QS_unit_role','rifleman'])) then {
			_playerRole = _QS_player getVariable ['QS_unit_role','rifleman'];
			_roleDisplayName = ['GET_ROLE_DISPLAYNAME',_playerRole] call _fn_roles;
			_roleDisplayNameL = toLower _roleDisplayName;
			if (_QS_player getUnitTrait 'QS_trait_pilot') then {
				_iAmPilot = _true;
				_pilotAtBase = _true;
				_difficultyEnabledRTD = difficultyEnabledRTD;
				_QS_player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,time],_true];
			};
		};
		if (_QS_side in [_s0,_s2]) then {
			if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
				if ((_QS_player distance2D (markerPos 'QS_marker_aoCircle')) > (((markerSize 'QS_marker_aoCircle') # 0) * 1.1)) then {
					if (((markerAlpha 'QS_marker_aoCircle') > 0) || {((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) isEqualTo 'GRID')}) then {
						if (_QS_uiTime > (uiNamespace getVariable ['QS_client_respawnCooldown',-1])) then {
							(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,20,-1,'OPFOR players cannot leave the Area of Operations.',[],-1,TRUE,'Mission Control',FALSE];		
							_QS_player setDamage [1,_true];
						};
					};
				};
				if (!(cameraView in ['INTERNAL','GUNNER'])) then {
					if (_lifeState isNotEqualTo 'INCAPACITATED') then {
						_QS_player switchCamera 'INTERNAL';
					};
				};
			};
		};
	};
	uiSleep 0.1;
};
['Uho! It appears something has gone wrong. Please report this error code to staff:<br/><br/>456<br/><br/>Thank you for your assistance.',TRUE] call _fn_hint;