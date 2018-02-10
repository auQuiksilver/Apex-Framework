/*/
File: fn_taskSetTimer.sqf
Author: 

	Quiksilver

Last Modified:

	3/11/2017 A3 1.76 by Quiksilver

Description:

	Set timer for a task
____________________________________________________________________________/*/

params ['_taskID','_enable','_timer'];
if (isNil {missionNamespace getVariable 'QS_mission_tasks'}) then {
	missionNamespace setVariable ['QS_mission_tasks',[],FALSE];
};
_taskIndex = [(missionNamespace getVariable 'QS_mission_tasks'),_taskID,0] call (missionNamespace getVariable 'ZEN_fnc_arrayGetNestedIndex');
if (!(_taskIndex isEqualTo -1)) then {
	_taskData = (missionNamespace getVariable 'QS_mission_tasks') select _taskIndex;
	_taskData set [2,[_enable,_timer]];
	(missionNamespace getVariable 'QS_mission_tasks') set [_taskIndex,_taskData];
	missionNamespace setVariable ['QS_mission_tasks',(missionNamespace getVariable 'QS_mission_tasks'),TRUE];
};