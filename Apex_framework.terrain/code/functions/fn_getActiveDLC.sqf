/*/
File: fn_getActiveDLC.sqf
Author:

	Quiksilver
	
Last Modified:

	1/12/2022 A3 2.10 by Quiksilver
	
Description:

	Get the currently active DLC
	
	['WS','VN','CSLA','GM']
_______________________________________________/*/

if !(missionNamespace isNil 'QS_system_activeDLC') exitWith {
	(missionNamespace getVariable ['QS_system_activeDLC',''])
};
missionNamespace setVariable ['QS_system_availableDLCs',['WS','VN','CSLA','GM'],TRUE];
if (isClass (configFile >> 'CfgPatches' >> 'data_f_lxWS')) exitWith {
	missionNamespace setVariable ['QS_system_activeDLC','WS',TRUE];
	'WS'
};
if (isClass (configFile >> 'CfgPatches' >> 'vn_data_f')) exitWith {
	missionNamespace setVariable ['QS_system_activeDLC','VN',TRUE];
	'VN'
};
if (isClass (configFile >> 'CfgPatches' >> 'CSLA')) exitWith {
	missionNamespace setVariable ['QS_system_activeDLC','CSLA',TRUE];
	'CSLA'
};
if (isClass (configFile >> 'CfgPatches' >> 'gm_core')) exitWith {
	missionNamespace setVariable ['QS_system_activeDLC','GM',TRUE];
	'GM'
};
missionNamespace setVariable ['QS_system_activeDLC','',TRUE];
''