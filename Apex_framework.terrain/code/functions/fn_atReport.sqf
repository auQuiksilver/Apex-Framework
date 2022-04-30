/*
File: fn_atReport.sqf
Author:

	Quiksilver
	
Last modified:

	26/10/2016 A3 1.64 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (isDedicated) exitWith {};
if (time < 60) exitWith {};
_array = _this # 3;
_array params [
	'_type',
	'_uid',
	'_causedBy',
	'_playerPos',
	'_nameCausedBy'
];
private _val = 1;
if (((_playerPos distance (markerPos 'QS_marker_base_marker')) < 1000) || ((_playerPos distance (markerPos 'QS_marker_module_fob')) < 50)) then {
	_val = 1.5;
};
if (((_playerPos distance (markerPos 'QS_marker_aoMarker')) < 1000) || {((_playerPos distance (markerPos 'QS_marker_sideMarker')) < 1000)} || {((_playerPos distance (markerPos 'QS_marker_priorityMarker')) < 1000)} || {((_playerPos distance (markerPos 'QS_marker_aoMarker_2')) < 1000)} || {((_playerPos distance (markerPos 'QS_marker_hqMarker')) < 1000)}) then {
	_val = 0.5;
};
{
	player removeAction _x;
} count (missionNamespace getVariable 'QS_sub_actions');
missionNamespace setVariable ['QS_sub_actions',[],FALSE];
if (_type isEqualTo 2) then {
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7.5,-1,'No incident report has been filed.',[],(serverTime + 15),TRUE,'ROBOCOP',FALSE];
	[41,[0,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 1) then {
	_text = format ['An incident report has been filed and in-game staff have been notified. Thank you for your assistance. You are on server:<br/><br/>%1',serverName];
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,10,-1,_text,[],(serverTime + 20),TRUE,'ROBOCOP',TRUE];
	[41,[1,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};