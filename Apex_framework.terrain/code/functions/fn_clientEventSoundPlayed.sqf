/*
File: fn_clientEventSoundPlayed.sqf
Author: 

	Quiksilver
	
Last modified:

	19/05/2016 A3 1.58 by Quiksilver
	
Description:

	Client Event Sound Played
___________________________________________________________________*/

if (((_this select 1) isEqualTo 2) && ((damage player) >= 0.1) && (!(missionNamespace getVariable 'BIS_fnc_feedback_damagePP')) && (((uavControl (getConnectedUav player)) select 1) isEqualTo '')) then {
	call (missionNamespace getVariable 'BIS_fnc_damagePulsing');
};