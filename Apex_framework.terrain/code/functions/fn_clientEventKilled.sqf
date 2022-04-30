/*
File: fn_clientEventKilled.sqf
Author: 

	Quiksilver
	
Last modified:

	7/06/2017 A3 1.70 by Quiksilver
	
Description:

	Apply code to player when killed
___________________________________________________________________*/

params ['_co','_killer','_instigator','_usedEffects'];
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
BIS_fnc_feedback_deltaDamage = 0;
[3,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
if ((actionIDs _co) isNotEqualTo []) then {
	removeAllActions _co;
};
if ((attachedObjects _co) isNotEqualTo []) then {
	{
		if (!isNull _x) then {
			detach _x;
			if (_x isKindOf 'CAManBase') then {
				if (alive _x) then {
					if ((lifeState _x) isEqualTo 'INCAPACITATED') then {
						if (['carr',(animationState _x),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) then {
							['switchMove',_x,'acts_InjuredLyingRifle02'] remoteExec ['QS_fnc_remoteExecCmd',0,FALSE];
						};
					};
				};
			};
		};
	} forEach (attachedObjects _co);
};
if (!isNull (attachedTo _co)) then {
	detach _co;
};
if (!isNull (objectParent _co)) then {
	[0,(objectParent _co)] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
	_co playActionNow 'Die';
};
if (!isNull (getConnectedUAV _co)) then {
	_co connectTerminalToUAV objNull;
};
if (_co getUnitTrait 'uavhacker') then {
	removeAllAssignedItems _co;
};
if (!isNull (objectParent _co)) then {
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