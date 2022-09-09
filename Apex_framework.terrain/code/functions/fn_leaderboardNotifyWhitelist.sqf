/*/
File: fn_leaderboardNotifyWhitelist.sqf
Author:

	Quiksilver
	
Last Modified:

	20/07/2022 A3 2.10 by Quiksilver
	
Description:

	Notify Player of being added to whitelist
______________________________________________________/*/

waitUntil {
	uiSleep 5;
	!(isNull (uiNamespace getVariable ['QS_client_dialog_menu_roles',displayNull]))
};
uiSleep 0.5;
with uiNamespace do {
	0 spawn {
		[
			localize 'STR_QS_Menu_147',
			localize 'STR_QS_Menu_030',
			TRUE, 
			FALSE, 
			(findDisplay 46), 
			FALSE, 
			FALSE 
		] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
	};
};