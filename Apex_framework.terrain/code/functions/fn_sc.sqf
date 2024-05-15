/*/
File: fn_sc.sqf
Author: 

	Quiksilver

Last Modified:

	28/05/2017 A3 1.70 by Quiksilver

Description:

	SC
	
	
	['INIT'] call QS_fnc_sc;
____________________________________________________________________________/*/

_type = param [0,'',['']];
if (_type isEqualTo 'MANAGE') exitWith {
	if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
		private _propagate = FALSE;
		if ((missionNamespace getVariable ['QS_virtualSectors_data',[]]) isNotEqualTo []) then {
			private _tickTime = diag_tickTime;
			private _unitsBelowHeight = allUnits unitsBelowHeight 10;
			private _allPlayers = allPlayers;
			private _playersAO = _allPlayers inAreaArray [(missionNamespace getVariable 'QS_virtualSectors_centroid'),((missionNamespace getVariable 'QS_aoSize') * 1.25),((missionNamespace getVariable 'QS_aoSize') * 1.25),0,FALSE];
			private _sectorData = [];
			private _sectorData_public = [];
			private _unitsConverting = [];
			private _unitsConvertingInArea = -1;
			private _unitsInterrupting = [];
			private _unitsInterruptingInArea = -1;
			private _unitsConvertingCoef = -1;
			private _unitsInterruptingCoef = -1;
			private _sidesOwnedByPrior = [];
			private _lifeStates = missionNamespace getVariable 'QS_virtualSectors_validLifestates';
			private _sides = missionNamespace getVariable 'QS_virtualSectors_sides';
			private _sidesFlagsTextures = missionNamespace getVariable 'QS_virtualSectors_sidesFlagsTextures';
			private _markerColors = ['coloropfor','colorwest','colorresistance','colorcivilian','colorunknown'];
			private _playerSide = WEST;
			private _enemySide = EAST;
			private _scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			private _sideIndex = -1;
			private _scoreCoef = 1;
			private _scoreWin = missionNamespace getVariable ['QS_virtualSectors_scoreWin',300];
			private _playerCount = count _allPlayers;
			private _scorePlayerCoef = 1 min (_playerCount / 50);
			{
				_sectorData = _x;
				_sectorData params [
					'_sectorID',
					'_isActive',
					'_nextEvaluationTime',
					'_increment',
					'_minConversionTime',
					'_interruptMultiplier',
					'_areaType',
					'_centerPos',
					'_areaOrRadiusConvert',
					'_areaOrRadiusInterrupt',
					'_sidesOwnedBy',
					'_sidesCanConvert',
					'_sidesCanInterrupt',
					'_conversionValue',
					'_conversionValuePrior',
					'_conversionAlgorithm',
					'_importance',
					'_flagData',
					'_sectorAreaObjects',
					'_locationData',
					'_objectData',
					'_markerData',
					'_taskData',
					'_initFunction',
					'_manageFunction',
					'_exitFunction',
					'_conversionRate',
					'_isBeingInterrupted'
				];
				if (_isActive) then {
					if (_tickTime > _nextEvaluationTime) then {
						_propagate = TRUE;
						_nextEvaluationTime = _tickTime + _increment;
						_unitsConverting = _unitsBelowHeight select {
							(((side _x) in _sidesCanConvert) && ((lifeState _x) in _lifeStates))
						};
						_unitsInterrupting = _unitsBelowHeight select {
							(((side _x) in _sidesCanInterrupt) && ((lifeState _x) in _lifeStates))
						};
						_unitsConvertingInArea = count (_unitsConverting inAreaArray [_centerPos,_areaOrRadiusConvert,_areaOrRadiusConvert,0,FALSE,-1]);
						_unitsInterruptingInArea = count (_unitsInterrupting inAreaArray [_centerPos,_areaOrRadiusInterrupt,_areaOrRadiusInterrupt,0,FALSE,-1]);
						_unitsConvertingCoef = (0 max _unitsConvertingInArea min 10) / ([10,10] select ((_sidesCanConvert # 0) isEqualTo _enemySide));
						_unitsInterruptingCoef = (0 max _unitsInterruptingInArea min 10) / ([10,10] select ((_sidesCanInterrupt # 0) isEqualTo _enemySide));
						_isBeingInterrupted = ((_unitsConvertingInArea isNotEqualTo 0) && (_unitsInterruptingInArea isNotEqualTo 0));
						if (!(_unitsInterruptingCoef > _unitsConvertingCoef)) then {
							//comment 'Half duration to capture already-owned sector';
							_interruptMultiplier = 1;
						};
						_conversionValuePrior = _conversionValue;
						_conversionValue = 0 max (_conversionValuePrior - ((_increment * _interruptMultiplier) * (_unitsConvertingCoef - _unitsInterruptingCoef))) min _minConversionTime;
						_conversionRate = _conversionValue / _minConversionTime;
						_sideIndex = _sides find (_sidesOwnedBy # 0);
						if (_conversionValue isEqualTo 0) then {
							_conversionValuePrior = _conversionValue;
							//comment 'Flip ownership';
							_sidesOwnedByPrior = _sidesOwnedBy;
							_sidesOwnedBy = _sidesCanConvert;
							_sidesCanInterrupt = _sidesCanConvert;
							_sidesCanConvert = _sidesOwnedByPrior;
							_sideIndex = _sides find (_sidesOwnedBy # 0);
							if (!((flagTexture (_flagData # 0)) == (_sidesFlagsTextures # _sideIndex))) then {
								(_flagData # 0) setFlagTexture (_sidesFlagsTextures # _sideIndex);
							};
							{
								if ((side _x) isNotEqualTo (_sidesOwnedBy # 0)) then {
									_x setSide (_sidesOwnedBy # 0);
								};
							} forEach _locationData;
							{
								if ((toLowerANSI (markerColor _x)) isNotEqualTo (_markerColors # _sideIndex)) then {
									_x setMarkerColor (_markerColors # _sideIndex);
								};
							} forEach _markerData;
							if ((_sidesOwnedBy # 0) isEqualTo EAST) then {
								[
									'SC_UPDATE_BAD',
									[
										(_taskData # 1),
										(format ['%2 %1!',(_taskData # 2),localize 'STR_QS_Notif_073'])
									]
								] remoteExec ['QS_fnc_showNotification',-2,FALSE];
								{
									if (!isNull _x) then {
										if ((getPosWorld _x) isNotEqualTo _centerPos) then {
											_x setPosWorld _centerPos;
											_x enableSimulationGlobal TRUE;
										};
									};
								} forEach (_sectorAreaObjects # 0);
								{
									if (!isNull _x) then {
										if ((getPosWorld _x) isNotEqualTo [-1000,-1000,0]) then {
											_x setPosWorld [-1000,-1000,0];
											_x enableSimulationGlobal TRUE;
										};
									};							
								} forEach (_sectorAreaObjects # 1);							
							} else {
								[
									'SC_UPDATE_GOOD',
									[
										(_taskData # 1),
										(format ['%2 %1!',(_taskData # 2),localize 'STR_QS_Notif_074'])
									]
								] remoteExec ['QS_fnc_showNotification',-2,FALSE];
								{
									if ((getPosWorld _x) isNotEqualTo [-1000,-1000,0]) then {
										_x setPosWorld [-1000,-1000,0];
										_x enableSimulationGlobal TRUE;
									};
								} forEach (_sectorAreaObjects # 0);
								{
									if ((getPosWorld _x) isNotEqualTo _centerPos) then {
										_x setPosWorld _centerPos;
										_x enableSimulationGlobal TRUE;
									};
								} forEach (_sectorAreaObjects # 1);
							};
							((_sectorAreaObjects # 0) + (_sectorAreaObjects # 1)) spawn {
								uiSleep 1;
								{
									_x enableSimulationGlobal FALSE;
								} forEach _this;
							};
						};
						if ((flagAnimationPhase (_flagData # 0)) isNotEqualTo _conversionRate) then {
							(_flagData # 0) setFlagAnimationPhase _conversionRate;
						};
						//comment 'Scoring component';
						/*/if ((count _playersAO) > 0) then {/*/
							if (_conversionValue >= _conversionValuePrior) then {
								if ((_scoreSides # _sideIndex) <= _scoreWin) then {
									_scoreCoef = [0,_sideIndex,[_playersAO,_scorePlayerCoef,_playerCount]] call (missionNamespace getVariable 'QS_fnc_scScoreProgress');
									_scoreSides set [_sideIndex,((_scoreSides # _sideIndex) + _scoreCoef)];
								};
							};
						/*/};/*/
					};
				} else {
					//comment 'Sector inactive, make sure markers and UI elements are grey';
				
				};
				_sectorData = [_sectorID,_isActive,_nextEvaluationTime,_increment,_minConversionTime,_interruptMultiplier,_areaType,_centerPos,_areaOrRadiusConvert,_areaOrRadiusInterrupt,_sidesOwnedBy,_sidesCanConvert,_sidesCanInterrupt,_conversionValue,_conversionValuePrior,_conversionAlgorithm,_importance,_flagData,_sectorAreaObjects,_locationData,_objectData,_markerData,_taskData,_initFunction,_manageFunction,_exitFunction,_conversionRate,_isBeingInterrupted];
				if ((!(missionNamespace getVariable ['QS_virtualSectors_enabled',FALSE])) || (!(missionNamespace getVariable ['QS_virtualSectors_active',FALSE]))) exitWith {_propagate = FALSE;};
				(missionNamespace getVariable 'QS_virtualSectors_data') set [_forEachIndex,_sectorData];
				_sectorData_public = ['',_isActive,'','','','','',_centerPos,_areaOrRadiusConvert,_areaOrRadiusInterrupt,_sidesOwnedBy,_sidesCanConvert,_sidesCanInterrupt,_conversionValue,_conversionValuePrior,'','',_flagData,_sectorAreaObjects,'','',_markerData,_taskData,'','','',_conversionRate,_isBeingInterrupted];
				(missionNamespace getVariable 'QS_virtualSectors_data_public') set [_forEachIndex,_sectorData_public];
			} forEach (missionNamespace getVariable 'QS_virtualSectors_data');
			missionNamespace setVariable ['QS_virtualSectors_scoreSides',_scoreSides,FALSE];
		};
		if (_propagate) then {
			['PROPAGATE'] call (missionNamespace getVariable 'QS_fnc_sc');
		};
	};
};
if (_type isEqualTo 'INIT') exitWith {
	_sleep = _this # 1;
	if (scriptDone (missionNamespace getVariable 'QS_virtualSectors_script')) then {
		missionNamespace setVariable [
			'QS_virtualSectors_script',
			(
				_sleep spawn {
					scriptName 'QS Thread SC';
					params ['_sleep'];
					missionNamespace setVariable ['QS_virtualSectors_enabled',TRUE,TRUE];
					_fn_sc = missionNamespace getVariable 'QS_fnc_sc';
					for '_x' from 0 to 1 step 0 do {
						if (!(missionNamespace getVariable 'QS_virtualSectors_enabled')) exitWith {};
						if (allPlayers isEqualTo []) then {
							waitUntil {
								uiSleep 1;
								(allPlayers isNotEqualTo [])
							};
						};
						['MANAGE',[]] call _fn_sc;
						uiSleep _sleep;
					};
				}
			),
			FALSE
		];
	};
};
if (_type isEqualTo 'EXIT') exitWith {
	if (!scriptDone (missionNamespace getVariable 'QS_virtualSectors_script')) then {
		terminate (missionNamespace getVariable 'QS_virtualSectors_script');
		missionNamespace setVariable ['QS_virtualSectors_enabled',FALSE,TRUE];
	};
	comment 'De-initialize active sectors here';
	{
		['REMOVE',(_x # 0)] call (missionNamespace getVariable 'QS_fnc_sc');
	} forEach (missionNamespace getVariable 'QS_virtualSectors_data');
	missionNamespace setVariable ['QS_virtualSectors_enabled',FALSE,TRUE];
	missionNamespace setVariable ['QS_virtualSectors_data',[],FALSE];
	missionNamespace setVariable ['QS_virtualSectors_data_public',[],TRUE];
};
if (_type isEqualTo 'ADD') exitWith {
	_sectorData = _this # 1;
	(missionNamespace getVariable 'QS_virtualSectors_data') pushBack _sectorData;
	[_sectorData] spawn (missionNamespace getVariable 'QS_fnc_scGetSectorTerrainData');
};
if (_type isEqualTo 'REMOVE') exitWith {
	diag_log '***** SC REMOVE * 0 *****';
	_sectorID = _this # 1;
	_index = (missionNamespace getVariable 'QS_virtualSectors_data') findIf {((_x # 0) isEqualTo _sectorID)};
	if (_index isNotEqualTo -1) then {
		diag_log '***** SC REMOVE * 1 *****';
		_sectorData = (missionNamespace getVariable 'QS_virtualSectors_data') # _index;
		_sectorData params [
			'_sectorID',
			'_isActive',
			'_nextEvaluationTime',
			'_increment',
			'_minConversionTime',
			'_interruptMultiplier',
			'_areaType',
			'_centerPos',
			'_areaOrRadiusConvert',
			'_areaOrRadiusInterrupt',
			'_sidesOwnedBy',
			'_sidesCanConvert',
			'_sidesCanInterrupt',
			'_conversionValue',
			'_conversionValuePrior',
			'_conversionAlgorithm',
			'_importance',
			'_flagData',
			'_sectorAreaObjects',
			'_locationData',
			'_objectData',
			'_markerData',
			'_taskData',
			'_initFunction',
			'_manageFunction',
			'_exitFunction',
			'_conversionRate',
			'_isBeingInterrupted'
		];
		deleteVehicle (_flagData # 0);
		private _array = [];
		{
			_array = _x;
			{
				_x setPos [-1000,-1000,0];
			} forEach _array;
		} forEach _sectorAreaObjects;
		{
			deleteLocation _x;
		} forEach _locationData;
		{
			0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
		} forEach _objectData;
		{
			deleteMarker _x;
		} forEach _markerData;
		{
			[_x] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		} forEach _taskData;
		(missionNamespace getVariable 'QS_virtualSectors_data') set [_index,FALSE];
		(missionNamespace getVariable 'QS_virtualSectors_data') deleteAt _index;
		diag_log '***** SC REMOVE * 2 *****';
	};
};
if (_type isEqualTo 'ACT') exitWith {
	diag_log '***** SC ACT * 0 *****';
	_sectorID = _this # 1;
	_activationState = _this # 2;
	_index = (missionNamespace getVariable 'QS_virtualSectors_data') findIf {((_x # 0) isEqualTo _sectorID)};
	if (_index isNotEqualTo -1) then {
		diag_log '***** SC ACT * 1 *****';
		_sectorData = (missionNamespace getVariable 'QS_virtualSectors_data') # _index;
		_sectorData params [
			'_sectorID',
			'_isActive',
			'_nextEvaluationTime',
			'_increment',
			'_minConversionTime',
			'_interruptMultiplier',
			'_areaType',
			'_centerPos',
			'_areaOrRadiusConvert',
			'_areaOrRadiusInterrupt',
			'_sidesOwnedBy',
			'_sidesCanConvert',
			'_sidesCanInterrupt',
			'_conversionValue',
			'_conversionValuePrior',
			'_conversionAlgorithm',
			'_importance',
			'_flagData',
			'_sectorAreaObjects',
			'_locationData',
			'_objectData',
			'_markerData',
			'_taskData',
			'_initFunction',
			'_manageFunction',
			'_exitFunction',
			'_conversionRate',
			'_isBeingInterrupted'
		];
		if (_isActive isNotEqualTo _activationState) then {
			diag_log '***** SC ACT * 2 *****';
			_isActive = _activationState;
			_sectorData = [_sectorID,_isActive,_nextEvaluationTime,_increment,_minConversionTime,_interruptMultiplier,_areaType,_centerPos,_areaOrRadiusConvert,_areaOrRadiusInterrupt,_sidesOwnedBy,_sidesCanConvert,_sidesCanInterrupt,_conversionValue,_conversionValuePrior,_conversionAlgorithm,_importance,_flagData,_sectorAreaObjects,_locationData,_objectData,_markerData,_taskData,_initFunction,_manageFunction,_exitFunction,_conversionRate,_isBeingInterrupted];
			(missionNamespace getVariable 'QS_virtualSectors_data') set [_index,_sectorData];
		};
	};
};
if (_type isEqualTo 'PROPAGATE') exitWith {
	missionNamespace setVariable ['QS_virtualSectors_scoreSides',(missionNamespace getVariable 'QS_virtualSectors_scoreSides'),TRUE];
	missionNamespace setVariable ['QS_virtualSectors_data_public',(missionNamespace getVariable 'QS_virtualSectors_data_public'),TRUE];
};