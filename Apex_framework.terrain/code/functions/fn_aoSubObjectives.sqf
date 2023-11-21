/*/
File: fn_aoSubObjectives.sqf
Author: 

	Quiksilver

Last Modified:

	17/08/2022 A3 2.10 by Quiksilver

Description:

	AO Sub Objectives
________________________________________________________/*/

params ['_type'];
if (_type isEqualTo 0) exitWith {
	private _return = TRUE;
	//comment 'Evaluate';
	private _objectivesData_update = FALSE;
	private _objectiveReturn = 0;
	private _objectiveData = [];
	_subObjectiveData = missionNamespace getVariable ['QS_classic_subObjectiveData',[]];
	{
		_objectiveData = _x;
		_objectiveData params [
			'_subType',
			'_objectiveState',
			'_objectiveIsRequired',
			'_objectiveArguments',
			'_objectiveCode',
			'_objectiveOnCompleted',
			'_objectiveOnFailed'
		];
		if (_objectiveState isEqualTo 0) then {
			_objectiveReturn = _objectiveArguments call _objectiveCode;
			if (_objectiveReturn isNotEqualTo _objectiveState) then {
				_objectivesData_update = TRUE;
				_objectiveData set [1,_objectiveReturn];
				_subObjectiveData set [_forEachIndex,_objectiveData];
				call ([_objectiveOnFailed,_objectiveOnCompleted] select (_objectiveReturn isEqualTo 1));
			};
		};
		if (_return) then {
			if (
				(_objectiveIsRequired isEqualTo 1) && 
				{(_objectiveState isEqualTo 0)}
			) then {
				_return = FALSE;
			};
		};
	} forEach _subObjectiveData;
	if (_objectivesData_update) then {
		missionNamespace setVariable ['QS_classic_subObjectiveData',_subObjectiveData,FALSE];
	};
	_return;
};
if (_type isEqualTo 1) exitWith {
	params ['','_subType'];
	private _return = [];
	private _objectiveIsRequired = 0;
	private _objectiveArguments = [];
	private _objectiveCode = {0};
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	if (_subType isEqualTo 'ENEMYPOP') then {
		_pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
		_aoSize = missionNamespace getVariable ['QS_aoSize',500];
		_objectiveIsRequired = 1;
		_objectiveArguments = [_pos,_aoSize,(missionNamespace getVariable 'QS_fnc_serverDetector'),10];
		_objectiveCode = {
			params ['_aoPos','_aoRadius','_detector','_threshold'];
			private _return = 0;
			if ((count ( (units EAST) inAreaArray [_aoPos,_aoRadius,_aoRadius,0,FALSE,-1])) < _threshold) then {
				_return = 1;
			};
			_return;
		};
		_objectiveOnCompleted = {};
		_objectiveOnFailed = {};
	};
	if (_subType isEqualTo 'RADIOTOWER') then {
		_pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
		_aoSize = missionNamespace getVariable ['QS_aoSize',500];
		_baseMarker = markerPos 'QS_marker_base_marker';
		_hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
		private _position = [0,0,0];
		private _usedSettlementPosition = FALSE;
		missionNamespace setVariable ['QS_radiotower_useFence',TRUE,FALSE];
		private _dir = 0;
		private _building = objNull;
		if (missionNamespace getVariable ['QS_ao_terrainIsSettlement',FALSE]) then {
			if ((random 1) > 0.666) then {
				if ((missionNamespace getVariable ['QS_ao_objsUsedTerrainBldgs',0]) <= 1) then {
					_buildingTypes = missionNamespace getVariable ['QS_data_smallBuildingTypes_10',[]];
					_buildingList = (nearestObjects [_pos,['House'],_aoSize * 0.9,TRUE]) select {((!isObjectHidden _x) && ((sizeOf (typeOf _x)) >= 10))};
					if (_buildingList isNotEqualTo []) then {
						_position = [0,0,0];
						for '_i' from 0 to 9 step 1 do {
							_building = selectRandom _buildingList;
							_position = getPosATL _building;
							if (
								((_position distance2D _hqPos) > 100) && 
								(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,25,25,0,FALSE]) isEqualTo [])
							) exitWith {
								_usedSettlementPosition = TRUE;
								missionNamespace setVariable ['QS_radiotower_useFence',FALSE,FALSE];
								_dir = getDir _building;
								_building allowDamage FALSE;
								_building hideObjectGlobal TRUE;
								(missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _building;
							};
						};
					};
				};
			};
		};
		if (!_usedSettlementPosition) then {
			for '_x' from 0 to 29 step 1 do {
				_position = ['RADIUS',_pos,(_aoSize * 0.75),'LAND',[1,-1,0.5,4,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
				if (
					((_position distance2D _baseMarker) > 500) && 
					{((_position distance2D _hqPos) > 200)} && 
					{((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
					{(!([_position,25,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))}
				) exitWith {};
			};
			_position set [2,0];
		};
		_roughPos = [((_position # 0) - 140) + (random 280),((_position # 1) - 140) + (random 280),0];
		_towerType = 'Land_TTowerBig_2_F';
		_radioTower = createVehicle [_towerType,_position,[],0,['NONE','CAN_COLLIDE'] select _usedSettlementPosition];
		if (_usedSettlementPosition) then {
			_position set [2,0];
			_radioTower setPosATL _position;
		};
		_radioTower setVectorUp [0,0,1];
		_radioTower allowDamage FALSE;
		_radioTower addEventHandler ['Killed',{call (missionNamespace getVariable 'QS_fnc_eventRTKilled');}];
		missionNamespace setVariable ['QS_radioTower',_radioTower,FALSE];
		missionNamespace setVariable ['QS_radioTower_pos',_position,FALSE];
		missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
		{
			_x setMarkerPosLocal _roughPos;
			_x setMarkerAlphaLocal 0.75;
		} count ['QS_marker_radioMarker','QS_marker_radioCircle'];
		'QS_marker_radioCircle' setMarkerSizeLocal [150,150];
		_objectiveIsRequired = 1;
		_objectiveArguments = [(missionNamespace getVariable 'QS_radioTower')];
		_objectiveCode = {
			params ['_tower'];
			private _return = 0;
			if (!alive _tower) then {
				if ((markerAlpha 'QS_marker_radioMarker') isNotEqualTo 0) then {
					{
						_x setMarkerAlpha 0;
					} count ['QS_marker_radioMarker','QS_marker_radioCircle'];
				};
				_return = 1;
			};
			_return;
		};
		_objectiveOnCompleted = {
			params ['_tower'];
		};
		_objectiveOnFailed = {
			params ['_tower'];
		};
		if ((random 1) > 0.333) then {
			missionNamespace setVariable ['QS_ao_createDelayedMinefield',TRUE,FALSE];
		};
	};
	if (_subType isEqualTo 'JAMMER') then {
		_pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
		_aoSize = missionNamespace getVariable ['QS_aoSize',500];
		_baseMarker = markerPos 'QS_marker_base_marker';
		_hqPos = missionNamespace getVariable ['QS_HQpos',[0,0,0]];
		_radiusCoef = [0.75,0.9] select (worldName in ['Stratis','Tanoa']);
		private _position = [0,0,0];
		for '_x' from 0 to 49 step 1 do {
			_position = ['RADIUS',_pos,(_aoSize * _radiusCoef),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				((_position distance2D _baseMarker) > 500) && 
				{((_position distance2D _hqPos) > 200)} && 
				{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,65,65,0,FALSE]) isEqualTo [])} &&
				{((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} && 
				{(!(surfaceIsWater _position))} &&
				{(!([_position,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))}
			) exitWith {};
		};
		missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
		_drawBlackCircle = FALSE;
		_jammerRadius = _aoSize;
		//_roughPos = [((_position # 0) - 140) + (random 280),((_position # 1) - 140) + (random 280),0];
		_jammer = [1,'QS_ao_jammer_1',_position,_pos,_jammerRadius,TRUE,_drawBlackCircle] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
		if (alive _jammer) then {
			_objectiveIsRequired = 1;
			_objectiveArguments = [_jammer];
			_objectiveCode = {
				params ['_jammer'];
				private _return = 0;
				if (!alive _jammer) then {
					_return = 1;
				};
				_return;
			};
			_objectiveOnCompleted = {
				params ['_jammer'];
			};
			_objectiveOnFailed = {
				params ['_jammer'];
			};
		};
	};
	_return = [
		_subType,
		0,
		_objectiveIsRequired,
		_objectiveArguments,
		_objectiveCode,
		_objectiveOnCompleted,
		_objectiveOnFailed
	];
	_return;
};