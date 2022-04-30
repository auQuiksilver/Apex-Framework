/*/
File: fn_clientEventArsenalClosed.sqf
Author: 

	Quiksilver

Last Modified:

	21/11/2018 A3 1.86 by Quiksilver

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
			if (!(_itemToRemove in ['ToolKit','Medikit'])) then {
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
_QS_playerRole = player getVariable ['QS_unit_role','rifleman'];
_QS_loadout = getUnitLoadout player;
missionNamespace setVariable ['QS_revive_arsenalInventory',_QS_loadout,FALSE];
private _QS_savedLoadouts = profileNamespace getVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa']))]),[]];
_QS_loadoutIndex = (_QS_savedLoadouts findIf {((_x # 0) isEqualTo _QS_playerRole)});
_a = [_QS_playerRole,_QS_loadout];
if (_QS_loadoutIndex isEqualTo -1) then {
	_QS_savedLoadouts pushBack _a;
} else {
	_QS_savedLoadouts set [_QS_loadoutIndex,_a];
};
profileNamespace setVariable [(format ['QS_RSS_loadouts_%1',(['arid','tropic'] select (worldName in ['Tanoa']))]),_QS_savedLoadouts];
saveProfileNamespace;
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};