/*/
File: fn_AIXHeliInsertLanding.sqf
Author:

	Quiksilver
	
Last modified:

	19/01/2018 A3 1.80 by Quiksilver
	
Description:

	-
__________________________________________________/*/

params ['_groupLeader'];
_v = vehicle _groupLeader;
_g = group _groupLeader;
_v land 'GET OUT';
if ((random 1) > 0.333) then {
	[_v] spawn {
		params ['_v'];
		private _smoke = objNull;
		private _vPos = position (_v getVariable 'QS_assignedHelipad');
		private _position = [0,0,0];
		if ((_v distance2D _vPos) < 250) then {
			private _increment = 0;
			for '_x' from 0 to 7 step 1 do {
				_position = _vPos getPos [(15 + (random [0,2.5,5])),_increment];
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
	((isTouchingGround _v) || {(!alive _v)} || {(!canMove _v)} || {(diag_tickTime > _timeout)})
};
_v removeAllEventHandlers 'GetOut';
private _grp = grpNull;
{
	if (_x getVariable ['QS_AI_HELICARGO',FALSE]) then {
		_x leaveVehicle _v;
		moveOut _x;
		_grp = group _x;
	};
} forEach (crew _v);
_grp setSpeedMode 'FULL';
_grp move (_v getVariable ['QS_heli_centerPosition',[0,0,0]]);
{
	_x setUnitPosWeak 'MIDDLE';
	doStop _x;
	_x doMove (_v getVariable ['QS_heli_centerPosition',[0,0,0]]);
} forEach (units _grp);
_helipad = _v getVariable ['QS_assignedHelipad',objNull];
if (!isNull _helipad) then {
	deleteVehicle _helipad;
};
_v land 'NONE';
_wp = _g addWaypoint [(_v getVariable ['QS_heli_spawnPosition',[0,0,50]]),0];
_wp setWaypointType 'MOVE';
_wp setWaypointSpeed 'FULL';
_wp setWaypointBehaviour 'CARELESS';
_wp setWaypointCombatMode 'BLUE';
_wp setWaypointCompletionRadius 150;
_wp setWaypointStatements [
	'TRUE',
	"
		if (!(local this)) exitWith {};
		_v = vehicle this;
		{
			deleteVehicle _x;
		} count (crew (vehicle this));							
		if (!isNull (_v getVariable 'QS_assignedHelipad')) then {
			deleteVehicle (_v getVariable 'QS_assignedHelipad');
		};
		deleteVehicle _v;
	"
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
					_unit disableAI 'AUTOCOMBAT';
					{
						_unit forgetTarget _x;
					} forEach (_unit targets [TRUE]);
				} forEach (units _supportGroup);
				_waypointIndex = currentWaypoint _supportGroup;
				_waypoint = [_supportGroup,_waypointIndex];
				_waypoint setWaypointPosition [(_v getVariable ['QS_heli_spawnPosition',[0,0,100]]),0];
				_waypoint setWaypointType 'MOVE';
				_waypoint setWaypointCompletionRadius 150;
				_waypoint setWaypointForceBehaviour TRUE;
				_waypoint setWaypointStatements [
					"TRUE",
					"
						if (!(local this)) exitWith {};
						_v = vehicle this;
						{
							deleteVehicle _x;
						} count (crew (vehicle this));
						deleteVehicle _v;
					"
				];
			};
		};
	};
};