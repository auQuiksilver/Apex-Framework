/*/
File: fn_carrier.sqf
Author:
	
	Quiksilver
	
Last Modified:

	17/08/2018 A3 1.82 by Quiksilver

Description:

	Destroyer (Ship)
______________________________________/*/

params ['_type'];
if (_type isEqualTo 'INPOLYGON_FOOT') exitWith {
	_entity = _this select 1;
	private _c = FALSE;
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
		if (!isNull (missionNamespace getVariable ['QS_destroyerObject',objNull])) then {
			if (isNull (objectParent _entity)) then {
				_worldPolygon = [[-11.4966,65.7358,9.01379],[11.1533,66.0415,8.76432],[11.0654,90.0938,8.74652],[-10.9414,90.1621,8.84945]] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
				if ((getPosWorld _entity) inPolygon _worldPolygon) then {
					_c = TRUE;
				};
			};
		};
	};
	_c;
};
if (_type isEqualTo 'INPOLYGON') exitWith {
	_entity = _this select 1;
	private _c = FALSE;
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 0)) then {
		if (!isNull (missionNamespace getVariable ['QS_destroyerObject',objNull])) then {
			_worldPolygon = [[-11.4966,65.7358,9.01379],[11.1533,66.0415,8.76432],[11.0654,90.0938,8.74652],[-10.9414,90.1621,8.84945]] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
			if ((getPosWorld _entity) inPolygon _worldPolygon) then {
				_c = TRUE;
			};
		};
	};
	_c;
};
if (_type isEqualTo 'MOVE') exitWith {
	// Not capable of moving without more development, for instance respawning vehicles would not follow
};
if (_type isEqualTo 'INIT') exitWith {
	if (isDedicated) then {
		diag_log 'Spawning destroyer';
		private ['_marker','_positionsData','_positionData'];
		_worldName = worldName;
		_worldSize = worldSize;
		if (_worldName isEqualTo 'Altis') then {
			_positionsData = [
				[[15500.522,13364.62,0],55.492],
				[[2356.854,15681.47,0],189.990],
				[[19163.883,21788.348,0],113.621],
				[[24862.773,14545.417,0],224.179]
			];
		};
		if (_worldName isEqualTo 'Stratis') then {
			_positionsData = [
				[[5143.174,1457.258,0],32.905],
				[[2319.417,7321.986,0],247.668]
			];
		};
		if (_worldName isEqualTo 'Malden') then {
			_positionsData = [
				[[1656.504,9324.308,0],37.569],
				[[9516.929,10224.356,0],179.788],
				[[3123.705,1002.906,0],45.917]
			];
		};
		if (_worldName isEqualTo 'Tanoa') then {
			_positionsData = [
				[[6909.691,1445.498,0],35],
				[[14140.768,6005.042,0],181.037],
				[[13881.917,13057.585,0],283.858],
				[[5384.38,13784.24,0],203.315]
			];
		};
		_positionData = selectRandom _positionsData;
		_positionData params ['_pos','_dir'];
		_dir = _dir + 180;
		_markerData = ['QS_marker_destroyer_1',[-1500,-1500,0],'b_naval','Icon','','ColorWEST',[0.25,0.25],0.5,[-1500,-1500,0],0,'Destroyer'];
		if ('QS_marker_destroyer_1' in allMapMarkers) then {
			_marker = 'QS_marker_destroyer_1';
			_pos = markerPos _marker;
			_dir = markerDir _marker;
			_dir = _dir + 180;
		} else {
			_marker = createMarker ['QS_marker_destroyer_1',_pos];
			_marker setMarkerPos _pos;
			_marker setMarkerDir _dir;
		};
		_marker setMarkerType (_markerData select 2);
		_marker setMarkerShape (_markerData select 3);
		_marker setMarkerColor (_markerData select 5);
		_marker setMarkerSize (_markerData select 6);
		_marker setMarkerAlpha (_markerData select 7);
		_marker setMarkerText (format ['%1%2',(toString [32,32,32]),(_markerData select 10)]);
		_carrier = createVehicle ['Land_Destroyer_01_base_F',(AGLToASL _pos),[],0,'CAN_COLLIDE'];
		_carrier setPosWorld _pos;
		_carrier setDir _dir;
		_carrier setVectorUp [0,0,1];
		missionNamespace setVariable ['QS_destroyerObject',_carrier,TRUE];
		[_carrier] call (missionNamespace getVariable 'BIS_fnc_Destroyer01PosUpdate');
		_carrier addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				if (!((_entity getVariable ['bis_carrierParts',[]]) isEqualTo [])) then {
					{
						deleteVehicle _x;
					} forEach (_entity getVariable ['bis_carrierParts',[]]);
				};
				if (!((_entity getVariable ['QS_destroyer_turrets',[]]) isEqualTo [])) then {
					{
						_x setDamage [1,FALSE];
						deleteVehicle _x;
					} forEach (_entity getVariable ['QS_destroyer_turrets',[]]);
				};
				if (!((_entity getVariable ['QS_carrier_props',[]]) isEqualTo [])) then {
					{
						deleteVehicle _x;
					} forEach (_entity getVariable ['QS_carrier_props',[]]);
				};
				missionNamespace setVariable ['QS_destroyerObject',objNull,TRUE];
			}
		];
		_carrier setVariable ['bis_carrierParts',(_carrier getVariable ['bis_carrierParts',[]]),TRUE];
		{
			if ((toLower (typeOf (_x select 0))) in ['land_destroyer_01_interior_01_f','land_destroyer_01_interior_02_f','land_destroyer_01_interior_03_f','land_destroyer_01_interior_04_f']) then {
				for '_i' from 1 to 4 step 1 do {
					(_x select 0) animateSource [(format ['Door_%1_source',_i]),1];
				};
			};
			if ((toLower (typeOf (_x select 0))) in ['land_destroyer_01_hull_04_f']) then {
				if ((missionNamespace getVariable ['QS_missionConfig_destroyerHangar',0]) isEqualTo 1) then {
					(_x select 0) spawn {
						sleep 1;
						[_this,1,FALSE] spawn (missionNamespace getVariable 'BIS_fnc_destroyer01AnimateHangarDoors');
					};
				};
			};
			if ((toLower (typeOf (_x select 0))) in ['shipflag_us_f']) then {
				(_x select 0) spawn {
					sleep 1;
					_this setFlagTexture (missionNamespace getVariable ['QS_missionConfig_destroyerFlag','a3\data_f\flags\flag_us_co.paa']);
				};
			};
			if ((toLower (typeOf (_x select 0))) in ['land_destroyer_01_hull_05_f']) then {
				(_x select 0) spawn {
					sleep 1;
					_this setObjectTextureGlobal [0,(missionNamespace getVariable ['QS_missionConfig_destroyerName','a3\boat_f_destroyer\destroyer_01\data\destroyer_01_tag_01_co.paa'])];
				};
			};
		} forEach (_carrier getVariable ['bis_carrierParts',[]]);
		{
			[([_carrier,'land_destroyer_01_hull_01_f'] call (missionNamespace getVariable 'BIS_fnc_destroyer01GetShipPart')),_x,_forEachIndex] call (missionNamespace getVariable 'bis_fnc_destroyer01InitHullNumbers');
		} forEach (missionNamespace getVariable ['QS_missionConfig_destroyerNumbers',[1,2,3]]);
		_logic = (createGroup [sideLogic,TRUE]) createUnit ['Logic',[-1000,-1000,500],[],0,'CAN_COLLIDE'];
		_logic enableDynamicSimulation FALSE;
		_logic enableSimulation TRUE;
		(group _logic) deleteGroupWhenEmpty FALSE;
		_logic setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_logic setVariable ['QS_cleanup_protected',TRUE,FALSE];
		_carrier setVariable ['QS_carrier_defenseLogic',_logic,FALSE];
		_logic setPosWorld (getPosWorld _carrier);
		_logic attachTo [_carrier,[0,0,0]];
		_logic setDir (getDir _carrier);
		detach _logic;
		private _prop = objNull;
		{
			_prop = createVehicle [(_x select 0),[-100,-100,0],[],5,'NONE'];
			_prop setPosWorld (_carrier modelToWorldWorld (_x select 1));
			_prop setDir ((getDir _carrier) - (_x select 2));
			_prop allowDamage FALSE;
			if ((toLower (_x select 0)) in ['land_destroyer_01_boat_rack_01_f']) then {
				[_prop,_logic,TRUE] call (missionNamespace getVariable 'BIS_fnc_attachToRelative');
			};
			if (!((_x select 3) isEqualTo {})) then {
				_prop call (_x select 3);
			};
		} forEach [
			['land_destroyer_01_boat_rack_01_f',[11.5142,14.25,6.8],180,{}],
			['land_destroyer_01_boat_rack_01_f',[-11.5142,14.25,6.8],180,{}]
		];
	};
};
if (_type isEqualTo 'PROPS') exitWith {
	_logic = (missionNamespace getVariable 'QS_destroyerObject') getVariable 'QS_carrier_defenseLogic';
	private _propList = [
		["B_supplyCrate_F",[6.58154,31.7271,9.75],-334.561],
		["Land_CampingChair_V2_F",[0.177246,26.3579,9.31482],-96.811],
		["Land_CampingChair_V2_F",[-2.41406,26.3906,9.31482],-217.635],
		["Land_CampingChair_V2_F",[-3.73486,26.6499,9.31482],-217.635],
		["Land_CampingChair_V2_F",[-4.77002,27.334,9.31482],-269.606],
		["Land_CampingChair_V2_F",[-5.91016,27.3247,9.31482],-269.606],
		["Land_CampingChair_V2_F",[-4.80322,28.3149,9.31482],-269.606],
		["Land_CampingChair_V2_F",[-5.93115,28.2646,9.31482],-269.606],
		["Land_CampingChair_V2_F",[0.265137,29.0479,9.31482],-72.01],
		["Land_CampingChair_V2_F",[-2.27979,29.2349,9.31482],-324.239],
		["Land_CampingChair_V2_F",[-3.48584,29.1841,9.31482],-316.667],
		["Land_File_research_F",[-1.15576,27.5718,9.61432],-244.454],
		["Land_CampingTable_F",[-1.95703,27.7778,9.20674],0],
		["Land_Document_01_F",[-2.79199,27.772,9.61432],-92.933],
		["Land_TripodScreen_01_large_F",[1.27588,30.353,9.82],-243.576],
		["Land_TripodScreen_01_large_F",[-2.0249,-34.5439,20.15],-154.386],
		["Land_Document_01_F",[3.59912,-39.0073,20.2969],-213.203],
		["Land_Orange_01_F",[2.58496,-39.1123,20.1],0],
		["Land_Laptop_03_black_F",[-0.0141602,-39.6001,20.4],-359.864],
		["Land_Orange_01_F",[-8.04883,-42.8735,10.446],0],
		["Land_Orange_01_F",[1.9751,-106.195,12.8429],0],
		["Land_FirstAidKit_01_closed_F",[3.4209,31.041,9],-169.561]
	];
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 0) then {
		_propList pushBack ['B_Ship_MRLS_01_F',[0,-62.2275,11.95],180];
		_propList pushBack ['B_Ship_Gun_01_F',[0,-79.1348,14.7424],0];
	};
	if (!((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 2)) then {
		_propList pushBack ['B_SAM_System_01_F',[0,50.6851,17.2588],0];
	};
	private _configClass = configNull;
	private _model = '';
	private _props = [];
	private _prop = objNull;
	private _modelPos = [0,0,0];
	private _modelPosZ = -1;
	{
		_configClass = configFile >> 'CfgVehicles' >> (_x select 0);
		_model = getText (_configClass >> 'model');
		if ((_model select [0,1]) isEqualTo '\') then {
			_model = _model select [1];
		};
		if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
			_model = _model + '.p3d';
		};
		_modelPos = (missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld (_x select 1);
		_modelPosZ = _modelPos select 2;
		//_modelPos set [2,(_modelPosZ + (getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')))];
		_prop = createSimpleObject [_model,_modelPos];
		_prop setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) - (_x select 2));
		_props pushBack _prop;
	} forEach _propList;
	(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_carrier_props',_props,FALSE];
};
if (_type isEqualTo 'DEFENSE') exitWith {
	if (((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]) isEqualTo []) then {
		private _turretList = [];
		if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 2) then {
			_turretList pushBack ['B_SAM_System_01_F',[0,50.6851,17.2588],0];
		};
		if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 1) then {
			_turretList pushBack ['B_Ship_Gun_01_F',[0,-79.1348,14.7424],180];
			_turretList pushBack ['B_Ship_MRLS_01_F',[-0.0473633,-62.2275,12],0];
		};
		if (!(_turretList isEqualTo [])) then {
			_logic = (missionNamespace getVariable 'QS_destroyerObject') getVariable 'QS_carrier_defenseLogic';
			private _turret = objNull;
			private _turrets = [];
			private _turretGrp = createGroup [WEST,TRUE];
			{
				_turret = createVehicle [(_x select 0),[-1000,-1000,500],[],100,'NONE'];
				_turret allowDamage FALSE;
				_turret enableSimulation FALSE;
				_turret enableVehicleCargo FALSE;
				_turret enableRopeAttach FALSE;
				_turret setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) - (_x select 2));
				_turret setPosWorld ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld (_x select 1));
				_turret setVelocity [0,0,0];
				[_turret,_logic,TRUE] call (missionNamespace getVariable 'BIS_fnc_attachToRelative');
				_turret enableSimulation TRUE;
				_turret setVehicleReportRemoteTargets FALSE;
				_turret setVehicleReceiveRemoteTargets FALSE;
				_turret setVehicleReportOwnPosition FALSE;
				_turret setVariable ['QS_curator_disableEditability',TRUE,FALSE];
				_turret setVariable ['QS_hidden',TRUE,TRUE];
				_turret setVariable ['QS_uav_protected',TRUE,TRUE];
				_turret addEventHandler [
					'Deleted',
					{
						params ['_entity'];
						{
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						} forEach (crew _entity);
					}
				];
				createVehicleCrew _turret;
				_turrets pushBack _turret;
				{
					_x setVariable ['QS_curator_disableEditability',TRUE,FALSE];
					_x setVariable ['QS_hidden',TRUE,TRUE];
					_x allowDamage FALSE;
					_x setSkill 0;
				} forEach (crew _turret);
				if ((toLower (_x select 0)) in ['b_sam_system_01_f','b_sam_system_02_f']) then {
					_turret setVehicleReceiveRemoteTargets TRUE;
					_turret setVehicleRadar 1;
					_turret addEventHandler [
						'Fired',
						{
							params ['_vehicle','_weapon','','','','','',''];
							if ((_vehicle ammo _weapon) isEqualTo 0) then {
								_vehicle setVehicleAmmo 1;
							};
						}
					];
				};
				if ((toLower (_x select 0)) in ['b_ship_mrls_01_f']) then {
					_turret setVehicleReceiveRemoteTargets TRUE;
					{
						_turret removeMagazineTurret [_x,[0]];
					} forEach [
						'magazine_Missiles_Cruise_01_Cluster_x18'
					];
					/*/
					_turret addEventHandler [
						'Fired',
						{
							params ['','','','','','','_projectile',''];
							missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
							missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
						}
					];
					_turret addEventHandler [
						'Local',
						{
							params ['_entity','_isLocal'];
							if (_isLocal) then {
								_entity removeAllEventHandlers 'Fired';
								_entity addEventHandler [
									'Fired',
									{
										params ['','','','','','','_projectile',''];
										missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
										missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
									}
								];
							};
						}
					];
					/*/
				};
				if ((toLower (_x select 0)) in ['b_ship_gun_01_f']) then {
					{
						_turret removeMagazineTurret [_x,[0]];
					} forEach [
						'magazine_ShipCannon_120mm_HE_shells_x32',			// these are the normal shells, we remove because there are so many
						'magazine_ShipCannon_120mm_HE_cluster_shells_x2',
						'magazine_ShipCannon_120mm_mine_shells_x6',
						'magazine_ShipCannon_120mm_smoke_shells_x6',
						'magazine_ShipCannon_120mm_AT_mine_shells_x6'
					];
				};
			} forEach _turretList;
			(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_destroyer_turrets',_turrets,TRUE];
			'QS_marker_destroyer_1' setMarkerText (format ['%1 (Armed)',(markerText 'QS_marker_destroyer_1')]);
		};
	};
};
if (_type isEqualTo 'DEFENSE_SERVICE') exitWith {
	if (!(((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]) isEqualTo [])) then {
		{
			_x setDamage [0,FALSE];
			_x setVehicleAmmo 1;
		} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]);
	};
};
if (_type isEqualTo 'HOSPITAL') then {
	_subType = _this select 1;
	if (_subType isEqualTo 'ADD') then {
		(missionNamespace getVariable 'QS_positions_fieldHospitals') pushBack ['DESTROYER',((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [-0.0966797,47.3291,8.80774]),25];
		missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
	};
	if (_subType isEqualTo 'REMOVE') then {
		_arrayIndex = ((missionNamespace getVariable 'QS_positions_fieldHospitals') findIf {((_x select 0) isEqualTo 'DESTROYER')});
		if (!(_arrayIndex isEqualTo -1)) then {
			(missionNamespace getVariable 'QS_positions_fieldHospitals') set [_arrayIndex,FALSE];
			(missionNamespace getVariable 'QS_positions_fieldHospitals') deleteAt _arrayIndex;
			missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
		};	
	};
};
if (_type isEqualTo 'VEHICLES') exitWith {
	private _list = [];
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerVehicles',0]) > 0) then {
		_list = [
			// Boat 1
			[objNull,30,false,{
				_this spawn {
					sleep 0.1;
					_this setVelocity [0,0,0];
					_boatRacks = nearestObjects [_this,['land_destroyer_01_boat_rack_01_f'],25,TRUE];
					if (!(_boatRacks isEqualTo [])) then {
						_boatRack = _boatRacks select 0;
						if ((getVehicleCargo _boatRack) isEqualTo []) then {
							_this setDir (getDir _boatRack);
							_boatRack setVehicleCargo _this;
						};
					};
					sleep 1;
					_this addEventHandler [
						'GetIn',
						{
							params ['_v','','',''];
							_v enableSimulationGlobal TRUE;
							_v removeEventHandler ['GetIn',_thisEventHandler];
						}
					];
					_this enableSimulationGlobal FALSE;
				};
			},
			(['b_boat_armed_01_minigun_f','b_t_boat_armed_01_minigun_f'] select (worldName in ['Tanoa','Lingor3'])),
			((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [30,12.7339,6.47747]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -126.998),false,0,-1,250,250,-1,5,FALSE,1],
			// Boat 2
			[objNull,30,false,{
				_this spawn {
					sleep 0.1;
					_this setVelocity [0,0,0];
					_boatRacks = nearestObjects [_this,['land_destroyer_01_boat_rack_01_f'],25,TRUE];
					if (!(_boatRacks isEqualTo [])) then {
						_boatRack = _boatRacks select 0;
						if ((getVehicleCargo _boatRack) isEqualTo []) then {
							_this setDir (getDir _boatRack);
							_boatRack setVehicleCargo _this;
						};
					};
					sleep 1;
					_this addEventHandler [
						'GetIn',
						{
							params ['_v','','',''];
							_v enableSimulationGlobal TRUE;
							_v removeEventHandler ['GetIn',_thisEventHandler];
						}
					];
					_this enableSimulationGlobal FALSE;
				};
			},
			(['b_boat_armed_01_minigun_f','b_t_boat_armed_01_minigun_f'] select (worldName in ['Tanoa','Lingor3'])),
			((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [-30,12.752,6.98745]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -126.998),false,0,-1,250,250,-1,5,FALSE,1]		
		];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerVehicles',0]) > 1) then {
		{
			_list pushBack _x;
		} forEach [
			// Heli 1
			[objNull,30,false,{
				_this setVelocity [0,0,0];
				_this spawn {
					sleep 2;
					_this addEventHandler [
						'GetIn',
						{
							params ['_v','','',''];
							_v enableSimulationGlobal TRUE;
							_v removeEventHandler ['GetIn',_thisEventHandler];
						}
					];
					_this enableSimulationGlobal FALSE;
				};
			},
			'b_heli_transport_01_f',
			((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [0.144043,77.332,10.9379]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -179.518),false,0,-1,250,250,-1,5,FALSE,1]
		];
	};
	if (!(_list isEqualTo [])) then {
		{
			(missionNamespace getVariable 'QS_v_Monitor') pushBack _x;
		} forEach _list;
	};
};
if (_type isEqualTo 'RESPAWN_PLAYER') exitWith {
	if (!isDedicated) then {
		if (hasInterface) then {
			_positions = [
				[1.6084,14.7378,7.26747],[1.61328,11.1191,7.26953],[-0.90918,13.2896,7.27783],[-1.10303,16.2041,7.27946],[-0.109375,18.124,7.27023],[1.21338,18.9902,7.26167],[1.10254,16.9429,7.27243]
			] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
			_position = selectRandom _positions;
			player setPosWorld _position;
		};
	};
};