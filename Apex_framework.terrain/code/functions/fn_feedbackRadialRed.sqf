/*
@filename: fn_feedbackRadialRed.sqf
Author:

	Quiksilver
	
Last modified:

	26/04/2022 A3 2.08 by Quiksilver
	
Description:

	-
__________________________________________________*/

params [
	'_unit',
	'_hitpart',
	'_damage',
	'_shooter'
];
BIS_canStartRed = false;
if (_hitpart isNotEqualTo '') then {
	_delayFade = 1;
	_colorRGB = [0.3,0.0,0.0];
	_coefFront = 0.3;
	_coefSide = 0.25;
	_coefBack = 0.25;
	_dir = if (_unit isEqualTo _shooter) then {0} else {_unit getRelDir _shooter};
	if (isNil '_dir') then {_dir = 0};
	_dirToFront = (180 - _dir) / 180;
	_dirToEnd = (abs _dirToFront / _dirToFront) - _dirToFront;
	_dirTotal = abs _dirToFront * _dirToEnd * 4;
	_sizeCoef = 0.85 - (_coefFront * abs _dirToFront);
	_offsetX = 1 * -_dirTotal * _coefSide;
	_offsetY = 1 * - abs (_dirToEnd^2) * _coefBack;
	_sizeX = 1 * _sizeCoef;
	_sizeY = 1 * _sizeCoef;
	_colorAlpha = 0.4 + 0.5 * (_damage min 0.8);
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
} else {
	if (isBurning _unit) then {
		_colorRGB = [0.3,0.0,0.0];
		if (missionNamespace isNil 'BIS_pp_burnDamage') then {BIS_pp_burnDamage = [_damage,(diag_tickTime - 30)]};
		_time = diag_tickTime;
		if ((_time - (BIS_pp_burnDamage # 1)) < 1.15) then {
			_partDamage = _damage - (BIS_pp_burnDamage # 0);
			_delayFade = 1.05 - _partDamage;
			_sizeCoef = 0.55;
			_offsetX = 0;
			_offsetY = 0;
			_sizeX = 1 * _sizeCoef;
			_sizeY = 1 * _sizeCoef;
			BIS_PP_burnParams = [_sizeCoef,_offsetX,_offsetY,_sizeX,_sizeY,_colorRGB];
			_colorAlpha = 0.45 + 3.6 * (_partDamage min 0.15);
			_adjust = [
				1,
				1,
				0,
				_colorRGB + [_colorAlpha],
				[1,1,1,1],
				[0.3,0.3,0.3,0],
				[
					_sizeX * 0.85,
					_sizeY * 0.85,
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
			_adjust = [1, 1, 0, _colorRGB + [0], [1, 1, 1, 0], [0.3, 0.3, 0.3, 0], [1, 1, 0, _offsetX, _offsetY, 0.5, 1]];
			BIS_HitCC ppeffectadjust _adjust;
			BIS_HitCC ppeffectcommit _delayFade;
			uiSleep _delayFade;
			BIS_pp_burnDamage = [_damage,_time];
		} else {
			BIS_pp_burnDamage = [_damage,_time];
		};
	};
};
BIS_canStartRed = true;