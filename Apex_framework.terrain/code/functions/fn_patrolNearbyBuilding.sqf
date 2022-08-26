/*
File: fn_searchNearbyBuilding.sqf
Author:

	Quiksilver
	
Last Modified:

	25/05/2022 A3 2.08 by Quiksilver
	
Description:

	Variant of "search nearby building"
_______________________________________________________________*/

params [
	['_grp',grpNull],
	['_array',[]],
	['_timeout',300],
	['_radius',300],
	['_regroup',FALSE]
];
private _leader = leader _grp;
if (_array isEqualTo []) then {
	_array = [_leader,_radius] call (missionNamespace getVariable 'QS_fnc_getNearestBuilding');
};
if (_array isEqualTo []) exitWith {};
_array params [
	'_building',
	'_indices'
];
_grp setFormDir (_leader getDir _building);
_startingPosition = getPosATL _leader;
private _buildingExits = [];
private _buildingExit = 0;
private _index = 0;
for '_x' from 0 to 12 step 1 do {
	_buildingExit = _building buildingExit _index;
	if (_buildingExit isNotEqualTo [0,0,0]) then {
		_buildingExits pushBack _buildingExit;
	};
	_index = _index + 1;
};

private _buildingPositions = _building buildingPos -1;
_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
if (_buildingPositions isNotEqualTo []) then {
	_buildingPositions = _buildingPositions apply { _x vectorAdd [0,0,1.5]; };
};
doStop _leader;
_leader commandMove (selectRandom _buildingExits);
{
	if (_x isNotEqualTo _leader) then {
		_x commandMove (selectRandom _buildingPositions);
	};
} forEach (units _grp);
_size = sizeOf (typeOf _building);
_size2 = _size * 2;
_duration = diag_tickTime + _timeout;
private _unit = objNull;
private _aliveUnits = [];
for '_x' from 0 to 1 step 0 do {
	if (diag_tickTime > _duration) exitWith {};
	_aliveUnits = [];
	{
		_unit = _x;
		if (alive _unit) then {
			if ((({(alive _x)} count (units (group _x))) > 1) && (_unit isNotEqualTo (leader (group _unit)))) then {
				_aliveUnits pushBack _unit;
			} else {
				if (({(alive _x)} count (units (group _unit))) < 2) then {
					_aliveUnits pushBack _unit;
				};
			};
		};
		sleep 0.1;
	} forEach (units _grp);
	if (_aliveUnits isEqualTo []) exitWith {};
	{
		if ((_x distance2D _building) > _size2) then {
			doStop _x;
			_x doMove (selectRandom _buildingPositions);
		} else {
			if ((random 1) > 0.5) then {
				if (((unitReady _x) && ((_x distance2D _building) < _size)) || {(moveToCompleted _x)} || {(moveToFailed _x)}) then {
					doStop _x;
					_x doMove (selectRandom _buildingPositions);
				};
			};
		};
		sleep (random [0.5,1,3]);
	} forEach _aliveUnits;
	sleep 10;
};
_grp setVariable ['QS_AI_GRP_SCRIPT',scriptNull,FALSE];
_grp setVariable ['QS_AI_GRP_TASK',[((_grp getVariable 'QS_AI_GRP_TASK') # 0),((_grp getVariable 'QS_AI_GRP_TASK') # 1),serverTime,-1],FALSE];
if (_regroup) then {
	if (((units _grp) findIf {(alive _x)}) isNotEqualTo -1) then {
		_leader = leader _grp;
		_position = getPosATL _leader;
		{
			if (alive _x) then {
				doStop _x;
				_x doMove [((_position # 0) + (5 - (random 10))),((_position # 1) + (5 - (random 10))),(_position # 2)];
				_x doFollow _leader;
			};
		} forEach (units _grp);
		_grp move _startingPosition;
	};
};