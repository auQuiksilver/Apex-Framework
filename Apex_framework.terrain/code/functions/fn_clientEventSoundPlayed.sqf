/*
File: fn_clientEventSoundPlayed.sqf
Author: 

	Quiksilver
	
Last modified:

	30/1/2023 A3 2.12 by Quiksilver
	
Description:

	Client Event Sound Played
	
Notes:

	1 Breath
	2 Breath Injured
	3 Breath Scuba
	4 Injured
	5 Pulsation
	6 Hit Scream
	7 Burning
	8 Drowning
	9 Drown
	10 Gasping
	11 Stabilizing
	12 Healing
	13 Healing With Medikit
	14 Recovered
	15 Breath Held
____________________________________*/

params ['_unit','_soundID'];
if (
	(_soundID isEqualTo 2) && 
	{((damage _unit) >= 0.1)} && 
	{(!(missionNamespace getVariable 'BIS_fnc_feedback_damagePP'))} && 
	{!isRemoteControlling _unit}
) then {
	0 spawn (missionNamespace getVariable 'QS_fnc_feedbackDamagePulsing');
};
if (
	(_soundID in [1,2,3,10,15]) &&
	{(cameraView in ['INTERNAL','EXTERNAL'])} &&
	{((toLowerANSI (goggles _unit)) in [
		'g_regulatormask_f','g_airpurifyingrespirator_01_f','g_airpurifyingrespirator_02_sand_f',
		'g_airpurifyingrespirator_02_olive_f','g_airpurifyingrespirator_02_black_f','g_airpurifyingrespirator_01_nofilter_f'
	])} &&
	{(isNull curatorCamera)}
) exitWith {0};
//((['soundplayed_volumes_1'] call QS_data_listOther) # _soundID)