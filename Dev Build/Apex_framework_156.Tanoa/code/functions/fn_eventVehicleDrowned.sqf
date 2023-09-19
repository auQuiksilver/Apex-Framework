/*/
File: fn_eventVehicleDrowned.sqf
Author:

	Quiksilver
	
Last modified:

	28/08/2023 A3 2.14 by Quiksilver
	
Description:

	Vehicle Drowned event
__________________________________________________/*/

params ['_vehicle','_drowned'];
if (local _vehicle) then {
	_vehicle setVariable ['QS_v_drowned',_drowned,!isDedicated];
};
