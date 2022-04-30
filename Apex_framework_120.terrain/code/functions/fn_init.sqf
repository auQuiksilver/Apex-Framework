if (!isDedicated) exitWith {};
missionNamespace setVariable ['QS_fnc_whitelist',(compileScript ['@Apex_cfg\whitelist.sqf',TRUE]),TRUE];
call (compileScript ['@Apex_cfg\parameters.sqf']);
0 spawn (missionNamespace getVariable 'QS_fnc_config');