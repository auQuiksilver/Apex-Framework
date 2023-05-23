/*
File: fn_SMpriorityARTY.sqf
Author:

	Quiksilver
	
Last modified:

	19/09/2018 A3 1.84 by Quiksilver
	
Description:

	-
______________________________________________________*/

scriptName 'QS - Side Mission - Artillery';
if ((count allPlayers) < 15) exitWith {};
if (worldName in ['Stratis']) exitWith {};
private ['_flatPos','_accepted','_unitsArray','_enemiesArray','_fuzzyPos','_briefing','_completeText','_baseMarker','_priorityTargets'];
missionNamespace setVariable ['QS_sideMission_enemyArray',[],FALSE];
_flatPos = [0,0,0];
_accepted = FALSE;
_baseMarker = markerPos 'QS_marker_base_marker';
for '_x' from 0 to 1 step 0 do {
	_flatPos = ['RADIUS',(missionNamespace getVariable 'QS_AOpos'),3500,'LAND',[5,0,0.2,5,0,FALSE,objNull],TRUE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_flatPos distance2D _baseMarker) > 2000) then {
		if ((_flatPos distance2D (missionNamespace getVariable 'QS_AOpos')) > 1200) then {
			_accepted = TRUE;
		};
	};
	if (_accepted) exitWith {};
};
_unitsArray = [_flatPos,(random 360),([] call (missionNamespace getVariable 'QS_data_artyPit'))] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
_priorityTargets = [];
_artyTypes2 = ['enemy_artillery_types_1'] call QS_data_listVehicles;
{
	
	if (!isSimpleObject _x) then {
		if ((toLowerANSI (typeOf _x)) in _artyTypes2) then {
			[0,_x,EAST,1] call (missionNamespace getVariable 'QS_fnc_vSetup2');
			_priorityTargets pushBack _x;
		};
	};
} forEach _unitsArray;
_enemiesArray = [_unitsArray # 0] call (missionNamespace getVariable 'QS_fnc_smEnemyEast');
private _playerCount = count allPlayers;
private _grp = grpNull;
private _grpSpawnPos = [0,0,0];
_tankTypes = [
	'I_LT_01_AA_F',0.4,
	'I_LT_01_AT_F',0.4,
	'I_LT_01_cannon_F',0.2
];
private _tankType = '';
private _tank = objNull;
private _tankCount = 1;
if (_playerCount > 10) then {_tankCount = 1;} else {_tankCount = 1;};
if (_playerCount > 20) then {_tankCount = 2;};
if (_playerCount > 30) then {_tankCount = 2;};
if (_playerCount > 40) then {_tankCount = 3;};
if (_playerCount > 50) then {_tankCount = 3;};
_tankCount = 2;
_speed = ceil (random [30,40,50]);
private _tanks = [];
for '_x' from 0 to (_tankCount - 1) step 1 do {
	_grpSpawnPos = ['RADIUS',_flatPos,300,'LAND',[5,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if ((_grpSpawnPos distance2D _flatPos) < 500) then {
		//_grp = createGroup [EAST,TRUE];
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
		_grp = createVehicleCrew _tank;
		[_grp,_flatPos,400,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_tank],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_enemiesArray pushBack _tank;
		{
			_x setUnitTrait ['engineer',TRUE,FALSE];
			_x setUnitLoadout (QS_core_units_map getOrDefault [toLowerANSI 'O_engineer_F','O_engineer_F']);
			_enemiesArray pushBack _x;
		} forEach (crew _tank);
		_tanks pushBack _tank;
	};
};
_fuzzyPos = [((_flatPos # 0) - 300) + (random 600),((_flatPos # 1) - 300) + (random 600),0];
'QS_marker_sideMarker' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_038']);
{
	_x setMarkerPosLocal _fuzzyPos;
	_x setMarkerAlpha 1;
} forEach ['QS_marker_sideMarker','QS_marker_sideCircle'];
[
	'QS_IA_TASK_SM_0',
	TRUE,
	[
		localize 'STR_QS_Task_098',
		localize 'STR_QS_Task_099',
		localize 'STR_QS_Task_099'
	],
	(markerPos 'QS_marker_sideMarker'),
	'CREATED',
	5,
	FALSE,
	TRUE,
	'destroy',
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
['NewPriorityTarget',[localize 'STR_QS_Notif_098']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_smSuccess',FALSE,TRUE];
waitUntil {
	sleep 5;
	(((_priorityTargets findIf {((canMove _x) && (alive _x))}) isEqualTo -1) || {(missionNamespace getVariable 'QS_smSuccess')})
};
['CompletedPriorityTarget',[localize 'STR_QS_Notif_099']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
{
	_x setMarkerPosLocal [-5000,-5000,0];
	_x setMarkerAlpha 0;
} forEach ['QS_marker_sideMarker','QS_marker_sideCircle'];
[1,_flatPos] spawn (missionNamespace getVariable 'QS_fnc_smDebrief');																
{
	if (alive _x) then {
		_x setDamage [1,TRUE];
	};
} forEach (missionNamespace getVariable ['QS_sideMission_enemyArray',[]]);
{
	0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
} count _enemiesArray;
{
	0 = (missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'NOW_DISCREET',0];
} count _unitsArray;