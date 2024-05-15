/*/
File: fn_initPlayerServer.sqf
Author:

	Quiksilver
	
Last modified:

	7/03/2024 A3 2.18 by Quiksilver
	
Description:

	Init Player Server
__________________________________________________/*/

scriptName 'QS InitPlayerServer';
//[playerID, owner, playerUID, soldierName, displayName, steamProfileName, 
//clientStateNumber, isHeadless, adminState, networkInfo, playerObject]
params [
	'_playerID',
	'_cid',
	'_uid',
	'_profileName',
	'_displayName',
	'_profileNameSteam',
	'_clientStateNumber',
	'_isHeadless',
	'_adminState',
	'_networkInfo',
	'_client'
];

//params ['_client','_jip','_cid','_uid','_profileName'];
if (!(missionNamespace getVariable ['QS_mission_init',FALSE])) then {
	waitUntil {
		uiSleep 0.1;
		(missionNamespace getVariable ['QS_mission_init',FALSE])
	};
};
if (_isHeadless) exitWith {diag_log 'Headless client connecting - exiting QS_fnc_initPlayerServer.sqf';};
//if (_client isKindOf 'HeadlessClient_F') exitWith {diag_log 'Headless client connecting - exiting QS_fnc_initPlayerServer.sqf';};
if (isNull _client) exitWith {};
if (allCurators isNotEqualTo []) then {
	{
		if (!isNull (getAssignedCuratorUnit _x)) then {
			_x addCuratorEditableObjects [[_client],FALSE];
		};
	} count allCurators;
};
//===== ROBOCOP
_val = QS_robocop getOrDefault [_uid,0,TRUE];
if (_val > 5) exitWith {
	FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
	uiSleep 0.1;
	(call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#kick %1',_cid]);
};
//===== Supporter Level
private _sLevel = 0;
if (_uid in (['S3'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {
	_sLevel = 2;
};
if (_cid < 3) exitWith {
	diag_log format ['***** DEBUG ***** Invalid Client Owner: %1 *****',_cid];
};
/*/ EXTDB3 - Database - Client Registry could go here /*/
['HANDLE',['HANDLE_CONNECT',_this]] call (missionNamespace getVariable 'QS_fnc_roles');
if ((missionNamespace getVariable ['QS_missionConfig_CAS',2]) isEqualTo 3) then {
	if (_uid in (['CAS'] call (missionNamespace getVariable 'QS_fnc_whitelist'))) then {		/*/EXTDB3 - Database - This is where you would check client if client is in CAS database/*/
		private _aircraftPool = 0;
		private _airIndex = (missionNamespace getVariable 'QS_CAS_jetAllowance') findIf {((_x # 0) isEqualTo _uid)};
		if (_airIndex isEqualTo -1) then {
			(missionNamespace getVariable 'QS_CAS_jetAllowance') pushBack [_uid,_aircraftPool];
		} else {
			_aircraftPool = ((missionNamespace getVariable 'QS_CAS_jetAllowance') # _airIndex) # 1;
		};
		_client setVariable ['QS_client_casAllowance',_aircraftPool,[2,_cid]];
	};
};
private _builtList = QS_hashmap_playerBuildables getOrDefault [_uid,[],TRUE];
if (_builtList isNotEqualTo []) then {
	_builtList = _builtList select {!isNull _x};
	{
		if (!isNull _x) then {
			_x setOwner _cid;
		};
	} forEach _builtList;	
	[_builtList,_cid] spawn {
		params ['_builtList','_cid'];
		private _timeout = 0;
		{
			if (!isNull _x) then {
				_timeout = diag_tickTime + 3;
				waitUntil {
					((_x setOwner _cid) || (diag_tickTime > _timeout))
				};
			};
		} forEach _builtList;
	};
	QS_hashmap_playerBuildables set [_uid,_builtList];
};
_loginVal = 998;
// Dynamic Groups
_grp = group _client;
{
	_grp setVariable _x;
} forEach [
	['BIS_dg_reg',TRUE,TRUE],
	['BIS_dg_cre',_client,TRUE],
	['BIS_dg_pri',FALSE,TRUE],
	['BIS_dg_var',format ['%1_%2_%3',groupId _grp,_uid,time],TRUE]
];
_grp setGroupIdGlobal [groupId _grp];
_client setVariable ['QS_5551212',_loginVal,FALSE];
_client setVariable ['QS_ClientSupporterLevel',_sLevel,FALSE];
private _notifyWhitelist = _uid in (missionProfileNamespace getVariable ['QS_whitelists_toInform',[]]);
if (_notifyWhitelist) then {
	(missionProfileNamespace getVariable 'QS_whitelists_toInform') deleteAt ((missionProfileNamespace getVariable ['QS_whitelists_toInform',[]]) find _uid);
};
[
	[[_uid,_cid,_val],_sLevel,_loginVal,_notifyWhitelist],
	{
		_info = _this # 0;
		_info pushBack didJIP;
		missionNamespace setVariable ['QS_atClientMisc',_info,FALSE];
		player setVariable ['QS_ClientSupporterLevel',(_this # 1),FALSE];
		player setVariable ['QS_5551212',(_this # 2),FALSE];
		0 spawn (missionNamespace getVariable 'QS_fnc_initPlayerLocal');
		if (_this # 3) then {
			0 spawn (missionNamespace getVariable 'QS_fnc_leaderboardNotifyWhitelist');
		};
	}
] remoteExec ['call',_cid,FALSE];