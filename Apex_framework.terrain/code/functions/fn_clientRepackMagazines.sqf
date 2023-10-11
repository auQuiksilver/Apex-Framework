/*/
File: fn_clientRepackMagazines.sqf
Author:
	
	Quiksilver
	
Last Modified:

	24/01/2023 A3 2.10 by Quiksilver

Description:

	Repack Magazines
	
Example:

	<unit> spawn QS_fnc_clientRepackMagazines;
__________________________________________________________/*/

_unit = _this;
if (
	(!(_unit isEqualType objNull)) ||
	{(!(alive _unit))} ||
	{(!(_unit isKindOf 'CAManBase'))} ||
	{(!local _unit)} ||
	{(underwater _unit)} ||
	{(captive _unit)} ||
	{(!((lifeState _unit) in ['HEALTHY','INJURED']))} ||
	{((magazinesAmmoFull _unit) isEqualTo [])} ||
	{(_unit getVariable ['QS_unit_repackingMagazines',FALSE])}
) exitWith {
	diag_log '***** QS Mag Repack ***** Log ***** Repack failed *****';
};
_vehicle = vehicle _unit;
if ((isPlayer _unit) && (!isNull (objectParent _unit)) && (_unit in [(driver _vehicle),(gunner _vehicle),(commander _vehicle)])) exitWith {};
if (_unit isEqualTo player) then {
	50 cutText [localize 'STR_QS_Text_186','PLAIN DOWN',0.3];
};
_unit setVariable ['QS_unit_repackingMagazines',TRUE,FALSE];
_canSuspend = canSuspend;
if (isNull (objectParent _unit)) then {
	_unit playActionNow 'Medic';
};
private _magazineTypes = [];
private _data1 = (magazinesAmmoFull _unit) select {((_x # 3) in [-1,1,2])};
private _data2 = [];
if (_data1 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];};
private _i = 0;
private _magazineClass = '';
private _magazineAmmoCount = 0;
private _magazineAmmoCapacity = 0;
{
	_magazineClass = _x # 0;
	_magazineAmmoCount = _x # 1;
	_magazineAmmoCapacity = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgmagazines_%1_count',toLowerANSI _magazineClass],
		{getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count')},
		TRUE
	];
	if (_magazineAmmoCapacity > 3) then {
		_magazineTypes pushBackUnique _magazineClass;
		if (_data2 isNotEqualTo []) then {
			_i = _data2 findIf {((_x # 0) isEqualTo _magazineClass)};
			if (_i isEqualTo -1) then {
				_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
			} else {
				((_data2 # _i) # 2) pushBack _magazineAmmoCount;
			};
		} else {
			_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
		};
	};
} forEach _data1;
if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];};
private _totalAmmoCountForMagazine = 0;
private _magazineCountArray = [];
_i = 0;
{
	_magazineClass = _x # 0;
	_magazineAmmoCapacity = _x # 1;
	_magazineCountArray = _x # 2;
	_totalAmmoCountForMagazine = 0;
	for '_i' from 0 to ((count _magazineCountArray) - 1) step 1 do {
		_totalAmmoCountForMagazine = _totalAmmoCountForMagazine + (_magazineCountArray # _i);
	};
	(_data2 # _forEachIndex) set [2,_totalAmmoCountForMagazine];
	(_data2 # _forEachIndex) pushBack (ceil(_totalAmmoCountForMagazine / _magazineAmmoCapacity));
} forEach _data2;
if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];};
private _addMagazineArray = [];
private _magazineAmmoCountTotal = 0;
private _magazineAmmoCapacity_moving = 0;
private _currentMagIndex = 0;
{
	_magazineClass = _x # 0;
	_magazineAmmoCapacity = _x # 1;
	_magazineAmmoCountTotal = _x # 2;
	_magazineAmmoCapacity_moving = 0;
	_currentMagIndex = _addMagazineArray pushBack [_magazineClass,_magazineAmmoCapacity_moving];
	for '_x' from 0 to (_magazineAmmoCountTotal - 1) step 1 do {
		_magazineAmmoCapacity_moving = _magazineAmmoCapacity_moving + 1;
		_addMagazineArray set [_currentMagIndex,[_magazineClass,_magazineAmmoCapacity_moving]];
		if (_magazineAmmoCapacity_moving isEqualTo _magazineAmmoCapacity) then {
			_magazineAmmoCapacity_moving = 0;
			_currentMagIndex = _addMagazineArray pushBack [_magazineClass,_magazineAmmoCapacity_moving];
		};
	};
} forEach _data2;
if ((primaryWeapon _unit) isNotEqualTo '') then {
	{
		_unit removePrimaryWeaponItem _x;
	} forEach (primaryWeaponMagazine _unit);
};
if ((handgunWeapon _unit) isNotEqualTo '') then {
	{
		_unit removeHandgunItem _x;
	} forEach (handgunMagazine _unit);
};
_currentMagazines = magazines _unit;
if (_currentMagazines isNotEqualTo []) then {
	{
		if (_x in _magazineTypes) then {
			_unit removeMagazine _x;
		};
	} count _currentMagazines;
};
if (_addMagazineArray isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];};
{
	if ((_x # 1) > 0) then {
		_unit addMagazine _x;
	};
	if (_canSuspend) then {
		uiSleep 0.1;
	};
} count _addMagazineArray;
if (_canSuspend) then {
	uiSleep 2;
	_unit setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];
	if (!isPlayer _unit) then {
		reload _unit;
	};
} else {
	_unit spawn {
		uiSleep 2;
		_this setVariable ['QS_unit_repackingMagazines',FALSE,FALSE];
		if (!isPlayer _this) then {
			reload _this;
		};
	};
};
if (_unit isEqualTo player) then {
	50 cutText [localize 'STR_QS_Text_187','PLAIN DOWN',0.2];
};