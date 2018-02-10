/*
File: fn_findSafePos.sqf
Author:

	Joris-Jan Van't Land (modified by Quiksilver)
	
Last modified:

	21/03/2016 A3 1.56 by Quiksilver
	
Description:

	Function to retrieve and dynamic position in the world according to several parameters.

Parameter(s):
	
	_this select 0: center position (Array)
						Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
	_this select 1: minimum distance from the center position (Number)
	_this select 2: maximum distance from the center position (Number)
						Note: passing -1, the world's safePositionRadius entry will be used.
	_this select 3: minimum distance from the nearest object (Number)
	_this select 4: water mode (Number)
						0: cannot be in water
						1: can either be in water or not
						2: must be in water
	_this select 5: maximum terrain gradient (average altitude difference in meters - Number)
	_this select 6: shore mode (Number):
						0: does not have to be at a shore
						1: must be at a shore
	
Returns:
	
	Coordinate array with a position solution.
	
TODO:
	
	* Maybe allow passing several combinations of position, min and max dist ... so that you can 
	avoid several things?
	* Interpretation of minDist / maxDist is wrong. It's not true distance that is used. Too bad?
	'TRAIL','TREE','SMALL TREE','BUSH','MAIN ROAD','TRACK','FOREST',
________________________________________________________________________________________________________*/

params ['_pos','_minDist','_maxDist','_objDist','_waterMode','_maxGradient','_shoreMode'];
private ['_newPos','_posX','_posY','_newX','_newY','_testPos','_defaultPos','_blacklist','_isTanoa','_bto'];
scopeName 'main';
if (_shoreMode isEqualTo 0) then {_shoreMode = FALSE;} else {_shoreMode = TRUE;};
if (_pos isEqualTo []) then {
	_pos = missionNamespace getVariable ['QS_safePositionAnchor',-1];
	if (_pos isEqualTo -1) then {
		_pos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'safePositionAnchor');
		missionNamespace setVariable ['QS_safePositionAnchor',(if (worldName isEqualTo 'Tanoa') then [{[2086.95,7805.91,0]},{_pos}]),TRUE];
	};
};
if (_pos isEqualTo []) exitWith {diag_log 'Log: [findSafePos] No center position was passed!'; []};
if (_maxDist isEqualTo -1) then {
	_maxDist = missionNamespace getVariable ['QS_safePositionRadius',-1];
	if (_maxDist isEqualTo -1) then {
		_maxDist = getNumber (configFile >> 'CfgWorlds' >> worldName >> 'safePositionRadius');
		missionNamespace setVariable ['QS_safePositionRadius',_maxDist,TRUE];
	};
};
_newPos = [];
_defaultPos = [];
_posX = _pos select 0;
_posY = _pos select 1;
_posZ = _pos select 2;
_isTanoa = FALSE;
if (worldName isEqualTo 'Tanoa') then {
	_isTanoa = TRUE;
};
_bto = [
	'BUILDING','HOUSE','FOREST BORDER', 
	'FOREST TRIANGLE','FOREST SQUARE','CHURCH','CHAPEL', 
	'CROSS','ROCK','BUNKER','FORTRESS','FOUNTAIN','VIEW-TOWER', 
	'LIGHTHOUSE','QUAY','FUELSTATION','HOSPITAL','FENCE','WALL', 
	'HIDE','BUSSTOP','ROAD','TRANSMITTER','STACK','RUIN', 
	'TOURISM','WATERTOWER','ROCKS','POWER LINES','RAILWAY', 
	'POWERSOLAR','POWERWAVE','POWERWIND','SHIPWRECK'
];

for '_x' from 0 to 999 step 1 do {
	_newX = _posX + (_maxDist - (random (_maxDist * 2)));
	_newY = _posY + (_maxDist - (random (_maxDist * 2)));
	_testPos = [_newX,_newY,_posZ];
	if ((_pos distance2D _testPos) >= _minDist) then {
		if (_isTanoa) then {
			if (!((_testPos isFlatEmpty [0,-1,_maxGradient,(_objDist max 2),_waterMode,_shoreMode,objNull]) isEqualTo [])) then {
				if ((nearestTerrainObjects [_testPos,_bto,_objDist,FALSE,TRUE]) isEqualTo []) then {
					_newPos = _testPos;
					breakTo 'main';
				};
			};
		} else {
			if (!((_testPos isFlatEmpty [_objDist,-1,_maxGradient,(_objDist max 5),_waterMode,_shoreMode,objNull]) isEqualTo [])) then {
				_newPos = _testPos;
				breakTo 'main';
			};
		};
	};
};
if (_newPos isEqualTo []) then {
	if (_waterMode isEqualTo 0) then {
		if (!(_defaultPos isEqualTo [])) then {
			_newPos = _defaultPos select 0;
		} else {
			_newPos = missionNamespace getVariable ['QS_positionStart',-1];
			if (_newPos isEqualTo -1) then {
				_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'Armory' >> 'positionStart');
				missionNamespace setVariable ['QS_positionStart',_newPos,TRUE];
			};
		};
	} else {
		if ((count _defaultPos) > 1) then {
			_newPos = _defaultPos select 1;
		} else {
			_newPos = missionNamespace getVariable ['QS_positionStartWater',-1];
			if (_newPos isEqualTo -1) then {
				_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'Armory' >> 'positionStartWater');
				missionNamespace setVariable ['QS_positionStartWater',_newPos,TRUE];
			};
		};
	};
};
if (_newPos isEqualTo []) then {
	_newPos = missionNamespace getVariable ['QS_centerPosition',-1];
	if (_newPos isEqualTo -1) then {
		_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'centerPosition');
		missionNamespace setVariable ['QS_centerPosition',_newPos,TRUE];
	};
};
_newPos set [2,0];
_newPos;