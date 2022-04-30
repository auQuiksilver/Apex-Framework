/*
File: fn_leaderboardAddToWhitelist.sqf
Author:

	Quiksilver
	
Last Modified:

	21/02/2016 A3 1.56 by Quiksilver
	
Description:

	Add top of leaderboard to respective whitelists
____________________________________________________________*/

private [
	'_leaderboardData','_leaderboardIndex','_leaderboard','_rankIndex','_leaderboardWLIndexes','_wl_helipilot','_wl_cls','_puid','_pname','_topX'
];
_leaderboardData = _this # 0;
_topX = 3;
_leaderboardIndex = 1;
_leaderboardWLIndexes = [1,2];
profileNamespace setVariable ['QS_whitelist_lb_helipilot',[]];
profileNamespace setVariable ['QS_whitelist_lb_cls',[]];
saveProfileNamespace;
_wl_helipilot = [];
_wl_cls = [];
for '_x' from 0 to ((count _leaderboardData) - 1) step 1 do {
	_leaderboard = _leaderboardData # _leaderboardIndex;
	if (_leaderboardIndex in _leaderboardWLIndexes) then {
		if (_leaderboard isNotEqualTo []) then {
			_leaderboard sort FALSE;
			_rankIndex = 0;
			for '_x' from 0 to (_topX - 1) step 1 do {
				_rankElement = _leaderboard # _rankIndex;
				_puid = _rankElement # 1;
				_pname = _rankElement # 2;
				diag_log format ['***** LEADERBOARD ***** Adding %1 (%2) to whitelist *****',_pname,_puid];
				if (_leaderboardIndex isEqualTo 1) then {
					0 = _wl_helipilot pushBack _puid;
				};
				if (_leaderboardIndex isEqualTo 2) then {
					0 = _wl_cls pushBack _puid;
				};
				_rankIndex = _rankIndex + 1;
			};
		};
	};
	_leaderboardIndex = _leaderboardIndex + 1;
};
profileNamespace setVariable ['QS_whitelist_lb_helipilot',_wl_helipilot];
profileNamespace setVariable ['QS_whitelist_lb_cls',_wl_cls];
saveProfileNamespace;
TRUE;