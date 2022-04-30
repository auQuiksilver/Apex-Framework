/*
File: fn_clientInteractFOBTerminal.sqf
Author:

	Quiksilver
	
Last modified:

	29/05/2016 A3 1.58 by Quiksilver
	
Description:
	
	-
__________________________________________________________________________*/

_type = _this select 3;
if (_type isEqualTo 1) exitWith {
	private ['_text','_respawnEnabled','_respawnTickets','_vehicleRespawnEnabled','_vehicleRepairService','_vehicleAmmoService','_radarServices','_vehicleFuelService','_personalRespawn'];
	_text = format [
		'<t align="left" size="2">FOB %1<t/><br/><t align="left" size="1.5">Status</t><br/><t align="left" size="1">__________</t><br/>',
		(missionNamespace getVariable 'QS_module_fob_displayName')
	];
	if ((missionNamespace getVariable 'QS_module_fob_side') isEqualTo (player getVariable ['QS_unit_side',WEST])) then {
		_radarServices = '<t size="1" align="left">Radar Services</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_radarServices = '<t size="1" align="left">Radar Services</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _radarServices;
	if (missionNamespace getVariable 'QS_module_fob_respawnEnabled') then {
		_respawnEnabled = '<t size="1" align="left">Respawn</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_respawnEnabled = '<t size="1" align="left">Respawn</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _respawnEnabled;
	_text = _text + (format ['<t size="1" align="left">Respawn Tickets</t><t size="1" align="right">%1</t><br/>',(missionNamespace getVariable 'QS_module_fob_respawnTickets')]);
	if (missionNamespace getVariable 'QS_module_fob_vehicleRespawnEnabled') then {
		_vehicleRespawnEnabled = '<t size="1" align="left">Vehicle Services - Respawn</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_vehicleRespawnEnabled = '<t size="1" align="left">Vehicle Services - Respawn</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _vehicleRespawnEnabled;
	if (missionNamespace getVariable 'QS_module_fob_services_repair') then {
		_vehicleRepairService = '<t size="1" align="left">Vehicle Services - Repair</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_vehicleRepairService = '<t size="1" align="left">Vehicle Services - Repair</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _vehicleRepairService;
	if (missionNamespace getVariable 'QS_module_fob_services_ammo') then {
		_vehicleAmmoService = '<t size="1" align="left">Vehicle Services - Ammo</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_vehicleAmmoService = '<t size="1" align="left">Vehicle Services - Ammo</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _vehicleAmmoService;
	if (missionNamespace getVariable 'QS_module_fob_services_fuel') then {
		_vehicleFuelService = '<t size="1" align="left">Vehicle Services - Fuel</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_vehicleFuelService = '<t size="1" align="left">Vehicle Services - Fuel</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _vehicleFuelService;
	if (player getVariable ['QS_module_fob_client_respawnEnabled',TRUE]) then {
		_personalRespawn = '<br/><t size="1" align="left">Personal FOB Respawn Beacon</t><t color="#008000" size="1" align="right">Online</t><br/>';
	} else {
		_personalRespawn = '<br/><t size="1" align="left">Personal FOB Respawn Beacon</t><t color="#ff0000" size="1" align="right">Offline</t><br/>';
	};
	_text = _text + _personalRespawn;
	playSound ['AddItemOK',FALSE];
	//_text = parseText _text;
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,15,-1,_text,[],-1,TRUE,'',TRUE];
	player selectDiarySubject 'fobs';
};
if (_type isEqualTo 2) exitWith {
	if (([(getPosATL player),100,([player] call (missionNamespace getVariable 'QS_fnc_enemySides')),allUnits,1] call (missionNamespace getVariable 'QS_fnc_serverDetector')) isEqualTo 0) then {
		playSound ['AddItemOK',FALSE];
		[50,[(player getVariable ['QS_unit_side',WEST]),profileName]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
	} else {
		50 cutText ['Enemies are within 100m of you, FOB activation failed!','PLAIN DOWN',1];
	};
};
if (_type isEqualTo 3) exitWith {
	if ((player getUnitTrait 'uavhacker') || (player getUnitTrait 'QS_trait_pilot') || (player getUnitTrait 'QS_trait_fighterPilot')) then {
		50 cutText ['Pilots cannot respawn at the FOB!','PLAIN'];
	} else {
		50 cutText ['Personal Respawn Beacon activated','PLAIN'];
		playSound ['AddItemOK',FALSE];
		player setVariable ['QS_module_fob_client_respawnEnabled',TRUE,FALSE];	
	};
};
if (_type isEqualTo 4) exitWith {
	50 cutText ['Soon','PLAIN'];
};