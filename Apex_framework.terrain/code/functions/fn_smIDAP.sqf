/*/
File: fn_smIDAP.sqf
Author: 

	Quiksilver
	
Last modified:

	21/04/2018 A3 1.82 by Quiksilver

Description:

	IDAP force protection
___________________________________________/*/

params ['_position','_type','_subType'];
private _return = [];
private _grp = grpNull;
private _unit = objNull;
private _spawnPosition = [0,0,0];
private _grpTypes = [
	'OG_InfTeam',
	'OG_InfTeam_AT',
	'OG_ReconSentry',
	'OG_InfAssaultTeam'
];
if (_type isEqualTo 0) exitWith {
	comment 'IDAP scene';
	if (_subType isEqualTo 0) then {
		comment 'Initial';
		for '_x' from 0 to (round (2 + (random 2))) step 1 do {
			_spawnPosition = ['RADIUS',_position,(150 + (random 150)),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[_grp,_position,(25 + (random 100)),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
				0 = _return pushBack _x;
			} count (units _grp);
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};
		if ((random 1) > 0) then {
			_spawnPosition = ['RADIUS',_position,150,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			_v = createVehicle [(selectRandomWeighted ([4] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'))),_spawnPosition,[],0,'NONE'];
			missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
			_v lock 3;
			_return pushBack _v;
			_v addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
			_v addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
			[0,_v,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
			_v allowCrewInImmobile TRUE;
			_v enableRopeAttach FALSE;
			_v enableVehicleCargo FALSE;
			_v setUnloadInCombat [TRUE,FALSE];
			(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
			_grp = createVehicleCrew _v;
			if (!((side _grp) in [EAST,RESISTANCE])) then {
				_grp = createGroup [EAST,TRUE];
				{
					[_x] joinSilent _grp;
				} forEach (crew _v);
			};
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + (count (crew _v))),
				FALSE
			];
			_grp addVehicle _v;
			[_grp,_position,350,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_v],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			{
				_x disableAI 'AUTOCOMBAT';
				_x disableAI 'COVER';
				0 = _return pushBack _x;
			} forEach (units _grp);
		};
	};
	if (_subType isEqualTo 1) then {
		comment 'Refill';
		_spawnPosition = _this select 3;
		_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		[_grp,_position,(75 + (random 75)),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_x disableAI 'AUTOCOMBAT';
			_x disableAI 'COVER';
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			0 = _return pushBack _x;
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
	};
	_return;
};
if (_type isEqualTo 1) exitWith {
	/*/_spawnArray = [_housePosition,1,0,_house,_houseBuildingPositions] call _fn_smIDAP;/*/
	/*/params ['_position','_type','_subType'];/*/
	_house = _this select 3;
	_houseBuildingPositions = _this select 4;
	_housePosition = position _house;
	comment 'Building + Patrol + Sentry';
	private _unit = objNull;
	private _grp = grpNull;
	_unitTypes1 = [
		'I_C_Soldier_Bandit_7_F',
		'I_C_Soldier_Bandit_3_F',
		'I_C_Soldier_Bandit_2_F',
		'I_C_Soldier_Bandit_5_F',
		'I_C_Soldier_Bandit_6_F',
		'I_C_Soldier_Bandit_1_F',
		'I_C_Soldier_Bandit_8_F',
		'I_C_Soldier_Bandit_4_F',
		'I_C_Soldier_Para_7_F',
		'I_C_Soldier_Para_2_F',
		'I_C_Soldier_Para_3_F',
		'I_C_Soldier_Para_4_F',
		'I_C_Soldier_Para_6_F',
		'I_C_Soldier_Para_8_F',
		'I_C_Soldier_Para_1_F',
		'I_C_Soldier_Para_5_F'
	];
	_unitTypes2 = [
		'O_G_Soldier_A_F',
		'O_G_Soldier_AR_F',
		'O_G_medic_F',
		'O_G_engineer_F',
		'O_G_Soldier_exp_F',
		'O_G_Soldier_GL_F',
		'O_G_Soldier_M_F',
		'O_G_Soldier_F',
		'O_G_Soldier_LAT_F',
		'O_G_Soldier_lite_F',
		'O_G_Sharpshooter_F',
		'O_G_Soldier_SL_F',
		'O_G_Soldier_TL_F'
	];
	_unitTypesAll = _unitTypes1 + _unitTypes2;
	if (_subType isEqualTo 0) then {
		comment 'Initial';
		_maxCount = 6;
		_houseGrp = createGroup [EAST,TRUE];
		private _houseBuildingPosition = [0,0,0];
		private _houseBuildingPositionIndex = -1;
		for '_x' from 0 to ((round ((count _houseBuildingPositions) - 1)) min _maxCount) step 1 do {
			_unit = _houseGrp createUnit [(selectRandom _unitTypesAll),_housePosition,[],15,'NONE'];
			_houseBuildingPosition = selectRandom _houseBuildingPositions;
			_houseBuildingPositionIndex = _houseBuildingPositions find _houseBuildingPosition;
			_houseBuildingPositions set [_houseBuildingPositionIndex,FALSE];
			_houseBuildingPositions deleteAt _houseBuildingPositionIndex;
			_unit disableAI 'PATH';
			_unit setUnitPosWeak (selectRandom ['UP','UP','MIDDLE']);
			_unit setPos _houseBuildingPosition;
			if ((random 1) > 0.5) then {
				_unit addEventHandler [
					'Hit',
					{
						(_this select 0) removeEventHandler ['Hit',_thisEventHandler];
						(_this select 0) enableAI 'PATH';
					}
				];
			};
			_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_return pushBack _unit;
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			if (_houseBuildingPositions isEqualTo []) exitWith {};
			if (_x >= _maxCount) exitWith {};
		};
		private _spawnPosition = [0,0,0];
		for '_x' from 0 to (round (1 + (random 1))) step 1 do {
			_spawnPosition = ['RADIUS',_housePosition,(150 + (random 150)),'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
			[_grp,_housePosition,(25 + (random 100)),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			{
				missionNamespace setVariable [
					'QS_analytics_entities_created',
					((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
					FALSE
				];
				[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
				_x disableAI 'AUTOCOMBAT';
				_x disableAI 'COVER';
				0 = _return pushBack _x;
			} count (units _grp);
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		};
	};
	if (_subType isEqualTo 1) then {
		_spawnPosition = _this select 5;
		comment 'Refill';
		_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_houseBuildingPositions,diag_tickTime,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp move (selectRandom _houseBuildingPositions);
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			missionNamespace setVariable [
				'QS_analytics_entities_created',
				((missionNamespace getVariable 'QS_analytics_entities_created') + 1),
				FALSE
			];
			_x disableAI 'AUTOCOMBAT';
			_x disableAI 'COVER';
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			0 = _return pushBack _x;
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,diag_tickTime],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
		_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];	
	};
	_return;
};
if (_type isEqualTo 2) exitWith {
	comment 'Building + Minefield + Sentry';
	if (_subType isEqualTo 0) then {
		comment 'Initial';
	
	};
	if (_subType isEqualTo 1) then {
		comment 'Refill';
	
	};
	_return;
};