/*
File: fn_turretActionCancel.sqf
Author:

	Quiksilver
	
Last modified:

	30/12/2022 A3 2.10
	
Description:

	Turret actions
	
	Trialing turretLocal
_______________________________________________*/

missionNamespace setVariable ['QS_turretControl',FALSE,FALSE];
params ['_v','_turret','_lock'];
{
	player removeAction _x;
} count QS_turretActions;
if (_lock isEqualTo 0) exitWith {
	if (_turret isEqualTo 1) then {
		[25,[_v,1,'LMG_Minigun_Transport',1]] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		_v setVariable ["QS_turretL_locked",FALSE,TRUE];
	};
	if (_turret isEqualTo 2) then {
		[25,[_v,2,'LMG_Minigun_Transport2',1]] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		_v setVariable ["QS_turretR_locked",FALSE,TRUE];
	};	
};
if (_lock isEqualTo 1) exitWith {
	if (_turret isEqualTo 1) then {
		[25,[_v,1,'LMG_Minigun_Transport',0]] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		_v setVariable ["QS_turretL_locked",TRUE,TRUE];
	};
	if (_turret isEqualTo 2) then {
		[25,[_v,2,'LMG_Minigun_Transport2',0]] remoteExec ['QS_fnc_remoteExec',0,FALSE];
		_v setVariable ["QS_turretR_locked",TRUE,TRUE];
	};
};