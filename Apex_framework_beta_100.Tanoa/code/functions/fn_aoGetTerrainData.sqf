/*/
File: fn_aoGetTerrainData.sqf
Author:

	Quiksilver
	
Last Modified:

	26/11/2017 A3 1.78 by Quiksilver
	
Description:

	Get AO Terrain Data
	
params [
	['_aoState',1],
	['_aoDisplayName',''],
	['_aoPolygon',[]],
	['_aoGridMarkers',[]],
	['_a',[]],
	['_b',0],
	['_c',0],
	['_d',0],
	['_e',0],
	['_f',0],
	['_g',0],
	['_h',0],
	['_i',0],
	['_j',0],
	['_k',0]
];
_____________________________________________________________________/*/

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
	_roadSegments = ([(_position select 0),(_position select 1)] nearRoads _radius) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
	if (!(_roadSegments isEqualTo [])) then {
		_roadSegments = _roadSegments call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_roadSegmentsInPolygon = _roadSegments select {((getPosWorld _x) inPolygon _aoPolygon)};
		_roadIntersections = _roadSegments select {((count (roadsConnectedTo _x)) in [1,3])};
	};
	_nearHouses = (nearestObjects [_position,['House'],_radius]) select {(!(([_x,(_x buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isEqualTo []))};
	_nearSimpleObjects = (allSimpleObjects []) select {((_x distance2D _position) <= _radius)};
	if (!(_nearSimpleObjects isEqualTo [])) then {
		_nearSimpleHouses = _nearSimpleObjects select {(!(([_x,[]] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isEqualTo []))};
		_nearHouses = _nearHouses + _nearSimpleHouses;
	};
	if (!(_nearHouses isEqualTo [])) then {
		_nearHouses = _nearHouses call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			_building = _x;
			_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
			if (!(_buildingPositions isEqualTo [])) then {
				if ((getPosWorld _building) inPolygon _aoPolygon) then {
					_nearHousesInPolygon pushBack _building;
				};
				{
					_nearBuildingPositions pushBack _x;
				} forEach _buildingPositions;
			};
		} forEach _nearHouses;
	};
	if (!(_nearBuildingPositions isEqualTo [])) then {
		_nearBuildingPositions = _nearBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		{
			if (_x inPolygon _aoPolygon) then {
				_buildingPositionsInPolygon pushBack _x;
			};
		} forEach _nearBuildingPositions;
		if (!(_buildingPositionsInPolygon isEqualTo [])) then {
			_buildingPositionsInPolygon = _buildingPositionsInPolygon call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_buildingPositionsInPolygonNearGround = _buildingPositionsInPolygon select {((_x select 2) < 6)};
			if (!(_buildingPositionsInPolygonNearGround isEqualTo [])) then {
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
	_return;
};
_return;