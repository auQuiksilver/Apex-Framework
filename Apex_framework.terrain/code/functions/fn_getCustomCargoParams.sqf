/*/
File: fn_getCustomCargoParams.sqf
Author: 

	Quiksilver

Last Modified:

	15/03/2023 A3 2.12 by Quiksilver

Description:

	Custom Cargo Data
	
Notes:

	QS_array = [];
	{
		QS_array pushBack (toLowerANSI (typeOf _x));
	} forEAch (curatorSelected # 0);
	copyToClipboard str QS_array;
	if ([0,object,objnull] call QS_fnc_getCustomCargoParams)
	
Notes 2:

	Lot of scope to flesh out this system with cost tables and stuff for better vehicle capacity
	
	[0,_cursorObject] call _fn_getCustomCargoParams
____________________________________________________________________________/*/

params [
	['_type',0],
	['_child',objNull],
	['_parent',objNull]
];
if (_type isEqualTo 0) exitWith {
	//comment 'Loadable object types';
	private _return1 = FALSE;
	_childType = toLowerANSI (typeOf _child);
	_loadableObjects = ['loadable_cargo_objects_1'] call QS_data_listVehicles;
	_loadableConfigs = ['StaticWeapon'];
	if (
		((_childType in _loadableObjects) && (!(_child getVariable ['attached',FALSE]))) ||
		{(((_loadableConfigs findIf { _childType isKindOf _x }) isNotEqualTo -1) && (!(_child getVariable ['attached',FALSE])))} ||
		{(_child getVariable ['QS_logistics',FALSE]) && (!(_child getVariable ['attached',FALSE]))} ||
		{(!isNull (isVehicleCargo _child))} ||
		{((!isNull _parent) && {(([_parent,_child] call QS_fnc_canVehicleCargo) isEqualTo [TRUE,TRUE])} && {(!(_child getVariable ['attached',FALSE]))})}
	) then {_return1 = TRUE;};
	_return1;
};
if (_type isEqualTo 1) exitWith {
	//comment 'Can load to parent';
	private _return1 = FALSE;
	private _cargoCapacity = [_parent,0] call QS_fnc_getCargoCapacity;
	private _currentLoad = [_parent,0] call QS_fnc_getCargoVolume;
	_cargoCapacity params ['_cargoMaxCapacity','_cargoMaxMass','_cargoMaxCoef'];
	_currentLoad params ['_currentCargoVolume','_currentCargoMass'];
	_newCargoVolume = [_child] call QS_fnc_getObjectVolume;
	_newCargoMass = getMass _child;
	if (
		(([_parent,_child] call QS_fnc_canVehicleCargo) isNotEqualTo [TRUE,TRUE]) &&
		(
			((_currentCargoVolume + _newCargoVolume) > _cargoMaxCapacity) ||
			((_currentCargoMass + _newCargoMass) > _cargoMaxMass)
		)
	) exitWith {FALSE};
	if (lockedInventory _parent) exitWith {FALSE};
	TRUE
};
if (_type isEqualTo 2) exitWith {
	//comment 'Towable non-vehicle object types';
	private _return1 = FALSE;
	_towableCargoObjects = ['towable_objects_2'] call QS_data_listVehicles;
	if (_childType in _towableCargoObjects) then {_return1 = TRUE;};
	_return1;
};
if (_type isEqualTo 3) exitWith {
	private _cargoCapacity = [_parent,0] call QS_fnc_getCargoCapacity;
	private _currentLoad = [_parent,0] call QS_fnc_getCargoVolume;
	_cargoCapacity params ['_cargoMaxCapacity','_cargoMaxMass','_cargoMaxCoef'];
	_currentLoad params ['_currentCargoVolume','_currentCargoMass'];
	[_currentCargoVolume,_cargoMaxCapacity,_currentCargoMass,_cargoMaxMass]
};
if (_type isEqualTo 4) exitWith {
	//comment 'carry-ability';
	private _return1 = TRUE;
	_childType = toLowerANSI (typeOf _child);
	_nonCarryable = ['noncarryable_objects_1'] call QS_data_listVehicles;
	if ((vehicle _parent) isKindOf 'CAManBase') then {
		if (_childType in _nonCarryable) then {
			_return1 = FALSE;
		};
	};
	if (
		((['Ship','Air','LandVehicle'] findIf { 
			(_child isKindOf _x) &&
			((getMass _child) > 1000)
		}) isNotEqualTo -1)
	) then {
		_return1 = FALSE;
	};
	
	_return1;
};
FALSE;