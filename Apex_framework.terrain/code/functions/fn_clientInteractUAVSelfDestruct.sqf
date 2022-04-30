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
if (!(((crew _cameraOn) findIf {((alive _x) && (isPlayer _x))}) isEqualTo -1)) exitWith {
	50 cutText ['Other players are in this vehicle','PLAIN DOWN',0.333];
};
private _result = [(format ['Are you sure you want to destroy this %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _cameraOn) >> 'displayName'))]),'Warning','Destroy','Cancel',(findDisplay 46),FALSE,FALSE] call (missionNamespace getVariable 'BIS_fnc_guiMessage'); 
if (_result) then {
	['systemChat',(format ['%1 self-destructed a(n) %2 at grid %3',profileName,(getText (configFile >> 'CfgVehicles' >> (typeOf _cameraOn) >> 'displayName')),(mapGridPosition _cameraOn)])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
	_cameraOn setDamage [1,FALSE];
} else {
	50 cutText ['Cancelled','PLAIN DOWN',0.333];
};