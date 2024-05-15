/*/
File: fn_carrier.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/09/2023 A3 2.14 by Quiksilver

Description:

	Carrier
______________________________________/*/

params ['_type'];
if (_type isEqualTo 'INPOLYGON_FOOT') exitWith {
	_entity = _this # 1;
	private _c = FALSE;
	if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
		if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
			if (isNull (objectParent _entity)) then {
				_worldPolygon = [[-41.34,171.173,23.605],[-41.0483,-70.9946,23.5818],[45.5078,-63.2866,23.5561],[42.7202,150.547,23.5823]] apply { ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x) };
				if (_entity inPolygon _worldPolygon) then {
					_c = TRUE;
				};
			};
		};
	};
	_c;
};
if (_type isEqualTo 'INPOLYGON') exitWith {
	_entity = _this # 1;
	private _c = FALSE;
	if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
		if (!isNull (missionNamespace getVariable ['QS_carrierObject',objNull])) then {
			_worldPolygon = [[-41.34,171.173,23.605],[-41.0483,-70.9946,23.5818],[45.5078,-63.2866,23.5561],[42.7202,150.547,23.5823]] apply { ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x) };
			if (_entity inPolygon _worldPolygon) then {
				_c = TRUE;
			};
		};
	};
	_c;
};
if (_type isEqualTo 'ACTION_CONDSHOW') exitWith {
	TRUE
};
if (_type isEqualTo 'ACTION_CONDPROGRESS') exitWith {
	TRUE
};
if (_type isEqualTo 'TAKEOFF_END') exitWith {
	
};
if (_type isEqualTo 'TAKEOFF_START') exitWith {
	
};
if (_type isEqualTo 'MOVE') exitWith {
	// Not capable of moving without more development, for instance respawning vehicles would not follow
	if (isDedicated) then {
		private ['_position','_direction'];
		if ((count _this) > 1) then {
			_position = (_this # 1) # 0;
			_direction = (_this # 1) # 1;
		} else {
			_position = markerPos 'QS_marker_carrier_1';
			_direction = markerDir 'QS_marker_carrier_1';
		};
		_carrier = missionNamespace getVariable ['QS_carrierObject',objNull];
		if (!isNull _carrier) then {
			_carrier setPosWorld _position;
			_carrier setDir (_direction + 180);
			_carrier setVectorUp [0,0,1];
			[_carrier] call (missionNamespace getVariable 'BIS_fnc_Carrier01PosUpdate');
			if ((_carrier getVariable ['QS_carrier_turrets',[]]) isNotEqualTo []) then {
				_logic = _carrier getVariable ['QS_carrier_defenseLogic',objNull];
				if (!isNull _logic) then {
					_logic setPosWorld (getPosWorld _carrier);
					[1,_logic,[_carrier,[0,0,0]]] call QS_fnc_eventAttach;
					[0,_logic] call QS_fnc_eventAttach;
					_logic setDir (getDir _carrier);
				};
			};
		};
		'QS_marker_carrier_1' setMarkerDir 0;
	};
};
if (
	(_type isEqualTo 'INIT') && 
	{(worldName in ['Altis','Stratis','Tanoa','Malden'])}
) exitWith {
	if (isDedicated) then {
		diag_log 'Spawning aircraft carrier';
		private ['_marker','_positionsData','_positionData'];
		_worldName = worldName;
		_worldSize = worldSize;
		if (_worldName isEqualTo 'Altis') then {
			_positionsData = [
				[[26789.1,4641.8,0],9.62274],
				[[3495.56,3444.6,0],37.8404],
				[[3217.6,27733.9,0],60.2552],
				[[23722.2,28258.7,0],44.2461]
			];
		};
		if (_worldName isEqualTo 'Stratis') then {
			_positionsData = [
				[[6332.64,1061.12,0],24.6236],
				[[6489.22,7066.53,0],11.2106],
				[[355.559,1222.49,0],26.2458],
				[[955.478,7563.02,0],34.7778]
			];
		};
		if (_worldName isEqualTo 'Malden') then {
			_positionsData = [
				[[10859.8,1702.29,0],37.2264],
				[[10696.3,11392.5,0],61.1328],
				[[566.918,9716.05,0],29.2914]
			];
		};
		if (_worldName isEqualTo 'Tanoa') then {
			_positionsData = [
				[[343.525,5595.97,0],62.8601],
				[[13879.4,1167.44,0],315.955],
				[[14213.3,14722.7,0],110.978],
				[[1141.3,14536.3,0],236.489]
			];
		};
		_positionData = selectRandom _positionsData;
		_positionData params ['_pos','_dir'];
		_dir = _dir + 180;
		_markerData = ['QS_marker_carrier_1',[-1500,-1500,0],'b_naval','Icon','','ColorWEST',[0.25,0.25],0.5,[-1500,-1500,0],0,localize 'STR_QS_Marker_069'];
		if ('QS_marker_carrier_1' in allMapMarkers) then {
			_marker = 'QS_marker_carrier_1';
			_pos = markerPos _marker;
			_dir = markerDir _marker;
			_dir = _dir + 180;
		} else {
			_marker = createMarker ['QS_marker_carrier_1',_pos];
			_marker setMarkerPosLocal _pos;
			_marker setMarkerDir _dir;
		};
		_marker setMarkerTypeLocal (_markerData # 2);
		_marker setMarkerShapeLocal (_markerData # 3);
		_marker setMarkerColorLocal (_markerData # 5);
		_marker setMarkerSizeLocal (_markerData # 6);
		_marker setMarkerAlphaLocal (_markerData # 7);
		_marker setMarkerShadowLocal TRUE;
		_marker setMarkerText (format ['%1%2',(toString [32,32,32]),(_markerData # 10)]);
		_carrier = createVehicle ['Land_Carrier_01_base_F',_pos,[],0,'CAN_COLLIDE'];
		_carrier setPosWorld _pos;
		_carrier setDir _dir;
		_carrier setVectorUp [0,0,1];
		missionNamespace setVariable ['QS_carrierObject',_carrier,TRUE];
		[_carrier] call (missionNamespace getVariable 'BIS_fnc_Carrier01PosUpdate');
		_carrier addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				if ((_entity getVariable ['bis_carrierParts',[]]) isNotEqualTo []) then {
					deleteVehicle (_entity getVariable ['bis_carrierParts',[]]);
				};
				if ((_entity getVariable ['QS_carrier_turrets',[]]) isNotEqualTo []) then {
					{
						_x setDamage [1,FALSE];
						deleteVehicle _x;
					} forEach (_entity getVariable ['QS_carrier_turrets',[]]);
				};
				if ((_entity getVariable ['QS_carrier_props',[]]) isNotEqualTo []) then {
					deleteVehicle (_entity getVariable ['QS_carrier_props',[]]);
				};
				missionNamespace setVariable ['QS_carrierObject',objNull,TRUE];
			}
		];
		_carrier setVariable ['bis_carrierParts',(_carrier getVariable ['bis_carrierParts',[]]),TRUE];
		{
			if ((toLowerANSI (typeOf (_x # 0))) in ['land_carrier_01_island_01_f','land_carrier_01_island_02_f','land_carrier_01_island_03_f']) then {
				for '_i' from 1 to 4 step 1 do {
					(_x # 0) animateSource [(format ['Door_%1_source',_i]),1];
				};
			};
		} forEach (_carrier getVariable ['bis_carrierParts',[]]);
		if ((allAirports # 1) isNotEqualTo []) then {
			((allAirports # 1) # 0) setAirportSide WEST;
		};
		// Safezone
		[2] call QS_fnc_zonePreset;
		['PRESET',2] call QS_fnc_deployment;
	};
};
if (_type isEqualTo 'PROPS') exitWith {
	private _configClass = configNull;
	private _model = '';
	private _props = [];
	private _prop = objNull;
	private _modelPos = [0,0,0];
	private _modelPosZ = -1;
	{
		_configClass = configFile >> 'CfgVehicles' >> (_x # 0);
		_model = getText (_configClass >> 'model');
		if ((_model select [0,1]) isEqualTo '\') then {
			_model = _model select [1];
		};
		if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
			_model = _model + '.p3d';
		};
		_modelPos = (missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld (_x # 1);
		_modelPosZ = _modelPos # 2;
		_modelPos set [2,(_modelPosZ + (getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')))];
		_prop = createSimpleObject [_model,_modelPos];
		_prop setDir ((getDir (missionNamespace getVariable 'QS_carrierObject')) - (_x # 2));
		_props pushBack _prop;
	} forEach [
		['B_supplyCrate_F',[-22.603,107.664,23.5],-89.5743],	//--- Arsenal
		['Land_FirstAidKit_01_closed_F',[-26.5304,115.991,23.575],-358.472],
		['Land_CampingChair_V2_F',[-23.0007,109.621,23.5],-251.104],
		['Land_CampingChair_V2_F',[-22.8322,111.798,23.5],-287.446]
	];
	private _moreProps = [
		['Land_HelipadEmpty_F',[-32.0634,69.3691,24.2326],0,{}],
		['Land_HelipadEmpty_F',[-34.8141,160.094,24.1154],0,{}],
		['Land_HelipadEmpty_F',[-34.8799,139.995,24.3029],0,{}],
		['Land_HelipadEmpty_F',[35.0972,150.09,24.9952],0,{}]
	];
	if ((missionNamespace getVariable ['QS_missionConfig_CAS',0]) isEqualTo 3) then {
		{	
			_moreProps pushBack _x;
		} forEach [
			['Land_CampingTable_small_F',[-32.2679,93.8193,23.9735],0,{}],
			['Land_Laptop_03_black_F',[-32.265,93.834,24.538],31.794,{
				missionNamespace setVariable ['QS_carrier_casLaptop',(_this # 0),TRUE];
			}]
		];
	};
	{
		_prop = createVehicle [(_x # 0),[-100,-100,0],[],5,'NONE'];
		if ((_x # 0) in ['Land_CampingTable_small_F','Land_Laptop_03_black_F']) then {
			_prop enableSimulationGlobal FALSE;
		};
		_prop setPosWorld ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld (_x # 1));
		_prop setDir ((getDir (missionNamespace getVariable 'QS_carrierObject')) - (_x # 2));
		_props pushBack _prop;
		if ((_x # 3) isNotEqualTo {}) then {
			[_prop] call (_x # 3);
		};
	} forEach _moreProps;
	(missionNamespace getVariable 'QS_carrierObject') setVariable ['QS_carrier_props',_props,FALSE];
};
if (_type isEqualTo 'DEFENSE') exitWith {
	if (((missionNamespace getVariable 'QS_carrierObject') getVariable ['QS_carrier_turrets',[]]) isEqualTo []) then {
		_logic = (createGroup [sideLogic,TRUE]) createUnit ['Logic',[-1000,-1000,500],[],0,'CAN_COLLIDE'];
		_logic enableDynamicSimulation FALSE;
		_logic setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_logic setVariable ['QS_cleanup_protected',TRUE,FALSE];
		_logic setPosWorld (getPosWorld (missionNamespace getVariable 'QS_carrierObject'));
		[1,_logic,[(missionNamespace getVariable 'QS_carrierObject'),[0,0,0]]] call QS_fnc_eventAttach;
		[0,_logic] call QS_fnc_eventAttach;
		_logic setDir (getDir (missionNamespace getVariable 'QS_carrierObject'));
		(missionNamespace getVariable 'QS_carrierObject') setVariable ['QS_carrier_defenseLogic',_logic,FALSE];
		private _turret = objNull;
		private _turrets = [];
		private _turretGrp = createGroup [WEST,TRUE];
		{
			_turret = createVehicle [(_x # 0),[-1000,-1000,500],[],100,'NONE'];
			_turret allowDamage FALSE;
			_turret enableSimulation FALSE;
			_turret enableVehicleCargo FALSE;
			_turret enableRopeAttach FALSE;
			_turret setDir ((getDir (missionNamespace getVariable 'QS_carrierObject')) - (_x # 2));
			_turret setPosWorld ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld (_x # 1));
			_turret setVelocity [0,0,0];
			[_turret,_logic,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
			_turret enableSimulation TRUE;
			_turret setVehicleReportRemoteTargets FALSE;
			_turret setVehicleReceiveRemoteTargets FALSE;
			_turret setVehicleReportOwnPosition FALSE;
			_turret setVehicleRadar 2;
			_turret setVariable ['QS_curator_disableEditability',TRUE,FALSE];
			_turret setVariable ['QS_hidden',TRUE,TRUE];
			_turret setVariable ['QS_uav_protected',TRUE,TRUE];
			_turret addEventHandler [
				'Deleted',
				{
					params ['_entity'];
					deleteVehicleCrew _entity;
				}
			];
			createVehicleCrew _turret;
			(crew _turret) joinSilent _turretGrp;
			_turrets pushBack _turret;
			{
				_x setVariable ['QS_curator_disableEditability',TRUE,FALSE];
				_x setVariable ['QS_hidden',TRUE,TRUE];
				_x allowDamage FALSE;
			} forEach (crew _turret);
		} forEach [
			['B_SAM_System_01_F',[25.0508,-114.915,18.2391],-89.5441],
			['B_AAA_System_01_F',[47.6074,-0.0134888,20.3989],-88.2512],
			['B_AAA_System_01_F',[-30.0938,-105.529,20.203],-269.183],
			['B_SAM_System_02_F',[-29.3047,-100.712,21.2492],-269.888],
			['B_SAM_System_01_F',[-39.4346,178.48,21.7008],-269.263],
			['B_AAA_System_01_F',[-16.7842,188.944,13.7356],-0.132763],
			['B_SAM_System_02_F',[30.3721,174.906,21.578],-89.5648]
		];
		_turretGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		(missionNamespace getVariable 'QS_carrierObject') setVariable ['QS_carrier_turrets',_turrets,FALSE];
		'QS_marker_carrier_1' setMarkerText (format ['%1 (%2)',(markerText 'QS_marker_carrier_1'),localize 'STR_QS_Marker_004']);
	};
};
if (_type isEqualTo 'DEFENSE_SERVICE') exitWith {
	if (((missionNamespace getVariable 'QS_carrierObject') getVariable ['QS_carrier_turrets',[]]) isNotEqualTo []) then {
		{
			_x setDamage [0,FALSE];
			_x setVehicleAmmo 1;
		} forEach ((missionNamespace getVariable 'QS_carrierObject') getVariable ['QS_carrier_turrets',[]]);
	};
};
if (_type isEqualTo 'HOSPITAL') then {
	_subType = _this # 1;
	if (_subType isEqualTo 'ADD') then {
		(missionNamespace getVariable 'QS_positions_fieldHospitals') pushBack ['CARRIER',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-30.5,109.6,23.9]),15];
		missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
	};
	if (_subType isEqualTo 'REMOVE') then {
		_arrayIndex = ((missionNamespace getVariable 'QS_positions_fieldHospitals') findIf {((_x # 0) isEqualTo 'CARRIER')});
		if (_arrayIndex isNotEqualTo -1) then {
			(missionNamespace getVariable 'QS_positions_fieldHospitals') set [_arrayIndex,FALSE];
			(missionNamespace getVariable 'QS_positions_fieldHospitals') deleteAt _arrayIndex;
			missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
		};	
	};
};
if (_type isEqualTo 'VEHICLES') exitWith {
	private _list = [
		// Hummingbird Heli 1
		[objNull,30,false,{
			_this setVelocity [0,0,0];
		},
		'B_Heli_Light_01_F',
		((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-34.8799,139.995,25.3029]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -126.998),false,0,-1,250,250,-1,5,FALSE,1],
		[objNull,30,false,{
			_this enableSimulationGlobal FALSE;
			_this addEventHandler [
				'GetIn',
				{
					(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
					(_this # 0) enableSimulationGlobal TRUE;
				}
			];
		},
		'B_Truck_01_mover_F',
		((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-38.0713,100.011,25.3474]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -179.807),false,0,-1,250,250,-1,5,FALSE,1]
	];
	if ((missionNamespace getVariable ['QS_missionConfig_carrierVehicles',0]) in [1,2]) then {
		if ((missionNamespace getVariable ['QS_missionConfig_CAS',0]) in [1,2]) then {
			{
				_list pushBack _x;
			} forEach [
				// Fighter jet 1
				[objNull,30,false,{
					_this animateSource ['wing_fold_r',1,TRUE];
					_this animateSource ['wing_fold_l',1,TRUE];
					_this setVelocity [0,0,0];
					[_this,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
				},
				'B_Plane_Fighter_01_F',
				((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [34.4048,125.563,25.6195]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -181.109),false,0,-1,250,250,-1,5,FALSE,1]
			];
		};
	};
	if ((missionNamespace getVariable ['QS_missionConfig_carrierVehicles',0]) isEqualTo 2) then {
		{
			_list pushBack _x;
		} forEach [
			// Fighter jet 2
			[objNull,30,false,{
				_this animateSource ['wing_fold_r',1,TRUE];
				_this animateSource ['wing_fold_l',1,TRUE];
				_this setVelocity [0,0,0];
				[_this,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
			},'B_Plane_Fighter_01_F',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-33.5347,-9.15674,25.8687]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -127.312),false,0,-1,250,250,-1,5,FALSE,1],
			// Fighter jet 3
			[objNull,30,false,{
				_this animateSource ['wing_fold_r',1,TRUE];
				_this animateSource ['wing_fold_l',1,TRUE];	
				_this setVelocity [0,0,0];
				[_this,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
			},'B_Plane_Fighter_01_F',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-33.5016,6.19629,25.8204]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -128.053),false,0,-1,250,250,-1,5,FALSE,1],
			// Huron Heli 1
			[objNull,30,false,{
				_this setVelocity [0,0,0];
			},'B_Heli_Transport_03_unarmed_F',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-32.0634,69.3691,27.2326]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -120.453),false,0,-1,250,250,-1,5,FALSE,1],
			// Huron Heli 2
			[objNull,30,false,{
				_this setVelocity [0,0,0];
			},'B_Heli_Transport_03_unarmed_F',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-34.8141,160.094,27.1154]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -139.238),false,0,-1,250,250,-1,5,FALSE,1]		
		];
	};
	if (_list isNotEqualTo []) then {
		{
			(serverNamespace getVariable 'QS_v_Monitor') pushBack _x;
		} forEach _list;
	};
};
if (_type isEqualTo 'RESPAWN_PLAYER') exitWith {
	params ['',['_entity',QS_player]];
	if (!isDedicated) then {
		if (hasInterface) then {
			private _inArea = ['INPOLYGON_FOOT',_entity] call (missionNamespace getVariable 'QS_fnc_carrier');
			if (
				(!_inArea) ||
				(_inArea && ((toLowerANSI (pose _entity)) in ['swimming','surfaceswimming']))
			) then {
				_positions = [
					[-26.5791,113.625,23.6446],[-29.3418,114.208,23.6797],[-31.8965,113.567,23.3593],[-31.9878,111.41,23.7361],[-30.1235,109.859,23.7606],
					[-28.0728,109.664,23.623],[-25.6973,110.073,23.5785],[-25.8208,112.113,23.5784],[-27.6646,112.978,23.6444],[-29.8735,112.596,23.5414],
					[-29.6924,111.376,23.7495],[-28.022,111.307,23.6492]
				] apply { ((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld _x) };
				_position = selectRandom _positions;
				[_position,_entity] spawn {
					params ['_position','_entity'];
					preloadCamera _position;
					uiSleep 0.5;
					_entity setPosWorld _position;
					uiSleep 5;
					if (surfaceIsWater (getPosASL _entity)) then {
						if (((getPosASL _entity) # 2) < 3) then {
							_entity setPosWorld _position;
						};
					};
				};
			};
		};
	};
};