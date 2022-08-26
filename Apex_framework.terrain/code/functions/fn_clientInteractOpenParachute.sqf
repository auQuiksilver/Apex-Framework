/*
File: fn_clientInteractOpenParachute.sqf
Author:

	Quiksilver
	
Last Modified:

	22/05/2022 A3 2.10 by Quiksilver
	
Description:

	Open Parachute Interaction
________________________________________________*/

if (diag_tickTime < (missionNamespace getVariable ['QS_client_openParachuteCooldown',-1])) exitWith {};
missionNamespace setVariable ['QS_client_openParachuteCooldown',diag_tickTime + 5,FALSE];
_para = createVehicle ['Steerable_Parachute_F',[-500 + (random 100),-500 + (random 100),500 + (random 100)]];
_para setDir (getDir player);
_para setPos (player modelToWorld [0,5,0]);
player assignAsDriver _para;
player moveInDriver _para;