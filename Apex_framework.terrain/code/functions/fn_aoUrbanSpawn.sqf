/*/
File: fn_aoUrbanSpawn.sqf
Author: 

	Quiksilver

Last Modified:

	9/10/2023 A3 2.14 by Quiksilver

Description:

	AO Urban Spawn System
____________________________________________/*/

params ['_type'];
private _return = [];
private _unitTypes = ['urbanspawn_units_1'] call QS_data_listUnits;
_worldName = worldName;
if (_type isEqualTo 'INIT') exitWith {
	private _pos = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
	private _aoSize = missionNamespace getVariable ['QS_aoSize',500];
	private _sizeMultiplier = 0.9;
	private _buildingCount = 8;
	private _safeDist = 50;
	if (_worldName in ['Stratis']) then {
		_sizeMultiplier = 1.1;
		_buildingCount = 5;
		_safeDist = 30;
	};
	private _hqPos = missionNamespace getVariable ['QS_hqPos',_pos];
	private _registeredPositions = missionNamespace getVariable ['QS_registeredPositions',[]];
	private _buildingData = (nearestObjects [_pos,['House'],_aoSize * _sizeMultiplier,TRUE]) select {
		(alive _x) &&
		{((sizeOf (typeOf _x)) > 10)} &&
		{((count (_x buildingPos -1)) >= 4)} && 
		{(!isObjectHidden _x)} &&
		{((_registeredPositions inAreaArray [_x,_safeDist,_safeDist,0,FALSE]) isEqualTo [])} &&
		{((_x distance2D _hqPos) > _safeDist)}
	};
	if ((count _buildingData) >= _buildingCount) then {
		_buildingData = _buildingData call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_buildingData = _buildingData select [0,_buildingCount]; 													//comment 'We need to ensure we arent using all buildings in small towns';
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
		_nodeUnitTypes = ['urbanspawn_nodes_1'] call QS_data_listUnits;
		private _unitType = '';
		{
			_buildingPositions = (_x # 0) buildingPos -1;
			_buildingPos = selectRandom _buildingPositions;
			_unitType = selectRandom _nodeUnitTypes;
			_unit = _grp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],_buildingPos,[],0,'CAN_COLLIDE'];
			_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_unit enableAIFeature ['PATH',FALSE];
			_unit enableAIFeature ['MINEDETECTION',FALSE];
			_unit setPos _buildingPos;
			_unit setUnitPos 'Middle';
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
	params ['','_validData','_allPlayers'];
	_usedData = selectRandom _validData;
	_usedData params ['_building','_unit','_buildingPositions'];
	_nearbyPlayers = _allPlayers inAreaArray [_building,500,500,0,FALSE];
	if (_nearbyPlayers isNotEqualTo []) then {
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
	private _buildingPosition = [0,0,0];
	private _urbanUnits = [];
	if (_buildingPositions isNotEqualTo []) then {
		_buildingPositions = _buildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		private _infTypes = ['urbanspawn_groups_1'] call QS_data_listUnits;
		if (_worldName isEqualTo 'Stratis') then {
			_infTypes = ['urbanspawn_groups_stratis_1'] call QS_data_listUnits;
		};
		private _infGroupType = selectRandomWeighted _infTypes;
		_groupComposition = QS_core_groups_map getOrDefault [toLowerANSI _infGroupType,[]];
		if (_groupComposition isEqualTo []) exitWith {
			diag_log (format ['***** DEBUG ***** Group composition is null - %1 *****',_infGroupType]);
		};
		_groupComposition = _groupComposition apply {_x # 0};
		_maxGrpSize = (count _groupComposition) - 1;
		private _newUnit = objNull;
		private _newGrp = createGroup [EAST,TRUE];
		_serverTime = serverTime;
		private _i = 0;
		private _unitType = '';
		for '_i' from 0 to (((count _buildingPositions) - 1) min _maxGrpSize) step 1 do {
			_buildingPosition = _buildingPositions deleteAt 0;
			_unitType = _groupComposition # _i;
			_newUnit = _newGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[worldSize,worldSize - 250,0],[],0,'CAN_COLLIDE'];	//comment 'SET TO PRONE OFFSITE';
			_newUnit enableAIFeature ['PATH',FALSE];
			_newUnit setVariable ['QS_AI_UNIT_delayedInstructions',[(_serverTime + (5 + (random 60))),1],QS_system_AI_owners];
			_newUnit hideObjectGlobal TRUE;
			//comment 'SET TO PRONE OFFSITE';
			_urbanUnits pushBack _newUnit;
			_newUnit = _newUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_newUnit setUnitPos 'Down';
			_newUnit setPos (_buildingPosition vectorAdd [0,0,-0.5]);
			_newUnit switchMove ['amovppnemstpsraswrfldnon'];
		};
		// This section makes a few assumptions about available patrol positions
		private _newPatrolRoute = ((missionNamespace getVariable 'QS_ao_urbanSpawn_bldgs') apply { ((getPosATL _x) vectorAdd [0,0,1]) }) call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
		_newPatrolRoute = _newPatrolRoute select [0,3];
		_newPatrolRoute pushBack ((selectRandom (missionNamespace getVariable ['QS_registeredPositions',[]])) getPos [30 + (random 30),random 360]);
		_newPatrolRoute pushBack ((missionNamespace getVariable 'QS_hqPos') getPos [random 50, random 360]);
		
		// Urban positions
		_nearHousesInArea = (missionNamespace getVariable 'QS_classic_terrainData') # 4;
		if ((count _nearHousesInArea) >= 5) then {
			_newPatrolRoute pushBack ((getPosATL (selectRandom _nearHousesInArea)) vectorAdd [0,0,1]);
		};		
		_newPatrolRoute = _newPatrolRoute call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
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
				_x setUnitPos 'Auto';
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
			private _infTypes = ['urbanspawn_groups_2'] call QS_data_listUnits;
			private _infGroupType = selectRandomWeighted _infTypes;
			_groupComposition = QS_core_groups_map getOrDefault [toLowerANSI _infGroupType,[]];
			if (_groupComposition isEqualTo []) exitWith {
				diag_log (format ['***** DEBUG ***** Group composition is null - %1 *****',_infGroupType]);
			};
			_groupComposition = _groupComposition apply {_x # 0};
			_maxGrpSize = (count _groupComposition) - 1;
			private _newUnit = objNull;
			private _newGrp = createGroup [EAST,TRUE];
			private _unitType = '';
			_serverTime = serverTime;
			private _i = 0;
			private _buildingPosition = [0,0,0];
			for '_i' from 0 to (((count _buildingPositions) - 1) min _maxGrpSize) step 1 do {
				_buildingPosition = _buildingPositions deleteAt 0;
				_unitType = _groupComposition # _i;
				_newUnit = _newGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[worldSize,worldSize - 500,0],[],0,'CAN_COLLIDE'];	//comment 'SET TO PRONE OFFSITE';
				_newUnit enableAIFeature ['PATH',FALSE];
				if (!(_isGarrisonLow)) then {
					_newUnit setVariable ['QS_AI_UNIT_delayedInstructions',[(_serverTime + (5 + (random 60))),1],QS_system_AI_owners];
				};
				_newUnit hideObjectGlobal TRUE;
				//comment 'SET TO PRONE OFFSITE';
				_hqUnits pushBack _newUnit;
				_newUnit = _newUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				_newUnit setUnitPos 'Down';
				_newUnit setPos (_buildingPosition vectorAdd [0,0,0.25]);
				_newUnit switchMove ['amovppnemstpsraswrfldnon'];
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
					_x setUnitPos 'Auto';
					_x enableAIFeature ['ANIM',TRUE];
				} forEach _this;
			};
		};
	};
	_hqUnits;
};
_return;