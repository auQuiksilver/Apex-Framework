/*/
File: fn_logisticsPlatformSnap.sqf
Author:

	Quiksilver
	
Last Modified:

	24/05/2023 A3 2.12 by Quiksilver
	
Description:

	Snap cargo platforms
	
Notes:

	Alias of BIN_fnc_cargoPlatform_01_update
___________________________________________/*/

params ['_object',['_adjustLegs',TRUE],['_wake',TRUE],['_zTolerance',2],['_distTolerance',1]];
private _snapped = FALSE;
private _nearestObject = objNull;
private _nearbyObjects = nearestObjects [_object,['cargoplatform_01_base_f'],7,TRUE];
private _objectZ = (getPosASL _object) # 2;
_nearbyObjects = _nearbyObjects - [_object];
if (
	(!(_object getVariable ['QS_elevator',FALSE])) &&
	(_nearbyObjects isNotEqualTo [])
) then {
	_nearestObject = _nearbyObjects # 0;
	_nearestObjectZ = (getPosASL _nearestObject) # 2;
	if (
		(_zTolerance isNotEqualTo -1) &&
		{((abs (_nearestObjectZ - _objectZ)) > _zTolerance)}
	) then {
		_nearestObject = objNull;
	};
	private _pos = getPosASL _object;
	private _snapPoint = [];
	private _snapPointsParent = [];
	if (!isNull _nearestObject) then {
		for '_i' from 1 to 4 do {
			_snapPointsParent pushBack (_object modelToWorldVisual (_object selectionPosition (format['panel%1_snap',_i])));
		};
		if (_snapPointsParent isNotEqualTo []) then {
			for '_i' from 1 to 4 do {
				_snapPoint = _nearestObject modelToWorldVisual (_nearestObject selectionPosition (format['panel%1_snap',_i]));
				{
					if ((_snapPoint distance2D _x) <= 1) exitWith {
						_pos = _pos vectorDiff ((_object modelToWorldVisual (_object worldToModel _x)) vectorDiff _snapPoint);
						_pos set [2,_nearestObjectZ];
						if ((nearestObjects [ASLToAGL _pos,['cargoplatform_01_base_f'],1,FALSE]) isEqualTo []) then {
							_snapped = TRUE;
							_nearestObject animate [format ['panel_%1_rotate',_i],3.15,TRUE];
							_nearestObject animateSource [format ['panel_%1_rotate_source',_i],3.15,TRUE];
							_object animate [format ['panel_%1_rotate',_forEachIndex + 1],3.15,TRUE];
							_object animateSource [format ['panel_%1_rotate_source',_forEachIndex + 1],3.15,TRUE];
							_dirTo = getDir _nearestObject - 360;
							_dirObject = getDir _object;
							_dir = _dirTo;
							for '_i' from 0 to 7 do {
								_dir = _dirTo + _i * 90;
								if (abs(_dir - _dirObject) < 45) then {
									_i = 10;
								};
							};
							_object setDir _dir;
							_object setPosASL _pos;
						};
						_i = 10;
					};
				} forEach _snapPointsParent;
			};
		};
	};
};
if (_adjustLegs) then {
	if (!simulationEnabled _object) then {
		_object enableSimulation TRUE;
	};
	for '_ii' from 1 to 4 step 1 do {
		_result = ((_object animationSourcePhase (format ['leg_%1_move_source',_ii])) - ((_object modelToWorldVisual (_object selectionPosition (format ['block%1_pos',_ii]))) # 2));
		_object animate [
			format['Leg_%1_move',_ii],
			_result,
			TRUE
		];
	};
};
if (_wake) then {
	['awake',_object,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	if (!isNull _nearestObject) then {
		['awake',_nearestObject,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
};
_snapped;