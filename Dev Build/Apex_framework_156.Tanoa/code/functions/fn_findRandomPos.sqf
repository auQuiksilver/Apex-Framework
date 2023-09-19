/*/
File: fn_findRandomPos.sqf
Author:

	Quiksilver
	
Last Modified:

	22/08/2022 A3 2.10 by Quiksilver
	
Description:

	Find a random position with given parameters
	
Parameters:

	0 - STRING - TYPE - ('WORLD' or 'RADIUS')
	1 - ARRAY - CENTER POSITION for radius
	2 - SCALAR - RADIUS FROM CENTER
	3 - STRING - 'LAND' or 'WATER'
	4 - ARRAY - isFlatEmpty array https://community.bistudio.com/wiki/isFlatEmpty
	5 - BOOL - blacklist enabled
	6 - ARRAY - selectBestPlaces array https://community.bistudio.com/wiki/selectBestPlaces      https://community.bistudio.com/wiki/Ambient_Parameters
	7 - ARRAY - findEmptyPosition array https://community.bistudio.com/wiki/findEmptyPosition
	8 - BOOL - force system to find position instead of give up after X number of searches
	
Example 1:

	_position = [
		'WORLD',
		-1,
		-1,
		'LAND',
		[5,0,1,10,0,FALSE,objNull],
		FALSE,
		[],
		[],
		TRUE
	] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
_____________________________________________________________________/*/

params ['_type','_centerPos','_radius','_whitelist','_isFlatEmpty','_blacklistEnabled','_selectBestPlaces','_findEmptyPosition','_forceFind'];
private _timeout = diag_tickTime + 30;
private _return = [];
private _testPos = [0,0,0];
_landPos = _whitelist isNotEqualTo 'WATER';
_worldName = worldName;
if (_isFlatEmpty isEqualTo []) then {
	if (_landPos) then {
		if (_worldName in ['Tanoa','Enoch']) then {
			_isFlatEmpty = [1,0,0.5,5,0,FALSE,objNull];
		} else {
			_isFlatEmpty = [5,0,0.25,5,0,FALSE,objNull];
		};
	} else {
		_isFlatEmpty = [5,0,0.25,5,2,TRUE,objNull];
	};
};
_bestPlacesEnabled = _selectBestPlaces isNotEqualTo [];
private _bestPlaces = [];
if (_bestPlacesEnabled) then {
	_selectBestPlaces = _selectBestPlaces select [1,4];
};
_emptyPositionEnabled = _findEmptyPosition isNotEqualTo [];
if (_emptyPositionEnabled) then {
	if (
		(_type isEqualTo 'RADIUS') &&
		{(_radius < 1500)}
	) then {
		_centerPos findEmptyPositionReady [0,_radius];
	};
};
private _fn_blacklist = {TRUE};
if (_blacklistEnabled) then {
	if (_worldName isEqualTo 'Altis') then {
		_fn_blacklist = {
			_pos = _this;
			private _c = TRUE;
			_blacklistData = [
				[(markerPos 'respawn'),500],
				[(markerPos 'QS_marker_Almyra_blacklist_area'),1500],
				[(markerPos 'QS_marker_base_marker'),1000],
				[(markerPos 'QS_marker_module_fob'),100]
			];
			{
				if ((_pos distance2D (_x # 0)) < (_x # 1)) then {
					if (([_pos,100,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) exitWith {
						_c = FALSE;
					};
				};
			} forEach _blacklistData;
			_c;
		};
	};
	if (_worldName isEqualTo 'Stratis') then {
		_fn_blacklist = {TRUE};
	};
	if (_worldName isEqualTo 'Tanoa') then {
		_fn_blacklist = {
			_pos = _this;
			private _c = TRUE;
			_blacklistData = [
				[(markerPos 'respawn'),300],
				[(markerPos 'QS_marker_base_marker'),800],
				[(markerPos 'QS_marker_module_fob'),100],
				[[5763,10369,0],750]
			];
			{
				if ((_pos distance2D (_x # 0)) < (_x # 1)) then {
					if (([_pos,100,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) exitWith {
						_c = FALSE;
					};
				};
			} forEach _blacklistData;
			_c;
		};
	};
	if (_worldName isEqualTo 'Malden') then {
		_fn_blacklist = {TRUE};
	};
	if (_worldName isEqualTo 'Enoch') then {
		_fn_blacklist = {TRUE};
	};
};
_true = TRUE;
_false = FALSE;
_attempts = 499;
_step = [1,0] select _forceFind;
_bto = [
	'building','house','church','chapel', 
	'cross','rock','bunker','fortress','fountain','view-tower', 
	'lighthouse','quay','fuelstation','hospital','fence','wall', 
	'busstop','road','transmitter','stack','ruin', 
	'tourism','watertower','rocks','power lines','railway', 
	'powersolar','powerwave','powerwind','shipwreck'
];
if (_type isEqualTo 'WORLD') then {
	_inset = [2000,500] select (_worldName in ['Tanoa','Stratis']);
	_max = worldSize - (_inset * 2);
	for '_x' from 0 to _attempts step _step do {
		if (diag_tickTime > _timeout) exitWith {
			diag_log format ['***** DEBUG ***** SAFE POS FAILURE * %1 * %2 * %3 * %4 * %5 * %6 * %7 * %8 * %9',_type,_centerPos,_radius,_whitelist,_isFlatEmpty,_blacklistEnabled,_selectBestPlaces,_findEmptyPosition,_forceFind];
			_return = getArray (configFile >> 'CfgWorlds' >> worldName >> 'safePositionAnchor');
		};
		_testPos = [_inset + (random _max),_inset + (random _max),0];
		if (_testPos inArea (missionNamespace getVariable 'QS_terrain_worldArea')) then {
			if ((!(_blacklistEnabled)) || {((_blacklistEnabled) && (_testPos call _fn_blacklist))}) then {
				if (_landPos) then {
					if (!(surfaceIsWater _testPos)) then {
						if (_bestPlacesEnabled) then {
							_bestPlaces = selectBestPlaces ([_testPos] + _selectBestPlaces);
							if (_bestPlaces isNotEqualTo []) then {
								if ((count _bestPlaces) > 1) then {
									_testPos = (selectRandom _bestPlaces) # 0;
								} else {
									_testPos = (_bestPlaces # 0) # 0;
								};
								_testPos set [2,0];
								_return = _testPos;
								if (
									(_emptyPositionEnabled) &&
									{(_return isNotEqualTo [])} &&
									{((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty # 0),_false,_true]) isEqualTo [])}
								) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						} else {
							_return = _testPos isFlatEmpty _isFlatEmpty;
							if (
								(_emptyPositionEnabled) &&
								{(_return isNotEqualTo [])} &&
								{((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty # 0),_false,_true]) isEqualTo [])}
							) then {
								_return = _testPos findEmptyPosition _findEmptyPosition;
							};
						};
					};		
				} else {
					if (surfaceIsWater _testPos) then {
						if (_bestPlacesEnabled) then {
							_bestPlaces = selectBestPlaces ([_testPos] + _selectBestPlaces);
							if (_bestPlaces isNotEqualTo []) then {
								if ((count _bestPlaces) > 1) then {
									_testPos = (selectRandom _bestPlaces) # 0;
								} else {
									_testPos = (_bestPlaces # 0) # 0;
								};
								_testPos set [2,0];
								_return = _testPos;
								if (_emptyPositionEnabled) then {
									if (_return isNotEqualTo []) then {
										_return = _testPos findEmptyPosition _findEmptyPosition;
									};
								};
							};
						} else {
							_return = _testPos isFlatEmpty _isFlatEmpty;
							if (_emptyPositionEnabled) then {
								if (_return isNotEqualTo []) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};
					};	
				};
			};
		};
		if (_return isNotEqualTo []) exitWith {};
	};
} else {
	if (_type isEqualTo 'RADIUS') then {
		for '_x' from 0 to _attempts step _step do {
			if (diag_tickTime > _timeout) exitWith {
				diag_log format ['***** DEBUG ***** SAFE POS FAILURE * %1 * %2 * %3 * %4 * %5 * %6 * %7 * %8 * %9',_type,_centerPos,_radius,_whitelist,_isFlatEmpty,_blacklistEnabled,_selectBestPlaces,_findEmptyPosition,_forceFind];
				_return = getArray (configFile >> 'CfgWorlds' >> worldName >> 'safePositionAnchor');
			};
			_testPos = _centerPos getPos [(_radius * (sqrt (random 1))),(random 360)];
			if (_testPos inArea (missionNamespace getVariable 'QS_terrain_worldArea')) then {
				if (
					(!(_blacklistEnabled)) || 
					{((_blacklistEnabled) && (_testPos call _fn_blacklist))}
				) then {
					if (_landPos) then {
						if (!(surfaceIsWater _testPos)) then {
							if (_bestPlacesEnabled) then {
								_bestPlaces = selectBestPlaces ([_testPos] + _selectBestPlaces);
								if (_bestPlaces isNotEqualTo []) then {
									if ((count _bestPlaces) > 1) then {
										_testPos = (selectRandom _bestPlaces) # 0;
									} else {
										_testPos = (_bestPlaces # 0) # 0;
									};
									_testPos set [2,0];
									_return = _testPos;
									if (
										(_emptyPositionEnabled) &&
										{(_return isNotEqualTo [])} &&
										{((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty # 0),_false,_true]) isEqualTo [])}
									) then {
										_return = _testPos findEmptyPosition _findEmptyPosition;
									};
								};
							} else {
								_return = _testPos isFlatEmpty _isFlatEmpty;
								if (
									(_emptyPositionEnabled) &&
									{(_return isNotEqualTo [])} &&
									{((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty # 0),_false,_true]) isEqualTo [])}
								) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};
					} else {
						if (surfaceIsWater _testPos) then {
							if (_bestPlacesEnabled) then {
								_bestPlaces = selectBestPlaces ([_testPos] + _selectBestPlaces);
								if (_bestPlaces isNotEqualTo []) then {
									if ((count _bestPlaces) > 1) then {
										_testPos = (selectRandom _bestPlaces) # 0;
									} else {
										_testPos = (_bestPlaces # 0) # 0;
									};
									_testPos set [2,0];
									_return = _testPos;
									if (_emptyPositionEnabled) then {
										if (_return isNotEqualTo []) then {
											_return = _testPos findEmptyPosition _findEmptyPosition;
										};
									};
								};
							} else {
								_return = _testPos isFlatEmpty _isFlatEmpty;
								if (_emptyPositionEnabled) then {
									if (_return isNotEqualTo []) then {
										_return = _testPos findEmptyPosition _findEmptyPosition;
									};
								};
							};
						};
					};
				};
			};
			if (_return isNotEqualTo []) exitWith {};
		};
	};
};
if (_return isEqualTo []) then {
	_return = [worldSize,worldSize,0];
};
_return;