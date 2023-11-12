/*
File: fn_clientVehicleEventFuel.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/11/2023 A3 2.14 by Quiksilver

Description:

	Event Fuel
	
	vehicle: Object - Vehicle the event handler is assigned to
	fuelState: Boolean - 0 when no fuel, 1 when the fuel tank is full
__________________________________________________________*/

params ['_vehicle','_fuelState'];
if (!_fuelState) then {
	50 cutText ['No fuel','PLAIN DOWN',0.3];	
};
if (_fuelState) then {
	50 cutText ['Fuel full','PLAIN DOWN',0.3];
};