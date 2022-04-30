/*/
File: fn_aoEnemyReinforceEvent.sqf
Author:

	Quiksilver
	
Last modified:

	11/05/2016 A3 1.58 by Quiksilver
	
Description:

	AO reinforcement event
	
	[1] call QS_fnc_aoEnemyReinforceEvent;
__________________________________________________/*/

QS_fnc_aoEnemyReinforceEvent3 = {
	_event = _this select 0;
	if (_event isEqualTo 1) exitWith {
		private ['_centerPos','_foundSpawnPos','_spawnPos','_v','_grp','_direction','_HLZ','_unit','_unitType','_unitTypes','_grp2','_wp','_foundHLZ','_helipad','_array'];
		_type = param [1,'O_Heli_Transport_04_covered_F'];
		_array = [];
		_centerPos = QS_hqPos;
		_unitTypes = [
			"I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F",
			"I_C_Soldier_Bandit_1_F","I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F",
			"I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F",'O_T_Soldier_AA_F','O_T_Soldier_AT_F'
		];
		missionNamespace setVariable ['QS_helipads',[],FALSE];
		_unitType = '';
		for '_x' from 0 to 2 step 1 do {
			_foundSpawnPos = FALSE;
			for '_x' from 0 to 49 step 1 do {
				_spawnPos = _centerPos getPos [(2000 + (random 2000)),(random 360)];
				if ((allPlayers findIf {((_x distance2D _spawnPos) < 400)}) isEqualTo -1) then {
					if ((_spawnPos distance2D (markerPos 'QS_marker_base_marker')) > 2000) then {
						if ((_spawnPos distance2D _centerPos) < 1201) then {
							_foundSpawnPos = TRUE;
						};
					};
				};
				if (_foundSpawnPos) exitWith {};
			};
			_foundHLZ = FALSE;
			for '_x' from 0 to 49 step 1 do {
				_HLZ = [_centerPos,100,500,15,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
				if ((count _HLZ) > 0) then {
					if ((allPlayers findIf {((_x distance2D _HLZ) < 50)}) isEqualTo -1) then {
						if ((_HLZ distance2D _centerPos) < 500) then {
							_foundHLZ = TRUE;
						};
					};
				};
				if (_foundHLZ) exitWith {};
			};
			_HLZ set [2,0];
			_spawnPos set [2,100];
			_v = createVehicle [_type,_spawnPos,[],0,'FLY'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			0 = _array pushBack _v;
			_grp = createVehicleCrew _v;
			(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _v))),
				FALSE
			];
			_v engineOn TRUE;
			{
				_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
				0 = _array pushBack _x;
			} count (crew _v);
			_v addEventHandler [
				'HandleDamage',
				{
					_unit = _this select 0;
					_selections = _unit getVariable ['selections',[]];
					_gethit = _unit getVariable ['gethit',[]];
					_selection = _this select 1;
					if !(_selection in _selections) then {
						_selections set [count _selections,_selection];
						_gethit set [count _gethit,0];
					};
					_i = _selections find _selection;
					_olddamage = _gethit select _i;
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
					_gethit set [_i,_damage];
					_damage;
				}
			];
			_v allowCrewInImmobile TRUE;
			_v lock 3;
			_grp setVariable ['QS_IA_spawnPos',_spawnPos,FALSE];
			{
				_x disableAI 'AUTOCOMBAT';
				_x disableAI 'COVER';
				_x disableAI 'TARGET';
				_x disableAI 'AUTOTARGET';
				_x disableAI 'SUPPRESSION';
			} count (units _grp);
			_direction = _spawnPos getDir _HLZ;
			_v setDir _direction;
			_grp2 = createGroup [EAST,TRUE];
			for '_x' from 0 to (round(((_v emptyPositions 'Cargo') - 1) / 2)) step 1 do {
				_unitType = selectRandom _unitTypes;
				_unit = _grp2 createUnit [_unitType,[0,0,0],[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				_unit assignAsCargo _v;
				_unit moveInAny _v;
				0 = _array pushBack _unit;
			};
			[(units _grp2),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			[_grp2,_centerPos,FALSE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
			_grp2 enableAttack TRUE;
			if (isServer) then {
				if (!(allCurators isEqualTo [])) then {
					{
						_x addCuratorEditableObjects [[_v],TRUE];
					} count allCurators;
				};
			};
			_helipad = 'Land_HelipadEmpty_F' createVehicleLocal _HLZ;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			0 = QS_helipads pushBack _helipad;
			0 = _array pushBack _helipad;
			_v setVariable ['QS_assignedHelipad',_helipad,FALSE];
			_v addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					if (!isNil {_killed getVariable 'QS_assignedHelipad'}) then {
						if (!isNull (_killed getVariable 'QS_assignedHelipad')) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle (_killed getVariable 'QS_assignedHelipad');
						};
					};
				}
			];
			if (isServer) then {
				if (!(allCurators isEqualTo [])) then {
					{
						_x addCuratorEditableObjects [[_helipad],TRUE];
					} count allCurators;
				};
			};
			
			QS_fnc_deleteHelipads = {
				private ["_v","_g","_wp","_grp"];
				_v = vehicle (_this select 0);
				_g = group (_this select 0);
				_v land "get out";
				waitUntil {(isTouchingGround _v)};
				{
					if (!(_x in [(driver _v),(_v turretUnit [0]),(_v turretUnit [1])])) then {
						_grp = group _x;
						_x leaveVehicle _v;
						moveOut _x;
					};
				} count (crew _v);
				[_grp,(markerPos 'QS_marker_hqMarker'),TRUE] call QS_fnc_taskAttack;
				if ((random 1) > 0.5) then {
					_wp = _g addWaypoint [[0,0,50],0];
				} else {
					_wp = _g addWaypoint [[worldSize,worldSize,50],0];
				};
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCombatMode "BLUE";
				_wp setWaypointCompletionRadius 300;
				_wp setWaypointStatements [
					"TRUE",
					"
						if (!(local this)) exitWith {};
						_v = vehicle this;
						{
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						} count (crew (vehicle this));							
						if (!isNull (_v getVariable 'QS_assignedHelipad')) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle (_v getVariable 'QS_assignedHelipad');
						};
						missionNamespace setVariable [
							'QS_analytics_entities_deleted',
							((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
							FALSE
						];
						deleteVehicle _v;
					"
				];
			};
			
			_wp = _grp addWaypoint [_HLZ,0];
			_wp setWaypointType 'TR UNLOAD';
			_wp setWaypointSpeed 'NORMAL';
			_wp setWaypointBehaviour 'CARELESS';
			_wp setWaypointCombatMode 'BLUE';
			_wp setWaypointStatements [
				'TRUE',
				'
					if (!(local this)) exitWith {};
					[this] spawn QS_fnc_deleteHelipads;
				'
			];
		};
		_array;
	};
};
[1] call QS_fnc_aoEnemyReinforceEvent3;
QS_fnc_aoEnemyReinforceEvent3 = {
	_event = _this select 0;
	if (_event isEqualTo 1) exitWith {
		private ['_centerPos','_foundSpawnPos','_spawnPos','_v','_grp','_direction','_HLZ','_unit','_unitType','_unitTypes','_grp2','_wp','_foundHLZ','_helipad','_array'];
		_type = param [1,'O_Heli_Transport_04_covered_F'];
		_array = [];
		_centerPos = position player;
		_unitTypes = [
			"O_soldier_F"
		];
		missionNamespace setVariable ['QS_helipads',[],FALSE];
		_unitType = '';
		for '_x' from 0 to 2 step 1 do {
			_foundSpawnPos = FALSE;
			for '_x' from 0 to 49 step 1 do {
				_spawnPos = _centerPos getPos [(2000 + (random 2000)),(random 360)];
				if ((allPlayers findIf {((_x distance2D _spawnPos) < 400)}) isEqualTo -1) then {
						if ((_spawnPos distance2D _centerPos) < 1201) then {
							_foundSpawnPos = TRUE;
						};
				};
				if (_foundSpawnPos) exitWith {};
			};
			_foundHLZ = FALSE;
			for '_x' from 0 to 49 step 1 do {
				_HLZ = [_centerPos,100,500,15,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
				if (!(_HLZ isEqualTo [])) then {
					if ((allPlayers findIf {((_x distance2D _HLZ) < 50)}) isEqualTo -1) then {
						if ((_HLZ distance2D _centerPos) < 500) then {
							_foundHLZ = TRUE;
						};
					};
				};
				if (_foundHLZ) exitWith {};
			};
			_HLZ set [2,0];
			_spawnPos set [2,100];
			_v = createVehicle [_type,_spawnPos,[],0,'FLY'];
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			0 = _array pushBack _v;
			_grp = createVehicleCrew _v;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _v))),
				FALSE
			];
			_v engineOn TRUE;
			{
				0 = _array pushBack _x;
			} count (crew _v);
			_v addEventHandler [
				'HandleDamage',
				{
					_unit = _this select 0;
					_selections = _unit getVariable ['selections',[]];
					_gethit = _unit getVariable ['gethit',[]];
					_selection = _this select 1;
					if !(_selection in _selections) then {
						_selections set [count _selections,_selection];
						_gethit set [count _gethit,0];
					};
					_i = _selections find _selection;
					_olddamage = _gethit select _i;
					_damage = _olddamage + ((_this select 2) - _olddamage) * 0.25;
					_gethit set [_i,_damage];
					_damage;
				}
			];
			_v setUnloadInCombat [FALSE,FALSE];
			_v allowCrewInImmobile TRUE;
			_v flyInHeight (25 + (random 30));
			_v lock 3;
			_grp setVariable ['QS_IA_spawnPos',_spawnPos,FALSE];
			{
				_x disableAI 'AUTOCOMBAT';
				_x disableAI 'COVER';
				_x disableAI 'TARGET';
				_x disableAI 'AUTOTARGET';
				_x disableAI 'SUPPRESSION';
			} count (units _grp);
			_direction = _spawnPos getDir _HLZ;
			_v setDir _direction;
			_grp2 = createGroup [EAST,TRUE];
			for '_x' from 0 to ((_v emptyPositions 'Cargo') - 1) step 1 do {
				_unitType = selectRandom _unitTypes;
				_unit = _grp2 createUnit [_unitType,[0,0,0],[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_unit assignAsCargo _v;
				_unit moveInAny _v;
				0 = _array pushBack _unit;
			};
			[_grp2,_centerPos,FALSE] call (missionNamespace getVariable 'BIS_fnc_taskAttack');
			_grp2 enableAttack TRUE;
			if (isServer) then {
				if (!(allCurators isEqualTo [])) then {
					{
						_x addCuratorEditableObjects [[_v],TRUE];
					} count allCurators;
				};
			};
			_helipad = 'Land_HelipadEmpty_F' createVehicleLocal _HLZ;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			0 = QS_helipads pushBack _helipad;
			0 = _array pushBack _helipad;
			_v setVariable ['QS_assignedHelipad',_helipad,FALSE];
			_v addEventHandler [
				'Killed',
				{
					params ['_killed','_killer'];
					if (!isNil {_killed getVariable 'QS_assignedHelipad'}) then {
						if (!isNull (_killed getVariable 'QS_assignedHelipad')) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle (_killed getVariable 'QS_assignedHelipad');
						};
					};
				}
			];
			if (isServer) then {
				if (!(allCurators isEqualTo [])) then {
					{
						_x addCuratorEditableObjects [[_helipad],TRUE];
					} count allCurators;
				};
			};
			
			QS_fnc_deleteHelipads = {
				private ["_v","_g","_wp","_grp"];
				_v = vehicle (_this select 0);
				_g = group (_this select 0);
				_v land "get out";
				waitUntil {(isTouchingGround _v)};
				{
					if (!(_x in [(driver _v),(_v turretUnit [0]),(_v turretUnit [1])])) then {
						_grp = group _x;
						_x leaveVehicle _v;
						moveOut _x;
					};
				} count (crew _v);
				[_grp,(position player),TRUE] call QS_fnc_taskAttack;
				if ((random 1) > 0.5) then {
					_wp = _g addWaypoint [[0,0,50],0];
				} else {
					_wp = _g addWaypoint [[worldSize,worldSize,50],0];
				};
				_wp setWaypointType "MOVE";
				_wp setWaypointSpeed "FULL";
				_wp setWaypointBehaviour "CARELESS";
				_wp setWaypointCombatMode "BLUE";
				_wp setWaypointCompletionRadius 300;
				_wp setWaypointStatements [
					"TRUE",
					"
						if (!(local this)) exitWith {};
						_v = vehicle this;
						{
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle _x;
						} count (crew (vehicle this));							
						if (!isNull (_v getVariable 'QS_assignedHelipad')) then {
							missionNamespace setVariable [
								'QS_analytics_entities_deleted',
								((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
								FALSE
							];
							deleteVehicle (_v getVariable 'QS_assignedHelipad');
						};
						missionNamespace setVariable [
							'QS_analytics_entities_deleted',
							((missionNamespace getVariable 'QS_analytics_entities_deleted') + 1),
							FALSE
						];
						deleteVehicle _v;
					"
				];
			};
			
			_wp = _grp addWaypoint [_HLZ,0];
			_wp setWaypointType 'TR UNLOAD';
			_wp setWaypointSpeed 'NORMAL';
			_wp setWaypointBehaviour 'CARELESS';
			_wp setWaypointCombatMode 'BLUE';
			_wp setWaypointStatements [
				'TRUE',
				'
					if (!(local this)) exitWith {};
					[this] spawn QS_fnc_deleteHelipads;
				'
			];
		};
		_array;
	};
};
[1,'O_Heli_Transport_04_covered_F'] spawn QS_fnc_aoEnemyReinforceEvent3;