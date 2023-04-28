/*/
File: fn_getPilotLeaderboardCoef.sqf
Author:

	Quiksilver
	
Last Modified:

	15/04/2023 A3 2.12 by Quiksilver
	
Description:

	Get pilot leaderboard coef
____________________________________________/*/

params [['_unit',objNull],['_minScore',10]];
if (!isPlayer _unit) exitwith {0};
private _uid = getPlayerUID _unit;
private _coef = 0;
private _pilotLeaderboards = QS_leaderboards2 toArray FALSE;
_pilotLeaderboards append (QS_leaderboards3 toArray FALSE);
_pilotLeaderboards = _pilotLeaderboards apply {
	[
		(_x # 1) # 1,
		(_x # 0),
		(_x # 1) # 0
	]
};
_pilotLeaderboards = _pilotLeaderboards select {((_x # 0) >= _minScore)};
_pilotLeaderboards sort FALSE;
_countLeaderboard = count _pilotLeaderboards;
if (_countLeaderboard isEqualTo 0) exitWith {0};
_pilotLeaderboardIndex = (_pilotLeaderboards findIf {((_x # 1) isEqualTo _uid)});
if (_pilotLeaderboardIndex isNotEqualTo -1) exitWith {0};
_pilotTransportRank = _pilotLeaderboardIndex + 1;
_pilotScore = (_pilotLeaderboards # _pilotLeaderboardIndex) # 0;
_coef = 1 - (_pilotTransportRank / _countLeaderboard);
_coef;