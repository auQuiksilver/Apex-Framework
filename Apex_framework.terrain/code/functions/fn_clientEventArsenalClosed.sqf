/*/
File: fn_clientEventArsenalClosed.sqf
Author: 

	Quiksilver

Last Modified:

	24/12/2022 A3 2.10 by Quiksilver

Description:

	Event Arsenal Closed
_______________________________________________/*/

if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	0 spawn {
		uiSleep 0.1;
		if ((player getVariable 'QS_ClientUTexture2') isNotEqualTo '') then {
			if ((player getVariable 'QS_ClientUTexture2_Uniforms2') isNotEqualTo []) then {
				if ((uniform player) in (player getVariable 'QS_ClientUTexture2_Uniforms2')) then {
					player setObjectTextureGlobal [0,(player getVariable 'QS_ClientUTexture2')];
					if ((vest player) isNotEqualTo '') then {
					
					};
					if ((backpack player) isNotEqualTo '') then {
					
					};
				};
			};
		};
		if ((player getVariable 'QS_ClientUnitInsignia2') isNotEqualTo '') then {
			[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
		};
	};
};
/*/===== Correct overfilled containers/*/

private _itemToRemove = '';
if ((backpack player) isNotEqualTo '') then {
	_maxLoadBackpack = 1;
	if ((loadBackpack player) > _maxLoadBackpack) then {
		while {((loadBackpack player) > _maxLoadBackpack)} do {
			_itemToRemove = selectRandom ((backpackItems player) + (backpackMagazines player));
			if (!((toLowerANSI _itemToRemove) in (QS_core_classNames_itemToolKits + QS_core_classNames_itemMedikits))) then {
				player removeItemFromBackpack _itemToRemove;
			};
			if (canSuspend) then {
				uiSleep 0.01;
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
			if (canSuspend) then {
				uiSleep 0.01;
			};
		};
	};
};
if ((uniform player) isNotEqualTo '') then {
	_maxLoadUniform = 1;
	if ((loadUniform player) > _maxLoadUniform) then {
		while {((loadUniform player) > _maxLoadUniform)} do {
			_itemToRemove = selectRandom ((uniformItems player) + (uniformMagazines player));
			player removeItemFromUniform _itemToRemove;
			if (canSuspend) then {
				uiSleep 0.01;
			};
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
_QS_playerRole = player getVariable ['QS_unit_role','rifleman'];
_QS_loadout = getUnitLoadout player;
missionNamespace setVariable ['QS_revive_arsenalInventory',_QS_loadout,FALSE];
private _QS_savedLoadouts = missionProfileNamespace getVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa']))]),[]];
_QS_loadoutIndex = (_QS_savedLoadouts findIf {((_x # 0) isEqualTo _QS_playerRole)});
_a = [_QS_playerRole,_QS_loadout];
if (_QS_loadoutIndex isEqualTo -1) then {
	_QS_savedLoadouts pushBack _a;
} else {
	_QS_savedLoadouts set [_QS_loadoutIndex,_a];
};
missionProfileNamespace setVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa']))]),_QS_savedLoadouts];
saveMissionProfileNamespace;
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};