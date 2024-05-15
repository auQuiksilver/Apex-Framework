/*/
File: fn_AIXHeliInsertLanding.sqf
Author:

	Quiksilver
	
Last modified:

	9/10/2023 A3 2.14 by Quiksilver
	
Description:

	-
__________________________________________________/*/

params ['_groupLeader'];
_v = vehicle _groupLeader;
_g = group _groupLeader;
if (!isNull (_v getVariable ['QS_assignedHelipad',objNull])) then {
	_v landAt [(_v getVariable ['QS_assignedHelipad',objNull]),'GET OUT'];
} else {
	_v land 'GET OUT';
};
_v flyInHeight [0.1,TRUE];
if ((random 1) > 0.333) then {
	[_v] spawn {
		params ['_v'];
		private _smoke = objNull;
		private _vPos = position (_v getVariable 'QS_assignedHelipad');
		private _position = [0,0,0];
		if ((_v distance2D _vPos) < 250) then {
			private _increment = 0;
			for '_x' from 0 to 7 step 1 do {
				_position = _vPos getPos [(25 + (random [0,2.5,5])),_increment];
				_increment = _increment + 45;
				_smoke = createVehicle ['SmokeShellArty',_position,[],0,'CAN_COLLIDE'];
				_smoke setVehiclePosition [(AGLToASL _position),[],3,'CAN_COLLIDE'];
				(missionNamespace getVariable 'QS_garbageCollector') pushBack [_smoke,'DELAYED_FORCED',(time + 90)];
			};
		};
	};
};
_timeout = diag_tickTime + 60;
waitUntil {
	uiSleep 0.25;
	(
		(isTouchingGround _v) ||
		{(((getPosATL _v) # 2) < 2.5)} ||
		{(!alive _v)} || 
		{(!canMove _v)} || 
		{(diag_tickTime > _timeout)}
	)
};
_v removeAllEventHandlers 'GetOut';
private _spawnUnits = alive _v && ((((getPosATL _v) # 2) < 10) || (isTouchingGround _v));
_side = EAST;
if (_spawnUnits) then {
	private _unitTypes = ['o_heli_insert_1'] call QS_data_listUnits;
	if (_side isEqualTo WEST) then {
		_unitTypes = ['b_heli_insert_1'] call QS_data_listUnits;
	};
	if (_side isEqualTo RESISTANCE) then {
		_unitTypes = ['i_heli_insert_1'] call QS_data_listUnits;
	};
	private _unit = objNull;
	private _units = [];
	_infantryGroup = createGroup [_side,TRUE];
	_emptyPositions = _v emptyPositions 'Cargo';
	for '_x' from 0 to ((round (_emptyPositions * (selectRandom [0.35,0.5,0.75]))) - 1) step 1 do {
		_unitType = selectRandomWeighted _unitTypes;
		_unit = _infantryGroup createUnit [QS_core_units_map getOrDefault [toLowerANSI _unitType,_unitType],[-100,-100,0],[],0,'NONE'];
		_unit setVariable ['QS_dynSim_ignore',TRUE,TRUE];
		_infantryGroup setBehaviour 'COMBAT';
		_infantryGroup setCombatMode 'RED';
		_infantryGroup addEventHandler ['EnemyDetected',{call (missionNamespace getVariable 'QS_fnc_AIGroupEventEnemyDetected')}];
		_unit enableDynamicSimulation TRUE;
		_unit enableStamina FALSE;
		_unit enableFatigue FALSE;
		_unit setSkill 1;
		_unit setUnitPos (selectRandomWeighted ['Down',1,'Middle',0.5]);
		_unit = _unit call (missionNamespace getVariable 'QS_fnc_unitSetup');
		if ((random 1) > 0.333) then {
			_unit enableAIFeature ['PATH',FALSE];
		};
		_units pushBack _unit;
		_unit setVehiclePosition [(getPosWorld _v),[],15,'NONE'];
	};
	//comment 'Radial positions';
	_position = missionNamespace getVariable ['QS_hqPos',(missionNamespace getVariable 'QS_aoPos')];
	_infantryGroup enableAttack TRUE;
	[(units _infantryGroup),2] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	private _radialIncrement = 45;
	private _radialStart = round (random 360);
	_radialOffset = 200;
	private _radialPatrolPositions = [];
	private _patrolPosition = _position getPos [_radialOffset,_radialStart];
	if (!surfaceIsWater _patrolPosition) then {
		_radialPatrolPositions pushBack _patrolPosition;
	};
	for '_x' from 0 to 6 step 1 do {
		_radialStart = _radialStart + _radialIncrement;
		_patrolPosition = _position getPos [_radialOffset,_radialStart];
		if (!surfaceIsWater _patrolPosition) then {
			_radialPatrolPositions pushBack _patrolPosition;
		};
	};
	if (_radialPatrolPositions isNotEqualTo []) then {
		_radialPatrolPositions = _radialPatrolPositions call (missionNamespace getVariable 'QS_fnc_arrayShuffle');
	};
	_infantryGroup setVariable ['QS_AI_GRP',TRUE,QS_system_AI_owners];
	_infantryGroup setVariable ['QS_AI_GRP_CONFIG',['GENERAL','INFANTRY',(count (units _infantryGroup))],QS_system_AI_owners];
	_infantryGroup setVariable ['QS_AI_GRP_DATA',[],QS_system_AI_owners];
	_infantryGroup setVariable ['QS_AI_GRP_TASK',['PATROL',_radialPatrolPositions,serverTime,-1],QS_system_AI_owners];
	_infantryGroup setVariable ['QS_AI_GRP_HC',[0,-1],QS_system_AI_owners];
	private _QS_array = missionNamespace getVariable 'QS_enemyGroundReinforceArray';
	{
		_QS_array pushBack _x;
	} forEach (units _infantryGroup);
	missionNamespace setVariable ['QS_enemyGroundReinforceArray',_QS_array,FALSE];
	[_units,getPosWorld _v,_infantryGroup] spawn {
		params ['_units','_position','_group'];
		uiSleep 2;
		deleteVehicle (_units select {((_x distance2D _position) > 100)});
		uiSleep 7;
		{
			if (alive _x) then {
				_x enableAIFeature ['PATH',TRUE];
				_x setUnitPos 'Auto';
			};
		} forEach _units;
		_units doFollow (leader _group);
		[(units _group),1] call (missionNamespace getVariable 'QS_fnc_serverSetAISkill');
	};
};
_helipad = _v getVariable ['QS_assignedHelipad',objNull];
if (!isNull _helipad) then {
	deleteVehicle _helipad;
};
_v land 'NONE';
_v flyInHeight [50,FALSE];
sleep 0.5;
_wp = _g addWaypoint [(_v getVariable ['QS_heli_spawnPosition',[0,0,50]]),0];
_wp setWaypointType 'MOVE';
_wp setWaypointSpeed 'FULL';
_wp setWaypointBehaviour 'CARELESS';
_wp setWaypointCombatMode 'BLUE';
_wp setWaypointCompletionRadius 150;
_g addEventHandler [
	'WaypointComplete',
	{
		params ['_group','_waypointIndex'];
		_group removeEventHandler [_thisEvent,_thisEventHandler];
		_leader = leader _group;
		_v = vehicle _leader;
		deleteVehicleCrew _v;
		if (!isNull (_v getVariable 'QS_assignedHelipad')) then {
			deleteVehicle (_v getVariable 'QS_assignedHelipad');
		};
		if ((allPlayers inAreaArray [_v,500,500,0,FALSE]) isEqualTo []) then {
			deleteVehicle _v;
		} else {
			_v setDamage [1,TRUE];
		};
	}
];
if (!isNull (_v getVariable ['QS_heliInsert_supportHeli',objNull])) then {
	_supportHeli = _v getVariable 'QS_heliInsert_supportHeli';
	_v removeAllEventHandlers 'Hit';
	if (alive _supportHeli) then {
		if (((crew _supportHeli) findIf {(alive _x)}) isNotEqualTo -1) then {
			_supportGroup = group (effectiveCommander _supportHeli);
			_supportGroup lockWP FALSE;
			[_supportHeli,_supportGroup,_v] spawn {
				params ['_supportHeli','_supportGroup','_v'];
				sleep 10;
				_supportGroup = group (effectiveCommander _supportHeli);
				_supportGroup setCombatMode 'BLUE';
				_supportGroup setBehaviour 'CARELESS';
				_supportGroup setBehaviourStrong 'CARELESS';
				_supportGroup setSpeedMode 'FULL';
				private _unit = objNull;
				{
					_unit = _x;
					_unit enableAIFeature ['AUTOCOMBAT',FALSE];
					{
						_supportGroup forgetTarget _x;
						_unit forgetTarget _x;
					} forEach (_unit targets [TRUE]);
				} forEach (units _supportGroup);
				_waypointIndex = currentWaypoint _supportGroup;
				_waypoint = [_supportGroup,_waypointIndex];
				_waypoint setWaypointPosition [(_v getVariable ['QS_heli_spawnPosition',[0,0,100]]),0];
				_waypoint setWaypointType 'MOVE';
				_waypoint setWaypointCompletionRadius 150;
				_waypoint setWaypointForceBehaviour TRUE;
				_supportGroup addEventHandler [
					'WaypointComplete',
					{
						params ['_group','_waypointIndex'];
						_group removeEventHandler [_thisEvent,_thisEventHandler];
						_leader = leader _group;
						_v = vehicle _leader;
						deleteVehicleCrew _v;
						if ((allPlayers inAreaArray [_v,500,500,0,FALSE]) isEqualTo []) then {
							deleteVehicle _v;
						} else {
							_v setDamage [1,TRUE];
						};
					}
				];
			};
		};
	};
};