/*/
File: fn_serverRestart.sqf
Author:
	
	Quiksilver
	
Last Modified:

	21/10/2023 A3 2.14 by Quiksilver
	
Description:

	Server Restart procedure
______________________________________________________/*/

if (isRemoteExecuted) exitWith {};
scriptName 'QS Restart Procedure';
//comment 'Play unique sound here as a hint';
['playSound','QS_restart'] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
uiSleep 25;		// Roughly 30 second procedure
_text = localize 'STR_QS_Notif_044';
['System',['',_text]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
// Server Restart message
{
	private _endImage = missionNamespace getVariable ['QS_missionConfig_communityLogo',''];
	if (_endImage isEqualTo '') then {
		_endImage = missionNamespace getVariable ['QS_missionConfig_textures_communityFlag','a3\data_f\flags\flag_nato_co.paa'];
	};
	51 cutText [
		(format [
			"<img size='4' image='%1'/><br/><br/><t size='5'>%2</t><br/><br/>",
			_endImage,
			localize 'STR_QS_Utility_000'
		]),
		'PLAIN DOWN',
		5,
		TRUE,
		TRUE
	];
} remoteExec ['call',-2,FALSE];
missionProfileNamespace setVariable ['QS_leaderboards2',(missionNamespace getVariable 'QS_leaderboards2')];	// Leaderboards persistence
{
	_x setVariable ['QS_respawn_disable',-1,TRUE];
} forEach allPlayers;
uiSleep 4;
saveMissionProfileNamespace;
uiSleep 1;
(call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand '#restartserver';