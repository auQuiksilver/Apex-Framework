/*
File: fn_clientEventKilled.sqf
Author: 

	Quiksilver
	
Last modified:

	7/06/2017 A3 1.70 by Quiksilver
	
Description:

	Apply code to player when killed
___________________________________________________________________*/

params ['_co','_killer','_instigator','_useEffects'];
if (currentChannel > 5) then {
	setCurrentChannel 5;
};
[3,-1] spawn (missionNamespace getVariable 'QS_fnc_clientRadio');
if (!((actionIDs _co) isEqualTo [])) then {
	removeAllActions _co;
};
if (!((attachedObjects _co) isEqualTo [])) then {
	{
		if (!isNull _x) then {
			detach _x;
		};
	} count (attachedObjects _co);
};
if (!isNull (attachedTo _co)) then {
	detach _co;
};
if (!isNull (objectParent _co)) then {
	_co playActionNow 'Die';
};
if (!isNull (getConnectedUAV _co)) then {
	_co connectTerminalToUAV objNull;
};
if (_co getUnitTrait 'uavhacker') then {
	removeAllAssignedItems _co;
};
missionNamespace setVariable ['QS_revive_KilledInventory',(getUnitLoadout _co),FALSE];	
player setVariable ['QS_FiredInAO',FALSE,TRUE];
private _rd = player getVariable ['QS_respawnDelay',-1];
if (_rd isEqualTo -1) then {
	_rd = getMissionConfigValue ['respawnDelay',3];
	player setVariable ['QS_respawnDelay',_rd,FALSE];
};
50 cutText ['','BLACK',_rd];