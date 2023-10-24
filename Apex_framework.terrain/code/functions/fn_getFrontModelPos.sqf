/*/
File: fn_getFrontModelPos.sqf
Author:
	
	Quiksilver
	
Last Modified:

	1/4/2023 A3 2.12 by Quiksilver
	
Description:

	Align position of a child object in front of a parent object
______________________________________________________/*/

params ['_mode','_parent','_child',['_yBuffer',0.25],'_rotationEnabled',['_memPoint',''],['_followRotation',FALSE],['_zOffset',0]];
private _parentBoundingBox = 0 boundingBoxReal _parent;
private _childBoundingBox = 0 boundingBoxReal _child;
private _parentBoundingBoxSize = ((_parentBoundingBox # 1) vectorDiff (_parentBoundingBox # 0));
private _childBoundingBoxSize = ((_childBoundingBox # 1) vectorDiff (_childBoundingBox # 0));
if (_mode isEqualTo 0) exitWith {
	_distY = selectMax [abs ((_childBoundingBox # 0) # 0),abs ((_childBoundingBox # 0) # 1)];
	//_distY
	//((_parentBoundingBoxSize # 1) / 2) + ((_childBoundingBoxSize # 1) / 2),
	private _offset = [
		0,
		((_parentBoundingBoxSize # 1) / 2) + _distY + _yBuffer,
		_zOffset
	];
	if (!_rotationEnabled) then {
		_halfLength = abs ((_parentBoundingBox # 0) # 1);
		_halfWidth = abs ((_childBoundingBox # 0) # 0);
		_offset set [1,_halfLength + _halfWidth + _yBuffer];
	};
	_offset;
};
if (_mode isEqualTo 1) exitWith {
	private _childLongestSideIndex = _childBoundingBoxSize find (selectMax _childBoundingBoxSize);
	if (_childLongestSideIndex isEqualTo 0) then {
		_child setDir 0;
		// bug fix
		_child spawn {
			sleep 0.2;
			_this setDir 0;
		};
		//_child setVectorDirAndUp [vectorDirVisual _parent,[0,0,1]];
	} else {
		//private _rotationAngle = 90;
		//private _dir = (getDirVisual _parent) + _rotationAngle;
		//private _sin = sin _dir;
		//private _cos = cos _dir;
		_child setDir 90;
		// bug fix
		_child spawn {
			sleep 0.2;
			_this setDir 90;
		};
		/*
		_child setVectorDirAndUp [
			[
				_cos * (vectorDirVisual _parent # 0) - _sin * (vectorDirVisual _parent # 1), 
				_sin * (vectorDirVisual _parent # 0) + _cos * (vectorDirVisual _parent # 1), 
				vectorDirVisual _parent # 2
			],
			[0,0,1]
		];
		*/
	};
	TRUE;
};
if (_mode isEqualTo 2) exitWith {
	private _args = _this;
	_args set [0,0];
	private _offset = _args call QS_fnc_getFrontModelPos;
	uiNamespace setVariable ['QS_targetBoundingBox_attachTo',[_parent,_offset]];
	if (_memPoint isNotEqualTo '') then {
		uiNamespace setVariable ['QS_targetBoundingBox_attachTo',[_parent,_offset,_memPoint,_followRotation]];
	};
	[1,_child,(uiNamespace getVariable ['QS_targetBoundingBox_attachTo',[_parent,_offset]])] call QS_fnc_eventAttach;
	_args set [0,1];
	_args call QS_fnc_getFrontModelPos;
	TRUE;
};