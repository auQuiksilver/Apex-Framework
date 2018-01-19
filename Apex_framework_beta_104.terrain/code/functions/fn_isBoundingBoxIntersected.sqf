/*/
File: fn_isBoundingBoxIntersected.sqf
Author: 

	Quiksilver

Last Modified:

	19/01/2018 A3 1.80 by Quiksilver

Description:

	-
____________________________________________________________________________/*/

_obj = _this;
_bb = {
	params ['_obj','_a1','_a2'];
	_bbx = [(_a1 select 0),(_a2 select 0)];
	_bby = [(_a1 select 1),(_a2 select 1)];
	_bbz = [(_a1 select 2),(_a2 select 2)];
	_arr = [];
	0 = {
		_y = _x;
		0 = {
			_z = _x;
			0 = {
				0 = _arr pushBack (_obj modelToWorldVisual [_x,_y,_z]);
			} count _bbx;
		} count _bbz;
		reverse _bbz;
	} count _bby;
	_arr pushBack (_arr select 0);
	_arr pushBack (_arr select 1);
	_arr;
};
_bboxr = [_obj,((boundingBoxReal _obj) select 0),((boundingBoxReal _obj) select 1)] call _bb;
private _obstruction = objNull;
private _groundIntersection = objNull;
private _obstrDetected = FALSE;
private _lineIntersectsSurfaces = [];
for '_i' from 0 to 7 step 2 do {
	{
		_lineIntersectsSurfaces = lineIntersectsSurfaces [(_x select 0),(_x select 1),(vehicle player),cameraOn];
		if (!(_lineIntersectsSurfaces isEqualTo [])) then {
			{
				if (!isNull (_x select 3)) then {
					_obstrDetected = TRUE;
					_obstruction = (_x select 3);
				};
			} forEach _lineIntersectsSurfaces;
		};
	} forEach [
		[(AGLToASL(_bboxr select _i)),(AGLToASL(_bboxr select (_i + 2)))],
		[(AGLToASL(_bboxr select (_i + 2))),(AGLToASL(_bboxr select (_i + 3)))],
		[(AGLToASL(_bboxr select (_i + 3))),(AGLToASL(_bboxr select (_i + 1)))]
	];
};
_groundIntersections = lineIntersectsSurfaces [(getPosASL _obj),[((getPosASL _obj) select 0),((getPosASL _obj) select 1),(((getPosASL _obj) select 2) - 1)],_obj,cameraOn,TRUE,1,'GEOM','VIEW',TRUE];
if (!(_groundIntersections isEqualTo [])) then {
	_groundIntersection = (_groundIntersections select 0) select 3;
};
if ((!isNull _groundIntersection) && (_obstruction isEqualTo _groundIntersection)) exitWith {FALSE};
_obstrDetected;