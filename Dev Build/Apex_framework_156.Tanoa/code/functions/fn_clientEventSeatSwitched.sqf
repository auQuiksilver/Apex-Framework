/*/
File: fn_clientEventSeatSwitched.sqf
Author: 

	Quiksilver
	
Last modified:

	21/11/2018 A3 1.86 by Quiksilver
	
Description:

	Seat Switched Event
_____________________________________________/*/

params ['_v','_u1','_u2'];
if (isPlayer _u1) then {
	if (((assignedVehicleRole _u1) # 0) in ['driver','Turret']) then {
		if ((!(_u1 getUnitTrait 'QS_trait_pilot')) && (!(_u1 getUnitTrait 'QS_trait_fighterPilot'))) then {
			_v enableCopilot FALSE;
			['systemChat',localize 'STR_QS_Chat_090'] remoteExec ['QS_fnc_remoteExecCmd',_u1,FALSE];
			moveOut _u1;
		};
	};
};