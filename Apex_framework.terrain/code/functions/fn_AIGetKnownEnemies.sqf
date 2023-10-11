/*/
File: fn_AIGetKnownEnemies.sqf
Author:

	Quiksilver

Last Modified:

	29/11/2022 A3 2.10 by Quiksilver
	
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
		private _allJetTypes = ['cas_plane'] call QS_data_listVehicles;
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
				{
					if (alive _x) then {
						if (local _x) then {
							_unit = _x;
							{
								if (alive _x) then {
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
									if (
										(_knownByGroup) &&
										{((_targetPosition distance2D _basePosition) > _baseRadius)} &&
										{((_positionError <= 50) || {(_knownVehicle isKindOf 'Air')})} &&
										{(_targetPosition isNotEqualTo [0,0,0])}
									) then {
										_targetIndexMem = (missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') findIf {((_x # 2) isEqualTo _knownVehicle)};
										if (_targetIndexMem isEqualTo -1) then {
											if ((_knownVehicle isKindOf 'Tank') || {(_knownVehicle isKindOf 'Wheeled_APC_F')}) then {
												_threat_armor pushBackUnique _knownVehicle;
											} else {
												if ((toLowerANSI (typeOf _knownVehicle)) in _allJetTypes) then {
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
									uiSleep 0.003;
								};
							} forEach (units _west);
							uiSleep 0.003;
						};
					};
				} forEach (units _side);
				missionNamespace setVariable ['QS_AI_targetsKnowledge_EAST',(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST'),TRUE];		//QS_system_AI_owners
				// Analyze intel, could also plug into objective/mission consideration
				if (_analyze) then {
					{
						missionNamespace setVariable _x;
					} forEach [
						['QS_AI_targetsKnowledge_threat_armor',(count _threat_armor),QS_system_AI_owners],
						['QS_AI_targetsKnowledge_threat_armor_entities',_threat_armor,QS_system_AI_owners],
						['QS_AI_targetsKnowledge_threat_air',(count _threat_air),QS_system_AI_owners],
						['QS_AI_targetsKnowledge_threat_air_entities',_threat_air,QS_system_AI_owners]
					];
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
	_targetPositions = ([0,1,_side] call (missionNamespace getVariable 'QS_fnc_AIGetKnownEnemies')) inAreaArray [_centerPos,_centerRadius,_centerRadius,0,FALSE];
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
	private _vehicleClass = '';
	{
		_vehicle = _x # 2;
		if (
			(alive _vehicle) &&
			{(!(_vehicle isKindOf 'CAManBase'))} &&
			{(((crew _vehicle) findIf {((alive _x) && ((side (group _x)) in [WEST]))}) isNotEqualTo -1)} &&
			{((_vehicle distance2D _position) < _radius)} &&
			{(!(_vehicle in _vehicles))}
		) then {
			_val = _vehicle getVariable ['QS_vehicle_armored',-1];
			if (_val isEqualType -1) then {
				_vehicleClass = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_vehicleclass',toLowerANSI (typeOf _vehicle)],
					{(toLowerANSI (getText ((configOf _vehicle) >> 'vehicleClass')))},
					TRUE
				];
				_val = _vehicleClass in ['armored'];
				_vehicle setVariable ['QS_vehicle_armored',_val,QS_system_AI_owners];
			};
			if (_val isEqualType FALSE) then {
				if (_val) then {
					_return = _return + 1;
					_vehicles pushBack _vehicle;
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
	private _supportTypes = [];
	{
		_vehicle = _x # 2;
		if (
			(alive _vehicle) &&
			{(_vehicle isKindOf 'Plane')} &&
			{(alive (effectiveCommander _vehicle))} &&
			{(!(_vehicle in _vehicles))}
		) then {
			_val = _vehicle getVariable ['QS_vehicle_isCAS',-1];
			if (_val isEqualType -1) then {
				_supportTypes = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_availableforsupporttypes',toLowerANSI (typeOf _vehicle)],
					{(getArray ((configOf _vehicle) >> 'availableForSupportTypes')) apply {toLowerANSI _x}},
					TRUE
				];
				_val = 'cas_bombing' in _supportTypes;
				_vehicle setVariable ['QS_vehicle_isCAS',_val,QS_system_AI_owners];
			};
			if (_val isEqualType FALSE) then {
				if (_val) then {
					_return = _return + 1;
					_vehicles pushBack _vehicle;
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
			if (
				(alive _vehicle) &&
				{(isTouchingGround _vehicle)} &&
				{(_vehicle isKindOf 'AllVehicles')} &&
				{(!(_vehicle isKindOf 'CAManBase'))} &&
				{((_vehicle distance2D _position) < _radius)} &&
				{(((crew _vehicle) findIf {((alive _x) && ((side (group _x)) in [WEST]))}) isNotEqualTo -1)}
			) then {
				_vehicles pushBackUnique _vehicle;
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
			if ((random 1) > 0.333) then {
				_targetEntity = _x # 0;
				_targetVehicle = _x # 2;
				if (alive _targetEntity) then {
					if ((_targetEntity distance2D _grpLeader) < _radius) then {
						if ((_grp knowsAbout _targetEntity) < 1) then {
							_return pushBack _targetEntity;
							_grp reveal [_targetEntity,(random [1,2,3])];
						};
						if (alive _targetVehicle) then {
							if ((_grp knowsAbout _targetVehicle) < 1) then {
								_return pushBackUnique _targetVehicle;
								_grp reveal [_targetVehicle,(random [1,2,3])];
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	_return;
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
							_return pushBack _targetEntity;
							_grp reveal [_targetEntity,(random [1.5,2,3.5])];
						};
						if (alive _targetVehicle) then {
							if ((_grp knowsAbout _targetVehicle) < 1) then {
								_return pushBackUnique _targetVehicle;
								_grp reveal [_targetVehicle,(random [1.5,2,3.5])];
							};
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	_return;
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
				
				if (
					(alive _targetVehicle) &&
					{(((crew _targetVehicle) findIf {((alive _x) && ((side (group _x)) in [WEST]))}) isNotEqualTo -1)} &&
					{((_targetVehicle isKindOf 'LandVehicle') || {(_targetVehicle isKindOf 'Air')})} &&
					{(alive _targetEntity)} &&
					{((_targetEntity distance2D _grpLeader) < 1000)}
				) then {
					if ((_grp knowsAbout _targetEntity) < 1) then {
						_return pushBack _targetEntity;
						_grp reveal [_targetEntity,(random [2,3,4])];
					};
					if ((_grp knowsAbout _targetVehicle) < 1) then {
						_return pushBackUnique _targetVehicle;
						_grp reveal [_targetVehicle,(random [2,3,4])];
					};
				};
			};
		} forEach _targetsKnowledge;
		{
			_targetVehicle = objectParent _x;
			if (
				(!isTouchingGround _targetVehicle) &&
				{(_targetVehicle isKindOf 'Plane')} &&
				{((EAST knowsAbout _targetVehicle) > 3.5)}
			) then {
				_return pushBack _targetVehicle;
				_grp reveal [_targetVehicle,(EAST knowsAbout _targetVehicle)];
			};
		} forEach allPlayers;
	};
	_return;
};
if (_type isEqualTo 10) exitWith {
	// Check for Tanks/Armor globally
	private _vehicle = objNull;
	private _val = -1;
	_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
	{
		_vehicle = _x # 2;
		if (
			(alive _vehicle) &&
			{(alive (effectiveCommander _vehicle))} &&
			{(((crew _vehicle) findIf {((alive _x) && ((side (group _x)) in [WEST]))}) isNotEqualTo -1)} &&
			{((_vehicle isKindOf 'Tank') || {(_vehicle isKindOf 'Wheeled_APC_F')})}
		) then {
			_return pushBack _vehicle;
		};
	} forEach _targetsKnowledge;
	_return;
};
if (_type isEqualTo 11) exitWith {
	params ['','',['_assault',FALSE]];
	// Update hostile buildings
	private _vehicle = objNull;
	private _return = [];
	private _return2 = [];
	private _return3 = [];
	if ((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isNotEqualTo []) then {
		_targetsKnowledge = missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]];
		_fn_inHouse = missionNamespace getVariable 'QS_fnc_inHouse';
		{
			_vehicle = _x # 2;
			if (alive _vehicle) then {
				if (
					(_vehicle isKindOf 'CAManBase') &&
					{((lifeState _vehicle) in ['HEALTHY','INJURED'])} &&
					{(!captive _vehicle)}
				) then {
					if ((_x # 7) > 2) then {
						([_vehicle,(getPosWorld _vehicle)] call _fn_inHouse) params ['_inHouse','_house'];
						if (_inHouse) then {
							_return pushBackUnique _house;
							{
								_return2 pushBackUnique _x;
								_return3 pushBack _x;
							} forEach (_house buildingPos -1);
						};
					};
				};
			};
		} forEach _targetsKnowledge;
	};
	missionNamespace setVariable ['QS_AI_hostileBuildings',_return,QS_system_AI_owners];
	missionNamespace setVariable ['QS_AI_hostileBuildings_positions',_return2,QS_system_AI_owners];
	// Assault building
	if (_assault) then {
		if (
			(_return isNotEqualTo []) &&
			(_return2 isNotEqualTo []) &&
			{((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3)}
		) then {
			private _targetBuilding = selectRandom _return;
			private _grp = grpNull;
			private _leader = objNull;
			private _found = FALSE;
			private _QS_script = scriptNull;
			private _validGroups = [];
			{
				if (local _x) then {
					_grp = _x;
					_leader = leader _grp;
					// Validate groups
					if (
						(_leader checkAIFeature 'PATH') &&
						{(({((lifeState _x) in ['HEALTHY','INJURED'])} count (units _grp)) isNotEqualTo 0)} &&
						{(isNull (objectParent _leader))} &&
						{(!((behaviour _leader) in ['STEALTH']))} &&
						{(attackEnabled _grp)} &&
						{(scriptDone (_grp getVariable ['QS_AI_GRP_SCRIPT',scriptNull]))} &&
						{((count (missionNamespace getVariable ['QS_AI_scripts_moveToBldg',[]])) < 3)} &&
						{(!(_grp getVariable ['QS_AI_GRP_disableBldgPtl',FALSE]))} &&
						{((_targetBuilding buildingPos -1) isNotEqualTo [])}
					) then {
						_validGroups pushBack _grp;
					};
				};
			} forEach ((groups EAST) + (groups RESISTANCE));
			if (_validGroups isNotEqualTo []) then {
				_grp = grpNull;
				private _dist = 999999;
				private _max = _dist;
				{
					_dist = (leader _x) distance2D _targetBuilding;
					if (_dist < _max) then {
						_max = _dist;
						_grp = _x;
					};
				} forEach _validGroups;
				if (!isNull _grp) then {
					_QS_script = [_grp,[_targetBuilding,(count (_targetBuilding buildingPos -1))],180] spawn (missionNamespace getVariable 'QS_fnc_searchNearbyBuilding');
					missionNamespace setVariable ['QS_AI_scripts_moveToBldg',((missionNamespace getVariable 'QS_AI_scripts_moveToBldg') + [serverTime + 180]),QS_system_AI_owners];
					_grp setVariable ['QS_AI_GRP_SCRIPT',_QS_script,QS_system_AI_owners];
				};
			};
		};
	};
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
			if (
				(alive _vehicle) &&
				{(isTouchingGround _vehicle)} &&
				{(_vehicle isKindOf 'AllVehicles')} &&
				{((_vehicle distance2D _targetPos) < _targetRad)} &&
				{(((crew _vehicle) findIf {((alive _x) && ((side (group _x)) in [WEST]))}) isNotEqualTo -1)}
			) then {
				_targets pushBackUnique _vehicle;
			};
		} forEach _targetsKnowledge;
	};
	_targets;
};
if (_type isEqualTo 13) exitWith {
	params ['','','_isArty','_supportProvider','_supportShells'];
	_data = [['',0]];
	_enemySides = [_side] call (missionNamespace getVariable 'QS_fnc_enemySides');
	_fn_isStealthy = missionNamespace getVariable 'QS_fnc_getVehicleStealth';
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
						_cost = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_cost',toLowerANSI (typeOf _vehicle)],
							{getNumber ((configOf _vehicle) >> 'cost')},
							TRUE
						];
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
			if ((count ((units _side) inAreaArray [_targetPosition,50,50,0,FALSE,-1])) <= 4) then {
				if (_targetCost > _costThreshold) then {
					if (!(_isArty)) then {
						_targetingData pushBack _x;
					} else {
						if (_targetPosition inRangeOfArtillery [[gunner _supportProvider],_supportShells]) then {
							if (
								((missionNamespace getVariable ['QS_AI_fireMissions',[]]) isEqualTo []) || 
								{(((missionNamespace getVariable ['QS_AI_fireMissions',[]]) findIf {(((_x # 0) distance2D _targetPosition) < (_x # 1))}) isEqualTo -1)}
							) then {
								_targetingData pushBack _x;
							};
						};
					};
				};
			};
		} forEach _data;
		if (_targetingData isNotEqualTo []) then {
			_targetingData = _targetingData select [0,3];
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