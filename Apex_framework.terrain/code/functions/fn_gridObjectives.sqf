/*/
File: fn_gridObjectives.sqf
Author: 

	Quiksilver

Last Modified:

	7/12/2017 A3 1.78 by Quiksilver

Description:

	- Grid AO objectives
____________________________________________________________________________/*/

params ['_type','_aoData','_aoPos','_aoSize','_terrainData','_playersCount'];
private _return = [];
if (_type isEqualTo 'GRID_MARKERS') exitWith {
	_gridMarkers = _aoData # 3;
	_objectiveIsRequired = 1;
	_objectiveArguments = [
		_gridMarkers,
		(count _gridMarkers),
		(diag_tickTime + 3600)
	];
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	_centroid = missionNamespace getVariable 'QS_grid_aoCentroid';
	_centroidOffset = [
		((_centroid # 0) + 1000),
		(_centroid # 1),
		(_centroid # 2)
	];
	_requiredCount = (15 + (round (_playersCount / 2))) min ((count _gridMarkers) - 3);
	'QS_marker_grid_capState' setMarkerColorLocal 'ColorOPFOR';
	'QS_marker_grid_capState' setMarkerPosLocal _centroidOffset;
	'QS_marker_grid_capState' setMarkerText (format ['%1 %3 0 / %2',(toString [32,32,32]),_requiredCount,localize 'STR_QS_Marker_014']);
	_objectiveCode = {
		params ['_gridMarkers','_gridMarkersCount','_duration'];
		private _c = 0;
		_playerCount = count allPlayers;
		private _requiredCount = (15 + (round (_playerCount / 2))) min (_gridMarkersCount - 3);
		if (diag_tickTime > _duration) then {
			_requiredCount = round (_requiredCount / 2);
		};
		_currentCount = {((markerColor _x) isEqualTo 'ColorGREEN')} count _gridMarkers;
		if ( (markerText 'QS_marker_grid_capState') isNotEqualTo (format ['%4 %3 %1 / %2',_currentCount,_requiredCount,localize 'STR_QS_Marker_014',(toString [32,32,32])])) then {
			'QS_marker_grid_capState' setMarkerText (format ['%1 %4 %2 / %3',(toString [32,32,32]),_currentCount,_requiredCount,localize 'STR_QS_Marker_014']);
		};
		if (_currentCount >= _requiredCount) then {
			_c = 1;
		};
		_c;
	};
	_objectiveOnCompleted = {
		['GRID_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_059']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		'QS_marker_grid_capState' setMarkerColor 'ColorGREEN';
	};
	_objectiveOnFailed = {
		
	};
	_return = [
		_type,
		0,
		_objectiveIsRequired,
		_objectiveArguments,
		_objectiveCode,
		_objectiveOnCompleted,
		_objectiveOnFailed
	];
	_return;
};
if (_type isEqualTo 'SITE_TUNNEL') exitWith {
	private _objectiveArguments = [];
	private _objectiveIsRequired = 1;
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	_aoPolygon = _aoData # 2;
	_nSites = (2 + (_playersCount / 10)) min 5;
	private _position = [0,0,0];
	private _usedPositions = [[-1000,-1000,0]];
	private _safeDistance = 50;
	private _foundPosition = FALSE;
	private _entities = [];
	_positionTypes = [
		'(1 + forest)',
		'(1 + forest) * (1 - houses)'
	];
	_fn_checkSafePosition = {
		params ['_position','_radius','_increment','_z'];
		private _c = TRUE;
		private _dir = 0;
		private _testPos = [0,0,0];
		private _testPosASL = [0,0,0];
		private _intersections = [];
		_dirIncrement = 360 / _increment;
		for '_x' from 0 to (_increment - 1) step 1 do {
			_testPos = _position getPos [_radius,_dir];
			_testPosASL = AGLToASL _testPos;
			_testPosASL set [2,0.25];
			_intersections = lineIntersectsSurfaces [
				_testPosASL,
				[
					_testPosASL # 0,
					_testPosASL # 1,
					((_testPosASL # 2) + _z)
				],
				objNull,
				objNull,
				TRUE,
				3,
				'GEOM',
				'VIEW',
				TRUE
			];
			if (_intersections isNotEqualTo []) then {
				{
					if (!isNull (_x # 3)) exitWith {
						_c = FALSE;
					};
				} forEach _intersections;
			};
			_dir = _dir + _dirIncrement;
		};
		_c;
	};
	private _searchTimeout = -1;
	for '_x' from 0 to _nSites step 1 do {
		//comment 'Find position';
		_foundPosition = FALSE;
		_searchTimeout = diag_tickTime + 15;
		for '_x' from 0 to 1 step 0 do {
			_position = ['RADIUS',_aoPos,_aoSize,'LAND',[2,0,0.25,5,0,FALSE,objNull],FALSE,[_aoPos,200,(selectRandom _positionTypes),15,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (_position inPolygon _aoPolygon) then {
				if ((_usedPositions findif {((_position distance2D _x) < _safeDistance)}) isEqualTo -1) then {
					if (!([_position,30,6] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
						if ((([(_position # 0),(_position # 1)] nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) then {
							if ([_position,1.5,6,2] call _fn_checkSafePosition) then {
								if (!((toLowerANSI (surfaceType _position)) in ['#gdtasphalt'])) then {
									_foundPosition = TRUE;
								};
							};
						};
					};
				};
			};
			if (diag_tickTime > _searchTimeout) exitWith {};
			if (_foundPosition) exitWith {};
		};
		if (diag_tickTime > _searchTimeout) exitWith {};
		if ((_position distance2D _aoPos) < (_aoSize * 2)) then {
			(missionNamespace getVariable 'QS_registeredPositions') pushBack _position;
			_usedPositions pushBack _position;
			//comment 'Spawn composition';
			{	
				if ((_x distance2D _position) < 6) then {
					(missionNamespace getVariable 'QS_grid_hiddenTerrainObjects') pushBack _x;
					_x hideObjectGlobal TRUE;
				};
			} forEach (nearestTerrainObjects [_position,[],15,FALSE,TRUE]);
			_entities pushBack ([1,_position,nil] call (missionNamespace getVariable 'QS_fnc_createWell'));
			diag_log format ['QS QS QS * Spawned position: %1',_position];
		};
	};
	missionNamespace setVariable ['QS_grid_enemyRespawnObjects',_entities,TRUE];
	missionNamespace setVariable ['QS_grid_AIRspTotal',(count _entities),FALSE];
	_centroid = missionNamespace getVariable 'QS_grid_aoCentroid';
	_centroidOffset = [
		((_centroid # 0) + 1000),
		((_centroid # 1) - 300),
		(_centroid # 2)
	];
	'QS_marker_grid_rspState' setMarkerColorLocal 'ColorOPFOR';
	'QS_marker_grid_rspState' setMarkerPosLocal _centroidOffset;
	'QS_marker_grid_rspState' setMarkerText (format ['%1 %3 0 / %2',(toString [32,32,32]),(missionNamespace getVariable 'QS_grid_AIRspTotal'),localize 'STR_QS_Marker_015']);
	if (_entities isNotEqualTo []) then {
		_objectiveIsRequired = 1;
		_objectiveArguments = [
			_entities,
			(count _entities)
		];
		_objectiveCode = {
			params ['_entities','_entitiesTotal'];
			private _c = 0;
			_aliveCount = {(alive _x)} count _entities;
			if ((toLower (markerText 'QS_marker_grid_rspState')) isNotEqualTo (toLower (format ['%4 %3 %1 / %2',((_entitiesTotal - _aliveCount) max 0),(missionNamespace getVariable 'QS_grid_AIRspTotal'),localize 'STR_QS_Marker_015',(toString [32,32,32])]))) then {
				'QS_marker_grid_rspState' setMarkerText (format ['%1 %4 %2 / %3',(toString [32,32,32]),(_entitiesTotal - _aliveCount),(missionNamespace getVariable 'QS_grid_AIRspTotal'),localize 'STR_QS_Marker_015']);
			};
			if (_aliveCount isEqualTo 0) then {
				_c = 1;
			};
			_c;
		};
		_objectiveOnCompleted = {
			'QS_marker_grid_rspState' setMarkerColor 'ColorGREEN';
			['GRID_IG_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_060']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		};
		_objectiveOnFailed = {};
		_return = [
			_type,
			0,
			_objectiveIsRequired,
			_objectiveArguments,
			_objectiveCode,
			_objectiveOnCompleted,
			_objectiveOnFailed
		];
	};
	_return;
};
if (_type isEqualTo 'SITE_IG') exitWith {
	private _objectiveArguments = [];
	private _objectiveIsRequired = 0;
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	_aoPolygon = _aoData # 2;
	private _spawnPos = [0,0,0];
	private _safeDistance = 75;
	private _foundPosition = FALSE;
	private _entities = [];
	private _igFlag = objNull;
	private _igLeader = objNull;
	private _composition = [];
	//comment 'Find position';
	private _searchTimeout = diag_tickTime + 15;
	_allPlayers = allPlayers;
	for '_x' from 0 to 1 step 0 do {
		_spawnPos = ['RADIUS',_aoPos,_aoSize,'LAND',[8,0,0.1,15,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (_spawnPos inPolygon _aoPolygon) then {
			if (((missionNamespace getVariable 'QS_registeredPositions') findif {((_spawnPos distance2D _x) < _safeDistance)}) isEqualTo -1) then {
				if (!([_spawnPos,30,6] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
					if ((([(_spawnPos # 0),(_spawnPos # 1)] nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) then {
						if (([_spawnPos,300,[WEST],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							if (!((toLowerANSI (surfaceType _spawnPos)) in ['#gdtasphalt'])) then {
								_foundPosition = TRUE;
							};
						};
					};
				};
			};
		};
		if (diag_tickTime > _searchTimeout) exitWith {};
		if (_foundPosition) exitWith {};
	};
	if (diag_tickTime > _searchTimeout) exitWith {
		_return;
	};
	_spawnPos set [2,0];
	if ((_spawnPos distance2D _aoPos) < (_aoSize * 2)) then {
		//comment 'Spawn composition';
		{	
			(missionNamespace getVariable 'QS_grid_hiddenTerrainObjects') pushBack _x;
			_x hideObjectGlobal TRUE;
		} forEach (nearestTerrainObjects [_spawnPos,[],15,FALSE,TRUE]);
		_composition = [
			_spawnPos,
			(random 360),
			(call (missionNamespace getVariable 'QS_data_siteIG')),
			TRUE
		] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
		(missionNamespace getVariable 'QS_AI_regroupPositions') pushBack ['QS_ao_HQ',[EAST,RESISTANCE],_spawnPos];
		(missionNamespace getVariable 'QS_registeredPositions') pushBack _spawnPos;
		diag_log format ['QS QS QS * IG Spawned position: %1',_spawnPos];
		missionNamespace setVariable ['QS_grid_IGcomposition',_composition,FALSE];
		private _leaderBuilding = objNull;
		private _potentialBuildings = [];
		private _buildingPositions = [];
		private _building = objNull;
		{
			if (_x isKindOf 'FlagCarrierCore') then {
				_igFlag = _x;
			};
			if ((_x buildingPos -1) isNotEqualTo []) then {
				_potentialBuildings pushBack _x;
			};
		} forEach _composition;
		if (!(isNull _igFlag)) then {
			missionNamespace setVariable ['QS_grid_IGflag',_igFlag,FALSE];
		};
		if (_potentialBuildings isEqualTo []) then {
			{	
				_building = _x;
				_buildingPositions = [_building,(_building buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
				if (_buildingPositions isNotEqualTo []) then {
					_potentialBuildings pushBack _building;
				};
			} forEach _composition;
		};
		if (_potentialBuildings isNotEqualTo []) then {
			_leaderBuilding = selectRandom _potentialBuildings;
			_buildingPositions = _leaderBuilding buildingPos -1;
			_buildingPosition = selectRandom _buildingPositions;
			_igLeader = (createGroup [EAST,TRUE]) createUnit [QS_core_units_map getOrDefault [toLowerANSI 'i_g_soldier_sl_f','i_g_soldier_sl_f'],[-50,-50,0],[],0,'CAN_COLLIDE'];
			_igLeader allowDamage FALSE;
			_igLeader enableDynamicSimulation FALSE;
			_igLeader setVariable ['QS_dynSim_ignore',TRUE,TRUE];
			_igLeader addHeadgear 'H_Construction_basic_red_F';
			_uncertainPos = [
				((_spawnPos # 0) + 200 - (random 400)),
				((_spawnPos # 1) + 200 - (random 400)),
				(_spawnPos # 2)
			];
			{
				_x setMarkerColor 'ColorOPFOR';
				_x setMarkerPos _uncertainPos;
			} forEach [
				'QS_marker_grid_IGmkr',
				'QS_marker_grid_IGcircle'
			];
			_composition pushBack _igLeader;
			missionNamespace setVariable ['QS_grid_IGcomposition',_composition,QS_system_AI_owners];
			(group _igLeader) setCombatMode 'RED';
			(group _igLeader) setBehaviour 'AWARE';
			(group _igLeader) setGroupIdGlobal ['Command'];
			{
				_igLeader enableAIFeature [_x,FALSE];
			} forEach [
				'PATH',
				'COVER'
			];
			_igLeader setPos _buildingPosition;
			_igLeader setUnitPos (selectRandom ['Middle','Down']);
			if ((random 1) > 0.25) then {
				_igLeader removeWeapon (primaryWeapon _igLeader);
				_igLeader addEventHandler [
					'FiredMan',
					{
						(_this # 0) setVehicleAmmo 1;
					}
				];
			};
			missionNamespace setVariable ['QS_grid_IGleader',_igLeader,QS_system_AI_owners];
			missionNamespace setVariable ['QS_grid_IGposition',_spawnPos,QS_system_AI_owners];
			_igLeader spawn {
				uiSleep 1;
				[_this] joinSilent (createGroup [EAST,TRUE]);
				_this setDamage [0,FALSE];
				_this allowDamage TRUE;
				_this setSkill 1;
				(group _this) setCombatMode 'RED';
				(group _this) setBehaviour 'AWARE';
			};
			for '_x' from 0 to 2 step 1 do {
				_igLeader setVariable ['QS_surrenderable',TRUE,TRUE];
			};
			_igLeader addEventHandler [
				'Killed',
				{
					params ['_killed','_killer','_instigator','_usedEffects'];
					['GRID_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_061']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
					if (!isNull _instigator) then {
						if (isPlayer _instigator) then {
							_text = format ['%1 (%2) %3',(name _instigator),(groupID (group _instigator)),localize 'STR_QS_Chat_019'];
							_text remoteExec ['systemChat',-2,FALSE];
						};
					};
				}
			];
			if (worldName in ['Altis','Malden','Tanoa']) then {
				if ((random 1) > 0.666) then {
					if (!(missionNamespace getVariable ['QS_grid_IG_taskActive',FALSE])) then {
						private _table = objNull;
						private _potentialTables = [];
						{
							if ((toLowerANSI ((getModelInfo _x) # 1)) in ['a3\structures_f\civ\camping\campingtable_f.p3d','a3\structures_f\civ\camping\campingtable_small_f.p3d']) then {
								_potentialTables pushBack _x;
							};
						} forEach _composition;
						if (_potentialTables isNotEqualTo []) then {
							_table = selectRandom _potentialTables;
							_intel = createSimpleObject ['Land_File1_F',(getPosASL _table)];
							[_intel,_table] spawn {
								params ['_intel','_table'];
								uiSleep 0.1;
								[1,_intel,[_table,[(random [-0.4,0,0.4]),0,0.45]]] call QS_fnc_eventAttach;
								_intel setDir (random 360);
							};
							{
								for '_i' from 0 to 1 step 1 do {
									_intel setVariable _x;
								};
							} forEach [
								['QS_entity_examine',TRUE,TRUE],
								['QS_entity_examined',FALSE,TRUE],
								['QS_entity_examine_intel',5,TRUE],
								['QS_entity_assocPos',_spawnPos,FALSE],
								['QS_dynSim_ignore',TRUE,TRUE]
							];
							missionNamespace setVariable ['QS_grid_IGintel',_intel,FALSE];
							_composition pushBack _intel;
							missionNamespace setVariable ['QS_grid_IGcomposition',_composition,FALSE];
						};
					};
				};
			};
			_objectiveArguments = [
				_igLeader,
				_spawnPos,
				20,
				_igFlag
			];
			_objectiveCode = {
				params ['_igLeader','_spawnPos','_radius','_flag'];
				private _c = 0;
				if ((!alive _igLeader) || {(_igLeader getVariable ['QS_isSurrendered',FALSE])}) then {
					if (((_spawnPos nearEntities ['CAManBase',_radius]) select {(((side _x) in [EAST,RESISTANCE]) && ((lifeState _x) in ['HEALTHY','INJURED']))}) isEqualTo []) then {
						if (((_spawnPos nearEntities ['CAManBase',_radius]) select {(((side _x) in [WEST]) && ((lifeState _x) in ['HEALTHY','INJURED']))}) isNotEqualTo []) then {
							['GRID_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_062']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
							{
								_x setMarkerPosLocal (missionNamespace getVariable 'QS_grid_IGposition');
								_x setMarkerColor 'ColorWEST';
							} forEach [
								'QS_marker_grid_IGmkr',
								'QS_marker_grid_IGcircle'
							];
							if (!isNull _flag) then {
								if ((flagTexture _flag) isNotEqualTo ((missionNamespace getVariable ['QS_virtualSectors_sidesFlagsTextures',['','a3\data_f\flags\flag_nato_co.paa']]) # 1)) then {
									_flag setFlagTexture ((missionNamespace getVariable ['QS_virtualSectors_sidesFlagsTextures',['','a3\data_f\flags\flag_nato_co.paa']]) # 1);
								};
							};
							_c = 1;
						};
					};
				};
				_c;
			};
			_objectiveOnCompleted = {
				if ((random 1) > 0.5) then {
					private _increment = 36;
					private _incrementVal = 0;
					private _intersectCheckPos = [0,0,0];
					private _intersections = 10;
					private _intersectCheckDist = 1500;
					private _centerPos = position (allPlayers # 0);
					for '_x' from 0 to 8 step 1 do {
						_intersectCheckPos = _centerPos getPos [_intersectCheckDist,_incrementVal];
						if ([_intersectCheckPos,_centerPos,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect')) then {
							_intersections = _intersections - 1;
						};
						_incrementVal = _incrementVal + _increment;
					};
					if (_intersections > 2) then {
						missionNamespace setVariable ['QS_grid_defend_trigger',TRUE,FALSE];
					};
				};
			};
			_objectiveOnFailed = {

			};
			_return = [
				_type,
				0,
				_objectiveIsRequired,
				_objectiveArguments,
				_objectiveCode,
				_objectiveOnCompleted,
				_objectiveOnFailed
			];
		};
	};
	_return;
};
if (_type isEqualTo 'SITE_IDAP') exitWith {
	private _objectiveArguments = [];
	private _objectiveIsRequired = 0;
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	_aoPolygon = _aoData # 2;
	private _position = [0,0,0];
	private _safeDistance = 75;
	private _foundPosition = FALSE;
	private _entities = [];
	private _checkPos = [0,0,0];
	private _composition = [];
	private _intel = [];
	//comment 'Find position';
	private _searchTimeout = diag_tickTime + 15;
	_allPlayers = allPlayers;
	for '_x' from 0 to 1 step 0 do {
		_checkPos = ['RADIUS',_aoPos,_aoSize,'LAND',[5,0,0.1,15,0,FALSE,objNull],FALSE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (_checkPos inPolygon _aoPolygon) then {
			if (((missionNamespace getVariable 'QS_registeredPositions') findif {((_checkPos distance2D _x) < _safeDistance)}) isEqualTo -1) then {
				if (!([_checkPos,30,6] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
					if ((([(_checkPos # 0),(_checkPos # 1)] nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) then {
						if (([_checkPos,300,[WEST],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
							_foundPosition = TRUE;
						};
					};
				};
			};
		};
		if (diag_tickTime > _searchTimeout) exitWith {};
		if (_foundPosition) exitWith {};
	};
	if (diag_tickTime > _searchTimeout) exitWith {
		_return;
	};
	if ((_checkPos distance2D _aoPos) < (_aoSize * 2)) then {
		//comment 'Spawn composition';
		{	
			(missionNamespace getVariable 'QS_grid_hiddenTerrainObjects') pushBack _x;
			_x hideObjectGlobal TRUE;
		} forEach (nearestTerrainObjects [_checkPos,[],12,FALSE,TRUE]);
		_composition = [
			_checkPos,
			(random 360),
			(call (missionNamespace getVariable 'QS_data_IDAPHospital')),
			TRUE
		] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
		_checkPos set [2,0];
		'QS_marker_grid_IDAPloc' setMarkerPos _checkPos;
		(missionNamespace getVariable 'QS_registeredPositions') pushBack _checkPos;
		diag_log format ['QS QS QS * IDAP Spawned position: %1',_checkPos];
		(missionNamespace getVariable 'QS_positions_fieldHospitals') pushBack ['GRID_IG',_checkPos,15];
		missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
		private _positionFound = FALSE;
		private _findTimeout = diag_tickTime + 5;
		private _testPos = [0,0,0];
		private _incrementDir = (random 360);
		private _increment = 15;
		private _nearRoads = [];
		private _allPlayers = allPlayers;
		private _nearRoadsRadius = 150;
		private _distanceFixed = 700;
		private _distanceRandom = 400;
		private _roadSegment = objNull;
		private _roadSegmentPosition = [0,0,0];
		for '_x' from 0 to 1 step 0 do {
			_testPos = _checkPos getPos [(_distanceFixed + (random _distanceRandom)),_incrementDir];
			_incrementDir = _incrementDir + _increment;
			_nearRoads = ([_testPos # 0,_testPos # 1] nearRoads _nearRoadsRadius) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))};
			if (_nearRoads isNotEqualTo []) then {
				_roadSegment = selectRandom _nearRoads;
				_roadSegmentPosition = position _roadSegment;
				if (!([_checkPos,_roadSegmentPosition,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
					_positionFound = TRUE;
				};
			};
			if (diag_tickTime > _findTimeout) exitWith {};
			if (_positionFound) exitWith {};
		};		
		if (_positionFound) then {
			if ((random 1) > 0.666) then {
				if (!(missionNamespace getVariable ['QS_grid_IDAP_taskActive',FALSE])) then {
					private _table = objNull;
					private _potentialTables = [];
					{
						if ((toLowerANSI ((getModelInfo _x) # 1)) in ['a3\structures_f\civ\camping\campingtable_f.p3d','a3\structures_f\civ\camping\campingtable_small_f.p3d']) then {
							_potentialTables pushBack _x;
						};
					} forEach _composition;
					if (_potentialTables isNotEqualTo []) then {
						_table = selectRandom _potentialTables;
						_intel = createSimpleObject ['Land_File1_F',(getPosASL _table)];
						[_intel,_table] spawn {
							params ['_intel','_table'];
							uiSleep 0.1;
							[1,_intel,[_table,[(random [-0.4,0,0.4]),0,0.45]]] call QS_fnc_eventAttach;
							_intel setDir (random 360);
						};
						{
							for '_i' from 0 to 1 step 1 do {
								_intel setVariable _x;
							};
						} forEach [
							['QS_entity_examine',TRUE,TRUE],
							['QS_entity_examined',FALSE,TRUE],
							['QS_entity_examine_intel',4,TRUE],
							['QS_entity_assocPos',_checkPos,FALSE],
							['QS_dynSim_ignore',TRUE,TRUE]
						];
						missionNamespace setVariable ['QS_grid_IDAPintel',_intel,FALSE];
						_composition pushBack _intel;
					};
				};
			};
		};
		missionNamespace setVariable ['QS_grid_IDAPcomposition',_composition,FALSE];
		private _uxoPos = [0,0,0];
		private _uxoPosFound = FALSE;
		_baseMarker = markerPos 'QS_marker_base_marker';
		for '_x' from 0 to 29 step 1 do {
			_uxoPos = ['RADIUS',_aoPos,_aoSize,'LAND',[1,0,-1,-1,0,FALSE,objNull],FALSE,[_aoPos,200,'(1 + forest) * (1 - houses)',25,3],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if ((_uxoPos distance2D _baseMarker) > 750) then {
				if ((_uxoPos distance2D _checkPos) > 100) then {
					if (((missionNamespace getVariable 'QS_registeredPositions') findif {((_uxoPos distance2D _x) < 50)}) isEqualTo -1) then {
						_uxoPosFound = TRUE;
					};
				};
			};
			if (_uxoPosFound) exitWith {};
		};
		if ((_uxoPos distance2D _aoPos) < (_aoSize * 1.25)) then {
			diag_log (format ['UXO field created at %1',_uxoPos]);
			_total = 6 + (round (random 5));
			_uxoTypeData = [
				['BombCluster_01_UXO1_F',0.1,'BombCluster_01_UXO2_F',0.1,'BombCluster_01_UXO3_F',0.1,'BombCluster_01_UXO4_F',0.1],
				['BombCluster_02_UXO1_F',0.1,'BombCluster_02_UXO2_F',0.1,'BombCluster_02_UXO3_F',0.1,'BombCluster_02_UXO4_F',0.1],
				['BombCluster_03_UXO1_F',0.1,'BombCluster_03_UXO2_F',0.1,'BombCluster_03_UXO3_F',0.1,'BombCluster_03_UXO4_F',0.1]
			];
			_uxoArray = [_uxoPos,25,_total,(selectRandom _uxoTypeData)] call (missionNamespace getVariable 'QS_fnc_aoCreateUXOfield');
			if (_uxoArray isNotEqualTo []) then {
				_uncertaintyPos = [
					((_uxoPos # 0) + 50 - (random 100)),
					((_uxoPos # 1) + 50 - (random 100)),
					0
				];
				{
					_x setMarkerColorLocal 'ColorOrange';
					_x setMarkerPosLocal _uncertaintyPos;
					_x setMarkerText (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_012']);
				} forEach [
					'QS_marker_grid_IDAPmkr',
					'QS_marker_grid_IDAPcircle'
				];
				missionNamespace setVariable ['QS_grid_IDAP_uxoField',_uxoArray,FALSE];
				_threshold = (round (_total / 3));
				_objectiveArguments = [
					_uxoArray,
					_total,
					_threshold
				];
				_objectiveCode = {
					params ['_uxos','_total','_threshold'];
					private _c = 0;
					if (({((!isNull _x) || (mineActive _x))} count _uxos) < _threshold) then {
						_c = 1;
					};
					_c;
				};
				_objectiveOnCompleted = {
					['GRID_IDAP_UPDATE',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_063']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
					{
						_x setMarkerColorLocal 'ColorGreen';
						_x setMarkerText (format ['%1 %2 (%3)',(toString [32,32,32]),localize 'STR_QS_Marker_012',localize 'STR_QS_Marker_016']);
					} forEach [
						'QS_marker_grid_IDAPmkr',
						'QS_marker_grid_IDAPcircle'
					];
					'QS_marker_grid_IDAPcircle' setMarkerAlpha 0;
				};
				_objectiveOnFailed = {};
				_return = [
					_type,
					0,
					_objectiveIsRequired,
					_objectiveArguments,
					_objectiveCode,
					_objectiveOnCompleted,
					_objectiveOnFailed
				];
			};
		} else {
			diag_log 'QS uxo field failed';
		};
	};
	_return;
};
if (_type isEqualTo 'MORTAR_DELAYED') exitWith {
	_objectiveDelay = diag_tickTime + (900 + (random 900));
	_objectiveIsRequired = 0;
	_objectiveArguments = [
		_objectiveDelay
	];
	_objectiveCode = {
		params ['_delay'];
		private _c = 0;
		if (diag_tickTime > _delay) then {
			_c = 1;
		};
		_c;
	};
	_objectiveOnCompleted = {
		[] call (missionNamespace getVariable 'QS_fnc_aoMortarSite');
	};
	_objectiveOnFailed = {
	
	};
	_return = [
		_type,
		0,
		_objectiveIsRequired,
		_objectiveArguments,
		_objectiveCode,
		_objectiveOnCompleted,
		_objectiveOnFailed
	];
	_return;
};
if (_type isEqualTo 'INTEL') exitWith {
	private _objectiveArguments = [];
	private _objectiveIsRequired = 0;
	private _objectiveOnCompleted = {};
	private _objectiveOnFailed = {};
	diag_log 'Intel 0';
	private _entities = [];
	private _markers = [];
	private _table = objNull;
	private _intel = objNull;
	private _buildingPositionsInPolygon = _terrainData # 6;
	if ((_terrainData # 7) isNotEqualTo []) then {
		if ((count (_terrainData # 7)) > 20) then {
			_buildingPositionsInPolygon = _terrainData # 7;
		};
	};
	private _buildingPosition = [0,0,0];
	private _buildingPositionIndex = -1;
	private _tablePosition = [0,0,0];
	private _mkr = '';
	private _intersections = [];
	private _intersectedObject = [];
	private _building = [];
	private _buildingPositionASL = [0,0,0];
	private _monitorStructure = FALSE;
	private _intelDetectors = [];
	private _entityIntels = [];
	private _j = 0;
	_intelCount = count (missionNamespace getVariable ['QS_grid_intelTargets',[]]);
	if (_intelCount > 0) then {
		if ((count _buildingPositionsInPolygon) >= _intelCount) then {
			for '_i' from 0 to (_intelCount - 1) step 1 do {
				((missionNamespace getVariable 'QS_grid_intelTargets') # _i) params [
					'_intelType',
					'_intelEntity',
					'_intelPosition',
					'_intelDetector'
				];
				_intelDetectors pushBack _intelDetector;
				_entityIntels = [];
				for '_j' from 0 to 2 step 1 do {
					_monitorStructure = FALSE;
					if (_intelType isEqualTo 'TUNNEL_ENTRANCE') then {
						//comment 'Find position';
						
						_buildingPosition = selectRandom _buildingPositionsInPolygon;
						_buildingPositionIndex = _buildingPositionsInPolygon find _buildingPosition;
						_buildingPositionsInPolygon set [_buildingPositionIndex,FALSE];
						_buildingPositionsInPolygon deleteAt _buildingPositionIndex;
						
						diag_log format ['QS intel building position: %1',_buildingPosition];
						
						//comment 'Get building';
						_buildingPositionASL = AGLToASL _buildingPosition;
						_intersections = lineIntersectsSurfaces [
							_buildingPositionASL,
							_buildingPositionASL vectorAdd [0,0,50],
							objNull,
							objNull,
							TRUE,
							1,
							'GEOM',
							'VIEW',
							TRUE
						];
						if (_intersections isEqualTo []) then {
							_intersections = lineIntersectsSurfaces [
								_buildingPositionASL,
								_buildingPositionASL vectorAdd [0,0,-50],
								objNull,
								objNull,
								TRUE,
								1,
								'GEOM',
								'VIEW',
								TRUE
							];
						};
						if (_intersections isNotEqualTo []) then {
							_intersectedObject = (_intersections # 0) # 3;
							if (!isNull _intersectedObject) then {
								if (([_intersectedObject,(_intersectedObject buildingPos -1)] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions')) isNotEqualTo []) then {
									_monitorStructure = TRUE;
								};
							};
						};
						
						//comment 'Create entities';
						_buildingPositionASL = _buildingPositionASL vectorAdd [0,0,0.15];
						_table = createSimpleObject ['a3\structures_f\civ\camping\campingtable_small_f.p3d',_buildingPositionASL];
						_table setDir (random 360);
						_table setVectorUp [0,0,1];
						_entities pushBack _table;
						_intel = createSimpleObject ['Land_File1_F',_buildingPositionASL];
						_intel setPosASL _buildingPositionASL;
						[_intel,_table] spawn {
							params ['_intel','_table'];
							uiSleep 0.1;
							[1,_intel,[_table,[(random [-0.4,0,0.4]),0,0.47]]] call QS_fnc_eventAttach;
							_intel setDir (random 360);
						};
						_entities pushBack _intel;
						_entityIntels pushBack _intel;
						
						//comment 'Assign variables';
						
						diag_log (str _j);
						
						if (_j isEqualTo 0) then {
							_mkr = createMarker [(format ['QS_marker_intel_%1',_buildingPosition]),[-1000,-1000,0]];
							_mkr setMarkerTextLocal (toString [32,32,32]);
							_mkr setMarkerAlphaLocal 0;
							_mkr setMarkerShapeLocal 'ELLIPSE';
							_mkr setMarkerBrushLocal 'Border';
							_mkr setMarkerSizeLocal [50,50];
							_mkr setMarkerColorLocal 'ColorOPFOR';
							[_mkr,_intelPosition] spawn {
								params ['_mkr','_intelPosition'];
								uiSleep 0.5;
								_mkr setMarkerPos [
									((_intelPosition # 0) - 45 + (random 90)),
									((_intelPosition # 1) - 45 + (random 90)),
									0
								];
								
							};
							(missionNamespace getVariable 'QS_grid_intelMarkers') pushBack _mkr;
						};
						{
							for '_y' from 0 to 1 step 1 do {
								_intel setVariable _x;
							};
						} forEach [
							['QS_entity_examine',TRUE,TRUE],
							['QS_entity_examined',FALSE,TRUE],
							['QS_entity_examine_intel',3,TRUE],
							['QS_dynSim_ignore',TRUE,TRUE]
						];
						if (_monitorStructure) then {
							_intersectedObject allowDamage FALSE;
							(missionNamespace getVariable 'QS_grid_intelHouses') pushBack [_intersectedObject,[_table,_intel]];
						};
					};
					if (_intelType isEqualTo 'IG_HVT') then {
					
					};
					if (_intelType isEqualTo 'CACHE_SUPPLY') then {
					
					};
				};
				if (_entityIntels isNotEqualTo []) then {
					{
						_x setVariable ['QS_intel_marker',_mkr,FALSE];
						_x setVariable ['QS_entity_intel_copy',_entityIntels,FALSE];
					} forEach _entityIntels;
					_intelDetector setVariable ['QS_entity_assocMkrs',[_mkr],FALSE];
					_intelDetector setVariable ['QS_entity_assocIntels',_entityIntels,FALSE];
					_intelDetector addEventHandler [
						'Killed',
						{
							params ['_entity','_killer','_instigator','_usedEffects'];
							if ((_entity getVariable ['QS_entity_assocIntels',[]]) isNotEqualTo []) then {
								{
									_x hideObjectGlobal TRUE;
								} forEach (_entity getVariable ['QS_entity_assocIntels',[]]);
							};
							if ((_entity getVariable ['QS_entity_assocMkrs',[]]) isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (_entity getVariable ['QS_entity_assocMkrs',[]]);
							};
						}
					];
					_intelDetector addEventHandler [
						'Deleted',
						{
							params ['_entity'];
							if ((_entity getVariable ['QS_entity_assocIntels',[]]) isNotEqualTo []) then {
								{
									_x hideObjectGlobal TRUE;
								} forEach (_entity getVariable ['QS_entity_assocIntels',[]]);
							};
							if ((_entity getVariable ['QS_entity_assocMkrs',[]]) isNotEqualTo []) then {
								{
									deleteMarker _x;
								} forEach (_entity getVariable ['QS_entity_assocMkrs',[]]);
							};
						}
					];
				};
			};
		} else {
			//comment 'Not enough building positions';
		};
	} else {
		//comment 'No intel required';
	};
	missionNamespace setVariable ['QS_grid_intelEntities',_entities,FALSE];
	diag_log 'Intel 1';
	_return;
};
_return;