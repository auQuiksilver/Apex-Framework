/*/
File: fn_AIGetKnownEnemies.sqf
Author:

	Quiksilver

Last Modified:

	6/10/2018 A3 1.84 by Quiksilver
	
Description:

	AI Get Known Enemies
________________________________________________________/*/

params ['_type','_side'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	if (canSuspend) then {
		scriptName 'QS AI Targets Knowledge';
		private _time = time;
		_true = TRUE;
		_false = FALSE;
		_east = EAST;
		_west = WEST;
		private _enemySides = [_side] call (missionNamespace getVariable 'QS_fnc_enemySides');
		private _unit = objNull;
		private _knownUnit = objNull;
		private _knownVehicle = objNull;
		private _targetKnowledge = [];
		private _targetKnowledgeMem = [];
		private _unitPositionMem = [0,0,0];
		private _positionErrorMem = -1;
		private _targetIndexMem = -1;
		private _targetElement = [];
		private _allUnits = allUnits;
		private _allUnitsEast = [];
		private _allUnitsWest = [];
		private _analyze = _true;
		private _threat_armor = [];
		private _threat_air = [];
		private _allJetTypes = [
			'b_plane_cas_01_f',
			'b_plane_cas_01_dynamicloadout_f',
			'b_plane_cas_01_cluster_f',
			'b_plane_fighter_01_f',
			'b_plane_fighter_01_stealth_f',
			'b_plane_fighter_01_cluster_f',
			'o_plane_cas_02_f',
			'o_plane_cas_02_dynamicloadout_f',
			'o_plane_cas_02_cluster_f',
			'o_plane_fighter_02_f',
			'o_plane_fighter_02_stealth_f',
			'o_plane_fighter_02_cluster_f',
			'i_plane_fighter_03_aa_f',
			'i_plane_fighter_03_cas_f',
			'i_plane_fighter_03_dynamicloadout_f',
			'i_plane_fighter_03_cluster_f',
			'i_plane_fighter_04_f',
			'i_plane_fighter_04_cluster_f'
		];
		_basePosition = markerPos 'QS_marker_base_marker';
		_baseRadius = 1000;
		for '_x' from 0 to 1 step 0 do {
			if ((diag_fps > 10) && (!(missionNamespace getVariable ['QS_AI_targetsKnowledge_suspend',_false]))) then {
				if ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') isNotEqualTo []) then {
					missionNamespace setVariable [
						'QS_AI_targetsKnowledge_EAST',
						((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') select {((alive (_x # 0)) && (((_x # 0) distance2D _basePosition) > _baseRadius) && ((_east knowsAbout (_x # 0)) > 0) && ((_x # 3) isNotEqualTo 0))}),
						_false
					];
				};
				_threat_armor = _threat_armor select {((alive _x) && ((_east knowsAbout _x) > 3))};
				_threat_air = _threat_air select {((alive _x) && (!isTouchingGround _x) && ((_east knowsAbout _x) > 3))};
				_allUnits = allUnits;
				{
					if (alive _x) then {
						if (local _x) then {
							if ((side _x) isEqualTo _side) then {
								_unit = _x;
								{
									if (alive _x) then {
										if ((side _x) isEqualTo _west) then {
											_knownUnit = _x;
											_knownVehicle = vehicle _knownUnit;
											(_unit targetKnowledge _knownVehicle) params [
												'_knownByGroup',
												'',
												'_timeLastSeen',
												'',
												'',
												'_positionError',
												'_targetPosition'
											];
											if (_knownByGroup) then {
												if ((_targetPosition distance2D _basePosition) > _baseRadius) then {
													if ((_positionError <= 50) || {(_knownVehicle isKindOf 'Air')}) then {		// <= 10
														if (_targetPosition isNotEqualTo [0,0,0]) then {
															_targetIndexMem = ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') findIf {((_x # 2) isEqualTo _knownVehicle)});
															if (_targetIndexMem isEqualTo -1) then {
																if ((_knownVehicle isKindOf 'Tank') || {(_knownVehicle isKindOf 'Wheeled_APC_F')}) then {
																	_threat_armor pushBackUnique _knownVehicle;
																} else {
																	if ((toLower (typeOf _knownVehicle)) in _allJetTypes) then {
																		_threat_air pushBackUnique _knownVehicle;
																	};
																};
																(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') pushBack [_knownUnit,_targetPosition,_knownVehicle,(parseNumber (_positionError toFixed 3)),_unit,(parseNumber ((_time - _timeLastSeen) toFixed 3)),(rating _knownUnit),(_east knowsAbout _knownVehicle)];
															} else {
																_targetElement = ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') # _targetIndexMem);
																_positionErrorMem = _targetElement # 3;
																if ((_positionError < _positionErrorMem) || {((_time - _timeLastSeen) > 60)}) then {
																	_targetElement = [_knownUnit,_targetPosition,_knownVehicle,(parseNumber (_positionError toFixed 3)),_unit,(parseNumber ((_time - _timeLastSeen) toFixed 3)),(rating _knownUnit),(_east knowsAbout _knownVehicle)];
																	(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') set [_targetIndexMem,_targetElement];
																};
															};
														};
													};
												};
											};
											uiSleep 0.003;
										};
									};
								} forEach _allUnits;
								uiSleep 0.003;
							};
						};
					};
				} forEach _allUnits;
				// Analyze intel, could also plug into objective/mission consideration
				if (_analyze) then {
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_armor',(count _threat_armor),_false];
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_armor_entities',_threat_armor,_false];
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_air',(count _threat_air),_false];
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_air_entities',_threat_air,_false];
				};
			};
			uiSleep 5;
		};
		_return;
	};
};
if (_type isEqualTo 1) exitWith {
	// Find nearest unit or unit position
	_referencePosition = _this # 3;
	_targetPositions = [0,1,_side] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
	if (_targetPositions isNotEqualTo []) then {
		_return = [0,0,0];
		private _targetDistance = 0;
		{
			_targetDistance = _x distance2D _referencePosition;
			if (_targetDistance < _return) then {
				_return = _x;
			};
		} forEach _targetPositions;
	};
	_return;
};
if (_type isEqualTo 2) exitWith {
	// SC sort by nearest sector and organize into array by most active sector to least active sector
	_sort = param [3,FALSE];
	_return = [];
	_centerPos = missionNamespace getVariable ['QS_AOpos',[0,0,0]];
	_centerRadius = (missionNamespace getVariable ['QS_aoSize',600]) * 2;
	_sectorPositions = missionNamespace getVariable ['QS_virtualSectors_positions',[]];	
	_targetPositions = ([0,1,_side] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) select {((_x distance2D _centerPos) < _centerRadius)};
	if ((_targetPositions isNotEqualTo []) && (_sectorPositions isNotEqualTo []) && (_centerPos isNotEqualTo [0,0,0])) then {
		_return = [0,0,0];
		private _targetPosition = [0,0,0];
		private _sectorPosition = [0,0,0];
		private _sectorIndex = -1;
		{
			_sectorPosition = _x;
			_sectorIndex = _forEachIndex;
			{
				_targetPosition = _x;
				if ((_targetPosition distance2D _sectorPosition) < 150) then {
					_return set [_sectorIndex,((_return # _sectorIndex) + 1)];
				};
			} forEach _targetPositions;
		} forEach _sectorPositions;
		_return sort _sort;
	};
	_return;
};
if (_type isEqualTo 3) exitWith {
	_position = param [2];
	_radius = param [3];
	// Check for armor in area
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
	{
		_vehicle = _x # 2;
		if (alive _vehicle) then {
			if (!(_vehicle isKindOf 'Man')) then {
				if (((crew _vehicle) findIf {(alive _x)}) isNotEqualTo -1) then {
					if ((_vehicle distance2D _position) < _radius) then {
						if (!(_vehicle in _vehicles)) then {
							_val = _vehicle getVariable ['QS_vehicle_armored',-1];
							if (_val isEqualType -1) then {
								_val = (toLower (getText (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'vehicleClass'))) in ['armored'];
								_vehicle setVariable ['QS_vehicle_armored',_val,FALSE];
							};
							if (_val isEqualType FALSE) then {
								if (_val) then {
									_return = _return + 1;
									_vehicles pushBack _vehicle;
								};
							};
						};
					};
				};
			};
		};
	} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	_return;
};
if (_type isEqualTo 4) exitWith {
	// Check for CAS/AA globally
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
	{
		_vehicle = _x # 2;
		if (alive _vehicle) then {
			if (_vehicle isKindOf 'Plane') then {
				if (alive (effectiveCommander _vehicle)) then {
					if (!(_vehicle in _vehicles)) then {
						_val = _vehicle getVariable ['QS_vehicle_isCAS',-1];
						if (_val isEqualType -1) then {
							_val = 'CAS_Bombing' in (getArray (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'availableForSupportTypes'));
							_vehicle setVariable ['QS_vehicle_isCAS',_val,FALSE];
						};
						if (_val isEqualType FALSE) then {
							if (_val) then {
								_return = _return + 1;
								_vehicles pushBack _vehicle;
							};
						};
					};
				};
			};
		};
	} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	_return;
};
if (_type isEqualTo 5) exitWith {
	// Get highest-rated enemy
	
	/*/
		if ((random 1) > 0.5) then {
			_target = selectRandom _filteredTargets;
		} else {
			private _rating = -9999;
			{
				if ((rating _x) > _rating) then {
					_target = _x;
					_rating = rating _x;
				};
			} count _filteredTargets;
		};
	/*/
};
if (_type isEqualTo 6) exitWith {
	_position = param [2];
	_radius = param [3];
	// Check for vehicles in area
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			_vehicle = _x # 2;
			if (alive _vehicle) then {
				if (isTouchingGround _vehicle) then {
					if (_vehicle isKindOf 'AllVehicles') then {
						if (!(_vehicle isKindOf 'CAManBase')) then {
							if ((_vehicle distance2D _position) < _radius) then {
								_vehicles pushBackUnique _vehicle;
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	_vehicles;
};
if (_type isEqualTo 7) exitWith {
	params ['','','_grp','_grpLeader','_objectParent',['_radius',200]];
	// Infantry info-receiving
	// Nearby enemies
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.5) then {
				_targetEntity = _x # 0;
				_targetVehicle = _x # 2;
				if (alive _targetEntity) then {
					if ((_targetEntity distance2D _grpLeader) < _radius) then {
						if ((_grp knowsAbout _targetEntity) < 1) then {
							_grp reveal [_targetEntity,(random [1,2,3])];
						};
						if (alive _targetVehicle) then {
							if ((_grp knowsAbout _targetEntity) < 1) then {
								_grp reveal [_targetEntity,(random [1,2,3])];
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
};
if (_type isEqualTo 8) exitWith {
	params ['','','_grp','_grpLeader','_objectParent'];
	// Vehicle/Ship info-receiving
	// Nearby enemies, wider radius
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.333) then {
				_targetEntity = _x # 0;
				_targetVehicle = _x # 2;
				if (alive _targetEntity) then {
					if ((_targetEntity distance2D _grpLeader) < 1000) then {
						if ((_grp knowsAbout _targetEntity) < 1) then {
							_grp reveal [_targetEntity,(random [1.5,2,3.5])];
						};
						if (alive _targetVehicle) then {
							if ((_grp knowsAbout _targetEntity) < 1) then {
								_grp reveal [_targetEntity,(random [1.5,2,3.5])];
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
};
if (_type isEqualTo 9) exitWith {
	params ['','','_grp','_grpLeader','_objectParent'];
	// Aircraft info-receiving
	// Priority targets like tanks and other aircraft
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.25) then {
				_targetEntity = _x # 0;
				_targetVehicle = _x # 2;
				if (alive _targetVehicle) then {
					if ((_targetVehicle isKindOf 'LandVehicle') || {(_targetVehicle isKindOf 'Air')}) then {
						if (alive _targetEntity) then {
							if ((_targetEntity distance2D _grpLeader) < 1000) then {
								if ((_grp knowsAbout _targetEntity) < 1) then {
									_grp reveal [_targetEntity,(random [2,3,4])];
								};
								if ((_grp knowsAbout _targetEntity) < 1) then {
									_grp reveal [_targetEntity,(random [2,3,4])];
								};
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
		{
			_targetVehicle = objectParent _x;
			if (!isTouchingGround _targetVehicle) then {
				if (_targetVehicle isKindOf 'Plane') then {
					if ((EAST knowsAbout _targetVehicle) > 3.5) then {
						_grp reveal [_targetVehicle,(EAST knowsAbout _targetVehicle)];
					};
				};
			};
		} forEach allPlayers;
	};
};
if (_type isEqualTo 10) exitWith {
	// Check for Tanks/Armor globally
	private _return = [];
	private _vehicle = objNull;
	private _val = -1;
	_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
	{
		_vehicle = _x # 2;
		if (alive _vehicle) then {
			if (alive (effectiveCommander _vehicle)) then {
				if ((_vehicle isKindOf 'Tank') || {(_vehicle isKindOf 'Wheeled_APC_F')}) then {
					_return pushBack _vehicle;
				};
			};
		};
	} forEach _targetsKnowledge;
	_return;
};
if (_type isEqualTo 11) exitWith {
	// Update hostile buildings
	private _vehicle = objNull;
	private _return = [];
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		_fn_inHouse = missionNamespace getVariable 'QS_fnc_inHouse';
		{
			_vehicle = _x # 2;
			if (alive _vehicle) then {
				if (_vehicle isKindOf 'CAManBase') then {
					if ((_x # 7) > 2) then {
						if (((_vehicle distance2D (nearestBuilding _vehicle)) < 25) || ((random 1) > 0.666)) then {
							([_vehicle,(getPosWorld _vehicle)] call _fn_inHouse) params ['_inHouse','_house'];
							if (_inHouse) then {
								_return pushBackUnique _house;
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	missionNamespace setVariable ['QS_AI_hostileBuildings',_return,FALSE];
};
if (_type isEqualTo 12) exitWith {
	// Targets in area
	params [
		'',
		'',
		'_targetPos',
		['_targetRad',100,[0]]
	];
	// Check for vehicles in area
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _targets = [];
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			_vehicle = _x # 2;
			if (alive _vehicle) then {
				if (isTouchingGround _vehicle) then {
					if (_vehicle isKindOf 'AllVehicles') then {
						if ((_vehicle distance2D _targetPos) < _targetRad) then {
							_targets pushBackUnique _vehicle;
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	_targets;
};
if (_type isEqualTo 13) exitWith {
	params ['','','_isArty','_supportProvider','_supportShells'];
	_data = [['',0]];
	_enemySides = [_side] call (missionNamespace getVariable 'QS_fnc_enemySides');
	_fn_isStealthy = {
		params ['_vehicle'];
		private _c = FALSE;	
		if (
			(
				(
					((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) && 
					(((vectorMagnitude (velocity _vehicle)) * 3.6) < 30)
				) || 
				{(!isEngineOn _vehicle)}
			) &&
			{(!isVehicleRadarOn _vehicle)} &&
			{(!isLaserOn _vehicle)} &&
			{(!isOnRoad _vehicle)} &&
			{(!((toLower (surfaceType (getPosWorld _vehicle))) in ['#gdtasphalt']))} &&
			{(
				(((getPosATL _vehicle) getEnvSoundController 'houses') isEqualTo 0) || 
				{(((getPosATL _vehicle) getEnvSoundController 'forest') isEqualTo 1)}
			)}
		) then {
			_c = TRUE;
		};
		_c;
	};
	private _return = [0,0,0];
	private _index = -1;
	private _mapGridPos = '';
	private _cost = -1;
	private _gridCenter = [0,0,0];
	private _gridData = [];
	private _costThreshold = 750;
	_camanbase = 100000;
	_sniper = 350000;
	_staticweapon = 200000;
	_car_f = 300000;
	_wheeled_apc_f = 500000;
	_tank_f = 1000000;
	_air_f = 1000000;
	private _vehicle = objNull;
	{
		_vehicle = _x # 2;
		if ((side _vehicle) in _enemySides) then {
			if ((_vehicle isKindOf 'CAManBase') || {(((vectorMagnitude (velocity _vehicle)) * 3.6) < 30)}) then {
				if ((isTouchingGround _vehicle) && (!(surfaceIsWater (_x # 1)))) then {
					_mapGridPos = mapGridPosition (_x # 1);
					_cost = -1;
					if (_vehicle isKindOf 'CAManBase') then {
						_cost = _camanbase;
						if (_vehicle isKindOf 'B_Soldier_sniper_base_F') then {
							_cost = _sniper;
						};
					};
					if (_vehicle isKindOf 'StaticWeapon') then {
						_cost = _staticweapon;
					};
					if (_vehicle isKindOf 'Car_F') then {
						_cost = [_car_f,(_car_f / 2)] select (_vehicle call _fn_isStealthy);
					};
					if (_vehicle isKindOf 'Wheeled_APC_F') then {
						_cost = [_wheeled_apc_f,(_wheeled_apc_f / 3)] select (_vehicle call _fn_isStealthy);
					};
					if (_vehicle isKindOf 'Tank_F') then {
						_cost = [_tank_f,(_tank_f / 3)] select (_vehicle call _fn_isStealthy);
					};
					if (_cost isEqualTo -1) then {
						_cost = getNumber (configFile >> 'CfgVehicles' >> (typeOf _vehicle) >> 'cost');
					};
					_cost = _cost / 1000;
					_index = _data findIf {((_x # 1) isEqualTo _mapGridPos)};
					if (_index isEqualTo -1) then {
						_data pushBack [_cost,_mapGridPos];
					} else {
						_data set [_index,[(((_data # _index) # 0) + _cost),((_data # _index) # 1)]];
					};
				};
			};
		};
	} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	_data set [0,-1];
	_data deleteAt 0;
	_data sort FALSE;
	if (_data isNotEqualTo []) then {
		{
			_gridData = (_x # 1) call (missionNamespace getVariable 'QS_fnc_gridToPos');
			_gridCenter = [(((_gridData # 0) # 0) + (((_gridData # 1) # 0) / 2)),(((_gridData # 0) # 1) + (((_gridData # 1) # 1) / 2)),0];
			_data set [_forEachIndex,[_x # 0,_gridCenter]];
		} forEach _data;
		private _targetingData = [];
		private _targetWeighted = [];
		private _targetPosition = [0,0,0];
		private _targetCost = -1;
		{
			_targetCost = _x # 0;
			_targetPosition = _x # 1;
			if (([_targetPosition,50,[_side],allUnits,1] call (missionNamespace getVariable 'QS_fnc_serverDetector')) <= 4) then {
				if (_targetCost > _costThreshold) then {
					if (!(_isArty)) then {
						_targetingData pushBack _x;
					} else {
						if (_targetPosition inRangeOfArtillery [[gunner _supportProvider],_supportShells]) then {
							if (((missionNamespace getVariable ['QS_AI_fireMissions',[]]) isEqualTo []) || {(((missionNamespace getVariable ['QS_AI_fireMissions',[]]) findIf {(((_x # 0) distance2D _targetPosition) < (_x # 1))}) isEqualTo -1)}) then {
								_targetingData pushBack _x;
							};
						};
					};
				};
			};
		} forEach _data;
		if (_targetingData isNotEqualTo []) then {
			if ((count _targetingData) > 3) then {
				_targetingData = [_targetingData # 0,_targetingData # 1,_targetingData # 2];
			};
			if ((count _targetingData) > 1) then {
				{
					_targetWeighted pushBack (_x # 1);
					_targetWeighted pushBack ((_x # 0) / 10000);
				} forEach _targetingData;
				_return = selectRandomWeighted _targetWeighted;
			} else {
				_return = (_targetingData # 0) # 1;
			};
		};
	};
	_return;
};
_return;