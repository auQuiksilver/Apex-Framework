/*
File: fn_AIunitEventHit.sqf
Author:

	Quiksilver
	
Last modified:

	25/10/2015 ArmA 3 1.52 by Quiksilver
	
Description:

	AI Unit Event Hit
__________________________________________________*/

_unit = _this select 0;
_causedBy = _this select 1;

_unit setVariable ['QS_AI_UNIT_EVENT_HIT',[time,_causedBy],FALSE];