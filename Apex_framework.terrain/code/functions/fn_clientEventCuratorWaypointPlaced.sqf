/*
File: fn_clientEventCuratorWaypointPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	30/04/2019 A3 1.92 by Quiksilver
	
Description:

	Curator waypoint placed event
__________________________________________________*/

params ['_module','_group','_wpIndex'];
if (_wpIndex in [0,1]) then {
	private _unit = objNull;
	private _targets = [];
	{
		_unit = _x;
		_targets = _unit targets [TRUE,0];
		if (!(_targets isEqualTo [])) then {
			{
				_unit forgetTarget _x;
			} forEach _targets;
		};
	} forEach (units _group);
};
_group setFormDir ((leader _group) getDir (waypointPosition [_group,_wpIndex]));
_group setBehaviourStrong 'AWARE';