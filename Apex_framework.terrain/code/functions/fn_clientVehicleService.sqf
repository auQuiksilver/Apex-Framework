/*
File: fn_clientVehicleService.sqf
Author:
	
	Quiksilver
	
Last Modified:

	10/11/2022 A3 2.10 by Quiksilver

Description:

	Service a vehicle (replacement for vanilla system)
_______________________________________*/

params [
	['_vehicle',objNull],
	['_types',[]]
];
private _msgDelay = -1;
private _text = '';
_cancel = {
	params ['_vehicle'];
	(
		(!alive _vehicle) ||
		(isEngineOn _vehicle) ||
		(_vehicle isNotEqualTo cameraOn) ||
		(((vectorMagnitude (velocity _vehicle)) * 3.6) >= 1) ||
		((!(_vehicle isKindOf 'Ship')) && (!(isTouchingGround _vehicle))) ||
		((!(_vehicle isKindOf 'Ship')) && (((getPosASL _vehicle) # 2) <= -1)) ||
		(!isNull curatorCamera)
	)
};
private _cancelled = FALSE;
if (isEngineOn _vehicle) exitWith {
	50 cutText [localize 'STR_QS_Text_285','PLAIN DOWN',0.333];
};
if ('repair' in _types) then {
	private _repairInterval = 0.2;			// per 0.05 of dmg restore
	private _repairPerCycle = 0.05;
	if (local _vehicle) then {
		(getAllHitPointsDamage _vehicle) params ['_selection','',['_damage',[]]];
		if (_damage isNotEqualTo []) then {
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
						if ([_vehicle] call _cancel) exitWith {_cancelled = TRUE;};
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
				if (_repairingPerformed) then {
					_vehicle setDamage [0,FALSE];
					50 cutText [localize 'STR_QS_Text_278','PLAIN DOWN',0.333];
				};
			};
		};
	};
	if (!(_cancelled)) then {
		private _repairedChildren = [];
		if ((attachedObjects _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if ((damage _x) > 0) then {
						_repairedChildren pushBackUnique _x;
						_x setDamage [0,FALSE];
					};
				};
			} forEach (attachedObjects _vehicle);
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if (!(_x in _repairedChildren)) then {
						if ((damage _x) > 0) then {
							_x setDamage [0,FALSE];
							_repairedChildren pushBackUnique _x;
						};
					};
				};
			} forEach (getVehicleCargo _vehicle);
		};
		if (alive (getSlingLoad _vehicle)) then {
			if (!((getSlingLoad _vehicle) in _repairedChildren)) then {
				if ((damage (getSlingLoad _vehicle)) > 0) then {
					(getSlingLoad _vehicle) setDamage [0,FALSE];
				};
			};
		};
	};
};
if (_cancelled) exitWith {50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];};
if ('refuel' in _types) then {
	private _refuelInterval = 0.3;
	private _refuelPerCycle = 0.01;
	private _fuel = fuel _vehicle;
	private _fuelAdded = FALSE;
	if (_fuel < 0.99) then {
		if (local _vehicle) then {
			for '_i' from 0 to 999 step 1 do {
				if ([_vehicle] call _cancel) exitWith {_cancelled = TRUE;};
				if (diag_tickTime > _msgDelay) then {
					50 cutText [localize 'STR_QS_Text_281','PLAIN DOWN',0.333];
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
	};
	if (!(_cancelled)) then {
		private _refuelledChildren = [];
		if ((attachedObjects _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if ((fuel _x) < 0.99) then {
						_refuelledChildren pushBackUnique _x;
						_fuelAdded = TRUE;
						if (local _x) then {
							_x setFuel 1;
						} else {
							['setFuel',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
						};
					};
				};
			} forEach (attachedObjects _vehicle);
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if (!(_x in _refuelledChildren)) then {
						if ((fuel _x) < 0.99) then {
							_refuelledChildren pushBackUnique _x;
							_fuelAdded = TRUE;
							if (local _x) then {
								_x setFuel 1;
							} else {
								['setFuel',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
							};
						};
					};
				};
			} forEach (getVehicleCargo _vehicle);
		};
		if (alive (getSlingLoad _vehicle)) then {
			if (!((getSlingLoad _vehicle) in _refuelledChildren)) then {
				if ((fuel (getSlingLoad _vehicle)) < 0.99) then {
					if (local (getSlingLoad _vehicle)) then {
						(getSlingLoad _vehicle) setFuel 1;
					} else {
						['setFuel',(getSlingLoad _vehicle),1] remoteExec ['QS_fnc_remoteExecCmd',(getSlingLoad _vehicle),FALSE];
					};
				};
			};
		};
		if (_fuelAdded) then {
			50 cutText [localize 'STR_QS_Text_280','PLAIN DOWN',0.333];
		};
	};
};
if (_cancelled) exitWith {50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];};
if ('reammo' in _types) then {
	private _rearmInterval = 0.1;
	private _rearmPerCycle = 1;
	private _rearmPerformed = FALSE;
	private _cached = [];
	private _displayName = '';
	private _fullCount = 0;
	private _isPylon = 0;
	{
		if ([_vehicle] call _cancel) exitWith {_cancelled = TRUE;};
		_x params ['_magazineClass','_turret','_count','',''];
		if (_vehicle turretLocal _turret) then {
			if (_magazineClass in _cached) then {
				_fullCount = _cached # ((_cached find _magazineClass) + 1);
				_displayName = _cached # ((_cached find _magazineClass) + 2);
				_isPylon = _cached # ((_cached find _magazineClass) + 3);
			} else {
				_fullCount = getNumber (configFile >> 'CfgMagazines' >> _magazineClass >> 'count');
				_displayName = getText (configFile >> 'CfgMagazines' >> _magazineClass >> 'displayName');
				_isPylon = [0,1] select ((getText (configFile >> 'CfgMagazines' >> _magazineClass >> 'pylonWeapon')) isNotEqualTo '');
				if ((toLowerANSI _magazineClass) in ['smokelaunchermag','smokelaunchermag_boat','smokelaunchermag_single']) then {
					_displayName = localize 'STR_QS_Text_284';
				};
				_cached pushBack _magazineClass;
				_cached pushBack _fullCount;
				_cached pushBack _displayName;
				_cached pushBack _isPylon;
			};
			if (_isPylon isEqualTo 0) then {
				if (_count isNotEqualTo _fullCount) then {
					_vehicle removeMagazineTurret [_magazineClass,_turret];
					if (diag_tickTime > _msgDelay) then {
						50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
						_msgDelay = diag_tickTime + 1;
					};
					for '_ii' from _count to 9999 step 1 do {
						sleep _rearmInterval;
						if ([_vehicle] call _cancel) exitWith {_cancelled = TRUE;};
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
		};
		if (_cancelled) exitWith {};
	} forEach (magazinesAllTurrets [_vehicle,TRUE]);
	if ((getAllPylonsInfo _vehicle) isNotEqualTo []) then {
		_rearmInterval = 1;
		{
			_x params ['_pIndex','_pName','_turret','_magazineClass','_count'];
			if (_vehicle turretLocal _turret) then {
				if (_magazineClass in _cached) then {
					_fullCount = _cached # ((_cached find _magazineClass) + 1);
					_displayName = _cached # ((_cached find _magazineClass) + 2);
					if (_count isNotEqualTo _fullCount) then {
						if (diag_tickTime > _msgDelay) then {
							50 cutText [format [localize 'STR_QS_Text_283',_count,_fullCount,_displayName],'PLAIN DOWN',0.333];
							_msgDelay = diag_tickTime + 1;
						};
						for '_ii' from _count to 9999 step 1 do {
							sleep _rearmInterval;
							if ([_vehicle] call _cancel) exitWith {_cancelled = TRUE;};
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
			};
			if (_cancelled) exitWith {};
		} forEach (getAllPylonsInfo _vehicle);
	};
	if (!(_cancelled)) then {
		private _rearmedChildren = [];
		if ((attachedObjects _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if (serverTime > (_x getVariable ['QS_v_rearm_cooldown',-1])) then {
						_x setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
						_rearmedChildren pushBackUnique _x;
						if (local _x) then {
							_x setVehicleAmmo 1;
						} else {
							['setVehicleAmmo',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
						};
					};
				};
			} forEach (attachedObjects _vehicle);
		};
		if ((getVehicleCargo _vehicle) isNotEqualTo []) then {
			{
				if (alive _x) then {
					if (!(_x in _rearmedChildren)) then {
						if (serverTime > (_x getVariable ['QS_v_rearm_cooldown',-1])) then {
							_x setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
							if (local _x) then {
								_x setVehicleAmmo 1;
							} else {
								['setVehicleAmmo',_x,1] remoteExec ['QS_fnc_remoteExecCmd',_x,FALSE];
							};
							_rearmedChildren pushBackUnique _x;
						};
					};
				};
			} forEach (getVehicleCargo _vehicle);
		};
		if (alive (getSlingLoad _vehicle)) then {
			if (!((getSlingLoad _vehicle) in _rearmedChildren)) then {
				if (serverTime > ((getSlingLoad _vehicle) getVariable ['QS_v_rearm_cooldown',-1])) then {
					(getSlingLoad _vehicle) setVariable ['QS_v_rearm_cooldown',serverTime + 180,TRUE];
					if (local (getSlingLoad _vehicle)) then {
						(getSlingLoad _vehicle) setVehicleAmmo 1;
					} else {
						['setVehicleAmmo',(getSlingLoad _vehicle),1] remoteExec ['QS_fnc_remoteExecCmd',(getSlingLoad _vehicle),FALSE];
					};
				};
			};
		};
	};
	if (_rearmPerformed) then {
		50 cutText [localize 'STR_QS_Text_282','PLAIN DOWN',0.333];
	};
};
if (_cancelled) exitWith {50 cutText [localize 'STR_QS_Text_128','PLAIN DOWN',0.333];};