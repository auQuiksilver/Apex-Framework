/*
File: fn_serverSpawnAsset.sqf
Author:
	
	Quiksilver
	
Last Modified:
	
	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Spawn Asset from players asset spawner
	
Notes:

		if (isDedicated) then {
			params ['',['_parent',objNull],['_data',[]]],['_pos',[0,0,0]]];
			[_parent,_data,_pos,_rxID] call QS_fnc_serverSpawnAsset;
		};
		
	['QS_managed_spawnedVehicles_maxCap',20,FALSE],
	['QS_managed_spawnedVehicles_maxByType',[],TRUE],
	['QS_managed_spawnedVehicles_local',[],FALSE],		// Note: persistence
	['QS_managed_spawnedVehicles_public',(missionNamespace getVariable ['QS_managed_spawnedVehicles_local',[]]),TRUE]
________________________________________________*/

missionNamespace setVariable ['QS_managed_spawnedVehicles_maxCap',5,TRUE];
QS_fnc_serverSpawnAsset = compileFinal {
	if (diag_frameNo <= (localNamespace getVariable ['QS_vehicleSpawner_frameCooldown',-1])) exitWith {
		diag_log '***** DEBUG ***** QS_fnc_serverSpawnAsset * Executed too frequently *';
	};
	localNamespace setVariable ['QS_vehicleSpawner_frameCooldown',diag_frameNo];
	params [
		['_parent',objNull],
		['_data',[]],
		['_pos',[0,0,0]],
		['_dir',0],
		['_cid',2]
	];
	QS_managed_spawnedVehicles_local = QS_managed_spawnedVehicles_local select {alive _x};
	if ((count QS_managed_spawnedVehicles_local) >= QS_managed_spawnedVehicles_maxCap) exitWith {
		comment 'Vehicle spawner global cap exceeded';
		[
			[],
			{
				50 cutText [
					(format [localize 'STR_QS_Text_488',QS_managed_spawnedVehicles_maxCap]),
					'PLAIN DOWN',
					0.5
				];
			}
		] remoteExec ['call',_cid,FALSE];
	};
	private _exit = FALSE;
	_data params ['_class'];
	
	_spawnedVehicleCost = [_class] call QS_fnc_vehicleGetCost;
	if (['IS_MANAGED_BASE',_parent] call QS_fnc_baseHandle) then {
		_budget = ['VEHICLES_GET_BUDGET',_parent] call QS_fnc_baseHandle;
		private _totalCost = ['VEHICLES_GET_COST',_parent] call QS_fnc_baseHandle;
		if ((_totalCost + _spawnedVehicleCost) > _budget) then {
			_exit = TRUE;
			[
				[],
				{
					50 cutText [
						(format [localize 'STR_QS_Text_493',(_totalCost + _spawnedVehicleCost),_budget]),
						'PLAIN DOWN',
						0.5
					];
				}
			] remoteExec ['call',_cid,FALSE];
		};
	};
	if (_exit) exitWith {};
	_spawnerBudget = _parent getVariable ['QS_spawnedVehicles_budget',-1];
	if (_spawnerBudget isNotEqualTo -1) then {
		private _spawnedVehiclesList = _parent getVariable ['QS_spawnedVehicles_list',[]];
		_spawnedVehiclesList = _spawnedVehiclesList select {alive _x};
		private  _totalCost = [_spawnedVehiclesList] call QS_fnc_vehiclesGetCost;
		if ((_totalCost + _spawnedVehicleCost) > _spawnerBudget) then {
			_exit = TRUE;
			[
				[],
				{
					50 cutText [
						(format [localize 'STR_QS_Text_493',(_totalCost + _spawnedVehicleCost),_budget]),
						'PLAIN DOWN',
						0.5
					];
				}
			] remoteExec ['call',_cid,FALSE];
		};
	};
	if (_exit) exitWith {};
	_data params ['_class'];

	comment 'validate';
	comment 'check blocked spawn';
	_position = ASLToAGL _pos;
	_safeRadius = 2.5;
	private _obstructionList = nearestObjects [_position,['LandVehicle','Air','Ship','StaticWeapon','Cargo_base_F','Reammobox_F','Slingload_base_F'], 50, FALSE];
	_obstructionList = _obstructionList select {
		_distance = _position distance _x;
		_radius = ((0 boundingBoxReal _x) # 2);
		(((_position distance _x) - ((0 boundingBoxReal _x) # 2)) < _safeRadius)
	};
	if (_obstructionList isNotEqualTo []) exitWith {
		[
			[_obstructionList],
			{
				params ['_obstructionList'];
				private _text = '';
				{
					if (_forEachIndex isNotEqualTo 0) then {
						_text = _text + ', ';
					};
					_text = _text + _x;
				} forEach (_obstructionList apply { (_x getVariable ['QS_ST_customDN',(getText ((configOf _x) >> 'displayName'))]) });
				50 cutText [format [localize 'STR_QS_Text_487',_text],'PLAIN DOWN',0.5];
			}
		] remoteExec ['call',_cid,FALSE];
	};
	private _object = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _class,_class],[-500,-500,(200 + (random 200))]];
	_object setDir _dir;
	
	_object addEventHandler [
		'Deleted',
		{
			params ['_entity'];		
		}
	];
	_object addEventHandler [
		'Killed',
		{
			params ['_entity'];		
		}
	];
	
	comment '
	_object setPosASL _pos;
	';
	_object setVehiclePosition [_pos,[],0,'NONE'];
	comment '_object setVelocity [0,0,0];';
	[_object] call QS_fnc_vSetup;
	(serverNamespace getVariable 'QS_v_Monitor') pushBack [
		_object,
		30,
		FALSE,
		{},
		_class,
		getPosASL _object,
		_dir,
		FALSE,
		0,
		-1,
		50,
		500,
		0,
		6,
		FALSE,
		0,
		{TRUE},
		FALSE,
		FALSE,
		[],
		[],
		0,
		{TRUE}
	];
	QS_managed_spawnedVehicles_local pushBack _object;
	missionNamespace setVariable [
		'QS_managed_spawnedVehicles_public',
		(missionNamespace getVariable ['QS_managed_spawnedVehicles_local',[]]),
		TRUE
	];
	if (['IS_MANAGED_BASE',_parent] call QS_fnc_baseHandle) then {
		['HANDLE',['VEHICLE_ADD',_parent,_object]] call QS_fnc_baseHandle;
	};
};