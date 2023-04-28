/*/
File: fn_removeWeapon.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/08/2019 A3 1.94 by Quiksilver
	
Description:

	To Do: Optimise
______________________________________________________/*/

params ['_unit','_weapon'];
private _weaponCfg = configFile >> 'CfgWeapons' >> _weapon;
if (!isClass _weaponCfg) exitWith { };
_unit removeWeapon _weapon;
private _magazineCfg = configFile >> 'CfgMagazines';
{				
	private _magazines = getArray (if (_x == 'this') then { _weaponCfg >> 'magazines' } else { _weaponCfg >> _x >> 'magazines' }) select { getNumber (_magazineCfg >> _x >> 'scope') isEqualTo 2 };
	if (_magazines isNotEqualTo []) then {
		_unit removeMagazines (_magazines # 0);
	};
} forEach (getArray (_weaponCfg >> 'muzzles'));