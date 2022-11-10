/*/
File: fn_isUnderRock.sqf
Author:

	Quiksilver
	
Last modified:

	1/11/2022 A3 2.10 by Quiksilver
	
Description:

	Is the position/object under a rock
__________________________________________________/*/

params ['_entity'];
private _return = FALSE;
_origin = getPosASL _entity;
_intersections = lineIntersectsSurfaces [_origin vectorAdd [0,0,0.5],_origin vectorAdd [0,0,50],_entity,objNull,TRUE,1,'GEOM','NONE',TRUE];
if (_intersections isNotEqualTo []) then {
	_object = (_intersections # 0) # 2;
	_return = ((!isNull _object) && {(['rock',(getModelInfo _object) # 1,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))});
};
_return;