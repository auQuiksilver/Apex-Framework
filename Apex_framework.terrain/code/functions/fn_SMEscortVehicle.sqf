/*/
File: escortVehicle.sqf
Author:

	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	Get vehicle to its destination
___________________________________________________/*/

scriptName 'QS - SM - Convoy';
private [
	'_vehicle','_position','_destination','_enemyArray','_intensity',
	'_vehicleDir','_vehiclePos','_vehicleDirToDestination','_startPosition',
	'_distanceInFront_fixed','_distanceInFront_random','_vehicleIsOnRoad',
	'_vehiclePosInFront','_vehiclePosToDest','_vehicleSpeed','_roadsInFront',
	'_roadsToDestination','_vehicleDamage','_vehicleCanMove','_timeNow',
	'_updateState_delay','_updateState_checkDelay','_vehicleVectorUp',
	'_vehicleAlive','_sleepTime','_nearbyPlayers','_ambushInProgress',
	'_enemyGroupTypes','_enemyGroupType','_enemySpawnPos','_ambushRadius','_ambushTimeout',
	'_marker1','_marker2','_ambushPos','_ambushPos_candidate1','_ambushPos_candidate2','_ambushPos_candidate3',
	'_ambushPos_candidate4','_ambushPos_candidates','_randomRoadSegment','_marker3','_marker4',
	'_enabled_IED','_enabled_mech','_enabled_RPG','_vehicleTravelDirection','_vehicleRoadAt',
	'_timeOffRoad','_unit','_grp','_distanceToAmbush','_updateAttackPos_checkDelay',
	'_enemyGroupArray','_enemyGroupTypes_big','_hasHitLandmine','_landMine','_IED',
	'_QS_manage_convoy_vehicles','_QS_manage_convoy','_QS_manage_convoy_delay','_QS_manage_convoy_checkDelay',
	'_QS_manage_convoy_armorTypes','_nearbySpawnPos','_bto','_armoredVehicle','_vehicleDriver',
	'_vehicleDriverGroup','_safezone_radius','_QS_manage_convoy_radius','_enemyTurretType','_enemyTurret',
	'_vehicleTypes','_vehicleType','_startDir','_destinations','_armorTokenVehicle','_armoredVehicleVelocity',
	'_armoredVehicleDir','_groupSide','_fuctionNotification','_functionAttack','_spawnPos','_player',
	'_ambushCount','_posToMove','_dmgCount','_count','_nearestVillage','_nearestCity','_nearestCapital',
	'_updateMoveDelay','_centerPos','_moveToPos','_suppressTarget','_suppressTargets','_nearestLocation',
	'_suppressTarget_var','_suppressTarget_type','_base','_baseBufferDist','_spawnDoubleChance','_enemyGroupTypes_small',
	'_convoyVehicle','_QS_manage_convoy_var','_enemyFiredEvent','_vehSpawnPos','_veh','_QS_manage_convoy_vehicleClass',
	'_convoyVehicleType','_landMine2','_launch','_nearRoadsPositions','_grpLeader','_worldName','_technicalTypes','_enemyGroupTypes_reinf_small',
	'_enemyGroupTypes_reinf_big'
];
_ambushCount = 0;
_fuctionNotification = 'QS_fnc_showNotification';
_functionAttack = 'QS_fnc_taskAttack';
_base = markerPos 'QS_marker_base_marker';
_baseBufferDist = 1000;
_worldName = worldName;
if (!(_worldName in ['Altis','Malden','Tanoa','Enoch'])) exitWith {
	diag_log '***** ERROR * Truck side mission * terrain not supported (needs config) *****';
};
if (_worldName isEqualTo 'Tanoa') then {
	_startPosition = [6817.86,7544.75,0.00139809];
	_startDir = 314.032;
	_vehicleTypes = [
		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_T_Truck_01_fuel_F','B_T_Truck_01_box_F'
	];
	_destinations = [
		[5394.51,9905.93,0.00143862],
		[5810.09,10820.5,0.00141287],
		[5589.65,12505.5,0.00145578],
		[6590.76,13069.8,0.00156212],
		[8949.53,13678.4,0.00143909],
		[9968.9,13474.9,0.00143886],
		[11623.5,13040,0.00142431],
		[14264.1,11510.7,0.12163],
		[8491.82,12444.2,0.00141907],
		[8972.57,10336.3,0.00143814],
		[11050.8,11501.7,0.00143433],
		[10933.8,9856.77,0.0013504],
		[14364.5,8748.88,0.00151825],
		[12606.8,7592.73,0.00143242],
		[10826.3,6495.3,0.00143886],
		[11626.3,3002.23,0.00141525],
		[11695.7,2255.52,0.00143909]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Altis') then {
	_startPosition = [14450,16763.7,0];
	_startDir = 330;
	_vehicleTypes = [
		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_Truck_01_fuel_F','B_Truck_01_box_F'
	];
	_destinations = [
		[5769.33,20082.4,0],[5025.37,14424.8,0],[6196.62,15083.5,0],[8248.69,10901.6,0],[9207.46,12108.8,0],[6801.55,15560.4,0],
		[8479.83,18265,0],[9216.9,19281.8,0],[5768.62,20080.6,0],[16753,12510.6,0],[21233.4,7112.81,0],[19958.3,11448.7,0],[25697.2,21376.9,0],
		[20780.9,16673,0],[23366.9,24186.6,0],[26997.3,23260.3,0],[3765.76,13480.9,0],[4173.69,15045.1,0]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Malden') then {
	_startPosition = [8241.15,10087.8,0];
	_startDir = 170;
	_vehicleTypes = [
		'C_Truck_02_fuel_F','C_Truck_02_box_F','B_Truck_01_fuel_F','B_Truck_01_box_F'
	];
	_destinations = [
		[1069.92,678.717,0],
		[5504.75,3496.67,0],
		[8047.61,4029.26,0],
		[7044.13,7051.86,0],
		[8147.69,3138.5,0],
		[3226.93,6286.52,0],
		[3779.3,3257.21,0],
		[7689.35,3309.53,0]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_worldName isEqualTo 'Enoch') then {
	_startPosition = [4268.87,10463.4,0];
	_startDir = 134;
	_vehicleTypes = ['B_T_Truck_01_fuel_F','B_T_Truck_01_box_F'];
	_destinations = [
		[11151.5,11434.7,0.00144577],
		[11436.9,9484.55,0.0016613],
		[11226.9,4360.06,0.00143433],
		[5946.78,4097.98,0.00137329],
		[4949.62,2143.18,0.00149536],
		[1664.64,3653.66,0.00143433],
		[11429.7,503.399,0.0014534],
		[7363.54,2856.99,0.00144196],
		[4906.16,5423.01,0.00140381],
		[9065.14,6668.31,0.00143433],
		[565.645,947.551,0.00146484],
		[565.645,947.551,0.00146484]
	] call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
_vehicleType = selectRandom _vehicleTypes;
_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],_startPosition,[],0,'NONE'];
_enabled_IED = FALSE;
_enabled_mech = FALSE;
_enabled_RPG = FALSE;
_timeNow = time;
_sleepTime = 3;
missionNamespace setVariable ['QS_sideMission_vehicle',_vehicle,TRUE];
_destination = selectRandom _destinations;
_nearestVillage = text (nearestLocation [_destination,'NameVillage']);
_nearestCity = text (nearestLocation [_destination,'NameCity']);
_nearestCapital = text (nearestLocation [_destination,'NameCityCapital']);
_nearestLocation = selectRandom [_nearestVillage,_nearestCity];
_enemyArray = [];
_enemyGroupArray = [];
_unit = objNull;
_grp = grpNull;
_player = objNull;
_intensity = 0;
_nearbyPlayers = 0;
_grpLeader = objNull;
_vehiclePos = _startPosition;
_vehicleDir = getDir _vehicle;
_vehicleTravelDirection = _vehicle getDir _destination;
_vehicleDirToDestination = _vehicle getDir _destination;
if (worldName isEqualTo 'Tanoa') then {
	_distanceInFront_fixed = 300;
	_distanceInFront_random = 500;
} else {
	_distanceInFront_fixed = 600;
	_distanceInFront_random = 1000;	
};
_distanceToAmbush = 0;
_vehiclePosInFront = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleTravelDirection];
_vehiclePosToDest = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleDirToDestination];
_vehicleRoadAt = roadAt _vehicle;
_vehicleIsOnRoad = isOnRoad _vehicle;
_vehicleSpeed = (vectorMagnitude (velocity _vehicle)) * 3.6;
_vehicleDamage = damage _vehicle;
_vehicleCanMove = canMove _vehicle;
_vehicleAlive = alive _vehicle;
_vehicleDriver = driver _vehicle;
_vehicleDriverGroup = grpNull;
_vehicle forceFlagTexture '\A3\Data_F\Flags\Flag_red_CO.paa';
_roadsInFront = ((_vehiclePosInFront select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
_roadsToDestination = ((_vehiclePosToDest select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
_timeOffRoad = 0;
_dmgCount = 0;
_count = 0;
private _roadblockEntities = [];
private _roadblockPosition = [0,0,0];
private _roadblockData = [];
_vehicle setUnloadInCombat [FALSE,FALSE];
_vehicle allowCrewInImmobile [TRUE,TRUE];
_vehicle enableRopeAttach FALSE;
_vehicle enableVehicleCargo FALSE;
_vehicle setConvoySeparation 50;
_vehicle setRepairCargo 0;
_vehicle setFuelCargo 0;
_vehicle setAmmoCargo 0;
_vehicle forceFollowRoad TRUE;
_technicalTypes = [
	'O_G_Offroad_01_armed_F',3,
	'O_G_Offroad_01_AT_F',1,
	'I_C_Offroad_02_LMG_F',3,
	'I_C_Offroad_02_AT_F',1
];
_vehicle addEventHandler [
	'GetIn',
	{
		params ['_vehicle','_position','_unit','_turret'];
		if (_position == 'driver') then {
			if (isPlayer _unit) then {
				['vehicleChat',_vehicle,'Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
			};
		};
	}
];
_vehicle addEventHandler [
	'GetOut',
	{
		params ['_vehicle','_position','_unit','_turret'];
	}
];
_vehicle addEventHandler [
	'SeatSwitched',
	{
		params ['_vehicle','_unit1','_unit2'];
		if ('Driver' in (assignedVehicleRole _unit1)) then {
			if (isPlayer _unit1) then {
				['vehicleChat',_vehicle,'Mission: Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit1,FALSE];
			};
		};
		if ('Driver' in (assignedVehicleRole _unit2)) then {
			if (isPlayer _unit2) then {
				['vehicleChat',_vehicle,'Mission: Get this vehicle to its destination, soldier!'] remoteExec ['QS_fnc_remoteExecCmd',_unit2,FALSE];
			};
		};
	}
];
_randomRoadSegment = objNull;
_hasHitLandmine = FALSE;
_landMine = objNull;
_landMine2 = objNull;
_IED = objNull;
_ambushInProgress = FALSE;
_ambushPos_candidates = [];
_ambushPos_candidate1 = [0,0,0];
_ambushPos_candidate2 = [0,0,0];
_ambushPos_candidate3 = [0,0,0];
_ambushPos_candidate4 = [0,0,0];
_ambushPos = [0,0,0];
_ambushRadius = [500,700] select (worldName isEqualTo 'Altis');
_ambushTimeout = _timeNow + 600;
_updateAttackPos_checkDelay = _timeNow + 20;
_spawnDoubleChance = 0;
if (worldName isEqualTo 'Tanoa') then {
	_groupSide = RESISTANCE;
	_enemyGroupTypes = ['IG_InfSentry','IG_ReconSentry','IG_ReconSentry','IG_InfSentry','IG_InfTeam','IG_InfTeam'];
	_enemyGroupTypes_big = ['IG_InfTeam','IG_InfSquad'];
	_enemyGroupTypes_small = ['IG_InfSentry','IG_ReconSentry'];
	_enemyGroupTypes_reinf_small = ['OG_InfAssaultTeam'];
	_enemyGroupTypes_reinf_big = ['OG_InfAssaultTeam'];
} else {
	_groupSide = EAST;
	_enemyGroupTypes = ['OG_InfSentry','OG_InfSentry','OG_ReconSentry','OG_InfSentry','OG_InfTeam','OG_InfTeam'];
	_enemyGroupTypes_big = ['OG_InfAssault','OG_InfTeam'];
	_enemyGroupTypes_small = ['OG_InfSentry','OG_ReconSentry'];
	_enemyGroupTypes_reinf_small = ['OG_InfAssaultTeam'];
	_enemyGroupTypes_reinf_big = ['OG_InfAssaultTeam'];
};
_enemyGroupType = '';
_enemySpawnPos = [0,0,0];
_enemyTurretType = '';
_enemyTurret = objNull;
_enemyFiredEvent = {
	_unit = _this # 0;
	_unit removeEventHandler [_thisEvent,_thisEventHandler];
	private _target = getAttackTarget _unit;
	if (!alive _target) then {
		_target = [_unit,500] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
	};
	if (alive _target) then {
		[_unit,_target,1,TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
	};
};
_veh = objNull;
_vehSpawnPos = [0,0,0];
_nearRoadsPositions = [];
_updateState_delay = 2.5;
_updateState_checkDelay = _timeNow + _updateState_delay;
_QS_manage_convoy = TRUE;
_QS_manage_convoy_delay = 10;
_QS_manage_convoy_checkDelay = _timeNow + _QS_manage_convoy_delay;
_QS_manage_convoy_radius = 500;
_QS_manage_convoy_vehicles = [];
_QS_manage_convoy_armor = [];
_QS_manage_convoy_armorTypes = ['armored_vehicles_1'] call QS_data_listVehicles;
_QS_manage_convoy_vehicleClass = 'armored';
_QS_manage_convoy_var = 'QS_truckmission_armortoken';
_armoredVehicle = objNull;
_convoyVehicle = objNull;
_convoyVehicleType = '';
_launch = FALSE;
_IEDtype = 'ATMine';
_armorTokenVehicle = [];
_bto = [
	'BUILDING','HOUSE','CHURCH','CHAPEL', 
	'CROSS','ROCK','BUNKER','FORTRESS','FOUNTAIN','VIEW-TOWER', 
	'LIGHTHOUSE','QUAY','FUELSTATION','HOSPITAL','FENCE','WALL', 
	'BUSSTOP','ROAD','TRANSMITTER','STACK','RUIN', 
	'TOURISM','WATERTOWER','ROCKS','POWER LINES','RAILWAY', 
	'POWERSOLAR','POWERWAVE','POWERWIND','SHIPWRECK'
];
//comment '[_position,_bto] call _nearbySpawnPos';
_spawnPos = [0,0,0];
_nearbySpawnPos = {
	_position = _this # 0;
	_bto = _this # 1;
	private _position2 = [0,0,0];
	for '_x' from 0 to 49 step 1 do {
		_position2 = _position getPos [(10 + (random 15)),(random 360)];
		if (((((_position select [0,2]) nearRoads 15) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) && ((nearestTerrainObjects [_position2,_bto,2,FALSE,TRUE]) isEqualTo [])) exitWith {};
	};
	if (_position2 isNotEqualTo [0,0,0]) exitWith {_position2;};
	_position;
};
_QS_manage_group = TRUE;
_QS_manage_group_delay = 10;
_QS_manage_group_checkDelay = _timeNow + _QS_manage_group_delay;
_grp = grpNull;
_markerName = 'QS_marker_escort_1';
_marker0 = createMarker [_markerName,[0,0,0]];
_marker0 setMarkerShapeLocal 'Icon';
_marker0 setMarkerTypeLocal 'mil_dot';
_marker0 setMarkerColorLocal 'ColorGreen';
_marker0 setMarkerAlphaLocal 1;
_marker0 setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_028']);
_marker0 setMarkerPos _destination;
_distanceInFront_fixed = 250;
_distanceInFront_random = 500;
_ambushRadius = 751;
_safezone_radius = 400 + (random 400);
_updateMoveDelay = time + 10;
_moveToPos = [0,0,0];
_module_suppressTargets = FALSE;
_suppressTarget = objNull;
_suppressTargets = [];
_suppressTarget_checkDelay = time + 30;
_suppressTarget_var = 'QS_vehicle_suppressTarget';
_suppressTarget_type = 'SuppressTarget';
_suppressTarget = createVehicle [_suppressTarget_type,[0,0,0],[],0,'NONE'];
[1,_suppressTarget,[_vehicle,[0,(random 2),(random 1)]]] call QS_fnc_eventAttach;
_vehicle setVariable [_suppressTarget_var,_suppressTarget,FALSE];
_suppressTargets pushBack _suppressTarget;
private _technicalType = '';
//comment 'Communicate to players';
[
	'QS_IA_TASK_SM_ESCORT',
	TRUE,
	[
		(format [
			'%2 %1 (%3). %4',
			_nearestVillage,
			localize 'STR_QS_Task_071',
			localize 'STR_QS_Task_072',
			localize 'STR_QS_Task_073'
		]),
		localize 'STR_QS_Task_070',
		localize 'STR_QS_Task_070'
	],
	[_vehicle,TRUE],
	'CREATED',
	5,
	FALSE,
	TRUE,
	'Truck',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_078']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
'QS_marker_sideMarker' setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_029']);
waitUntil {
	sleep 3;
	(!alive _vehicle) ||
	(((getPosATL _vehicle) distance2D _startPosition) > _safezone_radius)
};
if (!alive _vehicle) exitWith {
	//comment 'Mission fail';
	deleteMarker _marker0;
	['QS_IA_TASK_SM_ESCORT'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
	['TaskFailed',['',localize 'STR_QS_Notif_079']] remoteExec [_fuctionNotification,-2,FALSE];
	sleep 5;
	[0,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
};
for '_x' from 0 to 1 step 0 do {
	_timeNow = time;
	if (_timeNow > _updateState_checkDelay) then {
		//comment 'UPDATE SOME USEFUL VEHICLE DATA';
		_vehicleAlive = alive _vehicle;
		_vehicleCanMove = canMove _vehicle;
		_vehicleTravelDirection = _vehiclePos getDir (getPosATL _vehicle);
		_hasHitLandmine = FALSE;
		if (_vehicleAlive) then {
			if (_vehicleCanMove) then {
				if (!(_vehicleIsOnRoad)) then {
					if ( (((_vehiclePos select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) then {
						if ((_vehiclePos distance2D (getPosATL _vehicle)) > 5) then {
							if ((_vehiclePos distance2D _startPosition) > _safezone_radius) then {
								_timeOffRoad = _timeOffRoad + 1;
								if (_timeOffRoad > 7) then {
									['sideChat',[WEST,'BLU'],localize 'STR_QS_Chat_059'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
									_hasHitLandmine = TRUE;
								};
							};
						};
					};
				};
			};
		};
		_vehiclePos = getPosATL _vehicle;
		_vehicleDir = getDir _vehicle;
		_vehicleVectorUp = vectorUp _vehicle;
		_vehicleIsOnRoad = isOnRoad _vehicle;
		_vehicleRoadAt = roadAt _vehicle;
		_vehicleSpeed = (vectorMagnitude (velocity _vehicle)) * 3.6;
		_vehicleDamage = damage _vehicle;
		_vehicleDriver = driver _vehicle;
		if (!isNull _vehicleDriver) then {
			if (alive _vehicleDriver) then {
				if (isPlayer _vehicleDriver) then {
					_vehicleDriverGroup = group _vehicleDriver;
				} else {
					_vehicleDriverGroup = grpNull;
				};
			} else {
				_vehicleDriverGroup = grpNull;
			};
		} else {
			_vehicleDriverGroup = grpNull;
		};
		_vehicleDirToDestination = _vehicle getDir _destination;
		_updateState_checkDelay = _timeNow + _updateState_delay;
	};
	if (!(_ambushInProgress)) then {
		//comment 'AMBUSH NOT IN PROGRESS, PREPARE IT';
		_ambushPos_candidates = [];
		//comment 'Clean up old ambush';
		if (_enemyArray isNotEqualTo []) then {
			{
				if (!isNull _x) then {
					if (_x isKindOf 'CAManBase') then {
						if (((units WEST) inAreaArray [_x,300,300,0,FALSE]) isEqualTo []) then {
							deleteVehicle _x;
						} else {
							_x setDamage 1;
						};
					} else {
						if (((units WEST) inAreaArray [_x,300,300,0,FALSE]) isEqualTo []) then {
							deleteVehicle _x;
						} else {
							_x setDamage 1;
						};
					};
				};
			} count _enemyArray;
		};
		if (_enemyGroupArray isNotEqualTo []) then {
			{
				if (!isNull _x) then {
					deleteGroup _x;
				};
			} count _enemyGroupArray;
		};
		_enemyArray = [];
		_enemyGroupArray = [];
		//comment 'Get relevant positions';
		_vehiclePosInFront = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleTravelDirection];
		_vehiclePosToDest = _vehicle getPos [(_distanceInFront_fixed + (random _distanceInFront_random)),_vehicleDirToDestination];
		if (!surfaceIsWater _vehiclePosInFront) then {
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack _vehiclePosInFront;
			};
		};
		if (!surfaceIsWater _vehiclePosToDest) then {
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack _vehiclePosToDest;
			};
		};
		_roadsInFront = ((_vehiclePosInFront select [0,2]) nearRoads 200) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
		if (_roadsInFront isNotEqualTo []) then {
			for '_x' from 0 to 9 step 1 do {
				_randomRoadSegment = selectRandom _roadsInFront;
				if (isOnRoad _randomRoadSegment) exitWith {};
			};
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack (getPosATL _randomRoadSegment);
			};
		};
		_roadsToDestination = ((_vehiclePosToDest select [0,2]) nearRoads 200) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
		if (_roadsToDestination isNotEqualTo []) then {
			for '_x' from 0 to 9 step 1 do {
				_randomRoadSegment = selectRandom _roadsToDestination;
				if (isOnRoad _randomRoadSegment) exitWith {};
			};
			if ((_vehiclePosInFront distance2D _base) > _baseBufferDist) then {
				_ambushPos_candidates pushBack (getPosATL _randomRoadSegment);
			};
		};
		if (_ambushPos_candidates isEqualTo []) exitWith {};
		_ambushInProgress = TRUE;
		_ambushPos = selectRandom _ambushPos_candidates;
		_distanceToAmbush = _vehiclePos distance2D _ambushPos;
		_nearbyPlayers = count ((units WEST) inAreaArray [_vehiclePos,500,500,0,FALSE,-1]);
		_intensity = 1;
		if (_nearbyPlayers > 0) then {
			_intensity = 1;
			if (_nearbyPlayers > 5) then {
				_intensity = 2;
				if (_nearbyPlayers > 10) then {
					_intensity = 3;
					if (_nearbyPlayers > 15) then {
						_intensity = 4;
						if (_nearbyPlayers > 20) then {
							_intensity = 5;
						};
					};
				};
			};
		};
		if (_enabled_IED) then {
		
		};
		if (_enabled_mech) then {
		
		};
		if (_enabled_RPG) then {
		
		};
		//comment 'Spawn force protection';
		_ambushCount = _ambushCount + 1;
		_spawnDoubleChance = 0;
		{
			_enemyGroupType = selectRandom _enemyGroupTypes;
			_spawnPos = [(_ambushPos_candidates # _forEachIndex),_bto] call _nearbySpawnPos;
			_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_enemyGroupArray pushBack _grp;
			_grp setSpeedMode 'FULL';
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			{
				0 = _enemyArray pushBack _x;
				if ((random 1) > 0.5) then {
					_x addEventHandler ['Fired',_enemyFiredEvent];
				};
				if ((random 1) > 0.5) then {
					_x enableAIFeature ['AUTOCOMBAT',FALSE];
				};
				_x enableAIFeature ['COVER',FALSE];
				if ((random 1) > 0.9) then {
					_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
					[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
				};
				_x enableStamina FALSE;
				_x enableFatigue FALSE;
				_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			} forEach (units _grp);
			if ((random 1) > 0.666) then {
				if (_spawnDoubleChance isEqualTo 0) then {
					_spawnDoubleChance = 1;
					_enemyGroupType = selectRandom _enemyGroupTypes_small;
					_spawnPos = [(_ambushPos_candidates # _forEachIndex),_bto] call _nearbySpawnPos;
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x enableAIFeature ['AUTOCOMBAT',FALSE];
						};
						_x enableAIFeature ['COVER',FALSE];
						if ((random 1) > 0.9) then {
							_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
							[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
						};
						_x enableStamina FALSE;
						_x enableFatigue FALSE;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
			if (_intensity > 1) then {
				if ((_ambushPos_candidates # _forEachIndex) isEqualTo _ambushPos) then {
					if (_intensity > 2) then {
						_enemyGroupType = selectRandom _enemyGroupTypes_big;
					} else {
						_enemyGroupType = selectRandom _enemyGroupTypes;
					};
					_spawnPos = [_ambushPos,_bto] call _nearbySpawnPos;
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x enableAIFeature ['AUTOCOMBAT',FALSE];
						};
						if ((random 1) > 0.9) then {
							_x addBackpack (['b_carryall_ocamo','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
							[_x,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
						};
						_x enableAIFeature ['COVER',FALSE];
						_x enableStamina FALSE;
						_x enableFatigue FALSE;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
		} forEach _ambushPos_candidates;
		if (_ambushCount >= 2) then {
			_ambushCount = 0;
			_vehSpawnPos = [(getPosATL _vehicle),300,800,2.5,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if ((_vehSpawnPos distance2D _base) > 1500) then {
				_nearRoadsPositions = (((_vehSpawnPos select [0,2]) nearRoads 300) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply {(getPosATL _x)};
				if (_nearRoadsPositions isNotEqualTo []) then {
					_nearRoadsPositions = _nearRoadsPositions inAreaArray [_vehiclePos,300,300,0,FALSE];
					if (_nearRoadsPositions isNotEqualTo []) then {
						_vehSpawnPos = selectRandom _nearRoadsPositions;
					};
				};
				_technicalType = selectRandomWeighted _technicalTypes;
				_veh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _technicalType,_technicalType],_vehSpawnPos,[],0,'NONE'];
				_veh lock 3;
				_veh setUnloadInCombat [FALSE,FALSE];
				_veh allowCrewInImmobile [TRUE,TRUE];
				_veh enableRopeAttach FALSE;
				_veh enableVehicleCargo FALSE;
				_veh setConvoySeparation 50;
				_veh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
				_grp = createVehicleCrew _veh;
				[(units _grp),(selectRandom [1,2])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_enemyGroupArray pushBack _grp;
				_enemyArray pushBack _veh;
				{
					_x enableStamina FALSE;
					_x enableFatigue FALSE;
					_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
					0 = _enemyArray pushBack _x;
				} forEach (units _grp);
			};
		};
		//comment 'Configure force protection';
	} else {
		//comment 'AMBUSH IN PROGRESS, CHECK STATE';
		if (_enemyArray isNotEqualTo []) then {
			if (({(alive _x)} count _enemyArray) < 6) then {
				for '_x' from 0 to 49 step 1 do {
					_spawnPos = [_vehiclePos,200,400,3,0,0.7,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
					if (([_spawnPos,150,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) exitWith {};
				};
				if ((_spawnPos distance2D _vehiclePos) < 1000) then {
					if (_intensity > 2) then {
						_enemyGroupType = selectRandom _enemyGroupTypes_reinf_big;
					} else {
						_enemyGroupType = selectRandom _enemyGroupTypes_reinf_big;
					};
					_grp = [_spawnPos,(_spawnPos getDir _vehiclePos),_groupSide,_enemyGroupType,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
					[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_enemyGroupArray pushBack _grp;
					_grp setSpeedMode 'FULL';
					{
						0 = _enemyArray pushBack _x;
						if ((random 1) > 0.5) then {
							_x addEventHandler ['Fired',_enemyFiredEvent];
						};
						if ((random 1) > 0.5) then {
							_x enableAIFeature ['AUTOCOMBAT',FALSE];
						};
						_x enableAIFeature ['COVER',FALSE];
						_x setAnimSpeedCoef 1.1;
						_x setUnitPosWeak (selectRandom ['UP','MIDDLE']);
						_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
					} forEach (units _grp);
				};
			};
		};
		if (_timeNow > _updateAttackPos_checkDelay) then {
			if (_enemyGroupArray isNotEqualTo []) then {
				{
					_grp = _x;
					if (!isNull _grp) then {
						if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
							_grpLeader = leader _grp;
							if ((_grpLeader distance2D _vehiclePos) > 100) then {
								//comment 'move ahead of vic';
								_posToMove = _vehiclePos getPos [(random 50),_vehicleTravelDirection];
							} else {
								//comment 'move right to vic';
								_posToMove = _vehiclePos;
							};
							//_grp move _posToMove;
							doStop (units _grp);
							(units _grp) doMove _posToMove;
						};
					};
				} count _enemyGroupArray;
			};
			_updateAttackPos_checkDelay = _timeNow + 10;
		};
		if ((_vehicle distance2D _ambushPos) > (_distanceToAmbush * 1.2)) then {
			_ambushInProgress = FALSE;
		};
		if (_hasHitLandmine) then {
			_hasHitLandmine = FALSE;
			if ((random 1) > 0.5) then {
				_landMine = createMine ['ATMine',(getPosATL _vehicle),[],0];
				_landMine setDamage [1,TRUE];
				// good place to use the new addForce/addTorque functions
				[35,_vehicle,[((velocity _vehicle) # 0) + (sin (getDir _vehicle) * 4), ((velocity _vehicle) # 1) + (cos (getDir _vehicle) * 4), ((velocity _vehicle) # 2) + 5 + random 10]] remoteExec ['QS_fnc_remoteExec',_vehicle,FALSE];
			} else {
				_landMine = createMine ['APERSMine',(getPosATL _vehicle),[],0];
				_landMine setDamage 1;
				// good place to use the new addForce/addTorque functions
				[35,_vehicle,[((velocity _vehicle) # 0) + (sin (getDir _vehicle) * 4), ((velocity _vehicle) # 1) + (cos (getDir _vehicle) * 4), ((velocity _vehicle) # 2) + 3 + random 6]] remoteExec ['QS_fnc_remoteExec',_vehicle,FALSE];
				_dmgCount = ceil (random 3);
				_count = 0;
				//comment 'Set some wheels as fully damaged';
				{
					if (['wheel',_x,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
						if ((random 1) > 0.5) then {
							_vehicle setHit [_x,1];
							_count = _count + 1;
						};
					};
					if (_count >= _dmgCount) exitWith {};
				} count ((getAllHitPointsDamage _vehicle) # 1);
			};
			_timeOffRoad = 0;
		};
		if (_enemyArray isNotEqualTo []) then {
			{
				_unit = _x;
				if (!isNull _unit) then {
					if (alive _unit) then {
						if (_unit isKindOf 'CAManBase') then {
							if (alive _unit) then {
								if ((_unit knowsAbout _vehicle) < 3) then {
									_unit reveal [_vehicle,3.1];
								};
							};
						};
					};
				};
			} count _enemyArray;
			
			if (time > _updateMoveDelay) then {
				{
					_unit = _x;
					if (alive _unit) then {
						if (_unit isEqualTo (leader (group _unit))) then {
							if ((_unit distance2D _vehiclePos) > 100) then {
								//comment 'move ahead of vic';
								_posToMove = _vehiclePos getPos [(random 50),_vehicleTravelDirection];
							} else {
								//comment 'move right to vic';
								_posToMove = _vehiclePos;
							};
							//_grp move _posToMove;
							doStop (units _grp);
							(units _grp) doMove _posToMove;
						};
					};
				} count _enemyArray;
				_updateMoveDelay = time + 10;
			};
		};
		if ((_vehiclePos distance2D _startPosition) > 600) then {
			if (((units WEST) inAreaArray [_vehicle,500,500,0,FALSE,-1]) isEqualTo []) then {
				_vehicle setDamage [1,TRUE];
			};
		};
	};
	//comment 'Discourage use of heavy armor';
	if (_QS_manage_convoy) then {
		if (_timeNow > _QS_manage_convoy_checkDelay) then {
			_QS_manage_convoy_vehicles = _vehiclePos nearEntities ['LandVehicle',_QS_manage_convoy_radius];
			if (_QS_manage_convoy_vehicles isNotEqualTo []) then {
				_QS_manage_convoy_armor = [];
				{
					_convoyVehicle = _x;
					_convoyVehicleType = toLowerANSI (typeOf _convoyVehicle);
					if (
						(_convoyVehicleType in _QS_manage_convoy_armorTypes) || 
						{(_convoyVehicle isKindOf 'Tank')} || 
						{(_convoyVehicle isKindOf 'Wheeled_APC_F')} || 
						{(_QS_manage_convoy_vehicleClass isEqualTo (toLowerANSI (getText ((configOf _convoyVehicle) >> 'vehicleClass'))))}
					)  then {
						if (alive _convoyVehicle) then {
							if (canMove _convoyVehicle) then {
								0 = _QS_manage_convoy_armor pushBack _convoyVehicle;
							};
						};
					};
					if (_convoyVehicle isNil _suppressTarget_var) then {
						if (alive _convoyVehicle) then {
							_suppressTarget = createVehicle [_suppressTarget_type,[0,0,0],[],0,'NONE'];
							[1,_suppressTarget,[_convoyVehicle,[0,(random 2),(random 1)]]] call QS_fnc_eventAttach;
							_convoyVehicle setVariable [_suppressTarget_var,_suppressTarget,FALSE];
							0 = _suppressTargets pushBack _suppressTarget;
						};	
					};
				} count _QS_manage_convoy_vehicles;
				if (_QS_manage_convoy_armor isNotEqualTo []) then {
					{
						_launch = TRUE;
						_armoredVehicle = _x;
						if (_armoredVehicle isNil _QS_manage_convoy_var) then {
							0 = _armorTokenVehicle pushBackUnique _armoredVehicle;
							_armoredVehicle setVariable [_QS_manage_convoy_var,[0,(getPosATL _armoredVehicle),(500 + (random 500))],FALSE];
						} else {
							if (((_armoredVehicle getVariable _QS_manage_convoy_var) # 0) >= 3) then {
								_armoredVehicleVelocity = velocity _armoredVehicle;
								_armoredVehicleDir = getDir _armoredVehicle;
								if ((toLowerANSI (typeOf _armoredVehicle)) in ['b_apc_tracked_01_crv_f','b_t_apc_tracked_01_crv_f']) then {
									if ((_armoredVehicle animationSourcePhase 'MovePlow') isEqualTo 1) then {
										_launch = FALSE;
										_landMine = createMine [_IEDtype,(_armoredVehicle getRelPos [15,0]),[],0];
										_landMine2 = createMine [_IEDtype,(_armoredVehicle getRelPos [15,0]),[],3];
									} else {
										_landMine = createMine [_IEDtype,(getPosATL _armoredVehicle),[],0];
										_landMine2 = createMine [_IEDtype,(getPosATL _armoredVehicle),[],3];
									};
								} else {
									_landMine = createMine [_IEDtype,(getPosATL _armoredVehicle),[],0];
									_landMine2 = createMine [_IEDtype,(getPosATL _armoredVehicle),[],3];
								};
								_landMine setDamage [1,TRUE];
								_landMine2 setDamage [1,TRUE];
								if (_launch) then {
									// good place to use the new addForce/addTorque functions
									[35,_armoredVehicle,[(_armoredVehicleVelocity # 0) + (sin _armoredVehicleDir * 4), (_armoredVehicleVelocity # 1) + (cos _armoredVehicleDir * 4), (_armoredVehicleVelocity # 2) + 4 + random 8]] remoteExec ['QS_fnc_remoteExec',_armoredVehicle,FALSE];
								};
								_armoredVehicle setVariable [_QS_manage_convoy_var,[0,(getPosATL _armoredVehicle),(350 + (random 250))],FALSE];
							} else {
								if ((((_armoredVehicle getVariable _QS_manage_convoy_var) # 1) distance2D (getPosATL _armoredVehicle)) > ((_armoredVehicle getVariable _QS_manage_convoy_var) # 2)) then {
									_armoredVehicle setVariable [
										_QS_manage_convoy_var,
										[
											(((_armoredVehicle getVariable _QS_manage_convoy_var) # 0) + 1),
											(getPosATL _armoredVehicle),
											(500 + (random 500))
										],
										FALSE
									];
								};
							};
						};
					} count _QS_manage_convoy_armor;
				};
			};
			_QS_manage_convoy_checkDelay = time + _QS_manage_convoy_delay;
		};
	};
	//comment 'Keep all players near vehicle in the same group';
	if (_QS_manage_group) then {
		if (_timeNow > _QS_manage_group_checkDelay) then {
			if ((_vehicle distance2D _base) > 1000) then {
				if (!isNull _vehicleDriverGroup) then {
					{
						_player = _x;
						if (alive _player) then {
							if (!(_player getUnitTrait 'QS_trait_pilot')) then {
								if (!(captive _player)) then {
									if ((_player distance2D _vehicle) < 150) then {
										if (((units (group _player)) findIf {(!isPlayer _x)}) isEqualTo -1) then {
											if ((group _player) isNotEqualTo _vehicleDriverGroup) then {
												[_player] joinSilent _vehicleDriverGroup;
											};
										};
									};
								};
							};
						};
					} count (allPlayers unitsBelowHeight 25);
				};
			};
			_QS_manage_group_checkDelay = _timeNow + _QS_manage_group_delay;
		};
	};
	if (!alive _vehicle) exitWith {
		//comment 'Mission fail';
		['SM_TRUCK',[localize 'STR_QS_Notif_081',format ['%1<br/>%2',localize 'STR_QS_Notif_080',localize 'STR_QS_Notif_079']]] remoteExec [_fuctionNotification,-2,FALSE];
		sleep 5;
		[0,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	};
	if ((_vehicle distance2D _destination) < 50) exitWith {
		//comment 'Mission success';
		['SM_TRUCK',[localize 'STR_QS_Notif_081',format ['%1<br/>%2',localize 'STR_QS_Notif_082',localize 'STR_QS_Notif_083']]] remoteExec [_fuctionNotification,-2,FALSE];
		sleep 5;
		[1,_destination] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	};
	sleep _sleepTime;
};
//comment 'Cleanup';
['QS_IA_TASK_SM_ESCORT'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
if (_suppressTargets isNotEqualTo []) then {
	deleteVehicle _suppressTargets;
};
if (_enemyArray isNotEqualTo []) then {
	deleteVehicle _enemyArray;
};
if (_armorTokenVehicle isNotEqualTo []) then {
	{
		if (
			(alive _x) &&
			!(_x isNil _QS_manage_convoy_var)
		) then {
			_x setVariable [_QS_manage_convoy_var,nil];
		};
	} forEach _armorTokenVehicle;
};
deleteMarker _marker0;
deleteMarker 'QS_marker_escort_1';
if (alive _vehicle) then {
	0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_vehicle,'NOW_DISCREET',0];
};
missionNamespace setVariable ['QS_sideMission_vehicle',objNull,TRUE];
missionNamespace setVariable ['QS_sideMissionUp',FALSE,TRUE];