/*
File: fn_clientSetUnitInsignia.sqf
Author:

	Quiksilver (credit: Karel Moricky for BIS_fnc_setUnitInsignia)
	
Last modified:

	8/01/2015 ArmA 3 1.54 by Quiksilver
	
Description:

	QS_fnc_clientSetUnitInsignia
__________________________________________________________________________*/

private ['_unit','_cfgTexture','_texture','_index'];
_texture = _this select 0;
if (_texture isEqualTo '') then {
	_texture = '#(argb,8,8,3)color(0,0,0,0)';
};
_index = -1;
{
	if (_x isEqualTo 'insignia') exitWith {
		_index = _forEachIndex;
	};
} forEach (getArray (configFile >> 'CfgVehicles' >> getText (configFile >> 'CfgWeapons' >> (uniform player) >> 'ItemInfo' >> 'uniformClass') >> 'hiddenSelections'));
if (_index < 0) then {
	false
} else {
	player setVariable ['QS_ClientUnitInsignia2',_texture,TRUE];
	player setObjectTextureGlobal [_index,_texture];
	true
};