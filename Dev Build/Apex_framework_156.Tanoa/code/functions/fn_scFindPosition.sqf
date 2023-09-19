/*/
File: fn_scFindPosition.sqf
Author: 

	Quiksilver

Last Modified:

	28/03/2018 A3 1.82 by Quiksilver

Description:

	Find SC Position
___________________________________________/*/
private _centerPos = _this;
private _position = [0,0,0];
private _positionFound = FALSE;
private _radius = 250;
private _attempts = 0;
private _maxAttempts = 300;
private _placeType = '';
private _terrainObjectsExclusion = [
	"BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", 
	"FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "FENCE", "WALL", "BUSSTOP", "TRANSMITTER", 
	"STACK", "RUIN", "TOURISM", "WATERTOWER", "ROCK", "ROCKS", "POWER LINES", "RAILWAY", "POWERSOLAR", "POWERWAVE", "POWERWIND", "SHIPWRECK"
];
private _objectsExclusion = ['House','Building'];
_basePosition = markerPos 'QS_marker_base_marker';
_baseRadius = 1000;
_fobPosition = markerPos 'QS_marker_module_fob';
_fobRadius = 150;
_timeLimitFailsafe = diag_tickTime + 15;
_placeTypes = [
	'(1 + houses)',3,
	'(1 + forest)',1,
	'(1 + forest) * (1 + houses)',1,
	'(1 + meadow)',3
];
for '_x' from 0 to 1 step 0 do {
	if (diag_tickTime > _timeLimitFailsafe) exitWith {};
	_attempts = _attempts + 1;
	if ((count (missionNamespace getVariable 'QS_virtualSectors_positions')) > 0) then {
		_radius = 600;
	};
	_placeType = selectRandomWeighted _placeTypes;
	_position = [
		'RADIUS',
		_centerPos,
		_radius,
		'LAND',
		[9,0,-1,-1,0,FALSE,objNull],
		FALSE,
		[_centerPos,150,_placeType,15,3],
		[0,50],
		TRUE
	] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
	if (
		((_position distance2D _basePosition) > _baseRadius) &&
		{((_position distance2D _fobPosition) > _fobRadius)} &&
		{((getTerrainHeightASL _position) > 1)} &&
		{(([_position,16] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 7)} &&
		{(([_position,16] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -7)} &&
		{((((_position select [0,2]) nearRoads 25) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
		{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
		{((nearestObjects [_position,_objectsExclusion,12,FALSE]) isEqualTo [])} &&
		{((nearestTerrainObjects [_position,_terrainObjectsExclusion,10,FALSE,TRUE]) isEqualTo [])}
	) exitWith {};
	if (_attempts > _maxAttempts) exitWith {};
};
[_position,_placeType];