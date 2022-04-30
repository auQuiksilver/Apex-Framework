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
if (((_this select 1) select [0,2]) isEqualTo 'HC') exitWith {
	(missionNamespace getVariable ['QS_headlessClients',[]]) pushBackUnique (_this select 4);
	//comment 'Init headless client';
	if (!(missionNamespace getVariable 'QS_HC_Active')) then {
		missionNamespace setVariable ['QS_HC_Active',TRUE,TRUE];
	};
	'A headless client has connected' remoteExec ['systemChat',-2,FALSE];
	diag_log (format ['***** SERVER ***** HC Registered ***** %1 * %2 *****',(missionNamespace getVariable 'QS_headlessClients'),(missionNamespace getVariable 'QS_HC_Active')]);
};
