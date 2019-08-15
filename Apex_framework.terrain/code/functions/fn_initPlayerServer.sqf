/*/
File: fn_initPlayerServer.sqf
Author:

	Quiksilver
	
Last modified:

	5/01/2019 A3 1.88 by Quiksilver
	
Description:

	Init Player Server
__________________________________________________/*/

scriptName 'QS InitPlayerServer';
params ['_client','_jip','_cid','_uid','_profileName'];
if (!(missionNamespace getVariable ['QS_mission_init',FALSE])) then {
	waitUntil {
		uiSleep 0.1;
		(missionNamespace getVariable ['QS_mission_init',FALSE])
	};
};
_t = diag_tickTime + 15;
waitUntil {
	uiSleep 0.1;
	((!isNull _client) || {(diag_tickTime > _t)})
};
missionNamespace setVariable ['QS_analytics_entities_created',((missionNamespace getVariable 'QS_analytics_entities_created') + 1),FALSE];
if (!(allCurators isEqualTo [])) then {
	{
		if (!isNull (getAssignedCuratorUnit _x)) then {
			_x addCuratorEditableObjects [[_client],FALSE];
		};
	} count allCurators;
};
if (isNull _client) exitWith {};
_ii = (missionNamespace getVariable 'QS_roboCop') findIf {((_x # 0) isEqualTo _uid)};
private _val = 0;
private _a = [_uid,_val];
if (_ii isEqualTo -1) then {
	_a = [_uid,_val];
	(missionNamespace getVariable 'QS_roboCop') pushBack _a;
} else {
	_a = (missionNamespace getVariable 'QS_roboCop') # _ii;
	_val = _a # 1;
	(missionNamespace getVariable 'QS_roboCop') set [_ii,_a];
};
if (_val > 5) exitWith {
	FALSE remoteExecCall ['disableUserInput',_cid,FALSE];
	uiSleep 0.1;
	([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand (format ['#kick %1',_cid]);
};
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
_loginVal = 998;
_client setVariable ['QS_5551212',_loginVal,FALSE];
_client setVariable ['QS_ClientSupporterLevel',_sLevel,FALSE];
[
	[[_uid,_cid,_val,_jip],_sLevel,_loginVal],
	{
		missionNamespace setVariable ['QS_atClientMisc',(_this # 0),FALSE];
		player setVariable ['QS_ClientSupporterLevel',(_this # 1),FALSE];
		player setVariable ['QS_5551212',(_this # 2),FALSE];
		0 spawn (missionNamespace getVariable 'QS_fnc_initPlayerLocal');
	}
] remoteExec ['call',_cid,FALSE];