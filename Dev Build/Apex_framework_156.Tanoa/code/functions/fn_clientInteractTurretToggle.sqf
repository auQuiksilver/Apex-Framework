/*
File: fn_clientInteractTurretToggle.sqf
Author: 

	Quiksilver

Last Modified:

	8/04/2023 A3 2.12 by Quiksilver

Description:

	Toggle AI Turret
_________________________________________*/

getCursorObjectParams params ['_cursorObject','','_cursorDistance'];
private _side = side (group player);
private _objectSide = sideUnknown;
private _grp = grpNull;
if (isNull (objectParent player)) then {
	_side = side (group player);
	_enemySides = [player] call QS_fnc_enemySides;
	_objectSide = side _cursorObject;
	// Turn on turret
	if ((crew _cursorObject) isEqualTo []) then {
		// Uncrewed
		if (
			(alive _cursorObject) &&
			{(simulationEnabled _cursorObject)} &&
			{(!(_cursorObject getVariable ['QS_uav_disabled',FALSE]))} &&
			{(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE])} &&
			{(_cursorDistance < 5)} &&
			{(!(_objectSide in _enemySides))}
		) then {
			50 cutText [localize 'STR_QS_Interact_138','PLAIN DOWN',0.25];
			if (isNull (objectParent player)) then {
				player playActionNow 'PutDown';
			};
			_grp = createVehicleCrew _cursorObject;
			_cursorObject setVehicleRadar 1;
			_cursorObject setVehicleReceiveRemoteTargets TRUE;
			_cursorObject setVehicleReportRemoteTargets TRUE;
		} else {
			50 cutText [localize 'STR_QS_Text_429','PLAIN DOWN',0.25];
		};
	} else {
		// Crewed, Turn off
		if (
			(alive _cursorObject) &&
			{(simulationEnabled _cursorObject)} &&
			{(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE])} &&
			{(_cursorDistance < 5)} &&
			{(!(_objectSide in _enemySides))}
		) then {
			50 cutText [localize 'STR_QS_Interact_139','PLAIN DOWN',0.25];
			if (isNull (objectParent player)) then {
				player playActionNow 'PutDown';
			};
			deleteVehicleCrew _cursorObject;
		} else {
			50 cutText [localize 'STR_QS_Text_429','PLAIN DOWN',0.25];
		};
	};
} else {
	private _attached = attachedObjects cameraOn;
	private _turrets = [];
	_cursorDistance = 0;
	{
		if (
			(unitIsUav _x) &&
			(_x getVariable ['QS_uav_toggleEnabled',TRUE]) &&
			(!isObjectHidden _x)
		) then {
			_turrets pushBackUnique _x;
		};
	} forEach _attached;
	if (_turrets isNotEqualTo []) then {
		_side = side (group player);
		_enemySides = [player] call QS_fnc_enemySides;
		{
			_cursorObject = _x;
			_objectSide = side _cursorObject;
			// Turn on turret
			if ((crew _cursorObject) isEqualTo []) then {
				// Uncrewed
				if (
					(alive _cursorObject) &&
					(simulationEnabled _cursorObject) &&
					(!(_cursorObject getVariable ['QS_uav_disabled',FALSE])) &&
					(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE]) &&
					(_cursorDistance < 5) &&
					(!(_objectSide in _enemySides))
				) then {
					50 cutText [localize 'STR_QS_Interact_138','PLAIN DOWN',0.25];
					if (isNull (objectParent player)) then {
						player playActionNow 'PutDown';
					};
					_grp = createVehicleCrew _cursorObject;
					_cursorObject setVehicleRadar 1;
					_cursorObject setVehicleReceiveRemoteTargets TRUE;
					_cursorObject setVehicleReportRemoteTargets TRUE;
				} else {
					50 cutText [localize 'STR_QS_Text_429','PLAIN DOWN',0.25];
				};
			} else {
				// Crewed, Turn off
				if (
					(alive _cursorObject) &&
					(simulationEnabled _cursorObject) &&
					(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE]) &&
					(_cursorDistance < 5) &&
					(!(_objectSide in _enemySides))
				) then {
					50 cutText [localize 'STR_QS_Interact_139','PLAIN DOWN',0.25];
					if (isNull (objectParent player)) then {
						player playActionNow 'PutDown';
					};
					deleteVehicleCrew _cursorObject;
				} else {
					50 cutText [localize 'STR_QS_Text_429','PLAIN DOWN',0.25];
				};
			};
		} forEach _turrets;
	};
};