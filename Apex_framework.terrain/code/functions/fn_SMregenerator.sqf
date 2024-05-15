/*/
File: fn_SMregenerator.sqf
Author:

	Quiksilver
	
Last modified:

	7/06/2018 A3 1.82 by Quiksilver
	
Description:

	AI regenerator side mission
___________________________________________/*/

scriptName 'QS - SM - Regen';
private _all = [];
private _spawnPosition = [0,0,0];
_usedPositions = missionNamespace getVariable ['QS_AI_regen_usedPositions',[]];
_allPlayers = allPlayers;
_bestPlaces = '(1 + forest) * (1 - houses)';
private _nearestTerrainObjects = [];
_basePosition = markerPos 'QS_marker_base_marker';
_baseRadius = 1500;
_fobPosition = markerPos 'QS_marker_module_fob';
_fobRadius = 300;
_posGradient = 0;
for '_x' from 0 to 99 step 1 do {
	_spawnPosition = ['WORLD',-1,-1,'LAND',[1.5,0,0.1,3,0,FALSE,objNull],TRUE,[[0,0,0],300,_bestPlaces,15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	_posGradient = [_spawnPosition,12] call (missionNamespace getVariable 'QS_fnc_areaGradient');
	if (
		((_usedPositions inAreaArray [_spawnPosition,500,500,0,FALSE]) isEqualTo []) &&
		((_allPlayers inAreaArray [_spawnPosition,500,500,0,FALSE]) isEqualTo []) &&
		(!([_spawnPosition,150,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) &&
		((_spawnPosition distance2D _basePosition) > _baseRadius) &&
		((_spawnPosition distance2D _fobPosition) > _fobRadius) &&
		((_spawnPosition distance2D (missionNamespace getVariable 'QS_aoPos')) > 1000) &&
		((_posGradient < 5) && (_posGradient > -5)) &&
		(((_spawnPosition select [0,2]) nearRoads 100) isEqualTo [])
	) exitWith {};
};
(missionNamespace getVariable 'QS_AI_regen_usedPositions') pushBack _spawnPosition;
_terrainData = [2,_spawnPosition,500,[]] call (missionNamespace getVariable 'QS_fnc_aoGetTerrainData');
{	
	if ((_x distance2D _spawnPosition) < 10) then {
		_nearestTerrainObjects pushBack _x;
		_x hideObjectGlobal TRUE;
	};
} forEach (nearestTerrainObjects [_spawnPosition,[],20,FALSE,TRUE]);
private _regenerator = objNull;
_compositionData = [
	["Land_Device_assembled_F",[-0.223328,-1.41943,0],90.1458,[],true,true,false,{}], 
	["CamoNet_BLUFOR_open_F",[-0.0315552,-1.51709,0],177.875,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[-0.825806,1.73486,0],0,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[-2.48407,1.75146,0],0,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[2.53467,1.73096,0],0,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_3_F",[-3.27258,-1.4292,0.086091],270.445,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_3_F",[3.35931,-1.43408,0],90.8868,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[0.824219,-4.57129,0],181.01,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[-2.52747,-4.54443,0],181.01,[],false,false,true,{}], 
	["Land_Bunker_01_blocks_1_F",[2.52686,-4.59473,0],181.01,[],false,false,true,{}]
];
_composition = [_spawnPosition,(random 360),_compositionData,FALSE] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
{
	if ((toLowerANSI (typeOf _x)) in ['land_device_assembled_f']) exitWith {
		missionNamespace setVariable ['QS_AI_regenerator',_x,FALSE];
		_regenerator = _x;
	};
} forEach _composition;
//_soundSource = createSoundSource ['QS_deviceAssembled',(_regenerator modelToWorld [0,0,0]),[],0];
//[1,_soundSource,[_regenerator,[0,0,0]]] call QS_fnc_eventAttach;
{
	_regenerator addEventHandler _x;
} forEach [
	[
		'HandleDamage',
		{
			params ['_vehicle','','_damage','','','_hitPartIndex','',''];
			_oldDamage = if (_hitPartIndex isEqualTo -1) then {(damage _vehicle)} else {(_vehicle getHitIndex _hitPartIndex)};
			_damage = _oldDamage + (_damage - _oldDamage) * 0.2;
			_damage;
		}
	],
	[
		'Killed',
		{
			params ['_killed','_killer','_instigator','_usedEffects'];
			if ((attachedObjects _killed) isNotEqualTo []) then {
				deleteVehicle (attachedObjects _killed);
			};
		}
	],
	[
		'Deleted',
		{
			params ['_entity'];
			if ((attachedObjects _entity) isNotEqualTo []) then {
				deleteVehicle (attachedObjects _entity);
			};			
		}
	]
];
_unitTypes = [
	'o_v_soldier_tl_hex_f',0.1,
	'o_v_soldier_m_hex_f',0.3,
	'o_v_soldier_exp_hex_f',0.3,
	'o_v_soldier_lat_hex_f',0.4,
	'o_v_soldier_medic_hex_f',0.2,
	'o_v_soldier_hex_f',0.6
];
private _playerCount = count _allPlayers;
private _unitCount = 12;
private _groupSize = 4;
private _grp = grpNull;
private _unit = objNull;
private _grpSpawnPos = [0,0,0];
private _enemies = [];
_tankTypes = [
	'I_LT_01_AA_F',0.2,
	'I_LT_01_AT_F',0.3,
	'I_LT_01_cannon_F',0.4
];
private _tankType = '';
private _tank = objNull;
private _tankCount = 1;
if (_playerCount > 10) then {_unitCount = 16;_groupSize = 4;_tankCount = 1;} else {_unitCount = 12;_groupSize = 4;_tankCount = 1;};
if (_playerCount > 20) then {_unitCount = 20;_groupSize = 6;_tankCount = 2;};
if (_playerCount > 30) then {_unitCount = 20;_groupSize = 6;_tankCount = 2;};
if (_playerCount > 40) then {_unitCount = 24;_groupSize = 8;_tankCount = 3;};
if (_playerCount > 50) then {_unitCount = 24;_groupSize = 8;_tankCount = 3;};
_tankCount = 2;
_speed = ceil (random [30,40,50]);
private _tanks = [];
for '_x' from 0 to (_tankCount - 1) step 1 do {
	_grpSpawnPos = ['RADIUS',_spawnPosition,400,'LAND',[5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_grpSpawnPos distance2D _spawnPosition) < 500) then {
		_grp = createGroup [EAST,TRUE];
		_tankType = selectRandomWeighted _tankTypes;
		_tank = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _tankType,_tankType],_grpSpawnPos,[],0,'NONE'];
		_tank setDir (random 360);
		_tank setVehiclePosition [(getPosASL _tank),[],0,'NONE'];
		_tank allowCrewInImmobile [TRUE,TRUE];
		_tank enableVehicleCargo FALSE;
		_tank enableRopeAttach FALSE;
		_tank lock 3;
		_tank setConvoySeparation 50;
		_tank limitSpeed _speed;
		_tank addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
		[0,_tank,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _tank;
		createVehicleCrew _tank;
		(crew _tank) joinSilent _grp;
		[_grp,_spawnPosition,400,(_terrainData # 1),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_tank],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		_all pushBack _tank;
		{
			_x setUnitTrait ['engineer',TRUE,FALSE];
			_x setUnitLoadout (QS_core_units_map getOrDefault [toLowerANSI 'O_engineer_F','O_engineer_F']);
			_all pushBack _x;
		} forEach (crew _tank);
		_tanks pushBack _tank;
	};
};
private _tent = objNull;
if ((random 1) > 0.5) then {
	_grpSpawnPos = ['RADIUS',_spawnPosition,600,'LAND',[5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_grpSpawnPos distance2D _spawnPosition) < 600) then {
		_tank = createVehicle [QS_core_vehicles_map getOrDefault ['i_lt_01_scout_f','i_lt_01_scout_f'],_grpSpawnPos,[],0,'NONE'];
		_tank setDir (random 360);
		_tank setVehiclePosition [(getPosASL _tank),[],0,'NONE'];
		_tank allowCrewInImmobile [TRUE,TRUE];
		_tank enableVehicleCargo FALSE;
		_tank enableRopeAttach FALSE;
		_tank lock 3;
		_tank lockDriver TRUE;
		_tank setVariable ['QS_vehicle_disableAIUnstuck',TRUE,FALSE];
		[0,_tank,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
		(missionNamespace getVariable 'QS_AI_vehicles') pushBack _tank;
		createVehicleCrew _tank;
		_tank deleteVehicleCrew (driver _tank);
		_tank setVehicleRadar 1;
		_tank setVehicleReportRemoteTargets TRUE;
		_tank setVehicleReceiveRemoteTargets TRUE;
		_tank setVehicleReportOwnPosition FALSE;
		_tank engineOn FALSE;
		(crew _tank) joinSilent _grp;
		_all pushBack _tank;
		{
			_all pushBack _x;
		} forEach (crew _tank);
		_tanks pushBack _tank;
		if ((random 1) > 0.666) then {
			_tent = createVehicle ['CamoNet_INDP_big_F',(getPosATL _tank),[],0,'CAN_COLLIDE'];
			_tent allowDamage FALSE;
			_tent setDir ((getDir _tank) - 180); 
			_all pushBack _tent;
		};
	};
};
_fuzzyPos = [((_spawnPosition # 0) - 500) + (random 1000),((_spawnPosition # 1) - 500) + (random 1000),0];
'QS_marker_sideCircle' setMarkerSizeLocal [500,500];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_039']);
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
_task = [
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		(format [
			'%1<br/><br/>Send a team to destroy it!',
			localize 'STR_QS_Task_100',
			localize 'STR_QS_Task_101'
		]),
		localize 'STR_QS_Task_102',
		localize 'STR_QS_Task_102'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'destroy',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewSideMission',[localize 'STR_QS_Notif_100']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
private _time = diag_tickTime;
private _respawnDelay = 30;
private _respawnCheckDelay = _time + _respawnDelay;
private _regeneratorDelay = 5;
private _regeneratorCheckDelay = _time + _regeneratorDelay;
private _posFound = FALSE;
private _forestPositions = (_terrainData # 8) inAreaArray [_spawnPosition,300,300,0,FALSE];
_enoughPositions = (count _forestPositions) > 10;
private _arrayToSend = [];
private _signalPulseCheckDelay = 15;
_east = EAST;
missionNamespace setVariable ['QS_smSuccess',FALSE,FALSE];
for '_x' from 0 to 1 step 0 do {
	_time = diag_tickTime;
	_allPlayers = allPlayers;
	_playerCount = count _allPlayers;
	if (_playerCount > 10) then {_unitCount = 16;_groupSize = 4;} else {_unitCount = 12;_groupSize = 4;};
	if (_playerCount > 20) then {_unitCount = 20;_groupSize = 6;};
	if (_playerCount > 30) then {_unitCount = 20;_groupSize = 6;};
	if (_playerCount > 40) then {_unitCount = 24;_groupSize = 8;};
	if (_playerCount > 50) then {_unitCount = 24;_groupSize = 8;};
	if ((!alive _regenerator) || {(missionNamespace getVariable 'QS_smSuccess')}) exitWith {
		[1,_spawnPosition] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');
	};
	if (_time > _respawnCheckDelay) then {
		_enemies = _enemies select {(alive _x)};
		if ((count _enemies) < _unitCount) then {
			_posFound = FALSE;
			for '_x' from 0 to 29 step 1 do {
				_grpSpawnPos = ['RADIUS',_spawnPosition,500,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[[0,0,0],150,'(1 + forest)',15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
				if ((_allPlayers inAreaArray [_grpSpawnPos,300,300,0,FALSE]) isEqualTo []) exitWith {
					_posFound = TRUE;
				};
			};
			if (_posFound) then {
				_grp = createGroup [EAST,TRUE];
				_grp setFormDir (_spawnPosition getDir _grpSpawnPos);
				private _type = '';
				for '_x' from 0 to (_groupSize - 1) step 1 do {
					_type = selectRandomWeighted _unitTypes;
					_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _type,_type],_grpSpawnPos,[],5,'FORM'];
					_unit setVehiclePosition [(getPosWorld _unit),[],0,'NONE'];
					_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
					[_unit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
					{
						_unit setUnitTrait _x;
					} forEach [
						['camouflageCoef',0.5,FALSE],
						['audibleCoef',0.5,FALSE]
					];
					if ((random 1) > 0.8) then {
						_unit removeWeapon (primaryWeapon _unit);
						{
							_unit removeMagazine _x;
						} forEach (magazines _unit);
						[_unit,'MMG_01_hex_F',3] call (missionNamespace getVariable 'QS_fnc_addWeapon');
						_unit setVariable ['QS_AI_UNIT_isMG',TRUE,FALSE];
						_unit setVariable ['QS_AI_UNIT_lastSuppressiveFire',-1,FALSE];
						{
							_unit addPrimaryWeaponItem _x;
						} forEach [
							'muzzle_snds_93mmg',
							(selectRandom ['optic_tws_mg','optic_Nightstalker'])
						];
						_unit selectWeapon (primaryWeapon _unit);
					} else {
						{
							_unit addPrimaryWeaponItem _x;
						} forEach [
							(selectRandom ['optic_tws','optic_Nightstalker'])
						];	
					};
					_all pushBack _unit;
					_enemies pushBack _unit;
				};
				[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
				if ((random 1) > 0.333) then {
					if (!(_enoughPositions)) then {
						[_grp,_spawnPosition,50,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
					} else {
						_forestPositions = _forestPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
						_grp setVariable ['QS_AI_GRP_TASK',['PATROL',(_forestPositions select [0,4]),serverTime,-1],QS_system_AI_owners];
					};
					_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],QS_system_AI_owners];
				} else {
					_grp setVariable ['QS_AI_GRP_TASK',['HUNT',_spawnPosition,serverTime,-1],QS_system_AI_owners];
					_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INF_VIPER',(count (units _grp))],QS_system_AI_owners];
				};
				_grp setVariable ['QS_AI_GRP_DATA',[_spawnPosition],QS_system_AI_owners];
				_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				{
					diag_log str (_grp getVariable _x);
				} forEach [
					'QS_AI_GRP_TASK',
					'QS_AI_GRP_DATA',
					'QS_AI_GRP_CONFIG'
				];
			};
		};
		_respawnCheckDelay = _time + _respawnDelay;
	};
	if (_time > _signalPulseCheckDelay) then {
		_arrayToSend = [];
		if (_allPlayers isNotEqualTo []) then {
			{
				if ((_x distance2D _spawnPosition) < 600) then {
					_arrayToSend pushBack _x;
				};
			} forEach _allPlayers;
			if (_arrayToSend isNotEqualTo []) then {
				[1,_spawnPosition,500] remoteExec ['QS_fnc_signalStrength',_arrayToSend,FALSE];
			};
		};
		_signalPulseCheckDelay = _time + 15;
	};	
	if (_time > _regeneratorCheckDelay) then {
		{
			if (local _x) then {
				if (simulationEnabled _x) then {
					if ((damage _x) > 0) then {
						_unit = _x;
						if ((getAllHitPointsDamage _unit) isNotEqualTo []) then {
							{
								if (_x > 0) then {
									_unit setHitIndex [_forEachIndex,(_x * 0.5),FALSE];
								};
							} forEach ((getAllHitPointsDamage _unit) # 2);
						};
					};
				};
			};
			uiSleep 0.01;
		} forEach (units EAST);
		_regeneratorCheckDelay = _time + _regeneratorDelay;
	};
	uiSleep 3;
};
[_task] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
'QS_marker_sideCircle' setMarkerSize [300,300];
{
	_x setMarkerAlpha 0;
} count ['QS_marker_sideMarker','QS_marker_sideCircle'];
waitUntil {
	sleep 5;
	((allPlayers findIf {(((_x distance2D _spawnPosition) < 300) && ((lifeState _x) in ['HEALTHY','INJURED']))}) isEqualTo -1)
};
{
	if (!isNull _x) then {
		_x hideObjectGlobal FALSE;
	};
} forEach _nearestTerrainObjects;
deleteVehicle (_all + _composition);
missionNamespace setVariable ['QS_AI_regenerator',objNull,FALSE];