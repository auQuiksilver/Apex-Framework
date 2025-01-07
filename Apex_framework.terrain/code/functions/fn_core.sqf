/*/
File: fn_core.sqf
Author: 

	Quiksilver

Last modified: 

	9/10/2023 A3 2.14 by Quiksilver

Description:

	I&A Server Core
______________________________________________/*/

scriptName 'QS Server core thread';
scopeName '0';
private [
	'_QS_missionStart','_mainMission','_mainMissionList','_currentMainMission','_nextMission','_loopTimeout','_mainMissions',
	'_mainMissionActive','_sideMissions','_sideMissionActive','_sideMissionList','_sideMissionDelayFixed',
	'_sideMissionDelayRandom','_smDelay','_currentSideMission','_sideMissionListProxy','_sideMissionRefreshAt',
	'_unitCap','_pause','_mainMissionListProxy','_mainMissionRefreshAt','_enemyCAS','_timeLastCAS','_timeCASdelayFixed',
	'_timeCASdelayRandom','_timeNextCAS','_mainMissionRadius','_enemyGroundReinforceLimit','_enemyGroundReinforceLimitReal',
	'_playerThreshold','_enemyGroundReinforceCap','_enemyGroundReinforceSpawned','_spawned','_HVT_snipers','_HVT_vehicles',
	'_HVT_checkDelay','_HVT_targeting_system','_HVT_activeList','_HVT_list','_HVT_activeLaserTargets',
	'_HVT_element','_HVT_activeList','_HVT_laserDevice','_HVT_v','_QS_nearStatics','_QS_v','_QS_staticTypes',
	'_QS_v_target','_QS_v_target','_enemyVehicleReinforcements','_enemyVehicleReinforcementsSpawned','_enemyVehicleReinforcementsLimit',
	'_enemyVehicle_canReinforce','_enemyVehicleReinforceLimitReal','_enemyVehicleReinforceCap','_aoThreshold','_enemyVehicleReinforceChance',
	'_casThreshold','_enemyGroundReinforceThreshold','_enemyVehicleReinforceThreshold','_fps','_QS_distance','_distReal','_vRespawn_delay',
	'_vRespawn_checkDelay','_index','_v','_randomize','_configCode','_t','_pos','_dir','_isRespawning','_canRespawnAfter','_tt','_u','_array','_vpos',
	'_checkPlayerCount','_currentDeadMan','_checkFrequencyDefault','_checkFrequencyAccelerated',
	'_deadMenLimit','_deadMenDistCheck','_deadMenDist','_deadVehiclesLimit','_deadVehicleDistCheck',
	'_deadVehicleDist','_craterLimit','_craterDistCheck','_craterDist','_ruins','_ruinsLimit','_ruinsDistCheck','_ruinsDist',
	'_weaponHolderLimit','_weaponHolderDistCheck','_weaponHolderDist','_minesLimit','_minesDistCheck','_minesDist',
	'_staticsLimit','_staticsDistCheck','_staticsDist','_orphanedTriggers','_emptyGroups','_crateResetPos','_crate',
	'_crateArray','_crateIndex','_crateType','_backpackDroneLimit','_backpackDroneDistCheck','_backpackDroneDist',
	'_orphanedTriggerCount','_QS_weather','_QS_weather_stormDelay','_QS_weather_clearDelay','_w',
	'_QS_setFogDelay','_QS_revealLoudPlayers','_QS_revealLoudPlayers_timer',
	'_QS_revealLoudPlayers_delay','_grpLeader','_knownPlayers','_grp','_QS_fnc_reveal','_crate10Pos','_crate10Type','_QS_checkUAVsTime',
	'_QS_checkUAVsTime_delay','_QS_uavRespawnDelay','_aoTypes','_aoType','_fpsCheckDelay','_scMasterList','_regionMasterList','_aoList',
	'_defendAOActive','_mainMissionRegionListProxy','_mainMissionRegion','_ao','_defendAO','_defendAOScript','_nightVote','_nightVoteDelay',
	'_aoArray','_aoGraceTime','_QS_AOpos','_crate11Pos','_crate11Type','_crate12Pos','_crate12Type',
	'_QS_helmetCam','_QS_helmetCam_delay','_QS_helmetCam_checkDelay','_lfneck','_lfpilot','_lfTarget','_QS_nullPos','_pool','_timeNow',
	'_QS_weatherManager','_QS_weatherManager_checkDelay','_QS_worldName','_QS_worldSize','_QS_weatherSave','_QS_weatherSave_delay','_QS_weatherSave_checkDelay',
	'_QS_forceWeatherChange','_QS_weatherSyncMP','_QS_weatherSyncMP_interval','_QS_weatherSyncMP_delay','_QS_simulateWind','_QS_simulateOvercast','_QS_simulateRain',
	'_QS_simulateFog','_QS_simulateWaves','_QS_simulateLightning','_QS_simulateRainbow','_QS_simulateGusts','_QS_simulateEvent_storm','_QS_simulateEvent_fog',
	'_QS_simulateEvent_wind','_QS_rainUpdateValues','_QS_currentWind','_QS_currentWindDir','_QS_currentWindStr','_QS_currentOvercast','_QS_currentRain',
	'_QS_currentFog','_QS_currentGusts','_QS_currentLightnings','_QS_currentWaves','_QS_currentRainbow','_QS_forceWeatherChange_delayTimer','_QS_forceWeatherChange_delay',
	'_QS_windArray','_QS_windWorkingArray','_QS_windUpdate_checkDelay_timer','_QS_windUpdate_checkDelay','_QS_refreshWind','_QS_overcastUpdate','_QS_overcastArray',
	'_QS_overcastWorkingArray','_QS_overcastUpdate_checkDelay_timer','_QS_overcastUpdate_checkDelay','_QS_refreshOvercast','_QS_rainSimulated','_QS_rainUpdate_checkDelay_timer',
	'_QS_rainUpdate_checkDelay','_QS_fogEnabled','_QS_canEnableFog','_QS_fogUpdate_checkDelay_timer','_QS_fogUpdate_checkDelay','_QS_refreshFog','_QS_wavesUpdate_checkDelay_timer',
	'_QS_wavesUpdate_checkDelay','_QS_lightningsUpdate_checkDelay_timer','_QS_lightningsUpdate_checkDelay','_QS_lightningsEnabled','_QS_canEnableLightnings',
	'_QS_gustsUpdate_checkDelay_timer','_QS_gustsUpdate_checkDelay','_QS_rainbowUpdate_checkDelay_timer','_QS_rainbowUpdate_checkDelay','_QS_day','_QS_day_wind',
	'_QS_day_overcast','_QS_day_rain','_QS_day_fog','_QS_day_lightnings','_QS_dayTime','_QS_dayTime_wind','_QS_dayTime_overcast','_QS_dayTime_rain','_QS_dayTime_fog',
	'_QS_timeManager','_QS_date','_QS_date_checkDelay_timer','_QS_date_checkDelay','_QS_saveDate','_QS_saveDate_delay','_QS_timeAccelerationManager','_QS_solarHorizons',
	'_QS_sunrise','_QS_sunset','_QS_solarNoon','_QS_timeAcceleration_inProgress','_QS_darkAccelerated','_QS_lightAccelerated','_QS_dawnDuskTimeDeccelerated',
	'_QS_darkAccelerationFactor','_QS_noonAccelerationFactor','_QS_dawnDuskDeccelerationFactor','_QS_timeAccelerationControl',
	'_QS_module_recruitableAI','_QS_module_recruitableAI_checkDelay','_QS_module_recruitableAI_array','_array','_unit','_randomize','_configCode',
	'_t','_unitPos','_unitDir','_isRespawning','_canRespawnAfter','_respawnTickets','_exit','_QS_module_recruitableAI_delay','_QS_module_recruitableAI_side',
	'_QS_module_recruitableAI_unitTypes','_QS_module_recruitableAI_pilotTypes','_QS_messagingSystem','_QS_messages','_QS_message_interval','_QS_message_delay','_QS_messageCurrent','_QS_messageCount',
	'_QS_messageCountIndex','_QS_messageCurrentIndex','_QS_module_missionObjectives','_QS_module_missionObjectives_checkDelay','_missionObjectives','_unit',
	'_QS_module_missionObjectives_delay','_QS_module_recruitableAI_class','_unitVehicle',
	'_QS_fogWorkingArray','_QS_module_hc_delay','_QS_module_hc_checkDelay','_QS_module_hc_clientID','_QS_module_hc_active','_QS_module_hc_managedSides',
	'_QS_module_hc_grp','_isDefendLocal','_QS_module_curator','_QS_module_curator_delay','_QS_module_curator_checkDelay','_arrayToAdd',
	'_ownerInGame','_allDeadMen','_allDeadMenCount','_allDeadVehicles','_allDeadVehiclesCount','_allMines','_allMinesCount','_allMissionObjectsAll',
	'_missionCraters','_missionWeaponHolders','_missionWeaponHolderSimulated','_missionStaticWeapons','_missionRuins','_missionBackpackUAVs','_missionEmptyDetectors',
	'_missionCratersLimit','_weaponHoldersLimit','_missionWeaponHolderSimulatedLimit','_missionStaticWeaponsLimit','_missionRuinsLimit','_missionBackpackUAVsLimit',
	'_missionEmptyDetectorsLimit','_count','_limit','_n','_i','_garbageCollector','_allPlayers','_airDefenseAvailable','_QS_module_airDefense',
	'_QS_module_airDefense_checkDelay','_airDefenseArray','_QS_module_airDefense_delay','_airDefensePos','_airDefenseOnline','_QS_leaderboards_saveDelay',
	'_QS_leaderboards_saveCheckDelay','_QS_module_leaderboard','_QS_module_leaderboard_delay','_QS_module_leaderboard_checkDelay',
	'_QS_ladder_weekday','_QS_leaderboards_transport','_val','_QS_leaderboards_revive','_QS_leaderboards_ears','_QS_leaderboards_teeth',
	'_pname','_QS_leaderboards_prisoner','_pilot_whitelist','_wl_helipilot','_medic_whitelist','_wl_cls','_QS_module_captives','_QS_module_captives_delay',
	'_QS_module_captives_checkDelay','_QS_enemyCaptives','_gitmo','_baseMarker','_QS_module_enemyCAS','_QS_module_enemyCAS_delay','_QS_module_enemyCAS_checkDelay',
	'_uav','_surfaceIsWater','_posCurrent','_QS_module_animals','_QS_module_animals_delay','_QS_module_animals_checkDelay','_animal','_animalType',
	'_aoAnimals_farmPosition','_dirTo','_aoAnimals','_animStart','_anims','_QS_enemyCasArray','_enemyCasLimitLow','_enemyCasLimitHigh','_enemyQS_casJet','_enemyCasLimit',
	'_missionGroundWeaponHolders','_groundWeaponHoldersLimit','_QS_module_enemyCAS_spawnDelay','_QS_module_enemyCAS_checkSpawnDelay','_QS_garbageCollector_enabled',
	'_QS_garbageCollector','_QS_obj','_QS_instructions','_QS_timeDelete','_QS_deleteThis','_QS_i','_enemyQS_casPilot','_mainMissionRegionIndex','_module_fob_enabled',
	'_module_fob_delay','_module_fob_checkDelay','_module_fob_activeRegion','_module_fob_fobCreated','_module_fob_fob','_mainMissionRegion_aoList','_module_fob_logistics_respawnEnabled',
	'_module_fob_logistics_vehicleRespawnEnabled','_module_fob_logistics_repairServices','_module_fob_logistics_ammoServices','_vdelay','_delay','_QS_timeAccelerationManager_checkDelay','_QS_timeAccelerationManager_delay',
	'_QS_currentTimeMultiplier','_allHitPointsDamage','_allHitPointsDamage_0','_allHitPointsDamage_2','_module_fob_isFobActive','_fobVehicleID','_module_fob_vData',
	'_module_fob_vData_v','_module_fob_data','_module_fob_logistics_complete','_module_fob_location','_module_fob_logistics_assetTypes','_module_fob_logistics_radius',
	'_module_fob_respawn_ticketsAdded','_QS_module_fob_sideShownHUD_radarON','_QS_module_fob_sideShownHUD_radarOFF','_module_fob_assault_delay',
	'_module_fob_assault_checkDelay','_module_fob_underAssault','_module_fob_assault_enemyThreshold','_module_fob_assault_playerThreshold',
	'_module_fob_assault_timer','_module_fob_assault_groupComposition','_module_fob_assault_group','_module_fob_assault_duration','_resumeScript',
	'_QS_module_AI_cleanupCheckArray','_QS_module_AI_cleanup','_cleanupCheck','_module_fob_logistics_reinforceServices','_QS_module_airdefense_2',
	'_module_fob_allUnits','_QS_module_cas_respawn','_QS_module_cas_respawn_threshold','_QS_module_cas_respawn_checkDelay','_QS_module_recruitableAI_data',
	'_QS_rainCheckInterval','_QS_module_time_duskAcc','_QS_rainHoursMax','_QS_nextRainArray','_QS_heliDroneRespawnDelay','_QS_heliDroneRespawnCheckDelay',
	'_QS_aiAssignedTarget','_QS_vRespawnDist_base','_QS_vRespawnDist_field','_QS_module_aoSmallTasks','_QS_module_aoSmallTasks_delay','_QS_module_aoSmallTasks_checkDelay',
	'_QS_module_aoSmallTasks_timeout','_QS_module_aoSmallTasks_list','_QS_module_aoSmallTasks_current','_QS_module_aoSmallTasks_data','_QS_module_aoSmallTasks_isActive',
	'_QS_module_aoSmallTasks_timeoutDelay','_QS_marker_hqMarker_delay','_QS_marker_hqMarker_checkDelay',
	'_QS_ao_invincibility_delay','_QS_ao_invincibility_checkDelay','_QS_listNearbyPlayers','_QS_ao_EFB','_QS_ao_EFB_delay','_QS_ao_EFB_checkDelay','_QS_ao_EFB_threshold',
	'_QS_ao_EFB_group','_QS_module_heartbeat_delay','_QS_module_heartbeat_checkDelay','_QS_module_heartbeat_eventCount','_module_fob_attackEnabled',
	'_missionObject','_QS_baseLights','_QS_baseLights_state','_QS_lamp','_QS_lampHitPoints','_QS_lampHitValue','_player','_base_toc','_QS_simulateEvent_override','_QS_simulateEvent_overrideDelay',
	'_QS_simulateEvent_duration','_QS_simulateEvent_active','_QS_module_aoCivs','_QS_module_aoCivs_delay','_QS_module_aoCivs_checkDelay','_QS_module_aoCiv_civ','_vRespawnTickets',
	'_deleteNow','_QS_module_restart','_QS_module_restart_realTimeStart','_QS_module_restart_delay','_QS_module_restart_checkDelay','_QS_module_restart_isRestarting','_QS_module_restart_hours',
	'_QS_module_restart_hour','_QS_module_restart_realTimeNow','_QS_module_restart_hourCurrent','_QS_module_restart_lastBroadcast','_nearEntitiesCheck',
	'_QS_corpseCollector','_QS_wreckCollector','_QS_module_opsec','_QS_module_opsec_delay','_QS_module_opsec_checkDelay','_QS_module_opsec_checkMarkers','_QS_module_opsec_checkVariables',
	'_QS_module_opsec_clientHeartbeat','_QS_module_heartbeat_array','_QS_module_opsec_checkMarkers_whitelistedMarkers','_markerData','_QS_module_opsec_deleteMarker',
	'_QS_allMapMarkers','_QS_diagTickTimeNow','_QS_system_weekday','_QS_productVersion','_allSimpleObjects','_smokeShellCount','_smokeShellLimit','_missionSmokeShells',
	'_QS_module_dynSim','_QS_module_dynSim_delay','_QS_module_dynSim_checkDelay','_QS_module_time_dawnOffset','_QS_simulateEvent_data','_scMainMissionRegionListProxy','_scMainMissionRadius',
	'_scAOList','_scAOArray','_scAO','_scToRemove','_QS_module_customMissions','_QS_module_customMissions_list','_QS_module_customMission_selected','_QS_module_customMissions_delay',
	'_QS_module_customMission_played','_scWinningSide','_scDuration','_scTimeStart','_missionObjectType','_QS_module_enemyCAS_spawnDelayDefault','_scAOIndex','_casJetObj',
	'_casUID','_casAllowanceIndex','_casPilot','_casAllowancePool','_playerCountArray','_sum','_avgPlayerCount',
	'_resultsFactors','_factorIndex','_resultsFactor','_avgPlayerCountCheckDelay','_aoStartDelay','_scAOCount','_QS_profile_scStats','_allDeadMenCount','_deadMenLimitMax',
	'_allDeadVehiclesCount','_deadVehiclesLimitMax','_QS_objWorldPos','_supportMessagePopped','_QS_module_emergentTasks','_QS_module_emergentTasks_delay',
	'_QS_module_emergentTasks_checkDelay','_QS_module_emergentTasks_array','_QS_module_emergentTasks_add','_QS_attemptRecycle','_model','_configClass','_QS_module_emergentTask_maxType',
	'_QS_module_emergentTask_countType','_QS_module_emergentTasks_medevac','_arrayIndex','_grid_availableRegions','_grid_availableRegion_id','_grid_availableAOs','_grid_availableAO_id',
	'_grid_ao_data','_grid_ao_nearRadius','_grid_region_completionThreshold','_grid_markerEvalTimeout','_estimatedTimeLeft','_true','_false','_endl','_maxPrisoners','_element',
	'_trigger_delete_fobVehicles','_cargoParent'
];
_QS_productVersion = productVersion;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_unitCap = [125,110] select (_QS_worldName isEqualTo 'Tanoa');
_aoThreshold = 10;
_casThreshold = 12;
_pause = 5;
_timeNow = time;
private _serverTime = serverTime;
_true = TRUE;
_false = FALSE;
_endl = endl;

private _activeDLC = missionNamespace getVariable ['QS_system_activeDLC',''];
private _isActiveDLC = _activeDLC isNotEqualTo '';

private _allUnits = allUnits;
private _allUnitsUav = allUnitsUav;
private _allGroups = allGroups;
private _allVehicles = vehicles;
_enemySides = [EAST,RESISTANCE];
_east = EAST;
_west = WEST;
_resistance = RESISTANCE;
_civilian = CIVILIAN;
_QS_diagTickTimeNow = diag_tickTime;
_baseMarker = markerPos 'QS_marker_base_marker';
_base_toc = markerPos 'QS_marker_base_toc';
_QS_missionStart = systemTime;
_QS_system_weekday = toLowerANSI ([_QS_missionStart,'SHORT'] call (missionNamespace getVariable 'QS_fnc_getWeekday'));
_aoStartDelay = 60;
private _genericResult = nil;
enableSentences FALSE;
private _worldArea = missionNamespace getVariable ['QS_terrain_worldArea',[[(worldSize / 2),(worldSize / 2),0],(worldSize / 2),(worldSize / 2),0,TRUE,-1]];
private _ve = objNull;

/*/============================ PRIMARY AO*/

missionNamespace setVariable ['QS_mission_aoType',(missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']),TRUE];
_aoType = missionNamespace getVariable ['QS_mission_aoType',(missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC'])];
if (
	(_aoType in ['CLASSIC']) &&
	(!(_QS_worldName in ['Altis','Tanoa','Malden','Enoch','Stratis']))			// These terrains are configured for Classic
) then {
	diag_log '***** GAME MODE ***** CLASSIC mode not configured for this terrain *****';
	_aoType = 'NONE';
	missionNamespace setVariable ['QS_mission_aoType',_aoType,TRUE];
	missionNamespace setVariable ['QS_missionConfig_aoType',_aoType,TRUE];
};
if (
	(_aoType in ['SC']) &&
	(!(_QS_worldName in ['Altis','Tanoa','Malden','Enoch']))			// These terrains are configured for Sector Control
) then {
	diag_log '***** GAME MODE ***** SECTOR CONTROL mode not configured for this terrain *****';
	_aoType = 'NONE';
	missionNamespace setVariable ['QS_mission_aoType',_aoType,TRUE];
	missionNamespace setVariable ['QS_missionConfig_aoType',_aoType,TRUE];
};
if (
	(_aoType in ['GRID']) &&
	(!(_QS_worldName in ['Altis','Tanoa','Malden','Enoch']))			// These terrains are configured for Insurgency Mode
) then {
	diag_log '***** GAME MODE ***** INSURGENCY mode not configured for this terrain *****';
	_aoType = 'NONE';
	missionNamespace setVariable ['QS_mission_aoType',_aoType,TRUE];
	missionNamespace setVariable ['QS_missionConfig_aoType',_aoType,TRUE];
};
diag_log format ['***** CURRENT GAMEMODE: %1 *****',_aoType];
if (_aoType isEqualTo 'SC') then {
	['INIT',0.5] call (missionNamespace getVariable 'QS_fnc_sc');
};
_aoList = [];
_aoArray = [];
private _aoDurationData = [];
private _aoStartTime = -1;
private _aoDuration = -1;
private _aoName = 'Default';
private _aoStats = [];
private _aoStatsIndex = -1;
private _aoStatsSamples = -1;
private _aoPlayersAvg = -1;
private _aoDurationAvg = -1;
private _playerCountData = [];
private _playerCountSamples = 0;
_mainMissionRegionListProxy = [];
_mainMissions = TRUE;
_mainMissionActive = FALSE;
_mainMissionRefreshAt = 1;
_mainMissionRadius = 750;
_mainMissionRegionIndex = -1;
_regionMasterList = call (compileScript ['code\config\QS_data_ao.sqf']);
_defendAOActive = FALSE;
_isDefendLocal = TRUE;
_aoGraceTime = time;
_mainMissionRegion_aoList = [];
_QS_marker_hqMarker_delay = 25;
_QS_marker_hqMarker_checkDelay = _timeNow + _QS_marker_hqMarker_delay;
_QS_ao_invincibility_delay = 15;
_QS_ao_invincibility_checkDelay = _timeNow + _QS_ao_invincibility_delay;
_QS_listNearbyPlayers = [];
_QS_ao_EFB = FALSE;
_QS_ao_EFB_delay = 30;
_QS_ao_EFB_checkDelay = _timeNow + _QS_ao_EFB_delay;
_QS_ao_EFB_threshold = 25;
_QS_ao_EFB_group = grpNull;
//comment 'Grid AO';
private _fn_grid = missionNamespace getVariable 'QS_fnc_grid';
if (_aoType isEqualTo 'GRID') then {
	diag_log '***** QS ***** DEBUG ***** INIT GRID *****';
	['INIT'] spawn _fn_grid;
};
private _QS_grid_firstRun = TRUE;
missionNamespace setVariable ['QS_TEST_GRID',FALSE,FALSE];

/*/===== AO SC/*/

_scMasterList = call (compileScript ['code\config\QS_data_aoSC.sqf']);
_scMainMissionRegionListProxy = [];
_scMainMissionRadius = 1000;
_scAOList = [];
_scAOArray = [];
_scAO = [];
_scToRemove = [];
_scAreaPolygon = [];
_scWinningSide = -1;
_scDuration = -1;
_scTimeStart = -1;
_scAOIndex = -1;
_playerCountArray = [];
_sum = 0;
_avgPlayerCount = 0;
_resultsFactors = [0,0,0,0,0,0];
_factorIndex = -1;
_resultsFactor = 0;
_avgPlayerCountCheckDelay = 60;
_scAOCount = 0;

/*/============================ Primary AO small tasks/*/

_QS_module_aoSmallTasks = (missionNamespace getVariable ['QS_missionConfig_sideMissions',1]) isEqualTo 1;
_QS_module_aoSmallTasks_delay = 5;
_QS_module_aoSmallTasks_checkDelay = _timeNow + _QS_module_aoSmallTasks_delay;
_QS_module_aoSmallTasks_timeout = 1200;
_QS_module_aoSmallTasks_timeoutDelay = _timeNow + _QS_module_aoSmallTasks_timeout;
_QS_module_aoSmallTasks_list = [2];
_QS_module_aoSmallTasks_current = -1;
_QS_module_aoSmallTasks_data = [-1,objNull,{}];
_QS_module_aoSmallTasks_isActive = FALSE;

/*/============================ FOBS*/

_module_fob_enabled = (
	(missionNamespace getVariable ['QS_missionConfig_fobsDefault',TRUE]) && 
	((call (missionNamespace getVariable 'QS_data_fobs')) isNotEqualTo []) && 
	(_aoType isNotEqualTo 'ZEUS')
);
_module_fob_delay = 5;
_module_fob_checkDelay = _timeNow + _module_fob_delay;
_module_fob_activeRegion = -1;
_module_fob_fobCreated = FALSE;
_module_fob_fob = [];
_module_fob_logistics_complete = FALSE;
_module_fob_logistics_respawnEnabled = FALSE;
_module_fob_logistics_vehicleRespawnEnabled = FALSE;
_module_fob_logistics_repairServices = FALSE;
_module_fob_logistics_ammoServices = FALSE;
_module_fob_logistics_fuelServices = FALSE;
_module_fob_logistics_reinforceServices = FALSE;
_module_fob_attackEnabled = FALSE;
_module_fob_isFobActive = FALSE;
_module_fob_vData = [];
_module_fob_vData_v = [];
_module_fob_location = [0,0,0];
_module_fob_logistics_assetTypes = ['LandVehicle','Air','Ship','Reammobox_F','ThingX'];
_module_fob_logistics_radius = 75;
_module_fob_respawn_ticketsAdded = 0;
_module_fob_assault_delay = _timeNow + 15;
_module_fob_assault_checkDelay = _timeNow + _module_fob_assault_delay;
_module_fob_underAssault = FALSE;
_module_fob_allUnits = [];
_module_fob_assault_enemyThreshold = 2;
_module_fob_assault_playerThreshold = 4;
_module_fob_assault_timer = _timeNow + 30;
_module_fob_assault_duration = 480;
missionNamespace setVariable ['QS_fob_cycleAttack',FALSE,FALSE];
_QS_module_fob_sideShownHUD_radarON = [TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE];
_QS_module_fob_sideShownHUD_radarOFF = [TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE,TRUE];
_trigger_delete_fobVehicles = FALSE;
private _dn1 = '';
{
	missionNamespace setVariable _x;
} forEach [
	['QS_module_fob_services_fuel',FALSE,TRUE],
	['QS_module_fob_services_repair',FALSE,TRUE],
	['QS_module_fob_services_ammo',FALSE,TRUE]
];

/*/============================ SIDE MISSIONS/*/

_sideMissions = (missionNamespace getVariable ['QS_missionConfig_sideMissions',1]) isEqualTo 1;
_sideMissionActive = FALSE;
_resumeScript = TRUE;
_currentSideMission = '';
/*/
	Old side missions (disabled but still 100% functional. add to _sideMissionList below in correct format to enable.)
		QS_fnc_SMHQcoast
		QS_fnc_SMHQfia
		QS_fnc_SMHQind
		QS_fnc_SMHQresearch
		QS_fnc_SMsecureChopper
		QS_fnc_SMsecureRadar
/*/
_sideMissionList = [
	'QS_fnc_SMRescuePOW',0.2,			// Side mission function name + weighted probability of spawning ( https://community.bistudio.com/wiki/selectRandomWeighted )
	'QS_fnc_SMsecureUrban',0.2,
	'QS_fnc_SMEscortVehicle',0.3,
	'QS_fnc_SMPriorityAA',0.4,
	'QS_fnc_SMPriorityARTY',0.4,
	'QS_fnc_SMsecureIntelUAV',0.2,
	'QS_fnc_SMsecureIntelUnit',0.2,
	'QS_fnc_SMsecureIntelVehicle',0.2,
	'QS_fnc_SMidapRecover',0.3,
	'QS_fnc_SMregenerator',0.3,
	'QS_fnc_SMsecureRadar',0.1
];
_sideMissionRefreshAt = 2;
_sideMissionListProxy = _sideMissionList;
_sideMissionDelayFixed = 300;
_sideMissionDelayRandom = 300;
_smDelay = _sideMissionDelayFixed + (random _sideMissionDelayRandom);

/*/============================= Deployment Missions/*/

private _deploymentMissions = missionNamespace getVariable ['QS_missionConfig_deploymentMissions',FALSE];
(missionNamespace getVariable ['QS_missionConfig_deploymentMissionParams',[]]) params [
	['_deploymentMissionMaxConcurrent',3],
	['_deploymentMissionFrequency',0.5],
	['_deploymentMissionIntensity',0.5],
	['_deploymentMissionDuration',0.5],
	['_deploymentMissionSetupTime',60],
    ['_deploymentMissionOverclock',0]
];

private _deploymentMission_intensity = _deploymentMissionIntensity;
private _deploymentMissionInterval = linearConversion [0,1,_deploymentMissionFrequency,3600,60,TRUE];
private _deploymentMissionDelay = -1;
private _deploymentMissionCheckInterval = 10;
private _deploymentMissionCheckDelay = -1;
private _deploymentMissionScript = scriptNull;
private _deploymentMissionScripts = [];
private _currentDeployments = [];
localNamespace setVariable ['QS_deploymentMissions_forceAttack',FALSE];

/*/============================ CUSTOM MISSIONS/*/

_QS_module_customMissions = ((random 1) > 0.8);
_QS_module_customMissions_list = [];
if (_QS_worldName isEqualTo 'Tanoa') then {
	{
		_QS_module_customMissions_list pushBack _x;
	} forEach [
		'QS_fnc_missionGeorgetown'
	];
};
if (_QS_worldName isEqualTo 'Altis') then {
	{
		_QS_module_customMissions_list pushBack _x;
	} forEach [
		'QS_fnc_missionKavala'
	];
};
_QS_module_customMission_selected = '';
_QS_module_customMissions_delay = time + 1800 + (random 10800);
_QS_module_customMission_played = FALSE;
{
	missionNamespace setVariable _x;
} forEach [
	['QS_customAO_trigger',FALSE,FALSE],
	['QS_customAO_script',scriptNull,FALSE],
	['QS_customAO_active',FALSE,FALSE],
	['QS_customAO_select','',FALSE],
	['QS_customAO_GT_active',FALSE,TRUE]
];
if (_QS_module_customMissions_list isEqualTo []) then {
	_QS_module_customMissions = FALSE;
};

/*/============================= ENEMY CAS/*/
_enemyCAS = TRUE;
_timeLastCAS = 0;
_timeCASdelayFixed = 720;
_timeCASdelayRandom = 600;
_timeNextCAS = time + (_timeCASdelayFixed + (random _timeCASdelayRandom));

_HVT_targeting_system = TRUE && (!(worldName in ['Stratis']));
_HVT_checkDelay = time + 90;
_QS_v = objNull;
private _HVT_currentTargets = [];
private _HVT_removeFrom = FALSE;
private _HVT_laserTarget = objNull;
private _HVT_laserTargets = [];
private _HVT_targetingDelay = -1;
private _HVT_isTargeting = FALSE;
private _HVT_targetingThreshold = 10;
_QS_heliDroneRespawnDelay = 1200;
_QS_heliDroneRespawnCheckDelay = _timeNow + _QS_heliDroneRespawnDelay;

/*/===== Vehicle Respawn/Management System/*/

_vehData = call (missionNamespace getVariable 'QS_data_vehicles');
{
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
		(serverNamespace getVariable 'QS_v_Monitor') pushBack _x;
	} else {
		if ((_x # 9) isNotEqualTo -1) then {
			(serverNamespace getVariable 'QS_v_Monitor') pushBack _x;
		};
	};
} forEach _vehData;

// Temp solution for toggle-able containers
private _vtype = '';
{
	_vtype = toLowerANSI (_x # 4);
	if (_vtype in ['land_cargo10_white_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrMobRespawn',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_light_green_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrFortSmall',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_military_green_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrFortMed',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_grey_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrFortBig',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_sand_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrPlatform',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_yellow_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrTerrain',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_blue_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrSAM',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
	if (_vtype in ['land_cargo10_cyan_f']) then {
		if (!(missionNamespace getVariable ['QS_missionConfig_cntnrRadar',FALSE])) then {
			(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,FALSE];
		};
	};
} forEach (serverNamespace getVariable 'QS_v_Monitor');
serverNamespace setVariable ['QS_v_Monitor',((serverNamespace getVariable 'QS_v_Monitor') select { _x isEqualType [] })];

if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
	['VEHICLES'] call (missionNamespace getVariable 'QS_fnc_carrier');
};
if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
	['VEHICLES'] call (missionNamespace getVariable 'QS_fnc_destroyer');
};
_vehData = nil;
_QS_distance = 500;			// Normal abandonment distance for vehicles
_distReal = 0;
_v = objNull;
private _v2 = objNull;
private _wreckType = '';
private _codeBool = {TRUE};
private _objNull = objNull;
private _spawnedType = '';
private _cargoParent = objNull;
_vRespawn_delay = 5;
_vRespawn_checkDelay = time + _vRespawn_delay;
_allHitPointsDamage = [];
_allHitPointsDamage_0 = [];
_allHitPointsDamage_2 = [];
_fobVehicleID = -1;
_vRespawnTickets = 0;
_model = '';
_configClass = configNull;
private _isWreck = FALSE;
private _isDeployed = FALSE;
_fn_isPosSafe = {
	params ['_position','_radius'];
	private _return = TRUE;
	_list1 = (_position select [0,2]) nearEntities ['All',_radius];
	if (_list1 isNotEqualTo []) exitWith {FALSE};
	{
		if (!isNull _x) then {
			if (isSimpleObject _x) then {
				if (!(['helipad',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_return = FALSE;
				};
			};
		};
	} count (nearestObjects [_position,[],_radius,TRUE]);
	_return;
};
private _countChildEntities = 0;

/*/==================== GARBAGE MANAGER */

localNamespace setVariable ['QS_GC_trigger',FALSE];
localNamespace setVariable ['QS_GC_triggerDeep',FALSE];
_QS_corpseCollector = missionNamespace getVariable ['QS_system_BIScorpseCollector',FALSE];
_QS_wreckCollector = missionNamespace getVariable ['QS_system_BISwreckCollector',FALSE];
_checkPlayerCount = FALSE;
_checkFrequencyDefault = 60;
_checkFrequencyAccelerated = 30;
_playerThreshold = 20;
_QS_garbageCollector_enabled = TRUE;
_QS_garbageCollector = [];
_QS_deleteThis = FALSE;
_QS_attemptRecycle = FALSE;
_missionObject = objNull;
_missionObjectType = '';
private _protectedRuinTypes = ['protected_ruin_types_1'] call QS_data_listVehicles;
private _missionObjectsTicker = 0;
_deleteNow = [];
_allMines = allMines;
_jetJunk = ['eject_junk_1'] call QS_data_listVehicles;
_chuteTypes = ['chute_types_1'] call QS_data_listVehicles;
_jetStuff = _jetJunk + _chuteTypes;
_backpackDroneTypes = ['backpack_drones_1'] call QS_data_listVehicles;
_allDeadMenCount = 0;
_allDeadVehiclesCount = 0;
_maxPrisoners = 15;
private _managed_flares = [];
if (_QS_worldName in ['Tanoa']) then {
	_deadMenLimit = 30;
	_deadMenLimitMax = 40;
	_deadMenDistCheck = TRUE;
	_deadMenDist = 500;
	_deadVehiclesLimit = 10;
	_deadVehiclesLimitMax = 15;
	_deadVehicleDistCheck = TRUE;
	_deadVehicleDist = 500;
	_missionCratersLimit = 10;
	_craterDistCheck = TRUE;
	_craterDist = 500;
	_weaponHoldersLimit = 30;
	_weaponHolderDistCheck = TRUE;
	_weaponHolderDist = 5;
	_missionWeaponHolderSimulatedLimit = 30;
	_minesLimit = -1;
	_minesDistCheck = TRUE;
	_minesDist = 1000;
	_missionStaticWeaponsLimit = 15;
	_staticsDistCheck = TRUE;
	_staticsDist = 1000;
	_missionBackpackUAVsLimit = 3;
	_backpackDroneDistCheck = FALSE;
	_backpackDroneDist = 1000;
	_missionRuinsLimit = 10;
	_ruinsDistCheck = TRUE;
	_ruinsDist = 1500;
	_orphanedTriggers = TRUE;
	_orphanedTriggerCount = 0;
	_emptyGroups = TRUE;
	_missionGroundWeaponHolders = [];
	_groundWeaponHoldersLimit = 30;
	_smokeShellLimit = 30;
	_smokeShellCount = 0;
	_missionSmokeShells = [];
} else {
	_deadMenLimit = 30;
	_deadMenLimitMax = 40;
	_deadMenDistCheck = TRUE;
	_deadMenDist = 1000;
	_deadVehiclesLimit = 10;
	_deadVehiclesLimitMax = 15;
	_deadVehicleDistCheck = TRUE;
	_deadVehicleDist = 1000;
	_missionCratersLimit = 10;
	_craterDistCheck = TRUE;
	_craterDist = 1000;
	_weaponHoldersLimit = 30;
	_weaponHolderDistCheck = TRUE;
	_weaponHolderDist = 5;
	_missionWeaponHolderSimulatedLimit = 30;
	_minesLimit = -1;
	_minesDistCheck = TRUE;
	_minesDist = 3000;
	_missionStaticWeaponsLimit = 15;
	_staticsDistCheck = TRUE;
	_staticsDist = 3000;
	_missionBackpackUAVsLimit = 3;
	_backpackDroneDistCheck = FALSE;
	_backpackDroneDist = 1000;
	_missionRuinsLimit = 10;
	_ruinsDistCheck = TRUE;
	_ruinsDist = 3000;
	_orphanedTriggers = TRUE;
	_orphanedTriggerCount = 0;
	_emptyGroups = TRUE;
	_missionGroundWeaponHolders = [];
	_groundWeaponHoldersLimit = 30;
	_smokeShellLimit = 30;
	_smokeShellCount = 0;
	_missionSmokeShells = [];
};

private _allPlayers = units WEST;				// units WEST
private _allDeadSorted = [];
private _allDeadVehiclesSorted = [];
private _deadForThreshold = 0;

private _thresholdLower = 25;					// Corpses
private _thresholdUpper = 75;					// Corpses
private _deadDurationLower = 60;				// Corpses: Min dead-for duration before cleanup at 25 corpses
private _deadDurationUpper = 10;				// Corpses: Min dead-for duration before cleanup at 75 corpses
private _distanceIrrelevant = 1000;				// Corpse irrelevant distance
private _distanceRelevant = 25;					// Corpse relevant distance

private _thresholdLowerVehicle = 10;			// Vehicles
private _thresholdUpperVehicle = 20;			// Vehicles
private _deadDurationLowerVehicle = 90;			// Vehicles
private _deadDurationUpperVehicle = 30;			// Vehicles
private _distanceRelevantVehicle = 50;			// Vehicle relevant distance
private _distanceIrrelevantVehicle = 1000;		// Vehicle irrelevant distane

private _nToDelete = 0;
private _deadCount = 0;
private _nearPlayerCoef = 2;
private _nearPlayerCoefVehicle = 2;
private _toDelete = [];

/*/=============================== WEATHER MANAGER*/

_QS_weatherManager = TRUE;
_QS_date = date;
_QS_weatherManager_checkDelay = _timeNow + 30;

private _QS_weatherDynamic = missionNamespace getVariable ['QS_missionConfig_weatherDynamic',TRUE];
private _QS_weatherForced = missionNamespace getVariable ['QS_missionConfig_weatherForced',0];
private _QS_weatherEventsEnabled = TRUE && _QS_weatherDynamic;

private _forcedWeatherUpdateDelay = 300;
private _forcedWeatherUpdateCheckDelay = -1;

_QS_weatherSave = TRUE && _QS_weatherDynamic;
_QS_weatherSave_delay = 600;
_QS_weatherSave_checkDelay = _timeNow + _QS_weatherSave_delay;
_QS_forceWeatherChange = TRUE;
_QS_weatherSyncMP = TRUE;
_QS_weatherSyncMP_interval = 120;
_QS_weatherSyncMP_delay = _timeNow + _QS_weatherSyncMP_interval;
_QS_simulateWind = TRUE && _QS_weatherDynamic;
_QS_simulateOvercast = TRUE && _QS_weatherDynamic;
private _QS_simulateSnow = (missionNamespace getVariable ['QS_missionConfig_weatherForced',0]) isEqualTo 4;
_QS_simulateRain = FALSE;
_QS_simulateFog = TRUE && _QS_weatherDynamic;
_QS_simulateWaves = TRUE && _QS_weatherDynamic;
_QS_simulateLightning = TRUE && _QS_weatherDynamic;
_QS_simulateRainbow = TRUE && _QS_weatherDynamic;
_QS_simulateGusts = TRUE && _QS_weatherDynamic;
_QS_simulateEvent_storm = FALSE;
_QS_simulateEvent_fog = FALSE;	/*/Out of scope, no one wants this anyways/*/
_QS_simulateEvent_wind = FALSE; /*/Out of scope, no one wants this anyways/*/
_QS_simulateEvent_duration = 900 + (random 1800);
_QS_simulateEvent_override = FALSE;
_QS_simulateEvent_overrideDelay = 1800 + (random 14400);
_QS_simulateEvent_data = [];
_QS_simulateEvent_active = FALSE;
_QS_rainUpdateValues = FALSE;

_QS_currentWind = wind;
_QS_currentWindDir = windDir;
_QS_currentWindStr = windStr;
_QS_currentOvercast = overcast;
_QS_currentRain = rain;
_QS_currentFog = fogParams;
_QS_currentGusts = gusts;
_QS_currentLightnings = lightnings;
_QS_currentWaves = waves;
_QS_currentRainbow = rainbow;
_QS_w3 = _QS_worldName;
_QS_forceWeatherChange_delayTimer = 300;
_QS_forceWeatherChange_delay = _timeNow + _QS_forceWeatherChange_delayTimer;
if (_QS_simulateWind) then {
	_QS_windArray = [date,_QS_worldName,'REALISM','WIND'] call (missionNamespace getVariable 'QS_fnc_weatherConfig');
	_QS_windWorkingArray = _QS_windArray;
	diag_log format ['***** DEBUG ***** Weather wind array: %1',_QS_windWorkingArray];
	_QS_windUpdate_checkDelay_timer = 60;
	_QS_windUpdate_checkDelay = _timeNow + _QS_windUpdate_checkDelay_timer;
	_QS_windNextValue = _QS_windWorkingArray # 0;
	setWind _QS_windNextValue;
};
_QS_refreshWind = TRUE;
_QS_overcastUpdate = FALSE;
_QS_overcastArray = [date,_QS_worldName,'REALISM','OVERCAST'] call (missionNamespace getVariable 'QS_fnc_weatherConfig');
_QS_overcastWorkingArray = _QS_overcastArray # 0;
diag_log format ['***** DEBUG ***** Weather overcast array: %1',_QS_overcastWorkingArray];
_QS_overcastUpdate_checkDelay_timer = 30;
_QS_overcastUpdate_checkDelay = _timeNow + _QS_overcastUpdate_checkDelay_timer;
_QS_refreshOvercast = TRUE;
_QS_rainSimulated = FALSE;
if ((random 1) > 0.666) then {
	_QS_simulateRain = _QS_overcastArray # 1;
} else {
	_QS_simulateRain = FALSE;
};
if (_QS_simulateRain) then {
	_QS_rainSimulated = TRUE;
};
_QS_rainUpdate_checkDelay_timer = 30;
_QS_rainUpdate_checkDelay = _timeNow + _QS_rainUpdate_checkDelay_timer;
_QS_rainCheckInterval = 0.5;
if (_QS_worldName isEqualTo 'Tanoa') then {
	_QS_rainCheckInterval = 0.25;
};
_QS_nextRainArray = [0,0];
_QS_fogEnabled = TRUE;
_QS_canEnableFog = TRUE;
_QS_fogUpdate_checkDelay_timer = 45;
_QS_fogUpdate_checkDelay = _timeNow + _QS_fogUpdate_checkDelay_timer;
_QS_refreshFog = TRUE;
_QS_wavesUpdate_checkDelay_timer = 300;
_QS_wavesUpdate_checkDelay = _timeNow + _QS_wavesUpdate_checkDelay_timer;
_QS_lightningsUpdate_checkDelay_timer = 300;
_QS_lightningsUpdate_checkDelay = _timeNow + _QS_lightningsUpdate_checkDelay_timer;
_QS_lightningsEnabled = FALSE;
if (_QS_worldName in ['Altis','Stratis','Malden']) then {
	if ((random 1) >= 0.666) then {
		_QS_canEnableLightnings = TRUE;
	} else {
		_QS_canEnableLightnings = FALSE;
	};
} else {
	if ((random 1) >= 0.666) then {
		_QS_canEnableLightnings = TRUE;
	} else {
		_QS_canEnableLightnings = FALSE;
	};
};
_QS_canEnableLightnings = _QS_canEnableLightnings && _QS_weatherDynamic;
_QS_gustsUpdate_checkDelay_timer = 1800;
_QS_gustsUpdate_checkDelay = _timeNow + _QS_gustsUpdate_checkDelay_timer;
_QS_rainbowUpdate_checkDelay_timer = 300;
_QS_rainbowUpdate_checkDelay = _timeNow + _QS_rainbowUpdate_checkDelay_timer;
_QS_rainHoursMax = 3;
if (_QS_worldName isEqualTo 'Tanoa') then {
	_QS_rainHoursMax = 6;
};
_QS_day = date # 2;
_QS_day_wind = _QS_day;
_QS_day_overcast = _QS_day;
_QS_day_rain = _QS_day;
_QS_day_fog = _QS_day;
_QS_day_lightnings = _QS_day;
_QS_dayTime = round dayTime;
_QS_dayTime_wind = _QS_dayTime;
_QS_dayTime_overcast = _QS_dayTime;
_QS_dayTime_rain = _QS_dayTime;
_QS_dayTime_fog = _QS_dayTime;

if (!(_QS_weatherDynamic)) then {
	if (_QS_weatherForced > -1) then {
		[_QS_weatherForced] call QS_fnc_WeatherPreset;
		forceWeatherChange;
	};
};



/*/=============================== TIME MANAGER*/

_QS_timeManager = TRUE;
_QS_date_checkDelay_timer = 60;
_QS_date_checkDelay = _timeNow + _QS_date_checkDelay_timer;
_QS_saveDate = TRUE;
_QS_saveDate_delay = _timeNow + 1800;
_QS_timeAccelerationManager = TRUE;
_QS_solarHorizons = _QS_date call (missionNamespace getVariable 'BIS_fnc_sunriseSunsetTime');
_QS_sunrise = _QS_solarHorizons # 0;
_QS_sunset = _QS_solarHorizons # 1;
_QS_solarNoon = (_QS_sunrise + _QS_sunset) / 2;
_QS_timeAcceleration_inProgress = 0;
_QS_darkAccelerated = TRUE;
_QS_lightAccelerated = TRUE;
_QS_dawnDuskTimeDeccelerated = TRUE;
(missionNamespace getVariable ['QS_missionConfig_timeMultiplier',[12,1.5,0.35]]) params [
	'_QS_darkAccelerationFactor',
	'_QS_noonAccelerationFactor',
	'_QS_dawnDuskDeccelerationFactor'
];
_QS_timeAccelerationControl = 1;
_QS_currentTimeMultiplier = timeMultiplier;
_QS_timeAccelerationManager_delay = 15;
_QS_timeAccelerationManager_checkDelay = _timeNow + _QS_timeAccelerationManager_delay;
_QS_module_time_duskAcc = 0.5;
_QS_module_time_dawnOffset = 0.5;
if (_QS_worldName isEqualTo 'Tanoa') then {
	_QS_module_time_duskAcc = 1;
	_QS_module_time_dawnOffset = 0.1;
};
_QS_baseLights = TRUE;
missionNamespace setVariable ['QS_lamps',(missionNamespace getVariable 'QS_lamps'),TRUE];
if (_QS_baseLights) then {
	_QS_baseLights_state = (([0,0,0] getEnvSoundController 'night') isEqualTo 1);
	_QS_lamp = objNull;
	_QS_lampHitPoints = [];
	_QS_lampHitValue = 0.97;
	if (!(_QS_baseLights_state)) then {
		missionNamespace setVariable ['QS_base_lamps',_QS_baseLights_state,TRUE];
		//comment 'Turn off lights';
	};
};

_QS_revealLoudPlayers = FALSE;
_QS_revealLoudPlayers_timer = 60;
_QS_revealLoudPlayers_delay = time + _QS_revealLoudPlayers_timer;

/*/======================= OTHER STUFF*/
/*/===== Air defense crap*/
_QS_module_airDefense = TRUE;
_airDefenseAvailable = TRUE;
_QS_module_airDefense_delay = 3;
_QS_module_airDefense_checkDelay = _timeNow + _QS_module_airDefense_delay;
_airDefenseArray = [[],0,0];
_airDefensePos = markerPos 'QS_marker_airbaseDefense';
_airDefenseOnline = FALSE;

private _minefieldSpawned = FALSE;

_QS_checkUAVsTime_delay = 10;
_QS_checkUAVsTime = time + _QS_checkUAVsTime_delay;
_QS_uavRespawnDelay = 600;
_QS_cleanup_delay = 30;
_QS_cleanup_checkDelay = time + _QS_cleanup_delay;

_fps = diag_fps;
_fpsCheckDelay = diag_tickTime + 10;

private _logInterval = missionNamespace getVariable ['QS_missionConfig_logFrequency',60];
private _log = _logInterval > -1;
private _logDelay = -1;

_allPlayersCount = count allPlayers;
_allUnitsCount = count allUnits;
_allAICount = _allUnitsCount - _allPlayersCount;

_nightVote = FALSE;
_nightVoteDelay = 0;
if ((random 1) > 0.666) then {
	_nightVote = FALSE;
	_nightVoteDelay = time + 3600 + (random 7200);
};

/*/===== Helmet Cam*/

_QS_helmetCam = TRUE;
_QS_nullPos = [0,0,0];
if (_QS_helmetCam) then {
	_pool = [];
	_QS_helmetCam_delay = 15;
	_QS_helmetCam_checkDelay = time + _QS_helmetCam_delay;
	missionNamespace setVariable ['QS_RD_liveFeed',TRUE,TRUE];
	_lfneck = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
	_lfpilot = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
	_lfTarget = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
	for '_x' from 0 to 2 step 1 do {
		{
			_x allowDamage FALSE;
			_x hideObjectGlobal TRUE;
		} forEach [
			_lfneck,
			_lfpilot,
			_lfTarget
		];
	};
	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_RD_liveFeed_vehicle',objNull,TRUE],
		['QS_RD_liveFeed_neck',_lfneck,TRUE],
		['QS_RD_liveFeed_pilot',_lfpilot,TRUE],
		['QS_RD_liveFeed_target',_lfTarget,TRUE]
	];
};

/*/===== RECRUITABLE AI*/

_QS_module_recruitableAI = TRUE && ((missionNamespace getVariable ['QS_missionConfig_recruitableAI',1]) isEqualTo 1);
if (_QS_module_recruitableAI) then {
	_QS_module_recruitableAI_delay = 15;
	_QS_module_recruitableAI_checkDelay = time + _QS_module_recruitableAI_delay;
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
		_QS_module_recruitableAI_data = call (compileScript ['code\config\QS_data_recruitableAI.sqf']);
		//_QS_module_recruitableAI_data = call (missionNamespace getVariable 'QS_data_recruitableAI');
	} else {
		_QS_module_recruitableAI_data = missionNamespace getVariable ['QS_register_rAI',[]];
	};
	_QS_module_recruitableAI_array = _QS_module_recruitableAI_data;
	_QS_module_recruitableAI_side = WEST;
	_QS_module_recruitableAI_unitTypes = ['recruitable_1'] call QS_data_listUnits;
	_QS_module_recruitableAI_pilotTypes = ['pilot_types_1'] call QS_data_listUnits;
	_QS_module_recruitableAI_unitTypes = _QS_module_recruitableAI_unitTypes call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};

/*/============================= MESSAGING SYSTEM*/

_QS_messagingSystem = TRUE;
_QS_messages = missionNamespace getVariable ['QS_chat_messages',[]];
_QS_messages = _QS_messages call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
_QS_message_interval = 5 * 60;						/*/ Interval delay between messages. minutes x 60./*/
_QS_message_delay = time + _QS_message_interval;
_QS_messageCurrent = '';
_QS_messageCount = count _QS_messages;
_QS_messageCountIndex = _QS_messageCount - 1;
_QS_messageCurrentIndex = 0;

/*/===== Client Interaction server-side component*/

_QS_module_missionObjectives = TRUE;
_QS_module_missionObjectives_delay = 5;
_QS_module_missionObjectives_checkDelay = time + _QS_module_missionObjectives_delay;
missionNamespace setVariable ['QS_RD_mission_objectives',[],TRUE];
_missionObjectives = missionNamespace getVariable ['QS_RD_mission_objectives',[]];

/*/===== Headless Client module/*/

_QS_module_hc = FALSE;
_QS_module_hc_delay = 30;
_QS_module_hc_checkDelay = time + _QS_module_hc_delay;
_QS_module_hc_clientID = -1;
_QS_module_hc_active = FALSE;
_QS_module_hc_managedSides = [EAST,WEST,RESISTANCE,CIVILIAN];
_QS_module_hc_grp = grpNull;

/*/====== CURATOR MODULE/*/

_QS_module_curator = TRUE;
_QS_module_curator_delay = 60;
_QS_module_curator_checkDelay = _timeNow + _QS_module_curator_delay;

/*/====== Leaderboard Module*/
/*/mon = 0 tue = 1 wed = 2 thu = 3 fri = 4 sat = 5 sun = 6/*/
/*/[2017,3,14,20,14]/*/
_QS_module_leaderboard = TRUE;
missionNamespace setVariable ['QS_leaderboards_session_queue',[],FALSE];
_QS_module_leaderboard_delay = 20;
_QS_module_leaderboard_checkDelay = _timeNow + _QS_module_leaderboard_delay;
if (missionProfileNamespace isNil 'QS_leaderboards_meta') then {
	missionProfileNamespace setVariable ['QS_leaderboards_meta',[_QS_system_weekday,_QS_missionStart]];
};
(missionProfileNamespace getVariable ['QS_leaderboards_meta',[_QS_system_weekday,_QS_missionStart]]) params ['_QS_ladder_weekday',''];
missionProfileNamespace setVariable ['QS_leaderboards_meta',[_QS_system_weekday,_QS_missionStart]];
if ((_QS_system_weekday isNotEqualTo _QS_ladder_weekday) && {(_QS_system_weekday isEqualTo 'mon')}) then {
	if !(missionProfileNamespace isNil 'QS_leaderboards2') then {
		(missionProfileNamespace getVariable 'QS_leaderboards2') call (missionNamespace getVariable 'QS_fnc_leaderboardAddToWhitelist');
	};
	missionProfileNamespace setVariable ['QS_leaderboards2',nil];
};
if (missionProfileNamespace isNil 'QS_leaderboards2') then {
	missionProfileNamespace setVariable ['QS_leaderboards2',createHashMap];
};
missionNamespace setVariable ['QS_leaderboards2',(missionProfileNamespace getVariable ['QS_leaderboards2',createHashMap]),FALSE];		// Debug leaderboards
missionNamespace setVariable ['QS_leaderboards3',createHashMap,TRUE];
missionNamespace setVariable ['QS_leaderboards4',(missionNamespace getVariable 'QS_leaderboards2'),FALSE];						// Copy of initial state, for clients to merge to "QS_leaderboards3" changes
private _lbHeaders = ['NAME','TRANSPORT','REVIVE','BERET','TOOTH','TOWER','PRISONER','ACCURACY','ACCURACY_SNIPER'];					// Debug leaderboards
private _lbVal = -1;																											// Debug leaderboards
private _lbIndex = -1;
private _QS_module_accuracy_checkDelay = -1;
private _QS_module_accuracy_delay = 5;
private _accuracyAllPlayers = [];
private _accuracyPlayer = objNull;
_QS_leaderboards_saveDelay = 600;
_QS_leaderboards_saveCheckDelay = _timeNow + _QS_leaderboards_saveDelay;
_QS_leaderboards_publishDelay = 180;
_QS_leaderboards_publishCheckDelay = _timeNow + _QS_leaderboards_publishDelay;
if (missionProfileNamespace isNil 'QS_whitelist_lb_helipilot') then {
	missionProfileNamespace setVariable ['QS_whitelist_lb_helipilot',[]];
} else {
	_pilot_whitelist = [];
	_wl_helipilot = missionProfileNamespace getVariable ['QS_whitelist_lb_helipilot',[]];
	if (_wl_helipilot isNotEqualTo []) then {
		{
			0 = _pilot_whitelist pushBack _x;
		} count _wl_helipilot;
		missionNamespace setVariable ['QS_pilot_whitelist',compileFinal str _pilot_whitelist,TRUE];
	};
};
if (missionProfileNamespace isNil 'QS_whitelist_lb_cls') then {
	missionProfileNamespace setVariable ['QS_whitelist_lb_cls',[]];
} else {
	_medic_whitelist = [];
	_wl_cls = missionProfileNamespace getVariable ['QS_whitelist_lb_cls',[]];
	if (_wl_cls isNotEqualTo []) then {
		{
			0 = _medic_whitelist pushBack _x;
		} count _wl_cls;
		missionNamespace setVariable ['QS_cls_whitelist',compileFinal str _medic_whitelist,TRUE];
	};
};
if (missionProfileNamespace isNil 'QS_whitelist_lb_sniper') then {
	missionProfileNamespace setVariable ['QS_whitelist_lb_sniper',[]];
} else {
	private _sniper_whitelist = [];
	private _wl_sniper = missionProfileNamespace getVariable ['QS_whitelist_lb_sniper',[]];
	if (_wl_sniper isNotEqualTo []) then {
		{
			0 = _sniper_whitelist pushBack _x;
		} count _wl_sniper;
		missionNamespace setVariable ['QS_sniper_whitelist',compileFinal str _sniper_whitelist,TRUE];
	};
};

/*/===== Captured enemies*/

_QS_module_captives = TRUE;
_QS_module_captives_delay = 300;
_QS_module_captives_checkDelay = _timeNow + _QS_module_captives_delay;
missionNamespace setVariable ['QS_enemyCaptives',[],FALSE];
_gitmo = markerPos 'QS_marker_gitmo';

/*/===== Animals module*/

_QS_module_animals = TRUE;
_QS_module_animals_delay = 60;
_QS_module_animals_checkDelay = _timeNow + _QS_module_animals_delay;
missionNamespace setVariable ['QS_aoAnimals',[],TRUE];

/*/===== AO Civs module/*/

_QS_module_aoCivs = FALSE;
_QS_module_aoCivs_delay = 10;
_QS_module_aoCivs_checkDelay = _timeNow + _QS_module_aoCivs_delay;
_QS_module_aoCiv_civ = objNull;

/*/===== Cas Respawn /*/

_QS_module_cas_respawn = (missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 3;
_QS_module_cas_respawn_threshold = 10;
_QS_module_cas_respawn_checkDelay = _timeNow + 15;
_casJetObj = objNull;
_casUID = '';
_casAllowanceIndex = -1;
_casPilot = objNull;
_casAllowancePool = -1;
_casAllowance = missionNamespace getVariable ['QS_CAS_jetAllowance_value',3];

/*/===== Module OPSEC/*/

_QS_module_opsec = (call (missionNamespace getVariable ['QS_missionConfig_AH',{1}])) isEqualTo 1;
_QS_module_opsec_delay = 60;
_QS_module_opsec_checkDelay = _timeNow + _QS_module_opsec_delay;
_QS_module_opsec_checkMarkers = FALSE;	 // This is disabled for now, I am working on marker text language translation, which makes it too complicated
_QS_module_opsec_checkVariables = FALSE;
_QS_module_opsec_clientHeartbeat = TRUE;
_QS_module_opsec_checkMarkers_whitelistedMarkers = [];
_markerData = call (compileScript ['code\config\QS_data_markers.sqf']);
{
	_QS_module_opsec_checkMarkers_whitelistedMarkers pushBack (_x # 0);
} forEach _markerData;
_markerCheck = toString [32,32,32];
_markerData = nil;
missionNamespace setVariable ['QS_markers_whitelistedDynamic',[],FALSE];
_QS_module_opsec_deleteMarker = FALSE;
_QS_allMapMarkers = allMapMarkers;

/*/===== Client heartbeat /*/
_QS_module_heartbeat_delay = 60;
_QS_module_heartbeat_checkDelay = _timeNow + _QS_module_heartbeat_delay;
_QS_module_heartbeat_array = [];
_QS_module_heartbeat_eventCount = 0;
_player = objNull;
/*/=====/*/
private _QS_module_uniformFix = TRUE;
private _QS_module_uniformFix_delay = 180;
private _QS_module_uniformFix_checkDelay = _timeNow + _QS_module_uniformFix_delay;
private _uniformFix_list = [];

private _QS_module_groupFix = missionNamespace getVariable ['QS_missionConfig_joinUngrouped',TRUE];
private _QS_module_groupFix_delay = 3;
private _QS_module_groupFix_checkdelay = _timeNow + _QS_module_groupFix_delay;

private _mainGroup = createGroup [WEST,FALSE];
_mainGroup deleteGroupWhenEmpty FALSE;
{
	_mainGroup setVariable _x;
} forEach [
	['BIS_dg_reg',TRUE,TRUE],
	['BIS_dg_pri',FALSE,TRUE],
	['BIS_dg_var','var_76561100000000000_0',TRUE],
	['BIS_dg_ins','',TRUE]
];
_mainGroupName = missionNamespace getVariable ['QS_terrain_worldName',_QS_worldName];
_mainGroup setGroupIDGlobal [_mainGroupName];

/*/===== Dynamic Simulation/*/

_QS_module_dynSim = (missionNamespace getVariable ['QS_missionConfig_dynSim',1]) isEqualTo 1;
_QS_module_dynSim_delay = 10;
_QS_module_dynSim_checkDelay = _timeNow + _QS_module_dynSim_delay;
{
	(_x # 0) setDynamicSimulationDistance (_x # 1);
} forEach [
	['GROUP',1250],
	['VEHICLE',1000],
	['EMPTYVEHICLE',250],
	['PROP',100]
];
'ISMOVING' setDynamicSimulationDistanceCoef 1.5;
enableDynamicSimulationSystem _QS_module_dynSim;

/*/===== Dynamic Tasks/*/
_QS_module_emergentTasks = TRUE;
_QS_module_emergentTasks_delay = 5;
_QS_module_emergentTasks_checkDelay = _timeNow + _QS_module_emergentTasks_delay;
_QS_module_emergentTasks_array = [];
_QS_module_emergentTasks_add = [];
_QS_module_emergentTask_maxType = 3;
_QS_module_emergentTask_countType = 0;
_QS_module_emergentTasks_medevac = TRUE;
/*/===== Zeus Respawn Module/*/
private _QS_module_zeusRespawn = (_aoType in ['ZEUS']) && (missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]);
private _QS_module_zeusRespawn_delay = 1;
private _QS_module_zeusRespawn_checkDelay = -1;
private _QS_module_zeusRespawn_data = [];
private _QS_module_zeusRespawn_updateElement = FALSE;
private _QS_module_zeusRespawn_element = [];
private _QS_module_zeusRespawn_side = sideUnknown;
private _QS_module_zeusRespawn_object = objNull;
private _QS_module_zeusRespawn_marker = '';
private _zeusModeRespawnMarker = missionNamespace getVariable ['QS_missionConfig_zeusRespawnMarker',TRUE];
private _QS_module_zeusRespawn_pos = [0,0,0];
private _QS_module_zeusRespawn_objectType = 'FlagPole_F';
private _QS_module_zeusRespawn_flagTexture = '';
private _QS_module_zeusRespawn_flagTextures = ['faction_flagtextures_1'] call QS_data_listOther;
private _QS_module_zeusRespawn_arsenal = missionNamespace getVariable ['QS_missionConfig_zeusRespawnArsenal',FALSE];
if (_QS_module_zeusRespawn) then {
	if ((missionNamespace getVariable ['QS_roles_data',[]]) isNotEqualTo []) then {
		{
			if (_x isNotEqualTo []) then {
				if (_forEachIndex isEqualTo 0) then {
					_QS_module_zeusRespawn_data pushBack [EAST,'respawn_east',markerPos ['respawn_east',TRUE],objNull,_QS_module_zeusRespawn_objectType,_QS_module_zeusRespawn_flagTextures # _forEachIndex];
					['ADD',['RESPAWN_ZEUS_0',TRUE,'SAFE','RAD',2,['respawn_east',100],{},{},{TRUE},{},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
					[
						'ADD',
						[
							3,
							'ID_ZEUS_0',
							{TRUE},
							{localize 'STR_QS_Menu_207'},
							'MARKER',
							'respawn_east',
							300,
							[],
							[EAST],
							{
								_spawnpos = (markerPos ['respawn_east',TRUE]) vectorAdd [-3 + (random 6),-3 + (random 6),0]; 
								QS_player setPosASL _spawnpos;
							},
							{TRUE},
							{
								((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_east'];
								ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
								0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
							},
							{FALSE},
							{TRUE},
							''
						]
					] call QS_fnc_deployment;
				};
				if (_forEachIndex isEqualTo 1) then {
					_QS_module_zeusRespawn_data pushBack [WEST,'respawn_west',markerPos ['respawn_west',TRUE],objNull,_QS_module_zeusRespawn_objectType,_QS_module_zeusRespawn_flagTextures # _forEachIndex];
					['ADD',['RESPAWN_ZEUS_1',TRUE,'SAFE','RAD',2,['respawn_west',100],{},{},{TRUE},{},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
					[
						'ADD',
						[
							4,
							'ID_ZEUS_1',
							{TRUE},
							{localize 'STR_QS_Menu_208'},
							'MARKER',
							'respawn_west',
							300,
							[],
							[WEST],
							{
								_spawnpos = (markerPos ['respawn_west',TRUE]) vectorAdd [-3 + (random 6),-3 + (random 6),0]; 
								QS_player setPosASL _spawnpos;
							},
							{TRUE},
							{
								((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_west'];
								ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
								0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
							},
							{FALSE},
							{TRUE},
							''
						]
					] call QS_fnc_deployment;
					missionNamespace setVariable ['QS_deployment_default','ID_ZEUS_1',TRUE];
				};
				if (_forEachIndex isEqualTo 2) then {
					_QS_module_zeusRespawn_data pushBack [RESISTANCE,'respawn_guerrila',markerPos ['respawn_guerrila',TRUE],objNull,_QS_module_zeusRespawn_objectType,_QS_module_zeusRespawn_flagTextures # _forEachIndex];
					['ADD',['RESPAWN_ZEUS_2',TRUE,'SAFE','RAD',2,['respawn_guerrila',100],{},{},{TRUE},{},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
					[
						'ADD',
						[
							5,
							'ID_ZEUS_2',
							{TRUE},
							{localize 'STR_QS_Menu_209'},
							'MARKER',
							'respawn_guerrila',
							300,
							[],
							[RESISTANCE],
							{
								_spawnpos = (markerPos ['respawn_guerrila',TRUE]) vectorAdd [-3 + (random 6),-3 + (random 6),0]; 
								QS_player setPosASL _spawnpos;
							},
							{TRUE},
							{
								((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_guerrila'];
								ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
								0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
							},
							{FALSE},
							{TRUE},
							''
						]
					] call QS_fnc_deployment;
				};
				if (_forEachIndex isEqualTo 3) then {
					_QS_module_zeusRespawn_data pushBack [CIVILIAN,'respawn_civilian',markerPos ['respawn_civilian',TRUE],objNull,_QS_module_zeusRespawn_objectType,_QS_module_zeusRespawn_flagTextures # _forEachIndex];
					['ADD',['RESPAWN_ZEUS_3',TRUE,'SAFE','RAD',2,['respawn_civilian',100],{},{},{TRUE},{},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
					[
						'ADD',
						[
							6,
							'ID_ZEUS_3',
							{TRUE},
							{localize 'STR_QS_Menu_210'},
							'MARKER',
							'respawn_civilian',
							300,
							[],
							[CIVILIAN],
							{
								_spawnpos = (markerPos ['respawn_civilian',TRUE]) vectorAdd [-3 + (random 6),-3 + (random 6),0]; 
								QS_player setPosASL _spawnpos;
							},
							{TRUE},
							{
								((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_civilian'];
								ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
								0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
							},
							{FALSE},
							{TRUE},
							''
						]
					] call QS_fnc_deployment;
				};
			};
		} forEach QS_roles_data;
	} else {
		_QS_module_zeusRespawn = FALSE;
	};
} else {
	if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) > 0) then {
		[
			'ADD',
			[
				3,
				'ID_ZEUS_0',
				{TRUE},
				{localize 'STR_QS_Menu_207'},
				'MARKER',
				'respawn_east',
				300,
				[],
				[EAST],
				{
					_spawnpos = (markerPos ['respawn_east',TRUE]) vectorAdd [-3 + (random 6),-3 + (random 6),0];
					QS_player setPosASL _spawnpos;
					[QS_player,markerPos 'respawn_east'] call QS_fnc_respawnOPFOR;
				},
				{TRUE},
				{
					((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_east'];
					ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
					0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
				},
				{FALSE},
				{TRUE},
				''
			]
		] call QS_fnc_deployment;
	};
};

/*/===== Restart scheduler/*/
_QS_module_restart = ((missionNamespace getVariable ['QS_missionConfig_restartHours',[]]) isNotEqualTo []);
_QS_module_restart_isRestarting = FALSE;
private _QS_module_restart_isDynamic = (missionNamespace getVariable ['QS_missionConfig_restartDynamic',1]) isEqualTo 1;
if (_QS_module_restart) then {
	_QS_module_restart_realTimeStart = systemTime;
	missionNamespace setVariable ['QS_system_realTimeStart',_QS_module_restart_realTimeStart,TRUE];
	diag_log format ['***** RESTART SCHEDULE * %1 *****',_QS_module_restart_realTimeStart];	
	_QS_module_restart_realTimeStart = (_QS_module_restart_realTimeStart select [2,3]);
	_QS_module_restart_realTimeNow = _QS_module_restart_realTimeStart;
	_QS_module_restart_hourCurrent = _QS_module_restart_realTimeNow # 2;
	_QS_module_restart_delay = 5;
	_QS_module_restart_checkDelay = _timeNow + 4200;	// Initial long delay so restart is not triggered for same hour
	_QS_module_restart_lastBroadcast = -1;
	private _QS_module_restart_hours = missionNamespace getVariable ['QS_missionConfig_restartHours',[0,12,18]];
	private _restart_hour_test = -1;
	_QS_module_restart_hour = -1;
	{
		_restart_hour_test = _x;
		if ((_QS_module_restart_realTimeStart # 1) < _restart_hour_test) exitWith {
			_QS_module_restart_hour = _restart_hour_test;
		};
		if (_forEachIndex isEqualTo ((count _QS_module_restart_hours) - 1)) then {
			_QS_module_restart_hour = _QS_module_restart_hours # 0;
		};
	} forEach _QS_module_restart_hours;
	if (_QS_module_restart_hour isEqualTo -1) then {
		_QS_module_restart_hour = _QS_module_restart_hours # 0;
	};
	_estimatedTimeLeft = 0;
	if (_QS_module_restart_hour < (_QS_module_restart_realTimeStart # 1)) then {
		_estimatedTimeLeft = (24 - (_QS_module_restart_realTimeStart # 1)) + _QS_module_restart_hour - ((_QS_module_restart_realTimeStart # 2) / 60);
	} else {
		_estimatedTimeLeft = (_QS_module_restart_hour - (_QS_module_restart_realTimeStart # 1)) - ((_QS_module_restart_realTimeStart # 2) / 60);
	};
	_estimatedTimeLeft = _estimatedTimeLeft * 3600;
	diag_log format ['Estimated Time Left: %1',_estimatedTimeLeft];
	estimatedTimeLeft (0 max _estimatedTimeLeft min 36000);
	diag_log format ['***** Restart schedule * Restart Hour: %1 RealTimeStart: %2 *****',_QS_module_restart_hour,_QS_module_restart_realTimeStart];
	if (_QS_module_restart_hour isEqualTo -1) then {
		_QS_module_restart = FALSE;
	};
};
'QS_marker_curators' setMarkerAlpha 0;
_fpsMarkerText = localize 'STR_QS_Marker_005';
_zeusMarkerText = localize 'STR_QS_Marker_006';

private _miscDelay5 = -1;

diag_log '***** Saving Profile *****';
saveMissionProfileNamespace;
diag_log '***** Profile Saved *****';

//comment 'Functions preload';
_fn_arrayShuffle = missionNamespace getVariable 'QS_fnc_arrayShuffle';
_fn_deleteTask = missionNamespace getVariable 'BIS_fnc_deleteTask';
_fn_sunriseSunsetTime = missionNamespace getVariable 'BIS_fnc_sunriseSunsetTime';
_fn_setUnitInsignia = missionNamespace getVariable 'BIS_fnc_setUnitInsignia';
_fn_setTask = missionNamespace getVariable 'BIS_fnc_setTask';
_fn_taskSetState = missionNamespace getVariable 'BIS_fnc_taskSetState';
_fn_attachToRelative = missionNamespace getVariable 'QS_fnc_attachToRelative';
_fn_aoPrepare = missionNamespace getVariable 'QS_fnc_aoPrepare';
_fn_artillery = missionNamespace getVariable 'QS_fnc_artillery';
_fn_aoFires = missionNamespace getVariable 'QS_fnc_aoFires';
_fn_scPrepare = missionNamespace getVariable 'QS_fnc_scPrepare';
_fn_serverDetector = missionNamespace getVariable 'QS_fnc_serverDetector';
_fn_aoBriefing = missionNamespace getVariable 'QS_fnc_aoBriefing';
_fn_setFlag = missionNamespace getVariable 'QS_fnc_setFlag';
_fn_scEvaluate = missionNamespace getVariable 'QS_fnc_scEvaluate';
_fn_scBrief = missionNamespace getVariable 'QS_fnc_scBrief';
_fn_sc = missionNamespace getVariable 'QS_fnc_sc';
_fn_aoSmallTask = missionNamespace getVariable 'QS_fnc_aoSmallTask';
_fn_fobPrepare = missionNamespace getVariable 'QS_fnc_fobPrepare';
_fn_inString = missionNamespace getVariable 'QS_fnc_inString';
_fn_fobEnemyAssault = missionNamespace getVariable 'QS_fnc_fobEnemyAssault';
_fn_vRandom = missionNamespace getVariable 'QS_fnc_vRandom';
_fn_vSetup = missionNamespace getVariable 'QS_fnc_vSetup';
_fn_serverObjectsRecycler = missionNamespace getVariable 'QS_fnc_serverObjectsRecycler';
_fn_weatherConfig = missionNamespace getVariable 'QS_fnc_weatherConfig';
_fn_serverUnitConfigure = missionNamespace getVariable 'QS_fnc_serverUnitConfigure';
_fn_aoDefend = missionNamespace getVariable 'QS_fnc_aoDefend';
_fn_airbaseDefense = missionNamespace getVariable 'QS_fnc_airbaseDefense';
_fn_gridPrepare = missionNamespace getVariable 'QS_fnc_gridPrepare';
_fn_aoMinefield = missionNamespace getVariable 'QS_fnc_aoMinefield';
_fn_createMinefield = missionNamespace getVariable 'QS_fnc_createMinefield';
_fn_gpsJammer = missionNamespace getVariable 'QS_fnc_gpsJammer';
_fn_fobAssets = missionNamespace getVariable 'QS_fnc_fobAssets';
_fn_aoSubObjectives = missionNamespace getVariable 'QS_fnc_aoSubObjectives';
_fn_weatherPreset = missionNamespace getVariable 'QS_fnc_weatherPreset';
_fn_zoneManager = missionNamespace getVariable 'QS_fnc_zoneManager';
_fn_sideColor = missionNamespace getVariable 'BIS_fnc_sideColor';
_fn_setWrecked = missionNamespace getVariable 'QS_fnc_setWrecked';
_fn_getWreckType = missionNamespace getVariable 'QS_fnc_getWreckType';
_fn_isWreckable = missionNamespace getVariable 'QS_fnc_isWreckable';
_fn_deployAssault = missionNamespace getVariable 'QS_fnc_deployAssault';
_fn_isNearVehicleRally = missionNamespace getVariable 'QS_fnc_isNearVehicleRally';
_fn_getVehicleStealth = missionNamespace getVariable 'QS_fnc_getVehicleStealth';
_fn_dynamicGroups = missionNamespace getVariable 'BIS_fnc_dynamicGroups';
_fn_eventAttach = missionNamespace getVariable 'QS_fnc_eventAttach';

/*/============================================================================= LOOP/*/
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_QS_diagTickTimeNow = diag_tickTime;
	if (_QS_diagTickTimeNow > _miscDelay5) then {
		_miscDelay5 = _QS_diagTickTimeNow + 5;
		_serverTime = serverTime;
		_allPlayers = allPlayers - (entities 'HeadlessClient_F');
		_allUnits = allUnits;
		_allUnitsUav = allUnitsUav;
		_allGroups = allGroups;
		_allVehicles = vehicles;
		_allPlayersCount = count _allPlayers;
		_allUnitsCount = count _allUnits;
		_allAICount = _allUnitsCount - _allPlayersCount;
	};
	/*/===== Diagnostics report/*/
	if (_QS_diagTickTimeNow > _fpsCheckDelay) then {
		_fps = round diag_fps;
		missionNamespace setVariable ['QS_server_fps',_fps,_true];
		if (_log) then {
			if (_QS_diagTickTimeNow > _logDelay) then {
				_logDelay = _QS_diagTickTimeNow + _logInterval;
				diag_log format [
					'%1********** SERVER REPORT (TOP) ********** System Time: %21 * %1FPS: %2 * %1Frame: %3 * %1Frame-Time: %4 * %1Player count: %5 * %1Active Scripts: %6 * %1Active SQF Scripts: %7 * %1Active SQS Scripts: %8 * %1Active FSM Scripts: %9 * %1Active Zeus: %10 * %1Active HC: %11 * %1Created Entities: %12 * %1Deleted Entities: %13 * %1Killed Entities: %14 * %1Respawned Entities: %15 * %1Recycled Entities: %16 * %1Unit Count: %17 * %1Total objects count: %18 * %1Entities count: %19 * %1Simple objects count: %20 *%1Script Errors: %22 * %1********** SERVER REPORT (BOTTOM) **********',
					_endl,
					_fps,
					diag_frameNo,
					diag_deltaTime,
					_allPlayersCount,
					diag_activeScripts,
					(diag_activeSQFScripts select [0,4]),
					diag_activeSQSScripts,
					diag_activeMissionFSMs,
					allCurators,
					count (missionNamespace getVariable 'QS_headlessClients'),
					(missionNamespace getVariable 'QS_analytics_entities_created'),
					(missionNamespace getVariable 'QS_analytics_entities_deleted'),
					(missionNamespace getVariable 'QS_analytics_entities_killed'),
					(missionNamespace getVariable 'QS_analytics_entities_respawned'),
					(missionNamespace getVariable 'QS_analytics_entities_recycled'),
					_allAICount,
					(count (allMissionObjects '')),
					(count (entities [[],[],_true,_false])),
					(count (allSimpleObjects [])),
					systemTime,
					[(localNamespace getVariable ['QS_allScriptErrors',0]),(localNamespace getVariable ['QS_uniqueScriptErrors',0])]
				];
			};
		};
		if (_fps >= 20) then {
			if ((markerColor 'QS_marker_fpsMarker') isNotEqualTo 'ColorGREEN') then {
				'QS_marker_fpsMarker' setMarkerColorLocal 'ColorGREEN';
			};
			if (!sentencesEnabled) then {
				enableSentences _true;
			};
		} else {
			if (_fps >= 10) then {
				if ((markerColor 'QS_marker_fpsMarker') isNotEqualTo 'ColorYELLOW') then {
					'QS_marker_fpsMarker' setMarkerColorLocal 'ColorYELLOW';
				};
			} else {
				if ((markerColor 'QS_marker_fpsMarker') isNotEqualTo 'ColorRED') then {
					'QS_marker_fpsMarker' setMarkerColorLocal 'ColorRED';
				};
			};
			if (sentencesEnabled) then {
				enableSentences _false;
			};
		};
		_baseMarker = markerPos 'QS_marker_base_marker';
		'QS_marker_fpsMarker' setMarkerText (format ['%1 %3 %2',_markerCheck,_fps,_fpsMarkerText]);
		'QS_marker_curators' setMarkerText (format ['%1 %3 %2',_markerCheck,allCurators,_zeusMarkerText]);
		_fpsCheckDelay = _QS_diagTickTimeNow + 30;
	};

	if (_mainMissions) then {
		if (!(_mainMissionActive)) then {
			if (_timeNow > _aoStartDelay) then {
				if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'CLASSIC') then {
					if (!(_defendAOActive)) then {
						if (
							(!(missionNamespace getVariable ['QS_classic_AI_triggerDeinit',_false])) &&
							(!(missionNamespace getVariable ['QS_aoSuspended',_false])) && 
							(!(missionNamespace getVariable ['QS_customAO_active',_false]))
						) then {
							if (_aoList isEqualTo []) then {
								if (_mainMissionRegionListProxy isEqualTo []) then {
									_mainMissionRegionListProxy = _regionMasterList call _fn_arrayShuffle;
									if ((_QS_worldName isEqualTo 'Tanoa') && ((random 1) > 0.5)) then {
										_mainMissionRegion = _mainMissionRegionListProxy # 0;
									} else {
										_mainMissionRegion = selectRandom _mainMissionRegionListProxy;
									};
									_mainMissionRegionIndex = _mainMissionRegionListProxy find _mainMissionRegion;
									_mainMissionRegionListProxy deleteAt _mainMissionRegionIndex;
									missionNamespace setVariable ['QS_activeRegion',(_mainMissionRegion # 0),_false];
								} else {
									_mainMissionRegion = selectRandom _mainMissionRegionListProxy;
									_mainMissionRegionIndex = _mainMissionRegionListProxy find _mainMissionRegion;
									_mainMissionRegionListProxy deleteAt _mainMissionRegionIndex;
									missionNamespace setVariable ['QS_activeRegion',(_mainMissionRegion # 0),_false];								
								};
								_mainMissionRegion_aoList = (_mainMissionRegion # 1) call _fn_arrayShuffle;
								for '_x' from 0 to (round(((count _mainMissionRegion_aoList) * 0.75) - 1)) step 1 do {
									_ao = selectRandom _mainMissionRegion_aoList;
									_aoList pushBack _ao;
									_mainMissionRegion_aoList deleteAt (_mainMissionRegion_aoList find _ao);
								};
							};
							_ao = selectRandom _aoList;
							diag_log str _ao;
							_aoList deleteAt (_aoList find _ao);
							_mainMissionActive = _true;
							_defendAO = _false;
							missionNamespace setVariable ['QS_registeredPositions',[(markerPos 'QS_marker_module_fob')],_true];
							_defendAOActive = _false;		
							_QS_ao_EFB = _false;
							_aoGraceTime = _timeNow + 60;
							_aoName = _ao # 1;
							_QS_AOpos = _ao # 2;
							missionNamespace setVariable ['QS_AOpos',_QS_AOpos,_true];
							if (
								((missionNamespace getVariable 'QS_aoHQ') isEqualType []) &&
								{((missionNamespace getVariable 'QS_aoHQ') isNotEqualTo [])} &&
								{!(missionNamespace isNil 'QS_hqPos')}
							) then {
								{
									if (_x isEqualType _objNull) then {
										if (!isNull _x) then {
											0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										};
									};
								} count (missionNamespace getVariable 'QS_aoHQ');
								['REMOVE','ENEMY_HQ_0'] call _fn_zoneManager;
							};
							_aoStartTime = diag_tickTime + 10;
							_aoArray = [_ao] call _fn_aoPrepare;
						};
					} else {
						if (_isDefendLocal) then {
							if (scriptDone _defendAOScript) then {
								_defendAOActive = _false;
								_defendAO = _false;
								[1] call _fn_artillery;
							};
						} else {
							if (!(missionNamespace getVariable 'QS_defendActive')) then {
								_defendAOActive = _false;
								_defendAO = _false;
								[1] call _fn_artillery;
							};
						};
					};
				} else {
					if (!(missionNamespace getVariable 'QS_customAO_active')) then {
						if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
							if ((!(_defendAOActive)) && (!(missionNamespace getVariable 'QS_aoSuspended'))) then {
								if (!(missionNamespace getVariable 'QS_virtualSectors_AI_triggerDeinit')) then {
									if (_scAOCount <= 0) then {
										if (_QS_worldName isEqualTo 'Tanoa') then {
											_index = selectRandomWeighted [0,0.6,1,0.15,2,0.15,3,0.15];
										};
										if (_QS_worldName isEqualTo 'Altis') then {
											_index = selectRandomWeighted [0,0.15,1,0.15,2,0.15,3,0.15,4,0.15];
										};
										if (_QS_worldName isEqualTo 'Malden') then {
											_index = selectRandomWeighted [0,0.5,1,0.5,2];
										};
										if (_QS_worldName isEqualTo 'Enoch') then {
											_index = selectRandomWeighted [0,0.5,1,0.25,2,0.25];
										};
										_mainMissionRegion = _scMasterList # _index;
										if ((_mainMissionRegion # 0) isNotEqualTo (missionNamespace getVariable 'QS_activeRegion')) then {
											{
												missionNamespace setVariable _x;
											} forEach [
												['QS_virtualSectors_regionUsedPositions',[[-1000,-1000,0]],_false],
												['QS_virtualSectors_regionUsedRefPositions',[[-1000,-1000,0]],_false],
												['QS_virtualSectors_lastReferencePosition',[-1000,-1000,0],_false],
												['QS_virtualSectors_regionUsedCentroids',[[-1000,-1000,0]],_false]
											];
										};
										missionNamespace setVariable ['QS_activeRegion',(_mainMissionRegion # 0),_false];
										_scAOCount = 5;
										if (_QS_worldName isEqualTo 'Tanoa') then {
											if (_index isEqualTo 0) then {
												_scAOCount = selectRandom [8,9,10];
											};
											if (_index isEqualTo 1) then {
												_scAOCount = selectRandom [2,3,3];
											};
											if (_index isEqualTo 2) then {
												_scAOCount = selectRandom [2,3,3];
											};
											if (_index isEqualTo 3) then {
												_scAOCount = selectRandom [2,3,3];
											};
										};
										if (_QS_worldName isEqualTo 'Altis') then {
											if (_index isEqualTo 0) then {
												_scAOCount = selectRandom [4,5,6];
											};
											if (_index isEqualTo 1) then {
												_scAOCount = selectRandom [4,5,6];
											};
											if (_index isEqualTo 2) then {
												_scAOCount = selectRandom [4,5,6];
											};
											if (_index isEqualTo 3) then {
												_scAOCount = selectRandom [4,5,6];
											};
											if (_index isEqualTo 4) then {
												_scAOCount = selectRandom [4,5,6];
											};
										};
										if (_QS_worldName isEqualTo 'Malden') then {
											if (_index isEqualTo 0) then {
												_scAOCount = selectRandom [3,4];
											};
											if (_index isEqualTo 1) then {
												_scAOCount = selectRandom [3,4];
											};
										};
										if (_QS_worldName isEqualTo 'Enoch') then {
											if (_index isEqualTo 0) then {
												_scAOCount = selectRandom [3,4];
											};
											if (_index isEqualTo 1) then {
												_scAOCount = selectRandom [5,6];
											};
											if (_index isEqualTo 2) then {
												_scAOCount = selectRandom [5,6];
											};
										};
									};
									if ((!(_module_fob_enabled)) || ((_module_fob_enabled) && (_module_fob_isFobActive))) then {
										{
											missionNamespace setVariable  _x;
										} forEach [
											['QS_virtualSectors_scoreSides',[0,0,0,0,0],_true],
											['QS_registeredPositions',[(markerPos 'QS_marker_module_fob')],_false],
											['QS_virtualSectors_subObjectives',[],_false],
											['QS_virtualSectors_sub_1_active',_false,_false],
											['QS_virtualSectors_sub_2_active',_false,_false],
											['QS_virtualSectors_sub_3_active',_false,_false],
											['QS_virtualSectors_aoMortars',[],_false]
										];
										_playerCountArray = [];
										_scAOCount = _scAOCount - 1;
										_mainMissionActive = _true;
										diag_log '***** SC INIT * 0 *****';
										_scAreaPolygon = _mainMissionRegion # 2;
										_scTimeStart = diag_tickTime;
										if (
											((missionNamespace getVariable ['aoHQ',[]]) isNotEqualTo []) &&
											(!(missionNamespace isNil 'QS_hqPos'))
										) then {
											{
												if (_x isEqualType _objNull) then {
													if (!isNull _x) then {
														0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
													};
												};
											} count (missionNamespace getVariable 'aoHQ');
										};
										[_module_fob_enabled,_scAreaPolygon] call _fn_scPrepare;
									};
								};
							};
						} else {
							if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'GRID') then {
								if ((!(missionNamespace getVariable 'QS_aoSuspended')) && (!(missionNamespace getVariable 'QS_customAO_active')) && (!(_defendAOActive))) then {
									if (missionNamespace getVariable ['QS_grid_initialized',_false]) then {
										if (_QS_grid_firstRun) then {
											_QS_grid_firstRun = _false;
											_grid_availableRegions = [];
											_grid_availableRegion_id = ['REGION_GETACTIVE'] call _fn_grid;
											diag_log format ['***** QS DEBUG ***** Region: %1 *****',_grid_availableRegion_id];
											if (_grid_availableRegion_id isNotEqualTo -1) then {
												missionNamespace setVariable ['QS_activeRegion',_grid_availableRegion_id,_false];
											};
											_grid_availableAOs = [];
											_grid_availableAO_id = ['AO_GETACTIVE',_grid_availableRegion_id] call _fn_grid;
											diag_log format ['***** QS DEBUG ***** AO: %1 *****',_grid_availableAO_id];
											_grid_ao_data = [];
											_grid_ao_nearRadius = 2000;
											_grid_region_completionThreshold = 0;
											_grid_markerEvalTimeout = 0;
										};
										//comment 'Evaluate region';
										_mainMissionActive = _true;
										if ((_grid_availableRegion_id isEqualTo -1) || {(['EVALUATE_REGION',_grid_availableRegion_id,_grid_region_completionThreshold] call _fn_grid)}) then {
											if ((['REGION_GETAVAILABLEAOS',_grid_availableRegion_id] call _fn_grid) isEqualTo []) then {
												//comment 'Get available regions';
												_grid_availableRegions = ['REGION_GETAVAILABLE'] call _fn_grid;
												if (_grid_availableRegions isNotEqualTo []) then {
													//comment 'Select region';
													_grid_availableRegion_id = selectRandom _grid_availableRegions;
													['REGION_SETSTATE',_grid_availableRegion_id,1] call _fn_grid;
													missionNamespace setVariable ['QS_activeRegion',_grid_availableRegion_id,_false];
												} else {
													['RESET'] call _fn_grid;
													// This should be improved to show proper Outro + statistics, etc.
													[
														[],
														{
															3 fadeMusic 0.666; 
															playMusic 'LeadTrack04_F_Tacops';
															private _endImage = missionNamespace getVariable ['QS_missionConfig_communityLogo',''];
															if (_endImage isEqualTo '') then {
																_endImage = missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa'];
															};
															51 cutText [(format ["<img size='4' image='%1'/><br/><br/><t size='3'>%2 Campaign completed</t>",_endImage,worldName]),'PLAIN',5,_true,_true];
														}
													] remoteExec ['call',-2,_true];
													uiSleep 96;
													_QS_module_restart_isRestarting = _true;
													0 spawn QS_fnc_serverRestart;
												};
											};
										};
										diag_log format ['***** QS ***** DEBUG ***** Region ID: %1 *****',_grid_availableRegion_id];
										//comment 'Get suitable AO';
										if (_grid_availableAO_id isEqualTo -1) then {
											_grid_availableAO_id = ['AO_FINDNEAR_RANDOM',_grid_availableRegion_id,(missionNamespace getVariable ['QS_grid_aoCentroid',[0,0,0]]),_grid_ao_nearRadius] call _fn_grid;
										};
										_grid_ao_data = ['AO_SETSTATE',_grid_availableRegion_id,_grid_availableAO_id,1] call _fn_grid;
										diag_log format ['***** QS ***** DEBUG ***** AO ID: %1 *****',_grid_availableAO_id];
										//comment 'Prepare AO';
										missionNamespace setVariable ['QS_registeredPositions',[(markerPos 'QS_marker_module_fob')],_false];
										_grid_ao_data call _fn_gridPrepare;
										['SAVE'] call _fn_grid;
									};
								};
							};
						};
					};
				};
			};
		} else {
			if (_timeNow > _aoGraceTime) then {
				if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'CLASSIC') then {
					if (_timeNow > _avgPlayerCountCheckDelay) then {
						_avgPlayerCount = round (((_avgPlayerCount * _playerCountSamples) + _allPlayersCount) / (_playerCountSamples + 1));
						_playerCountData = [_playerCountSamples,_allPlayersCount,_avgPlayerCount];
						_playerCountSamples = _playerCountSamples + 1;
						_avgPlayerCountCheckDelay = _timeNow + 60;
					};
					if (
						([0] call _fn_aoSubObjectives) || 
						{(missionNamespace getVariable 'QS_aoCycleVar')}
					) then {
						diag_log 'Main AO deactivating';
						_aoDuration = round (diag_tickTime - _aoStartTime);
						_aoStats = missionProfileNamespace getVariable ['QS_statistics_classic_aoDuration',[]];
						_aoStatsIndex = _aoStats findIf { (_x # 0) isEqualTo _aoName };
						if (_aoStatsIndex isEqualTo -1) then {
							_aoStatsIndex = _aoStats pushBack [_aoName,1,_aoDuration,(_playerCountData # 2)];
						} else {
							_aoDurationData = _aoStats # _aoStatsIndex;
							_aoDurationData params [['_aoName','Default'],['_aoStatsSamples',0],['_aoStatsAvg',0],['_aoPlayersAvg',0]];
							_aoDurationAvg = round (((_aoStatsAvg * _aoStatsSamples) + _aoDuration) / (_aoStatsSamples + 1));
							_aoPlayersAvg = round (((_aoPlayersAvg * _aoStatsSamples) + (_playerCountData # 2)) / (_aoStatsSamples + 1));
							_aoStats set [_aoStatsIndex,[_aoName,_aoStatsSamples + 1,_aoDurationAvg,_aoPlayersAvg]];
						};
						diag_log format ['***** AO SAVED STATS ***** %1',(_aoStats # _aoStatsIndex)];
						missionProfileNamespace getVariable ['QS_statistics_classic_aoDuration',_aoStats];
						saveMissionProfileNamespace;
						_playerCountData = [0,0,0];
						_playerCountSamples = 0;
						_avgPlayerCount = 0;
						_mainMissionActive = _false;
						missionNamespace setVariable ['QS_classic_AI_triggerDeinit',_true,_false];
						missionNamespace setVariable ['QS_classic_AI_active',_false,_false];
						if (missionNamespace getVariable 'QS_aoCycleVar') then {
							missionNamespace setVariable ['QS_aoCycleVar',_false,_false];
						};
						{
							_x call _fn_deleteTask;
						} forEach [
							['QS_IA_TASK_AO_0'],
							['QS_IA_TASK_AO_1'],
							['QS_IA_TASK_AO_2']
						];
						if (alive (missionNamespace getVariable 'QS_radioTower')) then {
							(missionNamespace getVariable 'QS_radioTower') setDamage [1,_true];
						};
						[2,'QS_ao_jammer_1'] call _fn_gpsJammer;
						{
							_element = _x;
							_arrayIndex = (missionNamespace getVariable 'QS_AI_regroupPositions') findIf {((_x # 0) isEqualTo _element)};
							if (_arrayIndex isNotEqualTo -1) then {
								(missionNamespace getVariable 'QS_AI_regroupPositions') set [_arrayIndex,_false];
								(missionNamespace getVariable 'QS_AI_regroupPositions') deleteAt _arrayIndex;
							};
						} forEach [
							'QS_ao_HQ',
							'QS_ao_SD'
						];
						if (((missionNamespace getVariable 'QS_enemyGroundReinforceArray') findIf {(alive _x)}) isNotEqualTo -1) then {
							{
								if (!isNull _x) then {
									_x setDamage 1;
								};
							} count (missionNamespace getVariable 'QS_enemyGroundReinforceArray');
						};
						if (((missionNamespace getVariable 'QS_enemyVehicleReinforcementsArray') findIf {(alive _x)}) isNotEqualTo -1) then {
							{
								if (!isNull _x) then {
									_x setDamage 1;
								};
							} count (missionNamespace getVariable 'QS_enemyVehicleReinforcementsArray');
						};
						if ((missionNamespace getVariable 'QS_enemyJungleCamp_array') isNotEqualTo []) then {
							{
								if (!isNull _x) then {
									0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
								};
							} count (missionNamespace getVariable 'QS_enemyJungleCamp_array');
						};
						if (((missionNamespace getVariable 'QS_enemyVehicleReinforcements_crew') findIf {(alive _x)}) isNotEqualTo -1) then {
							{
								if (!isNull _x) then {
									_x setDamage 1;
								};
							} count (missionNamespace getVariable 'QS_enemyVehicleReinforcements_crew');
						};
						if ((missionNamespace getVariable ['QS_aoAnimals',[]]) isNotEqualTo []) then {
							deleteVehicle (missionNamespace getVariable ['QS_aoAnimals',[]]);
							missionNamespace setVariable ['QS_aoAnimals',[],_false];
						};
						if ((missionNamespace getVariable ['QS_ao_UXOs',[]]) isNotEqualTo []) then {
							deleteVehicle (missionNamespace getVariable ['QS_ao_UXOs',[]]);
							missionNamespace setVariable ['QS_ao_UXOs',[],_false];
						};
						if !(missionNamespace isNil 'QS_ao_aaMarkers') then {
							if ((missionNamespace getVariable 'QS_ao_aaMarkers') isEqualType []) then {
								if ((missionNamespace getVariable 'QS_ao_aaMarkers') isNotEqualTo []) then {
									{
										if (_x isEqualType '') then {
											deleteMarker _x;
										};
									} count (missionNamespace getVariable 'QS_ao_aaMarkers');
									missionNamespace setVariable ['QS_ao_aaMarkers',[],_false];
								};
							};
						};
						if ((missionNamespace getVariable ['QS_ao_civVehicles',[]]) isNotEqualTo []) then {
							{
								if (!isNull _x) then {
									(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
								};
							} forEach (missionNamespace getVariable ['QS_ao_civVehicles',[]]);
							missionNamespace setVariable ['QS_ao_civVehicles',[],_false];
						};
						if ((missionNamespace getVariable ['QS_entities_ao_customEntities',[]]) isNotEqualTo []) then {
							{
								if (!isNull _x) then {
									if (_x in _allMines) then {
										deleteVehicle _x;
									} else {
										(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
									};
								};
							} forEach (missionNamespace getVariable ['QS_entities_ao_customEntities',[]]);
							missionNamespace setVariable ['QS_entities_ao_customEntities',[],_false];
						};
						if ((missionNamespace getVariable ['QS_entities_ao_customStructures',[]]) isNotEqualTo []) then {
							{
								if (!isNull _x) then {
									(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
								};
							} forEach (missionNamespace getVariable ['QS_entities_ao_customStructures',[]]);
							missionNamespace setVariable ['QS_entities_ao_customStructures',[],_false];
						};
						if ((missionNamespace getVariable ['QS_primaryObjective_civilians',[]]) isNotEqualTo []) then {
							deleteVehicle (missionNamespace getVariable ['QS_primaryObjective_civilians',[]]);
							missionNamespace setVariable ['QS_primaryObjective_civilians',[],_false];
						};
						deleteVehicle (_allMines select {
							(
								(local _x) &&
								((_x distance2D _QS_AOpos) < 1200)
							)
						});
						if ((missionNamespace getVariable 'QS_classic_subObjectives') isNotEqualTo []) then {
							{
								if (_x isEqualType []) then {
									if (_x isNotEqualTo []) then {
										_array = (_x # 2) # 2;
										if (!isNil '_array') then {
											if (_array isEqualType []) then {
												if (_array isNotEqualTo []) then {
													{
														if (_x isEqualType _objNull) then {
															if (!isNull _x) then {
																if (!isNull (attachedTo _x)) then {
																	[0,_x] call _fn_eventAttach;
																};
																(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
															};
														};
													} forEach _array;
												
												};
											};
										};
									};
								};
							} forEach (missionNamespace getVariable 'QS_classic_subObjectives');
							missionNamespace setVariable ['QS_classic_subObjectives',[],_false];
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isNotEqualTo []) then {
							{
								deleteMarker _x;
							} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
							missionNamespace setVariable ['QS_virtualSectors_sub_1_markers',[],_false];
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
							{
								deleteMarker _x;
							} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
							missionNamespace setVariable ['QS_virtualSectors_sub_2_markers',[],_false];
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isNotEqualTo []) then {
							{
								deleteMarker _x;
							} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
							missionNamespace setVariable ['QS_virtualSectors_sub_3_markers',[],_false];
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') isNotEqualTo []) then {
							{
								if (!isNull _x) then {
									if (isObjectHidden _x) then {
										(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'UNHIDE_DISCREET',0];
									};
								};
							} forEach (missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects');
							missionNamespace setVariable ['QS_virtualSectors_hiddenTerrainObjects',[],_false];
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_sd_marker') isNotEqualTo []) then {
							{
								deleteMarker _x;
							} forEach (missionNamespace getVariable 'QS_virtualSectors_sd_marker');
							missionNamespace setVariable ['QS_virtualSectors_sd_marker',[],_false];
						};
						{
							_x call _fn_deleteTask;
						} forEach [
							['QS_virtualSectors_sub_1_task'],
							['QS_virtualSectors_sub_2_task'],
							['QS_virtualSectors_sub_3_task']
						];							
						{
							missionNamespace setVariable _x;
						} forEach [
							['QS_enemyVehicleReinforcements_crew',[],_true],
							['QS_enemyVehicleReinforcementsArray',[],_true],
							['QS_enemyGroundReinforceArray',[],_true],
							['QS_HC_AO_enemyArray',[],_true],
							['QS_aoAnimals',[],_true],
							['QS_enemyJungleCamp_array',[],_false]
						];
						if (_minefieldSpawned) then {
							_minefieldSpawned = _false;
						};
						missionNamespace setVariable ['QS_ao_createDelayedMinefield',_false,_false];
						['DEBRIEF',_ao,_QS_AOpos] call _fn_aoBriefing;
						if ((_ao # 8) isNotEqualTo 0) then {
							_defendAO = _true;
							_defendAOActive = _true;
							_isDefendLocal = _true;
							_defendAOScript = 0 spawn _fn_aoDefend;
						};
						_aoStartDelay = time + (30 + (random 15));
					};

					/*/===== HQ Marker color/*/
					
					if (_timeNow > _QS_marker_hqMarker_checkDelay) then {
						if (!alive (missionNamespace getVariable 'QS_csatCommander')) then {
							if ((markerColor 'QS_marker_hqMarker') isEqualTo 'ColorWEST') then {
								if ((((units _west) inAreaArray [(missionNamespace getVariable 'QS_HQpos'),100,100,0,_false,-1])) isEqualTo []) then {
									if ((count (((units _east) + (units _resistance)) inAreaArray [(missionNamespace getVariable 'QS_HQpos'),50,50,0,_false,-1])) isNotEqualTo []) then {
										['sideChat',[_west,'BLU'],localize 'STR_QS_Chat_039'] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
										[(missionNamespace getVariable 'QS_AO_HQ_flag'),_east,'',_false,_objNull,1] call _fn_setFlag;
										{
											_x setMarkerColor 'ColorOPFOR';
										} forEach [
											'QS_marker_hqMarker',
											'QS_marker_hqCircle'
										];
									};
								};
							} else {
								if ((markerColor 'QS_marker_hqMarker') isEqualTo 'ColorOPFOR') then {
									if ((((units _west) inAreaArray [(missionNamespace getVariable 'QS_HQpos'),100,100,0,_false,-1])) isNotEqualTo []) then {
										if (((((units _east) + (units _resistance)) inAreaArray [(missionNamespace getVariable 'QS_HQpos'),100,100,0,_false,-1])) isEqualTo []) then {
											[(missionNamespace getVariable 'QS_AO_HQ_flag'),_west,'',_false,_objNull,1] call _fn_setFlag;
											{
												_x setMarkerColor 'ColorWEST';
											} forEach [
												'QS_marker_hqMarker',
												'QS_marker_hqCircle'
											];
										};
									};
								};
							};
						};
						_QS_marker_hqMarker_checkDelay = _timeNow + _QS_marker_hqMarker_delay;
					};
					/*/Certain targets are invincible until ground elements are near/*/
					if (_timeNow > _QS_ao_invincibility_checkDelay) then {
						if (alive (missionNamespace getVariable 'QS_radioTower')) then {
							if (!isDamageAllowed (missionNamespace getVariable 'QS_radioTower')) then {
								_QS_listNearbyPlayers = [(missionNamespace getVariable 'QS_radioTower_pos'),250,[_west],(_allPlayers unitsBelowHeight 30),0] call _fn_serverDetector;
								if (_QS_listNearbyPlayers isNotEqualTo []) then {
									{
										if (!((vehicle _x) isKindOf 'Air')) exitWith {
											(missionNamespace getVariable 'QS_radioTower') allowDamage _true;
											(missionNamespace getVariable 'QS_radioTower') allowDamage _true;
										};
									} count _QS_listNearbyPlayers;
								};
							};
						};
						if (!(_minefieldSpawned)) then {
							if (missionNamespace getVariable ['QS_ao_createDelayedMinefield',_false]) then {
								_QS_listNearbyPlayers = [(missionNamespace getVariable 'QS_radioTower_pos'),150,[_west],(_allPlayers unitsBelowHeight 30),0] call _fn_serverDetector;
								if (_QS_listNearbyPlayers isNotEqualTo []) then {
									_minefieldSpawned = _true;
									call _fn_aoMinefield;
								};
							};
						};
						if (!isDamageAllowed (missionNamespace getVariable 'QS_csatCommander')) then {
							_QS_listNearbyPlayers = [(missionNamespace getVariable 'QS_HQpos'),250,[_west],(_allPlayers unitsBelowHeight 30),0] call _fn_serverDetector;
							if (_QS_listNearbyPlayers isNotEqualTo []) then {
								{
									if (!((vehicle _x) isKindOf 'Air')) exitWith {
										(missionNamespace getVariable 'QS_csatCommander') allowDamage _true;
										(missionNamespace getVariable 'QS_csatCommander') allowDamage _true;
									};
								} count _QS_listNearbyPlayers;
							};
						};
						_QS_ao_invincibility_checkDelay = _timeNow + _QS_ao_invincibility_delay;
					};
				} else {
					if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'SC') then {
						if (alive (missionNamespace getVariable 'QS_radioTower')) then {
							if (!isDamageAllowed (missionNamespace getVariable 'QS_radioTower')) then {
								_QS_listNearbyPlayers = [(missionNamespace getVariable 'QS_radioTower_pos'),250,[_west],(_allPlayers unitsBelowHeight 30),0] call _fn_serverDetector;
								if (_QS_listNearbyPlayers isNotEqualTo []) then {
									{
										if (!((vehicle _x) isKindOf 'Air')) exitWith {
											(missionNamespace getVariable 'QS_radioTower') allowDamage _true;
											(missionNamespace getVariable 'QS_radioTower') allowDamage _true;
										};
									} count _QS_listNearbyPlayers;
								};
							};
						};
						// Delayed minefield
						if (!(_minefieldSpawned)) then {
							if (missionNamespace getVariable ['QS_ao_createDelayedMinefield',_false]) then {
								_QS_listNearbyPlayers = [(missionNamespace getVariable 'QS_radioTower_pos'),150,[_west],(_allPlayers unitsBelowHeight 30),0] call _fn_serverDetector;
								if (_QS_listNearbyPlayers isNotEqualTo []) then {
									_minefieldSpawned = _true;
									_array = [(missionNamespace getVariable 'QS_radioTower_pos'),5,25,29,[],_true,_false] call _fn_createMinefield;
									{
										(missionNamespace getVariable 'QS_ao_UXOs') pushBack _x;
									} forEach _array;
									_array = [];
								};
							};
						};
						if ((missionNamespace getVariable 'QS_virtualSectors_aoMortars') isNotEqualTo []) then {
							if (((missionNamespace getVariable 'QS_virtualSectors_aoMortars') select {((alive _x) && (alive (gunner _x)))}) isEqualTo []) then {
								['sideChat',[_west,'HQ'],localize 'STR_QS_Chat_040'] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
								['SC_SUB_COMPLETED',['',localize 'STR_QS_Notif_046']] remoteExec ['QS_fnc_showNotification',-2,_false];
								missionNamespace setVariable ['QS_virtualSectors_aoMortars',[],_false];
								{
									if (_x in allMapMarkers) then {
										deleteMarker _x;
									};
								} forEach [
									'QS_marker_virtualSectors_mtr_0',
									'QS_marker_virtualSectors_mtr_00'
								];
								missionNamespace setVariable ['QS_virtualSectors_aoMortars',[],_false];								
							};
						};
						if (_timeNow > _avgPlayerCountCheckDelay) then {
							_playerCountArray pushBack _allPlayersCount;
							_avgPlayerCountCheckDelay = _timeNow + 60;
						};
						if ((([2] call _fn_scEvaluate) isNotEqualTo -1) || {(missionNamespace getVariable 'QS_aoCycleVar')}) then {
							_scDuration = diag_tickTime - _scTimeStart;
							_scWinningSide = [2] call _fn_scEvaluate;
							[0,[_scWinningSide,_scDuration]] call _fn_scBrief;
							//comment 'Save stats here';
							if (_playerCountArray isNotEqualTo []) then {
								_sum = 0;
								{
									_sum = _sum + _x;
								} forEach _playerCountArray;
								_avgPlayerCount = _sum / (count _playerCountArray);
								_playerCountArray = [];
								_resultsFactors = missionNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]];
								if (_avgPlayerCount < 10) then {_factorIndex = 0;};
								if (_avgPlayerCount >= 10) then {_factorIndex = 1;};
								if (_avgPlayerCount >= 20) then {_factorIndex = 2;};
								if (_avgPlayerCount >= 30) then {_factorIndex = 3;};
								if (_avgPlayerCount >= 40) then {_factorIndex = 4;};
								if (_avgPlayerCount >= 50) then {_factorIndex = 5;};
								_resultsFactor = _resultsFactors # _factorIndex;
								if (_scWinningSide isEqualTo 1) then {
									_resultsFactor = _resultsFactor + (random (missionNamespace getVariable ['QS_virtualSectors_resultsCoef',[0.01,0.02,0.03]]));
								} else {
									_resultsFactor = _resultsFactor * 0.8;
								};
								_resultsFactors set [_factorIndex,(_resultsFactor max 0)];
								missionNamespace setVariable ['QS_virtualSectors_resultsFactors',_resultsFactors,_false];
								missionProfileNamespace setVariable ['QS_virtualSectors_resultsFactors',_resultsFactors];
							};
							if (missionProfileNamespace isNil 'QS_server_profile_scStats') then {
								missionProfileNamespace setVariable ['QS_server_profile_scStats',[]];
							};
							_QS_profile_scStats = missionProfileNamespace getVariable ['QS_server_profile_scStats',[]];
							if ((count _QS_profile_scStats) > 300) then {
								for '_x' from 0 to 9 step 1 do {
									if ((count _QS_profile_scStats) <= 300) exitWith {};
									_QS_profile_scStats set [0,_false];
									_QS_profile_scStats deleteAt 0;
								};
							};
							_QS_profile_scStats pushBack [_scWinningSide,_scDuration,_allPlayersCount,_QS_missionStart,(missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]]),_resultsFactor];
							missionProfileNamespace setVariable ['QS_server_profile_scStats',_QS_profile_scStats];
							_mainMissionActive = _false;
							if ((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
								missionNamespace setVariable ['QS_virtualSectors_sub_1_markers',[],_false];
							};
							if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
								missionNamespace setVariable ['QS_virtualSectors_sub_2_markers',[],_false];
							};
							if ((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
								missionNamespace setVariable ['QS_virtualSectors_sub_3_markers',[],_false];
							};
							if ((missionNamespace getVariable 'QS_virtualSectors_sd_marker') isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (missionNamespace getVariable 'QS_virtualSectors_sd_marker');
								missionNamespace setVariable ['QS_virtualSectors_sd_marker',[],_false];
							};
							missionNamespace setVariable ['QS_virtualSectors_active',_false,_false];
							{
								missionNamespace setVariable  _x;
							} forEach [
								['QS_virtualSectors_scoreSides',[0,0,0,0,0],_true],
								['QS_virtualSectors_sub_1_active',_false,_false],
								['QS_virtualSectors_sub_2_active',_false,_false],
								['QS_virtualSectors_sub_3_active',_false,_false],
								['QS_virtualSectors_AI_triggerDeinit',_true,_false],
								['QS_virtualSectors_active',_false,_false]
							];
							if (_minefieldSpawned) then {
								_minefieldSpawned = _false;
							};
							[2,'QS_ao_jammer_1'] call _fn_gpsJammer;
							missionNamespace setVariable ['QS_ao_createDelayedMinefield',_false,_false];
							if (missionNamespace getVariable 'QS_aoCycleVar') then {
								missionNamespace setVariable ['QS_aoCycleVar',_false,_false];
							};
							{
								_element = _x;
								_arrayIndex = (missionNamespace getVariable 'QS_AI_regroupPositions') findIf {((_x # 0) isEqualTo _element)};
								if (_arrayIndex isNotEqualTo -1) then {
									(missionNamespace getVariable 'QS_AI_regroupPositions') set [_arrayIndex,_false];
									(missionNamespace getVariable 'QS_AI_regroupPositions') deleteAt _arrayIndex;
								};
							} forEach [
								'QS_ao_HQ',
								'QS_ao_SD'
							];
							[1] call _fn_artillery;
							_scToRemove = [];
							{
								_scToRemove pushBack (_x # 0);
							} forEach (missionNamespace getVariable 'QS_virtualSectors_data');
							{
								['REMOVE',_x] call _fn_sc;
							} forEach _scToRemove;
							missionNamespace setVariable ['QS_virtualSectors_locations',[],_false];
							deleteVehicle (missionNamespace getVariable ['QS_virtualSectors_entities',[]]);
							missionNamespace setVariable ['QS_virtualSectors_entities',[],_false];
							if ((missionNamespace getVariable 'QS_virtualSectors_subObjectives') isNotEqualTo []) then {
								{
									if (_x isEqualType []) then {
										if (_x isNotEqualTo []) then {
											_array = (_x # 2) # 2;
											if (!isNil '_array') then {
												if (_array isEqualType []) then {
													if (_array isNotEqualTo []) then {
														{
															if (_x isEqualType _objNull) then {
																if (!isNull _x) then {
																	if (!isNull (attachedTo _x)) then {
																		[0,_x] call _fn_eventAttach;
																	};
																	deleteVehicle _x;
																};
															};
														} forEach _array;
													
													};
												};
											};
										};
									};
								} forEach (missionNamespace getVariable 'QS_virtualSectors_subObjectives');
								missionNamespace setVariable ['QS_virtualSectors_subObjectives',[],_false];
							};
							if ((missionNamespace getVariable 'QS_virtualSectors_siteMarkers') isNotEqualTo []) then {
								{
									if (_x in allMapMarkers) then {
										deleteMarker _x;
									};
								} forEach (missionNamespace getVariable 'QS_virtualSectors_siteMarkers');
								missionNamespace setVariable ['QS_virtualSectors_siteMarkers',[],_false];
							};
							if ((missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') isNotEqualTo []) then {
								{
									if (!isNull _x) then {
										if (isObjectHidden _x) then {
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'UNHIDE_DISCREET',0];
										};
									};
								} forEach (missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects');
								missionNamespace setVariable ['QS_virtualSectors_hiddenTerrainObjects',[],_false];
							};
							if ((missionNamespace getVariable ['QS_ao_civVehicles',[]]) isNotEqualTo []) then {
								{
									if (!isNull _x) then {
										0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
									};
								} forEach (missionNamespace getVariable ['QS_ao_civVehicles',[]]);
								missionNamespace setVariable ['QS_ao_civVehicles',[],_false];
							};
							if ((missionNamespace getVariable ['QS_primaryObjective_civilians',[]]) isNotEqualTo []) then {
								deleteVehicle (missionNamespace getVariable ['QS_primaryObjective_civilians',[]]);
								missionNamespace setVariable ['QS_primaryObjective_civilians',[],_false];
							};
							deleteVehicle (_allMines select {
								(
									(local _x) &&
									((_x distance2D (missionNamespace getvariable ['QS_aoPos',[0,0,0]])) < 1200)
								)
							});
							if ((missionNamespace getVariable ['QS_entities_ao_customEntities',[]]) isNotEqualTo []) then {
								{
									if (!isNull _x) then {
										if (isSimpleObject _x) then {
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										} else {
											deleteVehicle _x;
										};
									};
								} forEach (missionNamespace getVariable ['QS_entities_ao_customEntities',[]]);
								missionNamespace setVariable ['QS_entities_ao_customEntities',[],_false];
							};
							if ((missionNamespace getVariable ['QS_entities_ao_customStructures',[]]) isNotEqualTo []) then {
								{
									if (!isNull _x) then {
										(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
									};
								} forEach (missionNamespace getVariable ['QS_entities_ao_customStructures',[]]);
								missionNamespace setVariable ['QS_entities_ao_customStructures',[],_false];
							};
							if ((missionNamespace getVariable ['QS_aoAnimals',[]]) isNotEqualTo []) then {
								deleteVehicle (missionNamespace getVariable ['QS_aoAnimals',[]]);
								missionNamespace setVariable ['QS_aoAnimals',[],_false];
							};
							if ((missionNamespace getVariable ['QS_ao_UXOs',[]]) isNotEqualTo []) then {
								deleteVehicle (missionNamespace getVariable ['QS_ao_UXOs',[]]);
								missionNamespace setVariable ['QS_ao_UXOs',[],_false];
							};
							{
								_x call _fn_deleteTask;
							} forEach [
								['QS_virtualSectors_sub_1_task'],
								['QS_virtualSectors_sub_2_task'],
								['QS_virtualSectors_sub_3_task']
							];
							_scToRemove = [];
							_aoStartDelay = time + (30 + (random 15));
						};
					} else {
						if ((missionNamespace getVariable 'QS_mission_aoType') isEqualTo 'GRID') then {
							if (['EVALUATE_AO',_grid_availableRegion_id,_grid_availableAO_id,''] call _fn_grid) then {
								if (missionNamespace getVariable ['QS_grid_evalMarkers',_false]) then {
									_grid_markerEvalTimeout = diag_tickTime + 30;
									waitUntil {
										uiSleep 0.1;
										((!(missionNamespace getVariable ['QS_grid_evalMarkers',_false])) || {(diag_tickTime > _grid_markerEvalTimeout)})
									};
								};
								_mainMissionActive = _false;
								missionNamespace setVariable ['QS_grid_active',_false,_true];
								diag_log '***** QS ***** DEBUG * GRID COMPLETE *****';
								['AO_SETSTATE',_grid_availableRegion_id,_grid_availableAO_id,2] call _fn_grid;
								_grid_availableAO_id = -1;
								['SAVE'] call _fn_grid;
								missionNamespace setVariable ['QS_grid_AIRspTotal',0,_false];
								missionNamespace setVariable ['QS_grid_AIRspDestroyed',0,_false];
								{
									_element = _x;
									_arrayIndex = (missionNamespace getVariable 'QS_AI_regroupPositions') findIf {((_x # 0) isEqualTo _element)};
									if (_arrayIndex isNotEqualTo -1) then {
										(missionNamespace getVariable 'QS_AI_regroupPositions') set [_arrayIndex,_false];
										(missionNamespace getVariable 'QS_AI_regroupPositions') deleteAt _arrayIndex;
									};
								} forEach [
									'QS_ao_HQ',
									'QS_ao_SD'
								];
								if ((missionNamespace getVariable ['QS_grid_aoProps',[]]) isNotEqualTo []) then {
									{
										(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
									} forEach (missionNamespace getVariable 'QS_grid_aoProps');
									missionNamespace setVariable ['QS_grid_aoProps',[],_false];
								};
								missionNamespace setVariable ['QS_grid_aoData',[],_false];
								if ((missionNamespace getVariable ['QS_grid_hiddenTerrainObjects',[]]) isNotEqualTo []) then {
									{
										if (!isNull _x) then {
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'UNHIDE_DISCREET',0];
										};
									} forEach (missionNamespace getVariable ['QS_grid_hiddenTerrainObjects',[]]);
									missionNamespace setVariable ['QS_grid_hiddenTerrainObjects',[],_false];
								};
								if ((missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]]);
									missionNamespace setVariable ['QS_grid_enemyRespawnObjects',[],_true];
								};
								if ((missionNamespace getVariable ['QS_grid_IGcomposition',[]]) isNotEqualTo []) then {
									{
										(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
									} forEach (missionNamespace getVariable ['QS_grid_IGcomposition',[]]);
									missionNamespace setVariable ['QS_grid_IGcomposition',[],_false];
								};
								if (!(missionNamespace getVariable ['QS_grid_IDAP_taskActive',_false])) then {
									if ((missionNamespace getVariable ['QS_grid_IDAPcomposition',[]]) isNotEqualTo []) then {
										{
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										} forEach (missionNamespace getVariable ['QS_grid_IDAPcomposition',[]]);
										missionNamespace setVariable ['QS_grid_IDAPcomposition',[],_false];
									};
								};
								missionNamespace setVariable ['QS_grid_intelTargets',[],_false];
								if ((missionNamespace getVariable ['QS_grid_intelEntities',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_grid_intelEntities',[]]);
									missionNamespace setVariable ['QS_grid_intelEntities',[],_false];
								};
								if (!isNull (missionNamespace getVariable ['QS_grid_IDAPintel',_objNull])) then {
									deleteVehicle (missionNamespace getVariable 'QS_grid_IDAPintel');
									missionNamespace setVariable ['QS_grid_IDAPintel',_objNull,_false];
								};
								if (!isNull (missionNamespace getVariable ['QS_grid_IGintel',_objNull])) then {
									deleteVehicle (missionNamespace getVariable 'QS_grid_IGintel');
									missionNamespace setVariable ['QS_grid_IGintel',_objNull,_false];
								};
								if ((missionNamespace getVariable ['QS_grid_intelMarkers',[]]) isNotEqualTo []) then {
									{
										deleteMarker _x;
									} forEach (missionNamespace getVariable ['QS_grid_intelMarkers',[]]);
									missionNamespace setVariable ['QS_grid_intelMarkers',[],_false];
								};
								if ((missionNamespace getVariable ['QS_grid_intelHouses',[]]) isNotEqualTo []) then {
									missionNamespace setVariable ['QS_grid_intelHouses',[],_false];
								};
								if ((missionNamespace getVariable ['QS_ao_UXOs',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_ao_UXOs',[]]);
									missionNamespace setVariable ['QS_ao_UXOs',[],_false];
								};
								if ((missionNamespace getVariable ['QS_grid_IDAP_uxoField',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_grid_IDAP_uxoField',[]]);
									missionNamespace setVariable ['QS_grid_IDAP_uxoField',[],_false];
								};
								deleteVehicle (_allMines select {
									(
										(local _x) &&
										((_x distance2D (missionNamespace getvariable ['QS_aoPos',[0,0,0]])) < 1200)
									)
								});
								if ((missionNamespace getVariable ['QS_grid_IGstaticComposition',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_grid_IGstaticComposition',[]]);
									missionNamespace setVariable ['QS_grid_IGstaticComposition',[],_false];
								};
								if ((missionNamespace getVariable ['QS_primaryObjective_civilians',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_primaryObjective_civilians',[]]);
									missionNamespace setVariable ['QS_primaryObjective_civilians',[],_false];
								};
								if ((missionNamespace getVariable ['QS_ao_civVehicles',[]]) isNotEqualTo []) then {
									{
										if (!isNull _x) then {
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										};
									} forEach (missionNamespace getVariable ['QS_ao_civVehicles',[]]);
									missionNamespace setVariable ['QS_ao_civVehicles',[],_false];
								};
								if ((missionNamespace getVariable ['QS_entities_ao_customEntities',[]]) isNotEqualTo []) then {
									{
										if (!isNull _x) then {
											if (isSimpleObject _x) then {
												(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
											} else {
												deleteVehicle _x;
											};
										};
									} forEach (missionNamespace getVariable ['QS_entities_ao_customEntities',[]]);
									missionNamespace setVariable ['QS_entities_ao_customEntities',[],_false];
								};
								if ((missionNamespace getVariable ['QS_entities_ao_customStructures',[]]) isNotEqualTo []) then {
									{
										if (!isNull _x) then {
											(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										};
									} forEach (missionNamespace getVariable ['QS_entities_ao_customStructures',[]]);
									missionNamespace setVariable ['QS_entities_ao_customStructures',[],_false];
								};
								if ((missionNamespace getVariable ['QS_aoAnimals',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_aoAnimals',[]]);
									missionNamespace setVariable ['QS_aoAnimals',[],_false];
								};
								if (!(missionNamespace getVariable ['QS_grid_AI_triggerDeinit',_false])) then {
									missionNamespace setVariable ['QS_grid_AI_triggerDeinit',_true,_true];
								};
								_arrayIndex = (missionNamespace getVariable 'QS_positions_fieldHospitals') findIf {((_x # 0) isEqualTo 'GRID_IG')};
								if (_arrayIndex isNotEqualTo -1) then {
									(missionNamespace getVariable 'QS_positions_fieldHospitals') set [_arrayIndex,_false];
									(missionNamespace getVariable 'QS_positions_fieldHospitals') deleteAt _arrayIndex;
									missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),_true];
								};
							};
						};
					};
				};
			};
		};
		/*/===== AO Small Tasks/*/
		
		if (_QS_module_aoSmallTasks) then {
			if ((_timeNow > _QS_module_aoSmallTasks_checkDelay) || {(!isNil 'QS_aoCycleSmallTask')}) then {
				if ((_timeNow > 120) || {(!isNil 'QS_aoCycleSmallTask')}) then {
					if (!(_QS_module_aoSmallTasks_isActive)) then {
						if ((!(_defendAOActive)) || {(!isNil 'QS_aoCycleSmallTask')}) then {
							if (!(missionNamespace getVariable 'QS_customAO_active')) then {
								if ((_timeNow > _QS_module_aoSmallTasks_timeoutDelay) || {(!isNil 'QS_aoCycleSmallTask')}) then {
									if !(missionNamespace isNil 'QS_aoCycleSmallTask') then {
										missionNamespace setVariable ['QS_aoCycleSmallTask',nil,_false];
									};
									diag_log 'CREATING SMALL TASK';
									_QS_module_aoSmallTasks_isActive = _true;
									_QS_module_aoSmallTasks_list = [1,2];
									_QS_module_aoSmallTasks_current = selectRandom _QS_module_aoSmallTasks_list;
									_QS_module_aoSmallTasks_data = [_QS_module_aoSmallTasks_current,1,[]] call _fn_aoSmallTask;
									if (_QS_module_aoSmallTasks_data isEqualType 0) then {
										_QS_module_aoSmallTasks_isActive = _false;
										diag_log 'CREATING SMALL TASK FAILED';
									};
								};
							};
						};
					} else {
						if ((_QS_module_aoSmallTasks_data call _fn_aoSmallTask) isEqualType []) then {
							diag_log 'DELETING SMALL TASK';
							_QS_module_aoSmallTasks_isActive = _false;
							_QS_module_aoSmallTasks_data set [1,0];
							_QS_module_aoSmallTasks_data = _QS_module_aoSmallTasks_data call _fn_aoSmallTask;
							_QS_module_aoSmallTasks_timeoutDelay = _timeNow + _QS_module_aoSmallTasks_timeout;
						};
					};
				};
				_QS_module_aoSmallTasks_checkDelay = _timeNow + _QS_module_aoSmallTasks_delay;
			};
		};
	};
	
	/*/Old Forward Operating Bases/*/
	
	if (_module_fob_enabled) then {
		if (_timeNow > _module_fob_checkDelay) then {
			if ((missionNamespace getVariable 'QS_activeRegion') isNotEqualTo _module_fob_activeRegion) then {
				//comment 'RELEVANT FOB NOT CREATED, CREATE IT';
				_module_fob_activeRegion = missionNamespace getVariable 'QS_activeRegion';
				if (_module_fob_fob isNotEqualTo []) then {
					diag_log '***** FOB ***** ADD TO REMAINS COLLECTOR *****';
					_module_fob_fob = [0,_module_fob_fob] call _fn_fobPrepare;
					_module_fob_isFobActive = _false;
					_trigger_delete_fobVehicles = _true;
				};
				if (_module_fob_activeRegion isNotEqualTo -1) then {
					diag_log '***** FOB ***** CREATING *****';
					_module_fob_fob = [1,_module_fob_activeRegion] call _fn_fobPrepare;
					_module_fob_vData = ([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 2;
					_module_fob_location = ([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 0;
					missionNamespace setVariable ['QS_module_fob_centerPosition',_module_fob_location,_false];
					_module_fob_assault_timer = _timeNow + 900 + 300 - (random 600);
					_module_fob_logistics_complete = _false;
					_module_fob_logistics_respawnEnabled = _false;
					_module_fob_logistics_vehicleRespawnEnabled = _false;
					_module_fob_logistics_vehicleService = _false;
					_module_fob_logistics_reinforceServices = _false;
					_module_fob_logistics_ammoServices = _false;
					_module_fob_logistics_repairServices = _false;
					_module_fob_logistics_fuelServices = _false;
					_module_fob_isFobActive = _true;
					/*/ Communicate with players /*/
					['FOB_INIT',['',(format ['%2 %1',(([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 5),localize 'STR_QS_Notif_047'])]] remoteExec ['QS_fnc_showNotification',-2,_false];
				};
			} else {
				//comment 'RELEVANT FOB IS ALREADY CREATED, MANAGE IT HERE';
				_supportMessagePopped = _false;
				{
					_ve = _x;
					// RESPAWN / TICKETS
					if (
						(_ve getVariable ['QS_services_medical',_false]) &&
						{(isNull (attachedTo _ve))} &&
						{(isNull (ropeAttachedTo _ve))} &&
						{_ve isNil 'QS_vehicle_isSuppliedFOB'}
					) exitWith {
						_ve setVariable ['QS_vehicle_isSuppliedFOB',_true,_true];
						_dn1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _ve)],
							{getText ((configOf _ve) >> 'displayName')},
							_true
						];
						if (!(_module_fob_logistics_respawnEnabled)) then {
							_module_fob_logistics_respawnEnabled = _true;
							missionNamespace setVariable ['QS_module_fob_respawnEnabled',_module_fob_logistics_respawnEnabled,_true];
						};
						_module_fob_respawn_ticketsAdded = 0;
						if (_ve isKindOf 'Slingload_base_F') then {			// Huron medical container
							_module_fob_respawn_ticketsAdded = 4;
						} else {
							_module_fob_respawn_ticketsAdded = _ve getVariable ['QS_medicalVehicle_reviveTickets',(getNumber ((configOf _ve) >> 'transportSoldier'))];
						};
						QS_module_fob_flag setVariable ['QS_deploy_tickets',(QS_module_fob_flag getVariable ['QS_deploy_tickets',0]) + _module_fob_respawn_ticketsAdded,_true];
						0 = ['sideChat',[_west,'HQ'],(format ['%3 %1 %4 %2',_module_fob_respawn_ticketsAdded,(QS_module_fob_flag getVariable ['QS_deploy_tickets',0]),localize 'STR_QS_Chat_041',localize 'STR_QS_Chat_042'])] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
						if !(_ve isNil 'QS_transporter') then {
							if (alive ((_ve getVariable 'QS_transporter') # 1)) then {
								0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',((_ve getVariable 'QS_transporter') # 2),((_ve getVariable 'QS_transporter') # 0),4];
							};
							if (!(_supportMessagePopped)) then {
								_supportMessagePopped = _true;
								['sideChat',[_west,'BLU'],(format [localize 'STR_QS_Chat_043',((_ve getVariable 'QS_transporter') # 0),_dn1])] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
							};
						};
					};
					// VEHICLE RESPAWN
					if (
						(!(_module_fob_logistics_vehicleRespawnEnabled)) &&
						{((getMass _ve) > 5000)} &&
						{(isNull (attachedTo _ve))} &&
						{(isNull (ropeAttachedTo _ve))} &&
						{(
							(['box',(typeOf _ve),_false] call _fn_inString) || 
							{(['mover',(typeOf _ve),_false] call _fn_inString)} || 
							{(['cargo',(typeOf _ve),_false] call _fn_inString)}
						)}
					) exitWith {
						_ve setVariable ['QS_vehicle_isSuppliedFOB',_true,_true];
						_dn1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _ve)],
							{getText ((configOf _ve) >> 'displayName')},
							_true
						];
						_module_fob_logistics_vehicleRespawnEnabled = _true;
						_vRespawn_checkDelay = -1;
						['VEHICLES_ADD',_module_fob_activeRegion] call _fn_fobAssets;
						missionNamespace setVariable ['QS_module_fob_vehicleRespawnEnabled',_module_fob_logistics_vehicleRespawnEnabled,_true];
						0 = ['FOB_UPDATE',['',localize 'STR_QS_Notif_048']] remoteExec ['QS_fnc_showNotification',-2,_false];
						if (alive ((_ve getVariable 'QS_transporter') # 1)) then {
							0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',((_ve getVariable 'QS_transporter') # 2),((_ve getVariable 'QS_transporter') # 0),4];
						};
					};					
					// VEHICLE REPAIR
					if (
						(!(_module_fob_logistics_repairServices)) &&
						{((getRepairCargo _ve) > -1)} &&
						{((getMass _ve) > 5000)} &&				// exclude light repair cars
						{(isNull (attachedTo _ve))} &&
						{(isNull (ropeAttachedTo _ve))} &&
						{_ve isNil 'QS_vehicle_isSuppliedFOB'}
					) exitWith {
						_ve setVariable ['QS_vehicle_isSuppliedFOB',_true,_true];
						_dn1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _ve)],
							{getText ((configOf _ve) >> 'displayName')},
							_true
						];
						_module_fob_logistics_repairServices = _true;
						_module_fob_logistics_fuelServices = _true;
						missionNamespace setVariable ['QS_module_fob_services_repair',_module_fob_logistics_repairServices,_true];
						missionNamespace setVariable ['QS_module_fob_services_fuel',_module_fob_logistics_fuelServices,_true];
						'QS_marker_veh_fieldservice_04' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 3);
						'QS_marker_veh_fieldservice_01' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 4);
						'QS_marker_veh_fieldservice_04' setMarkerAlpha 0.5;
						'QS_marker_veh_fieldservice_01' setMarkerAlpha 0.5;
						(missionNamespace getVariable 'QS_module_fob_repairDepot') hideObjectGlobal _false;
						0 = ['FOB_UPDATE',['',localize 'STR_QS_Notif_049']] remoteExec ['QS_fnc_showNotification',-2,_false];
					};
					// VEHICLE REAMMO
					if (
						(!(_module_fob_logistics_ammoServices)) &&
						{((getAmmoCargo _ve) > -1)} &&
						{((getRepairCargo _ve) isEqualTo -1)} &&		// Exclude multi-service assets
						{(isNull (attachedTo _ve))} &&
						{(isNull (ropeAttachedTo _ve))} &&
						{((getMass _ve) > 2000)} &&
						{_ve isNil 'QS_vehicle_isSuppliedFOB'}
					) exitWith {
						_ve setVariable ['QS_vehicle_isSuppliedFOB',_true,_true];
						_dn1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _ve)],
							{getText ((configOf _ve) >> 'displayName')},
							_true
						];
						_module_fob_logistics_ammoServices = _true;
						missionNamespace setVariable ['QS_module_fob_services_ammo',_module_fob_logistics_ammoServices,_true];
						(missionNamespace getVariable 'QS_module_fob_supplycrate') hideObjectGlobal _false;
						'QS_marker_veh_fieldservice_04' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 3);
						'QS_marker_veh_fieldservice_01' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 4);
						'QS_marker_veh_fieldservice_04' setMarkerAlpha 0.5;
						'QS_marker_veh_fieldservice_01' setMarkerAlpha 0.5;
						0 = ['FOB_UPDATE',['',localize 'STR_QS_Notif_050']] remoteExec ['QS_fnc_showNotification',-2,_false];
						if !(_ve isNil 'QS_transporter') then {
							if (alive ((_ve getVariable 'QS_transporter') # 1)) then {
								0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',((_ve getVariable 'QS_transporter') # 2),((_ve getVariable 'QS_transporter') # 0),4];
							};
							if (!(_supportMessagePopped)) then {
								_supportMessagePopped = _true;
								['sideChat',[_west,'BLU'],(format [localize 'STR_QS_Chat_043',((_ve getVariable 'QS_transporter') # 0),_dn1])] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
							};
						};
					};
					// VEHICLE REFUEL
					if (
						(!(_module_fob_logistics_fuelServices)) &&
						{((getFuelCargo _ve) > -1)} &&
						{((getAmmoCargo _ve) isEqualTo -1)} &&		// Exclude multi-service assets
						{(isNull (attachedTo _ve))} &&
						{(isNull (ropeAttachedTo _ve))} &&
						{_ve isNil 'QS_vehicle_isSuppliedFOB'}
					) exitWith {
						_ve setVariable ['QS_vehicle_isSuppliedFOB',_true,_true];
						_dn1 = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _ve)],
							{getText ((configOf _ve) >> 'displayName')},
							_true
						];
						_module_fob_logistics_repairServices = _true;
						_module_fob_logistics_fuelServices = _true;
						missionNamespace setVariable ['QS_module_fob_services_repair',_module_fob_logistics_repairServices,_true];
						missionNamespace setVariable ['QS_module_fob_services_fuel',_module_fob_logistics_fuelServices,_true];
						'QS_marker_veh_fieldservice_04' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 3);
						'QS_marker_veh_fieldservice_01' setMarkerPosLocal (([_module_fob_activeRegion] call (missionNamespace getVariable 'QS_data_fobs')) # 4);
						'QS_marker_veh_fieldservice_04' setMarkerAlpha 0.5;
						'QS_marker_veh_fieldservice_01' setMarkerAlpha 0.5;
						(missionNamespace getVariable 'QS_module_fob_repairDepot') hideObjectGlobal _false;
						0 = ['FOB_UPDATE',['',localize 'STR_QS_Notif_049']] remoteExec ['QS_fnc_showNotification',-2,_false];
						if !(_ve isNil 'QS_transporter') then {
							if (alive ((_ve getVariable 'QS_transporter') # 1)) then {
								0 = (missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TRANSPORT',((_ve getVariable 'QS_transporter') # 2),((_ve getVariable 'QS_transporter') # 0),4];
							};
							if (!(_supportMessagePopped)) then {
								_supportMessagePopped = _true;
								['sideChat',[_west,'BLU'],(format [localize 'STR_QS_Chat_043',((_ve getVariable 'QS_transporter') # 0),_dn1])] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
							};
						};
					};
				} forEach (_module_fob_location nearEntities [_module_fob_logistics_assetTypes,_module_fob_logistics_radius]);
			};
			if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo sideUnknown) then {
				if ((missionNamespace getVariable 'QS_allowedHUD_sideUnknown') isNotEqualTo _QS_module_fob_sideShownHUD_radarON) then {
					{
						missionNamespace setVariable _x;
					} forEach [
						[(format ['QS_allowedHUD_%1',(missionNamespace getVariable 'QS_module_fob_side')]),_QS_module_fob_sideShownHUD_radarON,_true],
						['QS_allowedHUD_EAST',_QS_module_fob_sideShownHUD_radarOFF,_true],
						['QS_allowedHUD_WEST',_QS_module_fob_sideShownHUD_radarOFF,_true],
						['QS_allowedHUD_RESISTANCE',_QS_module_fob_sideShownHUD_radarOFF,_true],
						['QS_allowedHUD_CIVILIAN',_QS_module_fob_sideShownHUD_radarOFF,_true]
					];
					[29,sideUnknown] remoteExec ['QS_fnc_remoteExec',-2,_false];
				};
			} else {
				if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo _east) then {
					if ((missionNamespace getVariable 'QS_allowedHUD_EAST') isNotEqualTo _QS_module_fob_sideShownHUD_radarON) then {
						{
							missionNamespace setVariable _x;
						} forEach [
							[(format ['QS_allowedHUD_%1',(missionNamespace getVariable 'QS_module_fob_side')]),_QS_module_fob_sideShownHUD_radarON,_true],
							['QS_allowedHUD_WEST',_QS_module_fob_sideShownHUD_radarOFF,_true],
							['QS_allowedHUD_RESISTANCE',_QS_module_fob_sideShownHUD_radarOFF,_true],
							['QS_allowedHUD_CIVILIAN',_QS_module_fob_sideShownHUD_radarOFF,_true]
						];
						[29,_east] remoteExec ['QS_fnc_remoteExec',-2,_false];
					};
				} else {
					if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo _west) then {
						if ((missionNamespace getVariable 'QS_allowedHUD_WEST') isNotEqualTo _QS_module_fob_sideShownHUD_radarON) then {
							{
								missionNamespace setVariable _x;
							} forEach [
								[(format ['QS_allowedHUD_%1',(missionNamespace getVariable 'QS_module_fob_side')]),_QS_module_fob_sideShownHUD_radarON,_true],
								['QS_allowedHUD_EAST',_QS_module_fob_sideShownHUD_radarOFF,_true],
								['QS_allowedHUD_RESISTANCE',_QS_module_fob_sideShownHUD_radarOFF,_true],
								['QS_allowedHUD_CIVILIAN',_QS_module_fob_sideShownHUD_radarOFF,_true]
							];
							[29,_west] remoteExec ['QS_fnc_remoteExec',-2,_false];
						};			
					} else {
						if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo RESISTANCE) then {
							if ((missionNamespace getVariable 'QS_allowedHUD_RESISTANCE') isNotEqualTo _QS_module_fob_sideShownHUD_radarON) then {							
								{
									missionNamespace setVariable _x;
								} forEach [
									[(format ['QS_allowedHUD_%1',(missionNamespace getVariable 'QS_module_fob_side')]),_QS_module_fob_sideShownHUD_radarON,_true],
									['QS_allowedHUD_EAST',_QS_module_fob_sideShownHUD_radarOFF,_true],
									['QS_allowedHUD_WEST',_QS_module_fob_sideShownHUD_radarOFF,_true],
									['QS_allowedHUD_CIVILIAN',_QS_module_fob_sideShownHUD_radarOFF,_true]
								];
								[29,RESISTANCE] remoteExec ['QS_fnc_remoteExec',-2,_false];
							};
						} else {
							if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo CIVILIAN) then {
								if ((missionNamespace getVariable 'QS_allowedHUD_CIVILIAN') isNotEqualTo _QS_module_fob_sideShownHUD_radarON) then {
									{
										missionNamespace setVariable _x;
									} forEach [
										[(format ['QS_allowedHUD_%1',(missionNamespace getVariable 'QS_module_fob_side')]),_QS_module_fob_sideShownHUD_radarON,_true],
										['QS_allowedHUD_EAST',_QS_module_fob_sideShownHUD_radarOFF,_true],
										['QS_allowedHUD_WEST',_QS_module_fob_sideShownHUD_radarOFF,_true],
										['QS_allowedHUD_RESISTANCE',_QS_module_fob_sideShownHUD_radarOFF,_true]
									];
									[29,CIVILIAN] remoteExec ['QS_fnc_remoteExec',-2,_false];
								};
							};
						};
					};
				};
			};
			
			if (
				(_module_fob_isFobActive) &&
				{(_module_fob_attackEnabled)} &&
				{((_timeNow > _module_fob_assault_checkDelay) || {(missionNamespace getVariable ['QS_fob_cycleAttack',_false])})}
			) then {
				if (!(_module_fob_underAssault)) then {
					if ((_allAICount < _unitCap) || {(missionNamespace getVariable ['QS_fob_cycleAttack',_false])}) then {
						if ((_timeNow > _module_fob_assault_timer) || {((missionNamespace getVariable ['QS_fob_cycleAttack',_false]))}) then {
							_module_fob_underAssault = _true;
							_module_fob_assault_duration = _timeNow + 600;
							missionNamespace setVariable ['QS_module_fob_attacked',_module_fob_underAssault,_true];
						};
					};
				} else {
					if (_timeNow < _module_fob_assault_duration) then {
						if (
							(_allAICount < _unitCap) &&
							{(((missionNamespace getVariable 'QS_module_fob_assaultArray') isEqualTo []) || {(({(alive _x)} count (missionNamespace getVariable 'QS_module_fob_assaultArray')) < 3)})} &&
							{(_fps >= 15)} &&
							{(!(missionNamespace getVariable ['QS_defendActive',_false]))}
						) then {
							[(markerPos 'QS_marker_module_fob')] call _fn_fobEnemyAssault;
						};
					} else {
						if (_module_fob_underAssault) then {
							_module_fob_underAssault = _false;
							missionNamespace setVariable ['QS_module_fob_attacked',_module_fob_underAssault,_true];
							[(missionNamespace getVariable 'QS_module_fob_flag'),_west,'',_false,_objNull,1] call _fn_setFlag;
							_module_fob_assault_timer = _timeNow + 900 + 300 - (random 600);
							if (((missionNamespace getVariable 'QS_module_fob_assaultArray') findIf {(alive _x)}) isNotEqualTo -1) then {
								{
									if (!isNull _x) then {
										_x setDamage 1;
									};
								} count (missionNamespace getVariable 'QS_module_fob_assaultArray');
							};
							missionNamespace setVariable ['QS_module_fob_assaultArray',[],_false];
						};
					};
				};
				if (([(markerPos 'QS_marker_module_fob'),50,_enemySides,_allUnits,1] call _fn_serverDetector) > 1) then {
					if (([(markerPos 'QS_marker_module_fob'),100,[_west],_allUnits,1] call _fn_serverDetector) < 1) then {
						[(missionNamespace getVariable 'QS_module_fob_flag'),_east,'',_false,_objNull,1] call _fn_setFlag;
					};
				};					
				_module_fob_assault_checkDelay = _timeNow + _module_fob_assault_delay;
			};
		};
	};
	/*/===== CUSTOM MISSION MODULE/*/

	if ((_QS_module_customMissions) || {(missionNamespace getVariable 'QS_customAO_trigger')}) then {
		if (!(missionNamespace getVariable 'QS_customAO_active')) then {
			if ((!(_QS_module_customMission_played)) || {(missionNamespace getVariable 'QS_customAO_trigger')}) then {
				if ((!(_mainMissionActive)) && (!(_defendAOActive)) && (!(missionNamespace getVariable ['QS_grid_defend_active',_false]))) then {
					if (((_timeNow > _QS_module_customMissions_delay) && (_allPlayersCount <= 36) && (_allPlayersCount >= 4)) || {(missionNamespace getVariable 'QS_customAO_trigger')}) then {
						if (_QS_module_customMissions_list isNotEqualTo []) then {
							if (missionNamespace getVariable 'QS_customAO_trigger') then {
								missionNamespace setVariable ['QS_customAO_trigger',_false,_false];
							};
							if ((missionNamespace getVariable 'QS_customAO_select') isNotEqualTo '') then {
								_QS_module_customMission_selected = missionNamespace getVariable 'QS_customAO_select';
							} else {
								_QS_module_customMission_selected = selectRandom _QS_module_customMissions_list;
								_QS_module_customMissions_list deleteAt (_QS_module_customMissions_list find _QS_module_customMission_selected);
							};
							_QS_module_customMission_played = _true;
							missionNamespace setVariable ['QS_customAO_active',_true,_false];
							diag_log '***** Spawning custom AO *****';
							missionNamespace setVariable ['QS_customAO_script',(0 spawn (missionNamespace getVariable _QS_module_customMission_selected)),_false];
						};
					};
				};
			};
		} else {
			if (scriptDone (missionNamespace getVariable 'QS_customAO_script')) then {
				diag_log '***** Custom AO finished *****';
				missionNamespace setVariable ['QS_customAO_active',_false,_false];
			};
		};
	};
	
	/*/===================================== SECONDARY MISSION/*/

	if (_sideMissions) then {
		if (!(_sideMissionActive)) then {
			if (
				(_timeNow > 80) &&
				{(!(missionNamespace getVariable ['QS_customAO_blockSideMissions',_false]))} &&
				{(!(missionNamespace getVariable ['QS_smSuspend',_false]))} &&
				{((_timeNow > _smDelay) || {(missionNamespace getVariable ['QS_forceSideMission',_false])})} &&
				{((_allAICount < _unitCap) || {(_allPlayersCount < 25)} || {(missionNamespace getVariable ['QS_forceSideMission',_false])})}
			) then {
				if (missionNamespace getVariable 'QS_forceSideMission') then {
					missionNamespace setVariable ['QS_forceSideMission',_false,_false];
				};
				_sideMissionActive = _true;
				_sideMission = selectRandomWeighted _sideMissionListProxy;
				_currentSideMission = 0 spawn (missionNamespace getVariable _sideMission);
			};
		} else {
			if (scriptDone _currentSideMission) then {
				if (_allPlayersCount < 20) then {
					_smDelay = time + ((_sideMissionDelayFixed + (random _sideMissionDelayRandom)) / 2);
				} else {
					_smDelay = time + (_sideMissionDelayFixed + (random _sideMissionDelayRandom));
				};
				_sideMissionActive = _false;
			};
		};
	};
	
	/*/===== Deployment Mission module/*/

	if (_deploymentMissions) then {
		if (_timeNow > _deploymentMissionCheckDelay) then {
			_deploymentMissionCheckDelay = _timeNow + _deploymentMissionCheckInterval;
			_deploymentMissionScripts = _deploymentMissionScripts select {(!isNull _x)};
			if (
				(
					((count _deploymentMissionScripts) < _deploymentMissionMaxConcurrent) &&
					{(QS_logistics_deployedAssets isNotEqualTo [])} &&
					{(_timeNow > _deploymentMissionDelay)}
				) ||
				{(localNamespace getVariable ['QS_deploymentMissions_forceAttack',_false])}
			) then {
				_deploymentMissionDelay = _timeNow + _deploymentMissionInterval;
				_deploymentMissionScript = [
					_deploymentMissionMaxConcurrent,
					_deploymentMissionFrequency,
					_deploymentMissionIntensity,
					_deploymentMissionDuration,
					_deploymentMissionSetupTime,
    				_deploymentMissionOverclock
				] spawn _fn_deployAssault;
				_deploymentMissionScripts pushBack _deploymentMissionScript;
			};
		};
	};
	
	/*/===== CAS module/*/

	if (_QS_module_cas_respawn) then {
		if (_timeNow > _QS_module_cas_respawn_checkDelay) then {
			if (missionNamespace getVariable ['QS_CAS_jetAllowance_gameover',_false]) then {
				if (alive (missionNamespace getVariable ['QS_fighterPilot',_objNull])) then {
					_casUID = getPlayerUID (missionNamespace getVariable 'QS_fighterPilot');
					if (_casUID isNotEqualTo '') then {
						_casPilot = missionNamespace getVariable ['QS_fighterPilot',_objNull];
						if (isPlayer _casPilot) then {
							if (_casPilot getUnitTrait 'QS_trait_fighterPilot') then {
								missionNamespace setVariable ['QS_CAS_jetAllowance_gameover',_false,_false];
								['HANDLE',['HANDLE_REQUEST_ROLE','',(_casPilot getVariable ['QS_unit_side',WEST]),'rifleman',_casPilot]] call (missionNamespace getVariable 'QS_fnc_roles');
								_casPilot spawn {
									moveOut _this;
									uiSleep 0.5;
									remoteExec ['QS_fnc_clientEventRespawn',_this,FALSE];
								};
							};
						};
					};
				};
			};
			_casJetObj = missionNamespace getVariable ['QS_casJet',_objNull];
			if (alive _casJetObj) then {
				if (
					(!(canMove _casJetObj)) && 
					{((fuel _casJetObj) isEqualTo 0)} && 
					{(((getPosATL _casJetObj) # 2) < 10)} && 
					{((crew _casJetObj) isEqualTo [])}
				) then {
					_casJetObj setDamage [1,_false];
					deleteVehicle _casJetObj;
				};
			};
			_QS_module_cas_respawn_checkDelay = _timeNow + 15;
		};
	};
	
	if (_HVT_targeting_system) then {
		if (_timeNow > _HVT_checkDelay) then {
			_HVT_isTargeting = _false;
			_HVT_currentTargets = _HVT_currentTargets select {(alive _x)};
			if (_HVT_laserTargets isNotEqualTo []) then {
				{
					if (!alive (attachedTo _x)) then {
						deleteVehicle _x;
					};
				} forEach _HVT_laserTargets;
			};
			_HVT_laserTargets = _HVT_laserTargets select {(!isNull _x)};
			{
				if ((alive (effectiveCommander _x)) && {((side (group (effectiveCommander _x))) isEqualTo _west)}) then {
					_HVT_removeFrom = _false;
					_QS_v = _x;
					if (!(_QS_v in _HVT_currentTargets)) then {
						if (
							(_timeNow > _HVT_targetingDelay) &&
							{(!(_HVT_isTargeting))} &&
							{(
								(_QS_v isKindOf 'Tank') || 
								{(_QS_v isKindOf 'Wheeled_APC_F')}
							)} &&
							{(isTouchingGround _QS_v)} &&
							{(canMove _QS_v)} &&
							{((_east knowsAbout _QS_v) > 1)} &&
							{((_QS_v distance2D _baseMarker) > 1000)} &&
							{(_allPlayersCount >= _HVT_targetingThreshold)} &&
							{(!([_QS_v] call _fn_getVehicleStealth))}
						) then {
							_HVT_isTargeting = _true;
							_HVT_targetingDelay = _timeNow + (random [480,900,1800]);
							_HVT_currentTargets pushBack _QS_v;
							_HVT_laserTarget = createVehicle ['LaserTargetE',[0,0,0]];
							_HVT_laserTarget allowDamage _false;
							(missionNamespace getVariable 'QS_AI_laserTargets') pushBack _HVT_laserTarget;
							_HVT_laserTarget setPosASL (AGLToASL (_QS_v getRelPos [(40 * (sqrt (random 1))),(random 360)]));
							if (((_HVT_laserTarget getEventHandlerInfo ['IncomingMissile',0]) # 2) isEqualTo 0) then {
								_HVT_laserTarget addEventHandler [
									'IncomingMissile',
									{
										params ['_target','_ammo','_vehicle','_instigator','_missile'];
										_parent = attachedTo _target;
										if (alive _parent) then {
											[1,_target,[_parent,_parent worldToModel (_parent getRelPos [(40 * (sqrt (random 1))),(random 360)])]] call QS_fnc_eventAttach;
										};
										if (_ammo isKindOf 'BombCore') then {
											[103,_target,_ammo,_vehicle,_missile] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
										};
									}
								];
							};
							[_HVT_laserTarget,_QS_v,_false] call _fn_attachToRelative;
							_HVT_laserTarget hideObjectGlobal _true;
							_HVT_laserTargets pushBack _HVT_laserTarget;
							uiSleep 0.25;
							_HVT_laserTarget hideObject _false;
						};
					} else {
						if (
							((_QS_v distance2D _baseMarker) < 1000) ||
							{((_east knowsAbout _QS_v) < 1)} ||
							{(((attachedObjects _QS_v) findIf {(_x isKindOf 'LaserTargetE')}) isEqualTo -1)} ||
							{(!isTouchingGround _QS_v)} ||
							{(!canMove _QS_v)} ||
							{(_allPlayersCount < _HVT_targetingThreshold)} ||
							{([_QS_v] call _fn_getVehicleStealth)}
						) then {
							_HVT_currentTargets deleteAt (_HVT_currentTargets find _QS_v);
							{
								if (_x isKindOf 'LaserTargetE') then {
									[0,_x] call _fn_eventAttach;
									deleteVehicle _x;
								};
							} forEach (attachedObjects _QS_v);
						};
					};
					uiSleep 0.01;
				} else {
					if (_x in _HVT_currentTargets) then {
						_QS_v = _x;
						if (
							((_QS_v distance2D _baseMarker) < 1000) ||
							{((_east knowsAbout _QS_v) < 1)} ||
							{(((attachedObjects _QS_v) findIf {(_x isKindOf 'LaserTargetE')}) isEqualTo -1)} ||
							{(!isTouchingGround _QS_v)} ||
							{(!canMove _QS_v)} ||
							{(_allPlayersCount < _HVT_targetingThreshold)} ||
							{([_QS_v] call _fn_getVehicleStealth)}
						) then {
							_HVT_currentTargets deleteAt (_HVT_currentTargets find _QS_v);
							{
								if (_x isKindOf 'LaserTargetE') then {
									[0,_x] call _fn_eventAttach;
									deleteVehicle _x;
								};
							} forEach (attachedObjects _QS_v);
						};
					};
				};
			} forEach _allVehicles;
			_HVT_checkDelay = _timeNow + (60 + (random 10));
		};
	};
	
	/*/ Vehicle Manager /*/

	if (_timeNow > _vRespawn_checkDelay) then {
		if ((serverNamespace getVariable 'QS_v_Monitor') isNotEqualTo []) then {
			if (_trigger_delete_fobVehicles) then {
				_trigger_delete_fobVehicles = _false;
				['VEHICLES_REMOVE'] call _fn_fobAssets;
			};
			{
				if (_x isEqualType []) then {
					_array = (serverNamespace getVariable 'QS_v_Monitor') # _forEachIndex;
					_array params [
						['_v',_objNull],
						['_vdelay',30],
						['_randomize',_false],
						['_configCode',{}],
						['_t',''],
						['_vpos',[0,0,0]],
						['_dir',0],
						['_isRespawning',_false],
						['_canRespawnAfter',-1],
						['_fobVehicleID',-1],
						['_QS_vRespawnDist_base',100],
						['_QS_vRespawnDist_field',500],
						['_vRespawnTickets',-1],
						['_nearEntitiesCheck',4],
						['_isDynamicVehicle',_true],
						['_isCarrierVehicle',0],
						['_vehicleSpawnCondition',_codeBool],
						['_isWreck',_false],
						['_isDeployed',_false],
						['_stateInfo',[]],
						['_wreckInfo',[_false,'','','']],
						['_wreckChance',0],
						['_wreckCond',_codeBool],
						['_persistenceID',''],
						['_childEntities',[]]
					];
					if (!alive _v) then {
						if (!_isRespawning) then {
							_isRespawning = _true;
							_canRespawnAfter = _timeNow + _vdelay;
							(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,_isRespawning,_canRespawnAfter,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,_isWreck,_isDeployed,_stateInfo,_wreckInfo,_wreckChance,_wreckCond]];
						} else {
							if (
								(_timeNow > _canRespawnAfter) &&
								{(call _vehicleSpawnCondition)}
							) then {
								if (!isNull _v) then {
									if ((attachedObjects _v) isNotEqualTo []) then {
										{
											[0,_x] call _fn_eventAttach;
											deleteVehicle _x;
										} count (attachedObjects _v);
									};
									deleteVehicle _v;
									sleep 0.1;
								};
								if (_fobVehicleID in [-1,-2,9]) then {
									if ((_nearEntitiesCheck isEqualTo -1) || {([_vpos,_nearEntitiesCheck] call _fn_isPosSafe)}) then {
										if (_vRespawnTickets isNotEqualTo -1) then {
											if (_vRespawnTickets isEqualTo 0) then {
												(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,_false];
											} else {
												_vRespawnTickets = _vRespawnTickets - 1;
											};
										};
										if (_vRespawnTickets isNotEqualTo 0) then {
											if (_randomize) then {
												_t = [_t] call _fn_vRandom;
											};
											_spawnedType = QS_core_vehicles_map getOrDefault [toLowerANSI _t,_t];
											missionNamespace setVariable ['QS_vehicleRespawnCount',((missionNamespace getVariable 'QS_vehicleRespawnCount') + 1),_false];
											if (
												_isDynamicVehicle &&
												(_t isKindOf 'Helicopter')
											) then {
												_isDynamicVehicle = _false;
											};
											if (
												_isDynamicVehicle &&
												!_isActiveDLC &&
												!_isWreck
											) then {
												if (_isDeployed) then {
													_isDeployed = _false;
												};
												_v = createSimpleObject [_spawnedType,[(random -1000),(random -1000),(1000 + (random 2000))]];
												if (_dir isEqualType 0) then {
													_v setDir _dir;
												} else {
													if (_dir isEqualType []) then {
														_v setVectorDirAndUp _dir;
													};
												};
												if (surfaceIsWater _vpos) then {
													_v setPosASL _vpos;
												} else {
													if (_isCarrierVehicle isEqualTo 0) then {
														_v setVectorUp (surfaceNormal _vpos);
													};
													if (_v isKindOf 'truck_01_base_f') then {
														_v setPosASL (AGLToASL (_vpos vectorAdd [0,0,0.7]));
													} else {
														_v setPosASL (AGLToASL _vpos);
													};
												};
												[_v] call _fn_vSetup;
											} else {
												if (_isDeployed) then {
													_isDeployed = _false;
												};
												if (
													_isWreck && 
													{(_stateInfo isNotEqualTo [])} &&
													{(_wreckInfo # 0)}
												) then {
													if ((_wreckInfo # 1) isNotEqualTo _spawnedType) then {
														_wreckInfo set [1,_spawnedType];
													};
													if ((_wreckInfo # 2) isEqualTo '') then {
														_wreckType = [_v,_spawnedType] call _fn_getWreckType;
														_wreckInfo set [2,_wreckType];
													};
													_v = createVehicle [_wreckInfo # 2,[(random -1000),(random -1000),(1000 + (random 2000))]];
													_v setVariable ['QS_wreck_chance',(random 1) < _wreckChance,_true];
													_v = [_v,0,_true,_wreckInfo,_false] call _fn_setWrecked;
													_v setVehiclePosition [_stateInfo # 0,[],0,'NONE'];
												} else {
													_v = createVehicle [_spawnedType,[(random -1000),(random -1000),(1000 + (random 2000))]];
													if (_dir isEqualType 0) then {
														_v setDir _dir;
													} else {
														if (_dir isEqualType []) then {
															_v setVectorDirAndUp _dir;
														};
													};
													if (_isCarrierVehicle isEqualTo 0) then {
														_v setVectorUp (surfaceNormal _vpos);
														_v setPosASL (AGLToASL (_vPos vectorAdd [0,0,0.1]));
													} else {
														if (_isCarrierVehicle isEqualTo 1) then {
															_v setPosASL _vpos;		// setPosWorld
														};
													};
													if ((str _configCode) isNotEqualTo '{}') then {
														_v call _configCode;
													};
													_v setVariable ['QS_wreck_chance',(random 1) < _wreckChance,_true];
													[_v,_false,(_wreckInfo # 0)] call _fn_vSetup;
												};
											};
											(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,_false,0,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,_isWreck,_isDeployed,_stateInfo,_wreckInfo,_wreckChance,_wreckCond]];
										};
									};
								} else {
									if (
										_module_fob_isFobActive &&
										{_module_fob_logistics_vehicleRespawnEnabled} &&
										{(_module_fob_vData isNotEqualTo [])}
									) then {	
										// FOB vehicles
										_module_fob_vData_v = _module_fob_vData # _fobVehicleID;
										if (_vpos isNotEqualTo (_module_fob_vData_v # 1)) then {
											_module_fob_vData_v params ['_t','_vpos','_dir'];
										};
										if ((_nearEntitiesCheck isEqualTo -1) || {([_vpos,_nearEntitiesCheck] call _fn_isPosSafe)}) then {
											_spawnedType = QS_core_vehicles_map getOrDefault [toLowerANSI _t,_t];
											missionNamespace setVariable ['QS_vehicleRespawnCount',((missionNamespace getVariable 'QS_vehicleRespawnCount') + 1),_false];
											if (
												_isDynamicVehicle &&
												(_t isKindOf 'Helicopter')
											) then {
												_isDynamicVehicle = _false;
											};
											if (_isDynamicVehicle && (!_isActiveDLC)) then {
												_v = createSimpleObject [_spawnedType,[(random -1000),(random -1000),(1000 + (random 2000))]];
												if (_dir isEqualType 0) then {
													_v setDir _dir;
												} else {
													if (_dir isEqualType []) then {
														_v setVectorDirAndUp _dir;
													};
												};
												if (surfaceIsWater _vpos) then {
													_v setPosASL _vpos;
												} else {
													if (_isCarrierVehicle isEqualTo 0) then {
														_v setVectorUp (surfaceNormal _vpos);
													};
													if (_v isKindOf 'truck_01_base_f') then {
														_v setPosASL (AGLToASL (_vpos vectorAdd [0,0,0.7]));
													} else {
														_v setPosASL (AGLToASL _vpos);
													};
												};
												_v enableSimulationGlobal _true;
												_v spawn {
													sleep 1;
													_this enableSimulationGlobal FALSE;
												};
												[_v] call _fn_vSetup;
											} else {
												_v = createVehicle [_spawnedType,[(random -1000),(random -1000),(1000 + (random 2000))],[],0,'NONE'];
												if (_dir isEqualType 0) then {
													_v setDir _dir;
												} else {
													if (_dir isEqualType []) then {
														_v setVectorDirAndUp _dir;
													};
												};
												if (_isCarrierVehicle isEqualTo 0) then {
													_v setVectorUp (surfaceNormal _vpos);
													_v setPos (_vpos vectorAdd [0,0,0.1]);
												} else {
													if (_isCarrierVehicle isEqualTo 1) then {
														_v setPosWorld _vpos;
													};
												};
												if ((str _configCode) isNotEqualTo '{}') then {
													_v call _configCode;
												};
												[_v] call _fn_vSetup;
											};
											(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,_false,0,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,_isWreck,_isDeployed,_stateInfo,_wreckInfo,_wreckChance,_wreckCond]];
										};
									};
								};
							};
						};
					} else {
						// vehicle is alive
						if (
							(_module_fob_logistics_vehicleRespawnEnabled) &&
							{(!(_fobVehicleID in [-1,-2,9]))} &&
							{(_module_fob_isFobActive)} &&
							{(!(_module_fob_activeRegion in [-1,0]))} &&
							{(_module_fob_vData isNotEqualTo [])}
						) then {
							// Update FOB info for FOB-enabled vehicles so they evaluate correct respawn position
							_module_fob_vData_v = _module_fob_vData # _fobVehicleID;
							if (_vpos isNotEqualTo (_module_fob_vData_v # 1)) then {
								_t = _module_fob_vData_v # 0;
								_vpos = _module_fob_vData_v # 1;
								_dir = _module_fob_vData_v # 2;
								(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,_false,0,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,_isWreck,_isDeployed,_stateInfo,_wreckInfo,_wreckChance,_wreckCond]];
							};
						};
						if (
							(
								(!isSimpleObject _v) || 
								{(!(_fobVehicleID in [-1,-2,9]))}
							) &&
							{!_isWreck} &&
							{!_isDeployed} &&
							{!(_v getVariable ['QS_logistics_packed',_false])} &&
							{_vPos isNotEqualTo [0,0,0]}
						) then {
							if !(_v isNil 'QS_ClientVTexture_owner') then {
								_ownerInGame = _false;
								{
									if ((getPlayerUID _x) isEqualTo (_v getVariable 'QS_ClientVTexture_owner')) exitWith {
										_ownerInGame = _true;
									};
								} count _allPlayers;
								if (!(_ownerInGame)) then {
									if ((toLowerANSI _t) in ['i_mrap_03_f','i_mrap_03_hmg_f','i_mrap_03_gmg_f']) then {
										_v setObjectTextureGlobal [0,'\A3\soft_f_beta\mrap_03\data\mrap_03_ext_co.paa'];
										_v setObjectTextureGlobal [1,'\A3\data_f\vehicles\turret_co.paa'];
									} else {
										{
											_v setObjectTextureGlobal [_forEachIndex,_x];
										} forEach (getArray ((configOf _v) >> 'hiddenSelectionsTextures'));
									};
									_v setVariable ['QS_ClientVTexture_owner',nil,_true];
								};
							};
							if (
								(isNull (ropeAttachedTo _v)) &&
								{(isNull (isVehicleCargo _v))} && 
								{(isNull (attachedTo _v))} &&
								{((ropeAttachedObjects _v) isEqualTo [])}
							) then {
								if ((_v distance2D _vpos) > 10) then {
									_posCheck = getPosATL _v;
									if (surfaceIsWater _posCheck) then {
										_posCheck = getPosASL _v;
									};
									if (((crew _v) findIf {(alive _x)}) isEqualTo -1) then {
										if (
											(
												(
													[
														_posCheck,
														([_QS_vRespawnDist_base,_QS_vRespawnDist_field] select ((_v distance2D _vpos) >= 750)),
														[_west,_civilian],
														(if ((_v isKindOf 'Helicopter') && {(_allPlayersCount > 15)}) then [{(_allPlayers select {(_x getUnitTrait 'QS_trait_pilot')})},{_allPlayers}]),
														0
													] call _fn_serverDetector
												) isEqualTo []
											) &&
											(!([_v,100] call _fn_isNearVehicleRally))
										) then {
											if (
												//(_isDynamicVehicle && (!_isActiveDLC)) || 
												(_v isKindOf 'Air')
											) then {
												deleteVehicle _v;
											} else {
												if (
													(local _v) &&
													{(
														(_nearEntitiesCheck isEqualTo -1) || 
														{([_vpos,_nearEntitiesCheck] call _fn_isPosSafe)}
													)}
												) then {
													if (_isCarrierVehicle isEqualTo 0) then {
														_v setVectorUp (surfaceNormal _vpos);
													};
													if (_dir isEqualType 0) then {
														_v setDir _dir;
													} else {
														if (_dir isEqualType []) then {
															_v setVectorDirAndUp _dir;
														};
													};
													if ((damage _v) > 0.1) then {
														_v setDamage [0,_false];
													};
													if (_isCarrierVehicle isEqualTo 1) then {
														if ((str _configCode) isNotEqualTo '{}') then {
															_v call _configCode;
														};													
													};
													_v setPosASL (AGLToASL _vpos);
												} else {
													if (!local _v) then {
														_v setOwner 2;
													};
												};
											};
										} else {
											if (isEngineOn _v) then {
												if (local _v) then {
													_v engineOn _false;
												} else {
													[_v,_false] remoteExec ['engineOn',_v,_false];
												};
											};
										};
									};
									if (
										((_posCheck # 2) < -1.5) &&
										{(!(_v isKindOf 'Ship'))} &&
										{(((crew _v) findIf {(alive _x)}) isEqualTo -1)} &&
										{(([_posCheck,25,[_west,_civilian],_allPlayers,0] call _fn_serverDetector) isEqualTo [])}
									) then {
										if (
											(_isDynamicVehicle && (!_isActiveDLC)) || 
											{(_v isKindOf 'Air')}
										) then {
											deleteVehicle _v;
										} else {
											if (
												(local _v) &&
												{(
													(_nearEntitiesCheck isEqualTo -1) || 
													{([_vpos,_nearEntitiesCheck] call _fn_isPosSafe)}
												)}
											) then {
												if (_isCarrierVehicle isEqualTo 0) then {
													_v setVectorUp (surfaceNormal _vpos);
												};
												if (_dir isEqualType 0) then {
													_v setDir _dir;
												} else {
													if (_dir isEqualType []) then {
														_v setVectorDirAndUp _dir;
													};
												};
												if ((damage _v) > 0.1) then {
													_v setDamage [0,_false];
												};
												_v setPosASL (AGLToASL _vpos);
												if (_isCarrierVehicle isEqualTo 1) then {
													if ((str _configCode) isNotEqualTo '{}') then {
														_v call _configCode;
													};
												};
											} else {
												if (!local _v) then {
													_v setOwner 2;
												};
											};
										};
									};
								} else {
									if (((crew _v) findIf {(alive _x)}) isEqualTo -1) then {
										if (
											(_isDynamicVehicle && (!_isActiveDLC)) &&
											{((_v isKindOf 'LandVehicle') || {(_v isKindOf 'Ship')})} &&
											{((_v nearEntities ['CAManBase',_QS_vRespawnDist_base]) isEqualTo [])}
										) then {
											deleteVehicle _v;
										} else {
											if (local _v) then {
												_allHitPointsDamage = getAllHitPointsDamage _v;
												if (
													(_allHitPointsDamage isNotEqualTo []) &&
													{((count _allHitPointsDamage) > 2)}
												) then {
													{
														if (_x isNotEqualTo 0) then {
															_v setHitIndex [_forEachIndex,0];
														};
													} forEach (_allHitPointsDamage # 2);
												};
												if (isEngineOn _v) then {
													_v engineOn _false;
												};
												if ((damage _v) > 0.1) then {
													_v setDamage [0,_false];
												};
												if ((fuel _v) < 0.95) then {
													_v setFuel 1;
												};
											} else {
												_v setOwner 2;
											};
										};
									};
								};
							};
						} else {
							if (_isWreck) then {
								if (!(_v inArea _worldArea)) then {
									_v setVehiclePosition [_stateInfo # 0,[],0,'NONE'];
									_v awake _true;								
								};
								if (((getPosASL _v) # 2) < -0.5) then {
									_v setVehiclePosition [_stateInfo # 0,[],0,'NONE'];
									_v awake _true;
								};
								if (
									((_v getVariable ['QS_wreck_marker','']) isNotEqualTo '') &&
									{(((markerPos [(_v getVariable ['QS_wreck_marker','']),_true]) distance2D _v) > 10)}
								) then {
									(_v getVariable ['QS_wreck_marker','']) setMarkerPos _v;
								};
							};
							if (_isDeployed) then {
								if (!(_v inArea _worldArea)) then {
									_v setVehiclePosition [_stateInfo # 0,[],0,'NONE'];
									_v awake _true;
								};
								if (((getPosASL _v) # 2) < -0.5) then {
									_v setVectorDirAndUp (_stateInfo # 1);
									_v setPosASL (_stateInfo # 0);
									_v awake _true;
								};
								if (
									((_v getVariable ['QS_deploy_marker','']) isNotEqualTo '') &&
									{(((markerPos [(_v getVariable ['QS_deploy_marker','']),_true]) distance2D _v) > 10)}
								) then {
									(_v getVariable ['QS_deploy_marker','']) setMarkerPos _v;
								};
								if (
									((((units _east) + (units _resistance)) inAreaArray [_v,30,30]) isNotEqualTo []) && 					//(((flatten (_deploymentEnemySides apply {units _x})) inAreaArray [_v,30,30]) isNotEqualTo []) 		// Use this code if you do TvT stuff with OPFOR deployments. Its less efficient so we dont use it unless we need it. For now we just assume EAST/RESISTANCE are enemies
									{(((units (_v getVariable ['QS_deploy_side',sideUnknown])) inAreaArray [_v,100,100]) isEqualTo [])}
								) then {
									// Enemies in radius AND no friendlies in radius
									if ((_v getVariable ['QS_deploy_enemyState',0]) > 0) then {
										// Step down the points
										_v setVariable ['QS_deploy_enemyState',((_v getVariable ['QS_deploy_enemyState',0]) - 1),_false];
									} else {
										// Points at 0, kill
										(format ['%1',localize 'STR_QS_Text_434']) remoteExec ['systemChat',-2];
										_v setDamage [1,_true];
									};
								} else {
									// Friendlies in radius OR no enemies in radius
									if ((_v getVariable ['QS_deploy_enemyState',0]) < 10) then {
										// Recover the points
										_v setVariable ['QS_deploy_enemyState',((_v getVariable ['QS_deploy_enemyState',0]) + 1),_false];
									};
								};
							};
							if (_v getVariable ['QS_logistics_packed',_false]) then {
								_cargoParent = _v getVariable ['QS_logistics_cargoParent',_objNull];
								if (!isNull _cargoParent) then {
									if (
										((_cargoParent getVariable ['QS_logistics_cargoMarker','']) isNotEqualTo '') &&
										{(((markerPos [(_cargoParent getVariable ['QS_logistics_cargoMarker','']),_true]) distance2D _cargoParent) > 10)}
									) then {
										(_cargoParent getVariable ['QS_logistics_cargoMarker','']) setMarkerPos _cargoParent;
									};
									if (!(_cargoParent inArea _worldArea)) then {
										_cargoParent setVehiclePosition [_cargoParent getVariable ['QS_logistics_cargoPackPos',[0,0,0]],[],0,'NONE'];
										_cargoParent awake _true;								
									};
									if (((getPosASL _cargoParent) # 2) < -0.5) then {
										_cargoParent setVehiclePosition [_cargoParent getVariable ['QS_logistics_cargoPackPos',[0,0,0]],[],0,'NONE'];
										_cargoParent awake _true;
									};
								};
							};
						};
					};
					if (_childEntities isNotEqualTo []) then {
						_countChildEntities = count _childEntities;
						_childEntities = _childEntities select {alive _x};
						if ((count _childEntities) isNotEqualTo _c) then {
							(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,[_v,_vdelay,_randomize,_configCode,_t,_vpos,_dir,_false,0,_fobVehicleID,_QS_vRespawnDist_base,_QS_vRespawnDist_field,_vRespawnTickets,_nearEntitiesCheck,_isDynamicVehicle,_isCarrierVehicle,_vehicleSpawnCondition,_isWreck,_isDeployed,_stateInfo,_wreckInfo,_wreckChance,_wreckCond,_persistenceID,_childEntities]];
						};			
					};
				};
				sleep 0.01;
			} forEach (serverNamespace getVariable 'QS_v_Monitor');
			serverNamespace setVariable ['QS_v_Monitor',((serverNamespace getVariable 'QS_v_Monitor') select {(_x isEqualType [])})];
		};
		_vRespawn_checkDelay = time + _vRespawn_delay;
	};
	
	// Garbage Manager

	if (
		(_QS_diagTickTimeNow > _QS_cleanup_checkDelay) ||
		(localNamespace getVariable ['QS_GC_trigger',_false])
	) then {
		if ((missionNamespace getVariable ['QS_managed_hints',[]]) isNotEqualTo []) then {
			missionNamespace setVariable ['QS_managed_hints',[],_false];
		};
		missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') select {(!isNull _x)}),_false];
		missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') select {(!isNull _x)}),_false];
		if (QS_markers_fireSupport_queue isNotEqualTo []) then {
			{
				if (_x isEqualType []) then {
					QS_markers_fireSupport pushBack _x;
					QS_markers_fireSupport_queue set [_forEachIndex,FALSE];
				};
			} forEach QS_markers_fireSupport_queue;
		};
		if (QS_markers_fireSupport isNotEqualTo []) then {
			{
				if (
					(_x isEqualType []) &&
					{(_serverTime > ((_x # 1) + 300))}
				) then {
					if ((_x # 0) in allMapMarkers) then {
						deleteMarker (_x # 0);
					};
					QS_markers_fireSupport set [_forEachIndex,FALSE];
				};
			} forEach QS_markers_fireSupport;
			QS_markers_fireSupport = QS_markers_fireSupport select {_x isEqualType []};
			missionNamespace setVariable ['QS_markers_fireSupport',QS_markers_fireSupport,_true];
		};
		
		_allPlayers = units WEST;		// DEBUG
		
		// Handle dead bodies
		
		if (!_QS_corpseCollector) then {
			_allDeadMen = allDeadMen select {(!(_x getVariable ['QS_dead_prop',_false]))};
			if ((count _allDeadMen) > _thresholdLower) then {
				deleteVehicle (_allDeadMen select {
					(
						((_x getEntityInfo 3) > 10) &&
						((_allPlayers inAreaArray [_x,_distanceIrrelevant,_distanceIrrelevant]) isEqualTo [])
					)
				});
				uiSleep (diag_deltaTime * 3);
				_allDeadMen = _allDeadMen select {!isNull _x};
				_deadCount = count _allDeadMen;
				if ((_deadCount - _thresholdLower) > 0) then {
					_toDelete = [];
					_allDeadSorted = _allDeadMen apply {
						[
							_x getEntityInfo 3,		//Number: how long unit been dead for
							((_allPlayers inAreaArray [_x,_distanceRelevant,_distanceRelevant]) isNotEqualTo []),	//Bool: Is a player nearby
							_x
						]
					};
					_allDeadSorted sort FALSE;
					{
						_x params ['_deadFor','_deadNearPlayer','_deadUnit'];
						_deadForThreshold = linearConversion [
							_thresholdLower,		//25
							_thresholdUpper,		//75
							_deadCount,				//40
							_deadDurationLower,		//60 - stays not cleaned up longer, when there are fewer bodies
							_deadDurationUpper,		//30 - stays not cleaned up shorter, when there are more bodies
							_true					//clip
						];
						_deadFor = [_deadFor,_deadFor / _nearPlayerCoef] select _deadNearPlayer;
						if (
							(_deadFor > _deadForThreshold) ||
							{((_deadCount > _thresholdUpper) && (!(_deadNearPlayer)))}
						) then {
							_deadCount = _deadCount - 1;
							if (isNull (objectParent _deadUnit)) then {
								_toDelete pushBack _deadUnit;
							} else {
								(objectParent _deadUnit) deleteVehicleCrew _deadUnit;
							};
						};
						if ((_deadCount - _thresholdLower) <= 0) exitWith {};
					} forEach _allDeadSorted;
					if (_toDelete isNotEqualTo []) then {
						deleteVehicle _toDelete;	
					};
				};
			};
		};

		// Handle destroyed wrecks
		
		if (!_QS_wreckCollector) then {
			QS_vehicles_destroyed = QS_vehicles_destroyed select {
				!(isNull _x) &&
				{!(_x getVariable ['QS_dead_prop',_false])}
			};
			_allDeadVehicles = QS_vehicles_destroyed;
			if ((count _allDeadVehicles) > _thresholdLowerVehicle) then {
				deleteVehicle (_allDeadVehicles select {
					(
						(((vectorMagnitude (velocity _x)) * 3.6) < 1) &&
						((_allPlayers inAreaArray [_x,_distanceIrrelevantVehicle,_distanceIrrelevantVehicle]) isEqualTo [])
					)
				});
				uiSleep (diag_deltaTime * 3);
				_allDeadVehicles = _allDeadVehicles select {!isNull _x};
				_deadCount = count _allDeadVehicles;
				if ((_deadCount - _thresholdLowerVehicle) > 0) then {
					_toDelete = [];
					_allDeadVehiclesSorted = _allDeadVehicles apply {
						[
							_x getEntityInfo 3,		//Number: how long vehicle been dead for
							((_allPlayers inAreaArray [_x,_distanceRelevantVehicle,_distanceRelevantVehicle]) isNotEqualTo []),	//Bool: Is a player nearby
							_x
						]
					};
					_allDeadVehiclesSorted sort FALSE;
					{
						_x params ['_deadFor','_deadNearPlayer','_deadUnit'];
						_deadForThreshold = linearConversion [
							_thresholdLowerVehicle,			//5
							_thresholdUpperVehicle,			//15
							_deadCount,						// ?
							_deadDurationLowerVehicle,		//60 - stays not cleaned up longer, when there are fewer bodies
							_deadDurationUpperVehicle,		//30 - stays not cleaned up shorter, when there are more bodies
							_true							//clip
						];
						_deadFor = [_deadFor,_deadFor / _nearPlayerCoefVehicle] select _deadNearPlayer;
						if (
							(
								(_deadFor > _deadForThreshold) ||
								((_deadCount > _thresholdUpperVehicle) && (!(_deadNearPlayer)))
							) &&
							{((_allPlayers inAreaArray [_deadUnit,15,15]) isEqualTo [])}		// hardcode dont delete when players using it as cover
						) then {
							_deadCount = _deadCount - 1;
							_toDelete pushBack _deadUnit;
							if ((attachedObjects _deadUnit) isNotEqualTo []) then {
								_toDelete = _toDelete + (attachedObjects _deadUnit);
							};
						};
						if ((_deadCount - _thresholdLowerVehicle) <= 0) exitWith {};
					} forEach _allDeadVehiclesSorted;				
					if (_toDelete isNotEqualTo []) then {
						deleteVehicle _toDelete;
					};
				};
			};
		};

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
		
		// Handle mines
		
		_allMines = allMines select {(!(_x getVariable ['QS_cleanup_protected',_false]))};	// managed mines array?
		if (_allMines isNotEqualTo []) then {
			deleteVehicle (_allMines select {
				((_allUnits inAreaArray [_x,500,500]) isEqualTo [])
			});
		};		

		// Handle flares
		
		_managed_flares = (missionNamespace getVariable ['QS_managed_flares',[]]) select {!isNull (_x # 0)};
		if (_managed_flares isNotEqualTo []) then {
			{
				if (diag_tickTime > (_x # 1)) then { 
					deleteVehicle (_x # 0);
				};
			} forEach _managed_flares;
		};

		// Handle Gitmo prisoners
		
		if ((count (missionNamespace getVariable ['QS_prisoners',[]])) > _maxPrisoners) then {
			deleteVehicle ((missionNamespace getVariable 'QS_prisoners') # 0);
			missionNamespace setVariable ['QS_prisoners',((missionNamespace getVariable 'QS_prisoners') select {(alive _x)}),_true];
		};
		
		// Handle active crater effects
		
		if (QS_entities_craterEffects isNotEqualTo []) then {
			QS_entities_craterEffects = QS_entities_craterEffects select {_x isEqualType []};
			{
				if (_x isEqualType []) then {
					_x params [
						'_state',
						'_list'
					];
					if (_state isEqualTo 1) then {
						QS_entities_craterEffects set [_forEachIndex,_false];
					} else {
						if (_state isEqualTo 0) then {
							QS_entities_craterEffects set [_forEachIndex,[1,_list]];
							{
								QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
							} forEach _list;
						};
					};
				};
			} forEach (missionNamespace getVariable ['QS_entities_craterEffects',[]]);
		};
		
		// Main garbage/overflow handler
		
		if ((missionNamespace getVariable 'QS_garbageCollector') isNotEqualTo []) then {
			missionNamespace setVariable ['QS_collectingGarbage',_true,_false];
			_QS_garbageCollector = [];
			{
				if (_x isEqualType []) then {
					_x params [
						'_QS_obj',
						'_QS_instructions',
						'_QS_timeDelete'
					];
					if (_QS_obj isEqualType {}) then {
						(missionNamespace getVariable 'QS_garbageCollector') set [_forEachIndex,_false];
					} else {
						if (_QS_obj isEqualType _objNull) then {
							_QS_attemptRecycle = _false;
							if (isNull _QS_obj) then {
								(missionNamespace getVariable 'QS_garbageCollector') set [_forEachIndex,_false];
							} else {
								_QS_objWorldPos = getPosWorld _QS_obj;
								if (_QS_instructions isEqualTo 'NOW_FORCED') then {
									_QS_attemptRecycle = _true;
									_QS_deleteThis = _true;
								};
								if (_QS_instructions isEqualTo 'NOW_DISCREET') then {
									if ((_allPlayers inAreaArray [_QS_objWorldPos,150,150,0,_false]) isEqualTo []) then {
										_QS_attemptRecycle = _true;
										_QS_deleteThis = _true;
									};
								};
								if (_QS_instructions isEqualTo 'DELAYED_FORCED') then {
									if (_timeNow > _QS_timeDelete) then {
										_QS_attemptRecycle = _true;
										_QS_deleteThis = _true;
									};
								};
								if (_QS_instructions isEqualTo 'DELAYED_DISCREET') then {
									if (_timeNow > _QS_timeDelete) then {
										if ((_allPlayers inAreaArray [_QS_objWorldPos,150,150,0,_false]) isEqualTo []) then {
											_QS_attemptRecycle = _true;
											_QS_deleteThis = _true;
										};
									};
								};	
								if (_QS_instructions isEqualTo 'CUSTOM') then {

								};
								if (_QS_instructions isEqualTo 'UNHIDE_DISCREET') then {
									if ((_allPlayers inAreaArray [_QS_objWorldPos,100,100,0,_false]) isEqualTo []) then {
										_QS_obj hideObjectGlobal _false;
										(missionNamespace getVariable 'QS_garbageCollector') set [_forEachIndex,_false];
									};
								};
								if (_QS_deleteThis) then {
									if (_QS_attemptRecycle) then {
										if ([1,0,_QS_obj] call _fn_serverObjectsRecycler) then {
											(missionNamespace getVariable 'QS_garbageCollector') set [_forEachIndex,_false];
										} else {
											_QS_garbageCollector pushBack _QS_obj;
										};
									} else {
										_QS_garbageCollector pushBack _QS_obj;
									};
									_QS_deleteThis = _false;
								};
							};
						};
					};
				} else {
					(missionNamespace getVariable 'QS_garbageCollector') set [_forEachIndex,_false];
				};
				uiSleep 0.01;
			} forEach (missionNamespace getVariable 'QS_garbageCollector');
			if (_QS_garbageCollector isNotEqualTo []) then {
				{
					if (_x isEqualType []) then {
						_element = _x;
						_QS_i = (missionNamespace getVariable 'QS_garbageCollector') findIf {((_x # 0) isEqualTo _element)};
						if (_QS_i isNotEqualTo -1) then {
							(missionNamespace getVariable 'QS_garbageCollector') set [_QS_i,_false];
						};
					} else {
						if (!isNull _x) then {
							if (_x isKindOf 'CAManBase') then {
								if (!isNull (objectParent _x)) then {
									if ((objectParent _x) isKindOf 'AllVehicles') then {
										(objectParent _x) deleteVehicleCrew _x;
									} else {
										deleteVehicle _x;
									};
								} else {
									deleteVehicle _x;
								};
							} else {
								deleteVehicle _x;
							};
							uiSleep 0.007;
						};
					};
				} count _QS_garbageCollector;
			};
			missionNamespace setVariable ['QS_collectingGarbage',_false,_false];
		};
		QS_garbageCollector = QS_garbageCollector select {!(_x isEqualType _true)};
		if (_missionObjectsTicker >= 5) then {
			_missionObjectsTicker = 0;
			_allMissionObjectsAll = allMissionObjects '';
		} else {
			_missionObjectsTicker = _missionObjectsTicker + 1;
			_allMissionObjectsAll = entities [[],[],_true,_false];
		};
		//_allSimpleObjects = allSimpleObjects [];
		_missionCraters = [];
		_missionWeaponHolders = [];
		_missionWeaponHolderSimulated = [];
		_missionStaticWeapons = [];
		_missionRuins = [];
		_missionBackpackUAVs = [];
		_missionSmokeShells = [];
		_missionObject = _objNull;
		_missionObjectType = '';
		_deleteNow = [];
		{
			_missionObject = _x;
			_missionObjectType = toLowerANSI (typeOf _x);
			if (_missionObject isKindOf 'CraterLong') then {
				if (!(_missionObject getVariable ['QS_cleanup_protected',_false])) then {
					if ((_allPlayers inAreaArray [_missionObject,500,500,0,_false]) isEqualTo []) then {
						_deleteNow pushBack _missionObject;
					} else {
						_missionCraters pushBack _missionObject;
					};
				};
				uiSleep 0.005;
				continue;
			};
			if (_missionObject isKindOf 'WeaponHolder') then {
				if (_missionObject isKindOf 'GroundWeaponHolder') then {
					if ((_allPlayers inAreaArray [_missionObject,100,100,0,_false]) isNotEqualTo []) then {
						_missionGroundWeaponHolders pushBack _missionObject;
					} else {
						_deleteNow pushBack _missionObject;
					};
				} else {
					if ((_missionObject distance2D _baseMarker) < 300) then {		// to do: change to "in safezone"
						_deleteNow pushBack _missionObject;
					} else {
						_missionWeaponHolders pushBack _missionObject;
					};
				};
				uiSleep 0.005;
				continue;
			};
			if (_missionObjectType isEqualTo 'weaponholdersimulated') then {
				if ((_allPlayers inAreaArray [_missionObject,100,100,0,_false]) isNotEqualTo []) then {
					_missionWeaponHolderSimulated pushBack _missionObject;
				} else {
					_deleteNow pushBack _missionObject;
				};
				uiSleep 0.005;
				continue;
			};
			if (
				(_missionObjectType in _jetJunk) &&
				{(((vectorMagnitude (velocity _missionObject)) * 3.6) < 1)} &&
				{(((crew _missionObject) isEqualTo []) || {(((crew _missionObject) findIf {((alive _x) && (isPlayer _x))}) isEqualTo -1)})} &&
				{(((_missionObject nearEntities ['CAManBase',25]) select {((alive _x) && (isPlayer _x))}) isEqualTo [])}
			) then {
				_deleteNow pushBack _missionObject;
				continue;
			};
			if (
				(_missionObject isKindOf 'StaticWeapon') &&
				{(!(_missionObject getVariable ['QS_cleanup_protected',_false]))} &&
				{(isNull (attachedTo _missionObject))}
			) then {
				if ((_allUnits inAreaArray [_missionObject,250,250,0,_false]) isEqualTo []) then {
					_deleteNow pushBack _missionObject;
				} else {
					_missionStaticWeapons pushBack _missionObject;
				};
				uiSleep 0.005;
				continue;
			};
			if (_missionObject isKindOf 'Ruins') then {
				if (_missionObject isKindOf 'Land_TTowerBig_2_ruins_F') then {
					// radio tower ruins
					if ((_allPlayers inAreaArray [_missionObject,1000,1000,0,_false]) isEqualTo []) then {
						_deleteNow pushBack _missionObject;
					};
				} else {
					if (!(_missionObject getVariable ['QS_cleanup_protected',_false])) then {
						if (!(_missionObjectType in _protectedRuinTypes)) then {
							if (
								((_missionObject distance2D [-1000,-1000,0]) > 10) &&
								{((_allPlayers inAreaArray [_missionObject,500,500]) isEqualTo [])}
							) then {
								_missionObject setPosWorld [-1000,-1000,0];
								_missionObject hideObjectGlobal _true;
								_missionObject enableSimulationGlobal _false;
								_missionObject setVariable ['QS_cleanup_protected',_true,_false];
							};
						} else {
							_missionObject setVariable ['QS_cleanup_protected',_true,_false];
							_missionObject enableSimulationGlobal _false;
						};
					};
				};
				uiSleep 0.005;
				continue;
			};
			if (_missionObject isKindOf 'Smokeshell') then {
				_missionSmokeShells pushBack _missionObject;
				continue;
			};
			if (
				(unitIsUAV _missionObject) &&
				{(_missionObjectType in _backpackDroneTypes)} &&
				{(isNull (attachedTo _missionObject))} &&
				{(isNull (isVehicleCargo _missionObject))}
			) then {
				_missionBackpackUAVs pushBack _missionObject;
			};
		} forEach _allMissionObjectsAll;
		if (_deleteNow isNotEqualTo []) then {
			deleteVehicle _deleteNow;
			_deleteNow = [];
		};
		{
			_array = _x # 0;
			if (_array isNotEqualTo []) then {
				_limit = _x # 1;
				_count = count _array;
				if (_count > _limit) then {
					deleteVehicle (_array select [0,_limit - 1]);
				};
			};
		} count [
			[_missionCraters,_missionCratersLimit],
			[_missionWeaponHolders,_weaponHoldersLimit],
			[_missionGroundWeaponHolders,_groundWeaponHoldersLimit],
			[_missionWeaponHolderSimulated,_missionWeaponHolderSimulatedLimit],
			[_missionStaticWeapons,_missionStaticWeaponsLimit],
			[_missionBackpackUAVs,_missionBackpackUAVsLimit],
			[_missionSmokeShells,_smokeShellLimit]
		];
		
		// Handle backpack UAVs
		if (_QS_diagTickTimeNow > _QS_checkUAVsTime) then {
			if (_allUnitsUav isNotEqualTo []) then {
				{
					_uav = _x;
					if (
						(local _uav) &&
						{((['Air','LandVehicle'] findIf {_uav isKindOf _x}) isNotEqualTo -1)} &&
						{(!(_uav getVariable ['QS_uav_protected',_false]))} &&
						{(isNull (isVehicleCargo _uav))} && 
						{(isNull (ropeAttachedTo _uav))} && 
						{(isNull (attachedTo _uav))}
					) then {
						if ((attachedObjects _uav) isNotEqualTo []) then {
							{
								[0,_x] call _fn_eventAttach;
								deleteVehicle _x
							} forEach (attachedObjects _uav);
						};
						deleteVehicle _uav;
					};
				} count _allUnitsUav;
			};
			if (!(missionNamespace getVariable 'QS_uavCanSpawn')) then {
				if (_QS_diagTickTimeNow > (missionNamespace getVariable 'QS_uavRespawnTimeout')) then {
					missionNamespace setVariable ['QS_uavCanSpawn',_true,_true];
				};
			};
			if (missionNamespace getVariable 'QS_drone_heli_enabled') then {
				if (missionNamespace getVariable 'QS_drone_heli_spawned') then {
					_QS_heliDroneRespawnCheckDelay = _QS_diagTickTimeNow + _QS_heliDroneRespawnDelay;
					missionNamespace setVariable ['QS_drone_heli_enabled',_false,_true];
					missionNamespace setVariable ['QS_drone_heli_spawned',_false,_true];
				};
			} else {
				if (_QS_diagTickTimeNow > _QS_heliDroneRespawnCheckDelay) then {
					missionNamespace setVariable ['QS_drone_heli_enabled',_true,_true];
				};
			};
			_QS_checkUAVsTime = _QS_diagTickTimeNow + _QS_checkUAVsTime_delay;
		};
		_QS_cleanup_checkDelay = _QS_diagTickTimeNow + _QS_cleanup_delay;
	};

	if (_QS_weatherManager) then {
		if (_timeNow > _QS_weatherManager_checkDelay) then {
			_QS_date = date;
			_QS_dayTime = dayTime;
			_QS_currentWind = wind;
			_QS_currentWindDir = windDir;
			_QS_currentWindStr = windStr;
			_QS_currentOvercast = overcast;
			_QS_currentRain = rain;
			_QS_currentFog = fogParams;
			_QS_currentGusts = gusts;
			_QS_currentLightnings = lightnings;
			_QS_currentWaves = waves;
			_QS_currentRainbow = rainbow;
			if (_QS_weatherDynamic) then {
				if (!(_QS_simulateEvent_override)) then {
					if (_QS_weatherEventsEnabled) then {
						if ((_timeNow > _QS_simulateEvent_overrideDelay) && (_QS_currentOvercast > 0.666)) then {
							missionNamespace setVariable ['QS_weather_simulateStorm',_true,_false];
							_QS_simulateEvent_overrideDelay = 9999999;
						};
						if !(missionNamespace isNil 'QS_weather_simulateStorm') then {
							_QS_simulateEvent_storm = _true;
							missionNamespace setVariable ['QS_weather_simulateStorm',nil,_false];
							(format ['"%2" - %1 %3',_QS_worldName,localize 'STR_QS_Chat_104',localize 'STR_QS_Chat_105']) remoteExec ['systemChat',-2,_false];
						};
					};
					if (_QS_simulateWind) then {
						if (_timeNow > _QS_windUpdate_checkDelay) then {
							if (((_QS_date # 2) isNotEqualTo _QS_day_wind) || {(_QS_refreshWind)}) then {
								if (_QS_refreshWind) then {
									_QS_refreshWind = _false;
								};
								_QS_windArray = [_QS_date,_QS_worldName,'REALISM','WIND'] call _fn_weatherConfig;
								_QS_windWorkingArray = _QS_windArray;
								_QS_day_wind = _QS_date # 2;
								_QS_dayTime_wind = round (_QS_dayTime - 1.01);
							};
							if (_QS_dayTime > (_QS_dayTime_wind + 1)) then {
								if (_QS_windWorkingArray isEqualTo []) then {
									_QS_refreshWind = _true;
								} else {
									_QS_windNextValue = _QS_windWorkingArray # 0;
									setWind _QS_windNextValue;
									_QS_windWorkingArray deleteAt 0;
									diag_log format ['***** WEATHER Setting next wind ***** %1 *****',_QS_windNextValue];
									_QS_dayTime_wind = round _QS_dayTime;
								};
							};
							_QS_windUpdate_checkDelay = _timeNow + _QS_windUpdate_checkDelay_timer;
						};
					} else {
						if (_QS_currentWind isNotEqualTo [0,0,0]) then {
							setWind [0,0,_true];
						};
					};
					if (_QS_simulateSnow) then {
						// Overcast when snowing
						if (_timeNow > _QS_overcastUpdate_checkDelay) then {
							0 setOvercast 1;
							_QS_overcastUpdate_checkDelay = _timeNow + _QS_overcastUpdate_checkDelay_timer;
						};
					} else {
						if (_QS_simulateOvercast) then {
							if (_timeNow > _QS_overcastUpdate_checkDelay) then {
								if (((_QS_date # 2) isNotEqualTo _QS_day_overcast) || {(_QS_refreshOvercast)}) then {
									if (_QS_refreshOvercast) then {
										_QS_refreshOvercast = _false;
									};
									_QS_overcastArray = [_QS_date,_QS_worldName,'REALISM','OVERCAST'] call _fn_weatherConfig;
									_QS_overcastWorkingArray = _QS_overcastArray # 0;
									_QS_simulateRain = _QS_overcastArray # 1;
									_QS_day_overcast = _QS_date # 2;
									_QS_dayTime_overcast = round (_QS_dayTime - 1);
								};
								if (_QS_dayTime > (_QS_dayTime_overcast + 1)) then {
									if (_QS_overcastWorkingArray isEqualTo []) then {
										_QS_refreshOvercast = _true;
									} else {
										_QS_overcastNextValue = _QS_overcastWorkingArray # 0;
										1800 setOvercast _QS_overcastNextValue;
										_QS_overcastWorkingArray deleteAt 0;
										diag_log format ['***** WEATHER setting next overcast ***** %1 *****',_QS_overcastNextValue];
										_QS_dayTime_overcast = round _QS_dayTime;
									};
								};
								_QS_overcastUpdate_checkDelay = _timeNow + _QS_overcastUpdate_checkDelay_timer;
							};
						} else {
							if (_QS_currentOvercast isNotEqualTo 0) then {
								10 setOvercast 0;
							};
						};
					};
					if (_QS_simulateSnow) then {
						// Rain when snowing
						if (_timeNow > _QS_rainUpdate_checkDelay) then {
							0 setRain 1;
							setHumidity 0.95;
							_QS_rainUpdate_checkDelay = _timeNow + _QS_rainUpdate_checkDelay_timer;
						};
					} else {
						if (_QS_simulateRain) then {
							if (!(_QS_rainSimulated)) then {
								_QS_rainSimulated = _true;
							};
							if (_allPlayersCount < 50) then {
								if (_timeNow > _QS_rainUpdate_checkDelay) then {
									if (_QS_dayTime > (_QS_dayTime_rain + _QS_rainCheckInterval)) then {
										_QS_rainChangeTime = 300 + (round (random 900));
										if (_QS_worldName isEqualTo 'Tanoa') then {
											_QS_rainChangeTime = 150 + (round (random 450));
										};
										if ((random 1) > 0.666) then {
											_QS_nextRainArray = [_QS_date,_QS_worldName,'REALISM','RAIN',_QS_rainChangeTime,_QS_currentOvercast,_QS_currentRain,_QS_currentFog] call _fn_weatherConfig;
										} else {
											_QS_nextRainArray = [60,0];
										};
										_QS_rainChangeTime = _QS_nextRainArray # 0;
										_QS_nextRainValue = _QS_nextRainArray # 1;
										_QS_rainChangeTime setRain _QS_nextRainValue;
										_QS_dayTime_rain = round (_QS_dayTime - 1);
									};
									_QS_rainUpdate_checkDelay = _timeNow + _QS_rainUpdate_checkDelay_timer;
								};
							} else {
								if (_QS_currentRain isNotEqualTo 0) then {
									30 setRain 0;
								};					
							};
						} else {
							if (_QS_rainSimulated) then {
								_QS_rainSimulated = _false;
								if (_QS_currentRain isNotEqualTo 0) then {
									30 setRain 0;
								};
							} else {
								if (_QS_currentRain isNotEqualTo 0) then {
									30 setRain 0;
								};				
							};
						};
					};
					
					if (_QS_simulateSnow) then {
						// Fog when snowing
						if (_timeNow > _QS_fogUpdate_checkDelay) then {
							0 setFog 0.1;
							_QS_fogUpdate_checkDelay = _timeNow + _QS_fogUpdate_checkDelay_timer;
						};
					} else {
						if (_QS_simulateFog) then {
							if (_timeNow > _QS_fogUpdate_checkDelay) then {
								if (((_QS_date # 2) isNotEqualTo _QS_day_fog) || {(_QS_refreshFog)}) then {
									if (_QS_refreshFog) then {
										_QS_refreshFog = _false;
									};
									_QS_canEnableFog = ((random 1) >= 0.85);
									if (_QS_canEnableFog) then {
										_QS_fogEnabled = _true;
										_QS_fogArray = [_QS_date,_QS_worldName,'REALISM','FOG',(_QS_overcastArray # 0)] call _fn_weatherConfig;
										_QS_fogWorkingArray = _QS_fogArray;
									} else {
										_QS_fogEnabled = _false;
									};
									_QS_day_fog = _QS_date # 2;
									_QS_dayTime_fog = round (_QS_dayTime - 1);
								};
								if (_QS_fogEnabled) then {
									if (_QS_dayTime > (_QS_dayTime_fog + 1)) then {
										if ((count _QS_fogWorkingArray) > 0) then {
											_QS_fogChangeTime = (_QS_fogWorkingArray # 0) # 0;
											_QS_fogValue = (_QS_fogWorkingArray # 0) # 1;
											_QS_fogDecay = (_QS_fogWorkingArray # 0) # 2;
											_QS_fogBase = (_QS_fogWorkingArray # 0) # 3;
											_QS_fogChangeTime setFog [_QS_fogValue,_QS_fogDecay,_QS_fogBase];
											_QS_fogWorkingArray deleteAt 0;
										} else {
											if (_QS_currentFog isNotEqualTo [0,0,0]) then {
												30 setFog [0,0,0];
											};
											_QS_fogEnabled = _false;
										};
										_QS_dayTime_fog = round _QS_dayTime;
									};
								} else {
									if (_QS_currentFog isNotEqualTo [0,0,0]) then {
										30 setFog [0,0,0];
									};
								};
								_QS_fogUpdate_checkDelay = _timeNow + _QS_fogUpdate_checkDelay_timer;
							};
						};
					};
					if (_QS_simulateWaves) then {
						if (_timeNow > _QS_wavesUpdate_checkDelay) then {
							_QS_nextWavesArray = [_QS_date,_QS_worldName,'REALISM','WAVES',_QS_currentWind] call _fn_weatherConfig;
							_QS_wavesChangeTime = _QS_nextWavesArray # 0;
							_QS_nextWavesValue = _QS_nextWavesArray # 1;
							_QS_wavesChangeTime setWaves _QS_nextWavesValue;
							_QS_wavesUpdate_checkDelay = _timeNow + _QS_wavesUpdate_checkDelay_timer;
						};
					} else {
						if (_QS_currentWaves isNotEqualTo 0) then {
							10 setWaves 0;
						};
					};
					if (_QS_simulateLightning) then {
						if (_timeNow > _QS_lightningsUpdate_checkDelay) then {
							if ((_QS_date # 2) isNotEqualTo _QS_day_lightnings) then {
								if ((random 1) >= 0.75) then {
									_QS_canEnableLightnings = _true;
								} else {
									_QS_canEnableLightnings = _false;
								};
								_QS_day_lightnings = _QS_date # 2;
							};
							if (_QS_lightningsEnabled) then {
								_QS_nextLightningsArray = [_QS_date,_QS_worldName,'REALISM','LIGHTNINGS',_QS_currentOvercast] call _fn_weatherConfig;
								_QS_lightningsChangeTime = _QS_nextLightningsArray # 0;
								_QS_lightningsNextValue = _QS_nextLightningsArray # 1;
								if (_QS_currentOvercast > 0.65) then {
									_QS_lightningsChangeTime setLightnings _QS_lightningsNextValue;
								} else {
									_QS_lightningsEnabled = _false;
									if (_QS_currentLightnings isNotEqualTo 0) then {
										30 setLightnings 0;
									};
								};
							} else {
								if (_QS_currentOvercast > 0.65) then {
									if (_QS_canEnableLightnings) then {
										_QS_lightningsEnabled = _true;
									};
								};
							};
							_QS_lightningsUpdate_checkDelay = _timeNow + _QS_lightningsUpdate_checkDelay_timer;
						};
					};
					if (_QS_simulateRainbow) then {
						if (_timeNow > _QS_rainbowUpdate_checkDelay) then {
							if (_QS_currentRain > 0) then {
								_QS_nextRainbowArray = [_QS_date,_QS_worldName,'REALISM','RAINBOW',_QS_currentRain] call _fn_weatherConfig;
								_QS_rainbowChangeTime = _QS_nextRainbowArray # 0;
								_QS_rainbowNextValue = _QS_nextRainbowArray # 1;
								_QS_rainbowChangeTime setRainbow _QS_rainbowNextValue;
							} else {
								if (_QS_currentRainbow isNotEqualTo 0) then {
									60 setRainbow 0;
								};
							};
							_QS_rainbowUpdate_checkDelay = _timeNow + _QS_rainbowUpdate_checkDelay_timer;
						};
					};
					if (_QS_simulateGusts) then {
						if (_timeNow > _QS_gustsUpdate_checkDelay) then {
							_QS_nextGustsArray = [_QS_date,_QS_worldName,'REALISM','GUSTS',_QS_currentWind] call _fn_weatherConfig;
							_QS_gustsChangeTime = _QS_nextGustsArray # 0;
							_QS_gustsNextValue = _QS_nextGustsArray # 1;
							_QS_gustsChangeTime setGusts _QS_gustsNextValue;
							_QS_gustsUpdate_checkDelay = _timeNow + _QS_gustsUpdate_checkDelay_timer;
						};
					};
					if (_QS_weatherEventsEnabled) then {
						if (_QS_simulateEvent_storm) then {
							_QS_simulateEvent_storm = _false;
							_QS_simulateEvent_override = _true;
							_QS_simulateEvent_data = [
								'STORM',							/*/TYPE/*/
								(time + 1200),					/*/DURATION/*/
								[0,1],							/*/OVERCAST/*/
								[0,(random [0,0.05,0.15])],		/*/RAIN/*/
								[0,1],							/*/WAVES/*/
								[0,(random [0.75,0.875,1])],			/*/LIGHTNINGS/*/
								[0,1],							/*/RAINBOW/*/
								[0,[0,0,0]]						/*/FOG/*/
							];
							((_QS_simulateEvent_data # 2) # 0) setOvercast ((_QS_simulateEvent_data # 2) # 1);
							((_QS_simulateEvent_data # 3) # 0) setRain ((_QS_simulateEvent_data # 3) # 1);
							((_QS_simulateEvent_data # 4) # 0) setWaves ((_QS_simulateEvent_data # 4) # 1);
							((_QS_simulateEvent_data # 5) # 0) setLightnings ((_QS_simulateEvent_data # 5) # 1);
							((_QS_simulateEvent_data # 6) # 0) setRainbow ((_QS_simulateEvent_data # 6) # 1);
							((_QS_simulateEvent_data # 7) # 0) setFog ((_QS_simulateEvent_data # 7) # 1);
							forceWeatherChange;
							/*/ WIP /*/
						};
						if (_QS_simulateEvent_fog) then {
							_QS_simulateEvent_override = _true;
							/*/ WIP /*/
						};
						if (_QS_simulateEvent_wind) then {
							_QS_simulateEvent_override = _true;
							/*/ WIP /*/
						};
					};
					if (_QS_weatherSave) then {
						if (_timeNow > _QS_weatherSave_checkDelay) then {
							_QS_currentWeatherData = [wind,windDir,windStr,overcast,rain,fogParams,gusts,lightnings,waves,rainbow];
							if (!(_QS_module_restart_isRestarting)) then {
								missionProfileNamespace setVariable [(format ['QS_QRF_weatherCurrent_%1',worldName]),_QS_currentWeatherData];
							};
							_QS_weatherSave_checkDelay = _timeNow + _QS_weatherSave_delay;
						};
					};	
				} else {
					//comment 'Override is TRUE';
					if (_timeNow > (_QS_simulateEvent_data # 1)) then {
						//comment 'Terminate override';
						_QS_simulateEvent_override = _false;
					} else {
						if ((_QS_simulateEvent_data # 0) isEqualTo 'STORM') then {
							//comment 'Storm event in progress';
							if (!(_QS_currentOvercast > 0.95)) then {
								((_QS_simulateEvent_data # 2) # 0) setOvercast ((_QS_simulateEvent_data # 2) # 1);
							};
							if (_QS_currentRain isNotEqualTo ((_QS_simulateEvent_data # 3) # 1)) then {
								((_QS_simulateEvent_data # 3) # 0) setRain ((_QS_simulateEvent_data # 3) # 1);
							};
							if (_QS_currentWaves isNotEqualTo ((_QS_simulateEvent_data # 4) # 1)) then {
								((_QS_simulateEvent_data # 4) # 0) setWaves ((_QS_simulateEvent_data # 4) # 1);
							};
							if (_QS_currentLightnings isNotEqualTo ((_QS_simulateEvent_data # 5) # 1)) then {
								((_QS_simulateEvent_data # 5) # 0) setLightnings ((_QS_simulateEvent_data # 5) # 1);
							};
							if (_QS_currentRainbow isNotEqualTo ((_QS_simulateEvent_data # 6) # 1)) then {
								((_QS_simulateEvent_data # 6) # 0) setRainbow ((_QS_simulateEvent_data # 6) # 1);
							};
							if (_QS_currentFog isNotEqualTo ((_QS_simulateEvent_data # 7) # 1)) then {
								((_QS_simulateEvent_data # 7) # 0) setFog ((_QS_simulateEvent_data # 7) # 1);
							};	
						};
					};
				};
			} else {
				// Weather is forced and has a valid preset
				if (_QS_weatherForced > -1) then {
					if (_timeNow > _forcedWeatherUpdateCheckDelay) then {
						[_QS_weatherForced] call _fn_weatherPreset;
						_forcedWeatherUpdateCheckDelay = _timeNow + _forcedWeatherUpdateDelay;
					};
				};
			};
			// Synchronize Weather
			// Synchronize immediately with stutter
			if (_QS_forceWeatherChange) then {
				if (missionNamespace getVariable ['QS_forceWeatherChange',_false]) then {
					if (_timeNow > _QS_forceWeatherChange_delay) then {
						forceWeatherChange;
						_QS_forceWeatherChange_delay = _timeNow + _QS_forceWeatherChange_delayTimer;
					};
				};
			};
			// Synchronize over time with no stutter
			if (_QS_weatherSyncMP) then {
				if (missionNamespace getVariable ['QS_weatherSync',_true]) then {
					if (_timeNow > _QS_weatherSyncMP_delay) then {
						[
							38,
							[
								[_false,wind],
								[_true,30,gusts],
								[_false,30,windDir],
								[_false,30,windStr],
								[_false,30,windStr],
								[_true,30,overcast],
								[_false,30,rain],
								[_true,30,fogParams],
								[_true,30,waves],
								[_true,30,lightnings],
								[_true,30,rainbow],
								[_true,humidity]
							],
							_QS_weatherDynamic,
							_QS_weatherForced
						] remoteExec ['QS_fnc_remoteExec',-2,_false];
						_QS_weatherSyncMP_delay = _timeNow + _QS_weatherSyncMP_interval;
					};
				};
			};
			_QS_weatherManager_checkDelay = _timeNow + 30;
		};
	};

	if (_QS_timeManager) then {
		if (_QS_saveDate) then {
			if (_timeNow > _QS_saveDate_delay) then {
				if (!(_QS_module_restart_isRestarting)) then {
					missionProfileNamespace setVariable [(format ['QS_QRF_date_%1',_QS_worldName]),date]; 
				};
				_QS_saveDate_delay = _timeNow + 600;
			};
		};
		if (_timeNow > _QS_date_checkDelay) then {
			if ((date # 2) isNotEqualTo (_QS_date # 2)) then {
				_QS_date = date;
				_QS_solarHorizons = _QS_date call _fn_sunriseSunsetTime;
				_QS_sunrise = _QS_solarHorizons # 0;
				_QS_sunset = _QS_solarHorizons # 1;
				_QS_solarNoon = (_QS_sunrise + _QS_sunset) / 2;
			};
			_QS_date_checkDelay = _timeNow + _QS_date_checkDelay_timer;
		};
		if (_QS_timeAccelerationManager) then {
			if (_timeNow > _QS_timeAccelerationManager_checkDelay) then {
				_QS_dayTime = dayTime;
				_QS_currentTimeMultiplier = timeMultiplier;
				if (_QS_timeAcceleration_inProgress > 0) then {
					if (
						(_QS_timeAcceleration_inProgress isEqualTo 1) &&
						{(_QS_dayTime > (_QS_sunrise - 0.25))} &&
						{(_QS_dayTime < _QS_solarNoon)}
					) then {
						if (_QS_currentTimeMultiplier isNotEqualTo _QS_timeAccelerationControl) then {
							setTimeMultiplier _QS_timeAccelerationControl;
						};
						_QS_timeAcceleration_inProgress = 0;
					};
					if (_QS_timeAcceleration_inProgress isEqualTo 2) then {
						if (_QS_dayTime > (_QS_sunset - 3)) then {
							if (_QS_currentTimeMultiplier isNotEqualTo _QS_timeAccelerationControl) then {
								setTimeMultiplier _QS_timeAccelerationControl;
							};
							_QS_timeAcceleration_inProgress = 0;
						};
					};
					if (_QS_timeAcceleration_inProgress isEqualTo 3) then {
						if (_QS_dayTime > _QS_sunset) then {
							if (_QS_currentTimeMultiplier isNotEqualTo _QS_timeAccelerationControl) then {
								setTimeMultiplier _QS_timeAccelerationControl;
							};
							_QS_timeAcceleration_inProgress = 0;
						};
					};
					if (_QS_timeAcceleration_inProgress isEqualTo 4) then {
						if (_QS_dayTime > (_QS_sunrise + 2)) then {
							if (_QS_currentTimeMultiplier isNotEqualTo _QS_timeAccelerationControl) then {
								setTimeMultiplier _QS_timeAccelerationControl;
							};
							_QS_timeAcceleration_inProgress = 0;
						};
					};
				} else {
					if (_QS_darkAccelerated) then {
						if ((_QS_dayTime > (_QS_sunset + _QS_module_time_duskAcc)) || {(_QS_dayTime < (_QS_sunrise - 0.5))}) then {
							_QS_timeAcceleration_inProgress = 1;
							if (_QS_currentTimeMultiplier isNotEqualTo _QS_darkAccelerationFactor) then {
								setTimeMultiplier _QS_darkAccelerationFactor;
							};
						};
					};
					if (_QS_lightAccelerated) then {
						if (_QS_dayTime > (_QS_solarNoon - 2)) then {
							if (_QS_dayTime < (_QS_sunset - 3)) then {
								_QS_timeAcceleration_inProgress = 2;
								if (_QS_currentTimeMultiplier isNotEqualTo _QS_noonAccelerationFactor) then {
									setTimeMultiplier _QS_noonAccelerationFactor;
								};
							};
						};
					};
					if (_QS_dawnDuskTimeDeccelerated) then {
						if (_QS_dayTime > (_QS_sunset - 1.5)) then {
							if (_QS_dayTime < _QS_sunset) then {
								_QS_timeAcceleration_inProgress = 3;
								if (_QS_currentTimeMultiplier isNotEqualTo _QS_dawnDuskDeccelerationFactor) then {
									setTimeMultiplier _QS_dawnDuskDeccelerationFactor;
								};
							};
						};
						if (_QS_dayTime > (_QS_sunrise - _QS_module_time_dawnOffset)) then {
							if (_QS_dayTime < (_QS_sunrise + 2)) then {
								_QS_timeAcceleration_inProgress = 4;
								if (_QS_currentTimeMultiplier isNotEqualTo _QS_dawnDuskDeccelerationFactor) then {
									setTimeMultiplier _QS_dawnDuskDeccelerationFactor;
								};
							};
						};
					};
				};
				if (_QS_baseLights) then {
					if (_QS_baseLights_state) then {
						if (([0,0,0] getEnvSoundController 'night') <= 0.7) then {
							//comment 'Turn off lights';
							_QS_baseLights_state = _false;
							missionNamespace setVariable ['QS_base_lamps',_QS_baseLights_state,_true];
							sleep 0.1;
							playSound3D ['a3\missions_f_exp\data\sounds\exp_m07_lightsoff_03.wss',_objNull,_false,_base_toc,5,1,200];
							remoteExec ['QS_fnc_clientBaseLights',-2,_false];
							if ((missionNamespace getVariable ['QS_fires',[]]) isNotEqualTo []) then {
								[0,(missionNamespace getVariable 'QS_AOpos'),400,3] call _fn_aoFires;
							};
						};
					} else {
						if (([0,0,0] getEnvSoundController 'night') > 0.7) then {
							//comment 'Turn on lights';
							_QS_baseLights_state = _true;
							missionNamespace setVariable ['QS_base_lamps',_QS_baseLights_state,_true];
							sleep 0.1;
							playSound3D ['a3\missions_f_exp\data\sounds\exp_m07_lightson_03.wss',_objNull,_false,_base_toc,5,1,200];
							remoteExec ['QS_fnc_clientBaseLights',-2,_false];
							if ((missionNamespace getVariable ['QS_fires',[]]) isEqualTo []) then {
								[1,(missionNamespace getVariable 'QS_AOpos'),400,3] call _fn_aoFires;
							};
						};
					};
				};	
				_QS_timeAccelerationManager_checkDelay = _timeNow + _QS_timeAccelerationManager_delay;
			};
		};
	};
	if (_QS_helmetCam) then {
		if (_timeNow > _QS_helmetCam_checkDelay) then {
			if (!isNull _lfneck) then {
				if (!isNull _lfpilot) then {
					if (!isNull _lftarget) then {
						if (_allPlayers isNotEqualTo []) then {
							_pool = [];
							{
								_testPlayer = _x;
								if (
									(alive _testPlayer) &&
									{((_testPlayer distance2D _baseMarker) > 1000)} &&
									{(isNull (objectParent _testPlayer))} &&
									{((headgear _testPlayer) isNotEqualTo '')}
								) then {
									_pool pushBack _x;
								};
							} forEach _allPlayers;
							_nextPlayer = _objNull;
							if (_pool isNotEqualTo []) then {
								if ((count _pool) > 1) then {
									_nextPlayer = selectRandom _pool;
								} else {
									_nextPlayer = _pool # 0;
								};
							};
							if (!isNull _nextPlayer) then {
								if (alive _nextPlayer) then {
									_nextPlayerVehicle = vehicle _nextPlayer;
									missionNamespace setVariable ['QS_RD_liveFeed_vehicle',_nextPlayerVehicle,_true];
									if (isNull (objectParent _nextPlayerVehicle)) then {
										[0,_lfneck] call _fn_eventAttach;
										[1,_lfneck,[_nextPlayer,[0,0,0],'neck',_true]] call _fn_eventAttach;
										[0,_lfpilot] call _fn_eventAttach;
										[1,_lfpilot,[_nextPlayer,[0,0,0],'pilot',_true]] call _fn_eventAttach;
										[0,_lftarget] call _fn_eventAttach;
										[1,_lftarget,[_lfneck,[0.5,10,1]]] call _fn_eventAttach;
									} else {
										_memPoints = _nextPlayerVehicle getVariable ['QS_RD_liveFeed_vehicle_memPoints',[]];
										if (_memPoints isEqualTo []) then {
											if (((configOf _nextPlayerVehicle) >> 'memoryPointDriverOptics') isEqualType []) then {
												_memPoints = (getArray ((configOf _nextPlayerVehicle) >> 'memoryPointDriverOptics')) # 0;
											};
											if (((configOf _nextPlayerVehicle) >> 'memoryPointDriverOptics') isEqualType '') then {
												_memPoints = getText ((configOf _nextPlayerVehicle) >> 'memoryPointDriverOptics');
											};
											_nextPlayerVehicle setVariable ['QS_RD_liveFeed_vehicle_memPoints',_memPoints,_false];
										};
										if (_memPoints isNotEqualTo []) then {
											[1,_lfpilot,[_nextPlayerVehicle,[0,0,0],_memPoints]] call _fn_eventAttach;
										} else {
											[1,_lfpilot,[_nextPlayerVehicle,[0,0,0]]] call _fn_eventAttach;
										};
										[0,_lftarget] call _fn_eventAttach;
										[1,_lftarget,[_nextPlayerVehicle,[0,15,0]]] call _fn_eventAttach;
									};
								};
							};
						};
					} else {
						_lftarget = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
						for '_x' from 0 to 1 step 1 do {
							_lftarget allowDamage _false;
							_lftarget hideObjectGlobal _true;
						};
						missionNamespace setVariable ['QS_RD_liveFeed_target',_lftarget,_true];					
					};
				} else {
					_lfpilot = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
					for '_x' from 0 to 1 step 1 do {
						_lfpilot allowDamage _false;
						_lfpilot hideObjectGlobal _true;
					};
					missionNamespace setVariable ['QS_RD_liveFeed_pilot',_lfpilot,_true];
				};
			} else {
				_lfneck = createSimpleObject ['Sign_Sphere10cm_F',_QS_nullPos];
				for '_x' from 0 to 1 step 1 do {
					_lfneck allowDamage _false;
					_lfneck hideObjectGlobal _true;
				};
				missionNamespace setVariable ['QS_RD_liveFeed_neck',_lfneck,_true];
			};
			_QS_helmetCam_checkDelay = time + _QS_helmetCam_delay;
		};
	};
	if (_QS_module_recruitableAI) then {
		if (_timeNow > _QS_module_recruitableAI_checkDelay) then {
			if (_QS_module_recruitableAI_array isNotEqualTo []) then {
				{
					_array = _QS_module_recruitableAI_array # _forEachIndex;
					_array params [
						'_unit',
						'_delay',
						'_randomize',
						'_configCode',
						'_t',
						'_unitPos',
						'_unitDir',
						'_isRespawning',
						'_canRespawnAfter',
						'_respawnTickets',
						'_popThreshold'
					];
					_exit = _false;
					if (!alive _unit) then {
						if (!(_isRespawning)) then {
							_isRespawning = _true;
							_canRespawnAfter = time + _delay;
							_QS_module_recruitableAI_array set [_forEachIndex,[_unit,_delay,_randomize,_configCode,_t,_unitPos,_unitDir,_isRespawning,_canRespawnAfter,_respawnTickets,_popThreshold]];
						} else {
							if (
								(time > _canRespawnAfter) &&
								(!isNull _unit)
							) then {
								if ((_unit distance2D _unitPos) < 500) then {
									if (!isNull (objectParent _unit)) then {
										if ((objectParent _unit) isKindOf 'AllVehicles') then {
											(objectParent _unit) deleteVehicleCrew _unit;
										} else {
											deleteVehicle _unit;
										};
									} else {
										deleteVehicle _unit;
									};
								} else {
									if (_QS_corpseCollector) then {
										if (!(isInRemainsCollector _unit)) then {
											addToRemainsCollector [_unit];
										};
									};
								};
							};
							if (
								(_fps >= 12) &&
								{(_allPlayersCount <= 45)} &&
								{((_unitPos nearEntities ['All',0.3]) isEqualTo [])} &&
								{((!(_popThreshold)) || {((_popThreshold) && (_allPlayersCount < 45))})}
							) then {
								if (_randomize) then {
									_t = selectRandom _QS_module_recruitableAI_unitTypes;
								};
								if (_respawnTickets isNotEqualTo -1) then {
									if (_respawnTickets isEqualTo 0) then {
										_QS_module_recruitableAI_array set [_forEachIndex,_false];
										_QS_module_recruitableAI_array deleteAt _forEachIndex;
										_exit = _true;
									} else {
										_respawnTickets = _respawnTickets - 1;
									};
								};
								if (_exit) exitWith {};
								_unit = (createGroup [_QS_module_recruitableAI_side,_true]) createUnit [QS_core_units_map getOrDefault [toLowerANSI _t,_t],[0,0,0],[],15,'NONE'];
								_unit setDir _unitDir;
								(group _unit) setFormDir _unitDir;
								_unit setPosASL _unitPos;
								_unit enableDynamicSimulation _true;
								[_unit,'A3CG'] call _fn_setUnitInsignia;
								[_unit] call _configCode;
								_unit setVariable ['QS_HComm_unit',_false,_true];
								(group _unit) setVariable ['QS_HComm_grp',_false,_true];
								if ((waypoints (group _unit)) isNotEqualTo []) then {
									for '_x' from 0 to ((count (waypoints (group _unit))) - 1) step 1 do {
										if ((waypoints (group _unit)) isEqualTo []) exitWith {};
										deleteWaypoint ((waypoints (group _unit)) # 0);
									};
								};
								_QS_module_recruitableAI_array set [_forEachIndex,[_unit,_delay,_randomize,_configCode,_t,_unitPos,_unitDir,_false,0,_respawnTickets,_popThreshold]];
								[_unit] call _fn_serverUnitConfigure;
							};
						};
					} else {
						if ((_unit distance2D _unitPos) > 1) then {
							if ((_allPlayers inAreaArray [_unit,500,500,0,_false]) isEqualTo []) then {
								if (!isNull (objectParent _unit)) then {
									if ((objectParent _unit) isKindOf 'AllVehicles') then {
										(objectParent _unit) deleteVehicleCrew _unit;
									} else {
										deleteVehicle _unit;
									};
								} else {
									deleteVehicle _unit;
								};
							};
						};
						if (!((toLowerANSI _t) in _QS_module_recruitableAI_pilotTypes)) then {
							if ((vehicle _unit) isKindOf 'Helicopter') then {
								_unitVehicle = vehicle _unit;
								if (_unit isEqualTo (driver _unitVehicle)) then {
									moveOut _unit;
									(group _unit) leaveVehicle _unitVehicle;
								};
							};
						};
						_QS_aiAssignedTarget = getAttackTarget _unit;
						if (alive _QS_aiAssignedTarget) then {
							if (_QS_aiAssignedTarget isKindOf 'CAManBase') then {
								if (isPlayer _QS_aiAssignedTarget) then {
									_unit setDamage 1;
								};
							} else {
								if ((_QS_aiAssignedTarget isKindOf 'LandVehicle') || {(_QS_aiAssignedTarget isKindOf 'Air')} || {(_QS_aiAssignedTarget isKindOf 'Ship')}) then {
									if (!isNull (effectiveCommander _QS_aiAssignedTarget)) then {
										if (isPlayer (effectiveCommander _QS_aiAssignedTarget)) then {
											_unit setDamage 1;
										};
									};
								};
							};
						};
						if ((rating _unit) < -1000) then {
							if (!isNull (objectParent _unit)) then {
								if ((objectParent _unit) isKindOf 'AllVehicles') then {
									(objectParent _unit) deleteVehicleCrew _unit;
								} else {
									deleteVehicle _unit;
								};
							} else {
								deleteVehicle _unit;
							};
						};
						if !(_unit isNil 'QS_unit_isRecruited') then {
							if (((units (group _unit)) findIf {(isPlayer _x)}) isEqualTo -1) then {
								if (!isNull (objectParent _unit)) then {
									if ((objectParent _unit) isKindOf 'AllVehicles') then {
										(objectParent _unit) deleteVehicleCrew _unit;
									} else {
										deleteVehicle _unit;
									};
								} else {
									deleteVehicle _unit;
								};
							};
						};
					};
					sleep 0.01;
				} forEach _QS_module_recruitableAI_array;
			};
			_QS_module_recruitableAI_checkDelay = _timeNow + _QS_module_recruitableAI_delay;
		};
	};

	if (_QS_messagingSystem) then {
		if (_timeNow > _QS_message_delay) then {
			_QS_messages = missionNamespace getVariable ['QS_chat_messages',[]];
			_QS_messageCount = count _QS_messages;
			if (_QS_messages isNotEqualTo []) then {
				if (_QS_messageCount > 1) then {
					_QS_messageCurrent = _QS_messages # _QS_messageCurrentIndex;
					_QS_messageCurrentIndex = _QS_messageCurrentIndex + 1;
					if (_QS_messageCurrentIndex > _QS_messageCountIndex) then {
						_QS_messageCurrentIndex = 0;
					};
				} else {
					_QS_messageCurrent = _QS_messages # _QS_messageCurrentIndex;
				};
				_QS_messageCurrent remoteExec ['systemChat',-2,_false];
			};
			_QS_message_delay = _timeNow + _QS_message_interval;
		};
	};

	if (_QS_module_missionObjectives) then {
		if (_timeNow > _QS_module_missionObjectives_checkDelay) then {
			_missionObjectives = missionNamespace getVariable 'QS_RD_mission_objectives';
			if !(missionNamespace isNil 'QS_RD_mission_objectives') then {
				if (_missionObjectives isEqualType []) then {
					if (_missionObjectives isNotEqualTo []) then {
						{
							_unit = _x;
							if (!isNull _unit) then {
								if (alive _unit) then {
									if (_unit getVariable ['QS_RD_isIncapacitated',_false]) then {
										if !(_unit isNil 'QS_RD_dragged') then {
											if ((animationState _unit) in ['ainjppnemrunsnonwnondb_grab','ainjppnemrunsnonwnondb_still']) then {
												if (
													(isNull (attachedTo _unit)) &&
													((((position _unit) nearEntities ['CAManBase',5]) - [_unit]) isEqualTo [])
												) then {
													if !(_unit isNil 'QS_RD_storedAnim') then {
														if ((_unit getVariable 'QS_RD_storedAnim') isEqualType '') then {
															0 = ['switchMove',_unit,(_unit getVariable 'QS_RD_storedAnim')] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
														} else {
															0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
														};
													} else {
														0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
													};
													_unit setVariable ['QS_RD_dragged',_false,_true];
													_unit setVariable ['QS_RD_interacting',_false,_true];
												};
											};
										};
										if !(_unit isNil 'QS_RD_carried') then {
											if ((animationState _unit) in ['ainjpfalmstpsnonwnondnon_carried_still','ainjpfalmstpsnonwnondf_carried_dead','ainjpfalmstpsnonwrfldnon_carried_still','ainjpfalmstpsnonwnondnon_carried_up']) then {
												if (
													(isNull (attachedTo _unit)) &&
													((((position _unit) nearEntities ['CAManBase',5]) - [_unit]) isEqualTo [])
												) then {
													if !(_unit isNil 'QS_RD_storedAnim') then {
														if ((_unit getVariable 'QS_RD_storedAnim') isEqualType '') then {
															0 = ['switchMove',_unit,(_unit getVariable 'QS_RD_storedAnim')] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
														} else {
															0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
														};
													} else {
														0 = ['switchMove',_unit,'AinjPpneMstpSnonWnonDnon'] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
													};
													_unit setVariable ['QS_RD_carried',_false,_true];
													_unit setVariable ['QS_RD_interacting',_false,_true];
												};
											};
										};
									};
									if (_unit getVariable ['QS_RD_escorted',_false]) then {
										if (isNull (attachedTo _unit)) then {
											if !(_unit isNil 'QS_RD_storedAnim') then {
												if ((_unit getVariable 'QS_RD_storedAnim') isEqualType '') then {
													0 = ['switchMove',_unit,(_unit getVariable 'QS_RD_storedAnim')] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
												} else {
													0 = ['switchMove',_unit,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
												};
											} else {
												0 = ['switchMove',_unit,''] remoteExec ['QS_fnc_remoteExecCmd',0,_false];
											};
											if (!isPlayer _unit) then {
												_unit setVariable ['QS_RD_escorted',_false,_true];
											};
											_unit setVariable ['QS_RD_interacting',_false,_true];
										};
									};
								} else {
									_missionObjectives set [_forEachIndex,_false];
									_missionObjectives deleteAt _forEachIndex;
									missionNamespace setVariable ['QS_RD_mission_objectives',_missionObjectives,_true];
								};
							} else {
								_missionObjectives set [_forEachIndex,_false];
								_missionObjectives deleteAt _forEachIndex;
								missionNamespace setVariable ['QS_RD_mission_objectives',_missionObjectives,_true];
							};
						} forEach _missionObjectives;
					};
				};
			};
			_QS_module_missionObjectives_checkDelay = time + _QS_module_missionObjectives_delay;
		};
	};
	if (_QS_module_airDefense) then {
		if (_timeNow > _QS_module_airDefense_checkDelay) then {
			if (_airDefenseAvailable) then {
				if (missionNamespace getVariable ['QS_airbaseDefense',_false]) then {
					_airDefenseAvailable = _false;
					_airDefenseOnline = _true;
					['sideChat',[_west,'AirBase'],'Air defense activated!'] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
					_airDefenseArray = [(missionNamespace getVariable ['QS_enemyCasArray2',[]])] call _fn_airbaseDefense;
				};
			} else {
				if (_airDefenseOnline) then {
					if (_timeNow > (_airDefenseArray # 1)) then {
						_airDefenseOnline = _false;
						deleteVehicle (_airDefenseArray # 0);
						['sideChat',[_west,'AirBase'],'Air defense offline'] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
					};
				};
				if (_timeNow > (_airDefenseArray # 2)) then {
					_airDefenseAvailable = _true;
					missionNamespace setVariable ['QS_airbaseDefense',_false,_true];
					['sideChat',[_west,'AirBase'],localize 'STR_QS_Chat_044'] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];	
				};
			};
			_QS_module_airDefense_checkDelay = _timeNow + _QS_module_airDefense_delay;
		};
	};
	
	if (_QS_module_leaderboard) then {
		if (_timeNow > _QS_module_leaderboard_checkDelay) then {
			if ((missionNamespace getVariable 'QS_leaderboards_session_queue') isNotEqualTo []) then {
				{
					if (_x isEqualType []) then {
						_x params ['_type','_puid','_pname','_val'];
						_lbVal = QS_leaderboards2 getOrDefault [_puid,-1];
						_lbIndex = _lbHeaders find _type;
						if (_lbVal isEqualTo -1) then {
							_lbVal = [_pname,0,0,0,0,0,0,[0,0],[0,0],0];
							if (_lbIndex in [7,8]) then {
								_lbVal set [
									_lbIndex,
									[
										((_lbVal # _lbIndex) # 0) + (_val # 0),
										((_lbVal # _lbIndex) # 1) + (_val # 1)
									]
								];
							} else {
								_lbVal set [_lbIndex,(_lbVal # _lbIndex) + _val];
							};
							QS_leaderboards2 set [_puid,_lbVal];
						} else {
							if (_lbIndex in [7,8]) then {
								_lbVal set [
									_lbIndex,
									[
										((_lbVal # _lbIndex) # 0) + (_val # 0),
										((_lbVal # _lbIndex) # 1) + (_val # 1)
									]
								];							
							} else {
								_lbVal set [_lbIndex,(_lbVal # _lbIndex) + _val];
							};
							QS_leaderboards2 set [_puid,_lbVal];
						};
						_lbVal = QS_leaderboards3 getOrDefault [_puid,-1];
						if (_lbVal isEqualTo -1) then {
							_lbVal = [_pname,0,0,0,0,0,0,[0,0],[0,0],0];
							if (_lbIndex in [7,8]) then {
								_lbVal set [
									_lbIndex,
									[
										((_lbVal # _lbIndex) # 0) + (_val # 0),
										((_lbVal # _lbIndex) # 1) + (_val # 1)
									]
								];							
							} else {
								_lbVal set [_lbIndex,(_lbVal # _lbIndex) + _val];
							};
							QS_leaderboards3 set [_puid,_lbVal];
						} else {
							if (_lbIndex in [7,8]) then {
								_lbVal set [
									_lbIndex,
									[
										((_lbVal # _lbIndex) # 0) + (_val # 0),
										((_lbVal # _lbIndex) # 1) + (_val # 1)
									]
								];							
							} else {
								_lbVal set [_lbIndex,(_lbVal # _lbIndex) + _val];
							};
							QS_leaderboards3 set [_puid,_lbVal];
						};
						(missionNamespace getVariable 'QS_leaderboards_session_queue') set [_forEachIndex,_false];
					};
				} forEach (missionNamespace getVariable 'QS_leaderboards_session_queue');
				QS_leaderboards_session_queue = QS_leaderboards_session_queue select {(_x isEqualType [])};
			};
			if (_timeNow > _QS_leaderboards_saveCheckDelay) then {
				if (!(_QS_module_restart_isRestarting)) then {
					missionProfileNamespace setVariable ['QS_leaderboards2',(missionNamespace getVariable 'QS_leaderboards2')];
				};
				_QS_leaderboards_saveCheckDelay = _timeNow + _QS_leaderboards_saveDelay;
			};
			_QS_module_leaderboard_checkDelay = _timeNow + _QS_module_leaderboard_delay;
		};
		if (_timeNow > _QS_module_accuracy_checkDelay) then {
			if (_accuracyAllPlayers isEqualTo []) then {
				_accuracyAllPlayers = allPlayers apply { [0,_x] };
			};
			if (_accuracyAllPlayers isNotEqualTo []) then {
				_accuracyAllPlayers = _accuracyAllPlayers select { (((_x # 0) isEqualTo 0) && (alive (_x # 1))) };
				if (_accuracyAllPlayers isNotEqualTo []) then {
					_accuracyAllPlayers sort _true;
					_accuracyPlayer = (_accuracyAllPlayers # 0) # 1;
					_accuracyAllPlayers deleteAt 0;
					missionNamespace setVariable ['QS_client_sendAccuracy',_true,owner _accuracyPlayer];
				};
			};
			_QS_module_accuracy_checkDelay = _timeNow + _QS_module_accuracy_delay;
		};
	};

	if (_QS_module_captives) then {
		if (_timeNow > _QS_module_captives_checkDelay) then {
			_QS_enemyCaptives = missionNamespace getVariable ['QS_enemyCaptives',[]];
			if (_QS_enemyCaptives isNotEqualTo []) then {
				{
					if (!isNull _x) then {
						if (alive _x) then {
							if ((_x distance2D _gitmo) > 25) then {
								if (([_x,200,[_west],_allPlayers,0] call _fn_serverDetector) isEqualTo []) then {
									deleteVehicle _x;
									_QS_enemyCaptives set [_forEachIndex,_false];
									_QS_enemyCaptives deleteAt _forEachIndex;
								};
							};
						} else {
							_QS_enemyCaptives set [_forEachIndex,_false];
							_QS_enemyCaptives deleteAt _forEachIndex;
						};
					} else {
						_QS_enemyCaptives set [_forEachIndex,_false];
						_QS_enemyCaptives deleteAt _forEachIndex;
					};
					sleep 0.01;
				} forEach _QS_enemyCaptives;
				{
					if (!(_x in (missionNamespace getVariable 'QS_enemyCaptives'))) then {
						missionNamespace setVariable ['QS_enemyCaptives',((missionNamespace getVariable 'QS_enemyCaptives') + [_x]),_false];
					};
				} count _QS_enemyCaptives;
			};
			_QS_module_captives_checkDelay = _timeNow + _QS_module_captives_delay;
		};
	};

	/*/===== OPSEC module/*/
	
	if (_QS_module_opsec) then {
		if (_timeNow > _QS_module_opsec_checkDelay) then {
			if (_QS_module_opsec_checkMarkers) then {
				_QS_allMapMarkers = allMapMarkers;
				{
					if (
						(!(_x in ['respawn','respawn_east','respawn_west','respawn_guerrila','respawn_civilian'])) &&
						{(!(_x in (_QS_module_opsec_checkMarkers_whitelistedMarkers + (missionNamespace getVariable 'QS_markers_whitelistedDynamic'))))} &&
						{(!(_x in (missionNamespace getVariable ['QS_grid_markers',[]])))} &&
						{(!(['curatorInterface',_x,_false] call _fn_inString))} &&
						{(!(['QS_',_x,_false] call _fn_inString))}
					) then {
						_QS_module_opsec_deleteMarker = _true;
					};
					if (((markerText _x) select [0,3]) isNotEqualTo _markerCheck) then {
						_QS_module_opsec_deleteMarker = _true;
					};
					if (!(_QS_module_opsec_deleteMarker)) then {
						if ((count (markerText _x)) >= 100) then {
							_QS_module_opsec_deleteMarker = _true;
						};
					};
					if (_QS_module_opsec_deleteMarker) then {
						_QS_module_opsec_deleteMarker = _false;
						diag_log format ['***** ANTI-HACK ***** Deleted invalid marker * %1 * %2 * %3 * %4 *****',_x,(markerText _x),(markerAlpha _x),(markerPos _x)];
						deleteMarker _x;
						_QS_allMapMarkers set [_forEachIndex,''];
					};
				} forEach _QS_allMapMarkers;
				if (_QS_module_opsec_deleteMarker) then {
					_QS_module_opsec_deleteMarker = _false;
				};
			};
			if (_QS_module_opsec_checkVariables) then {
				{
					{
					
					} count (allVariables _x);
				} forEach [
					missionNamespace,
					uiNamespace,
					profileNamespace
				];
			};
			if (_QS_module_opsec_clientHeartbeat) then {
				if (_timeNow > _QS_module_heartbeat_checkDelay) then {
					if (_allPlayers isNotEqualTo []) then {
						remoteExec ['QS_fnc_clientHeartbeat',-2,_false]; 
					};
					_QS_module_heartbeat_checkDelay = _timeNow + _QS_module_heartbeat_delay;
				};
			};
			_QS_module_opsec_checkDelay = _timeNow + _QS_module_opsec_delay;
		};
	};
	
	/*/===== Module Uniform Fix /*/
	
	if (_QS_module_uniformFix) then {
		if (_timeNow > _QS_module_uniformFix_checkDelay) then {
			_uniformFix_list = _allPlayers select {((uniform _x) isEqualTo '')};
			if (_uniformFix_list isNotEqualTo []) then {
				[95] remoteExec ['QS_fnc_remoteExec',_uniformFix_list,_false];
			};
			_QS_module_uniformFix_checkDelay = _timeNow + _QS_module_uniformFix_delay;
		};
	};
	
	/*/===== Fix Ungrouped Players. To-Do: Make this support multi faction/*/
	
	if (_QS_module_groupFix) then {
		if (_timeNow > _QS_module_groupFix_checkdelay) then {
			if (isNull _mainGroup) then {
				_mainGroup = createGroup [WEST,_false];
				_mainGroup deleteGroupWhenEmpty _false;
				{
					_mainGroup setVariable _x;
				} forEach [
					['QS_cleanup_protected',_true,_true],
					['BIS_dg_reg',_true,_true],
					['BIS_dg_pri',_false,_true],
					['BIS_dg_var','var_76561100000000000_0',_true],
					['BIS_dg_ins',(['LoadRandomInsignia'] call _fn_dynamicGroups),_true]				
				];
				_mainGroup setGroupIDGlobal [_mainGroupName];
			} else {
				if (_mainGroup getVariable ['BIS_dg_pri',_false]) then {
					_mainGroup setVariable ['BIS_dg_pri',_false,_true];
				};
				if (!(_mainGroup getVariable ['BIS_dg_reg',_false])) then {
					_mainGroup setVariable ['BIS_dg_reg',_true,_true];
				};
				if (isGroupDeletedWhenEmpty _mainGroup) then {
					_mainGroup deleteGroupWhenEmpty _false;
				};
				if ((groupId _mainGroup) isNotEqualTo _mainGroupName) then {
					_mainGroup setGroupIDGlobal [_mainGroupName];
				};
			};
			{
				if (
					(!((group _x) getVariable ['BIS_dg_reg',_false])) &&
					{((_x getVariable ['QS_unit_side',WEST]) isEqualTo WEST)}
				) exitWith {
					[_x] joinSilent _mainGroup;
				};
			} forEach _allPlayers;
			_QS_module_groupFix_checkdelay = _timeNow + _QS_module_groupFix_delay;
		};
	};
	
	/*/===== Module Dynamic Simulation/*/

	if (_QS_module_dynSim) then {
		if (_QS_diagTickTimeNow > _QS_module_dynSim_checkDelay) then {
			if (dynamicSimulationSystemEnabled) then {
				{
					if (_x isEqualType _objNull) then {
						if (
							(_x isKindOf 'LandVehicle') ||
							{(_x isKindOf 'StaticWeapon')} ||
							{(_x isKindOf 'Reammobox_F')} ||
							{(_x isKindOf 'Ship')}
						) then {
							if ((_x distance2D (_x getVariable ['QS_sim_pos',[-5000,-5000,0]])) > 50) then {
								_x setVariable ['QS_sim_pos',getPosATL _x,_true];
								sleep 0.1;
							};
						};
						if (alive _x) then {
							if (local _x) then {
								if (
									(!(unitIsUAV _x)) &&
									{(!(dynamicSimulationEnabled _x))} &&
									{(((_x distance2D [0,0,0]) > 1000) && ((_x distance2D _baseMarker) > 750))}
								) then {
									if ((!((vehicle _x) isKindOf 'Air')) && (!(_x isKindOf 'Air'))) then {
										if ((typeOf _x) isNotEqualTo 'test_EmptyObjectForFireBig') then {
											if (!(_x getVariable ['QS_dynSim_ignore',_false])) then {
												_x enableDynamicSimulation _true;
											};
										};
									} else {
										if (dynamicSimulationEnabled _x) then {
											_x enableDynamicSimulation _false;
										};
									};
								};
							} else {
								if ((isPlayer _x) || {(unitIsUAV _x)}) then {
									if (!(_x isKindOf 'HeadlessClient_F')) then {
										if (!(canTriggerDynamicSimulation _x)) then {
											_x triggerDynamicSimulation _true;
										};
										if (dynamicSimulationEnabled _x) then {
											_x enableDynamicSimulation _false;
										};
									} else {
										if (canTriggerDynamicSimulation _x) then {
											_x triggerDynamicSimulation _false;
										};
									};
								};
							};
						};
					} else {
						if (
							(_x isEqualType grpNull) &&
							{(local _x)}
						) then {
							if (
								(!(dynamicSimulationEnabled _x)) &&
								{(!((vehicle (leader _x)) isKindOf 'Air'))} &&
								{(!(_x getVariable ['QS_dynSim_ignore',_false]))} &&
								{((side _x) in [_east,_resistance])}
							) then {
								_x enableDynamicSimulation _true;
							};
						};
					};
					sleep 0.003;
				} forEach (_allUnits + _allUnitsUav + _allVehicles + _allGroups);
			};
			_QS_module_dynSim_checkDelay = _QS_diagTickTimeNow + _QS_module_dynSim_delay;
		};
		if (!(missionNamespace getVariable 'QS_server_dynSim')) then {
			_QS_module_dynSim = _false;
			if (dynamicSimulationSystemEnabled) then {
				{
					if (dynamicSimulationEnabled _x) then {
						_x enableDynamicSimulation _false;
					};
				} forEach (_allUnits + _allUnitsUav + _allVehicles + _allGroups);
				enableDynamicSimulationSystem _false;
			};
		};
	} else {
		if (missionNamespace getVariable 'QS_server_dynSim') then {
			_QS_module_dynSim = _true;
			if (!(dynamicSimulationSystemEnabled)) then {
				enableDynamicSimulationSystem _true;
			};
		};
	};

	/*/===== Dynamic Tasks/*/
	
	if (_QS_module_emergentTasks) then {
		if (_timeNow > _QS_module_emergentTasks_checkDelay) then {
			if ((missionNamespace getVariable ['QS_module_dynamicTasks_add',[]]) isNotEqualTo []) then {
				{
					if (_x isEqualType []) then {
						_QS_module_emergentTasks_array pushBack _x;
						(missionNamespace getVariable 'QS_module_dynamicTasks_add') set [_forEachIndex,_false];
					};
				} forEach (missionNamespace getVariable ['QS_module_dynamicTasks_add',[]]);
				{
					if (_x isEqualType _false) then {
						(missionNamespace getVariable 'QS_module_dynamicTasks_add') deleteAt _forEachIndex;
					};
				} forEach (missionNamespace getVariable 'QS_module_dynamicTasks_add');
			};
			if (_QS_module_emergentTasks_array isNotEqualTo []) then {
				{
					if (_x isEqualType []) then {
						_QS_module_emergentTask = _x;
						_QS_module_emergentTask params [
							'_QS_module_emergentTask_id',
							'_QS_module_emergentTask_instruction',
							'_QS_module_emergentTask_type',
							'_QS_module_emergentTask_logic',
							'_QS_module_emergentTask_data'
						];
						if (_QS_module_emergentTask_instruction isEqualTo 'ADD') then {
							_QS_module_emergentTask_logic params [
								'_QS_module_emergentTask_logic_created',
								'_QS_module_emergentTask_logic_success',
								'_QS_module_emergentTask_logic_fail',
								'_QS_module_emergentTask_logic_cancel'
							];
							if ((_QS_module_emergentTask_logic_created # 0) call (_QS_module_emergentTask_logic_created # 1)) then {
								_QS_module_emergentTask_countType = {(((_x # 2) isEqualTo _QS_module_emergentTask_type) && ((_x # 1) isEqualTo 'EVAL'))} count (_QS_module_emergentTasks_array select {(_x isEqualType [])});
								if (_QS_module_emergentTask_countType < _QS_module_emergentTask_maxType) then {
									(_QS_module_emergentTask_logic_created # 2) call _fn_setTask;
									//comment 'Add to eval';
									_QS_module_emergentTasks_array set [_forEachIndex,[_QS_module_emergentTask_id,'EVAL',_QS_module_emergentTask_type,_QS_module_emergentTask_logic,_QS_module_emergentTask_data]];
								};
							} else {
								[_QS_module_emergentTask_id,'CANCELED',_true] call _fn_taskSetState;
							};
						};
						if (_QS_module_emergentTask_instruction isEqualTo 'EVAL') then {
							_QS_module_emergentTask_logic params [
								'_QS_module_emergentTask_logic_created',
								'_QS_module_emergentTask_logic_success',
								'_QS_module_emergentTask_logic_fail',
								'_QS_module_emergentTask_logic_cancel'
							];
							if ((_QS_module_emergentTask_logic_success # 0) call (_QS_module_emergentTask_logic_success # 1)) then {
								[_QS_module_emergentTask_id,'SUCCEEDED',_true] call _fn_taskSetState;
								_QS_module_emergentTasks_array set [_forEachIndex,[_QS_module_emergentTask_id,'REMOVE',_QS_module_emergentTask_type,_QS_module_emergentTask_logic,_QS_module_emergentTask_data]];
							} else {
								if ((_QS_module_emergentTask_logic_fail # 0) call (_QS_module_emergentTask_logic_fail # 1)) then {
									[_QS_module_emergentTask_id,'FAILED',_true] call _fn_taskSetState;
									_QS_module_emergentTasks_array set [_forEachIndex,[_QS_module_emergentTask_id,'REMOVE',_QS_module_emergentTask_type,_QS_module_emergentTask_logic,_QS_module_emergentTask_data]];
								} else {
									if ((_QS_module_emergentTask_logic_cancel # 0) call (_QS_module_emergentTask_logic_cancel # 1)) then {
										[_QS_module_emergentTask_id,'CANCELED',_true] call _fn_taskSetState;
										_QS_module_emergentTasks_array set [_forEachIndex,[_QS_module_emergentTask_id,'REMOVE',_QS_module_emergentTask_type,_QS_module_emergentTask_logic,_QS_module_emergentTask_data]];
									};
								};
							};
						};						
						if (_QS_module_emergentTask_instruction isEqualTo 'REMOVE') then {
							[_QS_module_emergentTask_id,_true] call _fn_deleteTask;
							_QS_module_emergentTasks_array set [_forEachIndex,_false];
						};
					};
				} forEach _QS_module_emergentTasks_array;
				{
					if (_x isEqualType _false) then {
						_QS_module_emergentTasks_array deleteAt _forEachIndex;
					};
				} forEach _QS_module_emergentTasks_array;
				
			};
			if (_QS_module_emergentTasks_medevac) then {
				missionNamespace setVariable [
					'QS_dynTask_medevac_array',
					((missionNamespace getVariable 'QS_dynTask_medevac_array') select {((alive _x) && ((lifeState _x) isEqualTo 'INCAPACITATED') && (isPlayer _x))}),
					_false
				];
				if ((missionNamespace getVariable 'QS_dynTask_medevac_array') isEqualTo []) then {
					if (missionNamespace getVariable 'QS_dynTask_medevac_inProgress') then {
						missionNamespace setVariable ['QS_dynTask_medevac_inProgress',_false,_true];
					};
				} else {
					if (!(missionNamespace getVariable 'QS_dynTask_medevac_inProgress')) then {
						missionNamespace setVariable ['QS_dynTask_medevac_inProgress',_true,_true];
					};				
				};
			};
			_QS_module_emergentTasks_checkDelay = _timeNow + _QS_module_emergentTasks_delay;
		};
	};
	
	/*/ Movable Respawn point for Zeus mode/*/

	if (
		_QS_module_zeusRespawn ||
		{(missionNamespace getVariable ['QS_module_zeusRespawn',FALSE])}
	) then {
		if (_timeNow > _QS_module_zeusRespawn_checkDelay) then {
			_QS_module_zeusRespawn_checkDelay = _timeNow + _QS_module_zeusRespawn_delay;
			{
				_QS_module_zeusRespawn_updateElement = _false;
				_QS_module_zeusRespawn_element = _x;
				_QS_module_zeusRespawn_element params [
					'_QS_module_zeusRespawn_side',
					'_QS_module_zeusRespawn_marker',
					'_QS_module_zeusRespawn_pos',
					'_QS_module_zeusRespawn_object',
					'_QS_module_zeusRespawn_objectType',
					'_QS_module_zeusRespawn_flagTexture'
				];
				if (!alive _QS_module_zeusRespawn_object) then {
					_QS_module_zeusRespawn_object = createVehicle [_QS_module_zeusRespawn_objectType,[0,0,0]];
					if (((getPosATL _QS_module_zeusRespawn_object) # 2) < 0) then {
						_QS_module_zeusRespawn_pos = _QS_module_zeusRespawn_pos vectorAdd [0,0,abs ((getPosATL _QS_module_zeusRespawn_object) # 2)];
						_QS_module_zeusRespawn_element set [2,_QS_module_zeusRespawn_pos];
					};
					_QS_module_zeusRespawn_object setPosASL _QS_module_zeusRespawn_pos;
					_QS_module_zeusRespawn_object setFlagTexture _QS_module_zeusRespawn_flagTexture;
					_QS_module_zeusRespawn_object enableVehicleCargo _false;
					_QS_module_zeusRespawn_object enableRopeAttach _false;
					_QS_module_zeusRespawn_object enableDynamicSimulation _false;
					
					if (_zeusModeRespawnMarker) then {
						_QS_module_zeusRespawn_marker setMarkerTypeLocal 'Empty';
						_QS_module_zeusRespawn_marker setMarkerShapeLocal 'Ellipse';
						_QS_module_zeusRespawn_marker setMarkerBrushLocal 'SolidBorder';
						_QS_module_zeusRespawn_marker setMarkerColorLocal ([_QS_module_zeusRespawn_side,_true] call _fn_sideColor);
						_QS_module_zeusRespawn_marker setMarkerSizeLocal [100,100];
						_QS_module_zeusRespawn_marker setMarkerAlphaLocal 0.5;
						_QS_module_zeusRespawn_marker setMarkerPosLocal _QS_module_zeusRespawn_object;
						_QS_module_zeusRespawn_marker setMarkerDir 0;
					};
					
					if (_QS_module_zeusRespawn_arsenal) then {
						_QS_module_zeusRespawn_object setVariable ['QS_arsenal_object',_true,_true];
					};
					_QS_module_zeusRespawn_object setVariable ['QS_zeus',_true,_false];
					_QS_module_zeusRespawn_element set [3,_QS_module_zeusRespawn_object];
					_QS_module_zeusRespawn_updateElement = _true;
				} else {
					// If respawn flag is below terrain
					if (((ASLToATL (getPosASL _QS_module_zeusRespawn_object)) # 2) < 0) then {
						_QS_module_zeusRespawn_pos vectorAdd [0,0,getTerrainHeightASL _QS_module_zeusRespawn_pos];
						_QS_module_zeusRespawn_object setPosASL _QS_module_zeusRespawn_pos;
						_QS_module_zeusRespawn_element set [2,_QS_module_zeusRespawn_pos];
						_QS_module_zeusRespawn_updateElement = _true;
					};
					// If flag is not at saved position, update
					if ((_QS_module_zeusRespawn_pos vectorDistance (getPosASL _QS_module_zeusRespawn_object)) > 1) then {
						_QS_module_zeusRespawn_marker setMarkerPos (getPosASL _QS_module_zeusRespawn_object);
						_QS_module_zeusRespawn_element set [2,(getPosASL _QS_module_zeusRespawn_object)];
						_QS_module_zeusRespawn_updateElement = _true;
					};
				};
				if (_QS_module_zeusRespawn_updateElement) then {
					_QS_module_zeusRespawn_data set [_forEachIndex,_QS_module_zeusRespawn_element];
				};
			} forEach _QS_module_zeusRespawn_data;
		};
	};

	/*/===== Restart scheduler/*/
	
	if (_QS_module_restart) then {
		if (_QS_diagTickTimeNow > _QS_module_restart_checkDelay) then {
			if (!(_QS_module_restart_isRestarting)) then {
				_QS_module_restart_realTimeNow = systemTime;
				_QS_module_restart_hourCurrent = _QS_module_restart_realTimeNow # 3;
				if (_QS_module_restart_hour < _QS_module_restart_hourCurrent) then {
					_estimatedTimeLeft = (24 - _QS_module_restart_hourCurrent) + _QS_module_restart_hour - ((_QS_module_restart_realTimeNow # 4) / 60);
				} else {
					_estimatedTimeLeft = (_QS_module_restart_hour - _QS_module_restart_hourCurrent) - ((_QS_module_restart_realTimeNow # 4) / 60);
				};
				if (_QS_diagTickTimeNow > _QS_module_restart_lastBroadcast) then {
					_QS_module_restart_lastBroadcast = _QS_diagTickTimeNow + 60;
					_estimatedTimeLeft = _estimatedTimeLeft * 3600;
					estimatedTimeLeft (0 max _estimatedTimeLeft min 36000);
				};
				if (
					(_QS_module_restart_hourCurrent isEqualTo _QS_module_restart_hour) &&
					{((!_QS_module_restart_isDynamic) || {(_QS_module_restart_isDynamic && (missionNamespace getVariable ['QS_system_restartEnabled',_true]))})}
				) then {
					diag_log '***** Server restarting as scheduled *****';
					_QS_module_restart_isRestarting = _true;
					0 spawn QS_fnc_serverRestart;
				};
			};
			_QS_module_restart_checkDelay = _QS_diagTickTimeNow + _QS_module_restart_delay;
		};
	};
	sleep 2.5;
};
diag_log format ['* %1 ***** QS ***** DEBUG ***** MISSION ENGINE TERMINATED *****',diag_tickTime];
if (!(_resumeScript)) then {
	['hint',(parseText 'Uho! It appears something has gone wrong. Please report this error code to staff:<br/><br/>811<br/><br/>Thank you for your assistance.')] remoteExec ['QS_fnc_remoteExecCmd',-2,_false];
};
0 spawn QS_fnc_serverRestart;