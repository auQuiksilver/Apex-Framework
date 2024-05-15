/*/
File: fn_destroyer.sqf
Author:
	
	Quiksilver
	
Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	Destroyer (Ship)
______________________________________/*/

params ['_type'];
if (_type isEqualTo 'INPOLYGON_FOOT') exitWith {
	_entity = _this # 1;
	private _c = FALSE;
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
		if (!isNull (missionNamespace getVariable ['QS_destroyerObject',objNull])) then {
			if (isNull (objectParent _entity)) then {
				_worldPolygon = [[13.0117,92.106,8.71204],[-13.0034,92.1133,8.74377],[-15.9448,42.8906,8.58817],[-14.6387,-16.2246,8.67601],[-9.54688,-67.8555,8.99917],[-0.864258,-110.585,13.127],[1.05225,-110.629,12.7627],[9.64355,-65.5073,12.7884],[12.6826,-37.0854,12.8368],[15.8574,6.70361,8.00518],[14.5059,69.4863,8.44093]] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
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
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
		if (!isNull (missionNamespace getVariable ['QS_destroyerObject',objNull])) then {
			_worldPolygon = [[13.0117,92.106,8.71204],[-13.0034,92.1133,8.74377],[-15.9448,42.8906,8.58817],[-14.6387,-16.2246,8.67601],[-9.54688,-67.8555,8.99917],[-0.864258,-110.585,13.127],[1.05225,-110.629,12.7627],[9.64355,-65.5073,12.7884],[12.6826,-37.0854,12.8368],[15.8574,6.70361,8.00518],[14.5059,69.4863,8.44093]] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
			if (_entity inPolygon _worldPolygon) then {
				_c = TRUE;
			};
		};
	};
	_c;
};
if (_type isEqualTo 'MOVE') exitWith {
	// Not capable of moving without more development, for instance respawning vehicles would not follow
};
if (
	(_type isEqualTo 'INIT') &&
	{(worldName in ['Altis','Stratis','Tanoa','Malden','stozec'])}
) exitWith {
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
				[[2319.417,7321.986,0],247.668],
				[[5770.66,153.873,0],random 360],
				[[7972.38,2145.92,0],random 360]
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
		if (_worldName isEqualTo 'stozec') then {
			_positionData = [
				[[15201,859.724,0],132.394],
				[[15201,859.724,0],132.394]
			];
		};
		_positionData = selectRandom _positionsData;
		_positionData params ['_pos','_dir'];
		_dir = _dir + 180;
		_markerData = ['QS_marker_destroyer_1',[-1500,-1500,0],'b_naval','Icon','','ColorWEST',[0.25,0.25],0.5,[-1500,-1500,0],0,localize 'STR_QS_Marker_070'];
		if ('QS_marker_destroyer_1' in allMapMarkers) then {
			_marker = 'QS_marker_destroyer_1';
			_pos = markerPos _marker;
			_dir = markerDir _marker;
			_dir = _dir + 180;
		} else {
			_marker = createMarker ['QS_marker_destroyer_1',_pos];
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
				if ((_entity getVariable ['bis_carrierParts',[]]) isNotEqualTo []) then {
					deleteVehicle (_entity getVariable ['bis_carrierParts',[]]);
				};
				if ((_entity getVariable ['QS_destroyer_turrets',[]]) isNotEqualTo []) then {
					{
						_x setDamage [1,FALSE];
						deleteVehicle _x;
					} forEach (_entity getVariable ['QS_destroyer_turrets',[]]);
				};
				if ((_entity getVariable ['QS_carrier_props',[]]) isNotEqualTo []) then {
					deleteVehicle (_entity getVariable ['QS_carrier_props',[]]);
				};
				missionNamespace setVariable ['QS_destroyerObject',objNull,TRUE];
			}
		];
		_carrier setVariable ['bis_carrierParts',(_carrier getVariable ['bis_carrierParts',[]]),TRUE];
		{
			if ((toLowerANSI (typeOf (_x # 0))) in ['land_destroyer_01_interior_01_f','land_destroyer_01_interior_02_f','land_destroyer_01_interior_03_f','land_destroyer_01_interior_04_f']) then {
				for '_i' from 1 to 4 step 1 do {
					(_x # 0) animateSource [(format ['Door_%1_source',_i]),1];
				};
			};
			if ((toLowerANSI (typeOf (_x # 0))) isEqualTo 'land_destroyer_01_interior_04_f') then {
				(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_destroyer_hangarInterior',_x # 0,TRUE];
				missionNamespace setVariable ['QS_destroyer_hangarInterior',_x # 0,TRUE];
			};
			if ((toLowerANSI (typeOf (_x # 0))) in ['land_destroyer_01_hull_04_f']) then {
				(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_destroyer_hangarDoorPart',_x # 0,TRUE];
				missionNamespace setVariable ['QS_destroyer_hangarDoorPart',_x # 0,TRUE];
				if ((missionNamespace getVariable ['QS_missionConfig_destroyerHangar',0]) isEqualTo 1) then {
					(_x # 0) spawn {
						sleep 1;
						[_this,1,FALSE] spawn (missionNamespace getVariable 'BIS_fnc_destroyer01AnimateHangarDoors');
					};
				};
			};
			if ((toLowerANSI (typeOf (_x # 0))) in ['shipflag_us_f']) then {
				(_x # 0) spawn {
					sleep 1;
					_this setFlagTexture (missionNamespace getVariable ['QS_missionConfig_destroyerFlag','a3\data_f\flags\flag_us_co.paa']);
				};
			};
			if ((toLowerANSI (typeOf (_x # 0))) in ['land_destroyer_01_hull_05_f']) then {
				(_x # 0) spawn {
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
		[1,_logic,[_carrier,[0,0,0]]] call QS_fnc_eventAttach;
		_logic setDir (getDir _carrier);
		[0,_logic] call QS_fnc_eventAttach;
		private _prop = objNull;
		{
			_prop = createVehicle [(_x # 0),[-100,-100,0],[],5,'NONE'];
			_prop setPosWorld (_carrier modelToWorldWorld (_x # 1));
			_prop setDir ((getDir _carrier) - (_x # 2));
			_prop allowDamage FALSE;
			if ((toLowerANSI (_x # 0)) in ['land_destroyer_01_boat_rack_01_f']) then {
				[_prop,_logic,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
				_prop enableSimulationGlobal TRUE;
			};
			if ((_x # 3) isNotEqualTo {}) then {
				_prop call (_x # 3);
			};
		} forEach [
			['land_destroyer_01_boat_rack_01_f',[11.5142,14.25,6.8],180,{}],
			['land_destroyer_01_boat_rack_01_f',[-11.5142,14.25,6.8],180,{}]
		];

		// Add low-sec safezone to ship
		[3] call QS_fnc_zonePreset;
		['PRESET',1] call QS_fnc_deployment;
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
		["Land_Laptop_03_black_F",[-0.0141602,-39.6001,20.4],180],
		["Land_Orange_01_F",[-8.04883,-42.8735,10.446],0],
		["Land_Orange_01_F",[1.9751,-106.195,12.8429],0],
		["Land_FirstAidKit_01_closed_F",[3.4209,31.041,9],-169.561],
		["B_AAA_System_01_F",[-0.0136719,-47.8584,17.5221],0],						// Have these set as static props since they engage targets all over the map, rather than acting as self-defense
		["B_AAA_System_01_F",[0.00292969,36.0059,21.7332],180],						// Have these set as static props since they engage targets all over the map, rather than acting as self-defense
		["Land_Obstacle_Ramp_F",[-9.68555,57.5078,15.8],180],
		["Land_Obstacle_Ramp_F",[9.61328,57.4766,15.8],180]
	];
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 0) then {
		_propList pushBack ['B_Ship_MRLS_01_F',[0,-62.2275,11.95],180];
		_propList pushBack ['B_Ship_Gun_01_F',[0,-79.1348,14.7424],0];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 2) then {
		_propList pushBack ['B_SAM_System_01_F',[0,50.6851,17.2588],0];
		_propList pushBack ['B_AAA_System_01_F',[-0.0136719,-47.8584,17.5221],0];
		_propList pushBack ['B_AAA_System_01_F',[0.00292969,36.0059,21.7332],180];
	};
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
		_modelPos = (missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld (_x # 1);
		_modelPosZ = _modelPos # 2;
		//_modelPos set [2,(_modelPosZ + (getNumber (_configClass >> 'SimpleObject' >> 'verticalOffset')))];
		_prop = createSimpleObject [_model,_modelPos];
		_prop setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) - (_x # 2));
		_props pushBack _prop;
	} forEach _propList;
	_prop = createVehicle ['Land_HelipadEmpty_F',[0,0,0]];
	_prop setPosWorld ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [0.267822,78.0273,8.81878]);
	_props pushBack _prop;
	_prop = createVehicle ['Land_PierLadder_F',[0,0,0]];
	_prop setPosWorld ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [-8.90497,42.2529,13.3823]);
	_prop setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) + 267.865);
	_props pushBack _prop;
	(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_carrier_props',_props,FALSE];
};
if (_type isEqualTo 'DEFENSE') exitWith {
	if (((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]) isEqualTo []) then {
		private _turretList = [];
		if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isEqualTo 2) then {
			_turretList pushBack ['B_SAM_System_01_F',[0,50.6851,17.2588],0];
			//_propList pushBack ["B_AAA_System_01_F",[-0.0136719,-47.8584,17.5221],0];					// Have these set as static props since they engage targets all over the map, rather than acting as self-defense
			//_propList pushBack ["B_AAA_System_01_F",[0.00292969,36.0059,21.7332],180];				// Have these set as static props since they engage targets all over the map, rather than acting as self-defense
		};
		if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isEqualTo 1) then {
			_turretList pushBack ['B_Ship_Gun_01_F',[0,-79.1348,14.7424],180];
			_turretList pushBack ['B_Ship_MRLS_01_F',[-0.0473633,-62.2275,12],0];
		};
		if (_turretList isNotEqualTo []) then {
			_logic = (missionNamespace getVariable 'QS_destroyerObject') getVariable 'QS_carrier_defenseLogic';
			private _turret = objNull;
			private _turrets = [];
			private _turretGrp = createGroup [WEST,TRUE];
			{
				_turret = createVehicle [(_x # 0),[-1000,-1000,500],[],100,'NONE'];
				_turret allowDamage FALSE;
				_turret enableSimulation FALSE;
				_turret enableVehicleCargo FALSE;
				_turret enableRopeAttach FALSE;
				_turret setDir ((getDir (missionNamespace getVariable 'QS_destroyerObject')) - (_x # 2));
				_turret setPosWorld ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld (_x # 1));
				_turret setVelocity [0,0,0];
				[_turret,_logic,TRUE] call (missionNamespace getVariable 'QS_fnc_attachToRelative');
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
					_x setSkill 0;
				} forEach (crew _turret);
				if ((toLowerANSI (_x # 0)) in ['b_sam_system_01_f','b_sam_system_02_f']) then {
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
				if ((toLowerANSI (_x # 0)) in ['b_ship_mrls_01_f']) then {
					_turret setVariable ['QS_uav_toggleEnabled',FALSE,TRUE];
					{
						(gunner _turret) enableAIFeature _x;
					} forEach [
						['PATH',FALSE],
						['COVER',FALSE],
						['AUTOCOMBAT',FALSE],
						['TARGET',FALSE],
						['AUTOTARGET',FALSE]
					];
					_turret addEventHandler [
						'Fired',
						{
							if (!isNull (_this # 6)) then {
								if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
									if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
										(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
									} else {
										(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
									};
								};
							};
						}
					];
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
				if ((toLowerANSI (_x # 0)) in ['b_ship_gun_01_f']) then {
					_turret setVariable ['QS_uav_toggleEnabled',FALSE,TRUE];
					{
						(gunner _turret) enableAIFeature _x;
					} forEach [
						['PATH',FALSE],
						['COVER',FALSE],
						['AUTOCOMBAT',FALSE],
						['TARGET',FALSE],
						['AUTOTARGET',FALSE]
					];
					_turret addEventHandler [
						'Fired',
						{
							if (!isNull (_this # 6)) then {
								if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
									if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
										(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
									} else {
										(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
									};
								};
							};
							(_this # 0) setVehicleAmmo 1;
						}
					];
					{
						_turret removeMagazineTurret [_x,[0]];
					} forEach [
						//'magazine_ShipCannon_120mm_HE_shells_x32',			// these are the normal shells, we remove because there are so many
						'magazine_ShipCannon_120mm_HE_cluster_shells_x2',
						'magazine_ShipCannon_120mm_mine_shells_x6',
						'magazine_ShipCannon_120mm_smoke_shells_x6',
						'magazine_ShipCannon_120mm_AT_mine_shells_x6'
					];
				};
			} forEach _turretList;
			_turretGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			(missionNamespace getVariable 'QS_destroyerObject') setVariable ['QS_destroyer_turrets',_turrets,TRUE];
			'QS_marker_destroyer_1' setMarkerText (format ['%1 (%2)',(markerText 'QS_marker_destroyer_1'),localize 'STR_QS_Marker_004']);
		};
	};
};
if (_type isEqualTo 'DEFENSE_SERVICE') exitWith {
	if (((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]) isNotEqualTo []) then {
		{
			_x setDamage [0,FALSE];
			_x setVehicleAmmo 1;
		} forEach ((missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]]);
	};
};
if (_type isEqualTo 'HOSPITAL') then {
	_subType = _this # 1;
	if (_subType isEqualTo 'ADD') then {
		(missionNamespace getVariable 'QS_positions_fieldHospitals') pushBack ['DESTROYER',((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [-0.0966797,47.3291,8.80774]),25];
		missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
	};
	if (_subType isEqualTo 'REMOVE') then {
		_arrayIndex = ((missionNamespace getVariable 'QS_positions_fieldHospitals') findIf {((_x # 0) isEqualTo 'DESTROYER')});
		if (_arrayIndex isNotEqualTo -1) then {
			(missionNamespace getVariable 'QS_positions_fieldHospitals') set [_arrayIndex,FALSE];
			(missionNamespace getVariable 'QS_positions_fieldHospitals') deleteAt _arrayIndex;
			missionNamespace setVariable ['QS_positions_fieldHospitals',(missionNamespace getVariable 'QS_positions_fieldHospitals'),TRUE];
		};	
	};
};
if (_type isEqualTo 'VEHICLES') exitWith {
	private _list = [];
	_heliType = 'b_heli_transport_01_f';
	_boatType = 'b_boat_armed_01_minigun_f';
	
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerVehicles',0]) > 0) then {
		_list = [
			// Boat 1
			[objNull,30,false,{call QS_fnc_destroyerVehicleInit},
			_boatType,
			((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [30,12.7339,6.47747]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -126.998),false,0,-1,250,250,-1,5,FALSE,1],
			// Boat 2
			[objNull,30,false,{call QS_fnc_destroyerVehicleInit},
			_boatType,
			((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [-30,12.752,6.98745]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -126.998),false,0,-1,250,250,-1,5,FALSE,1]		
		];
	};
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerVehicles',0]) > 1) then {
		{
			_list pushBack _x;
		} forEach [
			// Heli 1
			[
				objNull,30,false,{call QS_fnc_destroyerVehicleInit},
				_heliType,
				((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld [0.074707,42.9854,10.9379]),((getDir (missionNamespace getVariable 'QS_destroyerObject')) - -180),false,0,-1,250,250,-1,5,FALSE,1,{((nearestObjects [QS_destroyerObject modelToWorldWorld [0.074707,42.9854,8.81596],['Air'],15,TRUE]) isEqualTo [])}
			]
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
			private _inArea = ['INPOLYGON_FOOT',_entity] call (missionNamespace getVariable 'QS_fnc_destroyer');
			if (
				(!_inArea) ||
				(_inArea && ((toLowerANSI (pose _entity)) in ['swimming','surfaceswimming']))
			) then {
				_positions = [
					[1.6084,14.7378,7.26747],[1.61328,11.1191,7.26953],[-0.90918,13.2896,7.27783],[-1.10303,16.2041,7.27946],[-0.109375,18.124,7.27023],[1.21338,18.9902,7.26167],[1.10254,16.9429,7.27243]
				] apply { ((missionNamespace getVariable 'QS_destroyerObject') modelToWorldWorld _x) };
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