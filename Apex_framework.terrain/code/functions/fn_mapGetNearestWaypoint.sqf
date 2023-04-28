/*/
File: fn_mapGetNearestWaypoint.sqf
Author:

	Quiksilver
	
Last Modified:

	10/04/2018 A3 1.82 by Quiksilver
	
Description:

	-
_____________________________________________________________________/*/

params ['_mousePosition','_mScale'];
private _wpIndex = 0;
private _grp = grpNull;
private _waypointsInRadius = [];
private _nearestWaypoint = [grpNull,-1];
private _dist = 999999;
private _max = _dist;
_radius = (10 max (200 * _mScale));
{
	if (!isNull _x) then {
		_grp = _x;
		if ((waypoints _grp) isNotEqualTo []) then {
			{
				if (((waypointPosition [_grp,_forEachIndex]) distance2D _mousePosition) <= _radius) then {
					_waypointsInRadius pushBack _x;
				};
			} forEach (waypoints _grp);
		};
	};
} forEach (groups (player getVariable ['QS_unit_side',WEST]));
if (_waypointsInRadius isNotEqualTo []) then {
	{
		_dist = (waypointPosition _x) distance2D _mousePosition;
		if (_dist < _max) then {
			_max = _dist;
			_nearestWaypoint = _x;
		};
	} forEach _waypointsInRadius;
};
_nearestWaypoint;