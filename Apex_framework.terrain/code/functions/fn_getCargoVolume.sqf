/*/
File: fn_getCargoVolume.sqf
Author:
	
	Quiksilver
	
Last Modified:

	31/05/2023 A3 2.12 by Quiksilver
	
Description:

	get total volume of current cargo
______________________________________________________/*/

params ['_vehicle',['_mode',0]];
if (_mode isEqualTo 0) exitWith {
	comment 'Physical';
	private _volume = 0;
	private _cargoMass = 0;
	_cargo = (attachedObjects _vehicle) select {
		(!(_x getVariable ['QS_attached',FALSE]))
	};
	{
		_cargoMass = _cargoMass + (getMass _x);
		_volume = _volume + ([_x] call QS_fnc_getObjectVolume);
	} forEach _cargo;
	_volume = _volume + ([_vehicle] call QS_fnc_getVirtualCargoVolume); // no virtual cargo mass?
	[_volume,_cargoMass]
};
if (_mode isEqualTo 1) exitWith {
	comment 'Virtual';
	private _volume = 0;
	private _cargoMass = 0;
	[_volume,_cargoMass];
};