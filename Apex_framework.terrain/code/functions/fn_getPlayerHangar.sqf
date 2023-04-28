/*/
File: fn_getPlayerHangar.sqf
Author:
	
	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver
	
Description:

	Get list of jets a pilot has access to in hangar
______________________________________________________/*/

params [['_mode',0]];
if (_mode isEqualTo 1) exitWith {
	// Get available loadouts

};
if (_mode isEqualTo 2) exitWith {
	// Get pilot leaderboard coef
};

private _minScore = 10;
private _pool = [];
_missionConfig_CAS = missionNamespace getVariable ['QS_missionConfig_CAS',2];
if (_missionConfig_CAS isEqualTo 0) exitWith {[]};
private _uid = getPlayerUID player;
private _jetsDLC = missionNamespace getVariable ['QS_cas_JetsDLCEnabled',(601670 in (getDLCs 1))];
// Preset pools
if (_missionConfig_CAS isEqualTo 1) exitWith {
	[
		'O_Plane_CAS_02_dynamicLoadout_F',
		'O_Plane_Fighter_02_F',
		'O_Plane_Fighter_02_Stealth_F',
		'B_Plane_Fighter_01_F',
		'B_Plane_Fighter_01_Stealth_F',
		'B_Plane_CAS_01_dynamicLoadout_F',
		'I_Plane_Fighter_03_dynamicLoadout_F',
		'I_Plane_Fighter_04_F'
	]
};
if (_missionConfig_CAS isEqualTo 2) exitWith {
	[
		'O_Plane_CAS_02_dynamicLoadout_F',
		'O_Plane_Fighter_02_F',
		'O_Plane_Fighter_02_Stealth_F',
		'B_Plane_Fighter_01_F',
		'B_Plane_Fighter_01_Stealth_F',
		'B_Plane_CAS_01_dynamicLoadout_F',
		'I_Plane_Fighter_03_dynamicLoadout_F',
		'I_Plane_Fighter_04_F'
	]
};
// Ranked pools
// To Do: Move these to data files
_pool0 = [
	'I_Plane_Fighter_03_dynamicLoadout_F'
];
_pool1 = [
	'O_Plane_CAS_02_dynamicLoadout_F',
	'I_Plane_Fighter_03_dynamicLoadout_F'
];
_pool2 = [
	'O_Plane_CAS_02_dynamicLoadout_F',
	'B_Plane_CAS_01_dynamicLoadout_F',
	'I_Plane_Fighter_03_dynamicLoadout_F'
];
_pool3 = [
	'O_Plane_CAS_02_dynamicLoadout_F',
	'B_Plane_Fighter_01_F',
	'B_Plane_CAS_01_dynamicLoadout_F',
	'I_Plane_Fighter_03_dynamicLoadout_F',
	'I_Plane_Fighter_04_F',
	'i_c_plane_civil_01_f'
];
_pool4 = [
	'O_Plane_CAS_02_dynamicLoadout_F',
	'O_Plane_Fighter_02_F',
	'O_Plane_Fighter_02_Stealth_F',
	'B_Plane_Fighter_01_F',
	'B_Plane_Fighter_01_Stealth_F',
	'B_Plane_CAS_01_dynamicLoadout_F',
	'I_Plane_Fighter_03_dynamicLoadout_F',
	'I_Plane_Fighter_04_F',
	'i_c_plane_civil_01_f'
];
private _coef = [_minScore] call QS_fnc_getPilotLeaderboardCoef;
_pool = _pool1;
if (_coef isEqualTo 0) then {
	_pool = _pool0;
};
if (_coef >= 0.5) then {
	_pool = _pool2;
};
if (_coef >= 0.75) then {
	_pool = _pool3;
};
if (_coef >= 0.9) then {
	_pool = _pool4;
};
_pool;