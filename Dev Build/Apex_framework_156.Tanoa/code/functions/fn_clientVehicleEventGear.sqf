/*
File: fn_clientVehicleEventEngine.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/01/2017 A3 1.66 by Quiksilver

Description:

	Event Engine
	
	vehicle: Object - Vehicle the event handler is assigned to
	engineState: Boolean - True when the engine is turned on, false when turned off
	
To Do:

	Use this event for vehicle service.
__________________________________________________________*/

if (!(local (_this # 0))) exitWith {};
params ['_vehicle','_gearState'];