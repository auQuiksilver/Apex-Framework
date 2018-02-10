if (!isDedicated) exitWith {};
_whitelist = compileFinal preprocessFileLineNumbers '@Apex_cfg\whitelist.sqf';
missionNamespace setVariable ['QS_fnc_whitelist',_whitelist,TRUE];
call (compile (preprocessFileLineNumbers '@Apex_cfg\parameters.sqf'));
0 spawn (missionNamespace getVariable 'QS_fnc_config');