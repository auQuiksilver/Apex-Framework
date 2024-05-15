/*/
File: fn_taskSetCustomData.sqf
Author: 

	Quiksilver

Last Modified:

	3/11/2017 A3 1.76 by Quiksilver

Description:

	Set task custom data
____________________________________________________________________________/*/

params ['_taskID','_customData'];
if (missionNamespace isNil 'QS_mission_tasks') then {
	missionNamespace setVariable ['QS_mission_tasks',[],FALSE];
};
_taskIndex = (missionNamespace getVariable 'QS_mission_tasks') findIf {((_x # 0) isEqualTo _taskID)};
if (_taskIndex isNotEqualTo -1) then {
	_taskData = (missionNamespace getVariable 'QS_mission_tasks') # _taskIndex;
	_taskData set [1,_customData];
	(missionNamespace getVariable 'QS_mission_tasks') set [_taskIndex,_taskData];
	missionNamespace setVariable ['QS_mission_tasks',(missionNamespace getVariable 'QS_mission_tasks'),TRUE];
};