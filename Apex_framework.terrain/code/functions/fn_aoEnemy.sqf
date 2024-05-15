/*/
File: fn_aoEnemy.sqf
Author:

	Quiksilver
	
Last modified:

	22/08/2022 A3 2.10 by Quiksilver
	
Description:

	AO Enemies
______________________________________________/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy START *****';
diag_log '****************************************************';
params ['_pos','_isHCEnabled','_aoData'];
private _terrainData = missionNamespace getVariable ['QS_classic_terrainData',[ [],[],[],[],[],[],[],[],[],[],[],[] ] ];
private _enemiesArray = [];
private _playerCount = count allPlayers;
private _randomPos = missionNamespace getVariable 'QS_aoPos';
private _aoPos = missionNamespace getVariable 'QS_aoPos';
private _playerThreshold = round (random [15,20,25]);
private _QS_new = FALSE;
private _isArmedAirEnabled = missionNamespace getVariable ['QS_armedAirEnabled',TRUE];
private _unit = objNull;
private _unit1 = objNull;
private _unit2 = objNull;
private _unit3 = objNull;
private _skill = 1;
private _dirToCenter = 0;
private _infTypes = ['classic_enemyinftypes_1'] call QS_data_listUnits;
if (worldName isEqualTo 'Stratis') then {
	_infTypes = ['classic_enemyinftypes_stratis_1'] call QS_data_listUnits;
};
private _infUrbanType = '';
private _infUrbanTypes = ['classic_enemygarrisontypes_1'] call QS_data_listUnits;
if (worldName isEqualTo 'Stratis') then {
	_infUrbanTypes = ['classic_enemygarrisontypes_stratis_1'] call QS_data_listUnits;
};
private _officerType = ['classic_enemyofficertype_1'] call QS_data_listUnits;
private _basePos = markerPos 'QS_marker_base_marker';
private _aoSize = missionNamespace getVariable ['QS_aoSize',750];
if (worldName isEqualTo 'Stratis') then {
	_aoSize = 350 * 1.3;
};
private _QS_HQpos = missionNamespace getVariable 'QS_HQpos';
if (worldName isEqualTo 'Stratis') then {
	_QS_HQpos = missionNamespace getVariable 'QS_aoPos';
	(missionNamespace getVariable ['QS_registeredPositions',[]]) pushBack _QS_HQpos;
};
private _centerPos = _pos;
private _centerRadius = _aoSize;
private _radialPositions_outer = _terrainData # 10;
private _radialPositions_outer2 = _radialPositions_outer;
private _radialPositions_inner = _terrainData # 11;
private _radialPositions_inner2 = _radialPositions_inner;
private _roadPositionsValid = (((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply {(getPosATL _x)};
private _allowVehicles = (count (_terrainData # 1)) > 40;
private _registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
private _buildingPositionsInArea = _terrainData # 6;
private _manyBuildingPositions = (count _buildingPositionsInArea) > 65;		// 100
if (_allowVehicles) then {
	_roadPositionsValid = _roadPositionsValid call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
diag_log format ['***** AO ENEMY * NEAR ROADS COUNT: %1 *****',(count _roadPositionsValid)];

/*/=============================================================== AA VEHICLE/*/

private _aaArray = [];
if (_playerCount > 0) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning Fortified AA *****';
	diag_log '****************************************************';
	private _aaCount = [1,2] select (_playerCount > 10);
	for '_x' from 1 to _aaCount step 1 do {
		_aaArray = [_centerPos] call (missionNamespace getVariable 'QS_fnc_aoFortifiedAA');
		if (_aaArray isNotEqualTo []) then {
			{
				_enemiesArray pushBack _x;
			} forEach _aaArray;
		};
	};
};

/*/=============================================================== INFANTRY PATROLS RANDOM/*/
	
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning infantry patrols *****';
diag_log '****************************************************';
private _grpCount = 5;
if (_playerCount > 10) then {_grpCount = [8,6] select _allowVehicles;};
if (_playerCount > 20) then {_grpCount = [9,7] select _allowVehicles;};
if (_playerCount > 30) then {_grpCount = [10,8] select _allowVehicles;};
if (_playerCount > 40) then {_grpCount = [11,8] select _allowVehicles;};
if (_playerCount > 50) then {_grpCount = [12,9] select _allowVehicles;};
if (worldName isEqualTo 'Altis') then {
	if (_playerCount > 10) then {_grpCount = [8,6] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [9,7] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [11,9] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [12,10] select _allowVehicles;};
};
if (worldName in ['Tanoa']) then {
	if (_playerCount > 10) then {_grpCount = [8,6] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [9,7] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [10,8] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [11,9] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [12,10] select _allowVehicles;};
};
if (worldName isEqualTo 'Malden') then {
	if (_playerCount > 10) then {_grpCount = [7,5] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [8,5] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [8,6] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [8,7] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [9,8] select _allowVehicles;};
};
if (worldName isEqualTo 'Stratis') then {
	if (_playerCount > 10) then {_grpCount = [6,5] select _allowVehicles;};
	if (_playerCount > 20) then {_grpCount = [6,5] select _allowVehicles;};
	if (_playerCount > 30) then {_grpCount = [7,6] select _allowVehicles;};
	if (_playerCount > 40) then {_grpCount = [9,8] select _allowVehicles;};
	if (_playerCount > 50) then {_grpCount = [9,8] select _allowVehicles;};
};
_placeTypes = [
	'(1 + houses)',2,
	'(1 + forest)',1,
	'(1 + forest) * (1 + houses)',1,
	'(1 + meadow)',1
];
private _placeType = '';
private _patrolRoute = [];
private _forestPositions = _terrainData # 8;
private _nearForestPositions = [];
private _nearForestPosition = [0,0,0];
private _forestPositionIndex = -1;
private _patrolGroup = grpNull;
private _bestPlaces = [];
_registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
for '_x' from 0 to (_grpCount - 1) step 1 do {
	if ((random 1) > 0.5) then {
		_bestPlaces = [];
	} else {
		_bestPlaces = [_centerPos,_aoSize,(selectRandomWeighted _placeTypes),15,3];
	};
	_randomPos = ['RADIUS',_centerPos,([_aoSize,_aoSize * 0.85] select ((random 1) > 0.5)),'LAND',[1.5,-1,0.5,3,0,FALSE,objNull],TRUE,_bestPlaces,[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_randomPos distance2D _centerPos) < (_aoSize * 1.5)) then {
		_patrolGroup = [_randomPos,(random 360),EAST,(selectRandomWeighted _infTypes),FALSE,grpNull,TRUE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		[_patrolGroup,_randomPos,200,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');		//125
		[(units _patrolGroup),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			_x setVehiclePosition [(getPosWorld _x), [], 0, 'CAN_COLLIDE'];
			_enemiesArray pushBack _x;
		} forEach (units _patrolGroup);
		_patrolRoute = (_patrolGroup getVariable 'QS_AI_GRP_TASK') # 1;
		if (_registeredPositions isNotEqualTo []) then {
			_patrolRoute pushBack ((selectRandom _registeredPositions) getPos [(30 + (random 30)),random 360]);
		};
		if (_manyBuildingPositions) then {
			_patrolRoute pushBack (selectRandom _buildingPositionsInArea);
		};
		_nearForestPositions = _forestPositions inAreaArray [_randomPos,_aoSize,_aoSize,0,FALSE];
		if (_nearForestPositions isNotEqualTo []) then {
			_nearForestPositions = _nearForestPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			for '_iii' from 0 to 1 step 1 do {
				_nearForestPosition = selectRandom _nearForestPositions;
				/*/
				_forestPositionIndex = _forestPositions find _nearForestPosition;
				_forestPositions set [_forestPositionIndex,FALSE];
				_forestPositions deleteAt _forestPositionIndex;
				/*/
				_patrolRoute pushBack _nearForestPosition;
			};
			_patrolRoute = _patrolRoute call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_patrolGroup setVariable ['QS_AI_GRP_TASK',[((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 0),_patrolRoute,((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 2),((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 3)],QS_system_AI_owners];
		};
		if ((random 1) > 0.75) then {
			//if (!(_usedRadialPatrol)) then {
				//_usedRadialPatrol = TRUE;
				if (_radialPositions_outer2 isNotEqualTo []) then {
					_patrolGroup setVariable ['QS_AI_GRP_TASK',[((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 0),_radialPositions_outer2,((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 2),((_patrolGroup getVariable 'QS_AI_GRP_TASK') # 3)],QS_system_AI_owners];		
					reverse _radialPositions_outer2;
				};
			//};
		} else {
			if ((count _radialPositions_outer2) > 2) then {
				_patrolRoute pushBack (selectRandom _radialPositions_outer2);
				_patrolRoute = _patrolRoute call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			};
		};
		_patrolGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_patrolGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _patrolGroup))],QS_system_AI_owners];
		_patrolGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_patrolGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	} else {
		diag_log format ['***** AO ENEMY * INFANTRY PATROL INVALID POSITION * %1 *****',_randomPos];
	};
};

/*/=============================================================== STATIC WEAPONS/*/
private _staticChance = 0;
if (worldName in ['Stratis']) then {
	_staticChance = 0.666;
};
if ((random 1) > _staticChance) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning static weapons *****';
	diag_log '****************************************************';
	_registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
	private _usedSettlementPosition = FALSE;
	private _dir = 0;
	private _building = objNull;
	if (missionNamespace getVariable ['QS_ao_terrainIsSettlement',FALSE]) then {
		if ((random 1) > 0.5) then {
			if ((missionNamespace getVariable ['QS_ao_objsUsedTerrainBldgs',0]) <= 2) then {
				_buildingTypes = missionNamespace getVariable ['QS_data_smallBuildingTypes_10',[]];
				_buildingList = (nearestObjects [_centerPos,['House'],_aoSize * 0.9,TRUE]) select {((!isObjectHidden _x) && ((sizeOf (typeOf _x)) >= 10))};
				if (_buildingList isNotEqualTo []) then {
					_randomPos = [0,0,0];
					for '_i' from 0 to 9 step 1 do {
						_building = selectRandom _buildingList;
						_randomPos = getPosATL _building;
						_randomPos set [2,0];
						if (
							((_randomPos distance2D _QS_HQpos) > 100) && 
							((_registeredPositions inAreaArray [_randomPos,50,50,0,FALSE]) isEqualTo [])
						) exitWith {
							_usedSettlementPosition = TRUE;
							_dir = getDir _building;
							_building allowDamage FALSE;
							_building hideObjectGlobal TRUE;
							(missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _building;
						};
					};
				};
			};
		};
	};
	if (!_usedSettlementPosition) then {
		for '_x' from 0 to 99 step 1 do {
			_randomPos = ['RADIUS',_centerPos,(_aoSize * 0.85),'LAND',[5,0,0.3,5,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				((_registeredPositions inAreaArray [_randomPos,100,100,0,FALSE]) isEqualTo []) && 
				((((_randomPos select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])
			) exitWith {};
		};
	};
	_list = [
		["Land_Mil_WallBig_4m_F",[-0.354004,-0.0078125,11.045],0,270.632],
		["Land_Mil_WallBig_4m_F",[-0.0952148,0.0634766,11.082],0,0],
		["O_HMG_02_high_F",[-2.18506,-2.04688,10.4124],0,234.27],
		["O_HMG_02_high_F",[-1.84229,2.15332,10.4124],0,309.028],
		["O_HMG_02_high_F",[2.16064,1.62402,10.4124],0,42.212],
		["O_HMG_02_high_F",[1.96973,-2.24854,10.4124],0,139.225]
	];
	_tower = createVehicle ['CargoPlaftorm_01_green_F',[0,0,0]];
	if (_usedSettlementPosition) then {
		_tower setPosATL _randomPos;
		//_tower setDir _dir;
	} else {
		_tower setPosASL _randomPos;
		//_tower setDir (random 360);
	};
	missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_randomPos]),FALSE];
	_tower addEventHandler [
		'Deleted',
		{
			params ['_tower'];
			deleteVehicle (_tower getVariable ['QS_entity_assocEntities',[]]);
		}
	];
	_tower addEventHandler [
		'Killed',
		{
			params ['_tower'];
			deleteVehicle (_tower getVariable ['QS_entity_assocEntities',[]]);
		}
	];
	_tower setVectorUp [0,0,1];
	sleep 0.5;
	_enemiesArray pushBack _tower;
	private _object = objNull;
	private _offset = 5;
	private _attachPos = [0,0,0];
	_tower setVariable ['QS_entity_assocEntities',[],FALSE];
	_towerGrp = createGroup [EAST,TRUE];
	{
		_object = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI (_x # 0),(_x # 0)],[0,0,0]];
		_object allowDamage FALSE;
		_attachPos = _x # 1;
		_attachPos set [2,(_attachPos # 2) - _offset];
		[1,_object,[_tower,_attachPos]] call QS_fnc_eventAttach;
		_object setDir ((getDir _tower) + (_x # 3));
		_object spawn {sleep 1; [0,_this] call QS_fnc_eventAttach;};
		_tower setVariable ['QS_entity_assocEntities',((_tower getVariable ['QS_entity_assocEntities',[]]) + [_object]),FALSE];
		_enemiesArray pushBack _object;
		if (_object isKindOf 'StaticWeapon') then {
			if (_playerCount < 30) then {
				[_object] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
			} else {
				if ((random 1) > 0.666) then {
					[_object] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
				};
			};
			_grp = createVehicleCrew _object;
			(units _grp) joinSilent _towerGrp;
			(gunner _object) setVariable ['QS_AI_UNIT_isMG',TRUE,QS_system_AI_owners];
			(gunner _object) setVariable ['QS_AI_UNIT_enabled',TRUE,QS_system_AI_owners];
			(gunner _object) addEventHandler [
				'Hit',
				{
					params ['_unit','_source','_damage','_instigator'];
					if (!isNull _source) then {
						_unit reveal [_source,4];
						(group _unit) reveal [_source,4];
					};
					if (!isNull _instigator) then {
						_unit reveal [_instigator,4];
						(group _unit) reveal [_instigator,4];
					};
				}
			];
			(gunner _object) addEventHandler [
				'Killed',
				{
					_killed = _this # 0;
					if (!isNull _killed) then {
						if (!isNull (_killed getVariable 'QS_staticGunnerVehicle')) then {
							(_killed getVariable 'QS_staticGunnerVehicle') setDamage 1;
						};
					};
				}
			];
			_object addEventHandler [
				'GetOut',
				{
					(_this # 2) setDamage 1;
					(_this # 0) setDamage 1;
				}
			];
			_object addEventHandler [
				'Deleted',
				{
					params ['_object'];
				}
			];
			_object lock 3;
			if (
				((random 1) > 0.333) ||
				{(_playerCount < 20)}
			) then {
				_object removeWeaponTurret ['HMG_M2_Mounted',[0]];
				{
					_object addWeaponTurret _x;
				} forEach [
					['M134_minigun',[0]]
				];
				{
					_object addMagazineTurret _x;
				} forEach [
					['5000Rnd_762x51_Yellow_Belt',[0]],
					['5000Rnd_762x51_Yellow_Belt',[0]],
					['5000Rnd_762x51_Yellow_Belt',[0]],
					['5000Rnd_762x51_Yellow_Belt',[0]]
				];
			};
			_enemiesArray pushBack (gunner _object);
			(gunner _object) setVariable ['QS_staticGunnerVehicle',_object,FALSE];
			(gunner _object) enableAIFeature ['PATH',FALSE];
			(gunner _object) enableAIFeature ['COVER',FALSE];
			
			if (worldName in ['Tanoa','Enoch']) then {
				if ((call (missionNamespace getVariable 'QS_fnc_getActiveDLC')) isEqualTo '') then {
					(gunner _object) setUnitLoadout 'o_t_soldier_f';
				};
			};
			_object enableDynamicSimulation TRUE;
			(gunner _object) enableDynamicSimulation TRUE;
		} else {
			_object enableSimulationGlobal FALSE;
		};
	} forEach _list;
	[(units _towerGrp),3] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	_towerGrp setGroupIdGlobal ['HMG Tower'];
	_towerGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	_towerGrp setCombatMode 'RED';
	_towerGrp setBehaviourStrong 'COMBAT';
	_towerGrp setCombatBehaviour 'COMBAT';
	_towerGrp enableAttack TRUE;
};
_registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
/*/=============================================================== INFANTRY OVERWATCH/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning infantry overwatch *****';
diag_log '****************************************************';

_grpCount = 3;
if (_playerCount > 15) then {
	_grpCount = 4;
	if (_playerCount > 30) then {
		_grpCount = 5;
	};
};
private _overwatchGroup = grpNull;
private _towerPos3 = ATLToASL (getPosATL (missionNamespace getVariable 'QS_radioTower'));
private _centerPosASL = ATLToASL _centerPos;
private _hqPosASL = ATLToASL _QS_HQpos;
private _watchPos = selectRandom [_centerPosASL,_hqPosASL,_towerPos3];
for '_x' from 0 to _grpCount step 1 do {
	_watchPos = selectRandom [_centerPosASL,_hqPosASL,_towerPos3];
	for '_z' from 0 to 49 step 1 do {
		_randomPos = [_watchPos,(_aoSize * 0.8),25,10,[[objNull,'VIEW'],(0.1 max (random 1))]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
		if (
			(!([_randomPos,50,6] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))
		) exitWith {};
		_watchPos = selectRandom [_centerPosASL,_hqPosASL,_towerPos3];
	};
	_infUrbanType = selectRandomWeighted _infUrbanTypes;
	_overwatchGroup = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
	[(units _overwatchGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	if ((random 1) > 0.5) then {
		[_overwatchGroup,_randomPos,65,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
	} else {
		if ((random 1) > 0.8) then {
			_overwatchGroup setFormDir (random 360);
		} else {
			_overwatchGroup setFormDir (_randomPos getDir _watchPos);
		};
		{_x setUnitPos 'Middle';} count (units _overwatchGroup);
	};
	{
		_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
		[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
		0 = _enemiesArray pushBack _x;
	} count (units _overwatchGroup);
	if ((_randomPos distance2D _watchPos) < 25) then {
		if ((random 1) > 0.5) then {
			if (_radialPositions_inner2 isNotEqualTo []) then {
				_overwatchGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPositions_inner2,-1,-1],QS_system_AI_owners];
				_overwatchGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
				reverse _radialPositions_inner2;
			};
		} else {
			if (_radialPositions_outer isNotEqualTo []) then {
				_overwatchGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPositions_outer,-1,-1],QS_system_AI_owners];
				_overwatchGroup setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
			};
		};
	};
	_overwatchGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_overwatchGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _overwatchGroup))],QS_system_AI_owners];
	_overwatchGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_overwatchGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};

/*/=============================================================== GROUND VEHICLE RANDOM/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Armored Vehicles *****';
diag_log '****************************************************';

private _vehCount = [1,1] select _allowVehicles;
if (_playerCount > 10) then {
	_vehCount = [1,2] select _allowVehicles;
};
if (_playerCount > 20) then {
	_vehCount = [1,2] select _allowVehicles;
};
if (_playerCount > 30) then {
	_vehCount = [2,3] select _allowVehicles;
};
if (_playerCount > 40) then {
	_vehCount = [2,3] select _allowVehicles;
};	
if (_playerCount > 50) then {
	_vehCount = [2,3] select _allowVehicles;
};
private _motorPool = [0,7] select _allowVehicles;
if (worldName in ['Stratis']) then {
	_vehCount = _vehCount min 2;
	_motorPool = 8;
};
private _AOveh = objNull;
private _AOvehGroup = grpNull;
private _AOvehType = '';
for '_x' from 0 to (_vehCount - 1) step 1 do {
	_AOvehGroup = createGroup [EAST,TRUE];
	if (_allowVehicles) then {
		_randomPos = selectRandom _roadPositionsValid;
	} else {
		_randomPos = [_centerPos,0,_aoSize,2.5,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	};
	_AOvehType = selectRandomWeighted ([_motorPool] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
	_AOveh = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _AOvehType,_AOvehType],(_randomPos vectorAdd [0,0,0.25]),[],0,'NONE'];
	_AOveh allowDamage FALSE;
	_AOveh limitSpeed (random [30,40,50]);
	(missionNamespace getVariable 'QS_AI_vehicles') pushBack _AOveh;
	clearMagazineCargoGlobal _AOveh;
	clearWeaponCargoGlobal _AOveh;
	clearItemCargoGlobal _AOveh;
	clearBackpackCargoGlobal _AOveh;
	_AOveh setUnloadInCombat [TRUE,FALSE];
	[0,_AOveh,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
	_AOveh addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
	_AOveh enableRopeAttach FALSE;
	_AOveh enableVehicleCargo FALSE;
	if (random 1 >= 0.25) then {_AOveh allowCrewInImmobile [TRUE,TRUE];};
	/*/_AOveh forceFollowRoad TRUE;/*/
	_AOveh setConvoySeparation 50;
	[_AOveh] spawn {sleep 2.5; (_this # 0) allowDamage TRUE;};
	_AOveh setVectorUp (surfaceNormal _randomPos);
	if (_playerCount < 30) then {
		[_AOveh] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
	} else {
		if ((random 1) > 0.5) then {
			[_AOveh] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
		};
	};
	_AOveh addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
	(units (createVehicleCrew _AOveh)) joinSilent _AOvehGroup;
	_AOvehGroup addVehicle _AOveh;
	[_AOvehGroup,_randomPos,_aoSize,_roadPositionsValid,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
	_AOveh lock 3;
	_skill = 1;
	if (_AOveh isKindOf 'mbt_04_base_f') then {
		_skill = 3;
	} else {
		if (_playerCount < 20) then {
			_skill = 1;
		} else {
			_skill = 2;
		};
	};
	[(units _AOvehGroup),_skill] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	
	if ((random 1) > 0.5) then {
		if (
			(alive (commander _AOveh)) &&
			(alive (gunner _AOveh))
		) then {
			_AOveh deleteVehicleCrew (commander _AOveh);
		};
	};
	
	{
		_x setVariable ['BIS_noCoreConversations',TRUE,FALSE];
		0 = _enemiesArray pushBack _x;
	} count (units _AOvehGroup);
	_unit2 setSkill ['aimingAccuracy',0.1];
	_AOvehGroup allowFleeing 0;
	_enemiesArray pushBack _AOveh;
	_AOvehGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_AOvehGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _AOvehGroup)),_AOveh],QS_system_AI_owners];
	_AOvehGroup setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
};

/*/===== Spawning Support vehicle/*/

if (_allowVehicles) then {
	private _supportData = [];
	private _supportEntities = [];
	private _supportElement = [];
	private _supportEntity = objNull;
	_supportData pushBack ['REPAIR',TRUE,[_roadPositionsValid]];
	if ((random 1) > 0.5) then {
		_supportData pushBack ['MEDICAL',TRUE,[_roadPositionsValid]];
	};
	{
		_supportElement = _x;
		_supportEntities = _supportElement call (missionNamespace getVariable 'QS_fnc_spawnSupport');
		{
			_supportEntity = _x;
			_enemiesArray pushBack _supportEntity;
		} forEach _supportEntities;
	} forEach _supportData;
};

/*/=============================================================== SNIPERS/*/

if (
	(_playerCount > 10) ||
	{((_playerCount <= 10) && ((random 1) > 0.8))}
) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning Snipers *****';
	diag_log '****************************************************';
	private _sniperGroup = grpNull;
	private _towerPos = getPosATL (missionNamespace getVariable 'QS_radioTower');
	for '_x' from 0 to ([1,2] select (_playerCount > 30)) step 1 do {
		private _watchPos = selectRandom [(ATLToASL _towerPos),(AGLToASL _QS_HQpos)];
		_randomPos = [_watchPos,(_aoSize * 1.25),(_aoSize * 0.5),10,[[objNull,'VIEW'],0.75]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
		_sniperGroup = [_randomPos,(random 360),EAST,'OI_SniperTeam_2',FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		_sniperGroup setCombatMode 'RED';
		_sniperGroup setBehaviourStrong 'STEALTH';
		[(units _sniperGroup),(selectRandom [3,4])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_sniperGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		_dirToCenter = _randomPos getDir _watchPos;
		_sniperGroup setFormDir _dirToCenter;
		{
			_x setUnitPos (['Middle','Down'] select (_playerCount > 10));
		} forEach (units _sniperGroup);
		{
			_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
			_x doWatch (ASLToAGL _watchPos); 
			0 = _enemiesArray pushBack _x;
		} count (units _sniperGroup);
	};
};

/*/=============================================================== AO MORTAR PIT/*/

private _mortarChance = (random 1) > 0.5;
if (worldName isEqualTo 'Stratis') then {
	_mortarChance = _mortarChance && (_playerCount > 15);
};
if (_mortarChance) then {
	diag_log '****************************************************';
	diag_log '***** AO ENEMY ***** Spawning Mortar Pit *****';
	diag_log '****************************************************';
	private _mortarPit = [_centerPos] call (missionNamespace getVariable 'QS_fnc_aoMortarPit');
	if (_mortarPit isNotEqualTo []) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _mortarPit;
	};
};

/*/=============================================================== ENEMIES IN BUILDINGS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Enemies in buildings *';
diag_log '****************************************************';
private _AOgarrisonGroup = grpNull;
private _toGarrison = [];
private _indArray = ['classic_garrisonindarray_1'] call QS_data_listUnits;
private _randomUnit = '';
if ((count (_terrainData # 4)) > 6) then {
	if (worldName in ['Tanoa','Enoch']) then {
		_indArray = ['classic_garrisonindarray_2'] call QS_data_listUnits;
	};
	_AOgarrisonGroup = createGroup [RESISTANCE,TRUE];
	for '_x' from 0 to ([29,14] select (missionNamespace getVariable ['QS_ao_urbanSpawn',FALSE])) step 1 do {
		_randomUnit = selectRandom _indArray;
		_unit = _AOgarrisonGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _randomUnit,_randomUnit],_centerPos,[],100,'NONE'];
		_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_enemiesArray pushBack _unit;
		_toGarrison pushBack _unit;
	};
	_AOgarrisonGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	[_toGarrison,2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
};
_QS_HQpos set [2,0];
private _resistanceGrp = createGroup [RESISTANCE,TRUE];
_unit = _resistanceGrp createUnit [QS_core_units_map getOrDefault ['i_c_soldier_para_1_f','i_c_soldier_para_1_f'],_QS_HQpos,[],10,'NONE'];
_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
_enemiesArray pushBack _unit;
_toGarrison pushBack _unit;
if (_toGarrison isNotEqualTo []) then {
	[_centerPos,(_aoSize * 0.9),_toGarrison,['House']] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
	_toGarrison joinSilent _resistanceGrp;
};
_resistanceGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];

/*/=============================================================== ENEMIES IN HQ BUILDINGS/*/
_indArray = ['classic_garrisonindarray_3'] call QS_data_listUnits;
private _AOgarrisonGroup2 = createGroup [RESISTANCE,TRUE];
_toGarrison = [];
for '_x' from 0 to 8 step 1 do {
	_randomUnit = selectRandom _indArray;
	_unit = _AOgarrisonGroup2 createUnit [QS_core_units_map getOrDefault [toLowerANSI _randomUnit,_randomUnit],_QS_HQpos,[],0,'NONE'];
	_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_enemiesArray pushBack _unit;
	_toGarrison pushBack _unit;
};
[_QS_HQpos,60,_toGarrison,[]] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[_toGarrison,2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_AOgarrisonGroup2 setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
{
	_x setDamage 0;
} forEach _toGarrison;

/*/=============================================================== BOAT PATROL/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning Boat Patrol *****';
diag_log '****************************************************';
if (((missionNamespace getVariable ['QS_classic_AOData',[]]) # 4) isEqualTo 1) then {
	private _boatArray = [(missionNamespace getVariable 'QS_AOpos')] call (missionNamespace getVariable 'QS_fnc_aoBoatPatrol');
	if (_boatArray isNotEqualTo []) then {
		{
			0 = _enemiesArray pushBack _x;
		} count _boatArray;
	};
};

/*/=============================================================== HQ GUARDS/*/

diag_log '****************************************************';
diag_log '***** AO ENEMY ***** Spawning HQ Guards *****';
diag_log '****************************************************';

_randomPos = [_QS_HQpos,0,150,1,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
_infUrbanType = selectRandomWeighted _infUrbanTypes;
private _hqGroup1 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup1,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup1),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup1 setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_hqGroup1 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup1))],QS_system_AI_owners];
_hqGroup1 setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_hqGroup1 setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	_x setVehiclePosition [(getPosWorld _x),[],0,'CAN_COLLIDE'];
	0 = _enemiesArray pushBack _x;
} forEach (units _hqGroup1);
_infUrbanType = selectRandomWeighted _infUrbanTypes;
//_randomPos = ['RADIUS',_QS_HQpos,150,'LAND',[],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_randomPos = [_QS_HQpos,0,150,1,0,0.4,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
private _hqGroup2 = [_randomPos,(random 360),EAST,_infUrbanType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
[_hqGroup2,_QS_HQpos,70,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
[(units _hqGroup2),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_hqGroup2 setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_hqGroup2 setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _hqGroup2))],QS_system_AI_owners];
_hqGroup2 setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
_hqGroup2 setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
{
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
	0 = _enemiesArray pushBack _x;
} forEach (units _hqGroup2);
private _commandGrp = createGroup [EAST,TRUE];
_commandGrp setGroupIdGlobal ['Command'];
_commandGrp setVariable ['QS_dynSim_ignore',TRUE,QS_system_AI_owners];
_commandGrp enableDynamicSimulation FALSE;
private _commander = _commandGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _officerType,_officerType],_QS_HQpos,[],0,'NONE'];
{
	missionNamespace setVariable _x;
} forEach [
	['csatHQGroup',_commandGrp,FALSE],
	['QS_csatCommander',_commander,TRUE],
	['QS_commanderAlive',TRUE,FALSE]
];
_commander setVariable ['QS_surrenderable',TRUE,TRUE];
_commander allowDamage FALSE;
_commander enableStamina FALSE;
_commander enableFatigue FALSE;
_commander setVariable ['QS_dynSim_ignore',TRUE,QS_system_AI_owners];
if ((call (missionNamespace getVariable 'QS_fnc_getActiveDLC')) isEqualTo '') then {
	private _headgear = ['H_Beret_blk','H_Beret_CSAT_01_F'] select ((random 1) > 0.9);
	private _loadouts = [
		[
			[["sgun_HunterShotgun_01_sawedoff_F","","","",["2Rnd_12Gauge_Pellets",2],[],""],[],[],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["Chemlight_red",1,1],["2Rnd_12Gauge_Pellets",4,2]]],["V_LegStrapBag_coyote_F",[["FirstAidKit",1],["2Rnd_12Gauge_Slug",5,2],["2Rnd_12Gauge_Pellets",5,2]]],["B_RadioBag_01_hex_F",[["2Rnd_12Gauge_Pellets",7,2],["2Rnd_12Gauge_Slug",5,2]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["Chemlight_red",1,1],["30Rnd_545x39_Mag_Tracer_F",3,30]]],["V_LegStrapBag_coyote_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_Tracer_F",9,30]]],["B_RadioBag_01_hex_F",[["30Rnd_545x39_Mag_Tracer_F",8,30],["SmokeShellRed",3,1]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["SMG_03C_TR_black","muzzle_snds_570","","optic_Nightstalker",["50Rnd_570x28_SMG_03",50],[],""],[],[],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["Chemlight_red",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_LegStrapBag_coyote_F",[["FirstAidKit",1],["50Rnd_570x28_SMG_03",5,50]]],["B_RadioBag_01_hex_F",[["SmokeShellRed",3,1],["50Rnd_570x28_SMG_03",5,50]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["SMG_05_F","muzzle_snds_L","","optic_Nightstalker",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],[],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["Chemlight_red",1,1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",3,30]]],["V_LegStrapBag_coyote_F",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",7,30]]],["B_RadioBag_01_hex_F",[["SmokeShellRed",3,1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",6,30]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["MMG_01_hex_F","muzzle_snds_93mmg_tan","","optic_Nightstalker",["150Rnd_93x64_Mag",150],[],"bipod_02_F_hex"],[],["hgun_Pistol_heavy_02_Yorris_F","","","optic_Yorris",["6Rnd_45ACP_Cylinder",6],[],""],["U_O_OfficerUniform_ocamo",[["FirstAidKit",1],["SmokeShellRed",3,1]]],["V_LegStrapBag_coyote_F",[["SmokeShell",1,1],["SmokeShellRed",1,1],["150Rnd_93x64_Mag",1,150]]],["B_RadioBag_01_hex_F",[["150Rnd_93x64_Mag",1,150],["SmokeShell",1,1],["SmokeShellRed",1,1]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]
		],
		[
			[["sgun_HunterShotgun_01_sawedoff_F","","","",["2Rnd_12Gauge_Pellets",2],[],""],[],[],["U_O_T_Officer_F",[["FirstAidKit",1],["Chemlight_red",1,1],["2Rnd_12Gauge_Pellets",4,2]]],["V_LegStrapBag_black_F",[["FirstAidKit",1],["2Rnd_12Gauge_Slug",5,2],["2Rnd_12Gauge_Pellets",5,2]]],["B_RadioBag_01_ghex_F",[["2Rnd_12Gauge_Pellets",7,2],["2Rnd_12Gauge_Slug",5,2]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["arifle_AKS_F","","","",["30Rnd_545x39_Mag_F",30],[],""],[],[],["U_O_T_Officer_F",[["FirstAidKit",1],["Chemlight_red",1,1],["30Rnd_545x39_Mag_Tracer_F",3,30]]],["V_LegStrapBag_black_F",[["FirstAidKit",1],["30Rnd_545x39_Mag_Tracer_F",9,30]]],["B_RadioBag_01_ghex_F",[["30Rnd_545x39_Mag_Tracer_F",8,30],["SmokeShellRed",3,1]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["SMG_03C_TR_black","muzzle_snds_570","","optic_Nightstalker",["50Rnd_570x28_SMG_03",50],[],""],[],[],["U_O_T_Officer_F",[["FirstAidKit",1],["Chemlight_red",1,1],["50Rnd_570x28_SMG_03",2,50]]],["V_LegStrapBag_black_F",[["FirstAidKit",1],["50Rnd_570x28_SMG_03",5,50]]],["B_RadioBag_01_ghex_F",[["SmokeShellRed",3,1],["50Rnd_570x28_SMG_03",5,50]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["SMG_05_F","muzzle_snds_L","","optic_Nightstalker",["30Rnd_9x21_Mag_SMG_02",30],[],""],[],[],["U_O_T_Officer_F",[["FirstAidKit",1],["Chemlight_red",1,1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",3,30]]],["V_LegStrapBag_black_F",[["FirstAidKit",1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",7,30]]],["B_RadioBag_01_ghex_F",[["SmokeShellRed",3,1],["30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",6,30]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]],
			[["MMG_01_tan_F","muzzle_snds_93mmg","","optic_Nightstalker",["150Rnd_93x64_Mag",150],[],"bipod_02_F_blk"],[],["hgun_Pistol_heavy_02_Yorris_F","","","optic_Yorris",["6Rnd_45ACP_Cylinder",6],[],""],["U_O_T_Officer_F",[["FirstAidKit",1],["SmokeShellRed",3,1]]],["V_LegStrapBag_coyote_F",[["SmokeShell",1,1],["SmokeShellRed",1,1],["150Rnd_93x64_Mag",1,150]]],["B_RadioBag_01_ghex_F",[["SmokeShell",1,1],["SmokeShellRed",1,1],["150Rnd_93x64_Mag",1,150]]],_headgear,"G_Aviator",[],["ItemMap","ItemGPS","ItemRadio","ItemCompass","ItemWatch",""]]
		]
	] select (worldName in ['Tanoa','Enoch']);
	_commander setUnitLoadout (selectRandom _loadouts);
};
{
	_commander enableAIFeature _x;
} forEach [
	['COVER',FALSE],
	['AUTOCOMBAT',FALSE],
	['PATH',FALSE],
	['AIMINGERROR',FALSE],
	['SUPPRESSION',FALSE],
	['MINEDETECTION',FALSE]
];
{
	_commander addEventHandler _x;
} forEach [
	[
		'HandleDamage',
		{
			_oldDamage = if ((_this # 5) isEqualTo -1) then {(damage (_this # 0))} else {((_this # 0) getHitIndex (_this # 5))};
			_damage = _oldDamage + (((_this # 2) - _oldDamage) * 0.05);
			_damage;
		}
	],
	[
		'Killed',
		{
			params ['_killed','_killer'];
			_killed removeAllEventHandlers 'HandleDamage';
			missionNamespace setVariable ['QS_commanderAlive',FALSE,FALSE];
			['QS_IA_TASK_AO_2'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			{
				_x setMarkerPos (missionNamespace getVariable 'QS_HQpos');
			} forEach [
				'QS_marker_hqMarker',
				'QS_marker_hqCircle'
			];
			['CompletedSub',[localize 'STR_QS_Notif_007']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			if (!isNull _killer) then {
				if (isPlayer _killer) then {
					_name = name _killer;
					_text = format ['%1 %2',_name,localize 'STR_QS_Chat_019'];
					['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				};
			};
		}
	],
	[
		'FiredMan',
		{
			(_this # 0) setAmmo [primaryWeapon (_this # 0),100];
		}
	],
	[
		'Hit',
		{
			(_this # 0) reveal [(_this # 1),4];
		}
	]
];
[_QS_HQpos,30,(units _commandGrp),[]] call (missionNamespace getVariable 'QS_fnc_garrisonUnits');
[(units _commandGrp),4] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_commander spawn {
	sleep 3;
	_this setUnitPos (selectRandom ['Middle','Down']);
};
_commandGrp setVariable ['QS_AI_GRP_TASK',['COMMAND',_centerPos,-1,-1],QS_system_AI_owners];
_commandGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
_commandGrp setVariable ['QS_AI_GRP_CONFIG',['COMMAND','CLASSIC'],QS_system_AI_owners];
_commandGrp setVariable ['QS_AI_GRP_DATA',[TRUE,-1],QS_system_AI_owners];
_commander setVariable ['QS_hidden',TRUE,TRUE];
_commander setVariable ['QS_AI_ignoreDamageReduction',TRUE,TRUE];
_commander setUnitTrait ['QS_trait_commander',TRUE,TRUE];
_commander setUnitTrait ['audibleCoef',0.5];
_commandGrp setFormDir (random 360);
{
	_enemiesArray pushBack _x;
} forEach (units _commandGrp);
{
	(missionNamespace getVariable 'QS_classic_AI_enemy_0') pushBack _x;
} forEach _enemiesArray;
diag_log '****************************************************';
diag_log '***** AO ENEMY ***** fn_aoEnemy END ****************';
diag_log '****************************************************';