/*
File: fn_clientInteractJoinGroup.sqf
Author:
	
	Quiksilver
	
Last Modified:

	12/08/2016 A3 1.62 by Quiksilver

Description:

	Join Group
__________________________________________________________*/

_t = cursorTarget;
if (isNull _t) exitWith {};
if (!(_t isKindOf 'Man')) exitWith {};
if (!alive _t) exitWith {};
if (!isPlayer _t) exitWith {};
[player] joinSilent (group _t);
player playActionNow 'gestureHi';
50 cutText [(format ['Joined %1s group ( %2 )',(name _t),(groupID (group _t))]),'PLAIN DOWN'];