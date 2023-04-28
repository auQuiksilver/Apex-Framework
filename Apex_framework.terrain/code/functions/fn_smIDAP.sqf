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
private _vType = '';
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
				[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
				0 = _return pushBack _x;
			} count (units _grp);
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
		if ((random 1) > 0) then {
			_spawnPosition = ['RADIUS',_position,150,'LAND',[],FALSE,[],[],TRUE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
			_vType = selectRandomWeighted ([4] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool'));
			_v = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _vType,_vType],_spawnPosition,[],0,'NONE'];
			_v lock 3;
			_return pushBack _v;
			_v addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
			_v addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
			[0,_v,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
			_v allowCrewInImmobile [TRUE,TRUE];
			_v enableRopeAttach FALSE;
			_v enableVehicleCargo FALSE;
			_v setUnloadInCombat [TRUE,FALSE];
			(missionNamespace getVariable 'QS_AI_vehicles') pushBack _v;
			_grp = createVehicleCrew _v;
			if (!((side _grp) in [EAST,RESISTANCE])) then {
				_grp = createGroup [EAST,TRUE];
				(crew _v) joinSilent _grp;
			};
			_grp addVehicle _v;
			[_grp,_position,350,[],TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_v],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			{
				_x enableAIFeature ['AUTOCOMBAT',FALSE];
				_x enableAIFeature ['COVER',FALSE];
				0 = _return pushBack _x;
			} forEach (units _grp);
		};
	};
	if (_subType isEqualTo 1) then {
		comment 'Refill';
		_spawnPosition = _this # 3;
		_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		[_grp,_position,(75 + (random 75)),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			_x enableAIFeature ['AUTOCOMBAT',FALSE];
			_x enableAIFeature ['COVER',FALSE];
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			0 = _return pushBack _x;
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	};
	_return;
};
if (_type isEqualTo 1) exitWith {
	/*/_spawnArray = [_housePosition,1,0,_house,_houseBuildingPositions] call _fn_smIDAP;/*/
	/*/params ['_position','_type','_subType'];/*/
	_house = _this # 3;
	_houseBuildingPositions = _this # 4;
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
		private _type = '';
		for '_x' from 0 to ((round ((count _houseBuildingPositions) - 1)) min _maxCount) step 1 do {
			_type = selectRandom _unitTypesAll;
			_unit = _houseGrp createUnit [QS_core_units_map getOrDefault [toLowerANSI _type,_type],_housePosition,[],15,'NONE'];
			_houseBuildingPosition = selectRandom _houseBuildingPositions;
			_houseBuildingPositionIndex = _houseBuildingPositions find _houseBuildingPosition;
			_houseBuildingPositions set [_houseBuildingPositionIndex,FALSE];
			_houseBuildingPositions deleteAt _houseBuildingPositionIndex;
			_unit enableAIFeature ['PATH',FALSE];
			_unit setUnitPosWeak (selectRandom ['UP','UP','MIDDLE']);
			_unit setPos _houseBuildingPosition;
			if ((random 1) > 0.5) then {
				_unit addEventHandler [
					'Hit',
					{
						(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
						(_this # 0) enableAIFeature ['PATH',TRUE];
					}
				];
			};
			_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
			_houseGrp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
			_return pushBack _unit;
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
				[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
				_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
				_x enableAIFeature ['AUTOCOMBAT',FALSE];
				_x enableAIFeature ['COVER',FALSE];
				0 = _return pushBack _x;
			} count (units _grp);
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
			_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
		};
	};
	if (_subType isEqualTo 1) then {
		_spawnPosition = _this # 5;
		comment 'Refill';
		_grp = [_spawnPosition,(random 360),EAST,(selectRandom _grpTypes),FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
		_grp setVariable ['QS_AI_GRP_TASK',['PATROL',_houseBuildingPositions,serverTime,-1],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_PATROLINDEX',0,QS_system_AI_owners];
		_grp move (selectRandom _houseBuildingPositions);
		[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
		{
			_x enableAIFeature ['AUTOCOMBAT',FALSE];
			_x enableAIFeature ['COVER',FALSE];
			[_x] call (missionNamespace getVariable 'QS_fnc_setCollectible');
			_x setVehiclePosition [(getPosWorld _x),[],0,'NONE'];
			0 = _return pushBack _x;
		} count (units _grp);
		_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_DATA',[TRUE,serverTime],QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
		_grp setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
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