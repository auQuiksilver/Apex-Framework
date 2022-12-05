/*
File: fn_leaderboardAddToWhitelist.sqf
Author:

	Quiksilver
	
Last Modified:

	5/12/2022 A3 2.10 by Quiksilver
	
Description:

	Add top of leaderboard to respective whitelists
____________________________________________________________*/

private _leaderboardData = _this toArray FALSE;
private _topX = 3;
private _leaderboardDataPilot = _leaderboardData apply {
	[
		(_x # 1) # 1,							// LB value for Transport Pilot leaderboard
		(_x # 0),								// UID
		(_x # 1) # 0							// Name
	]
};
_leaderboardDataPilot sort FALSE;
_leaderboardDataPilot = _leaderboardDataPilot select {(_x # 0) > 0};
_leaderboardDataPilot = _leaderboardDataPilot select [0,_topX];
private _allArray = [];
private _array = [];
if (_leaderboardDataPilot isNotEqualTo []) then {
	{
		diag_log format ['***** LEADERBOARD ***** Adding %1 (%2) to Transport Pilot whitelist *****',(_x # 2),(_x # 1)];
		_array pushBack (_x # 1);
		_allArray pushBack (_x # 1);
	} forEach _leaderboardDataPilot;
	missionProfileNamespace setVariable ['QS_whitelist_lb_helipilot',_array];
};
private _leaderboardDataMedic = _leaderboardData apply {
	[
		(_x # 1) # 2,							// LB value for Medic leaderboard
		(_x # 0),								// UID
		(_x # 1) # 0							// Name
	]
};
_leaderboardDataMedic sort FALSE;
_leaderboardDataMedic = _leaderboardDataMedic select {(_x # 0) > 0};
_leaderboardDataMedic = _leaderboardDataMedic select [0,_topX];
_array = [];
if (_leaderboardDataMedic isNotEqualTo []) then {
	{
		diag_log format ['***** LEADERBOARD ***** Adding %1 (%2) to Medic whitelist *****',(_x # 2),(_x # 1)];
		_array pushBack (_x # 1);
		_allArray pushBack (_x # 1);
	} forEach _leaderboardDataMedic;
	missionProfileNamespace setVariable ['QS_whitelist_lb_cls',_array];
};
private _divisor = 0;
private _leaderboardDataSniper = _leaderboardData apply {
	_divisor = (((_x # 1) # 8) # 1) max 1;
	[
		(((_x # 1) # 8) # 0) / _divisor,										// LB value for Sniper leaderboard
		(_x # 0),																// UID
		(_x # 1) # 0,															// Name
		_divisor																// Shots taken
	]
};
_leaderboardDataSniper sort FALSE;
_leaderboardDataSniper = _leaderboardDataSniper select {(_x # 3) >= 50};		// Require >= 50 shots to qualify
_leaderboardDataSniper = _leaderboardDataSniper select [0,_topX];
_array = [];
if (_leaderboardDataSniper isNotEqualTo []) then {
	{
		diag_log format ['***** LEADERBOARD ***** Adding %1 (%2) to Sniper whitelist *****',(_x # 2),(_x # 1)];
		_array pushBack (_x # 1);
		_allArray pushBack (_x # 1);
	} forEach _leaderboardDataSniper;
	missionProfileNamespace setVariable ['QS_whitelist_lb_sniper',_array];
};
missionProfileNamespace setVariable ['QS_whitelists_toInform',_allArray];
saveMissionProfileNamespace;
TRUE;