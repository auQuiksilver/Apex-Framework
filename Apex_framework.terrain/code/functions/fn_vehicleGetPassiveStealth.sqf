/*/
File: fn_vehicleGetPassiveStealth.sqf
Author:

	Quiksilver
	
Last Modified:

	27/01/2023 A3 2.12 by Quiksilver
	
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
	if (((vectorMagnitude (velocity _vehicle)) * 3.6) > 100) then {
		// Low and fast
		if (((getPos _vehicle) # 2) < 50) then {
			_stealth = _stealth + (linearConversion [0,50,((getPos _vehicle) # 2),0.3,0,TRUE]);
		};
	};
	// Hummingbird
	if (_vehicle isKindOf 'Heli_Light_01_unarmed_base_F') then {
		if (((vectorMagnitude (velocity _vehicle)) * 3.6) > 100) then {
			_stealth = _stealth + 0.15;
		};
		if ((_vehicle animationSourcePhase 'BenchL_Up') isEqualTo 1) then {
			_stealth = _stealth + 0.6;
		};
		if (!isNull (getSlingLoad _vehicle)) then {
			_stealth = _stealth - 0.3;
		};
	};
	// Pawnee
	if (_vehicle isKindOf 'Heli_Light_01_armed_base_F') then {
		if (((vectorMagnitude (velocity _vehicle)) * 3.6) > 100) then {
			_stealth = _stealth + 0.25;
		};
		if (!isNull (getSlingLoad _vehicle)) then {
			_stealth = _stealth - 0.3;
		};
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
(0 max (_vehicle getVariable ['QS_vehicle_passiveStealth',_stealth]) min _maxPassiveStealth)