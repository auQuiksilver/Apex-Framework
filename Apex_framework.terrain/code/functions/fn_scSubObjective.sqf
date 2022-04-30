/*/
File: fn_scSubObjective.sqf
Author: 

	Quiksilver

Last Modified:

	11/09/2017 A3 1.70 by Quiksilver

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
____________________________________________________________________________/*/

params ['_type','_subType','_data'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	diag_log '***** SC SUB OBJ ***** DELETE *****';
	comment 'Delete';
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
	private _centerRadius = (missionNamespace getVariable 'QS_aoSize') * 0.75;
	private _positionFound = FALSE;
	private _position = [0,0,0];
	private _uncertaintyPos = [0,0,0];
	_timeToFind = diag_tickTime + 10;
	private _attempts = 0;
	private _totalAttempts = 0;
	comment 'Create';
	if (_subType isEqualTo 'INTEL') then {
		comment 'Datalink';
		comment 'Find position';
		_attempts = 0;
		_totalAttempts = 0;
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
			if ((_position distance2D _basePosition) > 1000) then {
				if ((_position distance2D _fobPosition) > 150) then {
					if (((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 200)}) isEqualTo -1) then {
						if ((getTerrainHeightASL _position) > 2) then {
							if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 6) then {
								if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -6) then {
									if ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
										if (!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
											if ((nearestObjects [_position,['House','Building'],7,FALSE]) isEqualTo []) then {
												if ((nearestTerrainObjects [
													_position,
													[
														"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
														"FENCE","WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
														"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
													],
													10,
													FALSE,
													TRUE
												]) isEqualTo []) then {
													_positionFound = TRUE;
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
			if (_attempts > 100) then {
				_centerRadius = _centerRadius + 3;
				_attempts = 0;
			};
			_attempts = _attempts + 1;
			_totalAttempts = _totalAttempts + 1;
		};
		comment 'Spawn composition';
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
			_composition pushBack _house;
			_house setDir (random 360);
			{	
				if ((_x distance2D _position) < 8) then {
					0 = (missionNamespace getVariable 'QS_virtualSectors_hiddenTerrainObjects') pushBack _x;
					_x hideObjectGlobal TRUE;
				};
			} forEach (nearestTerrainObjects [_house,[],20,FALSE,TRUE]);
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
				if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
					_model = _model + '.p3d';
				};
				_object = createSimpleObject [_model,_position];
				_object attachTo [_house,_attachPoint];
				_object setDir _dir;
				_composition pushBack _object;
				if (!(_code isEqualTo {})) then {
					_object call _code;
				};
			} forEach _data;
			/*/
			_terminal = createSimpleObject ['a3\Drones_F\Weapons_F_Gamma\Items\UAV_controller_F.p3d',_position];
			_terminal attachTo [_house,[0.75,2.8,0.65]];
			_composition pushBack _terminal;
			/*/
			comment 'Force protection';
			_grpTypes = [
				'OIA_InfSentry',
				'OIA_InfSentry',
				'OI_reconSentry'
			];	
			private _grp = [_position,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				_x setUnitLoadout (['o_soldier_uav_f','o_t_soldier_uav_f'] select (worldName in ['Tanoa','Enoch']));
				_x allowDamage FALSE;
				_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP']);
				_x setVariable ['QS_hidden',TRUE,TRUE];
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
				_grp = [(_position getPos [(random 30),(random 360)]),(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
				[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_grp setVariable ['QS_AI_GRP',TRUE,FALSE];
				_grp setVariable ['QS_AI_GRP_CONFIG',['SC','INF_GENERAL',(count (units _grp))],FALSE];
				_grp setVariable ['QS_AI_GRP_DATA',[_position,50,50,[]],FALSE];
				_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,diag_tickTime,-1],FALSE];
				{
					_x setUnitPosWeak (selectRandom ['UP','MIDDLE','UP']);
					0 = _composition pushBack _x;
				} forEach (units _grp);
			};
			_house spawn {
				uiSleep 1;
				{
					detach _x;
				} forEach (attachedObjects _this);
			};
			_uncertaintyPos = [((_position select 0) + (100 - (random 200))),((_position select 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_0',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1Datalink',(toString [32,32,32])]);
			_marker1 setMarkerSizeLocal [0.5,0.5];
			_marker1 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') pushBack _marker1;
			_marker2 = createMarker ['QS_marker_virtualSectors_sub_00',[-1000,-1000,0]];
			_marker2 setMarkerAlphaLocal 0;
			_marker2 setMarkerShapeLocal 'ELLIPSE';
			_marker2 setMarkerBrushLocal 'Border';
			_marker2 setMarkerColorLocal 'ColorOPFOR';
			_marker2 setMarkerTextLocal (toString [32,32,32]);
			_marker2 setMarkerSizeLocal [100,100];
			_marker2 setMarkerPos _uncertaintyPos;
			(missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') pushBack _marker2;
			_description = 'Locate and secure the enemy datalink.<br/><br/>The enemy datalink allows the enemy to more easily communicate and share information on our troop movements, strength and force disposition. With this data they can adapt and better counter our attacks.<br/><br/> This datalink also allows them to call in UAV recon support. Securing the datalink will deny the enemy these benefits.';
			_title = 'Secure Datalink';
			_tooltip = 'Datalink';
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
		comment 'Radio Tower';
		comment 'Find position';
		private _attempts = 0;
		private _totalAttempts = 0;
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
				[_centerPos,300,'(1 + forest) * (1 - houses) * (1 + meadow)',15,3],
				[],
				TRUE
			] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if ((_position distance2D _basePosition) > 1000) then {
				if ((_position distance2D _fobPosition) > 150) then {
					if (((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 200)}) isEqualTo -1) then {
						if ((getTerrainHeightASL _position) > 2) then {
							if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 8) then {
								if (([_position,20] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -8) then {
									if ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
										if (!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
											if ((nearestObjects [_position,['House','Building'],10,FALSE]) isEqualTo []) then {
												if ((nearestTerrainObjects [
													_position,
													[
														"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
														"WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
														"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
													],
													10,
													FALSE,
													TRUE
												]) isEqualTo []) then {
													_positionFound = TRUE;
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
			if (_attempts > 100) then {
				_centerRadius = _centerRadius + 10;
				_attempts = 0;
			};
			_attempts = _attempts + 1;
			_totalAttempts = _totalAttempts + 1;
		};
		comment 'Spawn composition';
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
					_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,diag_tickTime,-1],FALSE];
					{
						0 = _composition pushBack _x;
					} forEach (units _grp);
				};
			};
			_uncertaintyPos = [((_position select 0) + (100 - (random 200))),((_position select 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_1',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1Radio Tower',(toString [32,32,32])]);
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
			_description = 'Destroy the enemy radio tower!<br/><br/>The enemy relies on radio communications to call in helicopter and armored vehicle reinforcements.<br/><br/>Destroying this target will greatly reduce the enemies ability to call in these force multipliers.';
			_title = 'Destroy Radio Tower';
			_tooltip = 'Radio Tower';
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
		comment 'Supply Depot';
		comment 'Find position';
		private _attempts = 0;
		private _totalAttempts = 0;
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
				[_centerPos,300,'(1 + forest) * (1 - houses) * (1 + meadow)',15,3],
				[],
				TRUE
			] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if ((_position distance2D _basePosition) > 1000) then {
				if ((_position distance2D _fobPosition) > 150) then {
					if (((missionNamespace getVariable 'QS_registeredPositions') findIf {((_position distance2D _x) < 200)}) isEqualTo -1) then {
						if ((getTerrainHeightASL _position) > 2) then {
							if (([_position,15] call (missionNamespace getVariable 'QS_fnc_areaGradient')) < 7) then {
								if (([_position,15] call (missionNamespace getVariable 'QS_fnc_areaGradient')) > -7) then {
									if ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) then {
										if (!([_position,30,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius'))) then {
											if ((nearestObjects [_position,['House','Building'],18,FALSE]) isEqualTo []) then {
												if ((nearestTerrainObjects [
													_position,
													[
														"BUILDING","HOUSE","CHURCH","CHAPEL","CROSS","ROCK","BUNKER","FORTRESS","FOUNTAIN","VIEW-TOWER","LIGHTHOUSE","QUAY","FUELSTATION","HOSPITAL",
														"FENCE","WALL","BUSSTOP","TRANSMITTER","STACK","RUIN","WATERTOWER",
														"ROCKS","POWER LINES","RAILWAY","POWERSOLAR","POWERWAVE","POWERWIND","SHIPWRECK"
													],
													7,
													FALSE,
													TRUE
												]) isEqualTo []) then {
													_positionFound = TRUE;
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
			if (_attempts > 100) then {
				_centerRadius = _centerRadius + 3;
				_attempts = 0;
			};
			_attempts = _attempts + 1;
			_totalAttempts = _totalAttempts + 1;
		};		
		comment 'Spawn composition';
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
			comment 'Force protection';
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
				_grp setVariable ['QS_AI_GRP_TASK',['DEFEND',_position,diag_tickTime,-1],FALSE];
				{
					0 = _composition pushBack _x;
				} forEach (units _grp);
			};
			_uncertaintyPos = [((_position select 0) + (100 - (random 200))),((_position select 1) + (100 - (random 200))),0];
			_marker1 = createMarker ['QS_marker_virtualSectors_sub_2',[-1000,-1000,0]];
			_marker1 setMarkerAlphaLocal 0;
			_marker1 setMarkerShapeLocal 'ICON';
			_marker1 setMarkerTypeLocal 'mil_dot';
			_marker1 setMarkerColorLocal 'ColorOPFOR';
			_marker1 setMarkerTextLocal (format ['%1Supply Depot',(toString [32,32,32])]);
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
			_description = 'Secure the enemy supply depot.<br/><br/>The enemy relies on this supply depot to distribute advanced gear to the enemy. This depot allows the enemy to equip with more Anti-Air, Anti-Tank and even call in the dreaded Viper units.<br/><br/>Securing this depot will greatly reduce the enemies ability to spawn AA teams, AT teams and Viper teams.<br/><br/>To secure the supply depot, simply use your Scroll Menu on the Taru pod located inside the fortifications.';
			_title = 'Enemy Supply Depot';
			_tooltip = 'Suppy Depot';
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
		comment 'Vehicle support base';
		
		
		
	};
	if (_subType isEqualTo 'JAMMER') then {
		private _position = [0,0,0];
		for '_x' from 0 to 9 step 1 do {
			_position = ['RADIUS',_centerPos,(_centerRadius * 0.666),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			if (((_position distance2D _basePosition) > 500) && ((((_position select [0,2]) nearRoads 20) select {((_x isEqualType objNull) && (!((roadsConnectedTo _x) isEqualTo [])))}) isEqualTo []) && (!([_position,50,8] call (missionNamespace getVariable 'QS_fnc_waterInRadius')))) exitWith {};
		};
		_roughPos = [((_position select 0) - 140) + (random 280),((_position select 1) - 140) + (random 280),0];
		_jammer = [1,'QS_ao_jammer_1',_position,_roughPos,(ceil (random [150,200,300]))] call (missionNamespace getVariable 'QS_fnc_gpsJammer');
		if (alive _jammer) then {
			_composition = [_jammer];
			_return = [2,_subType,[_position,{},_composition]];
		};
	};
	_return;
};
if (_type isEqualTo 2) exitWith {
	comment 'Evaluate';
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