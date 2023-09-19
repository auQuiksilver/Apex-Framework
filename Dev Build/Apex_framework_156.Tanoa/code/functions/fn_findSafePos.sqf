/*/
File: fn_findSafePos.sqf
Author:

	Joris-Jan Van't Land (modified by Quiksilver)
	
Last modified:

	20/08/2022 A3 2.10 by Quiksilver
	
Description:

	Function to retrieve and dynamic position in the world according to several parameters.

Parameter(s):
	
	_this # 0: center position (Array)
						Note: passing [] (empty Array), the world's safePositionAnchor entry will be used.
	_this # 1: minimum distance from the center position (Number)
	_this # 2: maximum distance from the center position (Number)
						Note: passing -1, the world's safePositionRadius entry will be used.
	_this # 3: minimum distance from the nearest object (Number)
	_this # 4: water mode (Number)
						0: cannot be in water
						1: can either be in water or not
						2: must be in water
	_this # 5: maximum terrain gradient (average altitude difference in meters - Number)
	_this # 6: shore mode (Number):
						0: does not have to be at a shore
						1: must be at a shore
	
Returns:
	
	Coordinate array with a position solution.
	
TODO:
	
	* Maybe allow passing several combinations of position, min and max dist ... so that you can 
	avoid several things?
	* Interpretation of minDist / maxDist is wrong. It's not true distance that is used. Too bad?
	'TRAIL','TREE','SMALL TREE','BUSH','MAIN ROAD','TRACK','FOREST',
________________________________________________________________________________________________________/*/

params ['_pos','_minDist','_maxDist','_objDist','_waterMode','_maxGradient','_shoreMode',['_maxGradientRadius',1]];
scopeName 'main';
_shoreMode = _shoreMode isNotEqualTo 0;
if (_pos isEqualTo []) then {
	_pos = missionNamespace getVariable ['QS_safePositionAnchor',-1];
	if (_pos isEqualTo -1) then {
		_pos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'safePositionAnchor');
		missionNamespace setVariable ['QS_safePositionAnchor',(if (worldName isEqualTo 'Tanoa') then [{[2086.95,7805.91,0]},{_pos}]),FALSE];
	};
};
if (_pos isEqualTo []) exitWith {diag_log 'Log: [findSafePos] No center position was passed!';[]};
if (_maxDist isEqualTo -1) then {
	_maxDist = missionNamespace getVariable ['QS_safePositionRadius',-1];
	if (_maxDist isEqualTo -1) then {
		_maxDist = getNumber (configFile >> 'CfgWorlds' >> worldName >> 'safePositionRadius');
		missionNamespace setVariable ['QS_safePositionRadius',_maxDist,FALSE];
	};
};
private _distDiff = _maxDist - _minDist;
private _newPos = [];
private _defaultPos = [];
private _testPos = [-1000,-1000,0];
private _newY = 0;
private _newX = 0;
_true = TRUE;
_false = FALSE;
_objNull = objNull;
_pos params ['_posX','_posY','_posZ'];
_isTropics = worldName in ['Tanoa','Lingor3','Enoch'];
_worldArea = missionNamespace getVariable 'QS_terrain_worldArea';
_bto = [
	'building','house','forest border', 
	'forest triangle','forest square','church','chapel', 
	'cross','rock','bunker','fortress','fountain','view-tower', 
	'lighthouse','quay','fuelstation','hospital','fence','wall', 
	'hide','busstop','road','transmitter','stack','ruin', 
	'tourism','watertower','rocks','power lines','railway', 
	'powersolar','powerwave','powerwind','shipwreck'
];
for '_x' from 0 to 999 step 1 do {
	_testPos = _pos getPos [_minDist + (_distDiff * (sqrt (random 1))),(random 360)];
	if (_testPos inArea _worldArea) then {
		if (_isTropics) then {
			if ((_testPos isFlatEmpty [_objDist,-1,_maxGradient,_maxGradientRadius,_waterMode,_shoreMode,_objNull]) isNotEqualTo []) then {
				if ((nearestTerrainObjects [_testPos,_bto,_objDist,_false,_true]) isEqualTo []) then {
					_newPos = _testPos;
					breakTo 'main';
				};
			};
		} else {
			if ((_testPos isFlatEmpty [_objDist,-1,_maxGradient,_maxGradientRadius,_waterMode,_shoreMode,_objNull]) isNotEqualTo []) then {
				if ((nearestTerrainObjects [_testPos,_bto,_objDist,_false,_true]) isEqualTo []) then {
					_newPos = _testPos;
					breakTo 'main';
				};
			};
		};
	};
};
if (_newPos isEqualTo []) then {
	if (_waterMode isEqualTo 0) then {
		if (_defaultPos isNotEqualTo []) then {
			_newPos = _defaultPos # 0;
		} else {
			_newPos = missionNamespace getVariable ['QS_positionStart',-1];
			if (_newPos isEqualTo -1) then {
				_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'Armory' >> 'positionStart');
				missionNamespace setVariable ['QS_positionStart',_newPos,FALSE];
			};
		};
	} else {
		if ((count _defaultPos) > 1) then {
			_newPos = _defaultPos # 1;
		} else {
			_newPos = missionNamespace getVariable ['QS_positionStartWater',-1];
			if (_newPos isEqualTo -1) then {
				_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'Armory' >> 'positionStartWater');
				missionNamespace setVariable ['QS_positionStartWater',_newPos,FALSE];
			};
		};
	};
};
if (_newPos isEqualTo []) then {
	_newPos = missionNamespace getVariable ['QS_centerPosition',-1];
	if (_newPos isEqualTo -1) then {
		_newPos = getArray (configFile >> 'CfgWorlds' >> worldName >> 'centerPosition');
		missionNamespace setVariable ['QS_centerPosition',_newPos,FALSE];
	};
};
_newPos set [2,0];
_newPos;