/*
File: fn_clientEventSeatSwitchedMan.sqf
Author: 

	Quiksilver
	
Last modified:

	25/04/2016 A3 1.56 by Quiksilver
	
Description:

	Seat Switched Man Event
	
	unit1: Object - Unit switching seat.
	unit2: Object - Unit with which unit1 is switching seat.
	vehicle: Object - Vehicle where switching seats is taking place.
___________________________________________________________________*/

params ['_u1','_u2','_v'];
private ['_taru_default','_taru_with_pod','_taru'];
_taru_default = ['O_Heli_Transport_04_F','O_Heli_Transport_04_black_F'];
_taru_with_pod = [
	'O_Heli_Transport_04_ammo_F','O_Heli_Transport_04_box_F','O_Heli_Transport_04_fuel_F','O_Heli_Transport_04_medevac_F',
	'O_Heli_Transport_04_repair_F','O_Heli_Transport_04_covered_F','O_Heli_Transport_04_covered_black_F'
];
_taru = _taru_default + _taru_with_pod;
if ((typeOf _v) in _taru) then {
	if (((assignedVehicleRole _u1) select 0) in ['driver','Turret']) then {
		if (!(_u1 getUnitTrait 'QS_trait_pilot')) then {
			_v enableCopilot FALSE;
			systemChat 'You are not a pilot';
			moveOut _u1;
		};
	};
};
if (player getUnitTrait 'QS_trait_pilot') then {
	player setVariable ['QS_pilot_vehicleInfo',[_v,(assignedVehicleRole player)],TRUE];
};