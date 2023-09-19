/*/
File: fn_getDoor.sqf
Author:

	Quiksilver
	
Last Modified:
	
	11/07/2017 A3 1.72 by Quiksilver
	
Description:

	Get Door
____________________________________________________/*/

getCursorObjectParams params [
	'_cursorObject',
	'_cursorObjectNamedSel',
	'_cursorObjectDist'
];
if (isNull _cursorObject) exitWith {[objNull,'']};
if (_cursorObjectNamedSel isEqualTo []) exitWith {[objNull,'']};
if (_cursorObjectDist > 2.25) exitWith {[objNull,'']};
[_cursorObject,(_cursorObjectNamedSel # 0)];