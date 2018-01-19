/*
File fn_clientEventRespawn.sqf
Author: 

	Quiksilver
	
Last modified:

	31/05/2017 A3 1.70 by Quiksilver
	
Description:

	Apply code to client on respawn
___________________________________________________________________*/

params [['_newUnit',objNull],['_oldUnit',objNull]];
private _position = AGLToASL (markerPos 'QS_marker_base_marker');
missionNamespace setVariable ['BIS_respawned',TRUE,FALSE];

/*/================================================================= RESET GEAR/*/

if (!isNil {missionNamespace getVariable 'QS_revive_arsenalInventory'}) then {
	player setUnitLoadout [(missionNamespace getVariable 'QS_revive_arsenalInventory'),TRUE];
} else {
	player setUnitLoadout [(missionNamespace getVariable 'QS_revive_KilledInventory'),TRUE];
};

/*/================================================================= COMMON/*/

if (captive player) then {
	player setCaptive FALSE;
};
if (isForcedWalk player) then {
	player forceWalk FALSE;
};
if ((player getVariable 'QS_revive_respawnType') in ['BASE','']) then {
	if ((missionNamespace getVariable ['QS_missionConfig_carrierRespawn',0]) isEqualTo 2) then {
		['RESPAWN_PLAYER'] call (missionNamespace getVariable 'QS_fnc_carrier');
	} else {
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
		preloadCamera _position;
		player setPosWorld _position;
	};
	player switchMove '';
	{
		player setVariable _x;
	} forEach [
		['QS_client_inBaseArea',TRUE,FALSE]
	];
	[] call (missionNamespace getVariable 'QS_fnc_respawnPilot');
	if (missionNamespace getVariable 'QS_module_fob_client_respawnEnabled') then {
		/*/50 cutText ['Personal Respawn Beacon de-activated!','PLAIN'];/*/
		/*/missionNamespace setVariable ['QS_module_fob_client_respawnEnabled',FALSE,FALSE];/*/
	};
} else {
	if ((player getVariable 'QS_revive_respawnType') isEqualTo 'FOB') then {
		player switchMove '';
		_position = (missionNamespace getVariable 'QS_module_fob_HQ') buildingPos (selectRandom [0,1,2,3,9,10,11,12]);
		preloadCamera _position;
		player setPos _position;
		player setDir (player getDir (missionNamespace getVariable 'QS_module_fob_HQ'));
		player setVariable ['QS_client_inFOBArea',TRUE,FALSE];
		missionNamespace setVariable ['QS_module_fob_client_timeLastRespawn',(time + 180),FALSE];
		50 cutText [format ['Respawned at FOB %1',(missionNamespace getVariable 'QS_module_fob_displayName')],'PLAIN DOWN'];
	};
};
{
	player setVariable _x;
} forEach [
	['QS_RD_interacting',FALSE,TRUE],
	['QS_RD_interacted',FALSE,TRUE],
	['QS_RD_draggable',FALSE,TRUE],
	['QS_RD_carryable',FALSE,TRUE],
	['QS_RD_loadable',FALSE,TRUE],
	['QS_RD_loaded',FALSE,TRUE],
	['QS_RD_escorting',FALSE,TRUE],
	['QS_RD_escortable',FALSE,TRUE],
	['QS_RD_interaction_busy',FALSE,FALSE],
	['QS_event_handleHeal',nil,TRUE],
	['QS_revive_respawnType','',FALSE],
	['QS_revive_disable',FALSE,TRUE],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
50 cutText ['','BLACK IN',1];
{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"],
	['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];

/*/========================== Common respawn stuff (other)/*/

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
if (!((toLower (speaker player)) == 'novoice')) then {
	player setSpeaker 'NoVoice';
};
player addRating (0 - (rating player));
{
	player disableAI _x;
} count [
	'TEAMSWITCH',
	'FSM',
	'AIMINGERROR',
	'SUPPRESSION',
	'COVER',
	'AUTOCOMBAT'
];
player enableAI 'MOVE';
_playerClass = typeOf player;
if (['medic',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['medic',TRUE,FALSE];
};
if (['engineer',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['engineer',TRUE,FALSE];
};
if (['exp',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['explosivespecialist',TRUE,FALSE];
};
if (['uav',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['uavhacker',TRUE,FALSE];
};
if (['recon',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['audibleCoef',0.5,FALSE];
};
if ((['sniper',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || (['ghillie',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || (['spotter',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
	player setUnitTrait ['camouflageCoef',0.5,FALSE];
};
if ((['_SL_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || (['_TL_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) then {
	player setUnitTrait ['loadCoef',0.5,FALSE];
};
if (['pilot',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['QS_trait_pilot',TRUE,TRUE];
};
if (['_AR_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['loadCoef',0.75,FALSE];
};
player setUnitTrait ['QS_trait_AT',FALSE,TRUE];
if ((['_AT_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['_LAT_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
	player setUnitTrait ['QS_trait_AT',TRUE,TRUE];
};
enableEngineArtillery FALSE;
player setUnitTrait ['QS_trait_gunner',FALSE,TRUE];
if (['_Mort_',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['QS_trait_gunner',TRUE,TRUE];
};
player setUnitTrait ['QS_trait_HQ',FALSE,TRUE];
if (['officer',_playerClass,FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
	player setUnitTrait ['QS_trait_HQ',TRUE,TRUE];
	missionNamespace setVariable ['QS_hc_Commander',player,TRUE];
};

[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
[2,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
if (!((player getVariable 'QS_ClientUnitInsignia2') isEqualTo '')) then {
	[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
};
if (!((player getVariable ['QS_tto',0]) < 1.5)) then {
	player disableTIEquipment TRUE;
};
if (!((getAllOwnedMines _oldUnit) isEqualTo [])) then {
	{
		player addOwnedMine _x;
	} count (getAllOwnedMines _oldUnit);
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
	TRUE spawn {
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
		//[17,_oldUnit] remoteExec ['QS_fnc_remoteExec',2,FALSE];
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