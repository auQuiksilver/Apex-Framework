/*/
File: fn_replenishServices.sqf
Author:
	
	Quiksilver
	
Last Modified:

	10/04/2023 A3 2.12 by Quiksilver
	
Description:

	Top up scripted services (like respawn tickets)
______________________________________________________/*/

params ['_vehicle'];
_vehicleTypeLower = toLowerANSI (typeOf _vehicle);
if !(_vehicle isNil 'QS_vehicle_isSuppliedFOB') then {
	_vehicle setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
};
_medical = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_attendant',_vehicleTypeLower],
	{getNumber ((configOf _vehicle) >> 'attendant')},
	TRUE
];
private _transportSoldier = QS_hashmap_configfile getOrDefaultCall [
	format ['cfgvehicles_%1_transportsoldier',_vehicleTypeLower],
	{getNumber ((configOf _vehicle) >> 'transportSoldier')},
	TRUE
];
if (
	(_medical > 0) ||
	{(_vehicle getVariable ['QS_services_medical',FALSE])}
) then {
	if (_transportSoldier > 0) then {
		if (_transportSoldier isEqualTo 4) then {
			_transportSoldier = 8;
		} else {
			_transportSoldier = round (_transportSoldier * 1.5);
		};
		if (_vehicleTypeLower isKindOf 'Van_02_medevac_base_F') then {
			_transportSoldier = 4;
		};
		_vehicle setVariable ['QS_medicalVehicle_reviveTickets',_transportSoldier,TRUE];
	} else {
		if (!(_vehicle isKindOf 'UAV_06_base_F')) then {
			_vehicle setVariable ['QS_medicalVehicle_reviveTickets',8,TRUE];
		};
	};
};
if (_vehicle isKindOf 'Air') then {
	if (_transportSoldier > 0) then {
		_backpackCargo = backpackCargo _vehicle;
		_paraType = QS_core_classNames_parachute;
		private _backpackCount = 0;
		{
			if (_x isEqualTo _paraType) then {
				_backpackCount = _backpackCount + 1;
			};
		} count _backpackCargo;
		clearBackpackCargoGlobal _vehicle;
		if (_backpackCount < _transportSoldier) then {
			_vehicle addBackpackCargoGlobal [_paraType,(_transportSoldier - _backpackCount)];
		};
	};
};
if (player getUnitTrait 'QS_trait_fighterPilot') then {
	if (_vehicle isKindOf 'Plane') then {
		if (diag_tickTime > (uiNamespace getVariable ['QS_fighterPilot_lastMsg',(diag_tickTime - 1)])) then {
			uiNamespace setVariable ['QS_fighterPilot_lastMsg',(diag_tickTime + 300)];
			[63,[4,['CAS_1',['',localize 'STR_QS_Notif_153']]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
			['sideChat',[WEST,'AirBase'],(format ['%3 %2 (%1)',(getText ((configOf _vehicle) >> 'displayName')),profileName,localize 'STR_QS_Chat_029'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
	};
};