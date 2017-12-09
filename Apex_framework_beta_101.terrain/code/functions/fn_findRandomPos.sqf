/*
File: fn_findRandomPos.sqf
Author:

	Quiksilver
	
Last Modified:

	15/04/2017 A3 1.68 by Quiksilver
	
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
_____________________________________________________________________*/

params ['_type','_centerPos','_radius','_whitelist','_isFlatEmpty','_blacklistEnabled','_selectBestPlaces','_findEmptyPosition','_forceFind'];
private [
	'_return','_inset','_max','_testPos','_worldName','_landPos','_bottomL','_blacklist','_fn_blacklist','_radius2',
	'_bestPlacesEnabled','_bestPlaces','_emptyPositionEnabled','_forceFind','_step','_bto','_attempts'
];
_return = [];
_landPos = TRUE;
if (_whitelist isEqualTo 'WATER') then {
	_landPos = FALSE;
};
if (_isFlatEmpty isEqualTo []) then {
	if (_landPos) then {
		if (worldName isEqualTo 'Tanoa') then {
			_isFlatEmpty = [1,0,0.5,5,0,FALSE,objNull];
		} else {
			_isFlatEmpty = [5,0,0.25,5,0,FALSE,objNull];
		};
	} else {
		_isFlatEmpty = [5,0,0.25,5,2,TRUE,objNull];
	};
};
_bestPlacesEnabled = FALSE;
if (!(_selectBestPlaces isEqualTo [])) then {
	_bestPlaces = [];
	_bestPlacesEnabled = TRUE;
};
_emptyPositionEnabled = FALSE;
if (!(_findEmptyPosition isEqualTo [])) then {
	_emptyPositionEnabled = TRUE;
};
if (_blacklistEnabled) then {
	_worldName = worldName;
	_fn_blacklist = {TRUE};
	if (_worldName isEqualTo 'Altis') then {
		_fn_blacklist = {
			_pos = _this;
			private _c = TRUE;
			_blacklistData = [
				[(markerPos 'respawn_west'),500],
				[(markerPos 'QS_marker_Almyra_blacklist_area'),1500],
				[(markerPos 'QS_marker_base_marker'),1000],
				[(markerPos 'QS_marker_module_fob'),100]
			];
			{
				if (([_pos,100,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
					if ((_pos distance2D (_x select 0)) < (_x select 1)) exitWith {
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
				[(markerPos 'respawn_west'),300],
				[(markerPos 'QS_marker_base_marker'),800],
				[(markerPos 'QS_marker_module_fob'),100],
				[[5763,10369,0],750]
			];
			{
				if (([_pos,100,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
					if ((_pos distance2D (_x select 0)) < (_x select 1)) exitWith {
						_c = FALSE;
					};
				};
			} forEach _blacklistData;
			_c;
		};
	};
	if (_worldName isEqualTo 'Takistan') then {
		_fn_blacklist = {TRUE};
	};
	if (_worldName isEqualTo 'Sahrani') then {
		_fn_blacklist = {TRUE};
	};
	if (_worldName isEqualTo 'Chernarus') then {
		_fn_blacklist = {TRUE};
	};
	if (_worldName isEqualTo 'Malden') then {
		_fn_blacklist = {TRUE};
	};
};
_attempts = 499;
_step = [1,0] select _forceFind;
comment "'TRAIL','TREE','SMALL TREE','BUSH','MAIN ROAD','TRACK','FOREST'";
_bto = [
	'BUILDING','HOUSE','FOREST BORDER', 
	'FOREST TRIANGLE','FOREST SQUARE','CHURCH','CHAPEL', 
	'CROSS','ROCK','BUNKER','FORTRESS','FOUNTAIN','VIEW-TOWER', 
	'LIGHTHOUSE','QUAY','FUELSTATION','HOSPITAL','FENCE','WALL', 
	'HIDE','BUSSTOP','ROAD','TRANSMITTER','STACK','RUIN', 
	'TOURISM','WATERTOWER','ROCKS','POWER LINES','RAILWAY', 
	'POWERSOLAR','POWERWAVE','POWERWIND','SHIPWRECK'
];
if (_type isEqualTo 'WORLD') then {
	_inset = [2000,500] select (worldName in ['Tanoa','Stratis']);
	_max = worldSize - (_inset * 2);
	for '_x' from 0 to _attempts step _step do {
		_testPos = [_inset + (random _max),_inset + (random _max),0];
		if ((!(_blacklistEnabled)) || {((_blacklistEnabled) && (_testPos call _fn_blacklist))}) then {
			if (_landPos) then {
				if (!(surfaceIsWater _testPos)) then {
					if (_bestPlacesEnabled) then {
						_bestPlaces = selectBestPlaces [_testPos,(_selectBestPlaces select 1),(_selectBestPlaces select 2),(_selectBestPlaces select 3),(_selectBestPlaces select 4)];
						if (!(_bestPlaces isEqualTo [])) then {
							if ((count _bestPlaces) > 1) then {
								_testPos = (selectRandom _bestPlaces) select 0;
							} else {
								_testPos = (_bestPlaces select 0) select 0;
							};
							_testPos set [2,0];
							_return = _testPos;
							if (_emptyPositionEnabled) then {
								if (!(_return isEqualTo [])) then {
									if ((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty select 0),FALSE,TRUE]) isEqualTo []) then {
										_return = _testPos findEmptyPosition _findEmptyPosition;
									};
								};
							};
						};
					} else {
						_return = _testPos isFlatEmpty _isFlatEmpty;
						if (_emptyPositionEnabled) then {
							if (!(_return isEqualTo [])) then {
								if ((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty select 0),FALSE,TRUE]) isEqualTo []) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};
					};
				};		
			} else {
				if (surfaceIsWater _testPos) then {
					if (_bestPlacesEnabled) then {
						_bestPlaces = selectBestPlaces [_testPos,(_selectBestPlaces select 1),(_selectBestPlaces select 2),(_selectBestPlaces select 3),(_selectBestPlaces select 4)];
						if (!(_bestPlaces isEqualTo [])) then {
							if ((count _bestPlaces) > 1) then {
								_testPos = (selectRandom _bestPlaces) select 0;
							} else {
								_testPos = (_bestPlaces select 0) select 0;
							};
							_testPos set [2,0];
							_return = _testPos;
							if (_emptyPositionEnabled) then {
								if (!(_return isEqualTo [])) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};						
					} else {
						_return = _testPos isFlatEmpty _isFlatEmpty;
						if (_emptyPositionEnabled) then {
							if (!(_return isEqualTo [])) then {
								_return = _testPos findEmptyPosition _findEmptyPosition;
							};
						};
					};
				};	
			};
		};
		if (!(_return isEqualTo [])) exitWith {};
	};
} else {
	if (_type isEqualTo 'RADIUS') then {
		for '_x' from 0 to _attempts step _step do {
			_testPos = _centerPos getPos [(_radius * (sqrt (random 1))),(random 360)];
			if (_landPos) then {
				if (!(surfaceIsWater _testPos)) then {
					if (_bestPlacesEnabled) then {
						_bestPlaces = selectBestPlaces [_testPos,(_selectBestPlaces select 1),(_selectBestPlaces select 2),(_selectBestPlaces select 3),(_selectBestPlaces select 4)];
						if (!(_bestPlaces isEqualTo [])) then {
							if ((count _bestPlaces) > 1) then {
								_testPos = (selectRandom _bestPlaces) select 0;
							} else {
								_testPos = (_bestPlaces select 0) select 0;
							};
							_testPos set [2,0];
							_return = _testPos;
							if (_emptyPositionEnabled) then {
								if (!(_return isEqualTo [])) then {
									if ((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty select 0),FALSE,TRUE]) isEqualTo []) then {
										_return = _testPos findEmptyPosition _findEmptyPosition;
									};
								};
							};
						};						
					} else {
						_return = _testPos isFlatEmpty _isFlatEmpty;
						if (_emptyPositionEnabled) then {
							if (!(_return isEqualTo [])) then {
								if ((nearestTerrainObjects [_testPos,_bto,(_isFlatEmpty select 0),FALSE,TRUE]) isEqualTo []) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};
					};
				};		
			} else {
				if (surfaceIsWater _testPos) then {
					if (_bestPlacesEnabled) then {
						_bestPlaces = selectBestPlaces [_testPos,(_selectBestPlaces select 1),(_selectBestPlaces select 2),(_selectBestPlaces select 3),(_selectBestPlaces select 4)];
						if (!(_bestPlaces isEqualTo [])) then {
							if ((count _bestPlaces) > 1) then {
								_testPos = (selectRandom _bestPlaces) select 0;
							} else {
								_testPos = (_bestPlaces select 0) select 0;
							};
							_testPos set [2,0];
							_return = _testPos;
							if (_emptyPositionEnabled) then {
								if (!(_return isEqualTo [])) then {
									_return = _testPos findEmptyPosition _findEmptyPosition;
								};
							};
						};						
					} else {
						_return = _testPos isFlatEmpty _isFlatEmpty;
						if (_emptyPositionEnabled) then {
							if (!(_return isEqualTo [])) then {
								_return = _testPos findEmptyPosition _findEmptyPosition;
							};
						};
					};
				};		
			};
			if (!(_return isEqualTo [])) exitWith {};
		};
	};
};
if (_return isEqualTo []) then {
	_return = [worldSize,worldSize,0];
};
_return;