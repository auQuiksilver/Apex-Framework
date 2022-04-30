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
_this call (missionNamespace getVariable 'QS_fnc_feedbackDirtEffect');
_strength = (0 max _damage) * 30;
if (
	(_strength < 0.05) ||
	(player getVariable ['QS_RD_earplugs',FALSE]) ||
	(diag_tickTime < (player getVariable ['QS_combatDeafness',0])) ||
	(!( (lifeState player) in ['HEALTHY','INJURED']))
) exitWith {
	_damage
};
player setVariable ['QS_combatDeafness',(diag_tickTime + 60),FALSE];
0 spawn {
	uiSleep (random [0.3,0.4,0.5]);
	playSound ['combat_deafness',FALSE];
};
_damage;