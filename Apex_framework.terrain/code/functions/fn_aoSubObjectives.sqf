/*/
File: fn_aoSubObjectives.sqf
Author: 

	Quiksilver

Last Modified:

	10/04/2018 A3 1.82 by Quiksilver

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
			if (!(_objectiveReturn isEqualTo _objectiveState)) then {
				_objectivesData_update = TRUE;
				_objectiveData set [1,_objectiveReturn];
				_subObjectiveData set [_forEachIndex,_objectiveData];
				call ([_objectiveOnFailed,_objectiveOnCompleted] select (_objectiveReturn isEqualTo 1));
			};
		};
		if (_return) then {
			if ((_objectiveIsRequired isEqualTo 1) && (_objectiveState isEqualTo 0)) then {
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
	//comment 'Create';
	//comment 'Radio tower';
	//comment 'Secure HQ';
	//comment 'Enemy pop threshold';
	if (_subType isEqualTo 'ENEMYPOP') then {
		_pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
		_aoSize = missionNamespace getVariable ['QS_aoSize',500];
		_objectiveIsRequired = 1;
		_objectiveArguments = [_pos,_aoSize,(missionNamespace getVariable 'QS_fnc_serverDetector'),10];
		_objectiveCode = {
			params ['_aoPos','_aoRadius','_detector','_threshold'];
			private _return = 0;
			if (([_aoPos,_aoRadius,[EAST],allUnits,1] call _detector) < _threshold) then {
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
		for '_x' from 0 to 9 step 1 do {
			_position = ['RADIUS',_pos,(_aoSize * 0.75),'LAND',[1,0,0.5,4,0,FALSE,objNull],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (((_position distance2D _baseMarker) > 500) && ((_position distance2D _hqPos) > 200) && ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo [])) exitWith {};
		};
		_position set [2,0];
		_roughPos = [((_position select 0) - 140) + (random 280),((_position select 1) - 140) + (random 280),0];
		_towerType = 'Land_TTowerBig_2_F';
		missionNamespace setVariable ['QS_radioTower',(createVehicle [_towerType,_position,[],0,'NONE']),FALSE];
		missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
		(missionNamespace getVariable 'QS_radioTower') setVectorUp [0,0,1];
		(missionNamespace getVariable 'QS_radioTower') allowDamage FALSE;
		(missionNamespace getVariable 'QS_radioTower') addEventHandler ['Killed',{call (missionNamespace getVariable 'QS_fnc_eventRTKilled');}];
		missionNamespace setVariable ['QS_radioTower_pos',_position,FALSE];
		missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
		{
			_x setMarkerPosLocal _roughPos;
			_x setMarkerAlpha 0.75;
		} count ['QS_marker_radioMarker','QS_marker_radioCircle'];
		'QS_marker_radioCircle' setMarkerSize [150,150];
		_objectiveIsRequired = 1;
		_objectiveArguments = [(missionNamespace getVariable 'QS_radioTower')];
		_objectiveCode = {
			params ['_tower'];
			private _return = 0;
			if (!alive _tower) then {
				if (!((markerAlpha 'QS_marker_radioMarker') isEqualTo 0)) then {
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
		private _position = [0,0,0];
		for '_x' from 0 to 9 step 1 do {
			_position = ['RADIUS',_pos,(_aoSize * 0.666),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (((_position distance2D _baseMarker) > 500) && ((_position distance2D _hqPos) > 200) && ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && (!([_position,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
		};
		_roughPos = [((_position select 0) - 140) + (random 280),((_position select 1) - 140) + (random 280),0];
		_jammer = [1,'QS_ao_jammer_1',_position,_roughPos,(ceil (random [150,200,300]))] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
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