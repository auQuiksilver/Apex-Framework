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
	private _capacity = _parent getVariable ['QS_vehicle_customCargoCap',0];
	private _count = 0;
	if (_capacity isEqualTo 0) then {
		if ([0,_child,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
			if (_parent isKindOf 'Kart_01_Base_F') then {
				_capacity = 0;
			} else {
				if (_parent isKindOf 'Quadbike_01_base_F') then {
					_capacity = 1;
				} else {
					if ((getMass _parent) > 5000) then {
						if ((getMass _parent) > 15000) then {
							_capacity = 4;
						} else {
							_capacity = 3;
						};
					} else {
						_capacity = 2;
					};
				};
			};
		} else {
			_capacity = 0;
		};
	};
	{
		if ([0,_x,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
			_count = _count + 1;
		};
	} count (attachedObjects _parent);
	_return1 = ((_count < _capacity) || (([_parent,_child] call QS_fnc_canVehicleCargo) isEqualTo [TRUE,TRUE]));
	_return1;
};
if (_type isEqualTo 2) exitWith {
	//comment 'Towable non-vehicle object types';
	private _return1 = FALSE;
	_towableCargoObjects = ['towable_objects_2'] call QS_data_listVehicles;
	if (_childType in _towableCargoObjects) then {_return1 = TRUE;};
	_return1;
};
if (_type isEqualTo 3) exitWith {
	//comment 'Return capacity';
	private _return1 = FALSE;
	private _capacity = _parent getVariable ['QS_vehicle_customCargoCap',0];
	private _count = 0;
	if (_capacity isEqualTo 0) then {
		if (_parent isKindOf 'Kart_01_Base_F') then {
			_capacity = 0;
		} else {
			if (_parent isKindOf 'Quadbike_01_base_F') then {
				_capacity = 1;
			} else {
				if ((getMass _parent) > 5000) then {
					if ((getMass _parent) > 15000) then {
						_capacity = 4;
					} else {
						_capacity = 3;
					};
				} else {
					_capacity = 2;
				};
			};
		};
	};
	{
		if ([0,_x,_parent] call (missionNamespace getVariable 'QS_fnc_getCustomCargoParams')) then {
			_count = _count + 1;
		};
	} count (attachedObjects _parent);
	_return1 = [_count,_capacity];
	_return1;
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