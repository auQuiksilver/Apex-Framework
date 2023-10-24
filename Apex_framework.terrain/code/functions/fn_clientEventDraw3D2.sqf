/*/
File: fn_clientEventDraw3D2.sqf
Author: 

	Quiksilver
	
Last modified:

	23/04/2023 A3 2.12 by Quiksilver
	
Description:

	Placement
______________________________________________/*/

_cameraOn = uiNamespace getVariable ['QS_targetBoundingBox_parent',objNull];
if (
	((uiNamespace getVariable ['QS_targetBoundingBox_this',[]]) call QS_fnc_placementModeCancel) ||
	{(missionNamespace getVariable ['QS_targetBoundingBox_placementModeCancel',FALSE])} ||
	{(!(cameraOn isEqualTo _cameraOn))} ||
	{(!(QS_targetBoundingBox_helper in (attachedObjects _cameraOn)))}
) exitWith {
	removeMissionEventHandler [_thisEvent,_thisEventHandler];
	(findDisplay 46) displayRemoveEventHandler ['KeyDown',QS_EH_placementKeyDown];
	missionNamespace setVariable ['QS_targetBoundingBox_placementMode',FALSE,FALSE];
	missionNamespace setVariable ['QS_targetBoundingBox_placementModeCancel',FALSE,FALSE];
	uiNamespace setVariable ['QS_targetBoundingBox_draw',FALSE];
	if (uiNamespace getVariable ['QS_localHelper',FALSE]) then {
		deleteVehicle QS_targetBoundingBox_helper;
		uiNamespace setVariable ['QS_localHelper',FALSE];
	} else {
		if (_cameraOn isKindOf 'CAManBase') then {
			[QS_targetBoundingBox_helper,_cameraOn,diag_frameNo + 2] spawn {
				params ['_child','_parent','_eventFrame'];
				waitUntil {diag_frameNo > _eventFrame};
				if (_child in (attachedObjects _parent)) then {
					[0,_child] call QS_fnc_eventAttach;
				};
			};
		};
	};
	if (isForcedWalk QS_player) then {
		QS_player forceWalk FALSE;
	};
};
_rotationEnabled = uiNamespace getVariable ['QS_uiaction_rotationEnabled',TRUE];
if (!local QS_targetBoundingBox_helper) then {
	if (diag_tickTime > (localNamespace getVariable ['QS_placementMode_updateOwnerDelay',-1])) then {
		localNamespace setVariable ['QS_placementMode_updateOwnerDelay',diag_tickTime + 5];
		['setOwner',QS_targetBoundingBox_helper,clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
	};
};
_desiredOffset = [
	(uiNamespace getVariable ['QS_targetBoundingBox_xOffset',0]),
	(uiNamespace getVariable ['QS_targetBoundingBox_yOffset',10]),
	(uiNamespace getVariable ['QS_targetBoundingBox_zOffset',0])
];
uiNamespace setVariable ['QS_targetBoundingBox_drawPos',(getPosVisual QS_targetBoundingBox_helper)];
_azi = uiNamespace getVariable ['QS_targetBoundingBox_azi',0];
if ((uiNamespace getVariable ['QS_targetBoundingBox_attachOffset',_desiredOffset]) isNotEqualTo _desiredOffset) then {
	uiNamespace setVariable ['QS_targetBoundingBox_attachOffset',_desiredOffset];
	(uiNamespace getVariable 'QS_targetBoundingBox_attachTo') set [1,_desiredOffset];
	[1,QS_targetBoundingBox_helper,(uiNamespace getVariable 'QS_targetBoundingBox_attachTo')] call QS_fnc_eventAttach;
};
_intersections = lineIntersectsSurfaces [
	(uiNamespace getVariable 'QS_targetBoundingBox_ASLPos'),
	((uiNamespace getVariable 'QS_targetBoundingBox_ASLPos') vectorAdd [0,0,-5]),
	QS_targetBoundingBox_helper
];
if (_intersections isNotEqualTo []) then {
	_intersections = _intersections select {
		(
			(alive (_x # 2)) &&
			{(vehicleCargoEnabled (_x # 2))} &&
			{(([(_x # 2),QS_targetBoundingBox_helper] call QS_fnc_canVehicleCargo) isEqualTo [TRUE,TRUE])} &&
			{(!((_x # 2) getVariable ['QS_lockedInventory',FALSE]))}
		)
	};
	if (_intersections isNotEqualTo []) then {
		localNamespace setVariable ['QS_placementMode_carrier',(_intersections # 0) # 2];
	} else {
		localNamespace setVariable ['QS_placementMode_carrier',objNull];
	};
} else {
	localNamespace setVariable ['QS_placementMode_carrier',objNull];
};
if (
	(uiNamespace getVariable ['QS_uiaction_alt',FALSE]) &&
	(uiNamespace getVariable ['QS_uiaction_altEnabled',TRUE]) &&
	_rotationEnabled
) then {
	if (
		(diag_tickTime > (uiNamespace getVariable ['QS_objectPlacement_surfaceInterval',-1])) ||
		((getPosASL QS_targetBoundingBox_helper) isNotEqualTo (uiNamespace getVariable ['QS_objectPlacement_surfacePos',[0,0,0]]))
	) then {
		uiNamespace setVariable ['QS_objectPlacement_surfacePos',getPosASL QS_targetBoundingBox_helper];
		uiNamespace setVariable ['QS_objectPlacement_surfaceInterval',diag_tickTime + 0.25];
		_surfaceIntersections = lineIntersectsSurfaces [
			getPosASLVisual QS_targetBoundingBox_helper, 
			(getPosASLVisual QS_targetBoundingBox_helper) vectorAdd [0,0,-25], 
			QS_targetBoundingBox_helper, 
			objNull, 
			TRUE, 
			1, 
			'ROADWAY'
		];
		_vector_up = if (_surfaceIntersections isNotEqualTo []) then {
			((_surfaceIntersections # 0) # 1)
		} else {
			(surfaceNormal (getPosASLVisual QS_targetBoundingBox_helper))
		};	
		_dir = _azi % 360/360 * 360 + (getDirVisual _cameraOn);
		_vector_dir = vectorNormalized ([sin _dir, cos _dir, 0] vectorCrossProduct _vector_up);
		_sin = sin (getDirVisual _cameraOn);
		_cos = cos (getDirVisual _cameraOn);
		QS_targetBoundingBox_helper setVectorDirAndUp [
			[
				_cos * (_vector_dir # 0) - _sin * (_vector_dir # 1),
				_sin * (_vector_dir # 0) + _cos * (_vector_dir # 1),
				_vector_dir # 2
			],
			[
				_cos * (_vector_up # 0) - _sin * (_vector_up # 1),
				_sin * (_vector_up # 0) + _cos * (_vector_up # 1),
				_vector_up # 2
			]
		];
	};
} else {
	if (
		_rotationEnabled &&
		(
			((vectorDirVisual QS_targetBoundingBox_helper) isNotEqualTo [sin _azi, cos _azi,0]) ||
			{((vectorUpVisual QS_targetBoundingBox_helper) isNotEqualTo [0,0,1])}
		)
	) then {
		QS_targetBoundingBox_helper setVectorDirAndUp [[sin _azi, cos _azi,0],[0,0,1]];
	};
};
uiNamespace setVariable ['QS_targetBoundingBox_ASLPos',getPosASLVisual QS_targetBoundingBox_helper];
uiNamespace setVariable ['QS_targetBoundingBox_vectors',[vectorDirVisual QS_targetBoundingBox_helper,vectorUpVisual QS_targetBoundingBox_helper]];