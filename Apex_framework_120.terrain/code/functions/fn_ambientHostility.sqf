/*/
File: fn_ambientHostility.sqf
Author:

	Quiksilver
	
Last Modified:

	14/04/2018 A3 1.82 by Quiksilver
	
Description:

	Ambient Hostility
_______________________________________________/*/

params ['_type','_target','_nearbyCount'];
private _return = [];
if (_type isEqualTo 0) exitWith {
	// prepare
	private _targetVehicle = vehicle _target;
	private _isVehicle = !(_targetVehicle isKindOf 'CAManBase');
	_basePosition = markerPos 'QS_marker_base_marker';
	_fobPosition = markerPos 'QS_marker_module_fob';
	_aoPosition = missionNamespace getVariable ['QS_aoPos',[0,0,0]];
	_smPosition = markerPos 'QS_marker_sideMarker';
	_blacklistedPositions = [
		[_basePosition,1000],
		[_fobPosition,150],
		[_aoPosition,600],
		[_smPosition,300],
		[(markerPos 'QS_marker_Almyra_blacklist_area'),400]
	];
	_knowsAbout = EAST knowsAbout _targetVehicle;
	private _threat = 2;
	if (_targetVehicle isKindOf 'CAManBase') then {
		_threat = 1;
	} else {
		if (_targetVehicle isKindOf 'Wheeled_APC_F') then {
			_threat = 3;
		} else {
			if (_targetVehicle isKindOf 'Tank') then {
				_threat = 4;
			};
		};
	};
	_fn_isStealthy = {
		params ['_vehicle'];
		private _c = FALSE;
		if (((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) || (!isEngineOn _vehicle)) then {
			if (!isOnRoad _vehicle) then {
				if (!((toLower (surfaceType (getPosWorld _vehicle))) in ['#gdtasphalt'])) then {
					if ((((getPosATL _vehicle) getEnvSoundController 'houses') isEqualTo 0) || {(((getPosATL _vehicle) getEnvSoundController 'forest') isEqualTo 1)}) then {
						_c = TRUE;
					};
				};
			};
		};
		_c;
	};
	if (_isVehicle) then {
		if (_threat in [3,4]) then {
			if ([_targetVehicle] call _fn_isStealthy) then {
				if (_knowsAbout < 4) then {
					_knowsAbout = 1;
				};
			};
		};
	};
	_unitTypes = [
		'O_G_Soldier_A_F',1,
		'O_G_Soldier_AR_F',3,
		'O_G_medic_F',1,
		'O_G_engineer_F',1,
		'O_G_Soldier_exp_F',1,
		'O_G_Soldier_GL_F',1,
		'O_G_Soldier_M_F',1,
		'O_G_Soldier_F',1,
		'O_G_Soldier_LAT_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_LAT2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'O_G_Soldier_lite_F',1,
		'O_G_Sharpshooter_F',3,
		'O_G_Soldier_TL_F',1,
		'I_C_Soldier_Bandit_7_F',1,
		'I_C_Soldier_Bandit_3_F',3,
		'I_C_Soldier_Bandit_2_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4),
		'I_C_Soldier_Bandit_5_F',2,
		'I_C_Soldier_Bandit_6_F',2,
		'I_C_Soldier_Bandit_1_F',2,
		'I_C_Soldier_Bandit_8_F',2,
		'I_C_Soldier_Bandit_4_F',2,
		'I_C_Soldier_Para_7_F',1,
		'I_C_Soldier_Para_2_F',1,
		'I_C_Soldier_Para_3_F',1,
		'I_C_Soldier_Para_4_F',3,
		'I_C_Soldier_Para_6_F',1,
		'I_C_Soldier_Para_8_F',1,
		'I_C_Soldier_Para_1_F',1,
		'I_C_Soldier_Para_5_F',(2 max (missionNamespace getVariable ['QS_AI_targetsKnowledge_threat_armor',0]) min 4)
	];
	_vehicleTypes = [([5,6] select (_knowsAbout >= 2))] call (missionNamespace getVariable 'QS_fnc_getAIMotorPool');
	// find position
	private _targetPosition = _targetVehicle getRelPos [500,0];
	if (_isVehicle) then {
		_targetPosition = _targetVehicle getRelPos [1000,0];
	};
	if (surfaceIsWater _targetPosition) exitWith {[]};
	if ((_targetPosition distance2D _basePosition) < 1000) exitWith {[]};
	private _spawnPosition = [0,0,0];
	private _positionFound = FALSE;
	private _minDist = 300;
	private _maxDist = 600;
	private _players = allPlayers;
	private _playersOnGround = (_players unitsBelowHeight 25) select { ((side _x) in [WEST,CIVILIAN,SIDEFRIENDLY]) };	
	_checkVisibleDistance = 300;
	for '_x' from 0 to 49 step 1 do {
		_spawnPosition = ['RADIUS',_targetPosition,_maxDist,'LAND',[3,0,0.5,3,0,FALSE,objNull],TRUE,[],[],FALSE] call (missionNamespace getVariable 'QS_fnc_findRandomPos');
		if (((_spawnPosition distance2D _targetPosition) > _minDist) && ((_spawnPosition distance2D _targetPosition) < _maxDist)) then {
			if ((_players inAreaArray [_spawnPosition,300,300,0,FALSE]) isEqualTo []) then {
				if (!([_spawnPosition,_targetPosition,25] call (missionNamespace getVariable 'QS_fnc_waterIntersect'))) then {
					if (([(AGLToASL _spawnPosition),_checkVisibleDistance,_playersOnGround,[WEST,CIVILIAN,SIDEFRIENDLY],0,0] call (missionNamespace getVariable 'QS_fnc_isPosVisible')) <= 0.1) then {
						if ((_blacklistedPositions findIf {((_spawnPosition distance2D (_x select 0)) < (_x select 1))}) isEqualTo -1) then {
							_positionFound = TRUE;
						};
					};
				};
			};
		};
		if (_positionFound) exitWith {};
	};
	if (!(_positionFound)) exitWith {_return};
	private _vehicle = objNull;
	private _unit = objNull;
	private _unitType = '';
	private _grp = grpNull;
	_spawnPosition set [2,0];
	if (_isVehicle) then {
		for '_x' from 0 to 1 step 1 do {
			_vehicle = createVehicle [(selectRandomWeighted _vehicleTypes),_spawnPosition,[],50,'NONE'];
			_vehicle setDir (random 360);
			_vehicle setVehiclePosition [(AGLToASL _spawnPosition),[],0,'NONE'];
			_grp = createVehicleCrew _vehicle;
			if (!((side _grp) in [EAST,RESISTANCE])) then {
				_grp = createGroup [EAST,TRUE];
				{
					[_x] joinSilent _grp;
				} forEach (crew _vehicle);
			};
			(missionNamespace getVariable 'QS_AI_vehicles') pushBack _vehicle;
			clearMagazineCargoGlobal _vehicle;
			clearWeaponCargoGlobal _vehicle;
			clearItemCargoGlobal _vehicle;
			clearBackpackCargoGlobal _vehicle;
			_vehicle enableRopeAttach FALSE;
			_vehicle enableVehicleCargo FALSE;
			_vehicle allowCrewInImmobile TRUE;
			_vehicle setVehicleTIPars [1,1,1];
			_vehicle lock 3;
			_return pushBack _vehicle;
			if ((count allPlayers) < 30) then {
				[_vehicle] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
			} else {
				if ((random 1) > 0.666) then {
					[_vehicle] call (missionNamespace getVariable 'QS_fnc_downgradeVehicleWeapons');
				};
			};
			[0,_vehicle,EAST] call (missionNamespace getVariable 'QS_fnc_vSetup2');
			_vehicle addEventHandler ['GetOut',(missionNamespace getVariable 'QS_fnc_AIXDismountDisabled')];
			_vehicle addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
			_grp addVehicle _vehicle;
			[_grp,_targetPosition,300,((_targetPosition select [0,2]) nearRoads 300),TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrolVehicle');
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','VEHICLE',(count (units _grp)),_vehicle],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			{
				_return pushBack _x;
				_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
			} forEach (units _grp);
		};
	} else {
		_grpSize = [2,4] select (_nearbyCount > 4);
		for '_x' from 0 to 1 step 1 do {
			_grp = createGroup [EAST,TRUE];
			for '_x' from 0 to (_grpSize - 1) step 1 do {
				_unitType = selectRandomWeighted _unitTypes;
				_unit = _grp createUnit [_unitType,_spawnPosition,[],15,'NONE'];
				_unit setDir (random 360);
				_unit setVehiclePosition [(getPosWorld _unit),[],10,'NONE'];
				_unit setVariable ['QS_AI_UNIT_enabled',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
				_unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
				if ((toLower _unitType) in ['o_g_soldier_f','o_g_soldier_lite_f','i_c_soldier_bandit_6_f','i_c_soldier_para_1_f']) then {
					if ((random 1) > 0.5) then {
						_unit addBackpack (['b_bergen_hex_f','b_carryall_ghex_f'] select (worldName in ['Tanoa','Lingor3']));
						[_unit,(['launch_o_titan_f','launch_o_titan_ghex_f'] select (worldName in ['Tanoa','Lingor3'])),4] call (missionNamespace getVariable 'QS_fnc_addWeapon');
					};
				};
				_return pushBack _unit;
			};
			[_grp,_targetPosition,125,TRUE] call (missionNamespace getVariable 'QS_fnc_taskPatrol');
			_grp setFormDir (_unit getDir _targetPosition);
			[(units _grp),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
			_grp setVariable ['QS_AI_GRP',TRUE,(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _grp))],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			_grp setVariable ['QS_AI_GRP_DATA',[TRUE,-1],(call (missionNamespace getVariable 'QS_fnc_AIOwners'))];
			if (_knowsAbout > 2.75) then {
				_grp reveal [_targetVehicle,_knowsAbout];
				{
					_x reveal [_targetVehicle,_knowsAbout];
				} forEach (units _grp);
				//_grp setFormDir (_vehicle getDir _targetPosition);
				_grp setFormDir ((leader _grp) getDir _targetPosition);
				_grp move (_targetPosition getPos [(random 50),(random 360)]);
			};
		};
	};
	_return;
};
[]