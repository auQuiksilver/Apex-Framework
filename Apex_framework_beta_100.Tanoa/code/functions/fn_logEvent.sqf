/*
File: fn_logEvent.sqf
Author: 

	Quiksilver

Last Modified:

	20/03/2017 A3 1.68 by Quiksilver

Description:

	Log Event
____________________________________________________________________________*/

_array = _this select 1;
diag_log '*******************************';
diag_log format [
	'***** ANTI-HACK ***** Time: %1 * Server Time: %2 * Name: %3 * Profile Name: %4 * Steam Name: %5 * UID: %6 * Detection Level: %7 * Detection: %8 * Object: %9 *****',
	(_array select 0),
	(_array select 1),
	(_array select 2),
	(_array select 3),
	(_array select 4),
	(_array select 5),
	(_array select 6),
	(_array select 7),
	(_array select 8)
];
diag_log '*******************************';
_QS_UID = ['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist');
if ((_array select 5) in _QS_UID) exitWith {};
private _message = parseText format ['ROBOCOP believes %1 has hacked the server.<br/><br/> Detected: %2',(str (_array select 2)),(str (_array select 7))];
if ((_array select 6) > 1) then {
	([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#exec kick %1',(owner (_array select 8))]);
	private _arrayToSend = [];
	{
		_unit = _x;
		if ((getPlayerUID _unit) in _QS_UID) then {
			0 = _arrayToSend pushBack (owner _unit);
		};
	} count allPlayers;
	if (!(_arrayToSend isEqualTo [])) then {
		['hint',_message] remoteExec ['QS_fnc_remoteExecCmd',_arrayToSend,FALSE];
		['systemChat',_message] remoteExec ['QS_fnc_remoteExecCmd',_arrayToSend,FALSE];
	};
} else {	
	if ((!(['RscUnitInfoAirRTDFullDigital',(_array select 7),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) && (!(['game thread',(_array select 7),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))) then {
		private _arrayToSend = [];
		{
			_unit = _x;
			if ((getPlayerUID _unit) in _QS_UID) then {
				0 = _arrayToSend pushBack (owner _unit);
			};
		} count allPlayers;
		if (!(_arrayToSend isEqualTo [])) then {
			[nil,[_message,(_array select 8),1]] remoteExec ['QS_fnc_msgToStaff',_arrayToSend,FALSE];
		};
	};
};