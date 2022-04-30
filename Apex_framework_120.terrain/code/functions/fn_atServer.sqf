/*
File: fn_atServer.sqf
Author:

	Quiksilver
	
Last modified:

	26/10/2016 A3 1.64 by Quiksilver
	
Description:

	[41,[0,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
__________________________________________________*/

private [
	'_i','_a','_clientVal','_clientArray',
	'_nameCausedBy','_inWatchList','_watchList',
	'_unit','_QS_UID','_message','_staffID','_i'
];
_array = _this # 1;
_array params [
	'_type',
	'_uid',
	'',
	'_nameCausedBy',
	'_reporter',
	'_val',
	'_jip'
];
private _causedBy = objNull;
{
	if ((getPlayerUID _x) isEqualTo _uid) exitWith {
		_causedBy = _x;
	};
} forEach allPlayers;
private _cid = owner _causedBy;
private _uidCausedBy = getPlayerUID _causedBy;
private _nameReporter = name _reporter;
private _uidReporter = getPlayerUID _reporter;
private _posReporter = getPosWorld _reporter;
private _posCausedBy = getPosWorld _causedBy;
if (_type isEqualTo 1) then {
	private _eventLog = profileNamespace getVariable ['QS_robocop_log_2',[]];
	if ((count _eventLog) >= 100) then {
		_eventLog deleteAt 0;
	};
	_eventLog pushBack [
		systemTime,
		_array # 1,
		_array # 3,
		_array # 4,
		_array # 5,
		_array # 6
	];
	profileNamespace setVariable ['QS_robocop_log_2',_eventLog];
	saveProfileNamespace;

	_i = ((missionNamespace getVariable 'QS_roboCop') findIf {((_x # 0) isEqualTo _uid)});
	diag_log format ['***** fn_atServer ***** UID to robocop: %1 *****',_uid];
	if (_i isEqualTo -1) then {
		_a = [_uid,_val];
		0 = (missionNamespace getVariable 'QS_roboCop') pushBack _a;		
		[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
	} else {
		_clientArray = (missionNamespace getVariable 'QS_roboCop') # _i;
		_clientVal = _clientArray # 1;
		_watchList = profileNamespace getVariable 'QS_robocop_watchlist';
		if (_clientVal > 3) then {
			if (!(_uid in _watchList)) then {
				profileNamespace setVariable [
					'QS_robocop_watchlist',
					((profileNamespace getVariable 'QS_robocop_watchlist') + [_uid])
				];
				saveProfileNamespace;
			};
		};
		if (_uid in _watchList) then {
			_val = _val * 2;
		};
		_val = _val + _clientVal;
		diag_log format ['************************ ADMIN ***** %1 ***** %2 has been threat-adjusted to %3 *****',time,_nameCausedBy,_val];
		_a = [_uid,_val];
		(missionNamespace getVariable 'QS_roboCop') set [_i,_a];
		[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
	};
	_message = format ['ROBOCOP: %1 has been reported',_nameCausedBy];
	_QS_UID = ['ALL'] call (missionNamespace getVariable 'QS_fnc_whitelist');
	private _arrayToSend = [];
	{
		_unit = _x;
		if ((getPlayerUID _unit) in _QS_UID) then {
			0 = _arrayToSend pushBack _unit;
		};
	} count allPlayers;
	if (_arrayToSend isNotEqualTo []) then {
		[nil,[_message,objNull,0]] remoteExec ['QS_fnc_msgToStaff',_arrayToSend,FALSE];
	};
	diag_log format ["************************ ADMIN - %1 - %2 %3 - was reported by %4 %5 - Location of Reported: %6 Location of Reporter: %7 ************************",time,_nameCausedBy,_uid,_nameReporter,_uidReporter,_posCausedBy,_posReporter];
};
if (_type isEqualTo 0) then {
	diag_log format ["************************ ADMIN - %1 - %2 %3 - was NOT reported by %4 %5 - Location of Not-Reported: %6 Location of Reporter: %7 ************************",time,_nameCausedBy,_uid,_nameReporter,_uidReporter,_posCausedBy,_posReporter];
};