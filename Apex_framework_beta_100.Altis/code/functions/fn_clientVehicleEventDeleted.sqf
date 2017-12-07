/*
File: fn_clientVehicleEventDeleted.sqf
Author:
	
	Quiksilver
	
Last Modified:

	18/04/2017 A3 1.68 by Quiksilver

Description:

	Client Vehicle Deleted Event
__________________________________________________________*/
if (!(local (_this select 0))) exitWith {};
params ['_vehicle'];
if (!((attachedObjects _vehicle) isEqualTo [])) then {
	{
		if (!isNull _x) then {
			detach _x;
			deleteVehicle _x;
		};
	} forEach (attachedObjects _vehicle);
};