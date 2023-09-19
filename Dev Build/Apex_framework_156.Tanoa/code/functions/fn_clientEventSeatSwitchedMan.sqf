/*/
File: fn_clientEventSeatSwitchedMan.sqf
Author: 

	Quiksilver
	
Last modified:

	18/02/2023 A3 2.12 by Quiksilver
	
Description:

	Seat Switched Man Event
__________________________________________________/*/

params ['_u1','_u2','_v'];
if (_v isKindOf 'Heli_Transport_04_base_F') then {
	if (((assignedVehicleRole _u1) # 0) in ['driver','Turret']) then {
		if (!(_u1 getUnitTrait 'QS_trait_pilot')) then {
			_v enableCopilot FALSE;
			systemChat (localize 'STR_QS_Chat_090');
			moveOut _u1;
		};
	};
};
if (player getUnitTrait 'QS_trait_pilot') then {
	player setVariable ['QS_pilot_vehicleInfo',[_v,(assignedVehicleRole player)],TRUE];
};
if (
	(((assignedVehicleRole _u1) # 0) in ['driver']) &&
	{(!(_v in (assignedVehicles (group QS_player))))} &&
	{((assignedGroup _v) isNotEqualTo (group QS_player))}
) then {
	['addVehicle',group QS_player,_v] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
};