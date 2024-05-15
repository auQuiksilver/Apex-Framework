/*/
File: fn_aoDefend.sqf
Author:

	Quiksilver
	
Last modified:

	27/10/2022 A3 2.10 by Quiksilver
	
Description:

	AO Defend
__________________________________________________/*/

scriptName 'QS AO Defend';
private [
	'_centerPos','_duration','_allArray','_infantryMaxSpawned','_infantryArray',
	'_infantryCheckDelay','_infantrySpawnDelay','_foundSpawnPos','_spawnPos',
	'_index','_grp','_side','_infTypes','_infType','_direction','_infantryInitialSpawnDelay',
	'_wp','_uavInitialSpawnDelay','_uavMaxSpawned','_uavArray','_uavCheckDelay','_uavSpawnDelay',
	'_uavTypes','_uavType','_uav','_uavFlyInHeight','_updateMoveDelay','_armorInitialSpawnDelay',
	'_armorMaxSpawned','_armorArray','_armorCheckDelay','_armorSpawnDelay','_armorTypes','_armorType',
	'_av','_destination','_groundTransportInitialSpawnDelay','_groundTransportMaxSpawned','_groundTransportArray',
	'_groundTransportCheckDelay','_groundTransportSpawnDelay','_groundTransportTypes','_groundTransportType',
	'_v','_unitTypes','_unitType','_grp2','_unloadPos','_checkHeldInitialDelay','_checkHeldDelay','_checkGroupDelay',
	'_QS_uavs','_QS_infantry','_QS_armor','_QS_groundTransport','_QS_flyBy','_startPos1','_startPos2','_endPos1',
	'_endPos2','_playersInArea','_QS_flyByDelay','_QS_airSuperiority','_jetsToSpawn','_jetType','_jetArray',
	'_jetInitialDelay','_QS_flyByHeight','_updatePlayers','_playerVehicles','_unit','_helicopters','_helicoptersToSpawn',
	'_helicopterTypes','_helicopterType','_helicopterArray','_helicopterInitialDelay','_helicopter','_paratroopers',
	'_paratroopersToSpawn','_paratrooperTypes','_paratrooperArray','_paratrooperInitialDelay','_paratrooper','_paratrooperType',
	'_QS_flyByType','_QS_flyBySpeed','_QS_flyByAltitude','_allPlayersCount','_exitSuccess','_exitFail','_defendMessages',
	'_durationAlmostOver','_durationAlmostOverHint','_heli','_heliParaGrp','_heliParaCheckDelay','_paratroopers2','_paratrooper2InitialDelay',
	'_LorR','_vPara','_vParaTypes','_vParaType','_vParaV','_vParaInitialDelay','_vParaHeightMin','_vParaHeightRandom','_vParaDelay','_vParaArray',
	'_vParaToSpawn','_grp3','_openHeight','_QS_priorMissionStatistics','_currentStats','_defendStats','_vehicleReammoDelay','_groundTransportSpawned',
	'_divisor','_hqBuildings','_hqBuildingPositions','_building','_buildingPositions','_sectorControlTicker','_sectorControlThreshold','_text',
	'_enemyInHQCount','_playersInHQCount','_moveToPos','_infantrySpawnDistanceFixed','_infantrySpawnDistanceRandom','_infantrySpawnDistanceFromPlayer',
	'_fn_blacklist','_QS_worldName','_QS_worldSize','_nearRoads','_roadsValid','_validRoadSurfaces','_timeNow','_tickTimeNow','_serverTime','_taskID'
];
diag_log 'Defend AO 0';
if (time < 300) exitWith {};
_allPlayersCount = count allPlayers;
if ((diag_fps < 13) && ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if (((count ((units WEST) inAreaArray [(missionNamespace getVariable 'QS_HQpos'),500,500,0,FALSE,-1])) < 4) && ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if (((random 1) > 0.333) && ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 2) then {};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 1) then {missionNamespace setVariable ['QS_forceDefend',0,TRUE];};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo -1) exitWith {missionNamespace setVariable ['QS_forceDefend',0,TRUE];missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo -2) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if ((_allPlayersCount > 60) && ((missionNamespace getVariable 'QS_defendCount') > 3) && ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
diag_log 'Defend AO 0.5';
{
	missionNamespace setVariable _x;
} forEach [
	['QS_defendCount',((missionNamespace getVariable 'QS_defendCount') + 1),TRUE],
	['QS_defendActive',TRUE,TRUE],
	['QS_system_restartEnabled',FALSE,FALSE]
];
_defendMessages = [
	localize 'STR_QS_Chat_010',
	localize 'STR_QS_Chat_011',
	localize 'STR_QS_Chat_012'
];
['DEFEND_HQ',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_004']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
{
	_x setMarkerAlphaLocal 0.75;
	_x setMarkerPos (missionNamespace getVariable 'QS_HQpos');
} forEach ['QS_marker_aoCircle','QS_marker_aoMarker'];
'QS_marker_aoMarker' setMarkerText format['%1 %3 %2 %4',(toString [32,32,32]),(missionNamespace getVariable 'QS_aoDisplayName'),localize 'STR_QS_Marker_002',localize 'STR_QS_Marker_003'];

if (worldName in ['Stratis']) then {
	missionNamespace setVariable ['QS_hqPos',missionNamespace getVariable 'QS_aoPos'];
};
_centerPos = missionNamespace getVariable 'QS_HQpos';
_centerPos params ['_centerPosX','_centerPosY','_centerPosZ'];
private _allPlayers = allPlayers;
_taskID = 'QS_IA_TASK_DEFENDHQ';
[_taskID,TRUE,[localize 'STR_QS_Task_010',localize 'STR_QS_Task_011',localize 'STR_QS_Task_011'],_centerPos,'AUTOASSIGNED',5,FALSE,TRUE,'Defend',TRUE] call (missionNamespace getVariable 'BIS_fnc_setTask');
_timeNow = time;
_serverTime = serverTime;
_tickTimeNow = diag_tickTime;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_duration = serverTime + 1200 + (random 600);
_durationAlmostOver = _duration - 30 - (random 60);
//[_taskID,TRUE,_duration] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');			//----- Task timer reduces suspense and tension, better to not know how long remaining? Uncomment to show timer UI
[_taskID,['Defend','Defend 1','Defend 2']] call (missionNamespace getVariable 'QS_fnc_taskSetCustomData');
[_taskID,TRUE,1] call (missionNamespace getVariable 'QS_fnc_taskSetProgress');
_durationAlmostOverHint = FALSE;
_exitSuccess = FALSE;
_exitFail = FALSE;
_checkHeldInitialDelay = time + 60;
_checkHeldDelay = time + 5;
_checkGroupDelay = time + 30;
_updatePlayers = time + 15;
_allArray = [];
_side = EAST;
_direction = 0;
_destination = [0,0,0];
_moveToPos = [0,0,0];
_validRoadSurfaces = ['#gdtreddirt','#gdtasphalt','#gdtsoil','#gdtconcrete'];
_grp2 = grpNull;
_updateMoveDelay = time + 30;
_hqFlag = missionNamespace getVariable ['QS_AO_HQ_flag',objNull];
[_hqFlag,WEST,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
if (_QS_worldName isEqualTo 'Tanoa') then {
	_fn_blacklist = {
		private _c = TRUE;
		{
			if ((_this distance2D (_x # 0)) < (_x # 1)) exitWith {
				_c = FALSE;
			};
		} count [
			[[13415.7,5194.57,0.00172806],350],
			[[12897.9,5442.16,0.00107098],175],
			[[2257.59,1664.31,0.00162601],90],
			[[3681.47,9377.08,0.00176811],400],
			[[11440.4,14422,0.0013628],275]
		];
		_c;
	};
} else {
	_fn_blacklist = {TRUE};
};
_QS_uavs = TRUE;
_uavInitialSpawnDelay = 0;
_uavMaxSpawned = 1;
if (_allPlayersCount > 0) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 10) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 20) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 30) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 40) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 50) then {_uavMaxSpawned = 1;};
_uavArray = [];
_uavCheckDelay = time + 5;
_uavSpawnDelay = time + 5;
_uavTypes = ['defend_uavtypes_1'] call QS_data_listVehicles;
_uavType = '';
_uav = objNull;
_uavFlyInHeight = 600 + (random 1400);
_QS_infantry = TRUE;
_infantryInitialSpawnDelay = time + 0;
private _infantryLimit_0 = 44;
private _infantryLimit_1 = 54;
private _infantryLimit_2 = 62;
private _infantryLimit_3 = 68;
private _infantryLimit_4 = 74;
private _infantryLimit_5 = 80;
if (_allPlayersCount > 0) then {_infantryMaxSpawned = _infantryLimit_0;};
if (_allPlayersCount > 10) then {_infantryMaxSpawned = _infantryLimit_1;};
if (_allPlayersCount > 20) then {_infantryMaxSpawned = _infantryLimit_2;};
if (_allPlayersCount > 30) then {_infantryMaxSpawned = _infantryLimit_3;};
if (_allPlayersCount > 40) then {_infantryMaxSpawned = _infantryLimit_4;};
if (_allPlayersCount > 50) then {_infantryMaxSpawned = _infantryLimit_5;};
_infantryArray = [];
_infantryCheckDelay = _tickTimeNow + 10;
_infantrySpawnDelay = time + 10;

_infantrySpawnDistanceFixed = 800;
_infantrySpawnDistanceRandom = 1000;
_infantrySpawnDistanceFromPlayer = 400;

if (worldName isEqualTo 'Tanoa') then {
	_infantrySpawnDistanceFixed = 700;
	_infantrySpawnDistanceRandom = 800;
	_infantrySpawnDistanceFromPlayer = 350;
};
if (worldName isEqualTo 'Stratis') then {
	_infantrySpawnDistanceFixed = 400;
	_infantrySpawnDistanceRandom = 500;
	_infantrySpawnDistanceFromPlayer = 250;
};
_infTypes = ['defend_grptypes_1'] call QS_data_listUnits;
if (worldName isEqualTo 'Stratis') then {
	_infTypes = ['defend_grptypes_2'] call QS_data_listUnits;
};
_infType = '';
_QS_armor = TRUE;
_armorInitialSpawnDelay = time + 60 + (random 60);
if (_allPlayersCount > 0) then {_armorMaxSpawned = 0;};
if (_allPlayersCount > 10) then {_armorMaxSpawned = 1;};
if (_allPlayersCount > 20) then {_armorMaxSpawned = 1;};
if (_allPlayersCount > 30) then {if ((random 1) > 0.333) then {_armorMaxSpawned = 2;} else {_armorMaxSpawned = 1;};};
if (_allPlayersCount > 40) then {_armorMaxSpawned = 2;};
if (_allPlayersCount > 50) then {if ((random 1) > 0.666) then {_armorMaxSpawned = 3;} else {_armorMaxSpawned = 2;};};
if (_armorMaxSpawned < 2) then {
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) > 1) then {
		_armorMaxSpawned = _armorMaxSpawned max 2;
	};
};
_armorArray = [];
_armorCheckDelay = time + 5;
_armorSpawnDelay = time + 5;
private _isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
private _motorPool = 0;
if (worldName in ['Stratis']) then {
	_motorPool = 8;
};
_armorType = '';
_QS_groundTransport = FALSE;
if ((random 1) > 0.333) then {_QS_groundTransport = TRUE;};
_groundTransportInitialSpawnDelay = time + 180 + (random 240);
if (_allPlayersCount > 0) then {_groundTransportMaxSpawned = 1;};
if (_allPlayersCount > 10) then {_groundTransportMaxSpawned = 1;};
if (_allPlayersCount > 20) then {_groundTransportMaxSpawned = 2;};
if (_allPlayersCount > 30) then {_groundTransportMaxSpawned = 2;};
if (_allPlayersCount > 40) then {_groundTransportMaxSpawned = 3;};
if (_allPlayersCount > 50) then {_groundTransportMaxSpawned = 3;};
_groundTransportSpawned = 0;
_groundTransportArray = [];
_groundTransportCheckDelay = time + 5;
_groundTransportSpawnDelay = time + 5;
_groundTransportTypes = ['defend_transporttypes_1'] call QS_data_listVehicles;
_groundTransportType = '';
_v = objNull;
_unitTypes = ['defend_unittypes_1'] call QS_data_listUnits;
_unitType = '';
_foundSpawnPos = FALSE;
_spawnPos = [0,0,0];
_index = 0;
_grp = grpNull;
_QS_airSuperiority = TRUE && (!(worldName in ['Stratis']));
if (_allPlayersCount > 0) then {_jetsToSpawn = 0;};
if (_allPlayersCount > 10) then {_jetsToSpawn = 0;};
if (_allPlayersCount > 20) then {_jetsToSpawn = 1;};
if (_allPlayersCount > 30) then {_jetsToSpawn = selectRandom [1,1,2];};
if (_allPlayersCount > 40) then {_jetsToSpawn = 2;};
if (_allPlayersCount > 50) then {_jetsToSpawn = 2;};
_jetType = selectRandomWeighted (['defend_jettypes_1'] call QS_data_listVehicles);
_jetArray = [];
_jetInitialDelay = time + (30 + (random 60));
_jet = objNull;
_helicopters = TRUE;
_helicoptersToSpawn = 1;
if (_allPlayersCount > 0) then {_helicoptersToSpawn = 0;};
if (_allPlayersCount > 10) then {_helicoptersToSpawn = 1;};
if (_allPlayersCount > 20) then {_helicoptersToSpawn = 1;};
if (_allPlayersCount > 30) then {_helicoptersToSpawn = 1;};
if (_allPlayersCount > 40) then {_helicoptersToSpawn = 2;};
if (_allPlayersCount > 50) then {_helicoptersToSpawn = 2;};
if (_allPlayersCount > 20) then {
	if (worldName in ['Tanoa','Enoch','Stratis']) then {
		_helicopterTypes = ['defend_helitypes_1'] call QS_data_listVehicles;
	} else {
		_helicopterTypes = ['defend_helitypes_2'] call QS_data_listVehicles;
	};
} else {
	_helicopterTypes = ['defend_helitypes_3'] call QS_data_listVehicles;
};
_helicopterType = '';
_helicopterArray = [];
_heliParaGrp = grpNull;
_helicopterInitialDelay = _groundTransportInitialSpawnDelay;
_helicopter = objNull;
_heliParaCheckDelay = time + 3;
if ((random 1) > 0.666) then {
	_paratroopers = TRUE;
} else {
	_paratroopers = FALSE;
};
if ((random 1) > 0.666) then {
	_paratroopers2 = TRUE;
} else {
	_paratroopers2 = FALSE;
};
if (!(_paratroopers)) then {
	_infantryMaxSpawned = round (_infantryMaxSpawned * 1.25);
	if (!(_paratroopers2)) then {
		_infantryMaxSpawned = round (_infantryMaxSpawned * 1.25);
	};
};
if (_allPlayersCount > 0) then {_paratroopersToSpawn = 2;};
if (_allPlayersCount > 10) then {_paratroopersToSpawn = 4;};
if (_allPlayersCount > 20) then {_paratroopersToSpawn = 6;};
if (_allPlayersCount > 30) then {_paratroopersToSpawn = 8;};
if (_allPlayersCount > 40) then {_paratroopersToSpawn = 10;};
if (_allPlayersCount > 50) then {_paratroopersToSpawn = 10;};
_paratrooperTypes = ['defend_paratypes_1'] call QS_data_listUnits;
_paratrooperType = '';
_paratrooperArray = [];
_paratrooperInitialDelay = time + 240 + (random 240);
_paratrooper2InitialDelay = _paratrooperInitialDelay + 180 + (random 240);
_paratrooper = objNull;
_vPara = FALSE;
if ((random 1) > 0.666) then {
	_vPara = TRUE;
};
_vParaTypes = ['defend_paravtypes_1'] call QS_data_listVehicles;
_vParaType = '';
_vParaV = objNull;
_vParaInitialDelay = _paratrooper2InitialDelay + 10 + (random 20);
_vParaHeightMin = 100;
_vParaHeightRandom = 150;
_vParaDelay = time + 3;
_vParaArray = [];
_vParaToSpawn = 0;
if (_allPlayersCount > 0) then {_vParaToSpawn = 1;};
if (_allPlayersCount > 10) then {_vParaToSpawn = 1;};
if (_allPlayersCount > 20) then {_vParaToSpawn = 2;};
if (_allPlayersCount > 30) then {_vParaToSpawn = 2;};
if (_allPlayersCount > 40) then {if ((random 1) > 0.666) then {_vParaToSpawn = 3;} else {_vParaToSpawn = 2;};};
if (_allPlayersCount > 50) then {_vParaToSpawn = 3;};
_QS_flyBy = FALSE;
if ((random 1) > 0.333) then {
	_QS_flyBy = TRUE;
};
_QS_flyByDelay = _jetInitialDelay - 15;
_QS_flyByHeight = 25 + (random 100);
_QS_flyByType = selectRandomWeighted (['defend_flybytypes_1'] call QS_data_listVehicles);
_QS_flyBySpeed = 'FULL';
_QS_flyByAltitude = 50 + (random 150);
if ((random 1) > 0.666) then {
	_startPos1 = [worldSize,(_centerPos # 1),100];
	_startPos2 = [worldSize,((_centerPos # 1) + 50),100];
	_endPos1 = [0,(_centerPos # 1),100];
	_endPos2 = [0,((_centerPos # 1) + 50),100];
} else {
	_startPos1 = [0,(_centerPos # 1),100];
	_startPos2 = [0,((_centerPos # 1) + 50),100];
	_endPos1 = [worldSize,(_centerPos # 1),100];
	_endPos2 = [worldSize,((_centerPos # 1) + 50),100];
};
missionNamespace setVariable ['QS_defend_terminate',FALSE,FALSE];
sleep 2;
if (_allPlayersCount > 20) then {
	if ((random 1) > 0.666) then {
		if (isClass (missionConfigFile >> 'CfgSounds' >> 'Bells')) then {
			['playSound','Bells'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
_vehicleReammoDelay = time + 30;
//comment 'Get all HQ building positions so units know where to go';
_hqBuildingPositions = [];
_hqBuildings = nearestObjects [_centerPos,['House','Building'],50,TRUE];
private _hqBuildingPosition = [0,0,0];
{
	_building = _x;
	_buildingPositions = _building buildingPos -1;
	_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (_buildingPositions isNotEqualTo []) then {
		{
			_hqBuildingPosition = _x;
			0 = _hqBuildingPositions pushBack _hqBuildingPosition;
		} forEach _buildingPositions;
	};
} forEach _hqBuildings;
if (_hqBuildingPositions isNotEqualTo []) then {
	_hqBuildingPositions = _hqBuildingPositions apply {[(_x # 0),(_x # 1),((_x # 2) + 1)]};
};
_sectorControlTicker = 0;
_sectorControlThreshold = 7;
_enemyInHQCount = 0;
_playersInHQCount = 0;
_defendMessage = selectRandom _defendMessages;
['sideChat',[WEST,'HQ'],_defendMessage] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
_QS_priorMissionStatistics = [0,0];
private _priorDefendStats = [];
if !(missionProfileNamespace isNil 'QS_defendHQ_statistics') then {
	_QS_priorMissionStatistics = missionProfileNamespace getVariable 'QS_defendHQ_statistics';
	if ((count _QS_priorMissionStatistics) > 100) then {
		_QS_priorMissionStatistics set [0,FALSE];
		_QS_priorMissionStatistics deleteAt 0;
		missionProfileNamespace setVariable ['QS_defendHQ_statistics',_QS_priorMissionStatistics];
		saveMissionProfileNamespace;
	};
} else {
	missionProfileNamespace setVariable ['QS_defendHQ_statistics',_QS_priorMissionStatistics];
	saveMissionProfileNamespace;
};
if (missionProfileNamespace isNil 'QS_defend_stat_2') then {
	missionProfileNamespace setVariable ['QS_defend_stat_2',[]];
	saveMissionProfileNamespace;
} else {
	_priorDefendStats = missionProfileNamespace getVariable 'QS_defend_stat_2';
	if ((count _priorDefendStats) > 100) then {
		_priorDefendStats set [0,FALSE];
		_priorDefendStats deleteAt 0;
		missionProfileNamespace setVariable ['QS_defend_stat_2',_QS_priorMissionStatistics];
		saveMissionProfileNamespace;
	};
};
_currentStats = [_allPlayersCount,(count (allPlayers inAreaArray [(missionNamespace getVariable 'QS_hqPos'),300,300,0,FALSE])),0,0,_exitSuccess];
private _unitGroup = grpNull;
private _groupLeader = objNull;
missionNamespace setVariable ['QS_defend_blockTimeout',FALSE,FALSE]; //missionNamespace setVariable ['QS_defend_blockTimeout',((random 1) > 0.95),FALSE];
private _extended = FALSE;
private _blockMessageShown = FALSE;
private _blockMessage = localize 'STR_QS_Chat_015';
missionNamespace setVariable ['QS_AI_targetsKnowledge_suspend',TRUE,FALSE];
//comment 'Functions preload';
_fn_serverDetector = missionNamespace getVariable 'QS_fnc_serverDetector';
_fn_findSafePos = missionNamespace getVariable 'QS_fnc_findSafePos';
_fn_waterIntersect = missionNamespace getVariable 'QS_fnc_waterIntersect';
_fn_findOverwatchPos = missionNamespace getVariable 'QS_fnc_findOverwatchPos';
_fn_setAISkill = missionNamespace getVariable 'QS_fnc_serverSetAISkill';
_fn_taskAttack = missionNamespace getVariable 'QS_fnc_taskAttack';
_fn_vehicleLoadouts = missionNamespace getVariable 'QS_fnc_vehicleLoadouts';
_fn_spawnGroup = missionNamespace getVariable 'QS_fnc_spawnGroup';
_fn_downgradeVehicleWeapons = missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons';
_fn_unitSetup = missionNamespace getVariable 'QS_fnc_unitSetup';
_fn_taskSetProgress = missionNamespace getVariable 'QS_fnc_taskSetProgress';
_fn_setFlag = missionNamespace getVariable 'QS_fnc_setFlag';
_fn_getAIMotorPool = missionNamespace getVariable 'QS_fnc_getAIMotorPool';

diag_log 'Defend AO 1';
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_tickTimeNow = diag_tickTime;
	_serverTime = serverTime;
	_allPlayers = allPlayers;
	_allPlayersCount = count _allPlayers;
	_allArray = _allArray select {(alive _x)};
	if (_timeNow > _uavInitialSpawnDelay) then {
		if (_timeNow > _uavCheckDelay) then {
			if (_timeNow > _uavSpawnDelay) then {
				if (({(alive _x)} count _uavArray) < _uavMaxSpawned) then {
					_foundSpawnPos = FALSE;
					for '_x' from 0 to 49 step 1 do {
						_spawnPos = _centerPos getPos [(2000 + (random 2000)),(random 360)];
						if ((_allPlayers inAreaArray [_spawnPos,1000,1000,0,FALSE]) isEqualTo []) then {
							_foundSpawnPos = TRUE;
						};
						if (_foundSpawnPos) exitWith {};
					};
					_uavType = selectRandom _uavTypes;
					_uav = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _uavType,_uavType],_spawnPos,[],0,'FLY'];
					_grp = createVehicleCrew _uav;
					if (_allPlayersCount >= 15) then {
						[_uav,1,[]] call _fn_vehicleLoadouts;
					} else {
						{ 
							_uav removeWeaponGlobal (getText (configFile >> 'CfgMagazines' >> _x >> 'pylonWeapon'));
						} forEach (getPylonMagazines _uav);
					};
					clearMagazineCargoGlobal _uav;
					clearWeaponCargoGlobal _uav;
					clearItemCargoGlobal _uav;
					clearBackpackCargoGlobal _uav;
					_uav setVariable ['QS_uav_protected',TRUE,FALSE];
					['setFeatureType',_uav,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_uav];
					0 = _uavArray pushBack _uav;
					0 = _allArray pushBack _uav;
					{
						0 = _allArray pushBack _x;
					} count (crew _uav);
					_uav setPos [((getPosWorld _uav) # 0),((getPosWorld _uav) # 1),_uavFlyInHeight];
					_direction = _spawnPos getDir _centerPos;
					_uav setDir _direction;
					_uav enableRopeAttach FALSE;
					_uav enableVehicleCargo FALSE;
					[(units _grp),0] call _fn_setAISkill;
					_wp = _grp addWaypoint [_centerPos,0];
					_wp setWaypointType 'LOITER';
					_wp setWaypointSpeed 'NORMAL';
					_wp setWaypointBehaviour 'CARELESS';
					_wp setWaypointCombatMode 'WHITE';
					_wp setWaypointLoiterType 'CIRCLE';
					_wp setWaypointLoiterRadius (800 + (random 300));
					_uav setVehicleReportRemoteTargets TRUE;
					_uav setVehicleReceiveRemoteTargets TRUE;
					_uav setVehicleRadar 1;
					_uav flyInHeight _uavFlyInHeight;
					_uav flyInHeightASL [_uavFlyInHeight,_uavFlyInHeight,_uavFlyInHeight];
					_grp setFormDir _direction;
					(gunner _uav) doWatch _centerPos;
					_uavSpawnDelay = time + 90;
				};
			};
			_uavCheckDelay = time + 5;
		};
	};
	if (_tickTimeNow > _infantryCheckDelay) then {
		if (_allPlayersCount > 0) then {_infantryMaxSpawned = _infantryLimit_0;};
		if (_allPlayersCount > 10) then {_infantryMaxSpawned = _infantryLimit_1;};
		if (_allPlayersCount > 20) then {_infantryMaxSpawned = _infantryLimit_2;};
		if (_allPlayersCount > 30) then {_infantryMaxSpawned = _infantryLimit_3;};
		if (_allPlayersCount > 40) then {_infantryMaxSpawned = _infantryLimit_4;};
		if (_allPlayersCount > 50) then {_infantryMaxSpawned = _infantryLimit_5;};
		if (_extended) then {
			_infantryMaxSpawned = round (_infantryMaxSpawned * 1.25);
		};
		_infantryArray = _infantryArray select {(alive _x)};
		if ((count _infantryArray) < _infantryMaxSpawned) then {
			_index = 0;
			for '_x' from 0 to 49 step 1 do {
				_spawnPos = ([[_centerPos,250,500,5,0,0.5,0],[_centerPos,300,550,5,0,0.5,0]] select ((random 1) > 0.666)) call _fn_findSafePos;
				if (
					(_spawnPos isNotEqualTo []) &&
					{((_allPlayers inAreaArray [_spawnPos,300,300,0,FALSE]) isEqualTo [])} &&
					{((_spawnPos distance2D _centerPos) < 1001)} &&
					{(_spawnPos call _fn_blacklist)} &&
					{(!([_spawnPos,_centerPos,25] call _fn_waterIntersect))}
				) exitWith {};
			};
			_infType = selectRandomWeighted _infTypes;
			_direction = _spawnPos getDir _centerPos;
			_grp = [_spawnPos,_direction,EAST,_infType,FALSE,grpNull,TRUE,TRUE] call _fn_spawnGroup;
			{
				0 = _infantryArray pushBack _x;
				0 = _allArray pushBack _x;
				_x enableStamina FALSE;
				_x enableFatigue FALSE;
				_x setDir _direction;
				//_x enableAIFeature ['AUTOCOMBAT',FALSE];
				_x enableAIFeature ['COVER',FALSE];
				_x enableAIFeature ['SUPPRESSION',FALSE];
			} forEach (units _grp);
			if (((random 1) > 0.8) || {(_extended)}) then {
				{
					_x setAnimSpeedCoef 1.1;
				} forEach (units _grp);
			};
			_grp enableAttack FALSE;
			_grp setCombatMode 'YELLOW';
			_grp setBehaviour 'AWARE';
			_grp setSpeedMode 'FULL';
			if ((random 1) > 0.5) then {
				{
					_x addEventHandler [
						'FiredNear',
						{
							{
								_x removeAllEventHandlers 'FiredNear';
								_x removeAllEventHandlers 'Hit';
								_x enableAIFeature ['TARGET',TRUE];
								_x enableAIFeature ['AUTOTARGET',TRUE];
							} forEach (units (group (_this # 0)));
						}
					];
					_x addEventHandler [
						'Hit',
						{
							{
								_x removeAllEventHandlers 'FiredNear';
								_x removeAllEventHandlers 'Hit';
								_x enableAIFeature ['TARGET',TRUE];
								_x enableAIFeature ['AUTOTARGET',TRUE];
							} forEach (units (group (_this # 0)));
						}
					];
					_x enableAIFeature ['TARGET',FALSE];
					_x enableAIFeature ['AUTOTARGET',FALSE];
				} forEach (units _grp);
			} else {
				{
					_x addEventHandler [
						'Hit',
						{
							(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
							(_this # 0) enableAIFeature ['TARGET',TRUE];
							(_this # 0) enableAIFeature ['AUTOTARGET',TRUE];
						}
					];
					_x enableAIFeature ['TARGET',FALSE];
					_x enableAIFeature ['AUTOTARGET',FALSE];
				} forEach (units _grp);
			};
			[(units _grp),([1,2] select ((random 1) > 0.8))] call _fn_setAISkill;
			if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 5) then {
				_wp = _grp addWaypoint [[_centerPosX,_centerPosY,1],5];
				_wp setWaypointType 'MOVE';
				_wp setWaypointSpeed 'FULL';
				_wp setWaypointBehaviour 'AWARE';
				_wp setWaypointCombatMode 'YELLOW';
				_grp setBehaviour 'AWARE';
				_wp setWaypointForceBehaviour TRUE;
				_wp setWaypointCompletionRadius 5;
				_grp setCurrentWaypoint _wp;
				_grp lockWP TRUE;
			} else {
				_grp move _centerPos;
			};
		};
		_infantryCheckDelay = _tickTimeNow + 5;
	};
	if (_timeNow > _armorInitialSpawnDelay) then {
		if (_timeNow > _armorCheckDelay) then {
			if (_allPlayersCount > 0) then {_armorMaxSpawned = 0;};
			if (_allPlayersCount > 10) then {_armorMaxSpawned = 1;};
			if (_allPlayersCount > 20) then {_armorMaxSpawned = 1;};
			if (_allPlayersCount > 30) then {_armorMaxSpawned = 2;};
			if (_allPlayersCount > 40) then {_armorMaxSpawned = 2;};
			if (_allPlayersCount > 50) then {_armorMaxSpawned = 3;};
			if (_armorMaxSpawned < 2) then {
				if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) > 1) then {
					_armorMaxSpawned = 2;
				};
			};
			{
				if (!canMove _x) then {
					_x setDamage [1,TRUE];
				};
			} forEach _armorArray;
			_armorArray = _armorArray select {(alive _x)};
			if ((count _armorArray) < _armorMaxSpawned) then {
				_foundSpawnPos = FALSE;
				_roadsValid = [];
				_nearRoads = [];
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = [_centerPos,600,1000,10,0,0.5,0] call _fn_findSafePos;
					
					if (
						(_spawnPos isNotEqualTo []) &&
						{((_allPlayers inAreaArray [_spawnPos,400,400,0,FALSE]) isEqualTo [])} &&
						{((_spawnPos distance2D _centerPos) < 1201)} &&
						{(_spawnPos call _fn_blacklist)} &&
						{(!([_spawnPos,_centerPos,25] call _fn_waterIntersect))}
					) then {
						_nearRoads = ((_spawnPos select [0,2]) nearRoads 150) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
						if (_nearRoads isNotEqualTo []) then {
							{
								if ((toLowerANSI (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
									0 = _roadsValid pushBack (getPosATL _x);
								};
							} count _nearRoads;
							if (_roadsValid isNotEqualTo []) then {
								_foundSpawnPos = TRUE;
								_spawnPos = selectRandom _roadsValid;
							};
						};
					};
					if (_foundSpawnPos) exitWith {};
				};
				_armorType = selectRandomWeighted ([_motorPool] call _fn_getAIMotorPool);
				_av = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _armorType,_armorType],_spawnPos,[],0,'NONE'];
				_av setVariable ['QS_dynSim_ignore',TRUE,FALSE];
				_av enableDynamicSimulation FALSE;
				0 = _armorArray pushBack _av;
				0 = _allArray pushBack _av;
				(missionNamespace getVariable 'QS_AI_vehicles') pushBack _av;
				clearMagazineCargoGlobal _av;
				clearWeaponCargoGlobal _av;
				clearItemCargoGlobal _av;
				clearBackpackCargoGlobal _av;
				_av setConvoySeparation 50;
				[_av] call _fn_downgradeVehicleWeapons;
				_av allowDamage FALSE;
				_av allowCrewInImmobile [TRUE,TRUE];
				[0,_av,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
				_av lock 2;
				_direction = _spawnPos getDir _centerPos;
				_av setDir _direction;
				_grp = createVehicleCrew _av;
				if (!((side _grp) in [EAST,RESISTANCE])) then {
					_grp = createGroup [EAST,TRUE];
					(crew _av) joinSilent _grp;
				};
				_destination = [_centerPos,(200 + (random 200)),(50 + (random 50)),10] call _fn_findOverwatchPos;
				_grp move _destination;
				_grp addVehicle _av;
				{
					doStop _x;
					_x doMove _destination;
					_x addEventHandler [
						'Killed',
						{
							params ['_killed'];
							_vehicle = vehicle _killed;
							if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
								_vehicle setDamage [1,TRUE];
							};
						}
					];
				} forEach (units _grp);
				_av enableRopeAttach FALSE;
				_av enableVehicleCargo FALSE;
				_av addEventHandler [
					'GetOut',
					{
						params ['_vehicle','','',''];
						if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
							_vehicle setDamage [1,TRUE];
						};
					}
				];
				[(units _grp),([1,2] select ((random 1) > 0.85))] call _fn_setAISkill;
				_grp setCombatMode 'RED';
				_grp setBehaviour 'AWARE';
				{
					0 = _allArray pushBack _x;
				} count (units _grp);
				if (!isNull (gunner _av)) then {
					(gunner _av) doWatch _centerPos;
				};
				if (!isNull (commander _av)) then {
					(commander _av) doWatch _centerPos;
				};
				_av allowDamage TRUE;
			};
			_armorCheckDelay = time + 15;
		};
	};
	
	
	//QS_core_vehicles_map getOrDefault [toLowerANSI _armorType,_armorType]
	
	if (_timeNow > _groundTransportInitialSpawnDelay) then {
		if (_timeNow > _groundTransportCheckDelay) then {
			if (_timeNow > _groundTransportSpawnDelay) then {
				if (_groundTransportSpawned < _groundTransportMaxSpawned) then {
					if (({(alive _x)} count _groundTransportArray) < _groundTransportMaxSpawned) then {
						_foundSpawnPos = FALSE;
						_roadsValid = [];
						_nearRoads = [];
						for '_x' from 0 to 49 step 1 do {
							_spawnPos = [_centerPos,600,1000,10,0,0.5,0] call _fn_findSafePos;
							if (
								(_spawnPos isNotEqualTo []) &&
								{((_allPlayers inAreaArray [_spawnPos,400,400,0,FALSE]) isEqualTo [])} &&
								{((_spawnPos distance2D _centerPos) < 1201)} &&
								{(_spawnPos call _fn_blacklist)} &&
								{(!([_spawnPos,_centerPos,25] call _fn_waterIntersect))}
							) then {
								_nearRoads = ((_spawnPos select [0,2]) nearRoads 150) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
								if (_nearRoads isNotEqualTo []) then {
									{
										if ((toLowerANSI (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
											0 = _roadsValid pushBack (getPosATL _x);
										};
									} count _nearRoads;
									if (_roadsValid isNotEqualTo []) then {
										_foundSpawnPos = TRUE;
										_spawnPos = selectRandom _roadsValid;
									};
								};
							};
							if (_foundSpawnPos) exitWith {};
						};
						_groundTransportType = selectRandom _groundTransportTypes;
						_v = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _groundTransportType,_groundTransportType],_spawnPos,[],0,'NONE'];
						_v setVariable ['QS_dynSim_ignore',TRUE,FALSE];
						_v enableDynamicSimulation FALSE;
						0 = _groundTransportArray pushBack _v;
						0 = _allArray pushBack _v;
						(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
						_v allowDamage FALSE;
						_v allowCrewInImmobile [FALSe,FALSE];
						_v setUnloadInCombat [FALSE,FALSE];
						/*/_v forceFollowRoad TRUE;/*/
						_v setConvoySeparation 50;
						_v lock 3;
						_v enableRopeAttach FALSE;
						_v enableVehicleCargo FALSE;
						clearMagazineCargoGlobal _v;
						clearWeaponCargoGlobal _v;
						clearItemCargoGlobal _v;
						clearBackpackCargoGlobal _v;
						_direction = _spawnPos getDir _centerPos;
						_v setDir _direction;
						_grp = createVehicleCrew _v;
						[(units _grp),3] call _fn_setAISkill;
						_v allowDamage TRUE;
						_v addEventHandler [
							'HandleDamage',
							{
								params ['_vehicle','_selection','_damage','_source','_ammo','',''];
								if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {_vehicle removeEventHandler [_thisEvent,_thisEventHandler];};
								if (_selection isNotEqualTo '?') then {
									_oldDamage = if (_selection isEqualTo '') then [{(damage _vehicle)},{(_vehicle getHit _selection)}];
									if (!isNull _source) then {
										_scale = 0.25;
										_oldDamage = if (_selection isEqualTo '') then [{(damage _vehicle)},{(_vehicle getHit _selection)}];
										_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
									} else {
										if (_ammo isEqualTo '') then {
											_scale = 0.25;
											if (['wheel',_selection,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
												_scale = 0.05;
											};
											_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
										};
									};
								};
							}
						];
						_v addEventHandler ['Killed',{(_this # 0) removeAllEventHandlers 'HandleDamage';}];
						_v addEventHandler [
							'GetOut',
							{
								params ['_vehicle','_position','_unit','_turret'];
								if (_unit isEqualTo (leader (group _unit))) then {
									(group _unit) move ((group _unit) getVariable ['QS_grp_movepos',(missionNamespace getVariable 'QS_hqPos')]);
								};
							}
						];
						_grp setVariable ['QS_IA_spawnPos',_spawnPos,TRUE];
						{
							_x call _fn_unitSetup;
							0 = _allArray pushBack _x;
							_x enableStamina FALSE;
							_x enableFatigue FALSE;
							_x allowFleeing 0;
						} count (units _grp);
						_grp2 = createGroup [_side,TRUE];
						_divisor = 1;
						if ((_v emptyPositions 'Cargo') > 6) then {
							_divisor = 2;
						};
						for '_x' from 0 to (round(((_v emptyPositions 'Cargo') - 1) / _divisor)) step 1 do {
							_unitType = selectRandom _unitTypes;
							_unit = _grp2 createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[0,0,0],[],0,'NONE'];
							sleep 0.1;
							_unit = _unit call _fn_unitSetup;
							_unit moveInAny _v;
						};
						{
							0 = _allArray pushBack _x;
							_x enableStamina FALSE;
							_x enableFatigue FALSE;
							//_x enableAIFeature ['AUTOCOMBAT',FALSE];
							_x enableAIFeature ['COVER',FALSE];
						} count (units _grp2);
						_unloadPos = [_centerPos,30,75,10,0,0.5,0] call _fn_findSafePos;
						_wp = _grp addWaypoint [_unloadPos,15];
						_wp setWaypointType 'TR UNLOAD';
						_wp setWaypointSpeed 'FULL';
						_wp setWaypointBehaviour 'CARELESS';
						_wp setWaypointCombatMode 'BLUE';
						_wp setWaypointCompletionRadius (50 + (random 100));
						_wp setWaypointStatements [
							'TRUE',
							'
								if (local this) then {
									(group this) setBehaviour "CARELESS";
									_v = vehicle this;
									{
										if (_x isNotEqualTo this) then {
											_x action ["getOut",(vehicle this)];
											_x leaveVehicle _v;
										};
									} count (crew _v);
									_wp = (group this) addWaypoint [((group this) getVariable "QS_IA_spawnPos"),0];
									_wp setWaypointType "MOVE";
									_wp setWaypointSpeed "FULL";
									_wp setWaypointBehaviour "CARELESS";
									_wp setWaypointCombatMode "BLUE";
								};
							'
						];
						_grp2 setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
						_grp2 setVariable ['QS_grp_movepos',_centerPos,FALSE];
						[(units _grp2),1] call _fn_setAISkill;
						_groundTransportSpawned = _groundTransportSpawned + 1;
						_groundTransportSpawnDelay = time + 5;
					};
				};
			};
			if (_groundTransportArray isNotEqualTo []) then {
				{
					if (_x isKindOf 'LandVehicle') then {
						if ((_x distance2D _centerPos) < 75) then {
							if (_x isNil 'QS_vehicle_canUnload') then {
								_x setVariable ['QS_vehicle_canUnload',TRUE,FALSE];
								_x setUnloadInCombat [TRUE,TRUE];
							};
						};
					};
				} forEach _groundTransportArray;
			};
			_groundTransportCheckDelay = time + 5;
		};
	};
	
	if (_vPara) then {
		if (_timeNow > _vParaInitialDelay) then {
			_vPara = FALSE;
			if (_vParaToSpawn > 0) then {
				for '_x' from 0 to (_vParaToSpawn - 1) step 1 do {
					_foundSpawnPos = FALSE;
					for '_x' from 0 to 49 step 1 do {
						_spawnPos = _centerPos getPos [(75 + (random 350)),(random 360)];
						_spawnPos set [2,75];
						if ((_allPlayers inAreaArray [_spawnPos,100,100,0,FALSE]) isEqualTo []) then {
							_foundSpawnPos = TRUE;
						};
						if (_foundSpawnPos) exitWith {};
					};
					_spawnPos set [2,(800 + (random 400))];
					_vParaType = selectRandom _vParaTypes;
					_vParaV = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vParaType,_vParaType],[0,0,(100 + (random 1000))],[],0,'NONE'];
					_allArray pushBack _vParaV;
					_vParaV setVariable ['QS_uav_protected',TRUE,FALSE];
					_vParaV setPos _spawnPos;
					_vParaV enableRopeAttach FALSE;
					_vParaV enableVehicleCargo FALSE;
					_vParaV setVariable ['QS_dynSim_ignore',TRUE,FALSE];
					_vParaV enableDynamicSimulation FALSE;
					clearMagazineCargoGlobal _vParaV;
					clearWeaponCargoGlobal _vParaV;
					clearItemCargoGlobal _vParaV;
					clearBackpackCargoGlobal _vParaV;
					createVehicleCrew _vParaV;
					if ((crew _vParaV) isNotEqualTo []) then {
						_grp = group (effectiveCommander _vParaV);
						{
							_x call _fn_unitSetup;
							0 = _allArray pushBack _x;
						} forEach (units _grp);
						_grp move (selectRandom _hqBuildingPositions);
						[(units _grp),1] call _fn_setAISkill;
					};
					if ((_vParaV emptyPositions 'CARGO') > 0) then {
						_grp3 = createGroup [_side,TRUE];
						for '_x' from 0 to ((_vParaV emptyPositions 'CARGO') - 1) step 1 do {
							_unitType = selectRandom _unitTypes;
							_unit = _grp3 createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[0,0,0],[],0,'NONE'];
							_unit = _unit call _fn_unitSetup;
							_unit assignAsCargo _vParaV;
							_unit moveInCargo _vParaV;
							0 = _allArray pushBack _unit;
						};
						_grp3 move (selectRandom _hqBuildingPositions);
						_grp3 setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
						[(units _grp3),1] call _fn_setAISkill;
					};
					_openHeight = _vParaHeightMin + (random _vParaHeightRandom);
					[_vParaV,_openHeight] spawn (missionNamespace getVariable 'QS_fnc_paraDrop');
					_vParaV lock 3;
					sleep 0.5;
				};
			};
		};
	};
	if (_tickTimeNow > _updateMoveDelay) then {
		if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 1) then {
			{
				if (alive _x) then {
					if ((vehicle _x) isKindOf 'CAManBase') then {
						_unit = _x;
						_unitGroup = group _unit;
						_groupLeader = leader _unitGroup;
						if ((_groupLeader distance2D _centerPos) > 50) then {
							if (_unit isEqualTo _groupLeader) then {
								if (((random 1) > 0.5) || {(weaponLowered _unit)}) then {
									if (((vectorMagnitude (velocity _groupLeader)) * 3.6) < 2) then {
										_unitGroup move (selectRandom _hqBuildingPositions);
									};
								};
							};
						} else {
							if (((random 1) > 0.333) || {(weaponLowered _unit)}) then {
								if ((random 1) > 0.5) then {
									_unit setUnitPosWeak (selectRandomWeighted ['UP',0.75,'MIDDLE',0.25]);
								};
								if (((vectorMagnitude (velocity _unit)) * 3.6) < 2) then {
									if ((random 1) > 0.5) then {
										if (alive (getAttackTarget _unit)) then {
											if (((getAttackTarget _unit) distance2D _unit) < 50) then {
												_moveToPos = getPosATL (getAttackTarget _unit);
											} else {
												_moveToPos = selectRandom _hqBuildingPositions;
											}
										} else {
											_moveToPos = selectRandom _hqBuildingPositions;
										};
									} else {
										_moveToPos = selectRandom _hqBuildingPositions;
									};
									_moveToPos = _moveToPos vectorAdd [0,0,1];
									if (_unit isEqualTo _groupLeader) then {
										if ((missionNamespace getVariable ['QS_debug_test',1]) isEqualTo 1) then {
											_unit commandMove _moveToPos;
										} else {
											_unitGroup move _moveToPos;
										};
									} else {
										_unit doMove _moveToPos;
									};
								};
							};
						};
					};
				};
				uiSleep 0.025;
			} count _allArray;
			if (_paratrooperArray isNotEqualTo []) then {
				_paratrooperArray = _paratrooperArray select {(alive _x)};
				if (_paratrooperArray isNotEqualTo []) then {
					{
						_unit = _x;
						if ((getSuppression _unit) < 0.5) then {
							doStop _unit;
							_unit doMove (selectRandom _hqBuildingPositions);
						};
					} forEach _paratrooperArray;
				};
			};	
		};
		if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 2) then {
			{
				if (alive _x) then {
					if ((vehicle _x) isKindOf 'CAManBase') then {
						_unit = _x;
						_unitGroup = group _unit;
						_groupLeader = leader _unitGroup;
						if ((_groupLeader distance2D _centerPos) > 25) then {
							if (_unit isEqualTo _groupLeader) then {
								if ((random 1) > 0.5) then {
									_unitGroup move [(_centerPosX + (6 - (random 12))),(_centerPosY + (6 - (random 12))),_centerPosZ];
								};
							};
						};
					};
				};
				uiSleep 0.025;
			} count _allArray;
			if (_paratrooperArray isNotEqualTo []) then {
				_paratrooperArray = _paratrooperArray select {(alive _x)};
				if (_paratrooperArray isNotEqualTo []) then {
					{
						_unit = _x;
						if ((getSuppression _unit) < 0.5) then {
							doStop _unit;
							_unit doMove (selectRandom _hqBuildingPositions);
						};
					} forEach _paratrooperArray;
				};
			};		
		};
		if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 3) then {
			{
				if (alive _x) then {
					if ((vehicle _x) isKindOf 'CAManBase') then {
						_unit = _x;
						doStop _unit;
						_unit doMove [(_centerPosX + (6 - (random 12))),(_centerPosY + (6 - (random 12))),_centerPosZ];
					};
				};
				uiSleep 0.025;
			} count _allArray;
			if (_paratrooperArray isNotEqualTo []) then {
				_paratrooperArray = _paratrooperArray select {(alive _x)};
				if (_paratrooperArray isNotEqualTo []) then {
					{
						_unit = _x;
						if ((getSuppression _unit) < 0.5) then {
							doStop _unit;
							_unit doMove (selectRandom _hqBuildingPositions);
						};
					} forEach _paratrooperArray;
				};
			};				
		};
		if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 4) then {
			{
				if (alive _x) then {
					if ((vehicle _x) isKindOf 'CAManBase') then {
						_unit = _x;
						if ((getSuppression _unit) < 0.5) then {
							doStop _unit;
							_unit doMove [(_centerPosX + (6 - (random 12))),(_centerPosY + (6 - (random 12))),_centerPosZ];
						};
					};
				};
				uiSleep 0.025;
			} count _allArray;
			if (_paratrooperArray isNotEqualTo []) then {
				_paratrooperArray = _paratrooperArray select {(alive _x)};
				if (_paratrooperArray isNotEqualTo []) then {
					{
						_unit = _x;
						if ((getSuppression _unit) < 0.5) then {
							doStop _unit;
							_unit doMove (selectRandom _hqBuildingPositions);
						};
					} forEach _paratrooperArray;
				};
			};
		};
		if ((missionNamespace getVariable ['QS_defend_propulsion',1]) isEqualTo 5) then {

		};
		_updateMoveDelay = diag_tickTime + (random [5,10,15]);
	};
	if (_QS_flyBy) then {
		if (_timeNow > _QS_flyByDelay) then {
			_QS_flyBy = FALSE;
			{
				_x call (missionNamespace getVariable 'BIS_fnc_ambientFlyby');
			} forEach [
				[_startPos1,_endPos1,_QS_flyByAltitude,_QS_flyBySpeed,_QS_flyByType,_side],
				[_startPos2,_endPos2,_QS_flyByAltitude,_QS_flyBySpeed,_QS_flyByType,_side]
			];
		};
	};
	if (_QS_airSuperiority) then {
		if (_timeNow > _jetInitialDelay) then {
			_QS_airSuperiority = FALSE;
			for '_x' from 0 to (_jetsToSpawn - 1) step 1 do {
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = _centerPos getPos [(4000 + (random 2000)),(random 360)];
					if ((_allPlayers inAreaArray [_spawnPos,1000,1000,0,FALSE]) isEqualTo []) exitWith {};
				};
				_jet = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _jetType,_jetType],_spawnPos,[],0,'FLY'];
				_jetArray pushBack _jet;
				_jet engineOn TRUE;
				_jet allowCrewInImmobile [TRUE,TRUE];
				_jet lock 2;
				_jet enableRopeAttach FALSE;
				[_jet,([1,2] select ((random 1) > 0.5)),[]] call _fn_vehicleLoadouts;
				clearMagazineCargoGlobal _jet;
				clearWeaponCargoGlobal _jet;
				clearItemCargoGlobal _jet;
				clearBackpackCargoGlobal _jet;
				_grp = createVehicleCrew _jet;
				[_grp,_centerPos,FALSE] call _fn_taskAttack;
				_grp enableAttack TRUE;
				_grp lockWP TRUE;
				_grp addVehicle _jet;
				['setFeatureType',_jet,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_jet];
				_jet setVehicleReportRemoteTargets TRUE;
				_jet setVehicleReceiveRemoteTargets TRUE;
				_jet setVehicleRadar 1;
				[(units _grp),4] call _fn_setAISkill;
				(driver _jet) enableStamina FALSE;
				(driver _jet) enableFatigue FALSE;
				0 = _allArray pushBack _jet;
				0 = _allArray pushBack (driver _jet);
				_grp setCombatMode 'RED';
			};
		};
	};
	if (_helicopters) then {
		if (_timeNow > _helicopterInitialDelay) then {
			_helicopters = FALSE;
			for '_x' from 0 to (_helicoptersToSpawn - 1) step 1 do {
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = _centerPos getPos [(3000 + (random 2000)),(random 360)];
					if ((_allPlayers inAreaArray [_spawnPos,1000,1000,0,FALSE]) isEqualTo []) exitWith {};
				};
				_helicopterType = selectRandom _helicopterTypes;
				_helicopter = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _helicopterType,_helicopterType],_spawnPos,[],0,'FLY'];
				[_helicopter,2,[]] call _fn_vehicleLoadouts;
				['setFeatureType',_helicopter,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_helicopter];
				_allArray pushBack _helicopter;
				_helicopterArray pushBack _helicopter;
				_grp = createVehicleCrew _helicopter;
				_direction = _spawnPos getDir _centerPos;
				_helicopter setDir _direction;
				_helicopter lock 2;
				_helicopter allowCrewInImmobile [TRUE,TRUE];
				clearMagazineCargoGlobal _helicopter;
				clearWeaponCargoGlobal _helicopter;
				clearItemCargoGlobal _helicopter;
				clearBackpackCargoGlobal _helicopter;
				if ((random 1) > 0) then {
					_helicopter setVariable ['QS_V_availableCargo',(round((_helicopter emptyPositions 'Cargo') * 2)),FALSE];
					_helicopter setVariable ['QS_V_dropInterval',(time + 10),FALSE];
				};
				[_grp,_centerPos,FALSE] call _fn_taskAttack;
				_grp lockWP TRUE;
				_grp setBehaviour 'AWARE';
				_grp setCombatMode 'RED';
				_grp setSpeedMode 'FULL';
				_grp enableAttack TRUE;
				[(units _grp),4] call _fn_setAISkill;
				_grp allowFleeing 0;
				{
					_x call _fn_unitSetup;
					0 = _allArray pushBack _x;
				} count (units _grp);
			};
		};
	};
	
	if (_timeNow > _heliParaCheckDelay) then {
		if (_helicopterArray isNotEqualTo []) then {
			{
				_heli = _x;
				if (!isNull _heli) then {
					if (alive _heli) then {
						if (canMove _heli) then {
							if (((getPosWorld _heli) # 2) > 40) then {
								if ((_heli distance2D _centerPos) < 400) then {
									if !(_heli isNil 'QS_V_availableCargo') then {
										if ((_heli getVariable 'QS_V_availableCargo') > 0) then {
											if (time > (_heli getVariable 'QS_V_dropInterval')) then {
												if ((count (units EAST)) < 150) then {
													if (isNull _heliParaGrp) then {
														_heliParaGrp = createGroup [_side,TRUE];
														_heliParaGrp move _centerPos;
													};
													_paratrooperType = selectRandom _paratrooperTypes;
													_parajumper = _heliParaGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _paratrooperType,_paratrooperType],[0,0,0],[],0,'NONE'];
													0 = _allArray pushBack _parajumper;
													_parajumper = _parajumper call _fn_unitSetup;
													if ((random 1) > 0.5) then {
														_LorR = 2;
													} else {
														_LorR = -2;
													};
													_parajumper setPos (_heli modelToWorld [_LorR,-5,-3]);
													//_parajumper enableAIFeature ['AUTOCOMBAT',FALSE];
													_parajumper enableAIFeature ['COVER',FALSE];
													_paratrooperArray pushBack _parajumper;
													sleep 0.01;
													_heli setVariable [
														'QS_V_availableCargo',
														((_heli getVariable 'QS_V_availableCargo') - 1),
														FALSE
													];
													_heli setVariable [
														'QS_V_dropInterval',
														(time + (3 + (random 7))),
														FALSE
													];
													_heliParaGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
													[(units _heliParaGrp),1] call _fn_setAISkill;
												};
											};
										};
									};
								};
							};
						};
					};
				};
			} count _helicopterArray;
		};
		_heliParaCheckDelay = time + 3;
	};
	
	if (_paratroopers) then {
		if (_timeNow > _paratrooperInitialDelay) then {
			_paratroopers = FALSE;
			_grp = createGroup [_side,TRUE];
			for '_x' from 0 to (_paratroopersToSpawn - 1) step 1 do {
				_spawnPos = _centerPos getPos [(250 + (random 150)),(random 360)];
				_spawnPos set [2,(60 + (random 150))];
				_paratrooperType = selectRandom _paratrooperTypes;
				_paratrooper = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _paratrooperType,_paratrooperType],[0,0,0],[],0,'NONE'];
				_paratrooper = _paratrooper call _fn_unitSetup;
				0 = _allArray pushBack _paratrooper;
				0 = _paratrooperArray pushBack _paratrooper;
				if ((backpack _paratrooper) isNotEqualTo QS_core_classNames_parachute) then {
					_paratrooper addBackpack QS_core_classNames_parachute;
				};
				//_paratrooper enableAIFeature ['AUTOCOMBAT',FALSE];
				_paratrooper enableAIFeature ['COVER',FALSE];
				_paratrooper setPos _spawnPos;
			};
			_grp move (selectRandom _hqBuildingPositions);
			_grp enableAttack TRUE;
			_grp setSpeedMode 'FULL';
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			[(units _grp),1] call _fn_setAISkill;
		};
	};
	
	if (_paratroopers2) then {
		if (_timeNow > _paratrooper2InitialDelay) then {
			_paratroopers2 = FALSE;
			if ((count (units EAST)) < 125) then {
				_grp = createGroup [_side,TRUE];
				for '_x' from 0 to (_paratroopersToSpawn - 1) step 1 do {
					_spawnPos = _centerPos getPos [(250 + (random 150)),(random 360)];
					_spawnPos set [2,(60 + (random 150))];
					_paratrooperType = selectRandom _paratrooperTypes;
					_paratrooper = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _paratrooperType,_paratrooperType],[0,0,0],[],0,'NONE'];
					_paratrooper = _paratrooper call _fn_unitSetup;
					//_paratrooper enableAIFeature ['AUTOCOMBAT',FALSE];
					_paratrooper enableAIFeature ['COVER',FALSE];
					0 = _allArray pushBack _paratrooper;
					0 = _paratrooperArray pushBack _paratrooper;
					if ((backpack _paratrooper) isNotEqualTo QS_core_classNames_parachute) then {
						_paratrooper addBackpack QS_core_classNames_parachute;
					};
					_paratrooper setPos _spawnPos;
				};
				_grp move (selectRandom _hqBuildingPositions);
				_grp enableAttack TRUE;
				_grp setSpeedMode 'FULL';
				_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				[(units _grp),1] call _fn_setAISkill;
			};
		};
	};
	
	if (_timeNow > _vehicleReammoDelay) then {
		if (_allArray isNotEqualTo []) then {
			{
				if (!isNull _x) then {
					_x setVehicleAmmo 1;
				};
				sleep 0.007;
			} count _allArray;
		};
		_vehicleReammoDelay = time + 70;
	};
	
	if (_timeNow > _updatePlayers) then {
		_playersInArea = _allPlayers inAreaArray [_centerPos,600,600,0,FALSE];
		if (_playersInArea isNotEqualTo []) then {
			_playerVehicles = [];
			{
				if (!isNull (objectParent _x)) then {
					0 = _playerVehicles pushBack _x;
				};
			} count _playersInArea;
			if (_playerVehicles isNotEqualTo []) then {
				{
					if (_x isKindOf 'CAManBase') then {
						if (alive _x) then {
							_unit = _x;
							if (!(isNull (objectParent _unit))) then {
								{
									if (alive _x) then {
										if ((_unit knowsAbout _x) < 1) then {
											_unit reveal [_x,(round(random 4))];
										};
									};
								} count _playerVehicles;
							};
						};
					};
				} forEach _allArray;
			};
		};
		_updatePlayers = time + 15;
	};
	
	if (!(_durationAlmostOverHint)) then {
		if (serverTime > _durationAlmostOver) then {
			_durationAlmostOverHint = TRUE;
			if ((random 1) > 0.5) then {
				_text = localize 'STR_QS_Chat_013';
			} else {
				_text = localize 'STR_QS_Chat_014';
			};
			['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	
	if (serverTime > _duration) then {
		if (!(missionNamespace getVariable ['QS_defend_blockTimeout',FALSE])) then {
			_exitSuccess = TRUE;
		} else {
			if (!(_blockMessageShown)) then {
				_extended = TRUE;
				missionNamespace setVariable ['QS_defend_blockTimeout',FALSE,FALSE];
				_duration = serverTime + 600 + (random 600);
				//[_taskID,TRUE,_duration] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
				_blockMessageShown = TRUE;
				['sideChat',[WEST,'HQ'],_blockMessage] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
		};
	};

	if (_timeNow > _checkHeldInitialDelay) then {
		if (_timeNow > _checkHeldDelay) then {
			_enemyInHQCount = count ((units EAST) inAreaArray [_centerPos,25,25,0,FALSE,-1]);
			_playersInHQCount = count ((units WEST) inAreaArray [_centerPos,35,35,0,FALSE,-1]);
			if (_playersInHQCount isEqualTo 0) then {
				//comment 'No players in HQ';
				if (_enemyInHQCount > 3) then {
					//comment 'More than 3 enemies in HQ';
					_exitFail = TRUE;
				};
			} else {
				//comment 'There are still players in HQ area';
				if (_enemyInHQCount >= 5) then {
					//comment 'There are more than 5 enemies in HQ';
					if (_sectorControlTicker isEqualTo 1) then {
						['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_016'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
					if (_sectorControlTicker > _sectorControlThreshold) then {
						_exitFail = TRUE;
					};
					if (!(_exitFail)) then {
						_sectorControlTicker = _sectorControlTicker + 1;
						if ((round((_sectorControlTicker / _sectorControlThreshold) * 100)) >= 100) then {
							//['systemChat',localize 'STR_QS_Chat_079'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				} else {
					//comment 'Less than 10 enemies in HQ';
					if (_sectorControlTicker isNotEqualTo 0) then {
						if (_enemyInHQCount < 8) then {
							//comment 'Below threshold of acceptable enemies in HQ';
							_sectorControlTicker = 0;
						};
					};
				};
			};
			[_hqFlag,WEST,'',FALSE,objNull,(0 max (1 - (_sectorControlTicker / _sectorControlThreshold)) min 1)] call _fn_setFlag;
			[_taskID,TRUE,(0 max (1 - (_sectorControlTicker / _sectorControlThreshold)) min 1)] call _fn_taskSetProgress;
			_checkHeldDelay = time + 15;
		};
	};
	
	if (_exitSuccess) exitWith {
		[_hqFlag,WEST,'',FALSE,objNull,1] call _fn_setFlag;
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_017'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['DEFEND_SUCCESS',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_005']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_DEFENDHQ','SUCCEEDED',FALSE] call (missionNamespace getVariable 'BIS_fnc_taskSetState');
		missionProfileNamespace setVariable [
			'QS_defendHQ_statistics',
			[
				(((missionProfileNamespace getVariable 'QS_defendHQ_statistics') # 0) + 1),
				((missionProfileNamespace getVariable 'QS_defendHQ_statistics') # 1)
			]
		];
	};
	if (_exitFail) exitWith {
		[_hqFlag,EAST,'',FALSE,objNull,1] call _fn_setFlag;
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_018'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['DEFEND_FAIL',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_006']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_DEFENDHQ','FAILED',FALSE] call (missionNamespace getVariable 'BIS_fnc_taskSetState');
		missionProfileNamespace setVariable [
			'QS_defendHQ_statistics',
			[
				((missionProfileNamespace getVariable 'QS_defendHQ_statistics') # 0),
				(((missionProfileNamespace getVariable 'QS_defendHQ_statistics') # 1) + 1)
			]
	   ];
	};
	if (missionNamespace getVariable 'QS_defend_terminate') exitWith {
		['hint','Defense cancelled!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	sleep 1.5;
};
missionNamespace setVariable ['QS_defend_blockTimeout',FALSE,FALSE];
_currentStats set [2,(count allPlayers)];
_currentStats set [3,([(missionNamespace getVariable 'QS_HQpos'),300,[WEST],allPlayers,1] call (missionNamespace getVariable 'QS_fnc_serverDetector'))];
_currentStats set [4,_exitSuccess];
_defendStats = [];
_defendStats = missionProfileNamespace getVariable 'QS_defend_stat_2';
_defendStats pushBack _currentStats;
missionProfileNamespace setVariable ['QS_defend_stat_2',_defendStats];
saveMissionProfileNamespace;
{
	_x setMarkerAlpha 0;
} forEach ['QS_marker_aoCircle','QS_marker_aoMarker'];
sleep 3;
[_taskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
sleep 7 + (random 7);
deleteVehicle _allArray;
deleteVehicle (allMines inAreaArray [_centerPos,300,300,0,FALSE]);
if ((count allPlayers) > 5) then {
	if ((random 1) > 0.666) then {
		if (isClass (missionConfigFile >> 'CfgSounds' >> 'TheEnd')) then {
			['playSound','TheEnd'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
diag_log 'Defend AO 2';
{
	missionNamespace setVariable _x;
} forEach [
	['QS_AI_targetsKnowledge_suspend',FALSE,FALSE],
	['QS_system_restartEnabled',TRUE,FALSE],
	['QS_defendActive',FALSE,TRUE]
];