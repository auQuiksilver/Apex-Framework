/*
File: fn_clientEventCuratorGroupPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	20/03/2017 A3 1.68 by Quiksilver
	
Description:

	Curator Group Placed
	
	generic error in expression
__________________________________________________*/

params ['_module','_group'];
{
	_x disableAI 'AUTOCOMBAT';
	_x disableAI 'COVER';
} count (units _group);
_group setSpeedMode 'FULL';
_group deleteGroupWhenEmpty TRUE;
{
	if (local _x) then {
		if (({(alive _x)} count (units _x)) isEqualTo 0) then {
			deleteGroup _x;
		};
	};
} count allGroups;