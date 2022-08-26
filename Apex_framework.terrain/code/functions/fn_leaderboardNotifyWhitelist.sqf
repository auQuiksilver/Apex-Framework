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
			"Congratulations! You have been WHITELISTED for a role for the week, for finishing Top 3 on the weekly Leaderboard in that role",
			'Leaderboards',
			TRUE, 
			FALSE, 
			(findDisplay 46), 
			FALSE, 
			FALSE 
		] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
	};
};