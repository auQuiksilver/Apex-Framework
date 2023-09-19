/*/
File: fn_scSpawnLandVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	31/10/2017 A3 1.76 by Quiksilver
	
Description:

	Spawn Land Vehicle Patrol
__________________________________________________/*/

private [
	'_pos','_base','_foundSpawnPos','_spawnPosDefault','_reinforceGroup','_infTypes','_infType','_destination','_count','_wp','_ticker','_playerSelected','_arr','_playerPos',
	'_vehTypes','_QS_array','_minDist','_maxDist','_nearRoads','_roadsValid','_roadRoadValid','_fn_blacklist','_centerPos','_centerRadius','_worldName','_worldSize','_isArmedAirEnabled',
	'_vehicle','_vehicleType','_grp'
];
_centerPos = missionNamespace getVariable 'QS_AOpos';
_centerRadius = missionNamespace getVariable 'QS_aoSize';
_isArmedAirEnabled = missionNamespace getVariable 'QS_armedAirEnabled';
_worldName = worldName;
_worldSize = worldSize;
_arrayVehicles = [];
_destination = [0,0,0];
_allPlayers = allPlayers;
_playerCount = count _allPlayers;
_playerThreshold = 30;
if (_worldName isEqualTo 'Tanoa') then {
	_minDist = 1200;
	_maxDist = 2400;
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
	_minDist = 1500;
	_maxDist = 3500;
	_fn_blacklist = {TRUE};
};

/*/================================================ FIND POSITION/*/
_roadsValid = [];
_validRoadSurfaces = ['#gdtreddirt','#gdtasphalt','#gdtsoil','#gdtconcrete'];
_base = markerPos 'QS_marker_base_marker';
for '_x' from 0 to 499 step 1 do {
	_roadRoadValid = [0,0,0];
	_spawnPosDefault = [_centerPos,_minDist,_maxDist,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if ((_allPlayers inAreaArray [_spawnPosDefault,500,500,0,FALSE]) isEqualTo []) then {
		if (_spawnPosDefault call _fn_blacklist) then {
			if (!([_spawnPosDefault,_centerPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
				if (_spawnPosDefault isNotEqualTo []) then {
					_nearRoads = ((_spawnPosDefault select [0,2]) nearRoads 250) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
					if (_nearRoads isNotEqualTo []) then {
						{
							if ((toLowerANSI (surfaceType (getPosATL _x))) in _validRoadSurfaces) then {
								0 = _roadsValid pushBack (getPosATL _x);
							};
						} count _nearRoads;
						if (_roadsValid isNotEqualTo []) then {
							_roadRoadValid = selectRandom _roadsValid;
						};
					};
				};
			};
		};
	};
	if (_roadRoadValid isNotEqualTo [0,0,0]) exitWith {};
};
if (_roadRoadValid isEqualTo [0,0,0]) then {
	_roadRoadValid = _spawnPosDefault;
};
_randomRoadPosition = _roadRoadValid;
_vehicleType = selectRandomWeighted ([1] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],(_randomRoadPosition vectorAdd [0,0,5]),[],0,'NONE'];
_arrayVehicles pushBack _vehicle;
_vehicle lock 3;
(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
_vehicle enableRopeAttach FALSE;
_vehicle enableVehicleCargo FALSE;
_vehicle forceFollowRoad TRUE;
_vehicle setConvoySeparation 50;
_vehicle forceSpeed (random [40,50,60]);
_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_vehicle allowCrewInImmobile [TRUE,TRUE];
_vehicle setUnloadInCombat [TRUE,FALSE];
[0,_vehicle,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
_vehicle addEventHandler [
	'GetOut',
	{
		(_this # 2) setDamage 1;
		(_this # 0) setDamage 1;
	}
];
clearMagazineCargoGlobal _vehicle;
clearWeaponCargoGlobal _vehicle;
clearItemCargoGlobal _vehicle;
clearBackpackCargoGlobal _vehicle;
if ((toLowerANSI _vehicleType) in ['b_apc_tracked_01_rcws_f','b_t_apc_tracked_01_rcws_f']) then {
	_engineerType = 'O_engineer_F';
	_grp = createGroup [EAST,TRUE];
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _engineerType,_engineerType],_randomRoadPosition,[],0,'NONE'];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit assignAsDriver _vehicle;
	_unit moveInDriver _vehicle;
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _engineerType,_engineerType],_randomRoadPosition,[],0,'NONE'];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit assignAsGunner _vehicle;
	_unit moveInGunner _vehicle;
	_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _engineerType,_engineerType],_randomRoadPosition,[],0,'NONE'];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_unit assignAsCommander _vehicle;
	_unit moveInCommander _vehicle;
} else {
	_grp = createVehicleCrew _vehicle;
};
if (!isNull (roadAt _randomRoadPosition)) then {
	_vehicle setDir (_randomRoadPosition getDir (position ((roadsConnectedTo (roadAt _randomRoadPosition)) # 0)));
};
_vehicle setVectorUp (surfaceNormal _randomRoadPosition);
_vehicle setPos _randomRoadPosition;
_grp addVehicle _vehicle;
[_vehicle] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
[(units _grp),(selectRandom [1,2])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_vehicle setVariable ['QS_dynSim_ignore',TRUE,FALSE];
_vehicle enableDynamicSimulation FALSE;
_vehicle limitSpeed (random [30,35,45]);
_grp addVehicle _vehicle;
_grp setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_grp enableDynamicSimulation FALSE;
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x enableDynamicSimulation FALSE;
} forEach (units _grp);
{
	_x setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
	_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
	_x setSpeaker 'NoVoice';
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	0 = _arrayVehicles pushBack _x;
} forEach (units _grp);
if (!isNull (gunner _vehicle)) then {
	(gunner _vehicle) setSkill 0.1;
	(gunner _vehicle) setSkill ['aimingAccuracy',(random [0.05,0.06,0.08])];
};
if (!isNull (commander _vehicle)) then {
	(commander _vehicle) setSkill 0.1;
	(commander _vehicle) setSkill ['aimingAccuracy',(random [0.05,0.06,0.08])];
};
_roadsValidPositions = ((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
_vehicleRoadPatrolPositions = [];
_vehicleRoadPatrolPositions pushBack (position (selectRandom _roadsValidPositions));
for '_x' from 0 to 2 step 1 do {
	_vehicleRoadPatrolPositions pushBack (position (selectRandom (_roadsValidPositions select {((_x distance2D (_vehicleRoadPatrolPositions select ((count _vehicleRoadPatrolPositions) - 1))) > 35)})));
};
_grp setSpeedMode 'LIMITED';
_grp setBehaviour 'SAFE';
_grp setCombatMode 'YELLOW';
_grp setFormation 'COLUMN';
_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
_grp setVariable ['QS_AI_GRP_CONFIG',['SC','VEH_PATROL',(count (units _grp)),_vehicle],FALSE];
_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
_grp setVariable ['QS_AI_GRP_TASK',['PATROL_VEH',_vehicleRoadPatrolPositions,serverTime,-1],FALSE];
_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
if (_vehicleRoadPatrolPositions isNotEqualTo []) then {
	_grp setFormDir (_randomRoadPosition getDir (_vehicleRoadPatrolPositions # 0));
	_grp move (_vehicleRoadPatrolPositions # 0);
};
if ((toLowerANSI _vehicleType) in (['classic_reinforcevslingable_1'] call QS_data_listVehicles)) then {
	if (diag_fps > 15) then {
		if ((count allPlayers) > 0) then {
			if ((random 1) > 0.5) then {
				if (missionNamespace getVariable ['QS_AI_insertHeli_enabled',FALSE]) then {
					if (({(alive _x)} count (missionNamespace getVariable ['QS_AI_insertHeli_helis',[]])) < (missionNamespace getVariable ['QS_AI_insertHeli_maxHelis',3])) then {
						if (diag_tickTime > ((missionNamespace getVariable ['QS_AI_insertHeli_lastEvent',-1]) + (missionNamespace getVariable ['QS_AI_insertHeli_cooldown',900]))) then {
							if ((missionNamespace getVariable ['QS_AI_insertHeli_spawnedAO',0]) < (missionNamespace getVariable ['QS_AI_insertHeli_maxAO',3])) then {
								if (([4,EAST,_centerPos,2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) isEqualTo 0) then {
									if (([3,EAST,_centerPos,2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) isEqualTo 0) then {
										private _insertHeliType = '';
										if ((toLowerANSI _vehicleType) in (['classic_reinforcevslingable_1'] call QS_data_listVehicles)) then {
											_insertHeliType = ['classic_reinforcevslinger_1'] call QS_data_listVehicles;
										};
										if (_insertHeliType isNotEqualTo '') then {
											missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',((missionNamespace getVariable 'QS_AI_insertHeli_spawnedAO') + 1),FALSE];
											missionNamespace setVariable ['QS_AI_insertHeli_lastEvent',diag_tickTime,FALSE];
											[
												_centerPos,
												_vehicle,
												_insertHeliType,
												EAST
											] spawn (missionNamespace getVariable 'QS_fnc_AIXHeliInsertVehicle');
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};
_arrayVehicles;