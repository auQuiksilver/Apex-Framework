/*/
File: fn_serverObjectsRecycler.sqf
Author: 

	Quiksilver

Last Modified:

	5/10/2018 A3 1.84 by Quiksilver

Description:

	Objects Recycler
	
	Custom recycler logic for FOBs?
________________________________________________/*/

params ['_type','_type2'];
private _return = objNull;
if (_type isEqualTo 0) exitWith {
	// Initialize
	private _simpleObjects = [];
	private _normalObjects = [];
	private _units = [];
	private _simpleObjectData = [
		[
			['Land_HBarrier_3_F',10],
			['Land_HBarrier_5_F',12],
			['Land_HBarrier_Big_F',20],
			['Land_HBarrier_1_F',10],
			['Land_HBarrierWall_corner_F',3],
			['Land_HBarrierWall6_F',3],
			['Land_HBarrierWall4_F',3],
			['Land_BagFence_Corner_F',5],
			['Land_BagFence_End_F',5],
			['Land_BagFence_Long_F',10],
			['Land_BagFence_Round_F',5],
			['Land_BagFence_Short_F',10]
		],
		[
			['Land_HBarrier_01_line_3_green_F',10],
			['Land_HBarrier_01_line_5_green_F',12],
			['Land_HBarrier_01_big_4_green_F',20],
			['Land_HBarrier_01_line_1_green_F',10],
			['Land_HBarrier_01_wall_corner_green_F',2],
			['Land_HBarrier_01_wall_6_green_F',2],
			['Land_HBarrier_01_wall_4_green_F',2],
			['Land_BagFence_01_corner_green_F',5],
			['Land_BagFence_01_end_green_F',5],
			['Land_BagFence_01_long_green_F',10],
			['Land_BagFence_01_round_green_F',5],
			['Land_BagFence_01_short_green_F',10]
		]
	] select (worldName isEqualTo 'Tanoa');
	_simpleObjectData = _simpleObjectData + [
		['Land_PaperBox_closed_F',5],
		['Land_PaperBox_open_full_F',5],
		['Land_Mil_WallBig_4m_F',10],
		['Land_Bunker_01_blocks_1_F',8],
		['Land_Bunker_01_blocks_3_F',8]
	];
	_normalObjectData = [
	
	];
	_unitsData = [
		[
			['o_soldier_ar_f',2],
			['o_medic_f',1],
			['o_engineer_f',1],
			['o_soldier_exp_f',1],
			['o_soldier_gl_f',1],
			['o_soldier_m_f',1],
			['o_soldier_f',1],
			['o_soldier_sl_f',1],
			['o_soldier_tl_f',1]
		],
		[
			['o_t_soldier_ar_f',2],
			['o_t_medic_f',1],
			['o_t_engineer_f',1],
			['o_t_soldier_exp_f',1],
			['o_t_soldier_gl_f',1],
			['o_t_soldier_m_f',1],
			['o_t_soldier_f',1],
			['o_t_soldier_tl_f',1],
			['o_t_soldier_sl_f',1]
		]
	] select (worldName in ['Tanoa','Lingor3']);
	private _object = objNull;
	private _type = '';
	private _configClass = configNull;
	private _model = '';
	private _quantity = 0;
	if (!(_simpleObjectData isEqualTo [])) then {
		{
			_type = _x select 0;
			_quantity = _x select 1;
			_configClass = configFile >> 'CfgVehicles' >> _type;
			_model = getText (_configClass >> 'model');
			if ((_model select [0,1]) isEqualTo '\') then {
				_model = _model select [1];
			};
			if (!((_model select [((count _model) - 4),4]) isEqualTo '.p3d')) then {
				_model = _model + '.p3d';
			};
			for '_x' from 0 to (_quantity - 1) step 1 do {
				_object = createSimpleObject [_model,[-1100,-1100,0]];
				0 = _simpleObjects pushBack _object;
			};
		} forEach _simpleObjectData;
	};
	if (!(_normalObjectData isEqualTo [])) then {
		{
			_type = _x select 0;
			_quantity = _x select 1;
			for '_x' from 0 to (_quantity - 1) step 1 do {
				_object = createVehicle [_type,[-1100,-1100,0],[],0,'CAN_COLLIDE'];
				_normalObjects pushBack _object;
			};
		} forEach _normalObjectData;
	};
	if (!(_unitsData isEqualTo [])) then {
		if (missionNamespace getVariable ['QS_recycler_units',FALSE]) then {
			_nullGrp = createGroup [CIVILIAN,FALSE];
			_nullGrp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_nullGrp enableDynamicSimulation FALSE;
			missionNamespace setVariable ['QS_recycler_nullGrp',_nullGrp,FALSE];
			private _unit = objNull;
			{
				_type = _x select 0;
				_quantity = _x select 1;
				for '_x' from 0 to (_quantity - 1) step 1 do {
					_unit = _nullGrp createUnit [_type,[-1100,-1100,0],[],0,'CAN_COLLIDE'];
					_unit allowDamage FALSE;
					_unit enableDynamicSimulation FALSE;
					_unit hideObjectGlobal TRUE;
					_unit enableSimulationGlobal FALSE;
					_unit disableAI 'ALL';
					_unit setVariable ['QS_dynSim_ignore',TRUE,FALSE];
					_unit setVariable ['QS_curator_disableEditability',TRUE,FALSE];
					[_unit] joinSilent _nullGrp;
					_units pushBack _unit;
				};
			} forEach _unitsData;
		};
	};
	missionNamespace setVariable ['QS_recycler_objects',[_normalObjects,_simpleObjects,_units],FALSE];
};
if (_type isEqualTo 1) exitWith {
	_return = FALSE;
	_object = _this select 2;
	// Put object into recycler
	if (!isNull _object) then {
		if (!(isSimpleObject _object)) then {
			if ((_object isKindOf 'CAManBase') && (alive _object)) then {
				if (missionNamespace getVariable ['QS_recycler_units',FALSE]) then {
					if (local _object) then {
						// if the unit is the right type and there is room in the recycler
						if (({(alive _x)} count ((missionNamespace getVariable 'QS_recycler_objects') select 2)) < (missionNamespace getVariable ['QS_recycler_unitCount',10])) then {
							if ((toLower (typeOf _object)) in (missionNamespace getVariable ['QS_recycler_unitTypes',[]])) then {
								_return = TRUE;
								private _grp = missionNamespace getVariable ['QS_recycler_nullGrp',grpNull];
								if (isNull _grp) then {
									_grp = createGroup [CIVILIAN,FALSE];
									missionNamespace setVariable ['QS_recycler_nullGrp',_grp,FALSE];
									_grp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
									_grp enableDynamicSimulation FALSE;
								} else {
									if (!local _grp) then {
										_grp setGroupOwner 2;
									};
								};
								{
									if (!isNull _object) then {
										_object setVariable [_x,nil,FALSE];
									};
								} forEach (allVariables _object);
								_object setVariable ['QS_dynSim_ignore',TRUE,FALSE];
								_object setVariable ['QS_curator_disableEditability',TRUE,FALSE];
								_object setPosASL (missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]]);
								_object hideObjectGlobal TRUE;
								_object enableSimulationGlobal FALSE;
								_object enableDynamicSimulation FALSE;
								_object disableAI 'ALL';
								[_object] joinSilent _grp;
								if ((damage _object) > 0) then {
									_object setDamage [0,FALSE];
								};
								_recycledUnits = (missionNamespace getVariable 'QS_recycler_objects') select 2;
								_recycledUnits pushBack _object;
								(missionNamespace getVariable 'QS_recycler_objects') set [2,_recycledUnits];
								if (!(allCurators isEqualTo [])) then {
									{
										_x removeCuratorEditableObjects [[_object],TRUE];
									} forEach allCurators;
								};
							};
						};
					};
				};
			} else {
				if (_object in ((missionNamespace getVariable 'QS_recycler_objects') select 0)) then {
					_return = TRUE;
					_object setPos (missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]]);
				};
			};
		} else {
			if (_object in ((missionNamespace getVariable 'QS_recycler_objects') select 1)) then {
				_return = TRUE;
				_object setPos (missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]]);
			};
		};
	};
	if (_return) then {};
	_return;
};
if (_type isEqualTo 2) exitWith {
	private _class = _this select 2;
	_class = toLower _class;
	_position = missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]];
	private _exit = FALSE;
	// Get object from recycler
	_validObjects = [
		[
			'land_hbarrier_01_line_3_green_f',
			'land_hbarrier_01_line_5_green_f',
			'land_hbarrier_01_big_4_green_f',
			'land_hbarrier_01_line_1_green_f',
			'land_hbarrier_01_wall_corner_green_f',
			'land_hbarrier_01_wall_6_green_f',
			'land_hbarrier_01_wall_4_green_f',
			'land_bagfence_01_corner_green_f',
			'land_bagfence_01_end_green_f',
			'land_bagfence_01_long_green_f',
			'land_bagfence_01_round_green_f',
			'land_bagfence_01_short_green_f',
			'land_hbarrier_3_f',
			'land_hbarrier_5_f',
			'land_hbarrier_big_f',
			'land_hbarrier_1_f',
			'land_hbarrierwall_corner_f',
			'land_hbarrierwall6_f',
			'land_hbarrierwall4_f',
			'land_mil_wallbig_4m_f',
			'land_bunker_01_blocks_1_f',
			'land_bagfence_corner_f',
			'land_bagfence_end_f',
			'land_bagfence_long_f',
			'land_bagfence_round_f',
			'land_bagfence_short_f',
			'land_paperbox_closed_f',
			'land_paperbox_open_full_f'
		],
		[
			'a3\structures_f_exp\military\fortifications\hbarrier_01_line_3_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_line_5_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_big_4_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_line_1_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_wall_corner_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_wall_6_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\hbarrier_01_wall_4_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\bagfence_01_corner_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\bagfence_01_end_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\bagfence_01_long_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\bagfence_01_round_green_f.p3d',
			'a3\structures_f_exp\military\fortifications\bagfence_01_short_green_f.p3d',
			'a3\structures_f\mil\fortification\hbarrier_3_f.p3d',
			'a3\structures_f\mil\fortification\hbarrier_5_f.p3d',
			'a3\structures_f\mil\fortification\hbarrier_big_f.p3d',
			'a3\structures_f\mil\fortification\hbarrier_1_f.p3d',
			'a3\structures_f\mil\fortification\hbarrierwall_corner_f.p3d',
			'a3\structures_f\mil\fortification\hbarrierwall6_f.p3d',
			'a3\structures_f\mil\fortification\hbarrierwall4_f.p3d',
			'a3\structures_f\walls\mil_wallbig_4m_f.p3d',
			'a3\structures_f_argo\military\bunkers\bunker_01_blocks_1_f.p3d',
			'a3\structures_f_argo\military\bunkers\bunker_01_blocks_3_f.p3d',
			'a3\structures_f\mil\bagfence\bagfence_corner_f.p3d',
			'a3\structures_f\mil\bagfence\bagfence_end_f.p3d',
			'a3\structures_f\mil\bagfence\bagfence_long_f.p3d',
			'a3\structures_f\mil\bagfence\bagfence_round_f.p3d',
			'a3\structures_f\mil\bagfence\bagfence_short_f.p3d',
			'a3\structures_f_epa\mil\scrapyard\paperbox_closed_f.p3d',
			'a3\structures_f_epa\mil\scrapyard\paperbox_open_full_f.p3d'
		],
		(missionNamespace getVariable ['QS_recycler_unitTypes',[]])
	];
	if (_type2 isEqualTo 0) then {
		// Normal objects
		_validNormalObjects = _validObjects select _type2;
		if (_class in _validNormalObjects) then {
			// Request is valid, search recycler for available prop
			_props = (missionNamespace getVariable 'QS_recycler_objects') select _type2;
			if (!(_props isEqualTo [])) then {
				{
					if (!isNull _x) then {
						if ((toLower (typeOf _x)) isEqualTo _class) then {
							if ((_x distance2D _position) < 50) then {
								// Prop is available
								_return = _x;
								_exit = TRUE;
							};
						};
					};
					if (_exit) exitWith {};
				} forEach _props;
			};
		};
	};	
	if (_type2 isEqualTo 1) then {
		// Simple objects
		_validSimpleObjects = _validObjects select _type2;
		if (_class in _validSimpleObjects) then {
			// Request is valid, search recycler for available prop
			_props = (missionNamespace getVariable 'QS_recycler_objects') select _type2;
			if (!(_props isEqualTo [])) then {
				{
					if (!isNull _x) then {
						if ((toLower ((getModelInfo _x) select 1)) isEqualTo _class) then {
							if ((_x distance2D _position) < 50) then {
								// Prop is available
								_return = _x;
								_exit = TRUE;
							};
						};
					};
					if (_exit) exitWith {};
				} forEach _props;
			};		
		};
	};
	if (_type2 isEqualTo 2) then {
		// AI
		_validUnits = _validObjects select _type2;
		if (_class in _validUnits) then {
			_props = (missionNamespace getVariable 'QS_recycler_objects') select _type2;
			if (!(_props isEqualTo [])) then {
				{
					if (alive _x) then {
						if ((_x distance2D _position) < 50) then {
							if (isObjectHidden _x) then {
								// Prop is available
								_return = _x;
								_exit = TRUE;
							};
						};
					};
					if (_exit) exitWith {};
				} forEach _props;	
			};
		};
	};
	_return;
};
_return;