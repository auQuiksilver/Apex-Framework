/*
Author: 

	Quiksilver
	
Last modified:

	12/04/2014

Description:

	Delete enemies.
	
___________________________________________*/

{
	sleep 1;
    if (_x isEqualType grpNull) then {
        {
            if (vehicle _x != _x) then {
                deleteVehicle (vehicle _x);
            };
            deleteVehicle _x;
        } forEach (units _x);
    } else {
        if (vehicle _x != _x) then {
            deleteVehicle (vehicle _x);
        };
        if !(_x isKindOf "Man") then {
            {
                deleteVehicle _x;
            } forEach (crew _x)
        };
        deleteVehicle _x;
    };
} forEach (_this select 0);