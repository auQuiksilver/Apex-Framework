/*/
File: fn_deployAssetPreset.sqf
Author:
	
	Quiksilver
	
Last Modified:

	26/11/2023 A3 2.14 by Quiksilver
	
Description:

	What happens when certain deployment presets are deployed
__________________________________________/*/

params ['_vehicle',['_deploy',TRUE],['_preset',-1],['_presetClass','']];
if (
	(isNull _vehicle) ||
	{(_preset isEqualTo -1)}
) exitWith {_vehicle};
if (_preset isEqualTo 0) then {
	if (_deploy) then {
	
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {

	};
};
if (_preset isEqualTo 1) then {
	if (_deploy) then {

		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
	
	};	
};
if (_preset isEqualTo 5) then {
	//comment 'Repair Depot Cargo Container - land_repairdepot_01_green_f';
	if (_deploy) then {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];
		_deployParams = _vehicle getVariable ['QS_logistics_deployParams',[30,30,30,30,100,30,500]];
		_oldVehicle = _vehicle;
		_oldType = typeOf _vehicle;
		_oldVehicle setPosASL [0,0,0];
		deleteVehicle _oldVehicle;
		if (_presetClass isEqualTo '') then {
			_presetClass = ['land_repairdepot_01_tan_f','land_repairdepot_01_green_f'] select (worldName in ['Tanoa','Enoch']);
		};
		_class = QS_core_vehicles_map getOrDefault [_presetClass,['land_repairdepot_01_tan_f','land_repairdepot_01_green_f'] select (worldName in ['Tanoa','Enoch'])];
		_vehicle = createVehicle [_class,[0,0,0]];
		_vehicle allowDamage (unitIsUav _vehicle);
		_vehicle enableSimulationGlobal FALSE;
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		_vehicle enableDynamicSimulation FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_deploy_type0',_oldType,FALSE],
			['QS_logistics',FALSE,TRUE],
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics_deployParams',_deployParams,TRUE]
		];
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		[_vehicle] call QS_fnc_vSetup;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
		QS_system_vehicleRallyPoints pushBackUnique [_vehicle,_posi];
	} else {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];	
		_rallyIndex = QS_system_vehicleRallyPoints findIf { ((_x # 0) isEqualTo _vehicle) };
		if (_rallyIndex isNotEqualTo -1) then {
			QS_system_vehicleRallyPoints deleteAt _rallyIndex;
		};
		_oldVehicle = _vehicle;
		_oldType = _vehicle getVariable ['QS_deploy_type0',typeOf _vehicle];
		_oldVehicle setPosASL [0,0,0];
		deleteVehicle _oldVehicle;
		_vehicle = createVehicle [_oldType,[0,0,0]];
		_vehicle allowDamage FALSE;
		_vehicle enableSimulationGlobal FALSE;_vehicle spawn {uiSleep 1; _this enableSimulationGlobal TRUE; };
		[_vehicle] call QS_fnc_vSetup;
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_deployable',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
	};
};
if (_preset isEqualTo 6) then {
	//comment 'SAM 1 - B_SAM_System_03_F';
	if (_deploy) then {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];
		_oldVehicle = _vehicle;
		_oldType = typeOf _vehicle;
		_oldVehicle setPosASL [0,0,0];
		deleteVehicle _oldVehicle;
		if (_presetClass isEqualTo '') then {
			_presetClass = 'b_sam_system_03_f';
		};
		_class = QS_core_vehicles_map getOrDefault [_presetClass,'b_sam_system_03_f'];
		_vehicle = createVehicle [_class,[0,0,0]];
		_vehicle allowDamage (unitIsUav _vehicle);
		_vehicle enableSimulationGlobal FALSE;_vehicle spawn {uiSleep 1; _this enableSimulationGlobal TRUE; };
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setTurretLimits [[0],-360, 360,30,90];
		_grp = createVehicleCrew _vehicle;
		_grp setBehaviourStrong 'COMBAT';
		(crew _vehicle) doWatch ((_vehicle getRelPos [500,0]) vectorAdd [0,0,500]);
		{ _x setSkill 1;  } forEach (units _grp);
		_vehicle addEventHandler [
			'Fired',
			{
				params ['','','','','','','_projectile',''];
				missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
				missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
			}
		];
		_vehicle addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				deleteVehicleCrew _entity;
			}
		];
		_vehicle addEventHandler [
			'Killed',
			{
				params ['_entity'];
				deleteVehicleCrew _entity;
			}
		];
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_deploy_type0',_oldType,FALSE],
			['QS_inventory_disabled',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE],
			['QS_logistics_immovable',TRUE,TRUE]
		];
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		[_vehicle] call QS_fnc_vSetup;
		_vehicle setVehicleRadar 1;
		_vehicle setVehicleReceiveRemoteTargets TRUE;
		_vehicle setVehicleReportRemoteTargets TRUE;
		_vehicle setVehicleReportOwnPosition TRUE;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];
		_oldVehicle = _vehicle;
		_oldType = _vehicle getVariable ['QS_deploy_type0',typeOf _vehicle];
		_oldVehicle setPosASL [0,0,0];
		deleteVehicleCrew _oldVehicle;
		deleteVehicle _oldVehicle;
		_vehicle = createVehicle [_oldType,[0,0,0]];
		_vehicle allowDamage FALSE;
		_vehicle enableSimulationGlobal FALSE;_vehicle spawn {uiSleep 1; _this enableSimulationGlobal TRUE; };
		[_vehicle] call QS_fnc_vSetup;
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_deployable',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
	};
};
if (_preset isEqualTo 7) then {
	//comment 'SAM Radar - B_Radar_System_01_F';
	if (_deploy) then {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];
		_oldVehicle = _vehicle;
		_oldType = typeOf _vehicle;
		_oldVehicle setPosASL [0,0,0];
		deleteVehicle _oldVehicle;
		if (_presetClass isEqualTo '') then {
			_presetClass = 'b_radar_system_01_f';
		};
		_class = QS_core_vehicles_map getOrDefault [_presetClass,'b_radar_system_01_f'];
		_vehicle = createVehicle [_class,[0,0,0]];
		_vehicle allowDamage (unitIsUav _vehicle);
		_vehicle enableSimulationGlobal FALSE;_vehicle spawn {uiSleep 1; _this enableSimulationGlobal TRUE; };
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		_vehicle enableDynamicSimulation FALSE;
		_grp = createVehicleCrew _vehicle;
		_grp setBehaviourStrong 'AWARE';
		{ _x setSkill 1;  } forEach (units _grp);
		_vehicle addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				deleteVehicleCrew _entity;
			}
		];
		_vehicle addEventHandler [
			'Killed',
			{
				params ['_entity'];
				deleteVehicleCrew _entity;
			}
		];
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_deploy_type0',_oldType,FALSE],
			['QS_inventory_disabled',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE],
			['QS_logistics_immovable',TRUE,TRUE]
		];	
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
		[_vehicle] call QS_fnc_vSetup;
		_vehicle setVehicleRadar 1;
		_vehicle setVehicleReceiveRemoteTargets TRUE;
		_vehicle setVehicleReportRemoteTargets TRUE;
		_vehicle setVehicleReportOwnPosition TRUE;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
		_posi = getPosASL _vehicle;
		_vectors = [vectorDir _vehicle,vectorUp _vehicle];
		_customDN = _vehicle getVariable ['QS_ST_customDN',''];
		_oldVehicle = _vehicle;
		_oldType = _vehicle getVariable ['QS_deploy_type0',typeOf _vehicle];
		_oldVehicle setPosASL [0,0,0];
		deleteVehicleCrew _oldVehicle;
		deleteVehicle _oldVehicle;
		_vehicle = createVehicle [_oldType,[0,0,0]];
		_vehicle allowDamage FALSE;
		_vehicle enableSimulationGlobal FALSE;_vehicle spawn {uiSleep 1; _this enableSimulationGlobal TRUE; };
		[_vehicle] call QS_fnc_vSetup;
		_vehicle setVectorDirAndUp _vectors;
		_vehicle setPosASL _posi;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_deployable',TRUE,TRUE],
			['QS_deploy_preset',_preset,TRUE],
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
		if (_customDN isNotEqualTo '') then {
			_vehicle setVariable ['QS_ST_customDN',_customDN,TRUE];
		};
		if (unitIsUav _vehicle) then {
			_vehicle setVariable ['QS_uav_protected',TRUE,TRUE];
		};
	};
};




if (_preset isEqualTo 8) then {
	//comment 'Parajump';
	if (_deploy) then {
		private _array = [];
		_vehicle setOwner 2;
		_vehicle allowDamage FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle enableSimulationGlobal FALSE;
		_flag = createVehicle ['Flag_White_F',[0,0,0]];
		_flag setPosASL (getPosASL _vehicle);
		_array pushBack _flag;
		private _tickets = _vehicle getVariable ['QS_deploy_tickets',-1];
		if (_tickets isEqualTo -1) then {
			_tickets = 10;
		};
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE],
			['QS_deploy_tickets',_tickets,TRUE],
			['QS_logistics_immovable',TRUE,TRUE]
		];
		[_vehicle] spawn {
			params ['_vehicle'];
			sleep 3;
			_marker = _vehicle getVariable ['QS_deploy_marker',''];
			_text = _vehicle getVariable ['QS_deploy_markerText',''];
			_marker setMarkerText (format ['%1 [%2]',_text,_vehicle getVariable ['QS_deploy_tickets',0]]);
		};
		QS_mobile_increment1 = QS_mobile_increment1 + 1;
		_systems_id = format ['ID_MOBILE_%1',QS_mobile_increment1];
		[
			'ADD',
			[
				25,
				_systems_id,
				{TRUE},
				{localize 'STR_QS_Menu_230'},
				'VEHICLE',
				_vehicle,
				300,
				[],
				[WEST],
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					_enemySides = QS_player call QS_fnc_enemySides;
					if (((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo []) then {
						private _tickets = _deploymentLocationData getVariable ['QS_deploy_tickets',0];
						_tickets = (_tickets - 1) max 0;
						_deploymentLocationData setVariable ['QS_deploy_tickets',_tickets,TRUE];
						_jumpPos = _deploymentPosition vectorAdd [(-5 + (random 10)),(-5 + (random 10)),1500];
						QS_player setPosASL _jumpPos;
						[2,QS_player] spawn {
							uiSleep (_this # 0);
							if (!isTouchingGround (_this # 1)) then {
								QS_EH_IronMan = addMissionEventHandler ['EachFrame',{call (missionNamespace getVariable 'QS_fnc_wingsuit')}];
							};
						};
						[116,_deploymentLocationData,_tickets] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					} else {
						50 cutText [localize 'STR_QS_Text_433','PLAIN DOWN',0.3,TRUE,TRUE];
					};
				},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					_enemySides = QS_player call QS_fnc_enemySides;
					_positionClear = (((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo []);
					if (!(_positionClear)) then {
						50 cutText [localize 'STR_QS_Text_433','PLAIN DOWN',0.3,TRUE,TRUE];
					};
					_positionClear
				},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,_deploymentPosition];
					ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
					0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
				},
				{FALSE},
				{TRUE},
				'',
				{TRUE},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					if (
						(_deploymentLocationData isEqualType objNull) &&
						{((_deploymentLocationData getVariable ['QS_deploy_tickets',0]) isNotEqualTo 0)}
					) exitWith {
						(_deploymentLocationData getVariable ['QS_deploy_tickets',0])
					};
					0
				}
			]
		] call QS_fnc_deployment;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,_array,_systems_id];
	} else {
		_vehicle enableDynamicSimulation TRUE;
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
		_assetsIndex = QS_logistics_deployedAssets findIf { (_x # 0) isEqualTo _vehicle };
		if (_assetsIndex isNotEqualTo -1) then {
			_assets = (QS_logistics_deployedAssets # _assetsIndex) # 1;
			_systems_id = (QS_logistics_deployedAssets # _assetsIndex) # 2;
			['REMOVE',_systems_id] call QS_fnc_deployment;
			if (_assets isNotEqualTo []) then {
				deleteVehicle _assets;
			};
			QS_logistics_deployedAssets deleteAt _assetsIndex;
		};
	};
};




















if (_preset isEqualTo 12) then {
	//comment 'Fortifications - Large';
	if (_deploy) then {
		_vehicle allowDamage FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_vehicle enableSimulationGlobal FALSE;
		_vehicle setVelocity [0,0,0];
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([6] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
		QS_system_vehicleRallyPoints pushBackUnique [_vehicle,getPosASL _vehicle];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		_rallyIndex = QS_system_vehicleRallyPoints findIf { ((_x # 0) isEqualTo _vehicle) };
		if (_rallyIndex isNotEqualTo -1) then {
			QS_system_vehicleRallyPoints deleteAt _rallyIndex;
		};
		_vehicle enableDynamicSimulation TRUE;
		_vehicle setVariable ['QS_dynSim_ignore',FALSE,TRUE];
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];			
	};
};
if (_preset isEqualTo 13) then {
	//comment 'Fortifications - Medium';
	if (_deploy) then {
		_vehicle allowDamage FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_vehicle enableSimulationGlobal FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([5] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
		QS_system_vehicleRallyPoints pushBackUnique [_vehicle,getPosASL _vehicle];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		_rallyIndex = QS_system_vehicleRallyPoints findIf { ((_x # 0) isEqualTo _vehicle) };
		if (_rallyIndex isNotEqualTo -1) then {
			QS_system_vehicleRallyPoints deleteAt _rallyIndex;
		};
		_vehicle enableDynamicSimulation TRUE;
		_vehicle setVariable ['QS_dynSim_ignore',FALSE,TRUE];
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];		
	};	
};
if (_preset isEqualTo 14) then {
	//comment 'Fortifications - Small';
	if (_deploy) then {
		_vehicle allowDamage FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_vehicle enableSimulationGlobal FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([4] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
		QS_system_vehicleRallyPoints pushBackUnique [_vehicle,getPosASL _vehicle];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		_rallyIndex = QS_system_vehicleRallyPoints findIf { ((_x # 0) isEqualTo _vehicle) };
		if (_rallyIndex isNotEqualTo -1) then {
			QS_system_vehicleRallyPoints deleteAt _rallyIndex;
		};
		_vehicle enableDynamicSimulation TRUE;
		_vehicle setVariable ['QS_dynSim_ignore',FALSE,TRUE];
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];		
	};	
};
if (_preset isEqualTo 15) then {
	//comment 'Platform/Bridge Kit';
	if (_deploy) then {
		_vehicle setOwner 2;
		_vehicle allowDamage FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_vehicle enableSimulationGlobal FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([7] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		_vehicle enableDynamicSimulation TRUE;
		_vehicle setVariable ['QS_dynSim_ignore',FALSE,TRUE];
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
	};
};

if (_preset isEqualTo 16) then {
	//comment 'Mobile Respawn';
	if (_deploy) then {
		private _array = [];
		_vehicle setOwner 2;
		_vehicle allowDamage FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle enableSimulationGlobal FALSE;
		_flag = createVehicle ['Flag_White_F',[0,0,0]];
		_flag setPosASL (getPosASL _vehicle);
		_array pushBack _flag;
		private _tickets = _vehicle getVariable ['QS_deploy_tickets',-1];
		if (_tickets isEqualTo -1) then {
			_tickets = 10;
		};
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE],
			['QS_deploy_tickets',_tickets,TRUE],
			['QS_logistics_immovable',TRUE,TRUE]
		];
		[_vehicle] spawn {
			params ['_vehicle'];
			sleep 3;
			_marker = _vehicle getVariable ['QS_deploy_marker',''];
			_text = _vehicle getVariable ['QS_deploy_markerText',''];
			_marker setMarkerText (format ['%1 [%2]',_text,_vehicle getVariable ['QS_deploy_tickets',0]]);
		};
		QS_mobile_increment1 = QS_mobile_increment1 + 1;
		_systems_id = format ['ID_MOBILE_%1',QS_mobile_increment1];
		['ADD',[_systems_id,TRUE,'SAFE','RAD',1,[_vehicle,50],{},{},{TRUE},{},[EAST,WEST,RESISTANCE,CIVILIAN]]] call QS_fnc_zoneManager;
		[
			'ADD',
			[
				4,
				_systems_id,
				{TRUE},
				{localize 'STR_QS_Menu_211'},
				'VEHICLE',
				_vehicle,
				300,
				[],
				[WEST],
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					_enemySides = QS_player call QS_fnc_enemySides;
					if (((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo []) then {
						private _tickets = _deploymentLocationData getVariable ['QS_deploy_tickets',0];
						_tickets = (_tickets - 1) max 0;
						_deploymentLocationData setVariable ['QS_deploy_tickets',_tickets,TRUE];
						QS_player setVehiclePosition [_deploymentPosition,[],15,'NONE'];
						[116,_deploymentLocationData,_tickets] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					} else {
						50 cutText [localize 'STR_QS_Text_433','PLAIN DOWN',0.3,TRUE,TRUE];
					};
				},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					_enemySides = QS_player call QS_fnc_enemySides;
					_positionClear = (((flatten (_enemySides apply {units _x})) inAreaArray [_deploymentPosition,QS_enemyInterruptAction_radius,QS_enemyInterruptAction_radius,0,FALSE,-1]) isEqualTo []);
					if (!(_positionClear)) then {
						50 cutText [localize 'STR_QS_Text_433','PLAIN DOWN',0.3,TRUE,TRUE];
					};
					_positionClear
				},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					_deploymentPosition = [_deploymentType,_deploymentLocationData] call QS_fnc_getDeploymentPosition;
					((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,_deploymentPosition];
					ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
					0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
				},
				{FALSE},
				{TRUE},
				'',
				{TRUE},
				{
					params (localNamespace getVariable ['QS_deployment_dataParams',[]]);
					if (
						(_deploymentLocationData isEqualType objNull) &&
						{((_deploymentLocationData getVariable ['QS_deploy_tickets',0]) isNotEqualTo 0)}
					) exitWith {
						(_deploymentLocationData getVariable ['QS_deploy_tickets',0])
					};
					0
				}
			]
		] call QS_fnc_deployment;
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([3] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,_array,_systems_id];
	} else {
		_vehicle enableDynamicSimulation TRUE;
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];
		_assetsIndex = QS_logistics_deployedAssets findIf { (_x # 0) isEqualTo _vehicle };
		if (_assetsIndex isNotEqualTo -1) then {
			_assets = (QS_logistics_deployedAssets # _assetsIndex) # 1;
			_systems_id = (QS_logistics_deployedAssets # _assetsIndex) # 2;	
			['REMOVE',_systems_id] call QS_fnc_zoneManager;
			['REMOVE',_systems_id] call QS_fnc_deployment;
			if (_assets isNotEqualTo []) then {
				deleteVehicle _assets;
			};
			QS_logistics_deployedAssets deleteAt _assetsIndex;
		};
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
	};
};
if (_preset isEqualTo 17) then {
	if (_deploy) then {
		_vehicle setOwner 2;
		_vehicle allowDamage FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle enableSimulationGlobal FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE],
			['QS_logistics_immovable',TRUE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([8] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		/*
		_vehicle enableDynamicSimulation TRUE;
		//_vehicle enableSimulationGlobal TRUE;
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_dynSim_ignore',TRUE,TRUE],
			['QS_logistics',TRUE,TRUE],
			['QS_logistics_immovable',FALSE,TRUE]
		];
		*/
		//Delete it until we figure out a better way to handle it
		_vehicle spawn {
			_this hideObjectGlobal TRUE;
			sleep 2;
			deleteVehicle _this;
		};
	};
};
if (_preset isEqualTo 18) then {
	
};
if (_preset isEqualTo 19) then {
	//comment 'Fortifications - Firebase';
	if (_deploy) then {
		_vehicle allowDamage FALSE;
		_vehicle enableVehicleCargo FALSE;
		_vehicle enableRopeAttach FALSE;
		_vehicle enableDynamicSimulation FALSE;
		_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_vehicle enableSimulationGlobal FALSE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',TRUE,TRUE],
			['QS_logistics',FALSE,TRUE]
		];
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			([14] call QS_data_virtualCargoPresets)
		] call QS_fnc_virtualVehicleCargo;
		QS_logistics_deployedAssets pushBackUnique [_vehicle,[],''];
	} else {
		[
			'SET_VCARGO_SERVER',
			_vehicle,
			[]
		] call QS_fnc_virtualVehicleCargo;
		_vehicle enableVehicleCargo TRUE;
		_vehicle enableRopeAttach TRUE;
		_vehicle enableDynamicSimulation TRUE;
		_vehicle setVariable ['QS_dynSim_ignore',FALSE,TRUE];
		_vehicle enableSimulationGlobal TRUE;
		{
			_vehicle setVariable _x;
		} forEach [
			['QS_logistics_immovable',FALSE,TRUE],
			['QS_logistics',TRUE,TRUE]
		];		
	};	
};
_vehicle;