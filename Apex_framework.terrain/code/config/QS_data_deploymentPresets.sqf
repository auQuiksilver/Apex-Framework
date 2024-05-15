/*/
File: QS_data_deploymentPresets.sqf
Author:

	Quiksilver
	
Last modified:

	19/03/2023 A3 2.12 by Quiksilver
	
Description:

	Deployment Presets
	
	Player Respawn Positions
________________________________________/*/

[
	[
		99,
		'ID_01',
		{TRUE},
		{'Main Base'},
		'MARKER',
		'QS_marker_base_marker',
		300,
		[],
		[WEST],
		{
			QS_player setPosASL (AGLToASL (markerPos ['QS_marker_base_marker',TRUE]));
		},
		{TRUE},
		{
			((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_base_marker'];
			ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
			0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
		},
		{TRUE},
		{TRUE},
		''
	],
	[
		1,
		'ID_02',
		{TRUE},
		{'Destroyer'},
		'MARKER',
		'QS_marker_destroyer_1',
		300,
		[],
		[WEST],
		{
			['RESPAWN_PLAYER',QS_player] spawn QS_fnc_destroyer
		},
		{TRUE},
		{
			((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'QS_marker_destroyer_1'];
			ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
			0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
		},
		{TRUE},
		{TRUE},
		''
	],
	[
		3,
		'ID_03',
		{TRUE},
		{'Zeus'},
		'MARKER',
		'respawn_west',
		300,
		[],
		[WEST],
		{QS_player setPosASL (AGLToASL (markerPos ['respawn_west',TRUE]));},
		{TRUE},
		{
			((findDisplay 12) displayCtrl 51) ctrlMapAnimAdd [0.25,0.8,markerPos 'respawn_west'];
			ctrlMapAnimCommit ((findDisplay 12) displayCtrl 51);
			0 spawn {uiSleep 0.5;ctrlMapAnimClear ((findDisplay 12) displayCtrl 51);};
		},
		{FALSE},
		{TRUE},
		''
	]
]