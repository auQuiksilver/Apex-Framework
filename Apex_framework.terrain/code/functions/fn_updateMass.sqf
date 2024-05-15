/*
File: fn_updateMass.sqf
Author:

	Quiksilver
	
Last Modified:

	25/03/2022 A3 2.12 by Quiksilver
	
Description:

	https://community.bistudio.com/wiki/setCenterOfMass
	https://community.bistudio.com/wiki/getCenterOfMass
________________________________________________*/

params [['_vehicle',objNull],['_requireLocal',TRUE]];
if (
	((!local _vehicle) && (_requireLocal)) ||
	{(!(missionNamespace getVariable ['QS_missionConfig_mass',FALSE]))}
) exitWith {getMass _vehicle};
_mass = getMass _vehicle;
_defaultMass = (getModelInfo _vehicle) # 4;
private _allAttached = ((attachedObjects _vehicle) + (getVehicleCargo _vehicle)) select {(!isSimpleObject _x) && (!isObjectHidden _x)};
private _filtered = _allAttached arrayIntersect _allAttached;
private _totalMass = _defaultMass;
{
	_totalMass = _totalMass + (getMass _x);
} forEach _filtered;
if (_mass isNotEqualTo _totalMass) then {
	if (local _vehicle) then {
		_vehicle setMass _totalMass;
	} else {
		['setMass',_vehicle,_totalMass] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
	};
};
_totalMass;