/*
File: fn_logEvent.sqf
Author: 

	Quiksilver

Last Modified:

	01/05/2023 A3 1.68 by Quiksilver

Description:

	Log Event
____________________________________________________________________________*/

_array = _this # 1;
diag_log '*******************************';
diag_log (format [localize 'STR_QS_DiagLogs_138',(_array # 0),(_array # 1),(_array # 2),(_array # 3),(_array # 4),(_array # 5),(_array # 6),(_array # 7),(_array # 8)]);
diag_log '*******************************';

private _eventLog = missionProfileNamespace getVariable ['QS_robocop_log_1',[]];
if ((count _eventLog) >= 100) then {
	_eventLog deleteAt 0;
};
_eventLog pushBack [
	systemTime,
	_array # 1,
	_array # 3,
	_array # 4,
	_array # 5,
	_array # 6,
	_array # 7
];
missionProfileNamespace setVariable ['QS_robocop_log_1',_eventLog];
saveMissionProfileNamespace;
_QS_UID = ['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist');
if ((_array # 5) in _QS_UID) exitWith {};
private _message = parseText (format [localize 'STR_QS_Chat_137',(str (_array # 2)),(str (_array # 7))]);
if ((_array # 6) > 1) then {
	(call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#kick %1',(owner (_array # 8))]);
	private _arrayToSend = [];
	{
		_unit = _x;
		if ((getPlayerUID _unit) in _QS_UID) then {
			0 = _arrayToSend pushBack (owner _unit);
		};
	} count allPlayers;
	if (_arrayToSend isNotEqualTo []) then {
		['hint',_message] remoteExec ['QS_fnc_remoteExecCmd',_arrayToSend,FALSE];
		['systemChat',_message] remoteExec ['QS_fnc_remoteExecCmd',_arrayToSend,FALSE];
	};
} else {	
	if ((!(['RscUnitInfoAirRTDFullDigital',(_array # 7),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))) && (!(['game thread',(_array # 7),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')))) then {
		private _arrayToSend = [];
		{
			_unit = _x;
			if ((getPlayerUID _unit) in _QS_UID) then {
				0 = _arrayToSend pushBack (owner _unit);
			};
		} count allPlayers;
		if (_arrayToSend isNotEqualTo []) then {
			[nil,[_message,(_array # 8),1]] remoteExec ['QS_fnc_msgToStaff',_arrayToSend,FALSE];
		};
	};
};