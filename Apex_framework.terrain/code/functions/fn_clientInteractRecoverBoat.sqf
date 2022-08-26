/*/
File: fn_clientInteractRecoverBoat.sqf
Author:

	Quiksilver
	
Last modified:

	15/08/2018 A3 1.84 by Quiksilver
	
Description:
	
	Recover Boat
____________________________________________/*/

_vehicle = vehicle player;
_nearRacks = (nearestObjects [_vehicle,['land_destroyer_01_boat_rack_01_f'],20,TRUE]) select {((getVehicleCargo _x) isEqualTo [])};
if (_nearRacks isNotEqualTo []) then {
	_rack = _nearRacks # 0;
	_rack setVehicleCargo _vehicle;
	_vehicle setDamage [0,FALSE];
	playSound3D ['A3\Sounds_F\sfx\ui\vehicles\vehicle_repair.wss',_rack,FALSE,(getPosASL _rack),2,1,25];
	if (local _vehicle) then {
		_vehicle setVehicleAmmo 1;
		_vehicle setFuel 1;
	} else {
		['setVehicleAmmo',_vehicle,1] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
		['setFuel',_vehicle,1] remoteExec ['QS_fnc_remoteExecCmd',_vehicle,FALSE];
	};
};