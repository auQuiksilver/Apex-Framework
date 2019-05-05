/*
File: fn_clientBaseLights.sqf
Author: 

	Quiksilver

Last Modified:

	30/04/2019 A3 1.92 by Quiksilver

Description:

	Base Lights toggle
_____________________________________________*/

private _simulated = TRUE;
if (!(missionNamespace getVariable 'QS_base_lamps')) then {
	_simulated = FALSE;
};
{
	_x switchLight (['off','on'] select _simulated);
	_x enableSimulation	_simulated;
} forEach ((missionNamespace getVariable 'QS_lamps') + (nearestObjects [(markerPos 'QS_marker_base_marker'),['Land_LampDecor_F','Land_LampHalogen_F','Land_LampStreet_F','Land_LampStreet_small_F','Land_LampShabby_F','Land_LampAirport_F','Land_LampHarbour_F'],500,TRUE]));
if (!isDedicated) then {
	if (!(missionNamespace getVariable 'QS_base_lamps')) then {
		_object = missionNamespace getVariable 'QS_torch';
		if (!isNil {_object getVariable 'effects'}) then {
			{
				if ((typeOf _x) isEqualTo '#lightpoint') then {
					_x setLightBrightness 1;
					_x setLightAmbient [1,0.28,0.05];
					_x setLightColor [1,0.28,0.05];
					_x setLightAttenuation [3,4,6,0.0125,5,300];
				};
			} count (_object getVariable ['effects',[]]);
		};
	} else {
		_object = missionNamespace getVariable 'QS_torch';
		if (!isNil {_object getVariable 'effects'}) then {
			{
				if ((typeOf _x) isEqualTo '#lightpoint') then {
					_x setLightBrightness 2.5;
					_x setLightAmbient [1,0.28,0.05];
					_x setLightColor [1,0.28,0.05];
					_x setLightAttenuation [3,4,6,0.0125,5,600];
				};
			} count (_object getVariable ['effects',[]]);
		};
	};
};