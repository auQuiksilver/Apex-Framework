/*/
File: fn_AIdisableCollision.sqf
Author:

	Quiksilver
	
Last Modified:

	5/04/2018 A3 1.82 by Quiksilver
	
Description:

	Disable collision
_______________________________________________/*/

params ['_entity'];
_entity setVariable ['QS_AI_unit_nextdColl',(diag_tickTime + (120 + (random 120))),FALSE];
if ((_entity getVariable ['QS_AI_unit_dColl',-1]) isEqualTo -1) then {
	_entity setVariable ['QS_AI_unit_dColl',[],FALSE];
};
{
	if (!(_x in (_entity getVariable ['QS_AI_unit_dColl',[]]))) then {
		(_entity getVariable 'QS_AI_unit_dColl') pushBack _x;
		_entity disableCollisionWith _x;
		_x disableCollisionWith _entity;
	};
} forEach (missionNamespace getVariable 'QS_AI_vehicles');
TRUE;