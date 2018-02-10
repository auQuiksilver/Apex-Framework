/*
File: fn_clientVehicleEventFuel.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/01/2017 A3 1.66 by Quiksilver

Description:

	Event Fuel
	
	vehicle: Object - Vehicle the event handler is assigned to
	fuelState: Boolean - 0 when no fuel, 1 when the fuel tank is full
__________________________________________________________*/

if (!(local (_this select 0))) exitWith {};
params ['_vehicle','_fuelState'];