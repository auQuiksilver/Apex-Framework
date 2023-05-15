/*
File: fn_clientInteractFOBTerminal.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 1.58 by Quiksilver
	
Description:
	
	-
__________________________________________________________________________*/

_type = _this # 3;
if (_type isEqualTo 1) exitWith {
	private ['_text','_respawnEnabled','_respawnTickets','_vehicleRespawnEnabled','_vehicleRepairService','_vehicleAmmoService','_radarServices','_vehicleFuelService','_personalRespawn'];
	_text = (format [localize 'STR_QS_Hints_034'(missionNamespace getVariable 'QS_module_fob_displayName')]);
	if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
		_radarServices = localize 'STR_QS_Hints_035';
	} else {
		_radarServices = localize 'STR_QS_Hints_036';
	};
	_text = _text + _radarServices;
	if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
		_respawnEnabled = localize 'STR_QS_Hints_039';
	} else {
		_respawnEnabled = localize 'STR_QS_Hints_040';
	};
	_text = _text + _respawnEnabled;
	_text = _text + (format [localize 'STR_QS_Hints_041',QS_module_fob_flag getVariable ['QS_deploy_tickets',0]]);
	if (missionNamespace getVariable 'QS_module_fob_vehicleRespawnEnabled') then {
		_vehicleRespawnEnabled = localize 'STR_QS_Hints_037';
	} else {
		_vehicleRespawnEnabled = localize 'STR_QS_Hints_038';
	};
	_text = _text + _vehicleRespawnEnabled;
	if (missionNamespace getVariable 'QS_module_fob_services_repair') then {
		_vehicleRepairService = localize 'STR_QS_Hints_042';
	} else {
		_vehicleRepairService = localize 'STR_QS_Hints_043';
	};
	_text = _text + _vehicleRepairService;
	if (missionNamespace getVariable 'QS_module_fob_services_ammo') then {
		_vehicleAmmoService = localize 'STR_QS_Hints_044';
	} else {
		_vehicleAmmoService = localize 'STR_QS_Hints_045';
	};
	_text = _text + _vehicleAmmoService;
	if (missionNamespace getVariable 'QS_module_fob_services_fuel') then {
		_vehicleFuelService = localize 'STR_QS_Hints_056';
	} else {
		_vehicleFuelService = localize 'STR_QS_Hints_073';
	};
	_text = _text + _vehicleFuelService;
	/*/
	if (player getVariable ['QS_module_fob_client_respawnEnabled',TRUE]) then {
		_personalRespawn = localize 'STR_QS_Hints_079';
	} else {
		_personalRespawn = localize 'STR_QS_Hints_080';
	};
	_text = _text + _personalRespawn;
	/*/
	playSound ['AddItemOK',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,15,-1,_text,[],-1,TRUE,'',TRUE];
	player selectDiarySubject 'fobs';
};
if (_type isEqualTo 2) exitWith {
	if (((((units EAST) + (units RESISTANCE)) inAreaArray [(getPosATL player),100,100,0,FALSE,-1])) isEqualTo []) then {
		playSound ['AddItemOK',FALSE];
		[50,[(player getVariable ['QS_unit_side',WEST]),profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	} else {
		50 cutText [localize 'STR_QS_Text_108','PLAIN DOWN',1];
	};
};
if (_type isEqualTo 3) exitWith {
	if ((player getUnitTrait 'uavhacker') || (player getUnitTrait 'QS_trait_pilot') || (player getUnitTrait 'QS_trait_fighterPilot')) then {
		50 cutText [localize 'STR_QS_Text_109','PLAIN'];
	} else {
		50 cutText [localize 'STR_QS_Text_110','PLAIN'];
		playSound ['AddItemOK',FALSE];
		player setVariable ['QS_module_fob_client_respawnEnabled',TRUE,FALSE];	
	};
};
if (_type isEqualTo 4) exitWith {
	50 cutText [localize 'STR_QS_Text_111','PLAIN'];
};