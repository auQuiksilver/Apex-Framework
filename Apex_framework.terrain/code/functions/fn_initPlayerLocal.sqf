/*/
File: fn_initPlayerLocal.sqf
Author:
	
	Quiksilver

Last modified:

	7/03/2024 A3 2.18 by Quiksilver
	
Description:

	Player Init
______________________________________________________/*/

if !(missionNamespace isNil 'QS_init_doorCloser') exitWith {
	hint parseText 'Uho! It appears something has gone wrong. Please report this error code to staff:<br/><br/>191<br/><br/>Thank you for your assistance.';
};
missionNamespace setVariable ['QS_player',player,FALSE];
{
	diag_log (format _x);
} forEach [
	['***** INIT PLAYER *****'],
	['***** Apex Framework Version: %1 * %2 *****',getMissionConfigValue ['missionProductVersion',-1],getMissionConfigValue ['missionProductStatus','Stable']]
];

if (!isMissionProfileNamespaceLoaded) then {
    saveMissionProfileNamespace;
};
missionNamespace setVariable ['QS_init_doorCloser',TRUE,FALSE];
uiNamespace setVariable ['BIS_fnc_advHint_hintHandlers',TRUE];
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	['BASE'] spawn (missionNamespace getVariable 'QS_fnc_localObjects');
};
if (!([getPlayerUID player] call (missionNamespace getVariable 'QS_fnc_atNameCheck'))) exitWith {};
if ((getPlayerUID player) in (['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	_code = {
		params ['','','','_array'];
		_array params ['_object','_action'];
		private _n = name _object;
		private _text = '';
		private _val = 9;
		if (_action isEqualTo 'KICK') then {_val = 9;};
		if (_action isEqualTo 'BAN') then {_val = 10;};
		if (!isNull _object) then {
			[42,[_object,_val,player]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
			{
				player removeAction _x;
			} count (missionNamespace getVariable 'QS_kiddieActions');
			missionNamespace setVariable ['QS_kiddieActions',[],FALSE];
			systemChat format ['%1 %2',(str _n),localize 'STR_QS_Chat_135'];
			_text = format ['%1 %2',(str _n),localize 'STR_QS_Hints_124'];
			(missionNamespace getVariable 'QS_managed_hints') pushBack [3,FALSE,7.5,-1,_text,[],-1];
		} else {
			systemChat (localize 'STR_QS_Chat_136');
			(missionNamespace getVariable 'QS_managed_hints') pushBack [3,FALSE,7.5,-1,localize 'STR_QS_Hints_125',[],-1];
		};	
	};
	missionNamespace setVariable ['QS_fnc_actionEjectSuspect',compileFinal _code,FALSE];
};
setPlayerRespawnTime 5;

/*/=========================== PLAYER JOIN TOKEN/*/

if (missionProfileNamespace isNil 'QS_IA_joinToken') then {
	missionProfileNamespace setVariable ['QS_IA_joinToken',1];
} else {
	if ((missionProfileNamespace getVariable 'QS_IA_joinToken') isEqualType 0) then {
		missionProfileNamespace setVariable [
			'QS_IA_joinToken',
			((missionProfileNamespace getVariable 'QS_IA_joinToken') + 1)
		];
	} else {
		missionProfileNamespace setVariable ['QS_IA_joinToken',1];
	};
};
saveMissionProfileNamespace;

/*/=========================== STAMINA/SWAY/*/
player enableStamina TRUE;
if (missionProfileNamespace isNil 'QS_stamina') then {
	if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 0) then {
		player enableStamina FALSE;
	};
	player setCustomAimCoef 0.1;
	player setVariable ['QS_stamina',[(isStaminaEnabled player),0.1],FALSE];
	missionProfileNamespace setVariable ['QS_stamina',FALSE];
	saveMissionProfileNamespace;
} else {
	private _qs_stamina = missionProfileNamespace getVariable ['QS_stamina',[TRUE,0.1]];
	if (_qs_stamina isEqualType []) then {
		_qs_stamina params ['_stamina','_aimcoef'];
		if (!(_aimcoef isEqualType 0)) then {
			_aimcoef = 0.1;
		};
		if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 0) then {
			if (_stamina isEqualType TRUE) then {
				player enableStamina _stamina;
			} else {
				player enableStamina FALSE;
			};
		};
		if (!(_aimcoef isEqualType 0)) then {
			_aimcoef = 0.1;
		};
		player setCustomAimCoef _aimcoef;
		player setVariable ['QS_stamina',[(isStaminaEnabled player),_aimcoef],FALSE];
	} else {
		if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 0) then {
			player enableStamina FALSE;
		};
		player setCustomAimCoef 0.1;
		player setVariable ['QS_stamina',[(isStaminaEnabled player),0.1],FALSE];
	};
};

/*/=========================== 1PV/*/

if ((allMissionObjects 'EmptyDetector') isNotEqualTo []) then {
	deleteVehicle ((allMissionObjects 'EmptyDetector') select {
		(
			(local _x) &&
			(!(_x getVariable ['QS_missionObject_protected',FALSE]))
		)
	});
};
if (missionProfileNamespace isNil 'QS_1PV') then {
	player setVariable ['QS_1PV',[FALSE,time],FALSE];
	missionProfileNamespace setVariable ['QS_1PV',FALSE];
	saveMissionProfileNamespace;
} else {
	private _qs_1pv = missionProfileNamespace getVariable 'QS_1PV';
	if (_qs_1pv isEqualType TRUE) then {
		player setVariable ['QS_1PV',[(missionProfileNamespace getVariable 'QS_1PV'),time],FALSE];
	};
};

/*/=========================== QUACKTAC HUD/*/

if !(missionProfileNamespace isNil 'QS_QTHUD') then {
	private _QTHUD = missionProfileNamespace getVariable 'QS_QTHUD';
	if (_QTHUD isEqualType TRUE) then {
		if (_QTHUD) then {
			['Init'] call (missionNamespace getVariable 'QS_fnc_groupIndicator');
		};
	};
};

/*/========= UAV Operators/*/

0 spawn {
	uiSleep 3;
	if !(missionNamespace isNil 'QS_atClientMisc') then {
		[nil,(missionNamespace getVariable 'QS_atClientMisc')] call (missionNamespace getVariable 'QS_fnc_atClientMisc');
		missionNamespace setVariable ['QS_atClientMisc',nil,FALSE];
	};
};
if !(missionNamespace isNil 'RscMissionStatus_draw3D') then {
	removeMissionEventHandler ['Draw3D',(missionNamespace getVariable ['RscMissionStatus_draw3D',-1])];
};

/*/====================== MISSION NAMESPACE VARS/*/

private _weaponsList = configFile >> 'CfgWeapons';
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_fnc_showNotification_queue',[],FALSE],
	['RscMissionStatus_draw3D',-9,FALSE],
	['QS_hashmap_configfile',createHashMap,FALSE],
	['QS_hashmap_simpleObjectInfo',createHashMap,FALSE],
	['QS_dynSim_script',scriptNull,FALSE],
	['QS_medSys',FALSE,FALSE],
	['QS_client_deltaVD',scriptNull,FALSE],
	['QS_earplug_EH_respawn',nil,FALSE],
	['QS_earplug_action',nil,FALSE],
	['QS_repairing_vehicle',FALSE,FALSE],
	['QS_jumpEnabled',FALSE,FALSE],
	['QS_revive_KilledInventory',(getUnitLoadout player),FALSE],
	['QS_sub_sd',FALSE,FALSE],
	['QS_sub_actions',[],FALSE],
	['QS_underEnforcement',FALSE,FALSE],
	['QS_exitingEnforcedVehicle',FALSE,FALSE],
	['QS_module_fob_client_timeLastRespawn',time,FALSE],
	['QS_client_radioChannels',[],FALSE],
	['QS_client_radioChannels_dynamic',[FALSE,FALSE],FALSE],
	['QS_client_heartbeat',-1,FALSE],
	['QS_client_infoPanels',[(infoPanel 'left'),(infoPanel 'right')],FALSE],
	['QS_draw2D_projectiles',[],FALSE],
	[
		'QS_veh_repair_mkrs',
		[
			'QS_marker_veh_baseservice_01',
			'QS_marker_veh_baseservice_02',
			'QS_marker_veh_baseservice_03',
			'QS_marker_veh_fieldservice_01',
			'QS_marker_veh_fieldservice_02',
			'QS_marker_veh_fieldservice_03',
			'QS_marker_veh_fieldservice_04'
		],
		FALSE
	],
	[
		'QS_veh_baseservice_mkrs',
		[
			'QS_marker_veh_baseservice_01',
			'QS_marker_veh_baseservice_02',
			'QS_marker_veh_baseservice_03'
		],
		FALSE
	],
	[
		'QS_veh_fieldservice_mkrs',
		[		/*/field service markers/*/
			'QS_marker_veh_fieldservice_01',
			'QS_marker_veh_fieldservice_02',
			'QS_marker_veh_fieldservice_03',
			'QS_marker_veh_fieldservice_04'
		],
		FALSE
	],
	[
		'QS_veh_heliservice_mkrs',
		[
			'QS_marker_veh_baseservice_02'
		],
		FALSE
	],
	[
		'QS_veh_planeservice_mkrs',
		[
			'QS_marker_veh_baseservice_03'
		],
		FALSE
	],
	[
		'QS_veh_airservice_mkrs',
		[
			'QS_marker_veh_fieldservice_04'
		],
		FALSE
	],
	[
		'QS_veh_landservice_mkrs',
		[
			'QS_marker_veh_baseservice_01',
			'QS_marker_veh_fieldservice_01',
			'QS_marker_veh_fieldservice_02',
			'QS_marker_veh_fieldservice_03'
		],
		FALSE
	],
	[
		'QS_veh_inventory_mkrs',
		[
			'QS_marker_veh_inventoryService_01',
			'QS_marker_crate_area'
		],
		FALSE
	],
	['QS_script_incapacitated',scriptNull,FALSE],
	['QS_missionStatus_shown',TRUE,FALSE],
	['QS_draw3D_projectiles',[],FALSE],
	['QS_anim_script',scriptNull,FALSE],
	['QS_client_triggerGearCheck',TRUE,FALSE],
	['QS_client_medicIcons_units',[],FALSE],
	['QS_client_AIBehaviours_script',scriptNull,FALSE],
	[
		'QS_client_baseIcons',
		[
			[
				'a3\ui_f\data\igui\cfg\cursors\iconRepairAt_ca.paa',
				[1,1,1,1],
				(markerPos 'QS_marker_veh_baseservice_01'),
				1.5,
				1.5,
				0
			],
			[
				'a3\ui_f\data\igui\cfg\cursors\iconRepairAt_ca.paa',
				[1,1,1,1],
				(markerPos 'QS_marker_veh_baseservice_02'),
				1.5,
				1.5,
				0
			],
			[
				'a3\ui_f\data\igui\cfg\cursors\iconRepairAt_ca.paa',
				[1,1,1,1],
				(markerPos 'QS_marker_veh_baseservice_03'),
				1.5,
				1.5,
				0
			],
			[
				'a3\ui_f\data\igui\cfg\simpleTasks\types\box_ca.paa',
				[1,1,1,1],
				(markerPos 'QS_marker_veh_inventoryService_01'),
				0.75,
				0.75,
				0
			]
		],
		FALSE
	],
	['QS_client_action_carrierLaunchCancel',[],FALSE],
	['QS_managed_hints',[],FALSE],
	['QS_projectile_manager',[],FALSE],
	['QS_vehicle_incomingMissiles',[],FALSE],
	['QS_HUD_show3DHex',(missionProfileNamespace getVariable ['QS_HUD_show3DHex',TRUE]),FALSE],
	['QS_HUD_toggleChatSpam',(missionProfileNamespace getVariable ['QS_HUD_toggleChatSpam',TRUE]),FALSE],
	['QS_HUD_toggleSuppression',(missionProfileNamespace getVariable ['QS_HUD_toggleSuppression',TRUE]),FALSE],
	['QS_HUD_toggleHitMarker',(missionProfileNamespace getVariable ['QS_HUD_toggleHitMarker',TRUE]),FALSE],
	['QS_heli_takeover_action',-1,FALSE],
	['QS_aircraft_critHit_array',[],FALSE],
	['QS_enabledWaypoints',(difficultyOption 'waypoints'),FALSE],
	['QS_managed_flares',[],FALSE],
	['QS_client_sendAccuracy',FALSE,FALSE],
	['QS_client_loadoutTarget',objNull,FALSE],
	['QS_hashmap_tracers',createHashMapFromArray (call QS_data_tracers),FALSE],
	['QS_hashmap_rockets',createHashMapFromArray (call QS_data_rockets),FALSE],
	['QS_session_weaponsList',((missionProfileNamespace getVariable ['QS_profile_weaponsList',[]]) select {(isClass (_weaponsList >> _x))}),FALSE],
	['QS_session_magazineList',[],FALSE],
	['QS_session_weaponMagazines',createHashMap,FALSE],
	['QS_client_hashmap_ammoConfig',createHashMap,FALSE],
	['QS_unit_ragdoll_script',scriptNull,FALSE],
	['QS_client_dynamicActionText',[],FALSE],
	['QS_simpleWinch_actionAttach',-1,FALSE],
	['QS_simpleWinch_actionRelease',-1,FALSE],
	['QS_simpleWinch_actionUnhook',-1,FALSE],
	['QS_pullrelease_action',-1,FALSE],
	['QS_ui_3DCursorTargets',[],FALSE],
	['QS_hashmap_boundingBoxes',createHashMap,FALSE],
	['QS_cas_JetsDLCEnabled',(601670 in (getDLCs 1)),FALSE],
	['QS_analytics_groups_created',0,FALSE],
	['QS_analytics_groups_deleted',0,FALSE]
];
_weaponsList = nil;
if ((missionProfileNamespace getVariable ['QS_IA_joinToken',0]) < 10) then {
	if ((missionNamespace getVariable ['QS_arsenals',[]]) isNotEqualTo []) then {
		{
			(missionNamespace getVariable 'QS_client_baseIcons') pushBack [
				'a3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa',
				[1,1,1,1],
				((position _x) vectorAdd [0,0,-1]),
				0.75,
				0.75,
				0
			];
		} forEach (missionNamespace getVariable ['QS_arsenals',[]]);
	};
};
if ((call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel')) > 0) then {
	missionNamespace setVariable ['BIS_dg_fia',nil,FALSE];
};
/*/====================== LOCAL VARS/*/

{
	localNamespace setVariable _x;
} forEach [
	['QS_focusOn',focusOn],
	['QS_client_lockedDrivers',[]],
	['QS_client_lockedLogistics',[]],
	['QS_uniqueScriptErrors',0]
];

/*/====================== UI VARS/*/
{
	uiNamespace setVariable _x;
} forEach [
	['QS_client_progressVisualization_active',FALSE],
	['RscMissionStatus_display',displayNull],
	['BIS_fnc_advHint_hintHandlers',TRUE],
	['RscEGSpectator_availableInsignias',((configFile >> 'CfgUnitInsignia') call (missionNamespace getVariable 'BIS_fnc_getCfgSubClasses'))],
	['QS_ui_timeLastRadioIn',diag_tickTime],
	['QS_ui_timeLastRadioOut',diag_tickTime],
	['QS_ui_mousePosition',getMousePosition],
	['QS_client_menu_interaction',FALSE],
	['QS_client_playerViewChanged',TRUE],
	['QS_client_uiLastAction',diag_tickTime],
	['QS_client_afkTimeout',diag_tickTime],
	['QS_eval_frameInterval_30',0]
];
/*/====================== PLAYER OBJECT =====/*/
{
	player setVariable _x;
} forEach [
	['BIS_noCoreConversations',TRUE,FALSE],
	['QS_soundVolume',soundVolume,FALSE],
	['QS_combatDeafness',time,FALSE],
	['QS_repackingMagazines',time,FALSE],
	['QS_animDone',FALSE,FALSE],
	['QS_revive_respawnType','',FALSE],
	['QS_earsCollected_session',0,FALSE],
	['QS_revive_killedVehiclePosition',[],FALSE],
	['QS_module_fob_client_respawnEnabled',TRUE,TRUE],
	['QS_lockedInventory',(missionProfileNamespace getVariable ['QS_lockedInventory',FALSE]),TRUE],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_vehicleEventHandlers',[],FALSE],
	['QS_client_hqLastSmoke',time,FALSE],
	['QS_client_assembledWeapons',[],FALSE],
	['QS_client_createdBoat',objNull,FALSE],
	['QS_client_lastGesture',time,FALSE],
	['QS_client_sectorScanLastRequest',time,FALSE],
	['QS_client_hc_waypoint',[],FALSE],
	['QS_client_soundControllers',[(getAllSoundControllers (vehicle player)),(getAllEnvSoundControllers (getPosWorld player))],FALSE],
	['QS_client_lastMedevacRequest',diag_tickTime,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE],
	['QS_client_inBaseArea',FALSE,FALSE],
	['QS_client_inFOBArea',FALSE,FALSE],
	['QS_client_inCarrierArea',FALSE,FALSE],
	['QS_client_inDestroyerArea',FALSE,FALSE],
	['QS_client_revivedAtHospital',-1,FALSE],
	['QS_client_animCancel',FALSE,FALSE],
	['QS_client_currentAnim',(animationState player),FALSE],
	['QS_client_shots',0,FALSE],
	['QS_client_hits',0,FALSE],
	['QS_client_shots_sniper',0,FALSE],
	['QS_client_hits_sniper',0,FALSE],
	['QS_client_lastCombatDamageTime',-1,FALSE],
	['QS_unit_side',WEST,TRUE]
];
// Remove BIS Zeus stuff
if !(player isNil 'BIS_fnc_addCuratorPlayer_handler') then {
	player removeMPEventHandler ['MPRespawn',(player getVariable 'BIS_fnc_addCuratorPlayer_handler')];
};
/*/ Add Scripted Event Handlers /*/
{
	_x call (missionNamespace getVariable 'BIS_fnc_addScriptedEventHandler');
} forEach [
	[missionNamespace,'arsenalClosed',(missionNamespace getVariable 'QS_fnc_clientEventArsenalClosed')],
	[missionNamespace,'arsenalOpened',(missionNamespace getVariable 'QS_fnc_clientEventArsenalOpened')]
];
/*/ Add Mission Event Handlers /*/
{
	addMissionEventHandler _x;
} forEach [
	['Draw3D',{call (missionNamespace getVariable 'QS_fnc_clientEventDraw3D')}],
	['Map',{call (missionNamespace getVariable 'QS_fnc_clientEventMap')}],
	['MapSingleClick',{call (missionNamespace getVariable 'QS_fnc_clientEventMapSingleClick')}],
	['MarkerUpdated',{call (missionNamespace getVariable 'QS_fnc_clientEventMarkerUpdated')}],
	['PlayerViewChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventPlayerViewChanged')}],
	[
		'Map',
		{
			params ['_mapIsOpened','_mapIsForced'];
			((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.75,player];
			ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
			removeMissionEventHandler [_thisEvent,_thisEventHandler];
			0 spawn {
				uiSleep 1;
				ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);
			};
		}
	],
	['HandleChatMessage',{call (missionNamespace getVariable 'QS_fnc_clientEventHandleChatMessage')}],
	['Service',{call (missionNamespace getVariable 'QS_fnc_eventService')}],
	['Drowned',{call (missionNamespace getVariable 'QS_fnc_eventVehicleDrowned')}]
];

// debug
addMissionEventHandler [
	'GroupCreated',
	{
		params ['_group'];
		QS_analytics_groups_created = QS_analytics_groups_created + 1;
		systemChat str _group;
	}
];
addMissionEventHandler [
	'GroupDeleted',
	{
		params ['_group'];
		QS_analytics_groups_deleted = QS_analytics_groups_deleted + 1;
	}
];
// debug

{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"]//,
	//['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	//['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];
{
	player addEventHandler _x;
} forEach [
	['FiredMan',{call (missionNamespace getVariable 'QS_fnc_clientEventFiredMan')}],
	['Respawn',{call (missionNamespace getVariable 'QS_fnc_clientEventRespawn')}],
	['Killed',{call (missionNamespace getVariable 'QS_fnc_clientEventKilled')}],
	['Explosion',{call (missionNamespace getVariable 'QS_fnc_clientEventExplosion')}],
	['WeaponAssembled',{call (missionNamespace getVariable 'QS_fnc_clientEventWeaponAssembled')}],
	['WeaponDisassembled',{call (missionNamespace getVariable 'QS_fnc_clientEventWeaponDisassembled')}],
	['Hit',{call (missionNamespace getVariable 'QS_fnc_clientEventHit')}],
	['HitPart',{call (missionNamespace getVariable 'QS_fnc_clientEventHitPart')}],
	['HandleDamage',{call (missionNamespace getVariable 'QS_fnc_clientEventHandleDamage')}],
	['FiredNear',{call (missionNamespace getVariable 'QS_fnc_clientEventFiredNear')}],
	//['GestureChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventGestureChanged')}],					// These execute frequently when player is moving, only use if you have a reason. Test out in editor
	//['GestureDone',{call (missionNamespace getVariable 'QS_fnc_clientEventGestureDone')}],						// These execute frequently when player is moving, only use if you have a reason. Test out in editor
	['GetInMan',{call (missionNamespace getVariable 'QS_fnc_clientEventGetInMan')}],
	['GetOutMan',{call (missionNamespace getVariable 'QS_fnc_clientEventGetOutMan')}],
	['SeatSwitchedMan',{call (missionNamespace getVariable 'QS_fnc_clientEventSeatSwitchedMan')}],
	['Suppressed',{call (missionNamespace getVariable 'QS_fnc_clientEventSuppressed')}],
	['Reloaded',{call (missionNamespace getVariable 'QS_fnc_clientEventReloaded')}],
	['WeaponDeployed',{}],
	['WeaponRested',{}],
	['Take',{call (missionNamespace getVariable 'QS_fnc_clientEventTake')}],
	['Put',{call (missionNamespace getVariable 'QS_fnc_clientEventPut')}],
	['SoundPlayed',{call (missionNamespace getVariable 'QS_fnc_clientEventSoundPlayed')}],
	['InventoryOpened',{call (missionNamespace getVariable 'QS_fnc_clientEventInventoryOpened')}],
	['InventoryClosed',{call (missionNamespace getVariable 'QS_fnc_clientEventInventoryClosed')}],
	['HandleRating',{call (missionNamespace getVariable 'QS_fnc_clientEventHandleRating')}],
	['HandleHeal',{call (missionNamespace getVariable 'QS_fnc_clientEventHandleHeal')}],
	['AnimChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventAnimChanged')}],
	['AnimDone',{call (missionNamespace getVariable 'QS_fnc_clientEventAnimDone')}],
	['AnimStateChanged',{}],
	['TaskSetAsCurrent',{call (missionNamespace getVariable 'QS_fnc_clientEventTaskSetAsCurrent')}],
	['PostReset',{call (missionNamespace getVariable 'QS_fnc_clientEventPostReset')}],
	['OpticsModeChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventOpticsModeChanged')}],
	['OpticsSwitch',{call (missionNamespace getVariable 'QS_fnc_clientEventOpticsSwitch')}],
	['VisionModeChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventVisionModeChanged')}],
	['SlotItemChanged',{call (missionNamespace getVariable 'QS_fnc_clientEventSlotItemChanged')}]
];
{
	addMusicEventHandler _x;
} forEach [
	['MusicStart',{}],
	['MusicStop',{}]
];
'init' call (missionNamespace getVariable 'QS_fnc_clientEventUserAction');
// Release-related actions
QS_ui_releaseActions = [
	(toLower (localize 'STR_QS_Interact_010')),		// 'release',
	(toLower (localize 'STR_QS_Interact_004')),		// 'load',
	(toLower (localize 'STR_QS_Interact_037')),		// 'load cargo',
	(toLower (localize 'STR_QS_Interact_108')),		// 'retract cargo ropes',
	(toLower (localize 'STR_QS_Interact_109')),		// 'extend cargo ropes',
	(toLower (localize 'STR_QS_Interact_110')),		// 'shorten cargo ropes',
	(toLower (localize 'STR_QS_Interact_111')),		// 'release cargo',
	(toLower (localize 'STR_QS_Interact_112')),		// 'deploy cargo ropes',
	(toLower (localize 'STR_QS_Interact_113')),		// 'attach to cargo ropes',
	(toLower (localize 'STR_QS_Interact_114')),		// 'drop cargo ropes',
	(toLower (localize 'STR_QS_Interact_115'))		// 'pickup cargo ropes'
];

// Init Deployment system
['INIT_PLAYER'] call QS_fnc_deployment;

// Init wreck materials
['INIT'] call (missionNamespace getVariable 'QS_fnc_wreckSetMaterials');

// Preload Arsenal
[player] call (missionNamespace getVariable 'QS_fnc_clientArsenal');

// Preload Dynamic Groups
["InitializePlayer",[player,(missionNamespace getVariable ['QS_missionConfig_registerInitGroup',FALSE])]] call BIS_fnc_dynamicGroups;

0 spawn {
	uiSleep 1;
	if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
		// Insignia
		if (
			!(missionProfileNamespace isNil 'QS_ClientUnitInsignia2') &&
			{((missionProfileNamespace getVariable 'QS_ClientUnitInsignia2') isEqualType '')} &&
			{((missionProfileNamespace getVariable 'QS_ClientUnitInsignia2') isNotEqualTo '')}
		) then {
			player setVariable ['QS_ClientUnitInsignia2',(missionProfileNamespace getVariable 'QS_ClientUnitInsignia2'),FALSE];
			[(missionProfileNamespace getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
		};
		// Uniform
		
		if (
			!(missionProfileNamespace isNil 'QS_ClientUTexture2') &&
			{((missionProfileNamespace getVariable 'QS_ClientUTexture2') isEqualType '')} &&
			{((missionProfileNamespace getVariable 'QS_ClientUTexture2') isNotEqualTo '')} &&
			{!(missionProfileNamespace isNil 'QS_ClientUTexture2_Uniforms2')} &&
			{((missionProfileNamespace getVariable 'QS_ClientUTexture2_Uniforms2') isEqualType [])} &&
			{((missionProfileNamespace getVariable 'QS_ClientUTexture2_Uniforms2') isNotEqualTo [])} &&
			{((uniform player) in (missionProfileNamespace getVariable 'QS_ClientUTexture2_Uniforms2'))}
		) then {
			player setObjectTextureGlobal [0,(missionProfileNamespace getVariable 'QS_ClientUTexture2')];
			player setVariable ['QS_ClientUTexture2',(missionProfileNamespace getVariable 'QS_ClientUTexture2'),FALSE];
			player setVariable ['QS_ClientUTexture2_Uniforms2',(missionProfileNamespace getVariable 'QS_ClientUTexture2_Uniforms2'),FALSE];
			if ((vest player) isNotEqualTo '') then {
			
			};
			if ((backpack player) isNotEqualTo '') then {
			
			};
		};
	};
};
private _itemToRemove = '';
if ((backpack player) isNotEqualTo '') then {
	_maxLoadBackpack = 1;
	if ((loadBackpack player) > _maxLoadBackpack) then {
		while {((loadBackpack player) > _maxLoadBackpack)} do {
			_itemToRemove = selectRandom ((backpackItems player) + (backpackMagazines player));
			if (!((toLowerANSI _itemToRemove) in (QS_core_classNames_itemToolKits + QS_core_classNames_itemMedikits))) then {
				player removeItemFromBackpack _itemToRemove;
			};
		};
	};
};
if ((vest player) isNotEqualTo '') then {
	_maxLoadVest = 1;
	if ((loadVest player) > _maxLoadVest) then {
		while {((loadVest player) > _maxLoadVest)} do {
			_itemToRemove = selectRandom ((vestItems player) + (vestMagazines player));
			player removeItemFromVest _itemToRemove;
		};
	};
};
if ((uniform player) isNotEqualTo '') then {
	_maxLoadUniform = 1;
	if ((loadUniform player) > _maxLoadUniform) then {
		while {((loadUniform player) > _maxLoadUniform)} do {
			_itemToRemove = selectRandom ((uniformItems player) + (uniformMagazines player));
			player removeItemFromUniform _itemToRemove;
		};
	};	
};
if (missionNamespace getVariable ['QS_missionConfig_weaponLasers',TRUE]) then {
	['INIT'] call QS_fnc_simpleLasers;
};
0 spawn (missionNamespace getVariable 'QS_fnc_clientDiary');
0 spawn (missionNamespace getVariable 'QS_fnc_icons');
call (missionNamespace getVariable 'AR_Advanced_Rappelling_Install');
enableDynamicSimulationSystem FALSE;
disableRemoteSensors TRUE;
calculatePlayerVisibilityByFriendly FALSE;
useAISteeringComponent FALSE;
enableEngineArtillery ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 2);
setMissionOptions (createHashMapFromArray [['IgnoreNoDamage', TRUE], ['IgnoreFakeHeadHit', TRUE]]);
if (missionProfileNamespace isNil 'QS_options_ambientLife') then {
	missionProfileNamespace setVariable ['QS_options_ambientLife',TRUE];
	enableEnvironment [TRUE,TRUE,getMissionConfigValue ['windyCoef',0.65]];
	saveMissionProfileNamespace;
} else {
	_ambientLife = missionProfileNamespace getVariable 'QS_options_ambientLife';
	if (!(_ambientLife isEqualType TRUE)) then {
		missionProfileNamespace setVariable ['QS_options_ambientLife',TRUE];
		enableEnvironment [TRUE,TRUE,getMissionConfigValue ['windyCoef',0.65]];
		saveMissionProfileNamespace;
	} else {
		enableEnvironment [(missionProfileNamespace getVariable 'QS_options_ambientLife'),TRUE,getMissionConfigValue ['windyCoef',0.65]];
	};
};
if (missionProfileNamespace getVariable ['QS_options_dynSim',FALSE]) then {
	missionNamespace setVariable ['QS_options_dynSim',TRUE,FALSE];
	missionNamespace setVariable [
		'QS_dynSim_script',
		(1 spawn (missionNamespace getVariable 'QS_fnc_clientSimulationManager')),
		FALSE
	];
};
0 fadeSpeech 1;
enableSentences FALSE;
showSubtitles FALSE;
enableSaving [FALSE,FALSE];
enableTeamSwitch FALSE;
enableWeaponDisassembly TRUE;
player disableConversation TRUE;
player setUnitFreefallHeight 65;
if (
	(!(missionNamespace getVariable ['QS_missionConfig_weatherDynamic',TRUE])) &&
	{((missionNamespace getVariable ['QS_missionConfig_weatherForced',0]) >= 4)}
) then {
	setRain ((missionNamespace getVariable ['QS_missionConfig_weatherForced',0]) call (missionNamespace getVariable 'QS_data_rainParams'));
};

{
	if ((flagAnimationPhase _x) isNotEqualTo -1) then {
		_x setFlagAnimationPhase (_x getVariable ['QS_flag_animationPhase',flagAnimationPhase _x]);
	};
} forEach (allMissionObjects 'FlagCarrier');

if ((rank player) isNotEqualTo 'PRIVATE') then {
	player setRank 'PRIVATE';
};
if ((toLowerANSI (speaker player)) isNotEqualTo 'novoice') then {
	player setSpeaker 'NoVoice';
};
player addRating (0 - (rating player));
{
	player enableAIFeature _x;
} count [
	['TEAMSWITCH',FALSE],
	['FSM',FALSE],
	['AIMINGERROR',FALSE],
	['COVER',FALSE],
	['AUTOCOMBAT',FALSE],
	['MOVE',TRUE]
];
if ((group player) isNil 'BIS_dg_reg') then {
	_allGroups = (groups ((side _x) isEqualTo (player getVariable ['QS_unit_side',WEST]))) select {
		(
			(isPlayer (leader _x)) && 
			{!(_x isNil 'BIS_dg_reg')} &&
			{(!(_x getVariable ['BIS_dg_pri',FALSE]))}
		)
	};
	if (_allGroups isNotEqualTo []) then {
		private _allGroupsSorted = [];
		{
			_allGroupsSorted pushBack [(count (units _x)),_x];
		} forEach _allGroups;
		_allGroupsSorted sort FALSE;
		if (_allGroups isNotEqualTo []) then {
			[player] joinSilent ((_allGroupsSorted # 0) # 1);
		};
	};
};
_squadParams = squadParams player;
if (_squadParams isNotEqualTo []) then {
	_squadName = (_squadParams # 0) # 0;
	private _exit3 = FALSE;
	{
		if ((side (group _x)) isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
			if ((squadParams _x) isNotEqualTo []) then {
				if ((((squadParams _x) # 0) # 0) isEqualTo _squadName) then {
					[player] joinSilent (group _x);
					_exit3 = TRUE;
				};
			};
			if (_exit3) exitWith {};
		};
	} forEach allPlayers;
};
_worldName = worldName;
if (_worldName isEqualTo 'Stratis') then {
	private _terrainLocation = nearestLocation [[3764.32,7944.11,0.0131321],'nameLocal'];
	private _editableLocation = createLocation [_terrainLocation];
	_editableLocation setText 'Quiksilver Island';
};
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
call (missionNamespace getVariable 'QS_fnc_clientBaseLights');
[1] call (missionNamespace getVariable 'QS_fnc_aoFires');
if ((missionNamespace getVariable ['QS_setFeatureType',[]]) isNotEqualTo []) then {
	{
		(_x # 0) setFeatureType (_x # 1);
	} forEach (missionNamespace getVariable 'QS_setFeatureType');
};
private _cosmeticsEnabled = call (missionNamespace getVariable 'QS_missionConfig_cosmetics');
private _canLoadFaceProfile = FALSE;
if (_cosmeticsEnabled > 0) then {
	if (_cosmeticsEnabled isEqualTo 1) then {
		if (
			((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) ||
			((call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel')) > 0)
		) then {
			_canLoadFaceProfile = TRUE;
		};
	} else {
		_canLoadFaceProfile = TRUE;
	};
};
if (_canLoadFaceProfile) then {
	private _availableFaces = ['cfgfaces_1'] call QS_data_listOther;
	_availableFaces = _availableFaces apply { toLowerANSI (_x # 1) };
	_profileFace = missionProfileNamespace getVariable ['QS_unit_face','default'];
	if ((toLowerANSI _profileFace) in _availableFaces) then {
		player setVariable ['QS_unit_face',_profileFace,TRUE];
		player setFace _profileFace;
	};
};
{
	if ((_x getVariable ['QS_unit_face','']) isNotEqualTo '') then {
		if (_x isNotEqualTo player) then {
			_x setFace (_x getVariable ['QS_unit_face','']);
		};
	};
} forEach allPlayers;

/*/================= Hidden Terrain Objects - We do this incase of desync/*/
private _obj = objNull;
if (_worldName isEqualTo 'Altis') then {
	{
		if (_x inPolygon [[5443.56,17947,0],[5387.14,17940.1,0],[5383.96,17933.4,0],[5368.8,17932.5,0],[5343.63,17919,0],[5355.7,17878.1,0],[5364.41,17850.4,0],[5379.65,17850.7,0],[5395.13,17870.1,0],[5434.97,17871.2,0],[5438.15,17916.3,0],[5445.73,17929.3,0]]) then {
			if (!isObjectHidden _x) then {
				_x hideObject TRUE;
				_x enableSimulation FALSE;
			};
		};
	} forEach (nearestTerrainObjects [[5398.63,17897.7,0.00141144],[],100,FALSE,TRUE]);
};
if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
	if (_worldName isEqualTo 'Altis') then {
		{
			_obj = (_x # 0) nearestObject (_x # 1);
			if (!isObjectHidden _obj) then {
				_obj hideObject TRUE;
				_obj enableSimulation FALSE;
			};
		} forEach [
			[[14529.1,16713.4,-0.095396],'Land_Airport_Tower_F'],
			[[14616.3,16714.1,3.8147e-006],'Land_LampAirport_off_F'],
			[[14677.8,16777,3.8147e-006],'Land_LampAirport_off_F'],
			[[14723.3,16821.3,3.8147e-006],'Land_LampAirport_F'],
			[[14572.2,16668.5,3.8147e-006],'Land_LampAirport_F']
		];
		{	
			if (!isObjectHidden _x) then {
				_x hideObject TRUE; 
				_x enableSimulation FALSE;
			};
		} forEach (nearestTerrainObjects [[16899.4,9935.51,0.00149155],['BUSH'],5,FALSE,TRUE]);	
		{
			if (!isObjectHidden _x) then {
				_x hideObject TRUE; 
				_x enableSimulation FALSE;
			};
		} forEach (nearestTerrainObjects [[14521.2,16778.4,0.0017128],[],5,FALSE,TRUE]);
	};
	if (_worldName isEqualTo 'Tanoa') then {
		{
			if (!isObjectHidden _x) then {
				_x hideObject TRUE;
				_x enableSimulation FALSE;
			};
		} forEach (nearestTerrainObjects [[4009.65,11793.7,0.00143814],['TREE'],10,FALSE,TRUE]);
	};
	if (_worldName isEqualTo 'Malden') then {
		{	
			_obj = (_x # 0) nearestObject (_x # 1);
			if (!isObjectHidden _obj) then {
				_obj hideObject TRUE;
				_obj enableSimulation FALSE;
			};
		} forEach [
			[[8066.87,10196.4,0.0199451],'Land_HelipadSquare_F'],
			[[8020.53,10196.8,0.0200291],'Land_HelipadSquare_F'],
			[[8068.54,9995.96,-0.320858],'Land_Hangar_F'],
			[[8091.6,9672.57,0.0110703],'Land_HelipadRescue_F'],
			[[8013.59,9688.03,0.0123863],'Land_HelipadCivil_F'],
			[[8100.73,10111.4,-0.000911713],'Land_LampAirport_F'],
			[[8093.89,10235.7,-0.00857162],'Land_LampAirport_F']
		];
	};
	if (_worldName isEqualTo 'Enoch') then {
		
	};
	if (_worldName isEqualTo 'Stratis') then {
		// Hide some key buildings in the base area
		{
			_obj = (_x # 0) nearestObject (_x # 1);
			if (!isObjectHidden _obj) then {
				_obj hideObject TRUE;
				_obj enableSimulation FALSE;
				_obj allowDamage FALSE
			};
		} forEach [
			[[1886.33,5728.47,0.00142622],'Land_HelipadSquare_F'],
			[[1894.68,5758.35,0.00143862],'Land_HelipadSquare_F'],
			[[1913.16,5820.46,9.53674e-007],'Land_TentHangar_V1_F'],
			[[1923.68,5863.94,2.95639e-005],'Land_TentHangar_V1_F'],
			[[1913.94,5955.27,0.000219345],'Land_TentHangar_V1_F'],
			[[1924.84,5850.23,2.62847],''],												//land_cargo20_military_green_f
			[[1916.95,5805.76,2.62856],''],												//land_cargo20_military_green_f
			[[1942.73,5872.22,2.62848],''],
			[[1958.54,5707.32,0.100458],'Land_MilOffices_V1_F'],
			[[1910.51,5713.64,0.00755119],'Land_Airport_Tower_F'],
			[[1906.17,5639.7,0.000470161],'Land_TentHangar_V1_F']
		];
	};
};


/*/================= Radio Channels/*/

enableRadio TRUE;
{
	(_x # 0) enableChannel (_x # 1);
} count [
	[0,[FALSE,FALSE]],
	[1,[TRUE,FALSE]],
	[2,[TRUE,TRUE]],
	[3,[TRUE,TRUE]],
	[4,[TRUE,TRUE]],
	[5,[TRUE,TRUE]]
];
if (currentChannel isEqualTo 4) then {
	setCurrentChannel 5;
};
private _QS_radioChannels = [1];
if ((player getUnitTrait 'QS_trait_pilot') || {(player getUnitTrait 'uavhacker')} || {(player getUnitTrait 'QS_trait_HQ')}) then {
	_QS_radioChannels pushBack 2;
};
{
	[1,_x] call (missionNamespace getVariable 'QS_fnc_clientRadio');
} forEach _QS_radioChannels;
if (missionProfileNamespace isNil 'QS_client_radioChannels_profile') then {
	missionProfileNamespace setVariable ['QS_client_radioChannels_profile',[FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE]];
	saveMissionProfileNamespace;
} else {
	private _QS_radioChannels_profile = missionProfileNamespace getVariable ['QS_client_radioChannels_profile',[FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE]];
	if ((count _QS_radioChannels_profile) isEqualTo 10) then {
		if ((_QS_radioChannels_profile # 2) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 2) then {
				missionNamespace setVariable [
					'QS_client_radioChannels_dynamic',
					[
						TRUE,
						((missionNamespace getVariable 'QS_client_radioChannels_dynamic') # 1)
					],
					FALSE
				];
			};
		};
		if ((_QS_radioChannels_profile # 3) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 3) then {
				missionNamespace setVariable [
					'QS_client_radioChannels_dynamic',
					[
						((missionNamespace getVariable 'QS_client_radioChannels_dynamic') # 0),
						TRUE
					],
					FALSE
				];
			};
		};
		if ((_QS_radioChannels_profile # 4) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 4) then {
				[1,5] call (missionNamespace getVariable 'QS_fnc_clientRadio');
			};
		};
		if ((_QS_radioChannels_profile # 5) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 5) then {
				[1,6] call (missionNamespace getVariable 'QS_fnc_clientRadio');
			};
		};
		if ((_QS_radioChannels_profile # 6) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 6) then {
				[1,7] call (missionNamespace getVariable 'QS_fnc_clientRadio');
			};
		};
		if ((_QS_radioChannels_profile # 7) isEqualType TRUE) then {
			if (_QS_radioChannels_profile # 7) then {
				[1,8] call (missionNamespace getVariable 'QS_fnc_clientRadio');
			};
		};
	};
};
if (missionNamespace getVariable ['QS_missionConfig_introMusic',TRUE]) then {
	if (uiNamespace isNil 'QS_hasJoinedSession') then {
		uiNamespace setVariable ['QS_hasJoinedSession',TRUE];
		if ((random 1) > 0.333) then {
			_track = selectRandomWeighted (['intro_music_custom'] call QS_data_listOther);
			if (isClass (missionConfigFile >> 'CfgSounds' >> _track)) then {
				playSound [_track,FALSE];
			};
		} else {
			1 fadeMusic 0.333;
			_musicClasses = ['intro_music_1'] call QS_data_listOther;
			private _music = [];
			{
				if (isClass (configFile >> 'CfgMusic' >> (_x # 0))) then {
					_music pushBack (_x # 0);
					_music pushBack (_x # 1);
				};
			} forEach _musicClasses;
			playMusic [(selectRandomWeighted _music),0];
		};
	};
};
0 spawn (missionNamespace getVariable 'QS_fnc_clientCore');
if (userInputDisabled) then {
	disableUserInput FALSE;
};