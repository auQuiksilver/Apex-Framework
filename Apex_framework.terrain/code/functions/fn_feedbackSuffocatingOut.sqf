/*
@filename: fn_feedbackSuffocatingOut.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

BIS_SuffCC ppEffectAdjust [1,1,0,[0, 0, 0, 0],[1, 1, 1, 1],[0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0]];
BIS_SuffCC ppEffectEnable TRUE;
BIS_SuffCC ppEffectCommit 8;
BIS_SuffRadialBlur ppEffectAdjust [0.0, 0.0, 0.5, 0.5];
BIS_SuffRadialBlur ppEffectEnable TRUE;
BIS_SuffRadialBlur ppEffectCommit 8;
BIS_SuffBlur ppEffectAdjust [0];
BIS_SuffBlur ppEffectEnable TRUE; 
BIS_SuffBlur ppEffectCommit 8;
uiSleep 8;
BIS_SuffCC ppEffectEnable FALSE;
BIS_SuffRadialBlur ppEffectEnable FALSE;
BIS_SuffBlur ppEffectEnable FALSE;