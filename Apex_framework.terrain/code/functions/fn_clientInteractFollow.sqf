/*
File: fn_clientInteractFollow.sqf
Author:

	Quiksilver
	
Last Modified:

	3/09/2015 ArmA 3 1.50
	
Description:

	-
	
	_QS_agent playActionNow _QS_gesture;
_____________________________________________________________*/

private ['_t'];
_t = cursorTarget;
if (!isNull (objectParent _t)) exitWith {};
if (isPlayer _t) exitWith {};
if (!alive _t) exitWith {};
player playActionNow 'gestureHi';
[_t] joinSilent (group player);
(group player) setBehaviour 'CARELESS';
(group player) setCombatMode 'BLUE';
50 cutText ['The unit is now in your group','PLAIN DOWN',0.5];
true;