/*/
File: fn_perFrameHandle.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Per Frame Handle
______________________________________________________/*/

if ((localNamespace getVariable ['QS_PF_queue',[]]) isEqualTo []) exitWith {
	removeMissionEventHandler [_thisEvent,_thisEventHandler];
	localNamespace setVariable ['QS_PF_queue_PFH',-1];
};
((localNamespace getVariable ['QS_PF_queue',[]]) deleteAt 0) call QS_fnc_perFrameExec;