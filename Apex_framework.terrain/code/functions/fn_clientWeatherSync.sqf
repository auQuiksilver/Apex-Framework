/*
File: fn_clientWeatherSync.sqf
Author:

	Quiksilver
	
Last Modified: 

	24/08/2016 A3 1.62 by Quiksilver
	
Description:

	Synchronize Client Weather with server
_______________________________________________________*/

private [
	'_QS_array','_QS_wind','_QS_windDir','_QS_windStr','_QS_windForce','_QS_gusts','_QS_overcast','_QS_rain','_QS_fog','_QS_waves','_QS_lightnings','_QS_rainbow',
	'_QS_syncOvercast','_QS_syncWind','_QS_syncRain','_QS_syncFog','_QS_syncWaves','_QS_syncGusts','_QS_simulWeatherSync','_QS_forceWeatherChange','_QS_syncRainbow',
	'_QS_syncLightnings','_QS_windValue','_QS_windGustsTime','_QS_windGustsValue','_QS_syncWindDir','_QS_windDirTime','_QS_windDirValue','_QS_syncWindStr',
	'_QS_windStrTime','_QS_windStrValue','_QS_syncWindForce','_QS_windForceTime','_QS_windForceValue','_QS_overcastTime','_QS_overcastValue',
	'_QS_rainTime','_QS_rainValue','_QS_fogTime','_QS_fogParams','_QS_wavesTime','_QS_wavesValue','_QS_lightningsTime','_QS_lightningsValue',
	'_QS_rainbowTime','_QS_rainbowValue'
];
_QS_array = _this select 1;
_QS_array params [
	'_QS_wind',
	'_QS_gusts',
	'_QS_windDir',
	'_QS_windStr',
	'_QS_windForce',
	'_QS_overcast',
	'_QS_rain',
	'_QS_fog',
	'_QS_waves',
	'_QS_lightnings',
	'_QS_rainbow'
];
_QS_syncWind = _QS_wind select 0;
if (_QS_syncWind) then {
	_QS_windValue = _QS_wind select 1;
	setWind _QS_windValue;
};
_QS_syncGusts = _QS_gusts select 0;
if (_QS_syncGusts) then {
	_QS_windGustsTime = _QS_gusts select 1;
	_QS_windGustsValue = _QS_gusts select 2;
	_QS_windGustsTime setGusts _QS_windGustsValue;
};
_QS_syncWindDir = _QS_windDir select 0;
if (_QS_syncWindDir) then {
	_QS_windDirTime = _QS_windDir select 1;
	_QS_windDirValue = _QS_windDir select 2;
	_QS_windDirTime setWindDir _QS_windDirValue;
};
_QS_syncWindStr = _QS_windStr select 0;
if (_QS_syncWindStr) then {
	_QS_windStrTime = _QS_windStr select 1;
	_QS_windStrValue = _QS_windStr select 2;
	_QS_windStrTime setWindStr _QS_windStrValue;
};
_QS_syncWindForce = _QS_windForce select 0;
if (_QS_syncWindForce) then {
	_QS_windForceTime = _QS_windForce select 1;
	_QS_windForceValue = _QS_windForce select 2;
	_QS_windForceTime setWindForce _QS_windForceValue;
};
_QS_syncOvercast = _QS_overcast select 0;
if (_QS_syncOvercast) then {
	_QS_overcastTime = _QS_overcast select 1;
	_QS_overcastValue = _QS_overcast select 2;
	_QS_overcastTime setOvercast _QS_overcastValue;
};
_QS_syncRain = _QS_rain select 0;
if (_QS_syncRain) then {
	_QS_rainTime = _QS_rain select 1;
	_QS_rainValue = _QS_rain select 2;
	_QS_rainTime setRain _QS_rainValue;
};
_QS_syncFog = _QS_fog select 0;
if (_QS_syncFog) then {
	_QS_fogTime = _QS_fog select 1;
	_QS_fogParams = _QS_fog select 2;
	_QS_fogTime setFog _QS_fogParams;
};
_QS_syncWaves = _QS_waves select 0;
if (_QS_syncWaves) then {
	_QS_wavesTime = _QS_waves select 1;
	_QS_wavesValue = _QS_waves select 2;
	_QS_wavesTime setWaves _QS_wavesValue;
};
_QS_syncLightnings = _QS_lightnings select 0;
if (_QS_syncLightnings) then {
	_QS_lightningsTime = _QS_lightnings select 1;
	_QS_lightningsValue = _QS_lightnings select 2;
	_QS_lightningsTime setLightnings _QS_lightningsValue;
};
_QS_syncRainbow = _QS_rainbow select 0;
if (_QS_syncRainbow) then {
	_QS_rainbowTime = _QS_rainbow select 1;
	_QS_rainbowValue = _QS_rainbow select 2;
	_QS_rainbowTime setRainbow _QS_rainbowValue;
};