/*/
File: fn_aoEnemyReinforce.sqf
Author:

	Quiksilver
	
Last modified:

	23/10/2023 A3 2.14 by Quiksilver
	
Description:

	Enemy reinforce AO
	
Notes:

	- Attempt urban spawn
	- Attempt helicopter insert
	- Attempt HQ spawn
	- Default spawn
	
Returns:

	- Array of entities (units)
__________________________________________________/*/

params ['_pos'];
private _allPlayers = allPlayers;
private _unitsEast = units EAST;
private _QS_array = [];
private _aoPos = _pos;
private _hqPos = missionNamespace getVariable 'QS_HQpos';
if (worldName isEqualTo 'Stratis') then {
	_hqPos = missionNamespace getVariable 'QS_aoPos';
};
private _minDist = 300;
private _maxDist = 800;
private _fn_blacklist = {TRUE};
private _spawnPosDefault = [worldSize - 1000,worldSize,0];
private _reinforceGroup = grpNull;
private _infTypes = [];
private _buildingPositions = [];
if (worldName isEqualTo 'Tanoa') then {
	_minDist = 250;
	_maxDist = 750;
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
};

/*/================================================ URBAN INSERT/*/

private _urbanUnits = [];
private _validData = [];
if (
	((missionNamespace getVariable ['QS_missionConfig_aoUrbanSpawning',1]) isEqualTo 1) &&
	{(missionNamespace getVariable ['QS_ao_urbanSpawn',FALSE])} &&
	{((random 1) > 0.5)} &&
	{
		_validData = ((missionNamespace getVariable 'QS_ao_urbanSpawn_data') select {
			(alive (_x # 0)) && 
			{(alive (_x # 1))} &&
			{((_allPlayers inAreaArray [(_x # 0),75,75,0,FALSE]) isEqualTo [])} &&
			{((count (_unitsEast inAreaArray [(_x # 0),25,25,0,FALSE])) <= 12)}
		});
		(_validData isNotEqualTo [])
	}
) then {
	_urbanUnits = ['REINFORCE',_validData,_allPlayers] call (missionNamespace getVariable 'QS_fnc_aoUrbanSpawn');
};
if (_urbanUnits isNotEqualTo []) exitWith {
	_QS_array = missionNamespace getVariable ['QS_enemyGroundReinforceArray',[]];
	{
		_QS_array pushBack _x;
	} forEach _urbanUnits;
	missionNamespace setVariable ['QS_enemyGroundReinforceArray',_QS_array,FALSE];
	_urbanUnits;
};

/*/================================================ HQ INSERT/*/

private _spawnedAtHQ = FALSE;
private _hqUnits = [];
_hqEnemies = _unitsEast inAreaArray [(missionNamespace getVariable 'QS_hqPos'),50,50,0,FALSE];
if (
	((random 1) > 0.666) &&
	{((count _hqEnemies) > 1)} &&
	{((count _hqEnemies) <= 12)} &&
	{((_allPlayers inAreaArray [(missionNamespace getVariable 'QS_hqPos'),200,200,0,FALSE]) isEqualTo [])}
) then {
	_hqUnits = ['HQ',_allPlayers] call (missionNamespace getVariable 'QS_fnc_aoUrbanSpawn');
};
if (_hqUnits isNotEqualTo []) exitWith {
	_QS_array = missionNamespace getVariable 'QS_enemyGroundReinforceArray';
	{
		_QS_array pushBack _x;
	} forEach _hqUnits;
	missionNamespace setVariable ['QS_enemyGroundReinforceArray',_QS_array,FALSE];
	_hqUnits;
};

/*/================================================ HELI INSERT/*/

private _heliInsert = FALSE;
if (
	(diag_fps > 14) &&
	{((random 1) > 0.666)} &&
	{(_allPlayers isNotEqualTo [])} &&
	{(missionNamespace getVariable ['QS_AI_insertHeli_enabled',FALSE])} &&
	{(({(alive _x)} count (missionNamespace getVariable ['QS_AI_insertHeli_helis',[]])) < (missionNamespace getVariable ['QS_AI_insertHeli_maxHelis',3]))} &&
	{(diag_tickTime > ((missionNamespace getVariable ['QS_AI_insertHeli_lastEvent',-1]) + (missionNamespace getVariable ['QS_AI_insertHeli_cooldown',480])))} &&
	{((missionNamespace getVariable ['QS_AI_insertHeli_spawnedAO',0]) < (missionNamespace getVariable ['QS_AI_insertHeli_maxAO',3]))} &&
	{(([4,EAST,_aoPos,2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) < 2)} &&
	{(([3,EAST,_aoPos,2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) < 2)}
) exitWith {
	missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',((missionNamespace getVariable 'QS_AI_insertHeli_spawnedAO') + 1),FALSE];
	missionNamespace setVariable ['QS_AI_insertHeli_lastEvent',diag_tickTime,FALSE];
	_heliInsert = TRUE;
	[
		_hqPos,
		EAST,
		['classic_reinforcehelitransport_1'] call QS_data_listVehicles,
		0.75,
		[],
		(((random 1) > 0.85) && ((count _allPlayers) > 10)),
		['classic_reinforceheliescort_1'] call QS_data_listVehicles,
		[],
		FALSE
	] spawn (missionNamespace getVariable 'QS_fnc_AIXHeliInsert');
	[]
};

/*/================================================ CONVENTIONAL INSERT/*/

/*/==================== FIND POSITION/*/

_worldName = worldName;
private _base = markerPos 'QS_marker_base_marker';
for '_x' from 0 to 999 step 1 do {
	_spawnPosDefault = [_pos,_minDist,_maxDist,2,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if (
		(_spawnPosDefault isNotEqualTo []) &&
		{((_allPlayers inAreaArray [_spawnPosDefault,300,300,0,FALSE]) isEqualTo [])} &&
		{((_spawnPosDefault distance2D _base) > 1200)} &&
		{(_spawnPosDefault call _fn_blacklist)} &&
		{(!([_spawnPosDefault,_pos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')))}
	) exitWith {};
};
if (!(_heliInsert)) then {
	_infTypes = ['classic_reinforcearray_1'] call QS_data_listUnits;
	if (_worldName isEqualTo 'Stratis') then {
		_infTypes = ['classic_reinforcearray_stratis'] call QS_data_listUnits;
	};
	_reinforceGroup = [_spawnPosDefault,(random 360),EAST,(selectRandomWeighted _infTypes),FALSE,grpNull,TRUE,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
};
_reinforceGroup setSpeedMode 'FULL';
_reinforceGroup setBehaviour 'AWARE';
private _buildings = nearestObjects [_hqPos,['Building','House'],50,TRUE] select {!isObjectHidden _x};
private _building = objNull;
_buildings = _buildings + ((allSimpleObjects []) inAreaArray [_hqPos,50,50,0,FALSE]);
private _arrayPositions = [];
_buildings = _buildings call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
{
	_building = _x;
	_buildingPositions = _building buildingPos -1;
	_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (_buildingPositions isNotEqualTo []) then {
		{
			0 = _arrayPositions pushBack _x;
		} forEach _buildingPositions;
	};
} forEach _buildings;
private _attackPosition = _hqPos;
private _attackType = 'ATTACK_2';	// 'ATTACK'
if (_arrayPositions isNotEqualTo []) then {
	_attackPosition = (selectRandom _arrayPositions) vectorAdd [0,0,1];
	_attackType = 'ATTACK_2';
};
if ((random 1) > 0.75) then {
	{
		_reinforceGroup setVariable _x;	
	} forEach [
		['QS_AI_GRP',TRUE,QS_system_AI_owners],
		['QS_AI_GRP_TASK',[_attackType,_attackPosition,serverTime,-1],QS_system_AI_owners],
		['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _reinforceGroup))],QS_system_AI_owners],
		['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners],
		['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners]
	];
} else {
	private _radialIncrement = 120;								// 45
	private _radialStart = round (random 360);
	_radialOffset = 150 * (0.75 + (random 0.4));				// 100
	private _radialPatrolPositions = [];
	private _patrolPosition = _hqPos getPos [_radialOffset,_radialStart];
	if (!surfaceIsWater _patrolPosition) then {
		_radialPatrolPositions pushBack _patrolPosition;
	};
	for '_x' from 0 to 2 step 1 do {							// 0 to 6
		_radialStart = _radialStart + _radialIncrement;
		_patrolPosition = _hqPos getPos [_radialOffset,_radialStart];
		if (!surfaceIsWater _patrolPosition) then {
			_radialPatrolPositions pushBack _patrolPosition;
		};
	};
	if (_radialPatrolPositions isNotEqualTo []) then {
		_radialPatrolPositions = _radialPatrolPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		//comment 'Initial movement';
		if (!(_heliInsert)) then {
			_reinforceGroup move (_radialPatrolPositions # 0);
			_reinforceGroup setFormDir (_spawnPosDefault getDir (_radialPatrolPositions # 0));
		};
	};
	// Forest positions
	_forestPositions = (missionNamespace getVariable 'QS_classic_terrainData') # 8;
	if (_forestPositions isNotEqualTo []) then {
		_radialPatrolPositions pushBack (selectRandom _forestPositions);
	};
	// Urban positions
	_nearHousesInArea = (missionNamespace getVariable 'QS_classic_terrainData') # 4;
	if ((count _nearHousesInArea) >= 5) then {
		_radialPatrolPositions pushBack ((getPosATL (selectRandom _nearHousesInArea)) vectorAdd [0,0,1]);
	};
	private _aoRadialPositions = (missionNamespace getVariable 'QS_classic_terrainData') # 11;
	if ((random 1) > 0.5) then {
		if ((random 1) > 0.5) then {
			reverse _aoRadialPositions;
		};
		_reinforceGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_aoRadialPositions,serverTime,-1],FALSE];
		_reinforceGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
	} else {
		if ((random 1) > 0.5) then {
			reverse _radialPatrolPositions;
		};
		_reinforceGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,serverTime,-1],FALSE];
		_reinforceGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
	};
	{
		_reinforceGroup setVariable _x;	
	} forEach [
		['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _reinforceGroup))],FALSE],
		['QS_AI_GRP_DATA',[],FALSE],
		['QS_AI_GRP',TRUE,FALSE],
		['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners]
	];
};
[(units _reinforceGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_QS_array = missionNamespace getVariable 'QS_enemyGroundReinforceArray';
{
	_QS_array pushBack _x;
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
	//_x enableAIFeature ['AUTOCOMBAT',FALSE];
	if ((random 1) > 0.5) then {
		_x enableAIFeature ['COVER',FALSE];
	};
	if (!(_heliInsert)) then {
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
	};
	[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
} forEach (units _reinforceGroup);
if (!(_heliInsert)) then {
	_reinforceGroup move _hqPos;
};
missionNamespace setVariable ['QS_enemyGroundReinforceArray',_QS_array,FALSE];
_reinforceGroup enableAttack TRUE;
(units _reinforceGroup);