/*/
File: fn_clientMFindHealer.sqf
Author:

	Quiksilver
	
Last modified:

	14/08/2022 A3 2.10 by Quiksilver

Description:

	Nearest Medic text
_________________________________________________________________________________________/*/

_unit = player;
private _defaultDistance = 500;
_units = (units (side (group _unit))) inAreaArray [getPosATL _unit,_defaultDistance,_defaultDistance,0,FALSE];
private _message = format ['No medics within %1m',_defaultDistance];
{
	if (
		(_x getUnitTrait 'medic') &&
		{((lifeState _x) in ['HEALTHY','INJURED'])} &&
		{(!captive _x)} &&
		{((_x distance _unit) < _defaultDistance)}
	) then {
		_defaultDistance = _x distance _unit;
		_message = format ['Nearest medic is %1 (%2m)',(name _x),(round _defaultDistance)];
	};
} forEach _units;
_message;