/*/
File: fn_aoGetTerrainData.sqf
Author:

	Quiksilver
	
Last Modified:

	17/03/2018 A3 1.82 by Quiksilver
	
Description:

	Get AO Terrain Data
____________________________________________________/*/

params ['_type','_position','_radius','_aoData'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	_aoPolygon = _aoData select 2;
	private _roadSegments = [];
	private _roadSegmentsInPolygon = [];
	private _roadIntersections = [];
	private _nearHouses = [];
	private _nearHousesInPolygon = [];
	private _nearSimpleObjects = [];
	private _nearSimpleHouses = [];
	private _nearBuildingPositions = [];
	private _buildingPositionsInPolygon = [];
	private _buildingPositionsInPolygonNearGround = [];
	private _building = objNull;
	private _buildingPositions = [];
	_roadSegments = ((_position select [0,2]) nearRoads _radius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
	if (_roadSegments isNotEqualTo []) then {
		_roadSegments = _roadSegments call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadSegmentsInPolygon = _roadSegments select {((getPosWorld _x) inPolygon _aoPolygon)};
		_roadIntersections = _roadSegments select {((count (roadsConnectedTo _x)) in [1,3])};
	};
	_nearHouses = (nearestObjects [_position,['House'],_radius,TRUE]) select {(([_x,(_x buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
	_nearSimpleObjects = (allSimpleObjects []) select {((_x distance2D _position) <= _radius)};
	if (_nearSimpleObjects isNotEqualTo []) then {
		_nearSimpleHouses = _nearSimpleObjects select {(([_x,[]] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
		_nearHouses = _nearHouses + _nearSimpleHouses;
	};
	if (_nearHouses isNotEqualTo []) then {
		_nearHouses = _nearHouses call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (_buildingPositions isNotEqualTo []) then {
				if ((getPosWorld _building) inPolygon _aoPolygon) then {
					_nearHousesInPolygon pushBack _building;
				};
				{
					_nearBuildingPositions pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _nearHouses;
	};
	if (_nearBuildingPositions isNotEqualTo []) then {
		_nearBuildingPositions = _nearBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			if (_x inPolygon _aoPolygon) then {
				_buildingPositionsInPolygon pushBack _x;
			};
		} forEach _nearBuildingPositions;
		if (_buildingPositionsInPolygon isNotEqualTo []) then {
			_buildingPositionsInPolygon = _buildingPositionsInPolygon call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_buildingPositionsInPolygonNearGround = _buildingPositionsInPolygon select {((_x select 2) < 6)};
			if (_buildingPositionsInPolygonNearGround isNotEqualTo []) then {
				_buildingPositionsInPolygonNearGround = _buildingPositionsInPolygonNearGround call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			};
		};
	};
	_return = [
		_roadSegments,
		_roadSegmentsInPolygon,
		_roadIntersections,
		_nearHouses,
		_nearHousesInPolygon,
		_nearBuildingPositions,
		_buildingPositionsInPolygon,
		_buildingPositionsInPolygonNearGround
	];
	missionNamespace setVariable ['QS_grid_terrainData',_return,FALSE];
	_return;
};
if (_type isEqualTo 1) exitWith {
	private _roadSegments = [];
	private _roadSegmentsInArea = [];
	private _roadIntersections = [];
	private _nearHouses = [];
	private _nearHousesInArea = [];
	private _nearSimpleObjects = [];
	private _nearSimpleHouses = [];
	private _nearBuildingPositions = [];
	private _buildingPositionsInArea = [];
	private _buildingPositionsInAreaNearGround = [];
	private _building = objNull;
	private _buildingPositions = [];
	private _forestPositions = [];
	_roadSegments = ((_position select [0,2]) nearRoads _radius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
	if (_roadSegments isNotEqualTo []) then {
		_roadSegments = _roadSegments call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadSegmentsInArea = _roadSegments select {((getPosWorld _x) inArea [_position,_radius,_radius,0,FALSE,-1])};
		_roadIntersections = _roadSegments select {((count (roadsConnectedTo _x)) in [1,3])};
	};
	_nearHouses = (nearestObjects [_position,['House'],_radius,TRUE]) select {(([_x,(_x buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
	_nearSimpleObjects = (allSimpleObjects []) select {((_x distance2D _position) <= _radius)};
	if (_nearSimpleObjects isNotEqualTo []) then {
		_nearSimpleHouses = _nearSimpleObjects select {(([_x,[]] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
		_nearHouses = _nearHouses + _nearSimpleHouses;
	};
	if (_nearHouses isNotEqualTo []) then {
		_nearHouses = _nearHouses call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (_buildingPositions isNotEqualTo []) then {
				if ((getPosWorld _building) inArea [_position,_radius,_radius,0,FALSE,-1]) then {
					_nearHousesInArea pushBack _building;
				};
				{
					_nearBuildingPositions pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _nearHouses;
	};
	if (_nearBuildingPositions isNotEqualTo []) then {
		_nearBuildingPositions = _nearBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			if (_x inArea [_position,_radius,_radius,0,FALSE,-1]) then {
				_buildingPositionsInArea pushBack _x;
			};
		} forEach _nearBuildingPositions;
		if (_buildingPositionsInArea isNotEqualTo []) then {
			_buildingPositionsInArea = _buildingPositionsInArea call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_buildingPositionsInAreaNearGround = _buildingPositionsInArea select {((_x select 2) < 6)};
			if (_buildingPositionsInAreaNearGround isNotEqualTo []) then {
				_buildingPositionsInAreaNearGround = _buildingPositionsInAreaNearGround call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			};
		};
	};
	private _randomPos = [0,0,0];
	for '_x' from 0 to 29 step 1 do {
		_randomPos = ['RADIUS',_position,_radius,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_position,_radius,(selectRandomWeighted ['(1 + forest)',0.333,'(1 + forest) * (1 + houses)',0.666]),15,3],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if ((_randomPos distance2D _position) < (_radius * 1.2)) then {
			_forestPositions pushBack _randomPos;
		};
	};
	if (_forestPositions isNotEqualTo []) then {
		_forestPositions = _forestPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_return = [
		_roadSegments,
		_roadSegmentsInArea,
		_roadIntersections,
		_nearHouses,
		_nearHousesInArea,
		_nearBuildingPositions,
		_buildingPositionsInArea,
		_buildingPositionsInAreaNearGround,
		_forestPositions
	];
	missionNamespace setVariable ['QS_classic_terrainData',_return,FALSE];
	_return;
};
if (_type isEqualTo 2) exitWith {
	private _roadSegments = [];
	private _roadSegmentsInArea = [];
	private _roadIntersections = [];
	private _nearHouses = [];
	private _nearHousesInArea = [];
	private _nearSimpleObjects = [];
	private _nearSimpleHouses = [];
	private _nearBuildingPositions = [];
	private _buildingPositionsInArea = [];
	private _buildingPositionsInAreaNearGround = [];
	private _building = objNull;
	private _buildingPositions = [];
	private _forestPositions = [];
	_roadSegments = ((_position select [0,2]) nearRoads _radius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
	if (_roadSegments isNotEqualTo []) then {
		_roadSegments = _roadSegments call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadSegmentsInArea = _roadSegments select {((getPosWorld _x) inArea [_position,_radius,_radius,0,FALSE,-1])};
		_roadIntersections = _roadSegments select {((count (roadsConnectedTo _x)) in [1,3])};
	};
	_nearHouses = (nearestObjects [_position,['House'],_radius,TRUE]) select {(([_x,(_x buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
	_nearSimpleObjects = (allSimpleObjects []) select {((_x distance2D _position) <= _radius)};
	if (_nearSimpleObjects isNotEqualTo []) then {
		_nearSimpleHouses = _nearSimpleObjects select {(([_x,[]] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
		_nearHouses = _nearHouses + _nearSimpleHouses;
	};
	if (_nearHouses isNotEqualTo []) then {
		_nearHouses = _nearHouses call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (_buildingPositions isNotEqualTo []) then {
				if ((getPosWorld _building) inArea [_position,_radius,_radius,0,FALSE,-1]) then {
					_nearHousesInArea pushBack _building;
				};
				{
					_nearBuildingPositions pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _nearHouses;
	};
	if (_nearBuildingPositions isNotEqualTo []) then {
		_nearBuildingPositions = _nearBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			if (_x inArea [_position,_radius,_radius,0,FALSE,-1]) then {
				_buildingPositionsInArea pushBack _x;
			};
		} forEach _nearBuildingPositions;
		if (_buildingPositionsInArea isNotEqualTo []) then {
			_buildingPositionsInArea = _buildingPositionsInArea call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_buildingPositionsInAreaNearGround = _buildingPositionsInArea select {((_x select 2) < 6)};
			if (_buildingPositionsInAreaNearGround isNotEqualTo []) then {
				_buildingPositionsInAreaNearGround = _buildingPositionsInAreaNearGround call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			};
		};
	};
	private _randomPos = [0,0,0];
	for '_x' from 0 to 29 step 1 do {
		_randomPos = ['RADIUS',_position,_radius,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_position,_radius,(selectRandomWeighted ['(1 + forest)',0.333,'(1 + forest) * (1 + houses)',0.666]),15,3],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if ((_randomPos distance2D _position) < (_radius * 1.2)) then {
			_forestPositions pushBack _randomPos;
		};
	};
	if (_forestPositions isNotEqualTo []) then {
		_forestPositions = _forestPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_return = [
		_roadSegments,
		_roadSegmentsInArea,
		_roadIntersections,
		_nearHouses,
		_nearHousesInArea,
		_nearBuildingPositions,
		_buildingPositionsInArea,
		_buildingPositionsInAreaNearGround,
		_forestPositions
	];
	missionNamespace setVariable ['QS_sideMission_terrainData',_return,FALSE];
	_return;
};
if (_type isEqualTo 3) exitWith {
	private _roadSegments = [];
	private _roadSegmentsInArea = [];
	private _roadIntersections = [];
	private _nearHouses = [];
	private _nearHousesInArea = [];
	private _nearSimpleObjects = [];
	private _nearSimpleHouses = [];
	private _nearBuildingPositions = [];
	private _buildingPositionsInArea = [];
	private _buildingPositionsInAreaNearGround = [];
	private _building = objNull;
	private _buildingPositions = [];
	private _forestPositions = [];
	_roadSegments = ((_position select [0,2]) nearRoads _radius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
	if (_roadSegments isNotEqualTo []) then {
		_roadSegments = _roadSegments call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadSegmentsInArea = _roadSegments select {((getPosWorld _x) inArea [_position,_radius,_radius,0,FALSE,-1])};
		_roadIntersections = _roadSegments select {((count (roadsConnectedTo _x)) in [1,3])};
	};
	_nearHouses = (nearestObjects [_position,['House'],_radius,TRUE]) select {(([_x,(_x buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
	_nearSimpleObjects = (allSimpleObjects []) select {((_x distance2D _position) <= _radius)};
	if (_nearSimpleObjects isNotEqualTo []) then {
		_nearSimpleHouses = _nearSimpleObjects select {(([_x,[]] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo [])};
		_nearHouses = _nearHouses + _nearSimpleHouses;
	};
	if (_nearHouses isNotEqualTo []) then {
		_nearHouses = _nearHouses call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (_buildingPositions isNotEqualTo []) then {
				if ((getPosWorld _building) inArea [_position,_radius,_radius,0,FALSE,-1]) then {
					_nearHousesInArea pushBack _building;
				};
				{
					_nearBuildingPositions pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _nearHouses;
	};
	if (_nearBuildingPositions isNotEqualTo []) then {
		_nearBuildingPositions = _nearBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			if (_x inArea [_position,_radius,_radius,0,FALSE,-1]) then {
				_buildingPositionsInArea pushBack _x;
			};
		} forEach _nearBuildingPositions;
		if (_buildingPositionsInArea isNotEqualTo []) then {
			_buildingPositionsInArea = _buildingPositionsInArea call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_buildingPositionsInAreaNearGround = _buildingPositionsInArea select {((_x select 2) < 6)};
			if (_buildingPositionsInAreaNearGround isNotEqualTo []) then {
				_buildingPositionsInAreaNearGround = _buildingPositionsInAreaNearGround call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			};
		};
	};
	private _randomPos = [0,0,0];
	for '_x' from 0 to 29 step 1 do {
		_randomPos = ['RADIUS',_position,_radius,'LAND',[1.5,0,0.5,3,0,FALSE,objNull],TRUE,[_position,_radius,(selectRandomWeighted ['(1 + forest)',0.333,'(1 + forest) * (1 + houses)',0.666]),15,3],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if ((_randomPos distance2D _position) < (_radius * 1.2)) then {
			_forestPositions pushBack _randomPos;
		};
	};
	if (_forestPositions isNotEqualTo []) then {
		_forestPositions = _forestPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_return = [
		_roadSegments,
		_roadSegmentsInArea,
		_roadIntersections,
		_nearHouses,
		_nearHousesInArea,
		_nearBuildingPositions,
		_buildingPositionsInArea,
		_buildingPositionsInAreaNearGround,
		_forestPositions
	];
	missionNamespace setVariable ['QS_genericAO_terrainData',_return,FALSE];
	_return;
};
_return;