/*
File: fn_aoBriefing.sqf
Author: 

	Quiksilver

Last modified: 

	27/10/2022 A3 2.10 by Quiksilver

Description:

	De-brief players and clear AO
______________________________________________*/

params ['_type','_ao','_QS_AOpos'];
diag_log str _ao;
if (_type isEqualTo 'BRIEF') then {
	missionNamespace setVariable ['QS_enemiesCaptured_AO',0,FALSE];
	{
		_x setMarkerPosLocal _QS_AOpos;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker'
	];
	if ((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isNotEqualTo 0) then {
		[objNull,_QS_AOpos] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
	};
	'QS_marker_aoMarker' setMarkerTextLocal (format ['%1 %3 %2',(toString [32,32,32]),_ao,localize 'STR_QS_Marker_001']);
	_targetStartText = parseText format [
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Remember to take down that radio tower to stop the enemy from calling in CAS.",
		_ao
	];
	if (!(missionNamespace getVariable 'QS_mainao_firstRun')) then {
		//['hint',_targetStartText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['NewMain',[_ao]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['NewSub',[localize 'STR_QS_Notif_002']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	} else {
		missionNamespace setVariable ['QS_mainao_firstRun',FALSE,FALSE];
	};
	{
		_x setMarkerColorLocal 'ColorOPFOR';
		_x setMarkerAlpha 0.8;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker',
		'QS_marker_radioCircle',
		'QS_marker_radioMarker'
	];
	if (!(worldName in ['Stratis'])) then {
		{
			_x setMarkerColorLocal 'ColorOPFOR';
			_x setMarkerAlpha 0.8;	
		} forEach [
			'QS_marker_hqCircle',
			'QS_marker_hqMarker'
		];
	};
	if ((missionNamespace getVariable 'QS_ao_aaMarkers') isNotEqualTo []) then {
		{
			_x setMarkerColorLocal 'ColorOPFOR';
			_x setMarkerAlpha 0.8;
		} count (missionNamespace getVariable 'QS_ao_aaMarkers');
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isNotEqualTo []) then {
		{
			_x setMarkerColorLocal 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
		{
			_x setMarkerColorLocal 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isNotEqualTo []) then {
		{
			_x setMarkerColorLocal 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};	
	{
		_x call (missionNamespace getVariable 'BIS_fnc_setTask');
	} forEach [
		[
			'QS_IA_TASK_AO_2',
			TRUE,
			[
				(localize 'STR_QS_Task_000'),
				(localize 'STR_QS_Task_001'),
				(localize 'STR_QS_Task_002')
			],
			(markerPos 'QS_marker_hqMarker'),
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Attack',
			TRUE
		],
		[
			'QS_IA_TASK_AO_1',
			TRUE,
			[
				(localize 'STR_QS_Task_003'),
				(localize 'STR_QS_Task_004'),
				(localize 'STR_QS_Task_004')
			],
			(markerPos 'QS_marker_radioMarker'),
			'CREATED',
			5,
			FALSE,
			TRUE,
			'Destroy',
			TRUE
		],
		[
			'QS_IA_TASK_AO_0',
			TRUE,
			[
				(localize 'STR_QS_Task_005'),
				(format ['%2 %1',_ao,localize 'STR_QS_Notif_123']),
				(format ['%2 %1',_ao,localize 'STR_QS_Notif_123'])
			],
			_QS_AOpos,
			'ASSIGNED',
			5,
			FALSE,
			TRUE,
			'X',
			TRUE
		]
	];	
};
if (_type isEqualTo 'DEBRIEF') then {
	['QS_IA_TASK_AO_0'] call (missionNamespace getVariable 'BIS_fnc_deleteTask');
	_targetCompleteText = parseText format [
		"<t align='center' size='2.2'>%3</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>%4 %1, %5!<br/><br/>%6 %2</t>",
		(_ao # 1),
		(missionNamespace getVariable 'QS_enemiesCaptured_AO'),
		localize 'STR_QS_Task_006',
		localize 'STR_QS_Task_007',
		localize 'STR_QS_Task_008',
		localize 'STR_QS_Task_009'
	];
	missionNamespace setVariable ['QS_evacPosition_1',_QS_AOpos,TRUE];
	{
		_x setMarkerAlpha 0;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker',
		'QS_marker_radioCircle',
		'QS_marker_radioMarker'
	];
	'QS_marker_aoMarker' setMarkerText (format ['%1',(toString [32,32,32])]);
	if (!(worldName in ['Stratis'])) then {
		{
			_x setMarkerAlphaLocal 0;
			_x setMarkerColor 'ColorOPFOR';
		} forEach [
			'QS_marker_hqMarker',
			'QS_marker_hqCircle'
		];
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isNotEqualTo []) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isNotEqualTo []) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if ((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isNotEqualTo []) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};
	['CompletedMain',[(_ao # 1)]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};