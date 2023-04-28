/*
File: fn_clientVehicleEventRopeBreak.sqf
Author:
	
	Quiksilver
	
Last Modified:

	4/1/2023 A3 2.10 by Quiksilver

Description:

	Event Rope Break
__________________________________________________________*/
if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_rope','_attachedObject'];
if (isNull (ropeAttachedTo _attachedObject)) then {
	if (_vehicle isKindOf 'Helicopter') then {
		_vehicle setCustomWeightRTD (((weightRTD _vehicle) # 3) - (getMass _attachedObject));
	};
	if (
		((_attachedObject distance2D (markerPos 'QS_marker_crate_area')) < 500) &&
		(!isNil {_attachedObject getVariable 'QS_vehicle_isSuppliedFOB'})
	) then {
		_attachedObject setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
		if (
			(alive (driver _vehicle)) &&
			(player isEqualTo (driver _vehicle))
		) then {
			private _displayName = _attachedObject getVariable ['QS_ST_customDN',''];
			if (_displayName isEqualTo '') then {
				_displayName = getText ((configOf _attachedObject) >> 'displayName');
				_attachedObject setVariable ['QS_ST_customDN',_displayName,TRUE];
			};
			_text = format [localize 'STR_QS_Text_204',_displayName];
			50 cutText [_text,'PLAIN DOWN',0.5];
		};
	};
	if (!isNull (_vehicle getVariable ['QS_sling_attached',objNull])) then {
		_slingLoad = _vehicle getVariable ['QS_sling_attached',objNull];
		if (_slingLoad in (attachedObjects _vehicle)) then {
			_slingData = [_vehicle,_slingLoad] call (missionNamespace getVariable ['QS_fnc_slingData',{}]);
			_slingData params ['','','','_attachCoordinates','','','',''];
			_attachCoordinates set [2,((_attachCoordinates # 2) - ([1,0.1] select (isTouchingGround _vehicle)))];
			_slingLoad attachTo [_vehicle,_attachCoordinates];
			_slingLoad spawn {
				uiSleep 0.1;
				detach _this;
			};
		};
	};
};