/*/
File: fn_grid.sqf
Author: 

	Quiksilver

Last Modified:

	12/09/2018 A3 1.84 by Quiksilver

Description:

	-
	
	0 = incomplete = Independent
	1 = in progress = OPFOR
	2 = succeeded = WEST
	3 = failed = ColorUnknown
	
Notes:

	Pre-compile marker data so we dont have to procedurally generate each init
____________________________________________________________________________/*/

params ['_type'];
if (_type isEqualTo 'RESET') exitWith {
	diag_log format ['***** GRID RESETTING - %1 *****',(missionNamespace getVariable ['QS_terrain_worldName',worldName])];
	missionProfileNamespace setVariable [(format ['QS_grid_data_persistent_%1',worldName]),[]];
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'SAVE') exitWith {
	diag_log '***** GRID SAVING *****';
	missionProfileNamespace setVariable [(format ['QS_grid_data_persistent_%1',worldName]),(missionNamespace getVariable ['QS_grid_data',[]])];
	saveMissionProfileNamespace;
};
if (_type isEqualTo 'AO_FINDNEAR_RANDOM') exitWith {
	params ['','_regionIndex3','_referencePosition','_radius'];
	_region_ao_data = (QS_GRID_DATA # _regionIndex3) # 1;
	private _ao_polygon_centroid1 = [0,0,0];
	private _tempData = [];
	{
		if ((_x # 0) isEqualTo 0) then {
			_ao_polygon_centroid1 = (_x # 2) call (missionNamespace getVariable 'QS_fnc_geomPolygonCentroid');
			_tempData pushBack [_forEachIndex,_ao_polygon_centroid1];
		};
	} forEach _region_ao_data;
	private _nearAOs = [];
	private _nearAOData = [];
	private _nearAOIndex = -1;
	{
		if (((_x # 1) distance2D _referencePosition) < _radius) then {
			_nearAOs pushBack (_x # 0);
		};
	} forEach _tempData;
	if (_nearAOs isNotEqualTo []) then {
		_nearAOIndex = selectRandom _nearAOs;
	} else {
		if (_tempData isNotEqualTo []) then {
			_nearAOIndex = (selectRandom _tempData) # 0;
		};
	};
	_nearAOIndex;
};
if (_type isEqualTo 'REGION_SETSTATE') exitWith {
	params ['','_regionIndex','_newState'];
	_region_data1 = QS_GRID_DATA # _regionIndex;
	_region_ao_data1 = _region_data1 # 1;
	private _ao_markers = [];
	private _markerColors = [
		'ColorBLACK','ColorOPFOR','ColorWEST','ColorUNKNOWN'
	];
	private _markerAlphas = [0,0.75,0.75,0.75];
	_markerAlpha = _markerAlphas # _newState;
	_markerColor = _markerColors # _newState;
	//comment 'Set main data';
	_region_data1 set [2,_newState];
	QS_GRID_DATA set [_regionIndex,_region_data1];
};
if (_type isEqualTo 'REGION_GETAVAILABLE') exitWith {
	private _availableRegions = [];
	{
		if ((_x # 2) isEqualTo 0) then {
			_availableRegions pushBack _forEachIndex;
		};
	} forEach QS_GRID_DATA;
	_availableRegions;
};

if (_type isEqualTo 'REGION_GETAVAILABLEAOS') exitWith {
	params ['','_regionIndex'];
	private _availableAOs = [];
	if (_regionIndex isNotEqualTo -1) then {
		_region_data1 = QS_GRID_DATA # _regionIndex;
		_region_ao_data1 = _region_data1 # 1;
		private _aoState = -1;
		private _availableAOs = [];
		if (_regionIndex isNotEqualTo -1) then {
			{
				_aoState = _x # 0;
				if (_aoState isEqualTo 0) then {
					_availableAOs pushBack _forEachIndex;
				};
			} forEach _region_ao_data1;
		};
	};
	_availableAOs;
};
if (_type isEqualTo 'REGION_GETACTIVE') exitWith {
	private _activeRegion = -1;
	{
		if ((_x # 2) isEqualTo 1) exitWith {
			_activeRegion = (_x # 0);
		};
	} forEach QS_GRID_DATA;
	_activeRegion;
};
if (_type isEqualTo 'AO_GETACTIVE') exitWith {
	params ['','_regionIndex'];
	private _activeAO = -1;
	if (_regionIndex isNotEqualTo -1) then {
		_region_data1 = QS_GRID_DATA # _regionIndex;
		_region_ao_data1 = _region_data1 # 1;
		{
			if ((_x # 0) isEqualTo 1) exitWith {
				_activeAO = _forEachIndex;
			};
		} forEach _region_ao_data1;
	};
	_activeAO;
};
if (_type isEqualTo 'AO_GETDATA') exitWith {
	params ['','_regionIndex','_aoIndex'];
	_region_data1 = QS_GRID_DATA # _regionIndex;
	_region_ao_data1 = _region_data1 # 1;
	private _ao_data = [];
	{
		if (_forEachIndex isEqualTo _aoIndex) exitWith {
			_ao_data = _x;
		};
	} forEach _region_ao_data1;
	_ao_data;
};
if (_type isEqualTo 'AO_SETSTATE') exitWith {
	params ['','_regionIndex','_aoIndex','_newState'];
	_region_data1 = QS_GRID_DATA # _regionIndex;
	_region_ao_data1 = _region_data1 # 1;
	private _ao_data = [];
	private _markerColors = [
		'ColorBLACK','ColorOPFOR','ColorWEST','ColorUNKNOWN'
	];
	_markerAlphas = [0,0.75,0.75,0.75];
	_markerColor = _markerColors # _newState;
	_markerAlpha = _markerAlphas # _newState;
	{
		if (_forEachIndex isEqualTo _aoIndex) then {
			_ao_data = _x;
			_ao_data set [0,_newState];
			{
				_x setMarkerColor _markerColor;
				//_x setMarkerAlpha _markerAlpha;
			} forEach (_ao_data # 3);
			_region_ao_data1 set [_forEachIndex,_ao_data];
		};
	} forEach _region_ao_data1;
	//comment 'Set main data';
	_region_data1 set [1,_region_ao_data1];
	QS_GRID_DATA set [_regionIndex,_region_data1];
	_ao_data;
};	
if (_type isEqualTo 'EVALUATE_AO') exitWith {
	params ['','_regionIndex','_aoIndex'];
	private _c = FALSE;
	if (missionNamespace getVariable ['QS_TEST_GRID',FALSE]) then {
		_c = TRUE;
	};
	_c;
};
if (_type isEqualTo 'EVALUATE_REGION') exitWith {
	params ['','_regionIndex','_threshold'];
	private _remainingAOs = 0;
	if (_regionIndex isNotEqualTo -1) then {
		_region_data1 = QS_GRID_DATA # _regionIndex;
		_region_ao_data1 = _region_data1 # 1;
		{
			if ((_x # 0) isEqualTo 0) then {
				_remainingAOs = _remainingAOs + 1;
			};
		} forEach _region_ao_data1;
	};
	(_remainingAOs <= _threshold)
};
if (_type isEqualTo 'AI_TRIGGER') exitWith {
	//comment 'Trigger AI init/de-init for server + HCs';
};
if (_type isEqualTo 'INIT') exitWith {
	//comment 'Get persistent data';
	// Note: This part takes way too long and needs to be optimized at some point.
	diag_log format ['Grid initializing START - %1',diag_tickTime];
	private _grid_data_persistent = missionProfileNamespace getVariable [(format ['QS_grid_data_persistent_%1',worldName]),[]];
	if (_grid_data_persistent isEqualTo []) then {
		_grid_data_persistent = call (compileScript ['code\config\QS_data_grid.sqf']); 
	};
	private _tempData = [];
	private _regionAOs = [];
	private _regionState = -1;
	private _aoData = [];
	private _aoPolygon = [];
	private _aoState = -1;
	{
		_regionAOs = _x # 1;
		_regionState = _x # 2;
		{
			_aoData = _x;
			_aoState = _aoData # 0;
			_aoPolygon = _aoData # 2;
			_tempData pushBack [_aoPolygon,_aoState,_regionState];
		} forEach _regionAOs;
	} forEach _grid_data_persistent;
	//comment 'Build marker layout here';
	_inPolygons = {
		params ['_position','_tempData'];
		private _c = [FALSE,0];
		{
			if (_position inPolygon (_x # 0)) exitWith {
				_c = [TRUE,(_x # 1)];
			};
		} forEach _tempData;
		_c;
	};
	_posi = {
		[(floor((_this # 0)*0.01))*100+50, (floor((_this # 1)*0.01))*100+50]
	};
	_generate = {
		params ['_start','_offset','_size','_res','_alpha','_tempData','_inPolygons'];
		private _creationPos = [-1000,-1000,0];
		private _markers = [];
		private _markerInfo = [];
		private _markerColors = [
			'ColorBLACK','ColorOPFOR','ColorWEST','ColorUNKNOWN'
		];
		private _markerAlphas = [0,0,0.5,0.5];	// [0,0.75,0.5,0.5];
		_ind = -1;  
		_start = _start apply {_ind = _ind + 1; _x + (_offset # _ind)};
		_start params ['_sx','_sz'];
		for '_i' from 0 to (round((_size # 0)/_res)) step 1 do {
			_pi = [_sx + _res * _i, _sz, 0];
			_str = format ['QS_grid_marker_%1',(parseNumber (mapGridPosition _pi))];/*/_str = format ['QS_grid_marker_%1',(_pi # 0),(_pi # 1)];/*/
			if (!(_str in allMapMarkers)) then {
				if (!surfaceIsWater _pi) then {
					_markerInfo = [_pi,_tempData] call _inPolygons;
					if (_markerInfo # 0) then {
						_mkr = createMarker [_str,_creationPos];
						_mkr setMarkerTextLocal (toString [32,32,32]);
						_mkr setMarkerShapeLocal 'Rectangle';
						_mkr setMarkerBrushLocal 'SolidBorder';
						_mkr setMarkerSizeLocal [(_res*0.5),(_res*0.5)];
						_mkr setMarkerColorLocal (_markerColors # (_markerInfo # 1));
						_mkr setMarkerAlphaLocal (_markerAlphas # (_markerInfo # 1));
						_mkr setMarkerPos _pi;
						_markers pushBack _mkr;
					};
				};
			};
			_pi params ['_px','_pz'];
			for '_e' from 1 to (round((_size # 1)/_res)) step 1 do {
				_pe = [_px, _pz + _res * _e, 0];
				_str = format ['QS_grid_marker_%1',(parseNumber (mapGridPosition _pe))];/*/_str = format ['QS_grid_marker_%1',(_pe # 0),(_pe # 1)];/*/
				if (!(_str in allMapMarkers)) then {
					if (!surfaceIsWater _pe) then {
						_markerInfo = [_pe,_tempData] call _inPolygons;
						if (_markerInfo # 0) then {
							_mkr = createMarker [_str,_creationPos];
							_mkr setMarkerTextLocal (toString [32,32,32]);
							_mkr setMarkerShapeLocal 'Rectangle';
							_mkr setMarkerBrushLocal 'SolidBorder';
							_mkr setMarkerSizeLocal [_res*0.5,_res*0.5];
							_mkr setMarkerColorLocal (_markerColors # (_markerInfo # 1));
							_mkr setMarkerAlphaLocal (_markerAlphas # (_markerInfo # 1));
							_mkr setMarkerPos _pe;
							_markers pushBack _mkr;
						};
					};
				};
			};
		};
		_markers;
	};
	_markers = [
		([0,0,0] call _posi),
		[0,0],
		[worldSize,worldSize],
		100,
		0,
		_tempData,
		_inPolygons
	] call _generate;
	private _markersData = [];
	{
		_markersData pushBack [_x,(markerPos _x),(markerText _x),(markerShape _x),(markerBrush _x),(markerSize _x),(markerColor _x),(markerAlpha _x),(markerDir _x)];
	} forEach _markers;
	missionNamespace setVariable ['QS_grid_markers',_markers,FALSE];
	missionNamespace setVariable ['QS_grid_markers_data',_markersData,FALSE];
	//comment 'Now lets store the markers in the data array';
	private _grid_data_region = [];
	private _ao_data = [];
	{
		_grid_data_region = _x;
		_grid_data_region params [
			'',
			'_region_ao_data',
			''
		];
		{
			_ao_data = _x;
			_ao_data params [
				'',
				'',
				'_ao_polygon',
				'_ao_markers',
				'',
				'',
				'',
				'',
				'',
				'',
				'',
				'',
				'',
				'',
				''
			];
			_ao_markers = [];
			{
				if ((_x # 1) inPolygon _ao_polygon) then {
					_ao_markers pushBack (_x # 0);
				};
			} forEach _markersData;
			_ao_data set [3,_ao_markers];
			_region_ao_data set [_forEachIndex,_ao_data];
		} forEach _region_ao_data;
		_grid_data_persistent set [_forEachIndex,_grid_data_region];
	} forEach _grid_data_persistent;
	QS_GRID_DATA = _grid_data_persistent;
	if (isNull (missionNamespace getVariable ['QS_grid_script',scriptNull])) then {
		missionNamespace setVariable ['QS_grid_script',(['MANAGE'] spawn (missionNamespace getVariable 'QS_fnc_grid')),FALSE];
	};
	_missionMarkerData = [
		['QS_marker_grid_capState',[-1000,-1000,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_009'],
		['QS_marker_grid_rspState',[-1000,-1000,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_010'],
		['QS_marker_grid_civState',[-1000,-1000,0],'mil_dot','Icon','','ColorCIVILIAN',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_011'],
		['QS_marker_grid_IGmkr',[-1000,-1000,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_003'],
		['QS_marker_grid_IGcircle',[-1000,-1000,0],'Empty','Ellipse','Border','ColorOPFOR',[200,200],0,[-1000,-1000,0],0,''],
		['QS_marker_grid_IDAPloc',[-1000,-1000,0],'flag_IDAP','Icon','','ColorWHITE',[0.5,0.5],0,[-1000,-1000,0],0,''],
		['QS_marker_grid_IDAPmkr',[-1000,-1000,0],'mil_dot','Icon','','ColorOrange',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_012'],
		['QS_marker_grid_IDAPcircle',[-1000,-1000,0],'Empty','Ellipse','Border','ColorOrange',[50,50],0,[-1000,-1000,0],0,''],
		['QS_marker_grid_mtrMkr',[-1000,-1000,0],'mil_dot','Icon','','ColorOPFOR',[0.5,0.5],0,[-1000,-1000,0],0,localize 'STR_QS_Marker_013'],
		['QS_marker_grid_mtrCircle',[-1000,-1000,0],'Empty','Ellipse','Border','ColorOPFOR',[100,100],0,[-1000,-1000,0],0,'']
	];
	{
		createMarker [(_x # 0),(_x # 1)];
		(_x # 0) setMarkerTypeLocal (_x # 2);
		(_x # 0) setMarkerShapeLocal (_x # 3);
		if ((_x # 3) isNotEqualTo 'Icon') then {
			(_x # 0) setMarkerBrushLocal (_x # 4);
		};
		(_x # 0) setMarkerColorLocal (_x # 5);
		(_x # 0) setMarkerSizeLocal (_x # 6);
		(_x # 0) setMarkerAlphaLocal (_x # 7);
		(_x # 0) setMarkerPosLocal (_x # 8);
		(_x # 0) setMarkerDirLocal (_x # 9);
		(_x # 0) setMarkerText (format ['%1%2',(toString [32,32,32]),(_x # 10)]);
		_markers pushBack (_x # 0);
	} forEach _missionMarkerData;
	diag_log format ['Grid initializing END - %1',diag_tickTime];
	missionNamespace setVariable ['QS_grid_initialized',TRUE,FALSE];
	_grid_data_persistent;
};
if (_type isEqualTo 'EXIT') exitWith {
	//comment 'End of mission';
	//comment 'AAR';
};
if (_type isEqualTo 'MANAGE') then {
	scriptName 'QS GRID MANAGEMENT';
	//comment 'Configure';
	private _sleep = 3;
	private _uiTime = diag_tickTime;
	private _unitCap = -1;
	private _objectivesData = [];
	private _aoData = [];
	private _aoGridMarkers = [];
	private _aoPolygon = [];
	private _generalInfoDelay = 5;
	private _generalInfoCheckDelay = _uiTime + _generalInfoDelay;
	private _allUnits = allUnits;
	private _allPlayers = allPlayers;
	private _allEnemies = [];
	private _allFriends = [];
	private _enemySides = [EAST,RESISTANCE];
	private _friendSides = [WEST];
	private _markerUpdateDelay = 5;
	private _markerUpdateCheckDelay = _uiTime + _markerUpdateDelay;
	private _markerColor = '';
	private _markerZ = 30;
	private _aoGridMarkerData = [];
	private _marker = '';
	private _markerData = [];
	private _markerVar = -1;
	private _markerDefaultColor = '';
	private _areaUnits = [];
	private _markerCheckSleep = 0.001;
	private _intelHouses = [];
	private _intelHousesData = [];
	private _intelHouse = objNull;
	private _intelItems = [];
	private _objectiveData = [];
	private _objectiveType = '';
	private _objectiveState = 0;
	private _objectiveIsRequired = 0;
	private _objectiveArguments = [];
	private _objectiveCode = {};
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	private _objectivesData_update = FALSE;
	private _objectiveEvalGraceTime = -1;
	private _objectivesRequiredComplete = FALSE;
	private _objectiveReturn = 0;
	private _false = FALSE;
	private _true = TRUE;
	//comment 'Loop';
	for '_x' from 0 to 1 step 0 do {
		_uiTime = diag_tickTime;
		if (_uiTime > _generalInfoCheckDelay) then {
			_generalInfoCheckDelay = _uiTime + _generalInfoDelay;
			_allUnits = allUnits;
			_allPlayers = allPlayers;
			_allEnemies = (((units EAST) + (units RESISTANCE)) select {((lifeState _x) in ['HEALTHY','INJURED'])}) unitsBelowHeight _markerZ;
			_allFriends = ((units WEST) select {((lifeState _x) in ['HEALTHY','INJURED'])}) unitsBelowHeight _markerZ;
		};
		if (missionNamespace getVariable ['QS_grid_active',_false]) then {
			if (_uiTime > _objectiveEvalGraceTime) then {
				if ((missionNamespace getVariable ['QS_grid_objectivesData',[]]) isNotEqualTo []) then {
					_objectivesData = missionNamespace getVariable ['QS_grid_objectivesData',[]];
					if (_objectivesData isNotEqualTo []) then {
						_objectivesData_update = _false;
						_objectivesRequiredComplete = _true;
						{
							_objectiveData = _x;
							_objectiveData params [
								'_objectiveType',
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
									_objectivesData_update = _true;
									_objectiveData set [1,_objectiveReturn];
									_objectivesData set [_forEachIndex,_objectiveData];
									call ([_objectiveOnFailed,_objectiveOnCompleted] select (_objectiveReturn isEqualTo 1));
								};
							};
							if (_objectivesRequiredComplete) then {
								if ((_objectiveIsRequired isEqualTo 1) && (_objectiveState isEqualTo 0)) then {
									_objectivesRequiredComplete = _false;
								};
							};
						} forEach _objectivesData;
						if (_objectivesData_update) then {
							_objectivesData_update = _false;
							missionNamespace setVariable ['QS_grid_objectivesData',_objectivesData,_false];
						};
						if ((_objectivesRequiredComplete) || {(missionNamespace getVariable ['QS_aoCycleVar',_false])}) then {
							[0,[]] call (missionNamespace getVariable 'QS_fnc_gridBrief');
							if (missionNamespace getVariable ['QS_aoCycleVar',_false]) then {
								missionNamespace setVariable ['QS_aoCycleVar',_false,_false];
							};
							if ((missionNamespace getVariable ['QS_grid_defend_trigger',_false]) || {(missionNamespace getVariable ['QS_grid_defend_force',_false])}) then {
								if (missionNamespace getVariable ['QS_grid_defend_active',_false]) then {
									missionNamespace setVariable ['QS_grid_defend_active',_false,_true];
								};
								if (!(missionNamespace getVariable ['QS_grid_AI_triggerDeinit',_false])) then {
									missionNamespace setVariable ['QS_grid_AI_triggerDeinit',_true,_true];
								};
								if ((missionNamespace getVariable ['QS_grid_intelEntities',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_grid_intelEntities',[]]);
									missionNamespace setVariable ['QS_grid_intelEntities',[],_false];
								};
								if (!isNull (missionNamespace getVariable ['QS_grid_IGintel',objNull])) then {
									deleteVehicle (missionNamespace getVariable 'QS_grid_IGintel');
									missionNamespace setVariable ['QS_grid_IGintel',objNull,_false];
								};
								if (!isNull (missionNamespace getVariable ['QS_grid_IDAPintel',objNull])) then {
									deleteVehicle (missionNamespace getVariable 'QS_grid_IDAPintel');
									missionNamespace setVariable ['QS_grid_IDAPintel',objNull,_false];
								};
								if (missionNamespace getVariable ['QS_grid_defend_force',_false]) then {
									missionNamespace setVariable ['QS_grid_defend_force',_false,_false];
								};
								if (missionNamespace getVariable ['QS_grid_defend_trigger',_false]) then {
									missionNamespace setVariable ['QS_grid_defend_trigger',_false,_false];
								};
								missionNamespace setVariable ['QS_grid_AIRspTotal',0,_false];
								missionNamespace setVariable ['QS_grid_AIRspDestroyed',0,_false];
								if ((missionNamespace getVariable ['QS_ao_UXOs',[]]) isNotEqualTo []) then {
									deleteVehicle (missionNamespace getVariable ['QS_ao_UXOs',[]]);
									missionNamespace setVariable ['QS_ao_UXOs',[],_false];
								};
								missionNamespace setVariable ['QS_grid_defend_script',(0 spawn (missionNamespace getVariable 'QS_fnc_gridDefend')),_false];
								waitUntil {
									uiSleep 1;
									(scriptDone (missionNamespace getVariable ['QS_grid_defend_script',scriptNull]))
								};
								missionNamespace setVariable ['QS_grid_defend_script',scriptNull,_false];
							};
							if (!(missionNamespace getVariable ['QS_grid_AI_triggerDeinit',_false])) then {
								missionNamespace setVariable ['QS_grid_AI_triggerDeinit',_true,_true];
							};
							missionNamespace setVariable ['QS_TEST_GRID',_true,_false];
						};
					};
				};
			};
			//comment 'Handle grid markers';
			if (_uiTime > _markerUpdateCheckDelay) then {
				_markerUpdateCheckDelay = _uiTime + _markerUpdateDelay;
				if (_aoData isNotEqualTo []) then {
					if (_aoGridMarkerData isNotEqualTo []) then {
						missionNamespace setVariable ['QS_grid_evalMarkers',_true,_false];
						{
							_markerData = _x;
							_markerData params [
								'_marker',
								'_markerVar',
								'_markerDefaultColor'
							];
							_markerColor = markerColor _marker;
							if (_markerColor isEqualTo 'ColorOPFOR') then {
								if ((_allFriends inAreaArray _marker) isNotEqualTo []) then {
									if ((_allEnemies inAreaArray _marker) isEqualTo []) then {
										_marker setMarkerColor 'ColorGREEN';
									};
								};
							} else {
								if (_markerColor isEqualTo 'ColorGREEN') then {
									//comment 'Evaluate for red conditions';
									if ((_allEnemies inAreaArray _marker) isNotEqualTo []) then {
										_marker setMarkerColor 'ColorOPFOR';
									};
								} else {
									if (_markerColor isEqualTo 'ColorRED') then {
										if ((_allEnemies inAreaArray _marker) isEqualTo []) then {
											if ((_allFriends inAreaArray _marker) isNotEqualTo []) then {
												_marker setMarkerColor 'ColorGREEN';
											};
										};
									} else {
										if (_markerColor isEqualTo 'ColorUNKNOWN') then {
									
										};
									};
								};
							};
							uiSleep _markerCheckSleep;
							if (!(missionNamespace getVariable 'QS_grid_active')) exitWith {};
						} forEach _aoGridMarkerData;
						missionNamespace setVariable ['QS_grid_evalMarkers',_false,_false];
					};
				};
			};
			if ((missionNamespace getVariable ['QS_grid_intelHouses',[]]) isNotEqualTo []) then {
				_intelHouses = missionNamespace getVariable ['QS_grid_intelHouses',[]];
				if (_intelHouses isNotEqualTo []) then {
					{
						_intelHousesData = _x;
						_intelHousesData params [
							['_intelHouse',objNull],
							['_intelItems',[]]
						];
						if (!(alive _intelHouse)) then {
							if (_intelItems isNotEqualTo []) then {
								{
									if (!(isNull _x)) then {
										if (!(isObjectHidden _x)) then {
											_x hideObjectGlobal _true;
										};
									};
								} forEach _intelItems;
							};
						};
					} forEach _intelHouses;
				};
			};
		} else {
			waitUntil {
				uiSleep 1;
				(missionNamespace getVariable ['QS_grid_active',_false])
			};
			//comment 'Grid init?';
			_objectiveEvalGraceTime = diag_tickTime + 60;
			_aoData = missionNamespace getVariable ['QS_grid_aoData',[]];
			if (_aoData isNotEqualTo []) then {
				_aoData params [
					'',
					'',
					'',
					'_aoGridMarkers'
				];
				_aoGridMarkerData = [];
				{
					_aoGridMarkerData pushBack [_x,0,(markerColor _x)];
				} forEach _aoGridMarkers;
			};
		};
		uiSleep _sleep;
	};
};