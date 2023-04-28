/*/
File: fn_isBoundingBoxIntersected.sqf
Author: 

	Quiksilver (Credit: Killzone Kid)

Last Modified:

	20/02/2022 A3 2.12 by Quiksilver

Description:

	Is a bounding box being intersected by any other surface
__________________________________/*/

params [['_obj',objNull],['_clippingType',0],['_bboxr',[]],['_returnType',0]];
private _attachedObjects3 = attachedObjects _obj;
if (isNull _obj) exitWith {FALSE};
if (_bboxr isEqualTo []) then {
	_boundingBox = _clippingType boundingBoxReal _obj;
	_bboxr = [_obj,(_boundingBox # 0),(_boundingBox # 1)] call {
		params ['_obj','_a1','_a2'];
		_bbx = [(_a1 # 0),(_a2 # 0)];
		_bby = [(_a1 # 1),(_a2 # 1)];
		_bbz = [(_a1 # 2),(_a2 # 2)];
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
		_arr pushBack (_arr # 0);
		_arr pushBack (_arr # 1);
		_arr;
	};
};
if (_returnType isEqualTo 1) exitWith {
	// Returns array of problematic intersections
	private _return = [];
	private _problematic = ['LandVehicle','Air','Sea','StaticWeapon','CAManBase','ThingX'];
	for '_i' from 0 to 7 step 2 do {
		{
			{
				_x params ['','','_intersectObj','_parentObj'];
				if (!isNull _intersectObj) then {
					if ((_problematic findIf { (_intersectObj isKindOf _x) }) isNotEqualTo -1) then {
						_return pushBackUnique _intersectObj;
					};
				};
				if (!isNull _parentObj) then {
					if ((_problematic findIf { (_parentObj isKindOf _x) }) isNotEqualTo -1) then {
						_return pushBackUnique _parentObj;
					};
				};
			} forEach ((lineIntersectsSurfaces [(_x # 0),(_x # 1),QS_player,_obj,TRUE,-1,'GEOM','ROADWAY',TRUE]) + (lineIntersectsSurfaces [(_x # 0),(_x # 1),QS_player,_obj,TRUE,-1,'VIEW','PHYSX',TRUE]));
		} forEach [
			[(AGLToASL(_bboxr # _i)),(AGLToASL(_bboxr # (_i + 2)))],
			[(AGLToASL(_bboxr # (_i + 2))),(AGLToASL(_bboxr # (_i + 3)))],
			[(AGLToASL(_bboxr # (_i + 3))),(AGLToASL(_bboxr # (_i + 1)))],
			[(AGLToASL (_obj modelToWorldVisual (_bboxr # 1))),(AGLToASL (_obj modelToWorldVisual (_bboxr # 0)))]
		];
	};
	_return;
};
// Returns bool
private _obstrDetected = FALSE;
for '_i' from 0 to 7 step 2 do {
	{
		{
			if ((isNull (_x # 2)) && (isNull (_x # 3))) then {
			
			} else {
				if (
					(!((_x # 2) in _attachedObjects3)) &&
					(!((_x # 3) in _attachedObjects3))
				) then {
					_obstrDetected = TRUE;
				};
			};
		} forEach ((lineIntersectsSurfaces [(_x # 0),(_x # 1),QS_player,_obj,TRUE,-1,'GEOM','ROADWAY',TRUE]) + (lineIntersectsSurfaces [(_x # 0),(_x # 1),QS_player,_obj,TRUE,-1,'VIEW','PHYSX',TRUE]));
	} forEach [
		[(AGLToASL(_bboxr # _i)),(AGLToASL(_bboxr # (_i + 2)))],
		[(AGLToASL(_bboxr # (_i + 2))),(AGLToASL(_bboxr # (_i + 3)))],
		[(AGLToASL(_bboxr # (_i + 3))),(AGLToASL(_bboxr # (_i + 1)))],
		[(AGLToASL (_obj modelToWorldVisual (_bboxr # 1))),(AGLToASL (_obj modelToWorldVisual (_bboxr # 0)))]
	];
};
_obstrDetected;