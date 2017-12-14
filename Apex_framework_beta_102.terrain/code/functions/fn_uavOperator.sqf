/*/
File: fn_uavOperator.sqf
Author:

	Quiksilver
	
Last modified:

	4/12/2017 A3 1.78 by Quiksilver
	
Description:

	UAV Operator
__________________________________________________/*/
scriptName 'QS Script Client UAV';
private [
	'_QS_maxUAVs','_QS_uavTypesAllowed','_QS_spawnedUAVs','_QS_uav','_QS_wp','_nearServiceMarkers','_grp','_QS_ugvType','_QS_ugv','_QS_ugvDir','_QS_ugvPos',
	'_QS_ugvPos2','_QS_ugvDir2','_QS_ugvType2','_QS_ugv2','_crate','_crateType','_QS_camShakeEnabled','_isOwnedApex','_QS_heliDrone',
	'_QS_heliDronePos','_QS_heliDroneDir','_QS_heliDroneType','_firedEvent','_QS_loiterPos','_isOwnedJets','_QS_module_safezone_pos','_isCASWhiteListed','_stretcher1','_stretcher2'
];
private _casEnabled = (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [2]) || (((missionNamespace getVariable ['QS_missionConfig_CAS',2]) in [1,3]) && ((getPlayerUID player) in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist')))));
_QS_module_safezone_pos = markerPos 'QS_marker_base_marker';
_isOwnedApex = 395180 in (getDLCs 1);
_isOwnedJets = 601670 in (getDLCs 1);
_isCASWhiteListed = player getUnitTrait 'QS_trait_cas';
_worldName = worldName;
_worldSize = worldSize;
_QS_maxUAVs = 1;
_QS_uavTypesAllowed = [
	['B_UAV_02_dynamicLoadout_F'],
	['B_UAV_05_F','B_UAV_02_dynamicLoadout_F']
] select _isOwnedJets;
_QS_spawnedUAVs = [];
_QS_ugvType = 'B_UGV_01_rcws_F';
_QS_ugv = objNull;
_QS_ugvPos = [];
_QS_ugvDir = 0;
_QS_ugvType2 = 'B_UGV_01_F';
_QS_ugv2 = objNull;
_QS_ugvPos2 = [];
_QS_ugvDir2 = 0;
_QS_heliDrone = objNull;
_QS_heliDronePos = [];
_QS_heliDroneDir = 0;
_QS_heliDroneType = 'B_T_UAV_03_dynamicLoadout_F';
_crate = objNull;
_crateType = 'B_CargoNet_01_ammo_F';
if (_worldName isEqualTo 'Altis') then {
	_QS_ugvPos = [14477,16790.4,0.0118294];
	_QS_ugvDir = 43.2471;
	_QS_ugvPos2 = [14484.3,16782.7,-0.0841827];
	_QS_ugvDir2 = 43.2471;
	_QS_heliDronePos = [14249,16224.1,0.00148201];
	_QS_heliDroneDir = 305.479;
	_QS_loiterPos = [0,0,0];
};
if (_worldName isEqualTo 'Tanoa') then {
	_QS_ugvPos = [6851.85,7436.02,0.00143886];
	_QS_ugvDir = 137.086;
	_QS_ugvPos2 = [6845.19,7443.85,0.00143886];
	_QS_ugvDir2 = 138.766;
	_QS_heliDronePos = [6902.32,7400.82,4.22622];
	_QS_heliDroneDir = 76.2204;
	_QS_loiterPos = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
};
if (_worldName isEqualTo 'Malden') then {
	_QS_ugvPos = [8195.94,10101.6,0.0110798];
	_QS_ugvDir = 268.097;
	_QS_ugvPos2 = [8196.02,10096.1,0.0110931];
	_QS_ugvDir2 = 270.973;
	_QS_heliDronePos = [8108.06,10183.9,0.00143433];
	_QS_heliDroneDir = 267.806;
	_QS_loiterPos = [((_worldSize / 2) + (250 - (random 500))),0,(500 + (random 500))];
};
private _carrierEnabled = FALSE;
private _QS_carrier_drone1_pos = [0,0,0];
private _QS_carrier_drone1_dir = 0;
private _QS_carrier_drone2_pos = [0,0,0];
private _QS_carrier_drone2_dir = 0;
if (!((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isEqualTo 0)) then {
	_carrierEnabled = TRUE;
	_QS_loiterPos = [((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) select 0),((getPosWorld (missionNamespace getVariable 'QS_carrierObject')) select 1),500];
	_QS_heliDronePos = (missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [35.0972,150.09,24.9952];
	_QS_heliDroneDir = (getDir (missionNamespace getVariable 'QS_carrierObject')) - -129.826;
	_QS_carrier_drone1_pos = (missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-35.5134,22.6885,25.2281];
	_QS_carrier_drone1_dir = (getDir (missionNamespace getVariable 'QS_carrierObject')) - -137.246;
	_QS_carrier_drone2_pos = (missionNamespace getVariable 'QS_carrierObject') modelToWorldWorld [-35.5052,41.71,25.4978];
	_QS_carrier_drone2_dir = (getDir (missionNamespace getVariable 'QS_carrierObject')) - -131.99;
};

_nearServiceMarkers = {
	private ['_c','_uav','_vuav'];
	_uav = _this select 0;
	_vuav = vehicle _uav;
	_c = FALSE;
	_serviceMkrAir = ['QS_marker_veh_fieldservice_04','QS_marker_veh_baseservice_03'];
	_serviceMkrLand = ['QS_marker_veh_baseservice_01','QS_marker_veh_fieldservice_01','QS_marker_veh_fieldservice_02','QS_marker_veh_fieldservice_03'];
	if (_uav isKindOf "Air") then {
		{
			if ((_uav distance (markerPos _x)) < 10) exitWith {
				_c = TRUE;
			};
		} count _serviceMkrAir;
	};
	if (_uav isKindOf 'LandVehicle') then {
		{
			if ((_vuav distance (markerPos _x)) < 10) exitWith {
				_c = TRUE;
			};
		} count _serviceMkrLand;
	};
	_c;
};
_firedEvent = {
	_vehicle = _this select 0;
	if ((_vehicle distance2D (markerPos 'QS_marker_base_marker')) < 500) exitWith {
		deleteVehicle (_this select 6);
	};
	if (!isNull (assignedTarget _vehicle)) then {
		if (alive (assignedTarget _vehicle)) then {
			_assignedTarget = assignedTarget _vehicle;
			if (!isNull (effectiveCommander _assignedTarget)) then {
				if (isPlayer (effectiveCommander _assignedTarget)) then {
					[17,_vehicle] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				};
			};
		};
	};
};
private _text = '';
for '_x' from 0 to 1 step 0 do {
	if (_casEnabled) then {
		if ((count _QS_spawnedUAVs) < _QS_maxUAVs) then {
			if (missionNamespace getVariable ['QS_uavCanSpawn',FALSE]) then {
				missionNamespace setVariable ['QS_uavCanSpawn',FALSE,FALSE];
				_QS_uav = createVehicle [(selectRandom _QS_uavTypesAllowed),_QS_loiterPos,[],0,'FLY'];
				_QS_uav engineOn TRUE;
				_QS_uav setVariable ['QS_ropeAttached',FALSE,TRUE];
				[57,_QS_uav] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				[_QS_uav,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
				_QS_uav setVehicleReportRemoteTargets FALSE;
				createVehicleCrew _QS_uav;
				[72,1,(1 + (count (crew _QS_uav)))] remoteExec ['QS_fnc_remoteExec',2,FALSE];
				_QS_uav flyInHeightASL [750,500,1000];
				_text = format ['A(n) %1 has spawned at grid %2',(getText (configFile >> 'CfgVehicles' >> (typeOf _QS_uav) >> 'displayName')),(mapGridPosition _QS_uav),worldName];
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7,-1,_text,[],-1];
				_grp = group (driver _QS_uav);
				{
					_x disableAI 'AUTOCOMBAT';
					_x disableAI 'COVER';
				} count (units _grp);
				_QS_wp = _grp addWaypoint [_QS_loiterPos,500];
				_QS_wp setWaypointType 'LOITER';
				_QS_uav addEventHandler [
					'Fired',
					{
						params ['_vehicle','_weapon','_muzzle','_mode','_ammo','_magazine','_projectile','_gunner'];
						if ((toLower _ammo) in [
							'bomb_03_f','bomb_04_f','bo_gbu12_lgb','bo_gbu12_lgb_mi10','bo_air_lgb','bo_air_lgb_hidden','bo_mk82','bo_mk82_mi08'
						]) then {
							missionNamespace setVariable ['QS_draw2D_projectiles',((missionNamespace getVariable 'QS_draw2D_projectiles') + [_projectile]),TRUE];
							missionNamespace setVariable ['QS_draw3D_projectiles',((missionNamespace getVariable 'QS_draw3D_projectiles') + [_projectile]),TRUE];
						};
					}
				];
				[_QS_uav] spawn {
					private ['_x','_QS_uav','_s'];
					_QS_uav = _this select 0;
					_s = 150;
					for '_x' from 0 to 24 step 1 do {
						_QS_uav setVelocity [0,_s,5];
						uiSleep 0.01;
					};
				};
				0 = _QS_spawnedUAVs pushBack _QS_uav;
			};
		};
	};
	if ((isNull _QS_ugv) || {(!alive _QS_ugv)}) then {
		if (!isNull _QS_ugv) then {
			[17,_QS_ugv] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
		if (_QS_ugvPos isEqualTo []) exitWith {};
		_QS_ugv = createVehicle [_QS_ugvType,_QS_ugvPos,[],0,'NONE'];
		_QS_ugv setDir _QS_ugvDir;
		_QS_ugv setVariable ['QS_ropeAttached',FALSE,TRUE];
		_QS_ugv enableVehicleCargo TRUE;
		createVehicleCrew _QS_ugv;
		[72,1,(1 + (count (crew _QS_ugv)))] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		_QS_ugv addEventHandler ['Fired',_firedEvent];
		_QS_ugv addEventHandler ['HandleDamage',{_this call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
		_QS_ugv addBackpackCargoGlobal ['B_UAV_01_backpack_F',2];
	} else {
		if (((getPosASL _QS_ugv) select 2) < -1.5) then {
			[17,_QS_ugv] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};
	if ((isNull _QS_ugv2) || {(!alive _QS_ugv2)}) then {
		if (!isNull _QS_ugv2) then {
			[17,_QS_ugv2] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
		if (_QS_ugvPos2 isEqualTo []) exitWith {};
		_QS_ugv2 = createVehicle [_QS_ugvType2,_QS_ugvPos2,[],0,'NONE'];
		_QS_ugv2 setDir _QS_ugvDir2;
		_QS_ugv2 enableVehicleCargo TRUE;
		_QS_ugv2 setVariable ['QS_ropeAttached',FALSE,TRUE];
		_QS_ugv2 setVariable ['QS_tow_veh',2,TRUE];
		createVehicleCrew _QS_ugv2;
		[72,1,(1 + (count (crew _QS_ugv2)))] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		_QS_ugv2 addEventHandler ['HandleDamage',{_this call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandleDamage')}];
		_QS_ugv2 addBackpackCargoGlobal ['B_UAV_01_backpack_F',2];
		_QS_ugv2 addEventHandler [
			'Killed',
			{
				_killed = _this select 0;
				if (!((attachedObjects _killed) isEqualTo [])) then {
					{
						0 = [72,0,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						deleteVehicle _x;
					} forEach (attachedObjects _killed);
				};
			}
		];
		_QS_ugv2 addEventHandler [
			'Deleted',
			{
				_deleted = _this select 0;
				if (!((attachedObjects _killed) isEqualTo [])) then {
					{
						0 = [72,0,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
						deleteVehicle _x;
					} forEach (attachedObjects _deleted);
				};				
			}
		];
		_stretcher1 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher1 attachTo [_QS_ugv2,[0,-0.75,-0.7]];
		_stretcher2 = createSimpleObject ['a3\props_f_orange\humanitarian\camps\stretcher_01_f.p3d',[0,0,0]];
		_stretcher2 attachTo [_QS_ugv2,[0.85,-0.75,-0.7]];
	} else {
		if (((getPosASL _QS_ugv2) select 2) < -1.5) then {
			deleteVehicle _QS_ugv2;
			[72,0,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		};
	};

	if (missionNamespace getVariable 'QS_armedAirEnabled') then {
		if (_isOwnedApex) then {
			if (missionNamespace getVariable ['QS_drone_heli_enabled',FALSE]) then {
				if ((isNull _QS_heliDrone) || {(!alive _QS_heliDrone)}) then {
					if (!isNull _QS_heliDrone) then {
						[17,_QS_heliDrone] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
					missionNamespace setVariable ['QS_drone_heli_spawned',TRUE,TRUE];
					if (_QS_heliDronePos isEqualTo []) exitWith {};
					if (_carrierEnabled) then {
						_QS_heliDrone = createVehicle [_QS_heliDroneType,[-500,-500,50],[],0,'NONE'];
						_QS_heliDrone setDir _QS_heliDroneDir;
						_QS_heliDrone setPosWorld _QS_heliDronePos;
						_QS_heliDrone setVelocity [0,0,0];
					} else {
						_QS_heliDrone = createVehicle [_QS_heliDroneType,_QS_heliDronePos,[],0,'NONE'];
						_QS_heliDrone setDir _QS_heliDroneDir;
					};
					_QS_heliDrone setVariable ['QS_ropeAttached',FALSE,TRUE];
					_QS_heliDrone removeWeapon 'missiles_SCALPEL';
					comment '_QS_heliDrone flyInHeightASL [500,100,750];';
					_QS_heliDrone addEventHandler ['Fired',_firedEvent];
					[_QS_heliDrone,1,[]] call (missionNamespace getVariable 'QS_fnc_vehicleLoadouts');
					createVehicleCrew _QS_heliDrone;
					[72,1,(1 + (count (crew _QS_heliDrone)))] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					_grp = group (effectiveCommander _QS_heliDrone);
					{
						_x setSkill 0.5;
						_x disableAI 'AUTOCOMBAT';
						_x disableAI 'COVER';
					} count (units _grp);
				} else {
					if (((getPosASL _QS_heliDrone) select 2) < -1.5) then {
						deleteVehicle _QS_heliDrone;
						[72,0,1] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					};
				};
			};
		};
	};
	{
		if (local _x) then {
			if (((side _x) isEqualTo sideEnemy) || {(((side _x) getFriend WEST) < 0.6)}) then {
				[17,_x] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			};
			if (!isNull (laserTarget _x)) then {
				_QS_laserTarget = laserTarget _x;
				if ((_QS_laserTarget distance2D _QS_module_safezone_pos) < 500) then {
					deleteVehicle _QS_laserTarget;
				};
			};
			
		};
	} count allUnitsUav;
	uiSleep 10;
};