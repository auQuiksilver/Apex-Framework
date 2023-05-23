/*/
File: fn_logisticsPlatformSnap.sqf
Author:

	Quiksilver
	
Last Modified:

	16/02/2023 A3 2.12 by Quiksilver
	
Description:

	Snap cargo platforms
	
Notes:

	Alias of BIN_fnc_cargoPlatform_01_update
___________________________________________/*/

params ['_object',['_adjustLegs',TRUE],['_wake',TRUE]];
private _snapped = FALSE;
private _nearbyObjects = nearestObjects [_object,['CargoPlatform_01_base_F'],7,TRUE];
_nearbyObjects = _nearbyObjects - [_object];
if (_nearbyObjects isNotEqualTo []) then {
	private _nearestObject	= _nearbyObjects # 0;
	private _pos			= getposASL _object;
	private _snapPoint			= [];
	private _snapPointsParent	= [];
	private _nearestToSnap = [];
	private _blockPos = [0,0,0];
	private _adjustment = 0;
	for "_i" from 1 to 4 do {
		_snapPointsParent pushBack (_object modelToWorldVisual (_object selectionPosition (format["panel%1_snap",_i])));
	};
	if (_snapPointsParent isNotEqualTo []) then {
		for "_i" from 1 to 4 do {
			_snapPoint = _nearestObject modelToWorldVisual (_nearestObject selectionPosition (format["panel%1_snap",_i]));
			{
				if ((_snapPoint distance2D _x) <= 1) exitWith {
					_snapped = TRUE;
					_nearestObject animate [format ['panel_%1_rotate',_i],3.15,TRUE];
					_nearestObject animateSource [format ['panel_%1_rotate_source',_i],3.15,TRUE];
					_object animate [format ['panel_%1_rotate',_forEachIndex + 1],3.15,TRUE];
					_object animateSource [format ['panel_%1_rotate_source',_forEachIndex + 1],3.15,TRUE];
					_posModel = _object worldToModel _x;
					_dirTo		= getDir _nearestObject - 360;
					_dirObject	= getDir _object;
					_dir		= _dirTo;
					for "_i" from 0 to 7 do {
						_dir = _dirTo + _i * 90;
						if (abs(_dir - _dirObject) < 45) then {
							_i = 10;
						};
					};
					_object setDir _dir;
					_x = _object modelToWorldVisual _posModel;
					_pos = _pos vectorDiff (_x vectorDiff _snapPoint);
					_pos = [_pos # 0, _pos # 1, (getposASL (_nearbyObjects # 0)) # 2];
					_object setPosASL _pos;
					if (_adjustLegs) then {
						for '_ii' from 1 to 4 step 1 do {
							_adjustment = (_object animationPhase (format ["leg_%1_move",_ii])) - ((_object modelToWorldVisual (_object selectionPosition (format ["block%1_pos",_ii]))) # 2);
							_object animate [format ["Leg_%1_move",_ii],linearConversion [1,6.541,_adjustment,0,1,TRUE],TRUE];
							_object animateSource [format ["Leg_%1_move_source",_ii],linearConversion [1,6.541,_adjustment,0,1,TRUE],TRUE];
						};
					};
					_i = 10;
				};
			} forEach _snapPointsParent;
		};
	};
};
if (_wake) then {
	['awake',_object,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	if (!isNull _nearestObject) then {
		['awake',_nearestObject,TRUE] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
	};
};
_snapped;