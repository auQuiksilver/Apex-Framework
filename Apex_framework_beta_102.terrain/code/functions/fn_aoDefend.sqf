/*/
File: fn_aoDefend.sqf
Author:

	Quiksilver
	
Last modified:

	2/12/2017 A3 1.78 by Quiksilver
	
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
	'_QS_flyByType','_QS_flyBySpeed','_QS_flyByAltitude','_allPlayersCount','_exitSuccess','_exitFail','_defendMessages','_targetStartText',
	'_durationAlmostOver','_durationAlmostOverHint','_heli','_heliParaGrp','_heliParaCheckDelay','_paratroopers2','_paratrooper2InitialDelay',
	'_LorR','_vPara','_vParaTypes','_vParaType','_vParaV','_vParaInitialDelay','_vParaHeightMin','_vParaHeightRandom','_vParaDelay','_vParaArray',
	'_vParaToSpawn','_grp3','_openHeight','_QS_priorMissionStatistics','_currentStats','_defendStats','_vehicleReammoDelay','_groundTransportSpawned',
	'_divisor','_hqBuildings','_hqBuildingPositions','_building','_buildingPositions','_sectorControlTicker','_sectorControlThreshold','_text',
	'_enemyInHQCount','_playersInHQCount','_moveToPos','_infantrySpawnDistanceFixed','_infantrySpawnDistanceRandom','_infantrySpawnDistanceFromPlayer',
	'_fn_blacklist','_QS_worldName','_QS_worldSize','_nearRoads','_roadsValid','_validRoadSurfaces','_timeNow','_tickTimeNow','_serverTime','_taskID'
];

diag_log 'Defend AO 0';
_allPlayersCount = count allPlayers;
if (diag_fps < 13) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
/*/if (([(missionNamespace getVariable 'QS_HQpos'),400,[WEST],allPlayers,1] call (missionNamespace getVariable 'QS_fnc_serverDetector')) < 4) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};/*/
if (((random 1) > 0.333) && ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo 1) then {missionNamespace setVariable ['QS_forceDefend',0,TRUE];};
if ((missionNamespace getVariable 'QS_forceDefend') isEqualTo -1) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
if ((_allPlayersCount > 60) && ((missionNamespace getVariable 'QS_defendCount') > 0)) exitWith {missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];};
missionNamespace setVariable ['QS_defendCount',((missionNamespace getVariable 'QS_defendCount') + 1),TRUE];
['sideChat',[WEST,'HQ'],'The enemy is attacking! Defend the HQ at all cost!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
_defendMessages = [
	'OPFOR Forces incoming! Seek cover immediately and defend the objective the HQ!',
	'The enemy managed to mount a counterattack! Hold the HQ at all cost!',
	'Dig in at the HQ boys, they are coming!'
];
_targetStartText = parseText format [
	"<t align='center' size='2.2'>Defend HQ</t><br/><t size='1.5' align='center' color='#0d4e8f'>%1</t><br/>____________________<br/>Intel reports CSAT is launching a massive counterattack. Defend the HQ at all cost!",
	(missionNamespace getVariable 'QS_aoDisplayName')
];
['hint',_targetStartText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['DEFEND_HQ',['Defend','Defend HQ']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
{
	_x setMarkerAlpha 0.75;
	_x setMarkerPos (missionNamespace getVariable 'QS_HQpos');
} forEach ['QS_marker_aoCircle','QS_marker_aoMarker'];
'QS_marker_aoMarker' setMarkerText format['%1Defend %2 HQ',(toString [32,32,32]),(missionNamespace getVariable 'QS_aoDisplayName')];
_centerPos = missionNamespace getVariable 'QS_HQpos';
_taskID = 'QS_IA_TASK_DEFENDHQ';
[_taskID,TRUE,['Defend the HQ boys!','Defend HQ','Defend HQ'],_centerPos,'AUTOASSIGNED',5,FALSE,TRUE,'Defend',TRUE] call (missionNamespace getVariable 'BIS_fnc_setTask');
_timeNow = time;
_serverTime = serverTime;
_tickTimeNow = diag_tickTime;
_QS_worldName = worldName;
_QS_worldSize = worldSize;
_duration = serverTime + 920 + (random 420);
_durationAlmostOver = _duration - 30 - (random 60);
[_taskID,TRUE,_duration] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
[_taskID,['Defend','Defend 1','Defend 2']] call (missionNamespace getVariable 'QS_fnc_taskSetCustomData');
[_taskID,TRUE,0] call (missionNamespace getVariable 'QS_fnc_taskSetProgress');
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
if (_QS_worldName isEqualTo 'Tanoa') then {
	_fn_blacklist = {
		private _c = TRUE;
		{
			if ((_this distance2D (_x select 0)) < (_x select 1)) exitWith {
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
if (_allPlayersCount > 0) then {_uavMaxSpawned = 0;};
if (_allPlayersCount > 10) then {_uavMaxSpawned = 0;};
if (_allPlayersCount > 20) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 30) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 40) then {_uavMaxSpawned = 1;};
if (_allPlayersCount > 50) then {_uavMaxSpawned = 0;};
_uavArray = [];
_uavCheckDelay = time + 5;
_uavSpawnDelay = time + 5;
_uavTypes = ['O_UAV_02_dynamicLoadout_F','I_UAV_02_dynamicLoadout_F','O_T_UAV_04_CAS_F'];
_uavType = '';
_uav = objNull;
_uavFlyInHeight = 600 + (random 1400);
_QS_infantry = TRUE;
_infantryInitialSpawnDelay = time + 0;
if (_allPlayersCount > 0) then {_infantryMaxSpawned = 27;};
if (_allPlayersCount > 10) then {_infantryMaxSpawned = 35;};
if (_allPlayersCount > 20) then {_infantryMaxSpawned = 40;};
if (_allPlayersCount > 30) then {_infantryMaxSpawned = 51;};
if (_allPlayersCount > 40) then {_infantryMaxSpawned = 59;};
if (_allPlayersCount > 50) then {_infantryMaxSpawned = 68;};
_infantryArray = [];
_infantryCheckDelay = time + 10;
_infantrySpawnDelay = time + 10;
if (worldName isEqualTo 'Tanoa') then {
	_infantrySpawnDistanceFixed = 1000;
	_infantrySpawnDistanceRandom = 1000;
	_infantrySpawnDistanceFromPlayer = 750;
} else {
	_infantrySpawnDistanceFixed = 2000;
	_infantrySpawnDistanceRandom = 2000;
	_infantrySpawnDistanceFromPlayer = 750;
};
_infTypes = [
	'OIA_InfSentry','OIA_InfSquad','OIA_InfTeam','OI_reconSentry',
	'OIA_InfAssault','OIA_InfTeam_AA','OIA_InfTeam_AT','OIA_InfSquad_Weapons','OIA_InfAssault'
];
_infType = '';
_QS_armor = TRUE;
_armorInitialSpawnDelay = time + 60 + (random 60);
if (_allPlayersCount > 0) then {_armorMaxSpawned = 0;};
if (_allPlayersCount > 10) then {_armorMaxSpawned = 0;};
if (_allPlayersCount > 20) then {_armorMaxSpawned = 1;};
if (_allPlayersCount > 30) then {if ((random 1) > 0.666) then {_armorMaxSpawned = 2;} else {_armorMaxSpawned = 1;};};
if (_allPlayersCount > 40) then {_armorMaxSpawned = 2;};
if (_allPlayersCount > 50) then {if ((random 1) > 0.666) then {_armorMaxSpawned = 3;} else {_armorMaxSpawned = 2;};};
_armorArray = [];
_armorCheckDelay = time + 5;
_armorSpawnDelay = time + 5;
private _isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
if (_isArmedAirEnabled) then {
	if ((random 1) > 0.333) then {
		if (worldName isEqualTo 'Tanoa') then {
			_armorTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MBT_02_cannon_ghex_F","O_T_APC_Tracked_02_AA_ghex_F",'I_APC_Wheeled_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_T_LSV_02_armed_ghex_F'
			];	
		} else {
			_armorTypes = [
				'O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_F','O_MBT_02_cannon_F','O_APC_Tracked_02_AA_F','I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F','I_MBT_03_cannon_F','O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F'
			];
		};
	} else {
		if (worldName isEqualTo 'Tanoa') then {
			_armorTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_MBT_02_cannon_ghex_F","O_T_APC_Tracked_02_AA_ghex_F",'I_APC_Wheeled_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_T_LSV_02_armed_ghex_F'
			];
		} else {
			_armorTypes = [
				'O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_F','O_MBT_02_cannon_F','O_APC_Tracked_02_AA_F','I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F','I_MBT_03_cannon_F','O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F'
			];
		};
	};
} else {
	if ((random 1) > 0.333) then {
		if (worldName isEqualTo 'Tanoa') then {
			_armorTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_AA_ghex_F",'I_APC_Wheeled_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_T_LSV_02_armed_ghex_F'
			];	
		} else {
			_armorTypes = [
				'O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_F','O_APC_Tracked_02_AA_F','I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F','O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F'
			];
		};
	} else {
		if (worldName isEqualTo 'Tanoa') then {
			_armorTypes = [
				"O_T_APC_Tracked_02_cannon_ghex_F","O_T_APC_Wheeled_02_rcws_ghex_F","O_T_APC_Tracked_02_AA_ghex_F",'I_APC_Wheeled_03_cannon_F',
				'O_T_MRAP_02_gmg_ghex_F','O_T_MRAP_02_hmg_ghex_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','O_T_LSV_02_armed_ghex_F'
			];
		} else {
			_armorTypes = [
				'O_APC_Tracked_02_cannon_F','O_APC_Wheeled_02_rcws_F','O_APC_Tracked_02_AA_F','I_APC_Wheeled_03_cannon_F',
				'I_APC_tracked_03_cannon_F','O_MRAP_02_gmg_F','O_MRAP_02_hmg_F','I_MRAP_03_gmg_F','I_MRAP_03_hmg_F'
			];
		};
	};
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
if (worldName isEqualTo 'Tanoa') then {
	_groundTransportTypes = [
		"O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F","O_T_Truck_03_transport_ghex_F","O_T_Truck_03_covered_ghex_F",
		'O_T_MRAP_02_ghex_F','I_MRAP_03_F','O_LSV_02_unarmed_ghex_F','O_LSV_02_unarmed_ghex_F'
	];
} else {
	_groundTransportTypes = [
		'O_Truck_03_transport_F','O_Truck_03_covered_F','O_Truck_02_transport_F','O_Truck_02_covered_F','I_Truck_02_transport_F','I_Truck_02_covered_F',
		"O_MRAP_02_F",'I_MRAP_03_F','O_LSV_02_unarmed_F','O_LSV_02_unarmed_ghex_F'
	];
};
_groundTransportType = '';
_v = objNull;
if (worldName isEqualTo 'Tanoa') then {
	_unitTypes = [
		'O_T_Soldier_SL_F','O_T_Soldier_F','O_T_Soldier_LAT_F','O_T_Soldier_M_F','O_T_Soldier_AR_F',
		'O_T_Soldier_A_F','O_T_medic_F'
	];
} else {
	_unitTypes = [
		'O_Soldier_SL_F','O_Soldier_F','O_Soldier_LAT_F','O_Soldier_M_F','O_Soldier_AR_F',
		'O_Soldier_A_F','O_medic_F'
	];
};
_unitType = '';
_foundSpawnPos = FALSE;
_spawnPos = [0,0,0];
_index = 0;
_grp = grpNull;
_QS_airSuperiority = TRUE;
_jetsToSpawn = 2;
if (_allPlayersCount > 0) then {_jetsToSpawn = 0;};
if (_allPlayersCount > 10) then {_jetsToSpawn = 0;};
if (_allPlayersCount > 20) then {_jetsToSpawn = 1;};
if (_allPlayersCount > 30) then {_jetsToSpawn = 1;};
if (_allPlayersCount > 40) then {_jetsToSpawn = 2;};
if (_allPlayersCount > 50) then {_jetsToSpawn = 2;};
_jetType = 'I_Plane_Fighter_03_dynamicLoadout_F';
_jetArray = [];
_jetInitialDelay = time + (20 + (random 40));
_jet = objNull;
_helicopters = TRUE;
_helicoptersToSpawn = 1;
if (_allPlayersCount > 0) then {_helicoptersToSpawn = 0;};
if (_allPlayersCount > 10) then {_helicoptersToSpawn = 0;};
if (_allPlayersCount > 20) then {_helicoptersToSpawn = 1;};
if (_allPlayersCount > 30) then {_helicoptersToSpawn = 1;};
if (_allPlayersCount > 40) then {_helicoptersToSpawn = 2;};
if (_allPlayersCount > 50) then {_helicoptersToSpawn = 2;};
if (_allPlayersCount > 20) then {
	if (worldName isEqualTo 'Tanoa') then {
		_helicopterTypes = [
			'o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f','o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f'
		];
	} else {
		_helicopterTypes = [
			'o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f','o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f','O_Heli_Attack_02_dynamicLoadout_black_F','O_Heli_Attack_02_dynamicLoadout_F'
		];	
		};
} else {
	_helicopterTypes = [
		'o_heli_light_02_dynamicloadout_f','O_Heli_Light_02_v2_F','i_heli_light_03_dynamicloadout_f'
	];
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
if (worldName isEqualTo 'Tanoa') then {
	_paratrooperTypes = ['O_T_soldier_PG_F','O_T_soldier_PG_F'];
} else {
	_paratrooperTypes = ['O_soldier_PG_F','O_soldier_PG_F'];
};
_paratrooperType = '';
_paratrooperArray = [];
_paratrooperInitialDelay = time + 240 + (random 240);
_paratrooper2InitialDelay = _paratrooperInitialDelay + 180 + (random 240);
_paratrooper = objNull;
_vPara = FALSE;
if ((random 1) > 0.666) then {
	_vPara = TRUE;
};
if (worldName isEqualTo 'Tanoa') then {
	_vParaTypes = [
		"O_T_MRAP_02_hmg_ghex_F","O_T_UGV_01_rcws_ghex_F",'O_T_MRAP_02_gmg_ghex_F',"O_T_LSV_02_armed_F","O_T_LSV_02_armed_F",
		'I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','Land_Pod_Heli_Transport_04_covered_F','Land_Pod_Heli_Transport_04_bench_F','Land_Pod_Heli_Transport_04_bench_F',
		'Land_Pod_Heli_Transport_04_covered_F','O_T_UGV_01_rcws_ghex_F'
	];
} else {
	_vParaTypes = [
		'O_MRAP_02_hmg_F','O_UGV_01_rcws_F','I_UGV_01_rcws_F','O_MRAP_02_gmg_F','O_G_Offroad_01_armed_F','O_G_Offroad_01_armed_F',
		'I_MRAP_03_gmg_F','I_MRAP_03_hmg_F','Land_Pod_Heli_Transport_04_covered_F','Land_Pod_Heli_Transport_04_bench_F','Land_Pod_Heli_Transport_04_bench_F',
		'Land_Pod_Heli_Transport_04_covered_F','O_UGV_01_rcws_F','I_UGV_01_rcws_F'
	];
};
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
_QS_flyBy = FALSE;
if (worldName isEqualTo 'Tanoa') then {
	_QS_flyByType = selectRandom ['O_T_VTOL_02_infantry_dynamicLoadout_F','O_Plane_CAS_02_dynamicLoadout_F'];
} else {
	_QS_flyByType = selectRandom ['O_T_VTOL_02_infantry_dynamicLoadout_F','O_Plane_CAS_02_dynamicLoadout_F'];
};
_QS_flyBySpeed = 'FULL';
_QS_flyByAltitude = 50 + (random 150);
if ((random 1) > 0.666) then {
	_startPos1 = [worldSize,(_centerPos select 1),100];
	_startPos2 = [worldSize,((_centerPos select 1) + 50),100];
	_endPos1 = [0,(_centerPos select 1),100];
	_endPos2 = [0,((_centerPos select 1) + 50),100];
} else {
	_startPos1 = [0,(_centerPos select 1),100];
	_startPos2 = [0,((_centerPos select 1) + 50),100];
	_endPos1 = [worldSize,(_centerPos select 1),100];
	_endPos2 = [worldSize,((_centerPos select 1) + 50),100];
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

comment 'Get all HQ building positions so units know where to go';
_hqBuildingPositions = [];
_hqBuildings = nearestObjects [_centerPos,['House','Building'],50];
private _hqBuildingPosition = [0,0,0];
{
	_building = _x;
	_buildingPositions = _building buildingPos -1;
	_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (!(_buildingPositions isEqualTo [])) then {
		{
			_hqBuildingPosition = _x;
			0 = _hqBuildingPositions pushBack _hqBuildingPosition;
		} forEach _buildingPositions;
	};
} forEach _hqBuildings;
if (!(_hqBuildingPositions isEqualTo [])) then {
	_hqBuildingPositions = _hqBuildingPositions apply {[(_x select 0),(_x select 1),((_x select 2) + 1)]};
};
_sectorControlTicker = 0;
_sectorControlThreshold = 6;
_enemyInHQCount = 0;
_playersInHQCount = 0;
_defendMessage = selectRandom _defendMessages;
['sideChat',[WEST,'HQ'],_defendMessage] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['sideChat',[WEST,'HQ'],'CSAT Assault will end in approximately 15-20 minutes.'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
_QS_priorMissionStatistics = [0,0];
private _priorDefendStats = [];
if (!isNil {profileNamespace getVariable 'QS_defendHQ_statistics'}) then {
	_QS_priorMissionStatistics = profileNamespace getVariable 'QS_defendHQ_statistics';
	if ((count _QS_priorMissionStatistics) > 100) then {
		_QS_priorMissionStatistics set [0,FALSE];
		_QS_priorMissionStatistics deleteAt 0;
		profileNamespace setVariable ['QS_defendHQ_statistics',_QS_priorMissionStatistics];
		saveProfileNamespace;
	};
} else {
	profileNamespace setVariable ['QS_defendHQ_statistics',_QS_priorMissionStatistics];
	saveProfileNamespace;
};
if (isNil {profileNamespace getVariable 'QS_defend_stat_2'}) then {
	profileNamespace setVariable ['QS_defend_stat_2',[]];
	saveProfileNamespace;
} else {
	_priorDefendStats = profileNamespace getVariable 'QS_defend_stat_2';
	if ((count _priorDefendStats) > 100) then {
		_priorDefendStats set [0,FALSE];
		_priorDefendStats deleteAt 0;
		profileNamespace setVariable ['QS_defend_stat_2',_QS_priorMissionStatistics];
		saveProfileNamespace;
	};
};
_currentStats = [_allPlayersCount,([(missionNamespace getVariable 'QS_HQpos'),300,[WEST],allPlayers,1] call (missionNamespace getVariable 'QS_fnc_serverDetector')),0,0,_exitSuccess];

private _unitGroup = grpNull;
private _groupLeader = objNull;

diag_log 'Defend AO 1';

for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	_tickTimeNow = diag_tickTime;
	_serverTime = serverTime;
	if (_timeNow > _uavInitialSpawnDelay) then {
		if (_timeNow > _uavCheckDelay) then {
			if (_timeNow > _uavSpawnDelay) then {
				if (({(alive _x)} count _uavArray) < _uavMaxSpawned) then {
					_foundSpawnPos = FALSE;
					for '_x' from 0 to 49 step 1 do {
						_spawnPos = _centerPos getPos [(2000 + (random 2000)),(random 360)];
						if (!(_spawnPos isEqualTo [])) then {
							if (({((_x distance _spawnPos) < 1000)} count allPlayers) isEqualTo 0) then {
								_foundSpawnPos = TRUE;
							};
						};
						if (_foundSpawnPos) exitWith {};
					};
					_uavType = selectRandom _uavTypes;
					_uav = createVehicle [_uavType,_spawnPos,[],0,'FLY'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					createVehicleCrew _uav;
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _uav))),
						FALSE
					];
					[_uav,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
					clearMagazineCargoGlobal _uav;
					clearWeaponCargoGlobal _uav;
					clearItemCargoGlobal _uav;
					clearBackpackCargoGlobal _uav;
					_uav setVariable ['QS_uav_protected',TRUE,(!isServer)];
					0 = _uavArray pushBack _uav;
					0 = _allArray pushBack _uav;
					{
						0 = _allArray;
					} count (crew _uav);
					_uav setPos [((getPosWorld _uav) select 0),((getPosWorld _uav) select 1),_uavFlyInHeight];
					_direction = _spawnPos getDir _centerPos;
					_uav setDir _direction;
					_uav enableRopeAttach FALSE;
					_uav enableVehicleCargo FALSE;
					_grp = group ((crew _uav) select 0);
					[(units _grp),0] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_wp = _grp addWaypoint [_centerPos,0];
					_wp setWaypointType 'LOITER';
					_wp setWaypointSpeed 'NORMAL';
					_wp setWaypointBehaviour 'CARELESS';
					_wp setWaypointCombatMode 'WHITE';
					_wp setWaypointLoiterType 'CIRCLE';
					_wp setWaypointLoiterRadius (800 + (random 300));
					_uav flyInHeight _uavFlyInHeight;
					_uav flyInHeightASL [_uavFlyInHeight,_uavFlyInHeight,_uavFlyInHeight];
					_grp setFormDir _direction;
					(gunner _uav) doWatch _centerPos;
					_uavSpawnDelay = time + 5;
				};
			};
			_uavCheckDelay = time + 5;
		};
	};
	if (_timeNow > _infantryInitialSpawnDelay) then {
		if (_timeNow > _infantryCheckDelay) then {
			if (_timeNow > _infantrySpawnDelay) then {
				if (({(alive _x)} count _infantryArray) < _infantryMaxSpawned) then {
					_index = 0;
					_foundSpawnPos = FALSE;
					for '_x' from 0 to 49 step 1 do {
						if ((random 1) > 0.333) then {
							_spawnPos = [_centerPos,400,700,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
						} else {
							_spawnPos = [_centerPos,300,600,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
						};
						if (!(_spawnPos isEqualTo [])) then {
							if (({((_x distance _spawnPos) < 300)} count allPlayers) isEqualTo 0) then {
								if ((_spawnPos distance _centerPos) < 1001) then {
									if (_spawnPos call _fn_blacklist) then {
										if (!([_spawnPos,_centerPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
											_foundSpawnPos = TRUE;
										};
									};
								};
							};
						};
						if (_foundSpawnPos) exitWith {};
					};
					if ((random 1) > 0.5) then {_side = EAST;} else {_side = RESISTANCE;};
					_infType = selectRandom _infTypes;
					_direction = _spawnPos getDir _centerPos;
					_grp = [_spawnPos,(random 360),_side,_infType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					_grp setFormDir _direction;
					{
						0 = _infantryArray pushBack _x;
						0 = _allArray pushBack _x;
						_x enableStamina FALSE;
						_x enableFatigue FALSE;
						_x setDir _direction;
						_x disableAI 'AUTOCOMBAT';
						_x disableAI 'COVER';
						_x disableAI 'SUPPRESSION';
					} forEach (units _grp);
					_grp setSpeedMode 'FULL';
					if ((random 1) > 0.8) then {
						[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					} else {
						[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					};
					_grp setFormDir _direction;
					if ((random 1) > 0.75) then {
						{
							_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP','UP']);
						} count (units _grp);
					};
					_infantrySpawnDelay = time + 10;
				};
			};
			_infantryCheckDelay = time + 10;
		};
	};
	if (_timeNow > _armorInitialSpawnDelay) then {
		if (_timeNow > _armorCheckDelay) then {
			if (_timeNow > _armorSpawnDelay) then {
				if (({(alive _x) && (canMove _x)} count _armorArray) < _armorMaxSpawned) then {
					_foundSpawnPos = FALSE;
					_roadsValid = [];
					_nearRoads = [];
					for '_x' from 0 to 49 step 1 do {
						_spawnPos = [_centerPos,700,1200,10,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
						if (!(_spawnPos isEqualTo [])) then {
							if (({((_x distance _spawnPos) < 400)} count allPlayers) isEqualTo 0) then {
								if ((_spawnPos distance _centerPos) < 1201) then {
									if (_spawnPos call _fn_blacklist) then {
										if (!([_spawnPos,_centerPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
											_nearRoads = (_spawnPos nearRoads 150) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};;
											if (!(_nearRoads isEqualTo [])) then {
												{
													if ((toLower (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
														0 = _roadsValid pushBack (getPosATL _x);
													};
												} count _nearRoads;
												if (!(_roadsValid isEqualTo [])) then {
													_foundSpawnPos = TRUE;
													_spawnPos = selectRandom _roadsValid;
												};
											};
										};
									};
								};
							};
						};
						if (_foundSpawnPos) exitWith {};
					};
					_armorType = selectRandom _armorTypes;
					_av = createVehicle [_armorType,_spawnPos,[],0,'NONE'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					0 = _armorArray pushBack _av;
					0 = _allArray pushBack _av;
					clearMagazineCargoGlobal _av;
					clearWeaponCargoGlobal _av;
					clearItemCargoGlobal _av;
					clearBackpackCargoGlobal _av;
					[_av] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
					_av allowDamage FALSE;
					_av allowCrewInImmobile TRUE;
					_av lock 2;
					_direction = _spawnPos getDir _centerPos;
					_av setDir _direction;
					createVehicleCrew _av;
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _av))),
						FALSE
					];
					_grp = group ((crew _av) select 0);
					_destination = [_centerPos,(200 + (random 200)),(50 + (random 50)),10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
					_grp move _destination;
					{
						_x doMove _destination;
					} forEach (units _grp);
					_av enableRopeAttach FALSE;
					_av enableVehicleCargo FALSE;
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_grp setCombatMode 'RED';
					{
						_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
						0 = _allArray pushBack _x;
					} count (units _grp);
					if (!isNull (gunner _av)) then {
						(gunner _av) doWatch _centerPos;
					};
					_av allowDamage TRUE;
					_armorSpawnDelay = time + 5;
				};
			};
			_armorCheckDelay = time + 20;
		};
	};
	if (_timeNow > _groundTransportInitialSpawnDelay) then {
		if (_timeNow > _groundTransportCheckDelay) then {
			if (_timeNow > _groundTransportSpawnDelay) then {
				if (_groundTransportSpawned < _groundTransportMaxSpawned) then {
					if (({(alive _x)} count _groundTransportArray) < _groundTransportMaxSpawned) then {
						_foundSpawnPos = FALSE;
						for '_x' from 0 to 49 step 1 do {
							_spawnPos = [_centerPos,600,1000,10,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
							if (!(_spawnPos isEqualTo [])) then {
								if (({((_x distance _spawnPos) < 400)} count allPlayers) isEqualTo 0) then {
									if ((_spawnPos distance _centerPos) < 1201) then {
										if (_spawnPos call _fn_blacklist) then {
											if (!([_spawnPos,_centerPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
												_foundSpawnPos = TRUE;
											};
										};
									};
								};
							};
							if (_foundSpawnPos) exitWith {};
						};
						_groundTransportType = selectRandom _groundTransportTypes;
						_v = createVehicle [_groundTransportType,_spawnPos,[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						0 = _groundTransportArray pushBack _v;
						0 = _allArray pushBack _v;
						_v allowDamage FALSE;
						_v allowCrewInImmobile FALSE;
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
						createVehicleCrew _v;
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _v))),
							FALSE
						];
						_grp = group ((crew _v) select 0);
						[(units _grp),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
						_v allowDamage TRUE;
						_v addEventHandler [
							'HandleDamage',
							{
								params ['_vehicle','_selection','_damage','_source','_ammo','',''];
								if (({(alive _x)} count (crew _vehicle)) isEqualTo 0) then {_vehicle removeEventHandler ['HandleDamage',_thisEventHandler];};
								if (!(_selection isEqualTo '?')) then {
									_oldDamage = if (_selection isEqualTo '') then [{(damage _vehicle)},{(_vehicle getHit _selection)}];
									if (!isNull _source) then {
										_scale = 0.25;
										_oldDamage = if (_selectionName isEqualTo '') then [{(damage _unit)},{(_unit getHit _selectionName)}];
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
						_v addEventHandler ['Killed',{(_this select 0) removeAllEventHandlers 'HandleDamage';}];
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
							_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
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
							_unit = _grp2 createUnit [_unitType,[0,0,0],[],0,'NONE'];
							missionNamespace setVariable [
								'QS_analytics_entities_created',
								((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
								FALSE
							];
							sleep 0.1;
							_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
							_unit moveInAny _v;
						};
						{
							0 = _allArray pushBack _x;
							_x enableStamina FALSE;
							_x enableFatigue FALSE;
							_x disableAI 'AUTOCOMBAT';
							_x disableAI 'COVER';
						} count (units _grp2);
						_unloadPos = [_centerPos,30,75,10,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
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
									_t = time + 10;
									while {((speed (vehicle this)) > 1)} do {
										(group this) setBehaviour "CARELESS";
										if (time > _t) exitWith {};
									};
									_v = vehicle this;
									{
										if (!(_x isEqualTo this)) then {
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
						_grp2 setVariable ['QS_grp_movepos',_centerPos,FALSE];
						[(units _grp2),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
						_groundTransportSpawned = _groundTransportSpawned + 1;
						_groundTransportSpawnDelay = time + 5;
					};
				};
			};
			if ((count _groundTransportArray) > 0) then {
				{
					if (_x isKindOf 'LandVehicle') then {
						if ((_x distance2D _centerPos) < 75) then {
							if (isNil {_x getVariable 'QS_vehicle_canUnload'}) then {
								_x setVariable ['QS_vehicle_canUnload',TRUE,FALSE];
								_x setUnloadInCombat [TRUE,TRUE];
							};
						};
					};
				} count _groundTransportArray;
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
						if (!(_spawnPos isEqualTo [])) then {
							if (({((_x distance _spawnPos) < 100)} count allPlayers) isEqualTo 0) then {
								_foundSpawnPos = TRUE;
							};
						};
						if (_foundSpawnPos) exitWith {};
					};
					_spawnPos set [2,(800 + (random 400))];
					_vParaType = selectRandom _vParaTypes;
					_vParaV = createVehicle [_vParaType,[0,0,(100 + (random 1000))],[],0,'NONE'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					0 = _allArray pushBack _vParaV;
					_vParaV setVariable ['QS_uav_protected',TRUE,(!isServer)];
					createVehicleCrew _vParaV;
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _vParaV))),
						FALSE
					];
					_vParaV setPos _spawnPos;
					_vParaV enableRopeAttach FALSE;
					_vParaV enableVehicleCargo FALSE;
					clearMagazineCargoGlobal _vParaV;
					clearWeaponCargoGlobal _vParaV;
					clearItemCargoGlobal _vParaV;
					clearBackpackCargoGlobal _vParaV;
					if (!((crew _vParaV) isEqualTo [])) then {
						_grp = group ((crew _vParaV) select 0);
						{
							_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
							0 = _allArray pushBack _x;
						} count (units _grp);
					};
					_grp move (selectRandom _hqBuildingPositions);
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_grp3 = createGroup [_side,TRUE];
					for '_x' from 0 to ((_vParaV emptyPositions 'CARGO') - 1) step 1 do {
						_unitType = selectRandom _unitTypes;
						_unit = _grp3 createUnit [_unitType,[0,0,0],[],0,'NONE'];
						missionNamespace setVariable [
							'QS_analytics_entities_created',
							((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
							FALSE
						];
						_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
						_unit assignAsCargo _vParaV;
						_unit moveInCargo _vParaV;
						0 = _allArray pushBack _unit;
					};
					_grp3 move (selectRandom _hqBuildingPositions);
					[(units _grp3),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_openHeight = _vParaHeightMin + (random _vParaHeightRandom);
					[_vParaV,_openHeight] spawn (missionNamespace getVariable 'QS_fnc_paraDrop');
					_vParaV lock 3;
					sleep 1.5;
				};
			};
		};
	};
	if (_tickTimeNow > _updateMoveDelay) then {
		{
			_unit = _x;
			if (alive _unit) then {
				if ((vehicle _unit) isKindOf 'Man') then {
					_unitGroup = group _unit;
					_groupLeader = leader _unitGroup;
					if ((_groupLeader distance2D _centerPos) > 75) then {
						if ((random 1) > 0.5) then {
							_unitGroup move _centerPos;
						};
					} else {
						if ((random 1) > 0.5) then {
							_moveToPos = selectRandom _hqBuildingPositions;
							_unit forceSpeed -1;
							_unit doMove _moveToPos;
						};
					};
				};
			};
			uiSleep 0.05;
		} count _allArray;
		_updateMoveDelay = diag_tickTime + (random [10,15,20]);
	};
	if (_timeNow > _checkGroupDelay) then {
		{
			_grp = _x;
			if (({(alive _x)} count (units _grp)) isEqualTo 0) then {
				deleteGroup _grp;
			};
		} count allGroups;
		_checkGroupDelay = time + 20;
	};
	if (_QS_flyBy) then {
		if (_timeNow > _QS_flyByDelay) then {
			_QS_flyBy = FALSE;
			[_startPos1,_endPos1,_QS_flyByAltitude,_QS_flyBySpeed,_QS_flyByType,_side] call (missionNamespace getVariable 'BIS_fnc_ambientFlyby');
			[_startPos2,_endPos2,_QS_flyByAltitude,_QS_flyBySpeed,_QS_flyByType,_side] call (missionNamespace getVariable 'BIS_fnc_ambientFlyby');
		};
	};
	if (_QS_airSuperiority) then {
		if (_timeNow > _jetInitialDelay) then {
			_QS_airSuperiority = FALSE;
			for '_x' from 0 to (_jetsToSpawn - 1) step 1 do {
				_foundSpawnPos = FALSE;
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = _centerPos getPos [(4000 + (random 2000)),(random 360)];
					if (!(_spawnPos isEqualTo [])) then {
						if (({((_x distance _spawnPos) < 1000)} count allPlayers) isEqualTo 0) then {
							_foundSpawnPos = TRUE;
						};
					};
					if (_foundSpawnPos) exitWith {};
				};
				_jet = createVehicle [_jetType,_spawnPos,[],0,'FLY'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				0 = _jetArray pushBack _jet;
				_jet engineOn TRUE;
				_jet allowCrewInImmobile TRUE;
				_jet lock 2;
				_jet enableRopeAttach FALSE;
				[_jet,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
				clearMagazineCargoGlobal _jet;
				clearWeaponCargoGlobal _jet;
				clearItemCargoGlobal _jet;
				clearBackpackCargoGlobal _jet;
				createVehicleCrew _jet;
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _jet))),
					FALSE
				];
				_grp = group (driver _jet);
				[_grp,_centerPos,FALSE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
				_grp enableAttack TRUE;
				_grp lockWP TRUE;
				_grp addVehicle _jet;
				[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
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
				_foundSpawnPos = FALSE;
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = _centerPos getPos [(3000 + (random 2000)),(random 360)];
					if (!(_spawnPos isEqualTo [])) then {
						if (({((_x distance _spawnPos) < 1000)} count allPlayers) isEqualTo 0) then {
							_foundSpawnPos = TRUE;
						};
					};
					if (_foundSpawnPos) exitWith {};
				};
				_helicopterType = selectRandom _helicopterTypes;
				_helicopter = createVehicle [_helicopterType,_spawnPos,[],0,'FLY'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				[_helicopter,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
				0 = _allArray pushBack _helicopter;
				0 = _helicopterArray pushBack _helicopter;
				createVehicleCrew _helicopter;
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _helicopter))),
					FALSE
				];
				_direction = _spawnPos getDir _centerPos;
				_helicopter setDir _direction;
				_helicopter lock 2;
				_helicopter allowCrewInImmobile TRUE;
				clearMagazineCargoGlobal _helicopter;
				clearWeaponCargoGlobal _helicopter;
				clearItemCargoGlobal _helicopter;
				clearBackpackCargoGlobal _helicopter;
				if ((random 1) > 0) then {
					_helicopter setVariable ['QS_V_availableCargo',(round((_helicopter emptyPositions 'Cargo') * 2)),FALSE];
					_helicopter setVariable ['QS_V_dropInterval',(time + 10),FALSE];
				};
				_grp = group (driver _helicopter);
				[_grp,_centerPos,FALSE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
				_grp setBehaviour 'AWARE';
				_grp setCombatMode 'RED';
				_grp setSpeedMode 'FULL';
				_grp enableAttack TRUE;
				[(units _grp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_grp allowFleeing 0;
				{
					_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
					0 = _allArray pushBack _x;
				} count (units _grp);
			};
		};
	};
	
	if (_timeNow > _heliParaCheckDelay) then {
		if ((count _helicopterArray) > 0) then {
			{
				_heli = _x;
				if (!isNull _heli) then {
					if (alive _heli) then {
						if (canMove _heli) then {
							if (((getPosWorld _heli) select 2) > 40) then {
								if ((_heli distance2D _centerPos) < 400) then {
									if (!isNil {_heli getVariable 'QS_V_availableCargo'}) then {
										if ((_heli getVariable 'QS_V_availableCargo') > 0) then {
											if (time > (_heli getVariable 'QS_V_dropInterval')) then {
												if ((EAST countSide allUnits) < 150) then {
													if (isNull _heliParaGrp) then {
														_heliParaGrp = createGroup [_side,TRUE];
														[_heliParaGrp,(selectRandom _hqBuildingPositions),FALSE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
													};
													_paratrooperType = selectRandom _paratrooperTypes;
													_parajumper = _heliParaGrp createUnit [_paratrooperType,[0,0,0],[],0,'NONE'];
													missionNamespace setVariable [
														'QS_analytics_entities_created',
														((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
														FALSE
													];
													0 = _allArray pushBack _parajumper;
													_parajumper = _parajumper call (missionNamespace getVariable 'QS_fnc_unitSetup');
													if ((random 1) > 0.5) then {
														_LorR = 2;
													} else {
														_LorR = -2;
													};
													_parajumper setPos (_heli modelToWorld [_LorR,-5,-3]);
													_parajumper disableAI 'AUTOCOMBAT';
													_parajumper disableAI 'COVER';
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
													[(units _heliParaGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
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
				_paratrooper = _grp createUnit [_paratrooperType,[0,0,0],[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_paratrooper = _paratrooper call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _allArray pushBack _paratrooper;
				0 = _paratrooperArray pushBack _paratrooper;
				if (!((backpack _paratrooper) isEqualTo 'B_Parachute')) then {
					_paratrooper addBackpack 'B_Parachute';
				};
				_paratrooper disableAI 'AUTOCOMBAT';
				_paratrooper disableAI 'COVER';
				_paratrooper setPos _spawnPos;
			};
			_grp move (selectRandom _hqBuildingPositions);
			_grp enableAttack TRUE;
			_grp setSpeedMode 'FULL';
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		};
	};
	
	if (_paratroopers2) then {
		if (_timeNow > _paratrooper2InitialDelay) then {
			_paratroopers2 = FALSE;
			if ((EAST countSide allUnits) < 125) then {
				_grp = createGroup [_side,TRUE];
				for '_x' from 0 to (_paratroopersToSpawn - 1) step 1 do {
					_spawnPos = _centerPos getPos [(250 + (random 150)),(random 360)];
					_spawnPos set [2,(60 + (random 150))];
					_paratrooperType = selectRandom _paratrooperTypes;
					_paratrooper = _grp createUnit [_paratrooperType,[0,0,0],[],0,'NONE'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					_paratrooper = _paratrooper call (missionNamespace getVariable 'QS_fnc_unitSetup');
					_paratrooper disableAI 'AUTOCOMBAT';
					_paratrooper disableAI 'COVER';
					0 = _allArray pushBack _paratrooper;
					0 = _paratrooperArray pushBack _paratrooper;
					if (!((backpack _paratrooper) isEqualTo 'B_Parachute')) then {
						_paratrooper addBackpack 'B_Parachute';
					};
					_paratrooper setPos _spawnPos;
				};
				_grp move (selectRandom _hqBuildingPositions);
				_grp enableAttack TRUE;
				_grp setSpeedMode 'FULL';
				[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			};
		};
	};
	
	if (_timeNow > _vehicleReammoDelay) then {
		if (!(_allArray isEqualTo [])) then {
			{
				if (!isNull _x) then {
					_x setVehicleAmmo 1;
				};
				sleep 0.007;
			} count _allArray;
		};
		_vehicleReammoDelay = time + 60;
	};
	
	if (_timeNow > _updatePlayers) then {
		_playersInArea = allPlayers select {((_x distance _centerPos) < 1500)};
		if (!(_playersInArea isEqualTo [])) then {
			_playerVehicles = [];
			{
				if (!isNull (objectParent _x)) then {
					0 = _playerVehicles pushBack _x;
				};
			} count _playersInArea;
			if (!(_playerVehicles isEqualTo [])) then {
				{
					if (_x isKindOf 'Man') then {
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
				_text = 'The attack is almost over!';
			} else {
				_text = 'Hang on boys, the end is near!';
			};
			['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
	
	if (serverTime > _duration) then {
		_exitSuccess = TRUE;
	};
	
	
	
	
	
	
	
			if ((count _enemiesInRadius) > _enemyInRadiusThreshold) then {
				if (_sectorControl > 0) then {
					_sectorControl = (_sectorControl - ([_enemyCoefLow,_enemyCoefHigh] select ((count _friendsInRadius) > 0))) max 0;
					[_taskID,TRUE,_sectorControl] call _fn_taskSetProgress;
				};
			} else {
				if (_sectorControl < 1) then {
					_sectorControl = (_sectorControl + ([_enemyCoefLow,_enemyCoefHigh] select ((count _friendsInRadius) > 0))) min 1;
					[_taskID,TRUE,_sectorControl] call _fn_taskSetProgress;
				};
			};
	
	
	
	
	
	
	
	
	if (_timeNow > _checkHeldInitialDelay) then {
		if (_timeNow > _checkHeldDelay) then {
			_enemyInHQCount = [_centerPos,25,[EAST,RESISTANCE],allUnits,1] call (missionNamespace getVariable 'QS_fnc_serverDetector');
			_playersInHQCount = [_centerPos,75,[WEST],allPlayers,1] call (missionNamespace getVariable 'QS_fnc_serverDetector');
			if (_playersInHQCount isEqualTo 0) then {
				comment 'No players in HQ';
				if (_enemyInHQCount > 3) then {
					comment 'More than 3 enemies in HQ';
					_exitFail = TRUE;
				};
			} else {
				comment 'There are still players in HQ area';
				if (_enemyInHQCount >= 15) then {
					comment 'There are more than 10 enemies in HQ';
					if (_sectorControlTicker isEqualTo 1) then {
						['sideChat',[WEST,'HQ'],'CSAT is taking the HQ!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
					};
					if (_sectorControlTicker > _sectorControlThreshold) then {
						_exitFail = TRUE;
					};
					if (!(_exitFail)) then {
						_sectorControlTicker = _sectorControlTicker + 1;
						if ((round((_sectorControlTicker / _sectorControlThreshold) * 100)) >= 100) then {
							['systemChat','HQ is 100 percent taken!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
						};
					};
				} else {
					comment 'Less than 10 enemies in HQ';
					if (!(_sectorControlTicker isEqualTo 0)) then {
						if (_enemyInHQCount < 10) then {
							comment 'Below threshold of acceptable enemies in HQ';
							_sectorControlTicker = 0;
						};
					};
				};
			};
			[_taskID,TRUE,(0 max (1 - (_sectorControlTicker / _sectorControlThreshold)) min 1)] call (missionNamespace getVariable 'QS_fnc_taskSetProgress');
			_checkHeldDelay = time + 20;
		};
	};
	
	if (_exitSuccess) exitWith {
		['sideChat',[WEST,'HQ'],'Well done boys! Secure an LZ and get back to base for rearm!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['DEFEND_SUCCESS',['Defend HQ','HQ defense completed!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_DEFENDHQ','SUCCEEDED',FALSE] call (missionNamespace getVariable 'BIS_fnc_taskSetState');
		profileNamespace setVariable [
			'QS_defendHQ_statistics',
			[
				(((profileNamespace getVariable 'QS_defendHQ_statistics') select 0) + 1),
				((profileNamespace getVariable 'QS_defendHQ_statistics') select 1)
			]
		];
	};
	if (_exitFail) exitWith {
		['sideChat',[WEST,'HQ'],'Bad luck soldiers!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['DEFEND_FAIL',['Defend','HQ Defense Failed!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['QS_IA_TASK_DEFENDHQ','FAILED',FALSE] call (missionNamespace getVariable 'BIS_fnc_taskSetState');
		profileNamespace setVariable [
			'QS_defendHQ_statistics',
			[
				((profileNamespace getVariable 'QS_defendHQ_statistics') select 0),
				(((profileNamespace getVariable 'QS_defendHQ_statistics') select 1) + 1)
			]
	   ];
	};
	if (missionNamespace getVariable 'QS_defend_terminate') exitWith {
		['hint','Defense cancelled!'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	sleep 1.5;
};
_currentStats set [2,(count allPlayers)];
_currentStats set [3,([(missionNamespace getVariable 'QS_HQpos'),300,[WEST],allPlayers,1] call (missionNamespace getVariable 'QS_fnc_serverDetector'))];
_currentStats set [4,_exitSuccess];
_defendStats = [];
_defendStats = profileNamespace getVariable 'QS_defend_stat_2';
0 = _defendStats pushBack _currentStats;
profileNamespace setVariable ['QS_defend_stat_2',_defendStats];
saveProfileNamespace;
{
	_x setMarkerAlpha 0;
} forEach ['QS_marker_aoCircle','QS_marker_aoMarker'];
sleep 3;
[_taskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
sleep 7 + (random 7);
{
	missionNamespace setVariable [
		'QS_analytics_entities_deleted',
		((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
		FALSE
	];
	deleteVehicle _x;
	sleep 0.05;
} count _allArray;
{
	missionNamespace setVariable [
		'QS_analytics_entities_deleted',
		((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
		FALSE
	];
	if (!(_x getVariable ['QS_dead_prop',FALSE])) then {
		deleteVehicle _x;
		sleep 0.01;
	};
} count allDeadMen;
{
	if ((units _x) isEqualTo []) then {
		deleteGroup _x;
	};
	sleep 0.001;
} count allGroups;
if ((count allPlayers) > 20) then {
	if ((random 1) > 0.666) then {
		if (isClass (missionConfigFile >> 'CfgSounds' >> 'TheEnd')) then {
			['playSound','TheEnd'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
diag_log 'Defend AO 2';
missionNamespace setVariable ['QS_defendActive',FALSE,TRUE];