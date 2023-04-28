/*
File: fn_clientEventKilled.sqf
Author: 

	Quiksilver
	
Last modified:

	20/04/2023 A3 2.12 by Quiksilver
	
Description:

	Apply code to player when killed
___________________________________________________________________*/

params ['_co','_killer','_instigator','_usedEffects'];
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
player setVariable ['QS_client_killedPosition',getPosASL player,FALSE];
BIS_fnc_feedback_deltaDamage = 0;
[3,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
if ((actionIDs _co) isNotEqualTo []) then {
	removeAllActions _co;
};
if (!isNull (missionNamespace getVariable ['QS_winch_globalHelperObject',objNull])) then {
	deleteVehicle QS_winch_globalHelperObject;
};
if ((attachedObjects _co) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			if (local _x) then {
				_x awake TRUE;
			} else {
				['awake',_x,TRUE] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
			};
			detach _x;
			if (
				(_x isKindOf 'CAManBase') &&
				{(alive _x)} &&
				{((lifeState _x) isEqualTo 'INCAPACITATED')}
			) then {
				['switchMove',_x,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
			};
		};
	} forEach (attachedObjects _co);
};
if (!isNull (attachedTo _co)) then {
	detach _co;
};
if (!isNull (getConnectedUAV _co)) then {
	_co connectTerminalToUAV objNull;
};
if (_co getUnitTrait 'uavhacker') then {
	removeAllAssignedItems _co;
};
if (!isNull (objectParent _co)) then {
	_co playActionNow 'Die';
	if ((objectParent _co) isKindOf 'AllVehicles') then {
		if (local (objectParent _co)) then {
			(objectParent _co) deleteVehicleCrew _co;
		};
	};
};
uiNamespace setVariable ['QS_client_respawnCooldown',diag_tickTime + 30];
missionNamespace setVariable ['QS_revive_KilledInventory',(getUnitLoadout _co),FALSE];
private _rd = player getVariable ['QS_respawnDelay',-1];
if (_rd isEqualTo -1) then {
	_rd = getMissionConfigValue ['respawnDelay',3];
	player setVariable ['QS_respawnDelay',_rd,FALSE];
};
50 cutText ['','BLACK',_rd];