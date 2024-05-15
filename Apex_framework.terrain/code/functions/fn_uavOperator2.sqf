/*/
File: fn_uavOperator2.sqf
Author:

	Quiksilver
	
Last modified:

	15/1/2023 A3 2.10 by Quiksilver
	
Description:

	UAV Operator
__________________________________________________/*/
scriptName 'QS - Script - UAV';
private _role_check = diag_tickTime + 15;
for '_x' from 0 to 1 step 0 do {
	if (!(isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull]))) then {
		waitUntil {
			uiSleep 0.1;
			((isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull])) || (!(player getUnitTrait 'uavhacker')))
		};
		_role_check = diag_tickTime + 15;
	};
	if (!(player getUnitTrait 'uavhacker')) exitWith {};
	if (diag_tickTime > _role_check) exitWith {};
	uiSleep 0.1;
};
if (!(player getUnitTrait 'uavhacker')) exitWith {};
private _casEnabled = (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [2]) || (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [1,3]) && ((getPlayerUID player) in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist')))));
_isOwnedApex = 395180 in (getDLCs 1);
_isOwnedJets = 601670 in (getDLCs 1);
_worldName = worldName;
_worldSize = worldSize;
private _displayName = '';
createCenter WEST;
private _carrierEnabled = ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0);
private _uavData = missionNamespace getVariable ['QS_uav_Monitor',[]];
private _uavLoiterPosition = [0,0,0];
private _uavRespawnDelay = uiNamespace getVariable ['QS_uavRespawnDelay',-1];
private _cfgVehicles = configFile >> 'CfgVehicles';
if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
	if ((missionNamespace getVariable ['QS_missionConfig_destroyerArtillery',0]) isNotEqualTo 0) then {
		_turrets = (missionNamespace getVariable 'QS_destroyerObject') getVariable ['QS_destroyer_turrets',[]];
		if (_turrets isNotEqualTo []) then {
			private _turret = objNull;
			{
				_turret = _x;
				//['setOwner',_turret,clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];		// setOwner is not the correct tool for this job. not deleting line incase there was a reason we did this before
				['setGroupOwner',(group (gunner _turret)),clientOwner] remoteExec ['QS_fnc_remoteExecCmd',2,FALSE];
				_turret addEventHandler [
					'Fired',
					{
						params ['','','','','','','_projectile',''];
						if (!isNull (_this # 6)) then {
							if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
								if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
									(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
								} else {
									(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
								};
							};
						};
						missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
						missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
					}
				];
				_turret addEventHandler [
					'Local',
					{
						params ['_entity','_isLocal'];
						if (_isLocal) then {
							_entity removeAllEventHandlers 'Fired';
							_entity addEventHandler [
								'Fired',
								{
									params ['','','','','','','_projectile',''];
									if (!isNull (_this # 6)) then {
										if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells','12rnd_230mm_rockets','32rnd_155mm_mo_shells','4rnd_155mm_mo_guided','2rnd_155mm_mo_lg','magazine_shipcannon_120mm_he_shells_x32','magazine_shipcannon_120mm_he_guided_shells_x2','magazine_shipcannon_120mm_he_lg_shells_x2','magazine_missiles_cruise_01_x18']) then {
											if ((toLowerANSI (_this # 5)) in ['8rnd_82mm_mo_shells']) then {
												(_this # 6) addEventHandler ['Explode',{(_this + [0]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
											} else {
												(_this # 6) addEventHandler ['Explode',{(_this + [1]) spawn (missionNamespace getVariable 'QS_fnc_craterEffect')}];
											};
										};
									};
									missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
									missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
								}
							];
						};
					}
				];
			} forEach _turrets;
		};
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (_worldName isEqualTo 'Altis') then {
		_uavLoiterPosition = [0,3000,500];
		_uavData = [
			[objNull,'b_ugv_01_rcws_f',(AGLToASL [14477,16790.4,0]),43.2471,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [14484.3,16782.7,0]),43.2471,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [14249,16224.1,0]),305.479,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.5,'b_uav_05_f',0.5])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Tanoa') then {
		_uavLoiterPosition = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
		_uavData = [
			[objNull,'b_t_ugv_01_rcws_olive_f',(AGLToASL [6851.85,7436.02,0]),137.086,[],{},TRUE,-1],
			[objNull,'b_t_ugv_01_olive_f',(AGLToASL [6845.19,7443.85,0]),138.766,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [6902.32,7400.82,4.22622]),76.2204,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.5,'b_uav_05_f',0.5])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Malden') then {
		_uavLoiterPosition = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
		_uavData = [
			[objNull,'b_ugv_01_rcws_f',(AGLToASL [8195.94,10101.6,0]),268.097,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [8196.02,10096.1,0]),270.973,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [8108.06,10183.9,0]),267.806,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.5,'b_uav_05_f',0.5])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Enoch') then {
		_uavLoiterPosition = [0,_worldSize + 2000,(500 + (random 500))];
		_uavData = [
			[objNull,'b_ugv_01_rcws_f',(AGLToASL [4287.99,10422.7,0]),134.995,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [4276.89,10433.9,0]),134.995,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [4148.64,10428.8,0]),(random 360),[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.5,'b_uav_05_f',0.5])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};
	if (_worldName isEqualTo 'Stratis') then {
		_uavLoiterPosition = [_worldSize,((_worldSize / 2) + (250 - (random 500))),(500 + (random 500))];
		_uavData = [
			[objNull,'b_ugv_01_rcws_f',(AGLToASL [1910.58,5636.2,0]),196.07,[],{},TRUE,-1],
			[objNull,'b_ugv_01_f',(AGLToASL [1901.76,5638.54,0]),192.739,[],{},TRUE,-1],
			[objNull,'b_t_uav_03_dynamicloadout_f',(AGLToASL [8108.06,10183.9,0]),267.806,[],{},TRUE,_uavRespawnDelay],
			[objNull,(['b_uav_02_dynamicloadout_f',(selectRandomWeighted ['b_uav_02_dynamicloadout_f',0.5,'b_uav_05_f',0.5])] select _isOwnedJets),[100,100,500],0,[],{},TRUE,_uavRespawnDelay]
		];
	};	
};
if (((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isNotEqualTo 0) && {(_uavData isEqualTo [])}) exitWith {};
if (_carrierEnabled) then {
	_uavLoiterPosition = [(((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) # 0) + 300),(((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) # 1) + 300),500];
	// Remove excess Falcon drones when Aircraft Carrier is enabled (only 1 can spawn without more config work).
	private _heliDroneCount = 0;
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isKindOf 'uav_03_base_f') then {
			_heliDroneCount = _heliDroneCount + 1;
			if (_heliDroneCount > 1) then {
				_uavData set [_forEachIndex,0];
			} else {
				_uavData set [_forEachIndex,[_uavEntity,'b_t_uav_03_dynamicloadout_f',((missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [35.0972,150.09,24.5]),((getDir (missionNamespace getVariable 'QS_carrierObject')) - -129.826),_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
			};
		};
	} forEach _uavData;
	_uavData = _uavData select {(_x isEqualType [])};
};
// If player doesnt own Apex DLC, filter out Apex UAVs
if (!(_isOwnedApex)) then {
	_uavData = _uavData select {(!((_x # 1) in ['b_t_uav_03_dynamicloadout_f','b_t_uav_03_f']))};
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isEqualTo 'o_t_uav_04_cas_f') then {
			_uavData set [_forEachIndex,[_uavEntity,'b_uav_02_dynamicloadout_f',_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
		};
	} forEach _uavData;
};
// If player doesnt own Jets DLC, filter out Jets UAVs
if (!(_isOwnedJets)) then {
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (_uavType isEqualTo 'b_uav_05_f') then {
			_uavData set [_forEachIndex,[_uavEntity,'b_uav_02_dynamicloadout_f',_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
		};
	} forEach _uavData;
};
{
	_x params [
		'_uavEntity',
		'_uavType',
		'_uavSpawnPosition',
		'_uavSpawnDirection',
		'_uavSpawnVectors',
		'_uavInitCode',
		'_uavIsRespawning',
		'_uavCanRespawnAfter'
	];
	if ((_uavType isKindOf ['uav_02_base_f',_cfgVehicles]) || {(_uavType isKindOf ['uav_03_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_04_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_05_base_f',_cfgVehicles])}) then {
		_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,TRUE,_uavRespawnDelay]];
	} else {
		_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,TRUE,-1]];
	};
} forEach _uavData;
private _uavElement = [];
private _uiTime = diag_tickTime;
private _ugvRespawnDelay = 30;
private _ugvRespawnFOB = FALSE;
private _operatorAtFOB = FALSE;
_uavRespawnDelay = 300;
_ugvCargoDisable = {
	params ['_parentVehicle','_cargoVehicle'];
	_displayName = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cargoVehicle)],
		{getText ((configOf _cargoVehicle) >> 'displayName')},
		TRUE
	];
	[_cargoVehicle,_displayName] spawn {
		params ['_cargoVehicle','_displayName'];
		waitUntil {
			(cameraOn isNotEqualTo _cargoVehicle)
		};
		deleteVehicleCrew _cargoVehicle;
		_cargoVehicle engineOn FALSE;
		50 cutText [format [localize 'STR_QS_Text_317',_displayName],'PLAIN DOWN',0.75];
	};
};
_ugvCargoEnable = {
	params ['_parentVehicle','_cargoVehicle'];
	createVehicleCrew _cargoVehicle;
};
private _ugvInCargo = FALSE;

_uavInitCodeGeneric = {
	params ['_uavEntity'];
	_grp = createVehicleCrew _uavEntity;
	_grp deleteGroupWhenEmpty TRUE;
	_grp setVariable ['QS_HComm_grp',FALSE,TRUE];
	{
		_x enableAIFeature ['LIGHTS',FALSE];
	} forEach (units _grp);
	_uavEntity setPilotLight FALSE;
	_uavEntity setCollisionLight FALSE;
	_uavEntity enableAIFeature ['LIGHTS',FALSE];
	if (_uavEntity isKindOf 'Plane') then {
		params ['','_loiterPos'];
		_displayName = QS_hashmap_configfile getOrDefaultCall [
			format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _uavEntity)],
			{getText ((configOf _uavEntity) >> 'displayName')},
			TRUE
		];
		_text = format ['%1 %3 %2',_displayName,(mapGridPosition _uavEntity),localize 'STR_QS_Hints_131'];
		(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7,-1,_text,[],-1];
		_uavEntity enableRopeAttach TRUE;
		_uavEntity enableVehicleCargo TRUE;
		[57,_uavEntity] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		[_uavEntity,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_uavEntity setVehicleReportRemoteTargets TRUE;
		_uavEntity engineOn TRUE;
		_uavEntity flyInHeightASL [500,500,500];
		['setFeatureType',_uavEntity,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_uavEntity];
		_uavEntity spawn {
			_uavEntity = _this;
			for '_x' from 0 to 49 step 1 do {
				_uavEntity setVelocity [
					((velocity _uavEntity) # 0),
					((velocity _uavEntity) # 1),
					((((velocity _uavEntity) # 2) max 0) + 5)
				];
				uiSleep 0.05;
			};
		};
		_uavPosition = getPosWorld _uavEntity;
		_uavPosition set [2,500];
		_wp = _grp addWaypoint [_uavPosition,100];
		_wp setWaypointType 'LOITER';
		_uavEntity addEventHandler [
			'Fired',
			{
				params ['','','','','_ammo','','_projectile',''];
				if ((toLowerANSI _ammo) in [
					'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
				]) then {
					missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
					missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
				};
			}
		];
	};
	if ((toLowerANSI (typeOf _uavEntity)) in ['b_t_uav_03_dynamicloadout_f','b_t_uav_03_f']) then {
		_uavEntity setVelocity [0,0,0];
		_uavEntity spawn {
			for '_x' from 0 to 9 step 1 do {
				_this setVectorUp [0,0,1];
				uiSleep 1;
			};
			_this setDamage 0;
		};
		[_uavEntity,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
		_uavEntity removeWeapon 'missiles_SCALPEL';
		['setFeatureType',_uavEntity,2] remoteExec ['QS_fnc_remoteExecCmd',-2,_uavEntity];
		_uavEntity addEventHandler ['Fired',
			{
				params ['_vehicle','','','','','','_projectile',''];
				if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
					deleteVehicle _projectile;
				};
				if (alive (getAttackTarget _vehicle)) then {
					_assignedTarget = getAttackTarget _vehicle;
					if (!isNull (effectiveCommander _assignedTarget)) then {
						if (isPlayer (effectiveCommander _assignedTarget)) then {
							[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				};
			}
		];
	};
	if (_uavEntity isKindOf 'ugv_01_base_f') then {
		_uavEntity addEventHandler ['CargoLoaded',_ugvCargoDisable];
		_uavEntity addEventHandler ['CargoUnloaded',_ugvCargoEnable];
	};
	if ((_uavEntity isKindOf 'ugv_01_base_f') && (!(_uavEntity isKindOf 'ugv_01_rcws_base_f'))) then {
		_uavEntity addBackpackCargoGlobal ['b_uav_06_medical_backpack_f',2];
		_uavEntity enableVehicleCargo TRUE;
		_uavEntity enableRopeAttach TRUE;
		_uavEntity addRating (0 - (rating _uavEntity));
		{
			_x addRating (0 - (rating _x));
		} forEach (crew _uavEntity);
		_uavEntity addEventHandler ['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
		_uavEntity setVariable ['QS_tow_veh',2,TRUE];
		_uavEntity addEventHandler [
			'Deleted',
			{
				params ['_entity'];
				if ((attachedObjects _entity) isNotEqualTo []) then {
					{
						if (isSimpleObject _x) then {
							deleteVehicle _x;
						};
					} forEach (attachedObjects _entity);
				};				
			}
		];
		_uavEntity addEventHandler [
			'Killed',
			{
				params ['_entity'];
				if ((attachedObjects _entity) isNotEqualTo []) then {
					{
						[0,_x] call QS_fnc_eventAttach;
						if (!isPlayer _x) then {
							_x setDamage [1,FALSE];
							deleteVehicle _x;
						};
					} forEach (attachedObjects _entity);
				};
			}
		];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		[1,_stretcher1,[_uavEntity,[0,-0.75,-0.7]]] call QS_fnc_eventAttach;
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		[1,_stretcher2,[_uavEntity,[0.85,-0.75,-0.7]]] call QS_fnc_eventAttach;
	};
	if (_uavEntity isKindOf 'ugv_01_rcws_base_f') then {
		_uavEntity addBackpackCargoGlobal ['b_uav_01_backpack_f',2];
		_uavEntity enableVehicleCargo TRUE;	
		_uavEntity enableRopeAttach TRUE;
		_uavEntity addEventHandler ['Fired',
			{
				params ['_vehicle','','','','','','_projectile',''];
				if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
					deleteVehicle _projectile;
				};
				if (alive (getAttackTarget _vehicle)) then {
					_assignedTarget = getAttackTarget _vehicle;
					if (!isNull (effectiveCommander _assignedTarget)) then {
						if (isPlayer (effectiveCommander _assignedTarget)) then {
							[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						};
					};
				};
			}
		];
		_uavEntity addEventHandler ['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
	};
};
_fn_isPosSafe = {
	params ['_position','_radius'];
	private _return = TRUE;
	_list1 = (_position select [0,2]) nearEntities ['All',_radius];
	if (_list1 isNotEqualTo []) exitWith {FALSE};
	{
		if (!isNull _x) then {
			if (isSimpleObject _x) then {
				if (!(['helipad',((getModelInfo _x) # 1),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
					_return = FALSE;
				};
			};
		};
	} count (nearestObjects [_position,[],_radius,TRUE]);
	_return;
};
_fn_findSafePos = missionNamespace getVariable 'QS_fnc_findSafePos';
private _grp = grpNull;
private _safePos = [0,0,0];
private _inNavalArtillery = FALSE;
private _artilleryEngineEnabled = FALSE;
private _artilleryEngineRestricted = missionNamespace getVariable ['QS_missionConfig_artyEngine',0] in [0,1];
_fn_inZone = missionNamespace getVariable 'QS_fnc_inZone';
_true = TRUE;
_false = FALSE;
for '_i' from 0 to 1 step 0 do {
	uiSleep 1.5;
	_uiTime = diag_tickTime;
	if (_artilleryEngineRestricted) then {
		_inNavalArtillery = ((cameraOn isKindOf 'B_Ship_Gun_01_F') || {(cameraOn isKindOf 'B_Ship_MRLS_01_F')});
		if (_inNavalArtillery) then {
			if (!_artilleryEngineEnabled) then {
				_artilleryEngineEnabled = _true;
				enableEngineArtillery _artilleryEngineEnabled;
			};
		} else {
			if (_artilleryEngineEnabled) then {
				_artilleryEngineEnabled = _false;
				enableEngineArtillery _artilleryEngineEnabled;
			};
		};
	};
	if ((player distance2D (markerPos 'QS_marker_module_fob')) < 300) then {
		if (!(_ugvRespawnFOB)) then {
			_ugvRespawnFOB = _true;
		};
	} else {
		if (_ugvRespawnFOB) then {
			_ugvRespawnFOB = _false;
		};
	};
	{
		_x params [
			'_uavEntity',
			'_uavType',
			'_uavSpawnPosition',
			'_uavSpawnDirection',
			'_uavSpawnVectors',
			'_uavInitCode',
			'_uavIsRespawning',
			'_uavCanRespawnAfter'
		];
		if (!alive _uavEntity) then {
			if (!(_uavIsRespawning)) then {
				_uavCanRespawnAfter = _uiTime + ([_ugvRespawnDelay,_uavRespawnDelay] select (_uavType isKindOf ['Air',_cfgVehicles]));
				if ((_uavType isKindOf ['uav_02_base_f',_cfgVehicles]) || {(_uavType isKindOf ['uav_03_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_04_base_f',_cfgVehicles])} || {(_uavType isKindOf ['uav_05_base_f',_cfgVehicles])}) then {
					_uavIsRespawning = missionNamespace getVariable ['QS_uavCanSpawn',_false];
					uiNamespace setVariable ['QS_uavRespawnDelay',_uavCanRespawnAfter];
				} else {
					_uavIsRespawning = _true;
				};
				_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_uavIsRespawning,_uavCanRespawnAfter]];
			} else {
				if (_uiTime > _uavCanRespawnAfter) then {
					if ([_uavSpawnPosition,4] call _fn_isPosSafe) then {
						if (!isNull _uavEntity) then {
							if ((attachedObjects _uavEntity) isNotEqualTo []) then {
								deleteVehicle (attachedObjects _uavEntity);
							};
							deleteVehicle _uavEntity;
							uiSleep 0.1;
						};
						if (_uavType isKindOf ['Plane',_cfgVehicles]) then {
							// UCav + Greyhawk
							_uavEntity = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _uavType,_uavType],_uavLoiterPosition,[],50,'FLY'];
						} else {
							if ((_ugvRespawnFOB) && (_uavType isKindOf ['ugv_01_base_f',_cfgVehicles]) && ((missionNamespace getVariable ['QS_module_fob_side',sideUnknown]) isEqualTo (player getVariable ['QS_unit_side',WEST]))) then {
								_safePos = [(markerPos 'QS_marker_module_fob'),0,70,5,0,5,0] call _fn_findSafePos;
								_uavEntity = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _uavType,_uavType],_safePos,[],0,'NONE'];
								_uavEntity setDir (random 360);
								_uavEntity enableAIFeature ['LIGHTS',FALSE];
								_uavEntity setVehiclePosition [_safePos,[],0,'NONE'];
							} else {
								_uavEntity = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _uavType,_uavType],(ASLToAGL _uavSpawnPosition),[],0,'NONE'];
								if (_uavSpawnVectors isEqualTo []) then {
									_uavEntity setDir _uavSpawnDirection;
								} else {
									_uavEntity setVectorDirAndUp _uavSpawnVectors;
								};
								_uavEntity enableAIFeature ['LIGHTS',FALSE];
								_uavEntity setPosASL _uavSpawnPosition;
							};
						};
						_uavEntity call _uavInitCodeGeneric;
						if (_uavInitCode isNotEqualTo {}) then {
							_uavEntity call _uavInitCode;
						};
						_uavData set [_forEachIndex,[_uavEntity,_uavType,_uavSpawnPosition,_uavSpawnDirection,_uavSpawnVectors,_uavInitCode,_false,_uavCanRespawnAfter]];
					};
				};
			};
		} else {
			if ((_uavEntity isKindOf 'ugv_01_base_f') && (!(_uavEntity isKindOf 'ugv_01_rcws_base_f'))) then {
				if ((rating _uavEntity) isNotEqualTo 0) then {
					_uavEntity addRating (0 - (rating _uavEntity));
				};
				{
					if ((rating _x) isNotEqualTo 0) then {
						_x addRating (0 - (rating _x));
					};
				} forEach (crew _uavEntity);
			};
			// UAV is still alive, handle various situations
			if (((getPosASL _uavEntity) # 2) < -1.5) then {
				_uavEntity setDamage [1,_false];
			};
			if (_uavEntity isKindOf 'ugv_01_base_f') then {
				if (
					(!isNull (ropeAttachedTo _uavEntity)) ||
					{(!isNull (isVehicleCargo _uavEntity))} ||
					{(!isNull (attachedTo _uavEntity))}
				) then {
					if (!(_uavEntity getVariable ['QS_uav_travelMode',_false])) then {
						if (cameraOn isNotEqualTo _uavEntity) then {
							_uavEntity setVariable ['QS_uav_travelMode',_true];
							if (alive (driver _uavEntity)) then {
								deleteVehicleCrew _uavEntity;
								_displayName = QS_hashmap_configfile getOrDefaultCall [
									format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _uavEntity)],
									{getText ((configOf _uavEntity) >> 'displayName')},
									TRUE
								];
								50 cutText [format [localize 'STR_QS_Text_317',_displayName],'PLAIN DOWN',0.75];
							};
						};
					};
				} else {
					if (_uavEntity getVariable ['QS_uav_travelMode',_false]) then {
						_uavEntity setVariable ['QS_uav_travelMode',_false];
						_grp = createVehicleCrew _uavEntity;
						_grp deleteGroupWhenEmpty _true;
						{
							_x setVariable ['QS_RD_recruitable',TRUE,TRUE];
						} forEach (units _grp);
					};
				};
			};
		};
	} forEach _uavData;
	{
		_uavEntity = _x;
		if (local _uavEntity) then {
			if (!(_uavEntity checkAIFeature 'TEAMSWITCH')) then {
				_uavEntity enableAIFeature ['TEAMSWITCH',_true];
			};
			if ((!isNull (attachedTo _uavEntity)) || {(!isNull (isVehicleCargo _uavEntity))} || {(!isNull (ropeAttachedTo _uavEntity))}) then {
				if (!(_uavEntity getVariable ['QS_uav_disabledAI',_false])) then {
					_uavEntity setVariable ['QS_uav_disabledAI',_true,_false];
					_uavEntity enableAIFeature ['ALL',_false];
					{
						_x enableAIFeature ['ALL',_false];
					} forEach (crew _uavEntity);
				};
			} else {
				if (_uavEntity getVariable ['QS_uav_disabledAI',_false]) then {
					_uavEntity setVariable ['QS_uav_disabledAI',_false,_false];
					_uavEntity enableAIFeature ['ALL',_true];
					{
						_x enableAIFeature ['ALL',_true];
					} forEach (crew _uavEntity);
				};
			};
			if (isLaserOn _uavEntity) then {
				if (!isNull (laserTarget _uavEntity)) then {
					([laserTarget _uavEntity,'SAFE'] call _fn_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
					if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
						deleteVehicle (laserTarget _uavEntity);
					};
				};
			};
			if (alive (driver _uavEntity)) then {
				if (((side (group (driver _uavEntity))) isEqualTo sideEnemy) || {(((side (group (driver _uavEntity))) getFriend WEST) < 0.6)}) then {
					[17,_x] remoteExec ['QS_fnc_remoteExec',2,_false];
				};
			};
			{
				_x setName ['AI','AI','AI'];
			} forEach (crew _uavEntity);
		};
		if (
			(_uavEntity getVariable ['QS_hidden',FALSE]) ||
			((typeOf _uavEntity) in ['b_ship_gun_01_f','b_ship_mrls_01_f'])
		) then {
			player disableUAVConnectability [_uavEntity,TRUE];
			{
				player disableUAVConnectability [_x,TRUE];
			} forEach (crew _uavEntity);
		};
		uiSleep 0.1;
	} count allUnitsUav;
	if (!(player getUnitTrait 'uavhacker')) exitWith {
		{
			if (local _x) then {
				_uavEntity = _x;
				if (!(_uavEntity getVariable ['QS_uav_protected',_false])) then {
					if ((crew _uavEntity) isNotEqualTo []) then {
						//_grp = group (effectiveCommander _uavEntity);
						deleteVehicleCrew _uavEntity;
						//deleteGroup _grp;
					};
					deleteVehicle _uavEntity;
				};
			};
		} forEach allUnitsUav;
	};
};