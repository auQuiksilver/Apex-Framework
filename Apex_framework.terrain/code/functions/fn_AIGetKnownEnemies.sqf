/*/
File: fn_AIGetKnownEnemies.sqf
Author:

	Quiksilver

Last Modified:

	8/04/2018 A3 1.82 by Quiksilver
	
Description:

	AI Get Known Enemies
	
To Do:

	- Identify tight groups of players for fire support attack
	- Analyze after collation
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
			if ((diag_fps > 12) && (!(missionNamespace getVariable ['QS_AI_targetsKnowledge_suspend',_false]))) then {
				if (!((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') isEqualTo [])) then {
					missionNamespace setVariable [
						'QS_AI_targetsKnowledge_EAST',
						((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') select {((alive (_x select 0)) && (((_x select 0) distance2D _basePosition) > _baseRadius) && ((_east knowsAbout (_x select 0)) > 0) && (!((_x select 3) isEqualTo 0)))}),
						_false
					];
				};
				_threat_armor = [];
				_threat_air = [];
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
													if (_positionError <= 10) then {
														if (!(_targetPosition isEqualTo [0,0,0])) then {
															_targetIndexMem = ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') findIf {((_x select 2) isEqualTo _knownVehicle)});
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
																_targetElement = ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') select _targetIndexMem);
																_positionErrorMem = _targetElement select 3;
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
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_armor',(count _threat_armor),FALSE];
					missionNamespace setVariable ['QS_AI_targetsKnowledge_threat_air',(count _threat_air),FALSE];
				};
			};
			uiSleep 5;
		};
		_return;
	};
};
if (_type isEqualTo 1) exitWith {
	// Find nearest unit or unit position
	_referencePosition = _this select 3;
	_targetPositions = [0,1,_side] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies');
	if (!(_targetPositions isEqualTo [])) then {
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
	if ((!(_targetPositions isEqualTo [])) && (!(_sectorPositions isEqualTo [])) && (!(_centerPos isEqualTo [0,0,0]))) then {
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
					_return set [_sectorIndex,((_return select _sectorIndex) + 1)];
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
		_vehicle = _x select 2;
		if (alive _vehicle) then {
			if (!(_vehicle isKindOf 'Man')) then {
				if (!(((crew _vehicle) findIf {(alive _x)}) isEqualTo -1)) then {
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
		_vehicle = _x select 2;
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
};
if (_type isEqualTo 6) exitWith {
	_position = param [2];
	_radius = param [3];
	// Check for vehicles in area
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			_vehicle = _x select 2;
			if (alive _vehicle) then {
				if (_vehicle isKindOf 'AllVehicles') then {
					if (!(_vehicle isKindOf 'CAManBase')) then {
						if ((_vehicle distance2D _position) < _radius) then {
							if (!(_vehicle in _vehicles)) then {
								if (isTouchingGround _vehicle) then {
									_vehicles pushBack _vehicle;
								};
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
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.5) then {
				_targetEntity = _x select 0;
				_targetVehicle = _x select 2;
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
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.333) then {
				_targetEntity = _x select 0;
				_targetVehicle = _x select 2;
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
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			if ((random 1) > 0.25) then {
				_targetEntity = _x select 0;
				_targetVehicle = _x select 2;
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
	};
};
if (_type isEqualTo 10) exitWith {
	// Check for Tanks/Armor globally
	private _return = [];
	private _vehicle = objNull;
	private _val = -1;
	_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
	{
		_vehicle = _x select 2;
		if (alive _vehicle) then {
			if ((_vehicle isKindOf 'Tank') || {(_vehicle isKindOf 'Wheeled_APC_F')}) then {
				if (alive (effectiveCommander _vehicle)) then {
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
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			_vehicle = _x select 2;
			if (alive _vehicle) then {
				if (_vehicle isKindOf 'CAManBase') then {
					if ((_x select 7) > 2) then {
						if ((_vehicle distance2D (nearestBuilding _vehicle)) < 25) then {
							([_vehicle,(getPosWorld _vehicle)] call (missionNamespace getVariable 'QS_fnc_inHouse')) params ['_inHouse','_house'];
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
	_position = param [2];
	_radius = param [3];
	// Check for vehicles in area
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _targets = [];
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		{
			_vehicle = _x select 2;
			if (alive _vehicle) then {
				if (_vehicle isKindOf 'AllVehicles') then {
					if ((_vehicle distance2D _position) < _radius) then {
						if (!(_vehicle in _targets)) then {
							if (isTouchingGround _vehicle) then {
								_targets pushBack _vehicle;
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	_targets;
};
_return;