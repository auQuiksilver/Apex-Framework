/*
File: fn_clientEventCuratorGroupPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	20/03/2017 A3 1.68 by Quiksilver
	
Description:

	Curator Group Placed
__________________________________________________*/

params ['_module','_group'];
{
	_x disableAI 'AUTOCOMBAT';
	_x disableAI 'COVER';
} count (units _group);
_group setSpeedMode 'FULL';
_group setBehaviourStrong 'AWARE';
_group deleteGroupWhenEmpty TRUE;
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