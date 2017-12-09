/*
File: fn_clientInteractSurrender.sqf
Author:
	
	Quiksilver
	
Last Modified:

	12/09/2017 A3 1.76 by Quiksilver

Description:

	Command Surrender
	QS_aoSmallTask_Arrested
__________________________________________________________*/

private ['_t'];
_t = cursorTarget;
if (isNull _t) exitWith {};
if (!alive _t) exitWith {};
if (!(_t isKindOf 'Man')) exitWith {};
if (!isNull (objectParent _t)) exitWith {};
if (captive _t) exitWith {};
if (isNil {_t getVariable 'QS_surrenderable'}) exitWith {};
if (!isNil {_t getVariable 'QS_missionSurrender'}) exitWith {
	for '_x' from 0 to 2 step 1 do {
		_t setVariable ['QS_surrenderable',nil,TRUE];
	};
	missionNamespace setVariable ['HE_SURRENDERS',TRUE,TRUE];
};
if (_t isEqualTo (missionNamespace getVariable 'QS_csatCommander')) then {
	[58,[profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_t isEqualTo (missionNamespace getVariable 'QS_arrest_target')) then {
	['sideChat',[WEST,'HQ'],(format ['%1 arrested the HVT!',profileName])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	for '_x' from 0 to 1 step 1 do {
		missionNamespace setVariable ['QS_aoSmallTask_Arrested',TRUE,TRUE];
	};
};
if (local _t) then {
	[21,_t,(getPlayerUID player),profileName] call (missionNamespace getVariable 'QS_fnc_remoteExec');
} else {
	[21,_t,(getPlayerUID player),profileName] remoteExecCall ['QS_fnc_remoteExec',_t,FALSE];
};
{
	_t setVariable _x;
} forEach [
	['QS_surrenderable',FALSE,TRUE],
	['QS_isSurrendered',TRUE,TRUE],
	['QS_RD_escortable',TRUE,TRUE],
	['QS_RD_loadable',TRUE,TRUE],
	['QS_surrender_captor',[profileName,(getPlayerUID player)],TRUE]
];
_text = format ['%1 has captured a unit at grid %2',profileName,(mapGridPosition player)];
['systemChat',_text] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
50 cutText ['Captured!','PLAIN DOWN',0.75];
TRUE;