/*/
File: fn_getRopeAttachPos.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/03/2023 A3 2.12 by Quiksilver
	
Description:

	Get Rope Attach Point
______________________________________________________/*/

params ['_mode','_vehicle'];
private _return = [0,0,0];
(0 boundingBoxReal _vehicle) params ['_p1','_p2'];
if (_mode isEqualTo 'FRONT') exitWith {
	_return = [0,2,0];
	_modelXhalf = ((_p1 # 0) + (_p2 # 0)) / 2;
	_modelY = _p2 # 1;
	_modelZ = _p1 # 2;
	_frontWorldPos = _vehicle modelToWorld [_modelXhalf,_modelY,_modelZ + 0.1];
	_centerPos = _vehicle modelToWorld [_modelXhalf,0,0];
	_intersections = lineIntersectsSurfaces [AGLToASL _frontWorldPos,AGLToASL _centerPos,objnull,objnull,TRUE,-1];
	if (_intersections isNotEqualTo []) then {
		{
			(_intersections # _forEachIndex) params ['_intersectionPos','',['_intersectionObject',objNull]];
			if (!isNull _intersectionObject) then {
				if (_intersectionObject isEqualTo _vehicle) then {
					_return = _vehicle worldToModel (ASLToAGL _intersectionPos);
				};
			};
			if (_return isNotEqualTo [0,0,0]) exitWith {};
		} forEach _intersections;
	};
	_return;
};
if (_mode isEqualTo 'BACK') exitWith {
	_return = [0,-2,0];
	_modelXhalf = ((_p1 # 0) + (_p2 # 0)) / 2;
	_modelY = _p1 # 1;
	_modelZ = _p1 # 2;
	_backWorldPos = _vehicle modelToWorld [_modelXhalf,_modelY,_modelZ + 0.1];
	_centerPos = _vehicle modelToWorld [_modelXhalf,0,0];
	_intersections = lineIntersectsSurfaces [AGLToASL _backWorldPos,AGLToASL _centerPos,objnull,objnull,TRUE,-1];
	if (_intersections isNotEqualTo []) then {
		{
			(_intersections # _forEachIndex) params ['_intersectionPos','',['_intersectionObject',objNull]];
			if (!isNull _intersectionObject) then {
				if (_intersectionObject isEqualTo _vehicle) then {
					_return = _vehicle worldToModel (ASLToAGL _intersectionPos);
				};
			};
			if (_return isNotEqualTo [0,0,0]) exitWith {};
		} forEach _intersections;
	};
	_return;
};
_return;