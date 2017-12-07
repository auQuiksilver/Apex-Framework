/*
File: BIS_HC_path_menu.sqf
Author:

	Quiksilver
	
Last modified:

	4/10/2016 A3 1.64 by Quiksilver
	
Description:

	Alias of BIS_HC_path_menu
__________________________________________________________________________*/

params ['_type','_pos','_is3D','_arraySelected','_somebool'];
systemChat format ['BIS_HC_path_menu * %1', _this];
private ['_grp','_wp','_leader'];
{
	_grp = _x;
	if (!((waypoints _grp) isEqualTo [])) then {
		for '_x' from 0 to ((count (waypoints _grp)) - 1) step 1 do {
			if ((waypoints _grp) isEqualTo []) exitWith {};
			deleteWaypoint ((waypoints _grp) select 0);
		};
	};
	if ((_pos distance2D (leader _grp)) > 50) then {
		_wp = _grp addWaypoint [_pos,0];
		if (isPlayer (leader _grp)) then {
			_wp setWaypointStatements [
				'TRUE',
				'
					if (isDedicated) exitWith {};
					if (local this) then {
						_leader = leader this;
						if (player isEqualTo _leader) then {
							["ScoreBonus",["Task complete","1"]] call QS_fnc_showNotification;
							if (!isNull (missionNamespace getVariable "QS_hc_Commander")) then {
								if (isPlayer (missionNamespace getVariable "QS_hc_Commander")) then {
									_text = format ["%1 ( %2 ) completed its task at grid %3",(groupID this),profileName,(mapGridPosition player)];
									[63,[5,[_text,"PLAIN DOWN",0.75]]] remoteExec ["QS_fnc_remoteExec",((missionNamespace getVariable "QS_hc_Commander") getVariable "QS_clientOwner"),FALSE];
									[63,[0,_text]] remoteExec ["QS_fnc_remoteExec",((missionNamespace getVariable "QS_hc_Commander") getVariable "QS_clientOwner"),FALSE];
								};
							};
						};
					};
				'
			];
			_leader = leader _grp;
			_ownerID = owner _leader;
			[63,[5,[(format['Task assigned by [Commander] %1',profileName]),'PLAIN DOWN',0.75]]] remoteExec ['QS_fnc_remoteExec',(_leader getVariable 'QS_clientOwner'),FALSE];
		};
	};
} forEach _arraySelected;