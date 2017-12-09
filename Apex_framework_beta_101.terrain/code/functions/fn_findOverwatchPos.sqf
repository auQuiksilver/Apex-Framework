/*/
File: fn_findOverwatchPos.sqf
Author:

	Quiksilver
	
Last modified:

	14/03/2017 A3 1.66 by Quiksilver
	
Description:
	Function which selects a position that provides overwatch
	onto another position.

Parameter(s):
	_this select 0: the target position (position)
	_this select 1: maximum distance from target in meters (optional)
	_this select 2: minimum distance from target in meters (optional)
	_this select 3: minimum height in relation to target in meters (optional)
	_this select 4: check visibility
__________________________________________________________________________/*/

params ['_targetPos','_maxrange','_minrange','_minheight','_checkVisibility'];
private [
	'_selectedPositions','_result','_checkPos','_height','_dis',
	'_terrainBlocked','_counter1','_counter2','_isCheckVisibility'
];
scopeName 'main';
_targetPos = [(_targetPos select 0),(_targetPos select 1), ((_targetPos select 2) + 1)];
_minheight = _minheight + (getTerrainHeightASL _targetPos);
_selectedPositions = [];
_result = [];
_checkPos = [];
_dis = 0;
_counter1 = 0;
_counter2 = 0;
_terrainBlocked = TRUE;
_isCheckVisibility = FALSE;
if (!isNil '_checkVisibility') then {
	if (!(_checkVisibility isEqualTo [])) then {
		_isCheckVisibility = TRUE;
	};
};
for '_x' from 0 to 49 step 1 do {
	for '_x' from 0 to 49 step 1 do {
		_checkPos = [_targetPos,_minrange,_maxrange,3,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		_checkPos set [2,((_checkPos select 2) + 0.5)];
		if (!(_checkPos isEqualTo [])) then {
			_height = getTerrainHeightASL _checkPos;
			_dis = _checkPos distance2D _targetPos;
			if (_height >= _minheight) then {
				if (_dis > _minrange) then {
					_terrainBlocked = terrainIntersect [_targetPos,_checkPos];
					if (!(_terrainBlocked)) then {
						if (_isCheckVisibility) then {
							if (((_checkVisibility select 0) checkVisibility [[(_checkPos select 0),(_checkPos select 1),(_height + 1)],(_checkVisibility select 1)]) > (_checkVisibility select 2)) then {
								_selectedPositions pushBack _checkPos;
							};
						} else {
							_selectedPositions pushBack _checkPos;
						};
					};
				};
			};
			if (_counter2 <= 25) then {
				if ((count _selectedPositions) >= 5) then {
					breakTo 'main';
				};
			} else {
				if ((count _selectedPositions) >= 1) then {
					breakTo 'main';
				};
			};
			_counter2 = _counter2 + 1;
		};
	};
	if (_counter1 <= 25) then {
		if ((count _selectedPositions) >= 5) then {
			breakTo 'main';
		};
	} else {
		if ((count _selectedPositions) >= 1) then {
			breakTo 'main';
		};
	};
	_minheight = _minheight - 0.1;
	_counter1 = _counter1 + 1;
};
if (!(_selectedPositions isEqualTo [])) then {
	if (!((count _selectedPositions) isEqualTo 1)) then {
		_result = selectRandom _selectedPositions;
		_maximum = getTerrainHeightASL _result;
		{
			_height = getTerrainHeightASL _x;
			if (_height > _maximum) then {
				_result = _x;
				_maximum = _height;
			};
		} count _selectedPositions;
	} else {
		_result = _selectedPositions select 0;
	};
} else {
	for '_x' from 0 to 299 step 1 do {
		_checkPos = [_targetPos,_minrange,_maxrange,3,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
		_checkPos set [2,((_checkPos select 2) + 0.5)];
		_terrainBlocked = terrainIntersect [_targetPos,_checkPos];
		if (!(_terrainBlocked)) then {
			if (_isCheckVisibility) then {
				if (((_checkVisibility select 0) checkVisibility [[(_checkPos select 0),(_checkPos select 1),(_height + 1)],(_checkVisibility select 1)]) > (_checkVisibility select 2)) then {
					_selectedPositions pushBack _checkPos;
				};
			} else {
				_selectedPositions pushBack _checkPos;
			};
		};
		if ((count _selectedPositions) >= 1) exitWith {};
	};
	if (!(_selectedPositions isEqualTo [])) then {
		if (!((count _selectedPositions) isEqualTo 1)) then {
			_result = selectRandom _selectedPositions;
			_maximum = getTerrainHeightASL _result;
			{
				_height = getTerrainHeightASL _x;
				if (_height > _maximum) then {
					_result = _x;
					_maximum = _height;
				};
			} count _selectedPositions;
		} else {
			_result = _selectedPositions select 0;
		};
	};
};
if (_result isEqualTo []) then {
	_result = _targetPos;
};
_result;