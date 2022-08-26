/*/
File: fn_atClientMisc.sqf
Author:

	Quiksilver
	
Last modified:

	13/04/2017 A3 1.68 by Quiksilver
	
Description:

	-
__________________________________________________/*/

_array = _this # 1;
_array params ['_uid','_cid','_val','_jip'];
if (isDedicated) exitWith {
	diag_log '***** ERROR ***** QS919 SERVER *****';
};
if ((getPlayerUID player) isNotEqualTo _uid) exitWith {
	diag_log '***** ERROR ***** QS919 CLIENT *****';
};
if (!(_jip)) exitWith {
	player setVariable ['QS_tto',_val,TRUE];
	[41,[1,_uid,_cid,profileName,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if ((player getVariable 'QS_tto') > 10) exitWith {};
if ((player getVariable 'QS_tto') > 9) exitWith {};
if ((player getVariable 'QS_tto') > 7) exitWith {};
player setVariable ['QS_tto',_val,TRUE];