/*/
File: fn_vehicleGetPassiveStealth.sqf
Author:

	Quiksilver
	
Last Modified:

	6/11/2023 A3 2.14 by Quiksilver
	
Description:

	Passive Stealth Coef
___________________________________________/*/

params ['_vehicle','_shooter','_projectile'];
if (!local _vehicle) exitWith {0};
private _stealth = 0;
_maxPassiveStealth = 0.95;
if ((['Tank','Wheeled_APC_F','Ship'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1) exitWith {
	if (((vectorMagnitude (velocity _vehicle)) * 3.6) < 10) then {
		_stealth = _stealth + 0.15;
	};
	if ((_vehicle animationSourcePhase 'showcamonethull') isEqualTo 1) then {
		_stealth = _stealth + 0.25;
	};
	(_vehicle getVariable ['QS_passiveStealth_smokeInterval',[-1,-1]]) params ['_smokeStart','_smokeEnd'];
	if (_smokeEnd > serverTime) then {
		_stealth = _stealth + (linearConversion [_smokeStart,_smokeEnd,serverTime,1,0,TRUE]);
	};
	// Disqualifiers
	if (
		(isLightOn _vehicle) ||
		{(isVehicleRadarOn _vehicle)}
	) then {
		_stealth = 0;
	};
	(0 max (_vehicle getVariable ['QS_vehicle_passiveStealth',_stealth]) min _maxPassiveStealth)
};
if ((['Helicopter'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1) exitWith {
	private _stealthAltCeiling = 50;		// altitude
	private _stealthAltCoef = 0.15;			// alt coef
	private _stealthVelCeiling = QS_hashmap_configfile getOrDefaultCall [
		format ['cfgvehicles_%1_maxspeed',toLowerANSI (typeOf _vehicle)],
		{getNumber ((configOf _vehicle) >> 'maxSpeed')},
		TRUE
	];
	private _stealthVelCoef = 0.15;			// vel coef
	// Hummingbird
	if (_vehicle isKindOf 'Heli_Light_01_unarmed_base_F') then {
		// Bench seats (stealth mode)
		if ((_vehicle animationSourcePhase 'BenchL_Up') isEqualTo 1) then {
			_stealth = _stealth + 0.6;
		};
	};
	// Pawnee
	if (_vehicle isKindOf 'Heli_Light_01_armed_base_F') then {
		_stealthVelCoef = 0.25;
	};
	// Ghosthawk
	if (_vehicle isKindOf 'Heli_Transport_01_base_F') then {
		_stealthVelCeiling = 100;
		_stealthVelCoef = 0.15;
		_stealthAltCeiling = 100;
		_stealthAltCoef = 0.15;
		// Ghosthawk doors closed
		if ((_vehicle animationPhase 'Door_L') isEqualTo 0) then {
			_stealth = _stealth + 0.10;
		};
	};
	// Blackfoot
	if (_vehicle isKindOf 'Heli_Attack_01_base_F') then {
		_stealthVelCeiling = 100;
		_stealthVelCoef = 0.25;
		_stealthAltCeiling = 100;
		_stealthAltCoef = 0.25;
		// Blackfoot missile bay closed
		if ((_vehicle animationPhase 'leftholdster_dynloadout') isEqualTo 0) then {
			_stealth = _stealth + 0.10;
		};
	};
	// Low
	_stealth = _stealth + (linearConversion [0,_stealthAltCeiling,((getPos _vehicle) # 2),_stealthAltCoef,0,TRUE]);
	// Fast
	_stealth = _stealth + (linearConversion [0,_stealthVelCeiling,((vectorMagnitude (velocity _vehicle)) * 3.6),0,_stealthVelCoef,TRUE]);
	// Slingload
	if (!isNull (getSlingLoad _vehicle)) then {
		_stealth = _stealth - 0.3;
	};
	// Disqualifiers
	if (
		(isLightOn _vehicle) ||
		{(isCollisionLightOn _vehicle)} ||
		{(isVehicleRadarOn _vehicle)}
	) then {
		_stealth = 0;
	};
	(0 max (_vehicle getVariable ['QS_vehicle_passiveStealth',_stealth]) min _maxPassiveStealth)
};
if ((['Plane'] findIf { _vehicle isKindOf _x }) isNotEqualTo -1) exitWith {
	// To Do
	(0 max (_vehicle getVariable ['QS_vehicle_passiveStealth',_stealth]) min _maxPassiveStealth)
};
(0 max (_vehicle getVariable ['QS_vehicle_passiveStealth',_stealth]) min _maxPassiveStealth)