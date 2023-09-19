/*/
File: fn_clientInteractRecoverWreck.sqf
Author:

	Quiksilver
	
Last Modified:

	25/03/2023 A3 2.12 by Quiksilver
	
Description:

	Recover Wreck
_____________________________________________________________/*/

getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
if (!alive _cursorObject) exitWith {};
if (!([_cursorObject] call QS_fnc_canRecover)) exitWith {};
localNamespace setVariable ['QS_recoverWreckClient_script',([_cursorObject,[],FALSE,cameraOn isKindOf 'CAManBase'] spawn QS_fnc_recoverWreckClient)];