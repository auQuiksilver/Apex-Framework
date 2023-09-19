/*/
File: fn_nearestRoad.sqf
Author:

	Quiksilver
	
Last Modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	Nearest road segment to a given position
_____________________________________________________________________/*/

params ['_centerPos','_centerRadius',['_includeTrails',FALSE]];
if (_centerPos isEqualType objNull) then {
	_centerPos = getPosATL _centerPos;
};
_roads = ((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo [_x,_includeTrails]) isNotEqualTo []))};
private _road = objNull;
if (_roads isNotEqualTo []) then {
	private _dist = 999999;
	private _max = _dist;
	{
		_dist = _x distanceSqr _centerPos;
		if (_dist < _max) then {
			_max = _dist;
			_road = _x;
		};
	} count _roads;
};
_road;