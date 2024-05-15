/*/
File: fn_perFrameExec.sqf
Author:
	
	Quiksilver
	
Last Modified:

	2/12/2023 A3 2.14 by Quiksilver
	
Description:

	Per Frame Exec

Notes:

	In the future, add support for more namespace, but we need to check security whitelist for each var for each namespace
______________________________________________________/*/

params ['_args','_fnc'];
if (
	(!((toLowerANSI _fnc) in (call QS_data_pfh_whitelist))) ||
	(!isFinal (missionNamespace getVariable _fnc))
) exitWith {};
if (_args # 0) then {
	(_args # 1) call (missionNamespace getVariable _fnc);
} else {
	(_args # 1) spawn (missionNamespace getVariable _fnc);
};