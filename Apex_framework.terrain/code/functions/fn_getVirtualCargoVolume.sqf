/*/
File: fn_getVirtualCargoVolume.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/05/2023 A3 2.12 by Quiksilver
	
Description:

	Get Volume of total virtual cargo
______________________________________________________/*/

params ['_vehicle'];
if (!alive _vehicle) exitWith {0};
_cargo = _vehicle getVariable ['QS_virtualCargo',[]];
if (_cargo isEqualTo []) exitWith {0};
private _cargoVolume = 0;
private _element = [];
private _count = 0;
private _objectType = '';
private _boundingVolume = 0;
{
	_element = _x;
	for '_i' from 0 to ((_element # 1) - 1) do {
		_objectType = (_element # 0) # 0;
		_boundingVolume = (_element # 0) # 4;
		_cargoVolume = _cargoVolume + _boundingVolume;
	};
} forEach _cargo;
_cargoVolume;