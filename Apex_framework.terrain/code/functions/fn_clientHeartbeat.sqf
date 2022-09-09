/*
File: fn_clientHeartbeat.sqf
Author:
	
	Quiksilver
	
Last Modified:

	28/05/2017 A3 1.70 by Quiksilver

Description:

	Client Heart Beat
__________________________________________________________*/

if (isDedicated) exitWith {};
if (!hasInterface) exitWith {};
_t = time;
if (_t > 120) then {
	if (
		((missionNamespace getVariable 'QS_client_heartbeat') < (_t - 60)) ||
		{((missionNamespace getVariable 'QS_client_heartbeat') > (_t + 60))}
	) then {
		[
			40,
			[
				_t,
				serverTime,
				(name player),
				profileName,
				profileNameSteam,
				(getPlayerUID player),
				1,
				localize 'STR_QS_Menu_117',
				player
			]
		] remoteExec ['QS_fnc_remoteExec',2,FALSE];
		if ((missionNamespace getVariable 'QS_heartAttacks') < 3) then {
			with uiNamespace do {
				uiSleep 0.1;
				[ 
					localize 'STR_QS_Menu_116',
					localize 'STR_QS_Menu_109',
					TRUE, 
					FALSE, 
					(findDisplay 46), 
					FALSE, 
					FALSE 
				] call (missionNamespace getVariable 'BIS_fnc_GUImessage');
			};
			missionNamespace setVariable [
				'QS_heartAttacks',
				((missionNamespace getVariable 'QS_heartAttacks') + 1),
				TRUE
			];
			endMission 'QS_RD_end_2';
		};
	};
};