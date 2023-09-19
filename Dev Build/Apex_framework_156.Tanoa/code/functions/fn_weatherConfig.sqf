/* 
File: fn_weatherConfig.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/05/2018 A3 1.82 by Quiksilver
	
Description:

	Weather Config
________________________________________________*/

params ['_QS_date','_QS_worldName','_QS_simulation','_QS_type'];
_QS_date params ['_QS_year','_QS_month','_QS_day','_QS_hour'];
private [
	'_QS_array','_QS_weatherData',
	'_QS_monthDays','_QS_overcastDaysMonthly','_QS_dailySunshineHoursMonthly','_QS_solarHorizons','_QS_sunriseTimeToday',
	'_QS_sunsetTimeToday','_QS_willRainToday','_QS_rainChance','_QS_overcastRangeToday_lower','_QS_hoursLeft24hr','_QS_overcastRangesMonthly',
	'_QS_overcastRangeToday_mean','_QS_overcastRangeToday_upper','_QS_overcast','_QS_overcastRangesToday','_QS_overcastRounded','_QS_isOvercast',
	'_QS_randomHour','_QS_sunshineOvercast','_QS_sunshineOvercastRange','_QS_sunshineOvercastRange_lower','_QS_sunshineOvercastRounded',
	'_QS_dailySunshineHours','_QS_windSpeedMonthly','_QS_windSpeedAvg','_QS_windDirVariabilityRange','_QS_windSpeedVariabilityRange',
	'_QS_windSpeedAvgRounded','_QS_windDirAvgMonthly','_QS_nextWindDirRounded','_QS_nextWindDir','_QS_windArray','_QS_nextWindSpeed',
	'_QS_wavesArray','_QS_windSpeed','_QS_newWavesValue','_QS_newWavesChangeTime','_QS_currentWind','_QS_gustsChangeTime','_QS_newGustsValue',
	'_QS_rainbowChangeTime','_QS_newRainbowValue','_QS_currentRain','_QS_lightningsChangeTime','_QS_newLightnings','_QS_currentOvercast',
	'_QS_rainChangeTime','_QS_fogData_monthly','_QS_fogThisMonth','_QS_colderMonths','_QS_warmerMonths','_QS_fogValue','_QS_fogDecay',
	'_QS_fogBase','_QS_fogValueAvg','_QS_fogDecayAvg','_QS_fogBaseAvg','_QS_overcastArray','_QS_hoursOfFog','_QS_overcastAssessmentArray',
	'_QS_todayIsOvercast','_QS_overcastAssessment','_QS_fogChangeTime'
];
_QS_array = [];
_QS_solarHorizons = date call (missionNamespace getVariable 'BIS_fnc_sunriseSunsetTime');
_QS_sunriseTimeToday = _QS_solarHorizons # 0;
_QS_sunsetTimeToday = _QS_solarHorizons # 1;
_QS_hoursLeft24hr = 24 - _QS_hour;
_QS_monthDays = [_QS_year,_QS_month] call (missionNamespace getVariable 'QS_fnc_monthDays');
_QS_weatherData = [] call (missionNamespace getVariable 'QS_RSC_weatherData');
if (_QS_type isEqualTo 'WIND') then {
	_QS_windSpeedMonthly = _QS_weatherData # 5;
	_QS_windSpeedAvg = _QS_windSpeedMonthly # _QS_month;
	_QS_windDirAvgMonthly = 205;
	if (worldName in ['Altis','Stratis','Malden']) then {
		_QS_windDirAvgMonthly = 205;
	};
	if (worldName isEqualTo 'Tanoa') then {
		_QS_windDirAvgMonthly = [0,90,50,70,(random [45,80,130]),120,120,120,120,123,120,100,90] select (date # 1);
	};
	if ((random 1) > 0.25) then {
		_QS_windDirVariabilityRange = 5;
	} else {
		_QS_windDirVariabilityRange = 10;
	};
	if ((random 1) > 0.25) then {
		_QS_windSpeedVariabilityRange = 1.5;
	} else {
		_QS_windSpeedVariabilityRange = 3;
	};
	for '_x' from 0 to (_QS_hoursLeft24hr - 1) step 1 do {
		_QS_nextWindDir = _QS_windDirAvgMonthly + (random _QS_windDirVariabilityRange - (random (2 * _QS_windDirVariabilityRange)));
		_QS_nextWindDirRounded = round (_QS_nextWindDir * (10 ^ 2)) / (10 ^ 2);
		_QS_nextWindSpeed = _QS_windSpeedAvg + (random _QS_windSpeedVariabilityRange - (random (2 * _QS_windSpeedVariabilityRange)));
		_QS_windSpeedAvgRounded = round (_QS_nextWindSpeed * (10 ^ 2)) / (10 ^ 2);
		
		_QS_windArray = ['SET',_QS_nextWindDirRounded,_QS_windSpeedAvgRounded] call (missionNamespace getVariable 'QS_fnc_windCalculation');
		0 = _QS_array pushBack [_QS_windArray # 0,_QS_windArray # 1,TRUE];
		//diag_log str _QS_windArray;
	};
};

if (_QS_type isEqualTo 'OVERCAST') then {
	_QS_isOvercast = FALSE;
	_QS_willRainToday = FALSE;
	_QS_array = [[],_QS_willRainToday];
	_QS_overcastDaysMonthly = _QS_weatherData # 0;
	_QS_dailySunshineHoursMonthly = _QS_weatherData # 1;
	_QS_overcastRangesMonthly = _QS_weatherData # 2;
	_QS_dailySunshineHours = _QS_dailySunshineHoursMonthly # _QS_month;
	_QS_overcastChance = (_QS_overcastRangesMonthly # _QS_month) # 0;
	_QS_rainChance = (_QS_overcastRangesMonthly # _QS_month) # 3;
	if ((random 1) > _QS_overcastChance) then {
		_QS_isOvercast = TRUE;
		_QS_overcastRangesToday = (_QS_overcastRangesMonthly # _QS_month) # 1;
		if ((random 1) > _QS_rainChance) then {
			_QS_willRainToday = TRUE;
			_QS_array set [1,_QS_willRainToday];
		};
	} else {
		_QS_overcastRangesToday = (_QS_overcastRangesMonthly # _QS_month) # 2;
	};
	_QS_overcastRangeToday_lower = _QS_overcastRangesToday # 0;
	_QS_overcastRangeToday_mean = _QS_overcastRangesToday # 1;
	_QS_overcastRangeToday_upper = _QS_overcastRangesToday # 2;
	_QS_overcast = _QS_overcastRangeToday_lower + (random 0.24);
	for '_x' from 0 to (_QS_hoursLeft24hr - 1) step 1 do {
		_QS_overcast = _QS_overcastRangeToday_lower + (random 0.24);
		_QS_overcastRounded = round (_QS_overcast * (10 ^ 2)) / (10 ^ 2);
		0 = (_QS_array # 0) pushBack _QS_overcastRounded;
	};
	if (_QS_isOvercast) then {
		_QS_sunshineOvercastRange = (_QS_overcastRangesMonthly # _QS_month) # 2;
		_QS_sunshineOvercastRange_lower = ((_QS_overcastRangesMonthly # _QS_month) # 2) # 0;
		//diag_log format ['***** DEBUG ***** weather config * Overcast ***** Sunshine hours: %1 *****',_QS_dailySunshineHours];
		if ((count (_QS_array # 0)) > 6) then {
			if ((count (_QS_array # 0)) > 12) then {
				for '_x' from 0 to (_QS_dailySunshineHours * 2) step 1 do {
					_QS_randomHour = selectRandom (_QS_array # 0);
					_QS_sunshineOvercast = _QS_sunshineOvercastRange_lower + (random 0.24);
					_QS_sunshineOvercastRounded = round (_QS_sunshineOvercast * (10 ^ 2)) / (10 ^ 2);
					(_QS_array # 0) set [_QS_randomHour,_QS_sunshineOvercastRounded];
				};
			} else {
				for '_x' from 0 to _QS_dailySunshineHours step 1 do {
					_QS_randomHour = selectRandom (_QS_array # 0);
					_QS_sunshineOvercast = _QS_sunshineOvercastRange_lower + (random 0.24);
					_QS_sunshineOvercastRounded = round (_QS_sunshineOvercast * (10 ^ 2)) / (10 ^ 2);
					(_QS_array # 0) set [_QS_randomHour,_QS_sunshineOvercastRounded];
				};			
			};
		};
	};
	//diag_log format ['***** DEBUG ***** weather config * Overcast ***** %1 ***** %2 *****',count _QS_array,_QS_array];
};

if (_QS_type isEqualTo 'RAIN') then {
	_QS_rainChangeTime = _this # 4;
	_QS_currentOvercast = _this # 5;
	if (worldName isEqualTo 'Tanoa') then {
		//comment 'Tanoa rain sim';
		if ((random 1) > 0.333) then {
			_QS_array = [30,0];
		} else {
			if (_QS_currentOvercast > 0.55) then {
				if (_QS_currentOvercast > 0.65) then {
					if (_QS_currentOvercast > 0.75) then {
						if (_QS_currentOvercast > 0.85) then {
							if (_QS_currentOvercast > 0.95) then {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.8 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.5)];
								};
							} else {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.6 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.4)];
								};
							};
						} else {
							if ((random 1) > 0.5) then {
								_QS_array = [_QS_rainChangeTime,(0.4 + (random 0.2))];
							} else {
								_QS_array = [_QS_rainChangeTime,(random 0.3)];
							};
						};
					} else {
						if ((random 1) > 0.5) then {
							_QS_array = [_QS_rainChangeTime,(0.2 + (random 0.2))];
						} else {
							_QS_array = [_QS_rainChangeTime,(random 0.2)];
						};
					};
				} else {
					_QS_array = [_QS_rainChangeTime,(random 0.2)];
				};
			} else {
				_QS_array = [30,0];
			};
		};
	} else {
		//comment 'Altis rain sim';
		if (worldName in ['Altis','Malden','Stratis']) then {
			if (_QS_currentOvercast > 0.55) then {
				if (_QS_currentOvercast > 0.65) then {
					if (_QS_currentOvercast > 0.75) then {
						if (_QS_currentOvercast > 0.85) then {
							if (_QS_currentOvercast > 0.95) then {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.8 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.5)];
								};
							} else {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.6 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.4)];
								};
							};
						} else {
							if ((random 1) > 0.5) then {
								_QS_array = [_QS_rainChangeTime,(0.4 + (random 0.2))];
							} else {
								_QS_array = [_QS_rainChangeTime,(random 0.3)];
							};
						};
					} else {
						if ((random 1) > 0.5) then {
							_QS_array = [_QS_rainChangeTime,(0.2 + (random 0.2))];
						} else {
							_QS_array = [_QS_rainChangeTime,(random 0.2)];
						};
					};
				} else {
					_QS_array = [_QS_rainChangeTime,(random 0.2)];
				};
			} else {
				_QS_array = [30,0];
			};
		} else {
			// Custom terrains
			if (_QS_currentOvercast > 0.55) then {
				if (_QS_currentOvercast > 0.65) then {
					if (_QS_currentOvercast > 0.75) then {
						if (_QS_currentOvercast > 0.85) then {
							if (_QS_currentOvercast > 0.95) then {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.8 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.5)];
								};
							} else {
								if ((random 1) > 0.5) then {
									_QS_array = [_QS_rainChangeTime,(0.6 + (random 0.2))];
								} else {
									_QS_array = [_QS_rainChangeTime,(random 0.4)];
								};
							};
						} else {
							if ((random 1) > 0.5) then {
								_QS_array = [_QS_rainChangeTime,(0.4 + (random 0.2))];
							} else {
								_QS_array = [_QS_rainChangeTime,(random 0.3)];
							};
						};
					} else {
						if ((random 1) > 0.5) then {
							_QS_array = [_QS_rainChangeTime,(0.2 + (random 0.2))];
						} else {
							_QS_array = [_QS_rainChangeTime,(random 0.2)];
						};
					};
				} else {
					_QS_array = [_QS_rainChangeTime,(random 0.2)];
				};
			} else {
				_QS_array = [30,0];
			};		
		};
	};
	//diag_log format ['***** DEBUG ***** weather config ***** Next rain array: ***** %1*****',_QS_array];
};

if (_QS_type isEqualTo 'FOG') then {
	_QS_overcastArray = _this # 4;
	_QS_fogData_monthly = _QS_weatherData # 7;
	_QS_fogThisMonth = _QS_fogData_monthly # _QS_month;
	_QS_colderMonths = [1,2,3,10,11,12];
	_QS_warmerMonths = [4,5,6,7,8,9];
	_QS_fogValueAvg = _QS_fogThisMonth # 0;
	_QS_fogDecayAvg = _QS_fogThisMonth # 1;
	_QS_fogBaseAvg = _QS_fogThisMonth # 2;
	_QS_fogValue = 0;
	_QS_fogDecay = 0;
	_QS_fogBase = 0;
	_QS_hoursOfFog = 0;
	_QS_overcastAssessment = 0;
	_QS_overcastAssessmentArray = [];
	_QS_todayIsOvercast = FALSE;
	_QS_fogChangeTime = 600;
	{
		if (_x > 0.5) then {
			0 = _QS_overcastAssessmentArray pushBack TRUE;
		} else {
			0 = _QS_overcastAssessmentArray pushBack FALSE;
		};
	} count _QS_overcastArray;
	{
		if (_x) then {
			_QS_overcastAssessment = _QS_overcastAssessment + 1;
		};
	} count _QS_overcastAssessmentArray;
	if (_QS_overcastAssessment > 12) then {
		_QS_todayIsOvercast = TRUE;
	} else {
		_QS_todayIsOvercast = FALSE;
	};
	
	if (_QS_todayIsOvercast) then {
		_QS_hoursOfFog = _QS_sunriseTimeToday + (4.5 + ((random 1) - (random 2)));
	} else {
		_QS_hoursOfFog = _QS_sunriseTimeToday + (2.5 + ((random 1) - (random 2)));
	};

	for '_x' from 1 to _QS_hoursOfFog step 1 do {
		if (_QS_month in _QS_colderMonths) then {
			/*/_QS_fogValue = _QS_fogValueAvg + ((random 0.2) - (random 0.3));/*/
			_QS_fogValue = _QS_fogValueAvg;
			/*/_QS_fogDecay = _QS_fogDecayAvg + ((random 0.2) - (random 0.4));/*/
			_QS_fogDecay = _QS_fogDecayAvg;
			if (_QS_fogDecay < 0) then {
				for '_x' from 0 to 1 step 0 do {
					/*/_QS_fogDecay = _QS_fogDecayAvg + ((random 0.2) - (random 0.4));/*/
					_QS_fogDecay = _QS_fogDecayAvg;
					if (_QS_fogDecay >= 0) exitWith {};
				};
			};
			/*/_QS_fogBase = _QS_fogBaseAvg + ((random 10) - (random 20));/*/
			_QS_fogBase = _QS_fogBaseAvg;
		} else {
			if (_QS_month in _QS_warmerMonths) then {
				/*/_QS_fogValue = _QS_fogValueAvg + ((random 0.2) - (random 0.3));/*/
				_QS_fogValue = _QS_fogValueAvg;
				/*/_QS_fogDecay = _QS_fogDecayAvg + ((random 0.025) - (random 0.04));/*/
				_QS_fogDecay = _QS_fogDecayAvg;
				if (_QS_fogDecay < 0) then {
					for '_x' from 0 to 1 step 0 do {
						/*/_QS_fogDecay = _QS_fogDecayAvg + ((random 0.025) - (random 0.04));/*/
						_QS_fogDecay = _QS_fogDecayAvg;
						if (_QS_fogDecay >= 0) exitWith {};
					};
				};
				/*/_QS_fogBase = _QS_fogBaseAvg + ((random 1) - (random 2));/*/
				_QS_fogBase = _QS_fogBaseAvg;
			};
		};
		0 = _QS_array pushBack [_QS_fogChangeTime,_QS_fogValue,_QS_fogDecay,_QS_fogBase];
	};
	//diag_log format ['***** DEBUG ***** WEATHER CONFIG ***** FOG ***** %1 *****',_QS_array];
};

if (_QS_type isEqualTo 'WAVES') then {
	_QS_currentWind = _this # 4;
	_QS_wavesArray = ['GET',_QS_currentWind] call (missionNamespace getVariable 'QS_fnc_windCalculation');
	_QS_newWavesValue = 0;
	_QS_newWavesChangeTime = 30;
	_QS_windSpeed = _QS_wavesArray # 1;
	if (_QS_windSpeed > 1) then {
		if (_QS_windSpeed > 2) then {
			if (_QS_windSpeed > 3) then {
				if (_QS_windSpeed > 4) then {
					if (_QS_windSpeed > 5) then {
						if (_QS_windSpeed > 6) then {
							if (_QS_windSpeed > 7) then {
								if (_QS_windSpeed > 8) then {
									if (_QS_windSpeed > 9) then {
										if (_QS_windSpeed > 10) then {
											_QS_newWavesValue = 1;
										} else {
											_QS_newWavesValue = 0.9;
										};
									} else {
										_QS_newWavesValue = 0.8;
									};
								} else {
									_QS_newWavesValue = 0.7;
								};
							} else {
								_QS_newWavesValue = 0.6;
							};
						} else {
							_QS_newWavesValue = 0.5;
						};
					} else {
						_QS_newWavesValue = 0.4;
					};
				} else {
					_QS_newWavesValue = 0.3;
				};
			} else {
				_QS_newWavesValue = 0.2;
			};
		} else {
			_QS_newWavesValue = 0.1;
		};
	} else {
		_QS_newWavesValue = 0;
	};
	_QS_array = [_QS_newWavesChangeTime,_QS_newWavesValue];
};
if (_QS_type isEqualTo 'LIGHTNINGS') then {
	_QS_currentOvercast = _this # 4;
	_QS_lightningsChangeTime = 60;
	if (_QS_currentOvercast > 0.5) then {
		if (_QS_currentOvercast > 0.6) then {
			if (_QS_currentOvercast > 0.7) then {
				if (_QS_currentOvercast > 0.8) then {
					if ((random 1) > 0.5) then {
						_QS_newLightnings = 0.6;
					} else {
						_QS_newLightnings = 0.75;
					};
				} else {
					if ((random 1) > 0.5) then {
						_QS_newLightnings = 0.5;
					} else {
						_QS_newLightnings = 0.6;
					};
				};
			} else {
				if ((random 1) > 0.5) then {
					_QS_newLightnings = 0.4;
				} else {
					_QS_newLightnings = 0.5;
				};
			};
		} else {
			if ((random 1) > 0.5) then {
				_QS_newLightnings = 0.3;
			} else {
				_QS_newLightnings = 0.4;
			};
		};
	} else {
		_QS_newLightnings = 0;
	};
	_QS_array = [_QS_lightningsChangeTime,_QS_newLightnings];
};
if (_QS_type isEqualTo 'RAINBOW') then {
	_QS_currentRain = _this # 4;
	_QS_rainbowChangeTime = 60;
	_QS_newRainbowValue = 0;
	if (_QS_currentRain > 0.1) then {
		if (_QS_currentRain > 0.2) then {
			if (_QS_currentRain > 0.3) then {
				if (_QS_currentRain > 0.4) then {
					if (_QS_currentRain > 0.5) then {
						if (_QS_currentRain > 0.6) then {
							if (_QS_currentRain > 0.7) then {
								if (_QS_currentRain > 0.8) then {
									if (_QS_currentRain > 0.9) then {
										_QS_newRainbowValue = 1;
									} else {
										_QS_newRainbowValue = 0.9;
									};
								} else {
									_QS_newRainbowValue = 0.8;
								};
							} else {
								_QS_newRainbowValue = 0.7;
							};
						} else {
							_QS_newRainbowValue = 0.6;
						};
					} else {
						_QS_newRainbowValue = 0.5;
					};
				} else {
					_QS_newRainbowValue = 0.4;
				};
			} else {
				_QS_newRainbowValue = 0.3;
			};
		} else {
			_QS_newRainbowValue = 0.2;
		};
	} else {
		_QS_newRainbowValue = 0;
	};
	_QS_array = [_QS_rainbowChangeTime,_QS_newRainbowValue];
};
if (_QS_type isEqualTo 'GUSTS') then {
	_QS_currentWind = _this # 4;
	_QS_windArray = ['GET',_QS_currentWind] call (missionNamespace getVariable 'QS_fnc_windCalculation');
	_QS_windSpeed = _QS_windArray # 1;
	_QS_gustsChangeTime = 30;
	if (_QS_windSpeed > 1) then {
		if (_QS_windSpeed > 2) then {
			if (_QS_windSpeed > 3) then {
				if (_QS_windSpeed > 4) then {
					if (_QS_windSpeed > 5) then {
						if (_QS_windSpeed > 6) then {
							if (_QS_windSpeed > 7) then {
								if (_QS_windSpeed > 8) then {
									if (_QS_windSpeed > 9) then {
										_QS_newGustsValue = 0.9 + ((random 0.1) - (random 0.2));
									} else {
										_QS_newGustsValue = 0.8 + ((random 0.1) - (random 0.2));
									};
								} else {
									_QS_newGustsValue = 0.7 + ((random 0.1) - (random 0.2));
								};
							} else {
								_QS_newGustsValue = 0.6 + ((random 0.1) - (random 0.2));
							};
						} else {
							_QS_newGustsValue = 0.5 + ((random 0.1) - (random 0.2));
						};
					} else {
						_QS_newGustsValue = 0.4 + ((random 0.1) - (random 0.2));
					};
				} else {
					_QS_newGustsValue = 0.3 + ((random 0.1) - (random 0.2));
				};
			} else {
				_QS_newGustsValue = 0.2 + ((random 0.1) - (random 0.2));
			};
		} else {
			_QS_newGustsValue = 0.1 + ((random 0.1) - (random 0.2));
		};
	} else {
		_QS_newGustsValue = 0;
	};
	_QS_array = [_QS_gustsChangeTime,_QS_newGustsValue];
};
_QS_array;