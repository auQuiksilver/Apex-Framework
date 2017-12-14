/*
File: fn_AIXHeliInsertLanding.sqf
Author:

	Quiksilver
	
Last modified:

	22/10/2017 A3 1.76 by Quiksilver
	
Description:

	-
__________________________________________________*/

params ['_groupLeader'];
_v = vehicle _groupLeader;
_g = group _groupLeader;
_v land 'GET OUT';
waitUntil {
	sleep 0.1;
	(isTouchingGround _v)
};
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
	_x doMove (_v getVariable ['QS_heli_centerPosition',[0,0,0]]);
} forEach (units _grp);	
_helipad = _v getVariable ['QS_assignedHelipad',objNull];
if (!isNull _helipad) then {
	deleteVehicle _helipad;
};
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
		if (({(alive _x)} count (crew _supportHeli)) > 0) then {
			_supportGroup = group (effectiveCommander _supportHeli);
			[_supportHeli,_supportGroup,_v] spawn {
				params ['_supportHeli','_supportGroup','_v'];
				sleep 10;
				_supportGroup = group (effectiveCommander _supportHeli);
				_supportGroup setCombatMode 'BLUE';
				_supportGroup setBehaviour 'CARELESS';
				_supportGroup setSpeedMode 'FULL';
				private _unit = objNull;
				{
					_unit = _x;
					{
						_unit forgetTarget _x;
					} forEach (_unit targets [TRUE]);
				} forEach (units _supportGroup);
				_waypointIndex = currentWaypoint _supportGroup;
				_waypoint = [_supportGroup,_waypointIndex];
				_waypoint setWaypointPosition [(_v getVariable ['QS_heli_spawnPosition',[0,0,50]]),0];
				_waypoint setWaypointType 'MOVE';
				_waypoint setWaypointCompletionRadius 150;
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