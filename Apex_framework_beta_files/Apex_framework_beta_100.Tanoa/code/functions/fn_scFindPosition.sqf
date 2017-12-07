/*/
File: fn_scFindPosition.sqf
Author: 

	Quiksilver

Last Modified:

	12/09/2017 A3 1.76 by Quiksilver

Description:

	Find SC Position
____________________________________________________________________________/*/
private _centerPos = _this;
private _position = [0,0,0];
private _positionFound = FALSE;
private _radius = 250;
private _attempts = 0;
private _maxAttempts = 300;
private _placeType = '';
private _terrainObjectsExclusion = [
	"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
	"FENCE","WALL","BUSSTOP","ROAD","TRANSMITTER","STACK","RUIN","WATERTOWER","MAIN ROAD",
	"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
];
private _objectsExclusion = ['House','Building'];
_basePosition = markerPos 'QS_marker_base_marker';
_baseRadius = 1000;
_fobPosition = markerPos 'QS_marker_module_fob';
_fobRadius = 150;
_timeLimitFailsafe = diag_tickTime + 15;
for '_x' from 0 to 1 step 0 do {
	if (diag_tickTime > _timeLimitFailsafe) exitWith {};
	_attempts = _attempts + 1;
	if ((count (missionNamespace getVariable 'QS_virtualSectors_positions')) > 0) then {
		_radius = 750;
	};
	_placeType = selectRandom [
		'(1 + houses)',
		'(1 + forest)',
		'(1 + forest) * (1 + houses)',
		'(1 + houses)',
		'(1 + meadow)',
		'(1 + meadow)',
		'(1 + houses)',
		'(1 + meadow)',
		'(1 + houses)'
	];
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
	if ((_position distance2D _basePosition) > _baseRadius) then {
		if ((_position distance2D _fobPosition) > _fobRadius) then {
			if ((getTerrainHeightASL _position) > 2) then {
				if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 7) then {
					if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -7) then {
						if ((([(_position select 0),(_position select 1)] nearRoads 25) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
							if (!([_position,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
								if ((nearestObjects [_position,_objectsExclusion,9,FALSE]) isEqualTo []) then {
									if ((nearestTerrainObjects [
										_position,
										_terrainObjectsExclusion,
										10,
										FALSE,
										TRUE
									]) isEqualTo []) then {
										_positionFound = TRUE;
									};
								};
							};
						};
					};
				};
			};
		};
	};
	if (_positionFound) exitWith {};
	if (_attempts > _maxAttempts) exitWith {};
};
[_position,_placeType];