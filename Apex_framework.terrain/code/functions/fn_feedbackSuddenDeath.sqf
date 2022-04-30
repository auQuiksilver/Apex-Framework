/*
@filename: fn_feedbackSuddenDeath.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

BIS_DeathRadialBlur ppEffectAdjust [0.025, 0.025, 0, 0];
BIS_DeathRadialBlur ppEffectEnable TRUE;
BIS_DeathRadialBlur ppEffectCommit 2; //1.5;
BIS_DeathBlur ppEffectAdjust [3.15];
BIS_DeathBlur ppEffectEnable TRUE;
BIS_DeathBlur ppEffectCommit 2;
uiSleep 2;
ppEffectDestroy BIS_DeathRadialBlur;
if (!(isNil "BIS_SuffCC")) then {ppEffectDestroy BIS_SuffCC;};
if (!(isNil "BIS_SuffRadialBlur")) then {ppEffectDestroy BIS_SuffRadialBlur;};
if (!(isNil "BIS_SuffBlur")) then {ppEffectDestroy BIS_SuffBlur;};
if (!(isNil "BIS_TotDesatCC")) then {ppEffectDestroy BIS_TotDesatCC;};
if (!(isNil "BIS_TotCC")) then {ppEffectDestroy BIS_TotCC;};
if (!(isNil "BIS_TotRadialBlur")) then {ppEffectDestroy BIS_TotRadialBlur;};			
if (!(isNil "BIS_TotBlur")) then {ppEffectDestroy BIS_TotBlur;};
(["HealthPP_blood"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","PLAIN"];
(["HealthPP_dirt"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","PLAIN"];
(["HealthPP_fire"] call bis_fnc_rscLayer) cutrsc ["RscHealthTextures","PLAIN"];
BIS_applyPP4 = TRUE;
BIS_fnc_feedback_allowDeathScreen = TRUE;