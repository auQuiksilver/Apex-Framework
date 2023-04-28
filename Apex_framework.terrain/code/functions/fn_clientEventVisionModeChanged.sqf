/*
File: fn_clientEventVisionModeChanged.sqf
Author: 

	Quiksilver
	
Last modified:

	22/12/2022 A3 2.10 by Quiksilver
	
Description:

	Triggers when the assigned vehicle/unit's vision mode has changed.
	
Notes:

	unit: Object - unit for whom the vision mode changes
	visionMode: Number - vision mode index
	TIindex: Number - thermal vision mode index; will return -1 when visionMode is not 2
	visionModePrev: Number - last vision mode
	TIindexPrev: Number - last TI mode; will return -1 when visionModePrev is not 2
	vehicle: Object - if unit is in a vehicle or controlling a UAV, this will be the vehicle
	turret: Array - turret path to the turret occupied by the unit, or [] if not on turret
___________________________________________________________________*/

params ['_unit','_visionMode','_TIindex','_visionModePrev','_TIindexPrev','_vehicle','_turret'];