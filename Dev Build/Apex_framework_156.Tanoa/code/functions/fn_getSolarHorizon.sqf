/*
File: fn_getSolarHorizon.sqf
Author:

	rübe (tweaked by Quiksilver)
	
Last modified:

	2/06/2015 ArmA 3 1.44 by Quiksilver
	
Description:

	- Return solar horizon times for a given date
__________________________________________________________________________*/

private [
	'_year','_month','_day','_zenith','_latitude','_longitude','_n1','_n2','_n3','_n','_lngHour','_times',
	'_t','_m','_l','_ra','_lQuadrant','_raQuadrant','_sinDec','_cosDec','_cosH','_h','_ut','_local','_localH',
	'_returnType','_sunrise','_sunset','_sunriseInDaytime','_sunsetInDaytime'
];

_date = _this # 0;
_year = _date # 0;
_month = _date # 1;
_day = _date # 2;
_returnType = 0;
if ((count _this) > 1) then {_returnType = _this # 1;};

_zenith = 90; 
_latitude = getNumber (configFile >> 'CfgWorlds' >> worldName >> 'latitude') * -1;
_longitude = getNumber (configFile >> 'CfgWorlds' >> worldName >> 'longitude');
_n1 = floor (275 * _month / 9);
_n2 = floor ((_month + 9) / 12);
_n3 = 1 + floor ((_year - (4 * (floor (_year / 4))) + 2) / 3);
_n = _n1 - (_n2 * _n3) + _day - 30;
_lngHour = _longitude / 15;
_times = [];
{
   if (_x) then {
      _t = (_n + ((6 - _lngHour) / 24));
   } else {
      _t = (_n + ((18 - _lngHour) / 24));
   };
   _m = (0.9856 * _t) - 3.289;
   _l = _m + (1.916 * (sin _m)) + (0.020 * (sin (2 * _m))) + 282.634;
   while {(_l < 0)} do {
		_l = _l + 360; 
	};
   _l = _l % 360;
   _ra = atan (0.91764 * (tan _l));
   while {(_ra < 0)} do {
		_ra = _ra + 360; 
	};
   _ra = _ra % 360;
   _lQuadrant = (floor (_l / 90)) * 90;
   _raQuadrant = (floor (_ra / 90)) * 90;
   _ra = _ra + (_lQuadrant - _raQuadrant);
   _ra = _ra / 15;
   _sinDec = 0.39782 * (sin _l);
   _cosDec = cos (asin _sinDec);
   _cosH = ((cos _zenith) - (_sinDec * (sin _latitude))) / (_cosDec * (cos _latitude));
   if (_x) then {
      _h = 360 - (acos _cosH);
   } else {
      _h = acos _cosH;
   };
   _h = _h / 15;
   _t = _h + _ra - (0.06571 * _t) - 6.622;
   _ut = _t - _lngHour;
   while {(_ut < 0)} do {
		_ut = _ut + 24; 
	};
   _ut = _ut % 24;
   _local = _ut + (floor (_longitude / 15));
   _localH = floor _local;
   0 = _times pushBack [_localH,(floor ((_local - _localH) * 60))];
} forEach [
   TRUE,
   FALSE
];

if (_returnType isEqualTo 0) exitWith {
	_times;
};
if (_returnType isEqualTo 1) exitWith {
	_sunrise = _times # 0;
	_sunriseInDaytime = (_sunrise # 0) + ((_sunrise # 1) / 60);
	_sunset = _times # 1;
	_sunsetInDaytime = (_sunset # 0) + ((_sunset # 1) / 60);
	_times = [_sunriseInDaytime,_sunsetInDaytime];
	_times;
};