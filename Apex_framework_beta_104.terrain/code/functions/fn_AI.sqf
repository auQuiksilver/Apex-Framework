/*/
File: fn_AI.sqf
Author:

	Quiksilver
	
Last modified:

	16/12/2017 A3 1.80 by Quiksilver
	
Description:

	AI
__________________________________________________/*/

scriptName 'QS AI';
private _isDedicated = isDedicated;
private _QS_threadSleep = 3;
private _QS_uiTime = diag_tickTime;
private _QS_time = time;
private _QS_serverTime = serverTime;
private _QS_dayTime = dayTime;
_worldName = worldName;
_worldSize = worldSize;
private _QS_unitCap = [125,110] select (_worldName isEqualTo 'Tanoa');
private _array = [];
private _QS_unit = objNull;
private _QS_grp = grpNull;
private _movePos = [0,0,0];
private _basePosition = markerPos 'QS_marker_base_marker';
comment 'General Info';
private _QS_updateGeneralInfoDelay = 10;
private _QS_updateGeneralInfoCheckDelay = _QS_uiTime + _QS_updateGeneralInfoDelay;
private _QS_diag_fps = round diag_fps;
private _QS_allPlayers = allPlayers;
private _QS_allPlayersCount = count _QS_allPlayers;
private _QS_allGroups = allGroups;
private _QS_allGroupsCount = count _QS_allGroups;
private _QS_allUnits = allUnits;
private _QS_allUnitsCount = count _QS_allUnits;
comment 'Dynamic skill';
private _QS_module_dynamicSkill = FALSE;
private _QS_module_dynamicSkill_delay = 300;
private _QS_module_dynamicSkill_checkDelay = _QS_uiTime + _QS_module_dynamicSkill_delay;
comment 'General group behaviors';
private _QS_module_groupBehaviors = TRUE;
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
comment 'General unit behaviors';
private _QS_module_unitBehaviors = TRUE;
private _QS_module_unitBehaviors_delay = 25;
private _QS_module_unitBehaviors_checkDelay = _QS_uiTime + _QS_module_unitBehaviors_delay;
private _QS_module_unitBehaviors_localUnits = [];
private _QS_module_unitBehaviors_unit = objNull;
comment 'General agent (civ + animal) behaviors';
private _QS_module_agentBehaviors = TRUE;
private _QS_module_agentBehaviors_delay = 30;
private _QS_module_agentBehaviors_checkDelay = _QS_uiTime + _QS_module_agentBehaviors_delay;
private _QS_module_agentBehaviors_localAgents = [];
private _QS_module_agentBehaviors_agent = objNull;
comment 'Virtual sectors logic';
private _QS_module_virtualSectors = (missionNamespace getVariable ['QS_missionConfig_aoType','NONE']) isEqualTo 'SC';
private _QS_module_virtualSectors_delay = 15;	/*/this value influences difficulty substantially/*/
private _QS_module_virtualSectors_checkDelay = _QS_uiTime + _QS_module_virtualSectors_delay;
private _QS_module_virtualSectors_data = missionNamespace getVariable ['QS_virtualSectors_data',[]];
private _QS_module_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
private _QS_module_virtualSectors_scoreWin = missionNamespace getVariable ['QS_virtualSectors_scoreWin',300];
private _QS_module_virtualSectors_scoreEndClose = _QS_module_virtualSectors_scoreWin * 0.75;
private _QS_module_virtualSectors_active = FALSE;
private _QS_module_virtualSectors_spawnedGrp = grpNull;
private _QS_module_virtualSectors_assignedUnits = [[],[],[],[]];
private _QS_module_virtualSectors_assignedUnitsSector = [];
private _QS_module_virtualSectors_patrolFallback = FALSE;
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

private _QS_module_virtualSectors_assaultEnabled = FALSE;
private _QS_module_virtualSectors_assaultScript = scriptNull;
private _QS_module_virtualSectors_assaultActive = FALSE;
private _QS_module_virtualSectors_assaultChance = selectRandom [0.333,0.666];
private _QS_module_virtualSectors_assaultReady = FALSE;
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
private _QS_module_virtualSectors_patrolsHeli_delay = 360;
private _QS_module_virtualSectors_patrolsHeli_checkDelay = _QS_uiTime + _QS_module_virtualSectors_patrolsHeli_delay;
private _QS_module_virtualSectors_heliEnabled = TRUE;
private _QS_module_virtualSectors_patrolsVeh_delay = 300;
private _QS_module_virtualSectors_patrolsVeh_checkDelay = _QS_uiTime + _QS_module_virtualSectors_patrolsVeh_delay;
private _QS_module_virtualSectors_vehiclesEnabled = TRUE;
private _QS_module_virtualSectors_uavEnabled = TRUE;
private _QS_module_virtualSectors_uav_delay = 30;
private _QS_module_virtualSectors_uav_checkDelay = _QS_uiTime + _QS_module_virtualSectors_uav_delay;
private _QS_module_virtualSectors_uavs = [];
private _QS_module_virtualSectors_defenderDelay = 30;
private _QS_module_virtualSectors_defenderCheckDelay = _QS_uiTime + _QS_module_virtualSectors_defenderDelay;
private _QS_module_virtualSectors_attackerDelay = 30;
private _QS_module_virtualSectors_attackerCheckDelay = _QS_uiTime + _QS_module_virtualSectors_attackerDelay;

comment 'Classic AO logic';
private _QS_module_classic = (missionNamespace getVariable ['QS_missionConfig_aoType','NONE']) isEqualTo 'CLASSIC';
private _QS_module_classic_delay = 10;
private _QS_module_classic_checkDelay = _QS_uiTime + _QS_module_classic_delay;
private _QS_module_classic_spawnedGrp = [];
private _QS_module_classic_scriptCreateEnemy = scriptNull;
private _QS_module_classic_enemy_0 = [];
private _QS_module_classic_aoPos = [0,0,0];
private _QS_module_classic_hqPos = [0,0,0];
private _QS_module_classic_aoSize = 0;
private _QS_module_classic_aoData = [];
private _QS_module_classic_spawnedEntities = [];

comment 'classic ao uavs';
private _QS_module_classic_uavEnabled = TRUE;
private _QS_module_classic_uav_delay = 30;
private _QS_module_classic_uav_checkDelay = _QS_uiTime + _QS_module_classic_uav_delay;
private _QS_module_classic_uavs = [];
comment 'classic ao helis';
private _QS_module_classic_heliEnabled = TRUE;
private _QS_module_classic_patrolsHeli_delay = 60;
private _QS_module_classic_patrolsHeli_checkDelay = _QS_uiTime + _QS_module_classic_patrolsHeli_delay;
private _QS_module_classic_patrolsHeli = [];
comment 'classic ao reinforcements';
private _QS_module_classic_infReinforce = TRUE;
private _QS_module_classic_infReinforce_enabled = TRUE;
private _QS_module_classic_infReinforce_delay = 20;
private _QS_module_classic_infReinforce_checkDelay = _QS_uiTime + _QS_module_classic_infReinforce_delay;
private _QS_module_classic_infReinforce_playerThreshold = 15;
private _QS_module_classic_infReinforce_cap = 0;
private _QS_module_classic_infReinforce_cap_0 = 14;
private _QS_module_classic_infReinforce_cap_1 = 24;
private _QS_module_classic_infReinforce_cap_2 = 34;
private _QS_module_classic_infReinforce_cap_3 = 44;
private _QS_module_classic_infReinforce_cap_4 = 54;
private _QS_module_classic_infReinforce_spawned = 0;
private _QS_module_classic_infReinforce_limit = 40;
private _QS_module_classic_infReinforce_limitReal = 0;
private _QS_module_classic_infReinforce_AIThreshold = 60;
private _QS_module_classic_infReinforce_array = [];
comment 'classic ao veh reinforcements';
private _QS_module_classic_vehReinforce = TRUE;
private _QS_module_classic_vehReinforce_enabled = TRUE;
private _QS_module_classic_vehReinforce_delay = 30;
private _QS_module_classic_vehReinforce_checkDelay = _QS_uiTime + _QS_module_classic_vehReinforce_delay;
private _QS_module_classic_vehReinforce_playerThreshold = 15;
private _QS_module_classic_vehReinforce_cap = 0;
private _QS_module_classic_vehReinforce_cap_0 = 0;
private _QS_module_classic_vehReinforce_cap_1 = 1;
private _QS_module_classic_vehReinforce_cap_2 = 1;
private _QS_module_classic_vehReinforce_cap_3 = 2;
private _QS_module_classic_vehReinforce_cap_4 = 2;
private _QS_module_classic_vehReinforce_spawned = 0;
private _QS_module_classic_vehReinforce_limit = 2;
private _QS_module_classic_vehReinforce_limitReal = 0;
private _QS_module_classic_vehReinforce_AIThreshold = 60;
private _QS_module_classic_vehReinforce_array = [];
comment 'classic ao fallback logic';
private _QS_module_classic_efb = FALSE;
private _QS_module_classic_efb_delay = 60;
private _QS_module_classic_efb_checkDelay = _QS_uiTime + _QS_module_classic_efb_delay;
private _QS_module_classic_efb_group = grpNull;
private _QS_module_classic_efb_threshold = 25;
comment 'grid ao';
private _QS_module_grid = (missionNamespace getVariable ['QS_missionConfig_aoType','NONE']) isEqualTo 'GRID';
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

private _QS_module_animalSpawnPosition = [0,0,0];
private _QS_module_civilian = FALSE;
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
comment 'Manage enemy jets';
private _QS_module_enemyCAS = TRUE;
private _QS_module_enemyCAS_delay = 60;
private _QS_module_enemyCAS_checkDelay = _QS_uiTime + _QS_module_enemyCAS_delay;
private _QS_module_enemyCAS_spawnDelay = 900;
private _QS_module_enemyCAS_spawnDelayDefault = 900;
private _QS_module_enemyCAS_checkSpawnDelay = _QS_uiTime + _QS_module_enemyCAS_spawnDelay;
private _QS_module_enemyCas_array = [];
private _QS_module_enemyCas_limit = 0;
private _QS_module_enemyCas_limitHigh = 0;
private _QS_module_enemyCas_limitLow = 0;
private _QS_module_enemyCas_plane = objNull;
comment 'Manage support providers';
private _QS_module_supportProvision = TRUE;
private _QS_module_supportProvision_delay = 60;
private _QS_module_supportProvision_checkDelay = _QS_uiTime + _QS_module_supportProvision_delay;

comment 'Manage custom scripts';
private _QS_module_scripts = TRUE;
private _QS_module_scripts_delay = 15;
private _QS_module_scripts_checkDelay = _QS_uiTime + _QS_module_scripts_delay;
private _QS_module_tracers = TRUE;
private _QS_module_tracers_delay = 600;
private _QS_module_tracers_checkDelay = _QS_uiTime + _QS_module_tracers_delay;
comment 'Targets Knowledge script';
missionNamespace setVariable ['QS_AI_script_targetsKnowledge',([0,EAST] spawn (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')),FALSE];
comment 'Preload Functions';
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
_fn_serverTracers = missionNamespace getVariable 'QS_fnc_serverTracers';
_fn_findRandomPos = missionNamespace getVariable 'QS_fnc_findRandomPos';
_fn_spawnAmbientCivilians = missionNamespace getVariable 'QS_fnc_spawnAmbientCivilians';
_fn_aoAnimals = missionNamespace getVariable 'QS_fnc_aoAnimals';
comment 'Loop';
for '_x' from 0 to 1 step 0 do {
	uiSleep _QS_threadSleep;
	_QS_uiTime = diag_tickTime;
	_QS_time = time;
	/*/Module get general data/*/
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
	};
	/*/Module Dynamic Skill/*/
	if (_QS_module_dynamicSkill) then {
		if (_QS_uiTime > _QS_module_dynamicSkill_checkDelay) then {
			/*/pulled from release build/*/
			_QS_module_dynamicSkill_checkDelay = diag_tickTime + _QS_module_dynamicSkill_delay;
		};
	};
	/*/Module groups/*/
	if (_QS_module_groupBehaviors) then {
		if (_QS_uiTime > _QS_module_groupBehaviors_checkDelay) then {
			{
				_QS_module_groupBehaviors_group = _x;
				if (!isNil {_QS_module_groupBehaviors_group getVariable 'QS_AI_GRP'}) then {
					[_QS_module_groupBehaviors_group,_QS_uiTime,_QS_diag_fps] call _fn_AIHandleGroup;
					uiSleep 0.03;
				};
			} forEach _QS_module_groupBehaviors_localGroups;
			_QS_module_groupBehaviors_checkDelay = diag_tickTime + _QS_module_groupBehaviors_delay;
		};
	};
	/*/Module units/*/
	if (_QS_module_unitBehaviors) then {
		if (_QS_uiTime > _QS_module_unitBehaviors_checkDelay) then {
			{
				_QS_module_unitBehaviors_unit = _x;
				if (_QS_module_unitBehaviors_unit getVariable ['QS_AI_UNIT_enabled',FALSE]) then {
					if (((random 1) > 0.333) || {(_QS_module_unitBehaviors_unit isEqualTo (leader (group _QS_module_unitBehaviors_unit)))}) then {
						[_QS_module_unitBehaviors_unit,_QS_uiTime,_QS_diag_fps] call _fn_AIHandleUnit;
					};
				};
				uiSleep 0.03;
			} forEach _QS_module_unitBehaviors_localUnits;
			_QS_module_unitBehaviors_checkDelay = diag_tickTime + _QS_module_unitBehaviors_delay;
		};
	};
	/*/Module agents/*/
	if (_QS_module_agentBehaviors) then {
		if (_QS_uiTime > _QS_module_agentBehaviors_checkDelay) then {
			{
				_QS_module_agentBehaviors_agent = _x;
				if (!isNil {_QS_module_agentBehaviors_agent getVariable 'QS_AI_ENTITY'}) then {
					if (((random 1) > 0.666) || {(_QS_module_agentBehaviors_agent isKindOf 'CAManBase')}) then {
						[_QS_module_agentBehaviors_agent,_QS_uiTime,_QS_diag_fps] call _fn_AIHandleAgent;
						uiSleep 0.03;
					};
				};
			} forEach _QS_module_agentBehaviors_localAgents;
			_QS_module_agentBehaviors_checkDelay = _QS_uiTime + _QS_module_agentBehaviors_delay;
		};
	};	
	/*/Module virtual sectors/*/
	if (_QS_module_virtualSectors) then {
		if (_QS_uiTime > _QS_module_virtualSectors_checkDelay) then {
			if (missionNamespace getVariable 'QS_virtualSectors_AI_triggerInit') then {
				missionNamespace setVariable ['QS_virtualSectors_AI_triggerInit',FALSE,FALSE];
				_QS_module_virtualSectors_aoPos = missionNamespace getVariable 'QS_AOpos';
				_QS_module_virtualSectors_aoSize = missionNamespace getVariable 'QS_aoSize';
				_QS_module_virtualSectors_vehiclesEnabled = FALSE;
				if ((count(([_QS_module_virtualSectors_aoPos select 0,_QS_module_virtualSectors_aoPos select 1] nearRoads _QS_module_virtualSectors_aoSize) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))})) > 50) then {
					_QS_module_virtualSectors_vehiclesEnabled = TRUE;
				};
				_QS_module_virtualSectors_scriptCreateEnemy = [_QS_module_virtualSectors_vehiclesEnabled] spawn _fn_scEnemy;
				waitUntil {
					uiSleep 0.1;
					(scriptDone _QS_module_virtualSectors_scriptCreateEnemy)
				};
				uiSleep 0.1;
				_QS_module_virtualSectors_enemy_0 = missionNamespace getVariable 'QS_virtualSectors_enemy_0';
				_QS_module_virtualSectors_enemy_1 = missionNamespace getVariable 'QS_virtualSectors_enemy_1';
				_QS_module_virtualSectors_patrolsHeli = _QS_module_virtualSectors_enemy_1 select 0;
				_QS_module_virtualSectors_patrolsInf = _QS_module_virtualSectors_enemy_1 select 1;
				_QS_module_virtualSectors_patrolsVeh = _QS_module_virtualSectors_enemy_1 select 2;
				_QS_module_virtualSectors_patrolsGarrison = _QS_module_virtualSectors_enemy_1 select 3;
				_QS_module_virtualSectors_patrolsBoat = _QS_module_virtualSectors_enemy_1 select 4;
				_QS_module_virtualSectors_patrolsSniper = _QS_module_virtualSectors_enemy_1 select 5;
				_QS_module_virtualSectors_patrolsInf_thresh = round ((count _QS_module_virtualSectors_patrolsInf) / 2);
				_QS_module_virtualSectors_patrolsVeh_thresh = round ((count _QS_module_virtualSectors_patrolsVeh) / 2);
				_QS_module_virtualSectors_patrolsSniper_thresh = round ((count _QS_module_virtualSectors_patrolsSniper) / 2);
				missionNamespace setVariable ['QS_virtualSectors_enemy_0',[],FALSE];
				missionNamespace setVariable ['QS_virtualSectors_enemy_1',[],FALSE];
				if (_QS_module_virtualSectors_assaultEnabled) then {
					if ((random 1) >= _QS_module_virtualSectors_assaultChance) then {
						_QS_module_virtualSectors_assaultReady = TRUE;
						_QS_module_virtualSectors_assaultScore = random [0.5,0.666,0.8];
						_QS_module_virtualSectors_assaultDuration = _QS_module_virtualSectors_assaultDuration_fixed + (random _QS_module_virtualSectors_assaultDuration_variable);
					};
				};
			};
			if (missionNamespace getVariable 'QS_virtualSectors_active') then {
				comment 'General sectors info';
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
				comment 'Manage assault';
				_QS_module_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
				_QS_module_virtualSectors_resultsFactors = missionNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]];
				if (_QS_module_virtualSectors_assaultEnabled) then {
					if (_QS_module_virtualSectors_assaultReady) then {
						if (!(_QS_module_virtualSectors_assaultActive)) then {
							comment 'Assault not active';
							if ((_QS_module_virtualSectors_scoreSides select 1) >= _QS_module_virtualSectors_assaultScore) then {
								_QS_module_virtualSectors_assaultActive = TRUE;
								diag_log '***** QS AI - Sector Assault Active *****';
								
								comment 'Select sector herePick random WEST-owned sector
								';
								_QS_module_virtualSectors_assaultDuration = _QS_uiTime + _QS_module_virtualSectors_assaultDuration_fixed + (random _QS_module_virtualSectors_assaultDuration_variable);
							};
						} else {
							comment 'Assault active';
							if (_QS_diag_tickTimeNow > _QS_module_virtualSectors_assaultDuration) then {
								comment 'Assault terminated';
							} else {
								comment 'Assault active';
							};
						};
					};
				};
				comment 'Manage general area patrols';
				_QS_module_virtualSectors_patrolsInf = _QS_module_virtualSectors_patrolsInf select {(alive _x)};
				if (!(_QS_module_virtualSectors_patrolFallback)) then {
					if ((_QS_module_virtualSectors_scoreSides select 1) >= _QS_module_virtualSectors_scoreEndClose) then {
						_QS_module_virtualSectors_patrolFallback = TRUE;
						diag_log '***** QS AI - Patrol Fall Back *****';
						if (!(_QS_module_virtualSectors_patrolsInf isEqualTo [])) then {
							{
								_QS_grp = group _x;
								if (!isNull _QS_grp) then {
									{
										_QS_unit = _x;
										{
											_QS_unit forgetTarget _x;
										} forEach (_QS_unit targets [TRUE,0]);
										{
											_QS_unit disableAI _x;
										} forEach [
											'AUTOCOMBAT','COVER','SUPPRESSION'
										];
										_QS_unit enableAI 'PATH';
										_QS_unit forceSpeed 24;
										_QS_unit setAnimSpeedCoef 1.15;
										_QS_unit enableStamina FALSE;
										_QS_unit enableFatigue FALSE;
									} count (units _QS_grp);
									{
										_movePos = [_x,(position (leader _QS_grp)),(side _QS_grp)] call _fn_scGetNearestSector;
										if (!(_movePos isEqualTo [])) exitWith {};
									} forEach [2,3];
									if (!(_movePos isEqualTo [])) then {
										_QS_grp setVariable [
											'QS_AI_GRP_CONFIG',
											[
												'SC',
												((_QS_grp getVariable ['QS_AI_GRP_CONFIG',['','','']]) select 1),
												((_QS_grp getVariable ['QS_AI_GRP_CONFIG',['','','']]) select 2)
											],
											FALSE
										];
										_QS_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_movePos,_QS_uiTime,-1],FALSE];
									};
								};
							} forEach _QS_module_virtualSectors_patrolsInf;
						};
					};
					_QS_module_virtualSectors_countAIInfPatrols = count _QS_module_virtualSectors_patrolsInf;
					if (_QS_module_virtualSectors_countAIInfPatrols < (_QS_module_virtualSectors_patrolsInf_thresh - 4)) then {
						if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
							comment 'Spawn more radial inf patrols';
							_QS_module_virtualSectors_spawnedGrp = [-2,_QS_module_virtualSectors_countAIInfPatrols,_QS_module_virtualSectors_patrolsInf_thresh] call _fn_scSpawnGroup;
							if (!(_QS_module_virtualSectors_spawnedGrp isEqualTo [])) then {
								{
									_QS_module_virtualSectors_patrolsInf pushBack _x;
								} forEach (units _QS_module_virtualSectors_spawnedGrp);
								_QS_module_virtualSectors_enemy_1 set [1,_QS_module_virtualSectors_patrolsInf];
							};
						};
					};
				};
				comment 'Manage vehicle patrols';
				if (_QS_module_virtualSectors_vehiclesEnabled) then {
					if (missionNamespace getVariable 'QS_virtualSectors_sub_2_active') then {
						if (_QS_uiTime > _QS_module_virtualSectors_patrolsVeh_checkDelay) then {
							_QS_module_virtualSectors_patrolsVeh = _QS_module_virtualSectors_patrolsVeh select {(alive _x)};
							if (({((alive _x) && (_x isKindOf 'LandVehicle'))} count _QS_module_virtualSectors_patrolsVeh) < 2) then {
								if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
									_QS_module_virtualSectors_spawnedGrp = [0] call _fn_scSpawnLandVehicle;
									if (!(_QS_module_virtualSectors_spawnedGrp isEqualTo [])) then {
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
				comment 'Manage heli patrols';
				if (_QS_diag_fps > 15) then {
					if (_QS_module_virtualSectors_heliEnabled) then {
						if (missionNamespace getVariable 'QS_virtualSectors_sub_2_active') then {
							if (_QS_uiTime > _QS_module_virtualSectors_patrolsHeli_checkDelay) then {
								_QS_module_virtualSectors_patrolsHeli = _QS_module_virtualSectors_patrolsHeli select {(alive _x)};
								if (({((alive _x) && (_x isKindOf 'Helicopter'))} count _QS_module_virtualSectors_patrolsHeli) isEqualTo 0) then {
									if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
										_QS_module_virtualSectors_spawnedGrp = [0] call _fn_scSpawnHeli;
										if (!(_QS_module_virtualSectors_spawnedGrp isEqualTo [])) then {
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
					comment 'Manage UAV patrol';
					if (_QS_module_virtualSectors_uavEnabled) then {
						if (missionNamespace getVariable 'QS_virtualSectors_sub_1_active') then {
							if (_QS_uiTime > _QS_module_virtualSectors_uav_checkDelay) then {
								_QS_module_virtualSectors_uavs = _QS_module_virtualSectors_uavs select {(alive _x)};
								if (({((alive _x) && (unitIsUav _x))} count _QS_module_virtualSectors_uavs) isEqualTo 0) then {
									_QS_module_virtualSectors_spawnedGrp = [] call _fn_scSpawnUAV;
									if (!(_QS_module_virtualSectors_spawnedGrp isEqualTo [])) then {
										{
											_QS_module_virtualSectors_uavs pushBack _x;
										} forEach _QS_module_virtualSectors_spawnedGrp;
									};
								};
								_QS_module_virtualSectors_uav_checkDelay = _QS_uiTime + _QS_module_virtualSectors_uav_delay;
							};
						};
					};
				};
				if (_QS_uiTime > _QS_module_virtualSectors_defenderCheckDelay) then {
					_QS_module_virtualSectors_countAI = 0;
					{
						if (!(_x isEqualTo [])) then {
							_array = _x;
							_array = _array select {(alive _x)};
							_QS_module_virtualSectors_assignedUnits set [_forEachIndex,_array];
							_QS_module_virtualSectors_countAI = _QS_module_virtualSectors_countAI + (count _array);
						};
					} forEach _QS_module_virtualSectors_assignedUnits;
					_QS_module_virtualSectors_data = missionNamespace getVariable 'QS_virtualSectors_data';
					if (!(_QS_module_virtualSectors_data isEqualTo [])) then {
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
							comment 'Manage sector patrols';
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
							_QS_module_virtualSectors_assignedUnitsSector = _QS_module_virtualSectors_assignedUnits select _forEachIndex;
							_QS_module_virtualSectors_countAISector = count _QS_module_virtualSectors_assignedUnitsSector;
							if (_QS_module_virtualSectors_countAISector <= (_QS_module_virtualSectors_maxAISector - _QS_module_virtualSectors_spawnGroupCount)) then {
								comment 'Spawn more AI';
								diag_log '***** AI ***** Spawning sector AI *';
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
						comment 'Fourth block of AI here, spawned all over zone and move between to nearest contested sector';
						_QS_module_virtualSectors_assignedUnitsSector = _QS_module_virtualSectors_assignedUnits select 3;
						_QS_module_virtualSectors_countAISector = count _QS_module_virtualSectors_assignedUnitsSector;
						if (_QS_module_virtualSectors_countAISector <= (_QS_module_virtualSectors_maxAIX - _QS_module_virtualSectors_spawnGroupCount)) then {
							diag_log '***** AI ***** Spawning attackers *';
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
				missionNamespace setVariable ['QS_virtualSectors_AI_triggerDeinit',FALSE,FALSE];
				missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',0,FALSE];
				{
					_QS_module_virtualSectors_assignedUnitsSector = _x;
					{
						if (!isNull _x) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						};
					} forEach _QS_module_virtualSectors_assignedUnitsSector;
				} forEach _QS_module_virtualSectors_assignedUnits;
				_QS_module_virtualSectors_assignedUnits = [[],[],[],[]];
				_QS_module_virtualSectors_assignedUnitsSector = [];
				if (!(_QS_module_virtualSectors_enemy_0 isEqualTo [])) then {
					{
						if (_x isEqualType objNull) then {
							if (!isNull _x) then {
								missionNamespace setVariable [
									'QS_analytics_entities_deleted',
									((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
									FALSE
								];
								deleteVehicle _x;
							};
						};
					} forEach _QS_module_virtualSectors_enemy_0;
					_QS_module_virtualSectors_enemy_0 = [];
				};
				if (!(_QS_module_virtualSectors_enemy_1 isEqualTo [])) then {
					{
						_array = _x;
						if (_array isEqualType []) then {
							if (!(_array isEqualTo [])) then {
								{
									if (_x isEqualType objNull) then {
										if (!isNull _x) then {
											missionNamespace setVariable [
												'QS_analytics_entities_deleted',
												((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
												FALSE
											];
											deleteVehicle _x;
										};
									};
								} forEach _array;
								_array = [];
							};
						};
					} forEach _QS_module_virtualSectors_enemy_1;
					_QS_module_virtualSectors_enemy_1 = [];
				};
				if (!(_QS_module_virtualSectors_uavs isEqualTo [])) then {
					{
						if (_x isEqualType objNull) then {
							if (!isNull _x) then {
								missionNamespace setVariable [
									'QS_analytics_entities_deleted',
									((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
									FALSE
								];
								_x setDamage [1,FALSE];
								uiSleep 0.1;
								deleteVehicle _x;
							};
						};
					} forEach _QS_module_virtualSectors_uavs;
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
				_QS_module_virtualSectors_patrolFallback = FALSE;
				_QS_module_virtualSectors_assaultReady = FALSE;
				_QS_module_virtualSectors_assaultActive = FALSE;
				_QS_module_virtualSectors_assaultArray = [];
			};
		};
	};
	/*/Module classic AOs/*/
	if (_QS_module_classic) then {
		if (_QS_uiTime > _QS_module_classic_checkDelay) then {
			if (missionNamespace getVariable 'QS_classic_AI_triggerInit') then {
				missionNamespace setVariable ['QS_classic_AI_triggerInit',FALSE,FALSE];
				_QS_module_classic_aoPos = missionNamespace getVariable 'QS_AOpos';
				_QS_module_classic_aoSize = missionNamespace getVariable 'QS_aoSize';
				_QS_module_classic_aoData = missionNamespace getVariable 'QS_classic_AOData';
				_QS_module_classic_hqPos = missionNamespace getVariable 'QS_hqPos';
				_QS_module_classic_scriptCreateEnemy = [_QS_module_classic_aoPos,FALSE,_QS_module_classic_aoData,[]] spawn _fn_aoEnemy;
				waitUntil {
					uiSleep 0.1;
					(scriptDone _QS_module_classic_scriptCreateEnemy)
				};
				uiSleep 0.1;
				_QS_module_classic_enemy_0 = missionNamespace getVariable ['QS_classic_AI_enemy_0',[]];
				missionNamespace setVariable ['QS_classic_AI_enemy_0',[],FALSE];
				_QS_module_classic_infReinforce_enabled = (_QS_module_classic_aoData select 8) isEqualTo 1;
				_QS_module_classic_vehReinforce_enabled = (_QS_module_classic_aoData select 9) isEqualTo 1;
				_QS_module_classic_efb = FALSE;
				_QS_module_classic_infReinforce_spawned = 0;
				_QS_module_classic_vehReinforce_spawned = 0;
				_QS_module_classic_efb_checkDelay = _QS_uiTime + 600;
				_QS_module_classic_infReinforce_array = [];
				_QS_module_classic_vehReinforce_array = _QS_module_classic_enemy_0 select {(_x isKindOf 'LandVehicle')};
				_QS_module_classic_patrolsHeli = [];
				_QS_module_classic_uavs = [];
			};
			if (missionNamespace getVariable 'QS_classic_AI_active') then {
				comment 'Enemy inf reinforcements';
				if (_QS_module_classic_infReinforce) then {
					if (_QS_module_classic_infReinforce_enabled) then {
						if (_QS_uiTime > _QS_module_classic_infReinforce_checkDelay) then {
							if (_QS_allUnitsCount < _QS_unitCap) then {
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
									if (({(alive _x)} count _QS_module_classic_infReinforce_array) < _QS_module_classic_infReinforce_limitReal) then {
										if (([_QS_module_classic_aoPos,_QS_module_classic_aoSize,[EAST,RESISTANCE],_QS_allUnits,1] call _fn_serverDetector) < _QS_module_classic_infReinforce_AIThreshold) then {

											diag_log 'QS AO enemy reinforcing';
											
											_QS_module_classic_spawnedEntities = [_QS_module_classic_aoPos] call _fn_aoEnemyReinforce;
											{
												_QS_module_classic_infReinforce_array pushBack _x;
											} forEach _QS_module_classic_spawnedEntities;
											
											if (!(alive (missionNamespace getVariable ['QS_radioTower',objNull]))) then {
												_QS_module_classic_infReinforce_spawned = _QS_module_classic_infReinforce_spawned + 4;
											};
										};
									};
								};
							};
							_QS_module_classic_infReinforce_checkDelay = _QS_uiTime + (random [20,30,40]);
						};
					};
				};
				comment 'Enemy vic reinforcements';
				if (_QS_module_classic_vehReinforce) then {
					if (_QS_module_classic_vehReinforce_enabled) then {
						if (_QS_uiTime > _QS_module_classic_vehReinforce_checkDelay) then {
							if (_QS_allUnitsCount < _QS_unitCap) then {
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
									if (({((alive _x) && (_x isKindOf 'LandVehicle'))} count _QS_module_classic_vehReinforce_array) < _QS_module_classic_vehReinforce_limitReal) then {
										if (([_QS_module_classic_aoPos,_QS_module_classic_aoSize,[EAST,RESISTANCE],_QS_allUnits,1] call _fn_serverDetector) < _QS_module_classic_vehReinforce_AIThreshold) then {
											
											diag_log 'QS AO enemy vehicle reinforcing';
											
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
				comment 'Enemy helo respawning';
				if (_QS_diag_fps > 15) then {
					if (_QS_module_classic_heliEnabled) then {
						if (alive (missionNamespace getVariable 'QS_radioTower')) then {
							if (_QS_uiTime > _QS_module_classic_patrolsHeli_checkDelay) then {
								_QS_module_classic_patrolsHeli = _QS_module_classic_patrolsHeli select {(alive _x)};
								if (({((alive _x) && (_x isKindOf 'Helicopter'))} count _QS_module_classic_patrolsHeli) isEqualTo 0) then {
									if ((count _QS_module_unitBehaviors_localUnits) < _QS_unitCap) then {
										_QS_module_classic_spawnedGrp = [0] call _fn_scSpawnHeli;
										if (!(_QS_module_classic_spawnedGrp isEqualTo [])) then {
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
					comment 'Manage UAV patrol';
					if (_QS_module_classic_uavEnabled) then {
						comment "if (missionNamespace getVariable 'QS_classic_sub_1_active') then {";
							if (_QS_uiTime > _QS_module_classic_uav_checkDelay) then {
								_QS_module_classic_uavs = _QS_module_classic_uavs select {(alive _x)};
								if (({((alive _x) && (unitIsUav _x))} count _QS_module_classic_uavs) isEqualTo 0) then {
									diag_log '***** AI ***** Spawning uav *';
									_QS_module_classic_spawnedGrp = [] call _fn_scSpawnUAV;
									if (!(_QS_module_classic_spawnedGrp isEqualTo [])) then {
										{
											_QS_module_classic_uavs pushBack _x;
										} forEach _QS_module_classic_spawnedGrp;
									};
								};
								_QS_module_classic_uav_checkDelay = diag_tickTime + _QS_module_classic_uav_delay;
							};
						comment "};";
					};
				};
				comment 'Enemy fallback';
				if (_QS_uiTime > _QS_module_classic_efb_checkDelay) then {
					if (!(_QS_module_classic_efb)) then {
						if (([_QS_module_classic_aoPos,_QS_module_classic_aoSize,[EAST],_QS_allUnits,1] call _fn_serverDetector) < _QS_module_classic_efb_threshold) then {
							_QS_module_classic_efb = TRUE;
							{
								_QS_module_classic_efb_group = _x;
								if ((side _QS_module_classic_efb_group) in [EAST,RESISTANCE]) then {
									if (({(alive _x)} count (units _QS_module_classic_efb_group)) > 0) then {
										if (((leader _QS_module_classic_efb_group) distance2D _QS_module_classic_aoPos) < (_QS_module_classic_aoSize * 1.25)) then {
											if (!((vehicle (leader _QS_module_classic_efb_group)) isKindOf 'Air')) then {
												{
													if ((random 1) > 0.5) then {
														_x enableAI 'PATH';
														_x forceSpeed -1;
													};
												} forEach (units _QS_module_classic_efb_group);
												_QS_module_classic_efb_group setSpeedMode 'FULL';
												_QS_module_classic_efb_group setBehaviour 'AWARE';
												_QS_module_classic_efb_group move _QS_module_classic_hqPos;
												_QS_module_classic_efb_group setVariable ['QS_AI_GRP',TRUE,FALSE];
												_QS_module_classic_efb_group setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _QS_module_classic_efb_group))],FALSE];
												_QS_module_classic_efb_group setVariable ['QS_AI_GRP_DATA',[],FALSE];
												_QS_module_classic_efb_group setVariable ['QS_AI_GRP_TASK',['MOVE',_QS_module_classic_hqPos,diag_tickTime,-1],FALSE];
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
					missionNamespace setVariable ['QS_classic_AI_triggerDeinit',FALSE,FALSE];
					missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',0,FALSE];
					if (!(_QS_module_classic_enemy_0 isEqualTo [])) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									if ((_x isKindOf 'Air') || {(_x isKindOf 'LandVehicle')} || {(_x isKindOf 'Ship')}) then {
										_x setDamage [1,FALSE];
									} else {
										if ((_x isKindOf 'Building') || {(_x isKindOf 'House')}) then {
											0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
										} else {
											missionNamespace setVariable [
												'QS_analytics_entities_deleted',
												((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
												FALSE
											];
											deleteVehicle _x;
										};
									};
								};
							};
						} count _QS_module_classic_enemy_0;
						_QS_module_classic_enemy_0 = [];
					};
					if (!(_QS_module_classic_infReinforce_array isEqualTo [])) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									uiSleep 0.05;
									deleteVehicle _x;
								};
							};
						} forEach _QS_module_classic_infReinforce_array;
						_QS_module_classic_infReinforce_array = [];
					};
					if (!(_QS_module_classic_vehReinforce_array isEqualTo [])) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									uiSleep 0.1;
									deleteVehicle _x;
								};
							};
						} forEach _QS_module_classic_vehReinforce_array;
						_QS_module_classic_vehReinforce_array = [];
					};					
					if (!(_QS_module_classic_uavs isEqualTo [])) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									_x setDamage [1,FALSE];
									uiSleep 0.1;
									deleteVehicle _x;
								};
							};
						} forEach _QS_module_classic_uavs;
						_QS_module_classic_uavs = [];
					};
					if (!(_QS_module_classic_patrolsHeli isEqualTo [])) then {
						{
							if (_x isEqualType objNull) then {
								if (!isNull _x) then {
									missionNamespace setVariable [
										'QS_analytics_entities_deleted',
										((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
										FALSE
									];
									_x setDamage [1,FALSE];
									uiSleep 0.1;
									deleteVehicle _x;
								};
							};
						} forEach _QS_module_classic_patrolsHeli;
						_QS_module_classic_patrolsHeli = [];
					};
				};
			};
			_QS_module_classic_checkDelay = diag_tickTime + _QS_module_classic_delay;
		};
	};
	/*/Module Grid/*/
	if (_QS_module_grid) then {
		if (_QS_uiTime > _QS_module_grid_checkDelay) then {
		
			if (missionNamespace getVariable ['QS_grid_AI_triggerDeinit',FALSE]) then {
				diag_log 'QS AI GRID deinit';
				missionNamespace setVariable ['QS_grid_AI_triggerDeinit',FALSE,TRUE];
				missionNamespace setVariable ['QS_grid_AI_active',FALSE,FALSE];
				if (!(_QS_module_grid_enemy isEqualTo [])) then {
					{
						_QS_module_grid_enemy_X = _x;
						{
							deleteVehicle _x;
						} forEach _QS_module_grid_enemy_X;
					} forEach _QS_module_grid_enemy;
					_QS_module_grid_enemy_X = [];
					_QS_module_grid_enemy = [];
				};
				if (!((missionNamespace getVariable ['QS_primaryObjective_civilians',[]]) isEqualTo [])) then {
					{
						if (!isNull _x) then {
							deleteVehicle _x;
						};
					} forEach (missionNamespace getVariable ['QS_primaryObjective_civilians',[]]);
					missionNamespace setVariable ['QS_primaryObjective_civilians',[],FALSE];
				};
				if (!((missionNamespace getVariable ['QS_aoAnimals',[]]) isEqualTo [])) then {
					{
						if (!isNull _x) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						};
					} count (missionNamespace getVariable 'QS_aoAnimals');
					missionNamespace setVariable ['QS_aoAnimals',[],FALSE];
				};
				if (!(_QS_module_grid_defendUnits isEqualTo [])) then {
					{
						deleteVehicle _x;
					} forEach _QS_module_grid_defendUnits;
					_QS_module_grid_defendUnits = [];
				};
			};
			if (missionNamespace getVariable ['QS_grid_AI_triggerInit',FALSE]) then {
				diag_log 'QS AI GRID init';
				missionNamespace setVariable ['QS_grid_AI_triggerInit',FALSE,TRUE];
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
				_QS_module_grid_bldgPatrolUnits = _QS_module_grid_enemy select 1;
				_QS_module_grid_areaPatrolUnits = _QS_module_grid_enemy select 2;
				_QS_module_grid_bldgPatrolRespawnThreshold = (round ((count _QS_module_grid_bldgPatrolUnits) / 1.5)) max 0;
				_QS_module_grid_areaPatrolRespawnThreshold = (round ((count _QS_module_grid_areaPatrolUnits) / 1.5)) max 0;
				comment 'Ambient civilians';
				if (!isNil {_QS_module_grid_terrainData select 4}) then {
					_QS_module_civilian_houseCount = count (_QS_module_grid_terrainData select 4);
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
						missionNamespace setVariable [
							'QS_primaryObjective_civilians',
							([_QS_module_grid_aoPos,_QS_module_grid_aoSize,'FOOT',_QS_module_civilian_count,FALSE,TRUE] call _fn_spawnAmbientCivilians),
							FALSE
						];
					};
				};
				for '_x' from 0 to 2 step 1 do {
					_QS_module_animalSpawnPosition = ['RADIUS',_QS_module_grid_aoPos,(_QS_module_grid_aoSize * 1.25),'LAND',[],FALSE,[],[],FALSE] call _fn_findRandomPos;
					if ((_QS_module_animalSpawnPosition distance2D _QS_module_grid_aoPos) < (_QS_module_grid_aoSize * 1.5)) then {
						[_QS_module_animalSpawnPosition,(selectRandomWeighted ['SHEEP',0.3,'GOAT',0.2,'HEN',0.1]),(round (3 + (random 3)))] call _fn_aoAnimals;
					};
				};
				missionNamespace setVariable ['QS_grid_AI_active',TRUE,FALSE];
			};
			if (missionNamespace getVariable ['QS_grid_AI_active',FALSE]) then {
				if (({(!isNull _x)} count (missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]])) > 0) then {
					if (_QS_uiTime > _QS_module_grid_bldgPatrol_checkDelay) then {
						_QS_module_grid_bldgPatrolUnits = _QS_module_grid_bldgPatrolUnits select {(alive _x)};
						if ((count _QS_module_grid_bldgPatrolUnits) < _QS_module_grid_bldgPatrolRespawnThreshold) then {
							_QS_module_grid_spawnArray = [0,_QS_module_grid_teamSize,_QS_module_grid_aoPos,_QS_module_grid_aoSize,_QS_module_grid_igPos,_QS_module_grid_aoData,_QS_module_grid_terrainData,(missionNamespace getVariable ['QS_grid_enemyRespawnObjects',[]])] call _fn_gridSpawnPatrol;
							if (!(_QS_module_grid_spawnArray isEqualTo [])) then {
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
							if (!(_QS_module_grid_spawnArray isEqualTo [])) then {
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
			if (missionNamespace getVariable ['QS_grid_defend_AIinit',FALSE]) then {
				missionNamespace setVariable ['QS_grid_defend_AIinit',FALSE,TRUE];
			};			
			if (missionNamespace getVariable ['QS_grid_defend_active',FALSE]) then {
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
						if (!(_QS_module_grid_spawnArray isEqualTo [])) then {
							{
								_QS_module_grid_defendUnits pushBack _x;
							} forEach _QS_module_grid_spawnArray;
							_QS_module_grid_spawnArray = [];
						};
					};
					_QS_module_grid_defend_checkDelay = diag_tickTime + _QS_module_grid_defend_delay;
				};
			};
			if (missionNamespace getVariable ['QS_grid_defend_AIdeInit',FALSE]) then {
				missionNamespace setVariable ['QS_grid_defend_AIdeInit',FALSE,TRUE];
				if (!(_QS_module_grid_defendUnits isEqualTo [])) then {
					{
						deleteVehicle _x;
					} forEach _QS_module_grid_defendUnits;
					_QS_module_grid_defendUnits = [];
				};
			};
			_QS_module_grid_checkDelay = _QS_uiTime + _QS_module_grid_delay;
		};
	};
	/*/Module Enemy CAS/*/
	if (_QS_module_enemyCAS) then {
		if (_QS_uiTime > _QS_module_enemyCAS_checkDelay) then {
			if (!(missionNamespace getVariable 'QS_casSuspend')) then {
				if (_QS_diag_fps > 15) then {
					if (((!isNull (missionNamespace getVariable 'QS_radioTower')) && (alive (missionNamespace getVariable 'QS_radioTower'))) || {(missionNamespace getVariable 'QS_virtualSectors_active')} || {(missionNamespace getVariable 'QS_cycleCAS')}) then {
						_QS_module_enemyCas_array = missionNamespace getVariable ['QS_enemyCasArray2',[]];
						if (_QS_allPlayersCount > 15) then {
							if (_QS_allPlayersCount > 30) then {
								_QS_module_enemyCas_limit = _QS_module_enemyCas_limitHigh;
							} else {
								_QS_module_enemyCas_limit = _QS_module_enemyCas_limitLow;
							};
						} else {
							_QS_module_enemyCas_limit = 1;
						};
						if (!isNull (missionNamespace getVariable ['QS_fighterPilot',objNull])) then {
							if (alive (missionNamespace getVariable ['QS_casJet',objNull])) then {
								if ((toLower (typeOf (missionNamespace getVariable 'QS_casJet'))) in ['o_plane_fighter_02_f','o_plane_fighter_02_stealth_f','b_plane_fighter_01_f','b_plane_fighter_01_stealth_f','i_plane_fighter_04_f']) then {
									_QS_module_enemyCas_limit = _QS_module_enemyCas_limit + 1;
									_QS_module_enemyCAS_spawnDelay = 300 + (random 240);
								};
							};
						} else {
							_QS_module_enemyCAS_spawnDelay = _QS_module_enemyCAS_spawnDelayDefault;
						};

						if (_QS_uiTime > _QS_module_enemyCAS_checkSpawnDelay) then {
							if ((count _QS_module_enemyCas_array) < _QS_module_enemyCas_limit) then {
								[] call _fn_enemyCAS;
							};
							_QS_module_enemyCAS_checkSpawnDelay = _QS_uiTime + _QS_module_enemyCAS_spawnDelay;
						};
						_QS_module_enemyCas_array = missionNamespace getVariable ['QS_enemyCasArray2',[]];
						if (!(_QS_module_enemyCas_array isEqualTo [])) then {
							{
								_QS_module_enemyCas_plane = _x;
								if ((!isNull _QS_module_enemyCas_plane) || {(alive _QS_module_enemyCas_plane)}) then {
									if (!isNil {_QS_module_enemyCas_plane getVariable 'QS_enemyCAS_nextRearmTime'}) then {
										if (_QS_uiTime > (_QS_module_enemyCas_plane getVariable 'QS_enemyCAS_nextRearmTime')) then {
											_QS_module_enemyCas_plane setVehicleAmmo 1;
											_QS_module_enemyCas_plane setVariable ['QS_enemyCAS_nextRearmTime',(_QS_uiTime + 600),FALSE];
											
											if (!isNil {_QS_module_enemyCas_plane getVariable 'QS_enemyCAS_position'}) then {
												if (((getPosWorld _QS_module_enemyCas_plane) distance (_QS_module_enemyCas_plane getVariable 'QS_enemyCAS_position')) < 50) then {
													_QS_module_enemyCas_plane setDamage [1,FALSE];
												} else {
													_QS_module_enemyCas_plane setVariable ['QS_enemyCAS_position',(getPosWorld _QS_module_enemyCas_plane),FALSE];
												};
											};
										};	
									};
									if (alive _QS_module_enemyCas_plane) then {
										if (!isNull (driver _QS_module_enemyCas_plane)) then {
											if (!(_QS_allPlayers isEqualTo [])) then {
												{
													if ((vehicle _x) isKindOf 'Plane') then {
														if (_x isEqualTo (driver (vehicle _x))) then {
															(group (driver _QS_module_enemyCas_plane)) reveal [(vehicle _x),4];
															if (isNull (assignedTarget _QS_module_enemyCas_plane)) then {
																(driver _QS_module_enemyCas_plane) doTarget (vehicle _x);
															};
														};
													};
												} count _QS_allPlayers;
											};
										};
									};
								} else {
									if (!isNull _QS_module_enemyCas_plane) then {
										if (!isNil {_QS_module_enemyCas_plane getVariable 'QS_enemyQS_casJetPilot'}) then {
											if (!isNull (_QS_module_enemyCas_plane getVariable 'QS_enemyQS_casJetPilot')) then {
												if (alive (_QS_module_enemyCas_plane getVariable 'QS_enemyQS_casJetPilot')) then {
													(_QS_module_enemyCas_plane getVariable 'QS_enemyQS_casJetPilot') setDamage 1;
												};
											};
										};
									};
									_QS_module_enemyCas_array set [_forEachIndex,FALSE];
									_QS_module_enemyCas_array deleteAt _forEachIndex;
								};
							} forEach _QS_module_enemyCas_array;
						};
						missionNamespace setVariable ['QS_enemyCasArray2',_QS_module_enemyCas_array,FALSE];
					};
				};
			};
			_QS_module_enemyCAS_checkDelay = diag_tickTime + _QS_module_enemyCAS_delay;
		};
	};
	/*/Module support provision/*/
	if (_QS_module_supportProvision) then {
		if (_QS_uiTime > _QS_module_supportProvision_checkDelay) then {
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_MTR') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_MTR',((missionNamespace getVariable 'QS_AI_supportProviders_MTR') select {((alive _x) && ((vehicle _x) isKindOf 'StaticWeapon'))}),FALSE];
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_ARTY',((missionNamespace getVariable 'QS_AI_supportProviders_ARTY') select {((alive _x) && ((vehicle _x) isKindOf 'LandVehicle'))}),FALSE];
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASHELI',((missionNamespace getVariable 'QS_AI_supportProviders_CASHELI') select {((alive _x) && ((vehicle _x) isKindOf 'Helicopter'))}),FALSE];			
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASPLANE',((missionNamespace getVariable 'QS_AI_supportProviders_CASPLANE') select {((alive _x) && ((vehicle _x) isKindOf 'Plane') && (canMove (vehicle _x)))}),FALSE];			
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_CASUAV',((missionNamespace getVariable 'QS_AI_supportProviders_CASUAV') select {((alive _x) && (unitIsUav (vehicle _x)) && (canMove (vehicle _x)))}),FALSE];			
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_supportProviders_INTEL',((missionNamespace getVariable 'QS_AI_supportProviders_INTEL') select {(alive _x)}),FALSE];
			};
			_QS_module_supportProvision_checkDelay = diag_tickTime + _QS_module_supportProvision_delay;
		};
	};
	if (_QS_module_scripts) then {
		if (_QS_uiTime > _QS_module_scripts_checkDelay) then {
			missionNamespace setVariable ['QS_AI_insertHeli_helis',((missionNamespace getVariable 'QS_AI_insertHeli_helis') select {(!isNull _x)}),FALSE];
			if (!((missionNamespace getVariable 'QS_AI_scripts_Assault') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_scripts_Assault',((missionNamespace getVariable 'QS_AI_scripts_Assault') select {(!isNull _x)}),FALSE];
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_scripts_fireMissions') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') select {(!isNull _x)}),FALSE];
			};
			uiSleep 0.1;			
			if (!((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_scripts_moveToBldg',((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') select {(!isNull _x)}),FALSE];
			};
			uiSleep 0.1;
			if (!((missionNamespace getVariable 'QS_AI_unitsGestureReady') isEqualTo [])) then {
				missionNamespace setVariable ['QS_AI_unitsGestureReady',((missionNamespace getVariable 'QS_AI_unitsGestureReady') select {((alive _x) && (_x getVariable ['QS_AI_UNIT_gestureEvent',FALSE]))}),FALSE];
			};
			if (_QS_module_tracers) then {
				if (_QS_uiTime > _QS_module_tracers_checkDelay) then {
					if ((!(sunOrMoon isEqualTo 1)) || {(_QS_allPlayersCount < 20)}) then {
						[_QS_module_unitBehaviors_localUnits] spawn _fn_serverTracers;
					};
					_QS_module_tracers_checkDelay = _QS_uiTime + _QS_module_tracers_delay;
				};
			};
			_QS_module_scripts_checkDelay = _QS_uiTime + _QS_module_scripts_delay;
		};
	};
};