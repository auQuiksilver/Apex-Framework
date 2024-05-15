/*/
File: fn_clientServiceVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	29/12/2022 A3 2.10 by Quiksilver
	
Description:

	Client vehicle service (Service Pads)
	
Note:

	OBSOLETE but still functional
__________________________________________________/*/

private _t = cursorTarget;
private _v = vehicle player;
private _rt = 1;
private _fuel = 1;
if (
	(_t getVariable ['under_service',FALSE]) ||
	{(_v getVariable ['under_service',FALSE])}
) exitWith {
	50 cutText [localize 'STR_QS_Text_191','PLAIN DOWN',0.5];
};
if (missionNamespace getVariable ['QS_repairing_vehicle',FALSE]) exitWith {50 cutText [localize 'STR_QS_Text_191','PLAIN DOWN',0.5];};
private _isUAV = unitIsUav cameraOn;
if (_isUAV) then {
	_v = cameraOn;
};

/*/=========================================== SORT INTO BASE OR FIELD SERVICE/*/

private _baseService = FALSE;
private _fieldService = FALSE;
private _nearestServiceSite = '';
{
	if (((_t distance2D (markerPos _x)) < 12) || {((_v distance2D (markerPos _x)) < 12)}) then {
		_baseService = TRUE;
		_fieldService = FALSE;
		_nearestServiceSite = _x;
	};
} count (missionNamespace getVariable 'QS_veh_baseservice_mkrs');
{
	if (((_t distance2D (markerPos _x)) < 12) || {((_v distance2D (markerPos _x)) < 12)}) then {
		_baseService = FALSE;
		_fieldService = TRUE;
		_nearestServiceSite = _x;
	};
} count (missionNamespace getVariable 'QS_veh_fieldservice_mkrs');
private _isCarrier = FALSE;
if ((missionNamespace getVariable ['QS_missionConfig_carrierEnabled',0]) isNotEqualTo 0) then {
	if (['INPOLYGON_FOOT',player] call (missionNamespace getVariable 'QS_fnc_carrier')) then {
		_nearestServiceSite = '';
		_fieldService = TRUE;
		_isCarrier = TRUE;
	};
};
if ((missionNamespace getVariable ['QS_missionConfig_destroyerEnabled',0]) isNotEqualTo 0) then {
	if (['INPOLYGON_FOOT',player] call (missionNamespace getVariable 'QS_fnc_destroyer')) then {
		_nearestServiceSite = '';
		_fieldService = TRUE;
		_isCarrier = TRUE;
	};
};

/*/=========================================== BASE SERVICE/*/
private _isDepot = [_v] call (missionNamespace getVariable 'QS_fnc_isNearRepairDepot');
if (_isDepot) then {
	_fieldService = FALSE;
	_baseService = TRUE
};
private _isQualified = TRUE;
if ((_baseService) || (_isDepot)) then {
	/*/=========================================== QUALIFY BY VEHICLE TYPE/*/
	if ((_baseService) && (!(_isDepot))) then {
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_landservice_mkrs')) then {
			if (!(_v isKindOf 'LandVehicle')) then {
				_isQualified = FALSE;
				50 cutText [localize 'STR_QS_Text_192','PLAIN DOWN',0.5];
			};
		};
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_planeservice_mkrs')) then {
			if (!(_v isKindOf 'Plane')) then {
				_isQualified = FALSE;
				50 cutText [localize 'STR_QS_Text_193','PLAIN DOWN',0.5];
			};
		};
		
		if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_heliservice_mkrs')) then {
			if (!(_v isKindOf 'Helicopter')) then {
				_isQualified = FALSE;
				50 cutText [localize 'STR_QS_Text_194','PLAIN DOWN',0.5];
			};
		};
	};
	if (!(local _v)) then {_isQualified = FALSE;};
	if (!(_isQualified)) exitWith {};
	if ((player isNotEqualTo (effectiveCommander _v)) && (!(_isUAV))) exitWith {
		(missionNamespace getVariable 'QS_managed_hints') pushBack [2,FALSE,7.5,-1,localize 'STR_QS_Hints_095',[],-1];
	};
	_rt = 10 + (60 * (damage _v));
	if (_v isKindOf 'Plane') then {
		_rt = _rt + 20;
	};
	missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
	_v setFuel 0;
	_sv = TRUE;
	_onCompleted = {
		params ['_v'];
		50 cutText [localize 'STR_QS_Text_195','PLAIN DOWN',0.5];
		// Repair
		if (
			(!(_v getVariable ['QS_services_repair_disabled',FALSE])) &&
			{(!(missionNamespace getVariable ['QS_services_repair_disabled',FALSE]))}
		) then {
			_v setDamage [0,FALSE];
		};
		// Refuel
		if (
			(!(_v getVariable ['QS_services_refuel_disabled',FALSE])) &&
			{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
		) then {
			if (local _v) then {
				_v setFuel 1;
			} else {
				['setFuel',_v,1] remoteExec ['QS_fnc_remoteExecCmd',_v,FALSE];
			};
		};
		// Reammo
		if (
			(!(_v getVariable ['QS_services_reammo_disabled',FALSE])) &&
			{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
		) then {
			_v setVehicleAmmo 1;
			if ((count (crew _v)) > 1) then {
				['setVehicleAmmo',_v,1] remoteExec ['QS_fnc_remoteExecCmd',(crew _v),FALSE];
			};
		};
		missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
		_v allowDamage TRUE;
		_v setFuelCargo 0;
		_v setRepairCargo 0;
		_v setAmmoCargo 0;
		if (_v isKindOf 'LandVehicle') then {
			[_v] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
		};
		if ((['medical',(typeOf _v),FALSE] call (missionNamespace getVariable 'QS_fnc_inString')) || {(['medevac',(typeOf _v),FALSE] call (missionNamespace getVariable 'QS_fnc_inString'))}) then {
			_v setVariable ['QS_medicalVehicle_reviveTickets',(getNumber ((configOf _v) >> 'transportSoldier')),TRUE];
		};
		if (_v isKindOf 'Air') then {
			_cargoSeats = getNumber ((configOf _v) >> 'transportSoldier');
			if (_cargoSeats > 0) then {
				_backpackCargo = backpackCargo _v;
				_paraType = QS_core_classNames_parachute;
				private _backpackCount = 0;
				{
					if (_x isEqualTo _paraType) then {
						_backpackCount = _backpackCount + 1;
					};
				} count _backpackCargo;
				clearBackpackCargoGlobal _v;
				if (_backpackCount < _cargoSeats) then {
					_v addBackpackCargoGlobal [_paraType,(_cargoSeats - _backpackCount)];
				};
			};
		};
		_v setVariable ['QS_vehicle_isSuppliedFOB',nil,TRUE];
		if ((attachedObjects _v) isNotEqualTo []) then {
			private _static = objNull;
			{
				_static = _x;
				if (alive _static) then {
					if ((_static isKindOf 'StaticWeapon') || (unitIsUAV _static)) then {
						if (local _static) then {
							if (
								(!(_static getVariable ['QS_services_reammo_disabled',FALSE])) &&
								{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
							) then {
								_static setVehicleAmmo 1;
							};
							if (
								(!(_static getVariable ['QS_services_refuel_disabled',FALSE])) &&
								{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
							) then {
								if ((fuel _static) isNotEqualTo 1) then {
									_static setFuel 1;
								};
							};
						} else {
							if (
								(!(_static getVariable ['QS_services_reammo_disabled',FALSE])) &&
								{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
							) then {
								['setVehicleAmmo',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
							};
							if (
								(!(_static getVariable ['QS_services_refuel_disabled',FALSE])) &&
								{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
							) then {
								if ((fuel _static) isNotEqualTo 1) then {
									['setFuel',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
								};
							};
						};
						if (
							(!(_static getVariable ['QS_services_repair_disabled',FALSE])) &&
							{(!(missionNamespace getVariable ['QS_services_repair_disabled',FALSE]))}
						) then {
							if ((damage _static) isNotEqualTo 0) then {
								_static setDamage [0,FALSE];
							};
						};
					};
				};
			} forEach (attachedObjects _v);
		};
		if (player getUnitTrait 'QS_trait_fighterPilot') then {
			if (_v isKindOf 'Plane') then {
				if (diag_tickTime > (uiNamespace getVariable ['QS_fighterPilot_lastMsg',(diag_tickTime - 1)])) then {
					uiNamespace setVariable ['QS_fighterPilot_lastMsg',(diag_tickTime + 300)];
					[63,[4,['CAS_1',['',localize 'STR_QS_Notif_153']]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
					['sideChat',[WEST,'AirBase'],(format ['%3 %2 (%1)',(getText ((configOf _v) >> 'displayName')),profileName,localize 'STR_QS_Chat_029'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				};
			};
		};
	};
	_onCancelled = {
		params ['_v','_position'];
		private _c = FALSE;
		if (local _v) then {
			if ((fuel _v) > 0) then {
				_v setFuel 0;
			};
		};
		if (!alive player) then {_c = TRUE;};
		if ((_v distance2D _position) > 10) then {_c = TRUE;};
		if (((vehicle player) isNotEqualTo _v) && (!(unitIsUav cameraOn))) then {_c = TRUE;};
		if (!alive _v) then {_c = TRUE;};
		if ((isEngineOn _v) && (!(unitIsUav cameraOn))) then {
			50 cutText [localize 'STR_QS_Text_148','PLAIN DOWN',0.3];
			_c = TRUE;
		};
		if (_c) then {
			missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
		};
		_c;
	};
	[
		localize 'STR_QS_Menu_173',
		_rt,
		0,
		[[_v],{FALSE}],							/*/onProgress/*/
		[[_v,(position _v)],_onCancelled],					/*/onCancelled/*/
		[[_v],_onCompleted],					/*/onCompleted/*/
		[[],{FALSE}]							/*/onFailed/*/
	] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
	[_v,_rt] spawn {
		params ['_vehicle','_rt'];
		_array = ['repair'];
		if (_rt > 5) then {
			_array pushBack 'rearm';
		};
		if (_rt > 15) then {
			_array pushBack 'refuel';
		};
		_position = getPosASL _vehicle;
		{
			playSound3D [
				(format ['A3\Sounds_F\sfx\ui\vehicles\vehicle_%1.wss',_x]),
				_vehicle,
				FALSE,
				_position,
				2,
				1,
				25
			];
			uiSleep 5;
		} forEach _array;
	};
};

/*/=========================================== FIELD SERVICE/*/

if (_fieldService) then {
	if ((isNull (objectParent player)) && (!alive _t)) exitWith {
		50 cutText [localize 'STR_QS_Text_196','PLAIN DOWN',0.5];
	};
	if (!(_v isKindOf 'CAManBase')) exitWith {
		50 cutText [localize 'STR_QS_Text_197','PLAIN DOWN',1];
	};
	/*/=========================================== QUALIFY BY VEHICLE TYPE/*/
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_landservice_mkrs')) then {
		if (!(_t isKindOf 'LandVehicle')) then {
			_isQualified = FALSE;
			50 cutText [localize 'STR_QS_Text_192','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_planeservice_mkrs')) then {
		if (!(_t isKindOf 'Plane')) then {
			_isQualified = FALSE;
			50 cutText [localize 'STR_QS_Text_193','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_heliservice_mkrs')) then {
		if (!(_t isKindOf 'Helicopter')) then {
			_isQualified = FALSE;
			50 cutText [localize 'STR_QS_Text_194','PLAIN DOWN',1];
		};
	};
	if (_nearestServiceSite in (missionNamespace getVariable 'QS_veh_airservice_mkrs')) then {
		if (!(_t isKindOf 'Air')) then {
			_isQualified = FALSE;
			50 cutText [localize 'STR_QS_Text_198','PLAIN DOWN',1];
		};
	};
	if (_isCarrier) then {
		_isQualified = TRUE;
	};
	if (!(local _t)) then {_isQualified = FALSE;};
	if (!(_isQualified)) exitWith {};
	if ((_t isKindOf 'LandVehicle') || {(_t isKindOf 'Ship')} || {(_t isKindOf 'Air')}) then {
		_rt = 10 + (90 * (damage _t));
		if (_t isKindOf 'Plane') then {
			_rt = _rt + 20;
		};
		missionNamespace setVariable ['QS_repairing_vehicle',TRUE,FALSE];
		_fuel = fuel _t;
		if (!(_isCarrier)) then {
			if (!(missionNamespace getVariable 'QS_module_fob_services_ammo')) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_096',[],-1];
			};
			if (!(missionNamespace getVariable 'QS_module_fob_services_repair')) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_097',[],-1];
			};
			if (!(missionNamespace getVariable 'QS_module_fob_services_fuel')) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_098',[],-1];
			};
		};
		_onCompleted = {
			params ['_t','_fuel','_isCarrier'];
			50 cutText [localize 'STR_QS_Text_195','PLAIN DOWN',0.5];
			player playActionNow 'stop';
			if ((missionNamespace getVariable 'QS_module_fob_services_repair') || {(_isCarrier)}) then {
				if (
					(!(_t getVariable ['QS_services_repair_disabled',FALSE])) &&
					{(!(missionNamespace getVariable ['QS_services_repair_disabled',FALSE]))}
				) then {
					_t setDamage [0,FALSE];
				};
			};
			if (_t isKindOf 'LandVehicle') then {
				[_t] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
			};
			if (
				(!(_t getVariable ['QS_services_refuel_disabled',FALSE])) &&
				{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
			) then {
				if (local _t) then {
					_t setFuel ([_fuel,1] select ((missionNamespace getVariable 'QS_module_fob_services_fuel') || {(_isCarrier)}));
				} else {
					['setFuel',([_fuel,1] select ((missionNamespace getVariable 'QS_module_fob_services_fuel') || {(_isCarrier)})),1] remoteExec ['QS_fnc_remoteExecCmd',_t,FALSE];
				};
			};
			if ((missionNamespace getVariable 'QS_module_fob_services_ammo') || {(_isCarrier)}) then {
				if (
					(!(_t getVariable ['QS_services_reammo_disabled',FALSE])) &&
					{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
				) then {
					if ((count (crew _t)) > 0) then {
						['setVehicleAmmo',_t,1] remoteExec ['QS_fnc_remoteExecCmd',(crew _t),FALSE];
					} else {
						if (local _t) then {
							_t setVehicleAmmo 1;
						} else {
							['setVehicleAmmo',_t,1] remoteExec ['QS_fnc_remoteExecCmd',_t,FALSE];
						};
					};
				};
			};
			if ((missionNamespace getVariable 'QS_module_fob_services_repair') || {(missionNamespace getVariable 'QS_module_fob_services_ammo')} || {(_isCarrier)}) then {
				if ((attachedObjects _t) isNotEqualTo []) then {
					private _static = objNull;
					{
						_static = _x;
						if (alive _static) then {
							if ((_static isKindOf 'StaticWeapon') || (unitIsUAV _static)) then {
								if ((missionNamespace getVariable 'QS_module_fob_services_repair') || {(_isCarrier)}) then {
									if (
										(!(_static getVariable ['QS_services_repair_disabled',FALSE])) &&
										{(!(missionNamespace getVariable ['QS_services_repair_disabled',FALSE]))}
									) then {
										if ((damage _static) isNotEqualTo 0) then {
											_static setDamage [0,FALSE];
										};
									};
								};
								if ((missionNamespace getVariable 'QS_module_fob_services_ammo') || {(_isCarrier)}) then {
									if (
										(!(_static getVariable ['QS_services_reammo_disabled',FALSE])) &&
										{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
									) then {
										if (local _static) then {
											_static setVehicleAmmo 1;
										} else {
											0 = ['setVehicleAmmo',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
										};
									};
								};
								if ((missionNamespace getVariable 'QS_module_fob_services_fuel') || {(_isCarrier)}) then {
									if (
										(!(_static getVariable ['QS_services_refuel_disabled',FALSE])) &&
										{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
									) then {
										if ((fuel _static) isNotEqualTo 1) then {
											['setFuel',_static,1] remoteExec ['QS_fnc_remoteExecCmd',_static,FALSE];
										};
									};
								};
							};
						};
					} forEach (attachedObjects _t);
				};
			};
			missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
		};
		_onCancelled = {
			params ['_t','_position','_fuel'];
			private _c = FALSE;
			if (!alive player) then {_c = TRUE;};
			if (player isNotEqualTo (vehicle player)) then {_c = TRUE;};
			if (!alive _t) then {_c = TRUE;};
			if (!((vehicle player) isKindOf 'CAManBase')) then {_c = TRUE;};
			if (isEngineOn _t) then {
				(missionNamespace getVariable 'QS_managed_hints') pushBack [5,TRUE,5,-1,localize 'STR_QS_Hints_099',[],-1];
				_c = TRUE;
			};
			if (!(_t in [cursorObject,cursorTarget])) then {_c = TRUE;};
			if (((position player) distance _position) > 5) then {_c = TRUE;};
			if (_c) then {
				if (local _t) then {
					_t setFuel _fuel;
				} else {
					['setFuel',_t,_fuel] remoteExec ['QS_fnc_remoteExecCmd',_t,FALSE];
				};				
				missionNamespace setVariable ['QS_repairing_vehicle',FALSE,FALSE];
			};
			_c;
		};
		[
			localize 'STR_QS_Menu_173',
			_rt,
			0,
			[[],{FALSE}],								/*/onProgress/*/
			[[_t,(position player),_fuel],_onCancelled],		/*/onCancelled/*/
			[[_t,_fuel,_isCarrier],_onCompleted],						/*/onCompleted/*/
			[[],{FALSE}]								/*/onFailed/*/
		] spawn (missionNamespace getVariable 'QS_fnc_clientProgressVisualization');
		[_v,_rt] spawn {
			params ['_vehicle','_rt'];
			_array = ['repair'];
			if (_rt > 5) then {
				_array pushBack 'rearm';
			};
			if (_rt > 15) then {
				_array pushBack 'refuel';
			};
			_position = getPosASL _vehicle;
			{
				playSound3D [
					(format ['A3\Sounds_F\sfx\ui\vehicles\vehicle_%1.wss',_x]),
					_vehicle,
					FALSE,
					_position,
					2,
					1,
					25
				];
				uiSleep 5;
			} forEach _array;
		};
	};
};