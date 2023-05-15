/*/
File: fn_atClientMisc.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 1.68 by Quiksilver
	
Description:

	-
__________________________________________________/*/

_array = _this # 1;
_array params ['_uid','_cid','_val','_jip'];
if (isDedicated) exitWith {
	diag_log localize 'STR_QS_DiagLogs_043';
};
if ((getPlayerUID player) isNotEqualTo _uid) exitWith {
	diag_log localize 'STR_QS_DiagLogs_044';
};
if (!(_jip)) exitWith {
	player setVariable ['QS_tto',_val,TRUE];
	[41,[1,_uid,_cid,profileName,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if ((player getVariable 'QS_tto') > 10) exitWith {};
if ((player getVariable 'QS_tto') > 9) exitWith {};
if ((player getVariable 'QS_tto') > 7) exitWith {};
player setVariable ['QS_tto',_val,TRUE];