/*/
File: fn_clientInteractUAVSelfDestruct.sqf
Author:

	Quiksilver
	
Last modified:

	10/04/2023 A3 2.12
	
Description:
	
	Self-Destruct UAV
____________________________________________________/*/

_cameraOn = cameraOn;
if (!(unitIsUAV _cameraOn)) exitWith {};
if (((crew _cameraOn) findIf {((alive _x) && (isPlayer _x))}) isNotEqualTo -1) exitWith {
	50 cutText [localize 'STR_QS_Text_158','PLAIN DOWN',0.333];
};
if (_cameraOn getVariable ['QS_logistics_blocked',FALSE]) exitWith {
	50 cutText [localize 'STR_QS_Chat_171','PLAIN DOWN',0.333];
};
_dn = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cameraOn)],
	{(getText ((configOf _cameraOn) >> 'displayName'))},
	TRUE
];
private _result = [(format [localize 'STR_QS_Text_159',(_cameraOn getVariable ['QS_ST_customDN',_dn])]),localize 'STR_QS_Menu_122',localize 'STR_QS_Menu_124',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
if (_result) then {
	['systemChat',(format [localize 'STR_QS_Chat_095',profileName,(_cameraOn getVariable ['QS_ST_customDN',_dn]),(mapGridPosition _cameraOn)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	_cameraOn setDamage [1,FALSE];
} else {
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};