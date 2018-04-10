/*/
File: fn_clientEventArsenalClosed.sqf
Author: 

	Quiksilver

Last Modified:

	10/03/2018 A3 1.81 by Quiksilver

Description:

	Event Arsenal Closed
_______________________________________________/*/

_QS_playerClass = typeOf player;
_QS_loadout = getUnitLoadout player;
missionNamespace setVariable ['QS_revive_arsenalInventory',_QS_loadout,FALSE];
private _QS_savedLoadouts = profileNamespace getVariable 'QS_saved_loadouts';
_QS_loadoutIndex = (_QS_savedLoadouts findIf {((_x select 0) isEqualTo _QS_playerClass)});
_a = [_QS_playerClass,_QS_loadout];
if (_QS_loadoutIndex isEqualTo -1) then {
	_QS_savedLoadouts pushBack _a;
} else {
	_QS_savedLoadouts set [_QS_loadoutIndex,_a];
};
profileNamespace setVariable ['QS_saved_loadouts',_QS_savedLoadouts];
saveProfileNamespace;
if ((getPlayerUID player) in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	0 spawn {
		uiSleep 0.1;
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
		if (!((player getVariable 'QS_ClientUnitInsignia2') isEqualTo '')) then {
			[(player getVariable 'QS_ClientUnitInsignia2')] call (missionNamespace getVariable 'QS_fnc_clientSetUnitInsignia');
		};
	};
};
/*/===== Correct overfilled containers/*/

private _itemToRemove = '';
if (!((backpack player) isEqualTo '')) then {
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
if (!((vest player) isEqualTo '')) then {
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
if (!((uniform player) isEqualTo '')) then {
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
if (!(missionNamespace getVariable ['QS_client_triggerGearCheck',FALSE])) then {
	missionNamespace setVariable ['QS_client_triggerGearCheck',TRUE,FALSE];
};