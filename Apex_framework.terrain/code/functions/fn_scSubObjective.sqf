/*/
File: fn_scSubObjective.sqf
Author: 

	Quiksilver

Last Modified:

	10/08/2022 A3 2.10 by Quiksilver

Description:

	SC Sub Objectives
	
Types:

	Datalink
		- Drone generator
		- Satellite intel
		- Skill coefficient modifier?
		- Remote target receive/report
	Vehicle
		- Armor reinforce
		- Helicopter reinforce
	Equipment
		- AA launch
		- AT launch
		- Viper / Recon
		
19:07:22 "****************************************************"
19:07:23 "***** SC SUB OBJ ***** CREATE *****"
19:07:23 Error in expression <bjects [_centerPos,['House'],_centerPos * 0.9,TRUE]) select {((!isObjectHidden _>
19:07:23   Error position: <* 0.9,TRUE]) select {((!isObjectHidden _>
19:07:23   Error *: Type Array, expected Number,Not a Number
19:07:23 File mpmissions\__cur_mp.Tanoa\code\functions\fn_scSubObjective.sqf..., line 75
19:20:39 BEServer: registering a new player #1556180685
19:20:49 "***** onPlayerConnected ***** [1.55618e+009,""76561198084065754"",""Quiksilver"",true,5
____________________________________________________________________________/*/

params ['_type','_subType','_data'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	diag_log '***** SC SUB OBJ ***** DELETE *****';
	if (_subType isEqualTo 'INTEL') then {
	
	};
	if (_subType isEqualTo 'VEHICLE') then {
	
	};
	if (_subType isEqualTo 'GEAR') then {
	
	};
	if (_subType isEqualTo 'SUPPORT') then {
	
	};
	if (_subType isEqualTo 'JAMMER') then {
	
	};
	_return;
};
if (_type isEqualTo 1) exitWith {
	diag_log '***** SC SUB OBJ ***** CREATE *****';
	_basePosition = markerPos 'QS_marker_base_marker';
	_fobPosition = markerPos 'QS_marker_module_fob';
	_centerPos = missionNamespace getVariable 'QS_AOpos';
	_hqPos = markerPos 'QS_marker_hqMarker';
	private _centerRadius = (missionNamespace getVariable 'QS_aoSize') * 0.75;
	private _positionFound = FALSE;
	private _position = [0,0,0];
	private _uncertaintyPos = [0,0,0];
	_timeToFind = diag_tickTime + 10;
	private _attempts = 0;
	private _totalAttempts = 0;

	if (_subType isEqualTo 'INTEL') then {
		private _usedSettlementPosition = FALSE;
		private _building = objNull;
		private _dir = 0;
		if ((random 1) > 0.5) then {
			if (missionNamespace getVariable ['QS_ao_terrainIsSettlement',FALSE]) then {
				if ((missionNamespace getVariable ['QS_ao_objsUsedTerrainBldgs',0]) <= 1) then {
					_buildingTypes = missionNamespace getVariable ['QS_data_smallBuildingTypes_12',[]];
					_buildingList = (nearestObjects [_centerPos,['House'],QS_aoSize * 0.9,TRUE]) select {((!isObjectHidden _x) && ((sizeOf (typeOf _x)) >= 12))};
					if (_buildingList isNotEqualTo []) then {
						_position = [0,0,0];
						for '_i' from 0 to 9 step 1 do {
							_building = selectRandom _buildingList;
							_position = getPosATL _building;
							if (
								((_position distance2D _hqPos) > 50) && 
								(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,50,50,0,FALSE]) isEqualTo [])
							) exitWith {};
						};
						_usedSettlementPosition = TRUE;
						_positionFound = TRUE;
						_dir = getDir _building;
						_building allowDamage FALSE;
						_building hideObjectGlobal TRUE;
					};
				};
			};
		};
		if (!_positionFound) then {
			for '_x' from 0 to 1 step 0 do {
				if (diag_tickTime > _timeToFind) exitWith {};
				if (_positionFound) exitWith {};
				_position = [
					'RADIUS',
					_centerPos,
					_centerRadius,
					'LAND',
					[1,0,-1,-1,0,FALSE,objNull],
					FALSE,
					[_centerPos,300,'(1 + forest) * (1 - houses)',15,3],
					[],
					TRUE
				] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
				if (
					((_position distance2D _basePosition) > 1000) &&
					{((_position distance2D _fobPosition) > 150)} &&
					{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,150,150,0,FALSE]) isEqualTo [])} &&
					{((getTerrainHeightASL _position) > 2)} &&
					{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 6)} &&
					{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -6)} &&
					{((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
					{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
					{((nearestObjects [_position,['House','Building'],7,FALSE]) isEqualTo [])} &&
					{((nearestTerrainObjects [
						_position,
						[
							"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
							"FENCE","WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
							"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
						],
						10,
						FALSE,
						TRUE
					]) isEqualTo [])}
				) then {
					_positionFound = TRUE;
				};
				if (_attempts > 100) then {
					_centerRadius = _centerRadius + 3;
					_attempts = 0;
				};
				_attempts = _attempts + 1;
				_totalAttempts = _totalAttempts + 1;
			};
		};
		if (_positionFound) then {
			private _composition = [];
			_data = [
				['Land_TTowerSmall_1_F',[2.8,2.5,2],0,{}],
				['Land_SatelliteAntenna_01_F',[-1,1,3.2],(random 360),{}],
				['Land_CampingTable_small_F',[1,3,0.26],180,{}],
				['Land_TripodScreen_01_dual_v1_F',[1,3.7,0.7],180,{}],
				['Land_SatellitePhone_F',[1.15,3,0.85],20,{
					missionNamespace setVariable ['QS_virtualSectors_sub_1_obj',_this,TRUE];
					for '_x' from 0 to 2 step 1 do {
						_this setVariable ['QS_sc_subObj_1',TRUE,TRUE];
						_this setVariable ['QS_secureable',TRUE,TRUE];
					};
				}]
			];
			_houseType = [
				'Land_Cargo_House_V3_F',
				'Land_Cargo_House_V4_F'
			] select (worldName in ['Tanoa','Enoch']);
			_position set [2,0];
			_house = createVehicle [_houseType,_position,[],0,'CAN_COLLIDE'];
			_house allowDamage FALSE;
			_house setDir ([random 360,_dir] select _usedSettlementPosition);
			_composition pushBack _house;
			if (_usedSettlementPosition) then {
				(missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _building;
			} else {
				{
					if ((_x distance2D _position) < 8) then {
						(missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _x;
						_x hideObjectGlobal TRUE;
					};
				} forEach (nearestTerrainObjects [_house,[],20,FALSE,TRUE]);
			};
			missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
			private _configClass = configNull;
			private _model = '';
			private _type = '';
			private _object = objNull;
			private _terminal = objNull;
			private _array = [];
			{
				_array = _x;
				_array params ['_type','_attachPoint','_dir','_code'];
				_configClass = configFile >> 'CfgVehicles' >> _type;
				_model = getText (_configClass >> 'model');
				if ((_model select [0,1]) isEqualTo '\') then {
					_model = _model select [1];
				};
				if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
					_model = _model + '.p3d';
				};
				_object = createSimpleObject [_model,_position];
				[1,_object,[_house,_attachPoint]] call QS_fnc_eventAttach;
				_object setDir _dir;
				_composition pushBack _object;
				if (_code isNotEqualTo {}) then {
					_object call _code;
				};
			} forEach _data;
			/*/
			_terminal = createSimpleObject ['a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_F.p3d',_position];
			[1,_terminal,[_house,[0.75,2.8,0.65]]] call QS_fnc_eventAttach;
			_composition pushBack _terminal;
			/*/
			_grpTypes = [
				'OIA_InfSentry',
				'OIA_InfSentry',
				'OI_reconSentry'
			];	
			private _grp = [_position,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				_x setUnitLoadout (QS_core_units_map getOrDefault [toLowerANSI 'o_soldier_uav_f','o_soldier_uav_f']);
				_x allowDamage FALSE;
				_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP']);
				_x setVariable ['QS_hidden',TRUE,TRUE];
				_composition pushBack _x;
			} forEach (units _grp);
			(units _grp) spawn {
				uiSleep 5;
				{
					_x allowDamage TRUE;
				} forEach _this;
			};
			[_position,10,(units _grp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
			if ((random 1) > 0.666) then {
				_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
				[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
				_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
				_grp setVariable ['QS_AI_GRP_DATA',[_position,50,50,[]],FALSE];
				_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,serverTime,-1],FALSE];
				_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				{
					_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP']);
					0 = _composition pushBack _x;
				} forEach (units _grp);
			};
			_house spawn {
				uiSleep 1;
				{
					[0,_x] call QS_fnc_eventAttach;
				} forEach (attachedObjects _this);
			};
			_uncertaintyPos = [((_position # 0) + (100 - (random 200))),((_position # 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_0',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_025']);
			_marker1 setMarkerSizeLocal [0.5,0.5];
			_marker1 setMarkerPosLocal _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') pushBack _marker1;
			_marker2 = createMarker ['QS_marker_virtualSectors_sub_00',[-1000,-1000,0]];
			_marker2 setMarkerAlphaLocal 0;
			_marker2 setMarkerShapeLocal 'ELLIPSE';
			_marker2 setMarkerBrushLocal 'Border';
			_marker2 setMarkerColorLocal 'ColorOPFOR';
			_marker2 setMarkerTextLocal (toString [32,32,32]);
			_marker2 setMarkerSizeLocal [100,100];
			_marker2 setMarkerPosLocal _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') pushBack _marker2;
			_description = format [
				'%1<br/><br/>%2<br/><br/>%3',
				localize 'STR_QS_Task_055',
				localize 'STR_QS_Task_056',
				localize 'STR_QS_Task_057'
			];
			_title = localize 'STR_QS_Task_058';
			_tooltip = localize 'STR_QS_Task_059';
			_icon = 'intel';
			[
				'QS_virtualSectors_sub_1_task',
				TRUE,
				[
					_description,
					_title,
					_tooltip
				],
				_uncertaintyPos,
				'CREATED',
				5,
				FALSE,
				TRUE,
				_icon,
				TRUE
			] call (missionNamespace getVariable 'BIS_fnc_setTask');
			missionNamespace setVariable ['QS_virtualSectors_sub_1_active',TRUE,FALSE];
			_return = [2,_subType,[_position,{},_composition]];
		};	
	};
	if (_subType isEqualTo 'VEHICLE') then {
		private _attempts = 0;
		private _totalAttempts = 0;
		for '_x' from 0 to 999 step 1 do {
			if (diag_tickTime > _timeToFind) exitWith {};
			if (_positionFound) exitWith {};
			_position = [
				'RADIUS',
				_centerPos,
				_centerRadius,
				'LAND',
				[1,0,-1,-1,0,FALSE,objNull],
				FALSE,
				[_centerPos,300,'(1 + forest) * (1 - houses) * (1 + meadow)',15,3],
				[],
				TRUE
			] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				((_position distance2D _basePosition) > 1000) &&
				{((_position distance2D _fobPosition) > 150)} &&
				{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,200,200,0,FALSE]) isEqualTo [])} &&
				{((getTerrainHeightASL _position) > 2)} &&
				{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 8)} &&
				{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -8)} &&
				{((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
				{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
				{((nearestObjects [_position,['House','Building'],10,FALSE]) isEqualTo [])} &&
				{((nearestTerrainObjects [
					_position,
					[
						"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
						"FENCE","WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
						"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
					],
					10,
					FALSE,
					TRUE
				]) isEqualTo [])}
			) then {
				_positionFound = TRUE;
			};
			if (_attempts > 100) then {
				_centerRadius = _centerRadius + 10;
				_attempts = 0;
			};
			_attempts = _attempts + 1;
			_totalAttempts = _totalAttempts + 1;
		};
		if (_positionFound) then {
			missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
			{	
				if ((_x distance2D _position) < 8) then {
					0 = (missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _x;
					_x hideObjectGlobal TRUE;
				};
			} forEach (nearestTerrainObjects [_position,[],20,FALSE,TRUE]);
			_compositionData = selectRandom (missionNamespace getVariable 'QS_compositions_radioTower');
			_composition = [_position,0,(call _compositionData)] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
			private _mines = [];
			if (((random 1) > 0.666) || ((_position distance2D _centerPos) > _centerRadius)) then {
				missionNamespace setVariable ['QS_ao_createDelayedMinefield',TRUE,FALSE];
			};
			_grpTypes = [
				'OIA_InfSentry',
				'OIA_InfSentry'
			];
			private _grp = [_position,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				_x setUnitPosWeak 'UP';
				_x allowDamage FALSE;
				_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP']);
				0 = _composition pushBack _x;
			} forEach (units _grp);
			(units _grp) spawn {
				uiSleep 5;
				{
					_x allowDamage TRUE;
				} forEach _this;
			};
			if (_mines isEqualTo []) then {
				if ((random 1) > 0.666) then {
					_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
					[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
					_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
					_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
					_grp setVariable ['QS_AI_GRP_DATA',[_position,50,50,[]],FALSE];
					_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,serverTime,-1],FALSE];
					_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
					{
						0 = _composition pushBack _x;
					} forEach (units _grp);
				};
			};
			_uncertaintyPos = [((_position # 0) + (100 - (random 200))),((_position # 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_1',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_026']);
			_marker1 setMarkerSizeLocal [0.5,0.5];
			_marker1 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') pushBack _marker1;
			_marker2 = createMarker ['QS_marker_virtualSectors_sub_11',[-1000,-1000,0]];
			_marker2 setMarkerAlphaLocal 0;
			_marker2 setMarkerShapeLocal 'ELLIPSE';
			_marker2 setMarkerBrushLocal 'Border';
			_marker2 setMarkerColorLocal 'ColorOPFOR';
			_marker2 setMarkerTextLocal (toString [32,32,32]);
			_marker2 setMarkerSizeLocal [100,100];
			_marker2 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') pushBack _marker2;
			_description = format [
				'%1<br/><br/>%2<br/><br/>%3',
				localize 'STR_QS_Task_060',
				localize 'STR_QS_Task_061',
				localize 'STR_QS_Task_062'
			];
			_title = localize 'STR_QS_Task_063';
			_tooltip = localize 'STR_QS_Task_064';
			_icon = 'destroy';
			[
				'QS_virtualSectors_sub_2_task',
				TRUE,
				[
					_description,
					_title,
					_tooltip
				],
				_uncertaintyPos,
				'CREATED',
				5,
				FALSE,
				TRUE,
				_icon,
				TRUE
			] call (missionNamespace getVariable 'BIS_fnc_setTask');
			missionNamespace setVariable ['QS_virtualSectors_sub_2_active',TRUE,FALSE];
			_return = [2,_subType,[_position,{},_composition]];
		};
	};
	if (_subType isEqualTo 'GEAR') then {
		private _attempts = 0;
		private _totalAttempts = 0;
		for '_x' from 0 to 999 step 1 do {
			if (diag_tickTime > _timeToFind) exitWith {};
			if (_positionFound) exitWith {};
			_position = [
				'RADIUS',
				_centerPos,
				_centerRadius,
				'LAND',
				[1,0,-1,-1,0,FALSE,objNull],
				FALSE,
				[_centerPos,300,'(1 + forest) * (1 - houses) * (1 + meadow)',15,3],
				[],
				TRUE
			] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (
				((_position distance2D _basePosition) > 1000) &&
				{((_position distance2D _fobPosition) > 150)} &&
				{(((missionNamespace getVariable 'QS_registeredPositions') inAreaArray [_position,150,150,0,FALSE]) isEqualTo [])} &&
				{((getTerrainHeightASL _position) > 2)} &&
				{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 7)} &&
				{(([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -7)} &&
				{((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo [])} &&
				{(!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))} &&
				{((nearestObjects [_position,['House','Building'],18,FALSE]) isEqualTo [])} &&
				{((nearestTerrainObjects [
					_position,
					[
						"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
						"FENCE","WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
						"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
					],
					7,
					FALSE,
					TRUE
				]) isEqualTo [])}
			) then {
				_positionFound = TRUE;
			};
			if (_attempts > 100) then {
				_centerRadius = _centerRadius + 3;
				_attempts = 0;
			};
			_attempts = _attempts + 1;
			_totalAttempts = _totalAttempts + 1;
		};
		if (_positionFound) then {
			missionNamespace setVariable ['QS_registeredPositions',((missionNamespace getVariable 'QS_registeredPositions') + [_position]),FALSE];
			_compositionData = selectRandom (missionNamespace getVariable 'QS_sc_compositions_sd');
			_composition = [_position,(random 360),(call _compositionData)] call (missionNamespace getVariable 'QS_fnc_serverObjectsMapper');
			{
				if (_x isKindOf 'Reammobox_F') then {
					[_x,0] call (missionNamespace getVariable 'QS_fnc_customInventory');
				};
			} forEach _composition;
			(missionNamespace getVariable 'QS_AI_regroupPositions') pushBack ['QS_ao_SD',[EAST,RESISTANCE],_position];
			_grpTypes = [
				'OIA_InfTeam_AA',
				'OIA_InfTeam_AT'
			];
			private _grp = [_position,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				_x allowDamage FALSE;
				0 = _composition pushBack _x;
			} forEach (units _grp);
			(units _grp) spawn {
				uiSleep 5;
				{
					_x allowDamage TRUE;
				} forEach _this;
			};
			[_position,25,(units _grp),['House','Building']] spawn (missionNamespace getVariable 'QS_fnc_garrisonUnits');
			if ((random 1) > 0.666) then {
				_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,(selectRandom ['OIA_InfSentry','OIA_InfSentry']),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
				[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
				_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
				_grp setVariable ['QS_AI_GRP_DATA',[_position,50,50,[]],FALSE];
				_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,serverTime,-1],FALSE];
				_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
				{
					0 = _composition pushBack _x;
				} forEach (units _grp);
			};
			_uncertaintyPos = [((_position # 0) + (100 - (random 200))),((_position # 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_2',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_023']);
			_marker1 setMarkerSizeLocal [0.5,0.5];
			_marker1 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') pushBack _marker1;
			_marker2 = createMarker ['QS_marker_virtualSectors_sub_22',[-1000,-1000,0]];
			_marker2 setMarkerAlphaLocal 0;
			_marker2 setMarkerShapeLocal 'ELLIPSE';
			_marker2 setMarkerBrushLocal 'Border';
			_marker2 setMarkerColorLocal 'ColorOPFOR';
			_marker2 setMarkerTextLocal (toString [32,32,32]);
			_marker2 setMarkerSizeLocal [100,100];
			_marker2 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') pushBack _marker2;
			missionNamespace setVariable ['QS_virtualSectors_sd_position',_position,FALSE];
			_description = format [
				'%1<br/><br/>%2<br/><br/>%3<br/><br/>%4',
				localize 'STR_QS_Task_065',
				localize 'STR_QS_Task_066',
				localize 'STR_QS_Task_067',
				localize 'STR_QS_Task_068'
			];
			_title = localize 'STR_QS_Task_069';
			_tooltip = localize 'STR_QS_Task_069';
			_icon = 'rearm';
			[
				'QS_virtualSectors_sub_3_task',
				TRUE,
				[
					_description,
					_title,
					_tooltip
				],
				_uncertaintyPos,
				'CREATED',
				5,
				FALSE,
				TRUE,
				_icon,
				TRUE
			] call (missionNamespace getVariable 'BIS_fnc_setTask');
			missionNamespace setVariable ['QS_virtualSectors_sub_3_active',TRUE,FALSE];
			_return = [2,_subType,[_position,{},_composition]];
		};
	};
	if (_subType isEqualTo 'SUPPORT') then {

		
	};
	if (_subType isEqualTo 'JAMMER') then {
		private _position = [0,0,0];
		for '_x' from 0 to 9 step 1 do {
			_position = ['RADIUS',_centerPos,(_centerRadius * 0.666),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (((_position distance2D _basePosition) > 500) && ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isEqualTo []) && (!([_position,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
		};
		_drawBlackCircle = FALSE;
		_jammer = [1,'QS_ao_jammer_1',_position,QS_aoPos,QS_aoSize,TRUE,_drawBlackCircle] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
		if (alive _jammer) then {
			_composition = [_jammer];
			_return = [2,_subType,[_position,{},_composition]];
		};
	};
	_return;
};
if (_type isEqualTo 2) exitWith {
	diag_log '***** SC SUB OBJ ***** EVALUATE *****';
	_return = _this;
	if (_subType isEqualTo 'INTEL') then {
	
	};
	if (_subType isEqualTo 'VEHICLE') then {
	
	};
	if (_subType isEqualTo 'GEAR') then {
	
	};
	if (_subType isEqualTo 'SUPPORT') then {
	
	};
	if (_subType isEqualTo 'JAMMER') then {
	
	};
	_return;
};
_return;