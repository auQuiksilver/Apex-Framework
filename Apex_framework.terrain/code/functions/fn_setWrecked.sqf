/*
File: fn_setWrecked.sqf
Author:

	Quiksilver
	
Last modified:

	12/11/2023 A3 2.14 by Quiksilver
	
Description:

	Set Vehicle as wreck
_______________________________________________*/

params ['_entity',['_state',0],['_manage',TRUE],['_wreckInfo',[FALSE,'','','']],['_replaceAsset',FALSE]];
if (isNull _entity) exitWith {};
if (_state isEqualTo 0) exitWith {
	//comment 'SET AS WRECK - NOW';
	_wreckInfo params [['_wreckState',TRUE],['_vehicleType',''],['_wreckType',''],['_vehicleDisplayName','']];
	if (_vehicleDisplayName isEqualTo '') then {
		_vehicleDisplayName = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI _vehicleType],
			{getText (configFile >> 'CfgVehicles' >> _vehicleType >> 'displayName')},
			TRUE
		];
		_wreckInfo set [3,_vehicleDisplayName];
	};
	if (_vehicleType isEqualTo '') then {
		_vehicleType = typeOf _entity;
	};
	_entityVectors = [vectorDir _entity,vectorUp _entity];
	_entityPos = (getPosASL _entity) vectorAdd [0,0,1];
	private _vIndex = -1;
	private _addToManager = FALSE;
	if (isDedicated && _manage) then {
		_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
		if (_vIndex isNotEqualTo -1) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [17,_wreckState];
			_element set [19,[_entityPos,_entityVectors]];
			_element set [20,_wreckInfo];
			(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
		} else {
			_addToManager = TRUE;
		};
	};
	if (_replaceAsset) then {
		_oldEntity = _entity;
		_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
		{ropeDestroy _x} forEach (ropes _oldEntity);
		deleteVehicle (attachedObjects _oldEntity);
		_wreckType = [_oldEntity,toLowerANSI (typeOf _oldEntity)] call QS_fnc_getWreckType;
		_entity = createVehicle [_wreckType,[-500,-500,500],[],100,'CAN_COLLIDE'];
		_entity setVectorDirAndUp _entityVectors;
		if (_vIndex isNotEqualTo -1) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [0,_entity];
			(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
		};
		deleteVehicle _oldEntity;
		_entity setVelocity [0,0,0];
		_entity setPosASL (_entityPos vectorAdd [0,0,1]);
	} else {
		// did not replace asset
		// spawn smoke?
		['ON',_entity] call (missionNamespace getVariable 'QS_fnc_wreckSetMaterials');
		[_entity,1] call (missionNamespace getVariable 'QS_fnc_vehicleAddSmokeEffect');
	};
	_entity setVariable ['QS_logistics_packable',FALSE,TRUE];
	if (_entity isKindOf 'Cargo_base_F') then {		// this is not ideal but should work for now
		// This should be a cargo container
		_entity setVariable ['QS_logistics_isCargoParent',TRUE,TRUE];
		_entity setVariable ['QS_logistics_disableCargo',TRUE,TRUE];
	};
	private _wreck_handlers = [];
	{
		_wreck_handlers pushBack [_x # 0,_entity addEventHandler _x];
	} forEach [
		[
			'Deleted',
			{
				params ['_entity'];
				_marker = _entity getVariable ['QS_wreck_marker',''];
				if (_marker isNotEqualTo '') then {
					deleteMarker _marker;
				};
				if (!isNull (_entity getVariable ['QS_effect_smoke',objNull])) then {
					deleteVehicle (_entity getVariable ['QS_effect_smoke',objNull]);
				};
			}
		],
		[
			'Killed',
			{
				params ['_entity'];
				_marker = _entity getVariable ['QS_wreck_marker',''];
				if (_marker isNotEqualTo '') then {
					deleteMarker _marker;
				};
				if (!isNull (_entity getVariable ['QS_effect_smoke',objNull])) then {
					deleteVehicle (_entity getVariable ['QS_effect_smoke',objNull]);
				};
			}
		],
		[
			'Local',
			{
				params ['_entity','_isLocal'];
				if (_isLocal) then {
					if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isEqualTo -1) then {
						_entity setVariable [
							'QS_wreck_damageHandler1',
							(_entity addEventHandler ['HandleDamage',{call QS_fnc_wreckHandleDamage}]),
							FALSE
						];
					};
				} else {
					if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isNotEqualTo -1) then {
						_entity removeEventHandler ['HandleDamage',(_entity getVariable ['QS_wreck_damageHandler1',-1])];
						_entity setVariable ['QS_wreck_damageHandler1',-1,FALSE];
					};
					[
						[_entity],
						{
							params ['_entity'];
							if ((_entity getVariable ['QS_wreck_damageHandler0',-1]) isEqualTo -1) then {
								_entity setVariable [
									'QS_wreck_damageHandler0',
									(_entity addEventHandler ['Local',{call QS_fnc_wreckHandleLocal}]),
									FALSE
								];
							};
							if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isEqualTo -1) then {
								_entity setVariable [
									'QS_wreck_damageHandler1',
									(_entity addEventHandler ['HandleDamage',{call QS_fnc_wreckHandleDamage}]),
									FALSE
								];
							};
						}
					] remoteExec ['call',_entity,FALSE];
				};
			}
		],
		[
			'GetIn',
			{
				params ['_vehicle','','_unit',''];
				if (_vehicle getVariable ['QS_logistics_wreck',FALSE]) then {
					_unit moveOut _vehicle;
				};
			}
		]
	];
	if (isDedicated && ((_entity getVariable ['QS_wreck_marker','']) isEqualTo '')) then {
		_marker = createMarker [str systemTime,_entity];
		_marker setMarkerTypeLocal 'mil_dot';
		_marker setMarkerShapeLocal 'Icon';
		_marker setMarkerColorLocal 'ColorBrown';
		_marker setMarkerSizeLocal [0.5,0.5];
		if (_vehicleDisplayName isEqualTo '') then {
			_vehicleDisplayName = getText ((configOf _entity) >> 'displayName');
		};
		_marker setMarkerTextLocal (format [localize 'STR_QS_Text_415',_vehicleDisplayName]);
		_marker setMarkerAlpha 0.75;
		_entity setVariable ['QS_wreck_marker',_marker,FALSE];
	};
	if (local _entity) then {
		if (isEngineOn _entity) then {
			_entity engineOn FALSE;	
		};
		if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isEqualTo -1) then {
			if (isDamageAllowed _entity) then {
				_entity allowDamage FALSE;
			};
			_entity setVariable [
				'QS_wreck_damageHandler1',
				(_entity addEventHandler ['HandleDamage',{call QS_fnc_wreckHandleDamage}]),
				FALSE
			];
		};
	} else {
		[
			[_entity],
			{
				params ['_entity'];
				_grp = assignedGroup _entity; 
				if (!isNull _grp) then {
					_grp leaveVehicle _entity;
				};
				if (isEngineOn _entity) then {
					_entity engineOn FALSE;
				};
				if (isDamageAllowed _entity) then {
					_entity allowDamage FALSE;
				};
				if ((_entity getVariable ['QS_wreck_damageHandler0',-1]) isEqualTo -1) then {
					_entity setVariable [
						'QS_wreck_damageHandler0',
						(_entity addEventHandler ['Local',{call QS_fnc_wreckHandleLocal}]),
						FALSE
					];
				};
				if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isEqualTo -1) then {
					_entity setVariable [
						'QS_wreck_damageHandler1',
						(_entity addEventHandler ['HandleDamage',{call QS_fnc_wreckHandleDamage}]),
						FALSE
					];
				};
			}
		] remoteExec ['call',_entity,FALSE];
	};
	{
		_entity setVariable _x;
	} forEach [
		['QS_dynSim_ignore',TRUE,TRUE],
		['QS_logistics_wreck',TRUE,TRUE],
		['QS_wreck_info',_wreckInfo,FALSE],
		['QS_wreck_handlers',_wreck_handlers,FALSE],
		['QS_logistics',TRUE,TRUE],
		['QS_logistics_dragDisabled',TRUE,TRUE],
		['QS_ST_customDN',_vehicleDisplayName,TRUE]
	];
	_entity enableDynamicSimulation FALSE;
	_entity enableSimulationGlobal TRUE;
	{
		if (!unitIsUav _x) then {
			_x moveOut _entity;
		};
	} forEach (crew _entity);
	if (_entity isKindOf 'Cargo10_base_F') then {
		_entity setMass 2500;
	};
	if (_addToManager) then {
		[_entity,3,_this,_wreckInfo] call QS_fnc_setWrecked;
	};
	_entity;
};
if (_state isEqualTo 1) exitWith {
	//comment 'SET AS WRECK - ON RESPAWN';
	if (_manage && isDedicated) then {
		_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
		if (_vIndex isNotEqualTo -1) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_wreckInfo params [['_wreckState',TRUE],['_vehicleType',''],['_wreckType',''],['_vehicleDisplayName','']];
			_wreckInfo set [0,TRUE];
			if (_vehicleType isEqualTo '') then {
				_wreckInfo set [1,typeOf _entity];
			};
			if (_wreckType isEqualTo '') then {
				_wreckInfo set [2,[_entity,_vehicleType] call QS_fnc_getWreckType];
			};
			if (_vehicleDisplayName isEqualTo '') then {
				_vehicleDisplayName = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _entity)],
					{getText ((configOf _entity) >> 'displayName')},
					TRUE
				];
				_wreckInfo set [3,_vehicleDisplayName];
			};
			_entity setVariable ['QS_logistics_isCargoParent',TRUE,TRUE];
			_element set [17,TRUE];
			_element set [19,[((getPosASL _entity) vectorAdd [0,0,0.1]),[vectorDir _entity,vectorUp _entity]]];
			_element set [20,[TRUE,_vehicleType,_wreckType,_vehicleDisplayName]];
			(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
		};
	};
};
if (_state isEqualTo 2) exitWith {
	//comment 'NO LONGER WRECK';
	_entity setVariable ['QS_logistics_wreck',FALSE,TRUE];
	if (_manage) then {
		_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
		if (_vIndex isNotEqualTo -1) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [17,FALSE];
			(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
		};
	};
	_wreck_handlers = _entity getVariable ['QS_wreck_handlers',[]];
	if (_wreck_handlers isNotEqualTo []) then {
		{
			_entity removeEventHandler _x;
		} forEach _wreck_handlers;
		_entity setVariable ['QS_wreck_handlers',[],FALSE];
	};
	if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isNotEqualTo -1) then {
		_entity removeEventHandler ['HandleDamage',(_entity getVariable ['QS_wreck_damageHandler1',-1])];
		_entity setVariable ['QS_wreck_damageHandler1',-1,FALSE];
	};
	if (local _entity) then {
		if ((['Air','LandVehicle','Ship'] findIf { _entity isKindOf _x }) isNotEqualTo -1) then {
			if (!isDamageAllowed _entity) then {
				_entity allowDamage TRUE;
			};
		};
	} else {
		[
			[_entity],
			{
				params ['_entity'];
				//systemChat format ['%1 is no longer a wreck',(typeOf _entity)];
				if (
					(local _entity) &&
					(!isDamageAllowed _entity) &&
					((['Air','LandVehicle','Ship'] findIf { _entity isKindOf _x }) isNotEqualTo -1)
				) then {
					_entity allowDamage TRUE;
				};
				if ((_entity getVariable ['QS_wreck_damageHandler1',-1]) isNotEqualTo -1) then {
					_entity removeEventHandler ['HandleDamage',(_entity getVariable ['QS_wreck_damageHandler1',-1])];
					_entity setVariable ['QS_wreck_damageHandler1',-1,FALSE];
				};
			}
		] remoteExec ['call',-2,FALSE];
	};
	_marker = _entity getVariable ['QS_wreck_marker',''];
	if (_marker isNotEqualTo '') then {
		deleteMarker _marker;
	};
};
if (_state isEqualTo 3) exitWith {
	params ['','','_args','_wreckInfo2'];
	_args params ['_entity',['_state',0],['_manage',TRUE],['_wreckInfo',[FALSE,'','','']],['_replaceAsset',FALSE]];
	_wreckInfo2 params [['_wreckState',TRUE],['_vehicleType',''],['_wreckType',''],['_vehicleDisplayName','']];
	_entityVectors = [vectorDir _entity,vectorUp _entity];
	_entityPos = (getPosASL _entity) vectorAdd [0,0,1];
	//comment 'Add existing wreck to monitor temporarily (until unwrecked)';
	(serverNamespace getVariable 'QS_v_Monitor') pushBack [
		_entity,
		-1,
		FALSE,
		{},
		typeOf _entity,
		[0,0,0],
		0,
		FALSE,
		-1,
		-1,
		1000,
		1000,
		0,		
		-1,
		FALSE,
		0,
		{TRUE},
		TRUE,
		FALSE,
		[_entityPos,_entityVectors],
		_wreckInfo2,
		1,
		{TRUE}
	];
};