/*/
File: fn_clientInteractActivateVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	24/04/2022 A3 2.08 by Quiksilver
	
Description:
	
	Activate Vehicle
__________________________________________________________________________/*/

_cursorObject = cursorObject;
if (
	(isNull _cursorObject) ||
	(!isNil {_cursorObject getVariable 'QS_v_disableActivation'})
) exitWith {};
_QS_tto = player getVariable ['QS_tto',0];
if (_QS_tto > 3) exitWith {
	50 cutText ['ROBOCOP: Access denied, please wait until restart or request Pardon from staff','PLAIN DOWN',1];
};
if ((_cursorObject isKindOf 'Plane') && (!(player getUnitTrait 'QS_trait_pilot')) && (!(player getUnitTrait 'QS_trait_fighterPilot'))) exitWith {
	50 cutText ['Only pilots can activate planes and VTOLs','PLAIN DOWN',0.5];
};



if (
	((missionNamespace getVariable ['QS_missionConfig_armor',1]) isEqualTo 0) &&
	((toLower (typeOf _cursorObject)) in ["b_apc_wheeled_01_cannon_f","b_apc_tracked_01_rcws_f","b_mbt_01_cannon_f","b_mbt_01_tusk_f","b_apc_tracked_01_aa_f","b_t_apc_wheeled_01_cannon_f","b_t_apc_tracked_01_rcws_f","b_t_apc_tracked_01_aa_f","b_t_mbt_01_cannon_f","b_t_mbt_01_tusk_f","o_mbt_02_cannon_f","o_apc_tracked_02_cannon_f","o_apc_wheeled_02_rcws_f","o_apc_wheeled_02_rcws_v2_f","o_apc_tracked_02_aa_f","o_t_apc_tracked_02_aa_ghex_f","o_t_apc_tracked_02_cannon_ghex_f","o_t_apc_wheeled_02_rcws_ghex_f","o_t_apc_wheeled_02_rcws_v2_ghex_f","o_t_mbt_02_cannon_ghex_f","i_apc_wheeled_03_cannon_f","i_apc_tracked_03_cannon_f","i_mbt_03_cannon_f"])
) exitWith {
	50 cutText ['Armored vehicles not authorized for use at this time (server config)','PLAIN DOWN',0.75];
};

private _exit = FALSE;
if (isSimpleObject _cursorObject) then {
	private _time = diag_tickTime;
	if (isNil {uiNamespace getVariable 'QS_vehicle_activations'}) then {
		uiNamespace setVariable ['QS_vehicle_activations',[]];
	};
	if ((uiNamespace getVariable 'QS_vehicle_activations') isNotEqualTo []) then {
		uiNamespace setVariable ['QS_vehicle_activations',((uiNamespace getVariable 'QS_vehicle_activations') select {(_x > (_time - 300))})];
		if ((count (uiNamespace getVariable 'QS_vehicle_activations')) >= 3) then {
			_exit = TRUE;
		};
	};
};
if (_exit) exitWith {
	50 cutText ['Too many vehicle activations (3+ within 5 minutes), try again soon','PLAIN DOWN',0.5];
};
if (isSimpleObject _cursorObject) then {
	(uiNamespace getVariable 'QS_vehicle_activations') pushBack diag_tickTime;
};
playSound 'Click';
player playActionNow 'PutDown';
50 cutText [(format ['Activating %1',(getText (configFile >> 'CfgVehicles' >> (typeOf _cursorObject) >> 'displayName'))]),'PLAIN DOWN',0.25];
if (
	(!isSimpleObject _cursorObject) && 
	(_cursorObject getVariable ['QS_vehicle_activateLocked',TRUE])
) exitWith {
	[69,_cursorObject,clientOwner,player,(getPlayerUID player),FALSE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
[69,_cursorObject,clientOwner,player,(getPlayerUID player),TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];