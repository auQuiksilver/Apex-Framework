/*/
File: fn_fire.sqf
Author:

	Quiksilver (Killzone Kid for BIS_fnc_fire)
	
Last Modified:

	24/11/2022 A3 2.10 by Quiksilver
	
Description:

	Alias of BIS_fnc_fire by Killzone Kid
	
To Do:

	Cache config data
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
		if ((toLowerANSI _muzzle) in ((weapons _unit) apply {(toLowerANSI _x)})) then {
			private _state = weaponState _unit;
			if ((isNil '_state') || {_state isEqualTo ['','','','',0]}) exitWith {};
			_state params ['_currentWeapon','_currentMuzzle','_currentMode'];
			if (_muzzle == _currentMuzzle) exitWith {[_unit, _currentMode] call _fnc_forceWeaponFire};
			private _cfgWeapons = configFile >> 'CfgWeapons';
			{
				if (_x == 'this' && _muzzle == _currentWeapon) exitWith {[_unit, getArray (_cfgWeapons >> _currentWeapon >> 'modes') param [0,'']] call _fnc_forceWeaponFire};
				if (_x == _muzzle) exitWith {[_unit, getArray (_cfgWeapons >> _currentWeapon >> _muzzle >> 'modes') param [0,'']] call _fnc_forceWeaponFire};
			} forEach (getArray (_cfgWeapons >> _currentWeapon >> 'muzzles'));
		} else {
			private _cfgWeapons = configFile >> 'CfgWeapons';
			private _cfgThrowMuzzle = _cfgWeapons >> 'Throw' >> _muzzle;
			if (!isNull _cfgThrowMuzzle) exitWith {[_unit, getArray (_cfgThrowMuzzle >> 'modes') param [0, '']] call _fnc_forceWeaponFire};	
		};
	};
};
_unitTurret = _vehicle unitTurret _unit;
_weaponState = (weaponState [_vehicle,_unitTurret,_muzzle]) params ['','','_xFiremode'];
[_unit,_xFireMode] call _fnc_forceWeaponFire;