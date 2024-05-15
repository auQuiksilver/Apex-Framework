/*/ 
File: fn_initClientLocal.sqf 
Author:

	Quiksilver
	
Last Modified:

	19/10/2020 A3 2.00 by Quiksilver
	
Description:

	Client Initialization 
______________________________________________________/*/
if (isDedicated || !isMultiplayer || is3DEN) exitWith {};
if (!((uiNamespace getVariable ['BIS_shownChat',TRUE]) isEqualType TRUE)) exitWith {
	[
		40,
		[
			time,
			serverTime,
			(name player),
			profileName,
			profileNameSteam,
			(getPlayerUID player),
			2,
			(format ['Anti-Hack * BIS_shownChat : %1',(uiNamespace getVariable 'BIS_shownChat'),2]),
			player,
			productVersion
		]
	] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	//disableUserInput TRUE;
	endMission 'QS_RD_end_2';
};
if (!(hasInterface)) exitWith {
	0 spawn (missionNamespace getVariable 'QS_fnc_hcCore');
	0 spawn (missionNamespace getVariable 'QS_fnc_AI');
};