/*/
File: fn_findOverwatchPos.sqf
Author:

	Quiksilver
	
Last modified:

	23/10/2018 A3 1.84 by Quiksilver
	
Description:

	Function which selects a position that provides overwatch
	onto another position.

Parameter(s):

	_this # 0: the target position (ASL)
	_this # 1: maximum distance from target in meters (optional)
	_this # 2: minimum distance from target in meters (optional)
	_this # 3: minimum height in relation to target in meters (optional)
	_this # 4: check visibility
	_this # 5: return array of positions instead of single position
	
Returns:

	Position (ASL) or array of ASL positions.
	
	systemChat str ([getPosASL,1000,100,10,[[player, "VIEW"],1],3] call QS_fnc_findOverwatchPos);
	
	params ['_pos','_minDist','_maxDist','_objDist','_waterMode','_maxGradient','_shoreMode',['_maxGradientRadius',1]];
	
__________________________________________________________________________/*/

params [
	['_targetPos',[0,0,0]],
	['_maxrange',3000],
	['_minrange',0],
	['_minheight',0],
	['_checkVisibility',[]],
	['_returnList',-1],
	['_minObjDist',2]
];
scopeName 'main';
_targetPos = _targetPos vectorAdd [0,0,1];
private _minheight = _minheight + (getTerrainHeightASL _targetPos);
private _selectedPositions = [];
private _result = [];
private _checkPos = [];
private _dis = 0;
private _counter1 = 0;
private _counter2 = 0;
private _terrainBlocked = TRUE;
private _isCheckVisibility = _checkVisibility isNotEqualTo [];
private _height = 0;
for '_x' from 0 to 49 step 1 do {
	for '_x' from 0 to 49 step 1 do {
		_checkPos = ([_targetPos,_minrange,_maxrange,_minObjDist,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos')) vectorAdd [0,0,0.5];
		_height = getTerrainHeightASL _checkPos;
		_dis = _checkPos distance2D _targetPos;
		_checkPos set [2,_height + 1];
		if (_height >= _minheight) then {
			if (_dis > _minrange) then {
				_terrainBlocked = terrainIntersect [_targetPos,_checkPos];
				if (!(_terrainBlocked)) then {
					if (_isCheckVisibility) then {
						if (((_checkVisibility # 0) checkVisibility [_checkPos,_targetPos]) >= (_checkVisibility # 1)) then {
							_selectedPositions pushBack _checkPos;
						};
					} else {
						_selectedPositions pushBack _checkPos;
					};
				};
			};
		};
		if (_counter2 <= 50) then {
			if ((count _selectedPositions) >= 10) then {
				breakTo 'main';
			};
		} else {
			if (_selectedPositions isNotEqualTo []) then {
				breakTo 'main';
			};
		};
		_counter2 = _counter2 + 1;
	};
	if (_counter1 <= 50) then {
		if ((count _selectedPositions) >= 10) then {
			breakTo 'main';
		};
	} else {
		if (_selectedPositions isNotEqualTo []) then {
			breakTo 'main';
		};
	};
	_minheight = _minheight - 0.1;
	_counter1 = _counter1 + 1;
};
if (_selectedPositions isNotEqualTo []) then {
	if ((count _selectedPositions) isNotEqualTo 1) then {
		_selectedPositions = _selectedPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_result = _selectedPositions # 0;
		private _maximum = getTerrainHeightASL _result;
		{
			if ((random 1) > 0.5) then {
				_height = getTerrainHeightASL _x;
				if (_height > _maximum) then {
					_result = _x;
					_maximum = _height;
				};
			};
		} count _selectedPositions;
	} else {
		_result = _selectedPositions # 0;
	};
} else {
	for '_x' from 0 to 299 step 1 do {
		_checkPos = ([_targetPos,_minrange,_maxrange,_minObjDist,0,1,0] call (missionNamespace getVariable 'QS_fnc_findSafePos')) vectorAdd [0,0,0.5];
		_terrainBlocked = terrainIntersect [_targetPos,_checkPos];
		if (!(_terrainBlocked)) then {
			if (_isCheckVisibility) then {
				if (((_checkVisibility # 0) checkVisibility [_checkPos,_targetPos]) >= (_checkVisibility # 1)) then {
					_selectedPositions pushBack _checkPos;
				};
			} else {
				_selectedPositions pushBack _checkPos;
			};
		};
		if (_selectedPositions isNotEqualTo []) exitWith {};
	};
	if (_selectedPositions isNotEqualTo []) then {
		if ((count _selectedPositions) isNotEqualTo 1) then {
			_selectedPositions = _selectedPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_result = _selectedPositions # 0;
			private _maximum = getTerrainHeightASL _result;
			{
				if ((random 1) > 0.5) then {
					_height = getTerrainHeightASL _x;
					if (_height > _maximum) then {
						_result = _x;
						_maximum = _height;
					};
				};
			} count _selectedPositions;
		} else {
			_result = _selectedPositions # 0;
		};
	};
};
if (_returnList isNotEqualTo -1) exitWith {
	_selectedPositions = _selectedPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	(_selectedPositions select [0,_returnList]);
};
if (_result isEqualTo []) then {
	_result = _targetPos;
};
_result;