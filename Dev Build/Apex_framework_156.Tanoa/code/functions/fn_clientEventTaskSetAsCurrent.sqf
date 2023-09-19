/*
File: fn_clientEventTaskSetAsCurrent.sqf
Author: 

	Quiksilver
	
Last modified:

	14/07/2016 A3 1.62 by Quiksilver
	
Description:

	Client Event TaskSetAsCurrent
	
Params:

	unit: Object - Unit to which the event handler is assigned
	task: Task - The new current task
___________________________________________________________________*/

params ['_unit','_task'];
{
	if (_x isNotEqualTo _task) then {
		if (taskAlwaysVisible _x) then {
			_x setSimpleTaskAlwaysVisible FALSE;
		};
	} else {
		if (!(taskAlwaysVisible _task)) then {
			_task setSimpleTaskAlwaysVisible TRUE;
		};
	};
} count (simpleTasks _unit);