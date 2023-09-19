/*/
File: QS_data_rainParams.sqf
Author:

	Quiksilver
	
Last modified:

	22/05/2023 A3 2.12 by Quiksilver
	
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
		'a3\data_f\snowflake4_ca.paa', 		// rainDropTexture			'a3\data_f\snowflake4_ca.paa'   'a3\data_f\snowflake8_ca.paa'    'a3\data_f\snowflake16_ca.paa'
		4, 									// texDropCount
		0.01, 								// minRainDensity
		25, 								// effectRadius
		0.05, 								// windCoef
		2.5, 								// dropSpeed
		0.5, 								// rndSpeed
		0.5, 								// rndDir
		0.07, 								// dropWidth
		0.07, 								// dropHeight
		[1,1,1,0.5], 						// dropColor
		0.0, 								// lumSunFront
		0.2, 								// lumSunBack
		0.5, 								// refractCoef
		0.5, 								// refractSaturation
		TRUE, 								// snow
		FALSE 								// dropColorStrong
	]
};
// Default (Snow)
[
	'a3\data_f\snowflake4_ca.paa', 		// rainDropTexture
	4, 									// texDropCount
	0.01, 								// minRainDensity
	25, 								// effectRadius
	0.05, 								// windCoef
	2.5, 								// dropSpeed
	0.5, 								// rndSpeed
	0.5, 								// rndDir
	0.07, 								// dropWidth
	0.07, 								// dropHeight
	[1,1,1,0.5], 						// dropColor
	0.0, 								// lumSunFront
	0.2, 								// lumSunBack
	0.5, 								// refractCoef
	0.5, 								// refractSaturation
	TRUE, 								// snow
	FALSE 								// dropColorStrong
]