/*
File: fn_aoBriefing.sqf
Author: 

	Quiksilver

Last modified: 

	9/06/2016 A3 1.61 by Quiksilver

Description:

	De-brief players and clear AO
______________________________________________*/

_type = _this select 0;
_ao = _this select 1;
_QS_AOpos = _this select 2;

diag_log str _ao;

if (_type isEqualTo 'BRIEF') then {
	missionNamespace setVariable ['QS_enemiesCaptured_AO',0,FALSE];
	{
		_x setMarkerPos _QS_AOpos;
	} forEach [
		'QS_marker_aoCircle',
		'QS_marker_aoMarker'
	];
	if (!((missionNamespace getVariable ['QS_missionConfig_playableOPFOR',0]) isEqualTo 0)) then {
		[objNull,_QS_AOpos] remoteExec ['QS_fnc_respawnOPFOR',[EAST,RESISTANCE],FALSE];
	};
	'QS_marker_aoMarker' setMarkerText (format ['%1Take %2',(toString [32,32,32]),_ao]);
	_targetStartText = parseText format [
		"<t align='center' size='2.2'>New Target</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/>We did a good job with the last target, lads. I want to see the same again. Get yourselves over to %1 and take 'em all down!<br/><br/>Remember to take down that radio tower to stop the enemy from calling in CAS.",
		_ao
	];
	if (!(missionNamespace getVariable 'QS_mainao_firstRun')) then {
		//['hint',_targetStartText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
		['NewMain',[_ao]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
		['NewSub',['Destroy radio tower']] remoteExec ['QS_fnc_showNotification',-2,FALSE];
	} else {
		missionNamespace setVariable ['QS_mainao_firstRun',FALSE,FALSE];
	};
	{
		_x setMarkerColor 'ColorOPFOR';
		_x setMarkerAlpha 0.8;
	} forEach [
		'QS_marker_hqCircle',
		'QS_marker_hqMarker',
		'QS_marker_aoCircle',
		'QS_marker_aoMarker',
		'QS_marker_radioCircle',
		'QS_marker_radioMarker'
	];
	if (!((missionNamespace getVariable 'QS_ao_aaMarkers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.8;
		} count (missionNamespace getVariable 'QS_ao_aaMarkers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
			_x setMarkerAlpha 0.5;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isEqualTo [])) then {
		{
			_x setMarkerColor 'ColorOPFOR';
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
				'Seize the enemy headquarters to degrade enemy coordination. This objective is completed when the enemy commander dies. He is usually located in the immediate vicinity of the HQ. This objective is not a requirement in order to finish the mission, however may be useful.',
				'Enemy HQ',
				'Seize Enemy HQ'
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
				'Destroy the radio tower. Destroying the radio tower will degrade enemy communications and prevent them from calling in air support. This objective is not accurately marked. The radio tower is somewhere within the surrounding circle.',
				'Destroy radiotower',
				'Destroy radiotower'
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
				'Clear the marked area of resistance. Once there are under 10 enemies in this area and no more sub-objectives to do, this task will complete. You may have to conduct a number of patrols around the zone to finish them off.',
				(format ['Take %1',_ao]),
				(format ['Take %1',_ao])
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
	_targetCompleteText = parseText format ["<t align='center' size='2.2'>Target Taken</t><br/><t size='1.5' align='center' color='#FFCF11'>%1</t><br/>____________________<br/><t align='left'>Fantastic job taking %1, boys!<br/><br/>Enemies imprisoned: %2</t>",(_ao select 0),(missionNamespace getVariable 'QS_enemiesCaptured_AO')];
	//['hint',_targetCompleteText] remoteExec ['QS_fnc_remoteExecCmd',-2,FALSE];
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
	{
		_x setMarkerAlpha 0;
		_x setMarkerColor 'ColorOPFOR';
	} forEach [
		'QS_marker_hqMarker',
		'QS_marker_hqCircle'
	];
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_1_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_1_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_2_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_2_markers');
	};
	if (!((missionNamespace getVariable 'QS_virtualSectors_sub_3_markers') isEqualTo [])) then {
		{
			_x setMarkerAlpha 0;
		} forEach (missionNamespace getVariable 'QS_virtualSectors_sub_3_markers');
	};
	['CompletedMain',[(_ao select 0)]] remoteExec ['QS_fnc_showNotification',-2,FALSE];
};