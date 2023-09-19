/*/
File: fn_clientSetUnitInsignia.sqf
Author:

	Quiksilver (credit: Karel Moricky for BIS_fnc_setUnitInsignia)
	
Last modified:

	31/03/2018 A3 1.82 by Quiksilver
	
Description:

	QS_fnc_clientSetUnitInsignia
_____________________________________________________/*/

params [['_texture',''],['_unit',player]];
if (_texture isEqualTo '') then {
	_texture = '#(argb,8,8,3)color(0,0,0,0)';
};
if ((uniform _unit) isEqualTo '') exitWith {FALSE};
_index = (getArray (configFile >> 'CfgVehicles' >> getText (configFile >> 'CfgWeapons' >> (uniform _unit) >> 'ItemInfo' >> 'uniformClass') >> 'hiddenSelections')) findIf {(_x isEqualTo 'insignia')};
if (_index isEqualTo -1) exitWith {FALSE};
_unit setVariable ['QS_ClientUnitInsignia2',_texture,TRUE];
_unit setObjectTextureGlobal [_index,_texture];
TRUE;