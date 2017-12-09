/*/
File: fn_isBoundingBoxIntersected.sqf
Author: 

	Quiksilver

Last Modified:

	18/04/2017 A3 1.68 by Quiksilver

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
private _obstrDetected = FALSE;
private _lineIntersectsSurfaces = [];
for '_i' from 0 to 7 step 2 do {
	{
		_lineIntersectsSurfaces = lineIntersectsSurfaces [(_x select 0),(_x select 1),(vehicle player),cameraOn];
		if (!(_lineIntersectsSurfaces isEqualTo [])) then {
			{
				if (!isNull (_x select 3)) then {
					_obstrDetected = TRUE;
				};
			} forEach _lineIntersectsSurfaces;
		};
	} forEach [
		[(AGLToASL(_bboxr select _i)),(AGLToASL(_bboxr select (_i + 2)))],
		[(AGLToASL(_bboxr select (_i + 2))),(AGLToASL(_bboxr select (_i + 3)))],
		[(AGLToASL(_bboxr select (_i + 3))),(AGLToASL(_bboxr select (_i + 1)))]
	];
};
_obstrDetected;