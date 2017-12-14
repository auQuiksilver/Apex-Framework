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
if (!(_cursorIntersections isEqualTo [])) then {
	_firstCursorIntersection = _cursorIntersections select 0;
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
				player removeMagazine 'DemoCharge_Remote_Mag';
				_mine = createVehicle ['democharge_remote_ammo',(position player),[],0,'NONE'];
				_mine setVectorUp _surfaceNormal;
				_mine setPosASL _intersectPosASL;
				[_mine,_objectParent,TRUE] call (missionNamespace getVariable 'BIS_fnc_attachToRelative');
				player playAction 'putdown';
				player addOwnedMine _mine;
				if (_objectParent getVariable ['QS_client_canAttachDetach',FALSE]) then {
					detach _mine;
				};
			};
		};
	};
};