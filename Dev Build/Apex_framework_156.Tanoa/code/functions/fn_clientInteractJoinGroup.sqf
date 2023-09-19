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
50 cutText [(format ['%1 ( %2 )',localize 'STR_QS_Text_113',(groupID (group _t))]),'PLAIN DOWN'];