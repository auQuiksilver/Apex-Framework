/*/
File: fn_clientInteractActivateVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	24/04/2022 A3 2.08 by Quiksilver
	
Description:
	
	Activate Vehicle
__________________________________________________________________________/*/

getCursorObjectParams params ['_cursorObject','',''];
if (
	(isNull _cursorObject) ||
	!(_cursorObject isNil 'QS_v_disableActivation')
) exitWith {};
_QS_tto = player getVariable ['QS_tto',0];
if (_QS_tto > 3) exitWith {
	50 cutText [localize 'STR_QS_Text_076','PLAIN DOWN',1];
};
if ((_cursorObject isKindOf 'Plane') && (!(player getUnitTrait 'QS_trait_pilot')) && (!(player getUnitTrait 'QS_trait_fighterPilot'))) exitWith {
	50 cutText [localize 'STR_QS_Text_077','PLAIN DOWN',0.5];
};
if (
	((missionNamespace getVariable ['QS_missionConfig_armor',1]) isEqualTo 0) &&
	{((toLowerANSI (typeOf _cursorObject)) in (['armored_vehicles_1'] call QS_data_listVehicles))}
) exitWith {
	50 cutText [localize 'STR_QS_Text_078','PLAIN DOWN',0.75];
};
private _exit = FALSE;
if (isSimpleObject _cursorObject) then {
	private _time = diag_tickTime;
	if (uiNamespace isNil 'QS_vehicle_activations') then {
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
	50 cutText [localize 'STR_QS_Text_079','PLAIN DOWN',0.5];
};
if (isSimpleObject _cursorObject) then {
	(uiNamespace getVariable 'QS_vehicle_activations') pushBack diag_tickTime;
};
playSound 'Click';
player playActionNow 'PutDown';
_dn = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_displayname',toLowerANSI (typeOf _cursorObject)],
	{getText ((configOf _cursorObject) >> 'displayName')},
	TRUE
];
50 cutText [(format ['%2 %1',_dn,localize 'STR_QS_Text_080']),'PLAIN DOWN',0.25];
if (
	(!isSimpleObject _cursorObject) && 
	(_cursorObject getVariable ['QS_vehicle_activateLocked',TRUE])
) exitWith {
	[69,_cursorObject,clientOwner,player,(getPlayerUID player),FALSE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];
};
[69,_cursorObject,clientOwner,player,(getPlayerUID player),TRUE] remoteExecCall ['QS_fnc_remoteExec',2,FALSE];