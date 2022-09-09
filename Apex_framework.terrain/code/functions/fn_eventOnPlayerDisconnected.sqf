/*
File: fn_eventOnPlayerDisconnected.sqf
Author:

	Quiksilver
	
Last modified:

	25/04/2016 A3 1.56 by Quiksilver
	
Description:

	On Player Disconnected
	
	Number - unique DirectPlay ID (very large number). It is also the same id used for user placed markers (same as _id param)
	String - getPlayerUID of the leaving client. The same as Steam ID (same as _uid param)
	String - profileName of the leaving client (same as _name param)
	Boolean - didJIP of the leaving client (same as _jip param)
	Number - owner id of the leaving client (same as _owner param)
__________________________________________________*/

diag_log format ['***** onPlayerDisconnected ***** %1 *****',_this];
if (((_this # 1) select [0,2]) isEqualTo 'HC') then {
	(missionNamespace getVariable 'QS_headlessClients') deleteAt ((missionNamespace getVariable 'QS_headlessClients') find (_this # 4));
	//comment 'De-init headless client';
	if ((missionNamespace getVariable ['QS_headlessClients',[]]) isEqualTo []) then {
		if (missionNamespace getVariable 'QS_HC_Active') then {
			missionNamespace setVariable ['QS_HC_Active',FALSE,TRUE];
		};
		if (getCalculatePlayerVisibilityByFriendly) then {
			calculatePlayerVisibilityByFriendly FALSE;
		};
		if (!getRemoteSensorsDisabled) then {
			disableRemoteSensors TRUE;
		};
	};
	if (allPlayers isNotEqualTo []) then {
		(format ['%1',localize 'STR_QS_Chat_111']) remoteExec ['systemChat',-2,FALSE];
	};
	diag_log (format ['Headless Client %1 ( %2 ) disconnected',(_this # 4),(_this # 1)]);
};