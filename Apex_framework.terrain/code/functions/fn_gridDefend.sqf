/*/
File: fn_gridDefend.sqf
Author: 

	Quiksilver

Last Modified:

	7/12/2017 A3 1.80 by Quiksilver

Description:

	-
____________________________________________________________________________/*/

['GRID_IG_UPDATE',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_004']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
missionNamespace setVariable ['QS_grid_defend_active',TRUE,TRUE];
missionNamespace setVariable ['QS_grid_defend_AIinit',TRUE,TRUE];
missionNamespace setVariable ['QS_system_restartEnabled',FALSE,FALSE];
_playersCount = count allPlayers;
_worldName = worldName;
_worldSize = worldSize;
_aoPos = missionNamespace getVariable 'QS_aoPos';
_aoSize = missionNamespace getVariable 'QS_aoSize';
_centerPos = missionNamespace getVariable 'QS_grid_IGposition';
_centerRadius = 20;
private _serverTime = serverTime;
_duration = 900 + (random 360);
_endTime = _serverTime + _duration;
private _enemyInRadiusThreshold = 2;
private _enemyCoefLow = 0.025;
private _enemyCoefHigh = 0.05;
private _sectorControl = 1;
private _enemySides = [EAST,RESISTANCE];
private _friendSides = [WEST];
_radiusDelay = 5;
private _radiusCheckDelay = _serverTime + _radiusDelay;
private _friendsInRadius = [];
private _enemiesInRadius = [];
private _nearUnits = [];
private _nearUnitsRadius = 20;
private _allUnits = allUnits;
_taskID = 'QS_GRID_TASK_DEFEND_0';
_taskType = 'defend';
[
	_taskID,
	TRUE,
	[
		localize 'STR_QS_Task_041',
		localize 'STR_QS_Task_011',
		''
	],
	[(_centerPos # 0),(_centerPos # 1),10],
	'CREATED',
	5,
	FALSE,
	TRUE,
	_taskType,
	TRUE
] call (missionNamespace getVariable 'BIS_fnc_setTask');
[_taskID,TRUE,_endTime] call (missionNamespace getVariable 'QS_fnc_taskSetTimer');
[_taskID,[_taskType,'Defend 1','Defend 2']] call (missionNamespace getVariable 'QS_fnc_taskSetCustomData');
[_taskID,TRUE,_sectorControl] call (missionNamespace getVariable 'QS_fnc_taskSetProgress');
_fn_detector = missionNamespace getVariable 'QS_fnc_serverDetector';
_fn_taskSetProgress = missionNamespace getVariable 'QS_fnc_taskSetProgress';
for '_x' from 0 to 1 step 0 do {
	_serverTime = serverTime;
	if (_serverTime > _radiusCheckDelay) then {
		_radiusCheckDelay = _serverTime + _radiusDelay;
		_allUnits = allUnits;
		_nearUnits = (_centerPos nearEntities ['CAManBase',_nearUnitsRadius]) select {((lifeState _x) in ['HEALTHY','INJURED'])};
		if (_nearUnits isNotEqualTo []) then {
			_enemiesInRadius = _nearUnits select {((side (group _x)) in _enemySides)};
			_friendsInRadius = _nearUnits select {((side (group _x)) in _friendSides)};
			if ((count _enemiesInRadius) > _enemyInRadiusThreshold) then {
				if (_sectorControl > 0) then {
					_sectorControl = (_sectorControl - ([_enemyCoefLow,_enemyCoefHigh] select ((count _friendsInRadius) > 0))) max 0;
					[_taskID,TRUE,_sectorControl] call _fn_taskSetProgress;
				};
			} else {
				if (_sectorControl < 1) then {
					_sectorControl = (_sectorControl + ([_enemyCoefLow,_enemyCoefHigh] select ((count _friendsInRadius) > 0))) min 1;
					[_taskID,TRUE,_sectorControl] call _fn_taskSetProgress;
				};
			};
		};
	};
	if (_sectorControl <= 0) exitWith {
		//comment 'enemy wins';
		['GRID_IG_UPDATE',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_006']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};
	if (_serverTime > _endTime) exitWith {
		//comment 'friends win';
		['GRID_IG_UPDATE',[localize 'STR_QS_Notif_003',localize 'STR_QS_Notif_005']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	};
	uiSleep 2;
};
[_taskID] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
missionNamespace setVariable ['QS_grid_defend_AIdeInit',TRUE,TRUE];
missionNamespace setVariable ['QS_system_restartEnabled',TRUE,FALSE];
missionNamespace setVariable ['QS_grid_defend_active',FALSE,TRUE];