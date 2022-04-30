/*
@filename: fn_feedbackRadialRedOut.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (BIS_PP_burnParams isEqualTo []) then {
	 BIS_PP_burnParams = [0.55,0,0,safezoneW * 0.55,safezoneH * 0.55,[0.3,0.0,0.0]];
};
BIS_PP_burnParams params [
	'_sizeCoef',
	'_offsetX',
	'_offsetY',
	'_sizeX',
	'_sizeY',
	'_colorRGB'	
];
_adjust = [1,1,0,_colorRGB + [0],[1,1,1,1],[0.3,0.3,0.3,0],[_sizeX,_sizeY,0,_offsetX,_offsetY,0.5,1]];
BIS_HitCC ppeffectadjust _adjust;
BIS_HitCC ppeffectcommit 0.3;
uiSleep 0.3;
BIS_HitCC ppEffectEnable FALSE;