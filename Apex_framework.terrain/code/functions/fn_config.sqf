/*/
File: config.sqf
Author:

	Quiksilver
	
Last modified: 

	7/03/2024 A3 2.18 by Quiksilver

Description:

	Configure Server
____________________________________________________/*/

missionNamespace setVariable ['QS_system_devBuild_text',(format ['Apex Framework %1 %3 (%2)',getMissionConfigValue ['missionProductVersion',''],getMissionConfigValue ['missionProductStatus',''],getMissionConfigValue ['missionProductDate','']]),TRUE];
diag_log str QS_system_devBuild_text;
private [
	'_year','_month','_day','_hour','_minute','_n','_QS_currentWeatherData','_spawnPoint_1',
	'_aoSize','_flagTextureFriendly','_flagTextureEast','_flagTextureWest','_flagTextureResistance','_flagTextureCivilian',
	'_flagTextureUnknown','_teamspeak','_website','_ah','_markers','_environment','_simple','_worldName','_result'
];
{
	diag_log _x;
} count [
	'*****************************************************************************',
	'************************* Server Config Starting ****************************',
	'*****************************************************************************',
	(format ['***** System Time: %1 * Product Version: %2 * Mission Name: %3 * Server Name: %4 * Briefing Name: %5 * Mission Version: %6 * Mission Difficulty: %7 * Mission DLCs: %8 * Distribution Region: %9 *****',systemTime,productVersion,missionName,serverName,briefingName,missionVersion,missionDifficulty,getMissionDLCs,distributionRegion]),
	'*****************************************************************************'
];
diag_log '***** Difficulty Options 0 *****';
{
	diag_log _x;
} forEach (difficultyOption []);
diag_log '***** Difficulty Options 1 *****';
diag_log format ['***** Mission Profile Namespace Loaded - %1 *****',isMissionProfileNamespaceLoaded];
if (!isMissionProfileNamespaceLoaded) then {
	saveMissionProfileNamespace;
	diag_log format ['***** Mission Profile Namespace Loaded - %1 *****',isMissionProfileNamespaceLoaded];
};
if (!isDedicated) exitWith {
	diag_log '***** SETUP ERROR * Server must be Dedicated *';
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['Server must be Dedicated'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 
	] remoteExec ['call',-2,TRUE];
};
if (((productVersion # 7) isNotEqualTo 'x64') && ((productVersion # 6) isNotEqualTo 'Linux')) exitWith {
	diag_log '***** SETUP ERROR * Server must be x64 or Linux *';
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['Server must be running 64-bit'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 	
	] remoteExec ['call',-2,TRUE];
};
if (!isFilePatchingEnabled) exitWith {
	diag_log '***** SETUP ERROR * File patching must be enabled *';
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['-filePatching must be enabled in Server launch options'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 
	] remoteExec ['call',-2,TRUE];
};
private _difficultyData = [];
private _difficultyInvalid = FALSE;
{
	_difficultyData = _x;
	_difficultyData params [
		'_difficultyFlag',
		'_difficultyValue'
	];
	if ((difficultyOption _difficultyFlag) isNotEqualTo _difficultyValue) exitWith {
		_difficultyInvalid = TRUE;
		{
			diag_log _x;
		} forEach [
			'******************************',
			'***** INVALID DIFFICULTY *****',
			'******************************',
			(format ['* Difficulty Option %1 is %2, must be %3 *',_difficultyFlag,(difficultyOption _difficultyFlag),_difficultyValue]),
			'******************************'
		];
	};
} forEach [
	['mapContent',0],
	['mapContentEnemy',0],
	['mapContentFriendly',0],
	['deathMessages',0],
	['autoReport',0],
	['enemyTags',0],
	['friendlyTags',0],
	['groupIndicators',0],
	['waypoints',0]
];
if (_difficultyInvalid) exitWith {
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['Invalid mission difficulties, view server RPT log file for more details'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 
	] remoteExec ['call',-2,TRUE];
};
private _addonActive = FALSE;
private _patchClass = configNull;
_binConfigPatches = configFile >> 'CfgPatches';
for '_i' from 0 to ((count _binConfigPatches) - 1) step 1 do {
	_patchClass = _binConfigPatches select _i;
	if (isClass _patchClass) then {
		if ((configName _patchClass) isEqualTo 'apex_server') then {
			_addonActive = TRUE;
		};
	};
	if (_addonActive) exitWith {};
};
if (!(_addonActive)) exitWith {
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['Apex Framework servermod @Apex must be active'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 
	] remoteExec ['call',-2,TRUE];
};
if (uiNamespace isNil 'QS_fnc_serverCommandPassword') exitWith {
	[
		[],
		{
			0 spawn {
				for '_x' from 0 to 1 step 0 do {
					['Apex Framework config files missing: @Apex_cfg'] call (missionNamespace getVariable 'QS_fnc_hint');
					uisleep 1;
				};
			};
		} 
	] remoteExec ['call',-2,TRUE];
};

missionNamespace setVariable ['QS_server_isUsingDB',FALSE,FALSE];

/*/ EXTDB3 - Database - Server Setup component would go here /*/

// Server Event Handler
serverNamespace setVariable ['QS_fnc_serverEventHandler',compileScript ["code\functions\fn_serverEventHandler.sqf",TRUE]];

/*/ If default base is selected, remove everything /*/
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	deleteVehicle ((allMissionObjects '') select {
		(
			(!isNull _x) &&
			(!(_x isKindOf 'Logic')) &&
			(!(_x getVariable ['QS_missionObject_protected',FALSE]))
		)
	});
	{
		deleteMarker _x;
	} forEach allMapMarkers;
};
setMissionOptions (createHashMapFromArray [['IgnoreNoDamage', TRUE], ['IgnoreFakeHeadHit', TRUE]]);
enableDynamicSimulationSystem TRUE;
enableEnvironment [FALSE,FALSE,0];
enableEngineArtillery TRUE;
disableRemoteSensors TRUE;
calculatePlayerVisibilityByFriendly FALSE;
useAISteeringComponent FALSE;
setViewDistance 2500;
setObjectViewDistance 2500;
setShadowDistance 0;
setTerrainGrid 50;
{
	(_x # 0) enableAIFeature (_x # 1);
} forEach [
	['CombatFormationSoft',FALSE],			// ---- this fucks up AI behaviours
	['AwareFormationSoft',TRUE]
];
{EAST setFriend _x;} forEach [[RESISTANCE,1],[WEST,0],[CIVILIAN,1]];
{WEST setFriend _x;} forEach [[CIVILIAN,1],[EAST,0],[RESISTANCE,0]];
{RESISTANCE setFriend _x;} forEach [[EAST,1],[WEST,0],[CIVILIAN,1]];
{CIVILIAN setFriend _x;} forEach [[WEST,1],[EAST,1],[RESISTANCE,1]];
_worldName = worldName;
if (_worldName isEqualTo 'Altis') then {
	{
		_x setAirportSide WEST;
	} forEach (allAirports # 0);		/*/0 = Airbase 1 = AAC Airfield 2 = Krya Nera Airstrip 3 = Selakeno Airfield 4 = Molos Airfield 5 = Almyra Salt Lake Airstrip/*/
};
if (_worldName isEqualTo 'Tanoa') then {
	{
		_x setAirportSide WEST;
	} forEach (allAirports # 0);			/*/0 = Aeroport de Tanoa 1 = Tuvanaka Airbase 2 = Saint-George Airstrip 3 = Bala Airstrip 4 = La Rochelle Aerodome /*/
};
if (_worldName isEqualTo 'Malden') then {
	{
		_x setAirportSide WEST;
	} forEach (allAirports # 0);
};
if (_worldName isEqualTo 'Enoch') then {
	{
		_x setAirportSide WEST;
	} forEach (allAirports # 0);
};
_environment = ['mediterranean','tropic'] select (_worldName in ['Tanoa','Lingor3','Enoch']);

/*/==================== MISSION NAMESPACE VARS/*/

(missionNamespace getVariable 'bis_functions_mainscope') setVariable ['bis_fnc_moduleInit_modules',[],FALSE];
_spawnPoint_1 = [0,0,0];
if (_worldName isEqualTo 'Altis') then {_spawnPoint_1 = [14628.6,16769.3,17.9114];};
if (_worldName isEqualTo 'Tanoa') then {_spawnPoint_1 = [6929.65,7380.26,2.66144];};
if (_worldName isEqualTo 'Malden') then {_spawnPoint_1 = [0,0,0];};
_spawnPoint_1 = [0,worldSize,0];
_aoSize = 800;	/*/ AO Circle Radius /*/
if (_worldName isEqualTo 'Altis') then {_aoSize = 800;};
if (_worldName isEqualTo 'Tanoa') then {_aoSize = 600;};
if (_worldName isEqualTo 'Malden') then {_aoSize = 300;};
if (_worldName isEqualTo 'Enoch') then {_aoSize = 500;};
_flagTextureEast = 'a3\data_f\flags\flag_csat_co.paa';
_flagTextureWest = (missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']);
_flagTextureResistance = 'a3\data_f\flags\flag_aaf_co.paa';
_flagTextureCivilian = 'a3\data_f\flags\flag_altis_co.paa';
_flagTextureUnknown = 'a3\data_f\flags\flag_uno_co.paa';
if (_worldName in ['Altis','Tanoa','Malden','Enoch']) then {
	_flagTextureEast = 'a3\data_f\flags\flag_csat_co.paa';
	_flagTextureWest = (missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']);
	_flagTextureResistance = 'a3\data_f\flags\flag_aaf_co.paa';
	_flagTextureCivilian = 'a3\data_f\flags\flag_altis_co.paa';
	_flagTextureUnknown = 'a3\data_f\flags\flag_uno_co.paa';
};
_sidesFlagsTextures = [
	[_flagTextureEast,_flagTextureWest,_flagTextureResistance,_flagTextureCivilian,_flagTextureUnknown],
	[_flagTextureEast,_flagTextureWest,'\a3\Data_F_Exp\Flags\flag_SYND_CO.paa','a3\data_f_exp\flags\flag_tanoa_co.paa',_flagTextureUnknown]
] select (_worldName isEqualTo 'Tanoa');
_ah = TRUE;
_flagTextureFriendly = (missionNamespace getVariable ['QS_missionConfig_textures_defaultFlag','a3\data_f\flags\flag_nato_co.paa']);
_teamspeak = '-teamspeak address-    Password:   -teamspeak password-';
_website = '-website-';
private _sectorAreaObjects = [];
if ((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isEqualTo 'SC') then {
	_sectorAreaObjects = [
		[
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast200m.p3d',[-1000,-1000,0]])
			],
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest200m.p3d',[-1000,-1000,0]])
			]
		],
		[
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast200m.p3d',[-1000,-1000,0]])
			],
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest200m.p3d',[-1000,-1000,0]])
			]
		],
		[
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorEast200m.p3d',[-1000,-1000,0]])
			],
			[
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest100m.p3d',[-1000,-1000,0]]),
				(createSimpleObject ['a3\Modules_F_Curator\Multiplayer\surfaceSectorWest200m.p3d',[-1000,-1000,0]])
			]
		]
	];
};
private _medicalGarbage = [];
_medicalGarbageData = [
	'a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_1x1_v1_f.p3d',0.333,
	'a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_1x1_v2_f.p3d',0.333,
	'a3\props_f_orange\humanitarian\garbage\medicalgarbage_01_1x1_v3_f.p3d',0.333
];
for '_x' from 0 to 11 step 1 do {
	_medicalGarbage pushBack (createSimpleObject [(selectRandomWeighted _medicalGarbageData),[-1000,-1000,0]]);
};
{
	uiNamespace setVariable _x;
} forEach [
	['QS_roles_handler',[]],
	['QS_virtualCargo_handler',[]]
];
private _weaponsList = configFile >> 'CfgWeapons';
// Mission Namespace
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_initRespawn_disconnect',-1,FALSE],
	['BIS_fnc_drawMinefields_active',TRUE,FALSE],
	['BIS_dg_fia','BI',TRUE],
	['BIS_dynamicGroups_allowInterface',TRUE,TRUE],
	['RscSpectator_allowedGroups',[],TRUE],
	['RscSpectator_allowFreeCam',FALSE,TRUE],
	['QS_hashmap_playerList',createHashMap,FALSE],
	['QS_hashmap_configfile',createHashMap,FALSE],
	['QS_headlessClients',[],FALSE],
	['QS_HC_Active',FALSE,FALSE],
	['QS_terrain_worldArea',[[(worldSize / 2),(worldSize / 2),0],(worldSize / 2),(worldSize / 2),0,TRUE,-1],TRUE],
	['QS_RSS_enabled',TRUE,TRUE],
	['QS_RSS_client_canSideSwitch',((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0),TRUE],
	['QS_missionConfig_restartHours',(missionNamespace getVariable ['QS_missionConfig_restartHours',[0,6,12,18]]),FALSE],
	['QS_mission_aoType',(missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']),TRUE],
	['QS_system_realTimeStart',systemTime,TRUE],
	['QS_carrierObject',objNull,TRUE],
	['QS_AI_dynSkill_coef',0,TRUE],
	['QS_CAS_jetAllowance_value',3,TRUE],
	['QS_CAS_jetAllowance_current',0,FALSE],
	['QS_CAS_jetAllowance',[],FALSE],
	['QS_CAS_jetAllowance_gameover',FALSE,FALSE],
	['QS_fighterPilot',objNull,FALSE],
	['QS_casJet_destroyedAtBase',FALSE,FALSE],
	['QS_casJet_destroyedAtBase_type','',FALSE],
	['QS_cas_uav',objNull,FALSE],
	['QS_analytics_fps',[],FALSE],
	['QS_server_fps',0,TRUE],
	['QS_analytics_playercount',[],FALSE],
	['QS_analytics_entities_created',0,FALSE],
	['QS_analytics_entities_deleted',0,FALSE],
	['QS_analytics_entities_respawned',0,FALSE],
	['QS_analytics_entities_killed',0,FALSE],
	['QS_analytics_entities_recycled',0,FALSE],
	['QS_analytics_groups_created',0,FALSE],
	['QS_analytics_groups_deleted',0,FALSE],
	['QS_armedAirEnabled',TRUE,TRUE],
	['QS_var_debug',FALSE,FALSE],
	['QS_serverKey','abc123',TRUE],
	['QS_teamspeak_address',_teamspeak,TRUE],
	['QS_community_website',_website,TRUE],
	['QS_chat_messages',(call (compileScript ['@Apex_cfg\chatMessages.sqf',FALSE])),FALSE],
	['QS_pilot_whitelist',{[]},TRUE],
	['QS_cls_whitelist',{[]},TRUE],
	['QS_sniper_whitelist',{[]},TRUE],
	['QS_pilot_blacklist',[],TRUE],
	['QS_spectator_whitelist',[],TRUE],
	['QS_arsenals',[],TRUE],
	['QS_billboards',[],FALSE],
	['QS_activeRegion',-1,FALSE],
	['QS_HC_AO_enemyArray',[],TRUE],
	[
		'QS_radioChannels',
		[
			(radioChannelCreate [[0.4,1,1,1],'Side channel (No voice)','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,0.4,1,1],'Aircraft channel','%UNIT_VEH_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[0.4,1,0.4,1],'Primary AO channel','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,1,0.4,1],'Secondary AO channel','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,0.4,0.4,1],'PLT Alpha channel','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,0.4,0.4,1],'PLT Bravo channel','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,0.4,0.4,1],'PLT Charlie channel','%UNIT_GRP_NAME ' + '(%UNIT_NAME)',[],TRUE]),
			(radioChannelCreate [[1,0.6,0.2,1],'General channel','%UNIT_NAME',[],TRUE])
		],
		TRUE
	],
	['QS_enemyGroundReinforceArray',[],TRUE],
	['QS_enemyVehicleReinforcementsArray',[],TRUE],
	['QS_enemyVehicleReinforcements_crew',[],TRUE],
	['QS_enemyJungleCamp_array',[],FALSE],
	['QS_defendActive',FALSE,TRUE],
	['QS_sideMission_enemyArray',[],TRUE],
	['QS_AOpos',[0,0,0],TRUE],
	['QS_HQpos',[0,0,0],TRUE],
	['QS_csatCommander',objNull,TRUE],
	['QS_AO_HQ_flag',objNull,FALSE],
	['QS_Billboard_02',objNull,TRUE],
	['QS_registeredPositions',[],FALSE],
	['QS_enemiesCaptured_AO',0,FALSE],
	['QS_sideMission_POW',objNull,TRUE],
	//['QS_curator_revivePoints',10,TRUE],
	['QS_evacPosition_1',[0,0,0],TRUE],
	['QS_evacPosition_2',[0,0,0],TRUE],
	['QS_radioTower',objNull,FALSE],
	['QS_radioTower_pos',[0,0,0],FALSE],
	['QS_artilleryUnlock',0,FALSE],
	['QS_fires',[],TRUE],
	['QS_firesStuff',[],FALSE],
	['QS_defendCount',0,TRUE],
	['QS_mission_fobEnabled',FALSE,TRUE],
	['QS_allowedHUD_EAST',[TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE],TRUE],
	['QS_allowedHUD_WEST',[TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE],TRUE],
	['QS_allowedHUD_RESISTANCE',[TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE],TRUE],
	['QS_allowedHUD_CIVILIAN',[TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE],TRUE],
	['QS_allowedHUD_sideUnknown',[FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE],TRUE],
	['QS_AH_enabled',_ah,TRUE],
	['QS_torch',objNull,TRUE],
	['QS_aoDisplayName','',TRUE],
	['QS_aoSuspended',FALSE,TRUE],
	['QS_aoCycleVar',FALSE,FALSE],
	['QS_forceSideMission',FALSE,FALSE],
	['QS_smSuspend',FALSE,TRUE],
	['QS_cycleCAS',FALSE,FALSE],
	['QS_casSuspend',FALSE,FALSE],
	['QS_smSuccess',FALSE,FALSE],
	['QS_forceNightVote',FALSE,FALSE],
	['QS_forceDefend',0,TRUE],
	['QS_heartAttacks',0,TRUE],
	['QS_mainao_firstRun',TRUE,FALSE],
	['QS_commanderAlive',FALSE,FALSE],
	['QS_module_recAI_array',[],TRUE],
	['QS_lamps',[],FALSE],
	['QS_garbageCollector',[],FALSE],
	['QS_forceWeatherChange',FALSE,FALSE],
	['QS_weatherSync',TRUE,FALSE],
	['QS_airbaseDefense',FALSE,TRUE],
	['QS_base_safePolygon',(call (compileScript ['code\config\QS_data_baseRestrictedArea.sqf',FALSE])),TRUE],
	['QS_enemyCasArray2',[],FALSE],
	['QS_uavRespawnTimeout',0,FALSE],
	['QS_uavCanSpawn',TRUE,TRUE],
	['QS_drone_heli_enabled',TRUE,TRUE],
	['QS_drone_heli_spawned',FALSE,TRUE],
	['QS_nightInProgress',FALSE,FALSE],
	['QS_RD_mission_objectives',[],TRUE],
	['QS_vehicleRespawnCount',0,FALSE],
	['QS_playerKilledCountServer',0,FALSE],
	['QS_playerRespawnCountServer',0,FALSE],
	['QS_mission_urban_active',FALSE,TRUE],
	['QS_mission_urban_objectsSecured',0,FALSE],
	['QS_enemyCasArray',[],FALSE],
	['QS_enemyCasGroup',grpNull,FALSE],
	['QS_casJet',objNull,FALSE],
	['QS_aoSize',_aoSize,TRUE],
	['QS_staff_requestBaseCleanup_time',0,FALSE],
	['QS_robocop',createHashMap,FALSE],
	['QS_panel_support',objNull,TRUE],
	['QS_smReward_array',[5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,23,24,25,26,27,29,30,31],FALSE],
	['QS_ao_aaMarkers',[],FALSE],
	['QS_module_fob_enabled',TRUE,TRUE],
	['QS_module_fob_centerPosition',[0,0,0],FALSE],
	['QS_module_fob_HQ',objNull,TRUE],
	['QS_module_fob_displayName','',TRUE],
	['QS_module_fob_vehicleRespawnEnabled',FALSE,TRUE],
	['QS_module_fob_respawnEnabled',FALSE,TRUE],
	['QS_module_fob_services_fuel',FALSE,TRUE],
	['QS_module_fob_services_repair',FALSE,TRUE],
	['QS_module_fob_services_ammo',FALSE,TRUE],
	['QS_module_fob_dataTerminal',objNull,TRUE],
	['QS_module_fob_baseTerminal',objNull,TRUE],
	['QS_module_fob_baseDataTerminal',objNull,TRUE],
	['QS_module_fob_attacked',FALSE,TRUE],
	['QS_module_fob_side',sideUnknown,TRUE],
	['QS_module_fob_flag',objNull,TRUE],
	['QS_module_fob_supplycrate',objNull,FALSE],
	['QS_module_fob_assaultArray',[],FALSE],
	['QS_module_fob_flag_textures',['a3\data_f\flags\flag_csat_co.paa',_flagTextureFriendly,'a3\data_f\flags\flag_aaf_co.paa','a3\data_f\flags\flag_altis_co.paa','a3\data_f\flags\flag_uno_co.paa'],FALSE],
	['QS_module_fob_repairDepot',objNull,FALSE],
	['QS_module_upload_device',objNull,FALSE],
	['QS_module_upload_flag',objNull,FALSE],
	['QS_module_upload_intel_1',objNull,FALSE],
	['QS_module_upload_intel_2',objNull,FALSE],
	['QS_module_upload_intel_3',objNull,FALSE],
	['QS_module_upload_carrier_1',objNull,FALSE],
	['QS_module_upload_carrier_2',objNull,FALSE],
	['QS_module_upload_carrier_3',objNull,FALSE],
	['QS_module_upload_carriers',[],FALSE],
	['QS_module_upload_uploaded',0,FALSE],
	['QS_module_upload_active',FALSE,FALSE],
	['QS_baseProtection_polygons',[],TRUE],
	['QS_base_lamps',TRUE,TRUE],
	['QS_sectorScan_lastTime',time,TRUE],
	['QS_hc_Commander',objNull,TRUE],
	['QS_arrest_target',objNull,TRUE],
	['QS_aoSmallTask_Arrested',FALSE,TRUE],
	['QS_draw3D_projectiles',[],TRUE],
	['QS_client_customDraw2D',[],TRUE],
	['QS_client_customDraw3D',[],TRUE],
	['QS_uavMission_usedPositions',[[-1000,-1000,0]],FALSE],
	['QS_sideMission_vehicle',objNull,TRUE],
	['QS_virtualSectors_scoreWin',300,TRUE],
	['QS_virtualSectors_scoreSides',[0,0,0,0,0],TRUE],
	['QS_virtualSectors_defCoef',2,FALSE],
	['QS_virtualSectors_startTime',0,FALSE],
	['QS_virtualSectors_duration',0,FALSE],
	['QS_virtualSectors_enabled',FALSE,TRUE],
	['QS_virtualSectors_active',FALSE,FALSE],
	['QS_virtualSectors_data',[],FALSE],
	['QS_virtualSectors_data_public',[],TRUE],
	['QS_virtualSectors_data_AI',[],FALSE],
	['QS_virtualSectors_positions',[],TRUE],
	['QS_virtualSectors_centroid',[],FALSE],
	['QS_virtualSectors_midpoints',[],FALSE],
	['QS_virtualSectors_entities',[],FALSE],
	['QS_virtualSectors_locations',[],FALSE],
	['QS_virtualSectors_enemy_0',[],FALSE],
	['QS_virtualSectors_enemy_1',[],FALSE],
	['QS_virtualSectors_subObjectives',[],FALSE],
	['QS_virtualSectors_script',scriptNull,FALSE],
	['QS_virtualSectors_validLifestates',['HEALTHY','INJURED'],FALSE],
	['QS_virtualSectors_sides',[EAST,WEST,RESISTANCE,CIVILIAN,sideUnknown],FALSE],
	['QS_virtualSectors_sidesFlagsTextures',_sidesFlagsTextures,FALSE],
	['QS_virtualSectors_sidesUIColors',[[0.5,0,0,0.65],[0,0.3,0.6,0.65],[0,0.5,0,0.65],[0.4,0,0.5,0.65],[0.7,0.6,0,0.5]],FALSE],
	['QS_virtualSectors_sidesUIIcons',[],FALSE],
	['QS_virtualSectors_regionUsedPositions',[[-1000,-1000,0]],FALSE],
	['QS_virtualSectors_regionUsedRefPositions',[[-1000,-1000,0]],FALSE],
	['QS_virtualSectors_lastReferencePosition',[-1000,-1000,0],FALSE],
	['QS_virtualSectors_lastReferenceCentroid',[-1000,-1000,0],FALSE],
	['QS_virtualSectors_sectorObjects',_sectorAreaObjects,TRUE],
	['QS_virtualSectors_assignedUnits',[[],[],[],[]],FALSE],
	['QS_virtualSectors_AI_triggerInit',FALSE,FALSE],
	['QS_virtualSectors_AI_triggerDeinit',FALSE,FALSE],
	['QS_virtualSectors_sub_1_obj',objNull,TRUE],
	['QS_virtualSectors_sub_2_obj',objNull,TRUE],
	['QS_virtualSectors_sub_3_obj',objNull,TRUE],
	['QS_virtualSectors_sub_1_active',FALSE,FALSE],
	['QS_virtualSectors_sub_2_active',FALSE,FALSE],
	['QS_virtualSectors_sub_3_active',FALSE,FALSE],
	['QS_virtualSectors_sub_1_markers',[],FALSE],
	['QS_virtualSectors_sub_2_markers',[],FALSE],
	['QS_virtualSectors_sub_3_markers',[],FALSE],
	['QS_virtualSectors_siteMarkers',[],FALSE],
	['QS_virtualSectors_hiddenTerrainObjects',[],FALSE],
	['QS_virtualSectors_sd_marker',[],FALSE],
	['QS_virtualSectors_sd_position',[0,0,0],FALSE],
	['QS_virtualSectors_bonusCoef_subTask',0.05,FALSE],
	['QS_virtualSectors_bonusCoef_smallTask',0.05,FALSE],
	['QS_virtualSectors_bonusCoef_sideTask',0.1,FALSE],
	['QS_virtualSectors_resultsFactors',(missionProfileNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]]),FALSE],
	['QS_virtualSectors_resultsCoef',[0.01,0.02,0.03],FALSE],
	['QS_setFeatureType',[],TRUE],
	['QS_missionStatus_SC_canShow',FALSE,TRUE],
	['QS_customAO_script',scriptNull,FALSE],
	['QS_customAO_active',FALSE,FALSE],
	['QS_customAO_GT_active',FALSE,TRUE],
	['QS_customAO_blockSideMissions',FALSE,FALSE],
	['QS_AI_scripts_Assault',[],FALSE],
	['QS_AI_scripts_moveToBldg',[],FALSE],
	['QS_AI_scripts_fireMissions',[],FALSE],
	['QS_AI_scripts_support',[],FALSE],
	['QS_AI_script_targetsKnowledge',scriptNull,FALSE],
	['QS_AI_GRP_AO_AA',grpNull,FALSE],
	['QS_AI_supportProviders_MTR',[],FALSE],
	['QS_AI_supportProviders_CASHELI',[],FALSE],
	['QS_AI_supportProviders_CASPLANE',[],FALSE],
	['QS_AI_supportProviders_CASUAV',[],FALSE],
	['QS_AI_supportProviders_ARTY',[],FALSE],
	['QS_AI_supportProviders_INTEL',[],FALSE],
	['QS_AI_hostileBuildings',[],FALSE],
	['QS_AI_fireMissions',[],FALSE],
	['QS_AI_weaponMagazines',[],TRUE],
	['QS_client_showKnownEnemies',TRUE,TRUE],
	['QS_client_showStealthEnemies',FALSE,TRUE],
	['QS_enemy_mortarFireMessage',diag_tickTime,FALSE],
	['QS_enemy_artyFireMessage',diag_tickTime,FALSE],
	['QS_georgetown_vExclusion_polygon',[[5588.88,10242.2,4.16775],[5807.1,10171,0.00125599],[5895.19,10388.9,0.0247574],[5844.87,10701.6,0.110656],[5724.18,10706,0.00174642],[5634.55,10656.1,8.57687]],FALSE],
	['QS_AI_targetsKnowledge_EAST',[],FALSE],
	['QS_medical_garbage',_medicalGarbage,TRUE],
	['QS_medical_garbage_backup',_medicalGarbage,FALSE],
	['QS_medical_garbage_enabled',TRUE,TRUE],
	['QS_medical_garbage_script',scriptNull,FALSE],
	['QS_server_dynSim',((missionNamespace getVariable ['QS_missionConfig_dynSim',1]) isEqualTo 1),TRUE],
	['QS_ao_civVehicles',[],FALSE],
	['QS_module_dynamicTasks_add',[],FALSE],
	['QS_dynTask_medevac_inProgress',FALSE,TRUE],
	['QS_dynTask_medevac_array',[],FALSE],
	['QS_primaryObjective_civilians',[],FALSE],
	['QS_recycler_units',FALSE,FALSE],
	['QS_recycler_unitCount',15,FALSE],
	['QS_recycler_nullGrp',grpNull,FALSE],
	['QS_recycler_objects',[[],[],[]],FALSE],
	['QS_recycler_position',[-1100,-1100,0],FALSE],
	['QS_AI_insertHeli_enabled',TRUE,TRUE],
	['QS_AI_insertHeli_maxHelis',3,TRUE],
	['QS_AI_insertHeli_inProgress',FALSE,TRUE],
	['QS_AI_insertHeli_lastEvent',-1,TRUE],
	['QS_AI_insertHeli_cooldown',900,TRUE],
	['QS_AI_insertHeli_helis',[],TRUE],
	['QS_AI_insertHeli_maxAO',3,TRUE],
	['QS_AI_insertHeli_spawnedAO',0,TRUE],
	['QS_AI_unitsGestureReady',[],FALSE],
	['QS_AI_regroupPositions',[],FALSE],
	['QS_AI_regenerator',objNull,FALSE],
	['QS_AI_regen_usedPositions',[[0,0,0]],FALSE],
	['QS_positions_fieldHospitals',[],TRUE],
	['QS_sideMission_terrainData',[],FALSE],
	['QS_classic_AOData',[],TRUE],
	['QS_classic_terrainData',[],FALSE],
	['QS_classic_AI_triggerDeinit',FALSE,FALSE],
	['QS_classic_AI_triggerInit',FALSE,FALSE],
	['QS_classic_AI_active',FALSE,FALSE],
	['QS_classic_AI_enemy_0',[],FALSE],
	['QS_classic_subObjectives',[],FALSE],
	['QS_classic_subObjectiveData',[],FALSE],
	['QS_mission_tasks',[],TRUE],
	['QS_anim_script',scriptNull,FALSE],
	['QS_grid_initialized',FALSE,FALSE],
	['QS_grid_script',scriptNull,FALSE],
	['QS_grid_data',[],FALSE],
	[(format ['QS_grid_data_persistent_%1',worldName]),(missionProfileNamespace getVariable [(format ['QS_grid_data_persistent_%1',worldName]),[]]),FALSE],
	['QS_grid_date_start',[],FALSE],
	['QS_grid_date_end',[],FALSE],
	['QS_grid_aoData',[],FALSE],
	['QS_grid_aoPolygon',[],TRUE],
	['QS_grid_aoMarkers',[],FALSE],
	['QS_grid_aoCentroid',[0,0,0],FALSE],
	['QS_grid_active_data',[],FALSE],
	['QS_grid_active',FALSE,TRUE],
	['QS_grid_objectivesData',[],FALSE],
	['QS_grid_AI_triggerInit',FALSE,TRUE],
	['QS_grid_AI_triggerDeinit',FALSE,TRUE],
	['QS_grid_AI_active',FALSE,TRUE],
	['QS_grid_AI_enemy_1',[],TRUE],
	['QS_grid_AIRspTotal',0,FALSE],
	['QS_grid_AIRspDestroyed',0,FALSE],
	['QS_grid_terrainData',[],FALSE],
	['QS_grid_statistics',[],FALSE],
	[(format ['QS_grid_statistics_persistent_%1',worldName]),(missionProfileNamespace getVariable [(format ['QS_grid_statistics_persistent_%1',worldName]),[]]),FALSE],
	['QS_grid_aoDurationHint',4200,FALSE],
	['QS_grid_aoDuration',0,FALSE],
	['QS_grid_markers',[],FALSE],
	['QS_grid_evalMarkers',FALSE,FALSE],
	['QS_grid_aoProps',[],FALSE],
	['QS_grid_hiddenTerrainObjects',[],FALSE],
	['QS_grid_enemyRespawnObjects',[],TRUE],
	['QS_grid_IGcomposition',[],FALSE],
	['QS_grid_IGleader',objNull,FALSE],
	['QS_grid_IGflag',objNull,FALSE],
	['QS_grid_IGposition',[0,0,0],TRUE],
	['QS_grid_IGintel',objNull,FALSE],
	['QS_grid_IDAPcomposition',[],FALSE],
	['QS_grid_IDAP_uxoField',[],FALSE],
	['QS_grid_IDAPintel',objNull,FALSE],
	['QS_grid_intelTargets',[],FALSE],
	['QS_grid_intelEntities',[],FALSE],
	['QS_grid_intelMarkers',[],FALSE],
	['QS_grid_intelHouses',[],FALSE],
	['QS_grid_markers_data',[],FALSE],
	['QS_grid_defend_script',scriptNull,FALSE],
	['QS_grid_defend_active',FALSE,FALSE],
	['QS_grid_defend_trigger',FALSE,FALSE],
	['QS_grid_defend_force',FALSE,FALSE],
	['QS_grid_defend_AIinit',FALSE,TRUE],
	['QS_grid_defend_AIdeInit',FALSE,TRUE],
	['QS_grid_IGstaticComposition',[],FALSE],
	['QS_grid_IDAP_taskActive',FALSE,FALSE],
	['QS_grid_IG_taskActive',FALSE,FALSE],
	['QS_grid_civCasualties',FALSE,TRUE],
	['QS_client_baseIcons',[],TRUE],
	['QS_client_fobIcons',[],TRUE],
	['QS_client_carrierIcons',[],TRUE],
	['QS_IDAP_taskInProgress',FALSE,FALSE],
	['QS_ao_UXOs',[],FALSE],
	['QS_managed_hints',[],TRUE],
	['QS_carrier_casLaptop',objNull,TRUE],
	['QS_prisoners',[],TRUE],
	['QS_vehicle_register',[],FALSE],
	['QS_AI_vehicles',[],FALSE],
	['QS_genericAO_terrainData',[],FALSE],
	['QS_ao_createDelayedMinefield',FALSE,FALSE],
	['QS_ao_createDelayedMinefieldPos',[0,0,0],FALSE],
	['QS_mission_gpsJammers',[],TRUE],
	['QS_uav_Monitor',[],TRUE],
	['QS_defend_propulsion',1,FALSE],
	['QS_AI_targetsKnowledge_suspend',FALSE,FALSE],
	['QS_entities_ao_customEntities',[],FALSE],
	['QS_entities_ao_customStructures',[],FALSE],
	['QS_entities_ao_customHTO',[],FALSE],
	['QS_mission_clearedBuildings',[],FALSE],
	['QS_ao_controlledSpawnPoints',[],FALSE],
	['QS_AI_targetsKnowledge_threat_armor_entities',[],FALSE],
	['QS_AI_targetsKnowledge_threat_air_entities',[],FALSE],
	['QS_AI_targetsKnowledge_threat_air',0,FALSE],
	['QS_AI_targetsKnowledge_threat_armor',0,FALSE],
	['QS_projectile_manager',[],FALSE],
	['QS_projectile_manager_PFH',-1,FALSE],
	['QS_analytics_entities_log',[],FALSE],
	['QS_system_AI_owners',[2],TRUE],
	['QS_entities_craterEffects',[],FALSE],
	['QS_AI_targetsIntel',[],TRUE],
	['QS_system_leaderboardUsers',[''],FALSE],
	['QS_ao_terrainIsSettlement',FALSE,FALSE],
	['QS_ao_objsUsedTerrainBldgs',0,FALSE],
	['QS_ao_urbanSpawn',FALSE,FALSE],
	['QS_ao_urbanSpawn_bldgs',[],FALSE],
	['QS_ao_urbanSpawn_nodes',[],FALSE],
	['QS_ao_urbanSpawn_init',FALSE,FALSE],
	['QS_system_restartEnabled',TRUE,FALSE],
	['QS_ao_hqBuildingPositions',[],FALSE],
	['QS_AI_laserTargets',[],TRUE],
	['QS_AI_cmdr_recentSuppPositions',[],FALSE],
	['QS_zeus_captureMan',objNull,TRUE],
	['QS_cas_JetsDLCEnabled',TRUE,FALSE],
	['QS_radiotower_useFence',TRUE,FALSE],
	['QS_AI_smokeTargets',[],TRUE],
	['QS_module_objectScale',[],TRUE],
	['QS_system_updateObjectScale',FALSE,TRUE],
	['QS_AI_forceTracers',FALSE,TRUE],
	['QS_hashmap_tracers',createHashMapFromArray (call QS_data_tracers),FALSE],
	['QS_hashmap_rockets',createHashMapFromArray (call QS_data_rockets),FALSE],
	['QS_session_weaponsList',((missionProfileNamespace getVariable ['QS_profile_weaponsList',[]]) select {(isClass (_weaponsList >> _x))})],
	['QS_session_magazineList',[]],
	['QS_session_weaponMagazines',createHashMap],
	['QS_hashmap_simpleObjectInfo',createHashMap],
	['QS_towing_maxTrain_1',-1,TRUE],
	['QS_towing_maxTrain_2',-1,TRUE],
	['QS_system_virtualCargo',[],TRUE],
	['QS_system_builtObjects',[],FALSE],
	['QS_system_maxBuiltObjects',[],FALSE],
	['QS_system_safezones',[],TRUE],
	['QS_hashmap_playerBuildables',createHashMap,FALSE],
	['QS_list_playerBuildables',[],TRUE],
	['QS_blacklist_logistics',[],TRUE],
	['QS_system_zones',[],TRUE],
	['QS_system_zonesLocal',[],TRUE],
	['QS_logistics_deployedAssets',[],FALSE],
	['QS_logistics_wrecktype','land_cargo10_orange_f',FALSE],
	['QS_mobile_increment1',0,FALSE],
	['QS_system_terrainMod',[],FALSE],
	['QS_global_wreckSmokes',[],FALSE],
	['QS_system_vehicleRallyPoints',[],FALSE],
	['QS_system_builtThings',[],TRUE],
	['QS_markers_fireSupport',[],TRUE],
	['QS_markers_fireSupport_queue',[],FALSE],
	['QS_managed_flares',[],FALSE],
	['QS_registered_vehicleSpawners',[],FALSE],
	['QS_managed_spawnedVehicles_maxCap',10,TRUE],
	['QS_managed_spawnedVehicles_maxByType',[],TRUE],
	['QS_managed_spawnedVehicles_local',[],FALSE],		// Note: persistence
	['QS_managed_spawnedVehicles_public',(missionNamespace getVariable ['QS_managed_spawnedVehicles_local',[]]),TRUE],
	['QS_enemyInterruptAction_radius',100,TRUE],
	['QS_base_manager',[],FALSE],
	['QS_base_manager_public',[],TRUE],
	['QS_missionConfig_aoUrbanSpawning',1,FALSE],
	['QS_vehicles_destroyed',[],FALSE],
	['QS_system_BIScorpseCollector',((getMissionConfigValue ['corpseManagerMode',0]) > 0),TRUE],
	['QS_system_BISwreckCollector',((getMissionConfigValue ['wreckManagerMode',0]) > 0),TRUE]
];
// Local Namespace
{
	localNamespace setVariable _x;	
} forEach [
	['QS_uniqueScriptErrors',0],
	['QS_PF_queue',[]]
];
// Server Namespace
{
	serverNamespace setVariable _x;	
} forEach [
	
];
///////////////////////////////////
_weaponsList = nil;
// Load terrain-specific Roles if file is found
if (fileExists (format ['@Apex_cfg\%1\roles.sqf',worldName])) then {
	diag_log '***** DEBUG ***** COMPILING TERRAIN SPECIFIC ROLES DATA';
	call (compileScript [(format ['@Apex_cfg\%1\roles.sqf',worldName])]);
} else {
	call (compileScript ['@Apex_cfg\roles.sqf']);
};
['INIT_SYSTEM'] call (missionNamespace getVariable 'QS_fnc_roles');
['INIT'] call (missionNamespace getVariable 'QS_fnc_deployment');
['INIT'] call (missionNamespace getVariable 'QS_fnc_zoneManager');
['INIT'] call (missionNamespace getVariable 'QS_fnc_wreckSetMaterials');
// Load terrain-specific Arsenal if file is found
if (fileExists (format ['@Apex_cfg\%1\arsenal.sqf',worldName])) then {
	diag_log '***** DEBUG ***** COMPILING TERRAIN SPECIFIC ARSENAL DATA';
	missionNamespace setVariable ['QS_data_arsenal',(compileScript [(format ['@Apex_cfg\%1\arsenal.sqf',worldName]),TRUE]),TRUE];
} else {
	missionNamespace setVariable ['QS_data_arsenal',(compileScript ['@Apex_cfg\arsenal.sqf',TRUE]),TRUE];
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_cas_laptop',objNull,TRUE]
	];
	serverNamespace setVariable ['QS_v_Monitor',[]];
};
_markerData = call (compileScript ['code\config\QS_data_markers.sqf']);
_markers = [];
_allMapMarkers = allMapMarkers;
if (worldName isEqualTo 'Stratis') then {
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
		_markerData pushBack ['QS_marker_stratisPatrolBase',[4094.31,4596.4,0.00143433],'b_hq','Icon','','ColorWEST',[0.5,0.5],0.75,[4094.31,4596.4,0.00143433],0,localize 'STR_QS_Marker_071'];
	};
};
{
	if (!((_x # 0) in _allMapMarkers)) then {
		createMarker [(_x # 0),(_x # 1)];
		(_x # 0) setMarkerTypeLocal (_x # 2);
		(_x # 0) setMarkerShapeLocal (_x # 3);
		if ((_x # 3) isNotEqualTo 'Icon') then {
			(_x # 0) setMarkerBrushLocal (_x # 4);
		};
		(_x # 0) setMarkerColorLocal (_x # 5);
		(_x # 0) setMarkerSizeLocal (_x # 6);
		(_x # 0) setMarkerAlphaLocal (_x # 7);
		(_x # 0) setMarkerPosLocal (_x # 8);
		(_x # 0) setMarkerDirLocal (_x # 9);
		(_x # 0) setMarkerText (format ['%1%2',(toString [32,32,32]),(_x # 10)]);
	};
	_markers pushBack (_x # 0);
} forEach _markerData;
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 1) then {
	private _markerText = '';
	{
		_markerText = markerText _x;
		if (!((_markerText select [0,3]) isEqualTo (toString [32,32,32]))) then {
			_x setMarkerText (format ['%1%2',(toString [32,32,32]),_markerText]);
		};
	} forEach allMapMarkers;
	{
		_x setMarkerAlpha 0;
	} forEach [
		'QS_marker_respawn_uavoperator',
		'QS_marker_respawn_jetpilot',
		'QS_marker_respawn_helipilot'
	];
};
_markerData = nil;
missionNamespace setVariable ['QS_RD_markers',_markers,FALSE];
_markers = nil;
/*/===== RADIO (defined also in pbo description.ext and server.cfg)/*/
{
	(_x # 0) enableChannel (_x # 1);
} count [
	[0,[FALSE,FALSE]],
	[1,[TRUE,FALSE]],
	[2,[TRUE,TRUE]],
	[3,[TRUE,TRUE]],
	[4,[TRUE,TRUE]],
	[5,[TRUE,TRUE]]
];
['Initialize',[FALSE,50,FALSE,'']] call (missionNamespace getVariable 'BIS_fnc_dynamicGroups');
call (missionNamespace getVariable 'AR_Advanced_Rappelling_Install');

/*/===== Safe Zones/*/

if (
	((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isNotEqualTo 'ZEUS') ||
	(!(missionNamespace getVariable ['QS_missionConfig_zeusRespawnFlag',FALSE]))
) then {
	[0] call QS_fnc_zonePreset;
	['PRESET',0,TRUE] call QS_fnc_deployment;	// Main base
	['PRESET',3] call QS_fnc_deployment;	// Pilot spawn
	['PRESET',4] call QS_fnc_deployment;	// UAV pilot spawn
	['PRESET',5] call QS_fnc_deployment;	// Jet pilot spawn
};

/*/===== Build base/*/

// Wreck Recovery marker handling
private _obj = objNull;
{
	if (['_wreck_',_x] call QS_fnc_inString) then {
		['ADD',[_x,TRUE,'WRECK_RECOVER','RAD',1,[_x,25],{TRUE},{TRUE},{TRUE},{TRUE},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
		_obj = createSimpleObject ['Land_JumpTarget_F',markerPos [_x,TRUE]];
		_obj setPosASL ((getPosASL _obj) vectorAdd [0,0,(getTerrainHeightASL (getPosASL _obj)) + 0.1]);
		_obj setDir (markerDir _x);
	};
} forEach allMapMarkers;

if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	0 spawn {
		_composition = call (compileScript ['code\config\QS_data_missionobjects.sqf']);
		private _array = [];
		private _entity = objNull;
		{
			_entity = objNull;
			_array = _x;
			_array params [
				'_type',
				'_model',
				'_pos',
				'_vectorDirAndUp',
				'_damageAllowed',
				'_simulationEnabled',
				'_simpleObject',
				'_clientOnly',
				'_args',
				'_code'
			];
			if (_clientOnly isEqualTo 0) then {
				if (_simpleObject isNotEqualTo 0) then {
					_entity = createSimpleObject [([_type,_model] select (_simpleObject isEqualTo 2)),[-500,-500,0]];
					_entity setVectorDirAndUp _vectorDirAndUp;
					_entity setPosWorld _pos;
				} else {
					_entity = createVehicle [_type,[-500,-500,0],[],0,'CAN_COLLIDE'];
					if (_simulationEnabled isEqualTo 1) then {
						if (!(simulationEnabled _entity)) then {
							_entity enableSimulationGlobal TRUE;
						};
					} else {
						if (simulationEnabled _entity) then {
							_entity enableSimulationGlobal FALSE;
						};
					};
					if (_damageAllowed isEqualTo 1) then {
						if (!(isDamageAllowed _entity)) then {
							_entity allowDamage TRUE;
						};
					} else {
						if (isDamageAllowed _entity) then {
							_entity allowDamage FALSE;
						};
					};
					_entity setPosWorld _pos;
					_entity setVectorDirAndUp _vectorDirAndUp;
				};
				if (!isNull _entity) then {
					[_entity] call _code;
				};
			};
		} forEach _composition;
	};
};

/*/===== World config/*/

if (_worldName in ['Altis','Tanoa','Malden','Enoch','Stratis']) then {
	private _subPos = [0,0,0];
	private _sub = objNull;
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
		private _spawnSub = FALSE;
		private _dir = random 360;
		if (_worldName isEqualTo 'Altis') then {
			_subPos = [15197.437,15219.423,(0 - (random 2))];
			_spawnSub = TRUE;
		};
		if (_worldName isEqualTo 'Tanoa') then {
			_subPos = [7025.683,6660.926,(0 - (random 2))];
			_spawnSub = TRUE;
		};
		if (_worldName isEqualTo 'Malden') then {
			_subPos = [8851.859,9930.916,(0 - (random 2))];
			_spawnSub = TRUE;
		};
		if (_worldName isEqualTo 'Stratis') then {
			_subPos = [1965.819,5248.986,(0 - (random 2))];
			_dir = 13.8;
			_spawnSub = TRUE;
		};
		if (_spawnSub) then {
			_sub = createSimpleObject ['A3\Boat_F_EPC\Submarine_01\Submarine_01_F.p3d',_subPos];
			_sub setDir _dir;
			missionNamespace setVariable ['QS_setFeatureType',((missionNamespace getVariable 'QS_setFeatureType') + [[_sub,2]]),TRUE];
		};
	} else {
		if ('QS_marker_subPosition' in allMapMarkers) then {
			if (surfaceIsWater (markerPos 'QS_marker_subPosition')) then {
				_subPos = (markerPos ['QS_marker_subPosition',TRUE]) vectorAdd [0,0,(0 - (random 2))];
				_sub = createSimpleObject ['A3\Boat_F_EPC\Submarine_01\Submarine_01_F.p3d',_subPos];
				_sub setDir (markerDir 'QS_marker_subPosition');
				missionNamespace setVariable ['QS_setFeatureType',((missionNamespace getVariable 'QS_setFeatureType') + [[_sub,2]]),TRUE];
			};
			deleteMarker 'QS_marker_subPosition';
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) isEqualTo 'GRID') then {
	{
		_x hideObjectGlobal TRUE;
	} forEach (nearestTerrainObjects [[worldSize/2, worldSize/2],['Land_ConcreteWell_01_F','Land_SewerCover_04_F','Land_ConcreteWell_02_F','Land_StoneWell_01_F'],worldSize,FALSE,TRUE]);
};
if (!((missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS']) in ['ZEUS'])) then {
	// Hide terrain radio towers
	{
		_x hideObjectGlobal TRUE;
		_x allowDamage FALSE;
	} forEach (nearestTerrainObjects [[worldSize / 2,worldSize / 2,0],['TRANSMITTER'],worldSize / 2]) select {( (toLowerANSI (typeOf _x)) in ['land_ttowerbig_1_f','land_ttowerbig_2_f'])};
};
if (_worldName isEqualTo 'Malden') then {
	{
		((_x # 0) nearestObject (_x # 1)) hideObjectGlobal (!isObjectHidden ((_x # 0) nearestObject (_x # 1)));
	} forEach [
		[[4779.35,5697.9,0.0012207],'Land_Bunker_01_HQ_F']
	];
};
if (_worldName isEqualTo 'Stratis') then {
	// Set all the terrain military structures to indestructible
	0 spawn {
		_QS_milBuildings = (nearestTerrainObjects [[worldsize / 2,worldsize / 2,0], ['HOUSE'],worldsize,false]) select {
			((((getModelInfo _x) # 0) select [0,7]) in ['cargo_h','cargo_p'])
		};
		_QS_milBuildings = _QS_milBuildings select {
			(!(_x inPolygon [
				[2619.61,5814.57,0.00137115],
				[2269.47,5989.51,0.00155592],
				[1882.34,6273.29,0.00182962],
				[1442.13,5642.64,-1.96785],
				[1485.09,4866.48,0.0010221],
				[2107.92,4833.72,0.00100517],
				[2603.8,5447.23,0.001297]
			]))
		};
		private _obj = objNull;
		private _pos = [0,0,0];
		private _type = '';
		private _vectorDirAndUp = [];
		{
			_obj = _x;
			_type = typeOf _obj;
			_pos = getPosWorld _obj;
			_vectorDirAndUp = [vectorDir _x,vectorUp _x];
			_x allowDamage FALSE;
			_x hideObjectGlobal TRUE;
			sleep 1;
			_obj = createVehicle [_type,[0,0,0]];
			_obj setVectorDirAndUp _vectorDirAndUp;
			_obj setPosWorld _pos;
			_obj allowDamage FALSE;
		} forEach _QS_milBuildings;
		([4357.12,3893.8,-0.00238037] nearestObject 'Land_Radar_F') hideObjectGlobal (!isObjectHidden ([4357.12,3893.8,-0.00238037] nearestObject 'Land_Radar_F'));
		_obj = createVehicle ['Land_Radar_F',[4357.12,3893.8,-0.00238037]];
		_obj setVectorDirAndUp [[-0.00336486,0.999995,5.69151e-006],[0.00169146,0,0.999999]];
		_obj setPosWorld [4358.67,3893.71,247.989];
		_obj allowDamage FALSE;
		//['setFeatureType',_obj,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_obj];
		missionNamespace setVariable ['QS_setFeatureType',((missionNamespace getVariable 'QS_setFeatureType') + [[_obj,2]]),TRUE];
		
		([2715.07,951.489,-0.0169754] nearestObject 'Land_LightHouse_F') hideObjectGlobal (!isObjectHidden ([4357.12,3893.8,-0.00238037] nearestObject 'Land_LightHouse_F'));
		_obj = createVehicle ['Land_LightHouse_F',[2715.07,951.489,-0.0169754]];
		_obj setVectorDirAndUp [[0.612695,0.79032,-0.000299167],[0.000488281,0,1]];
		_obj setPosWorld [2717.05,954.05,94.4399];
		_obj allowDamage FALSE;
		//['setFeatureType',_obj,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_obj];
		missionNamespace setVariable ['QS_setFeatureType',((missionNamespace getVariable 'QS_setFeatureType') + [[_obj,2]]),TRUE];
		
		([6602.79,5192.66,-0.0202332] nearestObject 'Land_LightHouse_F') hideObjectGlobal (!isObjectHidden ([6602.79,5192.66,-0.0202332] nearestObject 'Land_LightHouse_F'));
		_obj = createVehicle ['Land_LightHouse_F',[6602.79,5192.66,-0.0202332]];
		_obj setVectorDirAndUp [[-0.986766,-0.162154,0.000963638],[0.000976563,0,1]];
		_obj setPosWorld [6599.59,5192.14,92.6175];
		_obj allowDamage FALSE;
		//['setFeatureType',_obj,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_obj];
		missionNamespace setVariable ['QS_setFeatureType',((missionNamespace getVariable 'QS_setFeatureType') + [[_obj,2]]),TRUE];
		// Agia Marina HQ area
		{
			((_x # 1) nearestObject (_x # 0)) allowDamage FALSE;
			((_x # 1) nearestObject (_x # 0)) hideObjectGlobal TRUE;
			sleep 0.1;
			_obj = createVehicle [_x # 0,[0,0,0]];
			_obj allowDamage FALSE;
			_obj setPosWorld (_x # 2);
			_obj setVectorDirAndUp (_x # 3);
		} forEach [
			["Land_i_Shop_02_V1_F",[3042.54,6001.38,-0.0874577],[3041.74,6000.7,6.45441],[[0.0354329,-0.999372,-2.99668e-005],[0.000845734,0,1]]],
			["Land_i_Shop_01_V1_F",[3012.05,6012.8,-5.29289e-005],[3011.97,6015.21,6.41605],[[0.0700597,-0.997543,-6.84177e-005],[0.000976563,0,1]]],
			["Land_i_Shop_02_V1_F",[3003.53,6012.46,-0.0335679],[3002.83,6013.24,6.49596],[[-0.997961,-0.0638289,0.000487278],[0.000488273,0,1]]],
			["Land_i_Shop_01_V1_F",[2993.72,6011.59,0.0152993],[2993.65,6014.01,6.4314],[[0.0598389,-0.998208,-5.84364e-005],[0.000976562,0,1]]],
			["Land_i_House_Small_03_V1_F",[2971.06,6006.67,0.373476],[2971.07,6006.6,4.03916],[[0.482564,0.875862,-0.000999683],[0.0020716,0,1]]],
			["Land_i_Shop_01_V1_F",[3043.14,5991.52,-0.0422173],[3040.72,5991.52,6.37388],[[0.999439,0.0334988,-0.000345073],[0.000345267,0,1]]],
			["Land_i_House_Small_03_V1_F",[3039.68,6016.45,0.375698],[3039.64,6016.51,4.07278],[[0.0592463,-0.998244,-9.14812e-005],[0.00154408,0,1]]]
		];
		// Girna HQ area
		{
			((_x # 1) nearestObject (_x # 0)) allowDamage FALSE;
			((_x # 1) nearestObject (_x # 0)) hideObjectGlobal TRUE;
			sleep 0.1;
			_obj = createVehicle [_x # 4,[0,0,0]];
			_obj allowDamage FALSE;
			_obj setPosWorld (_x # 2);
			_obj setVectorDirAndUp (_x # 3);
		} forEach [
			["Land_Slum_House01_F",[2068.21,2724.03,0.302671],[2067.56,2724.67,6.90831],[[0.760586,-0.649237,-0.000643254],[0.000845734,0,1]],"Land_Slum_House01_F"],
			["Land_i_Stone_Shed_V1_F",[2043.74,2736.84,0.376987],[2044.14,2738.07,3.83615],[[-0.629329,-0.777139,0.000614579],[0.000976562,0,1]],"Land_i_Stone_Shed_V1_F"],
			["Land_Slum_House03_F",[2034.97,2713.54,-0.000620365],[2033.61,2713.42,4.74787],[[0.677418,0.735598,-0.00046778],[0.000690534,0,1]],"Land_Slum_House03_F"],
			["Land_i_Stone_Shed_V1_F",[2078.04,2748.53,0.711457],[2077.36,2747.5,6.73855],[[0.748614,0.663006,-0.00057796],[0.00077204,0,1]],"Land_i_Stone_Shed_V1_F"],
			["Land_i_Stone_Shed_V1_F",[2069.09,2704.37,0.382221],[2069.71,2705.47,7.84375],[[-0.785812,-0.618467,0.000939863],[0.00119604,0,1]],"Land_i_Stone_Shed_V1_F"],
			["Land_i_Stone_HouseBig_V1_F",[2084.5,2728.95,0.473867],[2084.66,2731.07,9.78233],[[0.659995,-0.75127,0],[0,0,1]],"Land_i_Stone_House_Big_01_b_clay_F"],
			["Land_i_Stone_HouseSmall_V1_F",[2042.27,2723.73,-0.827677],[2043.3,2722.7,4.69056],[[-0.711185,0.703005,0.000245549],[0.000345267,0,1]],"Land_i_Stone_HouseSmall_V1_F"],
			["Land_i_Stone_HouseBig_V1_F",[2040.26,2706.41,0.847298],[2040.02,2704.55,7.40889],[[-0.725972,0.687724,0],[0,0,1]],"Land_i_Stone_House_Big_01_b_clay_F"]
		];
	};
	// Generate some more terrain buildings
	0 spawn {
		_composition = call (compileScript ['code\config\QS_data_terrainStratis.sqf']);
		private _array = [];
		private _entity = objNull;
		{
			_entity = objNull;
			_array = _x;
			_array params [
				'_type',
				'_model',
				'_pos',
				'_vectorDirAndUp',
				'_damageAllowed',
				'_simulationEnabled',
				'_simpleObject',
				'_clientOnly',
				'_args',
				'_code'
			];
			if (_simpleObject isNotEqualTo 0) then {
				_entity = createSimpleObject [([_type,_model] select (_simpleObject isEqualTo 2)),[-500,-500,0]];
				_entity setVectorDirAndUp _vectorDirAndUp;
				_entity setPosWorld _pos;
			} else {
				_entity = createVehicle [_type,[-500,-500,0],[],0,'CAN_COLLIDE'];
				if (_simulationEnabled isEqualTo 1) then {
					if (!(simulationEnabled _entity)) then {
						_entity enableSimulationGlobal TRUE;
					};
				} else {
					if (simulationEnabled _entity) then {
						_entity enableSimulationGlobal FALSE;
					};
				};
				if (_damageAllowed isEqualTo 1) then {
					if (!(isDamageAllowed _entity)) then {
						_entity allowDamage TRUE;
					};
				} else {
					if (isDamageAllowed _entity) then {
						_entity allowDamage FALSE;
					};
				};
				_entity setPosWorld _pos;
				_entity setVectorDirAndUp _vectorDirAndUp;
			};
			if (!isNull _entity) then {
				//[_entity] call _code;
			};
		} forEach _composition;
	};
};
if (_worldName isEqualTo 'Altis') then {
	{
		if (_x inPolygon [[5443.56,17947,0],[5387.14,17940.1,0],[5383.96,17933.4,0],[5368.8,17932.5,0],[5343.63,17919,0],[5355.7,17878.1,0],[5364.41,17850.4,0],[5379.65,17850.7,0],[5395.13,17870.1,0],[5434.97,17871.2,0],[5438.15,17916.3,0],[5445.73,17929.3,0]]) then {
			_x hideObjectGlobal TRUE;
			_x enableSimulationGlobal FALSE;
		};
	} forEach (nearestTerrainObjects [[5398.63,17897.7,0.00141144],[],100,FALSE,TRUE]);
	
	if (TRUE) then {
		{
			if (_x inPolygon [[10736.3,10847.8,0],[10720.9,10829,0],[11042.4,10602,0],[11053.9,10635,0]]) then {
				_x hideObjectGlobal TRUE;
			};
		} forEach (nearestTerrainObjects [[10872.5,10725.4,0.00128937],[],500, FALSE, TRUE]);
		{
			if (!isObjectHidden _x) then {
				_x hideObjectGlobal TRUE;
			};
		} forEach (nearestTerrainObjects [[10872.5,10725.4,0.00128937],[],100, FALSE, TRUE]);
		_fn_flattenTerrain = {
			params ['_start', '_a', '_b', '_h','_radius','_dir','_widerRadius'];
			getTerrainInfo params ['_landGridWidth','_landGridSize','_terrainGridWidth','_terrainGridSize','_seaLevel'];
			private _newPos = [0,0,0];
			private _newPositions = [];
			_gridStepX = _terrainGridWidth;
			_gridStepY = _terrainGridWidth;
			for '_gridStepX' from -(_a / 2) to (_a / 2) do {
				for '_gridStepY' from -(_b / 2) to (_b / 2) do {
					_newPos = _start vectorAdd [_gridStepX,_gridStepY,0];
					_newPos set [2, (0 - ((getTerrainHeightASL _newPos) + 5))];
					if (_newPos inPolygon [[10736.3,10847.8,0],[10720.9,10829,0],[11042.4,10602,0],[11053.9,10635,0]]) then {
						_newPositions pushBack _newPos;
					};
				};
			};
			_newPositions;
		};
		private _radius = 500;
		private _widerRadius = (_radius * 2) max ((getTerrainInfo # 2) * 2);
		private _positionsAndHeights = [[10872.5,10725.4,0.00128937],_widerRadius,_widerRadius, 0,_radius,0,_widerRadius] call _fn_flattenTerrain;
		setTerrainHeight [_positionsAndHeights, TRUE];
		_list = [
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10986.5,10628.4,-0.168253],[[0.773929,-0.633273,0],[0,0,1]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10939.1,10661.3,6.36778],[[0.773812,-0.632231,-0.0387169],[0.0173306,-0.0399688,0.999051]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10888.9,10698.8,8.76846],[[0.773904,-0.632388,0.0340267],[-0.00801098,0.0439493,0.999002]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10832.2,10737.1,3.44848],[[0.773596,-0.626813,0.093029],[-0.0293173,0.111248,0.99336]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10777.8,10830.6,-3.60805],[[0.825527,-0.561831,0.0533905],[-0.0120076,0.0770963,0.996951]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10735.2,10804.3,-2.71294],[[0.773351,-0.631572,0.0551895],[-0.038632,0.039945,0.998455]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[11040,10675.4,-6.62856],[[0.922558,0.385858,0],[0,0,1]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10989.3,10689.1,4.49462],[[0.787577,-0.615126,-0.036653],[-0.00934902,-0.0714016,0.997404]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10945.9,10718.9,7.65103],[[-0.79806,0.597341,0.079271],[0.0572333,-0.0558168,0.996799]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10899.4,10749.5,8.08456],[[-0.799086,0.599446,-0.0461041],[-0.0266571,0.0412832,0.998792]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10856.6,10778.5,2.36122],[[-0.749536,0.589254,-0.301621],[-0.347559,0.0374768,0.936909]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10822,10806.6,2.03958],[[-0.798501,0.601987,-0.00281619],[-0.0466183,-0.0571711,0.997275]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10768.2,10785.3,1.1939],[[-0.741839,0.668993,-0.0460773],[-0.0200001,0.046609,0.998713]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10741.6,10868.2,-5.34404],[[0.283387,-0.956727,0.0660649],[-0.113088,0.03507,0.992966]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10690.1,10821.8,-4.94195],[[0.967154,-0.253752,0.014902],[0.033315,0.184661,0.982238]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[10795.9,10759,-0.406635],[[-0.873485,0.486732,-0.0107828],[0.00399714,0.0293171,0.999562]]],
			["Land_SharpRock_wallH","a3\rocks_f\sharp\sharprock_wallh.p3d",[11017.2,10588.2,-3.83494],[[0.39979,-0.909223,-0.116111],[0.226772,-0.0246243,0.973637]]],
			["Dirthump_3_F","a3\structures_f\training\dirthump_3_f.p3d",[10760.3,10853.1,3.6411],[[-0.80675,0.590009,-0.0323197],[-0.0293202,0.014658,0.999463]]],
			["Dirthump_3_F","a3\structures_f\training\dirthump_3_f.p3d",[10755,10846.7,4.21449],[[-0.80675,0.590009,-0.0323197],[-0.0293202,0.014658,0.999463]]],
			["Dirthump_3_F","a3\structures_f\training\dirthump_3_f.p3d",[10733.3,10795.7,5.87948],[[-0.996553,0.0764054,-0.0323198],[-0.0326434,-0.0029899,0.999463]]],
			["Dirthump_3_F","a3\structures_f\training\dirthump_3_f.p3d",[10732.4,10784.9,5.01382],[[-0.996553,0.0764054,-0.0323198],[-0.0326434,-0.0029899,0.999463]]]
		];
		private _obj = objNull;
		{
			_obj = createSimpleObject [_x # 0,[0,0,0]];
			_obj setPosWorld (_x # 2);
			_obj setVectorDirAndUp (_x # 3);
		} forEach _list;
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	private _newMarker = '';
	{
		deleteMarker _x;
		_newMarker = createMarker [_x,[0,0,0]];
		_newMarker setMarkerShapeLocal 'Icon';
		_newMarker setMarkerTypeLocal 'mil_dot';
		_newMarker setMarkerAlpha 0;
	} forEach [
		'QS_marker_respawn_uavoperator',
		'QS_marker_respawn_jetpilot',
		'QS_marker_respawn_helipilot'
	];
	missionNamespace setVariable ['QS_baseProtection_polygons',(call (compileScript ['code\config\QS_data_speedLimitAreas.sqf'])),TRUE];
	missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
	if (_worldName isEqualTo 'Altis') then {
	
		'QS_marker_respawn_uavoperator' setMarkerPos [14624.7,16721.2,30.8307];
		'QS_marker_respawn_uavoperator' setMarkerDir 110;
		'QS_marker_respawn_jetpilot' setMarkerPos [14461.8,16265.6,18.6627];
		'QS_marker_respawn_jetpilot' setMarkerDir 314;
		'QS_marker_respawn_helipilot' setMarkerPos [14752.6,16856.8,18.001];
		'QS_marker_respawn_helipilot' setMarkerDir 130;
	
		missionNamespace setVariable ['QS_prisonPos',[14687.747,16808.996,0],TRUE];
		{
			((_x # 0) nearestObject (_x # 1)) hideObjectGlobal (!isObjectHidden ((_x # 0) nearestObject (_x # 1)));
		} forEach [
			[[14529.1,16713.4,-0.095396],'Land_Airport_Tower_F'],
			[[14616.3,16714.1,3.8147e-006],'Land_LampAirport_off_F'],
			[[14677.8,16777,3.8147e-006],'Land_LampAirport_off_F'],
			[[14723.3,16821.3,3.8147e-006],'Land_LampAirport_F'],
			[[14572.2,16668.5,3.8147e-006],'Land_LampAirport_F']
		];
		{
			_x hideObjectGlobal TRUE; 
			_x enableSimulationGlobal FALSE;
		} forEach (nearestTerrainObjects [[16899.4,9935.51,0.00149155],['BUSH'],5,FALSE,TRUE]);	
		{
			_x hideObjectGlobal TRUE; 
			_x enableSimulationGlobal FALSE;
		} forEach (nearestTerrainObjects [[14521.2,16778.4,0.0017128],[],5,FALSE,TRUE]);
		0 spawn {
			private ['_obj','_pos'];
			_simpleObjects = call (compileScript ['code\config\QS_data_simpleobjects.sqf']);
			if (_simpleObjects isNotEqualTo []) then {
				{
					_pos = _x # 0;
					_pos set [2,(((_x # 0) # 2) + (_x # 2))];
					_obj = createSimpleObject [(_x # 1),_pos];
					_obj setDir (random 360);
				} forEach _simpleObjects;
			};
			_simpleObjects = nil;
		};
	};
	if (_worldName isEqualTo 'Tanoa') then {
	
		diag_log 'Setting marker Pos';
	
		'QS_marker_respawn_uavoperator' setMarkerPos [6899.05,7423.78,15.7328];
		'QS_marker_respawn_uavoperator' setMarkerDir 76;
		'QS_marker_respawn_jetpilot' setMarkerPos [6830,7261,2.69];
		'QS_marker_respawn_jetpilot' setMarkerDir 72;
		'QS_marker_respawn_helipilot' setMarkerPos [7089.77,7300,2.66144];
		'QS_marker_respawn_helipilot' setMarkerDir 0;
	
		missionNamespace setVariable ['QS_prisonPos',[6924.40,7370.55,0],TRUE];
		{
			_x hideObjectGlobal TRUE;
			_x enableSimulationGlobal FALSE;
		} forEach (nearestTerrainObjects [[4009.65,11793.7,0.00143814],['TREE'],10,FALSE,TRUE]);
	};
	if (_worldName isEqualTo 'Malden') then {
	
		'QS_marker_respawn_uavoperator' setMarkerPos [8106.64,10104.3,42.5627];
		'QS_marker_respawn_uavoperator' setMarkerDir 252.468;
		'QS_marker_respawn_jetpilot' setMarkerPos [8055.05,10014.9,30.0609];
		'QS_marker_respawn_jetpilot' setMarkerDir 100;
		'QS_marker_respawn_helipilot' setMarkerPos [8057.48,10291,29.8258];
		'QS_marker_respawn_helipilot' setMarkerDir 0;
	
		missionNamespace setVariable ['QS_prisonPos',[8106.4,10049.15,0],TRUE];
		{
			((_x # 0) nearestObject (_x # 1)) hideObjectGlobal (!isObjectHidden ((_x # 0) nearestObject (_x # 1)));
		} forEach [
			[[8066.87,10196.4,0.0199451],'Land_HelipadSquare_F'],
			[[8020.53,10196.8,0.0200291],'Land_HelipadSquare_F'],
			[[8068.54,9995.96,-0.320858],'Land_Hangar_F'],
			[[8091.6,9672.57,0.0110703],'Land_HelipadRescue_F'],
			[[8013.59,9688.03,0.0123863],'Land_HelipadCivil_F'],
			[[8100.73,10111.4,-0.000911713],'Land_LampAirport_F'],
			[[8093.89,10235.7,-0.00857162],'Land_LampAirport_F']
		];
	};
	if (_worldName isEqualTo 'Enoch') then {
	
		'QS_marker_respawn_uavoperator' setMarkerPos [4110.76,10286.7,77.2023];
		'QS_marker_respawn_uavoperator' setMarkerDir 258.922;
		'QS_marker_respawn_jetpilot' setMarkerPos [4306.76,10501.5,68.1707];
		'QS_marker_respawn_jetpilot' setMarkerDir 68.4751;
		'QS_marker_respawn_helipilot' setMarkerPos [3864.66,10137,67.7403];
		'QS_marker_respawn_helipilot' setMarkerDir 0;
	
		missionNamespace setVariable ['QS_prisonPos',[4104.49,10211.3,0],TRUE];
	};
	if (_worldName isEqualTo 'Stratis') then {
	
		'QS_marker_respawn_uavoperator' setMarkerPos [1906.07,5713.91,18.4492];
		'QS_marker_respawn_uavoperator' setMarkerDir 294.613;
		'QS_marker_respawn_jetpilot' setMarkerPos [1910.55,5938.28,5.50144];
		'QS_marker_respawn_jetpilot' setMarkerDir 341;
		'QS_marker_respawn_helipilot' setMarkerPos [1947.32,5820.64,5.50144];
		'QS_marker_respawn_helipilot' setMarkerDir 0;
	
		missionNamespace setVariable ['QS_prisonPos',[1913.8,5777.7,0.00142908],TRUE];
		// Hide some key buildings in the base area
		{
			((_x # 0) nearestObject (_x # 1)) hideObjectGlobal (!isObjectHidden ((_x # 0) nearestObject (_x # 1)));
			((_x # 0) nearestObject (_x # 1)) enableSimulationGlobal FALSE;
			((_x # 0) nearestObject (_x # 1)) allowDamage FALSE;
		} forEach [
			[[1886.33,5728.47,0.00142622],'Land_HelipadSquare_F'],
			[[1894.68,5758.35,0.00143862],'Land_HelipadSquare_F'],
			[[1913.16,5820.46,9.53674e-007],'Land_TentHangar_V1_F'],
			[[1923.68,5863.94,2.95639e-005],'Land_TentHangar_V1_F'],
			[[1913.94,5955.27,0.000219345],'Land_TentHangar_V1_F'],
			[[1924.84,5850.23,2.62847],''],												//land_cargo20_military_green_f
			[[1916.95,5805.76,2.62856],''],												//land_cargo20_military_green_f
			[[1942.73,5872.22,2.62848],''],
			[[1958.54,5707.32,0.100458],'Land_MilOffices_V1_F'],
			[[1910.51,5713.64,0.00755119],'Land_Airport_Tower_F'],
			[[1906.17,5639.7,0.000470161],'Land_TentHangar_V1_F']
		];
	};
} else {
	missionNamespace setVariable ['QS_baseProtection_polygons',(call (compileScript ['code\config\QS_data_speedLimitAreas.sqf'])),TRUE];
	missionNamespace setVariable ['QS_prisonPos',(markerPos 'QS_marker_gitmo'),TRUE];
	missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
};
[0] call (missionNamespace getVariable 'QS_fnc_serverObjectsRecycler');
missionNamespace setVariable [
	'QS_hqArray',
	[
		(missionNamespace getVariable 'QS_aoHQ1'),
		(missionNamespace getVariable 'QS_aoHQ2'),
		(missionNamespace getVariable 'QS_aoHQ3'),
		(missionNamespace getVariable 'QS_aoHQ4'),
		(missionNamespace getVariable 'QS_aoHQ5'),
		(missionNamespace getVariable 'QS_aoHQ6'),
		(missionNamespace getVariable 'QS_aoHQ7'),
		(missionNamespace getVariable 'QS_aoHQ8'),
		(missionNamespace getVariable 'QS_aoHQ9'),
		(missionNamespace getVariable 'QS_aoHQ10'),
		(missionNamespace getVariable 'QS_aoHQ11'),
		(missionNamespace getVariable 'QS_aoHQ12'),
		(missionNamespace getVariable 'QS_aoHQ13'),
		(missionNamespace getVariable 'QS_aoHQ14'),
		(missionNamespace getVariable 'QS_aoHQ15'),
		(missionNamespace getVariable 'QS_aoHQ16'),
		(missionNamespace getVariable 'QS_aoHQ17'),
		(missionNamespace getVariable 'QS_aoHQ18'),
		(missionNamespace getVariable 'QS_aoHQ19'),
		(missionNamespace getVariable 'QS_aoHQ20'),
		(missionNamespace getVariable 'QS_aoHQ21'),
		(missionNamespace getVariable 'QS_aoHQ22'),
		(missionNamespace getVariable 'QS_aoHQ23'),
		(missionNamespace getVariable 'QS_aoHQ24')
	],
	FALSE
];
missionNamespace setVariable [
	'QS_sc_compositions_hq',
	[
		(missionNamespace getVariable 'QS_sc_composition_hq_1')
	],
	FALSE
];
missionNamespace setVariable [
	'QS_sc_compositions_sd',
	[
		(missionNamespace getVariable 'QS_data_supplyDepot_1')
	],
	FALSE
];
missionNamespace setVariable [
	'QS_sc_compositions',
	[
		[
			(missionNamespace getVariable 'QS_sc_composition_small_1'),
			(missionNamespace getVariable 'QS_sc_composition_small_2'),
			(missionNamespace getVariable 'QS_sc_composition_small_3')
		],
		[
			(missionNamespace getVariable 'QS_sc_composition_medium_1'),
			(missionNamespace getVariable 'QS_sc_composition_medium_2'),
			(missionNamespace getVariable 'QS_sc_composition_medium_3')
		],
		[
			(missionNamespace getVariable 'QS_sc_composition_large_1'),
			(missionNamespace getVariable 'QS_sc_composition_large_2'),
			(missionNamespace getVariable 'QS_sc_composition_large_3')
		]
	],
	FALSE
];
missionNamespace setVariable [
	'QS_compositions_radioTower',
	[
		(missionNamespace getVariable 'QS_data_radioTower_1')
	],
	FALSE
];

/*/================================================== SERVER EVENT HANDLERS/*/
/*/===== Mission Event Handlers/*/

{
	removeAllMissionEventHandlers _x;
} forEach [
	'HandleDisconnect',
	'EachFrame',
	'Draw3D'
];
{
	addMissionEventHandler _x;
} forEach [
	['BuildingChanged',{call (missionNamespace getVariable 'QS_fnc_eventBuildingChanged')}],
	['Ended',{call (missionNamespace getVariable 'QS_fnc_eventMissionEnded')}],
	//['EntityCreated',(missionNamespace getVariable 'QS_fnc_eventEntityCreated')],							// Used for debug/diagnostics
	['EntityDeleted',{call (missionNamespace getVariable 'QS_fnc_eventEntityDeleted')}],
	['EntityKilled',{call (missionNamespace getVariable 'QS_fnc_eventEntityKilled')}],
	['EntityRespawned',{call (missionNamespace getVariable 'QS_fnc_eventEntityRespawned')}],
	['GroupCreated',{call (missionNamespace getVariable 'QS_fnc_eventGroupCreated')}],					// Not used
	['GroupDeleted',{call (missionNamespace getVariable 'QS_fnc_eventGroupDeleted')}],					// Not used
	['HandleDisconnect',{call (missionNamespace getVariable 'QS_fnc_eventHandleDisconnect')}],
	['MarkerDeleted',{call (missionNamespace getVariable 'QS_fnc_eventMarkerDeleted')}],
	['PlayerConnected',{call (missionNamespace getVariable 'QS_fnc_eventOnPlayerConnected')}],
	['PlayerDisconnected',{call (missionNamespace getVariable 'QS_fnc_eventOnPlayerDisconnected')}],
	['Drowned',{call (missionNamespace getVariable 'QS_fnc_eventVehicleDrowned')}],
	['UAVCrewCreated',{call (missionNamespace getVariable 'QS_fnc_eventUAVCrewCreated')}],
	['ScriptError',{call (missionNamespace getVariable 'QS_fnc_eventScriptError')}],
	['OnUserSelectedPlayer',{call QS_fnc_eventOnUserSelectedPlayer}]
	//['ProjectileCreated',{call (missionNamespace getVariable 'QS_fnc_eventProjectileCreated')}],			// Used for debug/diagnostics
];

/*/===== watchlist of troublemaker UIDs, harvested from RPT files. Reports against these players in the future are given 2x weighting by Robocop./*/

missionNamespace setVariable ['QS_robocop_watchlist',[],FALSE];
if (missionProfileNamespace isNil 'QS_robocop_watchlist') then {
	missionProfileNamespace setVariable ['QS_robocop_watchlist',[]];
	saveMissionProfileNamespace;
};
/*/===== Carrier Handling/*/

if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
	{
		if ((_x # 0) isEqualTo 'DEFENSE') then {
			if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 2) then {
				_x call (missionNamespace getVariable 'QS_fnc_carrier');
			};
		} else {
			_x call (missionNamespace getVariable 'QS_fnc_carrier');
		};
	} forEach [
		['INIT'],
		['PROPS'],
		['HOSPITAL','ADD'],
		['DEFENSE']
	];
};
if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
	{
		_x call (missionNamespace getVariable 'QS_fnc_destroyer');
	} forEach [
		['INIT'],
		['PROPS'],
		['HOSPITAL','ADD'],
		['DEFENSE']
	];
};
0 spawn (missionNamespace getVariable 'QS_fnc_easterEggs');
[0] call (missionNamespace getVariable 'QS_fnc_artillery');
if ((allMissionObjects 'Land_RepairDepot_01_base_F') isNotEqualTo []) then {
	{
		if (!isSimpleObject _x) then {
			_x setRepairCargo 0;
			_x setAmmoCargo 0;
			_x setFuelCargo 0;
		};
	} forEach (allMissionObjects 'Land_RepairDepot_01_base_F');
};
if ((allMissionObjects 'ModuleCurator_F') isNotEqualTo []) then {
	deleteVehicle ((allMissionObjects 'ModuleCurator_F') select {
		(!(_x getVariable ['QS_missionObject_protected',FALSE]))
	});
};

/*/===== DATE CONFIG /*/

diag_log format ['***** DEBUG ***** QS_initServer.sqf ***** %1 ***** 1 - SETTING DATE *****',time];
if ((missionNamespace getVariable ['QS_missionConfig_startDate',[]]) isNotEqualTo []) then {
	setDate (missionNamespace getVariable ['QS_missionConfig_startDate',[]]);
} else {
	if (missionProfileNamespace isNil (format ['QS_QRF_date_%1',worldName])) then {
		_QS_PARAMS_DATE = [-1,-1,-1,-1,-1];
		if (((_QS_PARAMS_DATE) # 0) isNotEqualTo -1) then {_year = ((_QS_PARAMS_DATE) # 0);} else {_year = selectRandom [2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040];};
		if (((_QS_PARAMS_DATE) # 1) isNotEqualTo -1) then {_month = ((_QS_PARAMS_DATE) # 1);} else {_month = round (random 12);};
		if (((_QS_PARAMS_DATE) # 2) isNotEqualTo -1) then {_day = ((_QS_PARAMS_DATE) # 2);} else {_days = [_year,_month] call (missionNamespace getVariable 'QS_fnc_monthDays');_day = ceil (random _days);};
		if (((_QS_PARAMS_DATE) # 3) isNotEqualTo -1) then {_hour = ((_QS_PARAMS_DATE) # 3);} else {_hour = round (random 23);};
		if (((_QS_PARAMS_DATE) # 4) isNotEqualTo -1) then {_minute = ((_QS_PARAMS_DATE) # 4);} else {_minute = round (random 60);};
		setDate [_year,_month,_day,_hour,_minute];
	} else {
		_QS_date = missionProfileNamespace getVariable (format ['QS_QRF_date_%1',worldName]);
		setDate _QS_date;
		missionProfileNamespace setVariable [(format ['QS_QRF_date_%1',worldName]),_QS_date]; 
		saveMissionProfileNamespace;
	};
	missionNamespace setVariable [(format ['QS_QRF_date_%1',worldName]),date,TRUE];
};

/*/==== Weather Config/*/

if (missionNamespace getVariable ['QS_missionConfig_weatherDynamic',TRUE]) then {
	if (missionProfileNamespace isNil (format ['QS_QRF_weatherCurrent_%1',worldName])) then {
		setWind [0,0,FALSE];
		0 setOvercast 0;
		0 setFog [0,0,0];
		0 setRain 0;
		0 setLightnings 0;
		0 setWindDir 0;
		0 setWindStr 0;
		0 setWindForce 0;
		0 setGusts 0;
		0 setRainbow 0;
		0 setWaves 0;
		setHumidity 0;
	} else {
		_QS_currentWeatherData = missionProfileNamespace getVariable [
			(format ['QS_QRF_weatherCurrent_%1',worldName]),
			[
				[0,0,TRUE],
				0,
				0,
				[0,0,0],
				0,
				0,
				0,
				0,
				0
			]
		];
		setWind [((_QS_currentWeatherData # 0) # 0),((_QS_currentWeatherData # 0) # 1),TRUE];
		0 setOvercast (_QS_currentWeatherData # 3);
		0 setRain (_QS_currentWeatherData # 4);
		0 setFog (_QS_currentWeatherData # 5);
		0 setGusts (_QS_currentWeatherData # 6);
		0 setLightnings (_QS_currentWeatherData # 7);
		0 setWaves (_QS_currentWeatherData # 8);
		0 setRainbow (_QS_currentWeatherData # 9);
		diag_log format ['***** DEBUG ***** QS_initServer.sqf ***** %1 ***** 2.5 - SETTING WEATHER FROM PROFILE *****',time];
	};
} else {
	[(missionNamespace getVariable ['QS_missionConfig_weatherForced',0])] call (missionNamespace getVariable 'QS_fnc_weatherPreset');
};
forceWeatherChange;
0 spawn (missionNamespace getVariable 'QS_fnc_core');
0 spawn (missionNamespace getVariable 'QS_fnc_AI');
if (missionNamespace getVariable ['QS_missionConfig_dlcReskin',FALSE]) then {
	(missionNamespace getVariable ['QS_missionConfig_dlcReskinParams',[]]) spawn QS_fnc_reskinModdedUnits;
};
missionNamespace setVariable ['QS_mission_init',TRUE,TRUE];
{
	diag_log _x;
} count [
	'*****************************************************************************',
	'************************* Server Config Complete ****************************',
	'*****************************************************************************'	
];
if (fileExists '@Apex_cfg\custom.sqf') then {
	call (compileScript ['@Apex_cfg\custom.sqf']);
};