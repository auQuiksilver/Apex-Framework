/*
File: fn_fobAssets.sqf
Author:

	Quiksilver
	
Last Modified:

	8/09/2016 A3 1.62 by Quiksilver

Description:

	Enable FOB
	
	copyToClipboard str ([(typeOf QS_cabinet),((getModelInfo QS_cabinet) # 1),(getPosWorld QS_cabinet),[vectorDir QS_cabinet,vectorUp QS_cabinet],0,0,2,[],{}]);
	
___________________________________________________*/

params [
	['_type',''],
	['_fobID',0]
];
private _return = [];
if (_type isEqualTo 'CREATE') exitWith {
	// Create FOB
	_composition = ([_fobID] call (missionNamespace getVariable 'QS_data_fobs')) # 1;
	private _array = [];
	private _entity = objNull;
	{
		_entity = objNull;
		_array = _x;
		_array params [
			'_type',
			'_model',
			'_pos',
			'_vectorDirAndUp',
			'_damageAllowed',
			'_simulationEnabled',
			'_simpleObject',
			'_args',
			'_code'
		];
		if (_simpleObject isNotEqualTo 0) then {
			_entity = createSimpleObject [([_type,_model] select (_simpleObject isEqualTo 2)),[-500,-500,0]];
			_entity setVectorDirAndUp _vectorDirAndUp;
			_entity setPosWorld _pos;
		} else {
			_entity = createVehicle [_type,[-500,-500,0],[],0,'CAN_COLLIDE'];
			if (_simulationEnabled isEqualTo 1) then {
				if (!(simulationEnabled _entity)) then {
					_entity enableSimulationGlobal TRUE;
				};
			} else {
				if (simulationEnabled _entity) then {
					_entity enableSimulationGlobal FALSE;
				};
			};
			if (_damageAllowed isEqualTo 1) then {
				if (!(isDamageAllowed _entity)) then {
					_entity allowDamage TRUE;
				};
			} else {
				if (isDamageAllowed _entity) then {
					_entity allowDamage FALSE;
				};
			};
			_entity setPosWorld _pos;
			_entity setVectorDirAndUp _vectorDirAndUp;
		};
		if (!isNull _entity) then {
			[_entity] call _code;
		};
		_return pushBack _entity;
	} forEach _composition;
	_return;
};
if (_type isEqualTo 'DELETE') exitWith {

};
if (_type isEqualTo 'VEHICLES_ADD') exitWith {
	_vehicles_data = ([_fobID] call (missionNamespace getVariable 'QS_data_fobs')) # 2;
	{
		(serverNamespace getVariable 'QS_v_Monitor') pushBack [objNull,30,FALSE,{},(_x # 0),(_x # 1),(_x # 2),FALSE,0,9,150,500,-1,-1,TRUE,0,{TRUE},FALSE,FALSE,[],[],0,{TRUE}];
	} forEach _vehicles_data;
};
if (_type isEqualTo 'VEHICLES_REMOVE') exitWith {
	private _entity = objNull;
	{
		if (_x isEqualType []) then {
			if ( (_x # 9) isNotEqualTo -1 ) then {
				_entity = _x # 0;
				_entity addEventHandler [
					'GetOut',
					{
						params ['_vehicle'];
						if (((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) then {
							deleteVehicle _vehicle;
						};
					}
				];
				if (isSimpleObject _entity) then {
					deleteVehicle _entity;
				} else {
					(missionNamespace getVariable 'QS_garbageCollector') pushBack [_entity,'NOW_DISCREET',0];
				};
				(serverNamespace getVariable 'QS_v_Monitor') set [_forEachIndex,TRUE];
			};
		};
	} forEach (serverNamespace getVariable 'QS_v_Monitor');
	serverNamespace setVariable ['QS_v_Monitor',((serverNamespace getVariable 'QS_v_Monitor') select {(_x isEqualType [])})];
	TRUE;
};