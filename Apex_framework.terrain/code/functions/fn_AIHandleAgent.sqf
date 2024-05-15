/*/
File: fn_AIHandleAgent.sqf
Author: 

	Quiksilver

Last Modified:

	8/05/2019 A3 1.92 by Quiksilver

Description:

	Handle Agents (Civilians, Animals)
________________________________________/*/

scriptName 'QS_fnc_AIHandleAgent';
params ['_entity','_uiTime','_fps'];
if (
	(!(alive _entity)) ||
	{(!(local _entity))} ||
	{(!(simulationEnabled _entity))} ||
	{(!((lifeState _entity) in ['','HEALTHY','INJURED']))}
) exitWith {};
if (!(_entity getVariable ['QS_AI_ENTITY_setup',FALSE])) then {
	_entity setVariable ['QS_AI_ENTITY_setup',TRUE,FALSE];
	_entity setVariable ['QS_AI_ENTITY_rv',[(random 1),(random 1),(random 1)],FALSE];
};
_side = side _entity;
_type = toLowerANSI (typeOf _entity);
_position = position _entity;
if (_entity getEntityInfo 0) exitWith {
	//comment 'Humans';
	if (
		(isNull (objectParent _entity)) &&
		{(!(_entity getVariable ['QS_AI_ENTITY_PANIC',FALSE]))} &&
		{(!(_entity getVariable ['QS_AI_ENTITY_PANIC_DISABLED',FALSE]))} &&
		{(_uiTime > (_entity getVariable ['QS_AI_ENTITY_PANIC_DELAY',-1]))}
	) then {
		if (_entity getVariable ['QS_AI_ENTITY_PANIC_ACTIVE',FALSE]) then {
			_entity setVariable ['QS_AI_ENTITY_PANIC_ACTIVE',FALSE,FALSE];
			_entity playMoveNow 'amovpercmstpsnonwnondnon';
		};
		_entity forceSpeed -1;
		_entity setVariable ['QS_AI_ENTITY_PANIC',TRUE,FALSE];
		_entity setVariable ['QS_AI_ENTITY_PANIC_DELAY',(_uiTime + (random 30)),FALSE];
		private _events = [];
		{
			_events pushBack [(_x # 0),(_entity addEventHandler _x)];
		} forEach [
			['FiredNear',{call (missionNamespace getVariable 'QS_fnc_AIXCivPanic')}],
			['Explosion',{call (missionNamespace getVariable 'QS_fnc_AIXCivPanic')}]
		];
		_entity setVariable ['QS_AI_ENTITY_PANIC_EVENTS',_events,FALSE];
	};
	_currentConfig = _entity getVariable ['QS_AI_ENTITY_CONFIG',[]];
	_currentData = _entity getVariable ['QS_AI_ENTITY_DATA',[]];
	_currentTask = _entity getVariable ['QS_AI_ENTITY_TASK',[]];
	_currentConfig params ['_currentConfig_major','_currentConfig_minor','_currentConfig_vehicle'];
	_currentTask params ['_currentTask_type','_currentTask_position','_currentTask_timeout'];
	if (((vectorMagnitude (velocity _entity)) < 0.1) || {(_uiTime > _currentTask_timeout)} || {((_entity distance2D ((expectedDestination _entity) # 0)) < 5)}) then {
		if (
			(_side isEqualTo CIVILIAN) &&
			{(_uiTime > (_entity getVariable ['QS_AI_ENTITY_PANIC_DELAY',-1]))} &&
			{(_currentConfig_major isEqualTo 'AMBIENT')}
		) then {
			if (
				(_currentConfig_minor isEqualTo 'FOOT') &&
				{(_currentTask_type isEqualTo 'CIRCUIT')} &&
				{(_currentTask_position isNotEqualTo [])}
			) then {
				if ((_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]) >= ((count _currentTask_position) - 1)) then {
					_entity setVariable ['QS_AI_ENTITY_CIRCUITINDEX',-1,FALSE];
				};
				_entity setVariable ['QS_AI_ENTITY_CIRCUITINDEX',((_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]) + 1),FALSE];
				_movePos = _currentTask_position # (_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]);
				_entity setDestination [_movePos,'LEADER PLANNED',TRUE];
				if ((random 1) > 0) then {
					_buildingExit = (nearestBuilding _movePos) buildingExit 0;
					if (_buildingExit isNotEqualTo [0,0,0]) then {
						_entity doWatch _buildingExit;
					};
				};
			};
			if (
				(_currentConfig_minor isEqualTo 'VEHICLE') &&
				{(_currentTask_type isEqualTo 'CIRCUIT')} &&
				{(_currentTask_position isNotEqualTo [])}
			) then {
				if ((_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]) >= ((count _currentTask_position) - 1)) then {
					_entity setVariable ['QS_AI_ENTITY_CIRCUITINDEX',-1,FALSE];
				};
				_entity setVariable ['QS_AI_ENTITY_CIRCUITINDEX',((_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]) + 1),FALSE];
				_movePos = _currentTask_position # (_entity getVariable ['QS_AI_ENTITY_CIRCUITINDEX',0]);
				_entity setDestination [_movePos,'VEHICLE PLANNED',TRUE];
			};
		};
		_entity setVariable ['QS_AI_ENTITY_TASK',[_currentTask_type,_currentTask_position,(serverTime + (random [10,20,40])),-1],FALSE];
	};
};
_terrainHeight = getTerrainHeightASL _position;
_taskData = _entity getVariable ['QS_AI_ENTITY_TASK',['',[0,0,0],0,0]];
_taskData params [
	'_taskType',
	'_taskPosition',
	'_taskRadius',
	'_taskTimeout'
];
if (_type in ['fin_random_f','fin_blackwhite_f','fin_ocherwhite_f','fin_sand_f','fin_tricolour_f']) exitWith {
	//comment 'Dogs';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
		if (_terrainHeight < -1) then {
			deleteVehicle _entity;
		};
	};
};
if (_type in ['sheep_random_f']) exitWith {
	//comment 'Sheep';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
	};
	if (_terrainHeight < -1) then {
		deleteVehicle _entity;
	};
};
if (_type in ['goat_random_f']) exitWith {
	//comment 'Goats';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			if ((random 1) > 0.666) then {
				if (_fps > 15) then {
					playSound3D ['a3\Sounds_F\environment\animals\Goats\Goat_' + (selectRandom ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18']) + '.wss',_entity,FALSE,(getPosASL _entity),1,1,45];
				};
			};
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
	};
	if (_terrainHeight < -1) then {
		deleteVehicle _entity;
	};
};
if (_type in ['hen_random_f','cock_random_f','cock_white_f']) exitWith {
	//comment 'Chickens';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			if ((random 1) > 0.85) then {
				if (_fps > 15) then {
					playSound3D ['a3\Sounds_F\environment\animals\Chickens\Chicken_' + (selectRandom ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20']) + '.wss',_entity,FALSE,getPosASL _entity,1,1,35];
				};
			};
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
	};
	if (_terrainHeight < -1) then {
		deleteVehicle _entity;
	};
};
if (_type in ['rabbit_f']) exitWith {
	//comment 'Rabbits';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
	};
	if (_terrainHeight < -1) then {
		deleteVehicle _entity;
	};
};
if (_type in ['snake_random_f']) exitWith {
	//comment 'Snakes';
	if (_taskType isEqualTo 'SITE_AMBIENT') then {
		if ((_uiTime > _taskTimeout) || {((_entity distance2D _taskPosition) > _taskRadius)}) then {
			_movePosition = _taskPosition getPos [(_taskRadius * (sqrt (random 1))),(random 360)];
			_entity moveTo _movePosition;
			_entity setDir (_entity getDir _movePosition);
			_entity setVariable ['QS_AI_ENTITY_TASK',[_taskType,_taskPosition,_taskRadius,(_uiTime + (random [2,9,25]))],FALSE];
		};
	};
	if (_terrainHeight < -1) then {
		deleteVehicle _entity;
	};
};