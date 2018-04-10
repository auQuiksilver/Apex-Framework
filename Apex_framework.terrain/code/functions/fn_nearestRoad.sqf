/*/
File: fn_nearestRoad.sqf
Author:

	Quiksilver
	
Last Modified:

	10/02/2018 A3 1.80 by Quiksilver
	
Description:

	Nearest road segment to a given position
_____________________________________________________________________/*/

params ['_centerPos','_centerRadius'];
if (_centerPos isEqualType objNull) then {
	_centerPos = getPosATL _centerPos;
};
_roads = ((_centerPos select [0,2]) nearRoads _centerRadius) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))};
private _road = objNull;
if (!(_roads isEqualTo [])) then {
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