/*
File: fn_eventRTKilled.sqf
Author:

	Quiksilver
	
Last modified:

	5/12/2018 A3 1.86 by Quiksilver
	
Description:

	Event Radio Tower Killed
__________________________________________________*/

params ['_object','_killer'];
{
	_x setMarkerAlphaLocal 0;
	_x setMarkerPos [-5000,-5000,0];
} forEach ['QS_marker_radioMarker','QS_marker_radioCircle'];
_radioTowerDownText = parseText "<t align='center' size='2.2'>Radio Tower</t><br/><t size='1.5' color='#08b000' align='center'>DESTROYED</t><br/>____________________<br/>The enemy radio tower has been destroyed! Fantastic job, lads!<br/><br/><t size='1.2' color='#08b000' align='center'> The enemy cannot call in air support now!</t><br/>";
//['hint',_radioTowerDownText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['QS_IA_TASK_AO_1'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
['CompletedSub',[localize 'STR_QS_Notif_001']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
if (!isNull _killer) then {
	if (isPlayer _killer) then {
		_name = name _killer;
		if ((random 1) > 0.5) then {
			['sideChat',[WEST,'HQ'],(format ['%1 %2',_name,localize 'STR_QS_Chat_008'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		} else {
			['sideChat',[WEST,'HQ'],(format ['%1 %2',_name,localize 'STR_QS_Chat_009'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		};
		if ((!(_killer getUnitTrait 'uavhacker')) && (!(_killer getUnitTrait 'QS_trait_pilot')) && (!(_killer getUnitTrait 'QS_trait_fighterPilot'))) then {
			(missionNamespace getVariable 'QS_leaderboards_session_queue') pushBack ['TOWER',(getPlayerUID _killer),(name _killer),1];
		};
	};
};