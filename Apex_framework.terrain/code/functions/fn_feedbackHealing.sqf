/*
@filename: fn_feedbackHealing.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

BIS_fnc_feedback_blue = false;
if (!isNull (objectParent player)) exitWith {BIS_fnc_feedback_blue = true;};
_delayFade = 2;
_colorRGB = [0.0,0.0,0.3];
_coefFront = 0.3;
_coefSide = 0.25;
_coefBack = 0.25;
_dir = 0;
_dirToFront = (180 - _dir) / 180;
_dirToEnd = (abs _dirToFront / _dirToFront) - _dirToFront;
_dirTotal = abs _dirToFront * _dirToEnd * 4;
_sizeCoef = 0.85 - (_coefFront * abs _dirToFront);
_offsetX = 1 * -_dirTotal * _coefSide;
_offsetY = 1 * - abs (_dirToEnd^2) * _coefBack;
_sizeX = 1 * _sizeCoef;
_sizeY = 1 * _sizeCoef;
_colorAlpha = 0.5;
_adjust = [
	1,
	1,
	0,
	_colorRGB + [_colorAlpha],
	[1,1,1,1],
	[0.3,0.3,0.3,0],
	[
		_sizeX,
		_sizeY,
		0,
		_offsetX,
		_offsetY,
		0.5,
		1
	]
];
BIS_HitCC ppeffectadjust _adjust;
BIS_HitCC ppEffectEnable TRUE;
BIS_HitCC ppEffectForceInNVG TRUE;
BIS_HitCC ppeffectcommit 0;
_adjust set [3,_colorRGB + [0]];
BIS_HitCC ppeffectadjust _adjust;
BIS_HitCC ppeffectcommit _delayFade;
uiSleep _delayFade;
BIS_HitCC ppEffectEnable FALSE;
BIS_fnc_feedback_blue = true;