/*
File: fn_atAdjust.sqf
Author:

	Quiksilver
	
Last modified:

	21/07/2015 ArmA 3 1.48 by Quiksilver
	
Description:

	-
__________________________________________________*/

private [
	'_array','_target','_val','_uid','_cid','_i','_clientArray','_clientVal','_a','_adjuster','_targetName'
];

_array = _this select 1;
_target = _array select 0;
_val = _array select 1;
_adjuster = _array select 2;
_uid = getPlayerUID _target;
_cid = owner _target;
_i = ((missionNamespace getVariable 'QS_roboCop') findIf {((_x select 0) isEqualTo _uid)});
_clientArray = (missionNamespace getVariable 'QS_roboCop') select _i;
_clientVal = _clientArray select 1;
_a = [_uid,_val];
(missionNamespace getVariable 'QS_roboCop') set [_i,_a];
_targetName = name _target;
if (_val > 9) exitWith {
	for '_x' from 0 to 2 step 1 do {
		['systemChat',(format ['Robocop has banned %1 from the server.',_targetName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand format ['#ban %1',_cid];
	diag_log format ["************************** ADMIN - %1 has been threat-adjusted to %2 - by %3 **************************",_targetName,_val,name _adjuster];
};

if (_val > 8) exitWith {
	for '_x' from 0 to 2 step 1 do {
		['systemChat',(format ['Robocop has kicked %1 from the server.',_targetName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	};
	([] call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand format ['#kick %1',_cid];
};
[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
diag_log format ["************************** ADMIN - %1 has been threat-adjusted to %2 - by %3 **************************",_targetName,_val,name _adjuster];