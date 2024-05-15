/*/
File: fn_deployAsset.sqf
Author:
	
	Quiksilver
	
Last Modified:

	25/04/2023 A3 2.12 by Quiksilver
	
Description:

	Manage deployed assets
__________________________________________/*/

params ['_entity','_state',['_profileName','Unknown Soldier'],'_clientOwner',['_faction',sideUnknown],['_currentCooldown',0]];
QS_system_vehicleRallyPoints = QS_system_vehicleRallyPoints select {(alive (_x # 0))};
missionNamespace setVariable ['QS_system_builtThings',QS_system_builtThings select {!isNull _x},TRUE];			// To do: optimize this
if (_state isEqualTo -1) exitWith {
	if (!isNull _entity) then {
		_deploy_handlers = _entity getVariable ['QS_deploy_handlers',[]];
		{
			_entity removeEventHandler _x;
		} forEach _deploy_handlers;
		_entity setVariable ['QS_deploy_handlers',[],FALSE];
		if ((_entity getVariable ['QS_deploy_marker','']) isNotEqualTo '') then {
			deleteMarker (_entity getVariable ['QS_deploy_marker','']);
			_entity setVariable ['QS_deploy_marker','',FALSE];
		};
		_index = QS_logistics_deployedAssets findIf {_entity isEqualTo (_x # 0)};
		_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
		if (_index isNotEqualTo -1) then {
			_assets = (QS_logistics_deployedAssets # _index) # 1;
			if (_assets isNotEqualTo []) then {
				{
					if (_x isEqualType objNull) then {
						_x removeAllEventHandlers 'Deleted';
						deleteVehicle _x;
					};
				} forEach _assets;
				QS_system_builtObjects = QS_system_builtObjects select {!isNull _x};
			};
			_systems_id = (QS_logistics_deployedAssets # _index) # 2;
			if (_systems_id isNotEqualTo '') then {
				['REMOVE',_systems_id] call QS_fnc_zoneManager;
				['REMOVE',_systems_id] call QS_fnc_deployment;
			};
			QS_logistics_deployedAssets deleteAt _index;
		};
		QS_logistics_deployedAssets = QS_logistics_deployedAssets select {alive (_x # 0)};
		if (_vIndex isNotEqualTo -1) then {
			_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
			_element set [0,objNull];
			_element set [18,FALSE];
			(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
		};
	};
};
// Pack up
if (_state isEqualTo 0) exitWith {
	if (!isNull _entity) then {
		_deploy_handlers = _entity getVariable ['QS_deploy_handlers',[]];
		if (_deploy_handlers isNotEqualTo []) then {
			private _displayName = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',(toLowerANSI (typeOf _entity))],
				{getText ((configOf _entity) >> 'displayName')},
				TRUE
			];
			_displayName = _entity getVariable ['QS_ST_customDN',_displayName];
			{
				_entity removeEventHandler _x;
			} forEach _deploy_handlers;
			private _deployParams = _entity getVariable ['QS_logistics_deployParams',[30,30,30,30,100,30,500]];
			_deployParams params [
				'_deploySafeRadius',
				'_deployCooldown',
				'_packSafeRadius',
				'_packCooldown',
				'_safeDistance',
				'_buildRadius',
				['_deployRestrictedZoneDistance',100]
			];
			_entity setVariable ['QS_deploy_handlers',[],FALSE];
			if ((_entity getVariable ['QS_deploy_marker','']) isNotEqualTo '') then {
				deleteMarker (_entity getVariable ['QS_deploy_marker','']);
				_entity setVariable ['QS_deploy_marker','',FALSE];
			};
			_entity setVariable ['QS_logistics_deployed',FALSE,TRUE];
			(format [localize 'STR_QS_Text_413',_displayName,_profileName]) remoteExec ['systemChat',-2];
			_index = QS_logistics_deployedAssets findIf {_entity isEqualTo (_x # 0)};
			_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
			_preset = _entity getVariable ['QS_deploy_preset',-1];
			_entity = [_entity,FALSE,_preset] call QS_fnc_deployAssetPreset;
			if (_index isNotEqualTo -1) then {
				_assets = (QS_logistics_deployedAssets # _index) # 1;
				if (_assets isNotEqualTo []) then {
					deleteVehicle _assets;
					QS_system_builtObjects = QS_system_builtObjects select {!isNull _x};
				};
				_systems_id = (QS_logistics_deployedAssets # _index) # 2;
				if (_systems_id isNotEqualTo '') then {
					['REMOVE',_systems_id] call QS_fnc_zoneManager;
					['REMOVE',_systems_id] call QS_fnc_deployment;
				};
				QS_logistics_deployedAssets deleteAt _index;
			};
			QS_logistics_deployedAssets = QS_logistics_deployedAssets select {alive (_x # 0)};
			{
				_entity setVariable _x;
			} forEach [
				['QS_logistics_deployParams',_deployParams,TRUE],
				['QS_logistics_deployCooldown',serverTime + _deployCooldown,TRUE],
				['QS_logistics_packCooldown',serverTime + _packCooldown,TRUE],
				['QS_logistics_deployable',TRUE,TRUE],
				['QS_deploy_preset',_preset,FALSE]
			];
			if (_vIndex isNotEqualTo -1) then {
				_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
				_element set [0,_entity];
				_element set [18,FALSE];
				(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
			};
		};
	};
};
// Deploy
if (_state isEqualTo 1) exitWith {
	if (
		(alive _entity) &&
		(
			(!([_entity,50,8] call QS_fnc_waterInRadius)) ||
			(_entity getVariable ['QS_logistics_deployNearWater',FALSE])
		)
	) then {
		if ((_entity getVariable ['QS_deploy_handlers',[]]) isEqualTo []) then {
			_timeout = diag_tickTime + 3;
			waitUntil {
				((_entity setOwner 2) || (diag_tickTime > _timeout))
			};
			_vIndex = (serverNamespace getVariable 'QS_v_Monitor') findIf { _entity isEqualTo (_x # 0) };
			private _deployParams = _entity getVariable ['QS_logistics_deployParams',[30,30,30,30,100,30,500]];
			_deployParams params [
				'_deploySafeRadius',
				'_deployCooldown',
				'_packSafeRadius',
				'_packCooldown',
				'_safeDistance',
				'_buildRadius',
				['_deployRestrictedZoneDistance',100]
			];
			_preset = _entity getVariable ['QS_deploy_preset',-1];
			if (_preset isEqualTo -1) then {
				QS_logistics_deployedAssets pushBackUnique [_entity,[],''];
			} else {
				_entity = [_entity,TRUE,_preset] call QS_fnc_deployAssetPreset;
			};
			if (isEngineOn _entity) then {
				[_entity,FALSE] remoteExec ['engineOn',_entity,FALSE];
			};
			private _displayName = QS_hashmap_configfile getOrDefaultCall [
				format ['cfgvehicles_%1_displayname',(toLowerANSI (typeOf _entity))],
				{getText ((configOf _entity) >> 'displayName')},
				TRUE
			];
			// I dont like these markers very much ...
			// To Do: Improve these markers
			_displayName = _entity getVariable ['QS_ST_customDN',_displayName];
			_marker = createMarker [str systemTime,_entity];
			_marker setMarkerTypeLocal 'mil_dot';
			_marker setMarkerShapeLocal 'Icon';
			_marker setMarkerColorLocal 'ColorBlack';
			_marker setMarkerSizeLocal [0.5,0.5];
			_marker setMarkerTextLocal (format ['%1',_displayName]);
			_marker setMarkerAlpha 0.35;
			private _deploy_handlers = [];
			{
				_deploy_handlers pushBack [_x # 0,_entity addEventHandler _x];
			} forEach [
				[
					'Deleted',
					{
						params ['_entity'];
						_marker = _entity getVariable ['QS_deploy_marker',''];
						if (_marker isNotEqualTo '') then {
							deleteMarker _marker;
						};
						[_entity,-1,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
					}
				],
				[
					'Killed',
					{
						params ['_entity'];
						_entity removeAllEventHandlers 'Deleted';
						[_entity,-1,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
						if (!simulationEnabled _entity) then {
							_entity enableSimulationGlobal TRUE;
						};
					}
				],
				[
					'Engine',
					{
						params ['_entity','_engineState'];
						if (_engineState) then {
							if (!unitIsUav _entity) then {
								[_entity,0,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
							};
						};
					}
				],
				[
					'Local',
					{
						params ['_entity','_isLocal'];
						if (!_isLocal) then {
							if (!unitIsUav _entity) then {
								[_entity,0,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
							};
						};
					}
				],
				[
					'CargoLoaded',
					{
						params ['_parent','_child'];
						if (_child getVariable ['QS_logistics_deployed',FALSE]) then {
							[_child,0,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
						};
					}
				],
				[
					'RopeAttach',
					{
						params ['_entity','_rope','_entity2'];
						(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
						if (_entity getVariable ['QS_logistics_deployed',FALSE]) then {
							[_entity,0,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
						};
						if (_entity2 getVariable ['QS_logistics_deployed',FALSE]) then {
							[_entity2,0,(_entity getVariable ['QS_deploy_profilename',''])] call QS_fnc_deployAsset;
						};
					}
				]
			];
			(missionNamespace getVariable ['QS_missionConfig_deploymentMissionParams',[]]) params [
				'',
				'',
				'',
				'',
				['_deploymentMissionSetupTime',60]
			];
			{
				_entity setVariable _x;
			} forEach [
				['QS_logistics_deployParams',_deployParams,TRUE],
				['QS_logistics_deployable',TRUE,TRUE],
				['QS_logistics_deployCooldown',serverTime + _deployCooldown,TRUE],
				['QS_logistics_packCooldown',serverTime + _packCooldown,TRUE],
				['QS_deploy_preset',_preset,FALSE],
				['QS_logistics_deployed',TRUE,TRUE],
				['QS_deploy_handlers',_deploy_handlers,FALSE],
				['QS_deploy_marker',_marker,FALSE],
				['QS_deploy_markerText',markerText _marker,FALSE],
				['QS_deploy_profilename',_profileName,FALSE],
				['QS_deploy_side',_faction,TRUE],
				['QS_deploy_enemySides',(_faction call QS_fnc_enemySides),FALSE],
				['QS_deploy_enemyState',10,FALSE],
				['QS_deploy_systemTime',systemTime,FALSE],
				['QS_deploy_graceTime',diag_tickTime + _deploymentMissionSetupTime,FALSE]
			];
			(format [localize 'STR_QS_Text_414',_displayName,_profileName]) remoteExec ['systemChat',-2];
			if (_vIndex isNotEqualTo -1) then {
				_element = (serverNamespace getVariable 'QS_v_Monitor') # _vIndex;
				_element set [0,_entity];
				_element set [18,TRUE];
				_element set [19,[getPosASL _entity,[vectorDir _entity,vectorUp _entity]]];
				(serverNamespace getVariable 'QS_v_Monitor') set [_vIndex,_element];
			} else {
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
					FALSE,
					TRUE,
					[getPosASL _entity,[vectorDir _entity,vectorUp _entity]],
					[FALSE,'','',''],
					0,
					{FALSE}
				];
			};
			QS_logistics_deployedAssets = QS_logistics_deployedAssets select {(alive (_x # 0))};
		};
	};
};