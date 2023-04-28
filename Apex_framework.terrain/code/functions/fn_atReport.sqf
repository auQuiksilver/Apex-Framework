/*
File: fn_atReport.sqf
Author:

	Quiksilver
	
Last modified:

	17/03/2023 A3 2.12 by Quiksilver
	
Description:

	-
__________________________________________________*/

if (isDedicated ||(time < 60)) exitWith {};
(_this # 3) params [
	'_type',
	'_uid',
	'_causedBy',
	'_playerPos',
	'_nameCausedBy'
];
private _val = 1;
([player,'SAFE'] call QS_fnc_inZone) params ['_inSafezone','_safezoneLevel','_safezoneActive'];
if (_inSafezone && _safezoneActive) then {
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
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,7.5,-1,localize 'STR_QS_Hints_001',[],(serverTime + 15),TRUE,localize 'STR_QS_Utility_002',FALSE];
	[41,[0,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};
if (_type isEqualTo 1) then {
	_text = localize 'STR_QS_Hints_002';
	(missionNamespace getVariable 'QS_managed_hints') pushBack [5,FALSE,10,-1,_text,[],(serverTime + 20),TRUE,localize 'STR_QS_Utility_002',TRUE];
	[41,[1,_uid,_causedBy,_nameCausedBy,player,_val,TRUE]] remoteExec ['QS_fnc_remoteExec',2,FALSE];
};