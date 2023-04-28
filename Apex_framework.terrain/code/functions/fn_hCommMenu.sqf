/*/
File: fn_hCommMenu.sqf
Author:

	Quiksilver
	
Last Modified:

	10/04/2018 A3 1.82 by Quiksilver
	
Description:

	-
__________________________________/*/

params ['_type','','_profileName',''];
if (_type isEqualTo 0) then {
	params ['','_command','','_hcSelected'];
	_localGroups = _hcSelected select {((!isNull _x) && (local _x))};
	if (_localGroups isNotEqualTo []) then {
		{
			[1,_command,_profileName,_x] call (missionNamespace getVariable 'QS_fnc_hCommMenu');
		} forEach _localGroups;
	};
};
if (_type isEqualTo 1) then {
	params ['','_command','','_group'];
	_groupID = groupID _group;
	_waypoint = [_group,(currentWaypoint _group)];
	if (_command isEqualTo 'SITREP') then {
		if ((!isDedicated) && (hasInterface)) then {
			if (player isEqualTo (leader _group)) then {
				playSound 'TacticalPing4';
				50 cutText [(format ['%3 %2',_profileName,_groupID,localize 'STR_QS_Text_208']),'PLAIN DOWN',0.5,TRUE,FALSE];
			};
		};
	};
	if (_command isEqualTo 'WP_TYPE_MOVE') then {_waypoint setWaypointType 'MOVE';};
	if (_command isEqualTo 'WP_TYPE_CYCLE') then {_waypoint setWaypointType 'CYCLE';};
	if (_command isEqualTo 'WP_TYPE_SAD') then {_waypoint setWaypointType 'SAD';};
	if (_command isEqualTo 'WP_TYPE_GUARD') then {_waypoint setWaypointType 'GUARD';};
	if (_command isEqualTo 'WP_TYPE_UNLOAD') then {_waypoint setWaypointType 'UNLOAD';};
	if (_command isEqualTo 'WP_TYPE_LOAD') then {_waypoint setWaypointType 'LOAD';};
	if (_command isEqualTo 'WP_TYPE_GETOUT') then {_waypoint setWaypointType 'GETOUT';};
	if (_command isEqualTo 'WP_TYPE_GETIN') then {
		_waypoint setWaypointType 'GETIN';
		private _vehicle = objNull;
		_position = waypointPosition _waypoint;
		_vehicles = (_position nearEntities [['Land','Air','Ship'],100]) select {((canMove _x) && ((side _x) in [(side _group),CIVILIAN]) && ((locked _x) in [0,1,3]))};
		if (_vehicles isNotEqualTo []) then {
			if ((count _vehicles) > 1) then {
				private _dist = 999999;
				{
					if ((_x distance2D _position) < _dist) then {
						_dist = _x distance2D _position;
						_vehicle = _x;
					};
				} forEach _vehicles;
			} else {
				_vehicle = _vehicles # 0;
			};
		};
		if (isNull _vehicle) then {
			50 cutText [localize 'STR_QS_Text_209','PLAIN DOWN',0.5,TRUE,FALSE];
		} else {
			_waypoint waypointAttachVehicle _vehicle;
		};
	};

	if (_command isEqualTo 'WP_COMBAT_STEALTH') then {_waypoint setWaypointBehaviour 'STEALTH'; _group setBehaviourStrong 'STEALTH'; _waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'WP_COMBAT_DANGER') then {_waypoint setWaypointBehaviour 'COMBAT'; _waypoint setWaypointForceBehaviour FALSE;};
	if (_command isEqualTo 'WP_COMBAT_AWARE') then {_waypoint setWaypointBehaviour 'AWARE'; _group setBehaviourStrong 'AWARE'; _waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'WP_COMBAT_SAFE') then {_waypoint setWaypointBehaviour 'SAFE';};
	if (_command isEqualTo 'WP_COMBAT_UNCHANGED') then {_waypoint setWaypointBehaviour 'UNCHANGED';_waypoint setWaypointForceBehaviour TRUE;};

	if (_command isEqualTo 'WP_COLUMN') then {_waypoint setWaypointFormation 'COLUMN';};
	if (_command isEqualTo 'WP_STAG COLUMN') then {_waypoint setWaypointFormation 'STAG COLUMN';};
	if (_command isEqualTo 'WP_WEDGE') then {_waypoint setWaypointFormation 'WEDGE';};
	if (_command isEqualTo 'WP_ECH LEFT') then {_waypoint setWaypointFormation 'ECH LEFT';};
	if (_command isEqualTo 'WP_ECH RIGHT') then {_waypoint setWaypointFormation 'ECH RIGHT';};
	if (_command isEqualTo 'WP_VEE') then {_waypoint setWaypointFormation 'VEE';};
	if (_command isEqualTo 'WP_LINE') then {_waypoint setWaypointFormation 'LINE';};
	if (_command isEqualTo 'WP_FILE') then {_waypoint setWaypointFormation 'FILE';};
	if (_command isEqualTo 'WP_DIAMOND') then {_waypoint setWaypointFormation 'DIAMOND';};
	if (_command isEqualTo 'WP_UNCHANGED') then {_waypoint setWaypointFormation 'NO CHANGE';};

	if (_command isEqualTo 'WP_SPEED_LIMITED') then {_waypoint setWaypointSpeed 'LIMITED';};
	if (_command isEqualTo 'WP_SPEED_NORMAL') then {_waypoint setWaypointSpeed 'NORMAL';};
	if (_command isEqualTo 'WP_SPEED_FULL') then {_waypoint setWaypointSpeed 'FULL';};
	if (_command isEqualTo 'WP_SPEED_UNCHANGED') then {_waypoint setWaypointSpeed 'UNCHANGED';};

	if (_command isEqualTo 'WP_WAIT_NO') then {_waypoint setWaypointTimeout [0,0,0];};
	if (_command isEqualTo 'WP_WAIT_1MIN') then {_waypoint setWaypointTimeout [59,60,61];};
	if (_command isEqualTo 'WP_WAIT_5MIN') then {_waypoint setWaypointTimeout [299,300,301];};
	if (_command isEqualTo 'WP_WAIT_10MIN') then {_waypoint setWaypointTimeout [599,600,601];};
	if (_command isEqualTo 'WP_WAIT_15MIN') then {_waypoint setWaypointTimeout [899,900,901];};
	if (_command isEqualTo 'WP_WAIT_20MIN') then {_waypoint setWaypointTimeout [1199,1200,1201];};
	if (_command isEqualTo 'WP_WAIT_25MIN') then {_waypoint setWaypointTimeout [1499,1500,1501];};
	if (_command isEqualTo 'WP_WAIT_30MIN') then {_waypoint setWaypointTimeout [1799,1800,1801];};
	if (_command isEqualTo 'WP_WAIT_45MIN') then {_waypoint setWaypointTimeout [2699,2700,2701];};
	if (_command isEqualTo 'WP_WAIT_60MIN') then {_waypoint setWaypointTimeout [3599,3600,3601];};

	if (_command isEqualTo 'WP_CREATETASK') then {};
	if (_command isEqualTo 'WP_CANCELWP') then {deleteWaypoint _waypoint;};
	if (_command isEqualTo 'NEXTWP') then {_group setCurrentWaypoint [_group,((currentWaypoint _group) + 1)];};
	if (_command isEqualTo 'CANCELWP') then {deleteWaypoint _waypoint;};
	if (_command isEqualTo 'CANCELALLWP') then {
		for '_x' from 0 to 1 step 1 do {
			if ( (waypoints _group) isNotEqualTo []) then {
				{
					deleteWaypoint _x;
				} forEach (waypoints _group);
			};
		};
	};

	if (_command isEqualTo 'OPENFIRE') then {
		private _target = objNull;
		_group setCombatMode 'RED';
		{
			if (!isPlayer _x) then {
				if (local _x) then {
					_target = getAttackTarget _x;
					if (!alive _target) then {
						_target = [_x,500] call (missionNamespace getVariable 'QS_fnc_AIGetAttackTarget');
					};
					if (alive _target) then {
						[_x,_target,1,TRUE,FALSE,FALSE,-1] call (missionNamespace getVariable 'QS_fnc_AIDoSuppressiveFire');
					};
				};
			};
		} forEach (units _group);
	};
	if (_command isEqualTo 'HOLDFIRE') then {_group setCombatMode 'GREEN';};

	if (_command isEqualTo 'SPEED_LIMITED') then {_group setSpeedMode 'LIMITED';};
	if (_command isEqualTo 'SPEED_NORMAL') then {_group setSpeedMode 'NORMAL';};
	if (_command isEqualTo 'SPEED_FULL') then {_group setSpeedMode 'FULL';};

	if (_command isEqualTo 'COMBAT_STEALTH') then {_group setBehaviourStrong 'STEALTH';};
	if (_command isEqualTo 'COMBAT_DANGER') then {_group setBehaviourStrong 'COMBAT';};
	if (_command isEqualTo 'COMBAT_AWARE') then {_group setBehaviourStrong 'AWARE';};
	if (_command isEqualTo 'COMBAT_SAFE') then {_group setBehaviourStrong 'SAFE';};

	if (_command isEqualTo 'COLUMN') then {_group setFormation 'COLUMN';};
	if (_command isEqualTo 'STAG COLUMN') then {_group setFormation 'STAG COLUMN';};
	if (_command isEqualTo 'WEDGE') then {_group setFormation 'WEDGE';};
	if (_command isEqualTo 'ECH LEFT') then {_group setFormation 'ECH LEFT';};
	if (_command isEqualTo 'ECH RIGHT') then {_group setFormation 'ECH RIGHT';};
	if (_command isEqualTo 'VEE') then {_group setFormation 'VEE';};
	if (_command isEqualTo 'LINE') then {_group setFormation 'LINE';};
	if (_command isEqualTo 'FILE') then {_group setFormation 'FILE';};
	if (_command isEqualTo 'DIAMOND') then {_group setFormation 'DIAMOND';};
	if (_command isEqualTo 'UNCHANGED') then {};
};