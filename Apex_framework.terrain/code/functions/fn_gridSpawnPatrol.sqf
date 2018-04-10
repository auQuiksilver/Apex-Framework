/*/
File: fn_gridSpawnPatrol.sqf
Author:

	Quiksilver
	
Last Modified:

	8/04/2018 A3 1.82 by Quiksilver
	
Description:

	Grid Spawn Patrol
_____________________________________________________________________/*/

params [
	'_type',
	'_teamSize',
	'_aoPos',
	'_aoSize',
	'_igPos',
	'_aoData',
	'_terrainData'
];
_isDedicated = isDedicated;
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
private _unitTypes = [
	'O_G_Soldier_A_F',1,
	'O_G_Soldier_AR_F',3,
	'O_G_medic_F',1,
	'O_G_engineer_F',1,
	'O_G_Soldier_exp_F',1,
	'O_G_Soldier_GL_F',1,
	'O_G_Soldier_M_F',1,
	'O_G_Soldier_F',1,
	'O_G_Soldier_LAT_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
	'O_G_Soldier_LAT2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
	'O_G_Soldier_lite_F',1,
	'O_G_Sharpshooter_F',3,
	'O_G_Soldier_TL_F',1,
	'I_C_Soldier_Bandit_7_F',1,
	'I_C_Soldier_Bandit_3_F',3,
	'I_C_Soldier_Bandit_2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
	'I_C_Soldier_Bandit_5_F',2,
	'I_C_Soldier_Bandit_6_F',2,
	'I_C_Soldier_Bandit_1_F',2,
	'I_C_Soldier_Bandit_8_F',2,
	'I_C_Soldier_Bandit_4_F',2,
	'I_C_Soldier_Para_7_F',1,
	'I_C_Soldier_Para_2_F',1,
	'I_C_Soldier_Para_3_F',1,
	'I_C_Soldier_Para_4_F',3,
	'I_C_Soldier_Para_6_F',1,
	'I_C_Soldier_Para_8_F',1,
	'I_C_Soldier_Para_1_F',1,
	'I_C_Soldier_Para_5_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4)
];
_worldName = worldName;
_worldSize = worldSize;
private _isHCActive = missionNamespace getVariable ['QS_HC_Active',FALSE];
private _basePosition = markerPos 'QS_marker_base_marker';
private _baseRadius = 500;
private _fobPosition = markerPos 'QS_marker_module_fob';
private _fobRadius = 150;
private _allPlayers = allPlayers;
private _playersCount = count _allPlayers;
private _enemyGrp = grpNull;
private _enemyUnitType = '';
private _enemyUnit = objNull;
if (_type isEqualTo 0) exitWith {
	private _buildingPatrolEnemies = [];
	private _filteredBuildingPositions = [];
	private _usedBuildingPositions = [];
	private _positionsMinRadius = 100;
	private _spawnPosition = [0,0,0];
	_checkPosition = {
		params ['_pos','_usedPositions','_radius','_allPlayers'];
		private _c = FALSE;
		if (_usedPositions isEqualTo []) exitWith {
			_c = TRUE;
			_c;
		};
		if ((_usedPositions findIf {(((_pos distance2D _x) < _radius) && ([_pos,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}) isEqualTo -1) then {
			if (([_pos,300,[WEST,CIVILIAN],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
				_c = TRUE;
			};
		};
		_c;
	};
	private _buildingPositions = _buildingPositionsInPolygon;
	private _buildingPositionIndex = -1;
	private _buildingPosition = [0,0,0];
	_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	if (_buildingPositions isEqualTo []) then {
		_buildingPositions = _nearBuildingPositions;
		_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_buildingPositions = _buildingPositions apply { [_x select 0,_x select 1,((_x select 2) + 1)] };
	private _usedBuildingPositions = [];
	private _filteredBuildingPositions = [];
	for '_i' from 0 to 2 step 1 do {
		_filteredBuildingPositions = _buildingPositions select {([_x,_usedBuildingPositions,_positionsMinRadius,_allPlayers] call _checkPosition)};
		if (!(_filteredBuildingPositions isEqualTo [])) then {
			_usedBuildingPositions pushBack (selectRandom _filteredBuildingPositions);
		};
	};
	if (!(_usedBuildingPositions isEqualTo [])) then {
		_spawnPosition = selectRandom _usedBuildingPositions;
		_enemyGrp = createGroup [EAST,TRUE];
		for '_j' from 0 to (_teamSize - 1) step 1 do {
			_enemyUnitType = selectRandomWeighted _unitTypes;
			_enemyUnit = _enemyGrp createUnit [_enemyUnitType,_spawnPosition,[],25,'NONE'];
			if (_isDedicated) then {
				[_enemyUnit,'amovppnemstpsraswrfldnon'] remoteExecCall ['switchMove',-2,FALSE];
			} else {
				['switchMove',_enemyUnit,'amovppnemstpsraswrfldnon'] remoteExecCall ['QS_fnc_remoteExecCmd',-2,FALSE];
			};
			_enemyUnit setVehiclePosition [(getPosWorld _enemyUnit),[],10,'NONE'];
			_enemyUnit disableAI 'COVER';
			_enemyUnit disableAI 'AUTOCOMBAT';
			_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			if ((toLower _enemyUnitType) in ['o_g_soldier_f','o_g_soldier_lite_f','i_c_soldier_bandit_6_f','i_c_soldier_para_1_f']) then {
				if ((random 1) > 0.5) then {
					_enemyUnit addBackpack (['b_bergen_hex_f','b_carryall_ghex_f'] select (_worldName in ['Tanoa','Lingor3']));
					[_enemyUnit,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (_worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
				};
			};
			[_enemyUnit] joinSilent _enemyGrp;
			_buildingPatrolEnemies pushBack _enemyUnit;
		};
		_enemyGrp enableAttack TRUE;
		_enemyGrp setCombatMode 'RED';
		_enemyGrp setBehaviour 'SAFE';
		[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_usedBuildingPositions,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		if (_isHCActive) then {
			_enemyGrp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};
	};
	_buildingPatrolEnemies;
};
if (_type isEqualTo 1) exitWith {
	private _areaPatrolEnemies = [];
	private _patrolRoute = [];
	private _patrolPos = [0,0,0];
	_positionsMinRadius = 150;
	_checkPatrolPos = {
		params ['_pos','_usedPositions','_radius','_allPlayers'];
		private _c = FALSE;
		if (_usedPositions isEqualTo []) exitWith {
			_c = TRUE;
			_c;
		};
		if ((_usedPositions findIf {(((_pos distance2D _x) < _radius) && ([_pos,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}) isEqualTo -1) then {
			if (([_pos,300,[WEST,CIVILIAN],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
				_c = TRUE;
			};
		};
		_c;
	};
	_patrolRoute = [];
	for '_i' from 0 to 49 step 1 do {
		_patrolPos = ['RADIUS',_aoPos,_aoSize,'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if ([_patrolPos,_patrolRoute,_positionsMinRadius,_allPlayers] call _checkPatrolPos) then {
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
		for '_j' from 0 to (_teamSize - 1) step 1 do {
			_enemyUnitType = selectRandomWeighted _unitTypes;
			_enemyUnit = _enemyGrp createUnit [_enemyUnitType,(_patrolRoute select 0),[],25,'NONE'];
			_enemyUnit setVehiclePosition [(getPosASL _enemyUnit),[],10,'NONE'];
			_enemyUnit disableAI 'COVER';
			_enemyUnit disableAI 'AUTOCOMBAT';
			_enemyUnit disableAI 'COVER';
			_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			if ((toLower _enemyUnitType) in ['o_g_soldier_f','o_g_soldier_lite_f','i_c_soldier_bandit_6_f','i_c_soldier_para_1_f']) then {
				if ((random 1) > 0.5) then {
					_enemyUnit addBackpack (['b_bergen_hex_f','b_carryall_ghex_f'] select (_worldName in ['Tanoa','Lingor3']));
					[_enemyUnit,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (_worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
				};
			};
			[_enemyUnit] joinSilent _enemyGrp;
			_areaPatrolEnemies pushBack _enemyUnit;
		};
		_enemyGrp enableAttack TRUE;
		_enemyGrp setCombatMode 'RED';
		_enemyGrp setBehaviour 'SAFE';
		[(units _enemyGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		if (_isHCActive) then {
			_enemyGrp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};
	};
	_areaPatrolEnemies;
};