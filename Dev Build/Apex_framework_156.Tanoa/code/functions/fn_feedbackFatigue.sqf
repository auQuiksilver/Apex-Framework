/*
@filename: fn_feedbackFatigue.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

BIS_fnc_feedback_fatigueCC ppEffectAdjust [1,1,0,[0.15, 0.15, 0.15, 0],[1, 1, 1, 1],[0.587, 0.587, 0.587, 0],[1, 1, 0, 0, 0, 0.2, 1]];
BIS_fnc_feedback_fatigueCC ppEffectCommit 0;
private _fatigue = ((getFatigue player) - 0.5) * 2;
private _delay1 = 0.8 * acctime;
BIS_fnc_feedback_fatigueRadialBlur ppEffectAdjust [0, 0, 0, 0];
BIS_fnc_feedback_fatigueRadialBlur ppEffectCommit 0;
BIS_fnc_feedback_fatigueRadialBlur ppEffectEnable TRUE;
BIS_fnc_feedback_fatigueRadialBlur ppEffectAdjust [((0.0004*_fatigue)+0.001067), ((0.0004*_fatigue)+0.001067), 0.04, 0.04];
BIS_fnc_feedback_fatigueRadialBlur ppEffectCommit _delay1;
if ((currentVisionMode player) isEqualTo 0) then {
	BIS_fnc_feedback_fatigueCC ppEffectAdjust [
		1,1,0,[0.15, 0.15, 0.15, ((0.466*_fatigue)+0.2)],
		[1.0, 1.0, 1.0, 1-((1.3*_fatigue)-0.8)],
		[0.587, 0.587, 0.587, 0.0],
		[0.85, 0.85, 0, 0, 0, 0.2, 1]
	];
} else {
	BIS_fnc_feedback_fatigueCC ppEffectAdjust [
		1,1,0,[0.15, 0.15, 0.15, ((0.466*_fatigue)+0.2)],
		[1, 1, 1, 1],
		[0.3, 0.3, 0.3, 0],
		[0.85, 0.85, 0, 0, 0, 0.2, 1]
	];
};
BIS_fnc_feedback_fatigueCC ppEffectEnable TRUE;
BIS_fnc_feedback_fatigueCC ppEffectForceInNVG TRUE;
BIS_fnc_feedback_fatigueCC ppEffectCommit _delay1;
uiSleep (_delay1 + 0.1);
private _delay2 = (1.5 + random 0.5) * acctime;
BIS_fnc_feedback_fatigueRadialBlur ppEffectAdjust [0,0,0.5,0.5];
BIS_fnc_feedback_fatigueRadialBlur ppEffectCommit _delay2;
BIS_fnc_feedback_fatigueCC ppEffectAdjust [1,1,0,[0.15, 0.15, 0.15, 0],[1, 1, 1, 1],[0.3, 0.3, 0.3, 0],[1, 1, 0, 0, 0, 0.2, 1]];
BIS_fnc_feedback_fatigueCC ppEffectCommit _delay2;
uiSleep (_delay2 + 0.1);
BIS_fnc_feedback_fatigueCC ppEffectEnable FALSE;
BIS_fnc_feedback_fatigueRadialBlur ppEffectEnable FALSE;
BIS_fnc_feedback_fatiguePP = false;