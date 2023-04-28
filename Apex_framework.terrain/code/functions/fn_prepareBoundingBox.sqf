/*/
File: fn_prepareBoundingBox.sqf
Author:

	Quiksilver
	
Last Modified:

	13/02/2023 A3 2.12 by Quiksilver
	
Description:

	Prepare Bounding Box Vertices
	
Credit:

	Killzone_Kid for explanations and examples re bounding boxes
	
	_bbox = [_bb,0,[0,0,0],[]] call QS_fnc_prepareBoundingBox;
___________________________________________/*/

params ['_boundingBox',['_drawMode',0],['_ref',[0,0,0]],['_rotMatrix',[]]];
_bbx = [(_boundingBox # 0) # 0, (_boundingBox # 1) # 0];
_bby = [(_boundingBox # 0) # 1, (_boundingBox # 1) # 1];
_bbz = [(_boundingBox # 0) # 2, (_boundingBox # 1) # 2];
_arr = [];
0 = {
	_y = _x;
	0 = {
		_z = _x;
		0 = {
			if (_drawMode isEqualTo 0) then {
				0 = _arr pushBack (_ref modelToWorldVisual [_x,_y,_z]);
			} else {
				0 = _arr pushBack (_ref vectorAdd ([_rotMatrix,[_x,_y,_z]] call {
					params ['_array1','_array2'];
					[
						(((_array1 # 0) # 0) * (_array2 # 0)) + (((_array1 # 0) # 1) * (_array2 # 1)),
						(((_array1 # 1) # 0) * (_array2 # 0)) + (((_array1 # 1) # 1) * (_array2 # 1)),
						_array2 # 2
					]
				}));
			};
		} count _bbx;
	} count _bbz;
	reverse _bbz;
} count _bby;
_arr pushBack (_arr # 0);
_arr pushBack (_arr # 1);
_arr;