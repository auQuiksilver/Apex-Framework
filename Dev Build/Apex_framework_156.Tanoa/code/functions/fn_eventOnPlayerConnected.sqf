/*
File: fn_eventOnPlayerConnected.sqf
Author:

	Quiksilver
	
Last modified:

	7/10/2018 A3 1.84 by Quiksilver
	
Description:

	On Player Connected
__________________________________________________*/

diag_log (format ['***** onPlayerConnected ***** %1 *****',_this]);
if (((_this # 1) select [0,2]) isEqualTo 'HC') exitWith {
	(missionNamespace getVariable ['QS_headlessClients',[]]) pushBackUnique (_this # 4);
	//comment 'Init headless client';
	if (!(missionNamespace getVariable 'QS_HC_Active')) then {
		missionNamespace setVariable ['QS_HC_Active',TRUE,TRUE];
	};
	if (!getCalculatePlayerVisibilityByFriendly) then {
		calculatePlayerVisibilityByFriendly TRUE;
	};
	if (getRemoteSensorsDisabled) then {
		disableRemoteSensors FALSE;
	};
	(format ['%1',localize 'STR_QS_Chat_110']) remoteExec ['systemChat',-2,FALSE];
	diag_log (format ['***** SERVER ***** HC Registered ***** %1 * %2 *****',(missionNamespace getVariable 'QS_headlessClients'),(missionNamespace getVariable 'QS_HC_Active')]);
};
