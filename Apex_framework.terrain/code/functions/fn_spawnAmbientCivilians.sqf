/*/
File: fn_spawnAmbientCivilians.sqf
Author: 

	Quiksilver
	
Last Modified:

	5/05/2019 A3 1.92 by Quiksilver

Description:

	Spawn ambient civilians
______________________________________________________/*/
if ((count allPlayers) >= 50) exitwith {};
params [
	'_centerPos',
	'_centerRad',
	'_type',
	'_quantity',
	'_forced',
	['_isGrid',FALSE]
];
private _entities = [];
if (_type isEqualTo 'FOOT') then {
	//comment 'Get area building positions';
	private _buildings = nearestObjects [_centerPos,['House','Building'],_centerRad,TRUE];
	_buildings = _buildings + ((allSimpleObjects []) select {((_x distance2D _centerPos) <= _centerRad)});
	_buildings = _buildings call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	private _building = objNull;
	private _buildingPositions = [];
	private _arrayBuildingPositions = [];
	private _arrayBuildingPositionsProxy = [];
	private _spawnPosIndex = -1;
	private _spawnPos = [0,0,0];
	{
		_building = _x;
		_buildingPositions = _building buildingPos -1;
		_buildingPositions = [_building,_buildingPositions] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions');
		if (!(_buildingPositions isEqualTo [])) then {
			{
				0 = _arrayBuildingPositions pushBack _x;
			} forEach _buildingPositions;
		};
	} forEach _buildings;
	if (!(_arrayBuildingPositions isEqualTo [])) then {
		_arrayBuildingPositions = _arrayBuildingPositions apply {[(_x select 0),(_x select 1),((_x select 2) + 1)]};
	};
	if (!(_arrayBuildingPositions isEqualTo [])) then {
		if (((count _arrayBuildingPositions) > 20) || (_forced)) then {
			_arrayBuildingPositions = _arrayBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			//comment 'Spawn agents';
			private _agent = objNull;
			private _agentType = '';
			private _agentTypes = [
				[
					'C_man_p_beggar_F_afro',
					'C_Man_casual_1_F_afro',
					'C_Man_casual_2_F_afro',
					'C_Man_casual_3_F_afro',
					'C_man_sport_1_F_afro',
					'C_man_sport_2_F_afro',
					'C_man_sport_3_F_afro',
					'C_Man_casual_4_F_afro',
					'C_Man_casual_5_F_afro',
					'C_Man_casual_6_F_afro',
					'C_man_polo_1_F_afro',
					'C_man_polo_2_F_afro',
					'C_man_polo_3_F_afro',
					'C_man_polo_4_F_afro',
					'C_man_polo_5_F_afro',
					'C_man_polo_6_F_afro',
					'C_man_shorts_1_F_afro',
					'C_Man_casual_1_F_tanoan',
					'C_Man_casual_2_F_tanoan',
					'C_Man_casual_3_F_tanoan',
					'C_Man_casual_1_F_euro',
					'C_Man_casual_2_F_euro',
					'C_Man_casual_3_F_euro',
					'C_Man_casual_4_F_euro',
					'C_Man_casual_5_F_euro',
					'C_Man_casual_6_F_euro',
					'C_man_polo_1_F_euro',
					'C_man_polo_2_F_euro',
					'C_man_polo_3_F_euro',
					'C_man_polo_4_F_euro',
					'C_man_polo_5_F_euro',
					'C_man_polo_6_F_euro',
					'C_IDAP_Man_AidWorker_01_F',
					'C_IDAP_Man_AidWorker_02_F',
					'C_IDAP_Man_AidWorker_09_F',
					'C_IDAP_Man_AidWorker_07_F'
				],
				[
					'C_man_p_beggar_F_afro',
					'C_Man_casual_1_F_afro',
					'C_Man_casual_2_F_afro',
					'C_Man_casual_3_F_afro',
					'C_man_sport_1_F_afro',
					'C_man_sport_2_F_afro',
					'C_man_sport_3_F_afro',
					'C_Man_casual_4_F_afro',
					'C_Man_casual_5_F_afro',
					'C_Man_casual_6_F_afro',
					'C_man_polo_1_F_afro',
					'C_man_polo_2_F_afro',
					'C_man_polo_3_F_afro',
					'C_man_polo_4_F_afro',
					'C_man_polo_5_F_afro',
					'C_man_polo_6_F_afro',
					'C_man_shorts_1_F_afro',
					'C_Man_casual_1_F_tanoan',
					'C_Man_casual_2_F_tanoan',
					'C_Man_casual_3_F_tanoan',
					'C_IDAP_Man_AidWorker_01_F',
					'C_IDAP_Man_AidWorker_02_F',
					'C_IDAP_Man_AidWorker_09_F',
					'C_IDAP_Man_AidWorker_07_F'
				]
			] select (worldName isEqualTo 'Tanoa');
			if (worldName in ['Enoch']) then {
				_agentTypes = [
					'c_man_1_enoch_f',
					'c_man_2_enoch_f',
					'c_man_3_enoch_f',
					'c_man_4_enoch_f',
					'c_farmer_01_enoch_f',
					'c_man_casual_1_f_euro',
					'c_man_casual_2_f_euro',
					'c_man_casual_3_f_euro',
					'c_scientist_01_formal_f',
					'c_scientist_01_informal_f',
					'c_scientist_02_informal_f',
					'c_scientist_02_formal_f',
					'c_man_casual_1_f_afro',
					'c_man_casual_2_f_afro',
					'c_man_casual_3_f_afro',
					'c_idap_man_aidworker_01_f',
					'c_idap_man_aidworker_02_f',
					'c_idap_man_aidworker_09_f',
					'c_idap_man_aidworker_07_f'
				];
			};
			_arrayBuildingPositionsProxy = _arrayBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			reverse _arrayBuildingPositionsProxy;
			_arrayBuildingPositionsProxy = _arrayBuildingPositionsProxy call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			scopeName 'main';
			for '_x' from 0 to (_quantity - 1) step 1 do {
				_spawnPos = selectRandom _arrayBuildingPositionsProxy;
				_spawnPosIndex = _arrayBuildingPositionsProxy find _spawnPos;
				_arrayBuildingPositionsProxy set [_spawnPosIndex,FALSE];
				_arrayBuildingPositionsProxy deleteAt _spawnPosIndex;
				if (_arrayBuildingPositionsProxy isEqualTo []) exitWith {
					breakTo 'main';
				};
				_agentType = selectRandom _agentTypes;
				_agent = createAgent [_agentType,_spawnPos,[],0,'NONE'];
				_agent setVariable ['QS_AI_ENTITY_CONFIG',['AMBIENT','FOOT',objNull],FALSE];
				_agent setVariable ['QS_AI_ENTITY_TASK',['CIRCUIT',[_spawnPos,(selectRandom _arrayBuildingPositionsProxy),(selectRandom _arrayBuildingPositionsProxy)],-1],FALSE];
				_agent setVariable ['QS_AI_ENTITY_DATA',[],FALSE];
				_agent setVariable ['QS_AI_ENTITY',TRUE,FALSE];
				_agent setVariable ['QS_ENTITY_HC',TRUE,FALSE];
				if (_isGrid) then {
					_agent addEventHandler [
						'Killed',
						{
							params ['_unit','_killer','_instigator','_usedEffects'];
							if (alive _instigator) then {
								if (isPlayer _instigator) then {
									if (!(missionNamespace getVariable ['QS_grid_civCasualties',FALSE])) then {
										missionNamespace setVariable ['QS_grid_civCasualties',TRUE,TRUE];
										if (isDedicated) then {
											['GRID_IDAP_UPDATE',['Area Of Operations','Objective failed<br/>No civilian casualties']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
											'QS_marker_grid_civState' setMarkerTextLocal (format ['%1No civilian casualties (failed)',(toString [32,32,32])]);
											'QS_marker_grid_civState' setMarkerColor 'ColorRED';
										} else {
											[85] remoteExec ['QS_fnc_remoteExec',2,FALSE];
										};
									};
								};
							};
						}
					];
				};
				_agent limitSpeed (random [8,16,26]);
				_agent enableStamina FALSE;
				_agent enableFatigue FALSE;
				_agent setSkill 0;
				_agent setPosASL (AGLToASL _spawnPos);
				_agent enableDynamicSimulation TRUE;
				if ((random 1) > 0.5) then {
					_agent forceWalk TRUE;
				};
				if ((random 1) > 0.5) then {
					_agent allowSprint FALSE;
				};
				_agent addEventHandler [
					'Killed',
					{
						params ['','','_instigator',''];
						if (!isNull _instigator) then {
							if (isPlayer _instigator) then {
								_name = name _instigator;
								_text = format ['%1 %2 a civilian!',_name,(selectRandom ['killed','murdered','butchered','slaughtered'])];
								['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							};
						};
					}
				];
				_entities pushBack _agent;
			};
		};
	};
};
if (_type isEqualTo 'VEHICLE') then {
	/*/ AI driving can fuck right off (1.78 A3 23/11/2017) /*/
};
_entities;