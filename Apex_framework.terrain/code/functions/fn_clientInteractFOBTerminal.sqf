/*
File: fn_clientInteractFOBTerminal.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:
	
	-
__________________________________________________________________________*/

_type = _this # 3;
if (_type isEqualTo 1) exitWith {
	private ['_text','_respawnEnabled','_respawnTickets','_vehicleRespawnEnabled','_vehicleRepairService','_vehicleAmmoService','_radarServices','_vehicleFuelService','_personalRespawn'];
	_text = format [
		'<t align="left" size="2">%2 %1<t/><br/><t align="left" size="1.5">%3</t><br/><t align="left" size="1">__________</t><br/>',
		(missionNamespace getVariable 'QS_module_fob_displayName'),
		localize 'STR_QS_Hints_034',
		localize 'STR_QS_Hints_035'
	];
	if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
		_radarServices = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_038',localize 'STR_QS_Hints_036'];
	} else {
		_radarServices = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_038',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _radarServices;
	if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
		_respawnEnabled = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_039',localize 'STR_QS_Hints_036'];
	} else {
		_respawnEnabled = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_039',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _respawnEnabled;
	_text = _text + (format ['<t size="1" align="left">%2</t><t size="1" align="right">%1</t><br/>',QS_module_fob_flag getVariable ['QS_deploy_tickets',0],localize 'STR_QS_Hints_040']);
	if (missionNamespace getVariable 'QS_module_fob_vehicleRespawnEnabled') then {
		_vehicleRespawnEnabled = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_041',localize 'STR_QS_Hints_036'];
	} else {
		_vehicleRespawnEnabled = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_041',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _vehicleRespawnEnabled;
	if (missionNamespace getVariable 'QS_module_fob_services_repair') then {
		_vehicleRepairService = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_042',localize 'STR_QS_Hints_036'];
	} else {
		_vehicleRepairService = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_042',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _vehicleRepairService;
	if (missionNamespace getVariable 'QS_module_fob_services_ammo') then {
		_vehicleAmmoService = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_043',localize 'STR_QS_Hints_036'];
	} else {
		_vehicleAmmoService = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_043',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _vehicleAmmoService;
	if (missionNamespace getVariable 'QS_module_fob_services_fuel') then {
		_vehicleFuelService = format ['<t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_044',localize 'STR_QS_Hints_036'];
	} else {
		_vehicleFuelService = format ['<t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_044',localize 'STR_QS_Hints_037'];
	};
	_text = _text + _vehicleFuelService;
	/*/
	if (player getVariable ['QS_module_fob_client_respawnEnabled',TRUE]) then {
		_personalRespawn = format ['<br/><t size="1" align="left">%1</t><t color="#008000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_045',localize 'STR_QS_Hints_036'];
	} else {
		_personalRespawn = format ['<br/><t size="1" align="left">%1</t><t color="#ff0000" size="1" align="right">%2</t><br/>',localize 'STR_QS_Hints_045',localize 'STR_QS_Hints_036'];
	};
	_text = _text + _personalRespawn;
	/*/
	playSound ['AddItemOK',FALSE];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,15,-1,_text,[],-1,TRUE,'',TRUE];
	player selectDiarySubject 'fobs';
};
if (_type isEqualTo 2) exitWith {
	if (((((units EAST) + (units RESISTANCE)) inAreaArray [player,100,100,0,FALSE,-1])) isEqualTo []) then {
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