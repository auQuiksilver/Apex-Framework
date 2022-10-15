/*
File: fn_clientEventCuratorGroupPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	22/08/2022 A3 2.10 by Quiksilver
	
Description:

	Curator Group Placed
__________________________________________________*/

params ['_module','_group'];
{
	_x enableAIFeature ['AUTOCOMBAT',FALSE];
	//_x enableAIFeature ['COVER',FALSE];
} forEach (units _group);
_group setSpeedMode 'FULL';
_group setBehaviourStrong 'AWARE';
_group deleteGroupWhenEmpty TRUE;
_group addEventHandler [
	'WaypointComplete',
	{
		params ['_group','_waypointIndex'];
		if ((waypointPosition [_group,_waypointIndex + 1]) isNotEqualTo [0,0,0]) then {
			_group setFormDir ((leader _group) getDir (waypointPosition [_group,_waypointIndex + 1]));
		};
	}
];
if (!isNull (objectParent (leader _group))) then {
	if ((objectParent (leader _group)) isKindOf 'LandVehicle') then {
		_group setFormation 'COLUMN';
	};
};
{
	if (local _x) then {
		if (((units _x) findIf {(alive _x)}) isEqualTo -1) then {
			deleteGroup _x;
		};
	};
} count allGroups;