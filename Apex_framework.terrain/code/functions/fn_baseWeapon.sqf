/*/
File: fn_baseWeapon.sqf
Author:

	Quiksilver (Alias of BIS_fnc_baseWeapon by Karel Moricky)
	
Last Modified:

	15/04/2018 A3 1.82 by Quiksilver
	
Description:

	Return base weapon (i.e., weapon without any attachments)
________________________________________________/*/

params [['_class','',['']]];
_cfg = configfile >> 'CfgWeapons' >> _class;
if (!(isClass _cfg)) exitWith {
	_class
};
_base = getText (_cfg >> 'baseWeapon');
if (isClass (configfile >> 'CfgWeapons' >> _base)) exitWith {
	_base
};
private _return = _class;
{
	if ((getArray (_x >> 'linkedItems')) isEqualTo []) exitWith {
		_return = configName _x;
	};
} forEach (_cfg call (missionNamespace getVariable 'BIS_fnc_returnParents'));
_return;