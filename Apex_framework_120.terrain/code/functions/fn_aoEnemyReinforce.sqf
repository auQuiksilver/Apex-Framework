/*/
File: fn_aoEnemyReinforce.sqf
Author:

	Quiksilver
	
Last modified:

	23/04/2019 A3 1.90 by Quiksilver
	
Description:

	Enemy reinforce AO
__________________________________________________/*/

params ['_pos'];
private [
	'_base','_foundSpawnPos','_spawnPosDefault','_reinforceGroup','_infTypes','_infType',
	'_destination','_count','_wp','_playerSelected','_arr','_playerPos','_ticker','_attackPos','_QS_array',
	'_minDist','_maxDist','_fn_blacklist','_hqPos','_buildings','_arrayPositions','_building','_buildingPositions',
	'_attackType','_attackPosition'
];
_QS_array = [];
_hqPos = (missionNamespace getVariable 'QS_HQpos');
if (worldName isEqualTo 'Tanoa') then {
	_minDist = 250;
	_maxDist = 750;
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
	_minDist = 300;
	_maxDist = 800;
	_fn_blacklist = {TRUE};
};

/*/================================================ FIND POSITION/*/

_worldName = worldName;
_base = markerPos 'QS_marker_base_marker';
_foundSpawnPos = FALSE;
for '_x' from 0 to 1 step 0 do {
	_spawnPosDefault = [_pos,_minDist,_maxDist,2,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if (_spawnPosDefault isNotEqualTo []) then {
		if ((allPlayers inAreaArray [_spawnPosDefault,300,300,0,FALSE]) isEqualTo []) then {
			if ((_spawnPosDefault distance2D _base) > 1200) then {
				if (_spawnPosDefault call _fn_blacklist) then {
					if (!([_spawnPosDefault,_pos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
						_foundSpawnPos = TRUE;
					};
				};
			};
		};
	};
	if (_foundSpawnPos) exitWith {};
};

/*/================================================ MANAGE UNITS/*/

private _heliInsert = FALSE;
if (diag_fps > 14) then {
	if (allPlayers isNotEqualTo []) then {
		if ((random 1) > 0.6) then {
			if (missionNamespace getVariable ['QS_AI_insertHeli_enabled',FALSE]) then {
				if (({(alive _x)} count (missionNamespace getVariable ['QS_AI_insertHeli_helis',[]])) < (missionNamespace getVariable ['QS_AI_insertHeli_maxHelis',3])) then {
					if (diag_tickTime > ((missionNamespace getVariable ['QS_AI_insertHeli_lastEvent',-1]) + (missionNamespace getVariable ['QS_AI_insertHeli_cooldown',480]))) then {
						if ((missionNamespace getVariable ['QS_AI_insertHeli_spawnedAO',0]) < (missionNamespace getVariable ['QS_AI_insertHeli_maxAO',3])) then {
							if (([4,EAST,(missionNamespace getVariable 'QS_aoPos'),2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) < 2) then {
								if (([3,EAST,(missionNamespace getVariable 'QS_aoPos'),2000] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) < 2) then {
									missionNamespace setVariable ['QS_AI_insertHeli_spawnedAO',((missionNamespace getVariable 'QS_AI_insertHeli_spawnedAO') + 1),FALSE];
									missionNamespace setVariable ['QS_AI_insertHeli_lastEvent',diag_tickTime,FALSE];
									_heliInsert = TRUE;
									_infTypes = [['OIA_InfSquad','OIA_InfAssault'],['OIA_InfSquad','OIA_InfAssault']] select (_worldName isEqualTo 'Altis');
									_infType = selectRandom _infTypes;
									_reinforceGroup = [_spawnPosDefault,(random 360),EAST,_infType,FALSE,grpNull,TRUE,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
									_reinforceGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
									[
										_hqPos,
										EAST,
										(['O_Heli_Transport_04_covered_F','O_Heli_Transport_04_covered_black_F'] select (_worldName isEqualTo 'Tanoa')),
										0.75,
										[],
										(((random 1) > 0.85) && ((count allPlayers) > 10)),
										(['O_Heli_Attack_02_dynamicLoadout_F','O_Heli_Attack_02_dynamicLoadout_black_F'] select (_worldName isEqualTo 'Tanoa')),
										(units _reinforceGroup),
										FALSE
									] spawn (missionNamespace getVariable 'QS_fnc_AIXHeliInsert');
								};
							};
						};
					};
				};
			};
		};
	};
};
if (!(_heliInsert)) then {
	_infTypes = [
		[
			'OIA_InfSquad',1,
			'OIA_InfTeam',1,
			'OI_reconPatrol',1,
			'OIA_InfAssault',1,
			'OG_InfSquad',1,
			'OG_InfAssaultTeam',1,
			'OIA_ARTeam',1,
			'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 3),
			'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
			'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 3)
		],
		[
			'OIA_InfSquad',1,
			'OIA_InfTeam',1,
			'OI_reconPatrol',1,
			'OIA_InfAssault',1,
			'OG_InfSquad',1,
			'OG_InfAssaultTeam',1,
			'OIA_ARTeam',1,
			'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 3),
			'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
			'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 3)
		]
	] select (_worldName isEqualTo 'Altis');
	_reinforceGroup = [_spawnPosDefault,(random 360),EAST,(selectRandomWeighted _infTypes),FALSE,grpNull,TRUE,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
};
_reinforceGroup setSpeedMode 'FULL';
_reinforceGroup setBehaviourStrong 'AWARE';
_buildings = nearestObjects [_hqPos,['Building','House'],50,TRUE];
_buildings = _buildings + ((allSimpleObjects []) select {((_x distance2D _hqPos) <= 50)});
_arrayPositions = [];
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
_attackPosition = _hqPos;
_attackType = 'ATTACK_2';	// 'ATTACK'
if (_arrayPositions isNotEqualTo []) then {
	_arrayPositions = _arrayPositions apply {[(_x select 0),(_x select 1),((_x select 2) + 1)]};
	_attackPosition = _arrayPositions;
	_attackType = 'ATTACK_2';
};
if ((random 1) > 0.5) then {
	_reinforceGroup setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_reinforceGroup setVariable ['QS_AI_GRP_TASK',[_attackType,_attackPosition,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_reinforceGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _reinforceGroup))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_reinforceGroup setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	_reinforceGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
} else {
	private _radialIncrement = 45;
	private _radialStart = round (random 360);
	_radialOffset = 100 * (0.75 + (random 0.4));
	private _radialPatrolPositions = [];
	private _patrolPosition = _hqPos getPos [_radialOffset,_radialStart];
	if (!surfaceIsWater _patrolPosition) then {
		_radialPatrolPositions pushBack _patrolPosition;
	};
	for '_x' from 0 to 6 step 1 do {
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
			_reinforceGroup move (_radialPatrolPositions select 0);
			_reinforceGroup setFormDir (_spawnPosDefault getDir (_radialPatrolPositions select 0));
		};
	};
	_reinforceGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _reinforceGroup))],FALSE];
	_reinforceGroup setVariable ['QS_AI_GRP_DATA',[],FALSE];
	_reinforceGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,diag_tickTime,-1],FALSE];
	_reinforceGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,FALSE];
	_reinforceGroup setVariable ['QS_AI_GRP',TRUE,FALSE];
	_reinforceGroup setVariable ['QS_GRP_HC',TRUE,FALSE];
};
[(units _reinforceGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_QS_array = missionNamespace getVariable 'QS_enemyGroundReinforceArray';
{
	0 = _QS_array pushBack _x;
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
	_x disableAI 'AUTOCOMBAT';
	if ((random 1) > 0.5) then {
		_x disableAI 'COVER';
		_x disableAI 'SUPPRESSION';
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
if ((random 1) > 0.5) then {
	_reinforceGroup enableAttack TRUE;
} else {
	_reinforceGroup enableAttack FALSE;
};
(units _reinforceGroup);