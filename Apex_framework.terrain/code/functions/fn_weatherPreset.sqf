/*
File: fn_weatherPreset.sqf
Author: 

	Quiksilver

Last Modified:

	26/12/2022 A3 2.10 by Quiksilver

Description:

	Weather Preset when using Forced Weather mode
_____________________________________________*/

params [['_mode',0]];
if (_mode isEqualTo -1) exitWith {};
if (_mode isEqualTo 0) exitWith {
	// Clear Skies
	setWind [0,0,FALSE];
	0 setOvercast 0;
	0 setFog [0,0,0];
	0 setRain 0;
	0 setLightnings 0;
	0 setWindDir 0;
	0 setWindStr 0;
	0 setWindForce 0;
	0 setGusts 0;
	0 setRainbow 0;
	0 setWaves 0;
	setHumidity 0;
	TRUE;
};
if (_mode isEqualTo 1) exitWith {
	// Overcast
	setWind [0,0,FALSE];
	0 setOvercast 0.75;
	0 setFog [0,0,0];
	0 setRain 0;
	0 setLightnings 0;
	0 setWindDir 0;
	0 setWindStr 0;
	0 setWindForce 0;
	0 setGusts 0;
	0 setRainbow 0;
	0 setWaves 0.25;
	setHumidity 0;
	TRUE;
};
if (_mode isEqualTo 2) exitWith {
	// Rain
	setWind [0,0,FALSE];
	0 setOvercast 1;
	0 setFog [0,0,0];
	0 setRain 0.3;
	0 setLightnings 0;
	0 setWindDir 0;
	0 setWindStr 0;
	0 setWindForce 0;
	0 setGusts 0;
	0 setRainbow 1;
	0 setWaves 0.5;
	setHumidity 0.5;
	TRUE;
};
if (_mode isEqualTo 3) exitWith {
	// Storm
	setWind [0,0,FALSE];
	0 setOvercast 1;
	0 setFog [0,0,0];
	0 setRain 0.6;
	0 setLightnings 1;
	0 setWindDir 0;
	0 setWindStr 0;
	0 setWindForce 0;
	0 setGusts 0;
	0 setRainbow 1;
	0 setWaves 1;
	setHumidity 0.6;
	TRUE;
};
if (_mode isEqualTo 4) exitWith {
	// Snow
	setWind [0,0,FALSE];
	0 setOvercast 1;
	0 setFog [0.1,0,0];
	0 setRain 1;
	0 setLightnings 1;
	0 setWindDir 0;
	0 setWindStr 0;
	0 setWindForce 0;
	0 setGusts 0;
	0 setRainbow 0;
	0 setWaves 0;
	setHumidity 0.95;
	TRUE;
};
// Default (Clear Skies)
setWind [0,0,FALSE];
0 setOvercast 0;
0 setFog [0,0,0];
0 setRain 0;
0 setLightnings 0;
0 setWindDir 0;
0 setWindStr 0;
0 setWindForce 0;
0 setGusts 0;
0 setRainbow 0;
0 setWaves 0;
setHumidity 0;
FALSE;