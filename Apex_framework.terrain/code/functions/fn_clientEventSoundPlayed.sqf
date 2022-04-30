/*
File: fn_clientEventSoundPlayed.sqf
Author: 

	Quiksilver
	
Last modified:

	19/05/2016 A3 1.58 by Quiksilver
	
Description:

	Client Event Sound Played
___________________________________________________________________*/

if (
	((_this # 1) isEqualTo 2) && 
	((damage player) >= 0.1) && 
	(!(missionNamespace getVariable 'BIS_fnc_feedback_damagePP')) && 
	(((uavControl (getConnectedUav player)) # 1) isEqualTo '')
) then {
	0 spawn (missionNamespace getVariable 'QS_fnc_feedbackDamagePulsing');
};