/*/
File: fn_AI.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	AI
	
Notes:

	For headless client,
	support providers need to remain on server
	fire support scripts var needs to be public
__________________________________________________/*/

scriptName 'QS AI';
if (hasInterface && !isDedicated) exitWith {};
private _isDedicated = isDedicated;
private _isHC = !isDedicated && !hasInterface;
if (_isHC) then {
	player setPosASL [
		worldSize + (random 2000),
		worldSize - (random 2000),
		10
	];
	waitUntil {(missionNamespace getVariable ['QS_mission_init',FALSE])};
};
private _QS_uiTime = diag_tickTime;
private _QS_time = time;
private _QS_serverTime = serverTime;
private _QS_dayTime = dayTime;
_worldName = worldName;
_worldSize = worldSize;
private _smallTerrains = ['Tanoa','Stratis'];
_true = TRUE;
_false = FALSE;
_endl = endl;
_isTropical = _worldName in ['Tanoa','Enoch'];
private _QS_unitCap = [140,120] select (_worldName in _smallTerrains);
private _array = [];
private _QS_unit = objNull;
private _QS_grp = grpNull;

private _QS_allAgents = [];

private _scriptEvalGrp = scriptNull;
private _scriptEvalUnit = scriptNull;
private _scriptEvalAgent = scriptNull;

private _movePos = [0,0,0];
private _basePosition = markerPos 'QS_marker_base_marker';
_east = EAST;
_west = WEST;
_civilian = CIVILIAN;
_resistance = RESISTANCE;
_sideFriendly = sideFriendly;
_enemySides = [_east,_resistance];
_friendlySides = [_west,_civilian,_sideFriendly];
//comment 'General Info';
private _QS_updateGeneralInfoDelay = 10;
private _QS_updateGeneralInfoCheckDelay = _QS_uiTime + _QS_updateGeneralInfoDelay;
private _QS_diag_fps = round diag_fps;
private _QS_allPlayers = allPlayers;
private _QS_allPlayersCount = count _QS_allPlayers;
private _QS_allGroups = allGroups;
private _QS_allGroupsCount = count _QS_allGroups;
private _QS_allUnits = allUnits;
private _QS_allUnitsCount = count _QS_allUnits;
//comment 'Dynamic skill';
private _QS_module_dynamicSkill = _false;
private _QS_module_dynamicSkill_delay = 300;
private _QS_module_dynamicSkill_checkDelay = _QS_uiTime + _QS_module_dynamicSkill_delay;
//comment 'General group behaviors';
private _QS_module_groupBehaviors = _true;
private _QS_module_groupBehaviors_delay = 15;
private _QS_module_groupBehaviors_checkDelay = _QS_uiTime + _QS_module_groupBehaviors_delay;
private _QS_module_groupBehaviors_localGroups = [];
private _QS_module_groupBehaviors_group = grpNull;
private _QS_module_groupBehaviors_groupConfig = [];
private _QS_module_groupBehaviors_groupConfig_gameType = '';
private _QS_module_groupBehaviors_groupData = [];
private _QS_module_groupBehaviors_groupTask = [];
private _QS_module_groupBehaviors_groupTask_type = '';
private _QS_module_groupBehaviors_groupTask_simple = '';
private _QS_module_groupBehaviors_groupTask_startTime = -1;
private _QS_module_groupBehaviors_groupTask_endTime = -1;
//comment 'General unit behaviors';
private _QS_module_unitBehaviors = _true;
private _QS_module_unitBehaviors_delay = 25;
private _QS_module_unitBehaviors_checkDelay = _QS_uiTime + _QS_module_unitBehaviors_delay;
private _QS_module_unitBehaviors_localUnits = [];
private _QS_module_unitBehaviors_unit = objNull;
//comment 'General agent (civ + animal) behaviors';
private _QS_module_agentBehaviors = _true;
private _QS_module_agentBehaviors_delay = 30;
private _QS_module_agentBehaviors_checkDelay = _QS_uiTime + _QS_module_agentBehaviors_delay;
private _QS_module_agentBehaviors_localAgents = [];
private _QS_module_agentBehaviors_agent = objNull;
//comment 'Virtual sectors logic';
private _QS_module_virtualSectors = _isDedicated && (missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isEqualTo 'SC';
private _QS_module_virtualSectors_delay = 15;	/*/this value influences difficulty substantially/*/
private _QS_module_virtualSectors_checkDelay = _QS_uiTime + _QS_module_virtualSectors_delay;
private _QS_module_virtualSectors_data = missionNamespace getVariable ['QS_virtualSectors_data',[]];
private _QS_module_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
private _QS_module_virtualSectors_scoreWin = missionNamespace getVariable ['QS_virtualSectors_scoreWin',300];
private _QS_module_virtualSectors_scoreEndClose = _QS_module_virtualSectors_scoreWin * 0.75;
private _QS_module_virtualSectors_active = _false;
private _QS_module_virtualSectors_spawnedGrp = grpNull;
private _QS_module_virtualSectors_assignedUnits = [[],[],[],[]];
private _QS_module_virtualSectors_assignedUnitsSector = [];
private _QS_module_virtualSectors_patrolFallback = _false;
private _QS_module_virtualSectors_maxAI = 0;
private _QS_module_virtualSectors_maxAISector = 0;
private _QS_module_virtualSectors_maxAIX = 0;
private _QS_module_virtualSectors_countAI = 0;
private _QS_module_virtualSectors_countAISector = 0;
private _QS_module_virtualSectors_playersInAO = [];
private _QS_module_virtualSectors_sectorData = [];
private _QS_module_virtualSectors_spawnGroupCount = 4;
private _QS_module_virtualSectors_scriptCreateEnemy = scriptNull;
private _QS_module_virtualSectors_enemy_0 = [];
private _QS_module_virtualSectors_enemy_1 = [];
private _QS_module_virtualSectors_patrolsHeli = [];
private _QS_module_virtualSectors_patrolsInf = [];
private _QS_module_virtualSectors_patrolsVeh = [];
private _QS_module_virtualSectors_patrolsGarrison = [];
private _QS_module_virtualSectors_patrolsBoat = [];
private _QS_module_virtualSectors_patrolsSniper = [];
private _QS_module_virtualSectors_patrolsHeli_thresh = 1;
private _QS_module_virtualSectors_patrolsInf_thresh = 20;
private _QS_module_virtualSectors_patrolsVeh_thresh = 1;
private _QS_module_virtualSectors_patrolsGarrison_thresh = 10;
private _QS_module_virtualSectors_patrolsBoat_thresh = 0;
private _QS_module_virtualSectors_patrolsSniper_thresh = 1;
private _QS_module_virtualSectors_countAIHeliPatrols = 0;
private _QS_module_virtualSectors_countAIInfPatrols = 0;
private _QS_module_virtualSectors_countAIVehPatrols = 0;
private _QS_module_virtualSectors_countAISnpPatrols = 0;

private _QS_module_virtualSectors_maxAI_0 = 48;
private _QS_module_virtualSectors_maxAI_1 = 64;
private _QS_module_virtualSectors_maxAI_2 = 96;
private _QS_module_virtualSectors_maxAI_3 = 108;
private _QS_module_virtualSectors_maxAI_4 = 124;
private _QS_module_virtualSectors_maxAI_5 = 136;

private _QS_module_virtualSectors_maxAISector_0 = 6;
private _QS_module_virtualSectors_maxAISector_1 = 8;
private _QS_module_virtualSectors_maxAISector_2 = 10;
private _QS_module_virtualSectors_maxAISector_3 = 14;
private _QS_module_virtualSectors_maxAISector_4 = 22;
private _QS_module_virtualSectors_maxAISector_5 = 26;

private _QS_module_virtualSectors_maxAIX_0 = 10;
private _QS_module_virtualSectors_maxAIX_1 = 12;
private _QS_module_virtualSectors_maxAIX_2 = 18;
private _QS_module_virtualSectors_maxAIX_3 = 26;
private _QS_module_virtualSectors_maxAIX_4 = 30;
private _QS_module_virtualSectors_maxAIX_5 = 38;

private _QS_module_virtualSectors_assaultEnabled = _false;
private _QS_module_virtualSectors_assaultScript = scriptNull;
private _QS_module_virtualSectors_assaultActive = _false;
private _QS_module_virtualSectors_assaultChance = selectRandom [0.333,0.666];
private _QS_module_virtualSectors_assaultReady = _false;
private _QS_module_virtualSectors_assaultCondition = {};
private _QS_module_virtualSectors_assaultVarName = 'QS_fnc_AIAssaultSector';
private _QS_module_virtualSectors_assaultDuration = 0;
private _QS_module_virtualSectors_assaultDuration_fixed = 300;
private _QS_module_virtualSectors_assaultDuration_variable = 300;
private _QS_module_virtualSectors_assaultSector = -1;
private _QS_module_virtualSectors_assaultArray = [];
private _QS_module_virtualSectors_assaultGrps = [];
private _QS_module_virtualSectors_assaultScore = random [0.5,0.666,0.75];

if (_QS_allPlayersCount < 10) then {
	_QS_module_virtualSectors_maxAI = 40;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
if (_QS_allPlayersCount >= 10) then {
	_QS_module_virtualSectors_maxAI = 60;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
if (_QS_allPlayersCount >= 20) then {
	_QS_module_virtualSectors_maxAI = 80;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
if (_QS_allPlayersCount >= 30) then {
	_QS_module_virtualSectors_maxAI = 96;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
if (_QS_allPlayersCount >= 40) then {
	_QS_module_virtualSectors_maxAI = 108;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
if (_QS_allPlayersCount >= 50) then {
	_QS_module_virtualSectors_maxAI = 128;
	_QS_module_virtualSectors_maxAISector = 12;
	_QS_module_virtualSectors_maxAIX = 16;
	_QS_module_virtualSectors_patrolsInf_thresh = 20;
	_QS_module_virtualSectors_patrolsVeh_thresh = 1;
	_QS_module_virtualSectors_patrolsGarrison_thresh = 10;
	_QS_module_virtualSectors_patrolsBoat_thresh = 0;
	_QS_module_virtualSectors_patrolsSniper_thresh = 1;
};
private _QS_module_virtualSectors_patrolsHeli_delay = [360,480] select (worldName in _smallTerrains);		// 360
private _QS_module_virtualSectors_patrolsHeli_checkDelay = _QS_uiTime + _QS_module_virtualSectors_patrolsHeli_delay;
private _QS_module_virtualSectors_heliEnabled = _true;
private _QS_module_virtualSectors_patrolsVeh_delay = 300;
private _QS_module_virtualSectors_patrolsVeh_checkDelay = _QS_uiTime + _QS_module_virtualSectors_patrolsVeh_delay;
private _QS_module_virtualSectors_vehiclesEnabled = _true;
private _QS_module_virtualSectors_uavEnabled = _true;
private _QS_module_virtualSectors_uav_delay = [120,240] select (worldName in _smallTerrains);			// 30
private _QS_module_virtualSectors_uav_checkDelay = _QS_uiTime + _QS_module_virtualSectors_uav_delay;
private _QS_module_virtualSectors_uavs = [];
private _QS_module_virtualSectors_defenderDelay = 30;
private _QS_module_virtualSectors_defenderCheckDelay = _QS_uiTime + _QS_module_virtualSectors_defenderDelay;
private _QS_module_virtualSectors_attackerDelay = 30;
private _QS_module_virtualSectors_attackerCheckDelay = _QS_uiTime + _QS_module_virtualSectors_attackerDelay;

//comment 'Classic AO logic';
private _QS_module_classic = _isDedicated && (missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isEqualTo 'CLASSIC';
private _QS_module_classic_delay = 10;
private _QS_module_classic_checkDelay = _QS_uiTime + _QS_module_classic_delay;
private _QS_module_classic_spawnedGrp = [];
private _QS_module_classic_scriptAOUrbanSpawn = scriptNull;
private _QS_module_classic_aoUrbanSpawning = (missionNamespace getVariable ['QS_missionConfig_aoUrbanSpawning',1]) isEqualTo 1;
private _QS_module_classic_scriptCreateEnemy = scriptNull;
private _QS_module_classic_enemy_0 = [];
private _QS_module_classic_aoPos = [0,0,0];
private _QS_module_classic_hqPos = [0,0,0];
private _QS_module_classic_aoSize = 0;
private _QS_module_classic_aoData = [];
private _QS_module_classic_spawnedEntities = [];
private _QS_module_classic_terrainData = [];

//comment 'classic ao uavs';
private _QS_module_classic_uavEnabled = _true;
private _QS_module_classic_uav_delay = [300,480] select (worldName in _smallTerrains);
private _QS_module_classic_uav_checkDelay = _QS_uiTime + _QS_module_classic_uav_delay;
private _QS_module_classic_uavs = [];
//comment 'classic ao helis';
private _QS_module_classic_heliEnabled = _true;
private _QS_module_classic_patrolsHeli_delay = [300,480] select (worldName in _smallTerrains);		//60;		// Enemy Heli respawn delay (down below in the code an extra (random 120) is applied)
private _QS_module_classic_patrolsHeli_checkDelay = _QS_uiTime + _QS_module_classic_patrolsHeli_delay;
private _QS_module_classic_patrolsHeli = [];
//comment 'classic ao reinforcements';
private _QS_module_classic_infReinforce = _true;
private _QS_module_classic_infReinforce_enabled = _true;
private _QS_module_classic_infReinforce_delay = 20;
private _QS_module_classic_infReinforce_checkDelay = _QS_uiTime + _QS_module_classic_infReinforce_delay;
private _QS_module_classic_infReinforce_playerThreshold = 15;
private _QS_module_classic_infReinforce_cap = 0;
private _QS_module_classic_infReinforce_cap_0 = 24;
private _QS_module_classic_infReinforce_cap_1 = 34;
private _QS_module_classic_infReinforce_cap_2 = 42;
private _QS_module_classic_infReinforce_cap_3 = 50;
private _QS_module_classic_infReinforce_cap_4 = 60;
private _QS_module_classic_infReinforce_spawned = 0;
private _QS_module_classic_infReinforce_limit = 60;
private _QS_module_classic_infReinforce_limitReal = 0;
private _QS_module_classic_infReinforce_AIThreshold = 85;
private _QS_module_classic_infReinforce_array = [];
//comment 'classic ao veh reinforcements';
private _QS_module_classic_vehReinforce = _true;
private _QS_module_classic_vehReinforce_enabled = _true;
private _QS_module_classic_vehReinforce_delay = 300;
private _QS_module_classic_vehReinforce_checkDelay = _QS_uiTime + _QS_module_classic_vehReinforce_delay;
private _QS_module_classic_vehReinforce_playerThreshold = 15;
private _QS_module_classic_vehReinforce_cap = 0;
private _QS_module_classic_vehReinforce_cap_0 = 1;
private _QS_module_classic_vehReinforce_cap_1 = 1;
private _QS_module_classic_vehReinforce_cap_2 = 1;
private _QS_module_classic_vehReinforce_cap_3 = 1;
private _QS_module_classic_vehReinforce_cap_4 = 2;
private _QS_module_classic_vehReinforce_spawned = 0;
private _QS_module_classic_vehReinforce_limit = 2;
private _QS_module_classic_vehReinforce_limitReal = 0;
private _QS_module_classic_vehReinforce_AIThreshold = 75;
private _QS_module_classic_vehReinforce_array = [];
//comment 'classic ao fallback logic';
private _QS_module_classic_efb = _false;
private _QS_module_classic_efb_delay = 60;
private _QS_module_classic_efb_checkDelay = _QS_uiTime + _QS_module_classic_efb_delay;
private _QS_module_classic_efb_group = grpNull;
private _QS_module_classic_efb_threshold = 25;
//comment 'grid ao';
private _QS_module_grid = (missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isEqualTo 'GRID';
private _QS_module_grid_delay = 10;
private _QS_module_grid_checkDelay = _QS_uiTime + _QS_module_grid_delay;
private _QS_module_grid_aoPos = [0,0,0];
private _QS_module_grid_aoSize = -1;
private _QS_module_grid_aoData = [];
private _QS_module_grid_igPos = [0,0,0];
private _QS_module_grid_terrainData = [];
private _QS_module_grid_scriptCreateEnemy = scriptNull;
private _QS_module_grid_enemy = [];
private _QS_module_grid_enemy_X = [];
private _QS_module_grid_bldgPatrolRespawnThreshold = 0;
private _QS_module_grid_bldgPatrolUnits = [];
private _QS_module_grid_areaPatrolRespawnThreshold = 0;
private _QS_module_grid_areaPatrolUnits = [];
private _QS_module_grid_teamSize = 4;
private _QS_module_grid_spawnArray = [];
private _QS_module_grid_bldgPatrol_delay = 30;
private _QS_module_grid_bldgPatrol_checkDelay = _QS_uiTime + _QS_module_grid_bldgPatrol_delay;
private _QS_module_grid_areaPatrol_delay = 30;
private _QS_module_grid_areaPatrol_checkDelay = _QS_uiTime + _QS_module_grid_areaPatrol_delay;

private _QS_module_grid_defendUnits = [];
private _QS_module_grid_defendQty = 0;
private _QS_module_grid_defendQty_0 = 12;
private _QS_module_grid_defendQty_1 = 18;
private _QS_module_grid_defendQty_2 = 25;
private _QS_module_grid_defendQty_3 = 32;
private _QS_module_grid_defendQty_4 = 40;
private _QS_module_grid_defendQty_5 = 48;
private _QS_module_grid_defend_delay = 10;
private _QS_module_grid_defend_checkDelay = _QS_uiTime + _QS_module_grid_defend_delay;

private _QS_module_viperTeam = _true;
private _QS_module_viperTeam_delay = 15;
private _QS_module_viperTeam_checkDelay = _QS_uiTime + _QS_module_viperTeam_delay;
private _QS_module_viperTeam_respawnDelay = 300;	//300
private _QS_module_viperTeam_respawnCheckDelay = _QS_uiTime + _QS_module_viperTeam_respawnDelay;
private _QS_module_viperTeam_qty = 0;
private _QS_module_viperTeam_qty_0 = 4;
private _QS_module_viperTeam_qty_1 = 4;
private _QS_module_viperTeam_qty_2 = 6;
private _QS_module_viperTeam_qty_3 = 8;
private _QS_module_viperTeam_array = [];
private _QS_module_viperTeam_grp = grpNull;

private _QS_module_animalSpawnPosition = [0,0,0];
private _QS_module_civilian = _false;
private _QS_module_civilian_count = 0;
private _QS_module_civilian_count_0 = 0;
private _QS_module_civilian_count_1 = 4;
private _QS_module_civilian_count_2 = 7;
private _QS_module_civilian_count_3 = 10;
private _QS_module_civilian_count_4 = 13;
private _QS_module_civilian_count_5 = 16;
private _QS_module_civilian_count_6 = 20;
private _QS_module_civilian_houseCoef = 2;
private _QS_module_civilian_houseCount = 0;
//comment 'Manage ambient hostility';

private _QS_module_ambientHostility = _isDedicated && ((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) in ['CLASSIC','SC','GRID']);
private _QS_module_ambientHostility_delay = 30;
private _QS_module_ambientHostility_checkDelay = _QS_uiTime + _QS_module_ambientHostility_delay;
private _QS_module_ambientHostility_cooldown = -1;
private _QS_module_ambientHostility_graceTime = -1;
private _QS_module_ambientHostility_duration = 600;
private _QS_module_ambientHostility_target = objNull;
private _QS_module_ambientHostility_position = [0,0,0];
private _QS_module_ambientHostility_inProgress = _false;
private _QS_module_ambientHostility_entities = [];
private _QS_module_ambientHostility_validTargets = [];
private _QS_module_ambientHostility_nearbyCount = -1;

//Ambient non-combatants
private _QS_ambientCivilians = missionNamespace getVariable ['QS_missionConfig_AmbCiv',1] isNotEqualTo 0;
private _QS_ambientAnimals = missionNamespace getVariable ['QS_missionConfig_AmbAnim',1] isNotEqualTo 0;

//comment 'Manage enemy jets';
private _QS_module_enemyCAS = _isDedicated && (missionNamespace getVariable ['QS_missionConfig_enemyCAS',1]) isEqualTo 1;
private _QS_module_enemyCAS_delay = 15;
private _QS_module_enemyCAS_checkDelay = _QS_uiTime + _QS_module_enemyCAS_delay;
private _QS_module_enemyCAS_spawnDelay = 600;
private _QS_module_enemyCAS_spawnDelayDefault = 600;
private _QS_module_enemyCAS_checkSpawnDelay = _QS_uiTime + _QS_module_enemyCAS_spawnDelay;
private _QS_module_enemyCas_array = [];
private _QS_module_enemyCas_limit = 0;
private _QS_module_enemyCas_limitHigh = 2;
private _QS_module_enemyCas_limitLow = 1;
private _QS_module_enemyCas_plane = objNull;
private _playerJetCount = 0;
private _QS_module_enemyCas_allJetTypes = ['cas_plane'] call QS_data_listVehicles;
//comment 'Manage support providers';
private _QS_module_supportProvision = _true && _isDedicated;
private _QS_module_supportProvision_delay = 30;
private _QS_module_supportProvision_checkDelay = _QS_uiTime + _QS_module_supportProvision_delay;

//comment 'Manage custom scripts';
private _QS_module_scripts = _true && _isDedicated;
private _QS_module_scripts_delay = 15;
private _QS_module_scripts_checkDelay = _QS_uiTime + _QS_module_scripts_delay;

//===== Get list of MG weapons for AI system
private _cfgWeapons = ("(isclass _x) && ((getnumber (_x >> 'scope')) isEqualTo 2) && ((getText (_x >> 'cursor')) isEqualTo 'mg') && (((getnumber (_x >> 'type')) < 5) || ((getnumber (_x >> 'type')) isEqualTo 4096))") configClasses (configFile >> 'cfgWeapons');
_cfgWeapons = _cfgWeapons apply { toLowerANSI (configName _x) };
_cfgWeapons = _cfgWeapons arrayIntersect _cfgWeapons;
missionNamespace setVariable ['QS_AI_weapons_MG',_cfgWeapons,FALSE];
//===== Get list of GL weapons
_cfgWeapons = ("(isclass _x) && ((getnumber (_x >> 'scope')) isEqualTo 2) && (((getnumber (_x >> 'type')) < 5) || ((getnumber (_x >> 'type')) isEqualTo 4096))") configClasses (configFile >> 'cfgWeapons');
_cfgWeapons = _cfgWeapons apply { toLowerANSI (configName _x) };
_cfgWeapons = (_cfgWeapons arrayIntersect _cfgWeapons) select {['_GL_',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')};
missionNamespace setVariable ['QS_AI_weapons_GL',_cfgWeapons,FALSE];

//===== AI stuff
{
	missionNamespace setVariable _x;
} forEach [
	['QS_AI_managed_smoke_interval',0,FALSE],
	['QS_AI_managed_smoke_max',10,FALSE],
	['QS_AI_managed_smoke',[],FALSE],
	['QS_AI_managed_frags_interval',0,FALSE],
	['QS_AI_managed_frags_max',20,FALSE],
	['QS_AI_managed_frags',[],FALSE],
	['QS_AI_managed_suppressions',[],FALSE]
];

//comment 'Targets Knowledge script';
missionNamespace setVariable ['QS_AI_script_targetsKnowledge',([0,_east] spawn (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')),_false];

// Headless client
private _QS_module_hc = TRUE;
private _QS_module_hc_delay = 30;
private _QS_module_hc_checkDelay = time + _QS_module_hc_delay;
private _QS_module_hc_clientID = -1;
private _QS_module_hc_active = FALSE;
private _QS_module_hc_managedSides = [EAST,WEST,RESISTANCE,CIVILIAN];
private _QS_module_hc_grp = grpNull;
private _QS_module_hc_entity = objNull;
private _QS_module_hc_maxLoad = 80;
private _QS_module_hc_maxAgents = 20;
(missionNamespace getVariable ['QS_missionConfig_hcMaxLoad',[80,60,40,25]]) params [
	'_QS_module_hc_maxLoad_1','_QS_module_hc_maxLoad_2','_QS_module_hc_maxLoad_3','_QS_module_hc_maxLoad_4'
];
(missionNamespace getVariable ['QS_missionConfig_hcMaxAgents',[20,15,10,5]]) params [
	'_QS_module_hc_maxAgents_1','_QS_module_hc_maxAgents_2','_QS_module_hc_maxAgents_3','_QS_module_hc_maxAgents_4'
];
missionNamespace setVariable ['QS_module_hc_maxLoad',_QS_module_hc_maxLoad,TRUE];
missionNamespace setVariable ['QS_module_hc_maxAgents',_QS_module_hc_maxAgents,TRUE];
private _QS_module_hc_units = [];
private _QS_module_hc_ID = 0;
private _QS_module_hc_scriptTransfer = scriptNull;
private _QS_module_hc_groups_s0 = [];
private _QS_module_hc_groups_s1 = [];
private _QS_module_hc_groups_s2 = [];
private _QS_module_hc_groups_s3 = [];
private _QS_module_hc_count = 0;

private _QS_module_hc_agents_s0 = [];
private _QS_module_hc_agents_s1 = [];
private _QS_module_hc_agents_s2 = [];
private _QS_module_hc_agents_s3 = [];

private _QS_module_hc_agents = [];

private _QS_module_hc_log_delay = 60;
private _QS_module_hc_log_checkDelay = time + _QS_module_hc_delay;

private _clientOwner = clientOwner;
private _setNewOwner = FALSE;
private _exit = FALSE;

private _grp = grpNull;
private _unit = objNull;
private _grpData = [];
private _unitData = [];
private _unitsData = [];
private _unitSkills = [];
private _unitAIFeatures = [];

if (_isHC) then {
	disableRemoteSensors FALSE;
	calculatePlayerVisibilityByFriendly TRUE;
	// SYNC existing group vars to HC
	[98] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
_groupEventHandlerTypes = ['CombatModeChanged','CommandChanged','FormationChanged','SpeedModeChanged','EnableAttackChanged','LeaderChanged','GroupIdChanged','KnowsAboutChanged','WaypointComplete','Fleeing','EnemyDetected'];
_groupEventLocalHC = {
	params ['_grp','_isLocal'];
	if (_isLocal) then {
		_grp removeEventHandler [_thisEvent,_thisEventHandler];
		_grp setVariable ['QS_AI_GRP_SETUP',FALSE,FALSE];
		_grp setVariable ['QS_AI_GRP_HC',[4,clientOwner],QS_system_AI_owners];
		private _data = [];
		private _unit = objNull;
		private _unitData = [];
		private _unitSkills = [];
		private _unitAI = [];
		{
			_data = _x;
			if (_forEachIndex isEqualTo 0) then {
				_grp setBehaviour (['CARELESS','SAFE','AWARE','COMBAT','STEALTH','AWARE'] # _data);
			};
			if (_forEachIndex isEqualTo 1) then {
				_grp setCombatMode (['BLUE','GREEN','WHITE','YELLOW','RED'] # _data);
			};
			if (_forEachIndex isEqualTo 2) then {
				_grp enableAttack (_data isEqualTo 1);
			};
			if (_forEachIndex isEqualTo 3) then {
				{
					_unitData = _x;
					_unitData params ['_unit','_unitSkill','_unitSkills','_unitAI','_unitPos','_unitAnimCoef','_unitStamina'];
					if (alive _unit) then {
						_unit setVariable ['QS_AI_UNIT',FALSE,FALSE];
						_unit setSkill _unitSkill;
						{
							_unit setSkill [QS_data_AISkills # _forEachIndex,_x];
						} forEach _unitSkills;
						{
							_unit enableAIFeature [QS_data_AIFeatures # _forEachIndex,_x isEqualTo 1];
						} forEach _unitAI;
						if (_unitPos isNotEqualTo -1) then {
							_unit setUnitPos (['Down','Up','Middle','Auto'] # _unitPos);
						};
						_unit setAnimSpeedCoef _unitAnimCoef;
						_unit enableStamina (_unitStamina isEqualTo 1);
						_unit enableFatigue (_unitStamina isEqualTo 1);
					};
				} forEach _data;
			};
		} forEach (_grp getVariable ['QS_AI_GRP_HC_data',[]]);
		_grp allowFleeing 0;
		_grp spawn {
			sleep 3;
			{
				if (alive _x) then {
					_x setUnitLoadout (getUnitLoadout _x);
				};
			} forEach (units _this);
		};
	};
};
_agentEventLocalHC = {
	params ['_agent','_isLocal'];
	if (_isLocal) then {
		_agent removeEventHandler [_thisEvent,_thisEventHandler];
		_agent setVariable ['QS_AI_ENTITY_HC',[4,clientOwner],QS_system_AI_owners];
	};
};
_groupEventLocalServer = {
	params ['_grp','_isLocal'];
	if (_isLocal) then {
		{
			_x setVariable ['QS_AI_UNIT',FALSE,FALSE];
		} forEach (units _grp);
		_grp setVariable ['QS_AI_GRP_SETUP',FALSE,FALSE];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	};
};
_agentEventLocalServer = {
	params ['_agent','_isLocal'];
	if (_isLocal) then {
		_agent setVariable ['QS_AI_ENTITY_HC',[0,-1],QS_system_AI_owners];
	};
};
QS_data_AISkills = [
	'general',
	'courage',
	'aimingAccuracy',
	'aimingShake',
	'aimingSpeed',
	'commanding',
	'endurance',
	'spotDistance',
	'spotTime',
	'reloadSpeed'
];
QS_data_AIFeatures = [
	//'ALL',
	'AIMINGERROR',
	'ANIM',
	'AUTOCOMBAT',
	'AUTOTARGET',
	'CHECKVISIBLE',
	'COVER',
	'FSM',
	'LIGHTS',
	'MINEDETECTION',
	'MOVE',
	'NVG',
	'PATH',
	'RADIOPROTOCOL',
	'SUPPRESSION',
	'TARGET',
	'TEAMSWITCH',
	'WEAPONAIM'
];
private _text = '';
private _QS_serverTime = serverTime;

//comment 'Preload Functions';
_fn_aoGetTerrainData = missionNamespace getVariable 'QS_fnc_aoGetTerrainData';
_fn_serverDetector = missionNamespace getVariable 'QS_fnc_serverDetector';
_fn_AIHandleGroup = missionNamespace getVariable 'QS_fnc_AIHandleGroup';
_fn_AIHandleUnit = missionNamespace getVariable 'QS_fnc_AIHandleUnit';
_fn_AIHandleAgent = missionNamespace getVariable 'QS_fnc_AIHandleAgent';
_fn_scEnemy = missionNamespace getVariable 'QS_fnc_scEnemy';
_fn_scGetNearestSector = missionNamespace getVariable 'QS_fnc_scGetNearestSector';
_fn_scSpawnGroup = missionNamespace getVariable 'QS_fnc_scSpawnGroup';
_fn_scSpawnLandVehicle = missionNamespace getVariable 'QS_fnc_scSpawnLandVehicle';
_fn_scSpawnHeli = missionNamespace getVariable 'QS_fnc_scSpawnHeli';
_fn_scSpawnUAV = missionNamespace getVariable 'QS_fnc_scSpawnUAV';
_fn_aoEnemy = missionNamespace getVariable 'QS_fnc_aoEnemy';
_fn_aoEnemyReinforce = missionNamespace getVariable 'QS_fnc_aoEnemyReinforce';
_fn_aoEnemyReinforceVehicles = missionNamespace getVariable 'QS_fnc_aoEnemyReinforceVehicles';
_fn_enemyCAS = missionNamespace getVariable 'QS_fnc_enemyCAS';
_fn_gridEnemy = missionNamespace getVariable 'QS_fnc_gridEnemy';
_fn_gridSpawnPatrol = missionNamespace getVariable 'QS_fnc_gridSpawnPatrol';
_fn_gridSpawnAttack = missionNamespace getVariable 'QS_fnc_gridSpawnAttack';
_fn_findRandomPos = missionNamespace getVariable 'QS_fnc_findRandomPos';
_fn_spawnAmbientCivilians = missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians';
_fn_aoAnimals = missionNamespace getVariable 'QS_fnc_aoAnimals';
_fn_spawnViperTeam = missionNamespace getVariable 'QS_fnc_spawnViperTeam';
_fn_serverObjectsRecycler = missionNamespace getVariable 'QS_fnc_serverObjectsRecycler';
_fn_aiGetKnownEnemies = missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies';
_fn_ambientHostility = missionNamespace getVariable 'QS_fnc_ambientHostility';
_fn_aiOwners = missionNamespace getVariable 'QS_fnc_AIOwners';
_fn_waterInRadius = missionNamespace getVariable 'QS_fnc_waterInRadius';
_fn_aoUrbanSpawn = missionNamespace getVariable 'QS_fnc_aoUrbanSpawn';

//comment 'Loop';
for '_x' from 0 to 1 step 0 do {
	uiSleep (random [2.5,3,3.5]);
	_QS_uiTime = diag_tickTime;
	_QS_time = time;
	_QS_serverTime = serverTime;
	/*/Get general data/*/
	if (_QS_uiTime > _QS_updateGeneralInfoCheckDelay) then {
		_QS_diag_fps = round diag_fps;
		_QS_allPlayers = allPlayers;
		_QS_allPlayersCount = count _QS_allPlayers;
		_QS_allGroups = allGroups;
		_QS_allGroupsCount = count _QS_allGroups;
		_QS_allUnits = allUnits;
		_QS_allUnitsCount = count _QS_allUnits;
		_QS_allAgents = (agents apply {(agent _x)}) select {(!isNull _x)};
		_QS_allAgentsCount = count _QS_allAgents;
		_QS_module_groupBehaviors_localGroups = _QS_allGroups select {(local _x)};
		_QS_module_unitBehaviors_localUnits = _QS_allUnits select {(local _x)};
		_QS_module_agentBehaviors_localAgents = _QS_allAgents select {(local _x)};
		_QS_updateGeneralInfoCheckDelay = _QS_uiTime + _QS_updateGeneralInfoDelay;
		if (_isDedicated && (missionNamespace getVariable ['QS_HC_Active',_false])) then {
			missionNamespace setVariable ['QS_system_AI_owners',call _fn_aiOwners,call _fn_aiOwners];
		};
	};
	//======================= Headless Client
	
	if (
		_QS_module_hc &&
		{(missionNamespace getVariable ['QS_HC_Active',_false])}
	) then {
		if (_isDedicated) then {
			// SERVER
			_QS_headlessClients = missionNamespace getVariable ['QS_headlessClients',[]];
			if (_QS_headlessClients isNotEqualTo []) then {
				//===== Distribution re-calc
				_QS_module_hc_count = count _QS_headlessClients;
				if (_QS_module_hc_count isEqualTo 1) then {
					if (QS_module_hc_maxLoad isNotEqualTo _QS_module_hc_maxLoad_1) then {
						QS_module_hc_maxLoad = _QS_module_hc_maxLoad_1;
					};
					if (QS_module_hc_maxAgents isNotEqualTo _QS_module_hc_maxAgents_1) then {
						QS_module_hc_maxAgents = _QS_module_hc_maxAgents_1;
					};
				} else {
					if (_QS_module_hc_count isEqualTo 2) then {
						if (QS_module_hc_maxLoad isNotEqualTo _QS_module_hc_maxLoad_2) then {
							QS_module_hc_maxLoad = _QS_module_hc_maxLoad_2;
						};
						if (QS_module_hc_maxAgents isNotEqualTo _QS_module_hc_maxAgents_2) then {
							QS_module_hc_maxAgents = _QS_module_hc_maxAgents_2;
						};
					};
					if (_QS_module_hc_count isEqualTo 3) then {
						if (QS_module_hc_maxLoad isNotEqualTo _QS_module_hc_maxLoad_3) then {
							QS_module_hc_maxLoad = _QS_module_hc_maxLoad_3;
						};
						if (QS_module_hc_maxAgents isNotEqualTo _QS_module_hc_maxAgents_3) then {
							QS_module_hc_maxAgents = _QS_module_hc_maxAgents_3;
						};
					};
					if (_QS_module_hc_count >= 4) then {
						if (QS_module_hc_maxLoad isNotEqualTo _QS_module_hc_maxLoad_4) then {
							QS_module_hc_maxLoad = _QS_module_hc_maxLoad_4;
						};
						if (QS_module_hc_maxAgents isNotEqualTo _QS_module_hc_maxAgents_4) then {
							QS_module_hc_maxAgents = _QS_module_hc_maxAgents_4;
						};
					};
					//===== HC Prioritization
					_QS_headlessClients = _QS_headlessClients apply {
						_QS_module_hc_ID = _x; 
						[
							count (_QS_allUnits select {(owner _x) isEqualTo _QS_module_hc_ID}),
							_QS_module_hc_ID
						]
					};
					_QS_headlessClients sort _true;
					_QS_headlessClients = _QS_headlessClients apply { _x # 1 };
				};
				{
					_exit = _false;
					_QS_module_hc_ID = _x;
					
					// Grouped Units
					_QS_module_hc_units = _QS_allUnits select {(owner _x) isEqualTo _QS_module_hc_ID};
					if ((count _QS_module_hc_units) < QS_module_hc_maxLoad) then {
						//======================= STEP 2 - 3
						_QS_module_hc_groups_s2 = _QS_module_groupBehaviors_localGroups select {
							(((_x getVariable ['QS_AI_GRP_HC',[-1,2]]) # 0) isEqualTo 2) &&
							(((_x getVariable ['QS_AI_GRP_HC',[-1,2]]) # 1) isEqualTo _QS_module_hc_ID)
						};
						if (_QS_module_hc_groups_s2 isNotEqualTo []) then {
							_exit = _true;
							_grp = selectRandom _QS_module_hc_groups_s2;
							_grp setVariable ['QS_AI_GRP_HC',[3,_QS_module_hc_ID],[2,_QS_module_hc_ID]];
							{
								_x removeAllEventHandlers 'FiredMan';
								_x removeAllEventHandlers 'Hit';
								_x removeAllEventHandlers 'Suppressed';
							} forEach (units _grp);
							{
								if (((_grp getEventHandlerInfo [_x,0]) # 2) isNotEqualTo 0) then {
									_grp removeAllEventHandlers _x;
								};
							} forEach _groupEventHandlerTypes;
							_grp addEventHandler ['Local',_groupEventLocalServer];
							if (!(_grp setGroupOwner _QS_module_hc_ID)) then {
								//===== Ownership transfer failed, reset to beginning of process
								_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
							};
						};
						if (_exit) exitWith {};

						//======================= STEP 0 - 1
						_QS_module_hc_groups_s0 = _QS_module_groupBehaviors_localGroups select {
							(((_x getVariable ['QS_AI_GRP_HC',[-1,2]]) # 0) isEqualTo 0)
							// check alive/count state incase group has been killed off
						};
						if (_QS_module_hc_groups_s0 isNotEqualTo []) then {
							_exit = _true;
							_grp = selectRandom _QS_module_hc_groups_s0;
							// Build group/unit data for network sync, convert string to number for network traffic reduction
							_grpData = [
								(['CARELESS','SAFE','AWARE','COMBAT','STEALTH','ERROR'] find (behaviour (leader _grp))),
								['BLUE','GREEN','WHITE','YELLOW','RED'] find (combatMode _grp),
								[0,1] select (attackEnabled _grp)
							];
							_unitsData = [];
							{
								_unit = _x;
								_unitData = [];
								_unitSkills = [];
								_unitAIFeatures = [];
								_unitData pushBack _unit;
								_unitData pushBack (skill _unit);
								{
									_unitSkills pushBack (_unit skillFinal _x);
								} forEach QS_data_AISkills;
								_unitData pushBack _unitSkills;
								{
									_unitAIFeatures pushBack ([0,1] select (_unit checkAIFeature _x));
								} forEach QS_data_AIFeatures;
								_unitData pushBack _unitAIFeatures;
								_unitData pushBack (['Down','Up','Middle','Auto'] find (unitPos _unit));
								_unitData pushBack (getAnimSpeedCoef _unit);
								_unitData pushBack ([0,1] select (isStaminaEnabled _unit));
								_unitsData pushBack _unitData;
							} forEach (units _grp);
							_grpData pushBack _unitsData;
							{
								_grp setVariable [_x,_grp getVariable _x,[2,_QS_module_hc_ID]];
							} forEach (allVariables _grp);
							_grp setVariable ['QS_AI_GRP_HC_data',_grpData,[2,_QS_module_hc_ID]];
							_grp setVariable ['QS_AI_GRP_HC',[1,_QS_module_hc_ID],[2,_QS_module_hc_ID]];
						};
						if (_exit) exitWith {};
					};
					//===== Agents
					_QS_module_hc_agents = _QS_allAgents select { (owner _x) isEqualTo _QS_module_hc_ID };
					if ((count _QS_module_hc_agents) < QS_module_hc_maxAgents) then {
						//======================= STEP 2 - 3
						_QS_module_hc_agents_s2 = _QS_module_agentBehaviors_localAgents select {
							(alive _x) &&
							{(((_x getVariable ['QS_AI_ENTITY_HC',[-1,2]]) # 0) isEqualTo 2)} &&
							{(((_x getVariable ['QS_AI_ENTITY_HC',[-1,2]]) # 1) isEqualTo _QS_module_hc_ID)}
						};
						if (_QS_module_hc_agents_s2 isNotEqualTo []) then {
							_exit = _true;
							_QS_module_agentBehaviors_agent = selectRandom _QS_module_hc_agents_s2;
							_QS_module_agentBehaviors_agent setVariable ['QS_AI_ENTITY_HC',[3,_QS_module_hc_ID],[2,_QS_module_hc_ID]];
							_QS_module_agentBehaviors_agent addEventHandler ['Local',_agentEventLocalServer];
							if (!(_QS_module_agentBehaviors_agent setOwner _QS_module_hc_ID)) then {
								//===== Ownership transfer failed, reset to beginning of process
								_QS_module_agentBehaviors_agent setVariable ['QS_AI_ENTITY_HC',[0,-1],QS_system_AI_owners];
							};
						};
						if (_exit) exitWith {};

						//======================= STEP 0 - 1
						_QS_module_hc_agents_s0 = _QS_module_agentBehaviors_localAgents select {
							(((_x getVariable ['QS_AI_ENTITY_HC',[-1,2]]) # 0) isEqualTo 0)
						};
						if (_QS_module_hc_agents_s0 isNotEqualTo []) then {
							_exit = _true;
							_QS_module_agentBehaviors_agent = selectRandom _QS_module_hc_agents_s0;
							{
								_QS_module_agentBehaviors_agent setVariable [_x,_QS_module_agentBehaviors_agent getVariable _x,[2,_QS_module_hc_ID]];
							} forEach (allVariables _QS_module_agentBehaviors_agent);
							_QS_module_agentBehaviors_agent setVariable ['BIS_fnc_animalBehaviour_disable',_true,[2,_QS_module_hc_ID]];
							_QS_module_agentBehaviors_agent setVariable ['QS_AI_ENTITY_HC',[1,_QS_module_hc_ID],[2,_QS_module_hc_ID]];
						};	
					};
				} forEach _QS_headlessClients;
			};
			if (_QS_time > _QS_module_hc_log_checkDelay) then {
				diag_log (format ['HC AI Report (Server): %1Local units: %2 * %1Local groups: %3 * %1Local agents: %4',_endl,(count _QS_module_unitBehaviors_localUnits),(count _QS_module_groupBehaviors_localGroups),(count _QS_module_agentBehaviors_localAgents)]);
				{
					diag_log format ['Headless Client Info: %1',getUserInfo (getPlayerID _x)];
				} forEach (entities 'HeadlessClient_F');
				_QS_module_hc_log_checkDelay = _QS_time + _QS_module_hc_log_delay;
			};
		} else {
			// HC
			//======================= STEP 1 - 2
			_QS_module_hc_groups_s1 = _QS_allGroups select {
				(((_x getVariable ['QS_AI_GRP_HC',[-1,2]]) # 0) isEqualTo 1) &&
				{(((_x getVariable ['QS_AI_GRP_HC',[-1,-1]]) # 1) isEqualTo _clientOwner)}
			};
			if (_QS_module_hc_groups_s1 isNotEqualTo []) then {
				_grp = selectRandom _QS_module_hc_groups_s1;
				
				if (_grp isNil 'QS_AI_GRP_HC_data') exitWith {
					_grp setVariable ['QS_AI_GRP_HC',[0,_clientOwner],[2,_clientOwner]];
				};
				_grp addEventHandler ['Local',_groupEventLocalHC];
				_grp setVariable ['QS_AI_GRP_HC',[2,_clientOwner],[2,_clientOwner]];
			};
			
			_QS_module_hc_agents_s1 = _QS_allAgents select {
				(((_x getVariable ['QS_AI_ENTITY_HC',[-1,2]]) # 0) isEqualTo 1) &&
				{(((_x getVariable ['QS_AI_ENTITY_HC',[-1,-1]]) # 1) isEqualTo _clientOwner)}
			};
			if (_QS_module_hc_agents_s1 isNotEqualTo []) then {
				_QS_module_agentBehaviors_agent = selectRandom _QS_module_hc_agents_s1;
				_QS_module_agentBehaviors_agent addEventHandler ['Local',_agentEventLocalHC];
				_QS_module_agentBehaviors_agent setVariable ['QS_AI_ENTITY_HC',[2,_clientOwner],[2,_clientOwner]];
			};
			diag_log (format ['HC AI Report (Headless Client): %1Local units: %2 * %1Local groups: %3 * %1Local agents: %4',_endl,(count _QS_module_unitBehaviors_localUnits),(count _QS_module_groupBehaviors_localGroups),(count _QS_module_agentBehaviors_localAgents)]);
		};
	};
	if (_QS_module_dynamicSkill) then {
		if (_QS_uiTime > _QS_module_dynamicSkill_checkDelay) then {
			_QS_module_dynamicSkill_checkDelay = _QS_uiTime + _QS_module_dynamicSkill_delay;
		};
	};
	if (_QS_module_groupBehaviors) then {
		if (_QS_uiTime > _QS_module_groupBehaviors_checkDelay) then {
			{
				_QS_module_groupBehaviors_group = _x;
				if (_QS_module_groupBehaviors_group getVariable ['QS_AI_GRP',_false]) then {
					_scriptEvalGrp = [_QS_module_groupBehaviors_group,_QS_serverTime,_QS_diag_fps] spawn _fn_AIHandleGroup;
					waitUntil {scriptDone _scriptEvalGrp};
				};
			} forEach _QS_module_groupBehaviors_localGroups;
			_QS_module_groupBehaviors_checkDelay = diag_tickTime + _QS_module_groupBehaviors_delay;
		};
	};
	if (_QS_module_unitBehaviors) then {
		if (_QS_uiTime > _QS_module_unitBehaviors_checkDelay) then {
			{
				_QS_module_unitBehaviors_unit = _x;
				if (_QS_module_unitBehaviors_unit getVariable ['QS_AI_UNIT_enabled',_false]) then {
					if (((random 1) > 0.333) || {(_QS_module_unitBehaviors_unit isEqualTo (leader (group _QS_module_unitBehaviors_unit)))}) then {
						_scriptEvalUnit = [_QS_module_unitBehaviors_unit,_QS_serverTime,_QS_diag_fps,_QS_allPlayersCount] spawn _fn_AIHandleUnit;
						waitUntil {scriptDone _scriptEvalUnit};
					};
				};
			} forEach _QS_module_unitBehaviors_localUnits;
			_QS_module_unitBehaviors_checkDelay = diag_tickTime + _QS_module_unitBehaviors_delay;
		};
	};
	if (_QS_module_agentBehaviors) then {
		if (_QS_uiTime > _QS_module_agentBehaviors_checkDelay) then {
			{
				_QS_module_agentBehaviors_agent = _x;
				if (_QS_module_agentBehaviors_agent getVariable ['QS_AI_ENTITY',_false]) then {
					if (((random 1) > 0.75) || {(_QS_module_agentBehaviors_agent getEntityInfo 0)}) then {
						_scriptEvalAgent = [_QS_module_agentBehaviors_agent,_QS_serverTime,_QS_diag_fps] spawn _fn_AIHandleAgent;
						waitUntil {scriptDone _scriptEvalAgent};
					};
				};
			} forEach _QS_module_agentBehaviors_localAgents;
			_QS_module_agentBehaviors_checkDelay = diag_tickTime + _QS_module_agentBehaviors_delay;
		};
	};	
	/*/Module virtual sectors/*/
	if (_QS_module_virtualSectors) then {
		if (_QS_uiTime > _QS_module_virtualSectors_checkDelay) then {
			if (missionNamespace getVariable 'QS_virtualSectors_AI_triggerInit') then {
				missionNamespace setVariable ['QS_virtualSectors_AI_triggerInit',_false,_false];
				_QS_module_virtualSectors_aoPos = missionNamespace getVariable 'QS_AOpos';
				_QS_module_virtualSectors_aoSize = missionNamespace getVariable 'QS_aoSize';
				_QS_module_virtualSectors_vehiclesEnabled = _false;
				if ((count(((_QS_module_virtualSectors_aoPos select [0,2]) nearRoads _QS_module_virtualSectors_aoSize) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))})) > 50) then {
					_QS_module_virtualSectors_vehiclesEnabled = _true;
				};
				_QS_module_virtualSectors_scriptCreateEnemy = [_QS_module_virtualSectors_vehiclesEnabled] spawn _fn_scEnemy;
				waitUntil {scriptDone _QS_module_virtualSectors_scriptCreateEnemy};
				uiSleep 0.1;
				_QS_module_virtualSectors_enemy_0 = missionNamespace getVariable 'QS_virtualSectors_enemy_0';
				_QS_module_virtualSectors_enemy_1 = missionNamespace getVariable 'QS_virtualSectors_enemy_1';
				_QS_module_virtualSectors_patrolsHeli = _QS_module_virtualSectors_enemy_1 # 0;
				_QS_module_virtualSectors_patrolsInf = _QS_module_virtualSectors_enemy_1 # 1;
				_QS_module_virtualSectors_patrolsVeh = _QS_module_virtualSectors_enemy_1 # 2;
				_QS_module_virtualSectors_patrolsGarrison = _QS_module_virtualSectors_enemy_1 # 3;
				_QS_module_virtualSectors_patrolsBoat = _QS_module_virtualSectors_enemy_1 # 4;
				_QS_module_virtualSectors_patrolsSniper = _QS_module_virtualSectors_enemy_1 # 5;
				_QS_module_virtualSectors_patrolsInf_thresh = round ((count _QS_module_virtualSectors_patrolsInf) / 2);
				_QS_module_virtualSectors_patrolsVeh_thresh = round ((count _QS_module_virtualSectors_patrolsVeh) / 2);
				_QS_module_virtualSectors_patrolsSniper_thresh = round ((count _QS_module_virtualSectors_patrolsSniper) / 2);
				missionNamespace setVariable ['QS_virtualSectors_enemy_0',[],_false];
				missionNamespace setVariable ['QS_virtualSectors_enemy_1',[],_false];
				_QS_module_tracers_checkOverride = _true;
				if (_QS_module_virtualSectors_assaultEnabled) then {
					if ((random 1) >= _QS_module_virtualSectors_assaultChance) then {
						_QS_module_virtualSectors_assaultReady = _true;
						_QS_module_virtualSectors_assaultScore = random [0.5,0.666,0.8];
						_QS_module_virtualSectors_assaultDuration = _QS_module_virtualSectors_assaultDuration_fixed + (random _QS_module_virtualSectors_assaultDuration_variable);
					};
				};
			};
			if (missionNamespace getVariable 'QS_virtualSectors_active') then {
				//comment 'General sectors info';
				if (_QS_allPlayersCount < 10) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_0;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_0;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_0;
					_QS_module_virtualSectors_patrolsInf_thresh = round (16 / 2);
				};
				if (_QS_allPlayersCount >= 10) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_1;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_1;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_1;
					_QS_module_virtualSectors_patrolsInf_thresh = round (24 / 2);
				};
				if (_QS_allPlayersCount >= 20) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_2;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_2;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_2;
					_QS_module_virtualSectors_patrolsInf_thresh = round (32 / 2);
				};
				if (_QS_allPlayersCount >= 30) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_3;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_3;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_3;
					_QS_module_virtualSectors_patrolsInf_thresh = round (40 / 2);
				};
				if (_QS_allPlayersCount >= 40) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_4;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_4;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_4;
					_QS_module_virtualSectors_patrolsInf_thresh = round (48 / 2);
				};
				if (_QS_allPlayersCount >= 50) then {
					_QS_module_virtualSectors_maxAI = _QS_module_virtualSectors_maxAI_5;
					_QS_module_virtualSectors_maxAISector = _QS_module_virtualSectors_maxAISector_5;
					_QS_module_virtualSectors_maxAIX = _QS_module_virtualSectors_maxAIX_5;
					_QS_module_virtualSectors_patrolsInf_thresh = round (56 / 2);
				};
				//comment 'Manage assault';
				_QS_module_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
				_QS_module_virtualSectors_resultsFactors = missionNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]];
				if (_QS_module_virtualSectors_assaultEnabled) then {
					if (_QS_module_virtualSectors_assaultReady) then {
						if (!(_QS_module_virtualSectors_assaultActive)) then {
							//comment 'Assault not active';
							if ((_QS_module_virtualSectors_scoreSides # 1) >= _QS_module_virtualSectors_assaultScore) then {
								_QS_module_virtualSectors_assaultActive = _true;
								diag_log '***** QS AI - Sector Assault Active *****';
								
								//comment 'Select sector herePick random WEST-owned sector';
								_QS_module_virtualSectors_assaultDuration = _QS_uiTime + _QS_module_virtualSectors_assaultDuration_fixed + (random _QS_module_virtualSectors_assaultDuration_variable);
							};
						} else {
							//comment 'Assault active';
							if (_QS_diag_tickTimeNow > _QS_module_virtualSectors_assaultDuration) then {
								//comment 'Assault terminated';
							} else {
								//comment 'Assault active';
							};
						};
					};
				};
				//comment 'Manage general area patrols';
				_QS_module_virtualSectors_patrolsInf = _QS_module_virtualSectors_patrolsInf select {(alive _x)};
				if (!(_QS_module_virtualSectors_patrolFallback)) then {
					if ((_QS_module_virtualSectors_scoreSides # 1) >= _QS_module_virtualSectors_scoreEndClose) then {
						_QS_module_virtualSectors_patrolFallback = _true;
						diag_log '***** QS AI - Patrol Fall Back *****';
						if (_QS_module_virtualSectors_patrolsInf isNotEqualTo []) then {
							{
								_QS_grp = group _x;
								if (!isNull _QS_grp) then {
									{
										_QS_unit = _x;
										{
											_QS_unit forgetTarget _x;
											_QS_grp forgetTarget _x;
										} forEach (_QS_unit targets [_true,0]);
										{
											_QS_unit enableAIFeature [_x # 0,_x # 1];
										} forEach [
											//['AUTOCOMBAT',_false],
											['COVER',_false],
											['SUPPRESSION',_false],
											['PATH',_true]
										];
										_QS_unit forceSpeed 24;
										_QS_unit setAnimSpeedCoef 1.15;
										_QS_unit enableStamina _false;
										_QS_unit enableFatigue _false;
									} count (units _QS_grp);
									{
										_movePos = [_x,(getPosATL (leader _QS_grp)),(side _QS_grp)] call _fn_scGetNearestSector;
										if (_movePos isNotEqualTo []) exitWith {};
									} forEach [2,3];
									if (_movePos isNotEqualTo []) then {
										_QS_grp setVariable [
											'QS_AI_GRP_CONFIG',
											[
												'SC',
												((_QS_grp getVariable ['QS_AI_GRP_CONFIG',['','','']]) # 1),
												((_QS_grp getVariable ['QS_AI_GRP_CONFIG',['','','']]) # 2)
											],
											_false
										];
										_QS_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_movePos,_QS_serverTime,-1],_false];
									};
								};
							} forEach _QS_module_virtualSectors_patrolsInf;
						};
					};
					_QS_module_virtualSectors_countAIInfPatrols = count _QS_module_virtualSectors_patrolsInf;
					if (_QS_module_virtualSectors_countAIInfPatrols < (_QS_module_virtualSectors_patrolsInf_thresh - 4)) then {
						if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
							//comment 'Spawn more radial inf patrols';
							_QS_module_virtualSectors_spawnedGrp = [-2,_QS_module_virtualSectors_countAIInfPatrols,_QS_module_virtualSectors_patrolsInf_thresh] call _fn_scSpawnGroup;
							if (_QS_module_virtualSectors_spawnedGrp isNotEqualTo []) then {
								{
									_QS_module_virtualSectors_patrolsInf pushBack _x;
								} forEach (units _QS_module_virtualSectors_spawnedGrp);
								_QS_module_virtualSectors_enemy_1 set [1,_QS_module_virtualSectors_patrolsInf];
							};
						};
					};
				};
				//comment 'Manage vehicle patrols';
				if (_QS_module_virtualSectors_vehiclesEnabled) then {
					if (missionNamespace getVariable 'QS_virtualSectors_sub_2_active') then {
						if (_QS_uiTime > _QS_module_virtualSectors_patrolsVeh_checkDelay) then {
							_QS_module_virtualSectors_patrolsVeh = _QS_module_virtualSectors_patrolsVeh select {(alive _x)};
							if (({((_x isKindOf 'LandVehicle') && (!(_x isKindOf 'StaticWeapon')))} count _QS_module_virtualSectors_patrolsVeh) < 2) then {
								if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
									_QS_module_virtualSectors_spawnedGrp = [0] call _fn_scSpawnLandVehicle;
									if (_QS_module_virtualSectors_spawnedGrp isNotEqualTo []) then {
										{
											_QS_module_virtualSectors_patrolsVeh pushBack _x;
										} forEach _QS_module_virtualSectors_spawnedGrp;
										_QS_module_virtualSectors_enemy_1 set [2,_QS_module_virtualSectors_patrolsVeh];
									};
								};
							};
							_QS_module_virtualSectors_patrolsVeh_checkDelay = _QS_uiTime + _QS_module_virtualSectors_patrolsVeh_delay;
						};
					};
				};
				//comment 'Manage heli patrols';
				if (_QS_diag_fps > 10) then {
					if (_QS_module_virtualSectors_heliEnabled) then {
						if (missionNamespace getVariable 'QS_virtualSectors_sub_2_active') then {
							if (_QS_uiTime > _QS_module_virtualSectors_patrolsHeli_checkDelay) then {
								_QS_module_virtualSectors_patrolsHeli = _QS_module_virtualSectors_patrolsHeli select {(alive _x)};
								if ((_QS_module_virtualSectors_patrolsHeli findIf {(_x isKindOf 'Helicopter')}) isEqualTo -1) then {
									if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
										_QS_module_virtualSectors_spawnedGrp = [0] call _fn_scSpawnHeli;
										if (_QS_module_virtualSectors_spawnedGrp isNotEqualTo []) then {
											{
												_QS_module_virtualSectors_patrolsHeli pushBack _x;
											} forEach _QS_module_virtualSectors_spawnedGrp;
											_QS_module_virtualSectors_enemy_1 set [0,_QS_module_virtualSectors_patrolsHeli];
										};
									};
								};
								_QS_module_virtualSectors_patrolsHeli_checkDelay = _QS_uiTime + (_QS_module_virtualSectors_patrolsHeli_delay + (random 120));
							};
						};
					};
					//comment 'Manage UAV patrol';
					if (_QS_module_virtualSectors_uavEnabled) then {
						if (missionNamespace getVariable 'QS_virtualSectors_sub_1_active') then {
							if (_QS_uiTime > _QS_module_virtualSectors_uav_checkDelay) then {
								_QS_module_virtualSectors_uavs = _QS_module_virtualSectors_uavs select {(alive _x)};
								if ((_QS_module_virtualSectors_uavs findIf {(unitIsUav _x)}) isEqualTo -1) then {
									_QS_module_virtualSectors_spawnedGrp = [] call _fn_scSpawnUAV;
									if (_QS_module_virtualSectors_spawnedGrp isNotEqualTo []) then {
										{
											_QS_module_virtualSectors_uavs pushBack _x;
										} forEach _QS_module_virtualSectors_spawnedGrp;
									};
								};
								_QS_module_virtualSectors_uav_checkDelay = _QS_uiTime + _QS_module_virtualSectors_uav_delay;
							};
						};
					};
					if (_QS_module_viperTeam) then {
						if (_QS_uiTime > _QS_module_viperTeam_checkDelay) then {
							if (_QS_uiTime > _QS_module_viperTeam_respawnCheckDelay) then {
								_QS_module_viperTeam_array = _QS_module_viperTeam_array select {(alive _x)};
								if (_QS_allPlayersCount > 10) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_1;} else {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_0;};
								if (_QS_allPlayersCount > 20) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_1;};
								if (_QS_allPlayersCount > 30) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_2;};
								if (_QS_allPlayersCount > 40) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_2;};
								if (_QS_allPlayersCount > 50) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_3;};
								if (
									(_QS_allPlayersCount > 10) &&
									{((count _QS_module_viperTeam_array) < ((round (_QS_module_viperTeam_qty / 2)) max 0))}
								) then {
									_array = ['SC',(count _QS_module_viperTeam_array),_QS_module_viperTeam_qty,_QS_module_viperTeam_grp] call _fn_spawnViperTeam;
									{
										_QS_module_viperTeam_grp = group _x;
										_QS_module_viperTeam_array pushBack _x;
									} forEach _array;
									_QS_module_viperTeam_respawnCheckDelay = _QS_uiTime + _QS_module_viperTeam_respawnDelay;
								};
							};
							_QS_module_viperTeam_checkDelay = _QS_uiTime + _QS_module_viperTeam_delay;
						};
					};
				};
				if (_QS_uiTime > _QS_module_virtualSectors_defenderCheckDelay) then {
					_QS_module_virtualSectors_countAI = 0;
					{
						if (_x isNotEqualTo []) then {
							_array = _x;
							_array = _array select {(alive _x)};
							_QS_module_virtualSectors_assignedUnits set [_forEachIndex,_array];
							_QS_module_virtualSectors_countAI = _QS_module_virtualSectors_countAI + (count _array);
						};
					} forEach _QS_module_virtualSectors_assignedUnits;
					_QS_module_virtualSectors_data = missionNamespace getVariable 'QS_virtualSectors_data';
					if (_QS_module_virtualSectors_data isNotEqualTo []) then {
						{
							_QS_module_virtualSectors_sectorData = _x;
							_QS_module_virtualSectors_sectorData params [
								'_sectorID',
								'_isActive',
								'_nextEvaluationTime',
								'_increment',
								'_minConversionTime',
								'_interruptMultiplier',
								'_areaType',
								'_centerPos',
								'_areaOrRadiusConvert',
								'_areaOrRadiusInterrupt',
								'_sidesOwnedBy',
								'_sidesCanConvert',
								'_sidesCanInterrupt',
								'_conversionValue',
								'_conversionValuePrior',
								'_conversionAlgorithm',
								'_importance',
								'_flagData',
								'_sectorAreaObjects',
								'_locationData',
								'_objectData',
								'_markerData',
								'_taskData',
								'_initFunction',
								'_manageFunction',
								'_exitFunction',
								'_conversionRate',
								'_isBeingInterrupted'
							];
							//comment 'Manage sector patrols';
							/*/ Debug lines
							if (!isNil 'QS_module_virtualSectors_maxAI') then {
								_QS_module_virtualSectors_maxAI = QS_module_virtualSectors_maxAI;
							};
							if (!isNil 'QS_module_virtualSectors_maxAISector') then {
								_QS_module_virtualSectors_maxAISector = QS_module_virtualSectors_maxAISector;
							};
							if (!isNil 'QS_module_virtualSectors_maxAIX') then {
								_QS_module_virtualSectors_maxAIX = QS_module_virtualSectors_maxAIX;
							};
							/*/
							_QS_module_virtualSectors_assignedUnitsSector = _QS_module_virtualSectors_assignedUnits # _forEachIndex;
							_QS_module_virtualSectors_countAISector = count _QS_module_virtualSectors_assignedUnitsSector;
							if (_QS_module_virtualSectors_countAISector <= (_QS_module_virtualSectors_maxAISector - _QS_module_virtualSectors_spawnGroupCount)) then {
								//comment 'Spawn more AI';
								_QS_module_virtualSectors_spawnedGrp = [_QS_module_virtualSectors_sectorData,_QS_module_virtualSectors_spawnGroupCount] call _fn_scSpawnGroup;
								{
									_QS_module_virtualSectors_assignedUnitsSector pushBack _x;
								} forEach (units _QS_module_virtualSectors_spawnedGrp);
								_QS_module_virtualSectors_assignedUnits set [_forEachIndex,_QS_module_virtualSectors_assignedUnitsSector];
							};
						} forEach _QS_module_virtualSectors_data;
						_QS_module_virtualSectors_defenderCheckDelay = _QS_uiTime + _QS_module_virtualSectors_defenderDelay;
					};
					if (_QS_uiTime > _QS_module_virtualSectors_attackerCheckDelay) then {
						//comment 'Fourth block of AI here, spawned all over zone and move between to nearest contested sector';
						_QS_module_virtualSectors_assignedUnitsSector = _QS_module_virtualSectors_assignedUnits # 3;
						_QS_module_virtualSectors_countAISector = count _QS_module_virtualSectors_assignedUnitsSector;
						if (_QS_module_virtualSectors_countAISector <= (_QS_module_virtualSectors_maxAIX - _QS_module_virtualSectors_spawnGroupCount)) then {
							_QS_module_virtualSectors_spawnedGrp = [-1,_QS_module_virtualSectors_spawnGroupCount] call _fn_scSpawnGroup;
							{
								_QS_module_virtualSectors_assignedUnitsSector pushBack _x;
							} forEach (units _QS_module_virtualSectors_spawnedGrp);
							_QS_module_virtualSectors_assignedUnits set [3,_QS_module_virtualSectors_assignedUnitsSector];
						};
						_QS_module_virtualSectors_attackerCheckDelay = _QS_uiTime + _QS_module_virtualSectors_attackerDelay;
					};
				};
			};
			_QS_module_virtualSectors_checkDelay = diag_tickTime + _QS_module_virtualSectors_delay;
		};
		if (!(missionNamespace getVariable 'QS_virtualSectors_active')) then {
			if (missionNamespace getVariable 'QS_virtualSectors_AI_triggerDeinit') then {
				missionNamespace setVariable ['QS_virtualSectors_AI_triggerDeinit',_false,_false];
				missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',0,_false];
				{
					_QS_module_virtualSectors_assignedUnitsSector = _x;
					{
						if (!isNull _x) then {
							uiSleep 0.05;
							if (!([1,0,_x] call _fn_serverObjectsRecycler)) then {
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
							};
						};
					} forEach _QS_module_virtualSectors_assignedUnitsSector;
				} forEach _QS_module_virtualSectors_assignedUnits;
				_QS_module_virtualSectors_assignedUnits = [[],[],[],[]];
				_QS_module_virtualSectors_assignedUnitsSector = [];
				if (_QS_module_virtualSectors_enemy_0 isNotEqualTo []) then {
					{
						if (_x isEqualType objNull) then {
							if (!isNull _x) then {
								uiSleep 0.05;
								if (!([1,0,_x] call _fn_serverObjectsRecycler)) then {
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
								};
							};
						};
					} forEach _QS_module_virtualSectors_enemy_0;
					_QS_module_virtualSectors_enemy_0 = [];
				};
				if (_QS_module_virtualSectors_enemy_1 isNotEqualTo []) then {
					{
						_array = _x;
						if (_array isEqualType []) then {
							if (_array isNotEqualTo []) then {
								{
									if (_x isEqualType objNull) then {
										if (!isNull _x) then {
											uiSleep 0.05;
											if (!([1,0,_x] call _fn_serverObjectsRecycler)) then {
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
											};
										};
									};
								} forEach _array;
								_array = [];
							};
						};
					} forEach _QS_module_virtualSectors_enemy_1;
					_QS_module_virtualSectors_enemy_1 = [];
				};
				if (_QS_module_virtualSectors_uavs isNotEqualTo []) then {
					{
						if (_x isEqualType objNull) then {
							if (!isNull _x) then {
								_x setDamage [1,_false];
								uiSleep 0.1;
								deleteVehicle _x;
							};
						};
					} forEach _QS_module_virtualSectors_uavs;
				};
				if (_QS_module_viperTeam_array isNotEqualTo []) then {
					{
						if (_x isEqualType objNull) then {
							if (!isNull _x) then {
								uiSleep 0.1;
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
							};
						};
					} forEach _QS_module_viperTeam_array;
					_QS_module_viperTeam_array = [];
					_QS_module_viperTeam_grp = grpNull;
				};
				_QS_module_virtualSectors_patrolsHeli = [];
				_QS_module_virtualSectors_patrolsInf = [];
				_QS_module_virtualSectors_patrolsVeh = [];
				_QS_module_virtualSectors_patrolsGarrison = [];
				_QS_module_virtualSectors_patrolsBoat = [];
				_QS_module_virtualSectors_patrolsSniper = [];
				_QS_module_virtualSectors_countAIInfPatrols = 0;
				_QS_module_virtualSectors_countAIVehPatrols = 0;
				_QS_module_virtualSectors_countAISnpPatrols = 0;
				_QS_module_virtualSectors_patrolFallback = _false;
				_QS_module_virtualSectors_assaultReady = _false;
				_QS_module_virtualSectors_assaultActive = _false;
				_QS_module_virtualSectors_assaultArray = [];
				_QS_module_viperTeam_array = [];
				missionNamespace setVariable ['QS_virtualSectors_AI_triggerDeinit',_false,_false];
			};
		};
	};
	
	/*/Module classic AOs/*/
	if (_QS_module_classic) then {
		if (_QS_uiTime > _QS_module_classic_checkDelay) then {
			if (missionNamespace getVariable 'QS_classic_AI_triggerInit') then {
				missionNamespace setVariable ['QS_classic_AI_triggerInit',_false,_false];
				_QS_module_classic_aoPos = missionNamespace getVariable 'QS_AOpos';
				_QS_module_classic_aoSize = missionNamespace getVariable 'QS_aoSize';
				_QS_module_classic_aoData = missionNamespace getVariable 'QS_classic_AOData';
				_QS_module_classic_hqPos = missionNamespace getVariable 'QS_hqPos';
				_QS_module_classic_terrainData = [1,_QS_module_classic_aoPos,_QS_module_classic_aoSize,_QS_module_classic_aoData,_true] spawn _fn_aoGetTerrainData;
				waitUntil {
					(scriptDone _QS_module_classic_terrainData)
				};
				_QS_module_classic_scriptCreateEnemy = [_QS_module_classic_aoPos,_false,_QS_module_classic_aoData] spawn _fn_aoEnemy;
				waitUntil {
					(scriptDone _QS_module_classic_scriptCreateEnemy)
				};
				if (
					_QS_module_classic_aoUrbanSpawning &&
					(missionNamespace getVariable ['QS_ao_urbanSpawn',_false])
				) then {
					_QS_module_classic_scriptAOUrbanSpawn = ['INIT'] spawn _fn_aoUrbanSpawn;
					waitUntil {
						(scriptDone _QS_module_classic_scriptAOUrbanSpawn)
					};
				};
				uiSleep 0.25;
				_QS_module_classic_enemy_0 = missionNamespace getVariable ['QS_classic_AI_enemy_0',[]];
				missionNamespace setVariable ['QS_classic_AI_enemy_0',[],_false];
				_QS_module_classic_infReinforce_enabled = (_QS_module_classic_aoData # 8) isEqualTo 1;
				_QS_module_classic_vehReinforce_enabled = (_QS_module_classic_aoData # 9) isEqualTo 1;
				_QS_module_classic_efb = _false;
				_QS_module_classic_infReinforce_spawned = 0;
				_QS_module_classic_vehReinforce_spawned = 0;
				_QS_module_classic_efb_checkDelay = _QS_uiTime + 600;
				_QS_module_classic_infReinforce_array = [];
				_QS_module_classic_vehReinforce_array = _QS_module_classic_enemy_0 select {((_x isKindOf 'LandVehicle') && (!(_x isKindOf 'StaticWeapon')))};
				_QS_module_classic_patrolsHeli = [];
				_QS_module_classic_uavs = [];
				_QS_module_tracers_checkOverride = _true;
			};
			if (missionNamespace getVariable 'QS_classic_AI_active') then {
				if ((missionNamespace getVariable ['QS_classic_AI_enemy_0',[]]) isNotEqualTo []) then {
					{
						_QS_module_classic_enemy_0 pushBack _x;
					} forEach (missionNamespace getVariable ['QS_classic_AI_enemy_0',[]]);
					missionNamespace setVariable ['QS_classic_AI_enemy_0',[],_false];
				};
				//comment 'Enemy inf reinforcements';
				if (_QS_module_classic_infReinforce) then {
					if (_QS_module_classic_infReinforce_enabled) then {
						if (_QS_uiTime > _QS_module_classic_infReinforce_checkDelay) then {
							if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
								if (_QS_allPlayersCount > 10) then {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_0;} else {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_0;};
								if (_QS_allPlayersCount > 20) then {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_1;};
								if (_QS_allPlayersCount > 30) then {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_2;};
								if (_QS_allPlayersCount > 40) then {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_3;};
								if (_QS_allPlayersCount > 50) then {_QS_module_classic_infReinforce_cap = _QS_module_classic_infReinforce_cap_4;};
								if (_QS_module_classic_infReinforce_spawned < _QS_module_classic_infReinforce_cap) then {
									if (_QS_allPlayersCount < _QS_module_classic_infReinforce_playerThreshold) then {
										_QS_module_classic_infReinforce_limitReal = (_QS_module_classic_infReinforce_limit / 2);
									} else {
										_QS_module_classic_infReinforce_limitReal = _QS_module_classic_infReinforce_limit;
									};
									_QS_module_classic_infReinforce_array = _QS_module_classic_infReinforce_array select {(alive _x)};
									if ((count _QS_module_classic_infReinforce_array) < _QS_module_classic_infReinforce_limitReal) then {
										if ((count (((units _east) + (units _resistance)) inAreaArray [_QS_module_classic_aoPos,_QS_module_classic_aoSize,_QS_module_classic_aoSize,0,FALSE,-1])) < _QS_module_classic_infReinforce_AIThreshold) then {
											_QS_module_classic_spawnedEntities = [_QS_module_classic_aoPos] call _fn_aoEnemyReinforce;
											{
												_QS_module_classic_infReinforce_array pushBack _x;
											} forEach _QS_module_classic_spawnedEntities;
											if (!alive (missionNamespace getVariable ['QS_radioTower',objNull])) then {
												_QS_module_classic_infReinforce_spawned = _QS_module_classic_infReinforce_spawned + 4;			// 4 seems to be a good fit
												//_QS_module_classic_infReinforce_spawned = _QS_module_classic_infReinforce_spawned + (count _QS_module_classic_infReinforce_array);
											};
										};
									};
								};
							};
							_QS_module_classic_infReinforce_checkDelay = _QS_uiTime + (random [20,30,40]);
						};
					};
				};
				//comment 'Enemy vic reinforcements';
				if (_QS_module_classic_vehReinforce) then {
					if (_QS_module_classic_vehReinforce_enabled) then {
						if (_QS_uiTime > _QS_module_classic_vehReinforce_checkDelay) then {
							if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
								if (_QS_allPlayersCount > 10) then {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_0;} else {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_0;};
								if (_QS_allPlayersCount > 20) then {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_1;};
								if (_QS_allPlayersCount > 30) then {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_2;};
								if (_QS_allPlayersCount > 40) then {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_3;};
								if (_QS_allPlayersCount > 50) then {_QS_module_classic_vehReinforce_cap = _QS_module_classic_vehReinforce_cap_4;};
								if (_QS_module_classic_vehReinforce_spawned < _QS_module_classic_vehReinforce_cap) then {
									if (_QS_allPlayersCount < _QS_module_classic_vehReinforce_playerThreshold) then {
										_QS_module_classic_vehReinforce_limitReal = (_QS_module_classic_vehReinforce_limit / 2);
									} else {
										_QS_module_classic_vehReinforce_limitReal = _QS_module_classic_vehReinforce_limit;
									};
									_QS_module_classic_vehReinforce_array = _QS_module_classic_vehReinforce_array select {(alive _x)};
									if (({((_x isKindOf 'LandVehicle') && (!(_x isKindOf 'StaticWeapon')))} count _QS_module_classic_vehReinforce_array) < _QS_module_classic_vehReinforce_limitReal) then {
										if ((count (((units _east) + (units _resistance)) inAreaArray [_QS_module_classic_aoPos,_QS_module_classic_aoSize,_QS_module_classic_aoSize,0,FALSE,-1])) < _QS_module_classic_vehReinforce_AIThreshold) then {	
											_QS_module_classic_spawnedEntities = [_QS_module_classic_aoPos] call _fn_aoEnemyReinforceVehicles;
											{
												_QS_module_classic_vehReinforce_array pushBack _x;
											} forEach _QS_module_classic_spawnedEntities;
											if (!(alive (missionNamespace getVariable ['QS_radioTower',objNull]))) then {
												_QS_module_classic_vehReinforce_spawned = _QS_module_classic_vehReinforce_spawned + 1;
											};
										};
									};
								};
							};
							_QS_module_classic_vehReinforce_checkDelay = _QS_uiTime + (random [20,30,40]);
						};
					};
				};
				//comment 'Enemy helo respawning';
				if (_QS_diag_fps > 10) then {
					if (_QS_module_classic_heliEnabled) then {
						if (alive (missionNamespace getVariable 'QS_radioTower')) then {
							if (_QS_uiTime > _QS_module_classic_patrolsHeli_checkDelay) then {
								_QS_module_classic_patrolsHeli = _QS_module_classic_patrolsHeli select {(alive _x)};
								if ((_QS_module_classic_patrolsHeli findIf {(_x isKindOf 'Helicopter')}) isEqualTo -1) then {
									if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
										_QS_module_classic_spawnedGrp = [0] call _fn_scSpawnHeli;
										if (_QS_module_classic_spawnedGrp isNotEqualTo []) then {
											{
												_QS_module_classic_patrolsHeli pushBack _x;
											} forEach _QS_module_classic_spawnedGrp;
										};
									};
								};
								_QS_module_classic_patrolsHeli_checkDelay = _QS_uiTime + (_QS_module_classic_patrolsHeli_delay + (random 120));
							};
						};
					};
					//comment 'Manage UAV patrol';
					if (_QS_module_classic_uavEnabled) then {
						if (_QS_uiTime > _QS_module_classic_uav_checkDelay) then {
							_QS_module_classic_uavs = _QS_module_classic_uavs select {(alive _x)};
							if ((_QS_module_classic_uavs findIf {(unitIsUav _x)}) isEqualTo -1) then {
								_QS_module_classic_spawnedGrp = [] call _fn_scSpawnUAV;
								if (_QS_module_classic_spawnedGrp isNotEqualTo []) then {
									{
										_QS_module_classic_uavs pushBack _x;
									} forEach _QS_module_classic_spawnedGrp;
								};
							};
							_QS_module_classic_uav_checkDelay = diag_tickTime + _QS_module_classic_uav_delay;
						};
					};
					if (_QS_module_viperTeam) then {
						if (_QS_uiTime > _QS_module_viperTeam_checkDelay) then {
							if (_QS_uiTime > _QS_module_viperTeam_respawnCheckDelay) then {
								if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
									_QS_module_viperTeam_array = _QS_module_viperTeam_array select {(alive _x)};
									if (_QS_allPlayersCount > 10) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_1;} else {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_0;};
									if (_QS_allPlayersCount > 20) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_1;};
									if (_QS_allPlayersCount > 30) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_2;};
									if (_QS_allPlayersCount > 40) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_2;};
									if (_QS_allPlayersCount > 50) then {_QS_module_viperTeam_qty = _QS_module_viperTeam_qty_3;};
									if (
										(_QS_allPlayersCount > 10) &&
										{((count _QS_module_viperTeam_array) < ((round (_QS_module_viperTeam_qty / 2)) max 0))}
									) then {
										if (!(_QS_module_classic_efb)) then {
											_array = ['CLASSIC',(count _QS_module_viperTeam_array),_QS_module_viperTeam_qty,_QS_module_viperTeam_grp] call _fn_spawnViperTeam;
											{
												_QS_module_viperTeam_grp = group _x;
												_QS_module_viperTeam_array pushBack _x;
											} forEach _array;
											_QS_module_viperTeam_respawnCheckDelay = _QS_uiTime + _QS_module_viperTeam_respawnDelay;
										};
									};
								};
							};
							_QS_module_viperTeam_checkDelay = _QS_uiTime + _QS_module_viperTeam_delay;
						};
					};
				};
				//comment 'Enemy fallback';
				if (_QS_uiTime > _QS_module_classic_efb_checkDelay) then {
					if (!(_QS_module_classic_efb)) then {
						if ((count ((units _east) inAreaArray [_QS_module_classic_aoPos,_QS_module_classic_aoSize,_QS_module_classic_aoSize,0,FALSE,-1])) < _QS_module_classic_efb_threshold) then {
							_QS_module_classic_efb = _true;
							{
								_QS_module_classic_efb_group = _x;
								if ((side _QS_module_classic_efb_group) in _enemySides) then {
									if (((units _QS_module_classic_efb_group) findIf {(alive _x)}) isNotEqualTo -1) then {
										if (((leader _QS_module_classic_efb_group) distance2D _QS_module_classic_aoPos) < (_QS_module_classic_aoSize * 1.25)) then {
											if (!((vehicle (leader _QS_module_classic_efb_group)) isKindOf 'Air')) then {
												if (isNull (objectParent (leader _QS_module_classic_efb_group))) then {
													{
														//if ((random 1) > 0.5) then {
														if (_unit checkAIFeature 'MINEDETECTION') then {
															_x enableAIFeature ['PATH',TRUE];
														};
													} forEach (units _QS_module_classic_efb_group);
													_QS_module_classic_efb_group setSpeedMode 'FULL';
													_QS_module_classic_efb_group setBehaviour 'AWARE';
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _QS_module_classic_efb_group))],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_DATA',[],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_TASK',['PATROL',[_QS_module_classic_hqPos,(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)]),(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)]),(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)])],serverTime,-1],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_PATROLINDEX',0,_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP',_true,_false];
												};
												if (((objectParent (leader _QS_module_classic_efb_group)) isKindOf 'LandVehicle') && (!((objectParent (leader _QS_module_classic_efb_group)) isKindOf 'StaticWeapon'))) then {
													_QS_module_classic_efb_group setSpeedMode 'FULL';
													_QS_module_classic_efb_group setBehaviour 'AWARE';
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _QS_module_classic_efb_group)),(objectParent (leader _QS_module_classic_efb_group))],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_DATA',[],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_TASK',['PATROL',[(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)]),(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)]),(_QS_module_classic_hqPos getPos [(50 + (random 50)),(random 360)])],serverTime,-1],_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP_PATROLINDEX',0,_false];
													_QS_module_classic_efb_group setVariable ['QS_AI_GRP',_true,_false];													
												};
											};
										};
									};
								};
							} forEach _QS_module_groupBehaviors_localGroups;
						};
					};
					_QS_module_classic_efb_checkDelay = _QS_uiTime + _QS_module_classic_efb_delay;
				};
			};	
			if (!(missionNamespace getVariable 'QS_classic_AI_active')) then {
				if (missionNamespace getVariable 'QS_classic_AI_triggerDeinit') then {
					missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',0,_false];
					if (_QS_module_classic_enemy_0 isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									if ((_x isKindOf 'Air') || {(_x isKindOf 'LandVehicle')} || {(_x isKindOf 'Ship')}) then {
										_x setDamage [1,_false];
									} else {
										if ((_x isKindOf 'Building') || {(_x isKindOf 'House')}) then {
											0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										} else {
											uiSleep 0.05;
											if (!([1,0,_x] call _fn_serverObjectsRecycler)) then {
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
											};
										};
									};
								};
							};
						} count _QS_module_classic_enemy_0;
						_QS_module_classic_enemy_0 = [];
					};
					if (_QS_module_classic_infReinforce_array isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									uiSleep 0.05;
									if (!([1,0,_x] call _fn_serverObjectsRecycler)) then {
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
									};
								};
							};
						} forEach _QS_module_classic_infReinforce_array;
						_QS_module_classic_infReinforce_array = [];
					};
					if (_QS_module_classic_vehReinforce_array isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									uiSleep 0.1;
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
								};
							};
						} forEach _QS_module_classic_vehReinforce_array;
						_QS_module_classic_vehReinforce_array = [];
					};					
					if (_QS_module_classic_uavs isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									uiSleep 0.1;
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
								};
							};
						} forEach _QS_module_classic_uavs;
						_QS_module_classic_uavs = [];
					};
					if (_QS_module_viperTeam_array isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									uiSleep 0.1;
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
								};
							};
						} forEach _QS_module_viperTeam_array;
						_QS_module_viperTeam_array = [];
						_QS_module_viperTeam_grp = grpNull;
					};
					if (_QS_module_classic_patrolsHeli isNotEqualTo []) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									uiSleep 0.1;
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
								};
							};
						} forEach _QS_module_classic_patrolsHeli;
						_QS_module_classic_patrolsHeli = [];
					};
					missionNamespace setVariable ['QS_classic_AI_triggerDeinit',_false,_false];
				};
			};
			_QS_module_classic_checkDelay = diag_tickTime + _QS_module_classic_delay;
		};
	};
	/*/Module Grid/*/
	if (_QS_module_grid) then {
		if (_QS_uiTime > _QS_module_grid_checkDelay) then {
			if (missionNamespace getVariable ['QS_grid_AI_triggerDeinit',_false]) then {
				diag_log 'QS AI GRID deinit';
				missionNamespace setVariable ['QS_grid_AI_active',_false,_false];
				if (_QS_module_grid_enemy isNotEqualTo []) then {
					{
						_QS_module_grid_enemy_X = _x;
						{
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
						} forEach _QS_module_grid_enemy_X;
					} forEach _QS_module_grid_enemy;
					_QS_module_grid_enemy_X = [];
					_QS_module_grid_enemy = [];
				};
				if ((missionNamespace getVariable ['QS_primaryObjective_civilians',[]]) isNotEqualTo []) then {
					{
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
						};
					} forEach (missionNamespace getVariable ['QS_primaryObjective_civilians',[]]);
					missionNamespace setVariable ['QS_primaryObjective_civilians',[],_false];
				};
				if ((missionNamespace getVariable ['QS_aoAnimals',[]]) isNotEqualTo []) then {
					{
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
						};
					} count (missionNamespace getVariable 'QS_aoAnimals');
					missionNamespace setVariable ['QS_aoAnimals',[],_false];
				};
				if (_QS_module_grid_defendUnits isNotEqualTo []) then {
					{
						if (alive _x) then {
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
						};
					} forEach _QS_module_grid_defendUnits;
					_QS_module_grid_defendUnits = [];
				};
				missionNamespace setVariable ['QS_grid_AI_triggerDeinit',_false,_true];
			};
			if (missionNamespace getVariable ['QS_grid_AI_triggerInit',_false]) then {
				diag_log 'QS AI GRID init';
				missionNamespace setVariable ['QS_grid_AI_triggerInit',_false,_true];
				_QS_module_grid_aoPos = missionNamespace getVariable 'QS_aoPos';
				_QS_module_grid_aoSize = missionNamespace getVariable 'QS_aoSize';
				_QS_module_grid_aoData = missionNamespace getVariable 'QS_grid_aoData';
				_QS_module_grid_igPos = missionNamespace getVariable 'QS_grid_IGposition';
				_QS_module_grid_terrainData = [0,_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_aoData] call _fn_aoGetTerrainData;
				_QS_module_grid_scriptCreateEnemy = [_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_igPos,_QS_module_grid_aoData,_QS_module_grid_terrainData] spawn _fn_gridEnemy;
				waitUntil {
					uiSleep 0.1;
					(scriptDone _QS_module_grid_scriptCreateEnemy)
				};
				_QS_module_grid_enemy = missionNamespace getVariable ['QS_grid_AI_enemy_1',[]];
				_QS_module_grid_bldgPatrolUnits = _QS_module_grid_enemy # 1;
				_QS_module_grid_areaPatrolUnits = _QS_module_grid_enemy # 2;
				_QS_module_grid_bldgPatrolRespawnThreshold = (round ((count _QS_module_grid_bldgPatrolUnits) / 1.5)) max 0;
				_QS_module_grid_areaPatrolRespawnThreshold = (round ((count _QS_module_grid_areaPatrolUnits) / 1.5)) max 0;
				if (!isNil {_QS_module_grid_terrainData # 4}) then {
					_QS_module_civilian_houseCount = count (_QS_module_grid_terrainData # 4);
					if (_QS_module_civilian_houseCount > 0) then {
						_QS_module_civilian_count = _QS_module_civilian_count_1;
					} else {
						_QS_module_civilian_count = _QS_module_civilian_count_0;
					};
					if (_QS_module_civilian_houseCount > 5) then {
						_QS_module_civilian_count = _QS_module_civilian_count_2;
					};
					if (_QS_module_civilian_houseCount > 10) then {
						_QS_module_civilian_count = _QS_module_civilian_count_3;
					};
					if (_QS_module_civilian_houseCount > 15) then {
						_QS_module_civilian_count = _QS_module_civilian_count_4;
					};
					if (_QS_module_civilian_houseCount > 20) then {
						_QS_module_civilian_count = _QS_module_civilian_count_5;
					};
					if (_QS_module_civilian_houseCount > 25) then {
						_QS_module_civilian_count = _QS_module_civilian_count_6;
					};
					if (_QS_module_civilian_count > 0) then {
						if (_QS_ambientCivilians) then {
							missionNamespace setVariable [
								'QS_primaryObjective_civilians',
								([_QS_module_grid_aoPos,_QS_module_grid_aoSize,'FOOT',_QS_module_civilian_count,_false,_true] call _fn_spawnAmbientCivilians),
								_false
							];
						};
					};
				};
				if (_QS_ambientAnimals) then {
					for '_x' from 0 to 2 step 1 do {
						_QS_module_animalSpawnPosition = ['RADIUS',_QS_module_grid_aoPos,(_QS_module_grid_aoSize * 1.25),'LAND',[],_false,[[0,0,0],150,'2*meadow + hills + forest + trees',30,10],[],_false] call _fn_findRandomPos;
						if (!([_QS_module_animalSpawnPosition,50,6] call _fn_waterInRadius)) then {
							if ((_QS_module_animalSpawnPosition distance2D _QS_module_grid_aoPos) < (_QS_module_grid_aoSize * 1.5)) then {
								[_QS_module_animalSpawnPosition,(selectRandomWeighted ['SHEEP',0.4,'GOAT',0.3,'HEN',0.1]),(round (3 + (random 3)))] call _fn_aoAnimals;
							};
						};
						
					};
				};
				_QS_module_tracers_checkOverride = _true;
				missionNamespace setVariable ['QS_grid_AI_active',_true,_false];
			};
			if (missionNamespace getVariable ['QS_grid_AI_active',_false]) then {
				if (((missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]]) findIf {(!isNull _x)}) isNotEqualTo -1) then {
					if (_QS_uiTime > _QS_module_grid_bldgPatrol_checkDelay) then {
						_QS_module_grid_bldgPatrolUnits = _QS_module_grid_bldgPatrolUnits select {(alive _x)};
						if ((count _QS_module_grid_bldgPatrolUnits) < _QS_module_grid_bldgPatrolRespawnThreshold) then {
							_QS_module_grid_spawnArray = [0,_QS_module_grid_teamSize,_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_igPos,_QS_module_grid_aoData,_QS_module_grid_terrainData,(missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]])] call _fn_gridSpawnPatrol;
							if (_QS_module_grid_spawnArray isNotEqualTo []) then {
								{
									_QS_module_grid_bldgPatrolUnits pushBack _x;
								} forEach _QS_module_grid_spawnArray;
								_QS_module_grid_enemy set [1,_QS_module_grid_bldgPatrolUnits];
								_QS_module_grid_spawnArray = [];
							};
						};
						_QS_module_grid_bldgPatrol_checkDelay = diag_tickTime + _QS_module_grid_bldgPatrol_delay;
					};
					if (_QS_uiTime > _QS_module_grid_areaPatrol_checkDelay) then {
						_QS_module_grid_areaPatrolUnits = _QS_module_grid_areaPatrolUnits select {(alive _x)};
						if ((count _QS_module_grid_areaPatrolUnits) < _QS_module_grid_areaPatrolRespawnThreshold) then {
							_QS_module_grid_spawnArray = [1,_QS_module_grid_teamSize,_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_igPos,_QS_module_grid_aoData,_QS_module_grid_terrainData,(missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]])] call _fn_gridSpawnPatrol;
							if (_QS_module_grid_spawnArray isNotEqualTo []) then {
								{
									_QS_module_grid_areaPatrolUnits pushBack _x;
								} forEach _QS_module_grid_spawnArray;
								_QS_module_grid_enemy set [2,_QS_module_grid_areaPatrolUnits];
								_QS_module_grid_spawnArray = [];
							};
						};
						_QS_module_grid_areaPatrol_checkDelay = diag_tickTime + _QS_module_grid_areaPatrol_delay;
					};
				};
			};
			if (missionNamespace getVariable ['QS_grid_defend_AIinit',_false]) then {
				missionNamespace setVariable ['QS_grid_defend_AIinit',_false,_true];
			};			
			if (missionNamespace getVariable ['QS_grid_defend_active',_false]) then {
				if (_QS_allPlayersCount > 5) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_1;} else {_QS_module_grid_defendQty = _QS_module_grid_defendQty_0;};
				if (_QS_allPlayersCount > 10) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_2;};
				if (_QS_allPlayersCount > 15) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_3;};
				if (_QS_allPlayersCount > 20) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_4;};
				if (_QS_allPlayersCount > 30) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_5;};
				if (_QS_allPlayersCount > 40) then {_QS_module_grid_defendQty = _QS_module_grid_defendQty_5;};
				if (_QS_uiTime > _QS_module_grid_defend_checkDelay) then {
					_QS_module_grid_defendUnits = _QS_module_grid_defendUnits select {(alive _x)};
					if ((count _QS_module_grid_defendUnits) < _QS_module_grid_defendQty) then {
						_QS_module_grid_spawnArray = [0,_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_igPos,_QS_module_grid_teamSize] call _fn_gridSpawnAttack;
						if (_QS_module_grid_spawnArray isNotEqualTo []) then {
							{
								_QS_module_grid_defendUnits pushBack _x;
							} forEach _QS_module_grid_spawnArray;
							_QS_module_grid_spawnArray = [];
						};
					};
					_QS_module_grid_defend_checkDelay = diag_tickTime + _QS_module_grid_defend_delay;
				};
			};
			if (missionNamespace getVariable ['QS_grid_defend_AIdeInit',_false]) then {
				missionNamespace setVariable ['QS_grid_defend_AIdeInit',_false,_true];
				if (_QS_module_grid_defendUnits isNotEqualTo []) then {
					{
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
						};
					} forEach _QS_module_grid_defendUnits;
					_QS_module_grid_defendUnits = [];
				};
			};
			_QS_module_grid_checkDelay = _QS_uiTime + _QS_module_grid_delay;
		};
	};
	
	/*/Module Ambient Hostility/*/

	if (_QS_module_ambientHostility) then {
		if (_QS_uiTime > _QS_module_ambientHostility_checkDelay) then {
			if (_QS_module_ambientHostility_inProgress) then {
				_QS_module_ambientHostility_entities = _QS_module_ambientHostility_entities select {(alive _x)};
				if (_QS_module_ambientHostility_entities isEqualTo []) then {
					_QS_module_ambientHostility_inProgress = _false;
					_QS_module_ambientHostility_cooldown = _QS_uiTime + (random 360);
				} else {
					{
						([_x,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
						if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
							_x setDamage [1,_false];
						};
					} forEach _QS_module_ambientHostility_entities;
				};
				if (_QS_uiTime > _QS_module_ambientHostility_duration) then {
					{
						if (((units _west) inAreaArray [_x,800,800,0,FALSE,-1]) isEqualTo []) then {
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
						};
					} forEach _QS_module_ambientHostility_entities;
				};
			} else {
				if (_QS_diag_fps > 10) then {
					if (_QS_uiTime > _QS_module_ambientHostility_cooldown) then {
						_QS_module_ambientHostility_validTargets = units _west;
						if (_QS_module_ambientHostility_validTargets isNotEqualTo []) then {
							_QS_module_ambientHostility_validTargets = _QS_module_ambientHostility_validTargets select { ((_x distance2D _basePosition) > 1500) && ((_x distance2D (missionNamespace getVariable 'QS_aoPos')) > 800) && ((lifeState _x) in ['HEALTHY','INJURED']) };
							if (_QS_module_ambientHostility_validTargets isNotEqualTo []) then {
								_QS_module_ambientHostility_validTargets = _QS_module_ambientHostility_validTargets select { ((((vehicle _x) isKindOf 'LandVehicle') || {((vehicle _x) isKindOf 'CAManBase')}) && (isTouchingGround (vehicle _x))) };
								if (_QS_module_ambientHostility_validTargets isNotEqualTo []) then {
									_QS_module_ambientHostility_graceTime = _QS_uiTime + 60;
									_QS_module_ambientHostility_duration = _QS_uiTime + (random [360,480,600]);
									_QS_module_ambientHostility_target = selectRandom _QS_module_ambientHostility_validTargets;
									_QS_module_ambientHostility_position = getPosATL _QS_module_ambientHostility_target;
									_QS_module_ambientHostility_nearbyCount = count (_QS_module_ambientHostility_validTargets inAreaArray [_QS_module_ambientHostility_position,100,100,0,_false,-1]);
									if (_QS_module_ambientHostility_entities isNotEqualTo []) then {
										{
											if (alive _x) then {
												if (
													(_x isKindOf 'CAManBase') &&
													{(!isNull (objectParent _x))}
												) then {
													(objectParent _x) deleteVehicleCrew _x;
												} else {
													deleteVehicle _x;
												};
											};
										} forEach _QS_module_ambientHostility_entities;
										_QS_module_ambientHostility_entities = [];
									};
									_QS_module_ambientHostility_entities = [0,_QS_module_ambientHostility_target,_QS_module_ambientHostility_nearbyCount] call _fn_ambientHostility;
									_QS_module_ambientHostility_inProgress = _QS_module_ambientHostility_entities isNotEqualTo [];
								};
							};
						};
					};
				};
			};
			_QS_module_ambientHostility_checkDelay = _QS_uiTime + _QS_module_ambientHostility_delay;
		};
	} else {
		if (_QS_module_ambientHostility_inProgress) then {
			_QS_module_ambientHostility_inProgress = _false;
			{
				_x setDamage [1,_false];
			} forEach _QS_module_ambientHostility_entities;
		};
	};
	/*/Module Enemy CAS/*/
	if (_QS_module_enemyCAS) then {
		if (_QS_uiTime > _QS_module_enemyCAS_checkDelay) then {
			if (!(missionNamespace getVariable 'QS_casSuspend')) then {
				missionNamespace setVariable ['QS_enemyCasArray2',((missionNamespace getVariable 'QS_enemyCasArray2') select {(alive _x)}),_false];
				_QS_module_enemyCas_array = missionNamespace getVariable ['QS_enemyCasArray2',[]];
				_playerJetCount = count (_QS_allPlayers select {((toLowerANSI (typeOf (vehicle _x))) in _QS_module_enemyCas_allJetTypes)});
				if (_QS_allPlayersCount > 10) then {
					if (_QS_allPlayersCount > 25) then {
						_QS_module_enemyCas_limit = _QS_module_enemyCas_limitHigh;
					} else {
						_QS_module_enemyCas_limit = _QS_module_enemyCas_limitLow;
					};
				} else {
					_QS_module_enemyCas_limit = 1;
				};
				if (_playerJetCount > 0) then {
					if (_playerJetCount > 1) then {
						_QS_module_enemyCas_limit = _QS_module_enemyCas_limit + 1;
					};
					_QS_module_enemyCAS_spawnDelay = _QS_module_enemyCAS_spawnDelayDefault / 1.5;
				} else {
					_QS_module_enemyCAS_spawnDelay = _QS_module_enemyCAS_spawnDelayDefault;
				};
				if (_QS_diag_fps > 10) then {
					if ((_QS_uiTime > _QS_module_enemyCAS_checkSpawnDelay) || {(missionNamespace getVariable 'QS_cycleCAS')} || {((missionNamespace getVariable 'QS_defendActive') && (_QS_module_enemyCas_array isEqualTo []) && (_playerJetCount > 1))}) then {
						if (((count _QS_module_enemyCas_array) < _QS_module_enemyCas_limit) || {(missionNamespace getVariable 'QS_cycleCAS')} || {((missionNamespace getVariable 'QS_defendActive') && (_QS_module_enemyCas_array isEqualTo []) && (_playerJetCount > 1))}) then {
							if (missionNamespace getVariable 'QS_cycleCAS') then {
								missionNamespace setVariable ['QS_cycleCAS',_false,_false];
							};
							call _fn_enemyCAS;
						};
						_QS_module_enemyCAS_checkSpawnDelay = _QS_uiTime + _QS_module_enemyCAS_spawnDelay;
					};
				};
				_QS_module_enemyCas_array = missionNamespace getVariable ['QS_enemyCasArray2',[]];
				if (_QS_module_enemyCas_array isNotEqualTo []) then {
					{
						_QS_module_enemyCas_plane = _x;
						if (alive _QS_module_enemyCas_plane) then {
							if (!(_QS_module_enemyCas_plane getVariable ['QS_AI_PLANE_fireMission',_false])) then {
								if ((_QS_module_enemyCas_plane getVariable ['QS_AI_PLANE_flyInHeight',-1]) > 0) then {
									_QS_module_enemyCas_speed = _QS_module_enemyCas_plane getVariable ['QS_enemy_casJetMaxSpeed',-1];
									if (_QS_module_enemyCas_speed isEqualTo -1) then {
										_QS_module_enemyCas_plane setVariable ['QS_enemy_casJetMaxSpeed',(getNumber ((configOf _QS_module_enemyCas_plane) >> 'maxSpeed')),_false];
									};
									_QS_module_enemyCas_plane forceSpeed ((_QS_module_enemyCas_plane getVariable ['QS_enemy_casJetMaxSpeed',1000]) * (random [0.7,0.85,1]));
									if ((_QS_module_enemyCas_plane getVariable ['QS_AI_PLANE_flyInHeight',-1]) isEqualTo 1) then {
										_QS_module_enemyCas_plane flyInHeight [(500 + (random 1000)),_true];
									};
									if ((_QS_module_enemyCas_plane getVariable ['QS_AI_PLANE_flyInHeight',-1]) isEqualTo 2) then {
										_QS_module_enemyCas_plane flyInHeight [(500 + (random 2000)),_true];
									};								
									if ((_QS_module_enemyCas_plane getVariable ['QS_AI_PLANE_flyInHeight',-1]) isEqualTo 3) then {
										_QS_module_enemyCas_plane flyInHeight [(500 + (random 3000)),_true];
									};
								};
							};
							if (_QS_serverTime > (_QS_module_enemyCas_plane getVariable ['QS_enemyCAS_nextRearmTime',-1])) then {
								_QS_module_enemyCas_plane setVehicleAmmo 1;
								_QS_module_enemyCas_plane setVariable ['QS_enemyCAS_nextRearmTime',(_QS_serverTime + 300),_false];
								if (((getPosWorld _QS_module_enemyCas_plane) distance2D (_QS_module_enemyCas_plane getVariable ['QS_enemyCAS_position',[0,0,0]])) < 25) then {
									_QS_module_enemyCas_plane setDamage [1,_false];
								} else {
									_QS_module_enemyCas_plane setVariable ['QS_enemyCAS_position',(getPosWorld _QS_module_enemyCas_plane),_false];
								};
							};
							if (alive _QS_module_enemyCas_plane) then {
								if (alive (currentPilot _QS_module_enemyCas_plane)) then {
									if (_QS_allPlayers isNotEqualTo []) then {
										{
											if ((vehicle _x) isKindOf 'Plane') then {
												if (_x isEqualTo (currentPilot (vehicle _x))) then {
													(group (currentPilot _QS_module_enemyCas_plane)) reveal [(vehicle _x),4];
													(currentPilot _QS_module_enemyCas_plane) reveal [vehicle _x,4];
													if (isNull (getAttackTarget (currentPilot _QS_module_enemyCas_plane))) then {
														(currentPilot _QS_module_enemyCas_plane) doTarget (vehicle _x);
													};
												};
											};
										} forEach _QS_allPlayers;
									};
									if ((missionNamespace getVariable ['QS_AI_laserTargets',[]]) isNotEqualTo []) then {
										{
											if (!isNull _x) then {
												(group (currentPilot _QS_module_enemyCas_plane)) reveal [_x,4];
												(currentPilot _QS_module_enemyCas_plane) reveal [_x,4];
											};
										} forEach (missionNamespace getVariable ['QS_AI_laserTargets',[]]);
									};
								};
							};
						};
					} forEach _QS_module_enemyCas_array;
				};
			};
			_QS_module_enemyCAS_checkDelay = diag_tickTime + _QS_module_enemyCAS_delay;
		};
	} else {
		if ((missionNamespace getVariable ['QS_enemyCasArray2',[]]) isNotEqualTo []) then {
			{
				_x setDamage [1,TRUE];
			} forEach (missionNamespace getVariable ['QS_enemyCasArray2',[]]);
		};
	};

	/*/Module support provision/*/
	if (_QS_module_supportProvision) then {
		if (_QS_uiTime > _QS_module_supportProvision_checkDelay) then {
			{
				missionNamespace setVariable _x;
				uiSleep 0.1;
			} forEach [
				['QS_AI_insertHeli_helis',((missionNamespace getVariable 'QS_AI_insertHeli_helis') select {(!alive _x)}),QS_system_AI_owners],
				['QS_AI_vehicles',((missionNamespace getVariable 'QS_AI_vehicles') select {(alive _x)}),QS_system_AI_owners],
				['QS_AI_targetsIntel',((missionNamespace getVariable 'QS_AI_targetsIntel') select {((alive (_x # 0)) && (_QS_serverTime < ((_x # 1) + 300)))}),QS_system_AI_owners],
				['QS_AI_laserTargets',((missionNamespace getVariable 'QS_AI_laserTargets') select {(!isNull _x)}),QS_system_AI_owners],
				['QS_AI_smokeTargets',((missionNamespace getVariable 'QS_AI_smokeTargets') select {(!isNull _x)}),QS_system_AI_owners]
			];
			if ((missionNamespace getVariable 'QS_AI_supportProviders_MTR') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') select {((alive _x) && ((vehicle _x) isKindOf 'StaticWeapon'))}),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_ARTY',((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') select {((alive _x) && ((vehicle _x) isKindOf 'LandVehicle'))}),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASHELI',((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') select {((alive _x) && ((vehicle _x) isKindOf 'Helicopter'))}),QS_system_AI_owners];			
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASPLANE',((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') select {((alive _x) && ((vehicle _x) isKindOf 'Plane') && (canMove (vehicle _x)))}),QS_system_AI_owners];			
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASUAV',((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') select {((alive _x) && (unitIsUav (vehicle _x)) && (canMove (vehicle _x)))}),QS_system_AI_owners];			
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') select {(alive _x)}),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable ['QS_AI_fireMissions',[]]) isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_fireMissions',((missionNamespace getVariable 'QS_AI_fireMissions') select {(_QS_serverTime < (_x # 2))}),QS_system_AI_owners];
			};
			_QS_module_supportProvision_checkDelay = diag_tickTime + _QS_module_supportProvision_delay;
		};
	};
	if (_QS_module_scripts) then {
		if (_QS_uiTime > _QS_module_scripts_checkDelay) then {
			if ((missionNamespace getVariable 'QS_AI_scripts_Assault') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') select { _QS_serverTime < _x }),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_scripts_fireMissions') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') select { _QS_serverTime < _x }),QS_system_AI_owners];
			};
			uiSleep 0.1;			
			if ((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_scripts_moveToBldg',((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') select { _QS_serverTime < _x }),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_scripts_support') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_scripts_support',((missionNamespace getVariable 'QS_AI_scripts_support') select { _QS_serverTime < _x }),QS_system_AI_owners];
			};
			uiSleep 0.1;
			if ((missionNamespace getVariable 'QS_AI_unitsGestureReady') isNotEqualTo []) then {
				missionNamespace setVariable ['QS_AI_unitsGestureReady',((missionNamespace getVariable 'QS_AI_unitsGestureReady') select {((alive _x) && (_x getVariable ['QS_AI_UNIT_gestureEvent',_false]))}),QS_system_AI_owners];
			};
			if (_QS_diag_fps > 10) then {
				[11,_east,_true] spawn _fn_aiGetKnownEnemies;
				uiSleep 0.1;
			};
			_QS_module_scripts_checkDelay = _QS_uiTime + _QS_module_scripts_delay;
		};
	};
};