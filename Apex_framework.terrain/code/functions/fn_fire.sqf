/*/
File: fn_fire.sqf
Author:

	Quiksilver (Killzone Kid for BIS_fnc_fire)
	
Last Modified:

	17/12/2022 A3 2.10 by Quiksilver
	
Description:

	Alias of BIS_fnc_fire by Killzone Kid
___________________________________________/*/

params ['_unit',['_muzzle','']];
if (!local _unit) exitWith {
	[104,_this] remoteExec ['QS_fnc_remoteExec',_unit];
	nil
};
_fnc_forceWeaponFire = {
	params ['_unit','_mode'];
	if (_mode isEqualTo '') exitWith {};
	if (_mode isEqualTo 'this') then {_mode = _muzzle};
	if (local _unit) then {
		_unit forceWeaponFire [_muzzle,_mode];
	} else {
		['forceWeaponFire',_unit,[_muzzle,_mode]] remoteExec ['QS_fnc_remoteExecCmd',_unit,FALSE];
	};
	TRUE
};
_currentWeapons = ((weapons _unit) apply {(toLowerANSI _x)});
if (_muzzle isEqualTo '') then {
	_muzzle = currentMuzzle _unit;
};
_vehicle = objectParent _unit;
if (isNull _vehicle) exitWith {
	if ((_unit ammo _muzzle) isNotEqualTo 0) then {
		if ((toLowerANSI _muzzle) in _currentWeapons) then {
			private _state = weaponState _unit;
			if ((isNil '_state') || {_state isEqualTo ['','','','',0]}) exitWith {};
			_state params ['_currentWeapon','_currentMuzzle','_currentMode'];
			if (_muzzle == _currentMuzzle) exitWith {[_unit, _currentMode] call _fnc_forceWeaponFire};
			_configMuzzles = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgweapons_%1_muzzles',toLowerANSI _currentWeapon],
				{getArray (configFile >> 'CfgWeapons' >> _currentWeapon >> 'muzzles')},
				TRUE
			];
			_modes = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgweapons_%1_modes',toLowerANSI _currentWeapon],
				{getArray (configFile >> 'CfgWeapons' >> _currentWeapon >> 'modes')},
				TRUE
			];
			_muzzleModes = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgweapons_%1_muzzlemodes',toLowerANSI _currentWeapon],
				{getArray (configFile >> 'CfgWeapons' >> _currentWeapon >> _muzzle >> 'modes')},
				TRUE
			];
			{
				if (_x == 'this' && _muzzle == _currentWeapon) exitWith {[_unit,_modes param [0,'']] call _fnc_forceWeaponFire};
				if (_x == _muzzle) exitWith {[_unit,_muzzleModes param [0,'']] call _fnc_forceWeaponFire};
			} forEach _configMuzzles;
		} else {
			_cfgMuzzle = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgweapons_throw_%1_muzzle',toLowerANSI _muzzle],
				{configFile >> 'CfgWeapons' >> 'Throw' >> _muzzle},
				TRUE
			];
			if (!isNull _cfgMuzzle) exitWith {
				_muzzleModes = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgweapons_throw_%1_muzzlemodes',toLowerANSI _muzzle],
					{getArray (configFile >> 'CfgWeapons' >> 'Throw' >> _muzzle >> 'modes')},
					TRUE
				];
				[_unit,_muzzleModes param [0, '']] call _fnc_forceWeaponFire
			};	
		};
	};
};
_weaponState = (weaponState [_vehicle,(_vehicle unitTurret _unit),_muzzle]) params ['','','_xFiremode'];
[_unit,_xFireMode] call _fnc_forceWeaponFire;