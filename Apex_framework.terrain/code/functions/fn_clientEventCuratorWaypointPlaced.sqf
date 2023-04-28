/*
File: fn_clientEventCuratorWaypointPlaced.sqf
Author:

	Quiksilver
	
Last modified:

	17/08/2022 A3 2.10 by Quiksilver
	
Description:

	Curator waypoint placed event
__________________________________________________*/

params ['_module','_group','_wpIndex'];
if (_wpIndex in [0,1]) then {
	private _unit = objNull;
	private _targets = [];
	{
		_unit = _x;
		_targets = _unit targets [TRUE,0];
		if (_targets isNotEqualTo []) then {
			{
				_group forgetTarget _x;
				_unit forgetTarget _x;
			} forEach _targets;
		};
	} forEach (units _group);
};
[_group,_wpIndex] setWaypointPosition [AGLToASL (waypointPosition [_group,_wpIndex]),-1];
_group setFormDir ((leader _group) getDir (waypointPosition [_group,_wpIndex]));
_group setBehaviour 'AWARE';
{
	_x enableAIFeature ['AUTOCOMBAT',FALSE];
} forEach (units _group);
if (!local _group) then {
	if (diag_tickTime > (_module getVariable ['QS_curator_lastWPSyncTime',-1])) then {
		_module setVariable ['QS_curator_lastWPSyncTime',diag_tickTime + 5];
		_type = waypointType [_group,_wpIndex];
		_wPos = waypointPosition [_group,_wpIndex];
		_radius = waypointCompletionRadius [_group,_wpIndex];
		[20,_group,_type,_wPos,_radius,_wpIndex] remoteExec ['QS_fnc_remoteExec',_group,FALSE];
		50 cutText [localize 'STR_QS_Text_010','PLAIN DOWN',0.5];
	} else {
		50 cutText [localize 'STR_QS_Text_011','PLAIN DOWN',0.5];
	};
};