/*
File: fn_clientVehicleService.sqf
Author:
	
	Quiksilver
	
Last Modified:

	20/09/2023 A3 2.14 by Quiksilver

Description:

	Service Assets
_______________________________________*/

if (localNamespace getVariable ['QS_service_blocked',FALSE]) exitWith {};
localNamespace setVariable ['QS_service_blocked',TRUE];
params [
	['_vehicle',objNull],
	['_types',[]],
	['_force',FALSE]
];
if ((_types isEqualTo []) && (!(_force))) exitWith {localNamespace setVariable ['QS_service_blocked',FALSE];};
private _onFoot = isNull (objectParent QS_player);
private _msgDelay = -1;
private _text = '';
private _vehicleTypeLower = toLowerANSI (typeOf _vehicle);
([_vehicle,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
localNamespace setVariable ['QS_service_cancelled',FALSE];
if ((_vehicle getVariable ['QS_service_eventHit',-1]) isEqualTo -1) then {
	_vehicle setVariable ['QS_service_eventHit',(_vehicle addEventHandler ['Hit',{
		localNamespace setVariable ['QS_service_cancelled',TRUE];
		(_this # 0) removeEventHandler [_thisEvent,_thisEventHandler];
	}]),FALSE];
};
private _fn_cancel = {
	params ['_vehicle',['_onFoot',FALSE]];
	(
		(!alive _vehicle) ||
		{(
			(isEngineOn _vehicle) && 
			{(!unitIsUav _vehicle)} &&
			{((['LandVehicle','Air','Ship'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1)}
		)} ||
		{(((vectorMagnitude (velocity _vehicle)) * 3.6) >= 1)} ||
		{((!(_vehicle isKindOf 'Ship')) && (!(isTouchingGround _vehicle)))} ||
		{((!(_vehicle isKindOf 'Ship')) && (((getPosASL _vehicle) # 2) <= -1))} ||
		{(!isNull curatorCamera)} ||
		{(localNamespace getVariable ['QS_service_cancelled',FALSE])}
	)
};
private _cancelled = FALSE;
if (
	(isEngineOn _vehicle) &&
	{(!unitIsUav _vehicle)} &&
	{((['LandVehicle','Air','Ship'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1)}
) exitWith {
	localNamespace setVariable ['QS_service_blocked',FALSE];
	_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
	_vehicle setVariable ['QS_service_eventHit',-1];
	50 cutText [localize 'STR_QS_Text_285','PLAIN DOWN',0.333];
};
private _waterDamaged = waterDamaged _vehicle;
private _attachedObjs = attachedObjects _vehicle;
private _serviceInfo = _types select { (_x # 1) isEqualTo 'recover' };
if (_vehicle getVariable ['QS_logistics_wreck',FALSE]) exitWith {
	localNamespace setVariable ['QS_service_blocked',FALSE];
	_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
	_vehicle setVariable ['QS_service_eventHit',-1,FALSE];
	_recoverTypes = _types select {
		((!((_x # 0) isKindOf 'B_APC_Tracked_01_CRV_F')) && (!((_x # 0) getVariable ['QS_logistics_recoverEnabled',FALSE])))
	};
	if (
		(_serviceInfo isNotEqualTo []) ||
		{((['repair','refuel','reammo'] arrayIntersect (_recoverTypes apply { _x # 1 })) isEqualTo ['repair','refuel','reammo'])} ||
		{([_vehicle] call QS_fnc_canRecover)} ||
		{_force}
	) then {
		if (scriptDone (localNamespace getVariable ['QS_recoverWreckClient_script',scriptNull])) then {
			localNamespace setVariable ['QS_recoverWreckClient_script',([_vehicle,_recoverTypes,_force,_onFoot] spawn QS_fnc_recoverWreckClient)];
		};
	};
};
_serviceInfo = _types select { (_x # 1) isEqualTo 'repair' };
if (
	((_serviceInfo isNotEqualTo []) || _force) &&
	{(!(_vehicle getVariable ['QS_services_repair_disabled',FALSE]))} &&
	{(!(missionNamespace getVariable ['QS_services_repair_disabled',FALSE]))}
) then {
	if (_serviceInfo isNotEqualTo []) then {
		_serviceInfo = _serviceInfo # 0;
		_serviceInfo params ['_serviceProvider','_serviceType'];
	};
	private _repairInterval = 0.2;			// per 0.05 of dmg restore
	private _repairPerCycle = 0.05;
	if (local _vehicle) then {
		(getAllHitPointsDamage _vehicle) params ['_selection','',['_damage',[]]];
		if ((_damage isNotEqualTo []) || _waterDamaged) then {
			private _repairingPerformed = FALSE;
			private _hit = 0;
			private _msgDelay = -1;
			private _selectionCount = count _damage;
			{
				_hit = _x;
				if (_hit > 0) then {
					if (!(_repairingPerformed)) then {
						_repairingPerformed = TRUE;
					};
					for '_i' from 0 to 999 step 1 do {
						if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
						if (diag_tickTime > _msgDelay) then {
							50 cutText [format [localize 'STR_QS_Text_279',(_forEachIndex + 1),_selectionCount],'PLAIN DOWN',0.333];
							_msgDelay = diag_tickTime + 1;
						};
						_hit = (_hit - _repairPerCycle) max 0;
						_vehicle setHitIndex [_forEachIndex,_hit,FALSE];
						if (_hit <= 0) exitWith {};
						sleep _repairInterval;
					};
				};
				if (_cancelled) exitWith {};
			} forEach _damage;
			if (!(_cancelled)) then {
				if (_repairingPerformed || _waterDamaged) then {
					_vehicle setDamage [0,FALSE];
					50 cutText [localize 'STR_QS_Text_278','PLAIN DOWN',0.333];
				};
			};
		} else {
			if (((damage _vehicle) > 0) || _waterDamaged) then {
				private _damage = damage _vehicle;
				if (!(_repairingPerformed)) then {
					_repairingPerformed = TRUE;
				};
				for '_i' from 0 to 999 step 1 do {
					if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
					if (diag_tickTime > _msgDelay) then {
						50 cutText [localize 'STR_QS_Text_286','PLAIN DOWN',0.333];
						_msgDelay = diag_tickTime + 1;
					};
					_damage = (_damage - _repairPerCycle) max 0;
					_vehicle setDamage [_damage,FALSE];
					if (_damage <= 0) exitWith {};
					sleep _repairInterval;
				};
			};
		};
	};
	if (!(_cancelled)) then {
		private _repairedChildren = [];
		if (_attachedObjs isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{((damage _x) > 0) || (waterDamaged _x)}
				)then {
					_repairedChildren pushBackUnique _x;
					_x setDamage [0,FALSE];
				};
			} forEach _attachedObjs;
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{((damage _x) > 0) || (waterDamaged _x)} &&
					{(!(_x in _repairedChildren))}
				) then {
					_x setDamage [0,FALSE];
					_repairedChildren pushBackUnique _x;
				};
			} forEach (getVehicleCargo _vehicle);
		};
		if (
			(alive (getSlingLoad _vehicle)) &&
			{((damage (getSlingLoad _vehicle)) > 0)} &&
			{(!((getSlingLoad _vehicle) in _repairedChildren))}
		) then {
			(getSlingLoad _vehicle) setDamage [0,FALSE];
		};
	};
};
if (_cancelled) exitWith {
	localNamespace setVariable ['QS_service_blocked',FALSE];
	_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
	_vehicle setVariable ['QS_service_eventHit',-1];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
_serviceInfo = _types select { (_x # 1) isEqualTo 'refuel' };
if (
	((_serviceInfo isNotEqualTo []) || _force) &&
	{(!(_vehicle getVariable ['QS_services_refuel_disabled',FALSE]))} &&
	{(!(missionNamespace getVariable ['QS_services_refuel_disabled',FALSE]))}
) then {
	if (_serviceInfo isNotEqualTo []) then {
		_serviceInfo = _serviceInfo # 0;
		_serviceInfo params ['_serviceProvider','_serviceType'];
	};
	private _refuelInterval = 0.3;
	private _refuelPerCycle = 0.01;
	private _fuel = fuel _vehicle;
	private _fuelAdded = FALSE;
	if (
		(local _vehicle) &&
		{(_fuel < 0.99)}
	) then {
		for '_i' from 0 to 999 step 1 do {
			if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
			if (diag_tickTime > _msgDelay) then {
				50 cutText [format ['%1 ( %2%3 )',localize 'STR_QS_Text_281',(ceil((fuel _vehicle) * 100)),'%'],'PLAIN DOWN',0.333];
				_msgDelay = diag_tickTime + 1;
			};
			_fuel = _fuel + _refuelPerCycle;
			if (!(_fuelAdded)) then {
				_fuelAdded = TRUE;
			};
			_vehicle setFuel _fuel;
			if (((fuel _vehicle) >= 1) || (_fuel >= 1)) exitWith {};
			sleep _refuelInterval;
		};
		if (!(_cancelled)) then {
			_vehicle setFuel 1;
		};
	};
	if (!(_cancelled)) then {
		private _refuelledChildren = [];
		if (_attachedObjs isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{((fuel _x) < 0.99)}
				) then {
					_refuelledChildren pushBackUnique _x;
					_fuelAdded = TRUE;
					if (local _x) then {
						_x setFuel 1;
					} else {
						['setFuel',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
					};
				};
			} forEach _attachedObjs;
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{((fuel _x) < 0.99)} &&
					{(!(_x in _refuelledChildren))}
				) then {
					_refuelledChildren pushBackUnique _x;
					_fuelAdded = TRUE;
					if (local _x) then {
						_x setFuel 1;
					} else {
						['setFuel',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
					};
				};
			} forEach (getVehicleCargo _vehicle);
		};
		if (
			(alive (getSlingLoad _vehicle)) &&
			{(!((getSlingLoad _vehicle) in _refuelledChildren))} &&
			{((fuel (getSlingLoad _vehicle)) < 0.99)}
		) then {
			if (local (getSlingLoad _vehicle)) then {
				(getSlingLoad _vehicle) setFuel 1;
			} else {
				['setFuel',(getSlingLoad _vehicle),1] remoteExec ['QS_fnc_remoteExecCmd',(getSlingLoad _vehicle),FALSE];
			};
		};
		if (_fuelAdded) then {
			50 cutText [localize 'STR_QS_Text_280','PLAIN DOWN',0.333];
		};
	};
};
if (_cancelled) exitWith {
	localNamespace setVariable ['QS_service_blocked',FALSE];
	_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
	_vehicle setVariable ['QS_service_eventHit',-1];
	50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];
};
_serviceInfo = _types select { (_x # 1) isEqualTo 'reammo' };
if (
	((_serviceInfo isNotEqualTo []) || _force) &&
	{(!(_vehicle getVariable ['QS_services_reammo_disabled',FALSE]))} &&
	{(!(missionNamespace getVariable ['QS_services_reammo_disabled',FALSE]))}
) then {
	if (_serviceInfo isNotEqualTo []) then {
		_serviceInfo = _serviceInfo # 0;
		_serviceInfo params ['_serviceProvider','_serviceType'];
	};
	private _rearmInterval = 0.1;
	private _rearmPerCycleDefault = 1;
	private _rearmPerCycle = 1;
	private _rearmPerformed = FALSE;
	private _cached = [];
	private _displayName = '';
	private _fullCount = 0;
	private _isPylon = 0;
	private _pylonWeaponCfg = '';
	{
		if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
		_x params ['_magazineClass','_turret','_count','',''];
		_magazineClass = toLowerANSI _magazineClass;
		if (_vehicle turretLocal _turret) then {
			if (_magazineClass in _cached) then {
				_fullCount = _cached # ((_cached find _magazineClass) + 1);
				_displayName = _cached # ((_cached find _magazineClass) + 2);
				_isPylon = _cached # ((_cached find _magazineClass) + 3);
			} else {
				_cached pushBack _magazineClass;
				_fullCount = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_count',_magazineClass],
					{getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count')},
					TRUE
				];
				_cached pushBack _fullCount;
				_displayName = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_displayname',_magazineClass],
					{getText (configFile >> 'CfgMagazines' >> _magazineClass >> 'displayName')},
					TRUE
				];
				if (_magazineClass in (['smokelaunchermags'] call QS_data_listItems)) then {
					_displayName = localize 'STR_QS_Text_284';
				};
				_cached pushBack _displayName;
				_pylonWeaponCfg = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_pylonweapon',_magazineClass],
					{getText (configFile >> 'CfgMagazines' >> _magazineClass >> 'pylonWeapon')},
					TRUE
				];
				_isPylon = [0,1] select (_pylonWeaponCfg isNotEqualTo '');
				_cached pushBack _isPylon;
			};
			if (
				(_isPylon isEqualTo 0) &&
				{(_count isNotEqualTo _fullCount)}
			) then {
				_vehicle removeMagazineTurret [_magazineClass,_turret];
				if (diag_tickTime > _msgDelay) then {
					50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
					_msgDelay = diag_tickTime + 1;
				};
				if (_fullCount > 100) then {
					_rearmPerCycle = ceil (_fullCount / 100);
				} else {
					_rearmPerCycle = _rearmPerCycleDefault;
				};
				for '_ii' from _count to 9999 step 1 do {
					sleep _rearmInterval;
					if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
					_count = _count + _rearmPerCycle;
					if (_count >= _fullCount) exitWith {};
					if (diag_tickTime > _msgDelay) then {
						50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
						_msgDelay = diag_tickTime + 1;
					};
				};
				if (!(_rearmPerformed)) then {
					_rearmPerformed = TRUE;
				};
				_vehicle addMagazineTurret [_magazineClass,_turret,_count min _fullCount];
			};
		};
		if (_cancelled) exitWith {};
	} forEach (magazinesAllTurrets [_vehicle,TRUE]);
	if ((getAllPylonsInfo _vehicle) isNotEqualTo []) then {
		_rearmInterval = 0.1;
		{
			_x params ['_pIndex','_pName','_turret','_magazineClass','_count'];
			if (_vehicle turretLocal _turret) then {
				_fullCount = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_count',_magazineClass],
					{getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count')},
					TRUE
				];
				_displayName = QS_hashmap_configfile getOrDefaultCall [
					format ['cfgmagazines_%1_displayname',_magazineClass],
					{getText (configFile >> 'CfgMagazines' >> _magazineClass >> 'displayName')},
					TRUE
				];
				if (_count isNotEqualTo _fullCount) then {
					if (diag_tickTime > _msgDelay) then {
						50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
						_msgDelay = diag_tickTime + 1;
					};
					_rearmPerCycle = [_rearmPerCycleDefault,ceil (_fullCount / 100)] select (_fullCount > 100);
					for '_ii' from _count to 9999 step 1 do {
						sleep _rearmInterval;
						if ([_vehicle,_onFoot] call _fn_cancel) exitWith {_cancelled = TRUE;};
						_count = _count + _rearmPerCycle;
						_vehicle setAmmoOnPylon [_pIndex,_count];
						if (_count >= _fullCount) exitWith {};
						if (diag_tickTime > _msgDelay) then {
							50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
							_msgDelay = diag_tickTime + 1;
						};
					};
				};
			};
			if (_cancelled) exitWith {};
		} forEach (getAllPylonsInfo _vehicle);
		if (QS_player getUnitTrait 'QS_trait_fighterPilot') then {
			if (_vehicle isKindOf 'Plane') then {
				if (diag_tickTime > (uiNamespace getVariable ['QS_fighterPilot_lastMsg',(diag_tickTime - 1)])) then {
					uiNamespace setVariable ['QS_fighterPilot_lastMsg',(diag_tickTime + 300)];
					[63,[4,['CAS_1',['',localize 'STR_QS_Notif_153']]]] remoteExec ['QS_fnc_remoteExec',-2,FALSE];
					['sideChat',[WEST,'AirBase'],(format ['%3 %2 (%1)',(getText ((configOf _vehicle) >> 'displayName')),profileName,localize 'STR_QS_Chat_029'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
				};
			};
		};
	};
	if (local _vehicle) then {
		if (_vehicle isKindOf 'LandVehicle') then {
			[_vehicle] call (missionNamespace getVariable 'QS_fnc_vehicleAPSParams');
		};
	};
	if (!(_cancelled)) then {
		private _rearmedChildren = [];
		if (_attachedObjs isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{(serverTime > (_x getVariable ['QS_v_rearm_cooldown',-1]))}
				) then {
					_x setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
					_rearmedChildren pushBackUnique _x;
					if (local _x) then {
						_x setVehicleAmmo 1;
					} else {
						['setVehicleAmmo',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
					};
				};
			} forEach _attachedObjs;
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (
					(alive _x) &&
					{(!(_x in _rearmedChildren))} &&
					{(serverTime > (_x getVariable ['QS_v_rearm_cooldown',-1]))}
				) then {
					_x setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
					if (local _x) then {
						_x setVehicleAmmo 1;
					} else {
						['setVehicleAmmo',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
					};
					_rearmedChildren pushBackUnique _x;
				};
			} forEach (getVehicleCargo _vehicle);
		};
		
		if (
			(alive (getSlingLoad _vehicle)) &&
			{(!((getSlingLoad _vehicle) in _rearmedChildren))} &&
			{(serverTime > ((getSlingLoad _vehicle) getVariable ['QS_v_rearm_cooldown',-1]))}
		) then {
			(getSlingLoad _vehicle) setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
			if (local (getSlingLoad _vehicle)) then {
				(getSlingLoad _vehicle) setVehicleAmmo 1;
			} else {
				['setVehicleAmmo',(getSlingLoad _vehicle),1] remoteExec ['QS_fnc_remoteExecCmd',(getSlingLoad _vehicle),FALSE];
			};
		};
	};
	if (_rearmPerformed) then {
		50 cutText [localize 'STR_QS_Text_282','PLAIN DOWN',0.333];
	};
};
if (_inSafezone && _safezoneActive && (_safezoneLevel > 1)) then {
	// Ideally this is not tied to a safezone, but its all we got for now
	// Vehicle is being serviced in a Level 2 safezone - replenish scripted consumables
	if (serverTime > (_vehicle getVariable ['QS_service_resupplyCooldown',-1])) then {
		(localize 'STR_QS_Hints_188') call QS_fnc_hint;
		_vehicle setVariable ['QS_service_resupplyCooldown',serverTime + 60,TRUE];
		[_vehicle] call QS_fnc_replenishServices;
		_attached = attachedObjects _vehicle;
		if (_attached isNotEqualTo []) then {
			{
				if (
					(!isSimpleObject _x) &&
					(!isObjectHidden _x)
				) then {
					[_x] call QS_fnc_vSetupContainer;
					[_x] call QS_fnc_replenishServices;
				};
			} forEach _attached;
		};
	};
};
localNamespace setVariable ['QS_service_blocked',FALSE];
_vehicle removeEventHandler ['Hit',(_vehicle getVariable ['QS_service_eventHit',-1])];
_vehicle setVariable ['QS_service_eventHit',-1];
if (_cancelled) exitWith {50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];};
51 cutText [localize 'STR_QS_Text_423','PLAIN',0.1];