/*/
File: fn_perFrameQueue.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Per Frame Queue
______________________________________________________/*/

params [['_args',[]],['_fnc','']];
if (!( (toLowerANSI _fnc) in (call QS_data_pfh_whitelist) )) exitWith {};
(localNamespace getVariable 'QS_PF_queue') pushBack _this;
if ((localNamespace getVariable ['QS_PF_queue_PFH',-1]) isEqualTo -1) then {
	localNamespace setVariable ['QS_PF_queue_PFH',(addMissionEventHandler ['EachFrame',{call QS_fnc_perFrameHandle}])];
};