/*/
File: fn_deployAssault.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/11/2023 A3 2.14 by Quiksilver
	
Description:

	Assault a deployment
______________________________________________________/*/

params [
	['_deploymentMissionMaxConcurrent',3],
	['_deploymentMissionFrequency',0.5],
	['_deploymentMissionIntensity',0.5],
	['_deploymentMissionDuration',0.5],
	['_deploymentMissionSetupTime',60],
	['_deploymentMissionOverclock',0]
];
private _object = objNull;
private _currentDeployments = QS_logistics_deployedAssets select {
	_object = _x # 0;
	((['Tank','Car'] findIf { _object isKindOf _x }) isEqualTo -1)
};
_uiTime = diag_tickTime;
_currentDeployments = _currentDeployments select {
	(
		(!((_x # 0) getVariable ['QS_deploy_underAttack',FALSE])) &&
		((_x # 0) getVariable ['QS_deploy_attackable',TRUE]) &&
		(_uiTime > ((_x # 0) getVariable ['QS_deploy_graceTime',-1])) &&
		(((_x # 0) getVariable ['QS_importance',0]) > 0)
	)
};
if (
	(allPlayers isEqualTo []) ||
	(_currentDeployments isEqualTo [])
) exitWith {};
_currentDeployments = _currentDeployments apply {
	[
		(_x # 0) getVariable ['QS_importance',0],
		(_x # 0) getVariable ['QS_deploy_type',''],
		(_x # 0)
	]
};
if (localNamespace getVariable ['QS_deploymentMissions_forceAttack',FALSE]) then {
	localNamespace setVariable ['QS_deploymentMissions_forceAttack',FALSE];
};
private _currentPrimaryMode = missionNamespace getVariable ['QS_missionConfig_aoType','ZEUS'];
private _weightedDeployments = [];
{
	_weightedDeployments pushBack (_x # 2);
	_weightedDeployments pushBack ((_x # 0) max 0.1);
} forEach _currentDeployments;
private _selectedDeployment = selectRandomWeighted _weightedDeployments;
private _referencePos = position _selectedDeployment;
diag_log (format ['***** DEBUG ***** Enemy assaulting deployment * %1 * %2 *****',typeOf _selectedDeployment,_referencePos]);
if (surfaceIsWater _referencePos) exitWith {diag_log 'Position over water, attack cancelled';};
[
	[WEST,'HQ'],
	localize 'STR_QS_Chat_172'
] remoteExec ['sideChat',-2,FALSE];
['GRID_BRIEF',[localize 'STR_QS_Notif_155',localize 'STR_QS_Notif_156']] remoteExec ['QS_fnc_showNotification',-2,FALSE];

private _allEnemiesCount = count ((units EAST) + (units RESISTANCE));
private _allEnemiesThreshold = 125;
private _radiusFriendly = 50;
private _radiusEnemy = 15;
private _enemyThreshold = 3;
_displayName = _selectedDeployment getVariable ['QS_ST_customDN',''];
private _tOut = diag_tickTime + 3;
waitUntil {
	uiSleep 0.25;
	(
		(_selectedDeployment setOwner 2) ||
		(diag_tickTime > _tOut)
	)
};
private _isDamageAllowed = isDamageAllowed _selectedDeployment;
private _simulationEnabled = simulationEnabled _selectedDeployment;
if (unitIsUav _selectedDeployment) then {
	/*/
	if ((crew _selectedDeployment) isNotEqualTo []) then {
		{
			[_x,TRUE] remoteExec ['setCaptive',_x];
		} forEach (crew _selectedDeployment);
	};
	/*/
	//_selectedDeployment setVariable ['QS_uav_toggleEnabled',FALSE,TRUE];
} else {
	[_selectedDeployment,FALSE] remoteExec ['allowDamage',0,FALSE];
	_selectedDeployment enableDynamicSimulation FALSE;
	_selectedDeployment enableSimulationGlobal FALSE;
};
{
	_selectedDeployment setVariable _x;
} forEach [
	['QS_logistics_blocked',TRUE,TRUE],
	['QS_deploy_assaultTerminate',FALSE,FALSE],
	['QS_deploy_underAttack',TRUE,FALSE]
];
private _allPlayers = allPlayers;
private _playerCount = count allPlayers;
private _endTime = diag_tickTime + (linearConversion [0,1,_deploymentMissionDuration,300,3600,TRUE]) + (60 - (random 120));
private _minUnits = round (linearConversion [0,1,_deploymentMissionIntensity,2,6,TRUE]);
private _quantity = round (linearConversion [0,1,_deploymentMissionIntensity,2,6,TRUE]);
private _maxGrpSize = round (linearConversion [0,1,_deploymentMissionIntensity,4,12,TRUE]);
if (_playerCount > 10) then {
	_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,4,12,TRUE]);
};
if (_playerCount > 20) then {
	_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,12,20,TRUE]);
};
if (_playerCount > 30) then {
	_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,16,24,TRUE]);
};
if (_playerCount > 40) then {
	_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,25,35,TRUE]);
};
if ((random 1) > 0.9) then {
	_quantity = round (_quantity * 1.5);
};
private _quantityDiff = 0;
private _enemyArray = [];
private _enemyInterval = 5;
private _enemyDelay = -1;
private _time = diag_tickTime;

private _enemyPool = ['deploy_assault_1','deploy_assault_2'] select ((random 1) < _deploymentMissionIntensity);
private _unitsList = [_enemyPool] call QS_data_listUnits;

private _grp = grpNull;
private _unit = objNull;
private _spawnPos = [0,0,0];
private _friendlySide = WEST;
private _enemySide = EAST;
private _unitType = '';
private _enemyCount = 0;

private _spawnPositionsList = [];
private _conditionInterval = 1;
private _conditionDelay = -1;
private _wp = nil;
if (_deploymentMissionOverclock > 0) then {
	localNamespace setVariable ['QS_deploy_assaultQuantity_override',round _deploymentMissionOverclock];
};
private _success = FALSE;
private _fail = FALSE;
private _end = FALSE;
private _fn_blacklist = {TRUE};
if (worldName isEqualTo 'Tanoa') then {
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
_basePos = markerPos 'QS_marker_base_marker';
_fn_setSkill = missionNamespace getVariable 'QS_fnc_serverSetAISkill';
_fn_findSafePos = missionNamespace getVariable 'QS_fnc_findSafePos';
_fn_waterIntersect = missionNamespace getVariable 'QS_fnc_waterIntersect';
_fn_unitSetup = missionNamespace getVariable 'QS_fnc_unitSetup';
for '_z' from 0 to 1 step 0 do {
	if (_allPlayers isEqualTo []) then {
		waitUntil {
			sleep 1;
			(allPlayers isNotEqualTo [])
		};
		_endTime = diag_tickTime + (linearConversion [0,1,_deploymentMissionDuration,300,3600,TRUE]) + (60 - (random 120));
	};
	_time = diag_tickTime;
	if (_time > _enemyDelay) then {
		_allPlayers = allPlayers;
		_playerCount = count allPlayers;
		_enemyDelay = _time + _enemyInterval;
		_enemyArray = _enemyArray select {alive _x};
		_enemyCount = count _enemyArray;
		_allEnemiesCount = count ((units EAST) + (units RESISTANCE));
		if (_playerCount > 10) then {
			_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,4,12,TRUE]);
		};
		if (_playerCount > 20) then {
			_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,12,20,TRUE]);
		};
		if (_playerCount > 30) then {
			_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,16,24,TRUE]);
		};
		if (_playerCount > 40) then {
			_quantity = round (linearConversion [0,1,_deploymentMissionIntensity,25,35,TRUE]);
		};
		if (
			((_allEnemiesCount < _allEnemiesThreshold) || (_enemyCount < _minUnits)) &&
			(_enemyCount < (localNamespace getVariable ['QS_deploy_assaultQuantity_override',_quantity]))
		) then {
			_quantityDiff = (localNamespace getVariable ['QS_deploy_assaultQuantity_override',_quantity]) - _enemyCount;
			for '_ii' from 0 to 49 step 1 do {
				_spawnPos = ([[_referencePos,250,500,5,0,0.5,0],[_referencePos,300,600,5,0,0.5,0]] select ((random 1) > 0.666)) call _fn_findSafePos;
				if (
					(_spawnPos isNotEqualTo []) &&
					{((_allPlayers inAreaArray [_spawnPos,300,300,0,FALSE]) isEqualTo [])} &&
					{((_spawnPos distance2D _referencePos) < 1001)} &&
					{(_spawnPos call _fn_blacklist)} &&
					{((_spawnPos distance2D _basePos) > 1000)} &&
					{(!([_spawnPos,_referencePos,25] call _fn_waterIntersect))}
				) exitWith {};
			};
			_grp = createGroup [_enemySide,TRUE];
			_grp setFormDir (_spawnPos getDir _referencePos);
			for '_i' from 0 to _quantityDiff step 1 do {
				_unitType = selectRandomWeighted _unitsList;
				_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[-500,-500,0],[],0,'FORM'];
				_unit enableAIFeature ['ANIM',FALSE];
				_unit switchMove ['amovppnemstpsraswrfldnon'];
				sleep (diag_deltaTime * 3);
				_unit setVehiclePosition [AGLToASL _spawnPos,[],0,'NONE'];
				_unit setVariable ['QS_AI_UNIT_enabled',TRUE,FALSE];
				_unit enableStamina FALSE;
				_unit enableFatigue FALSE;
				_unit call _fn_unitSetup;
				{
					_unit enableAIFeature _x;
				} forEach [
					['COVER',FALSE],
					['SUPPRESSION',FALSE],
					['ANIM',TRUE]
				];
				_enemyArray pushBack _unit;
				if (
					(((count _enemyArray) >= _quantity) && ((count (units _grp)) > 1)) ||
					((count (units _grp)) >= _maxGrpSize)
				) exitWith {};
			};
			if ((random 1) > 0.75) then {
				{
					_x setAnimSpeedCoef 1.1;
				} forEach (units _grp);
			};
			_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
			_grp setBehaviourStrong 'AWARE';
			_grp setCombatMode 'YELLOW';
			_grp setSpeedMode 'FULL';
			_wp = _grp addWaypoint [_referencePos,10];
			_wp setWaypointType (selectRandomWeighted ['MOVE',0.8,'SAD',0.2]);
			[units _grp,[1,2] select ((random 1) > 0.9)] call _fn_setSkill;
			_grp lockWP TRUE;
		};
	};
	if (_time > _conditionDelay) then {
		_conditionDelay = _time + _conditionInterval;
		if (
			(!alive _selectedDeployment) ||
			((count ((flatten ([EAST,RESISTANCE] apply {units _x})) inAreaArray [_referencePos,_radiusEnemy,_radiusEnemy,0,FALSE,-1])) > _enemyThreshold)
		) then {
			_fail = TRUE;
		} else {
			if (_time > _endTime) then {
				_success = TRUE;
			};
		};
	};
	if (
		_fail ||
		{_success} ||
		{(isNull _selectedDeployment)} ||
		{(_selectedDeployment getVariable ['QS_deploy_assaultTerminate',FALSE])}
	) exitWith {};
	uiSleep 1;
};
if (_fail) then {
	[[WEST,'HQ'],(format ['%1 lost!',_displayName])] remoteExec ['sideChat',-2,FALSE];
	['GRID_BRIEF',[localize 'STR_QS_Notif_155',localize 'STR_QS_Notif_158']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	deleteVehicle _selectedDeployment;
};
if (_success) then {
	
	//QS_deploy_graceTime
	
	
	[[WEST,'HQ'],(format ['%1 defended!',_displayName])] remoteExec ['sideChat',-2,FALSE];
	['GRID_BRIEF',[localize 'STR_QS_Notif_155',localize 'STR_QS_Notif_157']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};
_enemyArray = _enemyArray select {alive _x};
if (!isNull _selectedDeployment) then {
	if (unitIsUav _selectedDeployment) then {
		/*/
		if ((crew _selectedDeployment) isNotEqualTo []) then {
			{
				[_x,FALSE] remoteExec ['setCaptive',_x];
			} forEach (crew _selectedDeployment);
		};
		_selectedDeployment setVariable ['QS_uav_toggleEnabled',TRUE,TRUE];
		/*/
	} else {
		[_selectedDeployment,_isDamageAllowed] remoteExec ['allowDamage',0,FALSE];
		_selectedDeployment enableDynamicSimulation _simulationEnabled;
		_selectedDeployment enableSimulationGlobal _simulationEnabled;
	};
	_selectedDeployment setVariable ['QS_logistics_blocked',FALSE,TRUE];
	_selectedDeployment setVariable ['QS_deploy_underAttack',FALSE,FALSE];
};
if (_selectedDeployment getVariable ['QS_deploy_assaultTerminate',FALSE]) then {
	_selectedDeployment setVariable ['QS_deploy_assaultTerminate',FALSE,FALSE];
	deleteVehicle _enemyArray;
} else {
	_enemyArray spawn {
		{
			_x enableAIFeature ['PATH',FALSE];
			_x setUnitPos 'Down';
		} forEach _this;
		sleep 60;
		deleteVehicle (_this select {alive _x});
	};
};