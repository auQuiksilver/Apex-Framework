/*
File: fn_clientVehicleEventHit.sqf
Author:
	
	Quiksilver
	
Last Modified:

	6/07/2016 A3 1.62 by Quiksilver

Description:

	Event Hit

	systemChat format ['***** fn_clientVehicleEventHit ***** %1 *****',_this];
__________________________________________________________*/
if (!local (_this select 0)) exitWith {};
params ['_vehicle','_causedBy','_damage','_instigator'];
[player,_causedBy,0.1,objNull] call (missionNamespace getVariable 'QS_fnc_clientEventHit');