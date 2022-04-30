/*/
File: fn_AIHandleGroup.sqf
Author: 

	Quiksilver

Last Modified:

	8/05/2019 A3 1.92 by Quiksilver

Description:

	Handle Group AI
_______________________________________________________/*/

params ['_grp','_uiTime','_fps'];
private _grpLeader = leader _grp;
if (!(simulationEnabled _grpLeader)) exitWith {};
if (!(_grp getVariable ['QS_AI_GRP_SETUP',FALSE])) then {
	_grp setVariable ['QS_AI_GRP_SETUP',TRUE,FALSE];
	_grp setVariable ['QS_AI_GRP_rv',[(random 1),(random 1),(random 1)],FALSE];
	if (isNil {_grp getVariable 'QS_AI_GRP_CONFIG'}) then {
		_grp setVariable ['QS_AI_GRP_CONFIG',[-1,-1,-1],FALSE];
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_DATA'}) then {
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_TASK'}) then {
		_grp setVariable ['QS_AI_GRP_TASK',[-1,-1,-1,-1],FALSE];
	};
	if (!isNull (objectParent _grpLeader)) then {
		{
			_x disableAI 'COVER';
		} forEach (units _grp);
		if (((objectParent _grpLeader) isKindOf 'LandVehicle') || {((objectParent _grpLeader) isKindOf 'Ship')} || {((objectParent _grpLeader) isKindOf 'Helicopter')} || {(unitIsUav (objectParent _grpLeader))}) then {
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
		if (isNil {_grp getVariable 'QS_AI_GRP_vUnstuck'}) then {
			_grp setVariable ['QS_AI_GRP_vUnstuck',(_uiTime + 300),FALSE];
		};
	} else {
		if ((random 1) > 0.75) then {
			{
				_x disableAI 'COVER';
				_x disableAI 'AUTOCOMBAT';
			} forEach (units _grp);
		};
	};
	if (!isNil {_grp getVariable 'QS_AI_GRP_canNearTargets'}) then {
		if (isNil {_grp getVariable 'QS_AI_GRP_nearTargets'}) then {
			_grp setVariable ['QS_AI_GRP_nearTargets',[],FALSE];
			_grp setVariable ['QS_AI_GRP_lastNearTargets',_uiTime,FALSE];
		};
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_evalNearbyBuilding'}) then {
		_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + 60),FALSE];
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_allEnvSoundControllers'}) then {
		_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers (getPosATL _grpLeader)),FALSE];
		_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',_uiTime,FALSE];
	};
};
private _grpLeaderLifestate = lifeState _grpLeader;
if (!(_grpLeaderLifestate in ['HEALTHY','INJURED'])) then {
	private _grpUnits = (units _grp) select {((alive _x) && ((lifeState _x) in ['HEALTHY','INJURED']))};
	if (_grpUnits isNotEqualTo []) then {
		_grpUnits = _grpUnits apply {[rankId _x,_x]};
		_grpUnits sort FALSE;
		_grp selectLeader ((_grpUnits # 0) # 1);
		_grpLeader = leader _grp;
		_grpLeaderLifestate = lifeState _grpLeader;
	};
};
_grpAttackTarget = getAttackTarget _grpLeader;
_grpLeaderPosition = getPosATL _grpLeader;
_grpObjectParent = objectParent _grpLeader;
_grpMorale = morale _grpLeader;
_grpBehaviour = behaviour _grpLeader;
_grpCombatBehaviour = combatBehaviour _grp;
_grpSpeedMode = speedMode _grp;
_grpCombatMode = combatMode _grp;
_grpFormation = formation _grp;
_grpDestination = expectedDestination _grpLeader;
private _grpIsReady = (((unitReady _grpLeader) && (isNull _grpObjectParent)) || {((_grpDestination # 1) isEqualTo 'DoNotPlan')});
private _movePos = _grpLeaderPosition;
_currentConfig = _grp getVariable 'QS_AI_GRP_CONFIG';
_currentConfig params ['_currentConfig_major','_currentConfig_minor','_currentConfig_grpSize',['_currentConfig_vehicle',objNull]];
_currentData = _grp getVariable 'QS_AI_GRP_DATA';
_currentTask = _grp getVariable 'QS_AI_GRP_TASK';
_currentTask params ['_currentTask_type','_currentTask_position','_currentTask_timeout'];
if (isNull _grpObjectParent) then {
	if (_uiTime > (_grp getVariable 'QS_AI_GRP_lastEnvSoundCtrl')) then {
		_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',(_uiTime + (30 + (random 30))),FALSE];
		_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers _grpLeaderPosition),FALSE];
	};
	_envSoundControllers = _grp getVariable ['QS_AI_GRP_allEnvSoundControllers',[]];
	if (_envSoundControllers isNotEqualTo []) then {
		if (((_envSoundControllers # 7) # 1) > 0.3) then {
			if (_grpBehaviour isNotEqualTo 'COMBAT') then {
				if (!(_grpFormation in ['COLUMN','STAG COLUMN'])) then {
					_grp setFormation (selectRandom ['COLUMN','STAG COLUMN']);
				};
			} else {
				if (!(_grpFormation in ['WEDGE','LINE','VEE'])) then {
					_grp setFormation (selectRandom ['WEDGE']);
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
					_grp setFormation (selectRandomWeighted ['WEDGE',0.75,'LINE',0.25]);
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
if (_grp getVariable ['QS_AI_GRP_canNearTargets',TRUE]) then {
	if (_uiTime > (_grp getVariable ['QS_AI_GRP_lastNearTargets',-1])) then {
		if (alive _grpLeader) then {
			if (_grpLeaderLifestate in ['HEALTHY','INJURED']) then {
				if (_fps > 12) then {
					if (isNull _grpObjectParent) then {
						[7,EAST,_grp,_grpLeader,_grpObjectParent,250] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
					} else {
						if (((_grpObjectParent isKindOf 'LandVehicle') && (!(_grpObjectParent isKindOf 'Static'))) || {(_grpObjectParent isKindOf 'Ship')}) then {
							[8,EAST,_grp,_grpLeader,_grpObjectParent] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
						} else {
							if (_grpObjectParent isKindOf 'Air') then {
								[9,EAST,_grp,_grpLeader,_grpObjectParent] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
							};
						};
					};
					if ((random 1) > 0.666) then {
						_targets = _grpLeader targets [TRUE,600];
						_grp setVariable ['QS_AI_GRP_nearTargets',[_targets,(count _targets)],FALSE];
					};
				};
			};
		};
		_grp setVariable ['QS_AI_GRP_lastNearTargets',(_uiTime + (60 + (random 60))),FALSE];
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
if ((_uiTime > _currentTask_timeout) || {(((lifeState _grpLeader) in ['HEALTHY','INJURED']) && _grpIsReady)})  then {
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
					if ((unitPos _grpLeader) isNotEqualTo 'AUTO') then {
						{
							_x setUnitPos 'AUTO';
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
				if ((unitPos _grpLeader) isNotEqualTo 'AUTO') then {
					{
						_x setUnitPos 'AUTO';
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
						if (!isNil {_location getVariable 'QS_virtualSectors_terrainData'}) then {
							_buildingPositions = (_location getVariable ['QS_virtualSectors_terrainData',[ [],[],[],[],[] ]]) # 3;
							if (!isNil '_buildingPositions') then {
								if (_buildingPositions isNotEqualTo []) then {
									_movePos = selectRandom _buildingPositions;
									_movePos set [2,((_movePos # 2) + 1)];
									{
										doStop _x;
										_x doMove _movePos;
									} forEach (units _grp);
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
					if ((unitPos _grpLeader) isNotEqualTo 'MIDDLE') then {
						{
							_x setUnitPos 'MIDDLE';
						} count (units _grp);
					};
				} else {
					if (_grpSpeedMode isNotEqualTo 'FULL') then {
						_grp setSpeedMode 'FULL';
					};
					if ((unitPos _grpLeader) isNotEqualTo 'AUTO') then {
						{
							_x setUnitPos 'AUTO';
						} count (units _grp);
					};					
				};
				if (!surfaceIsWater _movePos) then {
					private _defaultMove = TRUE;
					if (_fps > 10) then {
						if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
							if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
								_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
								if ((random 1) > 0.75) then {
									if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
										if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
											_QS_script = [_grp,[],180,200,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
											(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
											_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
											_defaultMove = FALSE;
										};
									};
								};
							};
						};
					};
					if (!isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
						_defaultMove = FALSE;
					};
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
				private _unit = objNull;
				{
					if ((random 1) > 0.5) then {
						{
							_unit forgetTarget _x;
						} forEach (_unit targets [TRUE,0]);
					};
					doStop _unit;
					_unit doMove _movePos;
				} forEach (units _grp);
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
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (300 + (random 300))),-1],FALSE];					
					private _defaultMove = TRUE;
					if (_fps > 10) then {
						if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
							if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
								_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
								if ((random 1) > 0.75) then {
									if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
										if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
											_QS_script = [_grp,[],180,200,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
											(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
											_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
											_defaultMove = FALSE;
										};
									};
								};
							};
						};
					};
					if (!isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
						_defaultMove = FALSE;
					};
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
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (90 + (random 90))),-1],FALSE];
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
				if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
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
		if (_currentConfig_minor isEqualTo 'BLDG_GARRISON') then {
			if (_currentTask_type isEqualTo 'BLDG_GARRISON') then {

			};
		};
	};
	if (_currentConfig_major isEqualTo 'AO') then {
		if (_currentConfig_minor isEqualTo 'AIR_PATROL_HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
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
			if (_currentTask_type isEqualTo 'PATROL') then {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
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
						if (!isNil {_grp getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
							if (_uiTime > (_grp getVariable 'QS_AI_GRP_MTR_cooldown')) then {
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',nil,FALSE];
							};
						} else {
							if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
								_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
								_fireMission params ['_firePosition','_fireShells','_fireRounds'];
								_allPlayerCount = count allPlayers;
								private _cooldown = 0;
								if (_allPlayerCount < 20) then {
									_cooldown = 480 + (random 480);
								};
								if (_allPlayerCount >= 20) then {
									_cooldown = 120 + (random 120);
								};
								if (_allPlayerCount >= 40) then {
									_cooldown = 60 + (random 60);
								};
								if (_firePosition inRangeOfArtillery [[_grpLeader],_fireShells]) then {
									_grp setVariable ['QS_AI_GRP_DATA',[FALSE,(_uiTime + _cooldown)],FALSE];								
									_handle = [0,_grpLeader,_firePosition,_fireShells,_fireRounds] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
									(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;
								};
								_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',(diag_tickTime + _cooldown),FALSE];
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
							missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
							(missionNamespace getVariable ['QS_AI_fireMissions',[]]) pushBack [_firePosition,50,(diag_tickTime + 45)];
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
				_nearEntities = (_currentConfig_vehicle nearEntities [['LandVehicle','Air'],30]) select {(_x isNotEqualTo _currentConfig_vehicle)};
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
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (60 + (random 60))),-1],FALSE];
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
	if (_currentConfig_major isEqualTo 'AIR_PATROL_CAS') then {
		if (alive _grpLeader) then {
			if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
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
			if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
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
		if (alive _grpLeader) then {
			if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission # 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					_grp setCombatMode 'RED';
					_grp setBehaviourStrong 'AWARE';
					if (!(attackEnabled _grp)) then {
						_grp enableAttack TRUE;
					};
				};
			} else {
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
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
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (60 + (random 60))),-1],FALSE];
					_grp move _movePos;
					_grp setFormDir (_grpLeader getDir _movePos);
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'GENERAL') then {
		if (_currentConfig_minor isEqualTo 'INF_VIPER') then {
			if (_currentTask_type isEqualTo 'HUNT') then {
				[7,EAST,_grp,_grpLeader,_grpObjectParent,400] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
				_targets = _grpLeader targets [TRUE,400];
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
									if ((unitPos _x) in ['UP','AUTO']) then {
										_x setUnitPos (selectRandomWeighted ['DOWN',0.5,'MIDDLE',0.5]);
									};
								};
							} forEach (units _grp);
							if (_grpBehaviour isNotEqualTo 'STEALTH') then {
								_grp setBehaviourStrong 'STEALTH';
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
							if ((unitPos _x) in ['DOWN','MIDDLE']) then {
								_x setUnitPos 'AUTO';
							};
							_x setUnitPosWeak 'MIDDLE';
						} forEach (units _grp);
						if (_grpBehaviour isNotEqualTo 'STEALTH') then {
							_grp setBehaviourStrong 'STEALTH';
						};
					};
				};
				_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (90 + (random 90))),-1],FALSE];
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
				if (_grpIsReady || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
					if (isNull _grpObjectParent) then {
						private _defaultMove = TRUE;
						if (_fps > 10) then {
							if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
								if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
									_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
									if ((random 1) > 0.75) then {
										if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
											if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
												_QS_script = [_grp,[],180,200,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
												(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
												_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
												_defaultMove = FALSE;
											};
										};
									};
								};
							};
						};
						if (!isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
							_defaultMove = FALSE;
						};
						if (_defaultMove) then {
							_grp move _movePos;
							_grp setFormDir (_grpLeader getDir _movePos);
						};
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
					_movePos = selectRandom _currentTask_position;
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
							_unitMovePos = selectRandom _currentTask_position;
							_unitMovePos set [2,((_unitMovePos # 2) + 1.5)];
							if ((random 1) > 0.5) then {
								_nearestEnemy = _grpUnit findNearestEnemy _grpUnit;
								if (alive _nearestEnemy) then {
									if ((_nearestEnemy distance2D _movePos) < 50) then {
										_grpUnit doMove (getPosATL _nearestEnemy);
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
			
			};
			if (_currentTask_type isEqualTo 'BLDG_GARRISON') then {

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
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
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
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (90 + (random 90))),-1],FALSE];
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
				if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission # 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position # (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
						_currentConfig_vehicle land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
							doStop (driver _currentConfig_vehicle);
							(driver _currentConfig_vehicle) doMove _movePos;
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
							doStop (driver _currentConfig_vehicle);
							(driver _currentConfig_vehicle) doMove _movePos;
						};
						_grp setFormDir (_currentConfig_vehicle getDir _movePos);
					};
				};
			};
		};
	};
};