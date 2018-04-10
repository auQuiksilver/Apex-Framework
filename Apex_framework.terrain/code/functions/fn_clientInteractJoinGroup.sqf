/*/
File: fn_clientInteractJoinGroup.sqf
Author:
	
	Quiksilver
	
Last Modified:

	4/04/2018 A3 1.82 by Quiksilver

Description:

	Join Group
__________________________________________/*/

_t = cursorTarget;
if (
	(!alive _t) ||
	{(!(_t isKindOf 'CAManBase'))} ||
	{(!isPlayer _t)}
) exitWith {};
[player] joinSilent (group _t);
player playActionNow 'gestureHi';
50 cutText [(format ['Joined %1s group ( %2 )',(name _t),(groupID (group _t))]),'PLAIN DOWN'];