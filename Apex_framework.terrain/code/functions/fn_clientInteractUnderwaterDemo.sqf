/*/
File: fn_clientInteractUnderwaterDemo.sqf
Author:

	Quiksilver
	
Last Modified:

	1/11/2017 A3 1.76
	
Description:
	
	-
__________________________________________________________________________/*/
_cursorIntersections = lineIntersectsSurfaces [
	(AGLToASL (positionCameraToWorld [0,0,0])), 
	(AGLToASL (positionCameraToWorld [0,0,(if (cameraView isEqualTo 'INTERNAL') then [{2.1},{4.55}])])), 
	cameraOn, 
	objNull, 
	TRUE, 
	1, 
	'GEOM'
];
if (_cursorIntersections isNotEqualTo []) then {
	_firstCursorIntersection = _cursorIntersections # 0;
	_firstCursorIntersection params [
		'_intersectPosASL',
		'_surfaceNormal',
		'_intersectObject',
		'_objectParent'
	];
	_canAttachExp = _objectParent getVariable ['QS_client_canAttachExp',FALSE];
	if ((simulationEnabled _objectParent) || {(_canAttachExp)}) then {
		if ((_objectParent isKindOf 'AllVehicles') || {(_canAttachExp)}) then {
			if (((side _objectParent) in [EAST,RESISTANCE]) || {(_canAttachExp)}) then {
				_magazineIndex = ((magazines player) apply {toLowerANSI _x}) findAny QS_core_classNames_demoCharges;
				if (_magazineIndex isNotEqualTo -1) then {
					player removeMagazine ((magazines player) # _magazineIndex);
				};
				_mine = createVehicle [QS_core_classNames_demoChargeAmmo,((position player) vectorAdd [0,0.25,0.5]),[],0,'NONE'];
				_mine setVectorUp _surfaceNormal;
				_mine setPosASL _intersectPosASL;
				[_mine,_objectParent,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
				player playAction 'putdown';
				player addOwnedMine _mine;
				if (_objectParent getVariable ['QS_client_canAttachDetach',FALSE]) then {
					[0,_mine] call QS_fnc_eventAttach;
				};
			};
		};
	};
};