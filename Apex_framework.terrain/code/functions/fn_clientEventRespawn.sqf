/*/
File fn_clientEventRespawn.sqf
Author: 

	Quiksilver
	
Last modified:

	9/06/2019 A3 1.94 by Quiksilver
	
Description:

	Apply code to client on respawn
_______________________________________________/*/

params [['_newUnit',player],['_oldUnit',objNull]];
missionNamespace setVariable ['BIS_respawned',TRUE,FALSE];
if (captive player) then {
	player setCaptive FALSE;
};
if (isForcedWalk player) then {
	player forceWalk FALSE;
};
{
	player setVariable _x;
} forEach [
	['QS_RD_interacting',FALSE,TRUE],
	['QS_RD_loaded',FALSE,TRUE],
	['QS_event_handleHeal',nil,TRUE],
	['QS_revive_disable',FALSE,(player getVariable ['QS_revive_disable',FALSE])],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE],
	['QS_client_playerViewChanged',TRUE,FALSE]
];
50 cutText ['','BLACK IN',1];
{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"],
	['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];
disableRemoteSensors TRUE;
if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 1) then {
	player enableStamina TRUE;
} else {
	player enableStamina ((player getVariable 'QS_stamina') select 0);
};
player setCustomAimCoef ((player getVariable 'QS_stamina') select 1);
player disableConversation TRUE;
showSubtitles FALSE;
enableRadio TRUE;
{
	(_x select 0) enableChannel (_x select 1);
} count [
	[0,[FALSE,FALSE]],
	[1,[TRUE,FALSE]],
	[2,[TRUE,TRUE]],
	[3,[TRUE,TRUE]],
	[4,[TRUE,TRUE]],
	[5,[TRUE,TRUE]]
];
for '_i' from 0 to 499 step 1 do {
	if (ppEffectEnabled _i) then {
		_i ppEffectEnable FALSE;
		_i ppEffectCommit 0;
	};
};
if (player getUnitTrait 'uavhacker') then {
	if (!isNull (getConnectedUAV _oldUnit)) then {
		_uav = getConnectedUAV _oldUnit;
		_oldUnit connectTerminalToUAV objNull;
		_oldUnit disableUAVConnectability [_uav,TRUE];
		_uav spawn {
			uiSleep 1;
			player enableUAVConnectability [_this,TRUE];
			player connectTerminalToUAV _this;
		};
	};
};
if (!((toLower (speaker player)) isEqualTo 'novoice')) then {
	player setSpeaker 'NoVoice';
};
player addRating (0 - (rating player));
{
	player disableAI _x;
} forEach [
	'TEAMSWITCH',
	'FSM',
	'AIMINGERROR',
	'SUPPRESSION',
	'COVER',
	'AUTOCOMBAT'
];
{
	player enableAI _x;
} forEach [
	'MOVE'
];
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) in [0,1]) then {
	enableEngineArtillery FALSE;
};
if (player getUnitTrait 'QS_trait_HQ') then {
	missionNamespace setVariable ['QS_hc_Commander',player,TRUE];
};
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
if (!((player getVariable 'QS_ClientUnitInsignia2') isEqualTo '')) then {
	[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
};
if (!((player getVariable ['QS_tto',0]) < 1.5)) then {
	player disableTIEquipment TRUE;
};
if (!isNull _oldUnit) then {
	if (!((getAllOwnedMines _oldUnit) isEqualTo [])) then {
		{
			player addOwnedMine _x;
		} count (getAllOwnedMines _oldUnit);
	};
};
if (!((missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') isEqualTo [])) then {
	(missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') params [
		'_actionVehicle',
		'_actionAction'
	];
	if (!isNull _actionVehicle) then {
		_actionVehicle removeAction _actionAction;
	};
	missionNamespace setVariable ['QS_client_action_carrierLaunchCancel',[],FALSE];
};
if (([] call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel')) > 0) then {
	0 spawn {
		uiSleep 1;
		if (!((player getVariable 'QS_ClientUTexture2') isEqualTo '')) then {
			if (!((player getVariable 'QS_ClientUTexture2_Uniforms2') isEqualTo [])) then {
				if ((uniform player) in (player getVariable 'QS_ClientUTexture2_Uniforms2')) then {
					player setObjectTextureGlobal [0,(player getVariable 'QS_ClientUTexture2')];
					if (!((vest player) isEqualTo '')) then {
					
					};
					if (!((backpack player) isEqualTo '')) then {
					
					};
				};
			};
		};
	};
};
if (!isNull _oldUnit) then {
	if (((_oldUnit distance2D (markerPos 'QS_marker_base_marker')) < 1000) || {((_oldUnit distance2D (markerPos 'QS_marker_carrier_1')) < 1000)}) then {
		deleteVehicle _oldUnit;
	} else {
		if (!((getMissionConfigValue ['corpseManagerMode',0]) isEqualTo 0)) then {
			addToRemainsCollector [_oldUnit];
		};
	};
};
private _itemToRemove = '';
if (!((backpack player) isEqualTo '')) then {
	_maxLoadBackpack = 1;
	if ((loadBackpack player) > _maxLoadBackpack) then {
		while {((loadBackpack player) > _maxLoadBackpack)} do {
			_itemToRemove = selectRandom ((backpackItems player) + (backpackMagazines player));
			if (!(_itemToRemove in ['ToolKit','Medikit'])) then {
				player removeItemFromBackpack _itemToRemove;
			};
		};
	};
};
if (!((vest player) isEqualTo '')) then {
	_maxLoadVest = 1;
	if ((loadVest player) > _maxLoadVest) then {
		while {((loadVest player) > _maxLoadVest)} do {
			_itemToRemove = selectRandom ((vestItems player) + (vestMagazines player));
			player removeItemFromVest _itemToRemove;
		};
	};
};
if (!((uniform player) isEqualTo '')) then {
	_maxLoadUniform = 1;
	if ((loadUniform player) > _maxLoadUniform) then {
		while {((loadUniform player) > _maxLoadUniform)} do {
			_itemToRemove = selectRandom ((uniformItems player) + (uniformMagazines player));
			player removeItemFromUniform _itemToRemove;
		};
	};
};
// EAST respawn
if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo EAST) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
			setPlayerRespawnTime 15;
			['SET_DEFAULT_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
			[_newUnit,(missionNamespace getVariable 'QS_aoPos')] call (missionNamespace getVariable 'QS_fnc_respawnOPFOR');
		} else {
			0 spawn {
				preloadCamera (markerPos 'respawn_east');
				uiSleep 0.25;
				player setVehiclePosition [(markerPos 'respawn_east'),[],10,'NONE'];
			};
		};
	};
	0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
};
// RESISTANCE respawn
if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo RESISTANCE) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		if ((missionNamespace getVariable ['QS_missionConfig_aoType','CLASSIC']) in ['CLASSIC','SC','GRID']) then {
			setPlayerRespawnTime 15;
			['SET_DEFAULT_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
			[_newUnit,(missionNamespace getVariable 'QS_aoPos')] call (missionNamespace getVariable 'QS_fnc_respawnOPFOR');
		} else {
			0 spawn {
				preloadCamera (markerPos 'respawn_resistance');
				uiSleep 0.25;
				player setVehiclePosition [(markerPos 'respawn_resistance'),[],10,'NONE'];
			};
		};
	};
	0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
};
// CIVILIAN respawn
if ((_newUnit getVariable ['QS_unit_side',WEST]) isEqualTo CIVILIAN) exitWith {
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		0 spawn {
			preloadCamera (markerPos 'respawn_civilian');
			uiSleep 0.25;
			player setVehiclePosition [(markerPos 'respawn_civilian'),[],10,'NONE'];
		};
		setPlayerRespawnTime 15;
	};
	0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
};
// WEST respawn
setPlayerRespawnTime 5;
['SET_SAVED_LOADOUT',(_newUnit getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
[2,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
private _position = AGLToASL (markerPos 'QS_marker_base_marker');
if ((player getVariable 'QS_revive_respawnType') in ['BASE','']) then {
	if ((!((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2)) && (!((missionNamespace getVariable ['QS_missionConfig_destroyerRespawn',0]) isEqualTo 1))) then {
		if ((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) then {
			if (worldName isEqualTo 'Altis') then {
				_position = [((_position select 0) + 12 - (random 24)),((_position select 1) + 12 - (random 24)),(_position select 2)];
			};
			if (worldName isEqualTo 'Tanoa') then {
			
			};
			if (worldName isEqualTo 'Malden') then {
				_position = selectRandom (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingPos -1);
				_position = AGLToASL _position;
				player setDir (_position getDir (([8133.47,10123,-0.147434] nearestObject 'Land_MilOffices_V1_F') buildingExit 0));
			};
			if (worldName isEqualTo 'Enoch') then {
				_position = [((_position select 0) + 12 - (random 24)),((_position select 1) + 12 - (random 24)),(_position select 2)];
			};
		};
		preloadCamera _position;
		player setPosWorld _position;
	};
	player switchMove '';
	{
		player setVariable _x;
	} forEach [
		['QS_client_inBaseArea',TRUE,FALSE]
	];
	call (missionNamespace getVariable 'QS_fnc_respawnPilot');
} else {
	if ((player getVariable 'QS_revive_respawnType') isEqualTo 'FOB') then {
		player switchMove '';
		_position = selectRandom ([(missionNamespace getVariable 'QS_module_fob_HQ'),(((missionNamespace getVariable 'QS_module_fob_HQ') buildingPos -1) select {(!(_x isEqualTo [0,0,0]))})] call (missionNamespace getVariable 'QS_fnc_customBuildingPositions'));
		preloadCamera _position;
		_position spawn {
			uiSleep 0.1;
			player setPos _this;
			player setDir (player getDir (missionNamespace getVariable 'QS_module_fob_HQ'));
			50 cutText [format ['Respawned at FOB %1',(missionNamespace getVariable 'QS_module_fob_displayName')],'PLAIN DOWN'];
		};
		player setVariable ['QS_client_inFOBArea',TRUE,FALSE];
		missionNamespace setVariable ['QS_module_fob_client_timeLastRespawn',(time + 180),FALSE];
	};
};
if (player getUnitTrait 'QS_trait_fighterPilot') then {
	0 spawn {uiSleep 1;createDialog 'QS_client_dialog_menu_roles';};
};
{
	player setVariable _x;
} forEach [
	['QS_revive_respawnType','',FALSE]
];