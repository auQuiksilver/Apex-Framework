/*/
File: fn_clientMFindHealer.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	Nearest Medic text
_________________________________________________________________________________________/*/

_unit = player;
private _defaultDistance = 500;
_units = (units (side (group _unit))) inAreaArray [_unit,_defaultDistance,_defaultDistance,0,FALSE];
private _message = format [localize 'STR_QS_Text_269',_defaultDistance];
{
	if (
		(_x getUnitTrait 'medic') &&
		{((lifeState _x) in ['HEALTHY','INJURED'])} &&
		{(!captive _x)} &&
		{((_x distance _unit) < _defaultDistance)}
	) then {
		_defaultDistance = _x distance _unit;
		_message = format [localize 'STR_QS_Text_268',(name _x),(round _defaultDistance)];
	};
} forEach _units;
_message;