/*/
File: QS_data_rainParams.sqf
Author:

	Quiksilver
	
Last modified:

	26/12/2022 A3 2.10 by Quiksilver
	
Description:

	Custom Rain Params
	
Notes:

	To apply these, in your parameters file, set _weatherForced >= 4
	Add more modes with custom rain as you like
________________________________________________________/*/

params [['_mode',4]];

if (_mode isEqualTo 4) exitWith {
	// Snow - Basic
	[
		'a3\data_f\rainnormal_ca.paa',				// rainDropTexture
		1,											// texDropCount
		0.01,										// minRainDensity
		15,											// effectRadius
		0.1,										// windCoef
		2,											// dropSpeed
		0.5,										// rndSpeed
		0.5,										// rndDir
		0.02,										// dropWidth
		0.02,										// dropHeight
		[0.1, 0.1, 0.1, 1],							// dropColor
		0.1,										// lumSunFront
		0.1,										// lumSunBack
		5.5,										// refractCoef
		0.3,										// refractSaturation
		TRUE,										// snow
		FALSE										// dropColorStrong
	]
};
// Default (Snow)
[
	'a3\data_f\rainnormal_ca.paa',				// rainDropTexture
	1,											// texDropCount
	0.01,										// minRainDensity
	15,											// effectRadius
	0.1,										// windCoef
	2,											// dropSpeed
	0.5,										// rndSpeed
	0.5,										// rndDir
	0.02,										// dropWidth
	0.02,										// dropHeight
	[0.1, 0.1, 0.1, 1],							// dropColor
	0.1,										// lumSunFront
	0.1,										// lumSunBack
	5.5,										// refractCoef
	0.3,										// refractSaturation
	TRUE,										// snow
	FALSE										// dropColorStrong
]
