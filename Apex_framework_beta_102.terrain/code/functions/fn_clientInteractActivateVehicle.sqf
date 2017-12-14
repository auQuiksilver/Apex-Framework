/*/
File: fn_clientInteractActivateVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	23/10/2017 A3 1.76 by Quiksilver
	
Description:
	
	Activate Vehicle
__________________________________________________________________________/*/

_cursorObject = cursorObject;
if (
	(isNull _cursorObject) ||
	(!isSimpleObject _cursorObject) ||
	(!isNil {_cursorObject getVariable 'QS_v_disableActivation'})
) exitWith {};
_QS_tto = player getVariable ['QS_tto',0];
if (_QS_tto > 3) exitWith {
	50 cutText ['ROBOCOP: Access denied, please wait until restart or request Pardon from staff','PLAIN DOWN',1];
};
if ((_cursorObject isKindOf 'Plane') && (!(player getUnitTrait 'QS_trait_pilot'))) exitWith {
	50 cutText ['Only pilots can activate planes and VTOLs','PLAIN DOWN',0.5];
};
private _exit = FALSE;
private _time = diag_tickTime;
if (isNil {uiNamespace getVariable 'QS_vehicle_activations'}) then {
	uiNamespace setVariable ['QS_vehicle_activations',[]];
};
if (!((uiNamespace getVariable 'QS_vehicle_activations') isEqualTo [])) then {
	uiNamespace setVariable ['QS_vehicle_activations',((uiNamespace getVariable 'QS_vehicle_activations') select {(_x > (_time - 300))})];
	if ((count (uiNamespace getVariable 'QS_vehicle_activations')) >= 3) then {
		_exit = TRUE;
	};
};
if (_exit) exitWith {
	50 cutText ['Too many vehicle activations (3+ within 5 minutes), try again soon','PLAIN DOWN',0.5];
};
(uiNamespace getVariable 'QS_vehicle_activations') pushBack diag_tickTime;
playSound 'Click';
player playActionNow 'PutDown';
50 cutText [(format ['Activating %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'displayName'))]),'PLAIN DOWN',0.25];
[69,_cursorObject,clientOwner,player,(getPlayerUID player)] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];