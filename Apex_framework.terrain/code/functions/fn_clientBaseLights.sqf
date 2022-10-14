/*
File: fn_clientBaseLights.sqf
Author: 

	Quiksilver

Last Modified:

	30/04/2019 A3 1.92 by Quiksilver

Description:

	Base Lights toggle
_____________________________________________*/

private _simulated = missionNamespace getVariable ['QS_base_lamps',FALSE];
{
	_x switchLight (['off','on'] select _simulated);
	if (isDedicated) then {
		_x enableSimulationGlobal FALSE;
	} else {
		_x enableSimulation FALSE;
	};
} forEach (allMissionObjects 'Lamps_base_F');
if (!isDedicated) then {
	if (!(missionNamespace getVariable ['QS_base_lamps',FALSE])) then {
		// Turn extended effects OFF
		_object = missionNamespace getVariable ['QS_torch',objNull];
		if ((_object getVariable ['effects',[]]) isNotEqualTo []) then {
			{
				if ((typeOf _x) isEqualTo '#lightpoint') then {
					_x setLightBrightness 1;
					_x setLightAmbient [1,0.28,0.05];
					_x setLightColor [1,0.28,0.05];
					_x setLightAttenuation [3,4,6,0.0125,5,300];
				};
			} forEach (_object getVariable ['effects',[]]);
		};
	} else {
		// Turn extended effects ON
		_object = missionNamespace getVariable ['QS_torch',objNull];
		if ((_object getVariable ['effects',[]]) isNotEqualTo []) then {
			{
				if ((typeOf _x) isEqualTo '#lightpoint') then {
					_x setLightBrightness 2.5;
					_x setLightAmbient [1,0.28,0.05];
					_x setLightColor [1,0.28,0.05];
					_x setLightAttenuation [3,4,6,0.0125,5,600];
				};
			} forEach (_object getVariable ['effects',[]]);
		};
	};
};