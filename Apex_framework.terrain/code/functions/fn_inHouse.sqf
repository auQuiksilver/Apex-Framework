/*/
File: fn_inHouse.sqf
Author:

	Quiksilver
	
Last Modified:

	8/04/2018 A3 1.82 by Quiksilver
	
Description:

	Entity house check
_______________________________________________/*/

params ['_entity','_posworld'];
_intersections = lineIntersectsSurfaces [_posworld,(_posworld vectorAdd [0,0,25]),_entity,objNull,TRUE,1,'GEOM','NONE',TRUE];
if (_intersections isEqualTo []) then {
	_intersections = lineIntersectsSurfaces [_posworld,(_posworld vectorAdd [0,0,-25]),_entity,objNull,TRUE,1,'GEOM','NONE',TRUE];
};
if (_intersections isEqualTo []) exitWith {
	[FALSE,objNull]
};
(_intersections select 0) params ['','','',['_house',objNull]];
if (isNull _house) exitWith {
	[FALSE,objNull]
};
if (_house isKindOf 'House') exitWith {
	[TRUE,_house]
};
[FALSE,objNull]