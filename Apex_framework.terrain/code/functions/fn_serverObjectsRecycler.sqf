/*/
File: fn_serverObjectsRecycler.sqf
Author: 

	Quiksilver

Last Modified:

	23/10/2023 A3 2.14 by Quiksilver

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
		['o_soldier_ar_f',2],
		['o_medic_f',1],
		['o_engineer_f',1],
		['o_soldier_exp_f',1],
		['o_soldier_gl_f',1],
		['o_soldier_m_f',1],
		['o_soldier_f',1],
		['o_soldier_sl_f',1],
		['o_soldier_tl_f',1]
	];
	private _object = objNull;
	private _type = '';
	private _configClass = configNull;
	private _model = '';
	private _quantity = 0;
	if (_simpleObjectData isNotEqualTo []) then {
		{
			_type = _x # 0;
			_quantity = _x # 1;
			_configClass = configFile >> 'CfgVehicles' >> _type;
			_model = getText (_configClass >> 'model');
			if ((_model select [0,1]) isEqualTo '\') then {
				_model = _model select [1];
			};
			if ((_model select [((count _model) - 4),4]) isNotEqualTo '.p3d') then {
				_model = _model + '.p3d';
			};
			for '_x' from 0 to (_quantity - 1) step 1 do {
				_object = createSimpleObject [_model,[-1100,-1100,0]];
				0 = _simpleObjects pushBack _object;
			};
		} forEach _simpleObjectData;
	};
	if (_normalObjectData isNotEqualTo []) then {
		{
			_type = _x # 0;
			_quantity = _x # 1;
			for '_x' from 0 to (_quantity - 1) step 1 do {
				_object = createVehicle [_type,[-1100,-1100,0],[],0,'CAN_COLLIDE'];
				_normalObjects pushBack _object;
			};
		} forEach _normalObjectData;
	};
	if (_unitsData isNotEqualTo []) then {
		if (missionNamespace getVariable ['QS_recycler_units',FALSE]) then {
			_nullGrp = createGroup [CIVILIAN,FALSE];
			_nullGrp setVariable ['QS_dynSim_ignore',TRUE,FALSE];
			_nullGrp enableDynamicSimulation FALSE;
			missionNamespace setVariable ['QS_recycler_nullGrp',_nullGrp,FALSE];
			private _unit = objNull;
			{
				_type = _x # 0;
				_quantity = _x # 1;
				for '_x' from 0 to (_quantity - 1) step 1 do {
					_unit = _nullGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _type,_type],[-1100,-1100,0],[],0,'CAN_COLLIDE'];
					_unit allowDamage FALSE;
					_unit enableDynamicSimulation FALSE;
					_unit hideObjectGlobal TRUE;
					_unit enableSimulationGlobal FALSE;
					_unit enableAIFeature ['ALL',FALSE];
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
	_object = _this # 2;
	// Put object into recycler
	if (
		(alive _object) &&
		{(_object isKindOf 'CAManBase')} &&
		{(!(isSimpleObject _object))} &&
		{(missionNamespace getVariable ['QS_recycler_units',FALSE])} &&
		{(({(alive _x)} count ((missionNamespace getVariable 'QS_recycler_objects') # 2)) < (missionNamespace getVariable ['QS_recycler_unitCount',10]))}
	) then {
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
		[_object] joinSilent _grp;
		{
			if (!isNull _object) then {
				_object setVariable [_x,nil,FALSE];
			};
		} forEach (allVariables _object);
		_object setVariable ['QS_dynSim_ignore',TRUE,FALSE];
		_object setVariable ['QS_curator_disableEditability',TRUE,FALSE];
		_object setPosASL (missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]]);
		if (local _object) then {
			_object hideObjectGlobal TRUE;
			_object enableSimulationGlobal FALSE;
			_object enableDynamicSimulation FALSE;
			_object enableAIFeature ['ALL',FALSE];
		} else {
			[
				[_object],
				{
					params ['_object'];
					_object hideObjectGlobal TRUE;
					_object enableSimulationGlobal FALSE;
					_object enableDynamicSimulation FALSE;
					_object enableAIFeature ['ALL',FALSE];
				}
			] remoteExec ['call',_object,FALSE];
		};
		if ((damage _object) > 0) then {
			_object setDamage [0,FALSE];
		};
		_recycledUnits = (QS_recycler_objects # 2) select {!isNull _x};
		_recycledUnits pushBack _object;
		QS_recycler_objects set [2,_recycledUnits];
		if (allCurators isNotEqualTo []) then {
			{
				_x removeCuratorEditableObjects [[_object],TRUE];
			} forEach allCurators;
		};
	} else {
		if (_object in ((missionNamespace getVariable 'QS_recycler_objects') # 0)) then {
			_return = TRUE;
			_object setPosASL (missionNamespace getVariable ['QS_recycler_position',[-1100,-1100,0]]);
		};
	};
	if (_return) then {};
	_return;
};
if (_type isEqualTo 2) exitWith {
	private _class = _this # 2;
	_class = toLowerANSI _class;
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
		[]
	];
	if (_type2 isEqualTo 0) then {
		// Normal objects
		_validNormalObjects = _validObjects # _type2;
		if (_class in _validNormalObjects) then {
			// Request is valid, search recycler for available prop
			_props = (missionNamespace getVariable 'QS_recycler_objects') # _type2;
			if (_props isNotEqualTo []) then {
				{
					if (
						(!isNull _x) &&
						{((toLowerANSI (typeOf _x)) isEqualTo _class)} &&
						{((_x distance2D _position) < 50)}
					) exitWith {
						_return = _x;
					};
				} forEach _props;
			};
		};
	};	
	if (_type2 isEqualTo 1) then {
		// Simple objects
		_validSimpleObjects = _validObjects # _type2;
		if (_class in _validSimpleObjects) then {
			// Request is valid, search recycler for available prop
			_props = (missionNamespace getVariable 'QS_recycler_objects') # _type2;
			if (_props isNotEqualTo []) then {
				{
					
					if (
						(!isNull _x) &&
						{((toLowerANSI ((getModelInfo _x) # 1)) isEqualTo _class)} &&
						{((_x distance2D _position) < 50)}
					) exitWith {
						_return = _x;
					};
				} forEach _props;
			};		
		};
	};
	if (_type2 isEqualTo 2) then {
		// AI
		_props = (missionNamespace getVariable 'QS_recycler_objects') # _type2;
		if (_props isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{(_x isKindOf 'CAManBase')} &&
					{((_x distance2D _position) < 50)} &&
					{(isObjectHidden _x)}
				) exitWith {
					_recycledUnits = QS_recycler_objects # 2;
					_recycledUnits deleteAt (_recycledUnits find _x);
					QS_recycler_objects set [2,_recycledUnits];
					_return = _x;
				};
			} forEach _props;
		};
	};
	_return;
};
_return;