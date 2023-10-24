/*/
File: fn_gridEnemy.sqf
Author: 

	Quiksilver

Last Modified:

	7/12/2017 A3 1.80 by Quiksilver

Description:

	-
____________________________________________________________________________/*/

params ['_aoPos','_aoSize','_igPos','_aoData','_terrainData'];
_aoData params [
	'',
	'',
	'_aoPolygon',
	'_aoMarkers',
	'','','','','','','','','','',''
];
_terrainData params [
	'_roadSegments',
	'_roadSegmentsInPolygon',
	'_roadIntersections',
	'_nearHouses',
	'_nearHousesInPolygon',
	'_nearBuildingPositions',
	'_buildingPositionsInPolygon',
	'_buildingPositionsInPolygonNearGround'
];
_isDedicated = isDedicated;
_worldName = worldName;
_worldSize = worldSize;
private _basePosition = markerPos 'QS_marker_base_marker';
private _baseRadius = 500;
private _fobPosition = markerPos 'QS_marker_module_fob';
private _fobRadius = 150;
private _spawnPosition = [0,0,0];
private _gridEnemy = [];
private _allPlayers = allPlayers;
private _playersCount = count _allPlayers;
private _unitTypes = ['grid_units_1'] call QS_data_listUnits;
private _vehicleTypes = ['grid_vehicles_1'] call QS_data_listVehicles;
private _vehicleTypesArmed = ['grid_vehicles_2'] call QS_data_listVehicles;
private _enemiesInBuildingsCount = 16;
private _interBuildingCount = 14;
private _areaPatrolCount = 12;
private _unarmedVehicleCount = 1;
private _armedVehicleCount = 2;
private _hqGuardsMax = 6;
if (_playersCount > 10) then {
	_enemiesInBuildingsCount = 20;
	_interBuildingCount = 16;
	_areaPatrolCount = 12;
	_unarmedVehicleCount = 1;
	_armedVehicleCount = 2;
	_hqGuardsMax = 8;
};
if (_playersCount > 20) then {
	_enemiesInBuildingsCount = 22;
	_interBuildingCount = 18;
	_areaPatrolCount = 12;
	_unarmedVehicleCount = 1;
	_armedVehicleCount = 3;
	_hqGuardsMax = 10;
};
if (_playersCount > 30) then {
	_enemiesInBuildingsCount = 24;
	_interBuildingCount = 20;
	_areaPatrolCount = 12;
	_unarmedVehicleCount = 1;
	_armedVehicleCount = 3;
	_hqGuardsMax = 12;
};
if (_playersCount > 40) then {
	_enemiesInBuildingsCount = 26;
	_interBuildingCount = 22;
	_areaPatrolCount = 12;
	_unarmedVehicleCount = 1;
	_armedVehicleCount = 3;
	_hqGuardsMax = 12;
};
if (_playersCount > 50) then {
	_enemiesInBuildingsCount = 28;
	_interBuildingCount = 24;
	_areaPatrolCount = 12;
	_unarmedVehicleCount = 1;
	_armedVehicleCount = 3;
	_hqGuardsMax = 14;
};
private _enemyUnit = objNull;
private _enemyUnitType = '';
private _enemyGrp = grpNull;
private _enemySide = EAST;
private _enemyTeamSize = 4;

/*/================================================================================================== Building AI/*/
private _buildingEnemies = [];
private _buildingPositions = _buildingPositionsInPolygon;
private _buildingPositionIndex = -1;
private _buildingPosition = [0,0,0];
_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
if (_buildingPositions isEqualTo []) then {
	_buildingPositions = _nearBuildingPositions;
	_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
if (_buildingPositions isEqualTo []) then {
	private _house = objNull;
	{
		_house = _x;
		{
			_buildingPositions pushBack _x;
		} forEach (_house buildingPos -1);
	} forEach (nearestObjects [_aoPos,['House'],_aoSize,TRUE]); 
};
if (_buildingPositions isNotEqualTo []) then {
	_enemyGrp = createGroup [EAST,TRUE];
	for '_x' from 0 to (_enemiesInBuildingsCount - 1) step 1 do {
		_enemyUnitType = selectRandomWeighted _unitTypes;
		_buildingPosition = selectRandom _buildingPositions;
		_buildingPositionIndex = _buildingPositions find _buildingPosition;
		_buildingPositions set [_buildingPositionIndex,FALSE];
		_buildingPositions deleteAt _buildingPositionIndex;
		_enemyUnit = _enemyGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyUnitType,_enemyUnitType],[-300,-300,50],[],50,'NONE'];
		{
			_enemyUnit enableAIFeature [_x,FALSE];
		} forEach ['PATH','COVER','AUTOCOMBAT'];
		_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
		_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_enemyUnit setUnitPosWeak (selectRandomWeighted ['UP',0.666,'MIDDLE',0.333]);
		_buildingEnemies pushBack _enemyUnit;
		if ((random 1) > 0.666) then {
			_enemyUnit addEventHandler [
				'Hit',
				{
					params ['_unit'];
					_unit removeEventHandler [_thisEvent,_thisEventHandler];
					if (!isNull (_unit findNearestEnemy _unit)) then {
						if (((_unit findNearestEnemy _unit) distance2D _unit) < 50) then {
							_unit enableAIFeature ['PATH',TRUE];
						};
					};
				}
			];
		};
		_enemyUnit setPosASL (AGLToASL _buildingPosition);
		[_enemyUnit] joinSilent _enemyGrp;
		if (_buildingPositions isEqualTo []) then {
			_buildingPositions = _nearBuildingPositions;
			_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		};
		if (_buildingPositions isEqualTo []) exitWith {};
	};
	_enemyGrp enableAttack FALSE;
	_enemyGrp setCombatMode 'RED';
	[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],QS_system_AI_owners];
	_enemyGrp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
	_enemyGrp setVariable ['QS_AI_GRP_TASK',['BLDG_GARRISON',[],serverTime,-1],QS_system_AI_owners];
	_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	_enemyGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_enemyGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};
/*/================================================================================================== Inter-building patrols/*/
private _buildingPatrolEnemies = [];
private _interBuildingPatrols = round ((_interBuildingCount / _enemyTeamSize) - 1);
private _filteredBuildingPositions = [];
private _usedBuildingPositions = [];
private _positionsMinRadius = 100;
if (_interBuildingPatrols > 0) then {
	_checkPosition = {
		params ['_pos','_usedPositions','_radius'];
		private _c = FALSE;
		if (_usedPositions isEqualTo []) exitWith {
			_c = TRUE;
			_c;
		};
		if ((_usedPositions findIf {(((_pos distance2D _x) < _radius) && ([_pos,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}) isEqualTo -1) then {
			_c = TRUE;
		};
		_c;
	};
	_buildingPositions = _buildingPositionsInPolygon;
	_buildingPositionIndex = -1;
	_buildingPosition = [0,0,0];
	_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	if (_buildingPositions isEqualTo []) then {
		_buildingPositions = _nearBuildingPositions;
		_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_buildingPositions = _buildingPositions apply { [_x # 0,_x # 1,((_x # 2) + 1)] };
	for '_h' from 0 to _interBuildingPatrols step 1 do {
		_usedBuildingPositions = [];
		_filteredBuildingPositions = [];
		for '_i' from 0 to 2 step 1 do {
			_filteredBuildingPositions = _buildingPositions select {([_x,_usedBuildingPositions,_positionsMinRadius] call _checkPosition)};
			if (_filteredBuildingPositions isNotEqualTo []) then {
				_usedBuildingPositions pushBack (selectRandom _filteredBuildingPositions);
			};
		};
		if (_usedBuildingPositions isNotEqualTo []) then {
			_spawnPosition = selectRandom _usedBuildingPositions;
			_enemyGrp = createGroup [EAST,TRUE];
			for '_j' from 0 to (_enemyTeamSize - 1) step 1 do {
				_enemyUnitType = selectRandomWeighted _unitTypes;
				_enemyUnit = _enemyGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyUnitType,_enemyUnitType],_spawnPosition,[],25,'NONE'];
				_enemyUnit setVehiclePosition [(getPosWorld _enemyUnit),[],10,'NONE'];
				{
					_enemyUnit enableAIFeature [_x,FALSE];
				} forEach ['COVER','AUTOCOMBAT'];
				_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
				_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				[_enemyUnit] joinSilent _enemyGrp;
				_buildingPatrolEnemies pushBack _enemyUnit;
			};
			_enemyGrp enableAttack TRUE;
			_enemyGrp setCombatMode 'RED';
			_enemyGrp setBehaviour 'SAFE';
			[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_usedBuildingPositions,serverTime,-1],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
	};
};
/*/================================================================================================== Area patrols/*/
private _areaPatrols = (round (_areaPatrolCount / _enemyTeamSize)) - 1;
private _areaPatrolEnemies = [];
private _patrolRoute = [];
private _patrolPos = [0,0,0];
_positionsMinRadius = 150;
if (_areaPatrols > 0) then {
	_checkPatrolPos = {
		params ['_pos','_usedPositions','_radius'];
		private _c = FALSE;
		if (_usedPositions isEqualTo []) exitWith {
			_c = TRUE;
			_c;
		};
		if ((_usedPositions findIf {(((_pos distance2D _x) < _radius) && ([_pos,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}) isEqualTo -1) then {
			_c = TRUE;
		};
		_c;
	};
	for '_h' from 0 to _areaPatrols step 1 do {
		_patrolRoute = [];
		for '_i' from 0 to 49 step 1 do {
			_patrolPos = ['RADIUS',_aoPos,_aoSize,'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if ([_patrolPos,_patrolRoute,_positionsMinRadius] call _checkPatrolPos) then {
				if (_patrolPos inPolygon _aoPolygon) then {
					_patrolPos set [2,0];
					_patrolRoute pushBack _patrolPos;
				} else {
					if ((random 1) > 0.666) then {
						_patrolPos set [2,0];
						_patrolRoute pushBack _patrolPos;
					};
				};
			};
			if ((count _patrolRoute) >= 3) exitWith {};
		};
		if ((count _patrolRoute) > 1) then {
			_enemyGrp = createGroup [EAST,TRUE];
			for '_j' from 0 to (_enemyTeamSize - 1) step 1 do {
				_enemyUnitType = selectRandomWeighted _unitTypes;
				_enemyUnit = _enemyGrp createUnit [_enemyUnitType,(_patrolRoute # 0),[],25,'NONE'];
				_enemyUnit setVehiclePosition [(getPosASL _enemyUnit),[],10,'NONE'];
				{
					_enemyUnit enableAIFeature [_x,FALSE];
				} forEach ['COVER','AUTOCOMBAT'];
				_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
				_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				if ((toLowerANSI _enemyUnitType) in ['o_g_soldier_f','o_g_soldier_lite_f','i_c_soldier_bandit_6_f','i_c_soldier_para_1_f']) then {
					if ((random 1) > 0.5) then {
						_enemyUnit addBackpack (['b_bergen_hex_f','b_carryall_ghex_f'] select (_worldName isEqualTo 'Tanoa'));
						[_enemyUnit,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (_worldName isEqualTo 'Tanoa')),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					};
				};
				[_enemyUnit] joinSilent _enemyGrp;
				_areaPatrolEnemies pushBack _enemyUnit;
			};
			_enemyGrp enableAttack TRUE;
			_enemyGrp setCombatMode 'RED';
			_enemyGrp setBehaviour 'SAFE';
			[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_enemyGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
	};
};

/*/================================================================================================== Vehicle patrols/*/

private _armedVehiclePatrolEnemies = [];
private _roadSegment = objNull;
private _vehicle = objNull;
private _spawnDirection = 0;
private _static = objNull;
private _staticTypes = ['grid_statics_1'] call QS_data_listVehicles;
private _vehicleType = '';
_positionsMinRadius = 100;
if (_armedVehicleCount > 0) then {
	if ((count _roadSegmentsInPolygon) > 25) then {
		_roadSegmentsInPolygon = _roadSegmentsInPolygon call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_checkVehPatrolPos = {
			params ['_pos','_usedPositions','_radius'];
			private _c = FALSE;
			if (_usedPositions isEqualTo []) exitWith {
				_c = TRUE;
				_c;
			};
			if ((_usedPositions findIf {(((_pos distance2D _x) < _radius) && ([_pos,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}) isEqualTo -1) then {
				if ((_pos nearEntities ['All',6]) isEqualTo []) then {
					_c = TRUE;
				};
			};
			_c;
		};
		for '_h' from 0 to (_armedVehicleCount - 1) step 1 do {
			_patrolRoute = [];
			_spawnDirection = 0;
			for '_i' from 0 to 49 step 1 do {
				_roadSegment = selectRandom _roadSegmentsInPolygon;
				_patrolPos = position _roadSegment;
				if ([_patrolPos,_patrolRoute,_positionsMinRadius] call _checkVehPatrolPos) then {
					if (_patrolPos inPolygon _aoPolygon) then {
						_patrolPos set [2,0];
						_patrolRoute pushBack _patrolPos;
					} else {
						if ((random 1) > 0.666) then {
							_patrolPos set [2,0];
							_patrolRoute pushBack _patrolPos;
						};
					};
				};
				if ((count _patrolRoute) >= 3) exitWith {};
			};
			if ((count _patrolRoute) > 1) then {
				_enemyGrp = createGroup [EAST,TRUE];
				_spawnPos = _patrolRoute # 0;
				if (!isNull (roadAt _spawnPos)) then {
					_spawnDirection = _spawnPos getDir ((roadsConnectedTo (roadAt _spawnPos)) # 0);
				};
				_vehicleType = selectRandomWeighted ([4] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
				_vehicle = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],(_spawnPos vectorAdd [0,0,5]),[],0,'NONE'];
				if (_spawnDirection isNotEqualTo 0) then {
					_vehicle setDir _spawnDirection;
				};
				_vehicle setVectorUp (surfaceNormal _spawnPos);
				_vehicle setVehiclePosition [_spawnPos,[],0,'CAN_COLLIDE'];
				_vehicle lock 3;
				(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
				_vehicle allowCrewInImmobile [TRUE,TRUE];
				_vehicle setUnloadInCombat [TRUE,FALSE];
				_vehicle enableVehicleCargo FALSE;
				_vehicle enableRopeAttach FALSE;
				_vehicle forceFollowRoad TRUE;
				_vehicle setConvoySeparation 50;
				_vehicle limitSpeed 60;
				[0,_vehicle,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
				_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
				_vehicle addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
				_armedVehiclePatrolEnemies pushBack _vehicle;
				for '_j' from 0 to (((count (fullCrew [_vehicle,'',TRUE])) - 1) min 3) step 1 do {
					_enemyUnitType = selectRandomWeighted _unitTypes;
					_enemyUnit = _enemyGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyUnitType,_enemyUnitType],_spawnPos,[],25,'NONE'];
					{
						_enemyUnit enableAIFeature [_x,FALSE];
					} forEach ['COVER','AUTOCOMBAT'];
					if (_j isEqualTo 0) then {
						_enemyUnit assignAsDriver _vehicle;
						_enemyUnit moveInDriver _vehicle;
					} else {
						_enemyUnit moveInAny _vehicle;
					};
					_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
					_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
					[_enemyUnit] joinSilent _enemyGrp;
					_armedVehiclePatrolEnemies pushBack _enemyUnit;
				};
				
				if ((toLowerANSI (typeOf _vehicle)) in ['i_c_van_01_transport_f','o_g_van_01_transport_f']) then {
					_vehicle addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							{
								_x setDamage [1,FALSE];
								[0,_x] call QS_fnc_eventAttach;
								deleteVehicle _x;
							} forEach (attachedObjects _entity);
						}
					];
					_vehicle addEventHandler [
						'Killed',
						{
							params ['_entity'];
							{
								_x setDamage [1,FALSE];
								[0,_x] call QS_fnc_eventAttach;
								deleteVehicle _x;
							} forEach (attachedObjects _entity);
						}
					];
					_vehicleType = selectRandom _staticTypes;
					_static = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vehicleType,_vehicleType],[-200,-200,50],[],25,'NONE'];
					_static lock 2;
					_static allowCrewInImmobile [TRUE,TRUE];
					_static enableVehicleCargo FALSE;
					_static setVariable ['QS_curator_disableEditability',TRUE,QS_system_AI_owners];
					_static enableRopeAttach FALSE;
					if ((random 1) > 0.5) then {
						[_static] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
					};
					[1,_static,[_vehicle,[0,-2,1]]] call QS_fnc_eventAttach;
					_enemyUnitType = selectRandomWeighted _unitTypes;
					_enemyUnit = _enemyGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyUnitType,_enemyUnitType],_spawnPos,[],25,'NONE'];
					{
						_enemyUnit enableAIFeature [_x,FALSE];
					} forEach ['COVER','AUTOCOMBAT'];
					_enemyUnit moveInGunner _static;
					_enemyGrp addVehicle _static;
					_armedVehiclePatrolEnemies pushBack _enemyUnit;
				};
				_enemyGrp addVehicle _vehicle;
				_enemyGrp enableAttack TRUE;
				_enemyGrp setCombatMode 'RED';
				_enemyGrp setBehaviour 'SAFE';
				[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _enemyGrp)),_vehicle],QS_system_AI_owners];
				_enemyGrp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
				_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
				_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
				_enemyGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
				_enemyGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			};
		};
	};
};
/*/================================================================================================== IG HQ Guards/*/
private _hqGuards = [];
private _hqBuildingPositions = [];
private _hqBuildingPosition = [0,0,0];
private _hqBuildingPositionIndex = -1;
private _building = objNull;
if (alive (missionNamespace getVariable ['QS_grid_IGleader',objNull])) then {
	_composition = missionNamespace getVariable ['QS_grid_IGcomposition',[]];
	{	
		_building = _x;
		_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
		if (_buildingPositions isNotEqualTo []) then {
			{
				_hqBuildingPositions pushBack _x;
			} forEach _buildingPositions;
		};
	} forEach _composition;
	if (_hqBuildingPositions isNotEqualTo []) then {
		_enemyGrp = createGroup [EAST,TRUE];
		for '_k' from 0 to (_hqGuardsMax - 1) step 1 do {
			_hqBuildingPosition = selectRandom _hqBuildingPositions;
			_hqBuildingPositionIndex = _hqBuildingPositions find _hqBuildingPosition;
			_hqBuildingPositions set [_hqBuildingPositionIndex,FALSE];
			_hqBuildingPositions deleteAt _hqBuildingPositionIndex;
			_enemyUnitType = selectRandomWeighted _unitTypes;
			_enemyUnit = _enemyGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyUnitType,_enemyUnitType],[-300,-300,50],[],25,'NONE'];
			{
				_enemyUnit enableAIFeature [_x,FALSE];
			} forEach ['COVER','AUTOCOMBAT','PATH'];
			if ((random 1) > 0.666) then {
				_enemyUnit addEventHandler [
					'Hit',
					{
						params ['_unit'];
						_unit removeEventHandler [_thisEvent,_thisEventHandler];
						if (!isNull (_unit findNearestEnemy _unit)) then {
							if (((_unit findNearestEnemy _unit) distance2D _unit) < 50) then {
								_unit enableAIFeature ['PATH',TRUE];
							};
						};
					}
				];
			};
			_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
			_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_enemyUnit setUnitPosWeak (selectRandom ['UP','UP','MIDDLE']);
			_hqGuards pushBack _enemyUnit;
			_buildingEnemies pushBack _enemyUnit;
			if ((random 1) > 0.666) then {
				_enemyUnit addEventHandler [
					'Hit',
					{
						params ['_unit'];
						_unit removeEventHandler [_thisEvent,_thisEventHandler];
						if (alive (_unit findNearestEnemy _unit)) then {
							if (((_unit findNearestEnemy _unit) distance2D _unit) < 100) then {
								_unit enableAIFeature ['PATH',TRUE];
							};
						};
					}
				];
			};
			_enemyUnit setPosASL (AGLToASL _hqBuildingPosition);
			[_enemyUnit] joinSilent _enemyGrp;
			if (_hqBuildingPositions isEqualTo []) exitWith {};
		};
		_enemyGrp enableAttack FALSE;
		_enemyGrp setCombatMode 'RED';
		[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],QS_system_AI_owners];
		_enemyGrp setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
		_enemyGrp setVariable ['QS_AI_GRP_TASK',['BLDG_GARRISON',[],serverTime,-1],QS_system_AI_owners];
		_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
		_enemyGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_enemyGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	};
	{
		if (_x isEqualTo (leader (group _x))) then {
			_enemyGrp = group _x;
			_patrolRoute = (_enemyGrp getVariable 'QS_AI_GRP_TASK') # 1;
			_patrolRoute pushBack (missionNamespace getVariable 'QS_grid_IGposition');
			_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,serverTime,-1],QS_system_AI_owners];
		};
	} forEach _areaPatrolEnemies;
};
_gridEnemy = [
	_buildingEnemies,
	_buildingPatrolEnemies,
	_areaPatrolEnemies,
	_armedVehiclePatrolEnemies,
	_hqGuards
];
missionNamespace setVariable ['QS_grid_AI_enemy_1',_gridEnemy,QS_system_AI_owners];