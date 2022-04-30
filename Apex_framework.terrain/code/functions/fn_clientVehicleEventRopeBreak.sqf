/*
File: fn_clientVehicleEventRopeBreak.sqf
Author:
	
	Quiksilver
	
Last Modified:

	5/05/2018 A3 1.82 by Quiksilver

Description:

	Event Rope Break
__________________________________________________________*/

params ['_vehicle','_rope','_attachedObject'];
if (!local _vehicle) exitWith {};
if (isNull (ropeAttachedTo _attachedObject)) then {
	if ((_attachedObject distance2D (markerPos 'QS_marker_crate_area')) < 500) then {
		if (!isNil {_attachedObject getVariable 'QS_vehicle_isSuppliedFOB'}) then {
			_attachedObject setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
			if (!isNull (driver _vehicle)) then {
				if (alive (driver _vehicle)) then {
					if (player isEqualTo (driver _vehicle)) then {
						private _displayName = _attachedObject getVariable ['QS_ST_customDN',''];
						if (_displayName isEqualTo '') then {
							_displayName = getText (configFile >> 'CfgVehicles' >> (typeOf _attachedObject) >> 'displayName');
						};
						_text = format ['%1 reset for FOB resupply',_displayName];
						50 cutText [_text,'PLAIN DOWN',0.5];
					};
				};
			};
		};
	};
	if (!isNull (_vehicle getVariable ['QS_sling_attached',objNull])) then {
		_slingLoad = _vehicle getVariable ['QS_sling_attached',objNull];
		if (_slingLoad in (attachedObjects _vehicle)) then {
			_slingData = [_vehicle,_slingLoad] call (missionNamespace getVariable ['QS_fnc_slingData',{}]);
			_slingData params ['','','','_attachCoordinates','','','',''];
			_attachCoordinates set [2,((_attachCoordinates select 2) - ([1,0.1] select (isTouchingGround _vehicle)))];
			_slingLoad attachTo [_vehicle,_attachCoordinates];
			_slingLoad spawn {
				uiSleep 0.1;
				detach _this;
			};
		};
	};
};