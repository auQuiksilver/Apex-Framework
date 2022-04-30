/*--------------------------------------------------------------------------------------------------

	Author: Nelson Duarte?
	
	Return if vehicle is armed or not.

	Example:
	_weapons:array = _vehicle:object call bis_fnc_moduleSpawnAISectorTactic_getVehicleWeapons;

--------------------------------------------------------------------------------------------------*/

private[
	"_weapons","_weaponClasses","_weaponGroup","_weaponType","_weaponData","_turrets","_turret","_weaponClass"
];
_vehicle = _this param [0,objNull,[objNull]]; 
if (isNull _vehicle) exitWith {[]};
_turrets = [[-1]] + allTurrets [_vehicle,false];
_weapons = [];

{
	_turret = _x;
	_weaponClasses = _vehicle weaponsTurret _turret;

	{
		_weaponClass = _x;
		_weaponData = _weaponClass call bis_fnc_itemType;
		if ((count _weaponData) isEqualTo 2) then {
			_weaponGroup = _weaponData select 0;
			_weaponType  = _weaponData select 1;

			if (_weaponGroup == "VehicleWeapon" && {_weaponType in ["MachineGun","RocketLauncher","GrenadeLauncher"]}) then {
				_weapons pushBack _weaponClass;
			} else
			{
				if (_weaponType == "UnknownWeapon") then {
					["[x] Unknown weapon group detected on vehicle |%1| & weapon |%2|!",typeOf _vehicle,_weaponClass] call bis_fnc_error;
				};
			};
		};
	} forEach _weaponClasses;
} forEach _turrets;
_weapons;