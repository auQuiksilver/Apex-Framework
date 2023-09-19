/*
File: fn_clientVehicleEventEpeContactStart.sqf
Author:
	
	Quiksilver
	
Last Modified:

	19/04/2022 2.08 by Quiksilver

Description:

	Event Epe Contact Start
__________________________________________________________*/
if ((!local (_this # 0)) || {((_this # 4) < 1000)}) exitWith {};
params ['_vehicle','_vehicle2','','','_force'];
if (_force > 1000) then {
	[_vehicle,_vehicle2,0.5,(driver _vehicle2),'EPECONTACTSTART'] call (missionNamespace getVariable 'QS_fnc_clientEventHit');
};