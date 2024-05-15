/*/
File: fn_eventRespawnVehicle.sqf
Author:
	
	Quiksilver
	
Last Modified:

	10/03/2024 A3 2.18 by Quiksilver
	
Description:

	Vehicle Respawn event
	
Notes:

	https://community.bistudio.com/wiki/getRespawnVehicleInfo
	https://community.bistudio.com/wiki/vehicleVarName
	https://community.bistudio.com/wiki/respawnVehicle
	
	Find the bug!
______________________________________________________/*/

[missionNamespace, "respawn", {
		diag_log 'scripted respawn 0';
	params ["_newVeh", "_veh"];
	(format ['Respawn %1 - %2',typeOf _newVeh,diag_tickTime]) remoteExec ['systemChat',-2];
}] call BIS_fnc_addScriptedEventHandler;



QS_fnc_eventRespawnVehicle = {
	diag_log 'v respawn 0';
	
	params ['_v','_wreck'];
	
	(format ['Respawned %2 - %1',diag_tickTime,typeOf _v]) remoteExec ['systemChat',-2];
	
	private _vehicleVarName = '';
	private _respawnInfo = [
		-1,
		-1,
		TRUE,
		TRUE,
		FALSE,
		objNull,
		3,
		WEST,
		TRUE
	];
	private _respawnMarker = 'respawn_vehicle';
	if (!isNull _wreck) then {
		_respawnInfo = getRespawnVehicleInfo _wreck;
		_vehicleVarName = _wreck getVariable ['QS_vvn',vehicleVarName _wreck];
		_respawnMarker = _wreck getVariable ['QS_v_respawnMarker',_wreck getRespawnVehicleInfo 11];
	};
	_v setVehicleVarName _vehicleVarName;
	_v setVariable ['QS_vvn',_vehicleVarName,TRUE];
	_v setVariable ['QS_v_respawnMarker',_v getRespawnVehicleInfo 11,TRUE];
	_v addEventHandler ['Respawn',{call QS_fnc_eventRespawnVehicle}];
	_v addEventHandler [
		'Killed',
		{
			params ['_vehicle'];
			_vehicle removeAllEventHandlers 'Deleted';
		}
	];
	_v addEventHandler [
		'Deleted',
		{
			params ['_vehicle'];
			'deleted 0' remoteExec ['systemChat',-2];
			if (
				TRUE || 
				(!(_vehicle getRespawnVehicleInfo 10))
			) then {
				'deleted 1' remoteExec ['systemChat',-2];
				[
					vehicleVarName _vehicle,
					local _vehicle,
					typeOf _vehicle,
					getRespawnVehicleInfo _vehicle,
					getEntityInfo _vehicle,
					((allVariables _vehicle) apply { [_x,_vehicle getVariable _x] })
				] spawn QS_fnc_restoreDeletedVehicle;
			};
		}
	];
	_v respawnVehicle (_respawnInfo select [0,8]);
	diag_log 'v respawn 1';
};





QS_fnc_restoreDeletedVehicle = {
	diag_log 'restore deleted vehicle 0';
	params [
		'_vehicleVarName',
		'_isLocal',
		'_type',
		'_vehicleRespawnInfo',
		'_entityInfo',
		'_varData'
	];
	_v = createVehicle [_type,[-5000,-5000,100 + (random 1000)]];
	_v setVehicleVarName _vehicleVarName;
	_v setVariable ['QS_vvn',_vehicleVarName,TRUE];
	_v setVariable ['QS_v_respawnMarker',_vehicleRespawnInfo # 11,TRUE];
	_v respawnVehicle (_vehicleRespawnInfo select [0,8]);
	_v addEventHandler ['Respawn',{call QS_fnc_eventRespawnVehicle}];
	_v addEventHandler [
		'Deleted',
		{
			params ['_vehicle'];
			diag_log 'deleted 0';
			'deleted 0' remoteExec ['systemChat',-2];
			
			if (
				TRUE || 
				(!(_vehicle getRespawnVehicleInfo 10))
			) then {
				'deleted 1' remoteExec ['systemChat',-2];
				[
					vehicleVarName _vehicle,
					local _vehicle,
					typeOf _vehicle,
					getRespawnVehicleInfo _vehicle,
					getEntityInfo _vehicle,
					((allVariables _vehicle) apply { [_x,_vehicle getVariable _x] })
				] spawn QS_fnc_restoreDeletedVehicle;
			};
		}
	];
	_v addEventHandler [
		'Killed',
		{
			params ['_vehicle'];
			_vehicle removeAllEventHandlers 'Deleted';
		}
	];
	sleep 1;
	_v setDamage [1,TRUE];
	diag_log 'restore deleted vehicle 1';
};

QS_fnc_addBasicVehicleRespawn = {
	diag_log 'add basic vehicle respawn 0';
	params [
		['_vehicle',objNull],
		['_vehicleVarName',''],
		['_respawnInfo',[]],
		['_side',WEST]
	];
	
	if (
		(!isDedicated) ||
		(!alive _vehicle) ||
		(!local _vehicle)
	) exitWith {FALSE};
	if ((count _respawnInfo) > 7) then {
		_side = _respawnInfo # 7;
	}; 
	private _markerName = toLowerANSI (format ['respawn_vehicle_%1',_side]);
	if (_vehicleVarName isNotEqualTo '') then {
		_vehicle setVehicleVarName _vehicleVarName;
		_vehicle setVariable ['QS_vvn',_vehicleVarName,TRUE];
		_markerName = toLowerANSI (format ['respawn_%1_%2',_vehicleVarName,_side]);
		if (!(_markerName in (allMapMarkers apply {toLowerANSI _x}))) then {
			_marker = createMarkerLocal [_markerName, _vehicle];
			_marker setMarkerDirLocal 0;
		};
		_vehicle setVariable ['QS_v_respawnMarker',_markerName,TRUE];
	};
	_vehicle addEventHandler ['Respawn',{call QS_fnc_eventRespawnVehicle}];
	_vehicle addEventHandler [
		'Killed',
		{
			params ['_vehicle'];
			_vehicle removeAllEventHandlers 'Deleted';
		}
	];
	_vehicle addEventHandler [
		'Deleted',
		{
			params ['_vehicle'];
			'deleted 0' remoteExec ['systemChat',-2];
			if (
				TRUE || 
				(!(_vehicle getRespawnVehicleInfo 10))
			) then {
				'deleted 1' remoteExec ['systemChat',-2];
				[
					vehicleVarName _vehicle,
					local _vehicle,
					typeOf _vehicle,
					getRespawnVehicleInfo _vehicle,
					getEntityInfo _vehicle,
					((allVariables _vehicle) apply { [_x,_vehicle getVariable _x] })
				] spawn QS_fnc_restoreDeletedVehicle;
			};
		}
	];	
	_vehicle respawnVehicle (_respawnInfo select [0,8]);
	diag_log 'add basic vehicle respawn 1';
	TRUE;
};

[
	QS_testV,
	'veh2',
	[
		5,
		-1,
		TRUE,
		TRUE,
		FALSE,
		objNull,
		3,
		WEST,
		TRUE
	],
	WEST
] call QS_fnc_addBasicVehicleRespawn;


vehicle respawnVehicle [
	respawnDelay, respawnCount, deleteOldWreck, respawnOnServer, respawnFlying, respawnUnit, respawnMode, respawnSide, useRespawnMarkerDir
]

Array in format [respawnDelay, respawnCount, deleteOldWreck, respawnOnServer, respawnFlying, respawnUnit, respawnMode, respawnSide, useRespawnMarkerDir, canRespawn, isRespawning, respawnMarkerName, respawnTimeRemaining, missionRespawnDelay, missionRespawnMode], where:
0 - respawnDelay: Number - how long the vehicle will be in respawn queue after death. -1 - 'missionRespawnDelay' value is used.
1 - respawnCount: Number - how many times left for the vehicle to respawn. -1 - indefinite, 0 - no more respawns
2 - deleteOldWreck: Boolean - if true then the old wreck will be deleted when vehicle respawns.
3 - respawnOnServer: Boolean - if true the wreck will be transfered to the server and vehicle will respawn on server.
4 - respawnFlying: Boolean - if true vehicle will not be forced to the ground and if can fly and has pilot will be spawned flying.
5 - respawnUnit: Object - pilot/driver unit that will be placed into the new vehicle.
6 - respawnMode: Number - individual respawn mode for this vehicle. Any mode other than 2,3 or -1 means disabled respawn. -1 - use 'missionRespawnMode'
7 - respawnSide: Side - what side markers to use for respawn. For example if 'respawnSide' set to east the markers with names 'respawn_vehicle_eastXXX' and 'respawn_eastXXX' will be used.
8 - useRespawnMarkerDir: Boolean - align respawned vehicle with respawn marker direction or with wreck direction if no marker found or "INSTANT" mode is used. Otherwise, direction is random.

9 - canRespawn: Boolean - true if vehicle is respawnable (all conditions for respawn are ok)
10 - isRespawning: Boolean - true if vehicle is currently in the respawn queue awaiting respawn.
11 - respawnMarkerName: String - Chosen vehicle respawn marker, when vehicle respawns it will use the marker params. The respawn marker is processed instantly uppon vehicle's death.
12 - respawnTimeRemaining: Number - how long left before the respawn. -1 after vehicle has respawned or has respawn disabled.
13 - missionRespawnDelay: Number - global mission vehicle respawn delay. script command > mission param > 3DEN param
14 - missionRespawnMode: Number - global mission vehicle respawn mode. script command > mission param > 3DEN param