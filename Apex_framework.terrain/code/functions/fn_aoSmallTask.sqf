/*/
File: fn_aoSmallTask.sqf
Author: 

	Quiksilver

Last Modified:

	5/10/2016 A3 1.64 by Quiksilver

Description:

	Small AO Task
	
Spawn small task in AO

	Capture officer
	Medevac soldier
	Destroy vehicle
	Destroy SAM
________________________________________________________/*/

params ['_case','_state','_data'];
private _return = -1;
private _taskFunction = '';
if (_case isEqualTo 0) then {
	//comment 'Default';
	_taskFunction = '';
};
if (_case isEqualTo 1) then {
	//comment 'Medevac Soldier';
	_taskFunction = 'QS_fnc_aoTaskMedevac';
	_return = _this call (missionNamespace getVariable _taskFunction);
};
if (_case isEqualTo 2) then {
	//comment 'Arrest HVT';
	_taskFunction = 'QS_fnc_aoTaskHVT';
	_return = _this call (missionNamespace getVariable _taskFunction);
};
if (_case isEqualTo 3) then {
	//comment 'Destroy vehicle';
	_taskFunction = 'QS_fnc_aoTaskDestroyVehicle';
	_return = _this call (missionNamespace getVariable _taskFunction);
};
if (_case isEqualTo 4) then {
	//comment 'Destroy mobile SAM';
	_taskFunction = 'QS_fnc_aoTaskSAM';
	_return = _this call (missionNamespace getVariable _taskFunction);
};
_return;