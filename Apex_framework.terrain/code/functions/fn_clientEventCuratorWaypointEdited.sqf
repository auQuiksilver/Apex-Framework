/*
File: fn_clientEventCuratorWaypointEdited.sqf
Author:

	Quiksilver
	
Last modified:

	17/08/2022 A3 2.10 by Quiksilver
	
Description:

	Curator waypoint edited event
__________________________________________________*/

params ['_module','_group','_wpIndex'];
[_group,_wpIndex] setWaypointPosition [AGLToASL (waypointPosition [_group,_wpIndex]),-1];
_group setFormDir ((leader _group) getDir (waypointPosition [_group,_wpIndex]));