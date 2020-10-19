/*/
File: config.sqf
Author:

	Quiksilver
	
Last modified: 

	19/10/2020 A3 2.00 by Quiksilver

Description:

	Configure Server
____________________________________________________/*/

_missionProductVersion = '1.1.9';
_missionProductStatus = 'Stable';
missionNamespace setVariable ['QS_system_devBuild_text',(format ['Apex Framework %1 (%2)',_missionProductVersion,_missionProductStatus]),TRUE];
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
	'*****************************************************************************',
	(format [
		'***** Difficulty Options *****%1*****autoReport: %2%1*****cameraShake: %3%1*****commands: %4%1*****deathMessages: %5%1*****detectedMines: %6%1*****enemyTags: %7%1*****friendlyTags: %8%1*****groupIndicators: %9%1*****mapContent: %10%1*****mapContentEnemy: %11%1*****mapContentFriendly: %12%1*****mapContentMines: %13%1*****mapContentPing: %14%1*****multipleSaves: %15%1*****reducedDamage: %16%1*****scoreTable: %17%1*****squadRadar: %18%1*****staminaBar: %19%1*****stanceIndicator: %20%1*****tacticalPing: %21%1*****thirdPersonView: %22%1*****visionAid: %23%1*****vonID: %24%1*****waypoints: %25%1*****weaponCrosshair: %26%1*****weaponInfo: %27%1',
		endl,
		(difficultyOption 'autoReport'),
		(difficultyOption 'cameraShake'),
		(difficultyOption 'commands'),
		(difficultyOption 'deathMessages'),
		(difficultyOption 'detectedMines'),
		(difficultyOption 'enemyTags'),
		(difficultyOption 'friendlyTags'),
		(difficultyOption 'groupIndicators'),
		(difficultyOption 'mapContent'),
		(difficultyOption 'mapContentEnemy'),
		(difficultyOption 'mapContentFriendly'),
		(difficultyOption 'mapContentMines'),
		(difficultyOption 'mapContentPing'),
		(difficultyOption 'multipleSaves'),
		(difficultyOption 'reducedDamage'),
		(difficultyOption 'scoreTable'),
		(difficultyOption 'squadRadar'),
		(difficultyOption 'staminaBar'),
		(difficultyOption 'stanceIndicator'),
		(difficultyOption 'tacticalPing'),
		(difficultyOption 'thirdPersonView'),
		(difficultyOption 'visionAid'),
		(difficultyOption 'vonID'),
		(difficultyOption 'waypoints'),
		(difficultyOption 'weaponCrosshair'),
		(difficultyOption 'weaponInfo')
	]),
	'*****************************************************************************'
];
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
if ((!((productVersion select 7) isEqualTo 'x64')) && (!((productVersion select 6) isEqualTo 'Linux'))) exitWith {
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
	if (!((difficultyOption _difficultyFlag) isEqualTo _difficultyValue)) exitWith {
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
	['groupIndicators',0]
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
if (isNil {uiNamespace getVariable 'QS_fnc_serverCommandPassword'}) exitWith {
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

/*/ If default base is selected, remove everything /*/
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	{
		if (!isNull _x) then {
			if (!(_x isKindOf 'Logic')) then {
				if (!(_x getVariable ['QS_missionObject_protected',FALSE])) then {
					deleteVehicle _x;
				};
			};
		};
	} forEach (allMissionObjects '');
	{
		deleteMarker _x;
	} forEach allMapMarkers;
};
enableDynamicSimulationSystem TRUE;
enableEnvironment [FALSE,FALSE];
disableRemoteSensors TRUE;
calculatePlayerVisibilityByFriendly FALSE;
useAISteeringComponent FALSE;
setViewDistance 2500;
setObjectViewDistance 2500;
setShadowDistance 0;
setTerrainGrid 50;
{
	(_x select 0) enableAIFeature (_x select 1);
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
if (isNil {missionNamespace getVariable 'QS_HC_Active'}) then {
	missionNamespace setVariable ['QS_HC_Active',FALSE,FALSE];
};
if (isNil {missionNamespace getVariable 'QS_headlessClients'}) then {
	missionNamespace setVariable ['QS_headlessClients',[],FALSE];
};
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
if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'SC') then {
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
private _globalLightpoints = [];
/*/
for '_x' from 0 to 9 step 1 do {
	_globalLightpoints pushBack (createVehicle ['#lightpoint',[-1000,-1000,0],[],0,'NONE']);
};
{
	_x enableDynamicSimulation TRUE;
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
} forEach _globalLightpoints;
/*/
_recyclerUnitTypes = [
	[
		'o_soldier_ar_f',
		'o_medic_f',
		'o_engineer_f',
		'o_soldier_exp_f',
		'o_soldier_gl_f',
		'o_soldier_m_f',
		'o_soldier_f',
		'o_soldier_sl_f',
		'o_soldier_tl_f'
	],
	[
		'o_t_soldier_ar_f',
		'o_t_medic_f',
		'o_t_engineer_f',
		'o_t_soldier_exp_f',
		'o_t_soldier_gl_f',
		'o_t_soldier_m_f',
		'o_t_soldier_f',
		'o_t_soldier_tl_f',
		'o_t_soldier_sl_f'
	]
] select (worldName in ['Tanoa','Lingor3','Enoch']);
{
	uiNamespace setVariable _x;
} forEach [
	['QS_roles_handler',[]]
];
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_initRespawn_disconnect',-1,FALSE],
	['BIS_fnc_drawMinefields_active',TRUE,FALSE],
	['BIS_dg_fia','BI',TRUE],
	['BIS_dynamicGroups_allowInterface',TRUE,TRUE],
	['RscSpectator_allowedGroups',[],TRUE],
	['RscSpectator_allowFreeCam',FALSE,TRUE],
	['QS_terrain_worldArea',[[(worldSize / 2),(worldSize / 2),0],(worldSize / 2),(worldSize / 2),0,TRUE,-1],TRUE],
	['QS_RSS_enabled',((getMissionConfigValue ['skipLobby',0]) isEqualTo 1),TRUE],
	['QS_RSS_client_canSideSwitch',(!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)),TRUE],
	['QS_missionConfig_restartHours',(missionNamespace getVariable ['QS_missionConfig_restartHours',[0,6,12,18]]),FALSE],
	['QS_mission_aoType',(profileNamespace getVariable ['QS_mission_aoType','CLASSIC']),TRUE],
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
	['QS_analytics_playercount',[],FALSE],
	['QS_analytics_entities_created',12,FALSE],
	['QS_analytics_entities_deleted',0,FALSE],
	['QS_analytics_entities_respawned',0,FALSE],
	['QS_analytics_entities_killed',0,FALSE],
	['QS_analytics_entities_recycled',0,FALSE],
	['QS_aar_A_killed_bad',0,TRUE],
	['QS_aar_A_killed_good',0,TRUE],
	['QS_aar_A_killed_civ',0,TRUE],
	['QS_aar_A_killed_bldg',0,TRUE],
	['QS_aar_A_time_dur',0,TRUE],
	['QS_aar_B_killed_bad',0,TRUE],
	['QS_aar_B_killed_good',0,TRUE],
	['QS_aar_B_killed_civ',0,TRUE],
	['QS_aar_B_killed_bldg',0,TRUE],
	['QS_aar_B_time_dur',0,TRUE],
	['QS_armedAirEnabled',FALSE,TRUE],
	['QS_var_debug',FALSE,FALSE],
	['QS_serverKey','abc123',TRUE],
	['QS_teamspeak_address',_teamspeak,TRUE],
	['QS_community_website',_website,TRUE],
	['QS_chat_messages',(call (compile (preprocessFileLineNumbers '@Apex_cfg\chatMessages.sqf'))),FALSE],
	['QS_pilot_whitelist',[],TRUE],
	['QS_cls_whitelist',[],TRUE],
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
	['QS_curator_revivePoints',10,TRUE],
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
	['QS_HVT_totalList',[],FALSE],
	['QS_module_recAI_array',[],TRUE],
	['QS_lamps',[],FALSE],
	['QS_garbageCollector',[],FALSE],
	['QS_forceWeatherChange',FALSE,FALSE],
	['QS_weatherSync',TRUE,FALSE],
	['QS_airbaseDefense',FALSE,TRUE],
	['QS_base_safePolygon',(call (compile (preprocessFileLineNumbers 'code\config\QS_data_baseRestrictedArea.sqf'))),TRUE],
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
	/*/['QS_spawnPoint_1',_spawnPoint_1,TRUE],/*/
	['QS_staff_requestBaseCleanup_time',0,FALSE],
	['QS_roboCop',[],FALSE],
	['QS_panel_support',objNull,TRUE],
	['QS_smReward_array',[5,6,7,8,9,10,11,12,13,14,15,16,17,18,20,21,23,24,25,26,27,29,30,31],FALSE],
	['QS_ao_aaMarkers',[],FALSE],
	['QS_module_fob_enabled',TRUE,TRUE],
	['QS_module_fob_centerPosition',[0,0,0],FALSE],
	['QS_module_fob_HQ',objNull,TRUE],
	['QS_module_fob_displayName','',TRUE],
	['QS_module_fob_vehicleRespawnEnabled',FALSE,TRUE],
	['QS_module_fob_respawnEnabled',FALSE,TRUE],
	['QS_module_fob_respawnTickets',0,TRUE],
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
	['QS_virtualSectors_resultsFactors',(profileNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]]),FALSE],
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
	['QS_recycler_units',((missionNamespace getVariable 'QS_missionConfig_aoType') in ['CLASSIC','SC']),FALSE],
	['QS_recycler_unitTypes',_recyclerUnitTypes,FALSE],
	['QS_recycler_unitCount',8,FALSE],
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
	[(format ['QS_grid_data_persistent_%1',worldName]),(profileNamespace getVariable [(format ['QS_grid_data_persistent_%1',worldName]),[]]),FALSE],
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
	[(format ['QS_grid_statistics_persistent_%1',worldName]),(profileNamespace getVariable [(format ['QS_grid_statistics_persistent_%1',worldName]),[]]),FALSE],
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
	['QS_flare_lightpoints',_globalLightpoints,TRUE],
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
	['QS_projectile_manager_PFH',-1,FALSE]
];
call (compile (preprocessFileLineNumbers '@Apex_cfg\roles.sqf'));
['INIT_SYSTEM'] call (missionNamespace getVariable 'QS_fnc_roles');
missionNamespace setVariable ['QS_data_arsenal',(compileFinal (preprocessFileLineNumbers '@Apex_cfg\arsenal.sqf')),TRUE];
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	{
		missionNamespace setVariable _x;
	} forEach [
		['QS_cas_laptop',objNull,TRUE],
		['QS_v_Monitor',[],FALSE]
	];
};
_markerData = [] call (compile (preprocessFileLineNumbers 'code\config\QS_data_markers.sqf'));
_markers = [];
_allMapMarkers = allMapMarkers;
{
	if (!((_x select 0) in _allMapMarkers)) then {
		createMarker [(_x select 0),(_x select 1)];
		(_x select 0) setMarkerType (_x select 2);
		(_x select 0) setMarkerShape (_x select 3);
		if (!((_x select 3) isEqualTo 'Icon')) then {
			(_x select 0) setMarkerBrush (_x select 4);
		};
		(_x select 0) setMarkerColor (_x select 5);
		(_x select 0) setMarkerSize (_x select 6);
		(_x select 0) setMarkerAlpha (_x select 7);
		(_x select 0) setMarkerPos (_x select 8);
		(_x select 0) setMarkerDir (_x select 9);
		(_x select 0) setMarkerText (format ['%1%2',(toString [32,32,32]),(_x select 10)]);
	};
	0 = _markers pushBack (_x select 0);
} count _markerData;
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
	(_x select 0) enableChannel (_x select 1);
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

/*/===== Build base/*/

if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	0 spawn {
		_composition = call (compile (preprocessFileLineNumbers 'code\config\QS_data_missionobjects.sqf'));
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
			if (!(_simpleObject isEqualTo 0)) then {
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
				missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
				[_entity] call _code;
			};
		} forEach _composition;
	};
};

/*/===== World config/*/
if (_worldName in ['Altis','Tanoa','Malden','Enoch']) then {
	private _subPos = [0,0,0];
	private _spawnSub = FALSE;
	if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
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
		if (_spawnSub) then {
			_sub = createSimpleObject ['A3\Boat_F_EPC\Submarine_01\Submarine_01_F.p3d',_subPos];
			_sub setDir (random 360);
			['setFeatureType',_sub,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_sub];
		};
	} else {
		if ('QS_marker_subPosition' in allMapMarkers) then {
			if (surfaceIsWater (markerPos 'QS_marker_subPosition')) then {
				_subPos = [((markerPos 'QS_marker_subPosition') # 0),((markerPos 'QS_marker_subPosition') # 1),(0 - (random 2))];
				_sub = createSimpleObject ['A3\Boat_F_EPC\Submarine_01\Submarine_01_F.p3d',_subPos];
				_sub setDir (markerDir 'QS_marker_subPosition');
				['setFeatureType',_sub,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_sub];
			};
			deleteMarker 'QS_marker_subPosition';
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_aoType','']) isEqualTo 'GRID') then {
	{
		_x hideObjectGlobal TRUE;
	} forEach (nearestTerrainObjects [[worldSize/2, worldSize/2],['Land_ConcreteWell_01_F','Land_SewerCover_04_F','Land_ConcreteWell_02_F','Land_StoneWell_01_F'],worldSize,FALSE,TRUE]);
};
if (_worldName isEqualTo 'Malden') then {
	{
		((_x # 0) nearestObject (_x # 1)) hideObjectGlobal (!isObjectHidden ((_x # 0) nearestObject (_x # 1)));
	} forEach [
		[[4779.35,5697.9,0.0012207],'Land_Bunker_01_HQ_F']
	];
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (_worldName isEqualTo 'Altis') then {
		missionNamespace setVariable [
			'QS_baseProtection_polygons',
			[
				[[14576.5,16637.2,1],[14623,16593.1,1],[14800.4,16765,1],[14859.1,16719.5,1],[14904.8,16756.4,1],[14786.7,16873,1],[14731.4,16813.3,1],[14742,16803.9,1]]
			],
			TRUE
		];
		missionNamespace setVariable ['QS_prisonPos',[14687.747,16808.996,0],TRUE];
		missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
		{
			((_x select 0) nearestObject (_x select 1)) hideObjectGlobal (!isObjectHidden ((_x select 0) nearestObject (_x select 1)));
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
			if ((getPosWorld _x) inPolygon [[5443.56,17947,0],[5387.14,17940.1,0],[5383.96,17933.4,0],[5368.8,17932.5,0],[5343.63,17919,0],[5355.7,17878.1,0],[5364.41,17850.4,0],[5379.65,17850.7,0],[5395.13,17870.1,0],[5434.97,17871.2,0],[5438.15,17916.3,0],[5445.73,17929.3,0]]) then {
				_x hideObjectGlobal TRUE;
				_x enableSimulationGlobal FALSE;
			};
		} forEach (nearestTerrainObjects [[5398.63,17897.7,0.00141144],[],100,FALSE,TRUE]);
		0 spawn {
			private ['_obj','_pos'];
			_simpleObjects = call (compile (preprocessFileLineNumbers 'code\config\QS_data_simpleobjects.sqf'));
			if (!(_simpleObjects isEqualTo [])) then {
				{
					_pos = _x select 0;
					_pos set [2,(((_x select 0) select 2) + (_x select 2))];
					_obj = createSimpleObject [(_x select 1),_pos];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					_obj setDir (random 360);
				} forEach _simpleObjects;
			};
			_simpleObjects = nil;
		};
	};
	if (_worldName isEqualTo 'Tanoa') then {
		missionNamespace setVariable ['QS_prisonPos',[6924.40,7370.55,0],TRUE];
		missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
		missionNamespace setVariable [
			'QS_baseProtection_polygons',
			[
				[[6955.91,7320.77,1],[6998.99,7330.48,1],[6974.06,7456.62,1],[6933.65,7449.47,1]],
				[[7039,7296.95,1],[7053.38,7220.18,1],[7088.85,7174.77,1],[7165.03,7175.23,1],[7128.51,7311.59,1]],
				[[7059.01,7523.01,1],[7073.57,7565.42,1],[6994.1,7600.87,1],[6971.92,7553.27,1]]
			],
			TRUE
		];
		{
			_x hideObjectGlobal TRUE;
			_x enableSimulationGlobal FALSE;
		} forEach (nearestTerrainObjects [[4009.65,11793.7,0.00143814],['TREE'],10,FALSE,TRUE]);
	};
	if (_worldName isEqualTo 'Malden') then {
		missionNamespace setVariable ['QS_prisonPos',[8106.4,10049.15,0],TRUE];
		missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
		missionNamespace setVariable [
			'QS_baseProtection_polygons',
			[
				[[8098.5,10237.6,1],[7987.92,10238.1,1],[7987.61,10022.9,1],[8097.11,10023.5,1]],
				[[8017.61,10385.9,1],[8012.09,10246.4,1],[8115.71,10244.8,1],[8118.9,10382.4,1]]
			],
			TRUE
		];
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
		missionNamespace setVariable ['QS_prisonPos',[4104.49,10211.3,0],TRUE];
		missionNamespace setVariable ['QS_prisonPopulation',0,TRUE];
		missionNamespace setVariable [
			'QS_baseProtection_polygons',
			[
				[[4070.12,10310.7,0],[3942.69,10181.2,0],[3976.86,10147.4,0],[4105.77,10273.6,0]],
				[[3810.13,10133.7,0],[3832.01,10091.3,0],[3926.57,10177.1,0],[3890.72,10213.8,0]]
			],
			TRUE
		];
	};
} else {
	missionNamespace setVariable ['QS_baseProtection_polygons',(call (compile (preprocessFileLineNumbers 'code\config\QS_data_speedLimitAreas.sqf'))),TRUE];
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
	['Ended',{_this call (missionNamespace getVariable 'QS_fnc_eventMissionEnded')}],
	['EntityKilled',{_this call (missionNamespace getVariable 'QS_fnc_eventEntityKilled')}],
	['EntityRespawned',{_this call (missionNamespace getVariable 'QS_fnc_eventEntityRespawned')}],
	['HandleDisconnect',{_this call (missionNamespace getVariable 'QS_fnc_eventHandleDisconnect')}],
	['PlayerConnected',{_this call (missionNamespace getVariable 'QS_fnc_eventOnPlayerConnected')}],
	['PlayerDisconnected',{_this call (missionNamespace getVariable 'QS_fnc_eventOnPlayerDisconnected')}],
	['BuildingChanged',{_this call (missionNamespace getVariable 'QS_fnc_eventBuildingChanged')}]
];

/*/===== watchlist of troublemaker UIDs, harvested from RPT files. Reports against these players in the future are given 2x weighting by Robocop./*/

missionNamespace setVariable ['QS_robocop_watchlist',[],FALSE];
if (isNil {profileNamespace getVariable 'QS_robocop_watchlist'}) then {
	profileNamespace setVariable ['QS_robocop_watchlist',[]];
	saveProfileNamespace;
};
/*/===== Carrier Handling/*/

if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
	{
		if ((_x select 0) isEqualTo 'DEFENSE') then {
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
if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
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
if (!((allMissionObjects 'Land_RepairDepot_01_base_F') isEqualTo [])) then {
	{
		if (!isSimpleObject _x) then {
			_x setRepairCargo 0;
			_x setAmmoCargo 0;
			_x setFuelCargo 0;
		};
	} forEach (allMissionObjects 'Land_RepairDepot_01_base_F');
};
if (!((allMissionObjects 'ModuleCurator_F') isEqualTo [])) then {
	{
		deleteVehicle _x;
	} forEach (allMissionObjects 'ModuleCurator_F');
};

/*/===== DATE CONFIG /*/

diag_log format ['***** DEBUG ***** QS_initServer.sqf ***** %1 ***** 1 - SETTING DATE *****',time];
if (isNil {profileNamespace getVariable (format ['QS_QRF_date_%1',worldName])}) then {
	_QS_PARAMS_DATE = [-1,-1,-1,-1,-1];
	if (!(((_QS_PARAMS_DATE) select 0) isEqualTo -1)) then {_year = ((_QS_PARAMS_DATE) select 0);} else {_year = selectRandom [2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030,2031,2032,2033,2034,2035,2036,2037,2038,2039,2040];};
	if (!(((_QS_PARAMS_DATE) select 1) isEqualTo -1)) then {_month = ((_QS_PARAMS_DATE) select 1);} else {_month = round (random 12);};
	if (!(((_QS_PARAMS_DATE) select 2) isEqualTo -1)) then {_day = ((_QS_PARAMS_DATE) select 2);} else {_days = [_year,_month] call (missionNamespace getVariable 'QS_fnc_monthDays');_day = ceil (random _days);};
	if (!(((_QS_PARAMS_DATE) select 3) isEqualTo -1)) then {_hour = ((_QS_PARAMS_DATE) select 3);} else {_hour = round (random 23);};
	if (!(((_QS_PARAMS_DATE) select 4) isEqualTo -1)) then {_minute = ((_QS_PARAMS_DATE) select 4);} else {_minute = round (random 60);};
	setDate [_year,_month,_day,_hour,_minute];
} else {
	if (!isNil {profileNamespace getVariable (format ['QS_QRF_date_%1',worldName])}) then {
		_QS_date = profileNamespace getVariable (format ['QS_QRF_date_%1',worldName]);
		setDate _QS_date;
		profileNamespace setVariable [(format ['QS_QRF_date_%1',worldName]),_QS_date]; 
		saveProfileNamespace;
	};
};
missionNamespace setVariable [(format ['QS_QRF_date_%1',worldName]),date,TRUE];

/*/==== Weather Config/*/

if (isNil {profileNamespace getVariable (format ['QS_QRF_weatherCurrent_%1',worldName])}) then {
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
} else {
	_QS_currentWeatherData = profileNamespace getVariable [
		(format ['QS_QRF_weatherCurrent_%1',worldName]),
		[
			[0,0,TRUE],
			0,
			0,
			[0,0,0],
			0,
			0,
			0,
			0
		]
	];
	setWind [((_QS_currentWeatherData select 0) select 0),((_QS_currentWeatherData select 0) select 1),TRUE];
	0 setOvercast (_QS_currentWeatherData select 3);
	0 setRain (_QS_currentWeatherData select 4);
	0 setFog (_QS_currentWeatherData select 5);
	0 setGusts (_QS_currentWeatherData select 6);
	0 setLightnings (_QS_currentWeatherData select 7);
	0 setWaves (_QS_currentWeatherData select 8);
	0 setRainbow (_QS_currentWeatherData select 9);
	diag_log format ['***** DEBUG ***** QS_initServer.sqf ***** %1 ***** 2.5 - SETTING WEATHER FROM PROFILE *****',time];
};
forceWeatherChange;
0 spawn (missionNamespace getVariable 'QS_fnc_core');
0 spawn (missionNamespace getVariable 'QS_fnc_AI');
missionNamespace setVariable ['QS_mission_init',TRUE,TRUE];
{
	diag_log _x;
} count [
	'*****************************************************************************',
	'************************* Server Config Complete ****************************',
	'*****************************************************************************'	
];