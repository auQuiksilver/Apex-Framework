/*
File: fn_clientMenuActionContext.sqf
Author:
	
	Quiksilver
	
Last Modified:

	11/10/2023 A3 2.14 by Quiksilver

Description:

	Extended Context Menu
_____________________________________*/

params ['_mode'];
if (_mode isEqualTo 'CONDITION') exitWith {
	TRUE
};
if (
	(_mode isEqualTo 'IN') &&
	{((lifeState QS_player) in ['HEALTHY','INJURED'])} &&
	{(['CONDITION'] call QS_fnc_clientMenuActionContext)}
) exitWith {
	if (!(missionNamespace getVariable ['QS_menu_extendedContext',FALSE])) then {
		missionNamespace setVariable ['QS_menu_extendedContext',TRUE,FALSE];
		if (isNil 'QS_interactions_extendedContext') then {
			QS_interactions_extendedContext = [];
		};
		if (QS_interactions_extendedContext isNotEqualTo []) then {
			{
				(_x # 0) removeAction (_x # 1);
			} forEach QS_interactions_extendedContext;
			QS_interactions_extendedContext = [];
		};
		getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
		QS_extendedContext_cursorObject = _cursorObject;
		QS_extendedContext_objectParent = objectParent QS_player;
		QS_extendedContext_cursorDistance = _cursorDistance;
		//comment "VEHICLE LOCKING";
		private _lockedDrivers = localNamespace getVariable ['QS_client_lockedDrivers',[]] select { (alive _x) };
		private _lockedCargos = localNamespace getVariable ['QS_client_lockedLogistics',[]] select { (alive _x) };
		private _groupLocking = missionNamespace getVariable ['QS_missionConfig_vehicleGroupLock',FALSE];
		if (
			((missionNamespace getVariable ['QS_missionConfig_seatLocking',1]) > 0) &&
			(
				(
					((['LandVehicle','Air','Ship'] findIf { QS_extendedContext_cursorObject isKindOf _x }) isNotEqualTo -1) &&
					{(_cursorDistance < 5)} &&
					{
						(local QS_extendedContext_cursorObject) ||
						{((QS_extendedContext_cursorObject getVariable ['QS_vehicle_locker',-1]) isEqualTo clientOwner)} ||
						{_groupLocking && (QS_extendedContext_cursorObject in (assignedVehicles (group QS_player)))}
					} &&
					{(!(QS_extendedContext_cursorObject getVariable ['QS_commander_locked',FALSE]))} &&
					{(alive QS_extendedContext_cursorObject)} &&
					{(!(QS_extendedContext_cursorObject getVariable ['QS_logistics_wreck',FALSE]))} &&
					{(isNull QS_extendedContext_objectParent)} &&
					{(QS_extendedContext_cursorDistance < 3)} &&
					{((lifeState QS_player) in ['HEALTHY','INJURED'])}
				) ||
				(_lockedDrivers isNotEqualTo [])
			)
		) then {
			//comment "DRIVER SEAT LOCKING";
			if ((missionNamespace getVariable ['QS_missionConfig_seatLocking',1]) > 0) then {
				QS_extendedContext_lockedDriver = QS_extendedContext_cursorObject;
				if (_lockedDrivers isNotEqualTo []) then {
					QS_extendedContext_lockedDriver = _lockedDrivers # 0;
				};
				QS_action_vehicleLock1 = QS_player addAction [
					([localize 'STR_QS_Text_390',localize 'STR_QS_Text_391'] select (lockedDriver QS_extendedContext_lockedDriver)),
					{
						_dn = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf QS_extendedContext_lockedDriver)],
							{getText ((configOf QS_extendedContext_lockedDriver) >> 'displayName')},
							TRUE
						];
						_dn2 = QS_extendedContext_lockedDriver getVariable ['QS_ST_customDN',_dn];
						if (alive (driver QS_extendedContext_lockedDriver)) exitWith {
							50 cutText [format ['%1 ( %2 )',localize 'STR_QS_Text_392',_dn2],'PLAIN DOWN',0.333];
						};
						if (lockedDriver QS_extendedContext_lockedDriver) then {
							_index = (localNamespace getVariable ['QS_client_lockedDrivers',[]]) find QS_extendedContext_lockedDriver;
							if (_index isNotEqualTo -1) then {
								(localNamespace getVariable ['QS_client_lockedDrivers',[]]) deleteAt _index;
							};
							QS_player playActionNow 'PutDown';
							['lockDriver',QS_extendedContext_lockedDriver,FALSE] remoteExec ['QS_fnc_remoteExecCmd',QS_extendedContext_lockedDriver,FALSE];
							50 cutText [format ['%1 ( %2 )',localize 'STR_QS_Text_393',_dn2],'PLAIN',0.333];
						} else {
							localNamespace setVariable ['QS_client_lockedDrivers',((localNamespace getVariable ['QS_client_lockedDrivers',[]]) select {
								(
									(lockedDriver _x) &&
									((_x getVariable ['QS_vehicle_locker',-1]) isEqualTo clientOwner)
								)
							})];
							if ((count (localNamespace getVariable ['QS_client_lockedDrivers',[]])) >= 1) then {
								50 cutText [format [localize 'STR_QS_Text_404',_dn2],'PLAIN DOWN',0.5];
							} else {
								QS_player playActionNow 'PutDown';
								(localNamespace getVariable ['QS_client_lockedDrivers',[]]) pushBack QS_extendedContext_lockedDriver;
								QS_extendedContext_lockedDriver setVariable ['QS_vehicle_locker',clientOwner,TRUE];
								['lockDriver',QS_extendedContext_lockedDriver,TRUE] remoteExec ['QS_fnc_remoteExecCmd',QS_extendedContext_lockedDriver,FALSE];
								50 cutText [format ['%1 ( %2 )',localize 'STR_QS_Text_394',_dn2],'PLAIN',0.333];
							};
						};
						['OUT'] call QS_fnc_clientMenuActionContext;
					}
				];
				QS_interactions_extendedContext pushBack [QS_player,QS_action_vehicleLock1];
			};
		};
		if (
			((missionNamespace getVariable ['QS_missionConfig_cargoLocking',1]) > 0) &&
			(
				(
					((['LandVehicle','Air','Ship'] findIf { QS_extendedContext_cursorObject isKindOf _x }) isNotEqualTo -1) &&
					{(_cursorDistance < 5)} &&
					{
						(local QS_extendedContext_cursorObject) ||
						{((QS_extendedContext_cursorObject getVariable ['QS_vehicle_cargolocker',-1]) isEqualTo clientOwner)} ||
						{_groupLocking && (QS_extendedContext_cursorObject in (assignedVehicles (group QS_player)))}
					} &&
					{(alive QS_extendedContext_cursorObject)} &&
					{(!(QS_extendedContext_cursorObject getVariable ['QS_logistics_wreck',FALSE]))} &&
					{(isNull QS_extendedContext_objectParent)} &&
					{(QS_extendedContext_cursorDistance < 3)} &&
					{((lifeState QS_player) in ['HEALTHY','INJURED'])}
				) ||
				(_lockedCargos isNotEqualTo [])
			)
		) then {
			//comment "INVENTORY/CARGO LOCKING";
			if ((missionNamespace getVariable ['QS_missionConfig_cargoLocking',1]) > 0) then {
				QS_extendedContext_lockedCargo = QS_extendedContext_cursorObject;
				if (_lockedCargos isNotEqualTo []) then {
					QS_extendedContext_lockedCargo = _lockedCargos # 0;
				};
				QS_action_vehicleLock2 = QS_player addAction [
					([localize 'STR_QS_Text_395',localize 'STR_QS_Text_396'] select (lockedInventory QS_extendedContext_lockedCargo)),
					{
						_dn = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf QS_extendedContext_lockedCargo)],
							{getText ((configOf QS_extendedContext_lockedCargo) >> 'displayName')},
							TRUE
						];
						_dn2 = QS_extendedContext_lockedCargo getVariable ['QS_ST_customDN',_dn];
						if (lockedInventory QS_extendedContext_lockedCargo) then {
							_index = (localNamespace getVariable ['QS_client_lockedLogistics',[]]) find QS_extendedContext_lockedCargo;
							if (_index isNotEqualTo -1) then {
								(localNamespace getVariable ['QS_client_lockedLogistics',[]]) deleteAt _index;
							};
							QS_player playActionNow 'PutDown';
							QS_extendedContext_lockedCargo setVariable ['QS_lockedInventory',FALSE,TRUE];
							[110,QS_extendedContext_lockedCargo,TRUE] remoteExec ['QS_fnc_remoteExec',0,FALSE];
							50 cutText [format ['%1 ( %2 )',localize 'STR_QS_Text_397',_dn2],'PLAIN',0.333];
						} else {
							localNamespace setVariable ['QS_client_lockedLogistics',((localNamespace getVariable ['QS_client_lockedLogistics',[]]) select {
								(
									(lockedInventory _x) &&
									((_x getVariable ['QS_vehicle_cargolocker',-1]) isEqualTo clientOwner)
								)
							})];							
							if ((count (localNamespace getVariable ['QS_client_lockedLogistics',[]])) >= 1) then {
								50 cutText [format [localize 'STR_QS_Text_404',_dn2],'PLAIN DOWN',0.5];
							} else {
								QS_player playActionNow 'PutDown';
								(localNamespace getVariable ['QS_client_lockedLogistics',[]]) pushBack QS_extendedContext_lockedCargo;
								QS_extendedContext_lockedCargo setVariable ['QS_lockedInventory',TRUE,TRUE];
								QS_extendedContext_lockedCargo setVariable ['QS_vehicle_cargolocker',clientOwner,TRUE];
								[110,QS_extendedContext_lockedCargo,FALSE] remoteExec ['QS_fnc_remoteExec',0,FALSE];
								50 cutText [format ['%1 ( %2 )',localize 'STR_QS_Text_398',_dn2],'PLAIN',0.333];
							};
						};
						['OUT'] call QS_fnc_clientMenuActionContext;
					}
				];
				QS_interactions_extendedContext pushBack [QS_player,QS_action_vehicleLock2];
			};
		};
		
		if (
			((missionNamespace getVariable ['QS_missionConfig_quickBuild',0]) isNotEqualTo 0) &&
			{(isNull QS_extendedContext_objectParent)} &&
			{(((vectorMagnitude (velocity QS_player)) * 3.6) < 16)} &&
			{(!(missionNamespace getVariable ['QS_targetBoundingBox_placementMode',FALSE]))}
		) then {
			QS_action_playerBuildables = QS_player addAction [localize 'STR_QS_Interact_129',{
					(QS_player getVariable ['QS_inzone',[]]) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
					if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) exitWith {
						50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
					};
					([QS_player,'NO_BUILD'] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
					if (_inBuildRestrictedZone && _zoneActive && (_zoneLevel > 1)) exitWith {
						50 cutText [localize 'STR_QS_Text_403','PLAIN DOWN',0.5];
					};
					(findDisplay 46) createDisplay 'QS_RD_client_dialog_menu_playerBuild';
			}];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_playerBuildables];
			QS_action_deleteBuildable = QS_player addAction [localize 'STR_QS_Interact_130',{
				getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
				if ((['QS_trait_rifleman','engineer'] findIf { QS_player getUnitTrait _x }) isEqualTo -1) then {
					50 cutText [localize 'STR_QS_Text_461','PLAIN DOWN',0.333];
				};
				if (!isNull _cursorObject) then {
					if (_cursorObject in QS_list_playerBuildables) then {
						_radius = (0 boundingBoxReal _cursorObject) # 2;
						_nearUnits = allPlayers - [QS_player];
						if ((_nearUnits inAreaArray [_cursorObject,_radius * 2,_radius * 2,0,FALSE]) isEqualTo []) then {
							QS_player playActionNow 'PutDown';
							deleteVehicle _cursorObject;
						} else {
							50 cutText [localize 'STR_QS_Text_399','PLAIN',0.5,TRUE];
						};
					};
				};
			},nil,-97,FALSE,TRUE,'','
				getCursorObjectParams params ["_cursorObject","_cursorSelections","_cursorDistance"];
				(((!isNull _cursorObject) && {(_cursorObject in QS_list_playerBuildables)}) && (_cursorDistance < (((0 boundingBoxReal _cursorObject) # 2) * 2)))
			'];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_deleteBuildable];
		};
		([QS_player,['NO_BUILD','SAFE']] call QS_fnc_inZone) params ['_inBuildRestrictedZone','_zoneLevel','_zoneActive'];
		if (
			(alive _cursorObject) &&
			{(_cursorDistance < 10)} &&
			{(_cursorObject getVariable ['QS_logistics_deployable',FALSE])} &&
			{!(_inBuildRestrictedZone && _zoneActive && (_zoneLevel > 1))}
		) then {
			QS_action_deployAsset = QS_player addAction [
				[localize 'STR_QS_Interact_133',localize 'STR_QS_Interact_134'] select (_cursorObject getVariable ['QS_logistics_deployed',FALSE]),
				{
					[([1,0] select (QS_extendedContext_cursorObject getVariable ['QS_logistics_deployed',FALSE]))] spawn QS_fnc_clientInteractDeployAsset;
				},
				nil,
				-1,
				FALSE,
				TRUE,
				'',
				'call QS_fnc_conditionDeployAsset'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_deployAsset];
		};
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(alive _cursorObject)} &&
			{(_cursorDistance < 5)} &&
			{(( ['LandVehicle','Air','Ship'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
			{(
				(( { alive _x } count (crew _cursorObject)) isEqualTo 0) || 
				{ ((side (group (effectiveCommander _cursorObject))) isEqualTo (QS_player getVariable ['QS_unit_side',WEST])) }
			)}
		) then {
			QS_action_vehicleHealth = QS_player addAction [
				localize 'STR_QS_Interact_135',
				{
					call QS_fnc_clientInteractVehicleHealth
				},
				nil,
				-1,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","_cursorSelections","_cursorDistance"];
					(_cursorObject isEqualTo QS_extendedContext_cursorObject)
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_vehicleHealth];
		};
		// Cargo Manifest
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(alive _cursorObject)} &&
			{(_cursorDistance < 5)} &&
			{(( ['LandVehicle','Air','Ship'] findIf { _cursorObject isKindOf _x }) isNotEqualTo -1)} &&
			{(
				(( { alive _x } count (crew _cursorObject)) isEqualTo 0) || 
				{ ((side (group (effectiveCommander _cursorObject))) isEqualTo (QS_player getVariable ['QS_unit_side',WEST])) }
			)} &&
			{(!(_cursorObject getVariable ['QS_logistics_wreck',FALSE]))}
		) then {
			QS_action_cargoManifest = QS_player addAction [
				localize 'STR_QS_Interact_136',
				{
					call QS_fnc_clientInteractCargoManifest
				},
				nil,
				-1,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","_cursorSelections","_cursorDistance"];
					(_cursorObject isEqualTo QS_extendedContext_cursorObject)
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_cargoManifest];
		};
		// AI turret toggle
		if (
			(
				(alive _cursorObject) &&
				{(simulationEnabled _cursorObject)} &&
				{(_cursorDistance < 5)} &&
				{(unitIsUav _cursorObject)} &&
				{(!(_cursorObject getVariable ['QS_uav_disabled',FALSE]))} &&
				{(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE])}
			) ||
			{(
				(!isNull (objectParent QS_player)) &&
				{(([objectParent QS_player] call QS_fnc_turretsAttached) isNotEqualTo [])}
			)}
		) then {
			QS_action_turretToggle = QS_player addAction [
				'',
				{
					call QS_fnc_clientInteractTurretToggle
				},
				nil,
				-25,
				FALSE,
				TRUE,
				'',
				'call QS_fnc_conditionTurretToggle'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_turretToggle];
		};
		// AI turret remote control
		if (
			(alive _cursorObject) &&
			{(_cursorDistance < 5)} &&
			{(simulationEnabled _cursorObject)} &&
			{(unitIsUav _cursorObject)} &&
			{(!(_cursorObject getVariable ['QS_uav_disabled',FALSE]))} &&
			{(_cursorObject getVariable ['QS_uav_toggleEnabled',TRUE])} &&
			{((crew _cursorObject) isNotEqualTo [])} &&
			{(!isRemoteControlling QS_player)} &&
			{(cameraOn isEqualTo player)} &&
			{((!(_cursorObject isKindOf 'Air')) || ((_cursorObject isKindOf 'Air') && (QS_player getUnitTrait 'uavhacker'))) } &&
			{((side (effectiveCommander _cursorObject)) isEqualTo (QS_player getVariable ['QS_unit_side',WEST]))}
		) then {
			QS_action_turretTakeControl = QS_player addAction [
				localize '$STR_USERACT_UAV_TAKECONTROLS',
				{
					getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
					if (
						(_cursorObject isEqualTo QS_extendedContext_cursorObject) && 
						{(_cursorDistance < 5)} &&
						{(!isUAVConnected _cursorObject)} &&
						{(isNull (remoteControlled _cursorObject))} &&
						{(!alive (_cursorObject getVariable ['bis_fnc_moduleRemoteControl_owner',objNull]))}
					) then {
						QS_player playActionNow 'PutDown';
						50 cutText [localize 'STR_QS_Text_465','PLAIN DOWN',0.333];
						[_cursorObject,FALSE,FALSE] spawn QS_fnc_remoteControl;
					} else {
						if (
							(isUAVConnected _cursorObject) ||
							(!isNull (remoteControlled _cursorObject))
						) then {
							systemChat (localize 'STR_QS_Text_466');
						};
						if (alive (_cursorObject getVariable ['bis_fnc_moduleRemoteControl_owner',objNull])) then {
							systemChat (localize 'STR_QS_Text_466');
						};
					};
				},
				nil,
				-25,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","_cursorSelections","_cursorDistance"];
					((_cursorObject isEqualTo QS_extendedContext_cursorObject) && (_cursorDistance < 5))
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_turretTakeControl];
		};
		// UAV self destruct
		if (
			(alive _cursorObject) &&
			{(local _cursorObject)} &&
			{(_cursorDistance < 5)} &&
			{(
				(unitIsUav _cursorObject) ||
				{(_cursorObject isKindOf 'StaticWeapon')}
			)} &&
			{(isNull (attachedTo _cursorObject))} &&
			{(isNull (ropeAttachedTo _cursorObject))} &&
			{(isNull (isVehicleCargo _cursorObject))} &&
			{(!(_cursorObject getVariable ['QS_uav_disabled',FALSE]))}
		) then {
			QS_action_selfDestruct = QS_player addAction [
				localize 'STR_QS_Interact_045',
				{
					getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
					if (
						(alive _cursorObject) &&
						{(local _cursorObject)} &&
						{(_cursorDistance < 5)} &&
						{(
							(unitIsUav _cursorObject) ||
							{(_cursorObject isKindOf 'StaticWeapon')}
						)} &&
						{(isNull (attachedTo _cursorObject))} &&
						{(isNull (ropeAttachedTo _cursorObject))} &&
						{(isNull (isVehicleCargo _cursorObject))} &&
						{(!(_cursorObject getVariable ['QS_logistics_blocked',FALSE]))}
					) then {
						_dn = QS_hashmap_configfile getOrDefaultCall [
							format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
							{(getText ((configOf _cursorObject) >> 'displayName'))},
							TRUE
						];
						private _result = [(format [localize 'STR_QS_Text_159',(_cursorObject getVariable ['QS_ST_customDN',_dn])]),localize 'STR_QS_Menu_122',localize 'STR_QS_Menu_124',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
						if (_result) then {
							['systemChat',(format [localize 'STR_QS_Chat_095',profileName,(_cursorObject getVariable ['QS_ST_customDN',_dn]),(mapGridPosition _cursorObject)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
							QS_player playActionNow 'PutDown';
							_cursorObject setDamage [1,FALSE];
						} else {
							50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
						};
					} else {
						50 cutText [localize 'STR_QS_Text_335','PLAIN DOWN',0.2];
					};
				},
				nil,
				-65,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","_cursorSelections","_cursorDistance"];
					(
						(alive _cursorObject) &&
						{(local _cursorObject)} &&
						{(_cursorDistance < 5)} &&
						{(
							(unitIsUav _cursorObject) ||
							{(_cursorObject isKindOf "StaticWeapon")}
						)} &&
						{(isNull (attachedTo _cursorObject))} &&
						{(isNull (ropeAttachedTo _cursorObject))} &&
						{(isNull (isVehicleCargo _cursorObject))}
					)
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_selfDestruct];
		};
		
		//comment 'LITE MORTAR FOR MORTAR GUNNER';
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(QS_player getUnitTrait 'QS_trait_gunner')} &&
			{((stance QS_player) in ['STAND','CROUCH'])} &&
			{(!((toLowerANSI (pose QS_player)) in ['swimming','surfaceswimming']) )} &&
			{((toLowerANSI (backpack QS_player)) in (['mortar_tubes_1'] call QS_data_listItems))}
		) then {
			QS_action_mortarLite = QS_player addAction [
				localize 'STR_QS_Interact_119',
				{
					_this spawn (missionNamespace getVariable 'QS_fnc_clientInteractMortarLite')
				},
				nil,
				-75,
				FALSE,
				TRUE,
				'',
				'TRUE'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_mortarLite];
		};

		//comment 'WEAPON LASERS';
		if (
			(missionNamespace getVariable ['QS_missionConfig_weaponLasers',TRUE]) &&
			{(
				(isNull (objectParent QS_player)) ||
				(isTurnedOut QS_player)
			)} &&
			{((currentWeapon QS_player) isNotEqualTo '')}
		) then {
			QS_action_laserToggle = QS_player addAction [
				([localize 'STR_QS_Text_436',localize 'STR_QS_Text_435'] select (QS_player getVariable ['QS_toggle_visibleLaser',FALSE])),
				{
					_this call QS_fnc_clientInteractLaserToggle;
				},
				nil,
				-80,
				FALSE,
				TRUE,
				'',
				'[_target,_this,_originalTarget,_actionId] call QS_fnc_conditionLaserSelect'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_laserToggle];
		};
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(QS_extendedContext_cursorDistance < 10)} &&
			{(_cursorObject getVariable ['QS_respawn_object',FALSE])} &&
			{(_cursorObject getVariable ['QS_logistics_deployed',FALSE])} &&
			{(!isNull ([50] call QS_fnc_nearbyTickets))}
		) then {
			QS_action_resupplyTickets = QS_player addAction [
				localize 'STR_QS_Interact_140',
				{
					getCursorObjectParams params ['_cursorObject','_cursorSelections','_cursorDistance'];
					_dealer = [50] call QS_fnc_nearbyTickets;
					if (
						(!isNull _dealer) &&
						(_cursorObject getVariable ['QS_respawn_object',FALSE]) &&
						(_cursorObject getVariable ['QS_logistics_deployed',FALSE]) &&
						(_dealer isNil 'QS_vehicle_isSuppliedFOB')
					) then {
						QS_player playActionNow 'putdown';
						[117,_cursorObject,_dealer,profileName] remoteExec ['QS_fnc_remoteExec',2,FALSE];
					} else {
						50 cutText ['STR_QS_Text_335','PLAIN DOWN',0.333];
					};
				},
				nil,
				0,
				FALSE,
				TRUE,
				'',
				'call QS_fnc_canResupplyTickets'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_resupplyTickets];
		};
		// Light switch
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(QS_extendedContext_cursorDistance < 4)} &&
			{((getObjectType QS_extendedContext_cursorObject) isEqualTo 8)} &&
			{(QS_extendedContext_cursorObject isKindOf 'Lamps_base_F')} &&
			{(!isSimpleObject QS_extendedContext_cursorObject)}
		) then {
			QS_action_switchLight = QS_player addAction [
				localize 'STR_QS_Interact_141',
				{
					getCursorObjectParams params ['_cursorObject','','_cursorDistance'];
					if (
						(isNull (objectParent QS_player)) &&
						{(_cursorDistance < 3)} &&
						{((getObjectType _cursorObject) isEqualTo 8)} &&
						{(_cursorObject isKindOf 'Lamps_base_F')} &&
						{(!isSimpleObject _cursorObject)} &&
						{(serverTime > (_cursorObject getVariable ['QS_lamp_cooldown',-1]))}
					) then {
						_cursorObject setVariable ['QS_lamp_cooldown',serverTime + 1,TRUE];
						playSoundUI ['click',soundVolume,2,TRUE];
						QS_player playActionNow 'PutDown';
						_switch = !(isLightOn _cursorObject);
						['switchLight',_cursorObject,(['off','on'] select _switch)] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
					};
				},
				nil,
				-25,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","","_cursorDistance"];
					((!isNull _cursorObject) && {(_cursorDistance < 5)} && {(_cursorObject isEqualTo QS_extendedContext_cursorObject)})
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_switchLight];
		};
		// Disassemble (basebuilding)
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(QS_extendedContext_cursorDistance < 4)} &&
			{((getObjectType QS_extendedContext_cursorObject) isEqualTo 8)} &&
			{(QS_extendedContext_cursorObject getVariable ['QS_logistics_virtual',FALSE])} &&
			{((clientOwner isEqualTo (QS_extendedContext_cursorObject getVariable ['QS_logistics_owner',-2])) || (QS_extendedContext_cursorObject isKindOf 'CAManBase'))} &&
			{((['StaticWeapon','LandVehicle','Ship','Air'] findIf { QS_extendedContext_cursorObject isKindOf _x }) isEqualTo -1)}
		) then {
			QS_action_disassembleVirtual = QS_player addAction [
				localize 'STR_QS_Interact_130',
				{
					_cursorObject = QS_extendedContext_cursorObject;
					_nearUnits = allPlayers - [QS_player];
					_radius = (0 boundingBoxReal _cursorObject) # 2;
					if ((_nearUnits inAreaArray [_cursorObject,_radius,_radius,0,FALSE]) isEqualTo []) then {
						_virtualParent = _cursorObject getVariable ['QS_virtualCargoParent',objNull];
						if (!alive _virtualParent) exitWith {systemChat 'parent does not exist';};
						['DISASSEMBLE',_cursorObject] call QS_fnc_virtualVehicleCargo;
						QS_player playActionNow 'PutDown';
					} else {
						50 cutText [localize 'STR_QS_Text_399','PLAIN',0.5,TRUE];
					};
				},
				nil,
				-98,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","","_cursorDistance"];
					((!isNull _cursorObject) && {(_cursorDistance < 5)} && {(_cursorObject isEqualTo QS_extendedContext_cursorObject)})				
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_disassembleVirtual];
		};
		// Adjust AI unit stance
		if (
			(isNull QS_extendedContext_objectParent) &&
			{(QS_extendedContext_cursorDistance < 5)} &&
			{((getObjectType QS_extendedContext_cursorObject) isEqualTo 8)} &&
			{(QS_extendedContext_cursorObject isKindOf 'CAManBase')} &&
			{((lifeState QS_extendedContext_cursorObject) in ['HEALTHY','INJURED'])} &&
			{(isNull (objectParent QS_extendedContext_cursorObject))} &&
			{(QS_extendedContext_cursorObject getVariable ['QS_unit_canSetStance',FALSE])}
		) then {
			QS_action_cycleAIStance = QS_player addAction [
				localize 'STR_QS_Interact_147',
				{
					_cursorObject = QS_extendedContext_cursorObject;
					if (
						(_cursorObject isKindOf 'CAManBase') &&
						{((lifeState _cursorObject) in ['HEALTHY','INJURED'])} &&
						{(isNull (objectParent _cursorObject))} &&
						{(_cursorObject getVariable ['QS_unit_canSetStance',FALSE])}
					) then {
						_stance = stance _cursorObject;
						if (!(_stance in ['STAND','CROUCH','PRONE'])) exitWith {};
						if (_stance isEqualTo 'STAND') then {
							QS_player playActionNow (selectRandom ['gestureHi']);
							50 cutText [localize 'STR_QS_Text_481','PLAIN',0.2];
							['setUnitPos',_cursorObject,'Middle'] remoteExec ['QS_fnc_remoteExecCmd',_cursorObject,FALSE];							
						};
						if (_stance isEqualTo 'CROUCH') then {
							QS_player playActionNow (selectRandom ['gestureHi']);
							50 cutText [localize 'STR_QS_Text_482','PLAIN',0.2];
							['setUnitPos',_cursorObject,'Down'] remoteExec ['QS_fnc_remoteExecCmd',_cursorObject,FALSE];						
						};
						if (_stance isEqualTo 'PRONE') then {
							QS_player playActionNow (selectRandom ['gestureHi']);
							50 cutText [localize 'STR_QS_Text_480','PLAIN',0.2];
							['setUnitPos',_cursorObject,'Up'] remoteExec ['QS_fnc_remoteExecCmd',_cursorObject,FALSE];							
						};
					};
				},
				nil,
				-84,
				FALSE,
				TRUE,
				'',
				'
					getCursorObjectParams params ["_cursorObject","","_cursorDistance"];
					((!isNull _cursorObject) && {(_cursorDistance < 3)} && {(_cursorObject isEqualTo QS_extendedContext_cursorObject)})				
				'
			];
			QS_interactions_extendedContext pushBack [QS_player,QS_action_cycleAIStance];
		};
		//comment 'PLAYER MENU';
		QS_action_playerMenu = QS_player addAction [
			format ["<t color='#808080'>%1</t>",localize 'STR_QS_Menu_009'],
			{
				if (isNull (findDisplay 2000)) then {
					[0] call (missionNamespace getVariable 'QS_fnc_clientMenu');
				} else {
					[-1] call (missionNamespace getVariable 'QS_fnc_clientMenu');
				};
			},
			nil,
			-99,
			FALSE,
			TRUE,
			'',
			'TRUE'
		];
		QS_interactions_extendedContext pushBack [QS_player,QS_action_playerMenu];
		if (QS_interactions_extendedContext isNotEqualTo []) then {
			{
				(_x # 0) setUserActionText [
					_x # 1,
					(((_x # 0) actionParams (_x # 1)) # 0),
					format ["<t size='3'>%1</t>",(((_x # 0) actionParams (_x # 1)) # 0)]
				];
			} forEach QS_interactions_extendedContext;
		};
	};
};
if (_mode isEqualTo 'OUT') exitWith {
	if (QS_interactions_extendedContext isNotEqualTo []) then {
		{
			(_x # 0) removeAction (_x # 1);
		} forEach QS_interactions_extendedContext;
		QS_extendedContext_cursorObject = objNull;
		QS_interactions_extendedContext = [];
	};
	if (missionNamespace getVariable ['QS_menu_extendedContext',FALSE]) then {
		missionNamespace setVariable ['QS_menu_extendedContext',FALSE,FALSE];
	};
	(findDisplay 22000) closeDisplay 2;
};