/*/
File: fn_registerVehicle.sqf
Author:

	Quiksilver
	
Last Modified:

	6/01/2023 A3 2.10 by Quiksilver
	
Description:

	Vehicle Registration
	
Notes:
	
	[
		objnull,				// --- [DO NOT EDIT] the vehicle object stored here once it spawns
		30,						// --- [CAN EDIT] vehicle respawn delay
		false,					// --- [CAN EDIT] randomized vehicle
		{},						// --- [CAN EDIT] custom init code
		'B_Quadbike_01_F',		// --- [CAN EDIT] vehicle type
		[0,0,0],				// --- [CAN EDIT] vehicle spawn position
		0,						// --- [CAN EDIT] vehicle spawn direction
		false,					// --- [DO NOT EDIT] is vehicle respawning now
		0,						// --- [DO NOT EDIT] when can vehicle respawn
		-1,						// --- [CAN EDIT] FOB vehicle ID (-1 if not a FOB vehicle)
		50,						// --- [CAN EDIT] vehicle abandonment distance (at base)
		500,					// --- [CAN EDIT] vehicle abandonment distance (away from base)
		-1,						// --- [CAN EDIT] respawn tickets
		5,						// --- [CAN EDIT] required safe respawn radius
		true,					// --- [CAN EDIT] is a dynamic "Activate" vehicle (performance saving)
		0						// --- [CAN EDIT] is spawned on an aircraft carrier deck
	]

	0 = [
		this,
		30,
		false,
		{},
		50,
		500,
		-1,
		true
	] call QS_fnc_registerVehicle;
	
	0 = [
		this,
		30,
		false,
		{},
		50,
		500,
		-1,
		true,
		-1,			// Safe Position Radius check (-1 to ignore)
		1			// 0 - Ground position, 1 - Elevated position (including ship decks)
	] call QS_fnc_registerVehicle;
_____________________________________________________________________/*/

if (!isDedicated) exitWith {0};
_this spawn {
	waitUntil {
		uiSleep (0.1 + (random 0.1));
		((missionNamespace getVariable ['QS_missionConfig_baseLayout',-1]) isNotEqualTo -1)
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
	private _spawnPosition = (ASLToAGL (getPosASL _vehicle)) vectorAdd [0,0,([0.1,0] select (surfaceIsWater _spawnPosition))];	/*/ Ideally we'd use ASL but a lot of internal changes would have to be made and tested+verified .../*/
	private _spawnDirection = getDir _vehicle;
	private _isRespawning = FALSE;
	private _canRespawnAfter = 0;
	private _vehicleFobID = -1;
	if (_isCarrierVehicle > 0) then {
		_spawnPosition = getPosASL _vehicle;		// getPosWorld
	};
	if (unitIsUav _vehicle) exitWith {
		if (isNil {missionNamespace getVariable 'QS_uav_Monitor'}) then {
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
	if (isNil {serverNamespace getVariable 'QS_v_Monitor'}) then {
		serverNamespace setVariable ['QS_v_Monitor',[]];
	};
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
		_isDynamicVehicle,
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