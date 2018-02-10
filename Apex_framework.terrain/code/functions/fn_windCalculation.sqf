/*
File: fn_windCalculation.sqf
Author:

	Quiksilver
	
Last Modified:
	
	12/06/2015 ArmA 3 1.46 by Quiksilver
	
Description:

	Calculate Wind
____________________________________________________*/

private [
	'_QS_getSet','_QS_windDir','_QS_windSpeed','_QS_wind','_QS_windX','_QS_windY','_QS_windPos',
	'_QS_tan','_QS_windPosX','_QS_windPosY','_QS_windStr'
];
_QS_getSet = _this select 0;
if (_QS_getSet isEqualTo 'GET') then {
	_QS_windPos = _this select 1;
	_QS_windPosX = _QS_windPos select 0;
	_QS_windPosY = _QS_windPos select 1;
	_QS_windDir = _QS_windPosX atan2 _QS_windPosY;
	if (_QS_windDir < 0) then {
		_QS_windDir = _QS_windDir + 360;
	};	
	_QS_windDir = _QS_windDir % 360;
	_QS_windStr = vectorMagnitude [_QS_windPosX,_QS_windPosY,0];
	_QS_wind = [_QS_windDir,_QS_windStr];
};
if (_QS_getSet isEqualTo 'SET') then {
	_QS_windDir = _this select 1;
	_QS_windSpeed = _this select 2;
	_QS_wind = [];
	_QS_windX = 0;
	_QS_windY = 0;
	_QS_windX = (_QS_windSpeed * (sin _QS_windDir));
	_QS_windY = (_QS_windSpeed * (cos _QS_windDir));
	if (_QS_windDir in [0,180]) then {_QS_windX = 0;};
	if (_QS_windDir in [90,270]) then {_QS_windY = 0;};
	_QS_wind = [_QS_windX,_QS_windY];
};
_QS_wind;