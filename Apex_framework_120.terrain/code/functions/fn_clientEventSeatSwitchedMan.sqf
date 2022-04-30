/*/
File: fn_clientEventSeatSwitchedMan.sqf
Author: 

	Quiksilver
	
Last modified:

	21/11/2018 A3 1.86 by Quiksilver
	
Description:

	Seat Switched Man Event
__________________________________________________/*/

params ['_u1','_u2','_v'];
if (_v isKindOf 'Heli_Transport_04_base_F') then {
	if (((assignedVehicleRole _u1) select 0) in ['driver','Turret']) then {
		if (!(_u1 getUnitTrait 'QS_trait_pilot')) then {
			_v enableCopilot FALSE;
			systemChat 'You are not a pilot';
			moveOut _u1;
		};
	};
};
if (player getUnitTrait 'QS_trait_pilot') then {
	player setVariable ['QS_pilot_vehicleInfo',[_v,(assignedVehicleRole player)],TRUE];
};