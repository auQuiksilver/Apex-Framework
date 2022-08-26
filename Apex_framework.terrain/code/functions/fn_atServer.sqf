/*
File: fn_atServer.sqf
Author:

	Quiksilver
	
Last modified:

	2/07/2022 A3 2.10 by Quiksilver
	
Description:

	[41,[0,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
__________________________________________________*/

private ['_i','_a','_clientVal','_clientArray','_nameCausedBy','_watchList','_unit','_QS_UID','_message'];
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
if (_posReporter isEqualTo _posCausedBy) exitWith {/*/ Filters out error when player is reported by himself on connection /*/};
if (_type isEqualTo 1) then {
	private _eventLog = missionProfileNamespace getVariable ['QS_robocop_log_2',[]];
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
	missionProfileNamespace setVariable ['QS_robocop_log_2',_eventLog];
	saveMissionProfileNamespace;
	private _clientVal = QS_robocop getOrDefault [_uid,-1];
	diag_log format ['***** fn_atServer ***** UID to robocop: %1 *****',_uid];
	if (_clientVal isEqualTo -1) then {
		QS_robocop set [_uid,_val];	
		[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
	} else {
		_watchList = missionProfileNamespace getVariable 'QS_robocop_watchlist';
		if (_clientVal > 3) then {
			if (!(_uid in _watchList)) then {
				missionProfileNamespace setVariable ['QS_robocop_watchlist',((missionProfileNamespace getVariable 'QS_robocop_watchlist') + [_uid])];
				saveMissionProfileNamespace;
			};
		};
		if (_uid in _watchList) then {
			_val = _val * 2;
		};
		_val = _val + _clientVal;
		diag_log format ['************************ ADMIN ***** %1 ***** %2 has been threat-adjusted to %3 *****',time,_nameCausedBy,_val];
		QS_robocop set [_uid,_val];
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