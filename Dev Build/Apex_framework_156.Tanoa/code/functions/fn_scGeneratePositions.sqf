/*/
File: fn_scGeneratePositions.sqf
Author: 

	Quiksilver

Last Modified:

	19/12/2017 A3 1.80 by Quiksilver

Description:

	Generate SC Positions
____________________________________________________________________________/*/
diag_log '***** SC * Generating positions * 0 *****';
params ['_numberOfSectors','_module_fob_enabled','_scAreaPolygon'];
private _playerCount = count allPlayers;
private _aoSize = 10;
private _minDistBetweenSectors = 600;
private _minDistFromUsedPositions = 80;
if (worldName isEqualTo 'Altis') then {
	if (_playerCount > 10) then {
		if (_playerCount > 20) then {
			if (_playerCount > 30) then {
				if (_playerCount > 40) then {
					if (_playerCount > 50) then {
						_minDistBetweenSectors = 500;
					} else {
						_minDistBetweenSectors = 500;
					};
				} else {
					_minDistBetweenSectors = 500;
				};
			} else {
				_minDistBetweenSectors = 450;
			};
		} else {
			_minDistBetweenSectors = 400;
		};
	} else {
		_minDistBetweenSectors = 350;
	};
} else {
	if (_playerCount > 10) then {
		if (_playerCount > 20) then {
			if (_playerCount > 30) then {
				if (_playerCount > 40) then {
					if (_playerCount > 50) then {
						_minDistBetweenSectors = 500;
					} else {
						_minDistBetweenSectors = 500;
					};
				} else {
					_minDistBetweenSectors = 500;
				};
			} else {
				_minDistBetweenSectors = 450;
			};
		} else {
			_minDistBetweenSectors = 400;
		};
	} else {
		_minDistBetweenSectors = 350;
	};
};
private _minDistFromLastRefPos = 1000;
private _referencePosition = [0,0,0];
private _nearestLocations = [];
private _requireNearSettlement = (random 1) > 0.333;
private _requireNearSettlementRadius = 500;
private _timeLimitToFind = diag_tickTime + 30;
private _timeLimitFailsafe = diag_tickTime + 60;
private _distFromLastRefPositions = 1250;
if (_module_fob_enabled) then {
	missionNamespace setVariable ['QS_registeredPositions',[(markerPos 'QS_marker_module_fob')],FALSE];
	for '_x' from 0 to 1 step 0 do {
		_referencePosition = [
			'WORLD',
			-1,
			-1,
			'LAND',
			[-1,-1,-1,-1,0,FALSE,objNull],
			TRUE,
			[],
			[],
			TRUE
		] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (diag_tickTime > _timeLimitToFind) then {
			if (_requireNearSettlement) then {
				_requireNearSettlement = FALSE;
			};
			if (diag_tickTime > _timeLimitFailsafe) then {
				missionNamespace setVariable ['QS_virtualSectors_regionUsedRefPositions',[[-1000,-1000,0]],FALSE];
			};
		};
		if (_requireNearSettlement) then {
			_nearestLocations = nearestLocations [_referencePosition,['NameVillage','NameCity','NameCityCapital'],_requireNearSettlementRadius];
		};
		if (
			(((_requireNearSettlement) && (_nearestLocations isNotEqualTo [])) || (!(_requireNearSettlement))) && 
			(_referencePosition inPolygon _scAreaPolygon) && 
			((_referencePosition distance2D (missionNamespace getVariable 'QS_virtualSectors_lastReferencePosition')) >= _minDistFromLastRefPos) && 
			((_referencePosition distance2D (markerPos 'QS_marker_base_marker')) > 1200) && 
			(((missionNamespace getVariable 'QS_virtualSectors_regionUsedRefPositions') findIf {((_referencePosition distance2D _x) < _distFromLastRefPositions)}) isEqualTo -1) &&
			(!([_referencePosition,300,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))
		) exitWith {};
	};
} else {
	for '_x' from 0 to 1 step 0 do {
		_referencePosition = [
			'WORLD',
			-1,
			-1,
			'LAND',
			[-1,-1,-1,-1,0,FALSE,objNull],
			TRUE,
			[],
			[],
			TRUE
		] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (_requireNearSettlement) then {
			_nearestLocations = nearestLocations [_referencePosition,['NameVillage','NameCity','NameCityCapital'],_requireNearSettlementRadius];
		};
		if (
			(((_requireNearSettlement) && (_nearestLocations isNotEqualTo [])) || (!(_requireNearSettlement))) && 
			((_referencePosition distance2D (missionNamespace getVariable 'QS_virtualSectors_lastReferencePosition')) >= _minDistFromLastRefPos) && 
			(((missionNamespace getVariable 'QS_virtualSectors_regionUsedRefPositions') findIf {((_referencePosition distance2D _x) < 1500)}) isEqualTo -1) && 
			((_referencePosition distance2D (markerPos 'QS_marker_base_marker')) > 1200) && 
			(!([_referencePosition,300,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))
		) exitWith {};
	};
};
missionNamespace setVariable ['QS_virtualSectors_lastReferencePosition',_referencePosition,FALSE];
private _fobMarkerPos = [0,0,0];
_minDistFromFOB = 300;
if (_module_fob_enabled) then {
	_fobMarkerPos = markerPos 'QS_marker_module_fob';
};
private _attempts = 0;
missionNamespace setVariable ['QS_virtualSectors_positions',[],FALSE];
private _maxAttempts = 500;
private _foundPositionData = [];
private _position = [0,0,0];
private _foundPositionType = '';
_timeLimitToFind = diag_tickTime + 30;
_timeLimitFailsafe = diag_tickTime + 60;
private _processFailed = FALSE;
diag_log format ['***** SC * Generating positions * 0.5 * Reference Position: %1 *****',_referencePosition];
for '_x' from 0 to 1 step 0 do {
	_attempts = _attempts + 1;
	_foundPositionData = _referencePosition call (missionNamespace getVariable 'QS_fnc_scFindPosition');
	_position = _foundPositionData # 0;
	_foundPositionType = _foundPositionData # 1;
	if ((!(_module_fob_enabled)) || {((_module_fob_enabled) && ((_position distance2D _fobMarkerPos) >= _minDistFromFOB))}) then {
		if (((missionNamespace getVariable 'QS_virtualSectors_positions') inAreaArray [_position,(_minDistBetweenSectors max 200),(_minDistBetweenSectors max 200),0,FALSE]) isEqualTo []) then {
			if (((missionNamespace getVariable 'QS_virtualSectors_regionUsedPositions') inAreaArray [_position,(_minDistFromUsedPositions max 50),(_minDistFromUsedPositions max 50),0,FALSE]) isEqualTo []) then {
				if (((missionNamespace getVariable 'QS_virtualSectors_positions') isEqualTo []) || (((missionNamespace getVariable 'QS_virtualSectors_positions') isNotEqualTo []) && (((missionNamespace getVariable 'QS_virtualSectors_positions') findIf {([_position,_x,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))}) isEqualTo -1))) then {
					if ((!(surfaceIsWater _position)) && (_position isNotEqualTo [0,0,0])) then {
						(missionNamespace getVariable 'QS_virtualSectors_positions') pushBack _position;
						missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
					};
				};
			};
		};
	};
	if (diag_tickTime > _timeLimitFailsafe) exitWith {
		_processFailed = TRUE;
	};
	if ((count (missionNamespace getVariable 'QS_virtualSectors_positions')) isEqualTo _numberOfSectors) exitWith {
		_centroid = (missionNamespace getVariable 'QS_virtualSectors_positions') call (missionNamespace getVariable 'QS_fnc_geomPolygonCentroid');
		/*/_centroid = (((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) vectorAdd ((missionNamespace getVariable 'QS_virtualSectors_positions') # 1) vectorAdd ((missionNamespace getVariable 'QS_virtualSectors_positions') # 2)) vectorMultiply (1/3);/*/
		missionNamespace setVariable ['QS_virtualSectors_centroid',_centroid,FALSE];
		missionNamespace setVariable ['QS_virtualSectors_lastReferenceCentroid',_centroid,FALSE];
		{
			_x setMarkerPos _centroid;
		} forEach [
			'QS_marker_aoMarker',
			'QS_marker_aoCircle'
		];
		_dirAB = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) getDir ((missionNamespace getVariable 'QS_virtualSectors_positions') # 1);
		_distAB = (((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) distance2D ((missionNamespace getVariable 'QS_virtualSectors_positions') # 1)) / 2;
		_midpointAB = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) getPos [_distAB,_dirAB];
		_dirAC = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) getDir ((missionNamespace getVariable 'QS_virtualSectors_positions') # 2);
		_distAC = (((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) distance2D ((missionNamespace getVariable 'QS_virtualSectors_positions') # 2)) / 2;
		_midpointAC = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 0) getPos [_distAC,_dirAC];
		_dirBC = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 1) getDir ((missionNamespace getVariable 'QS_virtualSectors_positions') # 2);
		_distBC = (((missionNamespace getVariable 'QS_virtualSectors_positions') # 1) distance2D ((missionNamespace getVariable 'QS_virtualSectors_positions') # 2)) / 2;
		_midpointBC = ((missionNamespace getVariable 'QS_virtualSectors_positions') # 1) getPos [_distBC,_dirBC];
		missionNamespace setVariable ['QS_virtualSectors_midpoints',[_midpointAB,_midpointAC,_midpointBC],FALSE];
		missionNamespace setVariable ['QS_AOpos',_centroid,FALSE];
		(missionNamespace getVariable 'QS_virtualSectors_regionUsedCentroids') pushBack _centroid;
		(missionNamespace getVariable 'QS_virtualSectors_regionUsedRefPositions') pushBack _referencePosition;
		while {((count((missionNamespace getVariable 'QS_virtualSectors_positions') inAreaArray [_centroid,_aoSize,_aoSize,0,FALSE,-1])) isNotEqualTo _numberOfSectors)} do {
			_aoSize = _aoSize + 10;
		};
		_aoSize = _aoSize + 100;
		missionNamespace setVariable ['QS_aoSize',_aoSize,FALSE];
		'QS_marker_aoCircle' setMarkerSize [_aoSize,_aoSize];
		if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
			[objNull,_centroid] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
		};
	};
	if (_attempts > _maxAttempts) exitWith {};
	_minDistBetweenSectors = _minDistBetweenSectors - 5;
	_minDistFromUsedPositions = _minDistFromUsedPositions - 2;
};
diag_log '***** SC * Generating positions * 1 *****';
(missionNamespace getVariable 'QS_virtualSectors_positions')