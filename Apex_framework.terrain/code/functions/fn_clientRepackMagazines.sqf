/*
Script Name: QS Magazine Repack
File: fn_clientRepackMagazines.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/03/2017 A3 1.68 by Quiksilver

Description:

	Repack Magazines
	
Example:

	player call QS_fnc_clientRepackMagazines;
__________________________________________________________*/

private [
	'_unit','_data1','_data2','_i','_magazineClass','_magazineAmmoCount','_magazineAmmoCapacity',
	'_totalAmmoCountForMagazine','_magazineCountArray','_index','_addMagazineArray','_magazineAmmoCountTotal',
	'_magazineAmmoCapacity_moving','_currentMagIndex','_magazineTypes','_currentMagazines','_canSuspend'
];
_unit = _this;
if (
	(!(_unit isEqualType objNull)) ||
	{(isNull _unit)} ||
	{(!(_unit isKindOf 'Man'))} ||
	{(!(alive _unit))} ||
	{(!local _unit)} ||
	{(underwater _unit)} ||
	{(((eyePos _unit) select 2) < 0)} ||
	{(captive _unit)} ||
	{((lifeState _unit) in ['DEAD','DEAD-RESPAWN','DEAD-SWITCHING','INCAPACITATED'])} ||
	{((magazinesAmmoFull _unit) isEqualTo [])} ||
	{(!isNil {_unit getVariable 'QS_unit_repackingMagazines'})}
) exitWith {
	diag_log '***** QS Mag Repack ***** Log ***** Repack failed *****';
};
_vehicle = vehicle _unit;
if ((isPlayer _unit) && (!isNull (objectParent _unit)) && (_unit in [(driver _vehicle),(gunner _vehicle),(commander _vehicle)])) exitWith {comment 'Fail quietly, key binding overlap';};
if (_unit isEqualTo player) then {
	50 cutText ['Repacking magazines','PLAIN DOWN',0.3];
};
_unit setVariable ['QS_unit_repackingMagazines',TRUE,FALSE];
_canSuspend = canSuspend;
if (isNull (objectParent _unit)) then {
	_unit playActionNow 'Medic';
};
_magazineTypes = [];
_data1 = [];
{
	if ((_x select 3) in [-1,1,2]) then {
		_data1 pushBack _x;
	};
} forEach (magazinesAmmoFull _unit);
_data2 = [];
if (_data1 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
{
	_magazineClass = _x select 0;
	_magazineAmmoCount = _x select 1;
	_magazineAmmoCapacity = getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count');
	if (_magazineAmmoCapacity > 3) then {
		_magazineTypes pushBackUnique _magazineClass;
		if (!(_data2 isEqualTo [])) then {
			_i = [_data2,_magazineClass,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
			if (_i isEqualTo -1) then {
				_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
			} else {
				((_data2 select _i) select 2) pushBack _magazineAmmoCount;
			};
		} else {
			_data2 pushBack [_magazineClass,_magazineAmmoCapacity,[_magazineAmmoCount]];
		};
	};
} forEach _data1;
if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
{
	_magazineClass = _x select 0;
	_magazineAmmoCapacity = _x select 1;
	_magazineCountArray = _x select 2;
	_totalAmmoCountForMagazine = 0;
	for '_index' from 0 to ((count _magazineCountArray) - 1) step 1 do {
		_totalAmmoCountForMagazine = _totalAmmoCountForMagazine + (_magazineCountArray select _index);
	};
	(_data2 select _forEachIndex) set [2,_totalAmmoCountForMagazine];
	(_data2 select _forEachIndex) pushBack (ceil(_totalAmmoCountForMagazine / _magazineAmmoCapacity));
} forEach _data2;
if (_data2 isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
_addMagazineArray = [];
{
	_magazineClass = _x select 0;
	_magazineAmmoCapacity = _x select 1;
	_magazineAmmoCountTotal = _x select 2;
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
if (!((primaryWeapon _unit) isEqualTo '')) then {
	_unit removePrimaryWeaponItem ((primaryWeaponMagazine _unit) select 0);
};
if (!((handgunWeapon _unit) isEqualTo '')) then {
	_unit removeHandgunItem ((handgunMagazine _unit) select 0);
};
_currentMagazines = magazines _unit;
if (!(_currentMagazines isEqualTo [])) then {
	{
		if (_x in _magazineTypes) then {
			_unit removeMagazine _x;
		};
	} count _currentMagazines;
};
if (_addMagazineArray isEqualTo []) exitWith {_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];};
{
	if ((_x select 1) > 0) then {
		_unit addMagazine _x;
	};
	if (_canSuspend) then {
		uiSleep 0.1;
	};
} count _addMagazineArray;
if (_canSuspend) then {
	uiSleep 2;
	_unit setVariable ['QS_unit_repackingMagazines',nil,FALSE];
	if (!isPlayer _unit) then {
		reload _unit;
	};
} else {
	_unit spawn {
		uiSleep 2;
		_this setVariable ['QS_unit_repackingMagazines',nil,FALSE];
		if (!isPlayer _this) then {
			reload _this;
		};
	};
};
if (_unit isEqualTo player) then {
	50 cutText ['Magazines repacked','PLAIN DOWN',0.2];
};