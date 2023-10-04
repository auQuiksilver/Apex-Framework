/*/
File: fn_wreckSetMaterials.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/04/2023 A3 2.12 by Quiksilver
	
Description:

	Wreck Material Appearance
______________________________________________________/*/

params ['_mode','_entity'];
if (_mode isEqualTo 'ON') exitWith {
	_value = (localNamespace getVariable ['QS_hashmap_wreckmats',[]]) getOrDefault [toLowerANSI (typeOf _entity),[]];
	if (_value isNotEqualTo []) then {
		{
			_entity setObjectMaterialGlobal [_forEachIndex,_x];
		} forEach _value;
	};
};
if (_mode isEqualTo 'OFF') exitWith {
	{
		_entity setObjectMaterialGlobal [_forEachIndex,''];
	} forEach (getObjectMaterials _entity);
};
if (_mode isEqualTo 'INIT') exitWith {
	private _array = [];
	private _cfgArray = "(
		(getNumber (_x >> 'scope') >= 2) &&
		(
			((configName _x) isKindOf 'LandVehicle') ||
			((configName _x) isKindOf 'Air') ||
			((configName _x) isKindOf 'Ship') ||
			((configName _x) isKindOf 'Reammobox_F')
		)
	)" configClasses (configFile >> "CfgVehicles");
	_cfgArray = _cfgArray apply {toLowerANSI (configName _x)};
	private _mats = [];
	private _excluded = [];	// List of vehicle classnames excluded from wreck materials for whatever reason (some have unwanted visual glitches)
	_excluded = _excluded apply {toLowerANSI _x};
	{
		if (!(_x in _excluded)) then {
			_mats = getArray (configFile >> 'CfgVehicles' >> _x >> 'Damage' >> 'mat');
			_mats = _mats select {
				(['destruct',_x] call QS_fnc_inString) && 
				(!(['glass',_x] call QS_fnc_inString))
			};
			if (_mats isEqualTo []) then {
				_mats = getArray (configFile >> 'CfgVehicles' >> _x >> 'Damage' >> 'mat');
				_mats = _mats select {
					(['damage',_x] call QS_fnc_inString) &&
					(!(['glass',_x] call QS_fnc_inString))
				};		
			};
			_array pushBack [toLowerANSI _x,_mats];
		};
	} forEach _cfgArray;
	localNamespace setVariable ['QS_hashmap_wreckmats',createHashMapFromArray _array];
	diag_log '* QS Debug * Wreck materials compiled *';
};