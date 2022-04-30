/*
File: fn_clientWeatherSync.sqf
Author:

	Quiksilver
	
Last Modified: 

	23/05/2018 A3 1.82 by Quiksilver
	
Description:

	Synchronize Client Weather with server weather
_______________________________________________________*/

params ['','_QS_array'];
_QS_array params [
	['_QS_wind',[FALSE,[0,0,TRUE]]],
	['_QS_gusts',[FALSE,0,0]],
	['_QS_windDir',[FALSE,0,0]],
	['_QS_windStr',[FALSE,0,0]],
	['_QS_windForce',[FALSE,0,0]],
	['_QS_overcast',[FALSE,0,0]],
	['_QS_rain',[FALSE,0,0]],
	['_QS_fog',[FALSE,0,0]],
	['_QS_waves',[FALSE,0,0]],
	['_QS_lightnings',[FALSE,0,0]],
	['_QS_rainbow',[FALSE,0,0]]
];
if (_QS_wind select 0) then {
	setWind (_QS_wind select 1);
};
if (_QS_gusts select 0) then {
	(_QS_gusts select 1) setGusts (_QS_gusts select 2);
};
if (_QS_windDir select 0) then {
	(_QS_windDir select 1) setWindDir (_QS_windDir select 2);
};
if (_QS_windStr select 0) then {
	(_QS_windStr select 1) setWindStr (_QS_windStr select 2);
};
if (_QS_windForce select 0) then {
	(_QS_windForce select 1) setWindForce (_QS_windForce select 2);
};
if (_QS_overcast select 0) then {
	(_QS_overcast select 1) setOvercast (_QS_overcast select 2);
};
if (_QS_rain select 0) then {
	(_QS_rain select 1) setRain (_QS_rain select 2);
};
if (_QS_fog select 0) then {
	(_QS_fog select 1) setFog (_QS_fog select 2);
};
if (_QS_waves select 0) then {
	(_QS_waves select 1) setWaves (_QS_waves select 2);
};
if (_QS_lightnings select 0) then {
	(_QS_lightnings select 1) setLightnings (_QS_lightnings select 2);
};
if (_QS_rainbow select 0) then {
	(_QS_rainbow select 1) setRainbow (_QS_rainbow select 2);
};