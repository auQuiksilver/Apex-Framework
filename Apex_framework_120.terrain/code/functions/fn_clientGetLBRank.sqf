/*/
File: fn_clientGetLBRank.sqf
Author: 

	Quiksilver

Last Modified:

	14/04/2017 A3 1.68 by Quiksilver

Description:

	Get leaderboard rank [player,'TRANSPORT'] call QS_fnc_clientGetLBRank;
____________________________________________________________________________/*/

_myUID = getPlayerUID (_this select 0);
_lb = _this select 1;
_leaderboards = ['','TRANSPORT'];
private _rank = 9999;
if (_lb isEqualTo 'TRANSPORT') then {
	_leaderboardDataArray = (missionNamespace getVariable ['QS_leaderboards',[]]) select (_leaderboards find _lb);
	if (!(_leaderboardDataArray isEqualTo [])) then {
		_leaderboardDataArray sort FALSE;
		{
			_x params ['_points','_puid','_pname'];
			if (_puid isEqualTo _myUID) exitWith {
				_rank = _forEachIndex + 1;
			};
		} forEach _leaderboardDataArray;
	};
};
_rank;