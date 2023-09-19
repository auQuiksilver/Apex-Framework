/*
File: fn_clientVehicleEventHit.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/07/2016 A3 1.62 by Quiksilver

Description:

	Event Hit
__________________________________________________________*/
if (!local (_this # 0)) exitWith {};
params ['_vehicle','_causedBy','_dmg','_instigator'];
[player,_causedBy,0.1,_instigator] call (missionNamespace getVariable 'QS_fnc_clientEventHit');