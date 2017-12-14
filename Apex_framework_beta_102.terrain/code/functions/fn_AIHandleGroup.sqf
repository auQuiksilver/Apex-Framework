/*/
File: fn_AIHandleGroup.sqf
Author: 

	Quiksilver

Last Modified:

	23/11/2017 A3 1.78 by Quiksilver

Description:

	Handle Group AI

Notes:

	getallenvsoundcontrollers
	[
	0	[""rain"",0.000372368],
	1	[""night"",0],
	2	[""wind"",0.0475848],
	3	[""daytime"",0.376854],
	4	[""distance"",6.23892],
	5	[""meadows"",0.333333],
	6	[""trees"",0.333333],
	7	[""houses"",0.373942],
	8	[""forest"",0],
	9	[""sea"",0],
	10	[""coast"",0],
	11	[""altitudeGround"",0],
	12	[""altitudeSea"",0.00143862],
	13	[""shooting"",1],
	14	[""deadBody"",0],
	15	[""fog"",1.62126e-037]
	]
	
https://community.bistudio.com/wiki/Waypoint_types
https://community.bistudio.com/wiki/move
____________________________________________________________________________/*/

params ['_grp','_uiTime','_fps'];
_grpLeader = leader _grp;
if (!(simulationEnabled _grpLeader)) exitWith {};
comment 'Validate variables';
if (isNil {_grp getVariable 'QS_AI_GRP_SETUP'}) then {
	_grp setVariable ['QS_AI_GRP_SETUP',TRUE,FALSE];
	if (isNil {_grp getVariable 'QS_AI_GRP_CONFIG'}) then {
		_grp setVariable ['QS_AI_GRP_CONFIG',[-1,-1,-1],FALSE];
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_DATA'}) then {
		_grp setVariable ['QS_AI_GRP_DATA',[],FALSE];
	};
	if (isNil {_grp getVariable 'QS_AI_GRP_TASK'}) then {
		_grp setVariable ['QS_AI_GRP_TASK',[-1,-1,-1,-1],FALSE];
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
		_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers (position (leader _grp))),FALSE];
		_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',_uiTime,FALSE];
	};
	if (!isNull (objectParent _grpLeader)) then {
		if (isNil {_grp getVariable 'QS_AI_GRP_vUnstuck'}) then {
			_grp setVariable ['QS_AI_GRP_vUnstuck',(_uiTime + 300),FALSE];
		};
	};
};
_grpLeaderPosition = getPosATL _grpLeader;
_grpLeaderLifestate = lifeState _grpLeader;
_grpBehaviour = behaviour _grpLeader;
_grpSpeedMode = speedMode _grp;
_grpCombatMode = combatMode _grp;
_grpFormation = formation _grp;
private _movePos = _grpLeaderPosition;
_currentConfig = _grp getVariable 'QS_AI_GRP_CONFIG';
_currentConfig params ['_currentConfig_major','_currentConfig_minor','_currentConfig_grpSize','_currentConfig_vehicle'];
_currentData = _grp getVariable 'QS_AI_GRP_DATA';
_currentTask = _grp getVariable 'QS_AI_GRP_TASK';
_currentTask params ['_currentTask_type','_currentTask_position','_currentTask_timeout'];
comment 'Get env info at group leader position';
if (_uiTime > (_grp getVariable 'QS_AI_GRP_lastEnvSoundCtrl')) then {
	_grp setVariable ['QS_AI_GRP_lastEnvSoundCtrl',(_uiTime + (30 + (random 30))),FALSE];
	_grp setVariable ['QS_AI_GRP_allEnvSoundControllers',(getAllEnvSoundControllers _grpLeaderPosition),FALSE];
};
_envSoundControllers = _grp getVariable ['QS_AI_GRP_allEnvSoundControllers',[]];
if (!(_envSoundControllers isEqualTo [])) then {
	comment 'Formation';
	if (((_envSoundControllers select 7) select 1) > 0.3) then {
		comment 'Houses';
		if (!(_grpBehaviour isEqualTo 'COMBAT')) then {
			if (!(_grpFormation in ['COLUMN','STAG COLUMN'])) then {
				_grp setFormation (selectRandom ['COLUMN','STAG COLUMN']);
			};
		} else {
			if (!(_grpFormation in ['WEDGE','LINE','VEE'])) then {
				_grp setFormation (selectRandom ['WEDGE']);
			};
		};
	} else {
		comment 'Forest';
		if (((_envSoundControllers select 8) select 1) > 0.3) then {
			if (!(_grpBehaviour isEqualTo 'COMBAT')) then {
				if (!(_grpFormation in ['DIAMOND','FILE'])) then {
					_grp setFormation (selectRandom ['DIAMOND','FILE']);
				};
			} else {
				if (!(_grpFormation in ['WEDGE','LINE','VEE'])) then {
					_grp setFormation (selectRandom ['WEDGE']);
				};
			};
		} else {
			if (!(_grpFormation in ['WEDGE'])) then {
				_grp setFormation (selectRandom ['WEDGE']);
			};
		};
	};
	comment 'Skill';
	if ((_envSoundControllers select 8) isEqualTo 1) then {
		if (isNil {_grp getVariable 'QS_AI_GRP_skillAccuracy'}) then {
			_grp setVariable ['QS_AI_GRP_skillAccuracy',(_grpLeader skillFinal 'aimingAccuracy'),FALSE];
		};
		if (!((_grpLeader skillFinal 'aimingAccuracy') isEqualTo ((_grp getVariable 'QS_AI_GRP_skillAccuracy') * 0.5))) then {
			{
				if (alive _x) then {
					_x setSkill ['aimingAccuracy',((_grp getVariable 'QS_AI_GRP_skillAccuracy') * 0.5)];
					_x setSkill ['spotDistance',0.325];
					_x setSkill ['spotTime',0.325];
				};
			} forEach (units _grp);
		};
	} else {
		if (!isNil {_grp getVariable 'QS_AI_GRP_skillAccuracy'}) then {
			if (!((_grpLeader skillFinal 'aimingAccuracy') isEqualTo (_grp getVariable 'QS_AI_GRP_skillAccuracy'))) then {
				{
					if (alive _x) then {
						_x setSkill ['aimingAccuracy',(_grp getVariable 'QS_AI_GRP_skillAccuracy')];
						_x setSkill ['spotDistance',0.65];
						_x setSkill ['spotTime',0.65];
					};
				} forEach (units _grp);
			};
		};
	};
};

comment 'Near Targets';
if (_grp getVariable ['QS_AI_GRP_canNearTargets',FALSE]) then {
	if (_uiTime > (_grp getVariable ['QS_AI_GRP_lastNearTargets',-1])) then {
		if (alive _grpLeader) then {
			if (_grpLeaderLifestate in ['HEALTHY','INJURED']) then {
				if (_fps >= 15) then {
					_targets = _grpLeader targets [TRUE,300];
					_grp setVariable ['QS_AI_GRP_nearTargets',[_targets,(count _targets)],FALSE];
				};
			};
		};
		_grp setVariable ['QS_AI_GRP_lastNearTargets',(_uiTime + (90 + (random 90))),FALSE];
	};
};
/*/ WUT??? /*/
if (_grp getVariable ['QS_AI_GRP_regrouping',FALSE]) exitWith {
	if (({(alive _x)} count (units _grp)) > 1) then {
		_grp setVariable ['QS_AI_GRP_regrouping',FALSE,FALSE];
	} else {
		if ((_grpLeader distance2D (_grp getVariable 'QS_AI_GRP_regroupPos')) > 100) then {
			_grpLeader forceSpeed -1;
			_grpLeader doMove (_grp getVariable 'QS_AI_GRP_regroupPos');
		};
	};
};
/*/ WUT??? /*/
if ((_uiTime > _currentTask_timeout) || {(((lifeState _grpLeader) in ['HEALTHY','INJURED']) && (unitReady _grpLeader))})  then {
	if (_currentConfig_major isEqualTo 'SC') then {
		comment 'SC';
		if (_currentTask_type isEqualTo 'ATTACK') then {
			comment 'ATTACK';
			private _position = _grpLeaderPosition;
			{
				_position = [_x,_grpLeaderPosition,(side _grp)] call (missionNamespace getVariable 'QS_fnc_scGetNearestSector');
				if (!(_position isEqualTo [])) exitWith {};
			} forEach [2,3];
			if (_position isEqualTo []) then {	
				_position = [1,_grpLeaderPosition,WEST] call (missionNamespace getVariable 'QS_fnc_scGetNearestSector');
			};
			if (!(_position isEqualTo [])) then {
				if ((_position distance2D _grpLeader) > 50) then {
					_movePos = [((_position select 0) + (50 - (random 100))),((_position select 1) + (50 - (random 100))),(_position select 2)];
					if (surfaceIsWater _movePos) then {
						for '_x' from 0 to 11 step 1 do {
							_movePos = [((_position select 0) + (50 - (random 100))),((_position select 1) + (50 - (random 100))),(_position select 2)];
							if (!surfaceIsWater _movePos) exitWith {};
						};
					};
					if (!((unitPos _grpLeader) isEqualTo 'AUTO')) then {
						{
							_x setUnitPos 'AUTO';
						} count (units _grp);
					};
					if (!((speedMode _grp) isEqualTo 'FULL')) then {
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
				_movePos = [((_position select 0) + (150 - (random 300))),((_position select 1) + (150 - (random 300))),(_position select 2)];
				if (surfaceIsWater _movePos) then {
					for '_x' from 0 to 11 step 1 do {
						_movePos = [((_position select 0) + (150 - (random 300))),((_position select 1) + (150 - (random 300))),(_position select 2)];
						if (!surfaceIsWater _movePos) exitWith {};
					};
				};
				if (!((unitPos _grpLeader) isEqualTo 'AUTO')) then {
					{
						_x setUnitPos 'AUTO';
					} forEach (units _grp);
				};
				if (!((speedMode _grp) isEqualTo 'FULL')) then {
					_grp setSpeedMode 'FULL';
				};
				if (!surfaceIsWater _movePos) then {
					_grp setFormDir (_grpLeaderPosition getDir _movePos);
					{
						_x forceSpeed -1;
					} forEach (units _grp);
					_grp move _movePos;
					_grp setVariable ['QS_AI_GRP_TASK',['ATTACK',_movePos,(_uiTime + 60)],FALSE];
				};
			};
		};
		if (_currentTask_type isEqualTo 'DEFEND') then {
			comment 'DEFEND';
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
					_locationData = _currentData select 3;
					if (!(_locationData isEqualTo [])) then {
						_location = _locationData select 0;
						if (!isNil {_location getVariable 'QS_virtualSectors_terrainData'}) then {
							_buildingPositions = (_location getVariable ['QS_virtualSectors_terrainData',[ [],[],[],[],[] ]]) select 3;
							if (!isNil '_buildingPositions') then {
								if (!(_buildingPositions isEqualTo [])) then {
									_movePos = selectRandom _buildingPositions;
									_movePos set [2,((_movePos select 2) + 1)];
									{
										_x forceSpeed -1;
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
					if (!(_grpSpeedMode isEqualTo 'NORMAL')) then {
						_grp setSpeedMode 'NORMAL';
					};
					if (!((unitPos _grpLeader) isEqualTo 'MIDDLE')) then {
						{
							_x setUnitPos 'MIDDLE';
						} count (units _grp);
					};
				} else {
					if (!(_grpSpeedMode isEqualTo 'FULL')) then {
						_grp setSpeedMode 'FULL';
					};
					if (!((unitPos _grpLeader) isEqualTo 'AUTO')) then {
						{
							_x setUnitPos 'AUTO';
						} count (units _grp);
					};					
				};
				if (!surfaceIsWater _movePos) then {
					private _defaultMove = TRUE;
					if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
						if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
							_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
							if ((random 1) > 0.75) then {
								if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
									if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
										_QS_script = [_grp,[],180,150,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
										(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
										_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
										_defaultMove = FALSE;
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
						if (!isNil 'INF_PATROL_RADIAL_DOMOVE') then {
							comment 'DEBUG TESTING';
							{
								_x forceSpeed -1;
								_x doMove _movePos;
							} forEach (units _grp);
						};
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
					_unit forceSpeed -1;
					_unit doMove _movePos;
				} forEach (units _grp);
				_grp setVariable ['QS_AI_GRP_TASK',['ASSAULT',_movePos,(_uiTime + 15)],FALSE];
			};
		};
		if (_currentConfig_minor isEqualTo 'INF_PATROL_RADIAL') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (300 + (random 300))),-1],FALSE];					
					private _defaultMove = TRUE;
					if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
						if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
							_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
							if ((random 1) > 0.75) then {
								if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
									if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
										_QS_script = [_grp,[],180,150,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
										(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
										_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
										_defaultMove = FALSE;
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
						if (!isNil 'INF_PATROL_RADIAL_DOMOVE') then {
							comment 'DEBUG TESTING';
							{
								_x forceSpeed -1;
								_x doMove _movePos;
							} forEach (units _grp);
						};
					};					
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'VEH_PATROL') then {
			if (_currentTask_type isEqualTo 'PATROL_VEH') then {
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					_vehicle = _currentConfig select 3;
					if (!isNull _vehicle) then {
						if (alive _vehicle) then {
							if (((vectorUp _vehicle) select 2) < 0.1) then {
								if (_vehicle isKindOf 'LandVehicle') then {
									_position = position _vehicle;
									_vehicle setPos [(random -100),(random -100),(random 100)];
									_vehicle setVectorUp (surfaceNormal _position);
									_vehicle setDamage (damage _vehicle);
									_vehicle setPos [(_position select 0),(_position select 1),((_position select 2) + 0.25)];
								};
							};
							if (!canMove _vehicle) then {
								comment 'Request engineer or repair vehicle';
							};
						};
					};
					
					
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (90 + (random 90))),-1],FALSE];
					_movePos set [2,1];
					{
						if (_x isEqualTo (driver (vehicle _x))) then {
							_x doMove _movePos;
						};
					} forEach (units _grp);
				};
			};
		};		
		if (_currentConfig_minor isEqualTo 'AIR_PATROL_HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission select 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
						(vehicle (leader _grp)) land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
							/*/_grp move _movePos;/*/
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
						};
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
					if (_uiTime > (_fireMission select 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
						(vehicle (leader _grp)) land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
						};
					};
				};
			};
		};
	
		if (_currentConfig_minor isEqualTo 'UAV_PATROL_RADIAL') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
					_grp move _movePos;
				};
			};
		};
	};
	
	
	if (_currentConfig_major isEqualTo 'SUPPORT') then {
		if (_currentConfig_minor isEqualTo 'MORTAR') then {
			if (alive _grpLeader) then {
				if ((vehicle _grpLeader) isEqualTo (_currentConfig select 2)) then {
					if (!(_currentData select 0)) then {
						if (_uiTime > (_currentData select 1)) then {
							_grp setVariable ['QS_AI_GRP_DATA',[TRUE,(_uiTime - 1)],FALSE];
							(vehicle _grpLeader) setVehicleAmmo 1;
						};
					};
					if ((_grp getVariable 'QS_AI_GRP_DATA') select 0) then {
						if (!isNil {_grp getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
							if (_uiTime > (_grp getVariable 'QS_AI_GRP_MTR_cooldown')) then {
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',nil,FALSE];
							};
						} else {
							if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
								_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
								_fireMission params ['_firePosition','_fireShells','_fireRounds'];
								if (_firePosition inRangeOfArtillery [[_grpLeader],_fireShells]) then {
									_grp setVariable ['QS_AI_GRP_DATA',[FALSE,(_uiTime + (180 + (120 + (random 120))))],FALSE];								
									_handle = [0,_grpLeader,_firePosition,_fireShells,_fireRounds] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
									(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;
								};
								_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
								_allPlayerCount = count allPlayers;
								private _cooldown = 0;
								if (_allPlayerCount < 20) then {
									_cooldown = 480 + (random 480);
								};
								if (_allPlayerCount >= 20) then {
									_cooldown = 300 + (random 300);
								};
								if (_allPlayerCount >= 40) then {
									_cooldown = 240 + (random 240);
								};
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',(diag_tickTime + _cooldown),FALSE];
							};
						};
					};
				};
			};
		};
		if (_currentConfig_minor isEqualTo 'ARTILLERY') then {
			if (alive _grpLeader) then {
				if ((vehicle _grpLeader) isEqualTo (_currentConfig select 2)) then {
					if (!(_currentData select 0)) then {
						if (_uiTime > (_currentData select 1)) then {
							_grp setVariable ['QS_AI_GRP_DATA',[TRUE,(_uiTime - 1)],FALSE];
							(vehicle _grpLeader) setVehicleAmmo 1;
						};
					};
					if ((_grp getVariable 'QS_AI_GRP_DATA') select 0) then {
						if (!isNil {_grp getVariable 'QS_AI_GRP_MTR_cooldown'}) then {
							if (_uiTime > (_grp getVariable 'QS_AI_GRP_MTR_cooldown')) then {
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',nil,FALSE];
							};
						} else {
							if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
								_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
								_fireMission params ['_firePosition','_fireShells','_fireRounds'];
								if (_firePosition inRangeOfArtillery [[_grpLeader],_fireShells]) then {
									_grp setVariable ['QS_AI_GRP_DATA',[FALSE,(_uiTime + (180 + (180 + (random 180))))],FALSE];								
									_handle = [0,_grpLeader,_firePosition,_fireShells,_fireRounds] spawn (missionNamespace getVariable 'QS_fnc_AIFireMission');
									(missionNamespace getVariable 'QS_AI_scripts_fireMissions') pushBack _handle;
								};
								_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
								_allPlayerCount = count allPlayers;
								private _cooldown = 0;
								if (_allPlayerCount < 20) then {
									_cooldown = 480 + (random 480);
								};
								if (_allPlayerCount >= 20) then {
									_cooldown = 300 + (random 300);
								};
								if (_allPlayerCount >= 40) then {
									_cooldown = 240 + (random 240);
								};
								_grp setVariable ['QS_AI_GRP_MTR_cooldown',(diag_tickTime + _cooldown),FALSE];
							};
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
				if (_uiTime > (_fireMission select 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
				};
			} else {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) < 0.666) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
					} else {
						_movePos = [(random worldSize),(random worldSize),500];
					};
					_movePos set [2,500];
					_grp move _movePos;
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'AIR_PATROL_FIGHTER') then {
		if (alive _grpLeader) then {
			if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission select 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
				};
			} else {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) > 0.5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
					} else {
						_movePos = [(random worldSize),(random worldSize),500];
					};
					if (!(attackEnabled _grp)) then {
						_grp enableAttack TRUE;
					};
					_movePos set [2,500];
					_grp move _movePos;
				};
			};
		};
	};
	
	if (_currentConfig_major isEqualTo 'AIR_PATROL_UAV') then {
		if (alive _grpLeader) then {
			if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
				_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
				if (_uiTime > (_fireMission select 1)) then {
					_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					_grp setCombatMode 'RED';
					_grp setBehaviour 'AWARE';
					if (!(attackEnabled _grp)) then {
						_grp enableAttack TRUE;
					};
				};
			} else {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					_grp setVariable ['QS_AI_GRP_TASK',['',[],(diag_tickTime + (60 + (random 60))),-1],FALSE];
					if ((random 1) > 0.5) then {
						_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
					} else {
						_movePos = [(random worldSize),(random worldSize),500];
					};
					_movePos set [2,500];
					_grp move _movePos;
				};
			};
		};
	};
	if (_currentConfig_major isEqualTo 'BOAT_PATROL') then {
		if (_currentTask_type isEqualTo 'BOAT_PATROL') then {
			if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
				if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
				};
				_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
				_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
				_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (60 + (random 60))),-1],FALSE];
				_grp move _movePos;
			};
		};
	};
	if (_currentConfig_major isEqualTo 'GENERAL') then {
		if (_currentConfig_minor isEqualTo 'INFANTRY') then {
			if (_currentTask_type isEqualTo 'MOVE') then {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					if ((_grpLeader distance2D _currentTask_position) > 30) then {
						_grp move _currentTask_position;
						{
							_x forceSpeed -1;
							_x doMove _currentTask_position;
						} forEach (units _grp);
					};
				};
			};
		
			if (_currentTask_type isEqualTo 'PATROL') then {
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
					private _defaultMove = TRUE;
					if (!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE])) then {
						if (_uiTime > (_grp getVariable ['QS_AI_GRP_evalNearbyBuilding',0])) then {
							_grp setVariable ['QS_AI_GRP_evalNearbyBuilding',(_uiTime + (random [300,600,900])),FALSE];
							if ((random 1) > 0.75) then {
								if ((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3) then {
									if (isNull (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull])) then {
										_QS_script = [_grp,[],180,150,TRUE] spawn (missionNamespace getVariable 'QS_fnc_patrolNearbyBuilding');
										(missionNamespace getVariable 'QS_AI_scripts_moveToBldg') pushBack _QS_script;
										_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,FALSE];
										_defaultMove = FALSE;
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
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					_movePos = selectRandom _currentTask_position;
					if ((_grpLeader distance2D _movePos) > 50) then {
						_grp move _movePos;
					} else {
						private _unitMovePos = _movePos;
						private _grpUnit = objNull;
						private _nearestEnemy = objNull;
						private _enemyPos = [0,0,0];
						{
							_grpUnit = _x;
							_unitMovePos = selectRandom _currentTask_position;
							_unitMovePos set [2,((_unitMovePos select 2) + 1.5)];
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
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (180 + (random 180))),-1],FALSE];
					_movePos set [2,(_grpLeader getVariable ['QS_AI_UNIT_swimDepth',(_movePos select 2)])];
					_grp move _movePos;
				};
			};
		};
		
		if (_currentConfig_minor isEqualTo 'VEHICLE') then {
			if (_currentTask_type isEqualTo 'PATROL') then {
				if ((unitReady _grpLeader) || {((!(attackEnabled _grp)) && (_uiTime > _currentTask_timeout))}) then {
					if (alive _currentConfig_vehicle) then {
						if (((vectorUp _currentConfig_vehicle) select 2) < 0.1) then {
							if (_currentConfig_vehicle isKindOf 'LandVehicle') then {
								_position = position _currentConfig_vehicle;
								_currentConfig_vehicle setPos [(random -100),(random -100),(random 100)];
								_currentConfig_vehicle setVectorUp (surfaceNormal _position);
								_currentConfig_vehicle setDamage (damage _currentConfig_vehicle);
								_currentConfig_vehicle setPos [(_position select 0),(_position select 1),((_position select 2) + 0.25)];
							};
						};
						if (!canMove _currentConfig_vehicle) then {
							comment 'Request engineer or repair vehicle';
						};
					};
					if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
					};
					_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
					_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
					_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (90 + (random 90))),-1],FALSE];
					_movePos set [2,1];
					{
						if (_x isEqualTo (driver (vehicle _x))) then {
							_x doMove _movePos;
						};
					} forEach (units _grp);
					/*/_grp move _movePos;/*/
				};
			};
			if (_currentTask_type isEqualTo 'MOVE') then {
				if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
					if (alive _currentConfig_vehicle) then {
						if (((vectorUp _currentConfig_vehicle) select 2) < 0.1) then {
							if (_currentConfig_vehicle isKindOf 'LandVehicle') then {
								_position = position _currentConfig_vehicle;
								_currentConfig_vehicle setPos [(random -100),(random -100),(random 100)];
								_currentConfig_vehicle setVectorUp (surfaceNormal _position);
								_currentConfig_vehicle setDamage (damage _currentConfig_vehicle);
								_currentConfig_vehicle setPos [(_position select 0),(_position select 1),((_position select 2) + 0.25)];
							};
						};
						if (!canMove _currentConfig_vehicle) then {
							comment 'Request engineer or repair vehicle';
						};
						if ((_currentConfig_vehicle distance2D _currentTask_position) > 30) then {
							if (({(alive _x)} count (crew _currentConfig_vehicle)) > 0) then {
								/*/(driver _currentConfig_vehicle) doMove _currentTask_position;/*/
							} else {
								/*/_grp move _currentTask_position;/*/
							};
						};
					};
				};
			};
		};

		if (_currentConfig_minor isEqualTo 'HELI') then {
			if (_currentTask_type isEqualTo 'PATROL_AIR') then {
				if (!isNil {_grp getVariable 'QS_AI_GRP_fireMission'}) then {
					_fireMission = _grp getVariable 'QS_AI_GRP_fireMission';
					if (_uiTime > (_fireMission select 1)) then {
						_grp setVariable ['QS_AI_GRP_fireMission',nil,FALSE];
					};
				} else {
					if ((unitReady _grpLeader) || {(_uiTime > _currentTask_timeout)}) then {
						if ((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) >= ((count _currentTask_position) - 1)) then {
							_grp setVariable ['QS_AI_GRP_PATROLINDEX',-1,FALSE];
						};
						_grp setVariable ['QS_AI_GRP_PATROLINDEX',((_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]) + 1),FALSE];
						_movePos = _currentTask_position select (_grp getVariable ['QS_AI_GRP_PATROLINDEX',0]);
						_grp setVariable ['QS_AI_GRP_TASK',[_currentTask_type,_currentTask_position,(diag_tickTime + (30 + (random 30))),-1],FALSE];
						_currentConfig_vehicle land 'NONE';
						if ((random 1) > 0.333) then {
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
						} else {
							_movePos = (missionNamespace getVariable 'QS_AOpos') getPos [(random 1000),(random 360)];
							_movePos set [2,50];
							{
								_x doMove _movePos;
							} forEach (units _grp);
						};
					};
				};
			};
		};
	};
};