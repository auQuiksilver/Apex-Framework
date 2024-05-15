/*/
File: fn_clientCore.sqf
Author:

	Quiksilver
	
Last Modified:

	14/11/2023 A3 2.14 by Quiksilver
	
Description:

	Client Core
________________________________________________/*/

privateAll;
private [
	'_QS_module_liveFeed_checkDelay','_QS_liveFeed_display',
	'_QS_liveFeed_vehicle','_QS_liveFeed_vehicle_current','_QS_liveFeed_camera','_QS_nullPos','_screenPos','_QS_liveFeed_text','_QS_module_liveFeed_noSignalFile',
	'_QS_liveFeed_action_1','_QS_liveFeed_action_2','_QS_module_liveFeed_delay','_displayPos','_QS_fpsArray','_QS_fpsAvgSamples','_QS_module_viewSettings',
	'_QS_RD_client_viewSettings_saveDelay','_QS_RD_client_viewSettings_saveCheckDelay','_revalidate','_QS_RD_client_viewSettings','_QS_RD_client_viewSettings_overall',
	'_QS_RD_client_viewSettings_object','_QS_RD_client_viewSettings_shadow','_QS_RD_client_viewSettings_grass','_QS_RD_client_viewSettings_environment',
	'_mainMenuOpen','_QS_clientHp','_QS_clientMass','_QS_fpsLastPull','_mainMenuIDD','_QS_clientSideScore','_QS_clientScore',
	'_QS_rating','_viewMenuOpen','_viewMenuIDD','_viewDistance','_objectViewDistance','_shadowDistance','_clientViewSettings','_QS_module_crewIndicator',
	'_QS_module_crewIndicator_delay','_QS_module_crewIndicator_checkDelay','_QS_crewIndicatorIDD','_QS_crewIndicatorIDC','_QS_crewIndicator',
	'_QS_crewIndicator_imgDriver','_QS_crewIndicator_imgGunner','_QS_crewIndicator_imgCommander','_QS_crewIndicator_imgCargo','_QS_crewIndicator_imgSize','_QS_crewIndicator_color',
	'_QS_crewIndicator_colorHTML','_QS_crewIndicator_imgColor','_QS_crewIndicator_textColor','_QS_crewIndicator_textFont','_QS_crewIndicator_textSize','_crewManifest',
	'_QS_crewIndicator_shown','_fullCrew','_index','_QS_module_fuelConsumption','_QS_module_fuelConsumption_checkDelay','_QS_module_fuelConsumption_factor_2',
	'_QS_module_fuelConsumption_factor_1','_QS_module_fuelConsumption_delay','_unit','_role','_cargoIndex','_turretPath','_personTurret','_text','_roleImg','_roleIcon','_unitName',
	'_QS_module_gearManager','_QS_module_gearManager_checkDelay','_QS_module_gearManager_delay','_QS_firstRun','_playerThreshold','_QS_side',
	'_QS_clientATManager','_QS_clientATManager_delay','_QS_tto','_QS_artyEnabled','_QS_underEnforcement','_QS_enforcement_loop',
	'_QS_decayRate','_QS_decayDelay','_QS_fpsCheckDelay','_QS_fpsDelay','_pilotCheck',
	'_nearSite','_nearSite2','_QS_action_clearVehicleInventory','_QS_action_clearVehicleInventory_text',
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
	'_QS_action_teeth','_QS_action_teeth_text','_QS_action_teeth_array',
	'_QS_interaction_teeth','_QS_module_opsec_checkScripts','_baseMarkers','_pr','_clientDifficulty','_QS_parsingNamespace',
	'_playerNetId','_QS_action_joinGroup','_QS_action_joinGroup_text','_QS_action_joinGroup_array','_QS_interaction_joinGroup','_QS_joinGroup_privateVar',
	'_posATLPlayer','_bis_fnc_diagkey','_uiNamespace_dynamicText','_QS_module_handleHeal','_QS_module_handleHeal_delay','_QS_module_handleHeal_checkDelay',
	'_QS_handleHeal_unit','_isCurator','_curatorDisplay','_curatorDisplay_loaded','_restrictions_AT_msg','_restrictions_SNIPER_msg','_restrictions_AUTOTUR_msg',
	'_restrictions_UAV_msg','_restrictions_OPTICS_msg','_restrictions_MG_msg','_restrictions_MMG_msg','_restrictions_SOPT_msg','_restrictions_MK_msg',
	'_restrictions_PACK_msg','_restrictions_FIRED_msg','_QS_weapons','_QS_playerType','_QS_objectTypes','_QS_objectRange','_cursorObject','_cursorObjectDistance',
	'_grpTarget','_pilotAtBase','_QS_action_fob_status','_QS_action_fob_status_text','_QS_action_fob_status_array','_QS_interaction_fob_status','_QS_action_fob_terminals',
	'_QS_action_fob_activate','_QS_action_fob_activate_text','_QS_action_fob_activate_array','_QS_interaction_fob_activate','_QS_action_fob_respawn',
	'_QS_action_fob_respawn_text','_QS_action_fob_respawn_array','_QS_interaction_fob_respawn','_QS_action_crate_customize','_QS_action_crate_customize_text',
	'_QS_action_crate_array','_QS_interaction_customizeCrate','_nearInvSite','_QS_module_fuelConsumption_factor_3',
	'_checkworldtime','_QS_action_names','_QS_cameraOn','_QS_clientRankManager','_QS_clientRankManager_delay',
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
	'_QS_interaction_loadCargo','_QS_action_loadCargo_vTypes','_QS_action_loadCargo_validated','_QS_action_loadCargo_vehicle','_thermalsEnabled',
	'_QS_modelInfoPlayer','_QS_rappelling','_QS_action_rappelSelf','_QS_action_rappelSelf_text','_QS_action_rappelSelf_array',
	'_QS_action_rappelAI','_QS_action_rappelAI_text','_QS_action_rappelAI_array','_QS_action_rappelDetach','_QS_action_rappelDetach_text','_QS_action_rappelDetach_array','_QS_interaction_rappelSelf',
	'_QS_interaction_rappelAI','_QS_interaction_rappelDetach','_commandingMenu','_kicked','_QS_module_opsec_memCheck_script','_QS_objectTypePlayer','_QS_action_sit_chairModels','_QS_action_rappelSafety',
	'_QS_action_rappelSafety_textDisable','_QS_action_rappelSafety_textEnable','_QS_action_rappelSafety_array','_QS_interaction_rappelSafety','_QS_arsenal_model','_QS_resolution','_QS_module_opsec_displays_default',
	'_QS_clientDLCs','_QS_module_opsec_return','_QS_module_opsec_checkMarkers','_QS_module_opsec_chatIntercept','_QS_module_opsec_chatIntercept_IDD','_QS_module_opsec_chatIntercept_IDC',
	'_QS_module_opsec_chatIntercept_script','_QS_module_opsec_chatIntercept_code','_allDisplays','_QS_module_opsec_displayIDDstr','_QS_module_opsec_iguiDisplays',
	'_QS_module_opsec_memArrayIGUI','_QS_module_opsec_iguiDisplays_delay','_QS_module_opsec_iguiDisplays_checkDelay',
	'_QS_module_opsec_memArrayMission','_QS_module_opsec_memArrayTitles','_QS_module_opsec_memArrayTitlesMission','_QS_module_opsec_rsctitles',
	'_QS_module_opsec_rsctitles_delay','_QS_module_opsec_rsctitles_checkDelay','_QS_module_opsec_rsctitlesMission_delay','_QS_module_opsec_rsctitlesMission_checkDelay','_QS_module_opsec_rsctitlesMission',
	'_QS_module_opsec_memArrayMission_delay','_QS_module_opsec_memArrayMission_checkDelay','_QS_module_opsec_memoryMission',
	'_QS_module_opsec_memCheck_WorkingArray','_QS_uiTime','_QS_isAdmin',
	'_QS_action_activateVehicle','_QS_action_activateVehicle_text','_QS_action_activateVehicle_array','_QS_interaction_activateVehicle','_QS_cursorIntersections',
	'_QS_action_unloadCargo','_QS_action_unloadCargo_text','_QS_action_unloadCargo_array','_QS_interaction_unloadCargo','_QS_action_unloadCargo_vTypes','_QS_action_unloadCargo_cargoTypes',
	'_QS_action_unloadCargo_validated','_QS_action_unloadCargo_vehicle','_nearUnloadCargoVehicles','_QS_interaction_load2','_object','_QS_action_huronContainer','_QS_action_huronContainer_text',
	'_QS_action_huronContainer_array','_QS_interaction_huronContainer','_QS_action_huronContainer_models','_QS_helmetCam_helperType','_QS_module_swayManager_heavyWeapons','_QS_module_swayManager_heavyWeaponCoef_crouch',
	'_QS_module_swayManager_heavyWeaponCoef_stand','_QS_customAimCoef','_QS_recoilCoef','_QS_module_swayManager_recoilCoef_crouch','_QS_module_swayManager_recoilCoef_stand','_QS_module_scAssistant',
	'_QS_module_scAssistant_delay','_QS_module_scAssistant_checkDelay','_sectorFlag','_sectorPhase','_QS_viewSettings_var','_QS_isTanoa','_QS_tanoa_delay','_QS_tanoa_checkDelay',
	'_QS_inGeorgetown','_QS_georgetown_polygon','_QS_georgetown_priorVD','_QS_georgetown_priorOVD','_QS_georgetown_VD','_QS_georgetown_OVD','_QS_laserTarget','_QS_miscDelay5','_backpackWhitelisted','_QS_buttonAction',
	'_QS_module_groupIndicator','_QS_module_groupIndicator_delay','_QS_module_groupIndicator_checkDelay','_QS_module_groupIndicator_radius','_QS_module_groupIndicator_units','_QS_module_groupIndicator_types',
	'_QS_module_groupIndicator_filter','_QS_action_sensorTarget','_QS_action_sensorTarget_array','_QS_interaction_sensorTarget','_QS_virtualSectors_data_public','_QS_toDelete',
	'_QS_module_fuelConsumption_vehicle',
	'_offroadTypes','_QS_action_examine','_QS_action_examine_text','_QS_action_examine_array','_QS_interaction_examine',
	'_QS_medicIcons_radius','_QS_medicIcons_delay','_QS_medicIcons_checkDelay','_QS_action_attachExp','_QS_action_attachExp_text','_QS_action_attachExp_array','_QS_interaction_attachExp','_QS_action_attachExp_textReal',
	'_QS_userActionText','_QS_action_stabilise','_QS_action_stabilise_text','_QS_action_stabilise_array','_QS_interaction_stabilise','_QS_cO','_QS_action_ugv_types',
	'_QS_ugv','_QS_action_ugv_stretcherModel','_QS_action_ugvLoad','_QS_action_ugvLoad_text','_QS_action_ugvLoad_array','_QS_interaction_ugvLoad','_QS_action_ugvUnload',
	'_QS_action_ugvUnload_text','_QS_action_ugvUnload_array','_QS_interaction_ugvUnload','_QS_uav','_QS_interaction_serviceDrone','_QS_interaction_towUGV','_QS_action_towUGV','_QS_ugvTow',
	'_QS_v2Type','_QS_v2TypeL','_QS_action_uavSelfDestruct','_QS_action_uavSelfDestruct_text','_QS_action_uavSelfDestruct_array','_QS_interaction_uavSelfDestruct','_QS_ugvSD',
	'_QS_action_carrierLaunch','_QS_action_carrierLaunch_text','_QS_action_carrierLaunch_array','_QS_interaction_carrierLaunch','_QS_carrier_cameraOn','_QS_carrier_inPolygon',
	'_QS_carrierPolygon','_QS_carrierLaunchData','_QS_carrierPos','_fn_data_carrierLaunch','_serverTime','_hintsQueue','_hintDelay','_hintCheckDelay','_hintActive','_hintActiveDuration',
	'_hintPriority','_hintUseSound','_hintDuration','_hintPreset','_hintText','_hintOtherData','_hintIrrelevantWhen','_hintTextPrevious','_hintPriorClosedAt','_true','_false','_enemysides',
	'_isAltis','_isTanoa','_QS_carrierEnabled','_array','_QS_action_camonetArmor','_QS_action_camonetArmor_textA','_QS_action_camonetArmor_textB','_QS_action_camonetArmor_array',
	'_QS_interaction_camonetArmor','_QS_action_camonetArmor_anims','_QS_action_camonetArmor_vAnims','_animationSources','_animationSource','_QS_module_highCommand','_QS_module_highCommand_delay',
	'_QS_module_highCommand_checkDelay','_QS_module_highCommand_waypoints','_civSide','_QS_module_gpsJammer','_QS_module_gpsJammer_delay','_QS_module_gpsJammer_checkDelay','_QS_module_gpsJammer_signalDelay',
	'_QS_module_gpsJammer_signalCheck','_QS_module_gpsJammer_ctrlPlayer','_isNearRepairDepot','_uavNearRepairDepot','_viewDistance_target','_objectViewDistance_target',
	'_shadowDistance_target','_terrainGrid_target','_deltaVD_script','_fadeView','_arsenalType','_noObjectParent','_parsedText','_QS_module_opsec_hints','_ahHintText','_ahHintList',
	'_QS_destroyerEnabled','_lifeState','_QS_action_RSS','_QS_action_RSS_text','_QS_action_RSS_array','_QS_interaction_RSS','_QS_module_swayManager_managed','_player'
];
disableSerialization;
_QS_productVersion = productVersion;
_QS_missionVersion = missionNamespace getVariable ['QS_system_devBuild_text',''];
_QS_resolution = getResolution;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_QS_clientDLCs = [(getDLCs 0),(getDLCs 1),(getDLCs 2)];
private _timeNow = time;
_serverTime = serverTime;
_QS_uiTime = diag_tickTime;
_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',player];
_QS_player = player;
private _unit1 = objNull;
_namePlayer = name player;
private _puid = getPlayerUID player;
private _actionIDs = actionIDs player;
_allPlayers = allPlayers;
_QS_clientOwner = clientOwner;
_roleSelectionSystem = missionNamespace getVariable ['QS_RSS_enabled',TRUE];
private _playerRole = player getVariable ['QS_unit_role','rifleman'];
private _roleDisplayName = ['GET_ROLE_DISPLAYNAME',_playerRole] call (missionNamespace getVariable ['QS_fnc_roles',{'Rifleman'}]);
private _roleDisplayNameL = toLower _roleDisplayName;
private _RSS_MenuButton = (missionNamespace getVariable ['QS_missionConfig_RSS_MenuButton',0]) isNotEqualTo 0;
_objectParent = objectParent player;
_QS_v2 = vehicle player;
_QS_v2Type = typeOf _QS_v2;
_QS_v2TypeL = toLowerANSI _QS_v2Type;
_QS_cameraOn = cameraOn;
_QS_cO = cameraOn;
private _QS_cOTypeL = '';
_QS_fpsLastPull = round diag_fps;
_profileName = profileName;
_profileNameSteam = profileNameSteam;
_playerNetId = netId player;
_QS_posWorldPlayer = getPosWorld player;
private _terrainGrid = getTerrainGrid;
private _QS_cameraPosition2D = [(positionCameraToWorld [0,0,0]) # 0,(positionCameraToWorld [0,0,0]) # 2];
_QS_moveTime = moveTime player;
_QS_objectTypePlayer = getObjectType player;
_QS_modelInfoPlayer = getModelInfo player;
_lifeState = lifeState player;
_west = WEST;
_QS_side = player getVariable ['QS_unit_side',_west];
_dNull = displayNull;
_objNull = objNull;
private _cameraView = cameraView;
_scriptNull = scriptNull;
private _genericResult = nil;
private _isMissionCursorObject = objNull;
_QS_nullPos = [0,0,0];
_QS_firstRun = TRUE;
_mainMenuIDD = 2000;
_mainMenuOpen = FALSE;
_viewMenuIDD = 3000;
_viewMenuOpen = FALSE;
_QS_module_49Opened = FALSE;
private _simulWeatherSync = scriptNull;
_QS_buttonAction = "call (missionNamespace getVariable 'QS_fnc_clientMenu2')";
_QS_buttonAction2 = "closeDialog 2; 0 spawn {uiSleep 0.1;createDialog 'QS_client_dialog_menu_roles';};";
_QS_fpsArray = [];
_QS_fpsAvgSamples = 60;
_QS_fpsDelay = 0.5;
_QS_fpsCheckDelay = _timeNow + _QS_fpsDelay;
_QS_terminalVelocity = [10e10,10e14,10e18];
_QS_isAdmin = _puid in (['ALL'] call (missionNamespace getVariable ['QS_fnc_whitelist',{[]}]));
_QS_helmetCam_helperType = 'sign_sphere10cm_f';
private _attachedObjects = attachedObjects player;
private _nearServices = [];
_true = TRUE;
_false = FALSE;
_parsedText = parseText '';
_enemysides = _QS_side call (missionNamespace getVariable 'QS_fnc_enemySides');
_civSide = CIVILIAN;
_isAltis = _QS_worldName isEqualTo 'Altis';
_isTanoa = _QS_worldName isEqualTo 'Tanoa';
private _plane1PV = missionNamespace getVariable ['QS_missionConfig_plane1PV',FALSE];
private _inSafezone = FALSE;
private _safezoneLevel = 0;
private _safezoneActive = FALSE;
private _inZone = FALSE;
private _nearCarriers = [];
private _currentWeapon = '';
private _weaponItems = [];
private _emitters = ['weaponlight_emitters_1'] call QS_data_listItems;
private _laserBatteryClasses = qs_core_classnames_laserbatteries;
private _recoveryVehicleTypes = ['crv',0] call QS_data_listVehicles;
private _allGroups = allGroups;

_fn_inString = missionNamespace getVariable 'QS_fnc_inString';
if (_QS_isAdmin) then {
	{
		_x setMarkerAlphaLocal 0.5;
	} forEach [
		'QS_marker_fpsMarker',
		'QS_marker_curators'
	];
	missionNamespace setVariable ['QS_armedAirEnabled',TRUE,FALSE];
};
missionNamespace setVariable ['QS_client_heartbeat',_timeNow,FALSE];

//===== UI FEEDBACK (screen effects on taking damage, fire damage, drowning, fatigue, etc)

0 spawn (missionNamespace getVariable 'QS_fnc_feedback');

/*/========================= View settings module/*/

_QS_module_viewSettings = TRUE;
_QS_RD_client_viewSettings_saveDelay = 600;
_QS_RD_client_viewSettings_saveCheckDelay = time + _QS_RD_client_viewSettings_saveDelay;
player setVariable ['QS_RD_client_viewSettings_currentMode',0,FALSE];
uiNamespace setVariable ['QS_RD_viewSettings_update',TRUE];
_deltaVD_script = scriptNull;
_fadeView = FALSE;
_QS_viewSettings_var = format ['QS_RD_client_viewSettings_%1',_QS_worldName];

if (missionProfileNamespace isNil _QS_viewSettings_var) then {
	_revalidate = TRUE;
} else {
	_QS_RD_client_viewSettings = missionProfileNamespace getVariable [_QS_viewSettings_var,[]];
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
	missionProfileNamespace setVariable [_QS_viewSettings_var,(player getVariable _QS_viewSettings_var)];
	saveMissionProfileNamespace;
} else {
	player setVariable [
		_QS_viewSettings_var,
		(missionProfileNamespace getVariable [_QS_viewSettings_var,[]]),
		FALSE
	];
};

/*/=========================== Action manager module/*/

player setVariable ['QS_RD_interacting',FALSE,TRUE];
uiNamespace setVariable ['QS_RD_canRespawnVehicle',-1];
private _extendedContext = FALSE;
_cursorTarget = cursorTarget;
_cursorObject = cursorObject;
_QS_nearEntities_revealDelay = 5;
_QS_nearEntities_revealCheckDelay = time + _QS_nearEntities_revealDelay;
_QS_entityTypes = ['CAManBase','LandVehicle','Air','Ship'];
_QS_entityRange = 5;
_QS_objectTypes = 'All';
_QS_objectRange = 4;
_noObjectParent = TRUE;
private _QS_medicCameraOn = objNull;
_QS_actions = [];
_QS_interaction_escort = FALSE;
_QS_action_escort = nil;
_QS_action_escort_text = localize 'STR_QS_Interact_003';
_QS_action_escort_array = [_QS_action_escort_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractEscort')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_load = FALSE;
_QS_action_load = nil;
_QS_action_load_text = localize 'STR_QS_Interact_004';
_QS_action_load_array = [_QS_action_load_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractLoad')},[],94,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _attachedLoadableObject = objNull;
private _attachedLoadableObjects = [];
private _QS_interaction_load2 = FALSE;
private _QS_action_load2_text = localize 'STR_QS_Interact_037';
private _QS_action_load2_array = [_QS_action_load2_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractLoadCargo')},[],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_action_load2 = nil;
_QS_interaction_unload = FALSE;
_QS_action_unload = nil;
_QS_action_unload_text = localize 'STR_QS_Interact_005';
_QS_action_unload_array = [_QS_action_unload_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnload')},[],-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_questionCivilian = FALSE;
_QS_action_questionCivilian = nil;
_QS_action_questionCivilian_text = localize 'STR_QS_Interact_006';
_QS_action_questionCivilian_array = [_QS_action_questionCivilian_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCivilian')},[],92,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_drag = FALSE;
_QS_action_drag = nil;
_QS_action_drag_text = localize 'STR_QS_Interact_001';
_QS_action_drag_array = [_QS_action_drag_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractDrag')},[],-9,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _maxDragVolume = 5;
_QS_interaction_carry = FALSE;
_QS_action_carry = nil;
_QS_action_carry_text = localize 'STR_QS_Interact_002';
_QS_action_carry_array = [_QS_action_carry_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCarry')},[],-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _maxCarryVolume = 5;
_QS_interaction_follow = FALSE;
_QS_action_follow = nil;
_QS_action_follow_text = localize 'STR_QS_Interact_007';
_QS_action_follow_array = [_QS_action_follow_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFollow')},[],89,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_recruit = FALSE;
_QS_action_recruit = nil;
_QS_action_recruit_text = localize 'STR_QS_Interact_008';
_QS_action_recruit_array = [_QS_action_recruit_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRecruit')},[],88,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_dismiss = FALSE;
_QS_action_dismiss = nil;
_QS_action_dismiss_text = localize 'STR_QS_Interact_009';
_QS_action_dismiss_array = [_QS_action_dismiss_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractDismiss')},[],-81,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_release = FALSE;
_QS_action_release = nil;
_QS_action_release_text = localize 'STR_QS_Interact_010';
_QS_action_release_array = [_QS_action_release_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRelease')},[],88,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_respawnVehicle = FALSE;
_QS_action_respawnVehicle = nil;
_QS_action_respawnVehicle_text = localize 'STR_QS_Interact_011';
_QS_action_respawnVehicle_array = [_QS_action_respawnVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRespawnVehicle')},[],-80,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_vehDoors = FALSE;				
_QS_action_vehDoors = nil;
_QS_action_vehDoors_textOpen = localize 'STR_QS_Interact_012';
_QS_action_vehDoors_textClose = localize 'STR_QS_Interact_013';
_QS_action_vehDoors_array = [_QS_action_vehDoors_textOpen,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractVehicleDoors')},[],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_action_vehDoors_vehicles = ['veh_doors_1'] call (missionNamespace getVariable 'QS_data_listVehicles');

private _QS_interaction_service2 = FALSE;
private _QS_action_service2 = nil;
private _QS_action_service2_text = localize 'STR_QS_Interact_014';
private _QS_action_service2_array = [_QS_action_service2_text,{_this spawn QS_fnc_clientInteractServiceVehicle},nil,55,FALSE,TRUE,'','TRUE'];

_QS_action_serviceVehicle = nil;
_QS_action_serviceVehicle_text = localize 'STR_QS_Interact_014';
_QS_action_serviceVehicle_array = [_QS_action_serviceVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractServiceVehicle')},[],-1,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_serviceVehicle = FALSE;
_isNearRepairDepot = FALSE;
_nearSite = FALSE;
_nearSite2 = FALSE;
/*/===== Hangar/*/
private _QS_action_pylons = nil;
private _QS_action_pylons_text = localize 'STR_QS_Dialogs_083';
private _QS_action_pylons_array = [_QS_action_pylons_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractHangar')},[],9,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_pylons = FALSE;
private _hangarData = call (missionNamespace getVariable 'QS_data_planeLoadouts');
private _validHangarTypes = _hangarData apply { toLowerANSI (_x # 0) };
private _QS_hangarCameraOn = objNull;
private _customPylonPresets = (missionNamespace getVariable ['QS_missionConfig_pylonPresets',0]) isEqualTo 1;
private _hasPylons = FALSE;
/*/===== Unflip Vehicle/*/
_QS_action_unflipVehicle = nil;
_QS_action_unflipVehicle_text = localize 'STR_QS_Interact_015';
_QS_action_unflipVehicle_array = [_QS_action_unflipVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnflipVehicle')},[],-50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_unflipVehicle = FALSE;
/*/===== Revive /*/
_QS_action_revive = nil;
_QS_action_revive_text = localize 'STR_QS_Interact_016';
_QS_action_revive_array = [_QS_action_revive_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRevive')},[],99,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_action_AIrevive_array = [_QS_action_revive_text,{_this spawn (missionNamespace getVariable 'QS_fnc_rcAIRevive')},[],99,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_revive = FALSE;
_QS_revive_injuredAnims = ['injured_anims_1'] call (missionNamespace getVariable 'QS_data_listOther');
_checkworldtime = time + 30 + (random 600);
/*/===== Stabilise/*/
_QS_action_stabilise = nil;
_QS_action_stabilise_text = localize 'STR_QS_Interact_017';
_QS_action_stabilise_array = [_QS_action_stabilise_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractStabilise')},nil,91,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_stabilise = FALSE;
/*/===== Arsenal/*/
_QS_action_arsenal = nil;
_QS_action_arsenal_text = localize 'STR_A3_Arsenal';
_QS_action_arsenal_array = [_QS_action_arsenal_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractArsenal')},[],90,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_arsenal = FALSE;
_QS_arsenal_model = ['arsenal_model_1'] call (missionNamespace getVariable 'QS_data_listOther');
/*/===== Arsenal (AI)/*/
private _QS_interaction_arsenalAI = FALSE;
private _QS_action_arsenalAI_array = [_QS_action_arsenal_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractArsenal')},[],90,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_action_arsenalAI = nil;
/*/===== Role Selection/*/
_QS_action_RSS = nil;
_QS_action_RSS_text = localize 'STR_QS_Interact_018';
_QS_action_RSS_array = [_QS_action_RSS_text,{closeDialog 2;uiSleep 0.1;createDialog 'QS_client_dialog_menu_roles';},[],89,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_RSS = FALSE;
/*/===== Deployment/*/
private _QS_interaction_deployment = FALSE;
private _QS_action_deployment = nil;
private _QS_action_deploymentText = localize 'STR_QS_Menu_199';
private _QS_action_deployment_array = [_QS_action_deploymentText,{['INTERACT'] call (missionNamespace getVariable 'QS_fnc_clientInteractDeploy')},[],88,TRUE,TRUE,'','TRUE',-1,FALSE,''];
/*/===== Vehicle Spawner/*/
private _QS_action_vehicleSpawner = nil;
private _QS_action_vehicleSpawner_text = localize 'STR_QS_Interact_149';
private _QS_action_vehicleSpawner_array = [_QS_action_vehicleSpawner_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSpawnAsset')},nil,49,FALSE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_vehicleSpawner = FALSE;
/*/===== Utility offroad/*/
_QS_action_utilityOffroad = nil;
_QS_action_utilityOffroad_textOn = localize 'STR_QS_Interact_019';
_QS_action_utilityOffroad_textOff = localize 'STR_QS_Interact_020';
_QS_action_utilityOffroad_array = [_QS_action_utilityOffroad_textOn,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUtilityOffroad')},[],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_utilityOffroad = FALSE;
_offroadTypes = ['offroad_types_1'] call (missionNamespace getVariable 'QS_data_listVehicles');
/*/===== Tow/*/
_QS_action_tow = nil;
_QS_action_tow_text = localize 'STR_QS_Interact_021';
_QS_action_tow_array = [_QS_action_tow_text,{_this spawn (missionNamespace getVariable 'QS_fnc_vTow')},[],-80,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_tow = FALSE;
/*/===== Pull/*/
private _QS_action_pull = nil;
_QS_action_pull_text = localize 'STR_QS_Interact_123';
_QS_action_pull_array = [_QS_action_pull_text,{['MODE10',cameraOn,FALSE] call QS_fnc_simplePull},nil,55,FALSE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_pull = FALSE;
private _pullingEnabled = missionNamespace getVariable ['QS_missionConfig_interactTowing',TRUE];
/*/===== Winch/*/
private _QS_action_winch = nil;
_QS_action_winch_text = localize 'STR_QS_Interact_124';
_QS_action_winch_array = [_QS_action_winch_text,{['MODE4'] spawn QS_fnc_simpleWinch},nil,-25,FALSE,TRUE,'','TRUE'];
private _QS_interaction_winch = FALSE;
private _winchEnabled = (missionNamespace getVariable ['QS_missionConfig_interactWinch',1]) isNotEqualTo 0;
/*/===== Rope Cut/*/
private _QS_action_ropeCut = nil;
_QS_action_ropecut_text = localize 'STR_QS_Interact_127';
_QS_action_ropecut_array = [_QS_action_ropecut_text,{['MODE12'] call QS_fnc_simplePull},nil,-60,FALSE,TRUE,'','TRUE'];
private _QS_interaction_ropecut = FALSE;
/*/===== Surrender/*/
_QS_action_commandSurrender = nil;
_QS_action_commandSurrender_text = localize 'STR_QS_Interact_022';
_QS_action_commandSurrender_array = [_QS_action_commandSurrender_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSurrender')},[],90,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_commandSurrender = FALSE;
/*/===== Rescue/*/
_QS_action_rescue = nil;
_QS_action_rescue_text = localize 'STR_QS_Interact_023';
_QS_action_rescue_array = [_QS_action_rescue_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRescue')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_rescue = FALSE;
/*/===== Secure/*/
_QS_action_secure = nil;
_QS_action_secure_text = localize 'STR_QS_Interact_024';
_QS_action_secure_array = [_QS_action_secure_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSecure')},[],95,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_secure = FALSE;
/*/===== Examine/*/
_QS_action_examine = nil;
_QS_action_examine_text = localize 'STR_QS_Interact_025';
_QS_action_examine_array = [_QS_action_examine_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractExamine')},[],94,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_examine = FALSE;
/*/===== Turret safety/*/
_QS_action_turretSafety = nil;
_QS_action_turretSafety_text = localize 'STR_QS_Interact_026';
_QS_action_turretSafety_array = [_QS_action_turretSafety_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractTurretControl')},[],-50,FALSE,FALSE,'','TRUE',-1,FALSE,''];
_QS_interaction_turretSafety = FALSE;
missionNamespace setVariable ['QS_inturretloop',FALSE,FALSE];
_QS_turretSafety_heliTypes = ['turret_safety_1'] call (missionNamespace getVariable 'QS_data_listVehicles');
/*/===== Teeth collector/*/
_QS_action_teeth = nil;
_QS_action_teeth_text = localize 'STR_QS_Interact_027';
_QS_action_teeth_array = [_QS_action_teeth_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractTooth')},[],-52,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_teeth = FALSE;
/*/===== Commander Beret collector/*/
private _QS_action_beret = nil;
private _QS_action_beret_text = localize 'STR_QS_Interact_028';
private _QS_action_beret_array = [_QS_action_beret_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractBeret')},[],-51,TRUE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_beret = FALSE;
/*/===== Join group/*/
_QS_action_joinGroup = nil;
_QS_action_joinGroup_text = localize 'STR_QS_Interact_029';
_QS_action_joinGroup_array = [_QS_action_joinGroup_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractJoinGroup')},[],-50,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_joinGroup = FALSE;
_QS_joinGroup_privateVar = 'BIS_dg_pri';
_grpTarget = grpNull;
private _groupLocking = missionNamespace getVariable ['QS_missionConfig_groupLocking',TRUE];
/*/===== Fob status terminal/*/
_QS_action_fob_terminals = [];
_QS_action_fob_status = nil;
_QS_action_fob_status_text = localize 'STR_QS_Interact_030';
_QS_action_fob_status_array = [_QS_action_fob_status_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},1,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_status = FALSE;
/*/===== Activate FOB/*/
_QS_action_names = worldName;
_QS_action_fob_activate = nil;
_QS_action_fob_activate_text = localize 'STR_QS_Interact_031';
_QS_action_fob_activate_array = [_QS_action_fob_activate_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},2,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_activate = FALSE;
/*/===== Enable FOB Respawn/*/
_QS_action_fob_respawn = nil;
_QS_action_fob_respawn_text = localize 'STR_QS_Interact_032';
_QS_action_fob_respawn_array = [_QS_action_fob_respawn_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractFOBTerminal')},3,25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_fob_respawn = FALSE;
/*/===== Crate Customization/*/
_QS_action_crate_customize = nil;
_QS_action_crate_customize_text = localize 'STR_QS_Interact_033';
_QS_action_crate_array = [_QS_action_crate_customize_text,{['init',(_this # 3)] call (missionNamespace getVariable 'QS_fnc_clientMenuLoadout')},[],-1,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_customizeCrate = FALSE;
_nearInvSite = FALSE;
/*/===== Push Vehicle/*/
_QS_action_pushVehicle = nil;
_QS_action_pushVehicle_text = localize 'STR_QS_Interact_034';
_QS_action_pushVehicle_array = [_QS_action_pushVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractPush')},[],25,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_pushVehicle = FALSE;
/*/===== Mortar Lite/*/
private _QS_action_mortarLite = nil;
private _QS_action_mortarLite_text = localize 'STR_QS_Interact_119';
private _QS_action_mortarLite_array = [_QS_action_mortarLite_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractMortarLite')},[],-50,FALSE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_mortarLite = FALSE;
private _mortarTubeBackpacks = ['mortar_tubes_1'] call QS_data_listItems;
/*/===== Create Boat/*/
_QS_action_createBoat = nil;
_QS_action_createBoat_text = localize 'STR_QS_Interact_035';
_QS_action_createBoat_array = [_QS_action_createBoat_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCreateBoat')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_createBoat = FALSE;
/*/===== Recover Boat (boat rack)/*/
_QS_action_recoverBoat = nil;
_QS_action_recoverBoat_text = localize 'STR_A3_action_Recover_Boat';
_QS_action_recoverBoat_array = [_QS_action_recoverBoat_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRecoverBoat')},[],25,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_recoverBoat = FALSE;
/*/===== Sit/*/
_QS_action_sit = nil;
_QS_action_sit_text = localize 'STR_QS_Interact_036';
_QS_action_sit_array = [_QS_action_sit_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSit')},1,50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_sit = FALSE;
_QS_action_sit_chairTypes = ['chair_1'] call QS_data_listVehicles;
_QS_action_sit_chairModels = ['chair_2'] call QS_data_listVehicles;
/*/===== Load Cargo/*/
_QS_action_loadCargo = nil;
_QS_action_loadCargo_text = localize 'STR_QS_Interact_037';
_QS_action_loadCargo_array = [_QS_action_loadCargo_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractLoadCargo')},[],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_loadCargo = FALSE;
_QS_action_loadCargo_vTypes = ['load_cargo_1'] call QS_data_listVehicles;
_QS_action_loadCargo_validated = FALSE;
_QS_action_loadCargo_vehicle = objNull;
private _QS_action_loadCargo_vehicles = [];
_nearCargoVehicles = [];
/*/===== Unload Cargo/*/
_QS_action_unloadCargo = nil;
_QS_action_unloadCargo_text = localize 'STR_QS_Interact_038';
_QS_action_unloadCargo_array = [_QS_action_unloadCargo_text,{[cursorObject] call (missionNamespace getVariable 'QS_fnc_clientInteractUnloadCargo')},[],-30,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_unloadCargo = FALSE;
_QS_action_unloadCargo_vTypes = [];
_QS_action_unloadCargo_cargoTypes = [];
_QS_action_unloadCargo_validated = FALSE;
_QS_action_unloadCargo_vehicle = objNull;
_nearUnloadCargoVehicles = [];
/*/===== Forklift/*/
private _QS_action_forklift = nil;
private _QS_interaction_forklift = FALSE;
private _QS_action_forklift_text = localize 'STR_QS_Interact_131';
private _QS_action_forklift_array = [_QS_action_forklift_text,{_this spawn QS_fnc_clientInteractLift},[],-5,TRUE,TRUE,'','TRUE'];
/*/===== Interact Activate Vehicle/*/
_QS_action_activateVehicle = nil;
_QS_action_activateVehicle_text = localize 'STR_QS_Interact_039';
_QS_action_activateVehicle_array = [_QS_action_activateVehicle_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractActivateVehicle')},nil,49,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_activateVehicle = FALSE;
/*/===== Interact Pack Vehicle/*/
private _QS_interaction_packV = FALSE;
private _QS_action_packV = nil;
private _QS_action_packV_texts = [localize 'STR_QS_Interact_145',localize 'STR_QS_Interact_146'];
private _QS_action_packV_array = [_QS_action_packV_texts # 0,{_this spawn QS_fnc_clientInteractPackEntity},nil,-50,FALSE,TRUE,'','TRUE',-1,FALSE,''];
/*/===== Interact Pack Wreck/*/
private _QS_action_packWreck = nil;
private _QS_action_packWreck_text = localize 'STR_QS_Interact_145';
private _QS_action_packWreck_array = [_QS_action_packWreck_text,{_this spawn QS_fnc_clientInteractPackWreck},nil,61,FALSE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_packWreck = FALSE;
/*/===== Huron Medical Container (Simple Object)/*/
_QS_action_huronContainer = nil;
_QS_action_huronContainer_text = localize 'STR_QS_Interact_040';
_QS_action_huronContainer_array = [_QS_action_huronContainer_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractMedStation')},nil,48,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_huronContainer = FALSE;
_QS_action_medevac_models = call (compileScript ['code\config\QS_data_medevacAssets.sqf']);
/*/===== Sensor Target/*/
_QS_action_sensorTarget = nil;
private _sensorTarget_text_1 = localize 'STR_QS_Interact_041';
private _sensorTarget_text_2 = localize 'STR_QS_Interact_060';
_QS_action_sensorTarget_array = [_sensorTarget_text_1,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSensorTarget')},nil,60,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_sensorTarget = FALSE;
/*/===== Attach Explosive (underwater)/*/
_QS_action_attachExp = nil;
_QS_action_attachExp_text = localize 'STR_QS_Interact_042';
_QS_action_attachExp_textReal = '';
_QS_action_attachExp_array = [_QS_action_attachExp_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUnderwaterDemo')},nil,59,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_attachExp = FALSE;
/*/===== Cruise control/*/
private _QS_interaction_cc = FALSE;
private _QS_action_cc = nil;
private _ccTextDefault = localize 'STR_QS_Interact_043';
private _ccTextConvoy = localize 'STR_QS_Interact_121';
private _ccText = _ccTextDefault;
private _QS_action_cc_array = [_ccText,{[cameraOn] call (missionNamespace getVariable 'QS_fnc_setCruiseControl')},[],-50,FALSE,FALSE,'','TRUE',-1,FALSE,''];
/*/===== UGV/*/
_QS_action_ugv_types = ['ugv_types_1'] call QS_data_listVehicles;
//===== Parachute
private _QS_interaction_para = FALSE;
private _QS_action_para = nil;
private _QS_action_para_text = localize 'STR_QS_Interact_044';
private _QS_action_para_array = [_QS_action_para_text,{_this call (missionNamespace getVariable 'QS_fnc_clientInteractOpenParachute')},[],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
//===== Para Cut
private _QS_interaction_paracut = FALSE;
private _QS_action_paracut = nil;
private _QS_action_paracut_text = localize 'STR_QS_Interact_118';
private _QS_action_paracut_array = [_QS_action_paracut_text,{_this call (missionNamespace getVariable 'QS_fnc_clientInteractCutParachute')},[],49,FALSE,TRUE,'','TRUE',-1,FALSE,''];
//===== Wreck Recovery
private _QS_interaction_recoverWreck = FALSE;
private _QS_action_recoverWreck = nil;
private _QS_action_recoverWreck_text = localize 'STR_QS_Interact_132';
private _QS_action_recoverWreck_array = [_QS_action_recoverWreck_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRecoverWreck')},nil,15,TRUE,TRUE,'','TRUE'];
//===== Drone stuff
private _uavEntity = objNull;
_QS_uav = objNull;
_QS_ugv = objNull;
_QS_ugvTow = objNull;
_QS_action_ugv_stretcherModel = ['ugv_stretcher_1'] call QS_data_listOther;
_QS_action_ugvLoad = nil;
_QS_action_ugvLoad_text = localize 'STR_QS_Interact_004';
_QS_action_ugvLoad_array = [_QS_action_ugvLoad_text,{(_this # 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,4],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_ugvLoad = FALSE;
_QS_action_ugvUnload = nil;
_QS_action_ugvUnload_text = localize 'STR_QS_Interact_005';
_QS_action_ugvUnload_array = [_QS_action_ugvUnload_text,{(_this # 3) spawn (missionNamespace getVariable 'QS_fnc_clientInteractUGV');},[_QS_ugv,5],50,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_ugvUnload = FALSE;
_QS_interaction_serviceDrone = FALSE;
_QS_interaction_towUGV = FALSE;
_QS_action_towUGV = nil;
_QS_action_uavSelfDestruct = nil;
_QS_action_uavSelfDestruct_text = localize 'STR_QS_Interact_045';
_QS_action_uavSelfDestruct_array = [_QS_action_uavSelfDestruct_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractUAVSelfDestruct')},nil,-20,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_uavSelfDestruct = FALSE;
_QS_ugvSD = objNull;
/*/===== Carrier Launch/*/
_QS_action_carrierLaunch = nil;
_QS_action_carrierLaunch_text = localize 'STR_QS_Interact_046';
_QS_action_carrierLaunch_array = [_QS_action_carrierLaunch_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCarrierLaunch')},nil,85,TRUE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_carrierLaunch = FALSE;
_QS_carrier_cameraOn = objNull;
_QS_carrier_inPolygon = FALSE;
_QS_carrierPolygon = [];
_QS_carrierLaunchData = [];
_QS_carrierPos = [0,0,0];
_QS_carrierEnabled = missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0];
_QS_destroyerEnabled = missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0];
/*/===== Destroyer hangar/*/
private _QS_interaction_destroyerHeli = FALSE;
private _QS_action_destroyerHeli = nil;
private _QS_action_destroyerHeli_textLaunch = localize 'STR_QS_Interact_047';
private _QS_action_destroyerHeli_textRetract = localize 'STR_QS_Interact_048';
private _QS_action_destroyerHeli_array = [
	[_QS_action_destroyerHeli_textRetract,_QS_action_destroyerHeli_textLaunch] select (!isNull ((missionNamespace getVariable ['QS_destroyerObject',objNull]) getVariable ['QS_destroyer_hangarHeli',objNull])),
	{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractDestroyerHeliLaunch')},nil,100,TRUE,TRUE,'','TRUE',1.5,FALSE,'','pos_door_hangar_1_trigger'
];
/*/===== Armor Camonets/*/
_QS_action_camonetArmor = nil;
_QS_action_camonetArmor_textA = localize 'STR_QS_Interact_049';
_QS_action_camonetArmor_textB = localize 'STR_QS_Interact_050';
_QS_action_camonetArmor_array = [_QS_action_camonetArmor_textA,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractCamoNet')},[objNull,0],-10,FALSE,TRUE,'','TRUE',-1,FALSE,''];
_QS_interaction_camonetArmor = FALSE;
_QS_action_camonetArmor_anims = ['camonet_anims_1'] call QS_data_listOther;
_QS_action_camonetArmor_vAnims = [];
/*/===== Armor Slat/*/
private _QS_action_slatArmor = nil;
private _QS_action_slatArmor_textA = localize 'STR_QS_Interact_051';
private _QS_action_slatArmor_textB = localize 'STR_QS_Interact_052';
private _QS_action_slatArmor_array = [_QS_action_slatArmor_textA,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractSlatArmor')},[objNull,0],9,FALSE,TRUE,'','TRUE',-1,FALSE,''];
private _QS_interaction_slatArmor = FALSE;
private _QS_action_slatArmor_anims = ['slatarmor_anims_1'] call QS_data_listOther;
private _QS_action_slatArmor_vAnims = [];
private _animationSources = [];
private _animationSource = configNull;
/*/===== Advanced Rappelling/*/
_QS_rappelling = TRUE;
if (_QS_rappelling) then {
	_QS_action_rappelSelf = nil;
	_QS_action_rappelSelf_text = localize 'STR_QS_Interact_053';
	_QS_action_rappelSelf_array = [_QS_action_rappelSelf_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},1,-10,TRUE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelSelf = FALSE;
	_QS_action_rappelAI = nil;
	_QS_action_rappelAI_text = localize 'STR_QS_Interact_054';
	_QS_action_rappelAI_array = [_QS_action_rappelAI_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},2,-11,FALSE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelAI = FALSE;
	_QS_action_rappelDetach = nil;
	_QS_action_rappelDetach_text = localize 'STR_QS_Interact_055';
	_QS_action_rappelDetach_array = [_QS_action_rappelDetach_text,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},3,48,TRUE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelDetach = FALSE;
	_QS_action_rappelSafety = nil;
	_QS_action_rappelSafety_textDisable = localize 'STR_QS_Interact_056';
	_QS_action_rappelSafety_textEnable = localize 'STR_QS_Interact_057';
	_QS_action_rappelSafety_array = [_QS_action_rappelSafety_textDisable,{_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractRappel')},4,-12,FALSE,TRUE,'','TRUE',-1,FALSE,''];
	_QS_interaction_rappelSafety = FALSE;
};

private _localProps = QS_list_playerBuildables select {local _x};
private _listPropNearUnits = [];
private _localProp = objNull;

/*/============================ Live feed module/*/
private _QS_module_liveFeed = TRUE;
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
		localize 'STR_QS_Interact_095',
		{
			if (isPipEnabled) then {
				player setVariable ['QS_RD_client_liveFeed',TRUE,FALSE];
				50 cutText [localize 'STR_QS_Text_027','PLAIN DOWN',0.5];
			} else {
				50 cutText [localize 'STR_QS_Text_028','PLAIN DOWN',0.5];
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
	_QS_liveFeed_display setUserActionText [_QS_liveFeed_action_1,localize 'STR_QS_Interact_095',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_095'])];
	_QS_liveFeed_action_2 = _QS_liveFeed_display addAction [
		localize 'STR_QS_Interact_096',
		{
			player setVariable ['QS_RD_client_liveFeed',FALSE,FALSE];
			50 cutText [localize 'STR_QS_Text_029','PLAIN DOWN',0.5];
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
	_QS_liveFeed_display setUserActionText [_QS_liveFeed_action_2,localize 'STR_QS_Interact_096',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_096'])];
};

/*/======================= Vehicle manifest module/*/
_QS_module_crewIndicator = TRUE;
if (_QS_module_crewIndicator) then {
	_QS_module_crewIndicator_delay = 0.666;
	_QS_module_crewIndicator_checkDelay = time + _QS_module_crewIndicator_delay;
	_QS_crewIndicatorIDD = 6000;
	_QS_crewIndicatorIDC = 1001;
	_QS_crewIndicator = controlNull;
	_QS_crewIndicator_imgDriver = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_driver_ca.paa';
	_QS_crewIndicator_imgGunner = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_gunner_ca.paa';
	_QS_crewIndicator_imgCommander = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_commander_ca.paa';
	_QS_crewIndicator_imgCargo = str '\a3\ui_f\data\IGUI\RscIngameUI\RscUnitInfo\role_cargo_ca.paa';
	_QS_crewIndicator_imgSize = 0.55;
	_QS_crewIndicator_color = [(missionProfileNamespace getVariable ['GUI_BCG_RGB_R',0.3843]),(missionProfileNamespace getVariable ['GUI_BCG_RGB_G',0.7019]),(missionProfileNamespace getVariable ['GUI_BCG_RGB_B',0.8862]),(missionProfileNamespace getVariable ['GUI_BCG_RGB_A',0.7])];
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
_QS_module_fuelConsumption_factor_1 = 0.99750; 				// Normal												/*/0.99833;/*/
_QS_module_fuelConsumption_factor_2 = 0.99800;				// When parked, not moving								/*/0.99900;/*/
_QS_module_fuelConsumption_factor_3 = 0.99550;				// When sling loading or carrying another vehicle		/*/0.99775; 0.99700; 0.99600;/*/
private _QS_module_fuelConsumption_factor_4 = 0.99650;		// When in high gear 0.99700;
_QS_module_fuelConsumption_vehicle = objNull;
_QS_module_fuelConsumption_factor = 1;
_QS_module_fuelConsumption_rpm = 0;
_QS_module_fuelConsumption_rpmIdle = 0;
_QS_module_fuelConsumption_rpmRed = 0;
_QS_module_fuelConsumption_rpmDiff = 0;
_QS_module_fuelConsumption_rpmFactor = 0;
_QS_module_fuelConsumption_useRPMFactor = FALSE;
private _thrust = 0;
private _fuelConversion = 0;
private _QS_module_fuelConsumption_lower = 0;
private _QS_module_fuelConsumption_upper = 0;

/*/===================== Vehicle services (Vanilla rearm, repair, refuel)/*/
private _QS_module_services = TRUE;
private _QS_module_services_delay = 1;
private _QS_module_services_checkDelay = -1;
private _QS_module_services_asset = objNull;
private _QS_module_services_radius = 15;
private _QS_module_services_available = [];
missionNamespace setVariable ['QS_module_services_script',scriptNull,FALSE];
/*/===================== Gear manager module/*/
_QS_module_gearManager = TRUE && ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isNotEqualTo 3);
_arsenalType = missionNamespace getVariable ['QS_missionConfig_Arsenal',1];
missionNamespace setVariable ['QS_client_arsenalData',([(player getVariable ['QS_unit_side',WEST]),(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_data_arsenal')),FALSE];
_QS_module_gearManager_delay = 3;
_QS_module_gearManager_checkDelay = time + _QS_module_gearManager_delay;
_playerThreshold = 0;
if (!isNull (missionNamespace getVariable ['QS_airdefense_laptop',objNull])) then {
	_airDefenseLaptop = missionNamespace getVariable ['QS_airdefense_laptop',objNull];
	if (_airDefenseLaptop isEqualType objNull) then {
		if (!isNull _airDefenseLaptop) then {
			_QS_airbaseDefense_action_1 = _airDefenseLaptop addAction [
				localize 'STR_QS_Interact_097',
				{
					if (missionNamespace getVariable ['QS_airbaseDefense',FALSE]) exitWith {
						50 cutText [localize 'STR_QS_Text_030','PLAIN DOWN',0.5];
					};
					missionNamespace setVariable ['QS_airbaseDefense',TRUE,TRUE];
					player playAction 'PutDown';
					playSound ['Click',FALSE];
					50 cutText [localize 'STR_QS_Text_031','PLAIN DOWN',0.5];
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
			_airDefenseLaptop setUserActionText [_QS_airbaseDefense_action_1,localize 'STR_QS_Interact_097',(format ["<t size='3'>%1</t>",localize 'STR_QS_Interact_097'])];
		};
	};
};
/*/============= CLIENT RATING MANAGER/*/
_QS_clientRatingManager = TRUE;
_QS_clientRatingManager_delay = _timeNow + 5;
player addRating (0 - (rating player));
/*/============= CLIENT RANK MANAGER /*/
_QS_clientRankManager = TRUE;
_QS_clientRankManager_delay = _timeNow + 10;
player setRank 'PRIVATE';
/*/============= CLIENT GROUP MANAGER/*/

private _groupCleanup = TRUE;
private _groupCleanupDelay = 60;
private _groupCleanupCheckDelay = -1;



_QS_clientDynamicGroups = TRUE;
private _QS_groupWaypoint = missionNamespace getVariable ['QS_missionConfig_groupWaypoint',FALSE];
_QS_clientDynamicGroups_delay = 10;
_QS_clientDynamicGroups_checkDelay = _timeNow + _QS_clientDynamicGroups_delay;
_QS_playerGroup = group player;
_QS_clientDynamicGroups_testGrp = grpNull;
private _isLeader = FALSE;
private _squadName = '';
if ((squadParams player) isNotEqualTo []) then {
	_squadName = ((squadParams player) # 0) # 5;
};
private _radioBags = qs_core_classnames_radiobags;
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
_pilotCheck = missionNamespace getVariable ['QS_missionConfig_roleRestrictionHeli',FALSE];
_iAmPilot = FALSE;
_pilotAtBase = TRUE;
_difficultyEnabledRTD = difficultyEnabledRTD;
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
private _crvs = ['crv'] call (missionNamespace getVariable 'QS_data_listVehicles');
private _craterDecals = ['crater_decals_1'] call QS_data_listOther;
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
if (player isNil 'QS_ClientUTexture2') then {
	player setVariable ['QS_ClientUTexture2','',FALSE];
};
if (player isNil 'QS_ClientUTexture2_Uniforms2') then {
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
	(
		(((player distance2D _atcMarkerPos) < 12) && (((getPosATL player) # 2) > 5) && (isNull (objectParent player))) ||
		(((player distance2D _tocMarkerPos) < 10) &&(((getPosATL player) # 2) < 7) && (isNull (objectParent player)))
	)
};
_atcMarkerPos = markerPos ['QS_marker_base_atc',TRUE];
_tocMarkerPos = markerPos ['QS_marker_base_toc',TRUE];
/*/===== Weapon Sway module/*/
_QS_module_swayManager = TRUE;
_QS_module_swayManager_delay = 0.25;
_QS_module_swayManager_checkDelay = _timeNow + _QS_module_swayManager_delay;
_QS_module_swayManager_secWepSwayCoef = 2.5;
_QS_module_swayManager_heavyWeapons = call (compileScript ['code\config\QS_data_heavyWeapons.sqf']);
_QS_module_swayManager_heavyWeaponCoef_crouch = 1.4;
_QS_module_swayManager_heavyWeaponCoef_stand = 1.7;
_QS_module_swayManager_recoilCoef_crouch = 1.4;
_QS_module_swayManager_recoilCoef_stand = 1.7;
_QS_customAimCoef = getCustomAimCoef player;
_QS_recoilCoef = unitRecoilCoefficient player;
private _QS_module_swayManager_managed = FALSE;
_QS_recommendedAimCoef = ((_QS_player getVariable ['QS_stamina',[0,1]]) # 1);
_QS_recommendedRecoil = 1;
/*/===== Task Manager module/*/
_QS_module_taskManager = TRUE;
_QS_module_taskManager_delay = 15;
_QS_module_taskManager_checkDelay = -1;
_QS_module_taskManager_simpleTasks = [];
_QS_module_taskManager_currentTask = taskNull;
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
_QS_module_groupIndicator_radius = 50;
_QS_module_groupIndicator_types = ['CAManBase','LandVehicle','Ship','Air','StaticWeapon'];
_QS_module_groupIndicator_units = [];
_QS_module_groupIndicator_filter = {
	if (_x isKindOf 'CAManBase') then {
		if (
			((_x getVariable ['QS_unit_face','']) isNotEqualTo '') &&
			{((toLowerANSI (face _x)) isNotEqualTo (toLowerANSI (_x getVariable ['QS_unit_face',''])))}
		) then {
			if (!dialog) then {
				_x setFace (_x getVariable ['QS_unit_face','']);
			};
		};
		((side (group _x)) isEqualTo (QS_player getVariable ['QS_unit_side',WEST]))
	} else {
		((alive (effectiveCommander _x)) && {((side (group (effectiveCommander _x))) isEqualTo (QS_player getVariable ['QS_unit_side',WEST]))})
	};
};
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
_QS_module_gpsJammer_delay = 1;
_QS_module_gpsJammer_checkDelay = _QS_uiTime + _QS_module_gpsJammer_delay;
_QS_module_gpsJammer_signalDelay = 10;
_QS_module_gpsJammer_signalCheck = _QS_uiTime + _QS_module_gpsJammer_signalDelay;
_QS_module_gpsJammer_ctrlPlayer = (findDisplay 12) displayCtrl 1202;
missionNamespace setVariable ['QS_module_gpsJammer_inArea',FALSE,FALSE];
/*/===== Operational Security Module/*/
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
				50 cutText [(format [localize 'STR_QS_Text_002',(count _chatText),_maxCharacters]),'PLAIN DOWN',1];
				((findDisplay 24) displayCtrl 101) ctrlSetText (_chatText select [0,140]);
			};
			if ([_chatTextLower,0,_fn_inString] call (missionNamespace getVariable 'QS_fnc_ahScanString')) then {
				//comment 'Blacklisted string in chat';
				if (!isNull (findDisplay 24)) then {
					(findDisplay 24) closeDisplay 2;
				};
			};
			if ((QS_player getSlotItemName 611) isEqualTo '') then {
				if (currentChannel isNotEqualTo 5) then {
					50 cutText [localize 'STR_QS_Text_003','PLAIN DOWN',1];
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
		_patchList = (call (missionNamespace getVariable 'QS_data_patches')) apply { (toLowerANSI _x) };
		_binConfigPatches = configFile >> 'CfgPatches';
		private _patchConfigName = '';
		for '_i' from 0 to ((count _binConfigPatches) - 1) step 1 do {
			_patchEntry = _binConfigPatches select _i;
			if (isClass _patchEntry) then {
				_patchConfigName = toLowerANSI (configName _patchEntry);
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
		if (!((toLowerANSI (configName _child)) in _allowedChildren)) exitWith {
			_QS_module_opsec_detected = 1;
			_detected = configName _child;
		};
	} forEach _children;
	_allowedChildren = nil;
	_children = nil;
	if ((toLowerANSI (getText (configFile >> 'CfgFunctions' >> 'init'))) isNotEqualTo 'a3\functions_f\initfunctions.sqf') then {
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
		if (!((missionProfileNamespace getVariable [_x,0]) isEqualType 0)) then {
			missionProfileNamespace setVariable [_x,0.4];
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
_baseMarkers = ['markers_base_hide_1'] call QS_data_listOther;
/*/========== UI loading/*/
{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"]//,
	//['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	//['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];
0 spawn {
	scriptName 'QS - Add KeyDown Event';
	if !(missionNamespace isNil 'QS_uiEvent_magRepack') then {
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
			if (isNull (getAssignedCuratorLogic player)) exitWith {systemChat (localize 'STR_QS_Chat_087');};
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

//===== Player respawn position
_respawnScript = [-1] spawn (missionNamespace getVariable 'QS_fnc_clientRespawnPosition');
waitUntil {scriptDone _respawnScript};

/*/===== Ramp up view distance/*/
[(((player getVariable _QS_viewSettings_var) # 1) # 0),getPosATL player,_QS_viewSettings_var] spawn {
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
	player switchMove [''];
	if (missionNamespace getVariable ['QS_missionConfig_splash',TRUE]) then {
		createDialog 'QS_RD_client_dialog_menu_entry';
	};
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
// This fixes an Arma bug related to spawning of Destroyer ship boat racks.
// "BIS_fnc_BoatRack01InitAdjustZOffsets" gets stuck in an infinite waitUntil loop.
if (('land_destroyer_01_boat_rack_01_f' allObjects 1) isNotEqualTo []) then {
	0 spawn {
		sleep 1;
		private _simDisabled = ('land_destroyer_01_boat_rack_01_f' allObjects 1) select {!simulationEnabled _x};
		{
			_x enableSimulation TRUE;
			sleep 3;	// enough time for animations to complete
			_x enableSimulation FALSE;
		} forEach _simDisabled;
		_simDisabled = nil;
	};
};
/*/===== Managed Hints/*/
_hintsQueue = [];
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
/*/===== Object Scale Module/*/
private _QS_module_objectScale = TRUE;
private _QS_module_objectScale_delay = 7;
private _QS_module_objectScale_checkDelay = -1;
private _QS_module_objectScale_array = [];
private _QS_module_objectScale_obj = objNull;
private _QS_module_objectScale_scale = 1;
/*/===== Roles module/*/
private _QS_module_roleAssignment = TRUE;
private _QS_module_roleAssignment_updateDelay = -1;
private _QS_display1Opened = FALSE;
private _QS_display2Opened = FALSE;
private _display1_drawID = 0;
private _weaponIsSniper = FALSE;

private _healHandlers = [];

// Logging
private _debugLogging = TRUE;
private _debugLogging_interval = 60;
private _debugLogging_delay = -1;

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
_fn_isNearServiceCargo = missionNamespace getVariable 'QS_fnc_isNearServiceCargo';
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
_fn_dataSniperRifles = call (missionNamespace getVariable 'QS_data_sniperRifles');
_fn_clientVehicleService = missionNamespace getVariable 'QS_fnc_clientVehicleService';
_fn_simplePull = missionNamespace getVariable 'QS_fnc_simplePull';
_fn_simpleWinch = missionNamespace getVariable 'QS_fnc_simpleWinch';
_fn_isBusyAttached = missionNamespace getVariable 'QS_fnc_isBusyAttached';
_fn_inZone = missionNamespace getVariable 'QS_fnc_inZone';
_fn_zoneManager = missionNamespace getVariable 'QS_fnc_zoneManager';
_fn_getFrontObject = missionNamespace getVariable 'QS_fnc_getFrontObject';
_fn_updateCenterOfMass = missionNamespace getVariable 'QS_fnc_updateCenterOfMass';
_fn_updateMass = missionNamespace getVariable 'QS_fnc_updateMass';
_fn_canRecover = missionNamespace getVariable 'QS_fnc_canRecover';
_fn_canVehicleCargo = missionNamespace getVariable 'QS_fnc_canVehicleCargo';
_fn_getObjectVolume = missionNamespace getVariable 'QS_fnc_getObjectVolume';
_fn_eventAttach = missionNamespace getVariable 'QS_fnc_eventAttach';

/*/================================================================================================================= LOOP/*/

for '_z' from 0 to 1 step 0 do {
	_QS_uiTime = diag_tickTime;
	_timeNow = time;
	_cameraView = cameraView;
	if (_QS_uiTime > _QS_miscDelay1) then {
		_QS_miscDelay1 = _QS_uiTime + 0.5;
		_serverTime = serverTime;
		if (_QS_player isNotEqualTo player) then {
			_QS_player = player;
		};
		QS_player = missionNamespace getVariable ['BIS_fnc_moduleRemoteControl_unit',_QS_player];
		_QS_posWorldPlayer = getPosWorld _QS_player;
		_posATLPlayer = getPosATL _QS_player;
		if (_QS_cO isNotEqualTo cameraOn) then {
			_QS_cO = cameraOn;
			_QS_cOTypeL = toLowerANSI (typeOf _QS_cO);
			if (_QS_cO isKindOf 'Air') then {
				_hasPylons = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_pylons_isclass',_QS_cOTypeL],
					{isClass ((configOf _QS_cO) >> 'Components' >> 'TransportPylonsComponent')},
					_true
				];
			} else {
				_hasPylons = _false;
			};
		};
		if (_QS_v2 isNotEqualTo (vehicle _QS_player)) then {
			_QS_v2 = vehicle _QS_player;
			_QS_v2Type = typeOf _QS_v2;
			_QS_v2TypeL = toLowerANSI _QS_v2Type;
		};
		if (_objectParent isNotEqualTo (objectParent _QS_player)) then {
			_objectParent = objectParent _QS_player;
		};
		_lifeState = lifeState _QS_player;
		missionNamespace setVariable ['QS_client_heartbeat',_timeNow,_false];
		if (missionNamespace getVariable ['QS_client_sendAccuracy',_false]) then {
			missionNamespace setVariable ['QS_client_sendAccuracy',_false,_false];
			_weaponIsSniper = (toLowerANSI (primaryWeapon _QS_player)) in _fn_dataSniperRifles;
			[
				102,
				([0,1] select _weaponIsSniper),
				player,
				[
					player getVariable (['QS_client_hits','QS_client_hits_sniper'] select _weaponIsSniper),
					player getVariable (['QS_client_shots','QS_client_shots_sniper'] select _weaponIsSniper)
				]
			] remoteExec ['QS_fnc_remoteExec',2,_false];
			{
				_QS_player setVariable _x;
			} forEach [
				['QS_client_hits',0,_false],
				['QS_client_shots',0,_false],
				['QS_client_hits_sniper',0,_false],
				['QS_client_shots_sniper',0,_false]
			];
		};
		missionNamespace setVariable ['QS_client_assignedItems_lower',((assignedItems _QS_player) apply {toLowerANSI _x}),_false];
		_inZone = [QS_player,'SAFE'] call _fn_inZone;
		_inSafezone = _inZone # 0;
		_safezoneLevel = _inZone # 1;
		_safezoneActive = _inZone # 2;
		QS_player setVariable ['QS_inzone',_inZone,FALSE];
		//([QS_player,'SAFE'] call _fn_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
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
				((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetToolTip (localize 'STR_QS_Menu_001');
				((findDisplay _mainMenuIDD) displayCtrl 1001) ctrlSetText format ['%3 %1 | %4 %2h',_QS_fpsLastPull,([(0 max (estimatedEndServerTime - _serverTime) min 36000),'HH:MM'] call _fn_secondsToString),localize 'STR_QS_Menu_002',localize 'STR_QS_Menu_003'];
				((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetToolTip (localize 'STR_QS_Menu_004');
				((findDisplay _mainMenuIDD) displayCtrl 1002) ctrlSetText format ['%5 %1 | %6 %2 | %7 %3 | %8 %4/100',(score _QS_player),(rating _QS_player),_QS_clientHp,_QS_clientMass,localize 'STR_QS_Menu_005',localize 'STR_QS_Menu_006',localize 'STR_QS_Menu_007',localize 'STR_QS_Menu_008'];
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
				((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetToolTip (localize 'STR_QS_Menu_001');
				((findDisplay _viewMenuIDD) displayCtrl 1001) ctrlSetText format ['%3 %1 | %4 %2h',_QS_fpsLastPull,([(0 max (estimatedEndServerTime - _serverTime) min 36000),'HH:MM'] call _fn_secondsToString),localize 'STR_QS_Menu_002',localize 'STR_QS_Menu_003'];
			};
		};
	};
	if (!(_QS_display1Opened)) then {
		if (!isNull ((findDisplay 160) displayCtrl 51)) then {
			_QS_display1Opened = _true;
			_display1_drawID = ((findDisplay 160) displayCtrl 51) ctrlAddEventHandler ['Draw',(format ['call %1',_fn_mapDraw])];
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
			_display1_drawID = ((findDisplay -1) displayCtrl 500) ctrlAddEventHandler ['Draw',(format ['call %1',_fn_mapDraw])];
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
						_QS_liveFeed_vehicle = missionNamespace getVariable ['QS_RD_liveFeed_vehicle',_objNull];
						if (
							(_QS_liveFeed_vehicle isEqualType _objNull) &&
							{(alive _QS_liveFeed_vehicle)} &&
							{((_QS_player distance2D _QS_liveFeed_display) < 30)}
						) then {
							if (_QS_liveFeed_vehicle isNotEqualTo _QS_liveFeed_vehicle_current) then {
								_QS_liveFeed_vehicle_current = _QS_liveFeed_vehicle;
								[1,_QS_liveFeed_camera,[(missionNamespace getVariable 'QS_RD_liveFeed_neck'),([[2,-4,2],[0.25,-0.10,0.05]] select (_QS_liveFeed_vehicle isKindOf 'CAManBase'))]] call _fn_eventAttach;
								_QS_liveFeed_camera cameraEffect ['Internal','Back','qs_rd_lfe'];
								_QS_liveFeed_camera camSetTarget (missionNamespace getVariable 'QS_RD_liveFeed_target');
								_QS_liveFeed_display setObjectTexture [0,'#(argb,512,512,1)r2t(qs_rd_lfe,1)'];
								'qs_rd_lfe' setPiPEffect [[0,1] select (([0,0,0] getEnvSoundController 'night') isEqualTo 1)];
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
			if ((cameraOn isNotEqualTo _QS_cameraOn) || {(uiNamespace getVariable ['QS_RD_viewSettings_update',_false])}) then {
				if (uiNamespace getVariable ['QS_RD_viewSettings_update',_false]) then {
					uiNamespace setVariable ['QS_RD_viewSettings_update',_false];
				};
				_fadeView = cameraOn isNotEqualTo _QS_cameraOn;
				_QS_cameraOn = cameraOn;
				if !(_QS_player isNil _QS_viewSettings_var) then {
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
						if (
							(_QS_cameraOn isKindOf 'CAManBase') &&
							{(((getPos _QS_cameraOn) # 2) < 10)} &&
							{isNull curatorCamera}
						) then {
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
							if (
								((_QS_cameraOn isKindOf 'LandVehicle') || {(_QS_cameraOn isKindOf 'Ship')}) &&
								{isNull curatorCamera}
							) then {
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
								if ((_QS_cameraOn isKindOf 'Helicopter') && {isNull curatorCamera}) then {
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
									if ((_QS_cameraOn isKindOf 'Plane') || {!isNull curatorCamera}) then {
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
			_actionIDs = actionIDs _QS_player;
			_cursorTarget = cursorTarget;
			_cursorDistance = _QS_player distance _cursorTarget;
			getCursorObjectParams params ['_cursorObject','','_cursorObjectDistance'];
			_attachedObjects = (attachedObjects _QS_player) select {!isObjectHidden _x};
			if (isNull _cursorObject) then {
				_cursorObject = cursorObject;
			};
			_isMissionCursorObject = if (isNull _cursorObject) then {_false} else {((getObjectType _cursorObject) isEqualTo 8)};
			_noObjectParent = isNull _objectParent;
			_extendedContext = missionNamespace getVariable ['QS_menu_extendedContext',_false];
			
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
					player setUserActionText [_QS_action_escort,_QS_action_escort_text,(format ["<t size='3'>%1</t>",_QS_action_escort_text])];
				};
			} else {
				if (_QS_interaction_escort) then {
					_QS_interaction_escort = _false;
					player removeAction _QS_action_escort;
				};
			};

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
					_QS_medicCameraOn setUserActionText [_QS_action_revive,_QS_action_revive_text,(format ["<t size='3'>%1</t>",_QS_action_revive_text])];
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
				{((_attachedObjects findIf {(_x isKindOf 'CAManBase')}) isEqualTo -1)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(alive _cursorTarget)} &&
				{(_cursorTarget getVariable ['QS_interact_stabilise',_false])} &&
				{(!(_cursorTarget getVariable ['QS_interact_stabilised',_true]))}
			) then {
				if (!(_QS_interaction_stabilise)) then {
					_QS_interaction_stabilise = _true;
					_QS_action_stabilise = player addAction _QS_action_stabilise_array;
					player setUserActionText [_QS_action_stabilise,_QS_action_stabilise_text,(format ["<t size='3'>%1</t>",_QS_action_stabilise_text])];
				};
			} else {
				if (_QS_interaction_stabilise) then {
					_QS_interaction_stabilise = _false;
					player removeAction _QS_action_stabilise;
				};
			};
						
			/*/===== Action Load (Unit to vehicle)/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorTarget)} &&
				{(_cursorObjectDistance <= 3)} &&
				{((['LandVehicle','Air','Ship'] findIf { _cursorTarget isKindOf _x }) isNotEqualTo -1)} &&
				{((_attachedObjects findIf {(_x isKindOf 'CAManBase')}) isNotEqualTo -1)} &&
				{(!(_cursorTarget getVariable ['QS_logistics_wreck',_false]))} &&
				{((locked _cursorTarget) in [-1,0,1])} &&
				{(((_cursorTarget emptyPositions 'Cargo') > 0) || {((unitIsUav _cursorTarget) && (([_cursorTarget,1] call _fn_clientInteractUGV) > 0))})}
			) then {
				{
					if (
						(alive _x) &&
						{(_x isKindOf 'CAManBase')}
					) then {
						if (!(_QS_interaction_load)) then {
							_QS_interaction_load = _true;
							_QS_action_load = player addAction _QS_action_load_array;
							player setUserActionText [_QS_action_load,_QS_action_load_text,(format ["<t size='3'>%1</t>",_QS_action_load_text])];
						};
					};
				} forEach _attachedObjects;
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
				{(_cursorObjectDistance <= 3)} &&
				{((['LandVehicle','Air','Ship'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
				{((((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1) || ((unitIsUav _cursorObject) && ([_cursorObject,0] call _fn_clientInteractUGV) && (((attachedObjects _cursorObject) findIf {((_x isKindOf 'CAManBase') && (alive _x))}) isNotEqualTo -1)))} &&
				{((((crew _cursorObject) findIf {(_x getVariable ['QS_RD_loaded',_false])}) isNotEqualTo -1) || {(((attachedObjects _cursorObject) findIf {((_x isKindOf 'CAManBase') && (alive _x) && (_x getVariable ['QS_RD_loaded',_false]))}) isNotEqualTo -1)})}
			) then {
				{
					if (!(_QS_interaction_unload)) then {
						if ((_x getVariable ['QS_RD_loaded',_false]) || {((lifeState _x) isEqualTo 'INCAPACITATED')}) then {
							if (alive _x) then {
								_QS_interaction_unload = _true;
								_QS_action_unload = player addAction _QS_action_unload_array;
								player setUserActionText [_QS_action_unload,_QS_action_unload_text,(format ["<t size='3'>%1</t>",_QS_action_unload_text])];
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
				(_noObjectParent) &&
				{(alive _cursorTarget)} &&
				{(_cursorDistance < 10)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{((side _cursorTarget) isEqualTo _civSide)} &&
				{(_cursorTarget getVariable ['QS_civilian_interactable',_false])}
			) then {
				if (!(_QS_interaction_questionCivilian)) then {
					_QS_interaction_questionCivilian = _true;
					_QS_action_questionCivilian = player addAction _QS_action_questionCivilian_array;
					player setUserActionText [_QS_action_questionCivilian,_QS_action_questionCivilian_text,(format ["<t size='3'>%1</t>",_QS_action_questionCivilian_text])];
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
				{(alive _cursorTarget)} &&
				{((_cursorDistance < 2) || (_cursorObjectDistance < 2))} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(isNull (ropeAttachedTo _cursorTarget))} &&
				{
					(_cursorTarget isKindOf 'CAManBase') || 
					{(([_cursorTarget] call _fn_getObjectVolume) < _maxDragVolume)} ||
					{(_cursorTarget getVariable ['QS_logistics_draggable',_false])}
				} &&
				{(!(_cursorTarget getVariable ['QS_logistics_dragDisabled',_false]))} &&
				{(!(_cursorTarget getVariable ['QS_logistics_immovable',_false]))} &&
				{(!(_QS_player call _fn_isBusyAttached))}
			) then {
				if (_cursorTarget isKindOf 'CAManBase') then {
					if (((lifeState _cursorTarget) isEqualTo 'INCAPACITATED') && {((isNull (attachedTo _cursorTarget)) && (isNull (objectParent _cursorTarget)))}) then {
						if (!(_QS_interaction_drag)) then {
							_QS_interaction_drag = _true;
							_QS_action_drag = player addAction _QS_action_drag_array;
							player setUserActionText [_QS_action_drag,_QS_action_drag_text,(format ["<t size='3'>%1</t>",_QS_action_drag_text])];
						};
					} else {
						if (_QS_interaction_drag) then {
							_QS_interaction_drag = _false;
							player removeAction _QS_action_drag;
						};
					};
				} else {
					if (
						([0,_cursorTarget,_objNull] call _fn_getCustomCargoParams) || 
						{(_cursorTarget getVariable ['QS_RD_draggable',_false])}
					) then {
						if (!(_QS_interaction_drag)) then {
							_QS_interaction_drag = _true;
							_QS_action_drag = player addAction _QS_action_drag_array;
							player setUserActionText [_QS_action_drag,_QS_action_drag_text,(format ["<t size='3'>%1</t>",_QS_action_drag_text])];
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
				{((_cursorDistance < 2) || (_cursorObjectDistance < 2))} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(isNull (objectParent _cursorTarget))} &&
				{(!(_QS_player call _fn_isBusyAttached))}
			) then {
				if (_cursorTarget isKindOf 'CAManBase') then {
					if ((alive _cursorTarget) && {((lifeState _cursorTarget) isEqualTo 'INCAPACITATED')}) then {
						if (!(_QS_interaction_carry)) then {
							_QS_interaction_carry = _true;
							_QS_action_carry = player addAction _QS_action_carry_array;
							player setUserActionText [_QS_action_carry,_QS_action_carry_text,(format ["<t size='3'>%1</t>",_QS_action_carry_text])];
						};
					} else {
						if (_QS_interaction_carry) then {
							_QS_interaction_carry = _false;
							player removeAction _QS_action_carry;
						};
					};
				} else {
					if (
						([0,_cursorTarget,_objNull] call _fn_getCustomCargoParams) && 
						{([4,_cursorTarget,_QS_v2] call _fn_getCustomCargoParams)} &&
						{(!(_cursorTarget getVariable ['QS_logistics_immovable',_false]))} &&
						{
							(
								(([_cursorTarget] call _fn_getObjectVolume) < _maxCarryVolume) ||
								((['StaticWeapon'] findIf { _cursorTarget isKindOf _x }) isNotEqualTo -1)
							)
						}
					) then {
						if (!(_QS_interaction_carry)) then {
							_QS_interaction_carry = _true;
							_QS_action_carry = player addAction _QS_action_carry_array;
							player setUserActionText [_QS_action_carry,_QS_action_carry_text,(format ["<t size='3'>%1</t>",_QS_action_carry_text])];
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
				{(alive _cursorTarget)} &&
				{(_cursorDistance < 3)} &&
				{((_cursorTarget isKindOf 'CAManBase') || (unitIsUav _cursorTarget))} &&
				{(_cursorTarget isNotEqualTo _QS_player)} &&
				{(!isNull (group _cursorTarget))} &&
				{((lifeState _cursorTarget) in ['HEALTHY','INJURED',''])} &&
				{(_QS_player isEqualTo (leader (group _QS_player)))} &&
				{((group _cursorTarget) isNotEqualTo (group _QS_player))} &&
				{((side (group _cursorTarget)) isEqualTo (side (group _QS_player)))} &&
				{(_cursorTarget getVariable ['QS_RD_recruitable',_false])} &&
				{(isNull (attachedTo _cursorTarget))}
			) then {
				if (!(_QS_interaction_recruit)) then {
					_QS_interaction_recruit = _true;
					_QS_action_recruit = player addAction _QS_action_recruit_array;
					player setUserActionText [_QS_action_recruit,_QS_action_recruit_text,(format ["<t size='3'>%1</t>",_QS_action_recruit_text])];
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
				{(alive _cursorTarget)} &&
				{(_cursorDistance < 3.5)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(_cursorTarget isNotEqualTo _QS_player)} &&
				{(_QS_player isEqualTo (leader (group _QS_player)))} &&
				{((group _cursorTarget) isEqualTo (group _QS_player))} &&
				{(_cursorTarget getVariable ['QS_RD_dismissable',_false])}
			) then {
				if (!(_QS_interaction_dismiss)) then {
					_QS_interaction_dismiss = _true;
					_QS_action_dismiss = player addAction _QS_action_dismiss_array;
					player setUserActionText [_QS_action_dismiss,_QS_action_dismiss_text,(format ["<t size='3'>%1</t>",_QS_action_dismiss_text])];
				};
			} else {
				if (_QS_interaction_dismiss) then {
					_QS_interaction_dismiss = _false;
					player removeAction _QS_action_dismiss;
				};
			};
			
			/*/===== Action Respawn Vehicle/*/
			
			if (
				_extendedContext &&
				{_noObjectParent} &&
				{(alive _cursorObject)} &&
				{(local _cursorObject)} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(_cursorObjectDistance <= 2)} &&
				{((['LandVehicle','Air','Ship'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
				{(_QS_uiTime > (uiNamespace getVariable ['QS_RD_canRespawnVehicle',-1]))} &&
				{(_cursorObject getVariable ['QS_RD_vehicleRespawnable',_false])} &&
				{(!(_cursorObject getVariable ['QS_disableRespawnAction',_false]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))} &&
				{(!(_cursorObject getVariable ['QS_lockedInventory',_false]))} &&
				{(!lockedDriver _cursorObject)} &&
				{((crew _cursorObject) isEqualTo [])}
			) then {
				if (!(_QS_interaction_respawnVehicle)) then {
					_QS_interaction_respawnVehicle = _true;
					_QS_action_respawnVehicle = player addAction _QS_action_respawnVehicle_array;
					player setUserActionText [_QS_action_respawnVehicle,_QS_action_respawnVehicle_text,(format ["<t size='3'>%1</t>",_QS_action_respawnVehicle_text])];
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
					player setUserActionText [_QS_action_vehDoors,_QS_action_vehDoors_array # 0,(format ["<t size='3'>%1</t>",(_QS_action_vehDoors_array # 0)])];
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
			
			/*/===== Service/*/
			
			if (
				_noObjectParent &&
				{(alive _cursorObject)} &&
				{(_cursorObjectDistance < 10)} &&
				{((_QS_player distance _cursorObject) < 50)} &&		// 2/07/2023 Temporary bug fix line
				{(simulationEnabled _cursorObject)} &&
				{((['Air','LandVehicle','Ship','StaticWeapon','Reammobox_F','ThingX'] findIf {(_cursorObject isKindOf _x)}) isNotEqualTo -1)} &&
				{(((vectorMagnitude (velocity _cursorObject)) * 3.6) < 1)} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))} &&
				{((isTouchingGround _cursorObject) || (_cursorObject isKindOf 'Ship'))} &&
				{((((getPosASL _cursorObject) # 2) > -1) || (_cursorObject isKindOf 'Ship'))} &&
				{(isNull curatorCamera)} &&
				{(
					(([_cursorObject,sizeOf (typeOf _cursorObject)] call _fn_isNearServiceCargo) isNotEqualTo []) ||
					{((_QS_carrierEnabled isNotEqualTo 0) && {(['INPOLYGON',_cursorObject] call _fn_carrier)})} || 
					{((_QS_destroyerEnabled isNotEqualTo 0) && {(['INPOLYGON',_cursorObject] call _fn_destroyer)})}
				)} &&
				{(scriptDone (missionNamespace getVariable ['QS_module_services_script',_scriptNull]))} &&
				{(!(localNamespace getVariable ['QS_service_blocked',_false]))}
			) then {
				if (!_QS_interaction_service2) then {
					_QS_interaction_service2 = _true;
					_QS_action_service2_array set [2,[_cursorObject]];
					_QS_action_service2 = player addAction _QS_action_service2_array;
					player setUserActionText [_QS_action_service2,_QS_action_service2_text,(format ["<t size='3'>%1</t>",_QS_action_service2_text])];
				};
			} else {
				if (_QS_interaction_service2) then {
					_QS_interaction_service2 = _false;
					player removeAction _QS_action_service2;
				};
			};
			
			/*/===== Hangar/*/
			
			if (
				(_hasPylons) &&
				{(alive _QS_cO)} &&
				{(local _QS_cO)} &&
				{(!(_QS_cO isKindOf 'CAManBase'))} &&
				{((((toLowerANSI (typeOf _QS_cO)) in _validHangarTypes) && _customPylonPresets) || (!(_customPylonPresets)))} &&
				{(!(missionNamespace getVariable ['QS_repairing_vehicle',_false]))} &&
				{(!(_QS_cO getVariable ['QS_logistics_wreck',_false]))} &&
				{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)}
			) then {
				_isNearRepairDepot = (([_QS_cO] call _fn_isNearRepairDepot) || {([_cursorObject] call _fn_isNearRepairDepot)});
				_nearSite = _false;
				{
					if ((_QS_cO distance2D (markerPos _x)) < 15) exitWith {
						_nearSite = _true;
					};
				} count ((missionNamespace getVariable 'QS_veh_repair_mkrs') + ['QS_marker_casJet_spawn']);			
				if (
					_nearSite || 
					{(_isNearRepairDepot)} || 
					{((_QS_carrierEnabled isNotEqualTo 0) && {(['INPOLYGON',_QS_cO] call _fn_carrier)})} || 
					{((_QS_destroyerEnabled isNotEqualTo 0) && {(['INPOLYGON',_QS_cO] call _fn_destroyer)})}
				) then {
					if (!(_QS_interaction_pylons)) then {
						if (_QS_hangarCameraOn isNotEqualTo _QS_cO) then {
							_QS_hangarCameraOn = _QS_cO;
						};
						_QS_interaction_pylons = _true;
						if ((['INPOLYGON',_QS_cO] call _fn_carrier) || {(['INPOLYGON',_QS_cO] call _fn_destroyer)}) then {
							_QS_action_pylons_array set [3,-1];
						} else {
							_QS_action_pylons_array set [3,9];
						};
						_QS_action_pylons = _QS_hangarCameraOn addAction _QS_action_pylons_array;
						_QS_hangarCameraOn setUserActionText [_QS_action_pylons,_QS_action_pylons_text,(format ["<t size='3'>%1</t>",_QS_action_pylons_text])];
					};
				} else {
					if (_QS_interaction_pylons) then {
						_QS_interaction_pylons = _false;
						_QS_hangarCameraOn removeAction _QS_action_pylons;
					};
				};
			} else {
				if (_QS_interaction_pylons) then {
					_QS_interaction_pylons = _false;
					_QS_hangarCameraOn removeAction _QS_action_pylons;
				};
			};

			/*/===== Unflip vehicle/*/
			
			if (
				(alive _cursorObject) &&
				{_isMissionCursorObject} &&
				{((['LandVehicle','StaticWeapon','Reammobox_F','Ship','Cargo_base_F']findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
				{(((_cursorObjectDistance <= 2) && (_cursorObject isEqualTo _cursorTarget)) || {(((toLowerANSI _QS_v2Type) in _recoveryVehicleTypes) && (_cursorObjectDistance <= 15))})} &&
				{(_cursorObject getEntityInfo 6)}
			) then {
				if (!(_QS_interaction_unflipVehicle)) then {
					_QS_interaction_unflipVehicle = _true;
					_QS_action_unflipVehicle = player addAction _QS_action_unflipVehicle_array;
					player setUserActionText [_QS_action_unflipVehicle,_QS_action_unflipVehicle_text,(format ["<t size='3'>%1</t>",_QS_action_unflipVehicle_text])];
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
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 20)} &&
				{(((((getModelInfo _cursorObject) # 1) in _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorTarget getVariable ['QS_arsenal_object',_false])})} &&
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_arsenal)) then {
					_QS_interaction_arsenal = _true;
					_QS_action_arsenal_array set [2,_QS_player];
					_QS_action_arsenal = player addAction _QS_action_arsenal_array;
					player setUserActionText [_QS_action_arsenal,_QS_action_arsenal_text,(format ["<t size='3'>%1</t>",_QS_action_arsenal_text])];
				};
			} else {
				if (_QS_interaction_arsenal) then {
					_QS_interaction_arsenal = _false;
					player removeAction _QS_action_arsenal;
				};
			};
			
			/*/===== Arsenal (AI)/*/
			if (
				(_noObjectParent) &&
				{(alive _cursorTarget)} &&
				{_isMissionCursorObject} &&
				{(_cursorDistance < 6)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(_cursorTarget isNotEqualTo _QS_player)} &&
				{(_QS_player isEqualTo (leader (group _QS_player)))} &&
				{((group _cursorTarget) isEqualTo (group _QS_player))} &&
				{(_cursorTarget getVariable ['QS_RD_dismissable',_false])} &&
				{((_cursorTarget distance2D (_cursorTarget getVariable ['QS_RD_spawnPos',[0,0,0]])) < 100)} &&
				{(((vectorMagnitude (velocity _cursorTarget)) * 3.6) < 1)} &&
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_arsenalAI)) then {
					_QS_interaction_arsenalAI = _true;
					_QS_action_arsenalAI_array set [2,_cursorTarget];
					_QS_action_arsenalAI = player addAction _QS_action_arsenalAI_array;
					player setUserActionText [_QS_action_arsenalAI,_QS_action_arsenal_text,(format ["<t size='3'>%1</t>",_QS_action_arsenal_text])];
				};
			} else {
				if (_QS_interaction_arsenalAI) then {
					_QS_interaction_arsenalAI = _false;
					player removeAction _QS_action_arsenalAI;
				};
			};
			
			/*/===== Action Role Selection + Deployment/*/
			
			if (
				(_noObjectParent) &&
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 20)} &&
				{(((((getModelInfo _cursorObject) # 1) in _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorObject getVariable ['QS_arsenal_object',_false])})} &&
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_RSS)) then {
					_QS_interaction_RSS = _true;
					_QS_action_RSS = player addAction _QS_action_RSS_array;
					player setUserActionText [_QS_action_RSS,_QS_action_RSS_text,(format ["<t size='3'>%1</t>",_QS_action_RSS_text])];
				};
				if (
					(missionNamespace getVariable ['QS_system_deploymentEnabled',_true]) &&
					{(((((getModelInfo _cursorObject) # 1) in _QS_arsenal_model) && (!(simulationEnabled _cursorObject))) || {(_cursorObject getVariable ['QS_deployment_object',_false])})}
				) then {
					if (!(_QS_interaction_deployment)) then {
						_QS_interaction_deployment = _true;
						_QS_action_deployment = player addAction _QS_action_deployment_array;
						player setUserActionText [_QS_action_deployment,_QS_action_deploymentText,(format ["<t size='3'>%1</t>",_QS_action_deploymentText])];
					};
				};
			} else {
				if (_QS_interaction_RSS) then {
					_QS_interaction_RSS = _false;
					player removeAction _QS_action_RSS;
				};
				if (_QS_interaction_deployment) then {
					_QS_interaction_deployment = _false;
					player removeAction _QS_action_deployment;
				};
			};
			
			/*/===== Vehicle Spawner/*/
			if (
				(_noObjectParent) &&
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 15)} &&
				{(!isNull (_cursorObject getVariable ['QS_vehicleSpawnPad',_objNull]))} &&
				{(((vectorMagnitude (velocity _cursorObject)) * 3.6) < 1)}
			) then {
				if (!(_QS_interaction_vehicleSpawner)) then {
					_QS_interaction_vehicleSpawner = _true;
					_QS_action_vehicleSpawner = player addAction _QS_action_vehicleSpawner_array;
					player setUserActionText [_QS_action_vehicleSpawner,_QS_action_vehicleSpawner_text,(format ["<t size='3'>%1</t>",_QS_action_vehicleSpawner_text])];
				};
			} else {
				if (_QS_interaction_vehicleSpawner) then {
					_QS_interaction_vehicleSpawner = _false;
					player removeAction _QS_action_vehicleSpawner;
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
				{(ropeAttachEnabled _QS_v2)} &&
				{(vehicleCargoEnabled _QS_v2)} &&
				{(!unitIsUav _QS_v2)} &&
				{([_QS_v2] call _fn_vTowable)}
			) then {
				if ((!(_QS_interaction_tow)) && (!(_QS_interaction_towUGV))) then {
					_QS_interaction_tow = _true;
					_QS_action_tow = player addAction _QS_action_tow_array;
					player setUserActionText [_QS_action_tow,_QS_action_tow_text,(format ["<t size='3'>%1</t>",_QS_action_tow_text])];
				};
			} else {
				if (_QS_interaction_tow) then {
					_QS_interaction_tow = _false;
					player removeAction _QS_action_tow;
				};
			};
			
			/*/===== Action Pull/*/
			
			if (
				(!(_noObjectParent)) &&
				{['MODE8'] call _fn_simplePull} && 
				{_pullingEnabled}
			) then {
				if (!(_QS_interaction_pull)) then {
					_QS_interaction_pull = _true;
					_QS_action_pull = player addAction _QS_action_pull_array;
					player setUserActionText [_QS_action_pull,_QS_action_pull_text,(format ["<t size='3'>%1</t>",_QS_action_pull_text])];
				};
			} else {
				if (_QS_interaction_pull) then {
					_QS_interaction_pull = _false;
					player removeAction _QS_action_pull;
				};
			};
			
			/*/===== Action Winch/*/
			
			if (
				_noObjectParent &&
				{_isMissionCursorObject} &&
				//{((currentWeapon _QS_player) isEqualTo '')} &&
				{['MODE5',_QS_player] call _fn_simpleWinch} &&
				{_winchEnabled}
			) then {
				if (!(_QS_interaction_winch)) then {
					_QS_interaction_winch = _true;
					_QS_action_winch = player addAction _QS_action_winch_array;
					player setUserActionText [_QS_action_winch,_QS_action_winch_text,(format ["<t size='3'>%1</t>",_QS_action_winch_text])];
				};
			} else {
				if (_QS_interaction_winch) then {
					_QS_interaction_winch = _false;
					player removeAction _QS_action_winch;
				};
			};
			
			/*/===== Action Cut Rope/*/
			
			if (
				_noObjectParent &&
				{_isMissionCursorObject} &&
				//{((currentWeapon _QS_player) isEqualTo '')} &&
				{['MODE11',_QS_player] call _fn_simplePull}
			) then {
				if (!(_QS_interaction_ropecut)) then {
					_QS_interaction_ropecut = _true;
					_QS_action_ropeCut = player addAction _QS_action_ropecut_array;
					player setUserActionText [_QS_action_ropeCut,_QS_action_ropecut_text,(format ["<t size='3'>%1</t>",_QS_action_ropecut_text])];
				};
			} else {
				if (_QS_interaction_ropecut) then {
					_QS_interaction_ropecut = _false;
					player removeAction _QS_action_ropeCut;
				};
			};

			/*/===== Wreck Recovery/*/
			if (
				_noObjectParent &&
				{(alive _cursorObject)} &&
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 8)} &&
				{(_cursorObject getVariable ['QS_logistics_wreck',_false])} &&
				{([_cursorObject] call _fn_canRecover)}
			) then {
				if (!(_QS_interaction_recoverWreck)) then {
					_QS_interaction_recoverWreck = _true;
					_QS_action_recoverWreck = player addAction _QS_action_recoverWreck_array;
					player setUserActionText [_QS_action_recoverWreck,_QS_action_recoverWreck_text,(format ["<t size='3'>%1</t>",_QS_action_recoverWreck_text])];
				};
			} else {
				if (_QS_interaction_recoverWreck) then {
					_QS_interaction_recoverWreck = _false;
					player removeAction _QS_action_recoverWreck;
				};
			};
			
			/*/===== Interact Pack Vehicle/*/

			if (
				_extendedContext &&
				{_noObjectParent} &&
				{(alive _cursorObject)} &&
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 15)} &&
				{simulationEnabled _cursorObject} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{(((crew _cursorObject) findIf {(alive _x)}) isEqualTo -1)} &&
				{((getVehicleCargo _cursorObject) isEqualTo [])} &&
				{((ropes _cursorObject) isEqualTo [])} &&
				{!(uiNamespace getVariable ['QS_client_progressVisualization_active',_false])} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))} &&
				{(
					(
						(_cursorObject getVariable ['QS_logistics_packable',_false]) && 
						{(!(_cursorObject getVariable ['QS_logistics_packed',_false]))} && 
						{(!(_cursorObject getVariable ['QS_logistics_deployed',_false]))} &&
						{(!(lockedInventory _cursorObject))}
					) ||
					{(
						(_cursorObject getVariable ['QS_logistics_isCargoParent',_false]) &&
						{(!isNull (_cursorObject getVariable ['QS_logistics_cargoChild',_objNull]))}
					)}
				)}
			) then {
				if (!(_QS_interaction_packV)) then {
					_QS_interaction_packV = _true;
					_QS_action_packV_array set [0,(_QS_action_packV_texts select (_cursorObject getVariable ['QS_logistics_isCargoParent',_false]))];
					_QS_action_packV = player addAction _QS_action_packV_array;
					player setUserActionText [_QS_action_packV,_QS_action_packV_array # 0,(format ["<t size='3'>%1</t>",_QS_action_packV_array # 0])];
				};
			} else {
				if (_QS_interaction_packV) then {
					_QS_interaction_packV = _false;
					player removeAction _QS_action_packV;
				};
			};
			
			/*/===== Interact Pack Wreck/*/

			if (
				_extendedContext &&
				{_noObjectParent} &&
				{(alive _cursorObject)} &&
				{_isMissionCursorObject} &&
				{(_cursorObjectDistance < 8)} &&
				{(_cursorObject getVariable ['QS_logistics_wreck',_false])} &&
				{(!(_cursorObject getVariable ['QS_logistics_packable',_false]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_isCargoParent',_false]))}
			) then {
				if (!(_QS_interaction_packWreck)) then {
					_QS_interaction_packWreck = _true;
					_QS_action_packWreck = player addAction _QS_action_packWreck_array;
					player setUserActionText [_QS_action_packWreck,_QS_action_packWreck_text,(format ["<t size='3'>%1</t>",_QS_action_packWreck_text])];
				};
			} else {
				if (_QS_interaction_packWreck) then {
					_QS_interaction_packWreck = _false;
					player removeAction _QS_action_packWreck;
				};
			};

			/*/===== Action Command Surrender/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorTarget)} &&
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
					player setUserActionText [_QS_action_commandSurrender,_QS_action_commandSurrender_text,(format ["<t size='3'>%1</t>",_QS_action_commandSurrender_text])];
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
				{(alive _cursorTarget)} &&
				{(_cursorDistance < 4)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(captive _cursorTarget)} &&
				{(isNull (objectParent _cursorTarget))} &&
				{(isNull (attachedTo _cursorTarget))} &&
				{(_cursorTarget getVariable ['QS_rescueable',_false])}
			) then {
				if (!(_QS_interaction_rescue)) then {
					_QS_interaction_rescue = _true;
					_QS_action_rescue = player addAction _QS_action_rescue_array;
					player setUserActionText [_QS_action_rescue,_QS_action_rescue_text,(format ["<t size='3'>%1</t>",_QS_action_rescue_text])];
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
					player setUserActionText [_QS_action_secure,_QS_action_secure_text,(format ["<t size='3'>%1</t>",_QS_action_secure_text])];
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
					player setUserActionText [_QS_action_examine,_QS_action_examine_text,(format ["<t size='3'>%1</t>",_QS_action_examine_text])];
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
					player setUserActionText [_QS_action_turretSafety,_QS_action_turretSafety_text,(format ["<t size='3'>%1</t>",_QS_action_turretSafety_text])];
				};
			} else {
				if (_QS_interaction_turretSafety) then {
					_QS_interaction_turretSafety = _false;
					player removeAction _QS_action_turretSafety;
				};
			};
			
			/*/===== Tooth Collector/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(!alive _cursorTarget)} &&
				{(_cursorDistance < 3)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(_cursorTarget getVariable ['QS_collectible_tooth',_false])}
			) then {
				if (!(_QS_interaction_teeth)) then {
					_QS_interaction_teeth = _true;
					_QS_action_teeth = player addAction _QS_action_teeth_array;
					player setUserActionText [_QS_action_teeth,_QS_action_teeth_text,(format ["<t size='3'>%1</t>",_QS_action_teeth_text])];
				};
			} else {
				if (_QS_interaction_teeth) then {
					_QS_interaction_teeth = _false;
					player removeAction _QS_action_teeth;
				};
			};
			
			/*/===== Beret Collector/*/
			
			if (
				(_noObjectParent) &&
				{(!isNull _cursorTarget)} &&
				{(_cursorDistance < 3)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(_cursorTarget getUnitTrait 'QS_trait_commander')} &&
				{((headgear _cursorTarget) isNotEqualTo '')} &&
				{((!alive _cursorTarget) || (_cursorTarget getVariable ['QS_isSurrendered',_false]))}
			) then {
				if (!(_QS_interaction_beret)) then {
					_QS_interaction_beret = _true;
					_QS_action_beret = player addAction _QS_action_beret_array;
					player setUserActionText [_QS_action_beret,_QS_action_beret_text,(format ["<t size='3'>%1</t>",_QS_action_beret_text])];
				};
			} else {
				if (_QS_interaction_beret) then {
					_QS_interaction_beret = _false;
					player removeAction _QS_action_beret;
				};
			};
			
			/*/===== Join Group/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorTarget)} &&
				{(_cursorDistance < 5)} &&
				{(_cursorTarget isKindOf 'CAManBase')} &&
				{(isPlayer _cursorTarget)} &&
				{((group _cursorTarget) isNotEqualTo (group _QS_player))} &&
				{(!(_grpTarget getVariable [_QS_joinGroup_privateVar,_false]))}
			) then {
				if (!(_QS_interaction_joinGroup)) then {
					_QS_interaction_joinGroup = _true;
					_QS_action_joinGroup = player addAction _QS_action_joinGroup_array;
					player setUserActionText [_QS_action_joinGroup,_QS_action_joinGroup_text,(format ["<t size='3'>%1</t>",_QS_action_joinGroup_text])];
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
					player setUserActionText [_QS_action_fob_status,_QS_action_fob_status_text,(format ["<t size='3'>%1</t>",_QS_action_fob_status_text])];
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
					player setUserActionText [_QS_action_fob_activate,_QS_action_fob_activate_text,(format ["<t size='3'>%1</t>",_QS_action_fob_activate_text])];
				};
			} else {
				if (_QS_interaction_fob_activate) then {
					_QS_interaction_fob_activate = _false;
					player removeAction _QS_action_fob_activate;
				};
			};
			
			/*/===== Edit/Save Inventory/*/

			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(_cursorObjectDistance < 3)} &&
				{(simulationEnabled _cursorObject)} &&
				{((maxLoad _cursorObject) > 0)} &&
				{(!(_cursorObject isKindOf 'CAManBase'))} &&
				{(!(lockedInventory _cursorObject))} &&
				{(!(_cursorObject getVariable ['QS_inventory_disabled',_false]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))}
			) then {
				_nearInvSite = _false;
				{
					if ((_x isEqualTo 'QS_marker_veh_inventoryService_01') && ((_cursorObject distance2D (markerPos _x)) < 15)) exitWith {
						_nearInvSite = _true;
					};
					if ((_x isEqualTo 'QS_marker_crate_area') && ((_cursorObject distance2D (markerPos _x)) < 75)) exitWith {
						_nearInvSite = _true;
					};
				} count (missionNamespace getVariable 'QS_veh_inventory_mkrs');
				if (_nearInvSite) then {
					if (!(_QS_interaction_customizeCrate)) then {
						_QS_interaction_customizeCrate = _true;
						_QS_action_crate_array set [2,_cursorObject];
						_QS_action_crate_customize = player addAction _QS_action_crate_array;
						player setUserActionText [_QS_action_crate_customize,_QS_action_crate_customize_text,(format ["<t size='3'>%1</t>",_QS_action_crate_customize_text])];
					};
				} else {
					if (_QS_interaction_customizeCrate) then {
						_QS_interaction_customizeCrate = _false;
						player removeAction _QS_action_crate_customize;
						_QS_action_crate_array set [2,_objNull];
					};
				};
			} else {
				if (_QS_interaction_customizeCrate) then {
					_QS_interaction_customizeCrate = _false;
					player removeAction _QS_action_crate_customize;
					_QS_action_crate_array set [2,_objNull];
				};
			};
			
			/*/===== Action push vehicle/*/
			
			if (
				(_noObjectParent) &&
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
					player setUserActionText [_QS_action_pushVehicle,_QS_action_pushVehicle_text,(format ["<t size='3'>%1</t>",_QS_action_pushVehicle_text])];
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
				{((((items _QS_player) apply {toLowerANSI _x}) findAny QS_core_classNames_itemToolKits) isNotEqualTo -1)} &&
				{(((getPosASL _QS_player) # 2) < 0)}
			) then {
				if (!(_QS_interaction_createBoat)) then {
					_QS_interaction_createBoat = _true;
					_QS_action_createBoat = player addAction _QS_action_createBoat_array;
					player setUserActionText [_QS_action_createBoat,_QS_action_createBoat_text,(format ["<t size='3'>%1</t>",_QS_action_createBoat_text])];
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
					player setUserActionText [_QS_action_recoverBoat,_QS_action_recoverBoat_text,(format ["<t size='3'>%1</t>",_QS_action_recoverBoat_text])];
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
				{(((vectorMagnitude (velocity _QS_player)) * 3.6) < 0.1)} &&
				{(((typeOf _cursorObject) in _QS_action_sit_chairTypes) || {(((getModelInfo _cursorObject) # 0) in _QS_action_sit_chairModels)})} &&
				{(isNull (attachedTo _cursorObject))} &&
				{((attachedObjects _cursorObject) isEqualTo [])}
			) then {
				if (!(_QS_interaction_sit)) then {
					_QS_interaction_sit = _true;
					_QS_action_sit = player addAction _QS_action_sit_array;
					player setUserActionText [_QS_action_sit,_QS_action_sit_text,(format ["<t size='3'>%1</t>",_QS_action_sit_text])];
				};
			} else {
				if (_QS_interaction_sit) then {
					_QS_interaction_sit = _false;
					player removeAction _QS_action_sit;
				};
			};
			
			/*/===== Cargo Load by looking at object when a vehicle carrier is nearby/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(simulationEnabled _cursorObject)} &&
				{(_cursorObjectDistance < 4)} &&
				{
					(
						((['Reammobox_F','StaticWeapon','ThingX'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1) ||
						{(_cursorObject getVariable ['QS_logistics',_false])} ||
						{[0,_cursorObject] call _fn_getCustomCargoParams}
					)
				} &&
				{(isNull (attachedTo _cursorObject))} &&
				{(isNull (ropeAttachedTo _cursorObject))} &&
				{(isNull (isVehicleCargo _cursorObject))} &&
				{((ropes _cursorObject) isEqualTo [])} &&
				{(!(isSimpleObject _cursorObject))} &&
				{(!(_cursorObject getVariable ['QS_logistics_deployed',_false]))} &&
				{(((_cursorObject nearEntities [['Air','LandVehicle','Ship'],21]) - [_cursorObject]) isNotEqualTo [])} &&
				{(!(uiNamespace getVariable ['QS_localHelper',_false]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_immovable',_false]))}
			) then {
				if (_QS_action_loadCargo_validated) then {
					_QS_action_loadCargo_validated = _false;
					_QS_action_loadCargo_vehicles = [];
				};
				_nearCarriers = ((_cursorObject nearEntities [['Air','LandVehicle','Ship'],21]) - [_cursorObject]) apply { [_x distance _cursorObject,_x] };
				_nearCarriers sort _true;
				{
					if (
						(vehicleCargoEnabled (_x # 1)) &&
						{(simulationEnabled (_x # 1))} &&
						{
							((toLowerANSI (typeOf (_x # 1))) in _QS_action_loadCargo_vTypes) ||
							(([(_x # 1),_cursorObject] call _fn_canVehicleCargo) # 0)
						} &&
						{(!((_x # 1) getVariable ['QS_logistics_wreck',_false]))} &&
						{(!((_x # 1) getVariable ['QS_logistics_deployed',_false]))} &&
						{(!lockedInventory (_x # 1))}
					) exitWith {
						_QS_action_loadCargo_vehicles pushBack (_x # 1);
						_QS_action_loadCargo_validated = _true;
					};
				} forEach _nearCarriers;
				if (_QS_action_loadCargo_validated) then {
					if (!(_QS_interaction_loadCargo)) then {
						_QS_interaction_loadCargo = _true;
						_QS_action_loadCargo_array set [2,[_cursorObject,_QS_action_loadCargo_vehicles]];
						_QS_action_loadCargo = player addAction _QS_action_loadCargo_array;
						player setUserActionText [_QS_action_loadCargo,_QS_action_loadCargo_text,(format ["<t size='3'>%1</t>",_QS_action_loadCargo_text])];
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
			
			/*/===== Action Load 2 (load crates the player is carrying into vehicles)/*/
			
			if (
				(_noObjectParent) &&
				{(alive _cursorObject)} &&
				{(_cursorObjectDistance <= 4)} &&
				{((['LandVehicle','Air','Ship','Cargo_base_F'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
				{((locked _cursorObject) in [-1,0,1])} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))} &&
				{(!(_cursorObject getVariable ['QS_logistics_deployed',_false]))} &&
				{(!(lockedInventory _cursorObject))} &&
				{(!(_cursorObject getVariable ['QS_lockedInventory',_false]))} &&
				{
					_attachedLoadableObjects = _attachedObjects select {(!(_x isKindOf 'Sign_Sphere10cm_F')) &&(!(_x isKindOf 'Logic'))};
					(
						(
							(_attachedObjects isNotEqualTo []) && 
							{((_attachedObjects findIf {([0,_x,_cursorObject] call _fn_getCustomCargoParams)}) isNotEqualTo -1)}
						) ||
						{(
							(_attachedLoadableObjects isNotEqualTo []) &&
							{(([_cursorObject,(_attachedLoadableObjects # 0)] call _fn_canVehicleCargo) # 0)}
						)}
					)
				} &&
				{
					(
						(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',_false])) || 
						(missionNamespace getVariable ['QS_placementMode_carryMode',_false])
					)
				}
			) then {
				{
					_object = _x;
					if (
						(!isNull _object) &&
						{((toLowerANSI (typeOf _object)) isNotEqualTo _QS_helmetCam_helperType)}
					) then {
						if (
							([0,_object,_cursorObject] call _fn_getCustomCargoParams) || 
							{([_cursorObject,_object] call _fn_isValidCargoV)}
						) then {
							if (
								([1,_object,_cursorObject] call _fn_getCustomCargoParams) || 
								{([_cursorObject,_object] call _fn_isValidCargoV)}
							) then {
								if (!(_QS_interaction_load2)) then {
									_QS_interaction_load2 = _true;
									_QS_action_load2_array set [2,[_object,_cursorObject]];
									_QS_action_load2 = player addAction _QS_action_load2_array;
									player setUserActionText [_QS_action_load2,_QS_action_load2_text,(format ["<t size='3'>%1</t>",_QS_action_load2_text])];
								};
							} else {
								if (_QS_interaction_load2) then {
									_QS_interaction_load2 = _false;
									_QS_action_load2_array set [2,[]];
									player removeAction _QS_action_load2;
								};
							};
						} else {
							if (_QS_interaction_load2) then {
								_QS_interaction_load2 = _false;
								_QS_action_load2_array set [2,[]];
								player removeAction _QS_action_load2;
							};
						};
					};
				} forEach _attachedObjects;
			} else {
				if (_QS_interaction_load2) then {
					_QS_interaction_load2 = _false;
					_QS_action_load2_array set [2,[]];
					player removeAction _QS_action_load2;
				};
			};
			
			/*/===== Action Unload Cargo/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= (_cursorObject getVariable ['QS_logistics_unloadDistance',5]))} &&
				{((isNull (attachedTo _cursorObject)) || ((!isNull (attachedTo _cursorObject)) && (!(lockedInventory (attachedTo _cursorObject)))))} &&
				{(!(_cursorObject getVariable ['QS_lockedInventory',_false]))} &&
				{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',_false]))} &&
				{(!(_cursorObject isKindOf 'CAManBase'))} &&
				{(
					(!isNull (isVehicleCargo _cursorObject)) ||
					{(!isNull (attachedTo _cursorObject))} ||
					{((['LandVehicle','Ship','Air'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} ||
					{((_cursorObject getVariable ['QS_virtualCargo',[]]) isNotEqualTo [])}
				)} &&
				{
					(simulationEnabled _cursorObject) ||
					{((_cursorObject getVariable ['QS_virtualCargo',[]]) isNotEqualTo [])}
				} &&
				{(
					((attachedObjects _cursorObject) isNotEqualTo []) ||
					{(!isNull (isVehicleCargo _cursorObject))} ||
					{(!isNull (attachedTo _cursorObject))} ||
					{((_cursorObject getVariable ['QS_virtualCargo',[]]) isNotEqualTo [])}
				)} &&
				{
					(!isNull (isVehicleCargo _cursorObject)) ||
					{(!isNull (attachedTo _cursorObject))} ||
					{(((attachedObjects _cursorObject) findIf {(([0,_x,_cursorObject] call _fn_getCustomCargoParams) && (!(_x getVariable ['QS_interaction_disabled',_false])))}) isNotEqualTo -1)} ||
					{((getVehicleCargo _cursorObject) isNotEqualTo [])} ||
					{((_cursorObject getVariable ['QS_virtualCargo',[]]) isNotEqualTo [])}
				}
			) then {
				if (!(_QS_interaction_unloadCargo)) then {
					_QS_interaction_unloadCargo = _true;
					_QS_action_unloadCargo = player addAction _QS_action_unloadCargo_array;
					player setUserActionText [_QS_action_unloadCargo,_QS_action_unloadCargo_text,(format ["<t size='3'>%1</t>",_QS_action_unloadCargo_text])];
				};
			} else {
				if (_QS_interaction_unloadCargo) then {
					_QS_interaction_unloadCargo = _false;
					player removeAction _QS_action_unloadCargo;
				};
			};
			
			/*/===== Action Lift/*/

			if (
				(!_noObjectParent) &&
				{((_objectParent getVariable ['QS_vehicle_lift',-1]) isNotEqualTo -1)} &&
				{(!isNull ([0,_objectParent] call _fn_getFrontObject))}
			) then {
				if (!(_QS_interaction_forklift)) then {
					_QS_interaction_forklift = _true;
					_QS_action_forklift = player addAction _QS_action_forklift_array;
					player setUserActionText [_QS_action_forklift,_QS_action_forklift_text,(format ["<t size='3'>%1</t>",_QS_action_forklift_text])];				
				};
			} else {
				if (_QS_interaction_forklift) then {
					_QS_interaction_forklift = _false;
					player removeAction _QS_action_forklift;
				};
			};
			
			/*/===== Action Activate Vehicle/*/

			if (
				(_noObjectParent) &&
				{(!isNull _cursorObject)} &&
				{(_cursorObjectDistance <= 3)} &&
				{((isSimpleObject _cursorObject) || ((!simulationEnabled _cursorObject) && (_cursorObject getVariable ['QS_vehicle_activateLocked',_true])))} &&
				{((typeOf _cursorObject) isNotEqualTo '')} &&
				{((_cursorObject isKindOf 'AllVehicles') && (!(_cursorObject isKindOf 'CAManBase')))} &&
				{(!(missionNamespace getVariable ['QS_customAO_GT_active',_false])) || ((missionNamespace getVariable ['QS_customAO_GT_active',_false]) && {(((_isAltis) && ((_cursorObject distance2D [3476.77,13108.7,0]) > 500)) || {((_isTanoa) && ((_cursorObject distance2D [5762,10367,0]) > 500))})}) || ((!(_isAltis)) && (!(_isTanoa)))} &&
				{(!(_cursorObject getVariable ['QS_v_disableProp',_false]))}
			) then {
				if (!(_QS_interaction_activateVehicle)) then {
					_QS_interaction_activateVehicle = _true;
					_QS_action_activateVehicle = player addAction _QS_action_activateVehicle_array;
					player setUserActionText [_QS_action_activateVehicle,_QS_action_activateVehicle_text,(format ["<t size='3'>%1</t>",_QS_action_activateVehicle_text])];
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
				{((toLowerANSI ((getModelInfo _cursorObject) # 1)) in _QS_action_medevac_models)} &&
				{
					(
						((damage _QS_player) > 0) || 
						{
							((getAllHitPointsDamage _QS_player) isNotEqualTo []) &&
							{((selectMax ((getAllHitPointsDamage _QS_player) # 2)) > 0)}
						}
					)
				}
			) then {
				if (!(_QS_interaction_huronContainer)) then {
					_QS_interaction_huronContainer = _true;
					_QS_action_huronContainer = player addAction _QS_action_huronContainer_array;
					player setUserActionText [_QS_action_huronContainer,_QS_action_huronContainer_text,(format ["<t size='3'>%1</t>",_QS_action_huronContainer_text])];
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
					{((['LandVehicle','Air','Ship','StaticWeapon'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
					{(((crew _cursorObject) findIf {(alive _x)}) isNotEqualTo -1)} &&
					{(alive (effectiveCommander _cursorObject))} &&
					{((side (group (effectiveCommander _cursorObject))) in _enemysides)}
				) then {
					if (!(_QS_interaction_sensorTarget)) then {
						_QS_interaction_sensorTarget = _true;
						_QS_action_sensorTarget_array set [0,([_sensorTarget_text_1,_sensorTarget_text_2] select (_QS_player getUnitTrait 'QS_trait_JTAC'))];
						_QS_action_sensorTarget = player addAction _QS_action_sensorTarget_array;
						player setUserActionText [_QS_action_sensorTarget,(_QS_action_sensorTarget_array # 0),(format ["<t size='3'>%1</t>",(_QS_action_sensorTarget_array # 0)])];
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
				{((((magazines _QS_player) apply {toLowerANSI _x}) findAny QS_core_classNames_demoCharges) isNotEqualTo -1)}
			) then {
				if (!(_QS_interaction_attachExp)) then {
					_QS_interaction_attachExp = _true;
					_QS_userActionText = format ['%1 (%2 %3)',_QS_action_attachExp_text,({((toLowerANSI _x) in QS_core_classNames_demoCharges)} count (magazines _QS_player)),localize 'STR_QS_Utility_001'];
					QS_client_dynamicActionText pushBackUnique _QS_userActionText;
					_QS_action_attachExp_array set [0,_QS_userActionText];
					_QS_action_attachExp = player addAction _QS_action_attachExp_array;
					player setUserActionText [_QS_action_attachExp,_QS_userActionText,(format ["<t size='3'>%1</t>",_QS_userActionText])];
				} else {
					_QS_userActionText = format ['%1 (%2 %3)',_QS_action_attachExp_text,({((toLowerANSI _x) in QS_core_classNames_demoCharges)} count (magazines _QS_player)),localize 'STR_QS_Utility_001'];
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
				{(local _objectParent)} &&
				{((['Car','Tank','Ship'] findIf { _objectParent isKindOf _x }) isNotEqualTo -1)} &&
				{((lifeState _QS_player) in ['HEALTHY','INJURED'])} &&
				{(isNull (attachedTo _objectParent))} &&
				{(isNull (ropeAttachedTo _objectParent))} &&
				{(isNull (isVehicleCargo _objectParent))} &&
				{((((velocityModelSpace _objectParent) # 1) * 3.6) > 5)} &&
				{((getCruiseControl _objectParent) # 1) || ((!((getCruiseControl _objectParent) # 1)) && (((getCruiseControl _objectParent) # 0) isEqualTo 0))}
			) then {
				_ccText = if (
					(alive _cursorObject) &&
					{(simulationEnabled _cursorObject)} &&
					{((_cursorObject isKindOf 'LandVehicle') || (_cursorObject isKindOf 'Ship'))} &&
					{((_objectParent distance _cursorObject) < 250)} &&
					{(((_objectParent getRelDir _cursorObject) >= 270) || ((_objectParent getRelDir _cursorObject) <= 90))} &&
					{(_cursorObject isNotEqualTo _objectParent)} &&
					{(alive (driver _cursorObject))}
				) then {_ccTextConvoy} else {_ccTextDefault};
				if (!(_QS_interaction_cc)) then {
					_QS_interaction_cc = _true;
					_QS_action_cc_array set [0,_ccText];
					_QS_action_cc = player addAction _QS_action_cc_array;
					player setUserActionText [_QS_action_cc,_ccText,(format ["<t size='3'>%1</t>",_ccText])];
				} else {
					if (((player actionParams _QS_action_cc) # 0) isNotEqualTo _ccText) then {
						_QS_action_cc_array set [0,_ccText];
						player setUserActionText [_QS_action_cc,_ccText,(format ["<t size='3'>%1</t>",_ccText])];
					};
				};
			} else {
				if (_QS_interaction_cc) then {
					_QS_interaction_cc = _false;
					player removeAction _QS_action_cc;
				};
			};
			
			//===== Parachute

			if (
				(
					(isNull _objectParent) &&
					{((getUnitFreefallInfo _QS_player) # 0)} &&
					{(
						((getUnitFreefallInfo _QS_player) # 1) ||
						(((getPos _QS_player) # 2) >= ((getUnitFreefallInfo _QS_player) # 2))
					)} &&
					{(!((backpack _QS_player) in QS_core_classNames_parachutes))} &&
					{(_QS_uiTime > (uiNamespace getVariable ['QS_client_openParachuteCooldown',-1]))}
				) ||
				{(
					(alive _objectParent) &&
					{(_objectParent isKindOf 'LandVehicle')} &&
					{(local _objectParent)} &&
					{(!isTouchingGround _objectParent)} &&
					{(isNull (attachedTo _objectParent))} &&
					{(isNull (ropeAttachedTo _objectParent))} &&
					{(isNull (isVehicleCargo _objectParent))} &&
					{(((getPos _objectParent) # 2) > ((getUnitFreefallInfo _QS_player) # 2))} &&
					{(((vectorMagnitude (velocity _objectParent)) * 3.6) > 25)} &&
					{(_QS_uiTime > (uiNamespace getVariable ['QS_client_openParachuteCooldown',-1]))}
				)}
			) then {
				if (!(_QS_interaction_para)) then {
					_QS_interaction_para = _true;
					_QS_action_para = player addAction _QS_action_para_array;
					player setUserActionText [_QS_action_para,_QS_action_para_text,(format ["<t size='3'>%1</t>",_QS_action_para_text])];
				};
			} else {
				if (_QS_interaction_para) then {
					_QS_interaction_para = _false;
					player removeAction _QS_action_para;
				};
			};
			
			//===== Parachute Cut
			
			if (
				(!isNull _QS_v2) &&
				{(alive _QS_v2)} &&
				{(
					(_QS_v2TypeL in qs_core_classnames_steerableps) ||
					{((!isNull (attachedTo _QS_v2)) && ((toLowerANSI (typeOf (attachedTo _QS_v2))) in qs_core_classnames_vehicleparachutes))}
				)}
			) then {
				if (!(_QS_interaction_paracut)) then {
					_QS_interaction_paracut = _true;
					_QS_action_paracut = player addAction _QS_action_paracut_array;
					player setUserActionText [_QS_action_paracut,_QS_action_paracut_text,(format ["<t size='3'>%1</t>",_QS_action_paracut_text])];
				};
			} else {
				if (_QS_interaction_paracut) then {
					_QS_interaction_paracut = _false;
					player removeAction _QS_action_paracut;
				};
			};

			//===== Destroyer Hangar Launch/Retract
			
			if (_QS_player getVariable ['QS_client_inDestroyerArea',_false]) then {
				if (!(_QS_interaction_destroyerHeli)) then {
					_QS_interaction_destroyerHeli = _true;
					_QS_action_destroyerHeli_array set [
						0,
						[_QS_action_destroyerHeli_textRetract,_QS_action_destroyerHeli_textLaunch] select (!isNull ((missionNamespace getVariable ['QS_destroyerObject',_objNull]) getVariable ['QS_destroyer_hangarHeli',_objNull]))
					];
					_QS_action_destroyerHeli = (missionNamespace getVariable 'QS_destroyer_hangarInterior') addAction _QS_action_destroyerHeli_array;
					(missionNamespace getVariable 'QS_destroyer_hangarInterior') setUserActionText [_QS_action_destroyerHeli,(_QS_action_destroyerHeli_array # 0),(format ["<t size='3'>%1</t>",(_QS_action_destroyerHeli_array # 0)])];
				} else {
					(missionNamespace getVariable 'QS_destroyer_hangarInterior') setUserActionText [
						_QS_action_destroyerHeli,
						[_QS_action_destroyerHeli_textRetract,_QS_action_destroyerHeli_textLaunch] select (!isNull ((missionNamespace getVariable ['QS_destroyerObject',_objNull]) getVariable ['QS_destroyer_hangarHeli',_objNull])),
						(format ["<t size='3'>%1</t>",(((missionNamespace getVariable 'QS_destroyer_hangarInterior') actionParams _QS_action_destroyerHeli) # 0)])
					];
				};
			} else {
				if (_QS_interaction_destroyerHeli) then {
					_QS_interaction_destroyerHeli = _false;
					(missionNamespace getVariable ['QS_destroyer_hangarInterior',_objNull]) removeAction _QS_action_destroyerHeli;
				};
			};

			/*/===== UGV/*/
			
			if (
				(_QS_player getUnitTrait 'uavhacker') || 
				{(!isNull (getAssignedCuratorLogic _QS_player))}
			) then {
				if (
					(unitIsUav _QS_cO) &&
					{((toLowerANSI (typeOf _QS_cO)) in _QS_action_ugv_types)} &&
					{(isTouchingGround _QS_cO)} &&
					{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)} &&
					{((attachedObjects _QS_cO) isNotEqualTo [])} &&
					{(((attachedObjects _QS_cO) findIf {(((toLowerANSI ((getModelInfo _x) # 1)) isEqualTo _QS_action_ugv_stretcherModel) && (!(isObjectHidden _x)))}) isNotEqualTo -1)}
				) then {
					if (_QS_ugv isNotEqualTo _QS_cO) then {
						_QS_ugv = _QS_cO;
					};
					if (({(_x isKindOf 'CAManBase')} count (attachedObjects _QS_cO)) < ({((toLowerANSI ((getModelInfo _x) # 1)) isEqualTo _QS_action_ugv_stretcherModel)} count (attachedObjects _QS_cO))) then {
						_listOfFrontStuff = ((_QS_cO getRelPos [3,0]) nearEntities ['CAManBase',3]) select {(((lifeState _x) isEqualTo 'INCAPACITATED') && (isNull (attachedTo _x)) && (isNull (objectParent _x)) && (!(_x getVariable ['QS_unit_needsStabilise',_false])))};	/*/unit needs to be stabilised first?/*/
						if (_listOfFrontStuff isNotEqualTo []) then {
							if (!(_QS_interaction_ugvLoad)) then {
								_QS_interaction_ugvLoad = _true;
								_QS_action_ugvLoad_array set [2,[_QS_ugv,4]];
								_QS_action_ugvLoad = _QS_ugv addAction _QS_action_ugvLoad_array;
								_QS_ugv setUserActionText [_QS_action_ugvLoad,_QS_action_ugvLoad_text,(format ["<t size='3'>%1</t>",_QS_action_ugvLoad_text])];
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
							_QS_ugv setUserActionText [_QS_action_ugvUnload,_QS_action_ugvUnload_text,(format ["<t size='3'>%1</t>",_QS_action_ugvUnload_text])];
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
				
				/*/===== UGV Tow/*/
				
				if (unitIsUav _QS_cO) then {
					if (_QS_ugvTow isNotEqualTo _QS_cO) then {
						_QS_ugvTow = _QS_cO;
					};
					if (
						((toLowerANSI (typeOf _QS_ugvTow)) in _QS_action_ugv_types) &&
						{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)} &&
						{((_QS_ugvTow getVariable ['QS_tow_veh',-1]) > 0)} &&
						{(canMove _QS_ugvTow)} &&
						{(((attachedObjects _QS_ugvTow) findIf {((alive _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)} &&
						{([_QS_ugvTow] call _fn_vTowable)}
					) then {
						if ((!(_QS_interaction_tow)) && (!(_QS_interaction_towUGV))) then {
							_QS_interaction_towUGV = _true;
							_QS_action_towUGV = _QS_ugvTow addAction _QS_action_tow_array;
							_QS_ugvTow setUserActionText [_QS_action_towUGV,_QS_action_tow_text,(format ["<t size='3'>%1</t>",_QS_action_tow_text])];
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
					if (
						(local _QS_ugvSD) &&
						{(
							(!(canMove _QS_ugvSD)) || 
							{((fuel _QS_ugvSD) isEqualTo 0)} ||
							{
								((getAllHitPointsDamage _QS_ugvSD) isNotEqualTo []) &&
								{((selectMax ((getAllHitPointsDamage _QS_ugvSD) # 2)) > 0.5)}
							} || 
							{
								(_QS_ugvSD getEntityInfo 6)
							}
						)}
					) then {
						if (!(_QS_interaction_uavSelfDestruct)) then {
							_QS_interaction_uavSelfDestruct = _true;
							_QS_action_uavSelfDestruct = _QS_ugvSD addAction _QS_action_uavSelfDestruct_array;
							_QS_ugvSD setUserActionText [_QS_action_uavSelfDestruct,_QS_action_uavSelfDestruct_text,(format ["<t size='3'>%1</t>",_QS_action_uavSelfDestruct_text])];
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
											_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,localize 'STR_QS_Interact_046',format ['<t size="3">%1</t>',localize 'STR_QS_Interact_046']];
										};
										if (_QS_carrier_cameraOn getVariable ['QS_carrier_launch',_false]) then {
											if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) # 0) isEqualTo (localize 'STR_QS_Interact_046')) then {
												_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,localize 'STR_QS_Interact_047',format ['<t size="3">%1</t>',localize 'STR_QS_Interact_047']];
											};
										} else {
											if (((_QS_carrier_cameraOn actionParams _QS_action_carrierLaunch) # 0) isEqualTo (localize 'STR_QS_Interact_047')) then {
												_QS_carrier_cameraOn setUserActionText [_QS_action_carrierLaunch,localize 'STR_QS_Interact_046',format ['<t size="3">%1</t>',localize 'STR_QS_Interact_046']];
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
				{((['Tank','Wheeled_APC_F'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
				{(canMove _cursorObject)} &&
				{(!(isSimpleObject _cursorObject))} &&
				{((locked _cursorObject) in [0,1])} &&
				{(((crew _cursorObject) findIf {((side (group _x)) in _enemysides)}) isEqualTo -1)} &&
				{(!(_cursorObject getVariable ['QS_logistics_wreck',_false]))}
			) then {
				_QS_action_camonetArmor_vAnims = _cursorObject getVariable ['QS_vehicle_camonetAnims',-1];
				if (_QS_action_camonetArmor_vAnims isEqualTo -1) then {
					_array = [];
					_animationSources = QS_hashmap_configfile getOrDefaultCall [
						format ['cfgvehicles_%1_animationsources',toLowerANSI (typeOf _cursorObject)],
						{getArray ((configOf _cursorObject) >> 'animationSources')},
						_true
					];
					_i = 0;
					for '_i' from 0 to ((count _animationSources) - 1) step 1 do {
						_animationSource = _animationSources # _i;
						if (((toLowerANSI (configName _animationSource)) in _QS_action_camonetArmor_anims) || {(['showcamo',(configName _animationSource),_false] call _fn_inString)}) then {
							_array pushBack (toLowerANSI (configName _animationSource));
						};
					};
					{
						if (
							(_x isEqualType '') &&
							{(!((toLowerANSI _x) in _array))} &&
							{(((toLowerANSI _x) in _QS_action_camonetArmor_anims) || {(['showcamo',_x,_false] call _fn_inString)})}
						) then {
							_array pushBack (toLowerANSI _x);
						};
					} forEach (QS_hashmap_configfile getOrDefaultCall [format ['cfgvehicles_%1_animationslist',toLowerANSI (typeOf _cursorObject)],{getArray ((configOf _cursorObject) >> 'animationList')},_true]);
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
								player setUserActionText [_QS_action_camonetArmor,(_QS_action_camonetArmor_array # 0),(format ["<t size='3'>%1</t>",(_QS_action_camonetArmor_array # 0)])];
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
				{((['Tank','Wheeled_APC_F'] findIf { _QS_v2 isKindOf _x }) isNotEqualTo -1)} &&
				{(_QS_player isEqualTo (effectiveCommander _QS_v2))} &&
				{(!(missionNamespace getVariable ['QS_repairing_vehicle',_false]))} &&
				{(((vectorMagnitude (velocity _QS_v2)) * 3.6) < 2)}
			) then {
				if (
					([_QS_v2,sizeOf (typeOf _QS_v2)] call _fn_isNearRepairDepot) ||
					{
						_nearServices = [_QS_v2,sizeOf (typeOf _QS_v2),_false] call _fn_isNearServiceCargo;
						(
							(_nearServices isNotEqualTo []) &&
							({((['repair','refuel','reammo'] arrayIntersect (_nearServices apply { _x # 1 })) isEqualTo ['repair','refuel','reammo'])})
						)
					}
				) then {
					_QS_action_slatArmor_vAnims = _QS_v2 getVariable ['QS_vehicle_slatarmorAnims',-1];
					if (_QS_action_slatArmor_vAnims isEqualTo -1) then {
						_array = [];
						_animationSources = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_animationsources',toLowerANSI (typeOf _QS_v2)],
							{getArray ((configOf _QS_v2) >> 'animationSources')},
							_true
						];
						_i = 0;
						for '_i' from 0 to ((count _animationSources) - 1) step 1 do {
							_animationSource = _animationSources # _i;
							if (((toLowerANSI (configName _animationSource)) in _QS_action_slatArmor_anims) || {(['showslat',(configName _animationSource),_false] call _fn_inString)}) then {
								_array pushBack (toLowerANSI (configName _animationSource));
							};
						};
						{
							if (
								(_x isEqualType '') &&
								{(!((toLowerANSI _x) in _array))} &&
								{(((toLowerANSI _x) in _QS_action_slatArmor_anims) || {(['showslat',_x,_false] call _fn_inString)})}
							) then {
								_array pushBack (toLowerANSI _x);
							};
						} forEach (QS_hashmap_configfile getOrDefaultCall [format ['cfgvehicles_%1_animationlist',toLowerANSI (typeOf _QS_v2)],{getArray ((configOf _QS_v2) >> 'animationList')},_true]);
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
									player setUserActionText [_QS_action_slatArmor,(_QS_action_slatArmor_array # 0),(format ["<t size='3'>%1</t>",(_QS_action_slatArmor_array # 0)])];
								} else {
									if ((_QS_action_slatArmor_vAnims findIf {((_QS_v2 animationSourcePhase _x) isEqualTo 1)}) isNotEqualTo -1) then {
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
						if (!(_inSafezone && _safezoneActive)) then {
							if ([_QS_player,_QS_v2] call _fn_ARRappelFromHeliActionCheck) then {
								if (!(_QS_interaction_rappelSelf)) then {
									_QS_interaction_rappelSelf = _true;
									_QS_action_rappelSelf = player addAction _QS_action_rappelSelf_array;
									player setUserActionText [_QS_action_rappelSelf,_QS_action_rappelSelf_text,(format ["<t size='3'>%1</t>",_QS_action_rappelSelf_text])];
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
									player setUserActionText [_QS_action_rappelAI,_QS_action_rappelAI_text,(format ["<t size='3'>%1</t>",_QS_action_rappelAI_text])];
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
											if (!(_QS_v2 getVariable ['QS_rappellSafety',_false])) then {
												_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textDisable];
											} else {
												_QS_action_rappelSafety_array set [0,_QS_action_rappelSafety_textEnable];
											};
											_QS_action_rappelSafety = player addAction _QS_action_rappelSafety_array;
											player setUserActionText [_QS_action_rappelSafety,(_QS_action_rappelSafety_array # 0),(format ["<t size='3'>%1</t>",(_QS_action_rappelSafety_array # 0)])];
										} else {
											if (!(_QS_v2 getVariable ['QS_rappellSafety',_false])) then {
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
						player setUserActionText [_QS_action_rappelDetach,_QS_action_rappelDetach_text,(format ["<t size='3'>%1</t>",_QS_action_rappelDetach_text])];
					};
				} else {
					if (_QS_interaction_rappelDetach) then {
						_QS_interaction_rappelDetach = _false;
						player removeAction _QS_action_rappelDetach;
					};
				};
			};
			
			/*/===== Action Release/*/

			if (
				([_QS_player] call _fn_isBusyAttached) &&
				{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',_false]))}
			) then {
				{
					if (!(_QS_interaction_release)) exitWith {
						_QS_interaction_release = _true;
						_QS_action_release = player addAction _QS_action_release_array;
						player setUserActionText [_QS_action_release,_QS_action_release_text,(format ["<t size='3'>%1</t>",_QS_action_release_text])];
					};
				} forEach _attachedObjects;
			} else {
				if (_QS_interaction_release) then {
					_QS_interaction_release = _false;
					player removeAction _QS_action_release;
				};
			};
		};
	} else {
		if (_QS_player getVariable ['QS_RD_interacting',_false]) then {
			_QS_player setVariable ['QS_RD_interacting',_false,_true];
		};
		if (_QS_player getVariable ['QS_RD_carrying',_false]) then {
			_QS_player setVariable ['QS_RD_carrying',_false,_true];
		};
		if (_QS_player getVariable ['QS_RD_dragging',_false]) then {
			_QS_player setVariable ['QS_RD_dragging',_false,_true];
		};
	};
	if (_timeNow > _QS_miscDelay2) then {
		_QS_miscDelay2 = _timeNow + (random [2,3,4]);
		if (
			(!isNull _objectParent) &&
			{(_objectParent getVariable ['QS_logistics_wreck',_false])}
		) then {
			_QS_player moveOut (objectParent _QS_player);
		};
		if (!lockedInventory _objectParent) then {
			if (
				(_objectParent getVariable ['QS_lockedInventory',_false]) ||
				{(_objectParent getVariable ['QS_inventory_disabled',_false])} ||
				{(_objectParent getVariable ['QS_logistics_wreck',_false])}
			) then {
				_objectParent lockInventory _true;
			};
		} else {
			if (
				(!(_objectParent getVariable ['QS_lockedInventory',_false])) &&
				{(!(_objectParent getVariable ['QS_inventory_disabled',_false]))} &&
				{(!(_objectParent getVariable ['QS_logistics_wreck',_false]))}
			) then {
				_objectParent lockInventory _false;
			};				
		};
		if (
			!isGameFocused &&
			{(scriptDone _simulWeatherSync)}
		) then {
			_simulWeatherSync = 0 spawn {
				waitUntil {
					isGameFocused
				};
				simulWeatherSync;
			};
		};
		_allPlayers = allPlayers;
		_QS_cameraPosition2D = [(positionCameraToWorld [0,0,0]) # 0,(positionCameraToWorld [0,0,0]) # 2];
		if (_QS_player getVariable ['QS_RD_interacting',_false]) then {
			if (_QS_player getVariable ['QS_RD_carrying',_false]) then {
				if ((_attachedObjects isEqualTo []) || {((_attachedObjects findIf {((!isNull _x) && (_x isKindOf 'CAManBase'))}) isEqualTo -1)}) then {
					_QS_player setVariable ['QS_RD_carrying',_false,_true];
					_QS_player setVariable ['QS_RD_interacting',_false,_true];
					_QS_player playMoveNow 'AidlPknlMstpSrasWrflDnon_AI';
				} else {
					{
						if (
							(!isNull _x) &&
							{(_x isKindOf 'CAManBase')} &&
							{(!alive _x)}
						) then {
							[0,_x] call QS_fnc_eventAttach;
							['switchMove',_QS_player,['']] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
							if (_x getVariable ['QS_RD_carried',_false]) then {
								_QS_player setVariable ['QS_RD_carrying',_false,_true];
								_QS_player setVariable ['QS_RD_interacting',_false,_true];
							};
						};
					} forEach _attachedObjects;
				};
			};
			if (_QS_player getVariable ['QS_RD_dragging',_false]) then {
				if (_attachedObjects isEqualTo []) then {
					_QS_player setVariable ['QS_RD_dragging',_false,_true];
					_QS_player setVariable ['QS_RD_interacting',_false,_true];
					_QS_player playAction 'released';
				} else {
					if ((_attachedObjects findIf {(!isNull _x)}) isEqualTo -1) then {
						_QS_player setVariable ['QS_RD_dragging',_false,_true];
						_QS_player setVariable ['QS_RD_interacting',_false,_true];
						_QS_player playAction 'released';
					} else {
						{
							if (
								(!isNull _x) &&
								{(_x isKindOf 'CAManBase')} &&
								{(!alive _x)}
							) then {
								[0,_x] call QS_fnc_eventAttach;
								if (_x getVariable ['QS_RD_dragged',_false]) then {
									_QS_player setVariable ['QS_RD_dragging',_false,_true];
									_QS_player setVariable ['QS_RD_interacting',_false,_true];
									_QS_player playAction 'released';
								};
							};
						} forEach _attachedObjects;
					};
				};
			};
		};
		QS_managed_flares = QS_managed_flares select {!isNull (_x # 0)};
		if (QS_managed_flares isNotEqualTo []) then {
			{
				if (
					(_QS_uiTime > (_x # 1)) ||
					{((!isNull (_x # 0)) && {((vectorMagnitude (velocity (_x # 0))) < 0.1)})}
				) then {
					deleteVehicle (_x # 0);
				};
			} forEach QS_managed_flares;
		};
		//_localProps = QS_list_playerBuildables select {local _x};
		localNamespace setVariable ['QS_list_playerLocalBuildables',((localNamespace getVariable ['QS_list_playerLocalBuildables',[]]) select {!isNull _x})];
		_localProps = localNamespace getVariable ['QS_list_playerLocalBuildables',[]];
		if (_localProps isNotEqualTo []) then {
			//_listUnits = (units EAST) + (units RESISTANCE);    // not ideal
			{
				_localProp = _x;
				if (!isNull _localProp) then {
					if (
						(
							(_localProp nearEntities ['CAManBase',((0 boundingBox _localProp) # 2) * 2]) select {
								(alive _x) && {(!isNull (group _x)) && {((side (group _x)) in _enemySides)}}
							}
						) isNotEqualTo []
					) then {
						deleteVehicle _localProp;
					};
					/*/
					if ((_listUnits inAreaArray [_localProp,((0 boundingBox _localProp) # 2) * 2,((0 boundingBox _localProp) # 2) * 2]) isNotEqualTo []) then {
						// use small explosion here
						deleteVehicle _localProp;
					};
					/*/
				};
			} forEach _localProps;
		};
		if (
			(!isNull (getTowParent _QS_cO)) &&
			{(isNull (ropeAttachedTo _QS_cO))}
		) then {
			_QS_cO setTowParent _objNull;
		};
		if ((backpack _QS_cO) in ['B_CombinationUnitRespirator_01_F','B_SCBA_01_F']) then {
			if ((backpack _QS_cO) isEqualTo 'B_CombinationUnitRespirator_01_F') then {
				(getObjectTextures (backpackContainer _QS_cO)) params ['','_hose1','_hoseAPR','_hoseReg',''];
				if ((toLowerANSI (goggles _QS_cO)) in [
					'g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f'
				]) then {
					if (_hose1 isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
						(backpackContainer _QS_cO) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
					};
					if (_hoseAPR isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
						(backpackContainer _QS_cO) setObjectTextureGlobal [2,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
					};
					if (_hoseReg isNotEqualTo '') then {
						(backpackContainer _QS_cO) setObjectTextureGlobal [3,''];
					};
				} else {
					if ((toLowerANSI (goggles _QS_cO)) in ['g_regulatormask_f']) then {
						if (_hose1 isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
						};
						if (_hoseAPR isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [2,''];
						};
						if (_hoseReg isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [3,'a3\supplies_f_enoch\bags\data\b_cur_01_co.paa'];
						};
					} else {
						if (_hose1 isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [1,''];
						};
						if (_hoseAPR isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [2,''];
						};
						if (_hoseReg isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [3,''];
						};
					};
				};
			};
			if ((backpack _QS_cO) isEqualTo 'B_SCBA_01_F') then {
				(getObjectTextures (backpackContainer _QS_cO)) params ['','_hoseAPR','_hoseReg'];
				if ((toLowerANSI (goggles _QS_cO)) in [
					'g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f','g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f'
				]) then {
					if (_hoseAPR isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa') then {
						(backpackContainer _QS_cO) setObjectTextureGlobal [1,'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa'];
					};
					if (_hoseReg isNotEqualTo '') then {
						(backpackContainer _QS_cO) setObjectTextureGlobal [2,''];
					};
				} else {
					if ((toLowerANSI (goggles _QS_cO)) in ['g_regulatormask_f']) then {
						if (_hoseAPR isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [1,''];
						};
						if (_hoseReg isNotEqualTo 'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [2,'a3\supplies_f_enoch\bags\data\b_scba_01_co.paa'];
						};
					} else {
						if (_hoseAPR isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [1,''];
						};
						if (_hoseReg isNotEqualTo '') then {
							(backpackContainer _QS_cO) setObjectTextureGlobal [2,''];
						};
					};
				};
			};
		};
		// Update Mass/Center Of Mass
		if (
			(alive _cursorObject) &&
			{((['LandVehicle','Ship'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
			{((_cursorObject distance2D _QS_player) < 30)} &&
			{((attachedObjects _cursorObject) isNotEqualTo (_cursorObject getVariable ['QS_logistics_attachedobjects',[]]))} &&
			{(({(alive _x) && (isPlayer _x)} count (crew _cursorObject)) isEqualTo 0)}
		) then {
			_cursorObject setVariable ['QS_logistics_attachedobjects',attachedObjects _cursorObject,_false];
			[_cursorObject,_true,_true] call _fn_updateCenterOfMass;
		};
		if (
			(alive _QS_cO) &&
			{((['LandVehicle','Ship'] findIf { _QS_cO isKindOf _x }) isNotEqualTo -1)} &&
			{(local _QS_cO)} &&
			{((attachedObjects _QS_cO) isNotEqualTo (_QS_cO getVariable ['QS_logistics_attachedobjects',[]]))}
		) then {
			_QS_cO setVariable ['QS_logistics_attachedobjects',attachedObjects _QS_cO,_false];
			[_QS_cO,_true,_true] call _fn_updateCenterOfMass;
		};

		if (QS_player getVariable ['QS_toggle_visibleLaser',_false]) then {
			_currentWeapon = currentWeapon QS_player;
			_weaponItems = (QS_player weaponAccessories _currentWeapon) apply {toLowerANSI _x};
			if (
				(_currentWeapon isNotEqualTo '') &&
				{(_currentWeapon isEqualTo (binocular QS_player))}
			) then {
				_weaponItems = ((binocularItems QS_player) + (binocularMagazine QS_player)) apply {toLowerANSI _x};
			};
			if (
				((_emitters findAny _weaponItems) isEqualTo -1) ||
				{((((magazines QS_player) apply {toLowerANSI _x}) findAny _laserBatteryClasses) isEqualTo -1)}
			) then {
				QS_player setVariable ['QS_toggle_visibleLaser',_false,_true];
			};
		};
		
		if (QS_player getUnitTrait 'uavhacker') then {
			_uavEntity = objNull;
			{
				_uavEntity = _x;
				if (
					(_uavEntity getVariable ['QS_hidden',FALSE]) ||
					{((typeOf _uavEntity) in ['b_ship_gun_01_f','b_ship_mrls_01_f'])}
				) then {
					if (QS_player isUAVConnectable [_uavEntity,_true]) then {
						QS_player disableUAVConnectability [_uavEntity,_true];
					};
					{
						if (QS_player isUAVConnectable [_x,_true]) then {
							QS_player disableUAVConnectability [_x,_true];
						};
					} forEach (crew _uavEntity);
				};
			} forEach allUnitsUav;
		};
		
	};
	
	/*/========== Fuel consumption module/*/
	
	if (_QS_module_fuelConsumption) then {
		if (_timeNow > _QS_module_fuelConsumption_checkDelay) then {
			if (
				(alive _QS_cO) &&
				{(local _QS_cO)} &&
				{(!(_QS_cO isKindOf 'CAManBase'))} &&
				{((fuel _QS_cO) > 0)} &&
				{(!(_QS_cO getVariable ['QS_vehicle_fuelConsumption',_false]))}
			) then {
				if (_QS_module_fuelConsumption_vehicle isNotEqualTo _QS_cO) then {
					_QS_module_fuelConsumption_vehicle = _QS_cO;
				};
				if (
					(isEngineOn _QS_module_fuelConsumption_vehicle) &&
					{((vectorMagnitude (velocity _QS_module_fuelConsumption_vehicle)) > 1)}
				) then {
					_QS_module_fuelConsumption_lower = _QS_module_fuelConsumption_factor_1;
					_QS_module_fuelConsumption_upper = [_QS_module_fuelConsumption_factor_4,_QS_module_fuelConsumption_factor_3] select (
						(!isNull (getSlingLoad _QS_module_fuelConsumption_vehicle)) || 
						{((getVehicleCargo _QS_module_fuelConsumption_vehicle) isNotEqualTo [])} ||				// This is simplistic and can be made more sophisticated if desired, at cost of dev time of course!
						{((ropeAttachedObjects _QS_module_fuelConsumption_vehicle) isNotEqualTo [])}
					);
					_thrust = _QS_module_fuelConsumption_vehicle getSoundController (['thrust','rotorthrust'] select (_QS_module_fuelConsumption_vehicle isKindOf 'Helicopter'));
					_fuelConversion = linearConversion [0,1,_thrust,_QS_module_fuelConsumption_lower,_QS_module_fuelConsumption_upper,_true];
					_QS_module_fuelConsumption_vehicle setFuel (1 min ((fuel _QS_module_fuelConsumption_vehicle) - (1 - _fuelConversion)) max 0);
				};
			};
			_QS_module_fuelConsumption_checkDelay = time + _QS_module_fuelConsumption_delay;
		};
	};
	
	/*/============ Module Services/*/

	if (_QS_module_services) then {
		if (_timeNow > _QS_module_services_checkDelay) then {
			if (
				(alive _QS_cO) &&
				{((['Air','LandVehicle','Ship','StaticWeapon'] findIf {(_QS_cO isKindOf _x)}) isNotEqualTo -1)} &&
				{(((vectorMagnitude (velocity _QS_cO)) * 3.6) < 1)} &&
				{((isTouchingGround _QS_cO) || (_QS_cO isKindOf 'Ship'))} &&
				{((((getPosASL _QS_cO) # 2) > -1) || (_QS_cO isKindOf 'Ship'))} &&
				{(isNull curatorCamera)} &&
				{(([_QS_cO,sizeOf (typeOf _QS_cO),_true] call _fn_isNearServiceCargo) isNotEqualTo [])} &&
				{(!(localNamespace getVariable ['QS_service_blocked',_false]))}
			) then {
				if (scriptDone (missionNamespace getVariable ['QS_module_services_script',_scriptNull])) then {
					missionNamespace setVariable ['QS_module_services_script',([_QS_cO,([_QS_cO,sizeOf (typeOf _QS_cO),_true] call _fn_isNearServiceCargo)] spawn _fn_clientVehicleService),_false];
				};
			};
			_QS_module_services_checkDelay = _timeNow + _QS_module_services_delay;
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
				if !(uiNamespace isNil 'QS_RD_client_dialog_crewIndicator') then {
					_QS_crewIndicator = (uiNamespace getVariable 'QS_RD_client_dialog_crewIndicator') displayCtrl _QS_crewIndicatorIDC;
					if (alive _QS_cO) then {
						_fullCrew = fullCrew _QS_cO;
						if (
							(_fullCrew isNotEqualTo []) &&
							(({(alive (_x # 0))} count _fullCrew) > 1)
						) then {
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
										_genericResult = QS_hashmap_configfile getOrDefaultCall [
											format ['cfgvehicles_%1_icon',toLowerANSI (typeOf _unit)],
											{getText ((configOf _unit) >> 'icon')},
											_true
										];
										_roleIcon = format ['a3\ui_f\data\map\vehicleicons\%1_ca.paa',_genericResult];
										_unit setVariable ['QS_unit_role_icon',_roleIcon,_false];
									};
									_roleIcon = str _roleIcon;
								};
								_unitName = name _unit;
								if (
									((toLower _unitName) isNotEqualTo 'error: no unit') &&
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
													_roleImg = [_QS_crewIndicator_imgCargo,_QS_crewIndicator_imgGunner] select _personTurret;
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

	if (_groupCleanup) then {
		if (_timeNow > _groupCleanupCheckDelay) then {
			_groupCleanupCheckDelay = _timeNow + _groupCleanupDelay;
			// Handle Groups
			_allGroups = allGroups select {(!(_x getVariable ['QS_cleanup_protected',_false]))};
			{
				if (local _x) then {
					if (_x isNil 'QS_allGroups_reg') then {
						_x setVariable ['QS_allGroups_reg',_true,_false];
						if (!isGroupDeletedWhenEmpty _x) then {
							_x deleteGroupWhenEmpty _true;
						};
					};
					if ((units _x) isEqualTo []) then {
						if (_x isNil 'BIS_dg_reg') then {
							if (!isGroupDeletedWhenEmpty _x) then {
								_x deleteGroupWhenEmpty _true;
							};
						} else {
							// to do
							// handle now-local player groups
							if (!isGroupDeletedWhenEmpty _x) then {
								_x deleteGroupWhenEmpty _true;
							};
						};
					};
				} else {
					if (_x isNil 'QS_allGroups_reg') then {
						_x setVariable ['QS_allGroups_reg',_true,_false];
						_x addEventHandler [
							'Local',
							{
								params ['_grp'];
								if (
									(local _grp) &&
									{(!(_grp getVariable ['QS_cleanup_protected',FALSE]))} &&
									{(!isGroupDeletedWhenEmpty _grp)}
								) then {
									_grp deleteGroupWhenEmpty TRUE;
								};
							}
						];
					};
				};
			} forEach _allGroups;
		};
	};	

	if (_QS_clientDynamicGroups) then {
		if (
			(!_groupLocking) &&
			{(local (group _QS_player))} &&
			{((group _QS_player) getVariable [_QS_joinGroup_privateVar,_false])}
		) then {
			(group _QS_player) setVariable [_QS_joinGroup_privateVar,_false,_true];
		};
		if (_timeNow > _QS_clientDynamicGroups_checkDelay) then {
			_QS_playerGroup = group _QS_player;
			if ((_QS_playerGroup getVariable ['BIS_dg_ins','']) isEqualTo '') then {
				_QS_playerGroup setVariable ['BIS_dg_ins',(['LoadRandomInsignia'] call BIS_fnc_dynamicGroups),_true];
			};
			if (isNull (findDisplay 60490)) then {
				if ((count _allPlayers) > 1) then {
					if (
						(_QS_player isEqualTo (leader _QS_playerGroup)) &&
						{((count (units (group _QS_player))) > 1)} //&&
						//{((backpack _QS_player) in _radioBags)}					// gives some use to the radio backpacks but how would players know to use it?
					) then {
						if (!(_QS_player getUnitTrait 'QS_trait_leader')) then {
							_QS_player setUnitTrait ['QS_trait_leader',_true,_true];
						};
					} else {
						if (_QS_player getUnitTrait 'QS_trait_leader') then {
							_QS_player setUnitTrait ['QS_trait_leader',_false,_true];
						};
					};
				};
				_QS_clientDynamicGroups_checkDelay = _timeNow + _QS_clientDynamicGroups_delay;
			} else {
				if (_QS_isAdmin && {_groupLocking}) then {
					{
						if (
							(_x getVariable [_QS_joinGroup_privateVar,_false]) &&
							{_x isNotEqualTo _QS_playerGroup}
						) then {
							_x setVariable [_QS_joinGroup_privateVar,_false,_false];
						};
					} forEach (groups (_QS_player getVariable ['QS_unit_side',_west]));
				};
			};
			if (!(_isLeader)) then {
				if (_QS_player isEqualTo (leader _QS_playerGroup)) then {
					_isLeader = _true;
					if (
						(_squadName isNotEqualTo '') &&
						{((groupId _QS_playerGroup) isNotEqualTo _squadName)}
					) then {
						_QS_playerGroup setGroupIdGlobal [_squadName];
					};
				};
			} else {
				if (!(_QS_player isEqualTo (leader _QS_playerGroup))) then {
					_isLeader = _false;
				};
			};
		};
		if (_QS_groupWaypoint) then {
			if (
				(_QS_player isEqualTo (leader (group _QS_player))) &&
				{(({(isPlayer _x)} count (units (group _QS_player))) > 1)} &&
				{visibleMap} &&
				{(customWaypointPosition isNotEqualTo ((group _QS_player) getVariable ['QS_GRP_waypoint',[]]))}
			) then {
				if (_timeNow > (_QS_player getVariable ['QS_GRP_waypoint_delay',-1])) then {
					_QS_player setVariable ['QS_GRP_waypoint_delay',_timeNow + 3,_false];
					(group _QS_player) setVariable ['QS_GRP_waypoint',customWaypointPosition,_true];
				};
			};
		};
	};
	
	/*/=========== ROBOCOP /*/

	if (_QS_clientATManager) then {
		if (_timeNow > _QS_clientATManager_delay) then {
			if (!isNull (laserTarget _QS_player)) then {
				_QS_laserTarget = laserTarget _QS_player;
				if ([_QS_laserTarget,'SAFE',_true] call _fn_inZone) then {
					deleteVehicle _QS_laserTarget;
				};
			};
			if (!isNull (laserTarget _QS_v2)) then {
				_QS_laserTarget = laserTarget _QS_v2;
				if (local _QS_laserTarget) then {
					if ([_QS_laserTarget,'SAFE',_true] call _fn_inZone) then {
						deleteVehicle _QS_laserTarget;
					};
				};
			};
			if !(_QS_player isNil 'QS_tto') then {
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
							private _QS_terminalVelocity = _this # 1;
							private _QS_exitingEnforcedVehicle = FALSE;
							private _QS_exitingEnforcedVehicle_loop = nil;
							private _QS_tto = player getVariable ['QS_tto',0];
							private _QS_v = objectParent player;
							for '_x' from 0 to 1 step 0 do {
								_QS_tto = player getVariable ['QS_tto',0];
								_QS_v = objectParent player;
								if (!isNull _QS_v) then {
									if (player in [
										driver _QS_v,
										gunner _QS_v,
										commander _QS_v,
										(_QS_v turretUnit [0]),
										(_QS_v turretUnit [1]),
										(_QS_v turretUnit [2]),
										(effectiveCommander _QS_v),
										currentPilot _QS_v
									]) then {
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
										[0,player] call QS_fnc_eventAttach;
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
								uiSleep 0.1;
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
	
	if (
		(
			(_cameraView in ['EXTERNAL','GROUP']) &&
			{((_QS_player getVariable 'QS_1PV') # 0)} &&
			{(_lifeState in ['HEALTHY','INJURED'])}
		) ||
		{
			_plane1PV &&
			{(_QS_v2 isKindOf 'Plane')} &&
			{(_QS_player isEqualTo (currentPilot _QS_v2))}
		}
	) then {
		_QS_player switchCamera 'INTERNAL';
	};
	
	/*/========== Boot non-pilots out of pilot seats where necessary/*/
	
	if (_pilotCheck) then {
		if ((count _allPlayers) > 20) then {
			if (_QS_v2 isKindOf 'Air') then {
				if (!(_QS_v2TypeL in (['b_heli_light_01_f'] + QS_core_classNames_steerablePs))) then {
					if (
						(_QS_player in [driver _QS_v2,currentPilot _QS_v2]) &&
						{((!(_QS_player getUnitTrait 'QS_trait_pilot')) && {(!(_QS_player getUnitTrait 'QS_trait_fighterPilot'))})} &&
						{(((getPosATL _QS_v2) # 2) < 5)}
					) then {
						moveOut _QS_player;
						(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,localize 'STR_QS_Hints_003',[],(serverTime + 20),_true,localize 'STR_QS_Hints_004',_false];
					};
				} else {
					if (
						(!(_QS_v2TypeL in QS_core_classNames_steerablePs)) &&
						{(_QS_player in [(driver _QS_v2)])} &&
						{((!(_QS_player getUnitTrait 'QS_trait_pilot')) && {(!(_QS_player getUnitTrait 'QS_trait_fighterPilot'))})} &&
						{(((getPosATL _QS_v2) # 2) < 5)}
					) then {
						moveOut _QS_player;
						(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,localize 'STR_QS_Hints_003',[],(serverTime + 20),_true,localize 'STR_QS_Hints_004',_false];					
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
								if (!_inSafezone) then {
									_QS_currentTimeOnGround = _QS_currentTimeOnGround + 1;
									if (_QS_currentTimeOnGround > _QS_maxTimeOnGround) then {
										forceRespawn _QS_player;
									} else {
										if (_QS_currentTimeOnGround > _QS_warningTimeOnGround) then {
											(missionNamespace getVariable 'QS_managed_hints') pushBack [5,_false,10,-1,localize 'STR_QS_Hints_005',[],(serverTime + 20),_true,localize 'STR_QS_Hints_004',_false];
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
					if ((_QS_uiTime - _QS_afkTimer) >= (uiNamespace getVariable ['QS_client_afkTimeout',-1])) then {
						if (!(_QS_isAdmin)) then {
							if (!(_kicked)) then {
								_kicked = _true;
								with uiNamespace do {
									0 spawn {
										[
											localize 'STR_QS_Menu_115',
											localize 'STR_QS_Menu_109',
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
							{((_QS_cameraPosition2D distance2D [(positionCameraToWorld [0,0,0]) # 0,(positionCameraToWorld [0,0,0]) # 2]) > 1)} ||
							{(!isNull curatorCamera)}
						) then {
							uiNamespace setVariable ['QS_client_afkTimeout',diag_tickTime];
							_QS_afkTimer_playerPos = _QS_posWorldPlayer;
						};
					};
				};
			};
		};
	};

	/*/===== Leaderboards module/*/
	
	if (_QS_module_leaderboards) then {
		if (_timeNow > _QS_module_leaderboards_checkDelay) then {
			if (
				_QS_module_leaderboards_pilots &&
				{_iAmPilot}
			) then {
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
				_clientDifficulty = _QS_player getVariable ['QS_clientDifficulty',[]];
				if (!(_clientDifficulty # 0)) then {
					_QS_player setVariable ['QS_stamina_multiplier',[_false,(_timeNow + 900)],_false];
				} else {
					if (
						(!((_QS_player getVariable 'QS_stamina_multiplier') # 0)) &&
						{(_timeNow > ((_QS_player getVariable 'QS_stamina_multiplier') # 1))}
					) then {
						_QS_player setVariable ['QS_stamina_multiplier',[_true,_timeNow],_false];
					};
				};
				_QS_reportDifficulty_checkDelay = _timeNow + _QS_reportDifficulty_delay;
			};
		};		
	};

	/*/========== Animation state manager/*/

	if (_QS_module_animState) then {
		if (_timeNow > _QS_module_animState_checkDelay) then {
			_QS_animState = toLowerANSI (animationState _QS_player);
			if (
				(_QS_animState in ['ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwrfldnon_carried_still','ainjpfalmstpsnonwnondnon_carried_up']) &&
				{(!(_QS_player getVariable 'QS_RD_interacting'))} &&
				{(_QS_player getVariable 'QS_animDone')}
			) then {
				uiSleep 0.25;
				if (
					(isNull (attachedTo _QS_player)) ||
					{(!alive (attachedTo _QS_player))}
				) then {
					['switchMove',_QS_player,(['','acts_injuredlyingrifle02'] select (_lifeState isEqualTo 'INCAPACITATED'))] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
				};
			};
			if (
				(_QS_animState in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still','amovppnemstpsnonwnondnon']) &&
				{(isNull (attachedTo _QS_player))}
			) then {
				['switchMove',_QS_player,(['','acts_injuredlyingrifle02'] select (_lifeState isEqualTo 'INCAPACITATED'))] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
			};
			_QS_module_animState_checkDelay = _timeNow + _QS_module_animState_delay;
		};
	};
	
	/*/========== HUD Manager/*/

	if (_QS_module_manageHUD) then {
		if (_timeNow > _QS_module_manageHUD_checkDelay) then {
			if (
				(_lifeState isNotEqualTo 'INCAPACITATED') &&
				{(shownHud isNotEqualTo (missionNamespace getVariable (format ['QS_allowedHUD_%1',_QS_side])))}
			) then {
				showHud (missionNamespace getVariable [(format ['QS_allowedHUD_%1',_QS_side]),WEST]);
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
				if (
					(alive _myV) &&
					{(_QS_v2 isNotEqualTo _myV)} &&
					{((_QS_player distance2D _myV) > 100)}
				) then {
					_genericResult = QS_hashmap_configfile getOrDefaultCall [
						format ['cfgvehicles_%1_hiddenselectionstextures',toLowerANSI (typeOf _myV)],
						{getArray ((configOf _myV) >> 'hiddenSelectionsTextures')},
						_true
					];
					{
						_myV setObjectTextureGlobal [_forEachIndex,_x];
					} forEach _genericResult;
					_myV setVariable ['QS_ClientVTexture_owner',nil,_true];
					_QS_player setVariable ['QS_ClientVTexture',[_objNull,_puid,'',(_timeNow + 5)],_true];
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
					_unit1 = _x;
					if (alive _unit1) then {
						_healHandlers = _unit1 getEventHandlerInfo ['HandleHeal',0];
						if (_healHandlers isNotEqualTo []) then {
							if ((_healHandlers # 2) isEqualTo 0) then {
								_unit1 addEventHandler [
									'HandleHeal',
									{
										if ((local (_this # 0)) || {(local (_this # 1))}) then {
											_this spawn (missionNamespace getVariable 'QS_fnc_clientEventHandleHeal');
										};
									}
								];
							};
						};
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
				if ((['QS_trait_pilot','uavhacker','QS_trait_HQ','QS_trait_fighterPilot','QS_trait_CAS','QS_trait_JTAC'] findIf { _QS_player getUnitTrait _x }) isEqualTo -1) then {
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
		if (
			((getPlayerChannel _QS_player) in [0,1]) &&
			{(!_QS_isAdmin)}
		) then {
			setCurrentChannel 5;
		};
		if (
			(currentChannel isEqualTo 6) &&
			{(!isNull (findDisplay 55))} &&
			{(!_QS_isAdmin)}
		) then {
			50 cutText [localize 'STR_QS_Text_032','PLAIN DOWN'];
			setCurrentChannel 5;
		};
		if (
			(isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) &&
			{(currentChannel isEqualTo 7)} &&
			{(!isNull (findDisplay 55))} &&
			{((['QS_trait_pilot','uavhacker','QS_trait_HQ','QS_trait_fighterPilot','QS_trait_CAS','QS_trait_JTAC'] findIf { _QS_player getUnitTrait _x }) isEqualTo -1)} &&
			{(!_QS_isAdmin)}
		) then {
			// TO DO: cutText message here for why channel switched?
			setCurrentChannel 5;
		};
		if (
			(currentChannel isNotEqualTo 5) &&
			{(!isNull (findDisplay 55))} &&
			{((_QS_player getSlotItemName 611) isEqualTo '')}
		) then {
			50 cutText [localize 'STR_QS_Text_003','PLAIN DOWN'];
			setCurrentChannel 5;
		};
		if (
			(_QS_player getVariable ['QS_client_radioDisabled',_false]) &&
			{((_QS_player getSlotItemName 611) isNotEqualTo '')}
		) then {
			_QS_player unassignItem (_QS_player getSlotItemName 611);
		};
	};
	
	/*/========== Dynamic Sway/Recoil Module/*/

	if (_QS_module_swayManager) then {
		if (_QS_uiTime > _QS_module_swayManager_checkDelay) then {
			_QS_module_swayManager_managed = _false;
			_QS_customAimCoef = getCustomAimCoef _QS_player;
			_QS_recoilCoef = unitRecoilCoefficient _QS_player;
			_QS_recommendedAimCoef = ((_QS_player getVariable ['QS_stamina',[0,1]]) # 1);
			_QS_recommendedRecoil = 1;
			// Primary Weapon
			if (
				(isNull _objectParent) &&
				{((toLowerANSI (currentWeapon _QS_player)) in _QS_module_swayManager_heavyWeapons)} &&
				{((stance _QS_player) in ['STAND','CROUCH'])} &&
				{(!(isWeaponDeployed _QS_player))} &&
				{(!(isWeaponRested _QS_player))} &&
				{(!(canDeployWeapon _QS_player))}
			) then {
				_QS_module_swayManager_managed = _true;
				_QS_recommendedAimCoef = [_QS_module_swayManager_heavyWeaponCoef_crouch,_QS_module_swayManager_heavyWeaponCoef_stand] select ((stance _QS_player) isEqualTo 'STAND');
				_QS_recommendedRecoil = [_QS_module_swayManager_recoilCoef_crouch,_QS_module_swayManager_recoilCoef_stand] select ((stance _QS_player) isEqualTo 'STAND');
			};
			// Launcher Weapon
			if (
				(!_QS_module_swayManager_managed) &&
				{(isNull _objectParent)} &&
				{((secondaryWeapon _QS_player) isNotEqualTo '')} &&
				{((currentWeapon _QS_player) isEqualTo (secondaryWeapon _QS_player))} &&
				{(!(_QS_player getUnitTrait 'QS_trait_AT'))} &&
				{(!(isWeaponDeployed _QS_player))} &&
				{(!(isWeaponRested _QS_player))} &&
				{(!(canDeployWeapon _QS_player))}
			) then {
				_QS_recommendedAimCoef = _QS_module_swayManager_secWepSwayCoef;
				_QS_recommendedRecoil = [2,3] select ((stance _QS_player) isEqualTo 'STAND');
			};
			if (_QS_customAimCoef isNotEqualTo _QS_recommendedAimCoef) then {
				_QS_player setCustomAimCoef _QS_recommendedAimCoef;
			};
			if (_QS_recoilCoef isNotEqualTo _QS_recommendedRecoil) then {
				_QS_player setUnitRecoilCoefficient _QS_recommendedRecoil;
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
	
	/*/========== SC Assistant Module/*/

	if (_QS_module_scAssistant) then {
		if (_QS_uiTime > _QS_module_scAssistant_checkDelay) then {
			if ((missionNamespace getVariable ['QS_virtualSectors_data_public',[]]) isEqualType []) then {
				if ((missionNamespace getVariable 'QS_virtualSectors_data_public') isNotEqualTo []) then {
					_QS_virtualSectors_data_public = missionNamespace getVariable ['QS_virtualSectors_data_public',[]];
					{
						_sectorFlag = (_x # 17) # 0;
						_sectorPhase = _x # 26;
						if (
							(_sectorFlag isEqualType _objNull) &&
							{(!isNull _sectorFlag)} &&
							{(_sectorPhase isEqualType 0)} &&
							{((flagAnimationPhase _sectorFlag) isNotEqualTo _sectorPhase)}
						) then {
							_sectorFlag setFlagAnimationPhase _sectorPhase;
						};
					} forEach _QS_virtualSectors_data_public;
				};
			};
			_QS_module_scAssistant_checkDelay = _QS_uiTime + _QS_module_scAssistant_delay;
		};
	};
	
	/*/========== Module Urban AOs/*/
	
	if (_QS_isTanoa) then {
		if (_QS_uiTime > _QS_tanoa_checkDelay) then {
			if (missionNamespace getVariable ['QS_customAO_GT_active',_false]) then {
				if (!(_QS_inGeorgetown)) then {
					if (_QS_player inPolygon _QS_georgetown_polygon) then {
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
							50 cutText [(format ['%2 (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa')),localize 'STR_QS_Text_033']),'PLAIN DOWN',0.25];
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
					if (
						(!isNull _objectParent) &&
						{(local _QS_v2)} &&
						{(_QS_v2 isKindOf 'LandVehicle')} &&
						{(isNull (attachedTo _QS_v2))} &&
						{(isNull (isVehicleCargo _QS_v2))} &&
						{((fuel _QS_v2) > 0)}
					) then {
						_QS_v2 setFuel 0;
					};
					if ((!(_QS_player inPolygon _QS_georgetown_polygon)) || {(!isNull _objectParent)} || {((_posATLPlayer # 2) >= 50)}) then {
						_QS_inGeorgetown = FALSE;
						50 cutText [(format ['%2 (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa')),localize 'STR_QS_Text_034']),'PLAIN DOWN',0.25];
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
					50 cutText [(format ['%2 (%1) ...',(['Kavala','Georgetown'] select (_QS_worldName isEqualTo 'Tanoa')),localize 'STR_QS_Text_034']),'PLAIN DOWN',0.25];
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
				missionNamespace setVariable ['QS_client_groupIndicator_units',((nearestObjects [QS_player,_QS_module_groupIndicator_types,_QS_module_groupIndicator_radius]) select _QS_module_groupIndicator_filter),_false];
			};
			_QS_module_groupIndicator_checkDelay = _QS_uiTime + _QS_module_groupIndicator_delay;
		};
	};
	
	/*/===== Medic Revive icons/*/
	
	if (QS_player getUnitTrait 'medic') then {
		if (_QS_uiTime > _QS_medicIcons_checkDelay) then {
			[QS_player,500,_fn_enemySides] spawn _fn_getNearbyIncapacitated;
			_QS_medicIcons_checkDelay = _QS_uiTime + _QS_medicIcons_delay;
		};
	};
	
	/*/===== Client AI/*/
	
	if (_QS_module_clientAI) then {
		if (_QS_uiTime > _QS_module_clientAI_checkDelay) then {
			if (
				(_QS_player isEqualTo (leader (group _QS_player))) &&
				{(((units (group _QS_player)) findIf {((alive _x) && (!(isPlayer _x)) && (!(unitIsUav _x)))}) isNotEqualTo -1)} &&
				{(scriptDone _QS_module_clientAI_script)}
			) then {
				_QS_module_clientAI_script = 0 spawn _fn_clientAIBehaviours;
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
					if (
						(
							((unitRecoilCoefficient _QS_player) < 1) && 
							((unitRecoilCoefficient _QS_player) isNotEqualTo -1)
						) || 
						{((getCustomAimCoef _QS_player) < 0.1)} || 
						{((getAnimSpeedCoef _QS_player) > 1.1)}
					) then {
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
				_commandingMenu = toLowerANSI commandingMenu;
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
										if ((count (allControls (uiNamespace getVariable 'BIS_fnc_arsenal_display'))) > 213) then {
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
										if (((getText (_ctrlCfg >> 'action')) isNotEqualTo '') || {((getText (_ctrlCfg >> 'onButtonClick')) isNotEqualTo '')}) exitWith {
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
									if (
										(!(_opsec_actionTitle in _opsec_actionWhitelist)) &&
										{(!(_opsec_actionTitle in QS_client_dynamicActionText))} &&
										{(!(_puid in (['DEVELOPER'] call _fn_uidStaff)))}
									) then {
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
						if (_opsec_actionParams isNotEqualTo []) then {
							_opsec_actionParams params [
								'_opsec_actionTitle',
								'_opsec_actionCode'
							];
							if (
								(!(_opsec_actionTitle in _opsec_actionWhitelist)) &&
								{(!(_opsec_actionTitle in QS_client_dynamicActionText))} &&
								{(!(_puid in (['DEVELOPER'] call _fn_uidStaff)))}
							) then {
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
						_QS_buttonCtrl ctrlSetText (localize 'STR_QS_Menu_009');
						_QS_buttonCtrl buttonSetAction _QS_buttonAction;
						_QS_buttonCtrl ctrlSetTooltip (format ['%1 %2 %3 %4',localize 'STR_QS_Utility_011','&',localize 'STR_QS_Utility_012',localize 'STR_QS_Menu_009']);
						_QS_buttonCtrl ctrlSetBackgroundColor [1,0.5,0.5,1];
						_QS_buttonCtrl ctrlCommit 0;
					};
				} forEach [16700,2];
				_QS_buttonCtrl = _d49 displayCtrl 103;
				_QS_buttonCtrl ctrlEnable (([_false,_true] select _roleSelectionSystem) && _RSS_MenuButton);
				_QS_buttonCtrl ctrlShow (([_false,_true] select _roleSelectionSystem) && _RSS_MenuButton);
				_QS_buttonCtrl ctrlSetText (['',localize 'STR_QS_Role_001'] select _roleSelectionSystem);
				if (_roleSelectionSystem) then {
					_QS_buttonCtrl buttonSetAction _QS_buttonAction2;
					_QS_buttonCtrl ctrlSetTooltip (localize 'STR_QS_Role_029');
					_QS_buttonCtrl ctrlSetBackgroundColor [1,0.5,0.5,1];
					_QS_buttonCtrl ctrlCommit 0;
				};
				(_d49 displayCtrl 523) ctrlSetText (format ['%1',_profileName]);
				(_d49 displayCtrl 109) ctrlSetText (format ['%1',_roleDisplayName]);
				(_d49 displayCtrl 104) ctrlEnable _true;
				(_d49 displayCtrl 104) ctrlSetText ([localize 'STR_QS_Menu_010',localize 'STR_QS_Menu_011'] select _roleSelectionSystem);
				(_d49 displayCtrl 104) ctrlSetTooltip ([localize 'STR_QS_Menu_012',localize 'STR_QS_Menu_013'] select _roleSelectionSystem);
				(_d49 displayCtrl 1005) ctrlSetText (format ['%1 - A3 %2',_QS_missionVersion,(format ['%1.%2',(_QS_productVersion # 2),(_QS_productVersion # 3)])]);
			};
		} else {
			_d49 = findDisplay 49;
			if (isNull _d49) then {
				if (
					(!isStreamFriendlyUIEnabled) &&
					{(!shownChat)}
				) then {
					showChat _true;
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
			_QS_module_soundControllers_checkDelay = _QS_uiTime + (_QS_module_soundControllers_delay + (random 3));
		};
	};
	if (_QS_module_playerInArea) then {
		if (_QS_uiTime > _QS_module_playerInArea_checkDelay) then {
			if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_base_marker')) < 1000) then {
				if (!(_QS_player getVariable ['QS_client_inBaseArea',_false])) then {
					_QS_player setVariable ['QS_client_inBaseArea',_true,_false];
				};
				if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
					_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
				};
				if (_QS_player getVariable ['QS_client_inDestroyerArea',_false]) then {
					_QS_player setVariable ['QS_client_inDestroyerArea',_false,_false];
					if (_QS_destroyerEnabled isNotEqualTo 0) then {
						if (!isNull (missionNamespace getVariable ['QS_destroyerObject',_objNull])) then {
							if (simulationEnabled (missionNamespace getVariable 'QS_destroyerObject')) then {
								(missionNamespace getVariable 'QS_destroyerObject') enableSimulation _false;
								{
									if (!isNull (_x # 0)) then {
										if (simulationEnabled (_x # 0)) then {
											(_x # 0) enableSimulation _false;
										};
									};
								} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['bis_carrierParts',[]]);
							};
						};
					};
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
					if (_QS_player getVariable ['QS_client_inDestroyerArea',_false]) then {
						_QS_player setVariable ['QS_client_inDestroyerArea',_false,_false];
						if (_QS_destroyerEnabled isNotEqualTo 0) then {
							if (!isNull (missionNamespace getVariable ['QS_destroyerObject',_objNull])) then {
								if (simulationEnabled (missionNamespace getVariable 'QS_destroyerObject')) then {
									(missionNamespace getVariable 'QS_destroyerObject') enableSimulation _false;
									{
										if (!isNull (_x # 0)) then {
											if (simulationEnabled (_x # 0)) then {
												(_x # 0) enableSimulation _false;
											};
										};
									} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['bis_carrierParts',[]]);
								};
							};
						};
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
						if (_QS_player getVariable ['QS_client_inDestroyerArea',_false]) then {
							_QS_player setVariable ['QS_client_inDestroyerArea',_false,_false];
							if (_QS_destroyerEnabled isNotEqualTo 0) then {
								if (!isNull (missionNamespace getVariable ['QS_destroyerObject',_objNull])) then {
									if (simulationEnabled (missionNamespace getVariable 'QS_destroyerObject')) then {
										(missionNamespace getVariable 'QS_destroyerObject') enableSimulation _false;
										{
											if (!isNull (_x # 0)) then {
												if (simulationEnabled (_x # 0)) then {
													(_x # 0) enableSimulation _false;
												};
											};
										} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['bis_carrierParts',[]]);
									};
								};
							};
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
						if ((_QS_posWorldPlayer distance2D (markerPos 'QS_marker_destroyer_1')) < 200) then {
							if (_QS_player getVariable ['QS_client_inBaseArea',_false]) then {
								_QS_player setVariable ['QS_client_inBaseArea',_false,_false];
							};
							if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
								_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
							};
							if (!(_QS_player getVariable ['QS_client_inDestroyerArea',_false])) then {
								_QS_player setVariable ['QS_client_inDestroyerArea',_true,_false];
								if (_QS_destroyerEnabled isNotEqualTo 0) then {
									if (!isNull (missionNamespace getVariable ['QS_destroyerObject',_objNull])) then {
										if (simulationEnabled (missionNamespace getVariable 'QS_destroyerObject')) then {
											(missionNamespace getVariable 'QS_destroyerObject') enableSimulation _true;
											{
												if (!isNull (_x # 0)) then {
													if (simulationEnabled (_x # 0)) then {
														(_x # 0) enableSimulation _true;
													};
												};
											} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['bis_carrierParts',[]]);
										};
									};
								};
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
							if (_QS_player getVariable ['QS_client_inBaseArea',_false]) then {
								_QS_player setVariable ['QS_client_inBaseArea',_false,_false];
							};
							if (_QS_player getVariable ['QS_client_inFOBArea',_false]) then {
								_QS_player setVariable ['QS_client_inFOBArea',_false,_false];
							};
							if (_QS_player getVariable ['QS_client_inDestroyerArea',_false]) then {
								_QS_player setVariable ['QS_client_inDestroyerArea',_false,_false];
								if (_QS_destroyerEnabled isNotEqualTo 0) then {
									if (!isNull (missionNamespace getVariable ['QS_destroyerObject',_objNull])) then {
										if (simulationEnabled (missionNamespace getVariable 'QS_destroyerObject')) then {
											(missionNamespace getVariable 'QS_destroyerObject') enableSimulation _false;
											{
												if (!isNull (_x # 0)) then {
													if (simulationEnabled (_x # 0)) then {
														(_x # 0) enableSimulation _false;
													};
												};
											} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['bis_carrierParts',[]]);
										};
									};
								};
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
							if (_QS_module_playerInArea_delay isNotEqualTo 20) then {
								_QS_module_playerInArea_delay = 20;
							};
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
				(_hintsQueue deleteAt 0) params [
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
					if ((waypointVisible _x) isEqualType _true) then {
						if (!(waypointVisible _x)) then {
							_x setWaypointVisible _true;
						};
					};
					if ((waypointPosition _x) isEqualTo [0,0,0]) then {
						deleteWaypoint _x;
					};
				} forEach _QS_module_highCommand_waypoints;
			};
			_QS_module_highCommand_checkDelay = _QS_uiTime + _QS_module_highCommand_delay;
		};
	};
	if (_QS_module_objectScale) then {
		if (
			(_QS_uiTime > _QS_module_objectScale_checkDelay) ||
			(missionNamespace getVariable ['QS_system_updateObjectScale',_false])
		) then {
			_QS_module_objectScale_array = missionNamespace getVariable ['QS_module_objectScale',[]];
			if (_QS_module_objectScale_array isNotEqualTo []) then {
				{
					_x params [
						['_QS_module_objectScale_obj',objNull],
						['_QS_module_objectScale_scale',1]
					];
					if (
						(alive _QS_module_objectScale_obj) &&
						{(local _QS_module_objectScale_obj)} &&
						{((getObjectScale _QS_module_objectScale_obj) isNotEqualTo _QS_module_objectScale_scale)}
					) then {
						_QS_module_objectScale_obj setObjectScale _QS_module_objectScale_scale;
					};
				} forEach _QS_module_objectScale_array;
			};
			if (missionNamespace getVariable ['QS_system_updateObjectScale',_false]) then {
				missionNamespace setVariable ['QS_system_updateObjectScale',_false,_false];
			};
			_QS_module_objectScale_checkDelay = _QS_uiTime + _QS_module_objectScale_delay;
		};
	};
	if (_QS_module_gpsJammer) then {
		if (_QS_uiTime > _QS_module_gpsJammer_checkDelay) then {
			missionNamespace setVariable ['QS_module_gpsJammer_inArea',([0,_QS_player] call _fn_gpsJammer),_false];
			if (missionNamespace getVariable ['QS_module_gpsJammer_inArea',_false]) then {
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
		if (_QS_uiTime > _QS_module_roleAssignment_updateDelay) then {
			{
				if (_x getVariable ['QS_unit_role_netUpdate',_false]) then {
					['UPDATE_UI',_x] call _fn_roles;
				};
			} forEach _allPlayers;
			_QS_module_roleAssignment_updateDelay = _QS_uiTime + (random [5,10,15]);
		};
		if (_QS_side isNotEqualTo (_QS_player getVariable ['QS_unit_side',_west])) then {
			_QS_side = _QS_player getVariable ['QS_unit_side',_west];
			_enemysides = _QS_side call _fn_enemySides;
			_QS_player setVariable ['QS_unit_enemySides',_enemysides,_false];
			setPlayerRespawnTime ([15,5] select (_QS_side isEqualTo _west));
		};
		if (_playerRole isNotEqualTo (_QS_player getVariable ['QS_unit_role','rifleman'])) then {
			['UPDATE_UI',_QS_player] call _fn_roles;
			_playerRole = _QS_player getVariable ['QS_unit_role','rifleman'];
			_roleDisplayName = _QS_player getVariable ['QS_unit_role_displayName','Rifleman'];
			_roleDisplayNameL = toLower _roleDisplayName;
			if (_QS_player getUnitTrait 'QS_trait_pilot') then {
				_iAmPilot = _true;
				_pilotAtBase = _true;
				_difficultyEnabledRTD = difficultyEnabledRTD;
				_QS_player setVariable ['QS_PP_difficultyEnabledRTD',[_difficultyEnabledRTD,time],_true];
			};
		};
		if (
			(_QS_side in [_s0,_s2]) &&
			{((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID'])}
		) then {
			if (
				((_QS_player distance2D (markerPos 'QS_marker_aoCircle')) > (((markerSize 'QS_marker_aoCircle') # 0) * 1.1)) &&
				{(((markerAlpha 'QS_marker_aoCircle') > 0) || {((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) isEqualTo 'GRID')})} &&
				{(_QS_uiTime > (uiNamespace getVariable ['QS_client_respawnCooldown',-1]))}
			) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,20,-1,localize 'STR_QS_Hints_007',[],-1,TRUE,localize 'STR_QS_Hints_006',FALSE];		
				_QS_player setDamage [1,_true];
			};
			
			if (
				(!(cameraView in ['INTERNAL','GUNNER'])) &&
				{(_lifeState isNotEqualTo 'INCAPACITATED')}
			) then {
				_QS_player switchCamera 'INTERNAL';
			};
		};
	};
	// Client Logging
	if (
		_debugLogging &&
		{(_QS_uiTime > _debugLogging_delay)}
	) then {
		_debugLogging_delay = _QS_uiTime + _debugLogging_interval;
		diag_log format [
			'%1********** CLIENT REPORT (TOP) ********** System Time: %10 * %1Server Time: %11 * %1Server FPS: %12 * %1Client FPS: %2 * %1Frame: %3 * %1Frame-Time: %4 * %1Active Scripts: %5 * %1Active SQF Scripts: %6 * %1Active SQS Scripts: %7 * %1Active FSM Scripts: %8 * %1Active Zeus: %9 *%1********** CLIENT REPORT (BOTTOM) **********',
			endl,
			diag_fps,
			diag_frameNo,
			diag_deltaTime,
			diag_activeScripts,
			(diag_activeSQFScripts select [0,6]),
			diag_activeSQSScripts,
			diag_activeMissionFSMs,
			allCurators,
			systemTime,
			serverTime,
			(missionNamespace getVariable ['QS_server_fps',-1])
		];
	};
	uiSleep 0.1;
};
['Uho! It appears something has gone wrong. Please report this error code to staff:<br/><br/>456<br/><br/>Thank you for your assistance.',TRUE] call _fn_hint;