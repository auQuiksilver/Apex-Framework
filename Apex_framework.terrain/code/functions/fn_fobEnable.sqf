/*
File: fn_fobEnable.sqf
Author:

	Quiksilver
	
Last Modified:

	4/02/2023 A3 2.12 by Quiksilver

Description:

	Enable FOB
___________________________________________________*/

params ['_side','_activatorName'];
private _color = 'ColorUnknown';
if (_side isEqualTo EAST) then {
	_color = 'ColorOPFOR';
};
if (_side isEqualTo WEST) then {
	_color = 'ColorWEST';
};
if (_side isEqualTo RESISTANCE) then {
	_color = 'ColorINDEPENDENT';
};
if (_side isEqualTo CIVILIAN) then {
	_color = 'ColorCIVILIAN';
};
if (_side isEqualTo sideUnknown) then {
	_color = 'ColorUNKNOWN';
};
'QS_marker_module_fob' setMarkerAlpha 1;
{
	_x setMarkerColor _color;
} forEach [
	'QS_marker_module_fob',
	'QS_marker_veh_fieldservice_04',
	'QS_marker_veh_fieldservice_01'
];
_flag = missionNamespace getVariable ['QS_module_fob_flag',objNull];
_tickets = round (((missionNamespace getVariable ['QS_module_fob_respawnTickets',0]) / 2) max 0);
_flag setVariable ['QS_module_fob_flag',_tickets,TRUE];
['PRESET',6,FALSE,[_side]] call QS_fnc_deployment;
[
	[],
	{
		if ((vehicle player) isKindOf 'Air') then {
			if (player in [(driver (vehicle player)),(gunner (vehicle player))]) then {
				player enableAIFeature ['CHECKVISIBLE',TRUE];
			};
		};
	}
] remoteExec ['call',-2,FALSE];
[_flag,_side,'',FALSE,objNull,1] call (missionNamespace getVariable 'QS_fnc_setFlag');
['sideChat',[WEST,'HQ'],(format ['%3 %1 %4 %2!',(missionNamespace getVariable 'QS_module_fob_displayName'),_activatorName,localize 'STR_QS_Chat_047',localize 'STR_QS_Chat_048'])] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
['FOB_UPDATE',['',localize 'STR_QS_Notif_055']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
0 spawn {
	sleep 2;
	{
		if (!isNull _x) then {
			[_x,3] call (missionNamespace getVariable 'BIS_fnc_DataTerminalAnimate');
		};
	} forEach [
		(missionNamespace getVariable 'QS_module_fob_dataTerminal'),
		(missionNamespace getVariable 'QS_module_fob_baseDataTerminal')
	];
	sleep 3;
	['FOB_UPDATE',['',localize 'STR_QS_Notif_056']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};
missionNamespace setVariable ['QS_module_fob_side',_side,TRUE];