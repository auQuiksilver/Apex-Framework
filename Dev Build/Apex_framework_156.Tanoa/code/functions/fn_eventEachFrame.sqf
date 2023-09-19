/*/
File: fn_eventEachFrame.sqf
Author:

	Quiksilver
	
Last modified:

	17/01/2019 A3 1.88 by Quiksilver
	
Description:

	Event Each Frame
__________________________________________________/*/

if ((uiNamespace getVariable ['QS_roles_handler',[]]) isEqualTo []) then {
	removeMissionEventHandler [_thisEvent,_thisEventHandler];
	uiNamespace setVariable ['QS_roles_PFH',0];
} else {
	((uiNamespace getVariable ['QS_roles_handler',[]]) deleteAt 0) call (missionNamespace getVariable 'QS_fnc_roles');
};