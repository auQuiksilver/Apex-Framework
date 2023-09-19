/*/
File: fn_gridBrief.sqf
Author: 

	Quiksilver

Last Modified:

	9/12/2017 A3 1.78 by Quiksilver

Description:

	Grid (De)Briefing
____________________________________________________________________________/*/

params ['_type','_usedObjectives','_gridMarkers'];
if (_type isEqualTo 0) exitWith {
	//comment 'Debrief';
	['QS_TASK_GRID_0'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
	['GRID_BRIEF',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_057']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	{
		_x setMarkerAlpha 0;
	} forEach [
		'QS_marker_grid_IGmkr',
		'QS_marker_grid_IGcircle',
		'QS_marker_grid_IDAPloc',
		'QS_marker_grid_IDAPmkr',
		'QS_marker_grid_IDAPcircle',
		'QS_marker_grid_mtrMkr',
		'QS_marker_grid_mtrCircle'
	];
	0 spawn {
		uiSleep 5;
		{
			_x setMarkerAlpha 0;
		} forEach [
			'QS_marker_grid_capState',
			'QS_marker_grid_rspState',
			'QS_marker_grid_civState'
		];
	};
};
if (_type isEqualTo 1) exitWith {
	//comment 'Brief';
	private _text = '';
	{
		_x setMarkerAlpha 0.75;
	} forEach _aoGridMarkers;
	_centroid = missionNamespace getVariable 'QS_grid_aoCentroid';
	{
		_x setMarkerPos _centroid;
	} forEach [
		'QS_marker_aoMarker',
		'QS_marker_aoCircle'
	];
	if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
		[objNull,_centroid] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
	};
	_centroidOffset = [
		((_centroid # 0) + 1000),
		((_centroid # 1) + 300),
		(_centroid # 2)
	];	
	'QS_marker_grid_civState' setMarkerTextLocal (format ['%1 %2',(toString [32,32,32]),localize 'STR_QS_Marker_011']);
	'QS_marker_grid_civState' setMarkerColorLocal 'ColorCIVILIAN';
	'QS_marker_grid_civState' setMarkerPosLocal _centroidOffset;
	'QS_marker_grid_civState' setMarkerAlpha 0.75;
	'QS_marker_grid_capState' setMarkerAlpha 0.75;
	_text = format ['%1<br/><br/>- %2<br/>- %3<br/>- %4<br/>',localize 'STR_QS_Task_032',localize 'STR_QS_Task_033',localize 'STR_QS_Task_034',localize 'STR_QS_Task_035'];
	{
		if (_x isEqualTo 'SITE_TUNNEL') then {
			'QS_marker_grid_rspState' setMarkerAlpha 0.75;
		};
		if (_x isEqualTo 'SITE_IG') then {
			'QS_marker_grid_IGmkr' setMarkerAlpha 0.75;
			'QS_marker_grid_IGcircle' setMarkerAlpha 0.75;
			_text = _text + (format ['- %1<br/>',localize 'STR_QS_Task_036']);
			_text = _text + (format ['- %1<br/>',localize 'STR_QS_Task_037']);
		};
		if (_x isEqualTo 'SITE_IDAP') then {
			'QS_marker_grid_IDAPloc' setMarkerAlpha 0.75;
			'QS_marker_grid_IDAPmkr' setMarkerAlpha 0.75;
			'QS_marker_grid_IDAPcircle' setMarkerAlpha 0.75;
			_text = _text + (format ['- %1<br/>',localize 'STR_QS_Task_038']);
		};
	} forEach _usedObjectives;
	_text = _text + (format ['<br/><br/>%1<br/><br/>%2',localize 'STR_QS_Task_039',localize 'STR_QS_Task_040']);
	[
		'QS_TASK_GRID_0',
		TRUE,
		[
			_text,
			localize 'STR_QS_Notif_008',
			localize 'STR_QS_Notif_008'
		],
		_centroid,
		'CREATED',
		5,
		FALSE,
		TRUE,
		'X',
		TRUE
	] call (missionNamespace getVariable 'BIS_fnc_setTask');
	['GRID_BRIEF',[localize 'STR_QS_Notif_008',localize 'STR_QS_Notif_058']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	// yes do it again, the marker network propagation can be ... unstable ...
	{
		_x setMarkerAlpha 0.75;
	} forEach _aoGridMarkers;
};