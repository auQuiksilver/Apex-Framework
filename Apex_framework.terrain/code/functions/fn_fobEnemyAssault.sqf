/*
File: fn_fobEnemyAssault.sqf
Author:

	Quiksilver
	
Last modified:

	17/04/2018 A3 1.82 by Quiksilver
	
Description:

	FOB Enemy Assault
	
Notes:

	Not plugged into new AI architecture
__________________________________________________*/

private [
	'_pos','_base','_foundSpawnPos','_spawnPosDefault','_reinforceGroup','_infTypes','_infType',
	'_destination','_count','_wp','_playerSelected','_arr','_playerPos','_ticker','_attackPos','_QS_array'
];

_QS_array = [];

/*/================================================ FIND POSITION/*/

_pos = _this # 0;
_base = markerPos 'QS_marker_base_marker';
_foundSpawnPos = FALSE;
while {!_foundSpawnPos} do {
	_spawnPosDefault = [_pos,500,850,5,0,0.5,0] call (missionNamespace getVariable 'QS_fnc_findSafePos');
	if (_spawnPosDefault isNotEqualTo []) then {
		if ((allPlayers inAreaArray [_spawnPosDefault,350,350,0,FALSE]) isEqualTo []) then {
			if ((_spawnPosDefault distance2D _base) > 1200) then {
				_foundSpawnPos = TRUE;
			};
		};
	};
};

/*/================================================ SELECT + SPAWN UNITS/*/

_infTypes = ['fob_assault_1'] call QS_data_listUnits;
_infType = selectRandomWeighted _infTypes;
_reinforceGroup = [_spawnPosDefault,(random 360),EAST,_infType,FALSE] call (missionNamespace getVariable 'QS_fnc_spawnGroup');
_reinforceGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
/*/================================================ MANAGE UNITS/*/

_attackPos = [];
if ((random 1) > 0.3) then {
	if ((random 1) > 0.3) then {
		if ((random 1) > 0.5) then {
			[_reinforceGroup,(missionNamespace getVariable 'QS_module_fob_centerPosition'),TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
			[_reinforceGroup,(currentWaypoint _reinforceGroup)] setWaypointCompletionRadius 50;
		} else {
			_wp = _reinforceGroup addWaypoint [(missionNamespace getVariable 'QS_module_fob_centerPosition'),75];
			_wp setWaypointType 'MOVE';
			_wp setWaypointBehaviour 'AWARE';
			_wp setWaypointCombatMode 'YELLOW';
			_wp setWaypointCompletionRadius 25;
			_wp setWaypointSpeed 'FULL';
		};
	} else {
		_playerSelected = objNull;
		_arr = [(missionNamespace getVariable 'QS_module_fob_centerPosition'),600,[WEST],allPlayers,0] call (missionNamespace getVariable 'QS_fnc_serverDetector');
		if (_arr isNotEqualTo []) then {
			_arr = _arr call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
			{
				if (alive _x) then {
					if ((_x isKindOf 'CAManBase') || {(_x isKindOf 'LandVehicle')}) then {
						_playerSelected = _x;
					};
				};
			} count _arr;
		};
		if (!isNull _playerSelected) then {
			_playerPos = getPosATL _playerSelected;
			[_reinforceGroup,_playerPos,TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
			[_reinforceGroup,(currentWaypoint _reinforceGroup)] setWaypointCompletionRadius 50;
		} else {
			[_reinforceGroup,(missionNamespace getVariable 'QS_module_fob_centerPosition'),TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
			[_reinforceGroup,(currentWaypoint _reinforceGroup)] setWaypointCompletionRadius 50;
		};
	};
	_attackPos = missionNamespace getVariable 'QS_module_fob_centerPosition';
} else {
	_destination = [_pos,600,50,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
	if (_destination isEqualTo []) then {
		_ticker = 0;
		while {(_destination isEqualTo [])} do {
			_destination = [_pos,600,50,10] call (missionNamespace getVariable 'QS_fnc_findOverwatchPos');
			_ticker = _ticker + 1;
			if (_ticker > 30) exitWith {_destination = _pos;};
		};
	};
	[_reinforceGroup,_destination,TRUE] call (missionNamespace getVariable 'QS_fnc_taskAttack');
	_wp = _reinforceGroup addWaypoint [(missionNamespace getVariable 'QS_module_fob_centerPosition'),75];
	_wp setWaypointType 'SAD';
	_wp setWaypointBehaviour 'AWARE';
	_wp setWaypointCombatMode 'RED';
	_wp setWaypointCompletionRadius 100;
	_wp setWaypointSpeed 'FULL';
	_attackPos = _destination;
};
[(units _reinforceGroup),(selectRandom [1,2])] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
_QS_array = missionNamespace getVariable 'QS_module_fob_assaultArray';
{
	0 = _QS_array pushBack _x;
	_x enableStamina FALSE;
	_x enableFatigue FALSE;
	_x enableAIFeature ['AUTOCOMBAT',FALSE];
	_x enableAIFeature ['COVER',FALSE];
	_x call (missionNamespace getVariable 'QS_fnc_unitSetup');
} count (units _reinforceGroup);
missionNamespace setVariable ['QS_module_fob_assaultArray',_QS_array,TRUE];
_reinforceGroup enableAttack TRUE;
_reinforceGroup lockWP TRUE;
_reinforceGroup setVariable ['QS_AI_Groups',['QS_ATTACK',_attackPos],FALSE];
_count = count (units _reinforceGroup);
_count;