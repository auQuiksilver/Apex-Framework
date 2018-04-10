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
	if (!(_localGroups isEqualTo [])) then {
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
				50 cutText [(format ['[Commander] %1 requested a SITREP for %2',_profileName,_groupID]),'PLAIN DOWN',0.5,TRUE,FALSE];
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
	if (_command isEqualTo 'WP_TYPE_GETIN') then {_waypoint setWaypointType 'GETIN';};

	if (_command isEqualTo 'WP_COMBAT_STEALTH') then {_waypoint setWaypointBehaviour 'STEALTH';_waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'WP_COMBAT_DANGER') then {_waypoint setWaypointBehaviour 'COMBAT';_waypoint setWaypointForceBehaviour FALSE;};
	if (_command isEqualTo 'WP_COMBAT_AWARE') then {_waypoint setWaypointBehaviour 'AWARE';_waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'WP_COMBAT_SAFE') then {_waypoint setWaypointBehaviour 'SAFE';_waypoint setWaypointForceBehaviour TRUE;};
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

	if (_command isEqualTo 'WP_WAIT_NO') then {};
	if (_command isEqualTo 'WP_WAIT_1MIN') then {};
	if (_command isEqualTo 'WP_WAIT_5MIN') then {};
	if (_command isEqualTo 'WP_WAIT_10MIN') then {};
	if (_command isEqualTo 'WP_WAIT_15MIN') then {};
	if (_command isEqualTo 'WP_WAIT_20MIN') then {};
	if (_command isEqualTo 'WP_WAIT_25MIN') then {};
	if (_command isEqualTo 'WP_WAIT_30MIN') then {};
	if (_command isEqualTo 'WP_WAIT_45MIN') then {};
	if (_command isEqualTo 'WP_WAIT_60MIN') then {};

	if (_command isEqualTo 'WP_CREATETASK') then {};
	if (_command isEqualTo 'WP_CANCELWP') then {deleteWaypoint _waypoint;};
	if (_command isEqualTo 'NEXTWP') then {_group setCurrentWaypoint [_group,((currentWaypoint _group) + 1)];};
	if (_command isEqualTo 'CANCELWP') then {deleteWaypoint _waypoint;};
	if (_command isEqualTo 'CANCELALLWP') then {
		for '_x' from 0 to 1 step 1 do {
			if (!( (waypoints _group) isEqualTo [])) then {
				{
					deleteWaypoint _x;
				} forEach (waypoints _group);
			};
		};
	};

	if (_command isEqualTo 'OPENFIRE') then {_group setCombatMode 'RED';};
	if (_command isEqualTo 'HOLDFIRE') then {_group setCombatMode 'GREEN';};

	if (_command isEqualTo 'SPEED_LIMITED') then {_group setSpeedMode 'LIMITED';};
	if (_command isEqualTo 'SPEED_NORMAL') then {_group setSpeedMode 'NORMAL';};
	if (_command isEqualTo 'SPEED_FULL') then {_group setSpeedMode 'FULL';};

	if (_command isEqualTo 'COMBAT_STEALTH') then {_group setBehaviour 'STEALTH';_waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'COMBAT_DANGER') then {_group setBehaviour 'COMBAT';_waypoint setWaypointForceBehaviour FALSE;};
	if (_command isEqualTo 'COMBAT_AWARE') then {_group setBehaviour 'AWARE';_waypoint setWaypointForceBehaviour TRUE;};
	if (_command isEqualTo 'COMBAT_SAFE') then {_group setBehaviour 'SAFE';_waypoint setWaypointForceBehaviour TRUE;};

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