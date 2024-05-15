/*
File: fn_scScoreProgress.sqf
Author: 

	Quiksilver

Last Modified:

	28/05/2017 A3 1.70 by Quiksilver

Description:

	Scoring algo
____________________________________________________________________________*/

params ['_type','_sideNumber','_data'];
private _return = 0;
if (_type isEqualTo 0) then {
	if (_sideNumber isEqualTo 0) then {
		_data params [
			'_playersAO',
			'_scorePlayerCoef',
			'_playerCount'
		];
		_constant = 0.1;
		private _playerFactor = 0;
		private _factorIndex = 0;
		_count = count _playersAO;
		if (_count < 10) then {
			_playerFactor = 0.05;
			_factorIndex = 0;	
		};
		if (_count >= 10) then {
			_playerFactor = 0.07;
			_factorIndex = 1;
		};
		if (_count >= 20) then {
			_playerFactor = 0.09;
			_factorIndex = 2;
		};
		if (_count >= 30) then {
			_playerFactor = 0.11;
			_factorIndex = 3;
		};
		if (_count >= 40) then {
			_playerFactor = 0.13;
			_factorIndex = 4;
		};
		if (_count >= 50) then {
			_playerFactor = 0.15;
			_factorIndex = 5;
		};
		_resultsFactor = (missionNamespace getVariable ['QS_virtualSectors_resultsFactors',[0,0,0,0,0,0]]) # _factorIndex;
		_return = (_constant + _playerFactor + _resultsFactor);
		if !(missionProfileNamespace isNil 'QS_sc_scoreCoef_east_override') then {
			_return = call (missionProfileNamespace getVariable 'QS_sc_scoreCoef_east_override');
		};
		missionNamespace setVariable ['QS_sc_scoreCoef_east',_return,FALSE];
	};
	if (_sideNumber isEqualTo 1) then {
		_data params [
			'_playersAO',
			'_scorePlayerCoef',
			'_playerCount'
		];
		
		/*/ If players are winning by X margin, reduce _constant by some percent /*/
		
		_constant = 1;
		_return = (_constant + (1 - _scorePlayerCoef));
		if !(missionProfileNamespace isNil 'QS_sc_scoreCoef_west_override') then {
			_return = call (missionProfileNamespace getVariable 'QS_sc_scoreCoef_west_override');
		};
		missionNamespace setVariable ['QS_sc_scoreCoef_west',_return,FALSE];
	};
	if (_sideNumber isEqualTo 2) then {};
};
_return;