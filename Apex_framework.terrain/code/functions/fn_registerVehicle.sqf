/*/
File: fn_registerVehicle.sqf
Author:

	Quiksilver
	
Last Modified:

	2/06/2023 A3 2.12 by Quiksilver
	
Description:

	Vehicle Registration
	
Notes:

	0 = [
		this,
		30,			// respawn delay
		false,		// randomize from preset pool of similar assets
		{},			// init code
		50,			// at-base abandonment distance
		500,		// away-from-base abandonment distance
		-1,			// respawn tickets, -1 for infinite, 0 for no respawn, 1 for 1 respawn, etc.
		true,		// dynamic vehicle (performance saving, not for helicopters tho)
		-1,			// Safe Position Radius check (-1 to ignore)
		1,			// 0 - Ground position, 1 - Elevated position (including ship decks)
		{TRUE},		// Respawn condition code. Can only respawn if this returns true.
		[],
		0,			// Wreck chance. 0 = never a wreck. 1 = always a wreck. 0.5 = 50% chance of becoming a wreck.
		{TRUE}		// Wreck condition code. Can only become a wreck if this code returns true.
	] call QS_fnc_registerVehicle;
_____________________________________________________________________/*/

if (!isDedicated) exitWith {0};
_this spawn {
	waitUntil {
		uiSleep (0.2 + (random 0.2));
		(missionNamespace getVariable ['QS_mission_init',FALSE])
	};
	params [
		['_vehicle',objNull],
		['_respawnDelay',30],
		['_randomize',FALSE],
		['_initCode',{}],
		['_abandonmentDistanceBase',50],
		['_abandonmentDistanceField',500],
		['_respawnTickets',-1],
		['_isDynamicVehicle',TRUE],
		['_safeRespawnRadius',4],
		['_isCarrierVehicle',0],
		['_vehicleSpawnCondition',{TRUE}],
		['_wreckInfo',[]],
		['_wreckChance',0],
		['_wreckCondition',{TRUE}]
	];
	if (
		((missionNamespace getVariable ['QS_missionConfig_baseLayout',0]) isEqualTo 0) &&
		{(!(_vehicle getVariable ['QS_missionObject_protected',FALSE]))}
	) exitWith {};
	private _vehicleType = typeOf _vehicle;
	private _spawnPosition = (ASLToAGL (getPosASL _vehicle)) vectorAdd [0,0,([0.1,0] select (surfaceIsWater (getPosASL _vehicle)))];
	private _spawnDirection = getDir _vehicle;
	private _isRespawning = FALSE;
	private _canRespawnAfter = 0;
	private _vehicleFobID = -1;
	if (_isCarrierVehicle > 0) then {
		_spawnPosition = getPosASL _vehicle;		// getPosWorld
	};
	if (unitIsUav _vehicle) exitWith {
		if (missionNamespace isNil 'QS_uav_Monitor') then {
			missionNamespace setVariable ['QS_uav_Monitor',[],TRUE];
		};
		(missionNamespace getVariable 'QS_uav_Monitor') pushBack [
			objNull,
			(toLowerANSI _vehicleType),
			(getPosASL _vehicle),
			(getDir _vehicle),
			[(vectorDir _vehicle),(vectorUp _vehicle)],
			_initCode,
			FALSE,
			-1
		];
		missionNamespace setVariable ['QS_uav_Monitor',(missionNamespace getVariable ['QS_uav_Monitor',[]]),TRUE];
		deleteVehicle _vehicle;
	};
	if (serverNamespace isNil 'QS_v_Monitor') then {
		serverNamespace setVariable ['QS_v_Monitor',[]];
	};
	_wreckChance = [_wreckChance,0] select ((_vehicle isKindOf 'Helicopter') && ((getAllPylonsInfo _vehicle) isEqualTo []));
	(serverNamespace getVariable 'QS_v_Monitor') pushBack [
		_vehicle,
		_respawnDelay,
		_randomize,
		_initCode,
		_vehicleType,
		_spawnPosition,
		_spawnDirection,
		_isRespawning,
		_canRespawnAfter,
		_vehicleFobID,
		_abandonmentDistanceBase,
		_abandonmentDistanceField,
		_respawnTickets,
		_safeRespawnRadius,
		([_isDynamicVehicle,FALSE] select (_vehicle isKindOf 'Helicopter')),
		_isCarrierVehicle,
		_vehicleSpawnCondition,
		FALSE,						// is wreck
		FALSE,						// is deployed
		[],							// dynamic state data
		_wreckInfo,					// wreck info
		_wreckChance,				// wreck chance
		_wreckCondition				// wreck condition
	];
	deleteVehicle _vehicle;
};
0;