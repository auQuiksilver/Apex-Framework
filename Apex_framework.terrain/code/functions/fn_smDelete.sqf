/*
Author: 

	Quiksilver
	
Last modified:

	12/04/2014

Description:

	Delete enemies.
___________________________________________*/

{
    if (_x isEqualType grpNull) then {
        {
			if ((vehicle _x) isNotEqualTo _x) then {
                deleteVehicle (vehicle _x);
            };
            deleteVehicle _x;
        } forEach (units _x);
    } else {
        if ((vehicle _x) isNotEqualTo _x) then {
            deleteVehicle (vehicle _x);
        };
        if !(_x isKindOf 'CAManBase') then {
			deleteVehicleCrew _x;
        };
        deleteVehicle _x;
    };
} forEach (_this # 0);