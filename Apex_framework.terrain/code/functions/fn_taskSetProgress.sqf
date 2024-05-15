/*/
File: fn_taskSetProgress.sqf
Author: 

	Quiksilver

Last Modified:

	28/11/2017 A3 1.78 by Quiksilver

Description:

	Set progress for a task
	
	['QS_IA_TASK_SM_ESCORT',TRUE,0.5] call QS_fnc_taskSetProgress;
	
	[0.8,0.6,0,1]
____________________________________________________________________________/*/

params ['_taskID','_enable','_progress'];
if (missionNamespace isNil 'QS_mission_tasks') then {
	missionNamespace setVariable ['QS_mission_tasks',[],FALSE];
};
_taskIndex = (missionNamespace getVariable 'QS_mission_tasks') findIf {((_x # 0) isEqualTo _taskID)};
if (_taskIndex isNotEqualTo -1) then {
	_taskData = (missionNamespace getVariable 'QS_mission_tasks') # _taskIndex;
	_taskData set [3,[_enable,_progress]];
	(missionNamespace getVariable 'QS_mission_tasks') set [_taskIndex,_taskData];
	missionNamespace setVariable ['QS_mission_tasks',(missionNamespace getVariable 'QS_mission_tasks'),TRUE];
};