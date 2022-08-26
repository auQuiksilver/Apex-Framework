/*
File: fn_clientEventGetOutMan.sqf
Author:

	Quiksilver
	
Last modified:

	22/05/2022 A3 2.10 by Quiksilver
	
Description:

	unit: Object - unit the event handler is assigned to
	position: String - Can be either "driver", "gunner", "commander" or "cargo"
	vehicle: Object - Vehicle that the unit left
	turret: Array - turret path
__________________________________________________*/

params ['_unit','_position','_vehicle','_turret'];
player enableAIFeature ['CHECKVISIBLE',TRUE];
uiNamespace setVariable ['QS_robocop_timeout',diag_tickTime + 3];
[0,_vehicle] call (missionNamespace getVariable 'QS_fnc_clientVehicleEventHandlers');
/*/
{
	setInfoPanel [(['left','right'] select (_forEachIndex isEqualTo 1)),(_x # 0)];
} forEach (missionNamespace getVariable 'QS_client_infoPanels');
/*/
if ((missionNamespace getVariable ['QS_missionConfig_artyEngine',1]) isEqualTo 1) then {
	if (_vehicle isEqualTo (missionNamespace getVariable ['QS_arty',objNull])) then {
		enableEngineArtillery FALSE;
	};
};
if (!isNil {player getVariable 'QS_pilot_vehicleInfo'}) then {
	player setVariable ['QS_pilot_vehicleInfo',nil,TRUE];
};
if ((toLowerANSI (typeOf _vehicle)) in ['b_t_apc_tracked_01_crv_f','b_apc_tracked_01_crv_f']) then {
	player removeAction (missionNamespace getVariable 'QS_action_plow');
};
if ((((crew _vehicle) findIf {(alive _x)}) isEqualTo -1) || {(player isEqualTo (driver _vehicle))}) then {
	if (local _vehicle) then {
		_vehicle engineOn FALSE;
	};
};