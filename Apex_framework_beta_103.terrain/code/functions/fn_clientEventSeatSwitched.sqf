/*
File: fn_clientEventSeatSwitched.sqf
Author: 

	Quiksilver
	
Last modified:

	1/02/2016 A3 1.54 by Quiksilver
	
Description:

	Seat Switched event
___________________________________________________________________*/

params ['_v','_u1','_u2'];
if (isPlayer _u1) then {
	if (((assignedVehicleRole _u1) select 0) in ['driver','Turret']) then {
		if (!(['pilot',(typeOf _u1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
			if (isNil {_u1 getVariable 'QS_pilotLicense'}) then {
				_v enableCopilot FALSE;
				['systemChat','You are not a pilot'] remoteExec ['QS_fnc_remoteExecCmd',_u1,FALSE];
				moveOut _u1;
			};
		};
	};
};