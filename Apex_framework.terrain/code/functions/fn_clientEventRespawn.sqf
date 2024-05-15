/*/
File fn_clientEventRespawn.sqf
Author: 

	Quiksilver
	
Last modified:

	28/03/2023 A3 2.12 by Quiksilver
	
Description:

	Apply code to client on respawn
_______________________________________________/*/

params [['_newUnit',player],['_oldUnit',objNull]];
QS_player = missionNamespace getVariable ['bis_fnc_moduleRemoteControl_unit',_newUnit];
simulWeatherSync;
if (captive player) then {
	player setCaptive FALSE;
};
if (isForcedWalk player) then {
	player forceWalk FALSE;
};
{
	missionNamespace setVariable _x;
} forEach [
	['BIS_respawned',TRUE,FALSE],
	['BIS_oldDMG',0,FALSE],
	['BIS_deltaDMG',0,FALSE]
];
{
	uiNamespace setVariable _x;
} forEach [
	['QS_client_playerViewChanged',TRUE]
];
{
	player setVariable _x;
} forEach [
	['QS_revive_respawnType','',FALSE],
	['QS_RD_interacting',FALSE,TRUE],
	['QS_RD_loaded',FALSE,TRUE],
	['QS_event_handleHeal',nil,TRUE],
	['QS_revive_disable',FALSE,(player getVariable ['QS_revive_disable',FALSE])],
	['QS_respawn_disable',-1,FALSE],
	['QS_client_medevacRequested',FALSE,FALSE]
];
50 cutText ['','BLACK IN',1];
{
	inGameUISetEventHandler _x;
} forEach [
	['Action',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIAction');"]//,
	//['NextAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUINextAction');"],
	//['PrevAction',"_this call (missionNamespace getVariable 'QS_fnc_clientInGameUIPrevAction');"]
];
player setVehicleReportRemoteTargets (player getUnitTrait 'QS_trait_JTAC');
disableRemoteSensors TRUE;
if ((missionNamespace getVariable ['QS_missionConfig_stamina',0]) isEqualTo 1) then {
	player enableStamina TRUE;
} else {
	player enableStamina ((player getVariable 'QS_stamina') # 0);
};
player setCustomAimCoef ((player getVariable 'QS_stamina') # 1);
player disableConversation TRUE;
player enableAIFeature ['RADIOPROTOCOL',FALSE];
showSubtitles FALSE;
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
		if ((toLowerANSI (face player)) isNotEqualTo (toLowerANSI _profileFace)) then {
			['setFace',player,_profileFace] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};
if ((toLowerANSI (speaker player)) isNotEqualTo 'novoice') then {
	player setSpeaker 'NoVoice';
};
player addRating (0 - (rating player));
if (!((getPlayerUID player) in (['CURATOR'] call (missionNamespace getVariable 'QS_fnc_whitelist')))) then {
	{
		player enableAIFeature [_x,FALSE];
	} forEach [
		'TEAMSWITCH',
		'FSM',
		'AIMINGERROR',
		'COVER',
		'AUTOCOMBAT'
	];
};
player setUnitFreefallHeight 65;
player enableAIFeature ['MOVE',TRUE];
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) in [0,1]) then {
	enableEngineArtillery FALSE;
};
if (player getUnitTrait 'QS_trait_HQ') then {
	missionNamespace setVariable ['QS_hc_Commander',player,TRUE];
};
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
if ((player getVariable 'QS_ClientUnitInsignia2') isNotEqualTo '') then {
	[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
};
if (!((player getVariable ['QS_tto',0]) < 1.5)) then {
	player disableTIEquipment TRUE;
};
if (!isNull _oldUnit) then {
	if ((getAllOwnedMines _oldUnit) isNotEqualTo []) then {
		{
			player addOwnedMine _x;
		} count (getAllOwnedMines _oldUnit);
	};
};
if ((missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') isNotEqualTo []) then {
	(missionNamespace getVariable 'QS_client_action_carrierLaunchCancel') params [
		'_actionVehicle',
		'_actionAction'
	];
	if (!isNull _actionVehicle) then {
		_actionVehicle removeAction _actionAction;
	};
	missionNamespace setVariable ['QS_client_action_carrierLaunchCancel',[],FALSE];
};
if ((call (missionNamespace getVariable 'QS_fnc_clientGetSupporterLevel')) > 0) then {
	0 spawn {
		uiSleep 1;
		if (
			((player getVariable 'QS_ClientUTexture2') isNotEqualTo '') &&
			((player getVariable 'QS_ClientUTexture2_Uniforms2') isNotEqualTo []) &&
			((uniform player) in (player getVariable 'QS_ClientUTexture2_Uniforms2'))
		) then {
			player setObjectTextureGlobal [0,(player getVariable 'QS_ClientUTexture2')];
			if ((vest player) isNotEqualTo '') then {
			
			};
			if ((backpack player) isNotEqualTo '') then {
			
			};
		};
	};
};
if (!isNull _oldUnit) then {
	([_oldUnit,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
	if (_inSafezone && _safezoneActive) then {
		deleteVehicle _oldUnit;
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
private _deploymentData = ['GET_HOME_DATA'] call QS_fnc_deployment;
if (_deploymentData isEqualTo []) then {
	_deploymentData = ['GET_DEFAULT_DATA'] call QS_fnc_deployment;
};
['SELECT',_deploymentData] call QS_fnc_deployment;
['SET_SAVED_LOADOUT',(player getVariable ['QS_unit_role','rifleman'])] call (missionNamespace getVariable 'QS_fnc_roles');
[2,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
[29,(missionNamespace getVariable 'QS_module_fob_side')] call (missionNamespace getVariable 'QS_fnc_remoteExec');
if (
	(missionNamespace getVariable ['QS_missionConfig_deployment',TRUE]) &&
	{(missionNamespace getVariable ['QS_missionConfig_respawnDeploy',FALSE])}
) then {
	0 spawn {
		localNamespace setVariable ['QS_deploymentMenu_forceDeploy',TRUE];
		sleep 3;
		localNamespace setVariable ['QS_deploymentMenu_forceDeploy',FALSE];
	};
	['RESPAWN'] call QS_fnc_clientInteractDeploy;
};
if ((player getVariable ['QS_unit_side',WEST]) isNotEqualTo WEST) then {
	[1,player] call QS_fnc_clientRespawnPosition;
};