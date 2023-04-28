/*
File: fn_updateCenterOfMass.sqf
Author:

	Quiksilver
	
Last Modified:

	26/03/2022 A3 2.12 by Quiksilver
	
Description:

	https://community.bistudio.com/wiki/setCenterOfMass
	https://community.bistudio.com/wiki/getCenterOfMass
	
	onEachFrame {
		hintSilent str ([cameraOn,TRUE,TRUE] call QS_fnc_updateCenterOfMass);
	};
________________________________________________*/

params ['_vehicle',['_set',TRUE],['_recalcMass',TRUE],['_counterBalance',FALSE]];
if (!(_vehicle isKindOf 'LandVehicle')) exitWith {[0,[0,0,0]]};
_set = _set && ((missionNamespace getVariable ['QS_missionconfig_centerOfMass',0]) isNotEqualTo 0);
private _currentMass = getMass _vehicle;
private _currentCOM = getCenterOfMass _vehicle;
if (isNil {_vehicle getVariable 'QS_vehicle_massdef'}) then {
	_vehicle setVariable ['QS_vehicle_massdef',[_currentMass,getCenterOfMass _vehicle],TRUE];
};
_recalcMass = _recalcMass && (missionNamespace getVariable ['QS_missionConfig_mass',FALSE]);
private _centerOfMass = (_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1;
private _defaultMass = (_vehicle getVariable ['QS_vehicle_massdef',[_currentMass]]) # 0;
private _totalMass = _defaultMass;
private _massData = [[_vehicle, ((_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1), _defaultMass]];
private _newCenterOfMass = ((_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1);
private _allAttached = getVehicleCargo _vehicle;
if ((missionNamespace getVariable ['QS_missionconfig_centerOfMass',0]) isEqualTo 2) then {
	_allAttached = _allAttached + ((attachedObjects _vehicle) select {(!isSimpleObject _x) && (!isObjectHidden _x)});
};
if (_allAttached isEqualTo []) exitWith {
	_massInfo = ((_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1);
	if (_set) then {
		if (_currentCOM isNotEqualTo _centerOfMass) then {
			if (local _vehicle) then {
				_vehicle setCenterOfMass ((_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1);
			} else {
				['setCenterOfMass', _vehicle, ((_vehicle getVariable ['QS_vehicle_massdef',[]]) # 1)] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
			};
			_vehicle awake TRUE;
		};
	};
	if (_recalcMass) then {
		if (_totalMass isNotEqualTo _currentMass) then {
			if (local _vehicle) then {
				_vehicle setMass _totalMass;
			} else {
				['setMass',_vehicle,_totalMass] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
			};
			_vehicle awake TRUE;
		};
	};
	[_totalMass,_centerOfMass]
};
{
	private _relativePos = _vehicle worldToModel (ASLToAGL (getPosASL _x));
	private _mass = getMass _x;
	_massData pushBack [_x, _relativePos, _mass];
	_totalMass = _totalMass + _mass;
} forEach (_allAttached arrayIntersect _allAttached);
if (_recalcMass) then {
	if (_totalMass isNotEqualTo _currentMass) then {
		if (local _vehicle) then {
			_vehicle setMass _totalMass;
		} else {
			['setMass',_vehicle,_totalMass] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
		};
		_vehicle awake TRUE;
	};
};
if (_massData isEqualTo []) exitWith {[_totalMass,_centerOfMass]};
{
	private _massPosProduct = (_x # 1) vectorMultiply (_x # 2);
	_newCenterOfMass = _newCenterOfMass vectorAdd _massPosProduct;
} forEach _massData;
_newCenterOfMass = _newCenterOfMass apply {
	(_x / _totalMass)
};
if (_centerOfMass isEqualTo _newCenterOfMass) exitWith {
	[_totalMass,_centerOfMass]
};
if (_set) then {
	if (_currentCOM isNotEqualTo _newCenterOfMass) then {
		if (local _vehicle) then {
			_vehicle setCenterOfMass _newCenterOfMass;
		} else {
			['setCenterOfMass', _vehicle, _newCenterOfMass] remoteExec ['QS_fnc_remoteExecCmd', _vehicle, FALSE];
		};
		_vehicle awake TRUE;
	};
};
[_totalMass,_newCenterOfMass]