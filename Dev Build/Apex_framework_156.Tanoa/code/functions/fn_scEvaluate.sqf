/*
File: fn_scEvaluate.sqf
Author: 

	Quiksilver

Last Modified:

	15/04/2017 A3 1.68 by Quiksilver

Description:

	Evaluate Completion State
	
	['QS_virtualSectors_scoreSides',[0,0,0,0,0],TRUE]
____________________________________________________________________________*/

params ['_type'];
if (_type isEqualTo 1) exitWith {
	private _return = TRUE;
	comment 'If all are owned by WEST';
	{
		if ((_x # 10) isNotEqualTo [WEST]) then {
			_return = FALSE;
		};
	} count (missionNamespace getVariable 'QS_virtualSectors_data');
	_return;
};
if (_type isEqualTo 2) exitWith {
	private _return = -1;
	comment 'If winning score achieved';
	_scoreWin = missionNamespace getVariable ['QS_virtualSectors_scoreWin',300];
	{
		if (_x >= _scoreWin) exitWith {
			_return = _forEachIndex;
		};
	} forEach (missionNamespace getVariable 'QS_virtualSectors_scoreSides');
	_return;
};
FALSE;