/*
File: fn_clientVehicleEventKilled.sqf
Author:
	
	Quiksilver
	
Last Modified:

	27/03/2017 A3 1.68 by Quiksilver

Description:

	Event Killed
__________________________________________________________*/

params ['_vehicle','_killer','_instigator','_useEffects'];
if (!local _vehicle) exitWith {};
if ((attachedObjects _vehicle) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			[0,_x] call QS_fnc_eventAttach;
			deleteVehicle _x;
		};
	} forEach (attachedObjects _vehicle);
};