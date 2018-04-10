/*/
File: fn_clientArsenal.sqf
Author: 

	Quiksilver

Last Modified:

	28/02/2018 A3 1.80 by Quiksilver

Description:

	Setup Client Arsenal
____________________________________________________________________________/*/

if ((missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 0) exitWith {};
_isBlacklisted = (missionNamespace getVariable ['QS_missionConfig_Arsenal',0]) isEqualTo 2;
if (_isBlacklisted) then {
	{
		[missionNamespace,TRUE,FALSE,FALSE] call (missionNamespace getVariable _x);
	} forEach [
		'BIS_fnc_addVirtualItemCargo',
		'BIS_fnc_addVirtualMagazineCargo',
		'BIS_fnc_addVirtualBackpackCargo',
		'BIS_fnc_addVirtualWeaponCargo'
	];
};
_data = call (missionNamespace getVariable 'QS_data_arsenal');
private _weapons = [];
(_data select ([1,0] select _isBlacklisted)) params ['_itemsData','_magazines','_backpacks','_weapons'];
private _items = [];

private _goggles = _itemsData select 5;
if (!(_goggles isEqualTo [])) then {
	_binGoggles = configFile >> 'CfgGlasses';
	private _goggleClassname = '';
	private _className = configNull;
	for '_i' from 0 to ((count _binGoggles) - 1) step 1 do {
		_className = _binGoggles select _i;
		if (isClass _className) then {
			_goggleClassname = configName _className;
			if ((toLower _goggleClassname) in _goggles) then {
				_goggles set [(_goggles find (toLower _goggleClassname)),_goggleClassname];
			};
		};
	};
	_itemsData set [5,_goggles];
};
{
	_items = _items + _x;
} forEach _itemsData;
if (_isBlacklisted) exitWith {

	// This section doesnt work, BIS replaces the classnames with "%ALL" for some reason

	_cargo = missionNamespace getvariable ['bis_addVirtualWeaponCargo_cargo',[[],[],[],[]]];
	_cargo params ['_cargoItems','_cargoWeapons','_cargoMagazines','_cargoBackpacks'];
	private _class = '';
	private _foundIndex = -1;
	{
		_class = _x;
		_foundIndex = _cargoItems findIf {((toLower _x) isEqualTo (toLower _class))};
		if (!(_foundIndex isEqualTo -1)) then {
			_cargoItems deleteAt _foundIndex;
		};
	} forEach _items;
	if (!(_weapons isEqualTo [])) then {
		{
			_class = configname (configfile >> "cfgweapons" >> _x);
			_foundIndex = _cargoWeapons findIf {((toLower _x) isEqualTo (toLower _class))};
			if (!(_foundIndex isEqualTo -1)) then {
				_cargoWeapons deleteAt _foundIndex;
			};
		} forEach _weapons;
	};
	if (!(_magazines isEqualTo [])) then {
		{
			_class = configname (configfile >> "cfgweapons" >> _x);
			_foundIndex = _cargoMagazines findIf {((toLower _x) isEqualTo (toLower _class))};
			if (!(_foundIndex isEqualTo -1)) then {
				_cargoMagazines deleteAt _foundIndex;
			};
		} forEach _magazines;
	};	
	if (!(_backpacks isEqualTo [])) then {
		{
			_class = _x;
			_foundIndex = _cargoBackpacks findIf {((toLower _x) isEqualTo (toLower _class))};
			if (!(_foundIndex isEqualTo -1)) then {
				_cargoBackpacks deleteAt _foundIndex;
			};
		} forEach _backpacks;
	};
	missionNamespace setVariable ['bis_addVirtualWeaponCargo_cargo',[_cargoItems,_cargoWeapons,_cargoMagazines,_cargoBackpacks],FALSE];	
};
{
	if (!((_x select 1) isEqualTo [])) then {
		[missionNamespace,(_x select 1),FALSE,FALSE] call (missionNamespace getVariable (_x select 0));
	};
} forEach [
	[(format ['BIS_fnc_%1VirtualItemCargo',(['add','remove'] select _isBlacklisted)]),_items],
	[(format ['BIS_fnc_%1VirtualMagazineCargo',(['add','remove'] select _isBlacklisted)]),_magazines],
	[(format ['BIS_fnc_%1VirtualBackpackCargo',(['add','remove'] select _isBlacklisted)]),_backpacks],
	[(format ['BIS_fnc_%1VirtualWeaponCargo',(['add','remove'] select _isBlacklisted)]),_weapons]
];