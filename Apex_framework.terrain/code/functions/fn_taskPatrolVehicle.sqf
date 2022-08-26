/*/
File: fn_taskPatrolVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	22/08/2022 A3 2.10 by Quiksilver
	
Description:

	AI Vehicle Patrol
	
	[_AOvehGroup,_randomPos,_aoSize,_roadPositionsValid,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
__________________________________________________/*/

params [
	['_grp',grpNull],
	['_vCenterPos',[0,0,0]],
	['_patrolRadius',300],
	['_nearRoads',[]],
	['_new',FALSE]
];
_vehiclePos = getPosATL (vehicle (leader _grp));
private _nearRoadsPositions = [];
if (_nearRoads isEqualTo []) then {
	_nearRoadsPositions = (((_vCenterPos select [0,2]) nearRoads _patrolRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) apply {(getPosATL _x)};
} else {
	_nearRoadsPositions = _nearRoads apply {if (_x isEqualType objNull) then {(getPosATL _x)} else {_x};};
};
if (_nearRoadsPositions isNotEqualTo []) then {
	_nearRoadsPositions = _nearRoadsPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
};
private _waypointPositions = [_vehiclePos];
private _waypointPosition = nil;
_checkDist = {
	_c = TRUE;
	{
		if (((_this # 0) distance2D _x) <= (_this # 2)) then {
			_c = FALSE;
		};
	} forEach (_this # 1);
	_c;
};
_grpWPFormations = selectRandom ['COLUMN'];
_grpWPSpeed = selectRandom ['LIMITED','NORMAL'];
_grpWPType = 'MOVE';
_grpWPCombatMode = selectRandom ['WHITE','YELLOW','RED'];
_behaviours = ['SAFE','AWARE','COMBAT'];
private _grpBehaviour = 'SAFE';
if (_nearRoadsPositions isNotEqualTo []) then {
	for '_x' from 0 to (2 + (selectRandom [1,2])) step 1 do {
		_waypointPosition = (_nearRoadsPositions select { ([_x,_waypointPositions,75] call _checkDist) }) # 0;
		if (!isNil '_waypointPosition') then {
			_waypointPositions pushBack _waypointPosition;
		} else {
			diag_log '***** QS ERROR ***** fn_taskPatrolVehicle * Waypoint position is nil *****';
		};
	};
};
if ((count _waypointPositions) > 1) exitWith {
	if (_new) then {
		_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_waypointPositions,-1,-1],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
	} else {
		{
			if ((random 1) > 0.2) then {
				_grpBehaviour = 'SAFE';
			} else {
				_grpBehaviour = selectRandom _behaviours;
			};
			[
				_grp,
				[(_x # 0),(_x # 1),((_x # 2) + 1)],
				0,
				_grpWPType,
				_grpBehaviour,
				_grpWPCombatMode,
				_grpWPFormations,
				_grpWPSpeed,
				(10 + (random 20)),
				objNull,
				[],
				[],
				'',
				'',
				'',
				FALSE,
				FALSE,
				FALSE
			] call (missionNamespace getVariable 'QS_fnc_taskSetSingleWaypoint');
		} forEach _waypointPositions;
		[
			_grp,
			[(_vehiclePos # 0),(_vehiclePos # 1),1],
			0,
			'CYCLE',
			'UNCHANGED',
			'UNCHANGED',
			'UNCHANGED',
			'UNCHANGED',
			(10 + (random 20)),
			objNull,
			[],
			[],
			'',
			'',
			'',
			FALSE,
			FALSE,
			FALSE
		] call (missionNamespace getVariable 'QS_fnc_taskSetSingleWaypoint');
	};
	TRUE;
};
if (_new) then {
	private _prevPos = _vehiclePos;
	private _newPos = [0,0,0];
	private _exit = FALSE;
	for '_x' from 0 to (2 + (selectRandom [1,2])) step 1 do {
		_exit = FALSE;
		for '_x' from 0 to 49 step 1 do {
			_newPos = [_prevPos,50,300,0.1,0,0.75,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
			if ((_newPos distance2D _prevPos) < 350) then {
				if (!(surfaceIsWater _newPos)) then {
					_prevPos = _newPos;
					_exit = TRUE;
				};
			};
			if (_exit) exitWith {};
		};
		_waypointPositions pushBack _newPos;
	};
	_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_waypointPositions,-1,-1],QS_system_AI_owners];
	_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
};
FALSE;