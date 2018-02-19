/*/
File: fn_AIGetKnownEnemies.sqf
Author:

	Quiksilver

Last Modified:

	12/02/2018 A3 1.80 by Quiksilver
	
Description:

	AI Get Known Enemies
	
To Do:

	- Identify tight groups of players for fire support attack
________________________________________________________/*/

params ['_type','_side'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	if (canSuspend) then {
		scriptName 'QS AI Targets Knowledge';
		comment 'Build list of either units or unit positions';
		private _time = time;
		private _enemySides = [_side] call (missionNamespace getVariable 'BIS_fnc_enemySides');
		private _unit = objNull;
		private _knownUnit = [];
		private _targetKnowledge = [];
		private _targetKnowledgeMem = [];
		private _unitPositionMem = [0,0,0];
		private _positionErrorMem = -1;
		private _targetIndexMem = -1;
		private _targetElement = [];
		private _allUnits = allUnits;
		private _allUnitsEast = [];
		private _allUnitsWest = [];
		private _sleepDur = 0.005;
		private _sleepLoop = 10;
		_basePosition = markerPos 'QS_marker_base_marker';
		_baseRadius = 1000;
		_fn_getNestedIndex = missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex';
		for '_x' from 0 to 1 step 0 do {
			if (diag_fps > 15) then {
				if (!((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') isEqualTo [])) then {
					missionNamespace setVariable [
						'QS_AI_targetsKnowledge_EAST',
						((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') select {((alive (_x select 0)) && (((_x select 0) distance2D _basePosition) > _baseRadius) && ((EAST knowsAbout (_x select 0)) > 0) && (!((_x select 3) isEqualTo 0)))}),
						FALSE
					];
				};
				_allUnits = allUnits;
				{
					if (alive _x) then {
						if ((side _x) isEqualTo _side) then {
							_unit = _x;
							{
								if (alive _x) then {
									if ((side _x) in _enemySides) then {
										_knownUnit = _x;
										_targetKnowledge = _unit targetKnowledge (vehicle _knownUnit);
										_targetKnowledge params [
											'_knownByGroup',
											'',
											'_timeLastSeen',
											'',
											'',
											'_positionError',
											'_unitPosition'
										];
										if (_knownByGroup) then {
											if ((_unitPosition distance2D _basePosition) > _baseRadius) then {
												if (_positionError <= 10) then {
													if (!(_unitPosition isEqualTo [0,0,0])) then {
														_targetIndexMem = [(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST'),_knownUnit,0] call _fn_getNestedIndex;
														if (_targetIndexMem isEqualTo -1) then {
															(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') pushBack [_knownUnit,_unitPosition,(vehicle _knownUnit),(parseNumber (_positionError toFixed 3)),_unit,(parseNumber ((_time - _timeLastSeen) toFixed 3)),(rating _knownUnit)];
														} else {
															_targetElement = ((missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') select _targetIndexMem);
															_positionErrorMem = _targetElement select 3;
															if ((_positionError < _positionErrorMem) || {((_time - _timeLastSeen) > 60)}) then {
																_targetElement = [_knownUnit,_unitPosition,(vehicle _knownUnit),(parseNumber (_positionError toFixed 3)),_unit,(parseNumber ((_time - _timeLastSeen) toFixed 3)),(rating _knownUnit)];
																(missionNamespace getVariable 'QS_AI_targetsKnowledge_EAST') set [_targetIndexMem,_targetElement];
															};
														};
													};
												};
											};
										};
										uiSleep _sleepDur;
									};
								};
							} forEach _allUnits;
							uiSleep _sleepDur;
						};
					};
				} forEach _allUnits;
			};
			uiSleep _sleepLoop;
		};
		_return;
	};
};
if (_type isEqualTo 1) exitWith {
	comment 'Find nearest unit or unit position';
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
	comment 'SC sort by nearest sector and organize into array by most active sector to least active sector';
	_sort = param [3,FALSE];
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
	comment 'Check for armor in area';
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
	{
		_vehicle = _x select 2;
		if (alive _vehicle) then {
			if (!(_vehicle isKindOf 'Man')) then {
				if (({(alive _x)} count (crew _vehicle)) > 0) then {
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
	comment 'Check for CAS/AA globally';
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
	comment 'Get highest-rated enemy';
};
if (_type isEqualTo 6) exitWith {
	_position = param [2];
	_radius = param [3];
	comment 'Check for vehicles in area';
	private _return = 0;
	private _vehicle = objNull;
	private _val = -1;
	private _vehicles = [];
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
	} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	_vehicles;
};
if (_type isEqualTo 7) exitWith {
	params ['','','_grp','_grpLeader','_objectParent',['_radius',200]];
	comment 'Infantry info-receiving';
	comment 'Nearby enemies';
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
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
		} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	};
};
if (_type isEqualTo 8) exitWith {
	params ['','','_grp','_grpLeader','_objectParent'];
	comment 'Vehicle/Ship info-receiving';
	comment 'Nearby enemies, wider radius';
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
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
		} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	};
};
if (_type isEqualTo 9) exitWith {
	params ['','','_grp','_grpLeader','_objectParent'];
	comment 'Aircraft info-receiving';
	comment 'Priority targets like tanks and other aircraft';
	if (!((missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]) isEqualTo [])) then {
		private _targetEntity = objNull;
		private _targetVehicle = objNull;
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
		} forEach (missionNamespace getVariable ['QS_AI_targetsKnowledge_EAST',[]]);
	};
};
_return;