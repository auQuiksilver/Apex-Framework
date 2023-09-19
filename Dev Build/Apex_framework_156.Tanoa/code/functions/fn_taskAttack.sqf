/*
File: fn_taskAttack.sqf
Author: 

	Quiksilver

Description:

	Group will attack the position.

Parameter(s):

	_this # 0: group (Group)
	_this # 1: attack position (Array)
	_this # 2: attack movements enabled

Returns:

	Boolean - success flag
______________________________________________________*/

params ['_grp','_pos','_attackEnabled'];
_grp enableAttack _attackEnabled;
_pos set [2,1.5];
_grp setVariable ['QS_AI_Groups',['QS_ATTACK',_pos],FALSE];
[
	_grp,
	_pos,
	30,
	'SAD',
	'AWARE',
	'RED',
	'WEDGE',
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