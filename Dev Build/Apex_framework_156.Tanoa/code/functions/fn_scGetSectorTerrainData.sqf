/*/
File: fn_scGetSectorTerrainData.sqf
Author:

	Quiksilver
	
Last modified:

	6/10/2017 A3 1.76 by Quiksilver
	
Description:

	Sector Terrain Data
	
Notes:

	Roads
	Road Intersections
	Buildings
	Building Positions
	Overwatch Positions
__________________________________________________/*/
scriptName 'QS Get Sector Terrain Data';
params ['_sectorData'];
_sectorData params [
	'_sectorID',
	'_isActive',
	'_nextEvaluationTime',
	'_increment',
	'_minConversionTime',
	'_interruptMultiplier',
	'_areaType',
	'_centerPos',
	'_areaOrRadiusConvert',
	'_areaOrRadiusInterrupt',
	'_sidesOwnedBy',
	'_sidesCanConvert',
	'_sidesCanInterrupt',
	'_conversionValue',
	'_conversionValuePrior',
	'_conversionAlgorithm',
	'_importance',
	'_flagData',
	'_sectorAreaObjects',
	'_locationData',
	'_objectData',
	'_markerData',
	'_taskData',
	'_initFunction',
	'_manageFunction',
	'_exitFunction',
	'_conversionRate',
	'_isBeingInterrupted'
];
_location = _locationData # 0;
if (isNull _location) exitWith {};
_location setVariable ['QS_virtualSectors_terrainData',[]];
comment 'Roads';
_nearRoads = ((_centerPos select [0,2]) nearRoads _areaOrRadiusInterrupt) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
comment 'Intersections';
_nearRoadsIntersections = (_nearRoads select {(_x isEqualType objNull)}) select {((count (roadsConnectedTo _x)) in [1,3])};
comment 'Buildings with positions';
private _nearHouses = (nearestObjects [_centerPos,['House','Building'],_areaOrRadiusInterrupt,TRUE]) select {((_x buildingPos -1) isNotEqualTo [])};
_nearHouses = _nearHouses + ((allSimpleObjects []) inAreaArray [_centerPos,_areaOrRadiusInterrupt,_areaOrRadiusInterrupt,0,FALSE]);
comment 'Building Positions';
private _buildingPositions = [];
private _nearBuildingPositions = [];
private _house = objNull;
{
	_house = _x;
	_buildingPositions = _house buildingPos -1;
	_buildingPositions = [_house,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
	if (_buildingPositions isNotEqualTo []) then {
		{
			0 = _nearBuildingPositions pushBack _x;
		} forEach _buildingPositions;
	};
} forEach _nearHouses;
if (_nearBuildingPositions isNotEqualTo []) then {
	_nearBuildingPositions = _nearBuildingPositions apply {[(_x # 0),(_x # 1),((_x # 2) + 1)]};
};
comment 'Overwatch';
private _position = [0,0,0];
private _overwatch = [];
private _centerPosASL = AGLToASL _centerPos;
private _canSuspend = canSuspend;
for '_x' from 0 to 9 step 1 do {
	_position = [_centerPos,300,30,10,[[objNull,'VIEW',objNull],0.25]] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	if (_position isEqualTo _centerPos) exitWith {};
	_overwatch pushBack _position;
	if (_canSuspend) then {
		sleep 0.01;
	};
};
_location setVariable ['QS_virtualSectors_terrainData',[_nearRoads,_nearRoadsIntersections,_nearHouses,_nearBuildingPositions,_overwatch]];
TRUE;