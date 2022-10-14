/*/
File: fn_clientInteractUAVSelfDestruct.sqf
Author:

	Quiksilver
	
Last modified:

	22/11/2017 A3 1.78
	
Description:
	
	Self-Destruct UAV
__________________________________________________________________________/*/

_cameraOn = cameraOn;
if (!(unitIsUAV _cameraOn)) exitWith {};
if (((crew _cameraOn) findIf {((alive _x) && (isPlayer _x))}) isNotEqualTo -1) exitWith {
	50 cutText [localize 'STR_QS_Text_158','PLAIN DOWN',0.333];
};
private _result = [(format [localize 'STR_QS_Text_159',(getText (configFile >> 'CfgVehicles' >> (typeOf _cameraOn) >> 'displayName'))]),localize 'STR_QS_Menu_122',localize 'STR_QS_Menu_124',localize 'STR_QS_Menu_114',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
if (_result) then {
	['systemChat',(format [localize 'STR_QS_Chat_095',profileName,(getText (configFile >> 'CfgVehicles' >> (typeOf _cameraOn) >> 'displayName')),(mapGridPosition _cameraOn)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	_cameraOn setDamage [1,FALSE];
} else {
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};