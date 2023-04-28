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
	private _buildings = (nearestObjects [_centerPos,['House','Building'],_centerRad,TRUE]) select {!isObjectHidden _x};
	_buildings = _buildings + ((allSimpleObjects []) inAreaArray [_centerPos,_centerRad,_centerRad,0,FALSE]);
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
		if (_buildingPositions isNotEqualTo []) then {
			{
				0 = _arrayBuildingPositions pushBack _x;
			} forEach _buildingPositions;
		};
	} forEach _buildings;
	if (_arrayBuildingPositions isNotEqualTo []) then {
		_arrayBuildingPositions = _arrayBuildingPositions apply {(_x vectorAdd [0,0,0.1])};
	};
	if (_arrayBuildingPositions isNotEqualTo []) then {
		if (((count _arrayBuildingPositions) > 20) || (_forced)) then {
			_arrayBuildingPositions = _arrayBuildingPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			//comment 'Spawn agents';
			private _agent = objNull;
			private _agentType = '';
			private _agentTypes = missionNamespace getVariable ['QS_core_civilians_list',['C_man_1']];
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
				_agent setVariable ['QS_AI_ENTITY_HC',[0,-1],QS_system_AI_owners];
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
											['GRID_IDAP_UPDATE',[localize 'STR_QS_Notif_008',format ['%1<br/>%2',localize 'STR_QS_Notif_071',localize 'STR_QS_Notif_072']]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
											'QS_marker_grid_civState' setMarkerTextLocal (format ['%1 %2 (%3)',(toString [32,32,32]),localize 'STR_QS_Marker_011',localize 'STR_QS_Marker_024']);
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
								_text = format [
									'%1 %2 a civilian!',
									_name,
									(selectRandom [
										localize 'STR_QS_Chat_158',
										localize 'STR_QS_Chat_159',
										localize 'STR_QS_Chat_160',
										localize 'STR_QS_Chat_161'
									])
								];
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