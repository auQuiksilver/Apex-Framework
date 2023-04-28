/*/
File: fn_baseWeapon.sqf
Author:

	Quiksilver (Alias of BIS_fnc_baseWeapon by Karel Moricky)
	
Last Modified:

	21/09/2022 A3 2.10 by Quiksilver
	
Description:

	Return base weapon (i.e., weapon without any attachments)

Notes:

	To Do: Optimise this
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
{
	if ((getArray (_x >> 'linkedItems')) isEqualTo []) exitWith {
		_class = configName _x;
	};
} forEach (_cfg call (missionNamespace getVariable 'BIS_fnc_returnParents'));
_class;