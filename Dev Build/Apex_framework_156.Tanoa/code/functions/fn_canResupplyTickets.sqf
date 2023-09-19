/*/
File: fn_canResupplyTickets.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/04/2023 A3 2.12 by Quiksilver
	
Description:

	-
____________________________________________/*/

getCursorObjectParams params ['_cursorObject','','_cursorDistance'];
(
	(isNull (objectParent QS_player)) &&
	{(_cursorDistance < 10)} &&
	{(_cursorObject getVariable ['QS_respawn_object',FALSE])} &&
	{(_cursorObject getVariable ['QS_respawn_canResupply',TRUE])} &&
	{(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} &&
	{(!isNull ([30] call QS_fnc_nearbyTickets))}
)