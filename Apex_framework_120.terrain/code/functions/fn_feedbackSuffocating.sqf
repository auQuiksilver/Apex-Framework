/*
@filename: fn_feedbackSuffocating.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

private _oxygen = getOxygenRemaining player;
BIS_SuffCC ppEffectAdjust [
	1,
	1,
	0,
	[0.009019, 0.016078, 0.08, 0 max (-((0.845*_oxygen+0.3)^4)+0.9) ],
	[1, 1, 1, 1],
	[0,0,0,0],
	[1 min (0.676*_oxygen+0.3)^4+0.5, 1 min (0.676*_oxygen+0.3)^4+0.5, 0, 0, 0, 0.001, 0.5]
];
BIS_SuffCC ppEffectEnable TRUE;
BIS_SuffCC ppEffectForceInNVG TRUE;
BIS_SuffCC ppEffectCommit 1;
BIS_SuffRadialBlur ppEffectAdjust [0.02, 0.02, (0.02 max (1 / (-_oxygen + 2)) - 0.5)+0.166, (0.02 max (1 / (-_oxygen + 2)) - 0.5)+0.166];
BIS_SuffRadialBlur ppEffectEnable TRUE;
BIS_SuffRadialBlur ppEffectCommit 1;
BIS_SuffBlur ppEffectAdjust [0 max (3-(3.75*_oxygen))];
BIS_SuffBlur ppEffectEnable TRUE; 
BIS_SuffBlur ppEffectCommit 1;
uiSleep 1;
BIS_applyPP5 = true;