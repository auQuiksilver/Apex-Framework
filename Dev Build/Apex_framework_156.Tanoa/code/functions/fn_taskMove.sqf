/*
File: fn_taskMove.sqf
Author: 

	Quiksilver

Description:

	Group will move to a position.

Parameter(s):

	_this # 0: group (Group)
	_this # 1: move position (Array)

Returns:

	Boolean - success flag
______________________________________________________*/

params ['_grp','_pos'];
if (attackEnabled _grp) then {
	_grp enableAttack FALSE;
};
_pos set [2,1.5];
_grp setVariable ['QS_AI_Groups',['QS_MOVE',_pos],FALSE];
[
	_grp,
	_pos,
	30,
	'MOVE',
	'AWARE',
	'YELLOW',
	(formation _grp),
	'FULL',
	(10 + (random 50)),
	objNull,
	[],
	[],
	'',
	'',
	'',
	FALSE,
	FALSE,
	FALSE
] call (missionNamespace getVariable 'QS_fnc_taskSetSingleWaypoint');
TRUE;