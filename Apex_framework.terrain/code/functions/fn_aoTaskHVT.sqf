/*/
File: fn_aoTaskHVT.sqf
Author: 

	Quiksilver

Last Modified:

	12/09/2017 A3 1.76 by Quiksilver

Description:

	High-Value Target task
____________________________________________________________________________/*/

params ['_case','_state','_data'];
private _return = -1;
if (_state isEqualTo 0) then {
	//comment 'Clean up mission';
	//comment 'Return empty array';
	_agent = _data select 0;
	_enemyArray = _data select 1;
	if (!isNull _agent) then {
		QS_garbageCollector pushBack [_agent,'NOW_DISCREET',0];
	};
	{
		if (!isNull _x) then {
			if (alive _x) then {
				0 = QS_garbageCollector pushBack [_x,'NOW_DISCREET',0];
			};
		};
	} count _enemyArray;
	missionNamespace setVariable ['QS_arrest_target',objNull,TRUE];
	missionNamespace setVariable ['QS_aoSmallTask_Arrested',FALSE,TRUE];
	_return = [];
};
if (_state isEqualTo 1) then {
	//comment 'Create mission';
	//comment 'Return array';
	_aoPos = markerPos 'QS_marker_aoMarker';
	_worldSize = worldSize;
	private _agent = objNull;
	if (_aoPos inPolygon [
		[0,0,0],
		[_worldSize,0,0],
		[_worldSize,_worldSize,0],
		[0,_worldSize,0]
	]) then {
		private ['_enemyArray','_buildingCandidate','_enemyUnit','_buildingList','_buildingPosition','_buildingPosition_2','_buildingPositionSafe'];
		_unitTypes = [
			'C_man_p_fugitive_F','C_man_p_shorts_1_F','C_man_p_fugitive_F_afro','C_man_p_shorts_1_F_afro',
			'C_man_p_fugitive_F_asia','C_man_p_shorts_1_F_asia','C_man_p_fugitive_F_euro','C_man_p_shorts_1_F_euro'
		];
		_unitType = selectRandom _unitTypes;
		_building = objNull;
		_buildingCandidate = objNull;
		private _houseTypes = [
			'Land_i_House_Small_03_V1_F',
			'Land_u_House_Big_02_V1_F',
			'Land_i_House_Big_02_V3_F',
			'Land_i_House_Big_02_V1_F',
			'Land_i_House_Big_02_V2_F',
			'Land_u_House_Big_01_V1_F',
			'Land_i_House_Big_01_V3_F',
			'Land_i_House_Big_01_V1_F',
			'Land_i_House_Big_01_V2_F',
			'Land_u_Shop_02_V1_F',
			'Land_i_Shop_02_V3_F',
			'Land_i_Shop_02_V1_F',
			'Land_i_Shop_02_V2_F',
			'Land_u_Shop_01_V1_F',
			'Land_i_Shop_01_V3_F',
			'Land_i_Shop_01_V1_F',
			'Land_i_Shop_01_V2_F',
			'Land_u_House_Small_01_V1_F',
			'Land_u_House_Small_02_V1_F',
			'Land_i_House_Small_02_V3_F',
			'Land_i_House_Small_02_V1_F',
			'Land_i_House_Small_02_V2_F',
			'Land_i_House_Small_01_V3_F',
			'Land_i_House_Small_01_V1_F',
			'Land_i_House_Small_01_V2_F',
			'Land_i_Stone_HouseBig_V3_F',
			'Land_i_Stone_HouseBig_V1_F',
			'Land_i_Stone_HouseBig_V2_F',
			'Land_i_Stone_HouseSmall_V3_F',
			'Land_i_Stone_HouseSmall_V1_F',
			'Land_i_Stone_Shed_V2_F',
			'Land_i_Stone_Shed_V1_F',
			'Land_i_Stone_Shed_V3_F',
			'Land_i_Stone_HouseSmall_V2_F',
			'Land_i_House_Big_02_b_blue_F',
			'Land_i_House_Big_02_b_pink_F',
			'Land_i_House_Big_02_b_whiteblue_F',
			'Land_i_House_Big_02_b_white_F',
			'Land_i_House_Big_02_b_brown_F',
			'Land_i_House_Big_02_b_yellow_F',
			'Land_i_House_Big_01_b_blue_F',
			'Land_i_House_Big_01_b_pink_F',
			'Land_i_House_Big_01_b_whiteblue_F',
			'Land_i_House_Big_01_b_white_F',
			'Land_i_House_Big_01_b_brown_F',
			'Land_i_House_Big_01_b_yellow_F',
			'Land_i_Shop_02_b_blue_F',
			'Land_i_Shop_02_b_pink_F',
			'Land_i_Shop_02_b_whiteblue_F',
			'Land_i_Shop_02_b_white_F',
			'Land_i_Shop_02_b_brown_F',
			'Land_i_Shop_02_b_yellow_F',
			'Land_Barn_01_brown_F',
			'Land_Barn_01_grey_F',
			'Land_i_House_Small_01_b_blue_F',
			'Land_i_House_Small_01_b_pink_F',
			'Land_i_House_Small_02_b_blue_F',
			'Land_i_House_Small_02_b_pink_F',
			'Land_i_House_Small_02_b_whiteblue_F',
			'Land_i_House_Small_02_b_white_F',
			'Land_i_House_Small_02_b_brown_F',
			'Land_i_House_Small_02_b_yellow_F',
			'Land_i_House_Small_02_c_blue_F',
			'Land_i_House_Small_02_c_pink_F',
			'Land_i_House_Small_02_c_whiteblue_F',
			'Land_i_House_Small_02_c_white_F',
			'Land_i_House_Small_02_c_brown_F',
			'Land_i_House_Small_02_c_yellow_F',
			'Land_i_House_Small_01_b_whiteblue_F',
			'Land_i_House_Small_01_b_white_F',
			'Land_i_House_Small_01_b_brown_F',
			'Land_i_House_Small_01_b_yellow_F',
			'Land_i_Stone_House_Big_01_b_clay_F',
			'Land_i_Stone_Shed_01_b_clay_F',
			'Land_i_Stone_Shed_01_b_raw_F',
			'Land_i_Stone_Shed_01_b_white_F',
			'Land_i_Stone_Shed_01_c_clay_F',
			'Land_i_Stone_Shed_01_c_raw_F',
			'Land_i_Stone_Shed_01_c_white_F',
			'Land_House_Big_04_F',
			'Land_House_Small_04_F',
			'Land_House_Small_05_F',
			'Land_Addon_04_F',
			'Land_House_Big_03_F',
			'Land_House_Small_02_F',
			'Land_House_Big_02_F',
			'Land_House_Small_03_F',
			'Land_House_Small_06_F',
			'Land_House_Big_01_F',
			'Land_Slum_02_F',
			'Land_Slum_01_F',
			'Land_GarageShelter_01_F',
			'Land_House_Small_01_F',
			'Land_Slum_03_F',
			'Land_Temple_Native_01_F',
			'Land_House_Native_02_F',
			'Land_House_Native_01_F',
			"Land_GH_House_1_F",
			"Land_GH_House_2_F",
			"Land_GH_MainBuilding_entry_F",
			"Land_GH_MainBuilding_right_F",
			"Land_GH_MainBuilding_left_F",
			"Land_GH_Gazebo_F",
			"Land_WIP_F"
		];
		_buildingList = nearestObjects [_aoPos,_houseTypes,((missionNamespace getVariable 'QS_aoSize') * 1.1),TRUE];
		if (_buildingList isEqualTo []) then {
			_buildingList = _aoPos nearObjects ['House',((missionNamespace getVariable 'QS_aoSize') * 1.1)];
		};
		if (!(_buildingList isEqualTo [])) then {
			_buildingList = _buildingList call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_allPlayers = allPlayers;
			{
				_buildingCandidate = _x;
				if (([(getPosATL _buildingCandidate),75,[WEST,CIVILIAN],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
					if ((count (_buildingCandidate buildingPos -1)) > 3) then {
						_building = _buildingCandidate;
					};
				};
			} count _buildingList;
			if (!isNull _building) then {
				_building setDamage [0,FALSE];
				_building allowDamage FALSE;
				_buildingPositions = _building buildingPos -1;
				/*/_agent = createAgent [_unitType,[0,0,0],[],0,'NONE'];/*/
				_agent = (createGroup [CIVILIAN,TRUE]) createUnit [_unitType,[0,0,0],[],0,'NONE'];
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				_agent setUnitLoadout [[[],[],[],["U_Marshal",[]],[],[],"H_Beret_blk","G_Shades_Black",[],["ItemMap","","","ItemCompass","ItemWatch",""]],FALSE];
				_agent setDir (random 360);
				_buildingPosition = selectRandom _buildingPositions;
				_agent setPos _buildingPosition;
				_agent setUnitPos 'MIDDLE';
				for '_x' from 0 to 2 step 1 do {
					_agent setVariable ['QS_surrenderable',TRUE,TRUE];
				};
				_agent disableAI 'PATH';
				_agent addEventHandler [
					'Hit',
					{
						(_this select 0) removeEventHandler ['Hit',_thisEventHandler];
						(_this select 0) enableAI 'PATH';
						(_this select 0) setUnitPosWeak 'MIDDLE';
					}
				];
				_agent addEventHandler [
					'Killed',
					{
						params ['_killed','_killer'];
						if (!isNull _killed) then {
							if (!isNull _killer) then {
								if (isPlayer _killer) then {
									_text = format ['Task failed! HVT killed by %1!',(name _killer)];
									['sideChat',[WEST,'HQ'],_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
								};
							};
						};
					}
				];
				_agent addEventHandler [
					'Deleted',
					{
						params ['_agent'];
						
					}
				];
				missionNamespace setVariable ['QS_arrest_target',_agent,TRUE];
				missionNamespace setVariable ['QS_aoSmallTask_Arrested',FALSE,TRUE];
				['ST_HVT',['High Value Target','Arrest HVT']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				[
					'QS_IA_TASK_AO_3',
					TRUE,
					[
						'Intel teams have located a High Value Target in the area. Move in and arrest him!',
						'Arrest HVT',
						'Arrest HVT'
					],
					[_agent,TRUE],
					'CREATED',
					5,
					FALSE,
					TRUE,
					'Default',
					TRUE
				] call (missionNamespace getVariable 'BIS_fnc_setTask');
				//comment 'Force protection';
				_enemyArray = [];
				_enemyTypes = [
					"I_C_Soldier_Bandit_7_F","I_C_Soldier_Bandit_3_F","I_C_Soldier_Bandit_2_F","I_C_Soldier_Bandit_5_F","I_C_Soldier_Bandit_6_F","I_C_Soldier_Bandit_1_F",
					"I_C_Soldier_Bandit_8_F","I_C_Soldier_Bandit_4_F","I_C_Soldier_Para_7_F","I_C_Soldier_Para_2_F","I_C_Soldier_Para_3_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_6_F",
					"I_C_Soldier_base_unarmed_F","I_C_Soldier_Para_8_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_5_F"
				];
				_enemyCount = round (2 + (random 3));
				_enemyGroup = createGroup [RESISTANCE,TRUE];
				_enemyUnit = objNull;
				for '_x' from 0 to _enemyCount step 1 do {
					_enemyUnit = _enemyGroup createUnit [(selectRandom _enemyTypes),[0,0,0],[],0,'NONE'];
					missionNamespace setVariable [
						'QS_analytics_entities_created',
						((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
						FALSE
					];
					_enemyUnit = _enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
					_enemyUnit setPos (selectRandom _buildingPositions);
					_enemyUnit setUnitPos (selectRandom ['UP','MIDDLE']);
					_enemyUnit disableAI 'PATH';
					if ((random 1) > 0.5) then {
						_enemyUnit addEventHandler [
							'Hit',
							{
								(_this select 0) removeEventHandler ['Hit',_thisEventHandler];
								(_this select 0) enableAI 'PATH';
								(_this select 0) setUnitPosWeak 'MIDDLE';
							}
						];
					};
					_enemyArray pushBack _enemyUnit;
				};
				[_enemyArray,1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
				_return = [
					_case,
					2,
					[
						_agent,
						_enemyArray
					]
				];
			};
		};
	};
};
if (_state isEqualTo 2) then {
	//comment 'Check mission state';
	//comment 'Return -1 unless state changes';
	_agent = _data select 0;
	_enemyArray = _data select 1;
	if (missionNamespace getVariable ['QS_aoSmallTask_Arrested',FALSE]) then {
		//comment 'Mission success';
		['ST_HVT',['High Value Target','HVT arrested']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['sideChat',[WEST,'HQ'],'Bring the HVT back to base and imprison him in Gitmo'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
			private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
			_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			_scoreEast = _QS_virtualSectors_scoreSides select 0;
			if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
				_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_smallTask',0.05]);
				_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides select 0) - _scoreToRemove)];
				missionNamespace setVariable ['QS_virtualSectors_scoreSides',_QS_virtualSectors_scoreSides,FALSE];
			};
		};
		_return = [
			_case,
			0,
			[
				_agent,
				_enemyArray
			]
		];
	} else {
		if (!alive _agent) then {
			//comment 'Mission failure';
			['ST_HVT',['High Value Target','HVT killed, arrest failed!']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
			['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
			_return = [
				_case,
				0,
				[
					_agent,
					_enemyArray
				]
			];
		};
	};
};
_return;