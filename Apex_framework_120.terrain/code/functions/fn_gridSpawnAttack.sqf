/*/
File: fn_gridSpawnAttack.sqf
Author: 

	Quiksilver

Last Modified:

	2/12/2017 A3 1.78 by Quiksilver

Description:

	-
____________________________________________________________________________/*/

params ['_type','_aoPos','_aoSize','_igPos','_teamsize'];
private _enemyUnits = [];
_worldName = worldName;
_worldSize = worldSize;
_basePosition = markerPos 'QS_marker_base_marker';
_fobPosition = markerPos 'QS_marker_module_fob';
private _isHCActive = missionNamespace getVariable ['QS_HC_Active',FALSE];
private _fn_blacklist = {TRUE};
if (_worldName isEqualTo 'Tanoa') then {
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
			[[11440.4,14422,0.0013628],275],
			[(markerPos 'QS_marker_base_marker'),500],
			[(markerPos 'QS_marker_module_fob'),100]
		];
		_c;
	};
};
private _spawnPos = [0,0,0];
private _foundSpawnPos = FALSE;
private _unitTypes = [
	'O_G_Soldier_A_F',1,
	'O_G_Soldier_AR_F',4,
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
private _allPlayers = allPlayers;
private _playersCount = count _allPlayers;
private _enemyGrp = grpNull;
private _enemyUnitType = '';
private _enemyUnit = objNull;
private _buildingPositions = [];
private _moveData = [];
private _moveType = 'MOVE';
private _grpSpeedCoef = 1;
if (_type isEqualTo 0) exitWith {
	for '_x' from 0 to 49 step 1 do {
		if ((random 1) > 0.333) then {
			_spawnPos = [_igPos,300,600,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		} else {
			_spawnPos = [_igPos,250,500,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		};
		if (!(_spawnPos isEqualTo [])) then {
			if ((_allPlayers inAreaArray [_spawnPos,300,300,0,FALSE]) isEqualTo []) then {
				if ((_spawnPos distance2D _igPos) < 1001) then {
					if (_spawnPos call _fn_blacklist) then {
						if (!([_spawnPos,_igPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
							_foundSpawnPos = TRUE;
						};
					};
				};
			};
		};
		if (_foundSpawnPos) exitWith {};
	};
	if (_foundSpawnPos) then {
		_spawnPos set [2,0];
		_composition = missionNamespace getVariable ['QS_grid_IGcomposition',[]];
		{	
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (!(_buildingPositions isEqualTo [])) then {
				{
					_moveData pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _composition;
		if (!(_moveData isEqualTo [])) then {
			_moveData = _moveData apply {[(_x select 0),(_x select 1),((_x select 2) + 1)]};
			_moveType = 'ATTACK_2';
		} else {
			_moveData = _igPos;
		};
		_enemyGrp = createGroup [EAST,TRUE];
		_grpSpeedCoef = random [1,1.05,1.1];
		for '_j' from 0 to (_teamsize - 1) step 1 do {
			_enemyUnitType = selectRandomWeighted _unitTypes;
			_enemyUnit = _enemyGrp createUnit [_enemyUnitType,_spawnPos,[],10,'NONE'];
			_enemyUnit setVehiclePosition [(getPosWorld _enemyUnit),[],10,'NONE'];
			_enemyUnit disableAI 'COVER';
			_enemyUnit disableAI 'AUTOCOMBAT';
			_enemyUnit setAnimSpeedCoef _grpSpeedCoef;
			_enemyUnit enableStamina FALSE;
			_enemyUnit enableFatigue FALSE;
			_enemyUnit setVariable ['QS_AI_UNIT_enabled',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			[_enemyUnit] joinSilent _enemyGrp;
			_enemyUnits pushBack _enemyUnit;
		};
		_enemyGrp setFormDir (_spawnPos getDir _igPos);
		_enemyGrp enableAttack TRUE;
		_enemyGrp setCombatMode 'RED';
		_enemyGrp setBehaviour 'AWARE';
		_enemyGrp setSpeedMode 'FULL';
		[(units _enemyGrp),(selectRandomWeighted [1,0.5,2,0.5])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_enemyGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _enemyGrp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_DATA',[],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_TASK',[_moveType,_moveData,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_enemyGrp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		if (_isHCActive) then {
			_enemyGrp setVariable ['QS_grp_HC',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};	
		_enemyGrp move _igPos;
	};
	_enemyUnits;
};
_enemyUnits;