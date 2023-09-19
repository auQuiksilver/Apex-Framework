/*
  Function: QS_fnc_windCalculation
  Author: Quiksilver + ChatGPT-4
  Date: 18/03/2023

  Description:
  This function takes an action ('GET' or 'SET') and additional parameters to either
  calculate the wind direction and strength from a 2D wind position vector ('GET')
  or set the wind direction and speed, returning a 2D wind position vector ('SET').
  
  Input:
  - _this: An array containing the action and required parameters
    * For 'GET': ["GET", _QS_windPos]
    * For 'SET': ["SET", _QS_windDir, _QS_windSpeed]

  Output:
  - An array containing the calculated wind information
    * For 'GET': [_QS_windDir, _QS_windStr]
    * For 'SET': [_QS_windX, _QS_windY]
*/

params ['_QS_getSet'];
private _QS_wind = [0,0];
if (_QS_getSet isEqualTo 'GET') then {
	params ['','_QS_windPos'];
	_QS_windPos params ['_QS_windPosX','_QS_windPosY'];
	_QS_windDir = _QS_windPosX atan2 _QS_windPosY;
	if (_QS_windDir < 0) then {
		_QS_windDir = _QS_windDir + 360;
	};	
	_QS_windDir = _QS_windDir % 360;
	_QS_windStr = vectorMagnitude [_QS_windPosX,_QS_windPosY,0];
	_QS_wind = [_QS_windDir,_QS_windStr];
};
if (_QS_getSet isEqualTo 'SET') then {
	params ['','_QS_windDir','_QS_windSpeed'];
	private _QS_windX = (_QS_windSpeed * (sin _QS_windDir));
	private _QS_windY = (_QS_windSpeed * (cos _QS_windDir));
	if (_QS_windDir in [0,180]) then {_QS_windX = 0;};
	if (_QS_windDir in [90,270]) then {_QS_windY = 0;};
	_QS_wind = [_QS_windX,_QS_windY];
};
_QS_wind;