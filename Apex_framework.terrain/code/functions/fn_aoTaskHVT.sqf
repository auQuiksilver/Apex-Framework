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
	_agent = _data # 0;
	_enemyArray = _data # 1;
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
		_unitTypes = ['ao_hvt_units_1'] call QS_data_listUnits;
		_unitType = selectRandom _unitTypes;
		_building = objNull;
		_buildingCandidate = objNull;
		private _houseTypes = ['ao_hvt_housetypes_1'] call QS_data_listVehicles;
		_buildingList = nearestObjects [_aoPos,_houseTypes,((missionNamespace getVariable 'QS_aoSize') * 1.1),TRUE];
		if (_buildingList isEqualTo []) then {
			_buildingList = _aoPos nearObjects ['House',((missionNamespace getVariable 'QS_aoSize') * 1.1)];
		};
		if (_buildingList isNotEqualTo []) then {
			_buildingList = _buildingList call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			_allPlayers = allPlayers;
			{
				_buildingCandidate = _x;
				if (([_buildingCandidate,75,[WEST,CIVILIAN],_allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo []) then {
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
				_agent = (createGroup [CIVILIAN,TRUE]) createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[0,0,0],[],0,'NONE'];
				if ((call (missionNamespace getVariable 'QS_fnc_getActiveDLC')) isEqualTo '') then {
					_agent setUnitLoadout [[[],[],[],["U_Marshal",[]],[],[],"H_Beret_blk","G_Shades_Black",[],[QS_core_classNames_itemMap,"","",QS_core_classNames_itemCompass,QS_core_classNames_itemWatch,""]],FALSE];
				};
				_agent setDir (random 360);
				_buildingPosition = selectRandom _buildingPositions;
				_agent setPos _buildingPosition;
				_agent setUnitPos 'Middle';
				for '_x' from 0 to 2 step 1 do {
					_agent setVariable ['QS_surrenderable',TRUE,TRUE];
				};
				_agent enableAIFeature ['PATH',FALSE];
				_agent addEventHandler [
					'Hit',
					{
						(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
						(_this # 0) enableAIFeature ['PATH',TRUE];
						(_this # 0) setUnitPos 'Middle';
					}
				];
				_agent addEventHandler [
					'Killed',
					{
						params ['_killed','_killer'];
						if (!isNull _killed) then {
							if (!isNull _killer) then {
								if (isPlayer _killer) then {
									_text = format [localize 'STR_QS_Chat_021',(name _killer)];
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
				['ST_HVT',[localize 'STR_QS_Notif_014',localize 'STR_QS_Notif_015']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
				[
					'QS_IA_TASK_AO_3',
					TRUE,
					[
						localize 'STR_QS_Task_014',
						localize 'STR_QS_Task_015',
						localize 'STR_QS_Task_015'
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
				_enemyTypes = ['ao_hvt_guards_1'] call QS_data_listUnits;
				_enemyCount = round (2 + (random 3));
				_enemyGroup = createGroup [RESISTANCE,TRUE];
				_enemyUnit = objNull;
				private _enemyType = '';
				for '_x' from 0 to _enemyCount step 1 do {
					_enemyType = selectRandom _enemyTypes;
					_enemyUnit = _enemyGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _enemyType,_enemyType],[0,0,0],[],0,'NONE'];
					_enemyUnit = _enemyUnit call (missionNamespace getVariable 'QS_fnc_unitSetup');
					_enemyUnit setPos (selectRandom _buildingPositions);
					_enemyUnit setUnitPos (selectRandom ['Up','Middle']);
					_enemyUnit enableAIFeature ['PATH',FALSE];
					if ((random 1) > 0.5) then {
						_enemyUnit addEventHandler [
							'Hit',
							{
								(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
								(_this # 0) enableAIFeature ['PATH',TRUE];
								(_this # 0) setUnitPos 'Middle';
							}
						];
					};
					_enemyArray pushBack _enemyUnit;
				};
				_enemyGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
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
	_agent = _data # 0;
	_enemyArray = _data # 1;
	if (missionNamespace getVariable ['QS_aoSmallTask_Arrested',FALSE]) then {
		//comment 'Mission success';
		['ST_HVT',[localize 'STR_QS_Notif_014',localize 'STR_QS_Notif_016']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['sideChat',[WEST,'HQ'],localize 'STR_QS_Chat_022'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['QS_IA_TASK_AO_3'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
		if (missionNamespace getVariable ['QS_virtualSectors_active',FALSE]) then {
			private ['_QS_virtualSectors_scoreSides','_scoreEast','_scoreToRemove'];
			_QS_virtualSectors_scoreSides = missionNamespace getVariable ['QS_virtualSectors_scoreSides',[0,0,0,0,0]];
			_scoreEast = _QS_virtualSectors_scoreSides # 0;
			if (_scoreEast > ((missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * 0.1)) then {
				_scoreToRemove = (missionNamespace getVariable ['QS_virtualSectors_scoreWin',300]) * (missionNamespace getVariable ['QS_virtualSectors_bonusCoef_smallTask',0.05]);
				_QS_virtualSectors_scoreSides set [0,((_QS_virtualSectors_scoreSides # 0) - _scoreToRemove)];
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
			['ST_HVT',[localize 'STR_QS_Notif_014',localize 'STR_QS_Notif_017']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
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