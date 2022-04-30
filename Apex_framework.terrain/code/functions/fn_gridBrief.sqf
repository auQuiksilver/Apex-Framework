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
	['GRID_BRIEF',['Area Of Operations','Objectives complete']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
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
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		[objNull,_centroid] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
	};
	_centroidOffset = [
		((_centroid select 0) + 1000),
		((_centroid select 1) + 300),
		(_centroid select 2)
	];	
	'QS_marker_grid_civState' setMarkerTextLocal (format ['%1No civilian casualties',(toString [32,32,32])]);
	'QS_marker_grid_civState' setMarkerColorLocal 'ColorCIVILIAN';
	'QS_marker_grid_civState' setMarkerPosLocal _centroidOffset;
	'QS_marker_grid_civState' setMarkerAlpha 0.75;
	'QS_marker_grid_capState' setMarkerAlpha 0.75;
	_text = 'Objectives<br/><br/>- (Optional) No civilian casualties.<br/>- (Required) Convert required number of grid squares to green.<br/>- (Required) Destroy enemy respawn tunnel entrances.<br/>';
	{
		if (_x isEqualTo 'SITE_TUNNEL') then {
			'QS_marker_grid_rspState' setMarkerAlpha 0.75;
		};
		if (_x isEqualTo 'SITE_IG') then {
			'QS_marker_grid_IGmkr' setMarkerAlpha 0.75;
			'QS_marker_grid_IGcircle' setMarkerAlpha 0.75;
			_text = _text + '- (Optional) Kill or capture the local enemy commander.<br/>';
			_text = _text + '- (Optional) Capture and hold the enemy HQ.<br/>';
		};
		if (_x isEqualTo 'SITE_IDAP') then {
			'QS_marker_grid_IDAPloc' setMarkerAlpha 0.75;
			'QS_marker_grid_IDAPmkr' setMarkerAlpha 0.75;
			'QS_marker_grid_IDAPcircle' setMarkerAlpha 0.75;
			_text = _text + '- (Optional) Assist IDAP by clearing an Unexploded Ordnance (UXO) field.<br/>';
		};
	} forEach _usedObjectives;
	_text = _text + '<br/><br/>Search buildings and structures in the area for intel to locate the enemy respawn tunnel entrances.<br/><br/>Tunnel entrances look like small stone well covers, with a sewer grate inside.';
	[
		'QS_TASK_GRID_0',
		TRUE,
		[
			_text,
			'Area of Operations',
			'Area of Operations'
		],
		_centroid,
		'CREATED',
		5,
		FALSE,
		TRUE,
		'X',
		TRUE
	] call (missionNamespace getVariable 'BIS_fnc_setTask');
	['GRID_BRIEF',['Area Of Operations','Complete all objectives']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	// yes do it again, the marker network propagation can be ... unstable ...
	{
		_x setMarkerAlpha 0.75;
	} forEach _aoGridMarkers;
};