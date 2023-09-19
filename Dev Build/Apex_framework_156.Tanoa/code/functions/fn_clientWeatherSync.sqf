/*
File: fn_clientWeatherSync.sqf
Author:

	Quiksilver
	
Last Modified: 

	26/12/2022 A3 2.10 by Quiksilver
	
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
	['_QS_rainbow',[FALSE,0,0]],
	['_QS_humidity',[FALSE,0]]
];
if (_QS_wind # 0) then {
	setWind (_QS_wind # 1);
};
if (_QS_gusts # 0) then {
	(_QS_gusts # 1) setGusts (_QS_gusts # 2);
};
if (_QS_windDir # 0) then {
	(_QS_windDir # 1) setWindDir (_QS_windDir # 2);
};
if (_QS_windStr # 0) then {
	(_QS_windStr # 1) setWindStr (_QS_windStr # 2);
};
if (_QS_windForce # 0) then {
	(_QS_windForce # 1) setWindForce (_QS_windForce # 2);
};
if (_QS_overcast # 0) then {
	(_QS_overcast # 1) setOvercast (_QS_overcast # 2);
};
if (_QS_rain # 0) then {
	if (
		(!(missionNamespace getVariable ['QS_missionConfig_weatherDynamic',TRUE])) &&
		{((missionNamespace getVariable ['QS_missionConfig_weatherForced',0]) >= 4)}
	) then {
		setRain ((missionNamespace getVariable ['QS_missionConfig_weatherForced',4]) call (missionNamespace getVariable 'QS_data_rainParams'));
	} else {
		(_QS_rain # 1) setRain (_QS_rain # 2);
	};
};
if (_QS_fog # 0) then {
	(_QS_fog # 1) setFog (_QS_fog # 2);
};
if (_QS_waves # 0) then {
	(_QS_waves # 1) setWaves (_QS_waves # 2);
};
if (_QS_lightnings # 0) then {
	(_QS_lightnings # 1) setLightnings (_QS_lightnings # 2);
};
if (_QS_rainbow # 0) then {
	(_QS_rainbow # 1) setRainbow (_QS_rainbow # 2);
};
if (_QS_humidity # 0) then {
	setHumidity (_QS_humidity # 1);
};