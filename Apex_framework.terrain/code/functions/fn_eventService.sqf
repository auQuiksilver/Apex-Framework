/*
File: fn_eventService.sqf
Author:

	Quiksilver
	
Last modified:

	23/1/2023 A3 2.12 by Quiksilver
	
Description:

	Vehicle Service event
	
Notes:

	0 - MINOR REPAIR, 1 - REPAIR, 2 - REFUEL, 3 - REARM
__________________________________________________*/

params ['_serviceProvider','_serviceReceiver','_serviceType','_serviceNeeded','_autoSupply'];
if (
	((getObjectType _serviceProvider) in [8]) &&				// [8,1] to block terrain fuel pumps
	{((allowedService _serviceProvider) isNotEqualTo 0)}
) then {
	_serviceProvider allowService 0;
	['allowService',_serviceProvider,0] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
};
TRUE;