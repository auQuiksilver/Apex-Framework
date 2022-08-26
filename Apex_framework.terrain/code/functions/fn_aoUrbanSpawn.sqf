/*/
File: fn_aoUrbanSpawn.sqf
Author: 

	Quiksilver

Last Modified:

	18/08/2022 A3 2.10 by Quiksilver

Description:

	AO Urban Spawn System
____________________________________________/*/

params ['_type'];
private _return = [];
private _unitTypes = [
	"o_soldieru_a_f","o_soldieru_aar_f","o_soldieru_ar_f","o_soldieru_medic_f","o_engineer_u_f","o_soldieru_exp_f","o_soldieru_gl_f",
	"o_urban_heavygunner_f","o_soldieru_m_f","o_soldieru_at_f","o_soldieru_f","o_soldieru_lat_f","o_urban_sharpshooter_f",
	"o_soldieru_sl_f","o_soldieru_tl_f","o_g_engineer_f","o_g_medic_f","o_g_soldier_a_f","o_g_soldier_ar_f","o_g_soldier_exp_f","o_g_soldier_f","o_g_soldier_f",
	"o_g_soldier_gl_f","o_g_soldier_lat_f","o_g_soldier_lite_f","o_g_soldier_m_f","o_g_soldier_sl_f","o_g_soldier_tl_f",
	"o_g_sharpshooter_f","o_g_soldier_ar_f"
];
if (_type isEqualTo 'INIT') exitWith {
	private _pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
	private _aoSize = missionNamespace getVariable ['QS_aoSize',500];
	private _registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
	private _buildingData = (nearestObjects [_pos,['House'],_aoSize * 0.75,TRUE]) select {
		(alive _x) &&
		{((count (_x buildingPos -1)) > 4)} && 
		{(!isObjectHidden _x)} &&
		{((_registeredPositions inAreaArray [getPosATL _x,50,50,0,FALSE]) isEqualTo [])}
	};
	if ((count _buildingData) >= 8) then {
		_buildingData = _buildingData call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_buildingData = _buildingData select [0,8]; 													//comment 'We need to ensure we arent using all buildings in small towns';
		_buildingData = _buildingData apply { [_x,objNull,_x buildingPos -1] };							//_buildingData = _buildingData apply { [_x,objNull,([_x,_x buildingPos -1] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions'))] };
		private _bldgPos = [];
		{
			_bldgPos = _x # 2;
			_bldgPos = _bldgPos apply { _x vectorAdd [0,0,0.5] };
			_buildingData set [_forEachIndex,[_x # 0,_x # 1,_bldgPos]];
		} forEach _buildingData;
		missionNamespace setVariable ['QS_ao_urbanSpawn_data',_buildingData,FALSE];
		private _buildingData = missionNamespace getVariable ['QS_ao_urbanSpawn_data',[]];
		// spawn "node" units
		private _unit = objNull;
		private _grp = createGroup [RESISTANCE,TRUE]; 														//comment 'change this to resistance later';
		private _buildingPositions = [];
		private _buildingPos = [0,0,0];
		private _nodes = [];
		_nodeUnitTypes = [
			"i_c_soldier_para_1_f","i_c_soldier_para_2_f","i_c_soldier_para_3_f",
			"i_c_soldier_para_4_f","i_c_soldier_para_5_f","i_c_soldier_para_6_f",
			"i_c_soldier_para_7_f","i_c_soldier_para_8_f"
		];
		{
			_buildingPositions = (_x # 0) buildingPos -1;
			_buildingPos = selectRandom _buildingPositions;
			_unit = _grp createUnit [selectRandom _nodeUnitTypes,_buildingPos,[],0,'CAN_COLLIDE'];
			_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit enableAIFeature ['PATH',FALSE];
			_unit enableAIFeature ['MINEDETECTION',FALSE];
			_unit enableAIFeature ['PATH',FALSE];
			_unit setPos _buildingPos;
			_unit setUnitPos 'MIDDLE';
			_nodes pushBack _unit;
			(missionNamespace getVariable 'QS_classic_AI_enemy_0') pushBack _unit;
			_buildingData set [_forEachIndex,[_x # 0,_unit,_x # 2]];
		} forEach _buildingData;
		[(units _grp),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_grp setGroupIDGlobal ['Enemy Respawn Nodes'];
		{
			missionNamespace setVariable _x;
		} forEach [
			['QS_ao_urbanSpawn_data',_buildingData,FALSE],
			['QS_ao_urbanSpawn_bldgs',_buildingData apply { _x # 0 },FALSE],
			['QS_ao_urbanSpawn_nodes',_nodes,FALSE],
			['QS_ao_urbanSpawn_init',TRUE,FALSE],
			['QS_ao_urbanSpawn',TRUE,FALSE]
		];
	} else {
		missionNamespace setVariable ['QS_ao_urbanSpawn',FALSE,FALSE];
	};
	_return;
};
if (_type isEqualTo 'REINFORCE') exitWith {
	diag_log '***** DEBUG ***** AO REINFORCE ***** 1 *****';
	params ['','_validData','_allPlayers'];
	_usedData = selectRandom _validData;
	_usedData params ['_building','_unit','_buildingPositions'];
	_nearbyPlayers = _allPlayers inAreaArray [getPosATL _building,500,500,0,FALSE];
	if (_nearbyPlayers isNotEqualTo []) then {
		diag_log '***** DEBUG ***** AO REINFORCE ***** 2 *****';
		_isPosVisible = {
			params ['_position','_units','_tolerance','_returnType'];
			scopeName 'main';
			private _returnVisibilty = 0;
			private _visibility = 0;
			private _eyePos = [0,0,0];
			{
				_eyePos = (eyePos _x) vectorAdd [0,0,0.5];
				_visibility = ([_x,'VIEW'] checkVisibility [_eyePos,_position]) max ([_x,'GEOM'] checkVisibility [_eyePos,_position]);
				if (_visibility > _tolerance) then {
					_returnVisibilty = _returnVisibilty + _visibility;
					breakTo 'main';
				};
			} forEach _units;
			if (_returnType isEqualType TRUE) exitWith {
				(_returnVisibilty > _tolerance)
			};
			_returnVisibilty;
		};
		_buildingPositions = _buildingPositions select {
			!([_x,_nearbyPlayers,0.5,TRUE] call _isPosVisible)
		};
	};
	diag_log '***** DEBUG ***** AO REINFORCE ***** 3 *****';
	private _buildingPosition = [0,0,0];
	private _urbanUnits = [];
	if (_buildingPositions isNotEqualTo []) then {
		diag_log '***** DEBUG ***** AO REINFORCE ***** 4 *****';
		_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		private _infTypes = [
			[
				'OIA_InfSquad',2,
				'OIA_InfTeam',2,
				'OI_reconPatrol',1,
				'OIA_InfAssault',2,
				'OG_InfSquad',1,
				'OG_InfAssaultTeam',1,
				'OIA_ARTeam',2,
				'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
				'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
				'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
			],
			[
				'OIA_InfSquad',2,
				'OIA_InfTeam',2,
				'OI_reconPatrol',1,
				'OIA_InfAssault',2,
				'OG_InfSquad',1,
				'OG_InfAssaultTeam',1,
				'OIA_ARTeam',2,
				'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
				'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
				'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
			]
		] select (_worldName isEqualTo 'Altis');
		_groupComposition = ([EAST,selectRandomWeighted _infTypes] call (missionNamespace getVariable 'QS_fnc_returnGroupComposition')) apply { _x # 0 };
		_maxGrpSize = (count _groupComposition) - 1;
		private _newUnit = objNull;
		private _newGrp = createGroup [EAST,TRUE];
		_serverTime = serverTime;
		private _i = 0;
		diag_log '***** DEBUG ***** AO REINFORCE ***** 5 *****';
		for '_i' from 0 to (((count _buildingPositions) - 1) min _maxGrpSize) step 1 do {
			_buildingPosition = _buildingPositions deleteAt 0;
			_newUnit = _newGrp createUnit [_groupComposition # _i,[worldSize,worldSize,0],[],0,'CAN_COLLIDE'];	//comment 'SET TO PRONE OFFSITE';
			_newUnit enableAIFeature ['PATH',FALSE];
			_newUnit setVariable ['QS_AI_UNIT_delayedInstructions',[(_serverTime + (5 + (random 60))),1],QS_system_AI_owners];
			_newUnit hideObjectGlobal TRUE;
			//comment 'SET TO PRONE OFFSITE';
			_urbanUnits pushBack _newUnit;
			_newUnit = _newUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_newUnit setUnitPos 'DOWN';
			_newUnit setPos (_buildingPosition vectorAdd [0,0,-0.5]);
			_newUnit switchMove 'amovppnemstpsraswrfldnon';
		};
		// This section makes a few assumptions about available patrol positions
		private _newPatrolRoute = ((missionNamespace getVariable 'QS_ao_urbanSpawn_bldgs') apply { ((getPos _x) vectorAdd [0,0,1]) }) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_newPatrolRoute = _newPatrolRoute select [0,3];
		_newPatrolRoute pushBack ((selectRandom (missionNamespace getVariable ['QS_registeredPositions',[]])) getPos [30 + (random 30),random 360]);
		_newPatrolRoute pushBack ((missionNamespace getVariable 'QS_hqPos') getPos [random 50, random 360]);
		_newPatrolRoute = _newPatrolRoute call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		diag_log '***** DEBUG ***** AO REINFORCE ***** 6 *****';
		[(units _newGrp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		_newGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_newPatrolRoute,_serverTime,-1],QS_system_AI_owners];
		_newGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
		_newGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_newGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _newGrp))],QS_system_AI_owners];
		_newGrp setVariable ['QS_AI_GRP_DATA',[TRUE,_serverTime],QS_system_AI_owners];
		_newGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		_urbanUnits spawn {
			sleep 2;
			{
				_x hideObjectGlobal FALSE;
				sleep 0.5;
				_x hideObjectGlobal FALSE;	// Do it twice just incase of packet loss/desync
				_x setUnitPos 'AUTO';
				_x enableAIFeature ['ANIM',TRUE];
			} forEach _this;
		};
	};
	_urbanUnits;
};
if (_type isEqualTo 'HQ') exitWith {
	params ['','_allPlayers'];
	private _hqUnits = [];
	private _buildingPositions = missionNamespace getVariable ['QS_ao_hqBuildingPositions',[]];
	if (_buildingPositions isNotEqualTo []) then {
		_nearbyPlayers = _allPlayers inAreaArray [(missionNamespace getVariable 'QS_hqPos'),300,300,0,FALSE];
		if (_nearbyPlayers isNotEqualTo []) then {
			_isPosVisible = {
				params ['_position','_units','_tolerance','_returnType'];
				scopeName 'main';
				private _returnVisibilty = 0;
				private _visibility = 0;
				private _eyePos = [0,0,0];
				{
					_position = _position vectorAdd [0,0,0.3];
					_eyePos = (eyePos _x) vectorAdd [0,0,0.5];
					_visibility = ([_x,'VIEW'] checkVisibility [_eyePos,_position]) max ([_x,'GEOM'] checkVisibility [_eyePos,_position]);
					if (_visibility > _tolerance) then {
						_returnVisibilty = _returnVisibilty + _visibility;
						breakTo 'main';
					};
				} forEach _units;
				if (_returnType isEqualType TRUE) exitWith {
					(_returnVisibilty > _tolerance)
				};
				_returnVisibilty;
			};
			_buildingPositions = _buildingPositions select {
				!([_x,_nearbyPlayers,0.5,TRUE] call _isPosVisible)
			};
		};
		if (_buildingPositions isNotEqualTo []) then {
			_garrisonThreshold = 6;			// If number of enemies near HQ is <= 6, next group will become HQ guards. if > 6, next group will be regular AO infantry
			private _isGarrisonLow = (count ( (units EAST) inAreaArray [(missionNamespace getVariable 'QS_hqPos'),50,50,0,FALSE])) <= _garrisonThreshold;
			_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			private _infTypes = [
				[
					(['OIA_InfSquad','OIA_GuardSquad2'] select _isGarrisonLow),([2,4] select _isGarrisonLow),
					'OIA_InfSquad',2,
					'OIA_ARTeam',2,
					'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
					'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
					'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
				],
				[
					(['OIA_InfSquad','OIA_GuardSquad2'] select _isGarrisonLow),([2,4] select _isGarrisonLow),
					'OIA_InfSquad',2,
					'OIA_ARTeam',2,
					'OIA_InfTeam_HAT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2),
					'OIA_InfTeam_AA',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_air',0]) min 3),
					'OIA_InfTeam_AT',(1 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 2)
				]
			] select (worldName in ['Altis','Malden']);
			_groupComposition = ([EAST,selectRandomWeighted _infTypes] call (missionNamespace getVariable 'QS_fnc_returnGroupComposition')) apply { _x # 0 };
			_maxGrpSize = (count _groupComposition) - 1;
			private _newUnit = objNull;
			private _newGrp = createGroup [EAST,TRUE];
			_serverTime = serverTime;
			private _i = 0;
			private _buildingPosition = [0,0,0];
			for '_i' from 0 to (((count _buildingPositions) - 1) min _maxGrpSize) step 1 do {
				_buildingPosition = _buildingPositions deleteAt 0;
				_newUnit = _newGrp createUnit [_groupComposition # _i,[worldSize,worldSize,0],[],0,'CAN_COLLIDE'];	//comment 'SET TO PRONE OFFSITE';
				_newUnit enableAIFeature ['PATH',FALSE];
				_newUnit setVariable ['QS_AI_UNIT_delayedInstructions',[(_serverTime + (5 + (random 60))),1],QS_system_AI_owners];
				_newUnit hideObjectGlobal TRUE;
				//comment 'SET TO PRONE OFFSITE';
				_hqUnits pushBack _newUnit;
				_newUnit = _newUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				_newUnit setUnitPos 'DOWN';
				_newUnit setPos (_buildingPosition vectorAdd [0,0,0.25]);
				_newUnit switchMove 'amovppnemstpsraswrfldnon';
			};
			if (_isGarrisonLow) then {
				// HQ guards
				_defendRadius = 35;
				[(units _newGrp),selectRandom [1,2]] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_newGrp setVariable ['QS_AI_GRP_TASK',['GUARD',(missionNamespace getVariable 'QS_hqPos'),_serverTime,-1],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _newGrp))],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_DATA',[TRUE,_serverTime,_defendRadius,'HQ'],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			} else {
				// General patrols
				private _patrolRoute = [];
				_patrolRoute pushBack ((selectRandom (missionNamespace getVariable ['QS_registeredPositions',[]])) getPos [30 + (random 30),random 360]);
				_terrainData = missionNamespace getVariable ['QS_classic_terrainData',[ [],[],[],[],[],[],[],[],[],[] ] ];
				if ((_terrainData # 6) isNotEqualTo []) then {
					_patrolRoute pushBack (selectRandom (_terrainData # 6));
				};
				if ((_terrainData # 8) isNotEqualTo []) then {
					_patrolRoute pushBack (selectRandom (_terrainData # 8));
				};
				_newGrp setVariable ['QS_AI_GRP_TASK',['PATROL',_patrolRoute,_serverTime,-1],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _newGrp))],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_DATA',[TRUE,_serverTime],QS_system_AI_owners];
				_newGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			};
			_hqUnits spawn {
				sleep 2;
				{
					_x hideObjectGlobal FALSE;
					sleep 0.5;
					_x hideObjectGlobal FALSE;	// Do it twice just incase of packet loss/desync
					_x setUnitPos 'AUTO';
					_x enableAIFeature ['ANIM',TRUE];
				} forEach _this;
			};
		};
	};
	_hqUnits;
};
_return;