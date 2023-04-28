/*/
File: fn_inHouse.sqf
Author:

	Quiksilver
	
Last Modified:

	21/01/2023 A3 2.10 by Quiksilver
	
Description:

	Entity house check
_______________________________________________/*/

params [['_entity',objNull],'_posworld',['_alt',FALSE]];
if (_alt && {(insideBuilding _entity) isEqualTo 1}) exitWith {[TRUE,objNull]};
_intersections = lineIntersectsSurfaces [_posworld,(_posworld vectorAdd [0,0,15]),_entity,objNull,TRUE,1,'GEOM','NONE',TRUE];
if (_intersections isEqualTo []) then {
	_intersections = lineIntersectsSurfaces [_posworld,(_posworld vectorAdd [0,0,-5]),_entity,objNull,TRUE,1,'GEOM','NONE',TRUE];
};
if (_intersections isEqualTo []) exitWith {
	[FALSE,objNull]
};
(_intersections # 0) params ['','','',['_house',objNull]];
if (isNull _house) exitWith {
	[FALSE,objNull]
};
if (
	(_house isKindOf 'House') ||
	{(_house isKindOf 'Building')}
) exitWith {
	[TRUE,_house]
};
[FALSE,objNull]