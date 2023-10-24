/*
File: fn_clientVehicleEventDeleted.sqf
Author:
	
	Quiksilver
	
Last Modified:

	18/04/2017 A3 1.68 by Quiksilver

Description:

	Client Vehicle Deleted Event
__________________________________________________________*/
if (!(local (_this # 0))) exitWith {};
params ['_vehicle'];
if ((attachedObjects _vehicle) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			[0,_x] call QS_fnc_eventAttach;
			deleteVehicle _x;
		};
	} forEach (attachedObjects _vehicle);
};