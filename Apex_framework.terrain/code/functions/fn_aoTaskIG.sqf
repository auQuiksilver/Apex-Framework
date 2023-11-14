/*/
File: fn_aoTaskIG.sqf
Author: 

	Quiksilver

Last Modified:

	28/11/2017 A3 1.78 by Quiksilver

Description:

	IG Task
	
Flow:

	lifestate
	handledamage
	
	if after 30 seconds hes still healthy/injured, data is deleted and mission is lost
	after put down, 40 seconds before self-destruct
	https://community.bistudio.com/wiki/targets
	marked sentries/lookouts
____________________________________________________________________________/*/

missionNamespace setVariable ['QS_grid_IG_taskActive',TRUE,FALSE];
params ['_centerPos'];
private _houseFound = FALSE;
private _findTimeout = diag_tickTime + 15;
private _testPos = [0,0,0];
private _entities = [];
private _incrementDir = (random 360);
private _increment = 15;
private _nearBuildings = [];
private _nearBuilding = objNull;
private _nearBuildingPosition = [0,0,0];
private _allPlayers = allPlayers;
private _nearObjectsRadius = 300;
private _distanceFixed = 1000;
private _distanceRandom = 1400;
private _houseTypes = ['ao_hvt_housetypes_1'] call QS_data_listVehicles;
for '_x' from 0 to 1 step 0 do {
	_testPos = _centerPos getPos [(_distanceFixed + (random _distanceRandom)),_incrementDir];
	_incrementDir = _incrementDir + _increment;
	_nearBuildings = nearestObjects [_testPos,_houseTypes,_nearObjectsRadius,TRUE];
	if (_nearBuildings isNotEqualTo []) then {
		_nearBuilding = selectRandom _nearBuildings;
		_nearBuildingPosition = getPosATL _nearBuilding;
		if (([_nearBuildingPosition,300,[WEST],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
			_houseFound = TRUE;
		};
	};
	if (diag_tickTime > _findTimeout) exitWith {};
	if (_houseFound) exitWith {};
};
if (diag_tickTime > _findTimeout) exitWith {
	missionNamespace setVariable ['QS_grid_IG_taskActive',FALSE,FALSE];
};
missionNamespace setVariable ['QS_grid_IG_taskActive',TRUE,FALSE];
_nearBuilding allowDamage FALSE;
private _buildingPositions = _nearBuilding buildingPos -1;
_buildingPosition = selectRandom _buildingPositions;
_buildingPositions = _buildingPositions apply { [(_x # 0),(_x # 1),((_x # 2) + 1)] };
private _unitTypes = ['O_G_Soldier_SL_F'];
private _grp = createGroup [EAST,TRUE];
private _unitType = selectRandom _unitTypes;
private _objUnit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_buildingPosition,[],0,'NONE'];
_objUnit allowDamage FALSE;
[_objUnit] joinSilent _grp;
_objUnit setPos _buildingPosition;
_entities pushBack _objUnit;
_objUnit removeWeapon (primaryWeapon _objUnit);
uiSleep 0.1;
[_objUnit,(selectRandom ['hgun_Pistol_heavy_01_F','hgun_ACPC2_F','hgun_Pistol_01_F','hgun_Rook40_F','hgun_Pistol_heavy_02_F']),5] call (missionNamespace getVariable 'QS_fnc_addWeapon');
_objUnit setUnitPos 'Up';
_objUnit enableAIFeature ['PATH',FALSE];
_objUnit forceAddUniform 'U_C_ConstructionCoverall_Blue_F';
_objUnit addVest 'V_Safety_yellow_F';
_objUnit addBackpack 'B_LegStrapBag_black_repair_F';
_objUnit linkItem QS_core_classNames_itemRadio;
_objUnit linkItem QS_core_classNames_itemWatch;
_objUnit setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_grp setBehaviour 'CARELESS';
_objUnit enableDynamicSimulation FALSE;
_damageEvent = {
	params ['_unit','_selectionName','_damage','','','','_instigator',''];
	if ((_damage > 0.89) && (_selectionName in ['','head','body'])) then {
		_unit allowDamage FALSE;
		_unit removeEventHandler [_thisEvent,_thisEventHandler];
		_unit setCaptive TRUE;
		_unit setUnconscious TRUE;
		_unit setBleedingRemaining 600;
		_unit spawn {
			uiSleep 3;
			_this allowDamage TRUE;
		};
		(_damage min 0.89);
	};
	(_damage min 0.89);
};
_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
_grp setFormDir (_buildingPosition getDir (_nearBuilding buildingExit 0));
_objUnit spawn {
	uiSleep 2;
	_this enableAIFeature ['PATH',FALSE];
};
_objUnit addEventHandler ['HandleDamage',_damageEvent];
_objUnit addEventHandler [
	'FiredMan',
	{
		(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
		(_this # 0) enableAIFeature ['PATH',TRUE];
		(_this # 0) allowFleeing 1;
		(_this # 0) setSkill ['courage',0];
	}
];
_objUnit addEventHandler [
	'Killed',
	{
		(_this # 0) setVariable ['QS_dead_prop',TRUE,TRUE];
	}
];
_objUnit allowDamage TRUE;
_objUnit setSkill 1;
_objUnit setSkill ['spotDistance',0.2];
_objUnit setSkill ['spotTime',0.25];
[_objUnit] call (missionNamespace getVariable 'QS_fnc_setCollectible');
for '_x' from 0 to 2 step 1 do {
	_objUnit setVariable ['QS_secureable',TRUE,TRUE];
};
//comment 'spawn sentries';
_unitTypes = [
	[
		'O_G_Soldier_A_F',
		'O_G_Soldier_AR_F',
		'O_G_medic_F',
		'O_G_engineer_F',
		'O_G_Soldier_exp_F',
		'O_G_Soldier_GL_F',
		'O_G_Soldier_M_F',
		'O_G_officer_F',
		'O_G_Soldier_F',
		'O_G_Soldier_LAT_F',
		'O_G_Soldier_lite_F',
		'O_G_Soldier_unarmed_F',
		'O_G_Sharpshooter_F',
		'O_G_Soldier_SL_F',
		'O_G_Soldier_TL_F'
	],
	[
		'I_C_Soldier_Bandit_7_F',
		'I_C_Soldier_Bandit_3_F',
		'I_C_Soldier_Bandit_2_F',
		'I_C_Soldier_Bandit_5_F',
		'I_C_Soldier_Bandit_6_F',
		'I_C_Soldier_Bandit_1_F',
		'I_C_Soldier_Bandit_8_F',
		'I_C_Soldier_Bandit_4_F',
		'I_C_Soldier_Para_7_F',
		'I_C_Soldier_Para_2_F',
		'I_C_Soldier_Para_3_F',
		'I_C_Soldier_Para_4_F',
		'I_C_Soldier_Para_6_F',
		'I_C_Soldier_Para_8_F',
		'I_C_Soldier_Para_1_F',
		'I_C_Soldier_Para_5_F',
		'I_C_Soldier_base_unarmed_F'
	]		
] select (worldName isEqualTo 'Tanoa');
_sentryGrp = createGroup [EAST,TRUE];
private _sentriesEnabled = FALSE;
if ((random 1) > 0) then {
	 _sentriesEnabled = TRUE;
	private _sentryUnit = objNull;
	_count = (round (1 + (random 2)));
	for '_x' from 0 to _count step 1 do {
		_unitType = selectRandom _unitTypes;
		_sentryUnit = _sentryGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_nearBuildingPosition,[],30,'NONE'];
		_entities pushBack _sentryUnit;
		_sentryUnit setSkill 0.5;
		_sentryUnit setSkill ['spotDistance',0.2];
		_sentryUnit setSkill ['spotTime',0.25];
		_sentryUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		_sentryUnit setVehiclePosition [(getPosWorld _sentryUnit),[],0,'NONE'];
	};
	_sentryGrp setSpeedMode 'LIMITED';
	_sentryGrp setBehaviour 'CARELESS';
	_sentryGrp setVariable ['QS_AI_GRP_TASK',['PATROL',[(position (leader _sentryGrp)),(selectRandom _buildingPositions)],serverTime,-1],QS_system_AI_owners];
	_sentryGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	_sentryGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _sentryGrp))],QS_system_AI_owners];
	_sentryGrp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
	_sentryGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_sentryGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
};
private _enemyDetected = FALSE;
private _serverTime = serverTime;
private _durationDetected = 30;
private _durationSelfDestruct = 30;
private _timeoutDetected = -1;
private _timeoutSelfDestruct = -1;
private _targetsRadius = 300;
private _taskFailed = FALSE;
private _taskSucceeded = FALSE;
private _incapacitated = FALSE;
private _mine = objNull;
_taskID = 'QS_GRID_TASK_IG_1';
private _description = format [
	'%1<br/><br/>%2<br/><br/>%3',
	localize 'STR_QS_Task_024',
	localize 'STR_QS_Task_025',
	localize 'STR_QS_Task_026'
];
if (_sentriesEnabled) then {
	_description = _description + (format ['<br/><br/>%1',localize 'STR_QS_Task_027']);
};
[
	_taskID,
	TRUE,
	[
		_description,
		localize 'STR_QS_Task_023',
		localize 'STR_QS_Task_023'
	],
	_nearBuildingPosition,
	'CREATED',
	5,
	FALSE,
	TRUE,
	'kill',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['GRID_IG_UPDATE',[localize 'STR_QS_Notif_018',localize 'STR_QS_Notif_029']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
[_taskID,['kill','','']] call (missionNamespace getVariable 'QS_fnc_taskSetCustomData');
for '_x' from 0 to 1 step 0 do {
	_serverTime = serverTime;
	if (!(_enemyDetected)) then {
		if (_objUnit getVariable ['QS_secured',FALSE]) then {
			_taskSucceeded = TRUE;
		} else {
			if (((_objUnit targets [TRUE,_targetsRadius]) isNotEqualTo []) || (((units _sentryGrp) findIf {((alive _x) && ((_x targets [TRUE,_targetsRadius]) isNotEqualTo []))}) isNotEqualTo -1)) then {
				['GRID_IG_UPDATE',[localize 'STR_QS_Notif_018',localize 'STR_QS_Notif_030']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				_enemyDetected = TRUE;
				_sentryGrp setSpeedMode 'FULL';
				_sentryGrp setBehaviour 'COMBAT';
				_timeoutDetected = _serverTime + _durationDetected;
				[_taskID,TRUE,_timeoutDetected] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
			};
		};
	} else {
		if (!(_incapacitated)) then {
			if ((lifeState _objUnit) in ['HEALTHY','INJURED']) then {
				if (_serverTime > _timeoutDetected) then {
					_taskFailed = TRUE;
					for '_x' from 0 to 2 step 1 do {
						_objUnit setVariable ['QS_secureable',FALSE,TRUE];
					};
					_objUnit removeAllEventHandlers 'HandleDamage';
				} else {
					if (_objUnit getVariable ['QS_secured',FALSE]) then {
						_taskSucceeded = TRUE;
					};
				};
			} else {
				_incapacitated = TRUE;
				_timeoutSelfDestruct = _serverTime + _durationSelfDestruct;
				[_taskID,TRUE,_timeoutSelfDestruct] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
			};
		} else {
			if (_serverTime > _timeoutSelfDestruct) then {
				_taskFailed = TRUE;
				for '_x' from 0 to 2 step 1 do {
					_objUnit setVariable ['QS_secureable',TRUE,TRUE];
				};
				_mine = createVehicle ['SmallSecondary',(getPosATL _objUnit),[],0,'CAN_COLLIDE']; 
				_mine setDamage [1,TRUE];
				deleteVehicle _objUnit;
			} else {
				if (_objUnit getVariable ['QS_secured',FALSE]) then {
					_taskSucceeded = TRUE;
				};
			};
		};
	};
	if (_taskSucceeded) exitWith {
		['GRID_IG_UPDATE',[localize 'STR_QS_Notif_023',localize 'STR_QS_Notif_031']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};		
	if (_taskFailed) exitWith {
		['GRID_IG_UPDATE',[localize 'STR_QS_Notif_032',localize 'STR_QS_Notif_033']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};
	uiSleep 3;
};
missionNamespace setVariable ['QS_grid_IG_taskActive',FALSE,FALSE];
{
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
} forEach _entities;
[_taskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');