/*/
File: fn_addWeapon.sqf
Author:
	
	Mike Hannola (Alias of BIS_fnc_addWeapon) (tweaked by Quiksilver)
	
Last Modified:

	21/03/2018 A3 1.82 by Quiksilver
	
Description:

	-
______________________________________________________/*/

params [['_unit',objNull],['_weapon',''],['_magazineCount',0],['_magazineClass',0]];
_weaponExists = isClass (configFile >> 'CfgWeapons' >> _weapon);
if (_magazineCount > 0) then {
	if (_magazineClass isEqualType 0) then {
		_magazines = getArray (configFile >> 'CfgWeapons' >> _weapon >> 'magazines');
		if ((!(_magazines isEqualTo [])) && _weaponExists) then {
			_magazineClass = _magazines select (_magazineClass min ((count _magazines) - 1));
		} else {
			_magazineClass = '';
		};
	};
	if (isClass (configFile >> 'CfgMagazines' >> _magazineClass)) then {
		for '_i' from 1 to _magazineCount step 1 do {
			_unit addMagazine _magazineClass;
		};
	};
};
private _muzzle = '';
if (_weaponExists) then {
	if (!(_weapon in (weapons _unit))) then {
		_unit addWeapon _weapon;
	};
	_muzzles = getArray (configFile >> 'CfgWeapons' >> _weapon >> 'muzzles');
	_muzzle = if ((_muzzles select 0) isEqualTo 'this') then {_weapon} else {(_muzzles select 0)};
};
_muzzle;