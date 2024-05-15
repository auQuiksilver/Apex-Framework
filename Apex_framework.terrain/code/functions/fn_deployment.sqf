/*/
File: fn_deployment.sqf
Author:

	Quiksilver
	
Last Modified:

	27/03/2023 A3 2.12 by Quiksilver
	
Description:

	Deployment System
________________________________________________/*/

params ['_mode'];
if (_mode isEqualTo 'GET_NEAREST') exitWith {};
if (_mode isEqualTo 'GET_HOME_DATA') exitWith {
	_homeID = localNamespace getVariable ['QS_deployment_home',''];
	_index = (missionNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _homeID) };
	if (_index isEqualTo -1) exitWith {[]};
	((missionNamespace getVariable ['QS_system_deployments',[]]) # _index)
};
if (_mode isEqualTo 'GET_DEFAULT_DATA') exitWith {
	_homeID = missionNamespace getVariable ['QS_deployment_default',''];
	_index = (missionNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _homeID) };
	if (_index isEqualTo -1) exitWith {[]};
	((missionNamespace getVariable ['QS_system_deployments',[]]) # _index)
};
if (_mode isEqualTo 'SELECT') exitWith {
	params ['',['_data',(uiNamespace getVariable ['QS_client_menuDeployment_selectedData',[]])]];
	if (_data isEqualTo []) exitWith {
		50 cutText [localize 'STR_QS_Text_408','PLAIN DOWN',0.5];
	};
	localNamespace setVariable ['QS_deploymentMenu_deployed',TRUE];
	_data params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
	call _codeOnDeploy;
	if (visibleMap) then {
		openMap [FALSE,FALSE];
	};
};
if (_mode isEqualTo 'INIT_PLAYER') exitWith {
	localNamespace setVariable [
		'QS_deployment_dataParams',
		[
			['_priority',0],
			['_deploymentId','ID_DEFAULT'],
			['_codeEnabled',{TRUE}],
			['_codeDisplayName',{'Default'}],
			['_deploymentType','MARKER'],
			['_deploymentLocationData','respawn'],
			['_deploymentMinRadius',300],
			['_arrayDestinationData',[]],
			['_arrayfactions',[WEST]],
			['_codeOnDeploy',{TRUE}],
			['_codeConditionDeploy',{TRUE}],
			['_codeOnMenuSelect',{TRUE}],
			['_codeCanSetAsHome',{TRUE}],
			['_availableOnRespawn',{TRUE}],
			['_mapIcon',''],
			['_codeConditionAddToMenu',{TRUE}],
			['_deploymentTickets',{-1}]
		]
	];
};
// SERVER
if (_mode isEqualTo 'TICKETS') exitWith {
	params ['','_id',['_change',0],['_set',FALSE]];
	_index = (localNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		_element = (localNamespace getVariable ['QS_system_deployments',[]]) # _index;
		_entity = _element # 5;
		_tickets = call (_element # 16);
		if (
			(_tickets > 0) && 
			(!_set)
		) then {
			_element set [16,{_tickets + _change}];
			(localNamespace getVariable ['QS_system_deployments',[]]) set [_index,_element];
			['PROP'] call QS_fnc_deployment;
			if (_entity isEqualType objNull) then {
				_marker = _entity getVariable ['QS_deploy_marker',''];
				if (_marker isNotEqualTo '') then {
					_marker setMarkerText (format ['%1 [%2]',(_entity getVariable ['QS_deploy_markerText','']),call {(_tickets + _change)}]);
				};
			};
		};
		if (_set) then {
			_element set [16,{_change}];
			(localNamespace getVariable ['QS_system_deployments',[]]) set [_index,_element];
			['PROP'] call QS_fnc_deployment;
			if (_entity isEqualType objNull) then {
				_marker = _entity getVariable ['QS_deploy_marker',''];
				if (_marker isNotEqualTo '') then {
					_marker setMarkerText (format ['%1 [%2]',(_entity getVariable ['QS_deploy_markerText','']),call {_change}]);
				};
			};
		};
	};
};
if (_mode isEqualTo 'ADD') exitWith {
	params ['','_data'];
	_id = _data # 1;
	_index = (localNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _id) };
	if (_index isEqualTo -1) then {
		(localNamespace getVariable ['QS_system_deployments',[]]) pushBack _data;
	} else {
		(localNamespace getVariable ['QS_system_deployments',[]]) set [_index,_data];
	};
	['PROP'] call QS_fnc_deployment;
};
if (_mode isEqualTo 'REMOVE') exitWith {
	params ['','_id'];
	_index = (localNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		(localNamespace getVariable ['QS_system_deployments',[]]) deleteAt _index;
		['PROP'] call QS_fnc_deployment;
	};
};
if (_mode isEqualTo 'TOGGLE_STATE') exitWith {
	params ['','_id',['_toggle',{TRUE}]];
	_index = (localNamespace getVariable ['QS_system_deployments',[]]) findIf { ((_x # 1) isEqualTo _id) };
	if (_index isNotEqualTo -1) then {
		_element = (localNamespace getVariable ['QS_system_deployments',[]]) # _index;
		_element set [2,_toggle];
		(localNamespace getVariable ['QS_system_deployments',[]]) set [_index,_element];
		['PROP'] call QS_fnc_deployment;
	};	
};
if (_mode isEqualTo 'PROP') exitWith {
	missionNamespace setVariable ['QS_system_deployments',(localNamespace getVariable ['QS_system_deployments',[]]),TRUE];
	missionNamespace setVariable ['QS_deploymentMenu_update',TRUE,TRUE];
};
if (_mode isEqualTo 'INIT') exitWith {
	localNamespace setVariable ['QS_system_deployments',[]];
	missionNamespace setVariable ['QS_system_deploymentEnabled',TRUE,TRUE];
	['PROP'] call QS_fnc_deployment;
};
if (_mode isEqualTo 'PRESET') exitWith {
	params ['','_preset',['_setDefault',FALSE]];
	if (_preset isEqualTo 0) then {
		// Main Base spawn
		_data = [
			99,
			'BASE_01',
			{TRUE},
			{localize 'STR_QS_Menu_202'},
			'MARKER',
			'QS_marker_base_marker',
			0,
			[],
			[WEST],
			{
				_spawnpos = (markerPos ['QS_marker_base_marker',TRUE]) vectorAdd [-5 + (random 10),-5 + (random 10),0];
				QS_player setDir (random 360);
				QS_player setPosASL _spawnpos;
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_base_marker'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{TRUE},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
		if (_setDefault) then {
			missionNamespace setVariable ['QS_deployment_default','BASE_01',TRUE];
		};
	};
	if (_preset isEqualTo 1) then {
		// Destroyer ship
		_data = [
			90,
			'ID_DESTROYER_01',
			{TRUE},
			{localize 'STR_QS_Marker_070'},
			'MARKER',
			'QS_marker_destroyer_1',
			0,
			[],
			[WEST],
			{
				['RESPAWN_PLAYER',QS_player] spawn QS_fnc_destroyer
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_destroyer_1'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{TRUE},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
		if (_setDefault) then {
			missionNamespace setVariable ['QS_deployment_default','ID_DESTROYER_01',TRUE];
		};
	};
	if (_preset isEqualTo 2) then {
		// Carrier ship
		_data = [
			91,
			'ID_CARRIER_01',
			{TRUE},
			{localize 'STR_QS_Marker_069'},
			'MARKER',
			'QS_marker_carrier_1',
			0,
			[],
			[WEST],
			{
				['RESPAWN_PLAYER',QS_player] spawn QS_fnc_carrier
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_carrier_1'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{TRUE},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
		if (_setDefault) then {
			missionNamespace setVariable ['QS_deployment_default','ID_CARRIER_01',TRUE];
		};
	};
	if (_preset isEqualTo 3) then {
		// Pilot Spawn
		_data = [
			50,
			'ID_HELISPAWN_01',
			{TRUE},
			{localize 'STR_QS_Menu_203'},
			'MARKER',
			'QS_marker_heli_spawn',
			50,
			[],
			[WEST],
			{
				_spawnpos = (markerPos ['QS_marker_heli_spawn',TRUE]) vectorAdd [-5 + (random 10),-5 + (random 10),0];
				QS_player setDir (random 360);
				QS_player setPosASL _spawnpos;
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_heli_spawn'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{QS_player getUnitTrait 'QS_trait_pilot'},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
	};
	if (_preset isEqualTo 4) then {
		// UAV Pilot Spawn
		_data = [
			49,
			'ID_UAVSPAWN_01',
			{TRUE},
			{localize 'STR_QS_Menu_205'},
			'MARKER',
			'QS_marker_respawn_uavoperator',
			50,
			[],
			[WEST],
			{
				_spawnpos = (markerPos ['QS_marker_respawn_uavoperator',TRUE]);
				QS_player setDir (markerDir 'QS_marker_respawn_uavoperator');
				QS_player setPosASL _spawnpos;
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_respawn_uavoperator'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{QS_player getUnitTrait 'uavhacker'},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
	};
	if (_preset isEqualTo 5) then {
		// Jet Pilot Spawn
		_data = [
			48,
			'ID_UAVSPAWN_01',
			{TRUE},
			{localize 'STR_QS_Menu_204'},
			'MARKER',
			'QS_marker_respawn_jetpilot',
			50,
			[],
			[WEST],
			{
				_spawnpos = (markerPos ['QS_marker_respawn_jetpilot',TRUE]);
				QS_player setDir (markerDir 'QS_marker_respawn_jetpilot');
				QS_player setPosASL _spawnpos;
			},
			{TRUE},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_respawn_jetpilot'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{QS_player getUnitTrait 'QS_trait_fighterPilot'},
			{-1}
		];
		['ADD',_data] call QS_fnc_deployment;
	};
	if (_preset isEqualto 6) then {
		params ['','','',['_sides',[WEST]]];
		// FOB
		_data = [
			91,
			'ID_FOB_0',
			{TRUE},
			{localize 'STR_QS_Marker_007'},
			'MARKER',
			'QS_marker_module_fob',
			0,
			[],
			_sides,
			{
				params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
				_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
				_enemySides = QS_player call QS_fnc_enemySides;
				if (((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo []) then {
					private _tickets = QS_module_fob_flag getVariable ['QS_deploy_tickets',0];
					_tickets = (_tickets - 1) max 0;
					QS_module_fob_flag setVariable ['QS_deploy_tickets',_tickets,TRUE];
					QS_player setVehiclePosition [_deploymentPosition,[],15,'NONE'];
				} else {
					50 cutText [localize 'STR_QS_Text_433','PLAIN DOWN',0.3,TRUE,TRUE];
				};
			},
			{
				params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
				_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
				_enemySides = QS_player call QS_fnc_enemySides;
				(
					((missionNamespace getVariable ['QS_module_fob_side',WEST]) isEqualTo (QS_player getVariable ['QS_unit_side',WEST])) &&
					(((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo [])
				)
			},
			{
				((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_module_fob'];
				ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
				0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
			},
			{TRUE},
			{TRUE},
			'',
			{
				params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
				_result = _this call QS_fnc_canRespawnAtFOB;
				_result;
			},
			{QS_module_fob_flag getVariable ['QS_deploy_tickets',0]}
		];
		['ADD',_data] call QS_fnc_deployment;
	};
};