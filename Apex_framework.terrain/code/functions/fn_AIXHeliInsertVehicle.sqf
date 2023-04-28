/*/
File: fn_AIXHeliInsertVehicle.sqf
Author:

	Quiksilver
	
Last modified:

	23/08/2022 A3 2.10 by Quiksilver
	
Description:

	Insert Vehicle via Heli drop
	
	[QS_hqPos,QS_test_vehicle,'O_Heli_Transport_04_F',EAST] spawn QS_fnc_AIXHeliInsertVehicle;
__________________________________________________/*/

params [
	['_position',[0,0,0]],
	['_vehicle',objNull],
	['_heliType','O_Heli_Transport_04_F'],
	['_side',EAST]
];
missionNamespace setVariable ['QS_AI_insertHeli_helis',((missionNamespace getVariable 'QS_AI_insertHeli_helis') select {(alive _x)}),FALSE];
if (_heliType isEqualType []) then {
	_heliType = selectRandomWeighted _heliType;
};
_canSuspend = canSuspend;
_worldName = worldName;
_worldSize = worldSize + 2000;
_flyInHeight = 50;
_mapEdgePositions = [
	[-1000,-1000,_flyInHeight],
	[-1000,_worldSize,_flyInHeight],
	[_worldSize,_worldSize,_flyInHeight],
	[_worldSize,-1000,_flyInHeight],
	[-1000,(_worldSize / 2),_flyInHeight],
	[(_worldSize / 2),_worldSize,_flyInHeight],
	[_worldSize,(_worldSize / 2),_flyInHeight],
	[(_worldSize / 2),-1000,_flyInHeight]
];
private _mapEdgePosition = selectRandom _mapEdgePositions;
private _testDist = 99999;
if ((random 1) > 0) then {
	{
		if ((_x distance2D _position) < _testDist) then {
			_testDist = _x distance2D _position;
			_mapEdgePosition = _x;
		};
	} forEach _mapEdgePositions;
} else {
	_mapEdgePosition = selectRandom _mapEdgePositions;
};
private _foundHLZ = FALSE;
private _HLZ = [0,0,0];
private _allPlayers = allPlayers;
_helipadType = 'Land_HelipadEmpty_F';
for '_x' from 0 to 99 step 1 do {
	_HLZ = [_position,0,300,17,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if ((nearestObjects [_position,[_helipadType],75,TRUE]) isEqualTo []) then {
		if ((_allPlayers inAreaArray [_HLZ,50,50,0,FALSE]) isEqualTo []) then {
			if ((_HLZ distance2D _position) < 300) then {
				_foundHLZ = TRUE;
			};
		};
	};
	if (_foundHLZ) exitWith {};
};
if (!(_foundHLZ)) exitWith {};
_HLZ set [2,0];
private _spawnPosition = [0,0,0];
private _foundSpawnPosition = FALSE;
for '_x' from 0 to 99 step 1 do {
	_spawnPosition = [_HLZ,1000,2500,1,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if ((_allPlayers inAreaArray [_spawnPosition,500,500,0,FALSE]) isEqualTo []) then {
		if ((((_spawnPosition select [0,2]) nearRoads 30) select {((_x isEqualType objNull) && ((roadsConnectedTo _x) isNotEqualTo []))}) isNotEqualTo []) then {
			_foundSpawnPosition = TRUE;
		};
	};
	if (_foundSpawnPosition) exitWith {};
};
if (!(_foundSpawnPosition)) exitWith {};
_spawnPosition set [2,0];
_heli = createVehicle [QS_core_vehicles_map getOrDefault [toLowerANSI _heliType,_heliType],_spawnPosition,[],500,'FLY'];
_heli setVariable ['QS_dynSim_ignore',TRUE,TRUE];
_heli enableDynamicSimulation FALSE;
_heliGroup = createVehicleCrew _heli;
(missionNamespace getVariable 'QS_garbageCollector') pushBack [_heli,'DELAYED_DISCREET',(time + 600)];
_heliGroup addVehicle _heli;
(missionNamespace getVariable 'QS_AI_insertHeli_helis') pushBack _heli;
_heliGroup deleteGroupWhenEmpty TRUE;
{
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
	_x enableDynamicSimulation FALSE;
	(missionNamespace getVariable 'QS_garbageCollector') pushBack [_x,'DELAYED_DISCREET',(time + 600)];
} forEach (units _heliGroup);
_heli setVariable ['QS_heli_mapEdgePosition',_mapEdgePosition,FALSE];
_heli setVariable ['QS_heli_spawnPosition',_spawnPosition,FALSE];
_heli setVariable ['QS_heli_centerPosition',_position,FALSE];
_heli setVelocity [0,0,1];
_vehicle setVelocity [0,0,1];
_vehicle enableDynamicSimulation FALSE;
_vehicle setVariable ['QS_dynSim_ignore',TRUE,TRUE];
{
	(group _x) enableDynamicSimulation FALSE;
	_x setVariable ['QS_dynSim_ignore',TRUE,TRUE];
} forEach (crew _vehicle);
if (_canSuspend) then {
	sleep 3;
};
_heli setVelocity [0,0,1];
_vehicle setVelocity [0,0,1];
private _isSlingLoad = _heli setSlingLoad _vehicle;
if (_canSuspend) then {
	sleep 1;
};
if (isNull (getSlingLoad _heli)) then {
	_heli setSlingLoad _vehicle;
	if (_canSuspend) then {
		sleep 1;
	};
};
if (isNull (getSlingLoad _heli)) exitWith {
	deleteVehicleCrew _heli;
	deleteVehicle _heli;
};
_heli addEventHandler [
	'HandleDamage',
	{
		params ['_vehicle','_selectionName','_damage','','','','',''];
		private _scale = 0.2;
		_oldDamage = [(_vehicle getHit _selectionName),(damage _vehicle)] select (_selectionName isEqualTo '');
		if (_selectionName isEqualTo '?') then {
			_scale = 0.2;
		};
		if ((_vehicle getHit 'tail_rotor_hit') > 0) then {
			_vehicle setHit ['tail_rotor_hit',0,TRUE];
		};
		_damage = ((_damage - _oldDamage) * _scale) + _oldDamage;
		_damage;
	}
];
_heli addEventHandler [
	'RopeBreak',
	{
		params ['_vehicle','_rope','_attachedObject'];
		if (isNull (ropeAttachedTo _attachedObject)) then {
			_heliGroup = group (driver _vehicle);
			if (alive (driver _vehicle)) then {
				_attachedObject enableRopeAttach FALSE;
				_attachedObject enableVehicleCargo FALSE;
				_vehicle removeEventHandler [_thisEvent,_thisEventHandler];
				deleteWaypoint [_heliGroup,(currentWaypoint _heliGroup)];
				_wp = _heliGroup addWaypoint [(_vehicle getVariable ['QS_heli_mapEdgePosition',[0,0,100]]),0];
				_wp setWaypointType 'MOVE';
				_wp setWaypointSpeed 'FULL';
				_heliGroup addEventHandler [
					'WaypointComplete',
					{
						params ['_group','_wpIndex'];
						_vehicle = vehicle (leader _group);
						deleteVehicleCrew _vehicle;
						deleteVehicle _vehicle;	
					}
				];
			};
		};
	}
];
_heli addEventHandler ['Killed',(missionNamespace getVariable 'QS_fnc_vKilled2')];
_heli addEventHandler [
	'IncomingMissile',
	{
		params ['_vehicle','_ammo','_shooter','_instigator','_projectile'];
		if (alive (driver _vehicle)) then {
			_vehicle setVehicleAmmo 1;
			(driver _vehicle) forceWeaponFire ['CMFlareLauncher','AIBurst'];
			[driver _vehicle,_shooter,_projectile] spawn {
				params ['_pilot','_shooter','_projectile'];
				scriptName 'QS Incoming Missile Flares';
				_pilot forceWeaponFire ['CMFlareLauncher','AIBurst'];
				sleep 1;
				_pilot forceWeaponFire ['CMFlareLauncher','AIBurst'];
				sleep 1;
				_pilot forceWeaponFire ['CMFlareLauncher','AIBurst'];
				(vehicle _pilot) setVehicleAmmo 1;
				[_projectile,objNull] remoteExec ['setMissileTarget',_shooter,FALSE];
			};
		};
	}
];
_wp = _heliGroup addWaypoint [_HLZ,0];
_wp setWaypointType 'UNHOOK';
_wp setWaypointStatements [
	'TRUE',
	'
		if (!(local this)) exitWith {};
		this spawn {
			_v = vehicle _this;
			sleep 3;
			if (!isNull (getSlingLoad _v)) then {
				_v setSlingLoad objNull;
			};
		};
	'
];