/*/
File: fn_AIHandleGroup.sqf
Author: 

	Quiksilver

Last Modified:

	22/08/2022 A3 2.10 by Quiksilver

Description:

	Handle Group AI
_______________________________________________________/*/

scriptName 'QS_fnc_AIHandleGroup';
params ['_grp','_uiTime','_fps'];
private _grpLeader = leader _grp;
if (
	(isNull _grp) ||
	(!(simulationEnabled _grpLeader))
) exitWith {};
if (!(_grp getVariable ['QS_AI_GRP_SETUP',FALSE])) then {
	_grp setVariable ['QS_AI_GRP_SETUP',TRUE,FALSE];
	_grp setVariable ['QS_AI_GRP_rv',[(random 1),(random 1),(random 1)],FALSE];
	if (_grp isNil 'QS_AI_GRP_CONFIG') then {
		_grp setVariable ['QS_AI_GRP_CONFIG',[-1,-1,-1],FALSE];
	};
	if (_grp isNil 'QS_AI_GRP_DATA') then {
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
	};
	if (_grp isNil 'QS_AI_GRP_TASK') then {
		_grp setVariable ['QS_AI_GRP_TASK',[-1,-1,-1,-1],FALSE];
	};
	if (!isNull (objectParent _grpLeader)) then {
		{
			_x enableAIFeature ['COVER',FALSE];
			_x enableAIFeature ['AUTOCOMBAT',FALSE];
		} forEach (units _grp);
		if (((objectParent _grpLeader) isKindOf 'LandVehicle') || {((objectParent _grpLeader) isKindOf 'Ship')} || {((objectParent _grpLeader) isKindOf 'Helicopter')} || {(unitIsUav _grpLeader)}) then {
			if (!(_grp getVariable ['QS_AI_GRP_canNearTargets',FALSE])) then {
				_grp setVariable ['QS_AI_GRP_canNearTargets',TRUE,FALSE];
			};
			(objectParent _grpLeader) setConvoySeparation (random [40,50,60]);
			if ((objectParent _grpLeader) isKindOf 'Car') then {
				if (((_grp getVariable ['QS_AI_GRP_rv',[-1,-1,-1]]) # 0) > 0.5) then {
					/*/(objectParent _grpLeader) forceFollowRoad TRUE;/*/
				};
			};
		};
		if (_grp isNil 'QS_AI_GRP_vUnstuck') then {
			_grp setVariable ['QS_AI_GRP_vUnstuck',(_uiTime + 300),FALSE];
		};
	} else {
		if ((random 1) > 0.75) then {
			{
				_x enableAIFeature ['COVER',FALSE];
				//_x enableAIFeature ['AUTOCOMBAT',FALSE];
			} forEach (units _grp);
		};
	};
	if !(_grp isNil 'QS_AI_GRP_canNearTargets') then {
		if (_grp isNil 'QS_AI_GRP_nearTargets') then {
			_grp setVariable ['QS_AI_GRP_nearTargets',[],FALSE];
			_grp setVariable ['QS_AI_GRP_lastNearTargets',_uiTime,FALSE];
		};
	};
	if (_grp isNil 'QS_AI_GRP_evalNearbyBuilding') then {
		_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + 60),FALSE];
	};
	if (_grp isNil 'QS_AI_GRP_allEnvSoundControllers') then {
		_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers (getPosATL _grpLeader)),FALSE];
		_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',_uiTime,FALSE];
	};
};
private _grpLeaderLifestate = lifeState _grpLeader;
if (!(_grpLeaderLifestate in ['HEALTHY','INJURED'])) then {
	private _grpUnits = (units _grp) select {((lifeState _x) in ['HEALTHY','INJURED'])};
	if (_grpUnits isNotEqualTo []) then {
		_grpUnits = _grpUnits apply { [rankId _x,_x] };
		_grpUnits sort FALSE;
		_grp selectLeader ((_grpUnits # 0) # 1);
		_grpLeader = leader _grp;
		_grpLeaderLifestate = lifeState _grpLeader;
	};
};
_grpAttackTarget = getAttackTarget _grpLeader;
if (!alive _grpAttackTarget) then {
	if (_fps > 15) then {
		if ((random 1) > 0.5) then {
			_grpAttackTarget = [_grpLeader,500,TRUE] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
		};
	};
};
if ((_grp getVariable ['QS_AI_GRP_attackTarget',_grpAttackTarget]) isNotEqualTo _grpAttackTarget) then {
	_grp setVariable ['QS_AI_GRP_attackTarget',_grpAttackTarget,FALSE];
};
_grpLeaderPosition = getPosATL _grpLeader;
_grpObjectParent = objectParent _grpLeader;
_grpMorale = morale _grpLeader;
_grpBehaviour = behaviour _grpLeader;
_grpCombatBehaviour = combatBehaviour _grp;
_grpSpeedMode = speedMode _grp;
_grpCombatMode = combatMode _grp;
_grpFormation = formation _grp;
_grpDestination = expectedDestination _grpLeader;
_grpPath = _grpLeader checkAIFeature 'PATH';
private _grpIsReady = (((unitReady _grpLeader) && (isNull _grpObjectParent)) || {((_grpDestination # 1) isEqualTo 'DoNotPlan')});
private _movePos = _grpLeaderPosition;
_currentCommand = currentCommand _grpLeader;
_currentConfig = _grp getVariable ['QS_AI_GRP_CONFIG',['','',0,objNull]];
_currentConfig params ['_currentConfig_major','_currentConfig_minor','_currentConfig_grpSize',['_currentConfig_vehicle',objNull]];
_currentData = _grp getVariable 'QS_AI_GRP_DATA';
_currentTask = _grp getVariable ['QS_AI_GRP_TASK',['',[0,0,0],0]];
_currentTask params ['_currentTask_type','_currentTask_position','_currentTask_timeout'];
private _grpNearTargets = [];
if (_grp getVariable ['QS_AI_GRP_canNearTargets',TRUE]) then {
	if (_uiTime > (_grp getVariable ['QS_AI_GRP_lastNearTargets',-1])) then {
		if (
			(alive _grpLeader) &&
			{(_grpLeaderLifestate in ['HEALTHY','INJURED'])} &&
			{(_fps > 12)}
		) then {
			if (isNull _grpObjectParent) then {
				_grpNearTargets = [7,EAST,_grp,_grpLeader,_grpObjectParent,300] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
			} else {
				if (((_grpObjectParent isKindOf 'LandVehicle') && (!(_grpObjectParent isKindOf 'StaticWeapon'))) || {(_grpObjectParent isKindOf 'Ship')}) then {
					_grpNearTargets = [8,EAST,_grp,_grpLeader,_grpObjectParent] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
				} else {
					if (_grpObjectParent isKindOf 'Air') then {
						_grpNearTargets = [9,EAST,_grp,_grpLeader,_grpObjectParent] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
					};
				};
			};
			if ((random 1) > 0.666) then {
				_targets = _grp targets [TRUE,600];
				_grp setVariable ['QS_AI_GRP_nearTargets',[_targets,(count _targets)],FALSE];
			};
		};
		_grp setVariable ['QS_AI_GRP_lastNearTargets',(_uiTime + (60 + (random 60))),FALSE];
	};
};
if ((_grpLeader getUnitTrait 'audibleCoef') isEqualTo 0.5) then {
	if (_uiTime > (_grp getVariable ['QS_GRP_targetsIntel_cooldown',-1])) then {
		_grp setVariable ['QS_GRP_targetsIntel_cooldown',_uiTime + 60,FALSE];
		if ((missionNamespace getVariable 'QS_AI_targetsIntel') isNotEqualTo []) then {
			_intelTargets = (missionNamespace getVariable 'QS_AI_targetsIntel') select {
				((lifeState (_x # 0)) in ['HEALTHY','INJURED']) && 
				{(((_x # 2) distance _grpLeader) < 300)} &&
				{
					((_uiTime - (_x # 1)) < 60) && 
					(
						(((_x # 0) distance (_x # 2)) < 50) || 
						((_x # 3) > 3)
					)
				}
			};
			if (_intelTargets isNotEqualTo []) then {
				private _intelTargetObject = objNull;
				private _intelTargetKA = 0;
				{
					_intelTargetObject = _x # 0;
					_intelTargetKA = _x # 3;
					_grp reveal [_intelTargetObject,_intelTargetKA];
					{
						_x reveal [_intelTargetObject,_intelTargetKA];
					} forEach (units _grp);
				} forEach _intelTargets;
			};
		};
	};
};
if (_grpNearTargets isNotEqualTo []) then {
	if (_grpBehaviour isEqualTo 'SAFE') then {
		_grp setBehaviour 'AWARE';
	};
};
if (isNull _grpObjectParent) then {
	if (_uiTime > (_grp getVariable 'QS_AI_GRP_lastEnvSoundCtrl')) then {
		_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',(_uiTime + (30 + (random 30))),FALSE];
		_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers _grpLeaderPosition),FALSE];
	};
	if (
		(_uiTime > (_grp getVariable ['QS_AI_GRP_EH_ED_cooldown',-1])) &&
		{(((_grp getEventHandlerInfo ['EnemyDetected',0]) # 2) isEqualTo 0)}
	) then {
		_grp addEventHandler ['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected')}];
	};
	if (
		_grpPath &&
		{(_uiTime > (_grp getVariable ['QS_AI_GRP_EH_CMC_cooldown',-1]))} &&
		{(((_grp getEventHandlerInfo ['CombatModeChanged',0]) # 2) isEqualTo 0)}
	) then {
		_grp addEventHandler ['CombatModeChanged',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventCombatModeChanged')}];
	};
	_envSoundControllers = _grp getVariable ['QS_AI_GRP_allEnvSoundControllers',[]];
	if (_envSoundControllers isNotEqualTo []) then {
		if (((_envSoundControllers # 7) # 1) > 0.3) then {
			if (_grpBehaviour in ['SAFE','CARELESS']) then {
				if (!(_grpFormation in ['COLUMN','STAG COLUMN'])) then {
					_grp setFormation (selectRandom ['COLUMN','STAG COLUMN']);
				};
			} else {
				if (!(_grpFormation in ['WEDGE','LINE'])) then {
					_grp setFormation (selectRandomWeighted ['LINE',2,'WEDGE',1]);
				};
			};
		} else {
			if (((_envSoundControllers # 8) # 1) > 0.3) then {
				if (_grpSpeedMode isEqualTo 'FULL') then {
					_grp setSpeedMode 'NORMAL';
				};
				if (_grpBehaviour isNotEqualTo 'COMBAT') then {
					if (!(_grpFormation in ['DIAMOND','FILE'])) then {
						_grp setFormation (selectRandom ['DIAMOND','FILE']);
					};
				} else {
					if (!(_grpFormation in ['WEDGE','LINE','VEE'])) then {
						_grp setFormation (selectRandomWeighted ['WEDGE',0.75,'LINE',0.2,'VEE',0.05]);
					};
				};
			} else {
				if (!(_grpFormation in ['WEDGE','LINE'])) then {
					_grp setFormation (selectRandomWeighted ['WEDGE',1,'LINE',1]);
				};
			};
		};
		if ((_envSoundControllers # 8) isEqualTo 1) then {
			// adjust AI group accuracy skill
		} else {
			// adjust AI group accuracy skill
		};
	};
} else {
	if (_grpObjectParent isKindOf 'LandVehicle') then {
		if (_grpFormation isNotEqualTo 'COLUMN') then {
			_grp setFormation 'COLUMN';
		};
	};
};
if (!isNull _currentConfig_vehicle) then {
	if (!(_currentConfig_vehicle getVariable ['QS_vehicle_disableAIUnstuck',FALSE])) then {
		if (_currentConfig_vehicle isKindOf 'Land') then {
			[_currentConfig_vehicle,_grp,'LAND'] call (missionNamespace getVariable 'QS_fnc_AIXVehicleUnstuck');
		};
		if (_currentConfig_vehicle isKindOf 'Ship') then {
			[_currentConfig_vehicle,_grp,'SHIP'] call (missionNamespace getVariable 'QS_fnc_AIXVehicleUnstuck');
		};
		if (_currentConfig_vehicle isKindOf 'Helicopter') then {
			[_currentConfig_vehicle,_grp,'HELI'] call (missionNamespace getVariable 'QS_fnc_AIXVehicleUnstuck');
		};
	};
};
if (_grp getVariable ['QS_AI_GRP_regrouping',FALSE]) exitWith {
	if (({(alive _x)} count (units _grp)) > 1) then {
		_grp setVariable ['QS_AI_GRP_regrouping',FALSE,FALSE];
	} else {
		if ((_grpLeader distance2D (_grp getVariable 'QS_AI_GRP_regroupPos')) > 100) then {
			doStop _grpLeader;
			_grpLeader commandMove (_grp getVariable ['QS_AI_GRP_regroupPos',_grpLeaderPosition]);
		};
	};
};
if (
	!scriptDone (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])
) exitWith {};
if (
	(_uiTime > _currentTask_timeout) || 
	{(((lifeState _grpLeader) in ['HEALTHY','INJURED']) && _grpIsReady)}
)  then {
	if (_currentConfig_major isEqualTo 'COMMAND') then {
		if (_currentConfig_minor isEqualTo 'CLASSIC') then {
			// Commander support request
			if (_uiTime > (_grp getVariable ['QS_AI_cmd_suppReq_cool',-1])) then {
				_grp setVariable ['QS_AI_cmd_suppReq_cool',_uiTime + (5 + (random 5)),QS_system_AI_owners];
				private _targetPosition = [0,0,0];
				if ((missionNamespace getVariable ['QS_AI_targetsIntel',[]]) isNotEqualTo []) then {
					private _sortByRating = (random 1) > 0.5;
					private _targetsIntelList = missionNamespace getVariable ['QS_AI_targetsIntel',[]];
					private _targetsIntel = [];
					private _basePos = markerPos 'QS_marker_base_marker';
					private _aoPos = missionNamespace getVariable 'QS_aoPos';
					private _aoSize = (missionNamespace getVariable 'QS_aoSize') * 0.9;
					private _hqPos = missionNamespace getVariable 'QS_hqPos';
					private _sidePos = markerPos 'QS_marker_sideMarker';
					private _targetList = [];
					private _ratedTargetList = [];
					private _rating = 0;
					missionNamespace setVariable ['QS_AI_cmdr_recentSuppPositions',((missionNamespace getVariable ['QS_AI_cmdr_recentSuppPositions',[]]) select { _uiTime < (_x # 1) }),FALSE];
					private _recentTargetPositions = (missionNamespace getVariable ['QS_AI_cmdr_recentSuppPositions',[]]) apply { _x # 0 };
					{
						_targetsIntel = _x;
						_targetsIntel params ['_targetsIntel_target','_targetsIntel_spotTime','_targetsIntel_position','_targetsIntel_knowsabout','','_targetsIntel_grounded','_targetsIntel_rating'];
						if (
							(alive _targetsIntel_target) &&
							{((_uiTime - _targetsIntel_spotTime) < 120)} &&
							{(_targetsIntel_knowsabout > 3)} &&
							{(_targetsIntel_grounded)} &&
							{(!([_targetsIntel_target] call (missionNamespace getVariable 'QS_fnc_getVehicleStealth')))} &&
							{(!surfaceIsWater _targetsIntel_position)} &&
							{((_recentTargetPositions inAreaArray [_targetsIntel_position,100,100,0,FALSE]) isEqualTo [])} &&
							{((_targetsIntel_position distance2D _basePos) > 1000)} &&
							{((_targetsIntel_position distance2D _aoPos) > _aoSize)} &&
							{((_targetsIntel_position distance2D _sidePos) > 600)}
						) then {
							if (_sortByRating) then {
								_ratedTargetList pushBack [_targetsIntel_rating,_targetsIntel_position];
							} else {
								_targetList pushBack _targetsIntel_position;
							};
						};
					} forEach _targetsIntelList;
					if (_sortByRating) then {
						if (_ratedTargetList isNotEqualTo []) then {
							_ratedTargetList sort FALSE;
							_ratedTargetList = _ratedTargetList select [0,3];
							_ratedTargetList = _ratedTargetList apply { _x # 1 };
							_targetPosition = selectRandom _ratedTargetList;
							
						};
					} else {
						if (_targetList isNotEqualTo []) then {
							_targetPosition = selectRandom _targetList;
						};
					};
				};
				if (_targetPosition isNotEqualTo [0,0,0]) then {
					private _exit = FALSE;
					private _supportProvider = objNull;
					private _supportGroup = grpNull;
					if ((missionNamespace getVariable 'QS_AI_supportProviders_MTR') isNotEqualTo []) then {
						private _supportProviders = missionNamespace getVariable 'QS_AI_supportProviders_MTR';
						{
							_supportProvider = _x;
							if (
								(alive _supportProvider) &&
								{((vehicle _supportProvider) isKindOf 'StaticMortar')}
							) then {
								_supportGroup = group _supportProvider;
								if (
									((_supportGroup getVariable 'QS_AI_GRP_DATA') # 0) &&
									{(_supportGroup isNil 'QS_AI_GRP_fireMission')} &&
									{(_supportGroup isNil 'QS_AI_GRP_MTR_cooldown')} &&
									{(_targetPosition inRangeOfArtillery [[_supportProvider],((magazines (vehicle _supportProvider)) # 0)])}
								) then {
									(missionNamespace getVariable ['QS_AI_cmdr_recentSuppPositions',[]]) pushBack [_targetPosition,serverTime + (60 + (random 300))];
									(format ['%2 %1',mapGridPosition _targetPosition,localize 'STR_QS_Chat_078']) remoteExec ['systemChat',-2];
									_supportGroup setVariable ['QS_AI_GRP_fireMission',[(_targetPosition getPos [random 50,random 360]),((magazines (vehicle _supportProvider)) # 0),(round (4 + (random 4))),(serverTime + 90)],QS_system_AI_owners];
									_exit = TRUE;
								};
							};
							if (_exit) exitWith {};
						} forEach _supportProviders;
					};
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'SC') then {
		if (_currentTask_type isEqualTo 'ATTACK') then {
			private _position = _grpLeaderPosition;
			{
				_position = [_x,_grpLeaderPosition,(side _grp)] call (missionNamespace getVariable 'QS_fnc_scGetNearestSector');
				if (_position isNotEqualTo []) exitWith {};
			} forEach [2,3];
			if (_position isEqualTo []) then {	
				_position = [1,_grpLeaderPosition,WEST] call (missionNamespace getVariable 'QS_fnc_scGetNearestSector');
			};
			if (_position isNotEqualTo []) then {
				if ((_position distance2D _grpLeader) > 50) then {
					_movePos = [((_position # 0) + (50 - (random 100))),((_position # 1) + (50 - (random 100))),(_position # 2)];
					if (surfaceIsWater _movePos) then {
						for '_x' from 0 to 11 step 1 do {
							_movePos = [((_position # 0) + (50 - (random 100))),((_position # 1) + (50 - (random 100))),(_position # 2)];
							if (!surfaceIsWater _movePos) exitWith {};
						};
					};
					if ((unitPos _grpLeader) isNotEqualTo 'Auto') then {
						{
							_x setUnitPos 'Auto';
						} count (units _grp);
					};
					if ((speedMode _grp) isNotEqualTo 'FULL') then {
						_grp setSpeedMode 'FULL';
					};
					if (!surfaceIsWater _movePos) then {
						_grp setFormDir (_grpLeaderPosition getDir _movePos);
						_grp move _movePos;
						_grp setVariable ['QS_AI_GRP_TASK',['ATTACK',_movePos,(_uiTime + 60)],FALSE];
					};
				};
			} else {
				_position = missionNamespace getVariable 'QS_virtualSectors_centroid';
				_movePos = [((_position # 0) + (150 - (random 300))),((_position # 1) + (150 - (random 300))),(_position # 2)];
				if (surfaceIsWater _movePos) then {
					for '_x' from 0 to 11 step 1 do {
						_movePos = [((_position # 0) + (150 - (random 300))),((_position # 1) + (150 - (random 300))),(_position # 2)];
						if (!surfaceIsWater _movePos) exitWith {};
					};
				};
				if ((unitPos _grpLeader) isNotEqualTo 'Auto') then {
					{
						_x setUnitPos 'Auto';
					} forEach (units _grp);
				};
				if ((speedMode _grp) isNotEqualTo 'FULL') then {
					_grp setSpeedMode 'FULL';
				};
				if (!surfaceIsWater _movePos) then {
					_grp setFormDir (_grpLeaderPosition getDir _movePos);
					_grp move _movePos;
					_grp setVariable ['QS_AI_GRP_TASK',['ATTACK',_movePos,(_uiTime + 60)],FALSE];
				};
			};
		};
		if (_currentTask_type isEqualTo 'DEFEND') then {
			if (_uiTime > _currentTask_timeout) then {
				private _position = _grpLeaderPosition;
				if ((random 1) > 0.15) then {
					_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
					if (surfaceIsWater _movePos) then {
						for '_x' from 0 to 11 step 1 do {
							_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
							if (!surfaceIsWater _movePos) exitWith {};
						};
					};
				} else {
					_locationData = _currentData # 3;
					if (_locationData isNotEqualTo []) then {
						_location = _locationData # 0;
						if !(_location isNil 'QS_virtualSectors_terrainData') then {
							_buildingPositions = (_location getVariable ['QS_virtualSectors_terrainData',[ [],[],[],[],[] ]]) # 3;
							if (!isNil '_buildingPositions') then {
								if (_buildingPositions isNotEqualTo []) then {
									_movePos = (selectRandom _buildingPositions) vectorAdd [0,0,1];
									doStop (units _grp);
									if (canSuspend) then {sleep 0.1;};
									(units _grp) doMove _movePos;
								} else {
									_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
									if (surfaceIsWater _movePos) then {
										for '_x' from 0 to 11 step 1 do {
											_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
											if (!surfaceIsWater _movePos) exitWith {};
										};
									};
								};
							} else {
								_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
								if (surfaceIsWater _movePos) then {
									for '_x' from 0 to 11 step 1 do {
										_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
										if (!surfaceIsWater _movePos) exitWith {};
									};
								};
							};
						} else {
							_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
							if (surfaceIsWater _movePos) then {
								for '_x' from 0 to 11 step 1 do {
									_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
									if (!surfaceIsWater _movePos) exitWith {};
								};
							};
						};
					} else {
						_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
						if (surfaceIsWater _movePos) then {
							for '_x' from 0 to 11 step 1 do {
								_movePos = _currentTask_position getPos [(125 * (sqrt (random 1))),(random 360)];
								if (!surfaceIsWater _movePos) exitWith {};
							};
						};
					};
				};

				if ((_grpLeaderPosition distance2D _movePos) < 50) then {
					if (_grpSpeedMode isNotEqualTo 'NORMAL') then {
						_grp setSpeedMode 'NORMAL';
					};
					if ((unitPos _grpLeader) isNotEqualTo 'Middle') then {
						{
							_x setUnitPos 'Middle';
						} count (units _grp);
					};
				} else {
					if (_grpSpeedMode isNotEqualTo 'FULL') then {
						_grp setSpeedMode 'FULL';
					};
					if ((unitPos _grpLeader) isNotEqualTo 'Auto') then {
						{
							_x setUnitPos 'Auto';
						} count (units _grp);
					};					
				};
				if (!surfaceIsWater _movePos) then {
					private _defaultMove = TRUE;
					if (_defaultMove) then {
						_grp setFormDir (_grpLeaderPosition getDir _movePos);
						_grp move _movePos;
					};
					_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_currentTask_position,(_uiTime + (30 + (random 30)))],FALSE];
				};
			};
		};
		if (_currentTask_type isEqualTo 'ASSAULT') then {
			if (_uiTime > _currentTask_timeout) then {
				doStop (units _grp);
				if (canSuspend) then {sleep 0.1;};
				(units _grp) doMove _movePos;
				_grp setFormDir (_grpLeader getDir _movePos);
				_grp setVariable ['QS_AI_GRP_TASK',['ASSAULT',_movePos,(_uiTime + 15)],FALSE];
			};
		};
		if (_currentConfig_minor isEqualTo 'INF_PATROL_RADIAL') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (300 + (random 300))),-1],FALSE];					
					private _defaultMove = TRUE;
					if (_defaultMove) then {
						_grp move _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					};					
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'VEH_PATROL') then {
			if (_currentTask_type isEqualTo 'PATROL_VEH') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if (alive _currentConfig_vehicle) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (90 + (random 90))),-1],FALSE];
						_movePos set [2,1];
						if (alive (driver _currentConfig_vehicle)) then {
							if (((vectorMagnitude (velocity _currentConfig_vehicle)) * 3.6) < 2) then {
								doStop (driver _currentConfig_vehicle);
								if ((driver _currentConfig_vehicle) isEqualTo _grpLeader) then {
									(driver _currentConfig_vehicle) commandMove _movePos;
								} else {
									(driver _currentConfig_vehicle) doMove _movePos;
								};
								_grp setFormDir (_grpLeader getDir _movePos);
							};
						};
					};
				};
			};
		};		
		if (_currentConfig_minor isEqualTo 'AIR_PATROL_HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if !(_grp isNil 'QS_AI_GRP_fireMission') then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
					};
				} else {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (30 + (random 30))),-1],FALSE];
						(vehicle _grpLeader) land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
						};
						doStop (driver (vehicle _grpLeader));
						(driver (vehicle _grpLeader)) doMove _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					};
				};
				if (alive _currentConfig_vehicle) then {
					if (((vectorMagnitude (velocity _currentConfig_vehicle)) * 3.6) < 5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
						_movePos set [2,50];
						(vehicle _grpLeader) land 'NONE';
						doStop (driver (vehicle _grpLeader));
						(driver (vehicle _grpLeader)) doMove _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					};
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'AO') then {
		if (_currentConfig_minor isEqualTo 'AIR_PATROL_HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if !(_grp isNil 'QS_AI_GRP_fireMission') then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
					};
				} else {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (30 + (random 30))),-1],FALSE];
						(vehicle _grpLeader) land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
						};
						doStop (driver (vehicle _grpLeader));
						(driver (vehicle _grpLeader)) doMove _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					};
				};
				if (alive (vehicle _grpLeader)) then {
					if (((vectorMagnitude (velocity (vehicle _grpLeader))) * 3.6) < 5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
						_movePos set [2,50];
						(vehicle _grpLeader) land 'NONE';
						doStop (driver (vehicle _grpLeader));
						(driver (vehicle _grpLeader)) doMove _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					};
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'UAV_PATROL_RADIAL') then {
			if (alive _grpObjectParent) then {
				_grpObjectParent setFuel 1;
			};
			if (_currentTask_type isEqualTo 'PATROL') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (180 + (random 180))),-1],FALSE];
					if (!isNull (_grpLeader findNearestEnemy _grpLeader)) then {
						if (alive (gunner _grpObjectParent)) then {
							(gunner _grpObjectParent) doWatch (_grpLeader findNearestEnemy _grpLeader);
						};
					};
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'SUPPORT') then {
		if (_currentConfig_minor isEqualTo 'MORTAR') then {
			if (alive _grpLeader) then {
				if ((vehicle _grpLeader) isEqualTo (_currentConfig # 2)) then {
					if (!(_currentData # 0)) then {
						if (_uiTime > (_currentData # 1)) then {
							_grp setVariable ['QS_AI_GRP_DATA',[TRUE,(_uiTime - 1)],FALSE];
							(vehicle _grpLeader) setVehicleAmmo 1;
						};
					};
					if ((_grp getVariable 'QS_AI_GRP_DATA') # 0) then {
						if !(_grp isNil 'QS_AI_GRP_MTR_cooldown') then {
							if (_uiTime > (_grp getVariable 'QS_AI_GRP_MTR_cooldown')) then {
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',nil,QS_system_AI_owners];
							};
						} else {
							if !(_grp isNil 'QS_AI_GRP_fireMission') then {
								_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
								_fireMission params ['_firePosition','_fireShells','_fireRounds'];
								_allPlayerCount = count allPlayers;
								private _cooldown = 0;
								if (_allPlayerCount < 20) then {
									_cooldown = 360 + (random 360);
								};
								if (_allPlayerCount >= 20) then {
									_cooldown = 120 + (random 120);
								};
								if (_allPlayerCount >= 40) then {
									_cooldown = 60 + (random 60);
								};
								if (_firePosition inRangeOfArtillery [[_grpLeader],_fireShells]) then {
									_grp setVariable ['QS_AI_GRP_DATA',[FALSE,(_uiTime + _cooldown)],FALSE];
									if (isDedicated) then {
										[0,_grpLeader,_firePosition,_fireShells,_fireRounds] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
										missionNamespace setVariable ['QS_AI_scripts_fireMissions',((missionNamespace getVariable 'QS_AI_scripts_fireMissions') + [serverTime + 60]),QS_system_AI_owners];
									} else {
										[99,[0,_grpLeader,_firePosition,_fireShells,_fireRounds],(serverTime + 60)] remoteExec ['QS_fnc_remoteExec',2,FALSE];
									};
								};
								_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',(serverTime + _cooldown),QS_system_AI_owners];
							};
						};
					};
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'ARTILLERY') then {
			if (alive _grpLeader) then {
				if ((vehicle _grpLeader) isEqualTo (_currentConfig # 2)) then {
					if (!(_currentData # 0)) then {
						if (_uiTime > (_currentData # 1)) then {
							_grp setVariable ['QS_AI_GRP_DATA',[TRUE,(_uiTime - 1)],FALSE];
							(_currentConfig # 2) setVehicleAmmo 1;
						};
					};
					if ((_grp getVariable 'QS_AI_GRP_DATA') # 0) then {
						_firePosition = [13,EAST,TRUE,(_currentConfig # 2),((magazines (_currentConfig # 2)) # 0)] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
						if (_firePosition isNotEqualTo [0,0,0]) then {
							(_currentConfig # 2) setVehicleAmmo 1;
							_smokePos = _firePosition getPos [(random 15),(random 360)];
							_smokePos set [2,0.25];
							_smokeShell = createVehicle ['SmokeShellRed',_smokePos,[],0,'NONE'];
							_smokeShell setVehiclePosition [(getPosWorld _smokeShell),[],0,'NONE'];
							_smokeShell setPosATL [((getPosWorld _smokeShell) # 0),((getPosWorld _smokeShell) # 1),50];
							(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smokeShell,'DELAYED_FORCED',(time + 60)];
							missionNamespace setVariable ['QS_AI_fireMissions',((missionNamespace getVariable 'QS_AI_fireMissions') + [[_firePosition,50,(serverTime + 45)]]),QS_system_AI_owners];
							[0,_grpLeader,_firePosition,((magazines (_currentConfig # 2)) # 0),(round (2 + (random 6)))] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
						};
					};
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'SERVICES') then {
			if (alive _currentConfig_vehicle) then {
				if ((_grp getVariable ['QS_AI_GRP_services',[]]) isEqualTo []) then {
					_grp setVariable ['QS_AI_GRP_services',[((getRepairCargo _currentConfig_vehicle) > 0),((getFuelCargo _currentConfig_vehicle) > 0),((getAmmoCargo _currentConfig_vehicle) > 0)],FALSE];
				};
				_nearEntities = (_currentConfig_vehicle nearEntities [['LandVehicle','Air'],50]) - [_currentConfig_vehicle];
				if (_nearEntities isNotEqualTo []) then {
					private _v = objNull;
					{
						_v = _x;
						if (alive _v) then {
							if ((_grp getVariable ['QS_AI_GRP_services',[FALSE,FALSE,FALSE]]) # 0) then {
								if (((damage _v) > 0) || {(((getAllHitPointsDamage _v) isNotEqualTo []) && {((((getAllHitPointsDamage _v) # 2) findIf {(_x > 0)}) isNotEqualTo -1)})}) then {
									_v setDamage [0,TRUE];
								};
							};
							if ((_grp getVariable ['QS_AI_GRP_services',[FALSE,FALSE,FALSE]]) # 1) then {
								if ((fuel _v) < 0.95) then {
									if (local _v) then {
										_v setFuel 1;
									} else {
										[_v,1] remoteExec ['setFuel',_v,FALSE];
									};
								};
							};
							if ((_grp getVariable ['QS_AI_GRP_services',[FALSE,FALSE,FALSE]]) # 2) then {
								if (local _v) then {
									_v setVehicleAmmo 1;
								} else {
									[_v,1] remoteExec ['setVehicleAmmo',_v,FALSE];
								};
							};
						};
					} forEach _nearEntities;
				};
				if (_currentCommand isNotEqualTo 'SUPPORT') then {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (60 + (random 60))),-1],FALSE];
						_movePos set [2,1];
						if (alive (driver _currentConfig_vehicle)) then {
							if (((vectorMagnitude (velocity _currentConfig_vehicle)) * 3.6) < 2) then {
								doStop (driver _currentConfig_vehicle);
								if ((driver _currentConfig_vehicle) isEqualTo _grpLeader) then {
									(driver _currentConfig_vehicle) commandMove _movePos;
								} else {
									(driver _currentConfig_vehicle) doMove _movePos;
								};
								_grp setFormDir (_currentConfig_vehicle getDir _movePos);
							};
						};
					};
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'AIR_PATROL_CAS') then {
		if (alive _grpLeader) then {
			if !(_grp isNil 'QS_AI_GRP_fireMission') then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(serverTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) > 0.5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 600),(random 360)];
					} else {
						if ((random 1) > 0.5) then {
							if (((markerPos 'QS_marker_sideMarker') # 0) > 0) then {
								_movePos = (markerPos 'QS_marker_sideMarker') getPos [(random 600),(random 360)];
							} else {
								_movePos = [(random worldSize),(random worldSize),500];
							};
						} else {
							_movePos = [(random worldSize),(random worldSize),500];
						};
					};
					_movePos set [2,500];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'AIR_PATROL_FIGHTER') then {
		if (alive _grpLeader) then {
			if !(_grp isNil 'QS_AI_GRP_fireMission') then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(serverTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) > 0.5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 600),(random 360)];
					} else {
						if ((random 1) > 0.5) then {
							if (((markerPos 'QS_marker_sideMarker') # 0) > 0) then {
								_movePos = (markerPos 'QS_marker_sideMarker') getPos [(random 600),(random 360)];
							} else {
								_movePos = [(random worldSize),(random worldSize),500];
							};
						} else {
							_movePos = [(random worldSize),(random worldSize),500];
						};
					};
					if (!(attackEnabled _grp)) then {
						_grp enableAttack TRUE;
					};
					_movePos set [2,500];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'AIR_PATROL_UAV') then {
		if (alive _grpObjectParent) then {
			_grpObjectParent setFuel 1;
		};
		if (alive _grpLeader) then {
			if !(_grp isNil 'QS_AI_GRP_fireMission') then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
					_grp setCombatMode 'RED';
					_grp setBehaviour 'AWARE';
					if (!(attackEnabled _grp)) then {
						_grp enableAttack TRUE;
					};
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(serverTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) > 0.5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 600),(random 360)];
					} else {
						if ((random 1) > 0.5) then {
							if (((markerPos 'QS_marker_sideMarker') # 0) > 0) then {
								_movePos = (markerPos 'QS_marker_sideMarker') getPos [(random 600),(random 360)];
							} else {
								_movePos = [(random worldSize),(random worldSize),500];
							};
						} else {
							_movePos = [(random worldSize),(random worldSize),500];
						};
					};
					_movePos set [2,500];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'BOAT_PATROL') then {
		if (_currentTask_type isEqualTo 'BOAT_PATROL') then {
			if (alive _currentConfig_vehicle) then {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (60 + (random 60))),-1],FALSE];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'GENERAL') then {
		if (_currentConfig_minor isEqualTo 'INF_VIPER') then {
			if (_currentTask_type isEqualTo 'HUNT') then {
				private _defaultMove = TRUE;
				if (_grpPath) then {
					private _targetBuilding = objNull;
					if ((missionNamespace getVariable ['QS_AI_hostileBuildings',[]]) isNotEqualTo []) then {
						{
							if ((_grpLeader distance2D _x) < 500) exitWith {
								_targetBuilding = _x;
							};
						} forEach (missionNamespace getVariable ['QS_AI_hostileBuildings',[]]);
						if (!isNull _targetBuilding) then {
							_QS_script = [_grp,[_targetBuilding,(count (_targetBuilding buildingPos -1))],240] spawn (missionNamespace getVariable 'QS_fnc_searchNearbyBuilding');
							missionNamespace setVariable ['QS_AI_scripts_moveToBldg',((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') + [serverTime + 240]),QS_system_AI_owners];
							_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,QS_system_AI_owners];
							_defaultMove = FALSE;
						};
					};
				};
				if (_defaultMove) then {
					[7,EAST,_grp,_grpLeader,_grpObjectParent,400] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
					_targets = _grp targets [TRUE,400];
					if (_targets isEqualTo []) then {
						if ( ((_grp getVariable ['QS_AI_GRP_DATA',[[0,0,0]]]) # 0) isNotEqualTo [0,0,0] ) then {
							_movePos = (_grp getVariable ['QS_AI_GRP_DATA',[[0,0,0]]]) # 0;
							if ((_grpLeader distance2D _movePos) > 30) then {
								_grp move _movePos;
								_grp setFormDir (_grpLeader getDir _movePos);
							} else {
								if (attackEnabled _grp) then {
									_grp enableAttack FALSE;
								};
								{
									if ((_x distance2D _movePos) < 30) then {
										if ((unitPos _x) in ['Up','Auto']) then {
											_x setUnitPos (selectRandomWeighted ['Down',0.5,'Middle',0.5]);
										};
									};
								} forEach (units _grp);
								if (_grpBehaviour isNotEqualTo 'STEALTH') then {
									_grp setBehaviour 'STEALTH';
								};
							};
						};
					} else {
						_targets = _targets select {(((vehicle _x) isKindOf 'CAManBase') && (isTouchingGround (vehicle _x)))};
						private _rating = -9999;
						private _target = objNull;
						{
							if ((rating _x) > _rating) then {
								_target = _x;
								_rating = rating _x;
							};
						} count _targets;
						if (!isNull _target) then {
							if (!(attackEnabled _grp)) then {
								_grp enableAttack TRUE;
							};
							if ((_grp knowsAbout _target) < 2) then {
								_grp reveal [_target,4];
							};
							_grp move (getPosATL _target);
							_grp setFormDir (_grpLeader getDir _target);
							{
								if ((unitPos _x) in ['Down','Middle']) then {
									_x setUnitPos 'Auto';
								};
							} forEach (units _grp);
							if (_grpBehaviour isNotEqualTo 'STEALTH') then {
								_grp setBehaviour 'STEALTH';
							};
						};
					};
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (90 + (random 90))),-1],FALSE];
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'INFANTRY') then {
			if (_currentTask_type isEqualTo 'MOVE') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grpLeader distance2D _currentTask_position) > 30) then {
						_grp move _currentTask_position;
						_grp setFormDir (_grpLeader getDir _movePos);
					};
				};
			};

			if (_currentTask_type isEqualTo 'PATROL') then {
				_patrolIndex = _grp getVariable ['QS_AI_GRP_PATROLINDEX',0];
				_patrolPos = _currentTask_position # _patrolIndex;
				if (
					(_grpIsReady && ((_grpLeader distance2D _patrolPos) < 50)) || 
					{(_uiTime > _currentTask_timeout)}
				) then {
					if (_patrolIndex >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (180 + (random 180))),-1],FALSE];
					if (isNull _grpObjectParent) then {
						_grp move _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
						
						// DEBUG
						{
							if ((_x distance2D _grpLeader) > 100) then {
								_x doFollow _grpLeader;
							};
						} forEach (units _grp);
					} else {
						if (alive (driver _grpObjectParent)) then {
							doStop (driver _grpObjectParent);
							if ((driver _grpObjectParent) isEqualTo _grpLeader) then {
								(driver _grpObjectParent) commandMove _movePos;
							} else {
								(driver _grpObjectParent) doMove _movePos;
							};
							_grp setFormDir (_grpLeader getDir _movePos);
						};
					};
				} else {
					if (
						(isNull _grpObjectParent) &&
						{((_grpLeader distance2D _patrolPos) >= 50)} &&
						{(((vectorMagnitude (velocity _grpLeader)) * 3.6) < 1)}
					) then {
						_grp move _patrolPos;
						_grp setFormDir (_grpLeader getDir _patrolPos);
					};
				};
			};
			
			
			
			
			if (_currentTask_type isEqualTo 'ASSAULT') then {
			
			};
			if (_currentTask_type isEqualTo 'ATTACK') then {
				if (!(attackEnabled _grp)) then {
					_grp enableAttack TRUE;
				};
			};
			if (_currentTask_type isEqualTo 'ATTACK_2') then {
				if (!(attackEnabled _grp)) then {
					_grp enableAttack TRUE;
				};
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_movePos = _currentTask_position;
					if ((_grpLeader distance2D _movePos) > 50) then {
						_grp move _movePos;
						_grp setFormDir (_grpLeader getDir _movePos);
					} else {
						private _unitMovePos = _movePos;
						private _grpUnit = objNull;
						private _nearestEnemy = objNull;
						private _enemyPos = [0,0,0];
						{
							_grpUnit = _x;
							_unitMovePos = _currentTask_position vectorAdd [0,0,1.5];
							if ((random 1) > 0.5) then {
								_nearestEnemy = _grpUnit findNearestEnemy _grpUnit;
								if (alive _nearestEnemy) then {
									if ((_nearestEnemy distance2D _movePos) < 50) then {
										_grpUnit doMove ((getPosATL _nearestEnemy) vectorAdd [0,0,1]);
									} else {
										_grpUnit doMove _unitMovePos;
									};
								} else {
									_grpUnit doMove _unitMovePos;
								};
							} else {
								_grpUnit doMove _unitMovePos;
							};
						} forEach (units _grp);
					};
					_grp setVariable ['QS_AI_GRP_TASK',['ATTACK_2',_currentTask_position,(_uiTime + (random [20,30,60]))],FALSE];
				};
			};
			if (_currentTask_type isEqualTo 'DEFEND') then {
				/* WIP */
			};
			if (_currentTask_type isEqualTo 'GUARD') then {
				/* WIP */
				_currentData params ['','',['_radius',50],['_location','']];
				if (attackEnabled _grp) then {
					_grp enableAttack FALSE;
				};
				{
					if (_x checkAIFeature 'PATH') then {
						if ((_x distance2D _currentTask_position) > _radius) then {
							doStop _x;
							if (
								((random 1) > 0.5) &&
								{(_location isEqualTo 'HQ')} &&
								{((missionNamespace getVariable ['QS_classic_terrainData',[ [],[],[],[],[],[],[],[],[],[] ] ]) # 9) isNotEqualTo []}
							) then {
								_x doMove (selectRandom ((missionNamespace getVariable ['QS_classic_terrainData',[ [],[],[],[],[],[],[],[],[],[] ]]) # 9));
							} else {
								_x doMove (_currentTask_position getPos [_radius * (sqrt (random 1)),random 360]);
							};
						} else {
							if ((random 1) > 0.75) then {
								_x doMove (_currentTask_position getPos [_radius * (sqrt (random 1)),random 360]);
							};
						};
					};
				} forEach (units _grp);
			};
			if (_currentTask_type isEqualTo 'BLDG_GARRISON') then {
				/* WIP */

			};
		};
		if (_currentConfig_minor isEqualTo 'DIVER') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (180 + (random 180))),-1],FALSE];
					_movePos set [2,(_grpLeader getVariable ['QS_AI_UNIT_swimDepth',(_movePos # 2)])];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'VEHICLE') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if (alive _currentConfig_vehicle) then {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (90 + (random 90))),-1],FALSE];
						_movePos set [2,1];
						if (alive (driver _currentConfig_vehicle)) then {
							if (((vectorMagnitude (velocity _currentConfig_vehicle)) * 3.6) < 2) then {
								doStop (driver _currentConfig_vehicle);
								if (canSuspend) then {sleep 0.1;};
								(driver _currentConfig_vehicle) doMove _movePos;
								_grp setFormDir (_currentConfig_vehicle getDir _movePos);
							};
						};
					};
				};
			};
			if (_currentTask_type isEqualTo 'MOVE') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_currentConfig_vehicle distance2D _currentTask_position) > 30) then {
						if (alive (driver _currentConfig_vehicle)) then {
							doStop (driver _currentConfig_vehicle);
							if ((driver _currentConfig_vehicle) isEqualTo _grpLeader) then {
								(driver _currentConfig_vehicle) commandMove _movePos;
							} else {
								(driver _currentConfig_vehicle) doMove _movePos;
							};
							_grp setFormDir (_currentConfig_vehicle getDir _movePos);
						};
					};
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if !(_grp isNil 'QS_AI_GRP_fireMission') then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,QS_system_AI_owners];
					};
				} else {
					if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(serverTime + (30 + (random 30))),-1],FALSE];
						_currentConfig_vehicle land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
							doStop (driver _currentConfig_vehicle);
							if (canSuspend) then {sleep 0.1;};
							(driver _currentConfig_vehicle) doMove _movePos;
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
							doStop (driver _currentConfig_vehicle);
							if (canSuspend) then {sleep 0.1;};
							(driver _currentConfig_vehicle) doMove _movePos;
						};
						_grp setFormDir (_currentConfig_vehicle getDir _movePos);
					};
				};
			};
		};
	};
};