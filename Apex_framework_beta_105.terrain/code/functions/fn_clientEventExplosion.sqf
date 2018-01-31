/*
File: fn_clientEventExplosion.sqf
Author: 

	Quiksilver
	
Last modified:

	27/04/2017 A3 1.68 by Quiksilver
	
Description:

	Explosion Event
___________________________________________________________________*/

params ['_unit','_damage'];
_this call (missionNamespace getVariable 'QS_fnc_dirtEffect');
_strength = (0 max _damage) * 30;
if (_strength < 0.05) exitWith {_damage;};
if (player getVariable ['QS_RD_earplugs',FALSE]) exitWith {_damage;};
if (diag_tickTime < (player getVariable 'QS_combatDeafness')) exitWith {_damage;};
if (!alive player) exitWith {_damage;};
if ((lifeState player) isEqualTo 'INCAPACITATED') exitWith {_damage;};
player setVariable ['QS_combatDeafness',(diag_tickTime + 60),FALSE];
0 spawn {uiSleep 0.4;playSound ['combat_deafness',FALSE];};
_damage;