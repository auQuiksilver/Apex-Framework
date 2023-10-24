/*
File: fn_atAdjust.sqf
Author:

	Quiksilver
	
Last modified:

	12/07/2022 A3 2.10 by Quiksilver
	
Description:

	-
__________________________________________________*/

(_this # 1) params ['_target','_val','_adjuster'];
_uid = getPlayerUID _target;
_cid = owner _target;
QS_robocop set [_uid,_val];
_targetName = name _target;
if (_val > 9) exitWith {
	['systemChat',(format ['%2 %1 %3',_targetName,localize 'STR_QS_Chat_081',localize 'STR_QS_Chat_083'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	(call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand format ['#ban %1',_cid];
	diag_log format ["************************** ADMIN - %1 has been threat-adjusted to %2 - by %3 **************************",_targetName,_val,name _adjuster];
};

if (_val > 8) exitWith {
	['systemChat',(format ['%2 %1 %3',_targetName,localize 'STR_QS_Chat_082',localize 'STR_QS_Chat_083'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	(call (uiNamespace getVariable 'QS_fnc_serverCommandPassword')) serverCommand format ['#kick %1',_cid];
};
[nil,[_uid,_cid,_val,TRUE]] remoteExec ['QS_fnc_atClientMisc',_cid,FALSE];
diag_log format ["************************** ADMIN - %1 has been threat-adjusted to %2 - by %3 **************************",_targetName,_val,name _adjuster];