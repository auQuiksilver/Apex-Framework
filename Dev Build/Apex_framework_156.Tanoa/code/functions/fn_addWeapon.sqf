/*/
File: fn_addWeapon.sqf
Author:
	
	Mike Hannola (Alias of BIS_fnc_addWeapon) (tweaked by Quiksilver)
	
Last Modified:

	25/11/2022 A3 2.10 by Quiksilver
	
Description:

	Add a weapon + magazines

To Do:

	Cache config data
______________________________________________________/*/

params [['_unit',objNull],['_weapon',''],['_magazineCount',0],['_magazineClass',0],['_tracers',FALSE],['_return',FALSE]];
_weapon = toLowerANSI _weapon;
private _weaponExists = (QS_hashmap_configfile getOrDefault [format ['cfgweapons_%1_isclass',_weapon],'']) isNotEqualTo '';
if (!(_weaponExists)) then {
	_weaponExists = isClass (configFile >> 'CfgWeapons' >> _weapon);
	if (_weaponExists) then {
		QS_hashmap_configfile set [format ['cfgweapons_%1_isclass',_weapon],_weapon];
	};
};
if (!(_weaponExists)) exitWith {diag_log format ['***** Weapon does not exist - %1 *****',_weapon];};
if (_magazineCount > 0) then {
	if (_magazineClass isEqualType 0) then {
		private _magazines = (missionNamespace getVariable ['QS_session_weaponMagazines',[]]) getOrDefault [_weapon,[]];
		if (_magazines isEqualTo []) then {
			_magazines = (getArray (configFile >> 'CfgWeapons' >> _weapon >> 'magazines')) apply {toLowerANSI _x};
			(missionNamespace getVariable ['QS_session_weaponMagazines',[]]) set [_weapon,_magazines];
		};
		if (_magazines isNotEqualTo []) then {
			_magazineClass = toLowerANSI (_magazines # (_magazineClass min ((count _magazines) - 1)));
		} else {
			_magazineClass = '';
		};
	};
	if (_magazineClass isNotEqualTo '') then {
		if (_tracers) then {
			_value = QS_hashmap_tracers getOrDefault [_magazineClass,[]];
			if (_value isNotEqualTo []) then {
				_magazineClass = _value # (([EAST,WEST,RESISTANCE] find (side (group _unit))) max 0);
			};
		};
		if ((toLowerANSI _magazineClass) in (missionNamespace getVariable ['QS_session_magazineList',[]])) then {
			for '_i' from 1 to _magazineCount step 1 do {
				_unit addMagazine _magazineClass;
			};
		} else {
			if (isClass (configFile >> 'CfgMagazines' >> _magazineClass)) then {
				(missionNamespace getVariable ['QS_session_magazineList',[]]) pushBackUnique (toLowerANSI _magazineClass);
				for '_i' from 1 to _magazineCount step 1 do {
					_unit addMagazine _magazineClass;
				};
			};
		};
	};
};
private _muzzle = '';
if (!(_weapon in ((weapons _unit) apply {toLowerANSI _x}))) then {
	_unit addWeapon _weapon;
};
if (_return) then {
	_muzzles = getArray (configFile >> 'CfgWeapons' >> _weapon >> 'muzzles');
	_muzzle = if ((_muzzles # 0) isEqualTo 'this') then {_weapon} else {(_muzzles # 0)};
};
_muzzle;