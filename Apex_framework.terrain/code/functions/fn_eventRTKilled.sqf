/*
File: fn_eventRTKilled.sqf
Author:

	Quiksilver
	
Last modified:

	01/05/2023 A3 1.86 by Quiksilver
	
Description:

	Event Radio Tower Killed
__________________________________________________*/

params ['_object','_killer'];
{
	_x setMarkerAlphaLocal 0;
	_x setMarkerPos [-5000,-5000,0];
} forEach ['QS_marker_radioMarker','QS_marker_radioCircle'];
_radioTowerDownText = parseText (localize 'STR_QS_Chat_174');
['hint',_radioTowerDownText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['QS_IA_TASK_AO_1'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
['CompletedSub',[localize 'STR_QS_Notif_001']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
if (!isNull _killer) then {
	if (isPlayer _killer) then {
		_name = name _killer;
		if ((random 1) > 0.5) then {
			['sideChat',[WEST,'HQ'],(format [localize 'STR_QS_Chat_008',_name,(groupID (group _killer))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		} else {
			['sideChat',[WEST,'HQ'],(format [localize 'STR_QS_Chat_009',_name,(groupID (group _killer))])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		if ((!(_killer getUnitTrait 'uavhacker')) && (!(_killer getUnitTrait 'QS_trait_pilot')) && (!(_killer getUnitTrait 'QS_trait_fighterPilot'))) then {
			(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TOWER',(getPlayerUID _killer),(name _killer),1];
		};
	};
};